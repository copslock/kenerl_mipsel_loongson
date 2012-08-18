Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 18 Aug 2012 14:01:07 +0200 (CEST)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:58490 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1902232Ab2HRMA7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 18 Aug 2012 14:00:59 +0200
Received: by dajq27 with SMTP id q27so1330227daj.36
        for <multiple recipients>; Sat, 18 Aug 2012 05:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=5Vu57TlHI9MuILw5JS8BSd6M0Zg93m7qNBl47nWgoHE=;
        b=RnEz9JDYbMM/eiw9e4/L0FMtbIVxFKN88Q/857mHKPwKIXXUgp+B9hjTHFgqadPVaO
         GECQxFE1pD+H04lE7/YXD21/f+zj57z0rroIcWPtMHhlfhmZLiS2RsNVJ4WXk4EMie0y
         P8JLg+i0wdrZ/Uz6K2Dy5W4yU3auuxs9OLBBkaGhb89fvmdMa2b9fuRpA3SmA7cGDLa9
         4JxySET++JtuBhbbCvBfgXnbs37EiVA2MWB8Ub6H6IYm3C368CeeFVtg+woH+iWnuO6R
         vVroghYsbDUx6XLLSJOn37rcUL/dSwk2Lc9g6CfWxVpul7KxaGPN5HVocq2yn2IbHwNb
         4lXA==
Received: by 10.68.226.102 with SMTP id rr6mr8535429pbc.120.1345291252141;
        Sat, 18 Aug 2012 05:00:52 -0700 (PDT)
Received: from kelvin-Work.chd.intersil.com ([182.148.112.76])
        by mx.google.com with ESMTPS id gf3sm6932951pbc.74.2012.08.18.05.00.47
        (version=SSLv3 cipher=OTHER);
        Sat, 18 Aug 2012 05:00:51 -0700 (PDT)
From:   Kelvin Cheung <keguang.zhang@gmail.com>
To:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        ralf@linux-mips.org
Cc:     Kelvin Cheung <keguang.zhang@gmail.com>
Subject: [PATCH] MIPS: Loongson1B: use common clock infrastructure instead of private APIs.
Date:   Sat, 18 Aug 2012 20:00:41 +0800
Message-Id: <1345291241-25971-1-git-send-email-keguang.zhang@gmail.com>
X-Mailer: git-send-email 1.7.1
X-archive-position: 34276
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keguang.zhang@gmail.com
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

1. Remove private clock APIs, which are replaced by the code in
   drivers/clk/clk-ls1x.c
2. Enable COMMON_CLK in the Kconfig.
3. some minor modifications.

Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>
---
 arch/mips/include/asm/mach-loongson1/platform.h |    3 +-
 arch/mips/include/asm/mach-loongson1/regs-clk.h |    7 +-
 arch/mips/loongson1/Kconfig                     |    2 +-
 arch/mips/loongson1/common/clock.c              |  159 +----------------------
 arch/mips/loongson1/common/platform.c           |    9 +-
 arch/mips/loongson1/ls1b/board.c                |    5 +-
 6 files changed, 16 insertions(+), 169 deletions(-)

diff --git a/arch/mips/include/asm/mach-loongson1/platform.h b/arch/mips/include/asm/mach-loongson1/platform.h
index 2f17161..718a122 100644
--- a/arch/mips/include/asm/mach-loongson1/platform.h
+++ b/arch/mips/include/asm/mach-loongson1/platform.h
@@ -18,6 +18,7 @@ extern struct platform_device ls1x_eth0_device;
 extern struct platform_device ls1x_ehci_device;
 extern struct platform_device ls1x_rtc_device;
 
-void ls1x_serial_setup(void);
+extern void __init ls1x_clk_init(void);
+extern void __init ls1x_serial_setup(struct platform_device *pdev);
 
 #endif /* __ASM_MACH_LOONGSON1_PLATFORM_H */
diff --git a/arch/mips/include/asm/mach-loongson1/regs-clk.h b/arch/mips/include/asm/mach-loongson1/regs-clk.h
index 8efa7fb..a81fa3d 100644
--- a/arch/mips/include/asm/mach-loongson1/regs-clk.h
+++ b/arch/mips/include/asm/mach-loongson1/regs-clk.h
@@ -20,14 +20,15 @@
 
 /* Clock PLL Divisor Register Bits */
 #define DIV_DC_EN			(0x1 << 31)
