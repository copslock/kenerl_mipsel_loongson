Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Sep 2012 14:02:49 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:57346 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903258Ab2IHMCl (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 8 Sep 2012 14:02:41 +0200
X-Virus-Scanned: at arrakis.dune.hu
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 1070A23C0088;
        Sat,  8 Sep 2012 14:02:37 +0200 (CEST)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Gabor Juhos <juhosg@openwrt.org>,
        <stable@vger.kernel.org>
Subject: [PATCH] MIPS: ath79: fix CPU/DDR frequency calculation for SRIF PLLs
Date:   Sat,  8 Sep 2012 14:02:21 +0200
Message-Id: <1347105741-23091-1-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.10
X-archive-position: 34443
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
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Status: A

Besides the CPU and DDR PLLs, the CPU and DDR frequencies
can be derived from other PLLs in the SRIF block on the
AR934x SoCs. The current code does not checks if the SRIF
PLLs are used and this can lead to incorrectly calculated
CPU/DDR frequencies.

Fix it by calculating the frequencies from SRIF PLLs if
those are used on a given board.

Cc: <stable@vger.kernel.org>
Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
This depends on the following patch:
'MIPS: ath79: use correct fractional dividers for {CPU,DDR}_PLL on AR934x'
https://patchwork.linux-mips.org/patch/4305/

 arch/mips/ath79/clock.c                        |  109 ++++++++++++++++++------
 arch/mips/include/asm/mach-ath79/ar71xx_regs.h |   23 +++++
 2 files changed, 104 insertions(+), 28 deletions(-)

diff --git a/arch/mips/ath79/clock.c b/arch/mips/ath79/clock.c
index d272857..579f452 100644
--- a/arch/mips/ath79/clock.c
+++ b/arch/mips/ath79/clock.c
@@ -17,6 +17,8 @@
 #include <linux/err.h>
 #include <linux/clk.h>
 
+#include <asm/div64.h>
+
 #include <asm/mach-ath79/ath79.h>
 #include <asm/mach-ath79/ar71xx_regs.h>
 #include "common.h"
@@ -166,11 +168,34 @@ static void __init ar933x_clocks_init(void)
 	ath79_uart_clk.rate = ath79_ref_clk.rate;
 }
 
