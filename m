Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 May 2016 10:59:45 +0200 (CEST)
Received: from smtpbg302.qq.com ([184.105.206.27]:33527 "EHLO smtpbg302.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27029234AbcELI7mQ1a0T (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 12 May 2016 10:59:42 +0200
X-QQ-mid: esmtp32t1463043567t284t11680
Received: from localhost (unknown [180.109.228.28])
        by esmtp4.qq.com (ESMTP) with 
        id ; Thu, 12 May 2016 16:59:26 +0800 (CST)
X-QQ-SSF: 01000000000000F0F9200000002000P
X-QQ-FEAT: JNrLgFxDiy2238Ob3CCzR+xvJSjr44URriayiflXqV3GPAtjcCYxln/FwX7wy
        aczM4twF00SrKsAIDHh0dxsIKlYu+Xu7hNYsrp3gt0flwEOcGTLTc9jwVjm1RBtJWA5pDp9
        6Qrrmj9tpthD4cpOM/q8wy3Jt3v1TgHmMX99eUVkWItC8Pp0bhqYmleIlixukplfg0UX+2s
        suKdPmOkhAbDGmBTmQkWXXonOm7U+GrwEhhZNRz0o1KF3TAWyE9Izsx/KapJn8kA=
X-QQ-GoodBg: 0
X-QQ-CSender: 842587420@qq.com
From:   Yang Ling <gnaygnil@gmail.com>
To:     ralf@linux-mips.org, mturquette@baylibre.com, sboyd@codeaurora.org
Cc:     chenhc@lemote.com, gnaygnil@gmail.com, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH 1/4] clk: add Loongson1C clock support
Date:   Thu, 12 May 2016 16:59:24 +0800
Message-Id: <1463043564-21559-1-git-send-email-gnaygnil@gmail.com>
X-Mailer: git-send-email 1.9.1
X-QQ-SENDSIZE: 520
X-QQ-FName: 549E1D74D5E447BA889FC22C79FE96DC
X-QQ-LocalIP: 10.130.87.152
Return-Path: <842587420@qq.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53392
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gnaygnil@gmail.com
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

This adds clock support to Loongson1C SoC using the common clock
infrastructure.

Signed-off-by: Yang Ling <gnaygnil@gmail.com>
---
 arch/mips/include/asm/mach-loongson32/regs-clk.h | 33 ++++++++++++
 drivers/clk/clk-ls1x.c                           | 69 +++++++++++++++++++++---
 2 files changed, 95 insertions(+), 7 deletions(-)

diff --git a/arch/mips/include/asm/mach-loongson32/regs-clk.h b/arch/mips/include/asm/mach-loongson32/regs-clk.h
index 1f5a715..2cef0e2 100644
--- a/arch/mips/include/asm/mach-loongson32/regs-clk.h
+++ b/arch/mips/include/asm/mach-loongson32/regs-clk.h
@@ -1,5 +1,7 @@
 /*
  * Copyright (c) 2011 Zhang, Keguang <keguang.zhang@gmail.com>
+ * Copyright (c) 2015 Tang Haifeng <tanghaifeng-gz@loongson.cn>
+ * Copyright (c) 2016 Ling Yang <gnaygnil@gmail.com>
  *
  * Loongson 1 Clock Register Definitions.
  *
@@ -19,6 +21,7 @@
 #define LS1X_CLK_PLL_DIV		LS1X_CLK_REG(0x4)
 
 /* Clock PLL Divisor Register Bits */
+#if defined(CONFIG_LOONGSON1_LS1B)
 #define DIV_DC_EN			(0x1 << 31)
 #define DIV_DC_RST			(0x1 << 30)
 #define DIV_CPU_EN			(0x1 << 25)
@@ -48,4 +51,34 @@
 #define BYPASS_DDR_WIDTH		1
 #define BYPASS_CPU_WIDTH		1
 
