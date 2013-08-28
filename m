Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Aug 2013 10:43:19 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:55255 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822195Ab3H1IlxqJX4c (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 28 Aug 2013 10:41:53 +0200
Received: from arrakis.dune.hu (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 50183280766;
        Wed, 28 Aug 2013 10:41:20 +0200 (CEST)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA;
        Wed, 28 Aug 2013 10:41:20 +0200 (CEST)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH 6/6] MIPS: ath79: switch to the clkdev framework
Date:   Wed, 28 Aug 2013 10:41:47 +0200
Message-Id: <1377679307-429-7-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1377679307-429-1-git-send-email-juhosg@openwrt.org>
References: <1377679307-429-1-git-send-email-juhosg@openwrt.org>
Return-Path: <juhosg@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37700
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

The ath79 code uses static clock devices and
provides its own clk_{get,put} implementations.

Change the code to use dynamically allocated
clock devices and register the clocks within
the clkdev framework.

Additionally, remove the local clk_{get,put}
implementation. The clkdev framework has a
common implementation of those.

Also move the call of ath79_clock_init() from
plat_mem_init() to plat_time_init(). Otherwise
it would not be possible to use memory allocation
functions from ath79clock_init() becasuse the
memory subsystem is not yet initialized when
plat_mem_init() runs.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
 arch/mips/Kconfig       |    1 +
 arch/mips/ath79/clock.c |  123 ++++++++++++++++++++---------------------------
 arch/mips/ath79/setup.c |    3 +-
 3 files changed, 55 insertions(+), 72 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index fdaf628..24727a0 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -95,6 +95,7 @@ config ATH79
 	select CSRC_R4K
 	select DMA_NONCOHERENT
 	select HAVE_CLK
+	select CLKDEV_LOOKUP
 	select IRQ_CPU
 	select MIPS_MACHINE
 	select SYS_HAS_CPU_MIPS32_R2
diff --git a/arch/mips/ath79/clock.c b/arch/mips/ath79/clock.c
index 375cb77..26479f4 100644
--- a/arch/mips/ath79/clock.c
+++ b/arch/mips/ath79/clock.c
@@ -16,6 +16,7 @@
 #include <linux/init.h>
 #include <linux/err.h>
 #include <linux/clk.h>
+#include <linux/clkdev.h>
 
 #include <asm/div64.h>
 
@@ -31,12 +32,21 @@ struct clk {
 	unsigned long rate;
 };
 
-static struct clk ath79_ref_clk;
-static struct clk ath79_cpu_clk;
-static struct clk ath79_ddr_clk;
-static struct clk ath79_ahb_clk;
-static struct clk ath79_wdt_clk;
-static struct clk ath79_uart_clk;
+static void __init ath79_add_sys_clkdev(const char *id, unsigned long rate)
+{
+	struct clk *clk;
+	int err;
+
+	clk = kzalloc(sizeof(*clk), GFP_KERNEL);
+	if (!clk)
+		panic("failed to allocate %s clock structure", id);
+
+	clk->rate = rate;
+
+	err = clk_register_clkdev(clk, id, NULL);
+	if (err)
+		panic("unable to register %s clock device", id);
+}
 
 static void __init ar71xx_clocks_init(void)
 {
@@ -64,13 +74,13 @@ static void __init ar71xx_clocks_init(void)
 	div = (((pll >> AR71XX_AHB_DIV_SHIFT) & AR71XX_AHB_DIV_MASK) + 1) * 2;
 	ahb_rate = cpu_rate / div;
 
-	ath79_ref_clk.rate = ref_rate;
-	ath79_cpu_clk.rate = cpu_rate;
-	ath79_ddr_clk.rate = ddr_rate;
-	ath79_ahb_clk.rate = ahb_rate;
+	ath79_add_sys_clkdev("ref", ref_rate);
+	ath79_add_sys_clkdev("cpu", cpu_rate);
+	ath79_add_sys_clkdev("ddr", ddr_rate);
+	ath79_add_sys_clkdev("ahb", ahb_rate);
 
-	ath79_wdt_clk.rate = ath79_ahb_clk.rate;
-	ath79_uart_clk.rate = ath79_ahb_clk.rate;
+	clk_add_alias("wdt", NULL, "ahb", NULL);
+	clk_add_alias("uart", NULL, "ahb", NULL);
 }
 
 static void __init ar724x_clocks_init(void)
@@ -100,13 +110,13 @@ static void __init ar724x_clocks_init(void)
 	div = (((pll >> AR724X_AHB_DIV_SHIFT) & AR724X_AHB_DIV_MASK) + 1) * 2;
 	ahb_rate = cpu_rate / div;
 
-	ath79_ref_clk.rate = ref_rate;
-	ath79_cpu_clk.rate = cpu_rate;
-	ath79_ddr_clk.rate = ddr_rate;
-	ath79_ahb_clk.rate = ahb_rate;
+	ath79_add_sys_clkdev("ref", ref_rate);
+	ath79_add_sys_clkdev("cpu", cpu_rate);
+	ath79_add_sys_clkdev("ddr", ddr_rate);
+	ath79_add_sys_clkdev("ahb", ahb_rate);
 
-	ath79_wdt_clk.rate = ath79_ahb_clk.rate;
-	ath79_uart_clk.rate = ath79_ahb_clk.rate;
+	clk_add_alias("wdt", NULL, "ahb", NULL);
+	clk_add_alias("uart", NULL, "ahb", NULL);
 }
 
 static void __init ar913x_clocks_init(void)