+static u32 __init ar934x_get_pll_freq(u32 ref, u32 ref_div, u32 nint, u32 nfrac,
+				      u32 frac, u32 out_div)
+{
+	u64 t;
+	u32 ret;
+
+	t = ath79_ref_clk.rate;
+	t *= nint;
+	do_div(t, ref_div);
+	ret = t;
+
+	t = ath79_ref_clk.rate;
+	t *= nfrac;
+	do_div(t, ref_div * frac);
+	ret += t;
+
+	ret /= (1 << out_div);
+	return ret;
+}
+
 static void __init ar934x_clocks_init(void)
 {
-	u32 pll, out_div, ref_div, nint, frac, clk_ctrl, postdiv;
+	u32 pll, out_div, ref_div, nint, nfrac, frac, clk_ctrl, postdiv;
 	u32 cpu_pll, ddr_pll;
 	u32 bootstrap;
+	void __iomem *dpll_base;
+
+	dpll_base = ioremap(AR934X_SRIF_BASE, AR934X_SRIF_SIZE);
 
 	bootstrap = ath79_reset_rr(AR934X_RESET_REG_BOOTSTRAP);
 	if (bootstrap &	AR934X_BOOTSTRAP_REF_CLK_40)
@@ -178,33 +203,59 @@ static void __init ar934x_clocks_init(void)
 	else
 		ath79_ref_clk.rate = 25 * 1000 * 1000;
 
-	pll = ath79_pll_rr(AR934X_PLL_CPU_CONFIG_REG);
-	out_div = (pll >> AR934X_PLL_CPU_CONFIG_OUTDIV_SHIFT) &
-		  AR934X_PLL_CPU_CONFIG_OUTDIV_MASK;
-	ref_div = (pll >> AR934X_PLL_CPU_CONFIG_REFDIV_SHIFT) &
-		  AR934X_PLL_CPU_CONFIG_REFDIV_MASK;
-	nint = (pll >> AR934X_PLL_CPU_CONFIG_NINT_SHIFT) &
-	       AR934X_PLL_CPU_CONFIG_NINT_MASK;
-	frac = (pll >> AR934X_PLL_CPU_CONFIG_NFRAC_SHIFT) &
-	       AR934X_PLL_CPU_CONFIG_NFRAC_MASK;
-
-	cpu_pll = nint * ath79_ref_clk.rate / ref_div;
-	cpu_pll += frac * ath79_ref_clk.rate / (ref_div * (1 << 6));
-	cpu_pll /= (1 << out_div);
-
-	pll = ath79_pll_rr(AR934X_PLL_DDR_CONFIG_REG);
-	out_div = (pll >> AR934X_PLL_DDR_CONFIG_OUTDIV_SHIFT) &
-		  AR934X_PLL_DDR_CONFIG_OUTDIV_MASK;
-	ref_div = (pll >> AR934X_PLL_DDR_CONFIG_REFDIV_SHIFT) &
-		  AR934X_PLL_DDR_CONFIG_REFDIV_MASK;
-	nint = (pll >> AR934X_PLL_DDR_CONFIG_NINT_SHIFT) &
-	       AR934X_PLL_DDR_CONFIG_NINT_MASK;
-	frac = (pll >> AR934X_PLL_DDR_CONFIG_NFRAC_SHIFT) &
-	       AR934X_PLL_DDR_CONFIG_NFRAC_MASK;
-
-	ddr_pll = nint * ath79_ref_clk.rate / ref_div;
-	ddr_pll += frac * ath79_ref_clk.rate / (ref_div * (1 << 10));
-	ddr_pll /= (1 << out_div);
+	pll = __raw_readl(dpll_base + AR934X_SRIF_CPU_DPLL2_REG);
+	if (pll & AR934X_SRIF_DPLL2_LOCAL_PLL) {
+		out_div = (pll >> AR934X_SRIF_DPLL2_OUTDIV_SHIFT) &
+			  AR934X_SRIF_DPLL2_OUTDIV_MASK;
+		pll = __raw_readl(dpll_base + AR934X_SRIF_CPU_DPLL1_REG);
+		nint = (pll >> AR934X_SRIF_DPLL1_NINT_SHIFT) &
+		       AR934X_SRIF_DPLL1_NINT_MASK;
+		nfrac = pll & AR934X_SRIF_DPLL1_NFRAC_MASK;
+		ref_div = (pll >> AR934X_SRIF_DPLL1_REFDIV_SHIFT) &
+			  AR934X_SRIF_DPLL1_REFDIV_MASK;
+		frac = 1 << 18;
+	} else {
+		pll = ath79_pll_rr(AR934X_PLL_CPU_CONFIG_REG);
+		out_div = (pll >> AR934X_PLL_CPU_CONFIG_OUTDIV_SHIFT) &
+			AR934X_PLL_CPU_CONFIG_OUTDIV_MASK;
+		ref_div = (pll >> AR934X_PLL_CPU_CONFIG_REFDIV_SHIFT) &
+			  AR934X_PLL_CPU_CONFIG_REFDIV_MASK;
+		nint = (pll >> AR934X_PLL_CPU_CONFIG_NINT_SHIFT) &
+		       AR934X_PLL_CPU_CONFIG_NINT_MASK;
+		nfrac = (pll >> AR934X_PLL_CPU_CONFIG_NFRAC_SHIFT) &
+			AR934X_PLL_CPU_CONFIG_NFRAC_MASK;
+		frac = 1 << 6;
+	}
+
+	cpu_pll = ar934x_get_pll_freq(ath79_ref_clk.rate, ref_div, nint,
+				      nfrac, frac, out_div);
+
+	pll = __raw_readl(dpll_base + AR934X_SRIF_DDR_DPLL2_REG);
+	if (pll & AR934X_SRIF_DPLL2_LOCAL_PLL) {
+		out_div = (pll >> AR934X_SRIF_DPLL2_OUTDIV_SHIFT) &
+			  AR934X_SRIF_DPLL2_OUTDIV_MASK;
+		pll = __raw_readl(dpll_base + AR934X_SRIF_DDR_DPLL1_REG);
+		nint = (pll >> AR934X_SRIF_DPLL1_NINT_SHIFT) &
+		       AR934X_SRIF_DPLL1_NINT_MASK;
+		nfrac = pll & AR934X_SRIF_DPLL1_NFRAC_MASK;
+		ref_div = (pll >> AR934X_SRIF_DPLL1_REFDIV_SHIFT) &
+			  AR934X_SRIF_DPLL1_REFDIV_MASK;
+		frac = 1 << 18;
+	} else {
+		pll = ath79_pll_rr(AR934X_PLL_DDR_CONFIG_REG);
+		out_div = (pll >> AR934X_PLL_DDR_CONFIG_OUTDIV_SHIFT) &
+			  AR934X_PLL_DDR_CONFIG_OUTDIV_MASK;
+		ref_div = (pll >> AR934X_PLL_DDR_CONFIG_REFDIV_SHIFT) &
+			   AR934X_PLL_DDR_CONFIG_REFDIV_MASK;
+		nint = (pll >> AR934X_PLL_DDR_CONFIG_NINT_SHIFT) &
+		       AR934X_PLL_DDR_CONFIG_NINT_MASK;
+		nfrac = (pll >> AR934X_PLL_DDR_CONFIG_NFRAC_SHIFT) &
+			AR934X_PLL_DDR_CONFIG_NFRAC_MASK;
+		frac = 1 << 10;
+	}
+
+	ddr_pll = ar934x_get_pll_freq(ath79_ref_clk.rate, ref_div, nint,
+				      nfrac, frac, out_div);
 
 	clk_ctrl = ath79_pll_rr(AR934X_PLL_CPU_DDR_CLK_CTRL_REG);
 
@@ -240,6 +291,8 @@ static void __init ar934x_clocks_init(void)
 
 	ath79_wdt_clk.rate = ath79_ref_clk.rate;
 	ath79_uart_clk.rate = ath79_ref_clk.rate;
+
+	iounmap(dpll_base);
 }
 
 void __init ath79_clocks_init(void)
