Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Apr 2015 05:40:22 +0200 (CEST)
Received: from smtpbg299.qq.com ([184.105.67.99]:46810 "EHLO smtpbg299.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27012180AbbD2DkHEdjlw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 29 Apr 2015 05:40:07 +0200
X-QQ-mid: bizesmtp2t1430278787t988t327
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Wed, 29 Apr 2015 11:39:46 +0800 (CST)
X-QQ-SSF: 01100000002000F0F422B00A0000000
X-QQ-FEAT: wkBK5F5nnthN8RUWKzY/egJWqR2np3AIg8HvjU+2ClDhNAr7Zp7d6QuVnKkoO
        xJcL2xr3EYlsPhub88wGz8rPZtmR60R6m+Qb2XvElmCgwAvmlY8/9sIIFaK9MyaeqCs9CMc
        iGBUP3ZFNrrRPJ2qSFQsKDhrEXpki1mcmX7/DrIeRqOdmCADOJAhlx/OT4Z9Y7ZNzL7g/HP
        k1Lm9VOmBXa8Twry8tiw7RGGLgM6cGVBqoQara1eQVUyysshKyIN/
X-QQ-GoodBg: 0
From:   Binbin Zhou <zhoubb@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Binbin Zhou <zhoubb@lemote.com>, Chunbo Cui <cuicb@lemote.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH 5/8] MIPS: Loongson-1A: Workaround for pll register can't be read
Date:   Wed, 29 Apr 2015 11:57:24 +0800
Message-Id: <1430279847-25120-6-git-send-email-zhoubb@lemote.com>
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1430279847-25120-1-git-send-email-zhoubb@lemote.com>
References: <1430279847-25120-1-git-send-email-zhoubb@lemote.com>
X-QQ-SENDSIZE: 520
X-QQ-FName: DF56C5E3216B408C834745748AA31348
X-QQ-LocalIP: 112.95.241.173
Return-Path: <zhoubb@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47151
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zhoubb@lemote.com
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

This is Loongson 1A's bug that the pll register can't be read,
so we set the cpu clk in the inline command line.

The command line format is cpu_clk=osc_clk,cpu_mul, the osc_clk standby cpu clock
and the cpu_mul repect the clock multiplier.
For example, we use the command is cpu_clk=33333333,8

Signed-off-by: Chunbo Cui <cuicb@lemote.com>
Signed-off-by: Binbin Zhou <zhoubb@lemote.com>
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/include/asm/mach-loongson1/loongson1.h |  2 ++
 arch/mips/loongson1/common/platform.c            |  8 +++++++-
 arch/mips/loongson1/common/time.c                | 11 +++++++++++
 arch/mips/loongson1/ls1a/board.c                 |  2 ++
 drivers/clk/clk-ls1x.c                           | 19 +++++++++++++++----
 5 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/arch/mips/include/asm/mach-loongson1/loongson1.h b/arch/mips/include/asm/mach-loongson1/loongson1.h
index c7689ad..c7ce66e 100644
--- a/arch/mips/include/asm/mach-loongson1/loongson1.h
+++ b/arch/mips/include/asm/mach-loongson1/loongson1.h
@@ -165,6 +165,8 @@
 #define ls1x_writew(val, addr)		(*(volatile u16 *)CKSEG1ADDR(addr) = (val))
 #define ls1x_writel(val, addr)		(*(volatile u32 *)CKSEG1ADDR(addr) = (val))
 
+extern unsigned int ls1a_osc_clk, ls1a_cpu_mul;
+
 #include <regs-clk.h>
 #include <regs-mux.h>
 #include <regs-pwm.h>
