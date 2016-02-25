Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Feb 2016 19:30:38 +0100 (CET)
Received: from exsmtp01.microchip.com ([198.175.253.37]:6744 "EHLO
        email.microchip.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27014857AbcBYSa32sChl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Feb 2016 19:30:29 +0100
Received: from mx.microchip.com (10.10.76.4) by CHN-SV-EXCH01.mchp-main.com
 (10.10.76.37) with Microsoft SMTP Server id 14.3.181.6; Thu, 25 Feb 2016
 11:30:17 -0700
Received: by mx.microchip.com (sSMTP sendmail emulation); Thu, 25 Feb 2016
 11:31:03 -0700
From:   Joshua Henderson <joshua.henderson@microchip.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>,
        Purna Chandra Mandal <purna.mandal@microchip.com>,
        Joshua Henderson <joshua.henderson@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        <devicetree@vger.kernel.org>, <linux-watchdog@vger.kernel.org>
Subject: [PATCH v2 2/2] watchdog: pic32-dmt: Add PIC32 deadman timer driver
Date:   Thu, 25 Feb 2016 11:30:51 -0700
Message-ID: <1456425056-24483-2-git-send-email-joshua.henderson@microchip.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <Joshua.Henderson@microchip.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52270
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joshua.henderson@microchip.com
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

From: Purna Chandra Mandal <purna.mandal@microchip.com>

Adds support for the deadman timer peripheral found on PIC32 class devices.

The primary function of the deadman timer (DMT) is to reset the processor
in the event of a software malfunction. The DMT is a free-running
instruction fetch timer, which is clocked whenever an instruction fetch
occurs until a count match occurs. Instructions are not fetched when
the processor is in sleep mode.

Signed-off-by: Purna Chandra Mandal <purna.mandal@microchip.com>
Signed-off-by: Joshua Henderson <joshua.henderson@microchip.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
---
Note: Please merge this patch series through the MIPS tree.

Changes since v1:
	- Drop default y in Kconfig
	- Alphabetical include files
	- Use BIT() where appropriate
	- Replace cpu_relax() with nop() and comment why it's needed
	- Return bool on functions where appropriate
	- Add a way to break out of a tight loop
	- Remove static unused function
	- Remove redundant spinlock already covered by watchdog core
	- Remove unecessary error handling when enabling DMT
	- Drop implementation of .get_timeleft
	- Drop calculation of max_timeout
	- Cleanup dev_err() message contents
	- Fix race condition with watchdog device register
	- Unregister watchdog before disabling clock
	- Fix typo in driver name
---
 drivers/watchdog/Kconfig     |   13 +++
 drivers/watchdog/Makefile    |    1 +
 drivers/watchdog/pic32-dmt.c |  260 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 274 insertions(+)
 create mode 100644 drivers/watchdog/pic32-dmt.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 543fa81..53747e9 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1427,6 +1427,19 @@ config PIC32_WDT
 	  To compile this driver as a loadable module, choose M here.
 	  The module will be called pic32-wdt.
 
+config PIC32_DMT
+	tristate "Microchip PIC32 Deadman Timer"
+	select WATCHDOG_CORE
+	depends on MACH_PIC32
+	help
+	  Watchdog driver for PIC32 instruction fetch counting timer. This specific
+	  timer is typically be used in misson critical and safety critical
+	  applications, where any single failure of the software functionality
+	  and sequencing must be detected.
+
+	  To compile this driver as a loadable module, choose M here.
+	  The module will be called pic32-dmt.
+
 # PARISC Architecture
 
 # POWERPC Architecture
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index 244ed80..d051c9c 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -154,6 +154,7 @@ obj-$(CONFIG_RALINK_WDT) += rt2880_wdt.o
 obj-$(CONFIG_IMGPDC_WDT) += imgpdc_wdt.o
 obj-$(CONFIG_MT7621_WDT) += mt7621_wdt.o
 obj-$(CONFIG_PIC32_WDT) += pic32-wdt.o
+obj-$(CONFIG_PIC32_DMT) += pic32-dmt.o
 
 # PARISC Architecture
 
diff --git a/drivers/watchdog/pic32-dmt.c b/drivers/watchdog/pic32-dmt.c
new file mode 100644
index 0000000..91801fa
--- /dev/null
+++ b/drivers/watchdog/pic32-dmt.c
@@ -0,0 +1,260 @@
+/*
+ * PIC32 deadman timer driver
+ *
+ * Purna Chandra Mandal <purna.mandal@microchip.com>
+ * Copyright (c) 2016, Microchip Technology Inc.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/pm.h>
+#include <linux/watchdog.h>
+
+#include <asm/mach-pic32/pic32.h>
+
+/* Deadman Timer Regs */
+#define DMTCON_REG	0x00
+#define DMTPRECLR_REG	0x10
+#define DMTCLR_REG	0x20
+#define DMTSTAT_REG	0x30
+#define DMTCNT_REG	0x40
+#define DMTPSCNT_REG	0x60
+#define DMTPSINTV_REG	0x70
+
+/* Deadman Timer Regs fields */
+#define DMT_ON			BIT(15)
+#define DMT_STEP1_KEY		BIT(6)
+#define DMT_STEP2_KEY		BIT(3)
+#define DMTSTAT_WINOPN		BIT(0)
+#define DMTSTAT_EVENT		BIT(5)
+#define DMTSTAT_BAD2		BIT(6)
+#define DMTSTAT_BAD1		BIT(7)
+
+/* Reset Control Register fields for watchdog */
+#define RESETCON_DMT_TIMEOUT    BIT(5)
+
+struct pic32_dmt {
+	void __iomem	*regs;
+	struct clk	*clk;
+};
+
+static inline void dmt_enable(struct pic32_dmt *dmt)
+{
+	writel(DMT_ON, PIC32_SET(dmt->regs + DMTCON_REG));
+}
+
+static inline void dmt_disable(struct pic32_dmt *dmt)
+{
+	writel(DMT_ON, PIC32_CLR(dmt->regs + DMTCON_REG));
+	/*
+	 * Cannot touch registers in the CPU cycle following clearing the
+	 * ON bit.
+	 */
+	nop();
+}
+
+static inline int dmt_bad_status(struct pic32_dmt *dmt)
+{
+	u32 val;
+
+	val = readl(dmt->regs + DMTSTAT_REG);
+	val &= (DMTSTAT_BAD1 | DMTSTAT_BAD2 | DMTSTAT_EVENT);
+	if (val)
+		return -EAGAIN;
+
+	return 0;
+}
+
+static inline int dmt_keepalive(struct pic32_dmt *dmt)
+{
+	u32 v;
+	u32 timeout = 500;
+
+	/* set pre-clear key */
+	writel(DMT_STEP1_KEY << 8, dmt->regs + DMTPRECLR_REG);
+
+	/* wait for DMT window to open */
+	while (--timeout) {
+		v = readl(dmt->regs + DMTSTAT_REG) & DMTSTAT_WINOPN;
+		if (v == DMTSTAT_WINOPN)
+			break;
+	}
+
+	/* apply key2 */
+	writel(DMT_STEP2_KEY, dmt->regs + DMTCLR_REG);
+
+	/* check whether keys are latched correctly */
+	return dmt_bad_status(dmt);
+}
+
+static inline u32 pic32_dmt_get_timeout_secs(struct pic32_dmt *dmt)
+{
+	unsigned long rate;
+
+	rate = clk_get_rate(dmt->clk);
+	if (rate)
+		return readl(dmt->regs + DMTPSCNT_REG) / rate;
+
+	return -EINVAL;
+}
+
+static inline u32 pic32_dmt_bootstatus(struct pic32_dmt *dmt)
+{
+	u32 v;
+	void __iomem *rst_base;
+
+	rst_base = ioremap(PIC32_BASE_RESET, 0x10);
+	if (!rst_base)
+		return 0;
+
+	v = readl(rst_base);
+
+	writel(RESETCON_DMT_TIMEOUT, PIC32_CLR(rst_base));
+
+	iounmap(rst_base);
+	return v & RESETCON_DMT_TIMEOUT;
+}
+
+static int pic32_dmt_start(struct watchdog_device *wdd)
+{
+	struct pic32_dmt *dmt = watchdog_get_drvdata(wdd);
+
+	dmt_enable(dmt);
+	return dmt_keepalive(dmt);
+}
+
+static int pic32_dmt_stop(struct watchdog_device *wdd)
+{
+	struct pic32_dmt *dmt = watchdog_get_drvdata(wdd);
+
+	dmt_disable(dmt);
+
+	return 0;
+}
+
+static int pic32_dmt_ping(struct watchdog_device *wdd)
+{
+	struct pic32_dmt *dmt = watchdog_get_drvdata(wdd);
+
+	return dmt_keepalive(dmt);
+}
+
+static const struct watchdog_ops pic32_dmt_fops = {
+	.owner		= THIS_MODULE,
+	.start		= pic32_dmt_start,
+	.stop		= pic32_dmt_stop,
+	.ping		= pic32_dmt_ping,
+};
+
+static const struct watchdog_info pic32_dmt_ident = {
+	.options	= WDIOF_KEEPALIVEPING |
+			  WDIOF_MAGICCLOSE,
+	.identity	= "PIC32 Deadman Timer",
+};
+
+static struct watchdog_device pic32_dmt_wdd = {
+	.info		= &pic32_dmt_ident,
+	.ops		= &pic32_dmt_fops,
+};
+
+static int pic32_dmt_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct pic32_dmt *dmt;
+	struct resource *mem;
+	struct watchdog_device *wdd = &pic32_dmt_wdd;
+
+	dmt = devm_kzalloc(&pdev->dev, sizeof(*dmt), GFP_KERNEL);
+	if (IS_ERR(dmt))
+		return PTR_ERR(dmt);
+
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	dmt->regs = devm_ioremap_resource(&pdev->dev, mem);
+	if (IS_ERR(dmt->regs))
+		return PTR_ERR(dmt->regs);
+
+	dmt->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(dmt->clk)) {
+		dev_err(&pdev->dev, "clk not found\n");
+		return PTR_ERR(dmt->clk);
+	}
+
+	ret = clk_prepare_enable(dmt->clk);
+	if (ret)
+		return ret;
+
+	wdd->timeout = pic32_dmt_get_timeout_secs(dmt);
+	if (!wdd->timeout) {
+		dev_err(&pdev->dev,
+			"failed to read watchdog register timeout\n");
+		ret = -EINVAL;
+		goto out_disable_clk;
+	}
+
+	dev_info(&pdev->dev, "timeout %d\n", wdd->timeout);
+
+	wdd->bootstatus = pic32_dmt_bootstatus(dmt) ? WDIOF_CARDRESET : 0;
+
+	watchdog_set_nowayout(wdd, WATCHDOG_NOWAYOUT);
+	watchdog_set_drvdata(wdd, dmt);
+
+	ret = watchdog_register_device(wdd);
+	if (ret) {
+		dev_err(&pdev->dev, "watchdog register failed, err %d\n", ret);
+		goto out_disable_clk;
+	}
+
+	platform_set_drvdata(pdev, wdd);
+	return 0;
+
+out_disable_clk:
+	clk_disable_unprepare(dmt->clk);
+	return ret;
+}
+
+static int pic32_dmt_remove(struct platform_device *pdev)
+{
+	struct watchdog_device *wdd = platform_get_drvdata(pdev);
+	struct pic32_dmt *dmt = watchdog_get_drvdata(wdd);
+
+	watchdog_unregister_device(wdd);
+	clk_disable_unprepare(dmt->clk);
+
+	return 0;
+}
+
+static const struct of_device_id pic32_dmt_of_ids[] = {
+	{ .compatible = "microchip,pic32mzda-dmt",},
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, pic32_dmt_of_ids);
+
+static struct platform_driver pic32_dmt_driver = {
+	.probe		= pic32_dmt_probe,
+	.remove		= pic32_dmt_remove,
+	.driver		= {
+		.name		= "pic32-dmt",
+		.owner		= THIS_MODULE,
+		.of_match_table = of_match_ptr(pic32_dmt_of_ids),
+	}
+};
+
+module_platform_driver(pic32_dmt_driver);
+
+MODULE_AUTHOR("Purna Chandra Mandal <purna.mandal@microchip.com>");
+MODULE_DESCRIPTION("Microchip PIC32 DMT Driver");
+MODULE_LICENSE("GPL");
-- 
1.7.9.5