diff --git a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
index 3ccae12..a5e0f17 100644
--- a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
+++ b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
@@ -65,6 +65,8 @@
 #define AR934X_WMAC_SIZE	0x20000
 #define AR934X_EHCI_BASE	0x1b000000
 #define AR934X_EHCI_SIZE	0x200
+#define AR934X_SRIF_BASE	(AR71XX_APB_BASE + 0x00116000)
+#define AR934X_SRIF_SIZE	0x1000
 
 /*
  * DDR_CTRL block
@@ -406,4 +408,25 @@
 #define AR933X_GPIO_COUNT		30
 #define AR934X_GPIO_COUNT		23
 
+/*
+ * SRIF block
+ */
+#define AR934X_SRIF_CPU_DPLL1_REG	0x1c0
+#define AR934X_SRIF_CPU_DPLL2_REG	0x1c4
+#define AR934X_SRIF_CPU_DPLL3_REG	0x1c8
+
+#define AR934X_SRIF_DDR_DPLL1_REG	0x240
+#define AR934X_SRIF_DDR_DPLL2_REG	0x244
+#define AR934X_SRIF_DDR_DPLL3_REG	0x248
+
+#define AR934X_SRIF_DPLL1_REFDIV_SHIFT	27
+#define AR934X_SRIF_DPLL1_REFDIV_MASK	0x1f
+#define AR934X_SRIF_DPLL1_NINT_SHIFT	18
+#define AR934X_SRIF_DPLL1_NINT_MASK	0x1ff
+#define AR934X_SRIF_DPLL1_NFRAC_MASK	0x0003ffff
+
+#define AR934X_SRIF_DPLL2_LOCAL_PLL	BIT(30)
+#define AR934X_SRIF_DPLL2_OUTDIV_SHIFT	13
+#define AR934X_SRIF_DPLL2_OUTDIV_MASK	0x7
+
 #endif /* __ASM_MACH_AR71XX_REGS_H */
-- 
1.7.10
