Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Nov 2015 17:23:18 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:59821 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008025AbbK3QXEGKFkV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 30 Nov 2015 17:23:04 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 6C1E6F7F0FF33;
        Mon, 30 Nov 2015 16:22:54 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Mon, 30 Nov 2015 16:22:56 +0000
Received: from localhost (10.100.200.236) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Mon, 30 Nov
 2015 16:22:56 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>, Tejun Heo <tj@kernel.org>,
        "Miguel Ojeda Sandonis" <miguel.ojeda.sandonis@gmail.com>,
        Jiri Slaby <jslaby@suse.com>,
        Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
        <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Joe Perches" <joe@perches.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 03/28] auxdisplay: driver for simple memory mapped ASCII LCD displays
Date:   Mon, 30 Nov 2015 16:21:28 +0000
Message-ID: <1448900513-20856-4-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1448900513-20856-1-git-send-email-paul.burton@imgtec.com>
References: <1448900513-20856-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.236]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50184
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

Add a driver for simple memory mapped ASCII LCD displays such as those
found on the MIPS Malta & Boston development boards. The driver displays
the Linux kernel version as the default message, but allows the message
to be changed via a character device. Messages longer then the number of
characters that the display can show will scroll.

This provides different behaviour to the existing LCD display code for
the MIPS Malta platform in the following ways:

  - The default string to display is not "LINUX ON MALTA" but "Linux"
    followed by the version number of the kernel (UTS_RELEASE).

  - Since that string tends to significantly longer it scrolls twice
    as fast, moving every 500ms rather than every 1s.

  - The LCD won't be updated until the driver is probed, so it doesn't
    provide the early "LINUX" string.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 MAINTAINERS                    |   1 +
 drivers/auxdisplay/Kconfig     |   7 ++
 drivers/auxdisplay/Makefile    |   1 +
 drivers/auxdisplay/ascii-lcd.c | 230 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 239 insertions(+)
 create mode 100644 drivers/auxdisplay/ascii-lcd.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 1e2b74b..2e156b2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1786,6 +1786,7 @@ ASCII LCD DRIVER
 M:	Paul Burton <paul.burton@imgtec.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/ascii-lcd.txt
+F:	drivers/auxdisplay/ascii-lcd.c
 
 ASUS NOTEBOOKS AND EEEPC ACPI/WMI EXTRAS DRIVERS
 M:	Corentin Chary <corentin.chary@gmail.com>
diff --git a/drivers/auxdisplay/Kconfig b/drivers/auxdisplay/Kconfig
index c07e725..a465e0d 100644
--- a/drivers/auxdisplay/Kconfig
+++ b/drivers/auxdisplay/Kconfig
@@ -119,4 +119,11 @@ config CFAG12864B_RATE
 	  If you compile this as a module, you can still override this
 	  value using the module parameters.
 
+config ASCII_LCD
+	tristate "ASCII LCD Display"
+	default y if MIPS_MALTA
+	help
+	  Enable this to support simple memory mapped ASCII LCD displays such
+	  as those found on the MIPS Malta & Boston development boards.
+
 endif # AUXDISPLAY
diff --git a/drivers/auxdisplay/Makefile b/drivers/auxdisplay/Makefile
index 8a8936a..8a5aa81 100644
--- a/drivers/auxdisplay/Makefile
+++ b/drivers/auxdisplay/Makefile
@@ -4,3 +4,4 @@
 
 obj-$(CONFIG_KS0108)		+= ks0108.o
 obj-$(CONFIG_CFAG12864B)	+= cfag12864b.o cfag12864bfb.o
