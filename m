Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Jul 2008 14:28:02 +0100 (BST)
Received: from mo31.po.2iij.net ([210.128.50.54]:22027 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S28579239AbYGON17 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 15 Jul 2008 14:27:59 +0100
Received: by mo.po.2iij.net (mo31) id m6FDRqZE039988; Tue, 15 Jul 2008 22:27:52 +0900 (JST)
Received: from delta (16.26.30.125.dy.iij4u.or.jp [125.30.26.16])
	by mbox.po.2iij.net (po-mbox300) id m6FDRoJc015700
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 15 Jul 2008 22:27:51 +0900
Date:	Tue, 15 Jul 2008 22:27:51 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Andrew Morton <akpm@linux-foundation.org>
Cc:	yoichi_yuasa@tripeaks.co.jp,
	"Antonino A. Daplas" <adaplas@pol.net>,
	linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>,
	Ralf Baechle <ralf@linux-mips.org>,
	linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH v3] add new Cobalt LCD framebuffer driver
Message-Id: <20080715222751.86091a71.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.9; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19838
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi,

I update cobalt_lcdfb driver.

v3
- fix read/write count boundary check.
- add <include/uaccess.h>.
- fix MODULE_AUTHOR.

v2
- add dpends MIPS_COBALT in Kconfig.
- add handling of signal_pending().
- check overflow of read/write count.

v1
- first release.

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Acked-by: Ralf Baechle <ralf@linux-mips.org>

diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/drivers/video/Kconfig linux/drivers/video/Kconfig
--- linux-orig/drivers/video/Kconfig	2008-07-15 15:54:29.554677590 +0900
+++ linux/drivers/video/Kconfig	2008-07-15 10:37:54.612354756 +0900
@@ -1951,6 +1951,10 @@ config FB_AM200EPD
          This enables support for the Metronome display controller used on
          the E-Ink AM-200 EPD devkit.
 
+config FB_COBALT
+	tristate "Cobalt server LCD frame buffer support"
+	depends on FB && MIPS_COBALT
+
 config FB_VIRTUAL
 	tristate "Virtual Frame Buffer support (ONLY FOR TESTING!)"
 	depends on FB
diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/drivers/video/Makefile linux/drivers/video/Makefile
--- linux-orig/drivers/video/Makefile	2008-07-15 15:54:29.562678048 +0900
+++ linux/drivers/video/Makefile	2008-07-15 10:37:54.612354756 +0900
@@ -117,6 +117,7 @@ obj-$(CONFIG_FB_SM501)            += sm5
 obj-$(CONFIG_FB_XILINX)           += xilinxfb.o
 obj-$(CONFIG_FB_OMAP)             += omap/
 obj-$(CONFIG_XEN_FBDEV_FRONTEND)  += xen-fbfront.o
+obj-$(CONFIG_FB_COBALT)           += cobalt_lcdfb.o
 
 # Platform or fallback drivers go here
 obj-$(CONFIG_FB_UVESA)            += uvesafb.o
diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/drivers/video/cobalt_lcdfb.c linux/drivers/video/cobalt_lcdfb.c
--- linux-orig/drivers/video/cobalt_lcdfb.c	1970-01-01 09:00:00.000000000 +0900
+++ linux/drivers/video/cobalt_lcdfb.c	2008-07-15 15:48:52.035443466 +0900
@@ -0,0 +1,371 @@
+/*
+ *  Cobalt server LCD frame buffer driver.
+ *
+ *  Copyright (C) 2008  Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ */
+#include <linux/delay.h>
+#include <linux/fb.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/ioport.h>
+#include <linux/platform_device.h>
+#include <linux/uaccess.h>
+
+/*
+ * Cursor position address
+ * \X  0    1    2  ...  14   15
+ * Y+----+----+----+---+----+----+
+ * 0|0x00|0x01|0x02|...|0x0e|0x0f|
+ *  +----+----+----+---+----+----+
+ * 1|0x40|0x41|0x42|...|0x4e|0x4f|
+ *  +----+----+----+---+----+----+
+ */
+#define LCD_DATA_REG_OFFSET	0x10
+#define LCD_XRES_MAX		16
+#define LCD_YRES_MAX		2
+#define LCD_CHARS_MAX		32
+
+#define LCD_CLEAR		0x01
+#define LCD_CURSOR_MOVE_HOME	0x02
+#define LCD_RESET		0x06
+#define LCD_OFF			0x08
+#define LCD_CURSOR_OFF		0x0c
+#define LCD_CURSOR_BLINK_OFF	0x0e
+#define LCD_CURSOR_ON		0x0f
+#define LCD_ON			LCD_CURSOR_ON
+#define LCD_CURSOR_MOVE_LEFT	0x10
+#define LCD_CURSOR_MOVE_RIGHT	0x14
+#define LCD_DISPLAY_LEFT	0x18
+#define LCD_DISPLAY_RIGHT	0x1c
+#define LCD_PRERESET		0x3f	/* execute 4 times continuously */
+#define LCD_BUSY		0x80
+
+#define LCD_GRAPHIC_MODE	0x40
+#define LCD_TEXT_MODE		0x80
+#define LCD_CUR_POS_MASK	0x7f
+
+#define LCD_CUR_POS(x)		((x) & LCD_CUR_POS_MASK)
+#define LCD_TEXT_POS(x)		((x) | LCD_TEXT_MODE)
+
+static inline void lcd_write_control(struct fb_info *info, u8 control)
+{
+	writel((u32)control << 24, info->screen_base);
+}
+
+static inline u8 lcd_read_control(struct fb_info *info)
+{
+	return readl(info->screen_base) >> 24;
+}
+
+static inline void lcd_write_data(struct fb_info *info, u8 data)
+{
+	writel((u32)data << 24, info->screen_base + LCD_DATA_REG_OFFSET);
+}
+
+static inline u8 lcd_read_data(struct fb_info *info)
+{
+	return readl(info->screen_base + LCD_DATA_REG_OFFSET) >> 24;
+}
+
+static int lcd_busy_wait(struct fb_info *info)
+{
+	u8 val = 0;
+	int timeout = 10, retval = 0;
+
+	do {
+		val = lcd_read_control(info);
+		val &= LCD_BUSY;
+		if (val != LCD_BUSY)
+			break;
+
+		if (msleep_interruptible(1))
+			return -EINTR;
+
+		timeout--;
+	} while (timeout);
+
+	if (val == LCD_BUSY)
+		retval = -EBUSY;
+
+	return retval;
+}
+
+static void lcd_clear(struct fb_info *info)
+{
+	int i;
+
+	for (i = 0; i < 4; i++) {
+		udelay(150);
+
+		lcd_write_control(info, LCD_PRERESET);
+	}
+
+	udelay(150);
+
+	lcd_write_control(info, LCD_CLEAR);
+
+	udelay(150);
+
+	lcd_write_control(info, LCD_RESET);
+}
+
+static struct fb_fix_screeninfo cobalt_lcdfb_fix __initdata = {
+	.id		= "cobalt-lcd",
+	.type		= FB_TYPE_TEXT,
+	.type_aux	= FB_AUX_TEXT_MDA,
+	.visual		= FB_VISUAL_MONO01,
+	.line_length	= LCD_XRES_MAX,
+	.accel		= FB_ACCEL_NONE,
+};
+
+static ssize_t cobalt_lcdfb_read(struct fb_info *info, char __user *buf,
+				 size_t count, loff_t *ppos)
+{
+	char src[LCD_CHARS_MAX];
+	unsigned long pos;
+	int len, retval = 0;
+
+	pos = *ppos;
+	if (pos >= LCD_CHARS_MAX || count == 0)
+		return 0;
+
+	if (count > LCD_CHARS_MAX)
+		count = LCD_CHARS_MAX;
+
+	if (pos + count > LCD_CHARS_MAX)
+		count = LCD_CHARS_MAX - pos;
+
+	for (len = 0; len < count; len++) {
+		retval = lcd_busy_wait(info);
+		if (retval < 0)
+			break;
+
+		lcd_write_control(info, LCD_TEXT_POS(pos));
+
+		retval = lcd_busy_wait(info);
+		if (retval < 0)
+			break;
+
+		src[len] = lcd_read_data(info);
+		if (pos == 0x0f)
+			pos = 0x40;
+		else
+			pos++;
+	}
+
+	if (retval < 0 && signal_pending(current))
+		return -ERESTARTSYS;
+
+	if (copy_to_user(buf, src, len))
+		return -EFAULT;
+
+	*ppos += len;
+
+	return len;
+}
+
+static ssize_t cobalt_lcdfb_write(struct fb_info *info, const char __user *buf,
+				  size_t count, loff_t *ppos)
+{
+	char dst[LCD_CHARS_MAX];
+	unsigned long pos;
+	int len, retval = 0;
+
+	pos = *ppos;
+	if (pos >= LCD_CHARS_MAX || count == 0)
+		return 0;
+
+	if (count > LCD_CHARS_MAX)
+		count = LCD_CHARS_MAX;
+
+	if (pos + count > LCD_CHARS_MAX)
+		count = LCD_CHARS_MAX - pos;
+
+	if (copy_from_user(dst, buf, count))
+		return -EFAULT;
+
+	for (len = 0; len < count; len++) {
+		retval = lcd_busy_wait(info);
+		if (retval < 0)
+			break;
+
+		lcd_write_control(info, LCD_TEXT_POS(pos));
+
+		retval = lcd_busy_wait(info);
+		if (retval < 0)
+			break;
+
+		lcd_write_data(info, dst[len]);
+		if (pos == 0x0f)
+			pos = 0x40;
+		else
+			pos++;
+	}
+
+	if (retval < 0 && signal_pending(current))
+		return -ERESTARTSYS;
+
+	*ppos += len;
+
+	return len;
+}
+
+static int cobalt_lcdfb_blank(int blank_mode, struct fb_info *info)
+{
+	int retval;
+
+	retval = lcd_busy_wait(info);
+	if (retval < 0)
+		return retval;
+
+	switch (blank_mode) {
+	case FB_BLANK_UNBLANK:
+		lcd_write_control(info, LCD_ON);
+		break;
+	default:
+		lcd_write_control(info, LCD_OFF);
+		break;
+	}
+
+	return 0;
+}
+
+static int cobalt_lcdfb_cursor(struct fb_info *info, struct fb_cursor *cursor)
+{
+	u32 x, y;
+	int retval;
+
+	switch (cursor->set) {
+	case FB_CUR_SETPOS:
+		x = cursor->image.dx;
+		y = cursor->image.dy;
+		if (x >= LCD_XRES_MAX || y >= LCD_YRES_MAX)
+			return -EINVAL;
+
+		retval = lcd_busy_wait(info);
+		if (retval < 0)
+			return retval;
+
+		lcd_write_control(info,
+				  LCD_TEXT_POS(info->fix.line_length * y + x));
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	retval = lcd_busy_wait(info);
+	if (retval < 0)
+		return retval;
+
+	if (cursor->enable)
+		lcd_write_control(info, LCD_CURSOR_ON);
+	else
+		lcd_write_control(info, LCD_CURSOR_OFF);
+
+	return 0;
+}
+
+static struct fb_ops cobalt_lcd_fbops = {
+	.owner		= THIS_MODULE,
+	.fb_read	= cobalt_lcdfb_read,
+	.fb_write	= cobalt_lcdfb_write,
+	.fb_blank	= cobalt_lcdfb_blank,
+	.fb_cursor	= cobalt_lcdfb_cursor,
+};
+
+static int __init cobalt_lcdfb_probe(struct platform_device *dev)
+{
+	struct fb_info *info;
+	struct resource *res;
+	int retval;
+
+	info = framebuffer_alloc(0, &dev->dev);
+	if (!info)
+		return -ENOMEM;
+
+	res = platform_get_resource(dev, IORESOURCE_MEM, 0);
+	if (!res) {
+		framebuffer_release(info);
+		return -EBUSY;
+	}
+
+	info->screen_size = res->end - res->start + 1;
+	info->screen_base = ioremap(res->start, info->screen_size);
+	info->fbops = &cobalt_lcd_fbops;
+	info->fix = cobalt_lcdfb_fix;
+	info->fix.smem_start = res->start;
+	info->fix.smem_len = info->screen_size;
+	info->pseudo_palette = NULL;
+	info->par = NULL;
+	info->flags = FBINFO_DEFAULT;
+
+	retval = register_framebuffer(info);
+	if (retval < 0) {
+		iounmap(info->screen_base);
+		framebuffer_release(info);
+		return retval;
+	}
+
+	platform_set_drvdata(dev, info);
+
+	lcd_clear(info);
+
+	printk(KERN_INFO "fb%d: Cobalt server LCD frame buffer device\n",
+		info->node);
+
+	return 0;
+}
+
+static int __devexit cobalt_lcdfb_remove(struct platform_device *dev)
+{
+	struct fb_info *info;
+
+	info = platform_get_drvdata(dev);
+	if (info) {
+		iounmap(info->screen_base);
+		unregister_framebuffer(info);
+		framebuffer_release(info);
+	}
+
+	return 0;
+}
+
+static struct platform_driver cobalt_lcdfb_driver = {
+	.probe	= cobalt_lcdfb_probe,
+	.remove	= __devexit_p(cobalt_lcdfb_remove),
+	.driver	= {
+		.name	= "cobalt-lcd",
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int __init cobalt_lcdfb_init(void)
+{
+	return platform_driver_register(&cobalt_lcdfb_driver);
+}
+
+static void __exit cobalt_lcdfb_exit(void)
+{
+	platform_driver_unregister(&cobalt_lcdfb_driver);
+}
+
+module_init(cobalt_lcdfb_init);
+module_exit(cobalt_lcdfb_exit);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Yoichi Yuasa");
+MODULE_DESCRIPTION("Cobalt server LCD frame buffer driver");