+#elif defined(CONFIG_LOONGSON1_LS1C)
+
+#define PLL_VALID			(0x1 << 31)
+#define FRAC_N				(0xff << 16)
+#define RST_TIME			(0x3 << 2)
+#define SDRAM_DIV			(0x3 << 0)
+
+#define DIV_DC_EN			(0x1 << 31)
+#define DIV_DC				(0x7f << 24)
+#define DIV_CAM_EN			(0x1 << 23)
+#define DIV_CAM				(0x7f << 16)
+#define DIV_CPU_EN			(0x1 << 15)
+#define DIV_CPU				(0x7f << 8)
+#define DIV_DC_SEL_EN			(0x1 << 5)
+#define DIV_DC_SEL			(0x1 << 4)
+#define DIV_CAM_SEL_EN			(0x1 << 3)
+#define DIV_CAM_SEL			(0x1 << 2)
+#define DIV_CPU_SEL_EN			(0x1 << 1)
+#define DIV_CPU_SEL			(0x1 << 0)
+
+#define DIV_DC_SHIFT                    24
+#define DIV_CAM_SHIFT                   16
+#define DIV_CPU_SHIFT                   8
+
+#define DIV_DC_WIDTH                    7
+#define DIV_CPU_WIDTH                   7
+#define DIV_DDR_WIDTH                   7
+
+#endif
+
 #endif /* __ASM_MACH_LOONGSON32_REGS_CLK_H */
diff --git a/drivers/clk/clk-ls1x.c b/drivers/clk/clk-ls1x.c
index d4c6198..746e653 100644
--- a/drivers/clk/clk-ls1x.c
+++ b/drivers/clk/clk-ls1x.c
@@ -1,5 +1,7 @@
 /*
  * Copyright (c) 2012 Zhang, Keguang <keguang.zhang@gmail.com>
+ * Copyright (c) 2015 Tang Haifeng <tanghaifeng-gz@loongson.cn>
+ * Copyright (c) 2016 Ling Yang <gnaygnil@gmail.com>
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
@@ -15,8 +17,13 @@
 
 #include <loongson1.h>
 
+#if defined(CONFIG_LOONGSON1_LS1B)
 #define OSC		(33 * 1000000)
 #define DIV_APB		2
+#elif defined(CONFIG_LOONGSON1_LS1C)
+#define OSC		(24 * 1000000)
+#define DIV_APB		1
+#endif
 
 static DEFINE_SPINLOCK(_lock);
 
@@ -35,9 +42,15 @@ static unsigned long ls1x_pll_recalc_rate(struct clk_hw *hw,
 	u32 pll, rate;
 
 	pll = __raw_readl(LS1X_CLK_PLL_FREQ);
+#if defined(CONFIG_LOONGSON1_LS1B)
 	rate = 12 + (pll & 0x3f) + (((pll >> 8) & 0x3ff) >> 10);
 	rate *= OSC;
 	rate >>= 1;
+#elif defined(CONFIG_LOONGSON1_LS1C)
+	rate = ((pll >> 8) & 0xff) + ((pll >> 16) & 0xff);
+	rate *= OSC;
+	rate >>= 2;
+#endif
 
 	return rate;
 }
@@ -80,22 +93,25 @@ static struct clk *__init clk_register_pll(struct device *dev,
 	return clk;
 }
 
-static const char * const cpu_parents[] = { "cpu_clk_div", "osc_33m_clk", };
-static const char * const ahb_parents[] = { "ahb_clk_div", "osc_33m_clk", };
-static const char * const dc_parents[] = { "dc_clk_div", "osc_33m_clk", };
+static const char * const cpu_parents[] = { "cpu_clk_div", "osc_clk", };
+static const char * const ahb_parents[] = { "ahb_clk_div", "osc_clk", };
+static const char * const dc_parents[] = { "dc_clk_div", "osc_clk", };
 
 void __init ls1x_clk_init(void)
 {
 	struct clk *clk;
+	u32 reg;
+	u32 div;
 
-	clk = clk_register_fixed_rate(NULL, "osc_33m_clk", NULL, CLK_IS_ROOT,
+	clk = clk_register_fixed_rate(NULL, "osc_clk", NULL, CLK_IS_ROOT,
 				      OSC);
-	clk_register_clkdev(clk, "osc_33m_clk", NULL);
+	clk_register_clkdev(clk, "osc_clk", NULL);
 
-	/* clock derived from 33 MHz OSC clk */
-	clk = clk_register_pll(NULL, "pll_clk", "osc_33m_clk", 0);
+	/* clock derived from OSC clk */
+	clk = clk_register_pll(NULL, "pll_clk", "osc_clk", 0);
 	clk_register_clkdev(clk, "pll_clk", NULL);
 