@@ -133,13 +143,13 @@ static void __init ar913x_clocks_init(void)
 	div = (((pll >> AR913X_AHB_DIV_SHIFT) & AR913X_AHB_DIV_MASK) + 1) * 2;
 	ahb_rate = cpu_rate / div;
 
-	ath79_ref_clk.rate = ref_rate;
-	ath79_cpu_clk.rate = cpu_rate;
-	ath79_ddr_clk.rate = ddr_rate;
-	ath79_ahb_clk.rate = ahb_rate;
+	ath79_add_sys_clkdev("ref", ref_rate);
+	ath79_add_sys_clkdev("cpu", cpu_rate);
+	ath79_add_sys_clkdev("ddr", ddr_rate);
+	ath79_add_sys_clkdev("ahb", ahb_rate);
 
-	ath79_wdt_clk.rate = ath79_ahb_clk.rate;
-	ath79_uart_clk.rate = ath79_ahb_clk.rate;
+	clk_add_alias("wdt", NULL, "ahb", NULL);
+	clk_add_alias("uart", NULL, "ahb", NULL);
 }
 
 static void __init ar933x_clocks_init(void)
@@ -195,13 +205,13 @@ static void __init ar933x_clocks_init(void)
 		ahb_rate = freq / t;
 	}
 
-	ath79_ref_clk.rate = ref_rate;
-	ath79_cpu_clk.rate = cpu_rate;
-	ath79_ddr_clk.rate = ddr_rate;
-	ath79_ahb_clk.rate = ahb_rate;
+	ath79_add_sys_clkdev("ref", ref_rate);
+	ath79_add_sys_clkdev("cpu", cpu_rate);
+	ath79_add_sys_clkdev("ddr", ddr_rate);
+	ath79_add_sys_clkdev("ahb", ahb_rate);
 
-	ath79_wdt_clk.rate = ath79_ahb_clk.rate;
-	ath79_uart_clk.rate = ath79_ref_clk.rate;
+	clk_add_alias("wdt", NULL, "ahb", NULL);
+	clk_add_alias("uart", NULL, "ref", NULL);
 }
 
 static u32 __init ar934x_get_pll_freq(u32 ref, u32 ref_div, u32 nint, u32 nfrac,
@@ -329,13 +339,13 @@ static void __init ar934x_clocks_init(void)
 	else
 		ahb_rate = cpu_pll / (postdiv + 1);
 
-	ath79_ref_clk.rate = ref_rate;
-	ath79_cpu_clk.rate = cpu_rate;
-	ath79_ddr_clk.rate = ddr_rate;
-	ath79_ahb_clk.rate = ahb_rate;
+	ath79_add_sys_clkdev("ref", ref_rate);
+	ath79_add_sys_clkdev("cpu", cpu_rate);
+	ath79_add_sys_clkdev("ddr", ddr_rate);
+	ath79_add_sys_clkdev("ahb", ahb_rate);
 
-	ath79_wdt_clk.rate = ath79_ref_clk.rate;
-	ath79_uart_clk.rate = ath79_ref_clk.rate;
+	clk_add_alias("wdt", NULL, "ref", NULL);
+	clk_add_alias("uart", NULL, "ref", NULL);
 
 	iounmap(dpll_base);
 }
