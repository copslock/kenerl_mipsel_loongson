Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Mar 2005 15:48:12 +0000 (GMT)
Received: from mo01.iij4u.or.jp ([IPv6:::ffff:210.130.0.20]:205 "EHLO
	mo01.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225478AbVCQPrz>;
	Thu, 17 Mar 2005 15:47:55 +0000
Received: MO(mo01)id j2HFlqjj027215; Fri, 18 Mar 2005 00:47:52 +0900 (JST)
Received: MDO(mdo01) id j2HFlpVu002681; Fri, 18 Mar 2005 00:47:52 +0900 (JST)
Received: 4UMRO00 id j2HFloJJ012817; Fri, 18 Mar 2005 00:47:51 +0900 (JST)
	from stratos (localhost [127.0.0.1]) (authenticated)
Date:	Fri, 18 Mar 2005 00:47:50 +0900
From:	Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To:	ralf@linux-mips.org
Cc:	yuasa@hh.iij4u.or.jp, macro@linux-mips.org,
	linux-mips@linux-mips.org
Subject: Re: CVS Update@linux-mips.org: linux
Message-Id: <20050318004750.01b33b9e.yuasa@hh.iij4u.or.jp>
In-Reply-To: <20050308014420.6253f8ce.yuasa@hh.iij4u.or.jp>
References: <20050115013112Z8225557-1340+1316@linux-mips.org>
	<20050119134211.2c0e24f5.yuasa@hh.iij4u.or.jp>
	<Pine.LNX.4.61L.0501190502070.26851@blysk.ds.pg.gda.pl>
	<20050119143146.09982d63.yuasa@hh.iij4u.or.jp>
	<Pine.LNX.4.61L.0501190533450.26851@blysk.ds.pg.gda.pl>
	<20050119152151.7b756560.yuasa@hh.iij4u.or.jp>
	<20050308014420.6253f8ce.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7458
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hello again,

On Tue, 8 Mar 2005 01:44:20 +0900
Yoichi Yuasa <yuasa@hh.iij4u.or.jp> wrote:

> Hello Ralf and Maciej,
> 
> On Wed, 19 Jan 2005 15:21:51 +0900
> Yoichi Yuasa <yuasa@hh.iij4u.or.jp> wrote:
> 
> > Hi Maciej,
> > 
> > On Wed, 19 Jan 2005 05:35:29 +0000 (GMT)
> > "Maciej W. Rozycki" <macro@linux-mips.org> wrote:
> > 
> > > On Wed, 19 Jan 2005, Yoichi Yuasa wrote:
> > > 
> > > > >  Neither of these uses any CONFIG_* macros.
> > > > 
> > > > I'm making patch for giu.c and icu.c.
> > > > These patches need it. 
> > > 
> > >  Then please just include what you need within these patches.  That's the 
> > > usual way of doing stuff.
> > 
> > Ok, I'll send a patch including get back and add new line.
> 
> Sorry for the delay.
> Next I'll send giu.c update.

This is giu.c update.

Yoichi

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff a-orig/arch/mips/vr41xx/Kconfig a/arch/mips/vr41xx/Kconfig
--- a-orig/arch/mips/vr41xx/Kconfig	Tue Mar  8 08:10:16 2005
+++ a/arch/mips/vr41xx/Kconfig	Sun Mar 13 23:45:57 2005
@@ -98,7 +98,7 @@
 	depends on MACH_VR41XX && PCI
 
 config GPIO_VR41XX
-	bool "Add General-purpose I/O unit support of NEC VR4100 series"
+	tristate "Add General-purpose I/O unit support of NEC VR4100 series"
 	depends on MACH_VR41XX
 
 config VRC4171
diff -urN -X dontdiff a-orig/arch/mips/vr41xx/common/giu.c a/arch/mips/vr41xx/common/giu.c
--- a-orig/arch/mips/vr41xx/common/giu.c	Sun Jan 16 22:34:31 2005
+++ a/arch/mips/vr41xx/common/giu.c	Thu Mar 17 01:09:47 2005
@@ -3,8 +3,7 @@
  *
  *  Copyright (C) 2002 MontaVista Software Inc.
  *    Author: Yoichi Yuasa <yyuasa@mvista.com or source@mvista.com>
- *  Copyright (C) 2003-2004  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
- *  Copyright (C) 2005 Ralf Baechle (ralf@linux-mips.org)
+ *  Copyright (C) 2003-2005  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -29,6 +28,7 @@
  *  - Added support for NEC VR4133.
  *  - Removed board_irq_init.
  */
+#include <linux/config.h>
 #include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/irq.h>
@@ -63,12 +63,6 @@
 
 static uint32_t giu_base;
 
-static struct irqaction giu_cascade = {
-	.handler	= no_action,
-	.mask		= CPU_MASK_NONE,
-	.name		= "cascade",
-};
-
 #define read_giuint(offset)		readw(giu_base + (offset))
 #define write_giuint(val, offset)	writew((val), giu_base + (offset))
 
@@ -192,18 +186,20 @@
 	.end		= end_giuint_high_irq,
 };
 