-#define DIV_DC				(0x1f << 26)
 #define DIV_CPU_EN			(0x1 << 25)
-#define DIV_CPU				(0x1f << 20)
 #define DIV_DDR_EN			(0x1 << 19)
-#define DIV_DDR				(0x1f << 14)
 
 #define DIV_DC_SHIFT			26
 #define DIV_CPU_SHIFT			20
 #define DIV_DDR_SHIFT			14
 
+#define DIV_DC_WIDTH			5
+#define DIV_CPU_WIDTH			5
+#define DIV_DDR_WIDTH			5
+
 #endif /* __ASM_MACH_LOONGSON1_REGS_CLK_H */
diff --git a/arch/mips/loongson1/Kconfig b/arch/mips/loongson1/Kconfig
index a9a14d6..fbf75f6 100644
--- a/arch/mips/loongson1/Kconfig
+++ b/arch/mips/loongson1/Kconfig
@@ -15,7 +15,7 @@ config LOONGSON1_LS1B
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 	select SYS_SUPPORTS_HIGHMEM
 	select SYS_HAS_EARLY_PRINTK
-	select HAVE_CLK
+	select COMMON_CLK
 
 endchoice
 
diff --git a/arch/mips/loongson1/common/clock.c b/arch/mips/loongson1/common/clock.c
index 1bbbbec..07133de 100644
--- a/arch/mips/loongson1/common/clock.c
+++ b/arch/mips/loongson1/common/clock.c
@@ -7,175 +7,22 @@
  * option) any later version.
  */
 
-#include <linux/module.h>
-#include <linux/list.h>
-#include <linux/mutex.h>
 #include <linux/clk.h>
 #include <linux/err.h>
-#include <asm/clock.h>
 #include <asm/time.h>
-
-#include <loongson1.h>
-
-static LIST_HEAD(clocks);
-static DEFINE_MUTEX(clocks_mutex);
-
-struct clk *clk_get(struct device *dev, const char *name)
-{
-	struct clk *c;
-	struct clk *ret = NULL;
-
-	mutex_lock(&clocks_mutex);
-	list_for_each_entry(c, &clocks, node) {
-		if (!strcmp(c->name, name)) {
-			ret = c;
-			break;
-		}
-	}
-	mutex_unlock(&clocks_mutex);
-
-	return ret;
-}
-EXPORT_SYMBOL(clk_get);
-
-int clk_enable(struct clk *clk)
-{
-	return 0;
-}
-EXPORT_SYMBOL(clk_enable);
-
-void clk_disable(struct clk *clk)
-{
-}
-EXPORT_SYMBOL(clk_disable);
-
-unsigned long clk_get_rate(struct clk *clk)
-{
-	return clk->rate;
-}
-EXPORT_SYMBOL(clk_get_rate);
-
-void clk_put(struct clk *clk)
-{
-}
-EXPORT_SYMBOL(clk_put);
-
-static void pll_clk_init(struct clk *clk)
-{
-	u32 pll;
-
-	pll = __raw_readl(LS1X_CLK_PLL_FREQ);
-	clk->rate = (12 + (pll & 0x3f)) * 33 / 2
-			+ ((pll >> 8) & 0x3ff) * 33 / 1024 / 2;
-	clk->rate *= 1000000;
-}
-
-static void cpu_clk_init(struct clk *clk)
-{
-	u32 pll, ctrl;
-
-	pll = clk_get_rate(clk->parent);
-	ctrl = __raw_readl(LS1X_CLK_PLL_DIV) & DIV_CPU;
-	clk->rate = pll / (ctrl >> DIV_CPU_SHIFT);
-}
-
-static void ddr_clk_init(struct clk *clk)
-{
-	u32 pll, ctrl;
-
-	pll = clk_get_rate(clk->parent);
-	ctrl = __raw_readl(LS1X_CLK_PLL_DIV) & DIV_DDR;
-	clk->rate = pll / (ctrl >> DIV_DDR_SHIFT);
-}
-
-static void dc_clk_init(struct clk *clk)
-{
-	u32 pll, ctrl;
-
-	pll = clk_get_rate(clk->parent);
-	ctrl = __raw_readl(LS1X_CLK_PLL_DIV) & DIV_DC;
-	clk->rate = pll / (ctrl >> DIV_DC_SHIFT);
-}
-
-static struct clk_ops pll_clk_ops = {
-	.init	= pll_clk_init,
-};
-
-static struct clk_ops cpu_clk_ops = {
-	.init	= cpu_clk_init,
-};
-
-static struct clk_ops ddr_clk_ops = {
-	.init	= ddr_clk_init,
-};
-
-static struct clk_ops dc_clk_ops = {
-	.init	= dc_clk_init,
-};
-
-static struct clk pll_clk = {
-	.name	= "pll",
-	.ops	= &pll_clk_ops,
-};
-
-static struct clk cpu_clk = {
-	.name	= "cpu",
-	.parent = &pll_clk,
-	.ops	= &cpu_clk_ops,
-};
-
-static struct clk ddr_clk = {
-	.name	= "ddr",
-	.parent = &pll_clk,
-	.ops	= &ddr_clk_ops,
-};
-
-static struct clk dc_clk = {
-	.name	= "dc",
-	.parent = &pll_clk,
-	.ops	= &dc_clk_ops,
-};
-
-int clk_register(struct clk *clk)
-{
-	mutex_lock(&clocks_mutex);
-	list_add(&clk->node, &clocks);
-	if (clk->ops->init)
-		clk->ops->init(clk);
-	mutex_unlock(&clocks_mutex);
-
-	return 0;
-}
-EXPORT_SYMBOL(clk_register);
-
-static struct clk *ls1x_clks[] = {
-	&pll_clk,
-	&cpu_clk,
-	&ddr_clk,
-	&dc_clk,
-};
-
-int __init ls1x_clock_init(void)
-{
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(ls1x_clks); i++)
-		clk_register(ls1x_clks[i]);
-
-	return 0;
-}
+#include <platform.h>
 
 void __init plat_time_init(void)
 {
 	struct clk *clk;
 
 	/* Initialize LS1X clocks */
-	ls1x_clock_init();
+	ls1x_clk_init();
 
 	/* setup mips r4k timer */
 	clk = clk_get(NULL, "cpu");
 	if (IS_ERR(clk))
-		panic("unable to get dc clock, err=%ld", PTR_ERR(clk));
+		panic("unable to get cpu clock, err=%ld", PTR_ERR(clk));
 
 	mips_hpt_frequency = clk_get_rate(clk) / 2;
 }