+obj-$(CONFIG_ASCII_LCD)		+= ascii-lcd.o
diff --git a/drivers/auxdisplay/ascii-lcd.c b/drivers/auxdisplay/ascii-lcd.c
new file mode 100644
index 0000000..5c9ec32
--- /dev/null
+++ b/drivers/auxdisplay/ascii-lcd.c
@@ -0,0 +1,230 @@
+/*
+ * Copyright (C) 2015 Imagination Technologies
+ * Author: Paul Burton <paul.burton@imgtec.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ */
+
+#include <generated/utsrelease.h>
+#include <linux/kernel.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/sysfs.h>
+
+struct ascii_lcd_ctx;
+
+struct ascii_lcd_config {
+	unsigned num_chars;
+	void (*update)(struct ascii_lcd_ctx *ctx);
+};
+
+struct ascii_lcd_ctx {
+	struct platform_device *pdev;
+	void __iomem *base;
+	const struct ascii_lcd_config *cfg;
+	char *message;
+	unsigned message_len;
+	unsigned scroll_pos;
+	unsigned scroll_rate;
+	struct timer_list timer;
+	char curr[] __aligned(8);
+};
+
+static void update_boston(struct ascii_lcd_ctx *ctx)
+{
+	u32 val32;
+	u64 val64;
+
+	if (config_enabled(CONFIG_64BIT)) {
+		val64 = *((u64 *)&ctx->curr[0]);
+		__raw_writeq(val64, ctx->base);
+	} else {
+		val32 = *((u32 *)&ctx->curr[0]);
+		__raw_writel(val32, ctx->base);
+		val32 = *((u32 *)&ctx->curr[4]);
+		__raw_writel(val32, ctx->base + 4);
+	}
+}
+
+static void update_malta(struct ascii_lcd_ctx *ctx)
+{
+	unsigned i;
+
+	for (i = 0; i < ctx->cfg->num_chars; i++)
+		__raw_writel(ctx->curr[i], ctx->base + (i * 8));
+}
+
+static struct ascii_lcd_config boston_config = {
+	.num_chars = 8,
+	.update = update_boston,
+};
+
+static struct ascii_lcd_config malta_config = {
+	.num_chars = 8,
+	.update = update_malta,
+};
+
+static const struct of_device_id ascii_lcd_matches[] = {
+	{ .compatible = "img,boston-lcd", .data = &boston_config },
+	{ .compatible = "mti,malta-lcd", .data = &malta_config },
+};
+
+static void ascii_lcd_scroll(unsigned long arg)
+{
+	struct ascii_lcd_ctx *ctx = (struct ascii_lcd_ctx *)arg;
+	unsigned i, ch = ctx->scroll_pos;
+	unsigned num_chars = ctx->cfg->num_chars;
+
+	/* update the current message string */
+	for (i = 0; i < num_chars;) {
+		/* copy as many characters from the string as possible */
+		for (; i < num_chars && ch < ctx->message_len; i++, ch++)
+			ctx->curr[i] = ctx->message[ch];
+
+		/* wrap around to the start of the string */
+		ch = 0;
+	}
+
+	/* update the LCD */
+	ctx->cfg->update(ctx);
+
+	/* move on to the next character */
+	ctx->scroll_pos++;
+	ctx->scroll_pos %= ctx->message_len;
+
+	/* rearm the timer */
+	if (ctx->message_len > ctx->cfg->num_chars)
+		mod_timer(&ctx->timer, jiffies + ctx->scroll_rate);
+}
+
+static int ascii_lcd_display(struct ascii_lcd_ctx *ctx,
+			     const char *msg, ssize_t count)
+{
+	char *new_msg;
+
+	/* stop the scroll timer */
+	del_timer_sync(&ctx->timer);
+
+	if (count == -1)
+		count = strlen(msg);
+
+	/* if the string ends with a newline, trim it */
+	if (msg[count - 1] == '\n')
+		count--;
+
+	new_msg = devm_kmalloc(&ctx->pdev->dev, count + 1, GFP_KERNEL);
+	if (!new_msg)
+		return -ENOMEM;
+
+	memcpy(new_msg, msg, count);
+	new_msg[count] = 0;
+
+	if (ctx->message)
+		devm_kfree(&ctx->pdev->dev, ctx->message);
+
+	ctx->message = new_msg;
+	ctx->message_len = count;
+	ctx->scroll_pos = 0;
+
+	/* update the LCD */
+	ascii_lcd_scroll((unsigned long)ctx);
+
+	return 0;
+}
+
+static ssize_t message_show(struct device *dev, struct device_attribute *attr,
+			    char *buf)
+{
+	struct ascii_lcd_ctx *ctx = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%s\n", ctx->message);
+}
+
+static ssize_t message_store(struct device *dev, struct device_attribute *attr,
+			     const char *buf, size_t count)
+{
+	struct ascii_lcd_ctx *ctx = dev_get_drvdata(dev);
+	int err;
+
+	err = ascii_lcd_display(ctx, buf, count);
+	return err ?: count;
+}
+
+static DEVICE_ATTR_RW(message);
+
+static int ascii_lcd_probe(struct platform_device *pdev)
+{
+	const struct of_device_id *match;
+	const struct ascii_lcd_config *cfg;
+	struct ascii_lcd_ctx *ctx;
+	struct resource *res;
+	int err;
+
+	match = of_match_device(ascii_lcd_matches, &pdev->dev);
+	if (!match)
+		return -ENODEV;
+
+	cfg = match->data;
+	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx) + cfg->num_chars,
+			   GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	ctx->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(ctx->base))
+		return PTR_ERR(ctx->base);
+
+	ctx->pdev = pdev;
+	ctx->cfg = cfg;
+	ctx->message = NULL;
+	ctx->scroll_pos = 0;
+	ctx->scroll_rate = HZ / 2;
+
+	/* initialise a timer for scrolling the message */
+	init_timer(&ctx->timer);
+	ctx->timer.function = ascii_lcd_scroll;
+	ctx->timer.data = (unsigned long)ctx;
+
+	platform_set_drvdata(pdev, ctx);
+
+	/* display a default message */
+	err = ascii_lcd_display(ctx, "Linux " UTS_RELEASE "       ", -1);
+	if (err)
+		goto out_del_timer;
+
+	err = device_create_file(&pdev->dev, &dev_attr_message);
+	if (err)
+		goto out_del_timer;
+
+	return 0;
+out_del_timer:
+	del_timer_sync(&ctx->timer);
+	return err;
+}
+
+static int ascii_lcd_remove(struct platform_device *pdev)
+{
+	struct ascii_lcd_ctx *ctx = platform_get_drvdata(pdev);
+
+	device_remove_file(&pdev->dev, &dev_attr_message);
+	del_timer_sync(&ctx->timer);
+	return 0;
+}
+
+static struct platform_driver ascii_lcd_driver = {
+	.driver = {
+		.name		= "ascii-lcd",
+		.of_match_table	= ascii_lcd_matches,
+	},
+	.probe	= ascii_lcd_probe,
+	.remove	= ascii_lcd_remove,
+};
+module_platform_driver(ascii_lcd_driver);
-- 
2.6.2
