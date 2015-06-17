Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Jun 2015 12:15:21 +0200 (CEST)
Received: from smtpbg64.qq.com ([103.7.28.238]:15253 "EHLO smtpbg64.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008389AbbFQKOOxOhmp (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 17 Jun 2015 12:14:14 +0200
X-QQ-mid: bizesmtp4t1434536041t420t077
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Wed, 17 Jun 2015 18:14:00 +0800 (CST)
X-QQ-SSF: 01100000002000F0F852000A0000000
X-QQ-FEAT: 0ESs8nxzjD9Zi3Yv5inM6xRskGzEOtD6lEPWnw7bOkoFXRKODLEiDg1UO91mF
        Z3w39ipA6YY1HHsusvtZDkyL+rRO1JM2Q5CJ02jvcclLkprw+y/jg8m2roMdOSpF4FQv4cO
        jSmOiZ2R98T23parzj/O42tjPp5oOJR5o8xMGOaH0N2iUzdr5uDrveKOj63adlDuNYFav5W
        6YVHlmeT19/qKo7nQfukwrOy4AZkHlOjQHEFMM1hoxz56fXzDuTacrNIQLMlY6YM=
X-QQ-GoodBg: 0
From:   Binbin Zhou <zhoubb@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Kelvin Cheung <keguang.zhang@gmail.com>,
        Binbin Zhou <zhoubb@lemote.com>, Chunbo Cui <cuicb@lemote.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH v2 5/8] MIPS: Loongson-1A: Workaround for pll register can't be read
Date:   Wed, 17 Jun 2015 18:32:43 +0800
Message-Id: <1434537166-5385-6-git-send-email-zhoubb@lemote.com>
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1434537166-5385-1-git-send-email-zhoubb@lemote.com>
References: <1434537166-5385-1-git-send-email-zhoubb@lemote.com>
X-QQ-SENDSIZE: 520
Return-Path: <zhoubb@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47954
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

The command line format is cpu_clk=osc_clk,cpu_mul,
the osc_clk standby cpu clock and the cpu_mul repect the clock multiplier.
For example, we use the command is cpu_clk=33333333,8

Signed-off-by: Chunbo Cui <cuicb@lemote.com>
Signed-off-by: Binbin Zhou <zhoubb@lemote.com>
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/include/asm/mach-loongson32/loongson1.h |  2 ++
 arch/mips/loongson32/common/platform.c            |  8 +++++++-
 arch/mips/loongson32/common/time.c                | 16 ++++++++++++++++
 arch/mips/loongson32/ls1a/board.c                 |  2 ++
 drivers/clk/clk-ls1x.c                            | 19 +++++++++++++++----
 5 files changed, 42 insertions(+), 5 deletions(-)

diff --git a/arch/mips/include/asm/mach-loongson32/loongson1.h b/arch/mips/include/asm/mach-loongson32/loongson1.h
index 3061e64..82f951e 100644
--- a/arch/mips/include/asm/mach-loongson32/loongson1.h
+++ b/arch/mips/include/asm/mach-loongson32/loongson1.h
@@ -165,6 +165,8 @@
 #define ls1x_writew(val, addr)		(*(volatile u16 *)CKSEG1ADDR(addr) = (val))
 #define ls1x_writel(val, addr)		(*(volatile u32 *)CKSEG1ADDR(addr) = (val))
 
+extern unsigned int ls1a_osc_clk, ls1a_cpu_mul;
+
 #include <regs-clk.h>
 #include <regs-mux.h>
 #include <regs-pwm.h>
diff --git a/arch/mips/loongson32/common/platform.c b/arch/mips/loongson32/common/platform.c
index 97d8c01..a5bb1eb 100644
--- a/arch/mips/loongson32/common/platform.c
+++ b/arch/mips/loongson32/common/platform.c
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
diff --git a/arch/mips/loongson32/common/time.c b/arch/mips/loongson32/common/time.c
index df0f850..01d3950 100644
--- a/arch/mips/loongson32/common/time.c
+++ b/arch/mips/loongson32/common/time.c
@@ -224,3 +224,19 @@ void __init plat_time_init(void)
 	mips_hpt_frequency = clk_get_rate(clk) / 2;
 #endif /* CONFIG_CEVT_CSRC_LS1X */
 }
+
+#ifdef CONFIG_CPU_LOONGSON1A
+unsigned int ls1a_osc_clk = 0, ls1a_cpu_mul = 0;
+
+static int __init get_cpu_clk(char *string)
+{
+	int ret;
+
+	ret = sscanf(string, "%u,%u", &ls1a_osc_clk, &ls1a_cpu_mul);
+	if (ret != 1)
+		return -EINVAL;
+
+	return 1;
+}
+__setup("cpu_clk=", get_cpu_clk);
+#endif
diff --git a/arch/mips/loongson32/ls1a/board.c b/arch/mips/loongson32/ls1a/board.c
index 98fb86c..9c53ecc 100644
--- a/arch/mips/loongson32/ls1a/board.c
+++ b/arch/mips/loongson32/ls1a/board.c
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
