Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 May 2016 03:50:13 +0200 (CEST)
Received: from smtpbguseast2.qq.com ([54.204.34.130]:47692 "EHLO
        smtpbguseast2.qq.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27030503AbcESBuLfnWR0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 May 2016 03:50:11 +0200
X-QQ-mid: bizesmtp11t1463622570t978t01
Received: from localhost.localdomain (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Thu, 19 May 2016 09:49:14 +0800 (CST)
X-QQ-SSF: 01100000002000F0FG80000A0000000
X-QQ-FEAT: +kWWVVgwPy10g7dNVaWEBGv/G3Hzh7R4mLxw9WOF2B30I2hXX5MoCPiLj0Zy/
        G6sfWjdoNifxi6gw+19HePBAohVdqVCzIApFwsfuIJP6zPyGDpA6hBBA7dufH0nPcE4G4+N
        +amfJgaZqYpK1MaRCIbGzC83B8zPbf7vzSFx39YkOJrYgL9FHJAUrqABF9HHZcj0A1NdnzA
        UV1h8brkiGRjYxLRbwbKyJNNLRUCj8uvUs8GR3avy2yPJOs2yfUJc6LXslrZafw+IjwubwE
        eNyzmntH9OWmmWVSBWu6yGo8hO2pxNg1zdIA==
X-QQ-GoodBg: 0
From:   Binbin Zhou <zhoubb@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Kelvin Cheung <keguang.zhang@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, linux-clk@vger.kernel.org,
        Binbin Zhou <zhoubb@lemote.com>, Chunbo Cui <cuichboo@163.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH RESEND v4 5/9] MIPS: Loongson-1A: workaround of pll register's write-only property
Date:   Thu, 19 May 2016 09:47:12 +0800
Message-Id: <1463622432-10298-1-git-send-email-zhoubb@lemote.com>
X-Mailer: git-send-email 1.9.1
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <zhoubb@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53538
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

As Loongson 1A's pll register is write-only, so the cpu clk should be
set manually with the command line.

The format of command is cpu_clk=osc_clk,cpu_mul,
the osc_clk standby cpu clock and the cpu_mul repect the clock multiplier.

For example, generally, the command is cpu_clk=33333333,8

Signed-off-by: Chunbo Cui <cuichboo@163.com>
Signed-off-by: Binbin Zhou <zhoubb@lemote.com>
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/include/asm/mach-loongson32/platform.h |  4 ++++
 arch/mips/loongson32/common/platform.c           | 13 +++++++++++--
 arch/mips/loongson32/ls1a/board.c                | 17 +++++++++++++++++
 drivers/clk/clk-ls1x.c                           | 22 ++++++++++++++++++----
 4 files changed, 50 insertions(+), 6 deletions(-)

diff --git a/arch/mips/include/asm/mach-loongson32/platform.h b/arch/mips/include/asm/mach-loongson32/platform.h
index c48f17b..91da60d 100644
--- a/arch/mips/include/asm/mach-loongson32/platform.h
+++ b/arch/mips/include/asm/mach-loongson32/platform.h
@@ -41,4 +41,8 @@ void __init ls1x_dma_set_platdata(struct plat_ls1x_dma *pdata);
 void __init ls1x_nand_set_platdata(struct plat_ls1x_nand *pdata);
 void __init ls1x_serial_set_uartclk(struct platform_device *pdev);
 
+#ifdef CONFIG_CPU_LOONGSON1A
+extern u32 ls1a_osc_clk, ls1a_cpu_mul;
+#endif
+
 #endif /* __ASM_MACH_LOONGSON32_PLATFORM_H */
diff --git a/arch/mips/loongson32/common/platform.c b/arch/mips/loongson32/common/platform.c
index 24f35b6..0c3c608 100644
--- a/arch/mips/loongson32/common/platform.c
+++ b/arch/mips/loongson32/common/platform.c
@@ -62,9 +62,15 @@ struct platform_device ls1x_uart_pdev = {
 
 void __init ls1x_serial_set_uartclk(struct platform_device *pdev)
 {
-	struct clk *clk;
+	u32 ls1x_uartclk;
 	struct plat_serial8250_port *p;
 
+#ifdef CONIFG_CPU_LOONGSON1A
+	/* Special for ls1a, for its pll cannot be read */
+	ls1x_uartclk = ls1a_osc_clk * 2;
+#else
+	struct clk *clk;
+
 	clk = clk_get(&pdev->dev, pdev->name);
 	if (IS_ERR(clk)) {
 		pr_err("unable to get %s clock, err=%ld",
@@ -73,8 +79,11 @@ void __init ls1x_serial_set_uartclk(struct platform_device *pdev)
 	}
 	clk_prepare_enable(clk);
 
+	ls1x_uartclk = clk_get_rate(clk);
+#endif
+
 	for (p = pdev->dev.platform_data; p->flags != 0; ++p)
-		p->uartclk = clk_get_rate(clk);
+		p->uartclk = ls1x_uartclk;
 }
 
 /* CPUFreq */
diff --git a/arch/mips/loongson32/ls1a/board.c b/arch/mips/loongson32/ls1a/board.c
index 56c0dbb..ca84f23 100644
--- a/arch/mips/loongson32/ls1a/board.c
+++ b/arch/mips/loongson32/ls1a/board.c
@@ -19,6 +19,8 @@
 #include <platform.h>
 #include <loongson1.h>
 
+u32 ls1a_osc_clk = 0, ls1a_cpu_mul = 0;
+
 static struct platform_device *ls1a_platform_devices[] __initdata = {
 	&ls1x_nand_pdev,
 	&ls1x_uart_pdev,
@@ -91,10 +93,25 @@ void ls1a_route_setting(void)
 	ls1x_writel(ls1x_readl(LS1X_GMAC1_DMA_REG) | 1, LS1X_GMAC1_DMA_REG);
 }
 
+/* workaround! Get the cpu_clk form command line */
+static int __init ls1a_get_cpu_clk(char *string)
+{
+	int ret;
+
+	ret = sscanf(string, "%u,%u", &ls1a_osc_clk, &ls1a_cpu_mul);
+	if (ret != 1)
+		return -EINVAL;
+
+	return 1;
+}
+__setup("cpu_clk=", ls1a_get_cpu_clk);
+
 int __init ls1a_platform_init(void)
 {
 	ls1a_route_setting();
 
+	ls1x_serial_set_uartclk(&ls1x_uart_pdev);
+
 	i2c_register_board_info(1, &ls1a_pcf8563, 1);
 	spi_register_board_info(ls1a_spi_info, ARRAY_SIZE(ls1a_spi_info));
 
diff --git a/drivers/clk/clk-ls1x.c b/drivers/clk/clk-ls1x.c
index d4c6198..691439b 100644
--- a/drivers/clk/clk-ls1x.c
+++ b/drivers/clk/clk-ls1x.c
@@ -14,6 +14,7 @@
 #include <linux/err.h>
 
 #include <loongson1.h>
+#include <platform.h>
 
 #define OSC		(33 * 1000000)
 #define DIV_APB		2
@@ -34,10 +35,21 @@ static unsigned long ls1x_pll_recalc_rate(struct clk_hw *hw,
 {
 	u32 pll, rate;
 
+#ifdef CONFIG_CPU_LOONGSON1A
+	/*
+	 * workaround, loongson-1A's pll register can't be read,
+	 * on gateway board, multi is set to 11
+	 * */
+	if (ls1a_osc_clk != 0 && ls1a_cpu_mul != 0)
+		rate = ls1a_osc_clk * ls1a_cpu_mul;
+	else
+		rate = OSC * 8;
+#else
 	pll = __raw_readl(LS1X_CLK_PLL_FREQ);
 	rate = 12 + (pll & 0x3f) + (((pll >> 8) & 0x3ff) >> 10);
 	rate *= OSC;
 	rate >>= 1;
+#endif
 
 	return rate;
 }
@@ -107,7 +119,8 @@ void __init ls1x_clk_init(void)
 				   CLK_GET_RATE_NOCACHE, LS1X_CLK_PLL_DIV,
 				   DIV_CPU_SHIFT, DIV_CPU_WIDTH,
 				   CLK_DIVIDER_ONE_BASED |
-				   CLK_DIVIDER_ROUND_CLOSEST, &_lock);
+				   CLK_DIVIDER_ROUND_CLOSEST |
+				   CLK_DIVIDER_ALLOW_ZERO, &_lock);
 	clk_register_clkdev(clk, "cpu_clk_div", NULL);
 	clk = clk_register_mux(NULL, "cpu_clk", cpu_parents,
 			       ARRAY_SIZE(cpu_parents),
@@ -123,7 +136,8 @@ void __init ls1x_clk_init(void)
 	 */
 	clk = clk_register_divider(NULL, "dc_clk_div", "pll_clk",
 				   0, LS1X_CLK_PLL_DIV, DIV_DC_SHIFT,
-				   DIV_DC_WIDTH, CLK_DIVIDER_ONE_BASED, &_lock);
+				   DIV_DC_WIDTH, CLK_DIVIDER_ONE_BASED |
+				   CLK_DIVIDER_ALLOW_ZERO, &_lock);
 	clk_register_clkdev(clk, "dc_clk_div", NULL);
 	clk = clk_register_mux(NULL, "dc_clk", dc_parents,
 			       ARRAY_SIZE(dc_parents),
@@ -139,8 +153,8 @@ void __init ls1x_clk_init(void)
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
1.9.1