@@ -416,13 +426,13 @@ static void __init qca955x_clocks_init(void)
 	else
 		ahb_rate = cpu_pll / (postdiv + 1);
 
-	ath79_ref_clk.rate = ref_rate;
-	ath79_cpu_clk.rate = cpu_rate;
-	ath79_ddr_clk.rate = ddr_rate;
-	ath79_ahb_clk.rate = ahb_rate;
+	ath79_add_sys_clkdev("ref", ref_rate);
+	ath79_add_sys_clkdev("cpu", cpu_rate);
+	ath79_add_sys_clkdev("ddr", ddr_rate);
+	ath79_add_sys_clkdev("ahb", ahb_rate);
 
-	ath79_wdt_clk.rate = ath79_ref_clk.rate;
-	ath79_uart_clk.rate = ath79_ref_clk.rate;
+	clk_add_alias("wdt", NULL, "ref", NULL);
+	clk_add_alias("uart", NULL, "ref", NULL);
 }
 
 void __init ath79_clocks_init(void)
@@ -462,30 +472,6 @@ ath79_get_sys_clk_rate(const char *id)
 /*
  * Linux clock API
  */
-struct clk *clk_get(struct device *dev, const char *id)
-{
-	if (!strcmp(id, "ref"))
-		return &ath79_ref_clk;
-
-	if (!strcmp(id, "cpu"))
-		return &ath79_cpu_clk;
-
-	if (!strcmp(id, "ddr"))
-		return &ath79_ddr_clk;
-
-	if (!strcmp(id, "ahb"))
-		return &ath79_ahb_clk;
-
-	if (!strcmp(id, "wdt"))
-		return &ath79_wdt_clk;
-
-	if (!strcmp(id, "uart"))
-		return &ath79_uart_clk;
-
-	return ERR_PTR(-ENOENT);
-}
-EXPORT_SYMBOL(clk_get);
-
 int clk_enable(struct clk *clk)
 {
 	return 0;
@@ -502,8 +488,3 @@ unsigned long clk_get_rate(struct clk *clk)
 	return clk->rate;
 }
 EXPORT_SYMBOL(clk_get_rate);
-
-void clk_put(struct clk *clk)
-{
-}
-EXPORT_SYMBOL(clk_put);
diff --git a/arch/mips/ath79/setup.c b/arch/mips/ath79/setup.c
index c02d345..64807a4 100644
--- a/arch/mips/ath79/setup.c
+++ b/arch/mips/ath79/setup.c
@@ -200,7 +200,6 @@ void __init plat_mem_setup(void)
 
 	ath79_detect_sys_type();
 	detect_memory_region(0, ATH79_MEM_SIZE_MIN, ATH79_MEM_SIZE_MAX);
-	ath79_clocks_init();
 
 	_machine_restart = ath79_restart;
 	_machine_halt = ath79_halt;
@@ -214,6 +213,8 @@ void __init plat_time_init(void)
 	unsigned long ddr_clk_rate;
 	unsigned long ref_clk_rate;
 
+	ath79_clocks_init();
+
 	cpu_clk_rate = ath79_get_sys_clk_rate("cpu");
 	ahb_clk_rate = ath79_get_sys_clk_rate("ahb");
 	ddr_clk_rate = ath79_get_sys_clk_rate("ddr");
-- 
1.7.10
