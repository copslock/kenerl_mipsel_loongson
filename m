Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Aug 2013 08:32:13 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:41445 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6818702Ab3HWGbtY2IoL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 23 Aug 2013 08:31:49 +0200
Received: from arrakis.dune.hu (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 347E728029F;
        Fri, 23 Aug 2013 08:31:19 +0200 (CEST)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA;
        Fri, 23 Aug 2013 08:31:18 +0200 (CEST)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH v2 1/3] MIPS: ralink: mt7620: improve clock frequency detection
Date:   Fri, 23 Aug 2013 08:31:30 +0200
Message-Id: <1377239492-10802-1-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.10
Return-Path: <juhosg@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37653
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

The current code assumes that the peripheral clock always
runs at 40MHz which is not true in all configuration. The
peripheral clock can also use the reference clock instead
of the fixed 40MHz rate. If the reference clock runs at a
different rate, various peripheries are behaving incorrectly.

Additionally, the currectly calculated system clock is also
wrong. The actual value what the code computes is the rate
of the DRAM which can be different from the system clock.

Add new helper functions to get the rate of the different
clocks and use the correct values for the registered clock
devices.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
Changes since v1:
  - rebase against the mips-for-linux-next branch of the
    upstream-sfr.git tree
---
 arch/mips/include/asm/mach-ralink/mt7620.h |   40 ++++--
 arch/mips/ralink/mt7620.c                  |  200 ++++++++++++++++++++++++----
 2 files changed, 207 insertions(+), 33 deletions(-)

diff --git a/arch/mips/include/asm/mach-ralink/mt7620.h b/arch/mips/include/asm/mach-ralink/mt7620.h
index 9809972..6f9b24f 100644
--- a/arch/mips/include/asm/mach-ralink/mt7620.h
+++ b/arch/mips/include/asm/mach-ralink/mt7620.h
@@ -20,6 +20,8 @@
 #define SYSC_REG_CHIP_REV		0x0c
 #define SYSC_REG_SYSTEM_CONFIG0		0x10
 #define SYSC_REG_SYSTEM_CONFIG1		0x14
+#define SYSC_REG_CLKCFG0		0x2c
+#define SYSC_REG_CPU_SYS_CLKCFG		0x3c
 #define SYSC_REG_CPLL_CONFIG0		0x54
 #define SYSC_REG_CPLL_CONFIG1		0x58
 
@@ -29,20 +31,42 @@
 #define MT7620A_CHIP_NAME0		0x3637544d
 #define MT7620A_CHIP_NAME1		0x20203032
 
+#define SYSCFG0_XTAL_FREQ_SEL		BIT(6)
+
 #define CHIP_REV_PKG_MASK		0x1
 #define CHIP_REV_PKG_SHIFT		16
 #define CHIP_REV_VER_MASK		0xf
 #define CHIP_REV_VER_SHIFT		8
 #define CHIP_REV_ECO_MASK		0xf
 
-#define CPLL_SW_CONFIG_SHIFT		31
-#define CPLL_SW_CONFIG_MASK		0x1
-#define CPLL_CPU_CLK_SHIFT		24
-#define CPLL_CPU_CLK_MASK		0x1
-#define CPLL_MULT_RATIO_SHIFT           16
-#define CPLL_MULT_RATIO                 0x7
-#define CPLL_DIV_RATIO_SHIFT            10
-#define CPLL_DIV_RATIO                  0x3
+#define CLKCFG0_PERI_CLK_SEL		BIT(4)
+
+#define CPU_SYS_CLKCFG_OCP_RATIO_SHIFT	16
+#define CPU_SYS_CLKCFG_OCP_RATIO_MASK	0xf
+#define CPU_SYS_CLKCFG_OCP_RATIO_1	0	/* 1:1   (Reserved) */
+#define CPU_SYS_CLKCFG_OCP_RATIO_1_5	1	/* 1:1.5 (Reserved) */
+#define CPU_SYS_CLKCFG_OCP_RATIO_2	2	/* 1:2   */
+#define CPU_SYS_CLKCFG_OCP_RATIO_2_5	3       /* 1:2.5 (Reserved) */
+#define CPU_SYS_CLKCFG_OCP_RATIO_3	4	/* 1:3   */
+#define CPU_SYS_CLKCFG_OCP_RATIO_3_5	5	/* 1:3.5 (Reserved) */
+#define CPU_SYS_CLKCFG_OCP_RATIO_4	6	/* 1:4   */
+#define CPU_SYS_CLKCFG_OCP_RATIO_5	7	/* 1:5   */
+#define CPU_SYS_CLKCFG_OCP_RATIO_10	8	/* 1:10  */
+#define CPU_SYS_CLKCFG_CPU_FDIV_SHIFT	8
+#define CPU_SYS_CLKCFG_CPU_FDIV_MASK	0x1f
+#define CPU_SYS_CLKCFG_CPU_FFRAC_SHIFT	0
+#define CPU_SYS_CLKCFG_CPU_FFRAC_MASK	0x1f
+
+#define CPLL_CFG0_SW_CFG		BIT(31)
+#define CPLL_CFG0_PLL_MULT_RATIO_SHIFT	16
+#define CPLL_CFG0_PLL_MULT_RATIO_MASK   0x7
+#define CPLL_CFG0_LC_CURFCK		BIT(15)
+#define CPLL_CFG0_BYPASS_REF_CLK	BIT(14)
+#define CPLL_CFG0_PLL_DIV_RATIO_SHIFT	10
+#define CPLL_CFG0_PLL_DIV_RATIO_MASK	0x3
+
+#define CPLL_CFG1_CPU_AUX1		BIT(25)
+#define CPLL_CFG1_CPU_AUX0		BIT(24)
 
 #define SYSCFG0_DRAM_TYPE_MASK		0x3
 #define SYSCFG0_DRAM_TYPE_SHIFT		4
