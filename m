Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 May 2007 13:45:36 +0100 (BST)
Received: from mo30.po.2iij.NET ([210.128.50.53]:36915 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20022621AbXEKMpe (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 11 May 2007 13:45:34 +0100
Received: by mo.po.2iij.net (mo30) id l4BCiGbt040704; Fri, 11 May 2007 21:44:16 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (mbox32) id l4BCiFZf091423
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 11 May 2007 21:44:16 +0900 (JST)
Message-Id: <200705111244.l4BCiFZf091423@mbox32.po.2iij.net>
Date:	Fri, 11 May 2007 21:33:30 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips@linux-mips.org
Subject: [PATCH][MIPS][2/3] use RTC_CMOS for Cobalt
In-Reply-To: <20070511212959.6558d88e.yoichi_yuasa@tripeaks.co.jp>
References: <20070511212959.6558d88e.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15039
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has changed using new RTC_CMOS driver for Cobalt.
It's tested on Cobalt Qube2.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/cobalt/Makefile mips/arch/mips/cobalt/Makefile
--- mips-orig/arch/mips/cobalt/Makefile	2007-05-11 07:32:17.080779000 +0900
+++ mips/arch/mips/cobalt/Makefile	2007-05-11 07:45:08.628997750 +0900
@@ -2,7 +2,7 @@
 # Makefile for the Cobalt micro systems family specific parts of the kernel
 #
 
-obj-y := buttons.o irq.o reset.o serial.o setup.o
+obj-y := buttons.o irq.o reset.o rtc.o serial.o setup.o
 
 obj-$(CONFIG_PCI)		+= pci.o
 obj-$(CONFIG_EARLY_PRINTK)	+= console.o
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/cobalt/rtc.c mips/arch/mips/cobalt/rtc.c
--- mips-orig/arch/mips/cobalt/rtc.c	1970-01-01 09:00:00.000000000 +0900
+++ mips/arch/mips/cobalt/rtc.c	2007-05-11 09:59:38.689865250 +0900
@@ -0,0 +1,63 @@
+/*
+ *  Registration of Cobalt RTC platform device.
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
+static struct resource cobalt_rtc_resource[] __initdata = {
+	{
+		.start	= 0x70,
+		.end	= 0x77,
+		.flags	= IORESOURCE_IO,
+	},
+	{
+		.start	= 8,
+		.end	= 8,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static __init int cobalt_rtc_add(void)
+{
+	struct platform_device *pdev;
+	int retval;
+
+	pdev = platform_device_alloc("rtc_cmos", -1);
+	if (!pdev)
+		return -ENOMEM;
+
+	retval = platform_device_add_resources(pdev, cobalt_rtc_resource,
+	                                       ARRAY_SIZE(cobalt_rtc_resource));
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
+device_initcall(cobalt_rtc_add);
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/configs/cobalt_defconfig mips/arch/mips/configs/cobalt_defconfig
--- mips-orig/arch/mips/configs/cobalt_defconfig	2007-05-10 23:41:02.312092750 +0900
+++ mips/arch/mips/configs/cobalt_defconfig	2007-05-11 07:45:08.713003000 +0900
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.20
-# Tue Feb 20 21:47:24 2007
+# Linux kernel version: 2.6.21-rc7
+# Wed Apr 18 14:25:45 2007
 #
 CONFIG_MIPS=y
 
@@ -62,7 +62,6 @@ CONFIG_MIPS_COBALT=y
 # CONFIG_TOSHIBA_JMR3927 is not set
 # CONFIG_TOSHIBA_RBTX4927 is not set
 # CONFIG_TOSHIBA_RBTX4938 is not set
-CONFIG_EARLY_PRINTK=y
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 # CONFIG_ARCH_HAS_ILOG2_U32 is not set
 # CONFIG_ARCH_HAS_ILOG2_U64 is not set
@@ -74,12 +73,14 @@ CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
 CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ=y
 CONFIG_DMA_NONCOHERENT=y
 CONFIG_DMA_NEED_PCI_MAP_STATE=y
+CONFIG_EARLY_PRINTK=y
+CONFIG_SYS_HAS_EARLY_PRINTK=y
 CONFIG_I8259=y
 # CONFIG_CPU_BIG_ENDIAN is not set
 CONFIG_CPU_LITTLE_ENDIAN=y
 CONFIG_SYS_SUPPORTS_LITTLE_ENDIAN=y
 CONFIG_IRQ_CPU=y
-CONFIG_MIPS_GT64111=y
+CONFIG_PCI_GT64XXX_PCI0=y
 CONFIG_MIPS_L1_CACHE_SHIFT=5
 
 #
@@ -179,6 +180,7 @@ CONFIG_SYSVIPC_SYSCTL=y
 # CONFIG_IKCONFIG is not set
 CONFIG_SYSFS_DEPRECATED=y
 CONFIG_RELAY=y
+# CONFIG_BLK_DEV_INITRD is not set
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_SYSCTL=y
 CONFIG_EMBEDDED=y
@@ -477,7 +479,6 @@ CONFIG_BLK_DEV_LOOP=y
 # CONFIG_BLK_DEV_NBD is not set
 # CONFIG_BLK_DEV_SX8 is not set
 # CONFIG_BLK_DEV_RAM is not set
-# CONFIG_BLK_DEV_INITRD is not set
 CONFIG_CDROM_PKTCDVD=y
 CONFIG_CDROM_PKTCDVD_BUFFERS=8
 # CONFIG_CDROM_PKTCDVD_WCACHE is not set
@@ -518,7 +519,7 @@ CONFIG_BLK_DEV_IDEPCI=y
 # CONFIG_BLK_DEV_OPTI621 is not set
 CONFIG_BLK_DEV_IDEDMA_PCI=y
 # CONFIG_BLK_DEV_IDEDMA_FORCED is not set
-# CONFIG_IDEDMA_PCI_AUTO is not set
+# CONFIG_IDEDMA_ONLYDISK is not set
 # CONFIG_BLK_DEV_AEC62XX is not set
 # CONFIG_BLK_DEV_ALI15X3 is not set
 # CONFIG_BLK_DEV_AMD74XX is not set
@@ -546,7 +547,6 @@ CONFIG_BLK_DEV_TC86C001=y
 # CONFIG_IDE_ARM is not set
 CONFIG_BLK_DEV_IDEDMA=y
 # CONFIG_IDEDMA_IVB is not set
-# CONFIG_IDEDMA_AUTO is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
@@ -779,7 +779,8 @@ CONFIG_LEGACY_PTY_COUNT=256
 #
 # CONFIG_WATCHDOG is not set
 # CONFIG_HW_RANDOM is not set
-CONFIG_RTC=y
+# CONFIG_RTC is not set
+# CONFIG_GEN_RTC is not set
 CONFIG_COBALT_LCD=y
 # CONFIG_DTLK is not set
 # CONFIG_R3964 is not set
@@ -815,6 +816,11 @@ CONFIG_COBALT_LCD=y
 # CONFIG_HWMON_VID is not set
 
 #
+# Multifunction device drivers
+#
+# CONFIG_MFD_SM501 is not set
+
+#
 # Multimedia devices
 #
 # CONFIG_VIDEO_DEV is not set
@@ -827,7 +833,7 @@ CONFIG_COBALT_LCD=y
 #
 # Graphics support
 #
-# CONFIG_FIRMWARE_EDID is not set
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 # CONFIG_FB is not set
 
 #
@@ -835,7 +841,6 @@ CONFIG_COBALT_LCD=y
 #
 # CONFIG_VGA_CONSOLE is not set
 CONFIG_DUMMY_CONSOLE=y
-# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
 #
 # Sound
@@ -894,7 +899,29 @@ CONFIG_USB_ARCH_HAS_EHCI=y
 #
 # Real Time Clock
 #
-# CONFIG_RTC_CLASS is not set
+CONFIG_RTC_LIB=y
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_HCTOSYS=y
+CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
+# CONFIG_RTC_DEBUG is not set
+
+#
+# RTC interfaces
+#
+CONFIG_RTC_INTF_SYSFS=y
+CONFIG_RTC_INTF_PROC=y
+CONFIG_RTC_INTF_DEV=y
+# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
+
+#
+# RTC drivers
+#
+CONFIG_RTC_DRV_CMOS=y
+# CONFIG_RTC_DRV_DS1553 is not set
+# CONFIG_RTC_DRV_DS1742 is not set
+# CONFIG_RTC_DRV_M48T86 is not set
+# CONFIG_RTC_DRV_TEST is not set
+# CONFIG_RTC_DRV_V3020 is not set
 
 #
 # DMA Engine support
diff -pruN -X mips/Documentation/dontdiff mips-orig/drivers/rtc/Kconfig mips/drivers/rtc/Kconfig
--- mips-orig/drivers/rtc/Kconfig	2007-05-10 23:42:06.140081750 +0900
+++ mips/drivers/rtc/Kconfig	2007-05-11 07:45:08.713003000 +0900
@@ -245,7 +245,7 @@ comment "Platform RTC drivers"
 config RTC_DRV_CMOS
 	tristate "PC-style 'CMOS'"
 	depends on RTC_CLASS && (X86 || ALPHA || ARM26 || ARM \
-		|| M32R || ATARI || POWERPC)
+		|| M32R || ATARI || POWERPC || MIPS)
 	help
 	  Say "yes" here to get direct support for the real time clock
 	  found in every PC or ACPI-based system, and some other boards.
