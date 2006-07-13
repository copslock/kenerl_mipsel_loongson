Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Jul 2006 09:33:21 +0100 (BST)
Received: from mo31.po.2iij.net ([210.128.50.54]:22582 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S8133565AbWGMIdJ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 13 Jul 2006 09:33:09 +0100
Received: by mo.po.2iij.net (mo31) id k6D8X4GO077110; Thu, 13 Jul 2006 17:33:04 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (mbox32) id k6D8X3Ag039372
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 13 Jul 2006 17:33:04 +0900 (JST)
Date:	Thu, 13 Jul 2006 17:33:03 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH] vr41xx: moved the IRQ numbers to asm-mips/vr41xx/irq.h
Message-Id: <20060713173303.23f34127.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11978
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has moved the IRQ numbers to asm-mips/vr41xx/irq.h
Please apply.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/pci/fixup-mpc30x.c mips/arch/mips/pci/fixup-mpc30x.c
--- mips-orig/arch/mips/pci/fixup-mpc30x.c	2006-07-12 12:13:07.238092750 +0900
+++ mips/arch/mips/pci/fixup-mpc30x.c	2006-07-12 13:12:01.510971000 +0900
@@ -21,7 +21,6 @@
 #include <linux/pci.h>
 
 #include <asm/vr41xx/mpc30x.h>