-void __init init_vr41xx_giuint_irq(void)
+void vr41xx_enable_giuint(unsigned int pin)
 {
-	int i;
-
-	for (i = GIU_IRQ_BASE; i <= GIU_IRQ_LAST; i++) {
-		if (i < (GIU_IRQ_BASE + GIUINT_HIGH_OFFSET))
-			irq_desc[i].handler = &giuint_low_irq_type;
-		else
-			irq_desc[i].handler = &giuint_high_irq_type;
-	}
+	if (pin < GIUINT_HIGH_OFFSET)
+		enable_giuint_low_irq(GIU_IRQ(pin));
+	else
+		enable_giuint_high_irq(GIU_IRQ(pin));
+}
 
-	setup_irq(GIUINT_CASCADE_IRQ, &giu_cascade);
+void vr41xx_disable_giuint(unsigned int pin)
+{
+	if (pin < GIUINT_HIGH_OFFSET)
+		disable_giuint_low_irq(GIU_IRQ(pin));
+	else
+		disable_giuint_high_irq(GIU_IRQ(pin));
 }
 
 void vr41xx_set_irq_trigger(int pin, int trigger, int hold)
@@ -296,6 +292,8 @@
 
 EXPORT_SYMBOL(vr41xx_set_irq_level);
 
+#ifndef MODULE
+
 #define GIUINT_NR_IRQS		32
 
 enum {
@@ -310,6 +308,12 @@
 
 static struct vr41xx_giuint_cascade giuint_cascade[GIUINT_NR_IRQS];
 
+static struct irqaction giu_cascade = {
+	.handler	= no_action,
+	.mask		= CPU_MASK_NONE,
+	.name		= "cascade",
+};
+
 static int no_irq_number(int irq)
 {
 	return -EINVAL;
@@ -421,7 +425,7 @@
 	enable_irq(GIUINT_CASCADE_IRQ);
 }
 
-static int __init vr41xx_giu_init(void)
+void __init init_vr41xx_giuint_irq(void)
 {
 	int i;
 
@@ -437,7 +441,7 @@
 		break;
 	default:
 		printk(KERN_ERR "GIU: Unexpected CPU of NEC VR4100 series\n");
-		return -EINVAL;
+		return;
 	}
 
 	for (i = 0; i < GIUINT_NR_IRQS; i++) {
@@ -449,7 +453,14 @@
 		giuint_cascade[i].get_irq_number = no_irq_number;
 	}
 
-	return 0;
+	for (i = GIU_IRQ_BASE; i <= GIU_IRQ_LAST; i++) {
+		if (i < (GIU_IRQ_BASE + GIUINT_HIGH_OFFSET))
+			irq_desc[i].handler = &giuint_low_irq_type;
+		else
+			irq_desc[i].handler = &giuint_high_irq_type;
+	}
+
+	setup_irq(GIUINT_CASCADE_IRQ, &giu_cascade);
 }
 
-early_initcall(vr41xx_giu_init);
+#endif