diff --git a/arch/mips/ralink/mt7620.c b/arch/mips/ralink/mt7620.c
index 0018b1a..8dd3b0d 100644
--- a/arch/mips/ralink/mt7620.c
+++ b/arch/mips/ralink/mt7620.c
@@ -23,9 +23,6 @@
 /* does the board have sdram or ddram */
 static int dram_type;
 
-/* the pll dividers */
-static u32 mt7620_clk_divider[] = { 2, 3, 4, 8 };
-
 static struct ralink_pinmux_grp mode_mux[] = {
 	{
 		.name = "i2c",
@@ -140,34 +137,187 @@ struct ralink_pinmux rt_gpio_pinmux = {
 	.uart_mask = MT7620_GPIO_MODE_UART0_MASK,
 };
 
-void __init ralink_clk_init(void)
+static __init u32
+mt7620_calc_rate(u32 ref_rate, u32 mul, u32 div)
 {
-	unsigned long cpu_rate, sys_rate;
-	u32 c0 = rt_sysc_r32(SYSC_REG_CPLL_CONFIG0);
-	u32 c1 = rt_sysc_r32(SYSC_REG_CPLL_CONFIG1);
-	u32 swconfig = (c0 >> CPLL_SW_CONFIG_SHIFT) & CPLL_SW_CONFIG_MASK;
-	u32 cpu_clk = (c1 >> CPLL_CPU_CLK_SHIFT) & CPLL_CPU_CLK_MASK;
-
-	if (cpu_clk) {
-		cpu_rate = 480000000;
-	} else if (!swconfig) {
-		cpu_rate = 600000000;
-	} else {
-		u32 m = (c0 >> CPLL_MULT_RATIO_SHIFT) & CPLL_MULT_RATIO;
-		u32 d = (c0 >> CPLL_DIV_RATIO_SHIFT) & CPLL_DIV_RATIO;
+	u64 t;
 
-		cpu_rate = ((40 * (m + 24)) / mt7620_clk_divider[d]) * 1000000;
-	}
+	t = ref_rate;
+	t *= mul;
+	do_div(t, div);
+
+	return t;
+}
+
+#define MHZ(x)		((x) * 1000 * 1000)
+
+static __init unsigned long
+mt7620_get_xtal_rate(void)
+{
+	u32 reg;
+
+	reg = rt_sysc_r32(SYSC_REG_SYSTEM_CONFIG0);
+	if (reg & SYSCFG0_XTAL_FREQ_SEL)
+		return MHZ(40);
+
+	return MHZ(20);
+}
+
+static __init unsigned long
+mt7620_get_periph_rate(unsigned long xtal_rate)
+{
+	u32 reg;
+
+	reg = rt_sysc_r32(SYSC_REG_CLKCFG0);
+	if (reg & CLKCFG0_PERI_CLK_SEL)
+		return xtal_rate;
+
+	return MHZ(40);
+}
+
+static const u32 mt7620_clk_divider[] __initconst = { 2, 3, 4, 8 };
+
+static __init unsigned long
+mt7620_get_cpu_pll_rate(unsigned long xtal_rate)
+{
+	u32 reg;
+	u32 mul;
+	u32 div;
+
+	reg = rt_sysc_r32(SYSC_REG_CPLL_CONFIG0);
+	if (reg & CPLL_CFG0_BYPASS_REF_CLK)
+		return xtal_rate;
+
+	if ((reg & CPLL_CFG0_SW_CFG) == 0)
+		return MHZ(600);
+
+	mul = (reg >> CPLL_CFG0_PLL_MULT_RATIO_SHIFT) &
+	      CPLL_CFG0_PLL_MULT_RATIO_MASK;
+	mul += 24;
+	if (reg & CPLL_CFG0_LC_CURFCK)
+		mul *= 2;
+
+	div = (reg >> CPLL_CFG0_PLL_DIV_RATIO_SHIFT) &
+	      CPLL_CFG0_PLL_DIV_RATIO_MASK;
+
+	WARN_ON(div >= ARRAY_SIZE(mt7620_clk_divider));
+
+	return mt7620_calc_rate(xtal_rate, mul, mt7620_clk_divider[div]);
+}
+
+static __init unsigned long
+mt7620_get_pll_rate(unsigned long xtal_rate, unsigned long cpu_pll_rate)
+{
+	u32 reg;
+
+	reg = rt_sysc_r32(SYSC_REG_CPLL_CONFIG1);
+	if (reg & CPLL_CFG1_CPU_AUX1)
+		return xtal_rate;
+
+	if (reg & CPLL_CFG1_CPU_AUX0)
+		return MHZ(480);
 
+	return cpu_pll_rate;
+}
+
+static __init unsigned long
+mt7620_get_cpu_rate(unsigned long pll_rate)
+{
+	u32 reg;
+	u32 mul;
+	u32 div;
+
+	reg = rt_sysc_r32(SYSC_REG_CPU_SYS_CLKCFG);
+
+	mul = reg & CPU_SYS_CLKCFG_CPU_FFRAC_MASK;
+	div = (reg >> CPU_SYS_CLKCFG_CPU_FDIV_SHIFT) &
+	      CPU_SYS_CLKCFG_CPU_FDIV_MASK;
+
+	return mt7620_calc_rate(pll_rate, mul, div);
+}
+
+static const u32 mt7620_ocp_dividers[16] __initconst = {
+	[CPU_SYS_CLKCFG_OCP_RATIO_2] = 2,
+	[CPU_SYS_CLKCFG_OCP_RATIO_3] = 3,
+	[CPU_SYS_CLKCFG_OCP_RATIO_4] = 4,
+	[CPU_SYS_CLKCFG_OCP_RATIO_5] = 5,
+	[CPU_SYS_CLKCFG_OCP_RATIO_10] = 10,
+};
+
+static __init unsigned long
+mt7620_get_dram_rate(unsigned long pll_rate)
+{
 	if (dram_type == SYSCFG0_DRAM_TYPE_SDRAM)
-		sys_rate = cpu_rate / 4;
-	else
-		sys_rate = cpu_rate / 3;
+		return pll_rate / 4;
+
+	return pll_rate / 3;
+}
+
+static __init unsigned long
+mt7620_get_sys_rate(unsigned long cpu_rate)
+{
+	u32 reg;
+	u32 ocp_ratio;
+	u32 div;
+
+	reg = rt_sysc_r32(SYSC_REG_CPU_SYS_CLKCFG);
+
+	ocp_ratio = (reg >> CPU_SYS_CLKCFG_OCP_RATIO_SHIFT) &
+		    CPU_SYS_CLKCFG_OCP_RATIO_MASK;
+
+	if (WARN_ON(ocp_ratio >= ARRAY_SIZE(mt7620_ocp_dividers)))
+		return cpu_rate;
+
+	div = mt7620_ocp_dividers[ocp_ratio];
+	if (WARN(!div, "invalid divider for OCP ratio %u", ocp_ratio))
+		return cpu_rate;
+
+	return cpu_rate / div;
+}
+
+void __init ralink_clk_init(void)
+{
+	unsigned long xtal_rate;
+	unsigned long cpu_pll_rate;
+	unsigned long pll_rate;
+	unsigned long cpu_rate;
+	unsigned long sys_rate;
+	unsigned long dram_rate;
+	unsigned long periph_rate;
+
+	xtal_rate = mt7620_get_xtal_rate();
+
+	cpu_pll_rate = mt7620_get_cpu_pll_rate(xtal_rate);
+	pll_rate = mt7620_get_pll_rate(xtal_rate, cpu_pll_rate);
+
+	cpu_rate = mt7620_get_cpu_rate(pll_rate);
+	dram_rate = mt7620_get_dram_rate(pll_rate);
+	sys_rate = mt7620_get_sys_rate(cpu_rate);
+	periph_rate = mt7620_get_periph_rate(xtal_rate);
+
+#define RFMT(label)	label ":%lu.%03luMHz "
+#define RINT(x)		((x) / 1000000)
+#define RFRAC(x)	(((x) / 1000) % 1000)
+
+	pr_debug(RFMT("XTAL") RFMT("CPU_PLL") RFMT("PLL"),
+		 RINT(xtal_rate), RFRAC(xtal_rate),
+		 RINT(cpu_pll_rate), RFRAC(cpu_pll_rate),
+		 RINT(pll_rate), RFRAC(pll_rate));
+
+	pr_debug(RFMT("CPU") RFMT("DRAM") RFMT("SYS") RFMT("PERIPH"),
+		 RINT(cpu_rate), RFRAC(cpu_rate),
+		 RINT(dram_rate), RFRAC(dram_rate),
+		 RINT(sys_rate), RFRAC(sys_rate),
+		 RINT(periph_rate), RFRAC(periph_rate));
+
+#undef RFRAC
+#undef RINT
+#undef RFMT
 
 	ralink_clk_add("cpu", cpu_rate);
-	ralink_clk_add("10000100.timer", 40000000);
-	ralink_clk_add("10000500.uart", 40000000);
-	ralink_clk_add("10000c00.uartlite", 40000000);
+	ralink_clk_add("10000100.timer", periph_rate);
+	ralink_clk_add("10000500.uart", periph_rate);
+	ralink_clk_add("10000c00.uartlite", periph_rate);
 }
 
 void __init ralink_of_remap(void)
-- 
1.7.10
