Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Aug 2013 11:38:56 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:51104 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6816642Ab3HHJixWbbez (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 8 Aug 2013 11:38:53 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Wim Van Sebroeck <wim@iguana.be>
Cc:     John Crispin <blogic@openwrt.org>, linux-watchdog@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: [PATCH 2/2] watchdog: MIPS: add ralink watchdog driver
Date:   Thu,  8 Aug 2013 11:31:43 +0200
Message-Id: <1375954303-28830-1-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37449
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

Add a driver for the watchdog timer found on Ralink SoC

Signed-off-by: John Crispin <blogic@openwrt.org>
Cc: linux-watchdog@vger.kernel.org
Cc: linux-mips@linux-mips.org
---
 drivers/watchdog/Kconfig      |    7 ++
 drivers/watchdog/Makefile     |    1 +
 drivers/watchdog/rt2880_wdt.c |  208 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 216 insertions(+)
 create mode 100644 drivers/watchdog/rt2880_wdt.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 362085d..00b1450 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1117,6 +1117,13 @@ config LANTIQ_WDT
 	help
 	  Hardware driver for the Lantiq SoC Watchdog Timer.
 
+config RALINK_WDT
+	tristate "Ralink SoC watchdog"
+	select WATCHDOG_CORE
+	depends on RALINK
+	help
+	  Hardware driver for the Ralink SoC Watchdog Timer.
+
 # PARISC Architecture
 
 # POWERPC Architecture
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index 2f26a0b..8ce381d 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -135,6 +135,7 @@ obj-$(CONFIG_TXX9_WDT) += txx9wdt.o
 obj-$(CONFIG_OCTEON_WDT) += octeon-wdt.o
 octeon-wdt-y := octeon-wdt-main.o octeon-wdt-nmi.o
 obj-$(CONFIG_LANTIQ_WDT) += lantiq_wdt.o
+obj-$(CONFIG_RALINK_WDT) += rt2880_wdt.o
 
 # PARISC Architecture
 
diff --git a/drivers/watchdog/rt2880_wdt.c b/drivers/watchdog/rt2880_wdt.c
new file mode 100644
index 0000000..4d07964
--- /dev/null
+++ b/drivers/watchdog/rt2880_wdt.c
@@ -0,0 +1,208 @@
+/*
+ * Ralink RT288x/RT3xxx/MT76xx built-in hardware watchdog timer
+ *
+ * Copyright (C) 2011 Gabor Juhos <juhosg@openwrt.org>
+ * Copyright (C) 2013 John Crispin <blogic@openwrt.org>
+ *
+ * This driver was based on: drivers/watchdog/softdog.c
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ */
+
+#include <linux/clk.h>
+#include <linux/reset.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/watchdog.h>
+#include <linux/miscdevice.h>
+#include <linux/moduleparam.h>
+#include <linux/platform_device.h>
+
+#include <asm/mach-ralink/ralink_regs.h>
+
+#define SYSC_RSTSTAT			0x38
+#define WDT_RST_CAUSE			BIT(1)
+
+#define RALINK_WDT_TIMEOUT		30
+#define RALINK_WDT_PRESCALE		65536
+
+#define TIMER_REG_TMR1LOAD		0x00
+#define TIMER_REG_TMR1CTL		0x08
+
+#define TMRSTAT_TMR1RST			BIT(5)
+
+#define TMR1CTL_ENABLE			BIT(7)
+#define TMR1CTL_MODE_SHIFT		4
+#define TMR1CTL_MODE_MASK		0x3
+#define TMR1CTL_MODE_FREE_RUNNING	0x0
+#define TMR1CTL_MODE_PERIODIC		0x1
+#define TMR1CTL_MODE_TIMEOUT		0x2
+#define TMR1CTL_MODE_WDT		0x3
+#define TMR1CTL_PRESCALE_MASK		0xf
+#define TMR1CTL_PRESCALE_65536		0xf
+
+static struct clk *rt288x_wdt_clk;
+static unsigned long rt288x_wdt_freq;
+static void __iomem *rt288x_wdt_base;
+
+static bool nowayout = WATCHDOG_NOWAYOUT;
+module_param(nowayout, bool, 0);
+MODULE_PARM_DESC(nowayout,
+		"Watchdog cannot be stopped once started (default="
+		__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+
+static inline void rt_wdt_w32(unsigned reg, u32 val)
+{
+	iowrite32(val, rt288x_wdt_base + reg);
+}
+
+static inline u32 rt_wdt_r32(unsigned reg)
+{
+	return ioread32(rt288x_wdt_base + reg);
+}
+
+static int rt288x_wdt_ping(struct watchdog_device *w)
+{
+	rt_wdt_w32(TIMER_REG_TMR1LOAD, w->timeout * rt288x_wdt_freq);
+
+	return 0;
+}
+
+static int rt288x_wdt_start(struct watchdog_device *w)
+{
+	u32 t;
+
+	t = rt_wdt_r32(TIMER_REG_TMR1CTL);
+	t &= ~(TMR1CTL_MODE_MASK << TMR1CTL_MODE_SHIFT |
+		TMR1CTL_PRESCALE_MASK);
+	t |= (TMR1CTL_MODE_WDT << TMR1CTL_MODE_SHIFT |
+		TMR1CTL_PRESCALE_65536);
+	rt_wdt_w32(TIMER_REG_TMR1CTL, t);
+
+	rt288x_wdt_ping(w);
+
+	t = rt_wdt_r32(TIMER_REG_TMR1CTL);
+	t |= TMR1CTL_ENABLE;
+	rt_wdt_w32(TIMER_REG_TMR1CTL, t);
+
+	return 0;
+}
+
+static int rt288x_wdt_stop(struct watchdog_device *w)
+{
+	u32 t;
+
+	rt288x_wdt_ping(w);
+
+	t = rt_wdt_r32(TIMER_REG_TMR1CTL);
+	t &= ~TMR1CTL_ENABLE;
+	rt_wdt_w32(TIMER_REG_TMR1CTL, t);
+
+	return 0;
+}
+
+static int rt288x_wdt_set_timeout(struct watchdog_device *w, unsigned int t)
+{
+	w->timeout = t;
+	rt288x_wdt_ping(w);
+
+	return 0;
+}
+
+static int rt288x_wdt_bootcause(void)
+{
+	if (rt_sysc_r32(SYSC_RSTSTAT) & WDT_RST_CAUSE)
+		return WDIOF_CARDRESET;
+
+	return 0;
+}
+
+static struct watchdog_info rt288x_wdt_info = {
+	.identity = "Ralink Watchdog",
+	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
+};
+
+static struct watchdog_ops rt288x_wdt_ops = {
+	.owner = THIS_MODULE,
+	.start = rt288x_wdt_start,
+	.stop = rt288x_wdt_stop,
+	.ping = rt288x_wdt_ping,
+	.set_timeout = rt288x_wdt_set_timeout,
+};
+
+static struct watchdog_device rt288x_wdt_dev = {
+	.info = &rt288x_wdt_info,
+	.ops = &rt288x_wdt_ops,
+	.min_timeout = 1,
+};
+
+static int rt288x_wdt_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+	int ret;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	rt288x_wdt_base = devm_request_and_ioremap(&pdev->dev, res);
+	if (IS_ERR(rt288x_wdt_base))
+		return PTR_ERR(rt288x_wdt_base);
+
+	rt288x_wdt_clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(rt288x_wdt_clk))
+		return PTR_ERR(rt288x_wdt_clk);
+
+	device_reset(&pdev->dev);
+
+	rt288x_wdt_freq = clk_get_rate(rt288x_wdt_clk) / RALINK_WDT_PRESCALE;
+
+	rt288x_wdt_dev.dev = &pdev->dev;
+	rt288x_wdt_dev.bootstatus = rt288x_wdt_bootcause();
+
+	rt288x_wdt_dev.max_timeout = (0xfffful / rt288x_wdt_freq);
+	rt288x_wdt_dev.timeout = rt288x_wdt_dev.max_timeout;
+
+	watchdog_set_nowayout(&rt288x_wdt_dev, nowayout);
+
+	ret = watchdog_register_device(&rt288x_wdt_dev);
+	if (!ret)
+		dev_info(&pdev->dev, "Initialized\n");
+
+	return 0;
+}
+
+static int rt288x_wdt_remove(struct platform_device *pdev)
+{
+	watchdog_unregister_device(&rt288x_wdt_dev);
+
+	return 0;
+}
+
+static void rt288x_wdt_shutdown(struct platform_device *pdev)
+{
+	rt288x_wdt_stop(&rt288x_wdt_dev);
+}
+
+static const struct of_device_id rt288x_wdt_match[] = {
+	{ .compatible = "ralink,rt2880-wdt" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, rt288x_wdt_match);
+
+static struct platform_driver rt288x_wdt_driver = {
+	.probe		= rt288x_wdt_probe,
+	.remove		= rt288x_wdt_remove,
+	.shutdown	= rt288x_wdt_shutdown,
+	.driver		= {
+		.name		= KBUILD_MODNAME,
+		.owner		= THIS_MODULE,
+		.of_match_table	= rt288x_wdt_match,
+	},
+};
+
+module_platform_driver(rt288x_wdt_driver);
+
+MODULE_DESCRIPTION("MediaTek/Ralink RT288x/RT3xxx hardware watchdog driver");
+MODULE_AUTHOR("Gabor Juhos <juhosg@openwrt.org");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);
-- 
1.7.10.4