+#if defined(CONFIG_LOONGSON1_LS1B)
 	/* clock derived from PLL clk */
 	/*                                 _____
 	 *         _______________________|     |
@@ -114,7 +130,23 @@ void __init ls1x_clk_init(void)
 			       CLK_SET_RATE_NO_REPARENT, LS1X_CLK_PLL_DIV,
 			       BYPASS_CPU_SHIFT, BYPASS_CPU_WIDTH, 0, &_lock);
 	clk_register_clkdev(clk, "cpu_clk", NULL);
+#elif defined(CONFIG_LOONGSON1_LS1C)
+	reg = __raw_readl(LS1X_CLK_PLL_DIV);
+	if (reg & DIV_CPU_SEL) {
+		if (reg & DIV_CPU_EN) {
+			clk = clk_register_divider(NULL, "cpu_clk", "pll_clk",
+					CLK_SET_RATE_PARENT, LS1X_CLK_PLL_DIV,
+					DIV_CPU_SHIFT, DIV_CPU_WIDTH,
+					CLK_DIVIDER_ONE_BASED, &_lock);
+		} else {
+			clk = clk_register_fixed_factor(NULL, "cpu_clk",
+							"pll_clk", 0, 1, 2);
+		}
+	}
+	clk_register_clkdev(clk, "cpu_clk", NULL);
+#endif
 
+#if defined(CONFIG_LOONGSON1_LS1B)
 	/*                                 _____
 	 *         _______________________|     |
 	 * OSC ___/                       | MUX |___ DC  CLK
@@ -130,7 +162,14 @@ void __init ls1x_clk_init(void)
 			       CLK_SET_RATE_NO_REPARENT, LS1X_CLK_PLL_DIV,
 			       BYPASS_DC_SHIFT, BYPASS_DC_WIDTH, 0, &_lock);
 	clk_register_clkdev(clk, "dc_clk", NULL);
+#elif defined(CONFIG_LOONGSON1_LS1C)
+	clk = clk_register_divider(NULL, "dc_clk", "pll_clk",
+			CLK_SET_RATE_PARENT, LS1X_CLK_PLL_DIV, DIV_DC_SHIFT,
+			DIV_DC_WIDTH, CLK_DIVIDER_ONE_BASED, &_lock);
+	clk_register_clkdev(clk, "dc_clk", NULL);
+#endif
 
+#if defined(CONFIG_LOONGSON1_LS1B)
 	/*                                 _____
 	 *         _______________________|     |
 	 * OSC ___/                       | MUX |___ DDR CLK
@@ -146,6 +185,22 @@ void __init ls1x_clk_init(void)
 			       ARRAY_SIZE(ahb_parents),
 			       CLK_SET_RATE_NO_REPARENT, LS1X_CLK_PLL_DIV,
 			       BYPASS_DDR_SHIFT, BYPASS_DDR_WIDTH, 0, &_lock);
+#elif defined(CONFIG_LOONGSON1_LS1C)
+	reg = __raw_readl(LS1X_CLK_PLL_FREQ) & SDRAM_DIV;
+	switch (reg) {
+	case 0:
+		div = 2;
+		break;
+	case 1:
+		div = 4;
+		break;
+	case 2:
+	case 3:
+		div = 3;
+		break;
+	}
+	clk = clk_register_fixed_factor(NULL, "ahb_clk", "cpu_clk", 0, 1, div);
+#endif
 	clk_register_clkdev(clk, "ahb_clk", NULL);
 	clk_register_clkdev(clk, "stmmaceth", NULL);
 
-- 
1.9.1
