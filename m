Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Aug 2016 16:25:58 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:49439 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992478AbcHZOXDQsuNn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Aug 2016 16:23:03 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 205F585F266C5;
        Fri, 26 Aug 2016 15:22:42 +0100 (IST)
Received: from localhost (10.100.200.141) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 26 Aug
 2016 15:22:44 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        <linux-kernel@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 17/19] auxdisplay: img-ascii-lcd: driver for simple ASCII LCD displays
Date:   Fri, 26 Aug 2016 15:17:49 +0100
Message-ID: <20160826141751.13121-18-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160826141751.13121-1-paul.burton@imgtec.com>
References: <20160826141751.13121-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.141]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54780
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

Add a driver for simple ASCII LCD displays found on the MIPS Boston,
Malta & SEAD3 development boards. The Boston display is an independent
memory mapped device with a simple memory mapped 8 byte register space
containing the 8 ASCII characters to display. The Malta display is
exposed as part of the Malta board registers, and provides 8 registers
each of which corresponds to one of the ASCII characters to display. The
SEAD3 display is slightly more complex, exposing an interface to an
S6A0069 LCD controller via registers provided by the boards CPLD.
However although the displays differ in their register interface, we
require similar functionality on each board so abstracting away the
differences within a single driver allows us to share a significant
amount of code & ensure consistent behaviour.

The driver displays the Linux kernel version as the default message, but
allows the message to be changed via a character device. Messages longer
then the number of characters that the display can show will scroll.

This provides different behaviour to the existing LCD display code for
the MIPS Malta or MIPS SEAD3 platforms in the following ways:

  - The default string to display is not "LINUX ON MALTA" or "LINUX ON
    SEAD3" but "Linux" followed by the version number of the kernel
    (UTS_RELEASE).

  - Since that string tends to be significantly longer it scrolls twice
    as fast, moving every 500ms rather than every 1s.

  - The LCD won't be updated until the driver is probed, so it doesn't
    provide the early "LINUX" string.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>

---

Changes in v2:
- Fix filename in MAINTAINERS

 MAINTAINERS                        |   1 +
 drivers/auxdisplay/Kconfig         |   9 +
 drivers/auxdisplay/Makefile        |   1 +
 drivers/auxdisplay/img-ascii-lcd.c | 443 +++++++++++++++++++++++++++++++++++++
 4 files changed, 454 insertions(+)
 create mode 100644 drivers/auxdisplay/img-ascii-lcd.c

diff --git a/MAINTAINERS b/MAINTAINERS
index f7a68b1..39bda4e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5957,6 +5957,7 @@ IMGTEC ASCII LCD DRIVER
 M:	Paul Burton <paul.burton@imgtec.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/auxdisplay/img-ascii-lcd.txt
+F:	drivers/auxdisplay/img-ascii-lcd.c
 
 INA209 HARDWARE MONITOR DRIVER
 M:	Guenter Roeck <linux@roeck-us.net>
diff --git a/drivers/auxdisplay/Kconfig b/drivers/auxdisplay/Kconfig
index c07e725..10e1b9e 100644
--- a/drivers/auxdisplay/Kconfig
+++ b/drivers/auxdisplay/Kconfig
@@ -119,4 +119,13 @@ config CFAG12864B_RATE
 	  If you compile this as a module, you can still override this
 	  value using the module parameters.
 
+config IMG_ASCII_LCD
+	tristate "Imagination Technologies ASCII LCD Display"
+	default y if MIPS_MALTA || MIPS_SEAD3
+	select SYSCON
+	help
+	  Enable this to support the simple ASCII LCD displays found on
+	  development boards such as the MIPS Boston, MIPS Malta & MIPS SEAD3
+	  from Imagination Technologies.
+
 endif # AUXDISPLAY
diff --git a/drivers/auxdisplay/Makefile b/drivers/auxdisplay/Makefile
index 8a8936a..3127175 100644
--- a/drivers/auxdisplay/Makefile
+++ b/drivers/auxdisplay/Makefile
@@ -4,3 +4,4 @@
 
 obj-$(CONFIG_KS0108)		+= ks0108.o
 obj-$(CONFIG_CFAG12864B)	+= cfag12864b.o cfag12864bfb.o
