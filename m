Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Jun 2008 13:53:21 +0100 (BST)
Received: from mo30.po.2iij.NET ([210.128.50.53]:28186 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20025048AbYFZMxM (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 26 Jun 2008 13:53:12 +0100
Received: by mo.po.2iij.net (mo30) id m5QCr4jZ034974; Thu, 26 Jun 2008 21:53:04 +0900 (JST)
Received: from delta (61.25.30.125.dy.iij4u.or.jp [125.30.25.61])
	by mbox.po.2iij.net (po-mbox300) id m5QCr0q7012326
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 26 Jun 2008 21:53:01 +0900
Date:	Thu, 26 Jun 2008 21:52:51 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Andrew Morton <akpm@linux-foundation.org>,
	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp,
	linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>,
	linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH v2][2/2] add new Cobalt LCD platform device register
Message-Id: <20080626215251.e2effdd2.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20080626215018.2d946781.yoichi_yuasa@tripeaks.co.jp>
References: <20080626215018.2d946781.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.9; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19642
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips


Add new Cobalt LCD platform device register.

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/arch/mips/cobalt/Makefile linux/arch/mips/cobalt/Makefile
--- linux-orig/arch/mips/cobalt/Makefile	2008-06-01 18:01:46.808253360 +0900
+++ linux/arch/mips/cobalt/Makefile	2008-06-01 22:55:40.342007921 +0900
@@ -2,7 +2,7 @@
 # Makefile for the Cobalt micro systems family specific parts of the kernel
 #
 
-obj-y := buttons.o irq.o led.o reset.o rtc.o serial.o setup.o time.o
+obj-y := buttons.o irq.o lcd.o led.o reset.o rtc.o serial.o setup.o time.o
 
 obj-$(CONFIG_PCI)		+= pci.o
 obj-$(CONFIG_EARLY_PRINTK)	+= console.o
diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/arch/mips/cobalt/lcd.c linux/arch/mips/cobalt/lcd.c
--- linux-orig/arch/mips/cobalt/lcd.c	1970-01-01 09:00:00.000000000 +0900
+++ linux/arch/mips/cobalt/lcd.c	2008-06-01 22:55:40.350008376 +0900
@@ -0,0 +1,55 @@
+/*
+ *  Registration of Cobalt LCD platform device.
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
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/ioport.h>
+#include <linux/platform_device.h>
+
+static struct resource cobalt_lcd_resource __initdata = {
+	.start	= 0x1f000000,
+	.end	= 0x1f00001f,
+	.flags	= IORESOURCE_MEM,
+};
+
+static __init int cobalt_lcd_add(void)
+{
+	struct platform_device *pdev;
+	int retval;
+
+	pdev = platform_device_alloc("cobalt-lcd", -1);
+	if (!pdev)
+		return -ENOMEM;
+
+	retval = platform_device_add_resources(pdev, &cobalt_lcd_resource, 1);
+	if (retval)
+		goto err_free_device;
+
+	retval = platform_device_add(pdev);
+	if (retval)
+		goto err_free_device;
+
+	return 0;
+
+err_free_device:
+	platform_device_put(pdev);
+
+	return retval;
+}
+device_initcall(cobalt_lcd_add);
