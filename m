Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Oct 2012 04:49:31 +0200 (CEST)
Received: from mail.kernel.org ([198.145.19.201]:52047 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823121Ab2JSCt2k8MGa (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 19 Oct 2012 04:49:28 +0200
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 4B0BB202D5;
        Fri, 19 Oct 2012 02:49:25 +0000 (UTC)
Received: from localhost (c-67-168-183-230.hsd1.wa.comcast.net [67.168.183.230])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8CB8202D9;
        Fri, 19 Oct 2012 02:49:23 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        alan@lxorguk.ukuu.org.uk, Gabor Juhos <juhosg@openwrt.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [ 52/76] MIPS: ath79: Fix CPU/DDR frequency calculation for SRIF PLLs
Date:   Thu, 18 Oct 2012 19:47:16 -0700
Message-Id: <20121019024358.485523281@linuxfoundation.org>
X-Mailer: git-send-email 1.8.0.rc0.18.gf84667d
In-Reply-To: <20121019024350.087156547@linuxfoundation.org>
References: <20121019024350.087156547@linuxfoundation.org>
User-Agent: quilt/0.60-2.1.2
X-Virus-Scanned: ClamAV using ClamSMTP
X-archive-position: 34724
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

3.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gabor Juhos <juhosg@openwrt.org>

commit 97541ccfb9db2bb9cd1dde6344d5834438d14bda upstream.

Besides the CPU and DDR PLLs, the CPU and DDR frequencies
can be derived from other PLLs in the SRIF block on the
AR934x SoCs. The current code does not checks if the SRIF
PLLs are used and this can lead to incorrectly calculated
CPU/DDR frequencies.

Fix it by calculating the frequencies from SRIF PLLs if
those are used on a given board.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/4324/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/ath79/clock.c                        |  109 ++++++++++++++++++-------
 arch/mips/include/asm/mach-ath79/ar71xx_regs.h |   23 +++++
 2 files changed, 104 insertions(+), 28 deletions(-)

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
@@ -166,11 +168,34 @@ static void __init ar933x_clocks_init(vo
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
@@ -178,33 +203,59 @@ static void __init ar934x_clocks_init(vo
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
 
@@ -240,6 +291,8 @@ static void __init ar934x_clocks_init(vo
 
 	ath79_wdt_clk.rate = ath79_ref_clk.rate;
 	ath79_uart_clk.rate = ath79_ref_clk.rate;
+
+	iounmap(dpll_base);
 }
 
 void __init ath79_clocks_init(void)
--- a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
+++ b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
@@ -63,6 +63,8 @@
 
 #define AR934X_WMAC_BASE	(AR71XX_APB_BASE + 0x00100000)
 #define AR934X_WMAC_SIZE	0x20000
+#define AR934X_SRIF_BASE	(AR71XX_APB_BASE + 0x00116000)
+#define AR934X_SRIF_SIZE	0x1000
 
 /*
  * DDR_CTRL block
@@ -399,4 +401,25 @@
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
