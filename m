Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 May 2007 14:21:44 +0100 (BST)
Received: from mo30.po.2iij.NET ([210.128.50.53]:4429 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20022849AbXEJNVl (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 10 May 2007 14:21:41 +0100
Received: by mo.po.2iij.net (mo30) id l4ADLcU7078544; Thu, 10 May 2007 22:21:38 +0900 (JST)
Received: from localhost.localdomain (70.27.30.125.dy.iij4u.or.jp [125.30.27.70])
	by mbox.po.2iij.net (mbox33) id l4ADLaYf090244
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 10 May 2007 22:21:36 +0900 (JST)
Date:	Thu, 10 May 2007 22:21:35 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] separate platform_device registration for VR41xx GPIO
Message-Id: <20070510222135.56da1216.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15016
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has separated platform_device registration for VR41xx GPIO.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>


diff -pruN -X giu/Documentation/dontdiff giu-orig/arch/mips/vr41xx/common/Makefile giu/arch/mips/vr41xx/common/Makefile
--- giu-orig/arch/mips/vr41xx/common/Makefile	2007-05-09 10:41:46.547838750 +0900
+++ giu/arch/mips/vr41xx/common/Makefile	2007-05-09 10:42:15.205629750 +0900
@@ -2,4 +2,4 @@
 # Makefile for common code of the NEC VR4100 series.
 #
 
-obj-y	+= bcu.o cmu.o icu.o init.o irq.o pmu.o siu.o type.o
+obj-y	+= bcu.o cmu.o giu.o icu.o init.o irq.o pmu.o siu.o type.o
diff -pruN -X giu/Documentation/dontdiff giu-orig/arch/mips/vr41xx/common/giu.c giu/arch/mips/vr41xx/common/giu.c
--- giu-orig/arch/mips/vr41xx/common/giu.c	1970-01-01 09:00:00.000000000 +0900
+++ giu/arch/mips/vr41xx/common/giu.c	2007-05-09 13:12:54.451129250 +0900
@@ -0,0 +1,122 @@
+/*
+ *  NEC VR4100 series GIU platform device.
+ *
+ *  Copyright (C) 2007  Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
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
+ *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/ioport.h>
+#include <linux/platform_device.h>
+
+#include <asm/cpu.h>
+#include <asm/vr41xx/giu.h>
+#include <asm/vr41xx/irq.h>
+
+static struct resource giu_50pins_pullupdown_resource[] __initdata = {
+	{
+		.start	= 0x0b000100,
+		.end	= 0x0b00011f,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= 0x0b0002e0,
+		.end	= 0x0b0002e3,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= GIUINT_IRQ,
+		.end	= GIUINT_IRQ,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct resource giu_36pins_resource[] __initdata = {
+	{
+		.start	= 0x0f000140,
+		.end	= 0x0f00015f,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= GIUINT_IRQ,
+		.end	= GIUINT_IRQ,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct resource giu_48pins_resource[] __initdata = {
+	{
+		.start	= 0x0f000140,
+		.end	= 0x0f000167,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= GIUINT_IRQ,
+		.end	= GIUINT_IRQ,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static int __init vr41xx_giu_add(void)
+{
+	struct platform_device *pdev;
+	struct resource *res;
+	unsigned int num;
+	int retval;
+
+	pdev = platform_device_alloc("GIU", -1);
+	if (!pdev)
+		return -ENOMEM;
+
+	switch (current_cpu_data.cputype) {
+	case CPU_VR4111:
+	case CPU_VR4121:
+		pdev->id = GPIO_50PINS_PULLUPDOWN;
+		res = giu_50pins_pullupdown_resource;
+		num = ARRAY_SIZE(giu_50pins_pullupdown_resource);
+		break;
+	case CPU_VR4122:
+	case CPU_VR4131:
+		pdev->id = GPIO_36PINS;
+		res = giu_36pins_resource;
+		num = ARRAY_SIZE(giu_36pins_resource);
+		break;
+	case CPU_VR4133:
+		pdev->id = GPIO_48PINS_EDGE_SELECT;
+		res = giu_48pins_resource;
+		num = ARRAY_SIZE(giu_48pins_resource);
+		break;
+	default:
+		retval = -ENODEV;
+		goto err_free_device;
+	}
+
+	retval = platform_device_add_resources(pdev, res, num);
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
+device_initcall(vr41xx_giu_add);
diff -pruN -X giu/Documentation/dontdiff giu-orig/drivers/char/vr41xx_giu.c giu/drivers/char/vr41xx_giu.c
--- giu-orig/drivers/char/vr41xx_giu.c	2007-05-09 10:42:06.825106000 +0900
+++ giu/drivers/char/vr41xx_giu.c	2007-05-09 13:12:05.120046250 +0900
@@ -19,18 +19,17 @@
  *  along with this program; if not, write to the Free Software
  *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
-#include <linux/platform_device.h>
 #include <linux/errno.h>
 #include <linux/fs.h>
 #include <linux/init.h>
-#include <linux/irq.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/platform_device.h>
 #include <linux/spinlock.h>
 #include <linux/types.h>
 
-#include <asm/cpu.h>
 #include <asm/io.h>
 #include <asm/vr41xx/giu.h>
 #include <asm/vr41xx/irq.h>
@@ -44,18 +43,6 @@ static int major;	/* default is dynamic 
 module_param(major, int, 0);
 MODULE_PARM_DESC(major, "Major device number");
 
-#define GIU_TYPE1_START		0x0b000100UL
-#define GIU_TYPE1_SIZE		0x20UL
-
-#define GIU_TYPE2_START		0x0f000140UL
-#define GIU_TYPE2_SIZE		0x20UL
-
-#define GIU_TYPE3_START		0x0f000140UL
-#define GIU_TYPE3_SIZE		0x28UL
-
-#define GIU_PULLUPDOWN_START	0x0b0002e0UL
-#define GIU_PULLUPDOWN_SIZE	0x04UL
-
 #define GIUIOSELL	0x00
 #define GIUIOSELH	0x02
 #define GIUPIODL	0x04
@@ -89,8 +76,6 @@ MODULE_PARM_DESC(major, "Major device nu
 #define GPIO_HAS_INTERRUPT_EDGE_SELECT	0x0100
 
 static spinlock_t giu_lock;
-static struct resource *giu_resource1;
-static struct resource *giu_resource2;
 static unsigned long giu_flags;
 static unsigned int giu_nr_pins;
 
@@ -234,7 +219,7 @@ void vr41xx_set_irq_trigger(unsigned int
 				giu_set(GIUINTHTSELL, mask);
 			else
 				giu_clear(GIUINTHTSELL, mask);
-			if (current_cpu_data.cputype == CPU_VR4133) {
+			if (giu_flags & GPIO_HAS_INTERRUPT_EDGE_SELECT) {
 				switch (trigger) {
 				case IRQ_TRIGGER_EDGE_FALLING:
 					giu_set(GIUFEDGEINHL, mask);
@@ -269,7 +254,7 @@ void vr41xx_set_irq_trigger(unsigned int
 				giu_set(GIUINTHTSELH, mask);
 			else
 				giu_clear(GIUINTHTSELH, mask);
-			if (current_cpu_data.cputype == CPU_VR4133) {
+			if (giu_flags & GPIO_HAS_INTERRUPT_EDGE_SELECT) {
 				switch (trigger) {
 				case IRQ_TRIGGER_EDGE_FALLING:
 					giu_set(GIUFEDGEINHH, mask);
@@ -298,7 +283,6 @@ void vr41xx_set_irq_trigger(unsigned int
 		giu_write(GIUINTSTATH, mask);
 	}
 }
-
 EXPORT_SYMBOL_GPL(vr41xx_set_irq_trigger);
 
 void vr41xx_set_irq_level(unsigned int pin, irq_level_t level)
@@ -321,7 +305,6 @@ void vr41xx_set_irq_level(unsigned int p
 		giu_write(GIUINTSTATH, mask);
 	}
 }
-
 EXPORT_SYMBOL_GPL(vr41xx_set_irq_level);
 
 gpio_data_t vr41xx_gpio_get_pin(unsigned int pin)
@@ -350,7 +333,6 @@ gpio_data_t vr41xx_gpio_get_pin(unsigned
 
 	return GPIO_DATA_LOW;
 }
-
 EXPORT_SYMBOL_GPL(vr41xx_gpio_get_pin);
 
 int vr41xx_gpio_set_pin(unsigned int pin, gpio_data_t data)
@@ -388,7 +370,6 @@ int vr41xx_gpio_set_pin(unsigned int pin
 
 	return 0;
 }
-
 EXPORT_SYMBOL_GPL(vr41xx_gpio_set_pin);
 
 int vr41xx_gpio_set_direction(unsigned int pin, gpio_direction_t dir)
@@ -438,7 +419,6 @@ int vr41xx_gpio_set_direction(unsigned i
 
 	return 0;
 }
-
 EXPORT_SYMBOL_GPL(vr41xx_gpio_set_direction);
 
 int vr41xx_gpio_pullupdown(unsigned int pin, gpio_pull_t pull)
@@ -477,7 +457,6 @@ int vr41xx_gpio_pullupdown(unsigned int 
 
 	return 0;
 }
-
 EXPORT_SYMBOL_GPL(vr41xx_gpio_pullupdown);
 
 static ssize_t gpio_read(struct file *file, char __user *buf, size_t len,
@@ -596,61 +575,40 @@ static const struct file_operations gpio
 
 static int __devinit giu_probe(struct platform_device *dev)
 {
-	unsigned long start, size, flags = 0;
-	unsigned int nr_pins = 0, trigger, i, pin;
-	struct resource *res1, *res2 = NULL;
-	void *base;
+	struct resource *res;
+	unsigned int trigger, i, pin;
 	struct irq_chip *chip;
-	int retval;
+	int irq, retval;
 
-	switch (current_cpu_data.cputype) {
-	case CPU_VR4111:
-	case CPU_VR4121:
-		start = GIU_TYPE1_START;
-		size = GIU_TYPE1_SIZE;
-		flags = GPIO_HAS_PULLUPDOWN_IO;
-		nr_pins = 50;
+	switch (dev->id) {
+	case GPIO_50PINS_PULLUPDOWN:
+		giu_flags = GPIO_HAS_PULLUPDOWN_IO;
+		giu_nr_pins = 50;
 		break;
-	case CPU_VR4122:
-	case CPU_VR4131:
-		start = GIU_TYPE2_START;
-		size = GIU_TYPE2_SIZE;
-		nr_pins = 36;
+	case GPIO_36PINS:
+		giu_nr_pins = 36;
 		break;
-	case CPU_VR4133:
-		start = GIU_TYPE3_START;
-		size = GIU_TYPE3_SIZE;
-		flags = GPIO_HAS_INTERRUPT_EDGE_SELECT;
-		nr_pins = 48;
+	case GPIO_48PINS_EDGE_SELECT:
+		giu_flags = GPIO_HAS_INTERRUPT_EDGE_SELECT;
+		giu_nr_pins = 48;
 		break;
 	default:
+		printk(KERN_ERR "GIU: unknown ID %d\n", dev->id);
 		return -ENODEV;
 	}
 
-	res1 = request_mem_region(start, size, "GIU");
-	if (res1 == NULL)
+	res = platform_get_resource(dev, IORESOURCE_MEM, 0);
+	if (!res)
 		return -EBUSY;
 
-	base = ioremap(start, size);
-	if (base == NULL) {
-		release_resource(res1);
+	giu_base = ioremap(res->start, res->end - res->start + 1);
+	if (!giu_base)
 		return -ENOMEM;
-	}
-
-	if (flags & GPIO_HAS_PULLUPDOWN_IO) {
-		res2 = request_mem_region(GIU_PULLUPDOWN_START, GIU_PULLUPDOWN_SIZE, "GIU");
-		if (res2 == NULL) {
-			iounmap(base);
-			release_resource(res1);
-			return -EBUSY;
-		}
-	}
 
 	retval = register_chrdev(major, "GIU", &gpio_fops);
 	if (retval < 0) {
-		iounmap(base);
-		release_resource(res1);
-		release_resource(res2);
+		iounmap(giu_base);
+		giu_base = NULL;
 		return retval;
 	}
 
@@ -660,11 +618,6 @@ static int __devinit giu_probe(struct pl
 	}
 
 	spin_lock_init(&giu_lock);
-	giu_base = base;
-	giu_resource1 = res1;
-	giu_resource2 = res2;
-	giu_flags = flags;
-	giu_nr_pins = nr_pins;
 
 	giu_write(GIUINTENL, 0);
 	giu_write(GIUINTENH, 0);
@@ -685,22 +638,23 @@ static int __devinit giu_probe(struct pl
 
 	}
 
-	return cascade_irq(GIUINT_IRQ, giu_get_irq);
+	irq = platform_get_irq(dev, 0);
+	if (irq < 0 || irq >= NR_IRQS)
+		return -EBUSY;
+
+	return cascade_irq(irq, giu_get_irq);
 }
 
 static int __devexit giu_remove(struct platform_device *dev)
 {
-	iounmap(giu_base);
-
-	release_resource(giu_resource1);
-	if (giu_flags & GPIO_HAS_PULLUPDOWN_IO)
-		release_resource(giu_resource2);
+	if (giu_base) {
+		iounmap(giu_base);
+		giu_base = NULL;
+	}
 
 	return 0;
 }
 
-static struct platform_device *giu_platform_device;
-
 static struct platform_driver giu_device_driver = {
 	.probe		= giu_probe,
 	.remove		= __devexit_p(giu_remove),
@@ -712,30 +666,12 @@ static struct platform_driver giu_device
 
 static int __init vr41xx_giu_init(void)
 {
-	int retval;
-
-	giu_platform_device = platform_device_alloc("GIU", -1);
-	if (!giu_platform_device)
-		return -ENOMEM;
-
-	retval = platform_device_add(giu_platform_device);
-	if (retval < 0) {
-		platform_device_put(giu_platform_device);
-		return retval;
-	}
-
-	retval = platform_driver_register(&giu_device_driver);
-	if (retval < 0)
-		platform_device_unregister(giu_platform_device);
-
-	return retval;
+	return platform_driver_register(&giu_device_driver);
 }
 
 static void __exit vr41xx_giu_exit(void)
 {
 	platform_driver_unregister(&giu_device_driver);
-
-	platform_device_unregister(giu_platform_device);
 }
 
 module_init(vr41xx_giu_init);
diff -pruN -X giu/Documentation/dontdiff giu-orig/include/asm-mips/vr41xx/giu.h giu/include/asm-mips/vr41xx/giu.h
--- giu-orig/include/asm-mips/vr41xx/giu.h	2007-05-09 10:43:07.396891500 +0900
+++ giu/include/asm-mips/vr41xx/giu.h	2007-05-09 10:41:52.292197750 +0900
@@ -20,6 +20,15 @@
 #ifndef __NEC_VR41XX_GIU_H
 #define __NEC_VR41XX_GIU_H
 
+/*
+ * NEC VR4100 series GIU platform device IDs.
+ */
+enum {
+	GPIO_50PINS_PULLUPDOWN,
+	GPIO_36PINS,
+	GPIO_48PINS_EDGE_SELECT,
+};
+
 typedef enum {
 	IRQ_TRIGGER_LEVEL,
 	IRQ_TRIGGER_EDGE,
