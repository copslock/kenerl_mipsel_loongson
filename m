Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Mar 2003 07:18:22 +0000 (GMT)
Received: from sonicwall.montavista.co.jp ([IPv6:::ffff:202.232.97.131]:60089
	"EHLO yuubin.montavista.co.jp") by linux-mips.org with ESMTP
	id <S8225199AbTCKHSV>; Tue, 11 Mar 2003 07:18:21 +0000
Received: from pudding.montavista.co.jp ([10.200.0.40])
	by yuubin.montavista.co.jp (8.12.5/8.12.5) with SMTP id h2B7SYIH003670;
	Tue, 11 Mar 2003 16:28:35 +0900
Date: Tue, 11 Mar 2003 16:18:10 +0900
From: Yoichi Yuasa <yoichi_yuasa@montavista.co.jp>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: yoichi_yuasa@montavista.co.jp, linux-mips@linux-mips.org
Subject: [patch] Clean up the IRQ number in VR41xx
Message-Id: <20030311161810.6819792f.yoichi_yuasa@montavista.co.jp>
Organization: MontaVista Software Japan, Inc.
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Tue__11_Mar_2003_16:18:10_+0900_08238278"
Return-Path: <yoichi_yuasa@montavista.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1685
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@montavista.co.jp
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

--Multipart_Tue__11_Mar_2003_16:18:10_+0900_08238278
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Ralf,

I cleaned up the IRQ numbers in VR4100 series.

The IRQ number of VR4100 series were defined by various places.
This change defined the IRQ number in common(header file).

Please apply this patch.

Thanks,

Yoichi

--Multipart_Tue__11_Mar_2003_16:18:10_+0900_08238278
Content-Type: text/plain;
 name="vr41xx-irq-v24.diff"
Content-Disposition: attachment;
 filename="vr41xx-irq-v24.diff"
Content-Transfer-Encoding: 7bit

diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/common/giu.c linux/arch/mips/vr41xx/common/giu.c
--- linux.orig/arch/mips/vr41xx/common/giu.c	Mon Feb 24 11:00:04 2003
+++ linux/arch/mips/vr41xx/common/giu.c	Tue Mar 11 12:36:39 2003
@@ -167,7 +167,6 @@
 	vr41xx_clear_giuint(pin);
 }
 
