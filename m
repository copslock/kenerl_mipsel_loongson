Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 May 2007 13:20:19 +0100 (BST)
Received: from mo32.po.2iij.NET ([210.128.50.17]:49419 "EHLO mo32.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20022612AbXEKMUR (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 11 May 2007 13:20:17 +0100
Received: by mo.po.2iij.net (mo32) id l4BCIofP032665; Fri, 11 May 2007 21:18:50 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (mbox32) id l4BCImYJ071813
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 11 May 2007 21:18:48 +0900 (JST)
Date:	Fri, 11 May 2007 21:18:48 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp,
	linux-mips <linux-mips@linux-mips.org>,
	rtc-linux@googlegroups.com
Subject: [PATCH][MIPS] separate platform_device registration for VR41xx RTC
Message-Id: <20070511211848.40e921dd.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15036
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has separated platform_device registration for VR41xx RTC.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X rtc/Documentation/dontdiff rtc-orig/arch/mips/vr41xx/common/Makefile rtc/arch/mips/vr41xx/common/Makefile
--- rtc-orig/arch/mips/vr41xx/common/Makefile	2007-05-11 10:13:28.557705000 +0900
+++ rtc/arch/mips/vr41xx/common/Makefile	2007-05-11 10:19:05.454759750 +0900
@@ -2,4 +2,4 @@
 # Makefile for common code of the NEC VR4100 series.
 #
 
-obj-y	+= bcu.o cmu.o giu.o icu.o init.o irq.o pmu.o siu.o type.o
+obj-y	+= bcu.o cmu.o giu.o icu.o init.o irq.o pmu.o rtc.o siu.o type.o
diff -pruN -X rtc/Documentation/dontdiff rtc-orig/arch/mips/vr41xx/common/rtc.c rtc/arch/mips/vr41xx/common/rtc.c
--- rtc-orig/arch/mips/vr41xx/common/rtc.c	1970-01-01 09:00:00.000000000 +0900
+++ rtc/arch/mips/vr41xx/common/rtc.c	2007-05-11 10:19:05.458760000 +0900
@@ -0,0 +1,117 @@
+/*
+ *  NEC VR4100 series RTC platform device.
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
+#include <asm/vr41xx/irq.h>
+
+static struct resource rtc_type1_resource[] __initdata = {
+	{
+		.start	= 0x0b0000c0,
+		.end	= 0x0b0000df,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= 0x0b0001c0,
+		.end	= 0x0b0001df,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= ELAPSEDTIME_IRQ,
+		.end	= ELAPSEDTIME_IRQ,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.start	= RTCLONG1_IRQ,
+		.end	= RTCLONG1_IRQ,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct resource rtc_type2_resource[] __initdata = {
+	{
+		.start	= 0x0f000100,
+		.end	= 0x0f00011f,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= 0x0f000120,
+		.end	= 0x0f00013f,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= ELAPSEDTIME_IRQ,
+		.end	= ELAPSEDTIME_IRQ,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.start	= RTCLONG1_IRQ,
+		.end	= RTCLONG1_IRQ,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static int __init vr41xx_rtc_add(void)
+{
+	struct platform_device *pdev;
+	struct resource *res;
+	unsigned int num;
+	int retval;
+
+	pdev = platform_device_alloc("RTC", -1);
+	if (!pdev)
+		return -ENOMEM;
+
+	switch (current_cpu_data.cputype) {
+	case CPU_VR4111:
+	case CPU_VR4121:
+		res = rtc_type1_resource;
+		num = ARRAY_SIZE(rtc_type1_resource);
+		break;
+	case CPU_VR4122:
+	case CPU_VR4131:
+	case CPU_VR4133:
+		res = rtc_type2_resource;
+		num = ARRAY_SIZE(rtc_type2_resource);
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
+device_initcall(vr41xx_rtc_add);
diff -pruN -X rtc/Documentation/dontdiff rtc-orig/drivers/rtc/rtc-vr41xx.c rtc/drivers/rtc/rtc-vr41xx.c
--- rtc-orig/drivers/rtc/rtc-vr41xx.c	2007-05-11 10:14:29.613520750 +0900
+++ rtc/drivers/rtc/rtc-vr41xx.c	2007-05-11 10:22:40.480198000 +0900
@@ -17,10 +17,11 @@
  *  along with this program; if not, write to the Free Software
  *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
+#include <linux/err.h>
 #include <linux/fs.h>
 #include <linux/init.h>
 #include <linux/ioport.h>
-#include <linux/irq.h>
+#include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/rtc.h>
@@ -30,25 +31,11 @@
 #include <asm/div64.h>
 #include <asm/io.h>
 #include <asm/uaccess.h>
-#include <asm/vr41xx/irq.h>
 
 MODULE_AUTHOR("Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>");
 MODULE_DESCRIPTION("NEC VR4100 series RTC driver");
 MODULE_LICENSE("GPL");
 
-#define RTC1_TYPE1_START	0x0b0000c0UL
-#define RTC1_TYPE1_END		0x0b0000dfUL
-#define RTC2_TYPE1_START	0x0b0001c0UL
-#define RTC2_TYPE1_END		0x0b0001dfUL
-
-#define RTC1_TYPE2_START	0x0f000100UL
-#define RTC1_TYPE2_END		0x0f00011fUL
-#define RTC2_TYPE2_START	0x0f000120UL
-#define RTC2_TYPE2_END		0x0f00013fUL
-
-#define RTC1_SIZE		0x20
-#define RTC2_SIZE		0x20
-
 /* RTC 1 registers */
 #define ETIMELREG		0x00
 #define ETIMEMREG		0x02
@@ -98,13 +85,8 @@ static char rtc_name[] = "RTC";
 static unsigned long periodic_frequency;
 static unsigned long periodic_count;
 static unsigned int alarm_enabled;
-
-struct resource rtc_resource[2] = {
-	{	.name	= rtc_name,
-		.flags	= IORESOURCE_MEM,	},
-	{	.name	= rtc_name,
-		.flags	= IORESOURCE_MEM,	},
-};
+static int aie_irq = -1;
+static int pie_irq = -1;
 
 static inline unsigned long read_elapsed_second(void)
 {
@@ -150,8 +132,8 @@ static void vr41xx_rtc_release(struct de
 
 	spin_unlock_irq(&rtc_lock);
 
-	disable_irq(ELAPSEDTIME_IRQ);
-	disable_irq(RTCLONG1_IRQ);
+	disable_irq(aie_irq);
+	disable_irq(pie_irq);
 }
 
 static int vr41xx_rtc_read_time(struct device *dev, struct rtc_time *time)
@@ -209,14 +191,14 @@ static int vr41xx_rtc_set_alarm(struct d
 	spin_lock_irq(&rtc_lock);
 
 	if (alarm_enabled)
-		disable_irq(ELAPSEDTIME_IRQ);
+		disable_irq(aie_irq);
 
 	rtc1_write(ECMPLREG, (uint16_t)(alarm_sec << 15));
 	rtc1_write(ECMPMREG, (uint16_t)(alarm_sec >> 1));
 	rtc1_write(ECMPHREG, (uint16_t)(alarm_sec >> 17));
 
 	if (wkalrm->enabled)
-		enable_irq(ELAPSEDTIME_IRQ);
+		enable_irq(aie_irq);
 
 	alarm_enabled = wkalrm->enabled;
 
@@ -234,7 +216,7 @@ static int vr41xx_rtc_ioctl(struct devic
 		spin_lock_irq(&rtc_lock);
 
 		if (!alarm_enabled) {
-			enable_irq(ELAPSEDTIME_IRQ);
+			enable_irq(aie_irq);
 			alarm_enabled = 1;
 		}
 
@@ -244,17 +226,17 @@ static int vr41xx_rtc_ioctl(struct devic
 		spin_lock_irq(&rtc_lock);
 
 		if (alarm_enabled) {
-			disable_irq(ELAPSEDTIME_IRQ);
+			disable_irq(aie_irq);
 			alarm_enabled = 0;
 		}
 
 		spin_unlock_irq(&rtc_lock);
 		break;
 	case RTC_PIE_ON:
-		enable_irq(RTCLONG1_IRQ);
+		enable_irq(pie_irq);
 		break;
 	case RTC_PIE_OFF:
-		disable_irq(RTCLONG1_IRQ);
+		disable_irq(pie_irq);
 		break;
 	case RTC_IRQP_READ:
 		return put_user(periodic_frequency, (unsigned long __user *)arg);
@@ -331,31 +313,37 @@ static const struct rtc_class_ops vr41xx
 
 static int __devinit rtc_probe(struct platform_device *pdev)
 {
+	struct resource *res;
 	struct rtc_device *rtc;
-	unsigned int irq;
 	int retval;
 
-	if (pdev->num_resources != 2)
+	if (pdev->num_resources != 4)
 		return -EBUSY;
 
-	rtc1_base = ioremap(pdev->resource[0].start, RTC1_SIZE);
-	if (rtc1_base == NULL)
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
 		return -EBUSY;
 
-	rtc2_base = ioremap(pdev->resource[1].start, RTC2_SIZE);
-	if (rtc2_base == NULL) {
-		iounmap(rtc1_base);
-		rtc1_base = NULL;
+	rtc1_base = ioremap(res->start, res->end - res->start + 1);
+	if (!rtc1_base)
 		return -EBUSY;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (!res) {
+		retval = -EBUSY;
+		goto err_rtc1_iounmap;
+	}
+
+	rtc2_base = ioremap(res->start, res->end - res->start + 1);
+	if (!rtc2_base) {
+		retval = -EBUSY;
+		goto err_rtc1_iounmap;
 	}
 
 	rtc = rtc_device_register(rtc_name, &pdev->dev, &vr41xx_rtc_ops, THIS_MODULE);
 	if (IS_ERR(rtc)) {
-		iounmap(rtc1_base);
-		iounmap(rtc2_base);
-		rtc1_base = NULL;
-		rtc2_base = NULL;
-		return PTR_ERR(rtc);
+		retval = PTR_ERR(rtc);
+		goto err_iounmap_all;
 	}
 
 	spin_lock_irq(&rtc_lock);
@@ -368,35 +356,50 @@ static int __devinit rtc_probe(struct pl
 
 	spin_unlock_irq(&rtc_lock);
 
-	irq = ELAPSEDTIME_IRQ;
-	retval = request_irq(irq, elapsedtime_interrupt, IRQF_DISABLED,
-	                     "elapsed_time", pdev);
-	if (retval == 0) {
-		irq = RTCLONG1_IRQ;
-		retval = request_irq(irq, rtclong1_interrupt, IRQF_DISABLED,
-		                     "rtclong1", pdev);
+	aie_irq = platform_get_irq(pdev, 0);
+	if (aie_irq < 0 || aie_irq >= NR_IRQS) {
+		retval = -EBUSY;
+		goto err_device_unregister;
 	}
 
-	if (retval < 0) {
-		printk(KERN_ERR "rtc: IRQ%d is busy\n", irq);
-		rtc_device_unregister(rtc);
-		if (irq == RTCLONG1_IRQ)
-			free_irq(ELAPSEDTIME_IRQ, NULL);
-		iounmap(rtc1_base);
-		iounmap(rtc2_base);
-		rtc1_base = NULL;
-		rtc2_base = NULL;
-		return retval;
-	}
+	retval = request_irq(aie_irq, elapsedtime_interrupt, IRQF_DISABLED,
+	                     "elapsed_time", pdev);
+	if (retval < 0)
+		goto err_device_unregister;
+
+	pie_irq = platform_get_irq(pdev, 1);
+	if (pie_irq < 0 || pie_irq >= NR_IRQS)
+		goto err_free_irq;
+
+	retval = request_irq(pie_irq, rtclong1_interrupt, IRQF_DISABLED,
+		             "rtclong1", pdev);
+	if (retval < 0)
+		goto err_free_irq;
 
 	platform_set_drvdata(pdev, rtc);
 
-	disable_irq(ELAPSEDTIME_IRQ);
-	disable_irq(RTCLONG1_IRQ);
+	disable_irq(aie_irq);
+	disable_irq(pie_irq);
 
 	printk(KERN_INFO "rtc: Real Time Clock of NEC VR4100 series\n");
 
 	return 0;
+
+err_free_irq:
+	free_irq(aie_irq, pdev);
+
+err_device_unregister:
+	rtc_device_unregister(rtc);
+
+err_iounmap_all:
+	iounmap(rtc2_base);
+	rtc2_base = NULL;
+
+err_rtc1_iounmap:
+	iounmap(rtc1_base);
+	rtc1_base = NULL;
+
+	return retval;
 }
 
 static int __devexit rtc_remove(struct platform_device *pdev)
@@ -404,23 +407,21 @@ static int __devexit rtc_remove(struct p
 	struct rtc_device *rtc;
 
 	rtc = platform_get_drvdata(pdev);
-	if (rtc != NULL)
+	if (rtc)
 		rtc_device_unregister(rtc);
 
 	platform_set_drvdata(pdev, NULL);
 
-	free_irq(ELAPSEDTIME_IRQ, NULL);
-	free_irq(RTCLONG1_IRQ, NULL);
-	if (rtc1_base != NULL)
+	free_irq(aie_irq, pdev);
+	free_irq(pie_irq, pdev);
+	if (rtc1_base)
 		iounmap(rtc1_base);
-	if (rtc2_base != NULL)
+	if (rtc2_base)
 		iounmap(rtc2_base);
 
 	return 0;
 }
 
-static struct platform_device *rtc_platform_device;
-
 static struct platform_driver rtc_platform_driver = {
 	.probe		= rtc_probe,
 	.remove		= __devexit_p(rtc_remove),
@@ -432,55 +433,12 @@ static struct platform_driver rtc_platfo
 
 static int __init vr41xx_rtc_init(void)
 {
-	int retval;
-
-	switch (current_cpu_data.cputype) {
-	case CPU_VR4111:
-	case CPU_VR4121:
-		rtc_resource[0].start = RTC1_TYPE1_START;
-		rtc_resource[0].end = RTC1_TYPE1_END;
-		rtc_resource[1].start = RTC2_TYPE1_START;
-		rtc_resource[1].end = RTC2_TYPE1_END;
-		break;
-	case CPU_VR4122:
-	case CPU_VR4131:
-	case CPU_VR4133:
-		rtc_resource[0].start = RTC1_TYPE2_START;
-		rtc_resource[0].end = RTC1_TYPE2_END;
-		rtc_resource[1].start = RTC2_TYPE2_START;
-		rtc_resource[1].end = RTC2_TYPE2_END;
-		break;
-	default:
-		return -ENODEV;
-		break;
-	}
-
-	rtc_platform_device = platform_device_alloc("RTC", -1);
-	if (rtc_platform_device == NULL)
-		return -ENOMEM;
-
-	retval = platform_device_add_resources(rtc_platform_device,
-				rtc_resource, ARRAY_SIZE(rtc_resource));
-
-	if (retval == 0)
-		retval = platform_device_add(rtc_platform_device);
-
-	if (retval < 0) {
-		platform_device_put(rtc_platform_device);
-		return retval;
-	}
-
-	retval = platform_driver_register(&rtc_platform_driver);
-	if (retval < 0)
-		platform_device_unregister(rtc_platform_device);
-
-	return retval;
+	return platform_driver_register(&rtc_platform_driver);
 }
 
 static void __exit vr41xx_rtc_exit(void)
 {
 	platform_driver_unregister(&rtc_platform_driver);
-	platform_device_unregister(rtc_platform_device);
 }
 
 module_init(vr41xx_rtc_init);
