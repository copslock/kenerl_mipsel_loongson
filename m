Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Oct 2014 09:51:04 +0200 (CEST)
Received: from static.88-198-24-112.clients.your-server.de ([88.198.24.112]:46030
        "EHLO nbd.name" rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org
        with ESMTP id S27011052AbaJJHt4Xo8aT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Oct 2014 09:49:56 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: [PATCH 4/4] MIPS: ralink: add mt7628an support
Date:   Fri, 10 Oct 2014 09:49:48 +0200
Message-Id: <1412927388-60721-5-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1412927388-60721-1-git-send-email-blogic@openwrt.org>
References: <1412927388-60721-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@nbd.name>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43195
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/include/asm/mach-ralink/mt7620.h |   11 ++
 arch/mips/ralink/Kconfig                   |    2 +-
 arch/mips/ralink/mt7620.c                  |  276 +++++++++++++++++++++++-----
 3 files changed, 243 insertions(+), 46 deletions(-)

diff --git a/arch/mips/include/asm/mach-ralink/mt7620.h b/arch/mips/include/asm/mach-ralink/mt7620.h
index 863aea5..1976fb8 100644
--- a/arch/mips/include/asm/mach-ralink/mt7620.h
+++ b/arch/mips/include/asm/mach-ralink/mt7620.h
@@ -13,6 +13,13 @@
 #ifndef _MT7620_REGS_H_
 #define _MT7620_REGS_H_
 
+enum mt762x_soc_type {
+	MT762X_SOC_UNKNOWN = 0,
+	MT762X_SOC_MT7620A,
+	MT762X_SOC_MT7620N,
+	MT762X_SOC_MT7628AN,
+};
+
 #define MT7620_SYSC_BASE		0x10000000
 
 #define SYSC_REG_CHIP_NAME0		0x00
@@ -27,6 +34,7 @@
 
 #define MT7620_CHIP_NAME0		0x3637544d
 #define MT7620_CHIP_NAME1		0x20203032
+#define MT7628_CHIP_NAME1		0x20203832
 
 #define SYSCFG0_XTAL_FREQ_SEL		BIT(6)
 
@@ -71,6 +79,9 @@
 #define SYSCFG0_DRAM_TYPE_DDR1		1
 #define SYSCFG0_DRAM_TYPE_DDR2		2
 
+#define SYSCFG0_DRAM_TYPE_DDR2_MT7628	0
+#define SYSCFG0_DRAM_TYPE_DDR1_MT7628	1
+
 #define MT7620_DRAM_BASE		0x0
 #define MT7620_SDRAM_SIZE_MIN		2
 #define MT7620_SDRAM_SIZE_MAX		64
diff --git a/arch/mips/ralink/Kconfig b/arch/mips/ralink/Kconfig
index 4a29665..cfd0e54 100644
--- a/arch/mips/ralink/Kconfig
+++ b/arch/mips/ralink/Kconfig
@@ -26,7 +26,7 @@ choice
 		select HW_HAS_PCI
 
 	config SOC_MT7620
-		bool "MT7620"
+		bool "MT7620/8"
 
 endchoice
 
diff --git a/arch/mips/ralink/mt7620.c b/arch/mips/ralink/mt7620.c
index e4b1f82..2ea5ff6 100644
--- a/arch/mips/ralink/mt7620.c
+++ b/arch/mips/ralink/mt7620.c
@@ -37,6 +37,9 @@
 #define PMU1_CFG		0x8C
 #define DIG_SW_SEL		BIT(25)
 
+/* is this a MT7620 or a MT7628 */
+enum mt762x_soc_type mt762x_soc;
+
 /* does the board have sdram or ddram */
 static int dram_type;
 
@@ -94,6 +97,136 @@ static struct rt2880_pmx_group mt7620a_pinmux_data[] = {
 	{ 0 }
 };
 
+static struct rt2880_pmx_func pwm1_grp_mt7628[] = {
+	FUNC("sdcx", 3, 19, 1),
+	FUNC("utif", 2, 19, 1),
+	FUNC("gpio", 1, 19, 1),
+	FUNC("pwm", 0, 19, 1),
+};
+
+static struct rt2880_pmx_func pwm0_grp_mt7628[] = {
+	FUNC("sdcx", 3, 18, 1),
+	FUNC("utif", 2, 18, 1),
+	FUNC("gpio", 1, 18, 1),
+	FUNC("pwm", 0, 18, 1),
+};
+
+static struct rt2880_pmx_func uart2_grp_mt7628[] = {
+	FUNC("sdcx", 3, 20, 2),
+	FUNC("pwm", 2, 20, 2),
+	FUNC("gpio", 1, 20, 2),
+	FUNC("uart", 0, 20, 2),
+};
+
+static struct rt2880_pmx_func uart1_grp_mt7628[] = {
+	FUNC("sdcx", 3, 45, 2),
+	FUNC("pwm", 2, 45, 2),
+	FUNC("gpio", 1, 45, 2),
+	FUNC("uart", 0, 45, 2),
+};
+
+static struct rt2880_pmx_func i2c_grp_mt7628[] = {
+	FUNC("-", 3, 4, 2),
+	FUNC("debug", 2, 4, 2),
+	FUNC("gpio", 1, 4, 2),
+	FUNC("i2c", 0, 4, 2),
+};
+
+static struct rt2880_pmx_func refclk_grp_mt7628[] = { FUNC("reclk", 0, 36, 1) };
+static struct rt2880_pmx_func perst_grp_mt7628[] = { FUNC("perst", 0, 37, 1) };
+static struct rt2880_pmx_func wdt_grp_mt7628[] = { FUNC("wdt", 0, 15, 38) };
+static struct rt2880_pmx_func spi_grp_mt7628[] = { FUNC("spi", 0, 7, 4) };
+
+static struct rt2880_pmx_func sd_mode_grp_mt7628[] = {
+	FUNC("jtag", 3, 22, 8),
+	FUNC("utif", 2, 22, 8),
+	FUNC("gpio", 1, 22, 8),
+	FUNC("sdcx", 0, 22, 8),
+};
+
+static struct rt2880_pmx_func uart0_grp_mt7628[] = {
+	FUNC("-", 3, 12, 2),
+	FUNC("-", 2, 12, 2),
+	FUNC("gpio", 1, 12, 2),
+	FUNC("uart", 0, 12, 2),
+};
+
+static struct rt2880_pmx_func i2s_grp_mt7628[] = {
+	FUNC("antenna", 3, 0, 4),
+	FUNC("pcm", 2, 0, 4),
+	FUNC("gpio", 1, 0, 4),
+	FUNC("i2s", 0, 0, 4),
+};
+
+static struct rt2880_pmx_func spi_cs1_grp_mt7628[] = {
+	FUNC("-", 3, 6, 1),
+	FUNC("refclk", 2, 6, 1),
+	FUNC("gpio", 1, 6, 1),
+	FUNC("spi", 0, 6, 1),
+};
+
+static struct rt2880_pmx_func spis_grp_mt7628[] = {
+	FUNC("pwm", 3, 14, 4),
+	FUNC("util", 2, 14, 4),
+	FUNC("gpio", 1, 14, 4),
+	FUNC("spis", 0, 14, 4),
+};
+
+static struct rt2880_pmx_func gpio_grp_mt7628[] = {
+	FUNC("pcie", 3, 11, 1),
+	FUNC("refclk", 2, 11, 1),
+	FUNC("gpio", 1, 11, 1),
+	FUNC("gpio", 0, 11, 1),
+};
+
+#define MT7628_GPIO_MODE_MASK	0x3
+
+#define MT7628_GPIO_MODE_PWM1	30
+#define MT7628_GPIO_MODE_PWM0	28
+#define MT7628_GPIO_MODE_UART2	26
+#define MT7628_GPIO_MODE_UART1	24
+#define MT7628_GPIO_MODE_I2C	20
+#define MT7628_GPIO_MODE_REFCLK	18
+#define MT7628_GPIO_MODE_PERST	16
+#define MT7628_GPIO_MODE_WDT	14
+#define MT7628_GPIO_MODE_SPI	12
+#define MT7628_GPIO_MODE_SDMODE	10
+#define MT7628_GPIO_MODE_UART0	8
+#define MT7628_GPIO_MODE_I2S	6
+#define MT7628_GPIO_MODE_CS1	4
+#define MT7628_GPIO_MODE_SPIS	2
+#define MT7628_GPIO_MODE_GPIO	0
+
+static struct rt2880_pmx_group mt7628an_pinmux_data[] = {
+	GRP_G("pmw1", pwm1_grp_mt7628, MT7628_GPIO_MODE_MASK,
+				1, MT7628_GPIO_MODE_PWM1),
+	GRP_G("pmw1", pwm0_grp_mt7628, MT7628_GPIO_MODE_MASK,
+				1, MT7628_GPIO_MODE_PWM0),
+	GRP_G("uart2", uart2_grp_mt7628, MT7628_GPIO_MODE_MASK,
+				1, MT7628_GPIO_MODE_UART2),
+	GRP_G("uart1", uart1_grp_mt7628, MT7628_GPIO_MODE_MASK,
+				1, MT7628_GPIO_MODE_UART1),
+	GRP_G("i2c", i2c_grp_mt7628, MT7628_GPIO_MODE_MASK,
+				1, MT7628_GPIO_MODE_I2C),
+	GRP("refclk", refclk_grp_mt7628, 1, MT7628_GPIO_MODE_REFCLK),
+	GRP("perst", perst_grp_mt7628, 1, MT7628_GPIO_MODE_PERST),
+	GRP("wdt", wdt_grp_mt7628, 1, MT7628_GPIO_MODE_WDT),
+	GRP("spi", spi_grp_mt7628, 1, MT7628_GPIO_MODE_SPI),
+	GRP_G("sdmode", sd_mode_grp_mt7628, MT7628_GPIO_MODE_MASK,
+				1, MT7628_GPIO_MODE_SDMODE),
+	GRP_G("uart0", uart0_grp_mt7628, MT7628_GPIO_MODE_MASK,
+				1, MT7628_GPIO_MODE_UART0),
+	GRP_G("i2s", i2s_grp_mt7628, MT7628_GPIO_MODE_MASK,
+				1, MT7628_GPIO_MODE_I2S),
+	GRP_G("spi cs1", spi_cs1_grp_mt7628, MT7628_GPIO_MODE_MASK,
+				1, MT7628_GPIO_MODE_CS1),
+	GRP_G("spis", spis_grp_mt7628, MT7628_GPIO_MODE_MASK,
+				1, MT7628_GPIO_MODE_SPIS),
+	GRP_G("gpio", gpio_grp_mt7628, MT7628_GPIO_MODE_MASK,
+				1, MT7628_GPIO_MODE_GPIO),
+	{ 0 }
+};
+
 static __init u32
 mt7620_calc_rate(u32 ref_rate, u32 mul, u32 div)
 {
@@ -244,29 +377,42 @@ void __init ralink_clk_init(void)
 
 	xtal_rate = mt7620_get_xtal_rate();
 
-	cpu_pll_rate = mt7620_get_cpu_pll_rate(xtal_rate);
-	pll_rate = mt7620_get_pll_rate(xtal_rate, cpu_pll_rate);
-
-	cpu_rate = mt7620_get_cpu_rate(pll_rate);
-	dram_rate = mt7620_get_dram_rate(pll_rate);
-	sys_rate = mt7620_get_sys_rate(cpu_rate);
-	periph_rate = mt7620_get_periph_rate(xtal_rate);
-
 #define RFMT(label)	label ":%lu.%03luMHz "
 #define RINT(x)		((x) / 1000000)
 #define RFRAC(x)	(((x) / 1000) % 1000)
 
-	pr_debug(RFMT("XTAL") RFMT("CPU_PLL") RFMT("PLL"),
-		 RINT(xtal_rate), RFRAC(xtal_rate),
-		 RINT(cpu_pll_rate), RFRAC(cpu_pll_rate),
-		 RINT(pll_rate), RFRAC(pll_rate));
+	if (mt762x_soc == MT762X_SOC_MT7628AN) {
+		if (xtal_rate == MHZ(40))
+			cpu_rate = MHZ(580);
+		else
+			cpu_rate = MHZ(575);
+		dram_rate = sys_rate = cpu_rate / 3;
+		periph_rate = MHZ(40);
+
+		ralink_clk_add("10000d00.uartlite", periph_rate);
+		ralink_clk_add("10000e00.uartlite", periph_rate);
+	} else {
+		cpu_pll_rate = mt7620_get_cpu_pll_rate(xtal_rate);
+		pll_rate = mt7620_get_pll_rate(xtal_rate, cpu_pll_rate);
+
+		cpu_rate = mt7620_get_cpu_rate(pll_rate);
+		dram_rate = mt7620_get_dram_rate(pll_rate);
+		sys_rate = mt7620_get_sys_rate(cpu_rate);
+		periph_rate = mt7620_get_periph_rate(xtal_rate);
+
+		pr_debug(RFMT("XTAL") RFMT("CPU_PLL") RFMT("PLL"),
+			 RINT(xtal_rate), RFRAC(xtal_rate),
+			 RINT(cpu_pll_rate), RFRAC(cpu_pll_rate),
+			 RINT(pll_rate), RFRAC(pll_rate));
+
+		ralink_clk_add("10000500.uart", periph_rate);
+	}
 
 	pr_debug(RFMT("CPU") RFMT("DRAM") RFMT("SYS") RFMT("PERIPH"),
 		 RINT(cpu_rate), RFRAC(cpu_rate),
 		 RINT(dram_rate), RFRAC(dram_rate),
 		 RINT(sys_rate), RFRAC(sys_rate),
 		 RINT(periph_rate), RFRAC(periph_rate));
-
 #undef RFRAC
 #undef RINT
 #undef RFMT
@@ -274,7 +420,6 @@ void __init ralink_clk_init(void)
 	ralink_clk_add("cpu", cpu_rate);
 	ralink_clk_add("10000100.timer", periph_rate);
 	ralink_clk_add("10000120.watchdog", periph_rate);
-	ralink_clk_add("10000500.uart", periph_rate);
 	ralink_clk_add("10000b00.spi", sys_rate);
 	ralink_clk_add("10000c00.uartlite", periph_rate);
 	ralink_clk_add("10180000.wmac", xtal_rate);
@@ -289,6 +434,52 @@ void __init ralink_of_remap(void)
 		panic("Failed to remap core resources");
 }
 
+static __init void
+mt7620_dram_init(struct ralink_soc_info *soc_info)
+{
+	switch (dram_type) {
+	case SYSCFG0_DRAM_TYPE_SDRAM:
+		pr_info("Board has SDRAM\n");
+		soc_info->mem_size_min = MT7620_SDRAM_SIZE_MIN;
+		soc_info->mem_size_max = MT7620_SDRAM_SIZE_MAX;
+		break;
+
+	case SYSCFG0_DRAM_TYPE_DDR1:
+		pr_info("Board has DDR1\n");
+		soc_info->mem_size_min = MT7620_DDR1_SIZE_MIN;
+		soc_info->mem_size_max = MT7620_DDR1_SIZE_MAX;
+		break;
+
+	case SYSCFG0_DRAM_TYPE_DDR2:
+		pr_info("Board has DDR2\n");
+		soc_info->mem_size_min = MT7620_DDR2_SIZE_MIN;
+		soc_info->mem_size_max = MT7620_DDR2_SIZE_MAX;
+		break;
+	default:
+		BUG();
+	}
+}
+
+static __init void
+mt7628_dram_init(struct ralink_soc_info *soc_info)
+{
+	switch (dram_type) {
+	case SYSCFG0_DRAM_TYPE_DDR1_MT7628:
+		pr_info("Board has DDR1\n");
+		soc_info->mem_size_min = MT7620_DDR1_SIZE_MIN;
+		soc_info->mem_size_max = MT7620_DDR1_SIZE_MAX;
+		break;
+
+	case SYSCFG0_DRAM_TYPE_DDR2_MT7628:
+		pr_info("Board has DDR2\n");
+		soc_info->mem_size_min = MT7620_DDR2_SIZE_MIN;
+		soc_info->mem_size_max = MT7620_DDR2_SIZE_MAX;
+		break;
+	default:
+		BUG();
+	}
+}
+
 void prom_soc_init(struct ralink_soc_info *soc_info)
 {
 	void __iomem *sysc = (void __iomem *) KSEG1ADDR(MT7620_SYSC_BASE);
@@ -306,18 +497,25 @@ void prom_soc_init(struct ralink_soc_info *soc_info)
 	rev = __raw_readl(sysc + SYSC_REG_CHIP_REV);
 	bga = (rev >> CHIP_REV_PKG_SHIFT) & CHIP_REV_PKG_MASK;
 
-	if (n0 != MT7620_CHIP_NAME0 || n1 != MT7620_CHIP_NAME1)
-		panic("mt7620: unknown SoC, n0:%08x n1:%08x\n", n0, n1);
-
-	if (bga) {
-		name = "MT7620A";
-		soc_info->compatible = "ralink,mt7620a-soc";
-	} else {
-		name = "MT7620N";
-		soc_info->compatible = "ralink,mt7620n-soc";
+	if (n0 == MT7620_CHIP_NAME0 && n1 == MT7620_CHIP_NAME1) {
+		if (bga) {
+			mt762x_soc = MT762X_SOC_MT7620A;
+			name = "MT7620A";
+			soc_info->compatible = "ralink,mt7620a-soc";
+		} else {
+			mt762x_soc = MT762X_SOC_MT7620N;
+			name = "MT7620N";
+			soc_info->compatible = "ralink,mt7620n-soc";
 #ifdef CONFIG_PCI
-		panic("mt7620n is only supported for non pci kernels");
+			panic("mt7620n is only supported for non pci kernels");
 #endif
+		}
+	} else if (n0 == MT7620_CHIP_NAME0 && n1 == MT7628_CHIP_NAME1) {
+		mt762x_soc = MT762X_SOC_MT7628AN;
+		name = "MT7628AN";
+		soc_info->compatible = "ralink,mt7628an-soc";
+	} else {
+		panic("mt762x: unknown SoC, n0:%08x n1:%08x\n", n0, n1);
 	}
 
 	snprintf(soc_info->sys_type, RAMIPS_SYS_TYPE_LEN,
@@ -329,28 +527,11 @@ void prom_soc_init(struct ralink_soc_info *soc_info)
 	cfg0 = __raw_readl(sysc + SYSC_REG_SYSTEM_CONFIG0);
 	dram_type = (cfg0 >> SYSCFG0_DRAM_TYPE_SHIFT) & SYSCFG0_DRAM_TYPE_MASK;
 
-	switch (dram_type) {
-	case SYSCFG0_DRAM_TYPE_SDRAM:
-		pr_info("Board has SDRAM\n");
-		soc_info->mem_size_min = MT7620_SDRAM_SIZE_MIN;
-		soc_info->mem_size_max = MT7620_SDRAM_SIZE_MAX;
-		break;
-
-	case SYSCFG0_DRAM_TYPE_DDR1:
-		pr_info("Board has DDR1\n");
-		soc_info->mem_size_min = MT7620_DDR1_SIZE_MIN;
-		soc_info->mem_size_max = MT7620_DDR1_SIZE_MAX;
-		break;
-
-	case SYSCFG0_DRAM_TYPE_DDR2:
-		pr_info("Board has DDR2\n");
-		soc_info->mem_size_min = MT7620_DDR2_SIZE_MIN;
-		soc_info->mem_size_max = MT7620_DDR2_SIZE_MAX;
-		break;
-	default:
-		BUG();
-	}
 	soc_info->mem_base = MT7620_DRAM_BASE;
+	if (mt762x_soc == MT762X_SOC_MT7628AN)
+		mt7628_dram_init(soc_info);
+	else
+		mt7620_dram_init(soc_info);
 
 	pmu0 = __raw_readl(sysc + PMU0_CFG);
 	pmu1 = __raw_readl(sysc + PMU1_CFG);
@@ -359,4 +540,9 @@ void prom_soc_init(struct ralink_soc_info *soc_info)
 		(pmu0 & PMU_SW_SET) ? ("sw") : ("hw"));
 	pr_info("Digital PMU set to %s control\n",
 		(pmu1 & DIG_SW_SEL) ? ("sw") : ("hw"));
+
+	if (mt762x_soc == MT762X_SOC_MT7628AN)
+		rt2880_pinmux_data = mt7628an_pinmux_data;
+	else
+		rt2880_pinmux_data = mt7620a_pinmux_data;
 }
-- 
1.7.10.4
