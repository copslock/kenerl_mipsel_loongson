Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Mar 2005 16:44:42 +0000 (GMT)
Received: from mo01.iij4u.or.jp ([IPv6:::ffff:210.130.0.20]:46055 "EHLO
	mo01.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225307AbVCGQo0>;
	Mon, 7 Mar 2005 16:44:26 +0000
Received: MO(mo01)id j27GiNDI000647; Tue, 8 Mar 2005 01:44:23 +0900 (JST)
Received: MDO(mdo00) id j27GiMf2027770; Tue, 8 Mar 2005 01:44:23 +0900 (JST)
Received: 4UMRO00 id j27GiL0h007645; Tue, 8 Mar 2005 01:44:22 +0900 (JST)
	from stratos (localhost [127.0.0.1]) (authenticated)
Date:	Tue, 8 Mar 2005 01:44:20 +0900
From:	Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yuasa@hh.iij4u.or.jp, macro@linux-mips.org,
	linux-mips@linux-mips.org
Subject: Re: CVS Update@linux-mips.org: linux
Message-Id: <20050308014420.6253f8ce.yuasa@hh.iij4u.or.jp>
In-Reply-To: <20050119152151.7b756560.yuasa@hh.iij4u.or.jp>
References: <20050115013112Z8225557-1340+1316@linux-mips.org>
	<20050119134211.2c0e24f5.yuasa@hh.iij4u.or.jp>
	<Pine.LNX.4.61L.0501190502070.26851@blysk.ds.pg.gda.pl>
	<20050119143146.09982d63.yuasa@hh.iij4u.or.jp>
	<Pine.LNX.4.61L.0501190533450.26851@blysk.ds.pg.gda.pl>
	<20050119152151.7b756560.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7389
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hello Ralf and Maciej,

On Wed, 19 Jan 2005 15:21:51 +0900
Yoichi Yuasa <yuasa@hh.iij4u.or.jp> wrote:

> Hi Maciej,
> 
> On Wed, 19 Jan 2005 05:35:29 +0000 (GMT)
> "Maciej W. Rozycki" <macro@linux-mips.org> wrote:
> 
> > On Wed, 19 Jan 2005, Yoichi Yuasa wrote:
> > 
> > > >  Neither of these uses any CONFIG_* macros.
> > > 
> > > I'm making patch for giu.c and icu.c.
> > > These patches need it. 
> > 
> >  Then please just include what you need within these patches.  That's the 
> > usual way of doing stuff.
> 
> Ok, I'll send a patch including get back and add new line.

Sorry for the delay.
Next I'll send giu.c update.

Yoichi

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff a-orig/arch/mips/vr41xx/Kconfig a/arch/mips/vr41xx/Kconfig
--- a-orig/arch/mips/vr41xx/Kconfig	Mon Jan 31 05:45:36 2005
+++ a/arch/mips/vr41xx/Kconfig	Tue Mar  8 01:34:14 2005
@@ -97,6 +97,10 @@
 	bool "Add PCI control unit support of NEC VR4100 series"
 	depends on MACH_VR41XX && PCI
 
+config GPIO_VR41XX
+	bool "Add General-purpose I/O unit support of NEC VR4100 series"
+	depends on MACH_VR41XX
+
 config VRC4171
 	tristate "Add NEC VRC4171 companion chip support"
 	depends on MACH_VR41XX && ISA
diff -urN -X dontdiff a-orig/arch/mips/vr41xx/common/Makefile a/arch/mips/vr41xx/common/Makefile
--- a-orig/arch/mips/vr41xx/common/Makefile	Thu Feb 26 00:23:50 2004
+++ a/arch/mips/vr41xx/common/Makefile	Fri Mar  4 17:29:00 2005
@@ -2,7 +2,8 @@
 # Makefile for common code of the NEC VR4100 series.
 #
 
-obj-y				+= bcu.o cmu.o giu.o icu.o init.o int-handler.o ksyms.o pmu.o rtc.o
+obj-y				+= bcu.o cmu.o icu.o init.o int-handler.o ksyms.o pmu.o rtc.o
+obj-$(CONFIG_GPIO_VR41XX)	+= giu.o
 obj-$(CONFIG_SERIAL_8250)	+= serial.o
 obj-$(CONFIG_VRC4171)		+= vrc4171.o
 obj-$(CONFIG_VRC4173)		+= vrc4173.o
diff -urN -X dontdiff a-orig/arch/mips/vr41xx/common/icu.c a/arch/mips/vr41xx/common/icu.c
--- a-orig/arch/mips/vr41xx/common/icu.c	Sun Jan 16 22:34:31 2005
+++ a/arch/mips/vr41xx/common/icu.c	Tue Mar  8 01:08:13 2005
@@ -3,8 +3,7 @@
  *
  *  Copyright (C) 2001-2002  MontaVista Software Inc.
  *    Author: Yoichi Yuasa <yyuasa@mvista.com or source@mvista.com>
- *  Copyright (C) 2003-2004  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
- *  Copyright (C) 2005 Ralf Baechle (ralf@linux-mips.org)
+ *  Copyright (C) 2003-2005  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -29,6 +28,7 @@
  *  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
  *  - Coped with INTASSIGN of NEC VR4133.
  */
+#include <linux/config.h>
 #include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
@@ -45,8 +45,10 @@
 
 extern asmlinkage void vr41xx_handle_interrupt(void);
 
+#ifdef CONFIG_GPIO_VR41XX
 extern void init_vr41xx_giuint_irq(void);
 extern void giuint_irq_dispatch(struct pt_regs *regs);
+#endif
 
 static uint32_t icu1_base;
 static uint32_t icu2_base;
@@ -672,9 +674,11 @@
 		for (i = 0; i < 16; i++) {
 			if (intnum == sysint1_assign[i] &&
 			    (mask1 & ((uint16_t)1 << i))) {
+#ifdef CONFIG_GPIO_VR41XX
 				if (i == 8)
 					giuint_irq_dispatch(regs);
 				else
+#endif
 					do_IRQ(SYSINT1_IRQ(i), regs);
 				return;
 			}
@@ -698,8 +702,10 @@
 
 /*=======================================================================*/
 
-static int __init vr41xx_icu_init(void)
+static inline void init_vr41xx_icu_irq(void)
 {
+	int i;
+
 	switch (current_cpu_data.cputype) {
 	case CPU_VR4111:
 	case CPU_VR4121:
@@ -723,17 +729,6 @@
 	write_icu2(0, MSYSINT2REG);
 	write_icu2(0xffff, MGIUINTHREG);
 
-	return 0;
-}
-
-early_initcall(vr41xx_icu_init);
-
-/*=======================================================================*/
-
-static inline void init_vr41xx_icu_irq(void)
-{
-	int i;
-
 	for (i = SYSINT1_IRQ_BASE; i <= SYSINT1_IRQ_LAST; i++)
 		irq_desc[i].handler = &sysint1_irq_type;
 
@@ -751,7 +746,9 @@
 {
 	mips_cpu_irq_init(MIPS_CPU_IRQ_BASE);
 	init_vr41xx_icu_irq();
+#ifdef CONFIG_GPIO_VR41XX
 	init_vr41xx_giuint_irq();
+#endif
 
 	set_except_vector(0, vr41xx_handle_interrupt);
 }