diff --git a/arch/mips/loongson1/common/platform.c b/arch/mips/loongson1/common/platform.c
index e92d59c..5ca38dc 100644
--- a/arch/mips/loongson1/common/platform.c
+++ b/arch/mips/loongson1/common/platform.c
@@ -42,16 +42,17 @@ struct platform_device ls1x_uart_device = {
 	},
 };
 
-void __init ls1x_serial_setup(void)
+void __init ls1x_serial_setup(struct platform_device *pdev)
 {
 	struct clk *clk;
 	struct plat_serial8250_port *p;
 
-	clk = clk_get(NULL, "dc");
+	clk = clk_get(NULL, pdev->name);
 	if (IS_ERR(clk))
-		panic("unable to get dc clock, err=%ld", PTR_ERR(clk));
+		panic("unable to get %s clock, err=%ld",
+			pdev->name, PTR_ERR(clk));
 
-	for (p = ls1x_serial8250_port; p->flags != 0; ++p)
+	for (p = pdev->dev.platform_data; p->flags != 0; ++p)
 		p->uartclk = clk_get_rate(clk);
 }
 
diff --git a/arch/mips/loongson1/ls1b/board.c b/arch/mips/loongson1/ls1b/board.c
index 295b1be..1fbd526 100644
--- a/arch/mips/loongson1/ls1b/board.c
+++ b/arch/mips/loongson1/ls1b/board.c
@@ -9,9 +9,6 @@
 
 #include <platform.h>
 
-#include <linux/serial_8250.h>
-#include <loongson1.h>
-
 static struct platform_device *ls1b_platform_devices[] __initdata = {
 	&ls1x_uart_device,
 	&ls1x_eth0_device,
@@ -23,7 +20,7 @@ static int __init ls1b_platform_init(void)
 {
 	int err;
 
-	ls1x_serial_setup();
+	ls1x_serial_setup(&ls1x_uart_device);
 
 	err = platform_add_devices(ls1b_platform_devices,
 				   ARRAY_SIZE(ls1b_platform_devices));
-- 
1.7.1