-#include <asm/vr41xx/vrc4173.h>
 
 static const int internal_func_irqs[] __initdata = {
 	VRC4173_CASCADE_IRQ,
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/vr41xx/common/icu.c mips/arch/mips/vr41xx/common/icu.c
--- mips-orig/arch/mips/vr41xx/common/icu.c	2006-07-12 12:13:07.318097750 +0900
+++ mips/arch/mips/vr41xx/common/icu.c	2006-07-12 13:00:49.252957500 +0900
@@ -38,6 +38,7 @@
 
 #include <asm/cpu.h>
 #include <asm/io.h>
+#include <asm/vr41xx/irq.h>
 #include <asm/vr41xx/vr41xx.h>
 
 static void __iomem *icu1_base;
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/vr41xx/common/init.c mips/arch/mips/vr41xx/common/init.c
--- mips-orig/arch/mips/vr41xx/common/init.c	2006-07-12 12:13:07.318097750 +0900
+++ mips/arch/mips/vr41xx/common/init.c	2006-07-12 13:01:04.617917750 +0900
@@ -24,6 +24,7 @@
 
 #include <asm/bootinfo.h>
 #include <asm/time.h>
+#include <asm/vr41xx/irq.h>
 #include <asm/vr41xx/vr41xx.h>
 
 #define IO_MEM_RESOURCE_START	0UL
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/vr41xx/common/irq.c mips/arch/mips/vr41xx/common/irq.c
--- mips-orig/arch/mips/vr41xx/common/irq.c	2006-07-12 12:13:07.318097750 +0900
+++ mips/arch/mips/vr41xx/common/irq.c	2006-07-12 13:01:44.724424250 +0900
@@ -22,7 +22,7 @@
 
 #include <asm/irq_cpu.h>
 #include <asm/system.h>
-#include <asm/vr41xx/vr41xx.h>
+#include <asm/vr41xx/irq.h>
 
 typedef struct irq_cascade {
 	int (*get_irq)(unsigned int, struct pt_regs *);
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/vr41xx/common/vrc4173.c mips/arch/mips/vr41xx/common/vrc4173.c
--- mips-orig/arch/mips/vr41xx/common/vrc4173.c	2006-07-12 12:13:07.318097750 +0900
+++ mips/arch/mips/vr41xx/common/vrc4173.c	2006-07-12 13:17:44.408400750 +0900
@@ -28,6 +28,7 @@
 #include <linux/spinlock.h>
 #include <linux/types.h>
 
+#include <asm/vr41xx/irq.h>
 #include <asm/vr41xx/vr41xx.h>
 #include <asm/vr41xx/vrc4173.h>
 
diff -pruN -X mips/Documentation/dontdiff mips-orig/drivers/char/vr41xx_giu.c mips/drivers/char/vr41xx_giu.c
--- mips-orig/drivers/char/vr41xx_giu.c	2006-07-12 12:13:08.998202750 +0900
+++ mips/drivers/char/vr41xx_giu.c	2006-07-12 13:04:59.980627000 +0900
@@ -33,6 +33,7 @@
 #include <asm/cpu.h>
 #include <asm/io.h>
 #include <asm/vr41xx/giu.h>
+#include <asm/vr41xx/irq.h>
 #include <asm/vr41xx/vr41xx.h>
 
 MODULE_AUTHOR("Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>");
diff -pruN -X mips/Documentation/dontdiff mips-orig/drivers/rtc/rtc-vr41xx.c mips/drivers/rtc/rtc-vr41xx.c
--- mips-orig/drivers/rtc/rtc-vr41xx.c	2006-07-12 12:13:10.158275250 +0900
+++ mips/drivers/rtc/rtc-vr41xx.c	2006-07-12 13:05:30.870557500 +0900
@@ -30,7 +30,7 @@
 #include <asm/div64.h>
 #include <asm/io.h>
 #include <asm/uaccess.h>
-#include <asm/vr41xx/vr41xx.h>
+#include <asm/vr41xx/irq.h>
 
 MODULE_AUTHOR("Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>");
 MODULE_DESCRIPTION("NEC VR4100 series RTC driver");
diff -pruN -X mips/Documentation/dontdiff mips-orig/drivers/serial/vr41xx_siu.c mips/drivers/serial/vr41xx_siu.c
--- mips-orig/drivers/serial/vr41xx_siu.c	2006-07-12 12:13:10.534298750 +0900
+++ mips/drivers/serial/vr41xx_siu.c	2006-07-12 13:07:48.327148000 +0900
@@ -38,6 +38,7 @@
 #include <linux/tty_flip.h>
 
 #include <asm/io.h>
+#include <asm/vr41xx/irq.h>
 #include <asm/vr41xx/siu.h>
 #include <asm/vr41xx/vr41xx.h>
 
diff -pruN -X mips/Documentation/dontdiff mips-orig/include/asm-mips/vr41xx/capcella.h mips/include/asm-mips/vr41xx/capcella.h
--- mips-orig/include/asm-mips/vr41xx/capcella.h	2006-07-12 12:13:12.654431250 +0900
+++ mips/include/asm-mips/vr41xx/capcella.h	2006-07-12 13:02:54.692797000 +0900
@@ -20,7 +20,7 @@
 #ifndef __ZAO_CAPCELLA_H
 #define __ZAO_CAPCELLA_H
 
-#include <asm/vr41xx/vr41xx.h>
+#include <asm/vr41xx/irq.h>
 
 /*
  * General-Purpose I/O Pin Number
diff -pruN -X mips/Documentation/dontdiff mips-orig/include/asm-mips/vr41xx/cmbvr4133.h mips/include/asm-mips/vr41xx/cmbvr4133.h
--- mips-orig/include/asm-mips/vr41xx/cmbvr4133.h	2006-07-12 12:13:12.654431250 +0900
+++ mips/include/asm-mips/vr41xx/cmbvr4133.h	2006-07-12 13:10:11.764112250 +0900
@@ -15,8 +15,7 @@
 #ifndef __NEC_CMBVR4133_H
 #define __NEC_CMBVR4133_H
 
-#include <asm/addrspace.h>
-#include <asm/vr41xx/vr41xx.h>
+#include <asm/vr41xx/irq.h>
 
 /*
  * General-Purpose I/O Pin Number
diff -pruN -X mips/Documentation/dontdiff mips-orig/include/asm-mips/vr41xx/irq.h mips/include/asm-mips/vr41xx/irq.h
--- mips-orig/include/asm-mips/vr41xx/irq.h	1970-01-01 09:00:00.000000000 +0900
+++ mips/include/asm-mips/vr41xx/irq.h	2006-07-12 13:22:25.161946750 +0900
@@ -0,0 +1,101 @@
+/*
+ * include/asm-mips/vr41xx/irq.h
+ *
+ * Interrupt numbers for NEC VR4100 series.
+ *
+ * Copyright (C) 1999 Michael Klar
+ * Copyright (C) 2001, 2002 Paul Mundt
+ * Copyright (C) 2002 MontaVista Software, Inc.
+ * Copyright (C) 2002 TimeSys Corp.
+ * Copyright (C) 2003-2006 Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ */
+#ifndef __NEC_VR41XX_IRQ_H
+#define __NEC_VR41XX_IRQ_H
+
+/*
+ * CPU core Interrupt Numbers
+ */
+#define MIPS_CPU_IRQ_BASE	0
+#define MIPS_CPU_IRQ(x)		(MIPS_CPU_IRQ_BASE + (x))
+#define MIPS_SOFTINT0_IRQ	MIPS_CPU_IRQ(0)
+#define MIPS_SOFTINT1_IRQ	MIPS_CPU_IRQ(1)
+#define INT0_IRQ		MIPS_CPU_IRQ(2)
+#define INT1_IRQ		MIPS_CPU_IRQ(3)
+#define INT2_IRQ		MIPS_CPU_IRQ(4)
+#define INT3_IRQ		MIPS_CPU_IRQ(5)
+#define INT4_IRQ		MIPS_CPU_IRQ(6)
+#define TIMER_IRQ		MIPS_CPU_IRQ(7)
+
+/*
+ * SYINT1 Interrupt Numbers
+ */
+#define SYSINT1_IRQ_BASE	8
+#define SYSINT1_IRQ(x)		(SYSINT1_IRQ_BASE + (x))
+#define BATTRY_IRQ		SYSINT1_IRQ(0)
+#define POWER_IRQ		SYSINT1_IRQ(1)
+#define RTCLONG1_IRQ		SYSINT1_IRQ(2)
+#define ELAPSEDTIME_IRQ		SYSINT1_IRQ(3)
+/* RFU */
+#define PIU_IRQ			SYSINT1_IRQ(5)
+#define AIU_IRQ			SYSINT1_IRQ(6)
+#define KIU_IRQ			SYSINT1_IRQ(7)
+#define GIUINT_IRQ		SYSINT1_IRQ(8)
+#define SIU_IRQ			SYSINT1_IRQ(9)
+#define BUSERR_IRQ		SYSINT1_IRQ(10)
+#define SOFTINT_IRQ		SYSINT1_IRQ(11)
+#define CLKRUN_IRQ		SYSINT1_IRQ(12)
+#define DOZEPIU_IRQ		SYSINT1_IRQ(13)
+#define SYSINT1_IRQ_LAST	DOZEPIU_IRQ
+
+/*
+ * SYSINT2 Interrupt Numbers
+ */
+#define SYSINT2_IRQ_BASE	24
+#define SYSINT2_IRQ(x)		(SYSINT2_IRQ_BASE + (x))
+#define RTCLONG2_IRQ		SYSINT2_IRQ(0)
+#define LED_IRQ			SYSINT2_IRQ(1)
+#define HSP_IRQ			SYSINT2_IRQ(2)
+#define TCLOCK_IRQ		SYSINT2_IRQ(3)
+#define FIR_IRQ			SYSINT2_IRQ(4)
+#define CEU_IRQ			SYSINT2_IRQ(4)	/* same number as FIR_IRQ */
+#define DSIU_IRQ		SYSINT2_IRQ(5)
+#define PCI_IRQ			SYSINT2_IRQ(6)
+#define SCU_IRQ			SYSINT2_IRQ(7)
+#define CSI_IRQ			SYSINT2_IRQ(8)
+#define BCU_IRQ			SYSINT2_IRQ(9)
+#define ETHERNET_IRQ		SYSINT2_IRQ(10)
+#define SYSINT2_IRQ_LAST	ETHERNET_IRQ
+
+/*
+ * GIU Interrupt Numbers
+ */
+#define GIU_IRQ_BASE		40
+#define GIU_IRQ(x)		(GIU_IRQ_BASE + (x))	/* IRQ 40-71 */
+#define GIU_IRQ_LAST		GIU_IRQ(31)
+
+/*
+ * VRC4173 Interrupt Numbers
+ */
+#define VRC4173_IRQ_BASE	72
+#define VRC4173_IRQ(x)		(VRC4173_IRQ_BASE + (x))
+#define VRC4173_USB_IRQ		VRC4173_IRQ(0)
+#define VRC4173_PCMCIA2_IRQ	VRC4173_IRQ(1)
+#define VRC4173_PCMCIA1_IRQ	VRC4173_IRQ(2)
+#define VRC4173_PS2CH2_IRQ	VRC4173_IRQ(3)
+#define VRC4173_PS2CH1_IRQ	VRC4173_IRQ(4)
+#define VRC4173_PIU_IRQ		VRC4173_IRQ(5)
+#define VRC4173_AIU_IRQ		VRC4173_IRQ(6)
+#define VRC4173_KIU_IRQ		VRC4173_IRQ(7)
+#define VRC4173_GIU_IRQ		VRC4173_IRQ(8)
+#define VRC4173_AC97_IRQ	VRC4173_IRQ(9)
+#define VRC4173_AC97INT1_IRQ	VRC4173_IRQ(10)
+/* RFU */
+#define VRC4173_DOZEPIU_IRQ	VRC4173_IRQ(13)
+#define VRC4173_IRQ_LAST	VRC4173_DOZEPIU_IRQ
+
+#endif /* __NEC_VR41XX_IRQ_H */
diff -pruN -X mips/Documentation/dontdiff mips-orig/include/asm-mips/vr41xx/mpc30x.h mips/include/asm-mips/vr41xx/mpc30x.h
--- mips-orig/include/asm-mips/vr41xx/mpc30x.h	2006-07-12 12:13:12.654431250 +0900
+++ mips/include/asm-mips/vr41xx/mpc30x.h	2006-07-12 13:10:46.838304250 +0900
@@ -20,7 +20,7 @@
 #ifndef __VICTOR_MPC30X_H
 #define __VICTOR_MPC30X_H
 
-#include <asm/vr41xx/vr41xx.h>
+#include <asm/vr41xx/irq.h>
 
 /*
  * General-Purpose I/O Pin Number
diff -pruN -X mips/Documentation/dontdiff mips-orig/include/asm-mips/vr41xx/tb0219.h mips/include/asm-mips/vr41xx/tb0219.h
--- mips-orig/include/asm-mips/vr41xx/tb0219.h	2006-07-12 12:13:12.654431250 +0900
+++ mips/include/asm-mips/vr41xx/tb0219.h	2006-07-12 13:10:58.647042250 +0900
@@ -23,7 +23,7 @@
 #ifndef __TANBAC_TB0219_H
 #define __TANBAC_TB0219_H
 
-#include <asm/vr41xx/vr41xx.h>
+#include <asm/vr41xx/irq.h>
 
 /*
  * General-Purpose I/O Pin Number
diff -pruN -X mips/Documentation/dontdiff mips-orig/include/asm-mips/vr41xx/tb0226.h mips/include/asm-mips/vr41xx/tb0226.h
--- mips-orig/include/asm-mips/vr41xx/tb0226.h	2006-07-12 12:13:12.654431250 +0900
+++ mips/include/asm-mips/vr41xx/tb0226.h	2006-07-12 13:11:11.571850000 +0900
@@ -20,7 +20,7 @@
 #ifndef __TANBAC_TB0226_H
 #define __TANBAC_TB0226_H
 
-#include <asm/vr41xx/vr41xx.h>
+#include <asm/vr41xx/irq.h>
 
 /*
  * General-Purpose I/O Pin Number
diff -pruN -X mips/Documentation/dontdiff mips-orig/include/asm-mips/vr41xx/tb0287.h mips/include/asm-mips/vr41xx/tb0287.h
--- mips-orig/include/asm-mips/vr41xx/tb0287.h	2006-07-12 12:13:12.654431250 +0900
+++ mips/include/asm-mips/vr41xx/tb0287.h	2006-07-12 13:11:25.972750000 +0900
@@ -22,7 +22,7 @@
 #ifndef __TANBAC_TB0287_H
 #define __TANBAC_TB0287_H
 
-#include <asm/vr41xx/vr41xx.h>
+#include <asm/vr41xx/irq.h>
 
 /*
  * General-Purpose I/O Pin Number
diff -pruN -X mips/Documentation/dontdiff mips-orig/include/asm-mips/vr41xx/vr41xx.h mips/include/asm-mips/vr41xx/vr41xx.h
--- mips-orig/include/asm-mips/vr41xx/vr41xx.h	2006-07-12 12:13:12.654431250 +0900
+++ mips/include/asm-mips/vr41xx/vr41xx.h	2006-07-12 12:56:30.872809750 +0900
@@ -74,59 +74,6 @@ extern void vr41xx_mask_clock(vr41xx_clo
 /*
  * Interrupt Control Unit
  */
-/* CPU core Interrupt Numbers */
-#define MIPS_CPU_IRQ_BASE	0
-#define MIPS_CPU_IRQ(x)		(MIPS_CPU_IRQ_BASE + (x))
-#define MIPS_SOFTINT0_IRQ	MIPS_CPU_IRQ(0)
-#define MIPS_SOFTINT1_IRQ	MIPS_CPU_IRQ(1)
-#define INT0_IRQ		MIPS_CPU_IRQ(2)
-#define INT1_IRQ		MIPS_CPU_IRQ(3)
-#define INT2_IRQ		MIPS_CPU_IRQ(4)
-#define INT3_IRQ		MIPS_CPU_IRQ(5)
-#define INT4_IRQ		MIPS_CPU_IRQ(6)
-#define TIMER_IRQ		MIPS_CPU_IRQ(7)
-
-/* SYINT1 Interrupt Numbers */
-#define SYSINT1_IRQ_BASE	8
-#define SYSINT1_IRQ(x)		(SYSINT1_IRQ_BASE + (x))
-#define BATTRY_IRQ		SYSINT1_IRQ(0)
-#define POWER_IRQ		SYSINT1_IRQ(1)
-#define RTCLONG1_IRQ		SYSINT1_IRQ(2)
-#define ELAPSEDTIME_IRQ		SYSINT1_IRQ(3)
-/* RFU */
-#define PIU_IRQ			SYSINT1_IRQ(5)
-#define AIU_IRQ			SYSINT1_IRQ(6)
-#define KIU_IRQ			SYSINT1_IRQ(7)
-#define GIUINT_IRQ		SYSINT1_IRQ(8)
-#define SIU_IRQ			SYSINT1_IRQ(9)
-#define BUSERR_IRQ		SYSINT1_IRQ(10)
-#define SOFTINT_IRQ		SYSINT1_IRQ(11)
-#define CLKRUN_IRQ		SYSINT1_IRQ(12)
-#define DOZEPIU_IRQ		SYSINT1_IRQ(13)
-#define SYSINT1_IRQ_LAST	DOZEPIU_IRQ
-
-/* SYSINT2 Interrupt Numbers */
-#define SYSINT2_IRQ_BASE	24
-#define SYSINT2_IRQ(x)		(SYSINT2_IRQ_BASE + (x))
-#define RTCLONG2_IRQ		SYSINT2_IRQ(0)
-#define LED_IRQ			SYSINT2_IRQ(1)
-#define HSP_IRQ			SYSINT2_IRQ(2)
-#define TCLOCK_IRQ		SYSINT2_IRQ(3)
-#define FIR_IRQ			SYSINT2_IRQ(4)
-#define CEU_IRQ			SYSINT2_IRQ(4)	/* same number as FIR_IRQ */
-#define DSIU_IRQ		SYSINT2_IRQ(5)
-#define PCI_IRQ			SYSINT2_IRQ(6)
-#define SCU_IRQ			SYSINT2_IRQ(7)
-#define CSI_IRQ			SYSINT2_IRQ(8)
-#define BCU_IRQ			SYSINT2_IRQ(9)
-#define ETHERNET_IRQ		SYSINT2_IRQ(10)
-#define SYSINT2_IRQ_LAST	ETHERNET_IRQ
-
-/* GIU Interrupt Numbers */
-#define GIU_IRQ_BASE		40
-#define GIU_IRQ(x)		(GIU_IRQ_BASE + (x))	/* IRQ 40-71 */
-#define GIU_IRQ_LAST		GIU_IRQ(31)
-
 extern int vr41xx_set_intassign(unsigned int irq, unsigned char intassign);
 extern int cascade_irq(unsigned int irq, int (*get_irq)(unsigned int, struct pt_regs *));
 
diff -pruN -X mips/Documentation/dontdiff mips-orig/include/asm-mips/vr41xx/vrc4173.h mips/include/asm-mips/vr41xx/vrc4173.h
--- mips-orig/include/asm-mips/vr41xx/vrc4173.h	2006-07-12 12:13:12.654431250 +0900
+++ mips/include/asm-mips/vr41xx/vrc4173.h	2006-07-12 12:56:09.215456250 +0900
@@ -27,26 +27,6 @@
 #include <asm/io.h>
 
 /*
- * Interrupt Number
- */
-#define VRC4173_IRQ_BASE	72
-#define VRC4173_IRQ(x)		(VRC4173_IRQ_BASE + (x))
-#define VRC4173_USB_IRQ		VRC4173_IRQ(0)
-#define VRC4173_PCMCIA2_IRQ	VRC4173_IRQ(1)
-#define VRC4173_PCMCIA1_IRQ	VRC4173_IRQ(2)
-#define VRC4173_PS2CH2_IRQ	VRC4173_IRQ(3)
-#define VRC4173_PS2CH1_IRQ	VRC4173_IRQ(4)
-#define VRC4173_PIU_IRQ		VRC4173_IRQ(5)
-#define VRC4173_AIU_IRQ		VRC4173_IRQ(6)
-#define VRC4173_KIU_IRQ		VRC4173_IRQ(7)
-#define VRC4173_GIU_IRQ		VRC4173_IRQ(8)
-#define VRC4173_AC97_IRQ	VRC4173_IRQ(9)
-#define VRC4173_AC97INT1_IRQ	VRC4173_IRQ(10)
-/* RFU */
-#define VRC4173_DOZEPIU_IRQ	VRC4173_IRQ(13)
-#define VRC4173_IRQ_LAST	VRC4173_DOZEPIU_IRQ
-
-/*
  * PCI I/O accesses
  */
 #ifdef CONFIG_VRC4173