+obj-$(CONFIG_IMG_ASCII_LCD)	+= img-ascii-lcd.o
diff --git a/drivers/auxdisplay/img-ascii-lcd.c b/drivers/auxdisplay/img-ascii-lcd.c
new file mode 100644
index 0000000..bf43b5d
--- /dev/null
+++ b/drivers/auxdisplay/img-ascii-lcd.c
@@ -0,0 +1,443 @@
+/*
+ * Copyright (C) 2016 Imagination Technologies
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
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <linux/sysfs.h>
+
+struct img_ascii_lcd_ctx;
+
+/**
+ * struct img_ascii_lcd_config - Configuration information about an LCD model
+ * @num_chars: the number of characters the LCD can display
+ * @external_regmap: true if registers are in a system controller, else false
+ * @update: function called to update the LCD
+ */
+struct img_ascii_lcd_config {
+	unsigned int num_chars;
+	bool external_regmap;
+	void (*update)(struct img_ascii_lcd_ctx *ctx);
+};
+
+/**
+ * struct img_ascii_lcd_ctx - Private data structure
+ * @pdev: the ASCII LCD platform device
+ * @base: the base address of the LCD registers
+ * @regmap: the regmap through which LCD registers are accessed
+ * @offset: the offset within regmap to the start of the LCD registers
+ * @cfg: pointer to the LCD model configuration
+ * @message: the full message to display or scroll on the LCD
+ * @message_len: the length of the @message string
+ * @scroll_pos: index of the first character of @message currently displayed
+ * @scroll_rate: scroll interval in jiffies
+ * @timer: timer used to implement scrolling
+ * @curr: the string currently displayed on the LCD
+ */
+struct img_ascii_lcd_ctx {
+	struct platform_device *pdev;
+	union {
+		void __iomem *base;
+		struct regmap *regmap;
+	};
+	u32 offset;
+	const struct img_ascii_lcd_config *cfg;
+	char *message;
+	unsigned int message_len;
+	unsigned int scroll_pos;
+	unsigned int scroll_rate;
+	struct timer_list timer;
+	char curr[] __aligned(8);
+};
+
+/*
+ * MIPS Boston development board
+ */
+
+static void boston_update(struct img_ascii_lcd_ctx *ctx)
+{
+	ulong val;
+
+#if BITS_PER_LONG == 64
+	val = *((u64 *)&ctx->curr[0]);
+	__raw_writeq(val, ctx->base);
+#elif BITS_PER_LONG == 32
+	val = *((u32 *)&ctx->curr[0]);
+	__raw_writel(val, ctx->base);
+	val = *((u32 *)&ctx->curr[4]);
+	__raw_writel(val, ctx->base + 4);
+#else
+# error Not 32 or 64 bit
+#endif
+}
+
+static struct img_ascii_lcd_config boston_config = {
+	.num_chars = 8,
+	.update = boston_update,
+};
+
+/*
+ * MIPS Malta development board
+ */
+
+static void malta_update(struct img_ascii_lcd_ctx *ctx)
+{
+	unsigned int i;
+	int err;
+
+	for (i = 0; i < ctx->cfg->num_chars; i++) {
+		err = regmap_write(ctx->regmap,
+				   ctx->offset + (i * 8), ctx->curr[i]);
+		if (err)
+			break;
+	}
+
+	if (unlikely(err))
+		pr_err_ratelimited("Failed to update LCD display: %d\n", err);
+}
+
+static struct img_ascii_lcd_config malta_config = {
+	.num_chars = 8,
+	.external_regmap = true,
+	.update = malta_update,
+};
+
+/*
+ * MIPS SEAD3 development board
+ */
+
+enum {
+	SEAD3_REG_LCD_CTRL		= 0x00,
+#define SEAD3_REG_LCD_CTRL_SETDRAM	BIT(7)
+	SEAD3_REG_LCD_DATA		= 0x08,
+	SEAD3_REG_CPLD_STATUS		= 0x10,
+#define SEAD3_REG_CPLD_STATUS_BUSY	BIT(0)
+	SEAD3_REG_CPLD_DATA		= 0x18,
+#define SEAD3_REG_CPLD_DATA_BUSY	BIT(7)
+};
+
+static int sead3_wait_sm_idle(struct img_ascii_lcd_ctx *ctx)
+{
+	unsigned int status;
+	int err;
+
+	do {
+		err = regmap_read(ctx->regmap,
+				  ctx->offset + SEAD3_REG_CPLD_STATUS,
+				  &status);
+		if (err)
+			return err;
+	} while (status & SEAD3_REG_CPLD_STATUS_BUSY);
+
+	return 0;
+
+}
+
+static int sead3_wait_lcd_idle(struct img_ascii_lcd_ctx *ctx)
+{
+	unsigned int cpld_data;
+	int err;
+
+	err = sead3_wait_sm_idle(ctx);
+	if (err)
+		return err;
+
+	do {
+		err = regmap_read(ctx->regmap,
+				  ctx->offset + SEAD3_REG_LCD_CTRL,
+				  &cpld_data);
+		if (err)
+			return err;
+
+		err = sead3_wait_sm_idle(ctx);
+		if (err)
+			return err;
+
+		err = regmap_read(ctx->regmap,
+				  ctx->offset + SEAD3_REG_CPLD_DATA,
+				  &cpld_data);
+		if (err)
+			return err;
+	} while (cpld_data & SEAD3_REG_CPLD_DATA_BUSY);
+
+	return 0;
+}
+
+static void sead3_update(struct img_ascii_lcd_ctx *ctx)
+{
+	unsigned int i;
+	int err;
+
+	for (i = 0; i < ctx->cfg->num_chars; i++) {
+		err = sead3_wait_lcd_idle(ctx);
+		if (err)
+			break;
+
+		err = regmap_write(ctx->regmap,
+				   ctx->offset + SEAD3_REG_LCD_CTRL,
+				   SEAD3_REG_LCD_CTRL_SETDRAM | i);
+		if (err)
+			break;
+
+		err = sead3_wait_lcd_idle(ctx);
+		if (err)
+			break;
+
+		err = regmap_write(ctx->regmap,
+				   ctx->offset + SEAD3_REG_LCD_DATA,
+				   ctx->curr[i]);
+		if (err)
+			break;
+	}
+
+	if (unlikely(err))
+		pr_err_ratelimited("Failed to update LCD display: %d\n", err);
+}
+
+static struct img_ascii_lcd_config sead3_config = {
+	.num_chars = 16,
+	.external_regmap = true,
+	.update = sead3_update,
+};
+
+static const struct of_device_id img_ascii_lcd_matches[] = {
+	{ .compatible = "img,boston-lcd", .data = &boston_config },
+	{ .compatible = "mti,malta-lcd", .data = &malta_config },
+	{ .compatible = "mti,sead3-lcd", .data = &sead3_config },
+};
+
+/**
+ * img_ascii_lcd_scroll() - scroll the display by a character
+ * @arg: really a pointer to the private data structure
+ *
+ * Scroll the current message along the LCD by one character, rearming the
+ * timer if required.
+ */
+static void img_ascii_lcd_scroll(unsigned long arg)
+{
+	struct img_ascii_lcd_ctx *ctx = (struct img_ascii_lcd_ctx *)arg;
+	unsigned int i, ch = ctx->scroll_pos;
+	unsigned int num_chars = ctx->cfg->num_chars;
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
+/**
+ * img_ascii_lcd_display() - set the message to be displayed
+ * @ctx: pointer to the private data structure
+ * @msg: the message to display
+ * @count: length of msg, or -1
+ *
+ * Display a new message @msg on the LCD. @msg can be longer than the number of
+ * characters the LCD can display, in which case it will begin scrolling across
+ * the LCD display.
+ *
+ * Return: 0 on success, -ENOMEM on memory allocation failure
+ */
+static int img_ascii_lcd_display(struct img_ascii_lcd_ctx *ctx,
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
+	img_ascii_lcd_scroll((unsigned long)ctx);
+
+	return 0;
+}
+
+/**
+ * message_show() - read message via sysfs
+ * @dev: the LCD device
+ * @attr: the LCD message attribute
+ * @buf: the buffer to read the message into
+ *
+ * Read the current message being displayed or scrolled across the LCD display
+ * into @buf, for reads from sysfs.
+ *
+ * Return: the number of characters written to @buf
+ */
+static ssize_t message_show(struct device *dev, struct device_attribute *attr,
+			    char *buf)
+{
+	struct img_ascii_lcd_ctx *ctx = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%s\n", ctx->message);
+}
+
+/**
+ * message_store() - write a new message via sysfs
+ * @dev: the LCD device
+ * @attr: the LCD message attribute
+ * @buf: the buffer containing the new message
+ * @count: the size of the message in @buf
+ *
+ * Write a new message to display or scroll across the LCD display from sysfs.
+ *
+ * Return: the size of the message on success, else -ERRNO
+ */
+static ssize_t message_store(struct device *dev, struct device_attribute *attr,
+			     const char *buf, size_t count)
+{
+	struct img_ascii_lcd_ctx *ctx = dev_get_drvdata(dev);
+	int err;
+
+	err = img_ascii_lcd_display(ctx, buf, count);
+	return err ?: count;
+}
+
+static DEVICE_ATTR_RW(message);
+
+/**
+ * img_ascii_lcd_probe() - probe an LCD display device
+ * @pdev: the LCD platform device
+ *
+ * Probe an LCD display device, ensuring that we have the required resources in
+ * order to access the LCD & setting up private data as well as sysfs files.
+ *
+ * Return: 0 on success, else -ERRNO
+ */
+static int img_ascii_lcd_probe(struct platform_device *pdev)
+{
+	const struct of_device_id *match;
+	const struct img_ascii_lcd_config *cfg;
+	struct img_ascii_lcd_ctx *ctx;
+	struct resource *res;
+	int err;
+
+	match = of_match_device(img_ascii_lcd_matches, &pdev->dev);
+	if (!match)
+		return -ENODEV;
+
+	cfg = match->data;
+	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx) + cfg->num_chars,
+			   GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	if (cfg->external_regmap) {
+		ctx->regmap = syscon_node_to_regmap(pdev->dev.parent->of_node);
+		if (IS_ERR(ctx->regmap))
+			return PTR_ERR(ctx->regmap);
+
+		if (of_property_read_u32(pdev->dev.of_node, "offset",
+					 &ctx->offset))
+			return -EINVAL;
+	} else {
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+		ctx->base = devm_ioremap_resource(&pdev->dev, res);
+		if (IS_ERR(ctx->base))
+			return PTR_ERR(ctx->base);
+	}
+
+	ctx->pdev = pdev;
+	ctx->cfg = cfg;
+	ctx->message = NULL;
+	ctx->scroll_pos = 0;
+	ctx->scroll_rate = HZ / 2;
+
+	/* initialise a timer for scrolling the message */
+	init_timer(&ctx->timer);
+	ctx->timer.function = img_ascii_lcd_scroll;
+	ctx->timer.data = (unsigned long)ctx;
+
+	platform_set_drvdata(pdev, ctx);
+
+	/* display a default message */
+	err = img_ascii_lcd_display(ctx, "Linux " UTS_RELEASE "       ", -1);
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
+/**
+ * img_ascii_lcd_remove() - remove an LCD display device
+ * @pdev: the LCD platform device
+ *
+ * Remove an LCD display device, freeing private resources & ensuring that the
+ * driver stops using the LCD display registers.
+ *
+ * Return: 0
+ */
+static int img_ascii_lcd_remove(struct platform_device *pdev)
+{
+	struct img_ascii_lcd_ctx *ctx = platform_get_drvdata(pdev);
+
+	device_remove_file(&pdev->dev, &dev_attr_message);
+	del_timer_sync(&ctx->timer);
+	return 0;
+}
+
+static struct platform_driver img_ascii_lcd_driver = {
+	.driver = {
+		.name		= "img-ascii-lcd",
+		.of_match_table	= img_ascii_lcd_matches,
+	},
+	.probe	= img_ascii_lcd_probe,
+	.remove	= img_ascii_lcd_remove,
+};
+module_platform_driver(img_ascii_lcd_driver);
-- 
2.9.3