-#define GIUINT_CASCADE_IRQ	16
 #define GIUINT_NR_IRQS		32
 
 enum {
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/common/icu.c linux/arch/mips/vr41xx/common/icu.c
--- linux.orig/arch/mips/vr41xx/common/icu.c	Thu Feb 27 11:39:22 2003
+++ linux/arch/mips/vr41xx/common/icu.c	Tue Mar 11 12:36:39 2003
@@ -54,16 +54,6 @@
 #include <asm/mipsregs.h>
 #include <asm/vr41xx/vr41xx.h>
 
-#define MIPS_CPU_IRQ_BASE	0
-#define SYSINT1_IRQ_BASE	8
-#define SYSINT1_IRQ_LAST	23
-#define SYSINT2_IRQ_BASE	24
-#define SYSINT2_IRQ_LAST	39
-#define GIUINT_IRQ_BASE		GIU_IRQ(0)
-#define GIUINT_IRQ_LAST		GIU_IRQ(31)
-
-#define ICU_CASCADE_IRQ		(MIPS_CPU_IRQ_BASE + 2)
-
 extern asmlinkage void vr41xx_handle_interrupt(void);
 
 extern void __init init_generic_irq(void);
@@ -228,7 +218,7 @@
 {
 	int pin;
 
-	pin = irq - GIUINT_IRQ_BASE;
+	pin = irq - GIU_IRQ_BASE;
 	if (pin < 16)
 		set_icu1(MGIUINTLREG, (u16)1 << pin);
 	else
@@ -241,7 +231,7 @@
 {
 	int pin;
 
-	pin = irq - GIUINT_IRQ_BASE;
+	pin = irq - GIU_IRQ_BASE;
 	vr41xx_disable_giuint(pin);
 
 	if (pin < 16)
@@ -252,7 +242,7 @@
 
 static unsigned int startup_giuint_irq(unsigned int irq)
 {
-	vr41xx_clear_giuint(irq - GIUINT_IRQ_BASE);
+	vr41xx_clear_giuint(irq - GIU_IRQ_BASE);
 
 	enable_giuint_irq(irq);
 
@@ -265,7 +255,7 @@
 {
 	disable_giuint_irq(irq);
 
-	vr41xx_clear_giuint(irq - GIUINT_IRQ_BASE);
+	vr41xx_clear_giuint(irq - GIU_IRQ_BASE);
 }
 
 static void end_giuint_irq(unsigned int irq)
@@ -315,12 +305,12 @@
 	write_icu2(0, MSYSINT2REG);
 	write_icu2(0, MGIUINTHREG);
 
-	for (i = SYSINT1_IRQ_BASE; i <= GIUINT_IRQ_LAST; i++) {
+	for (i = SYSINT1_IRQ_BASE; i <= GIU_IRQ_LAST; i++) {
 		if (i >= SYSINT1_IRQ_BASE && i <= SYSINT1_IRQ_LAST)
 			irq_desc[i].handler = &sysint1_irq_type;
 		else if (i >= SYSINT2_IRQ_BASE && i <= SYSINT2_IRQ_LAST)
 			irq_desc[i].handler = &sysint2_irq_type;
-		else if (i >= GIUINT_IRQ_BASE && i <= GIUINT_IRQ_LAST)
+		else if (i >= GIU_IRQ_BASE && i <= GIU_IRQ_LAST)
 			irq_desc[i].handler = &giuint_irq_type;
 	}
 
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/common/serial.c linux/arch/mips/vr41xx/common/serial.c
--- linux.orig/arch/mips/vr41xx/common/serial.c	Mon Jul 15 09:02:56 2002
+++ linux/arch/mips/vr41xx/common/serial.c	Tue Mar 11 12:36:39 2003
@@ -67,7 +67,6 @@
 
 #define SIU_BASE_BAUD		1152000
 #define SIU_CLOCK		0x0102
-#define SIU_IRQ			17
 
 /* VR4122 and VR4131 DSIU Registers */
 #define DSIURB			KSEG1ADDR(0x0f000820)
@@ -77,7 +76,6 @@
 
 #define DSIU_BASE_BAUD		1152000
 #define DSIU_CLOCK		0x0802
-#define DSIU_IRQ		29
 
 int vr41xx_serial_ports = 0;
 
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/common/time.c linux/arch/mips/vr41xx/common/time.c
--- linux.orig/arch/mips/vr41xx/common/time.c	Mon Dec  2 09:24:52 2002
+++ linux/arch/mips/vr41xx/common/time.c	Tue Mar 11 12:36:39 2003
@@ -48,8 +48,7 @@
 #include <asm/mipsregs.h>
 #include <asm/param.h>
 #include <asm/time.h>
-
-#define MIPS_COUNTER_TIMER_IRQ	7
+#include <asm/vr41xx/vr41xx.h>
 
 #define VR4111_ETIMELREG	KSEG1ADDR(0x0b0000c0)
 #define VR4122_ETIMELREG	KSEG1ADDR(0x0f000100)
@@ -87,7 +86,7 @@
 {
 	u32 count;
 
-	setup_irq(MIPS_COUNTER_TIMER_IRQ, irq);
+	setup_irq(MIPS_COUNTER_IRQ, irq);
 
 	count = read_c0_count();
 	write_c0_compare(count + (mips_counter_frequency / HZ));
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/include/asm-mips/vr41xx/capcella.h linux/include/asm-mips/vr41xx/capcella.h
--- linux.orig/include/asm-mips/vr41xx/capcella.h	Mon Jul 15 09:02:57 2002
+++ linux/include/asm-mips/vr41xx/capcella.h	Tue Mar 11 15:44:51 2003
@@ -5,7 +5,7 @@
  * BRIEF MODULE DESCRIPTION
  *	Include file for ZAO Networks Capcella.
  *
- * Copyright 2002 Yoichi Yuasa
+ * Copyright 2002,2003 Yoichi Yuasa
  *                yuasa@hh.iij4u.or.jp
  *
  *  This program is free software; you can redistribute it and/or modify it
@@ -49,13 +49,21 @@
 #define IO_MEM2_RESOURCE_END		(VR41XX_PCI_MEM2_BASE + VR41XX_PCI_MEM2_SIZE)
 
 /*
+ * General-Purpose I/O Pin Number
+ */
+#define PC104PLUS_INTA_PIN		2
+#define PC104PLUS_INTB_PIN		3
+#define PC104PLUS_INTC_PIN		4
+#define PC104PLUS_INTD_PIN		5
+
+/*
  * Interrupt Number
  */
-#define RTL8139_1_IRQ			GIU_IRQ(4)
-#define RTL8139_2_IRQ			GIU_IRQ(5)
-#define PC104PLUS_INTA_IRQ		GIU_IRQ(2)
-#define PC104PLUS_INTB_IRQ		GIU_IRQ(3)
-#define PC104PLUS_INTC_IRQ		GIU_IRQ(4)
-#define PC104PLUS_INTD_IRQ		GIU_IRQ(5)
+#define RTL8139_1_IRQ			GIU_IRQ(PC104PLUS_INTC_PIN)
+#define RTL8139_2_IRQ			GIU_IRQ(PC104PLUS_INTD_PIN)
+#define PC104PLUS_INTA_IRQ		GIU_IRQ(PC104PLUS_INTA_PIN)
+#define PC104PLUS_INTB_IRQ		GIU_IRQ(PC104PLUS_INTB_PIN)
+#define PC104PLUS_INTC_IRQ		GIU_IRQ(PC104PLUS_INTC_PIN)
+#define PC104PLUS_INTD_IRQ		GIU_IRQ(PC104PLUS_INTD_PIN)
 
 #endif /* __ZAO_CAPCELLA_H */
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/include/asm-mips/vr41xx/eagle.h linux/include/asm-mips/vr41xx/eagle.h
--- linux.orig/include/asm-mips/vr41xx/eagle.h	Fri Oct  4 01:58:02 2002
+++ linux/include/asm-mips/vr41xx/eagle.h	Tue Mar 11 15:45:11 2003
@@ -8,7 +8,7 @@
  * Author: MontaVista Software, Inc.
  *         yyuasa@mvista.com or source@mvista.com
  *
- * Copyright 2001,2002 MontaVista Software Inc.
+ * Copyright 2001-2003 MontaVista Software Inc.
  *
  *  This program is free software; you can redistribute it and/or modify it
  *  under the terms of the GNU General Public License as published by the
@@ -82,19 +82,22 @@
 #define DCD_IRQ				GIU_IRQ(DCD_PIN)
 
 #define SDBINT_IRQ_BASE			88
-#define DEG_IRQ				(SDBINT_IRQ_BASE + 1)
-#define ENUM_IRQ			(SDBINT_IRQ_BASE + 2)
-#define SIO1INT_IRQ			(SDBINT_IRQ_BASE + 3)
-#define SIO2INT_IRQ			(SDBINT_IRQ_BASE + 4)
-#define PARINT_IRQ			(SDBINT_IRQ_BASE + 5)
+#define SDBINT_IRQ(x)			(SDBINT_IRQ_BASE + (x))
+/* RFU */
+#define DEG_IRQ				SDBINT_IRQ(1)
+#define ENUM_IRQ			SDBINT_IRQ(2)
+#define SIO1INT_IRQ			SDBINT_IRQ(3)
+#define SIO2INT_IRQ			SDBINT_IRQ(4)
+#define PARINT_IRQ			SDBINT_IRQ(5)
 #define SDBINT_IRQ_LAST			PARINT_IRQ
 
 #define PCIINT_IRQ_BASE			96
-#define CP_INTA_IRQ			(PCIINT_IRQ_BASE + 0)
-#define CP_INTB_IRQ			(PCIINT_IRQ_BASE + 1)
-#define CP_INTC_IRQ			(PCIINT_IRQ_BASE + 2)
-#define CP_INTD_IRQ			(PCIINT_IRQ_BASE + 3)
-#define LANINTA_IRQ			(PCIINT_IRQ_BASE + 4)
+#define PCIINT_IRQ(x)			(PCIINT_IRQ_BASE + (x))
+#define CP_INTA_IRQ			PCIINT_IRQ(0)
+#define CP_INTB_IRQ			PCIINT_IRQ(1)
+#define CP_INTC_IRQ			PCIINT_IRQ(2)
+#define CP_INTD_IRQ			PCIINT_IRQ(3)
+#define LANINTA_IRQ			PCIINT_IRQ(4)
 #define PCIINT_IRQ_LAST			LANINTA_IRQ
 
 /*
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/include/asm-mips/vr41xx/mpc30x.h linux/include/asm-mips/vr41xx/mpc30x.h
--- linux.orig/include/asm-mips/vr41xx/mpc30x.h	Fri Oct  4 01:58:02 2002
+++ linux/include/asm-mips/vr41xx/mpc30x.h	Tue Mar 11 15:45:20 2003
@@ -5,7 +5,7 @@
  * BRIEF MODULE DESCRIPTION
  *	Include file for Victor MP-C303/304.
  *
- * Copyright 2002 Yoichi Yuasa
+ * Copyright 2002,2003 Yoichi Yuasa
  *                yuasa@hh.iij4u.or.jp
  *
  *  This program is free software; you can redistribute it and/or modify it
@@ -51,21 +51,15 @@
 #define IO_MEM2_RESOURCE_END		(VR41XX_PCI_MEM2_BASE + VR41XX_PCI_MEM2_SIZE)
 
 /*
- * Interrupt Number
+ * General-Purpose I/O Pin Number
  */
-#define VRC4173_CASCADE_IRQ		GIU_IRQ(1)
-#define MQ200_IRQ			GIU_IRQ(4)
-
-#ifdef CONFIG_VRC4173
-
-#define VRC4173_IRQ_BASE		72
-#define USB_IRQ				(VRC4173_IRQ_BASE + 0)
-#define PCMCIA2_IRQ			(VRC4173_IRQ_BASE + 1)
-#define PCMCIA1_IRQ			(VRC4173_IRQ_BASE + 2)
-#define PIU_IRQ				(VRC4173_IRQ_BASE + 5)
-#define KIU_IRQ				(VRC4173_IRQ_BASE + 7)
-#define AC97_IRQ			(VRC4173_IRQ_BASE + 9)
+#define VRC4173_PIN			1
+#define MQ200_PIN			4
 
-#endif	/* CONFIG_VRC4173 */
+/*
+ * Interrupt Number
+ */
+#define VRC4173_CASCADE_IRQ		GIU_IRQ(VRC4173_PIN)
+#define MQ200_IRQ			GIU_IRQ(MQ200_PIN)
 
 #endif /* __VICTOR_MPC30X_H */
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/include/asm-mips/vr41xx/vr41xx.h linux/include/asm-mips/vr41xx/vr41xx.h
--- linux.orig/include/asm-mips/vr41xx/vr41xx.h	Fri Oct  4 01:58:02 2002
+++ linux/include/asm-mips/vr41xx/vr41xx.h	Tue Mar 11 15:34:23 2003
@@ -53,9 +53,50 @@
 /*
  * Interrupt Control Unit
  */
+/* CPU core Interrupt Numbers */
+#define MIPS_CPU_IRQ_BASE	0
+#define MIPS_CPU_IRQ(x)		(MIPS_CPU_IRQ_BASE + (x))
+#define MIPS_SOFTINT0_IRQ	MIPS_CPU_IRQ(0)
+#define MIPS_SOFTINT1_IRQ	MIPS_CPU_IRQ(1)
+#define ICU_CASCADE_IRQ		MIPS_CPU_IRQ(2)
+#define RTC_LONG1_IRQ		MIPS_CPU_IRQ(3)
+#define RTC_LONG2_IRQ		MIPS_CPU_IRQ(4)
+/* RFU */
+#define BATTERY_IRQ		MIPS_CPU_IRQ(6)
+#define MIPS_COUNTER_IRQ	MIPS_CPU_IRQ(7)
+
+/* SYINT1 Interrupt Numbers */
+#define SYSINT1_IRQ_BASE	8
+#define SYSINT1_IRQ(x)		(SYSINT1_IRQ_BASE + (x))
+/* RFU */
+#define POWER_IRQ		SYSINT1_IRQ(1)
+/* RFU */
+#define GIUINT_CASCADE_IRQ	SYSINT1_IRQ(8)
+#define SIU_IRQ			SYSINT1_IRQ(9)
+/* RFU */
+#define SOFTINT_IRQ		SYSINT1_IRQ(11)
+#define CLKRUN_IRQ		SYSINT1_IRQ(12)
+#define SYSINT1_IRQ_LAST	CLKRUN_IRQ
+
+/* SYSINT2 Interrupt Numbers */
+#define SYSINT2_IRQ_BASE	24
+#define SYSINT2_IRQ(x)		(SYSINT2_IRQ_BASE + (x))
+/* RFU */
+#define LED_IRQ			SYSINT2_IRQ(1)
+/* RFU */
+#define VTCLOCK_IRQ		SYSINT2_IRQ(3)
+#define FIR_IRQ			SYSINT2_IRQ(4)
+#define DSIU_IRQ		SYSINT2_IRQ(5)
+#define PCI_IRQ			SYSINT2_IRQ(6)
+#define SCU_IRQ			SYSINT2_IRQ(7)
+#define CSI_IRQ			SYSINT2_IRQ(8)
+#define BCU_IRQ			SYSINT2_IRQ(9)
+#define SYSINT2_IRQ_LAST	BCU_IRQ
 
 /* GIU Interrupt Numbers */
-#define GIU_IRQ(x)	(40 + (x))
+#define GIU_IRQ_BASE		40
+#define GIU_IRQ(x)		(GIU_IRQ_BASE + (x))	/* IRQ 40-71 */
+#define GIU_IRQ_LAST		GIU_IRQ(31)
 
 extern void (*board_irq_init)(void);
 extern int vr41xx_cascade_irq(unsigned int irq, int (*get_irq_number)(int irq));
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/include/asm-mips/vr41xx/vrc4173.h linux/include/asm-mips/vr41xx/vrc4173.h
--- linux.orig/include/asm-mips/vr41xx/vrc4173.h	Thu Dec 12 10:10:10 2002
+++ linux/include/asm-mips/vr41xx/vrc4173.h	Tue Mar 11 15:45:45 2003
@@ -11,7 +11,7 @@
  *
  * Copyright (C) 2000 by Michael R. McDonald
  *
- * Copyright 2001,2002 Montavista Software Inc.
+ * Copyright 2001-2003 Montavista Software Inc.
  * Author: Yoichi Yuasa
  *         yyuasa@mvista.com or source@mvista.com
  */
@@ -24,18 +24,20 @@
  * Interrupt Number
  */
 #define VRC4173_IRQ_BASE	72
-#define VRC4173_USB_IRQ		(VRC4173_IRQ_BASE + 0)
-#define VRC4173_PCMCIA2_IRQ	(VRC4173_IRQ_BASE + 1)
-#define VRC4173_PCMCIA1_IRQ	(VRC4173_IRQ_BASE + 2)
-#define VRC4173_PS2CH2_IRQ	(VRC4173_IRQ_BASE + 3)
-#define VRC4173_PS2CH1_IRQ	(VRC4173_IRQ_BASE + 4)
-#define VRC4173_PIU_IRQ		(VRC4173_IRQ_BASE + 5)
-#define VRC4173_AIU_IRQ		(VRC4173_IRQ_BASE + 6)
-#define VRC4173_KIU_IRQ		(VRC4173_IRQ_BASE + 7)
-#define VRC4173_GIU_IRQ		(VRC4173_IRQ_BASE + 8)
-#define VRC4173_AC97_IRQ	(VRC4173_IRQ_BASE + 9)
-#define VRC4173_AC97INT1_IRQ	(VRC4173_IRQ_BASE + 10)
-#define VRC4173_DOZEPIU_IRQ	(VRC4173_IRQ_BASE + 13)
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
 #define VRC4173_IRQ_LAST	VRC4173_DOZEPIU_IRQ
 
 /*

--Multipart_Tue__11_Mar_2003_16:18:10_+0900_08238278--