diff --git a/arch/mips/loongson1/common/platform.c b/arch/mips/loongson1/common/platform.c
index 97d8c01..a5bb1eb 100644
--- a/arch/mips/loongson1/common/platform.c
+++ b/arch/mips/loongson1/common/platform.c
@@ -63,9 +63,14 @@ struct platform_device ls1x_uart_pdev = {
 
 void __init ls1x_serial_setup(struct platform_device *pdev)
 {
-	struct clk *clk;
 	struct plat_serial8250_port *p;
 
+#ifdef CONFIG_CPU_LOONGSON1A
+	for (p = pdev->dev.platform_data; p->flags != 0; ++p)
+		p->uartclk = ls1a_osc_clk * 2;
+#else
+	struct clk *clk;
+
 	clk = clk_get(&pdev->dev, pdev->name);
 	if (IS_ERR(clk)) {
 		pr_err("unable to get %s clock, err=%ld",
@@ -76,6 +81,7 @@ void __init ls1x_serial_setup(struct platform_device *pdev)
 
 	for (p = pdev->dev.platform_data; p->flags != 0; ++p)
 		p->uartclk = clk_get_rate(clk);
+#endif
 }
 
 /* CPUFreq */
diff --git a/arch/mips/loongson1/common/time.c b/arch/mips/loongson1/common/time.c
index df0f850..c9f2ee4 100644
--- a/arch/mips/loongson1/common/time.c
+++ b/arch/mips/loongson1/common/time.c
@@ -224,3 +224,14 @@ void __init plat_time_init(void)
 	mips_hpt_frequency = clk_get_rate(clk) / 2;
 #endif /* CONFIG_CEVT_CSRC_LS1X */
 }
+
+#ifdef CONFIG_CPU_LOONGSON1A
+unsigned int ls1a_osc_clk = 0, ls1a_cpu_mul = 0;
+
+static int __init get_cpu_clk(char *string)
+{
+	sscanf(string, "%u,%u", &ls1a_osc_clk, &ls1a_cpu_mul);
+	return 1;
+}
+__setup("cpu_clk=", get_cpu_clk);
+#endif
diff --git a/arch/mips/loongson1/ls1a/board.c b/arch/mips/loongson1/ls1a/board.c
index 98fb86c..9c53ecc 100644
--- a/arch/mips/loongson1/ls1a/board.c
+++ b/arch/mips/loongson1/ls1a/board.c
@@ -95,6 +95,8 @@ int __init ls1a_platform_init(void)
 {
 	ls1a_route_setting();
 
+	ls1x_serial_setup(&ls1x_uart_pdev);
+
 	i2c_register_board_info(1, &ls1a_pcf8563, 1);
 	spi_register_board_info(ls1a_spi_info, ARRAY_SIZE(ls1a_spi_info));
 
diff --git a/drivers/clk/clk-ls1x.c b/drivers/clk/clk-ls1x.c
index ca80103..93eda9e 100644
--- a/drivers/clk/clk-ls1x.c
+++ b/drivers/clk/clk-ls1x.c
@@ -32,6 +32,14 @@ static void ls1x_pll_clk_disable(struct clk_hw *hw)
 static unsigned long ls1x_pll_recalc_rate(struct clk_hw *hw,
 					  unsigned long parent_rate)
 {
+#ifdef CONFIG_CPU_LOONGSON1A
+	/* workaround, loongson 1A pll register can't be read,
+	 * on gateway board, multi is set to 11 */
+	if (ls1a_osc_clk != 0 && ls1a_cpu_mul != 0)
+		return ls1a_osc_clk * ls1a_cpu_mul;
+	else
+		return 33333333 * 8;
+#else
 	u32 pll, rate;
 
 	pll = __raw_readl(LS1X_CLK_PLL_FREQ);
@@ -40,6 +48,7 @@ static unsigned long ls1x_pll_recalc_rate(struct clk_hw *hw,
 	rate >>= 1;
 
 	return rate;
+#endif
 }
 
 static const struct clk_ops ls1x_pll_clk_ops = {
@@ -107,7 +116,8 @@ void __init ls1x_clk_init(void)
 				   CLK_GET_RATE_NOCACHE, LS1X_CLK_PLL_DIV,
 				   DIV_CPU_SHIFT, DIV_CPU_WIDTH,
 				   CLK_DIVIDER_ONE_BASED |
-				   CLK_DIVIDER_ROUND_CLOSEST, &_lock);
+				   CLK_DIVIDER_ROUND_CLOSEST |
+				   CLK_DIVIDER_ALLOW_ZERO, &_lock);
 	clk_register_clkdev(clk, "cpu_clk_div", NULL);
 	clk = clk_register_mux(NULL, "cpu_clk", cpu_parents,
 			       ARRAY_SIZE(cpu_parents),
@@ -123,7 +133,8 @@ void __init ls1x_clk_init(void)
 	 */
 	clk = clk_register_divider(NULL, "dc_clk_div", "pll_clk",
 				   0, LS1X_CLK_PLL_DIV, DIV_DC_SHIFT,
-				   DIV_DC_WIDTH, CLK_DIVIDER_ONE_BASED, &_lock);
+				   DIV_DC_WIDTH, CLK_DIVIDER_ONE_BASED |
+				   CLK_DIVIDER_ALLOW_ZERO, &_lock);
 	clk_register_clkdev(clk, "dc_clk_div", NULL);
 	clk = clk_register_mux(NULL, "dc_clk", dc_parents,
 			       ARRAY_SIZE(dc_parents),
@@ -139,8 +150,8 @@ void __init ls1x_clk_init(void)
 	 */
 	clk = clk_register_divider(NULL, "ahb_clk_div", "pll_clk",
 				   0, LS1X_CLK_PLL_DIV, DIV_DDR_SHIFT,
-				   DIV_DDR_WIDTH, CLK_DIVIDER_ONE_BASED,
-				   &_lock);
+				   DIV_DDR_WIDTH, CLK_DIVIDER_ONE_BASED |
+				   CLK_DIVIDER_ALLOW_ZERO, &_lock);
 	clk_register_clkdev(clk, "ahb_clk_div", NULL);
 	clk = clk_register_mux(NULL, "ahb_clk", ahb_parents,
 			       ARRAY_SIZE(ahb_parents),
-- 
1.9.0
