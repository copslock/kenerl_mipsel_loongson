Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Jan 2007 14:01:16 +0000 (GMT)
Received: from mo31.po.2iij.net ([210.128.50.54]:34861 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20038988AbXAVOBL (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 22 Jan 2007 14:01:11 +0000
Received: by mo.po.2iij.net (mo31) id l0ME17xg057482; Mon, 22 Jan 2007 23:01:08 +0900 (JST)
Received: from localhost.localdomain (69.25.30.125.dy.iij4u.or.jp [125.30.25.69])
	by mbox.po.2iij.net (mbox33) id l0ME16pA043084
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 22 Jan 2007 23:01:06 +0900 (JST)
Date:	Mon, 22 Jan 2007 23:01:06 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] GENERIC_HARDIRQS_NO__DO_IRQ update for vr41xx
Message-Id: <20070122230106.312a6348.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13732
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch is necessary according to GENERIC_HARDIRQS_NO__DO_IRQ update for vr41xx.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/vr41xx/common/irq.c mips/arch/mips/vr41xx/common/irq.c
--- mips-orig/arch/mips/vr41xx/common/irq.c	2007-01-22 22:40:50.549626250 +0900
+++ mips/arch/mips/vr41xx/common/irq.c	2007-01-22 22:42:59.001654000 +0900
@@ -1,7 +1,7 @@
 /*
  *  Interrupt handing routines for NEC VR4100 series.
  *
- *  Copyright (C) 2005  Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
+ *  Copyright (C) 2005-2007  Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -73,13 +73,19 @@ static void irq_dispatch(unsigned int ir
 	if (cascade->get_irq != NULL) {
 		unsigned int source_irq = irq;
 		desc = irq_desc + source_irq;
-		desc->chip->ack(source_irq);
+		if (desc->chip->mask_ack)
+			desc->chip->mask_ack(source_irq);
+		else {
+			desc->chip->mask(source_irq);
+			desc->chip->ack(source_irq);
+		}
 		irq = cascade->get_irq(irq);
 		if (irq < 0)
 			atomic_inc(&irq_err_count);
 		else
 			irq_dispatch(irq);
-		desc->chip->end(source_irq);
+		if (!(desc->status & IRQ_DISABLED) && desc->chip->unmask)
+			desc->chip->unmask(source_irq);
 	} else
 		do_IRQ(irq);
 }
diff -pruN -X mips/Documentation/dontdiff mips-orig/drivers/char/vr41xx_giu.c mips/drivers/char/vr41xx_giu.c
--- mips-orig/drivers/char/vr41xx_giu.c	2007-01-22 22:40:55.221918250 +0900
+++ mips/drivers/char/vr41xx_giu.c	2007-01-22 22:42:59.005654250 +0900
@@ -3,7 +3,7 @@
  *
  *  Copyright (C) 2002 MontaVista Software Inc.
  *	Author: Yoichi Yuasa <yyuasa@mvista.com or source@mvista.com>
- *  Copyright (C) 2003-2005  Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
+ *  Copyright (C) 2003-2007  Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -125,30 +125,17 @@ static inline uint16_t giu_clear(uint16_
 	return data;
 }
 
-static unsigned int startup_giuint_low_irq(unsigned int irq)
+static void ack_giuint_low(unsigned int irq)
 {
-	unsigned int pin;
-
-	pin = GPIO_PIN_OF_IRQ(irq);
-	giu_write(GIUINTSTATL, 1 << pin);
-	giu_set(GIUINTENL, 1 << pin);
-
-	return 0;
+	giu_write(GIUINTSTATL, 1 << GPIO_PIN_OF_IRQ(irq));
 }
 
-static void shutdown_giuint_low_irq(unsigned int irq)
+static void mask_giuint_low(unsigned int irq)
 {
 	giu_clear(GIUINTENL, 1 << GPIO_PIN_OF_IRQ(irq));
 }
 
-static void enable_giuint_low_irq(unsigned int irq)
-{
-	giu_set(GIUINTENL, 1 << GPIO_PIN_OF_IRQ(irq));
-}
-
-#define disable_giuint_low_irq	shutdown_giuint_low_irq
-
-static void ack_giuint_low_irq(unsigned int irq)
+static void mask_ack_giuint_low(unsigned int irq)
 {
 	unsigned int pin;
 
@@ -157,46 +144,30 @@ static void ack_giuint_low_irq(unsigned 
 	giu_write(GIUINTSTATL, 1 << pin);
 }
 
-static void end_giuint_low_irq(unsigned int irq)
+static void unmask_giuint_low(unsigned int irq)
 {
-	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS)))
-		giu_set(GIUINTENL, 1 << GPIO_PIN_OF_IRQ(irq));
+	giu_set(GIUINTENL, 1 << GPIO_PIN_OF_IRQ(irq));
 }
 
-static struct hw_interrupt_type giuint_low_irq_type = {
-	.typename	= "GIUINTL",
-	.startup	= startup_giuint_low_irq,
-	.shutdown	= shutdown_giuint_low_irq,
-	.enable		= enable_giuint_low_irq,
-	.disable	= disable_giuint_low_irq,
-	.ack		= ack_giuint_low_irq,
-	.end		= end_giuint_low_irq,
+static struct irq_chip giuint_low_irq_chip = {
+	.name		= "GIUINTL",
+	.ack		= ack_giuint_low,
+	.mask		= mask_giuint_low,
+	.mask_ack	= mask_ack_giuint_low,
+	.unmask		= unmask_giuint_low,
 };
 
-static unsigned int startup_giuint_high_irq(unsigned int irq)
+static void ack_giuint_high(unsigned int irq)
 {
-	unsigned int pin;
-
-	pin = GPIO_PIN_OF_IRQ(irq) - GIUINT_HIGH_OFFSET;
-	giu_write(GIUINTSTATH, 1 << pin);
-	giu_set(GIUINTENH, 1 << pin);
-
-	return 0;
+	giu_write(GIUINTSTATH, 1 << (GPIO_PIN_OF_IRQ(irq) - GIUINT_HIGH_OFFSET));
 }
 
-static void shutdown_giuint_high_irq(unsigned int irq)
+static void mask_giuint_high(unsigned int irq)
 {
 	giu_clear(GIUINTENH, 1 << (GPIO_PIN_OF_IRQ(irq) - GIUINT_HIGH_OFFSET));
 }
 
-static void enable_giuint_high_irq(unsigned int irq)
-{
-	giu_set(GIUINTENH, 1 << (GPIO_PIN_OF_IRQ(irq) - GIUINT_HIGH_OFFSET));
-}
-
-#define disable_giuint_high_irq	shutdown_giuint_high_irq
-
-static void ack_giuint_high_irq(unsigned int irq)
+static void mask_ack_giuint_high(unsigned int irq)
 {
 	unsigned int pin;
 
@@ -205,20 +176,17 @@ static void ack_giuint_high_irq(unsigned
 	giu_write(GIUINTSTATH, 1 << pin);
 }
 
-static void end_giuint_high_irq(unsigned int irq)
+static void unmask_giuint_high(unsigned int irq)
 {
-	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS)))
-		giu_set(GIUINTENH, 1 << (GPIO_PIN_OF_IRQ(irq) - GIUINT_HIGH_OFFSET));
+	giu_set(GIUINTENH, 1 << (GPIO_PIN_OF_IRQ(irq) - GIUINT_HIGH_OFFSET));
 }
 
-static struct hw_interrupt_type giuint_high_irq_type = {
-	.typename	= "GIUINTH",
-	.startup	= startup_giuint_high_irq,
-	.shutdown	= shutdown_giuint_high_irq,
-	.enable		= enable_giuint_high_irq,
-	.disable	= disable_giuint_high_irq,
-	.ack		= ack_giuint_high_irq,
-	.end		= end_giuint_high_irq,
+static struct irq_chip giuint_high_irq_chip = {
+	.name		= "GIUINTH",
+	.ack		= ack_giuint_high,
+	.mask		= mask_giuint_high,
+	.mask_ack	= mask_ack_giuint_high,
+	.unmask		= unmask_giuint_high,
 };
 
 static int giu_get_irq(unsigned int irq)
@@ -282,9 +250,15 @@ void vr41xx_set_irq_trigger(unsigned int
 					break;
 				}
 			}
+			set_irq_chip_and_handler(GIU_IRQ(pin),
+			                         &giuint_low_irq_chip,
+			                         handle_edge_irq);
 		} else {
 			giu_clear(GIUINTTYPL, mask);
 			giu_clear(GIUINTHTSELL, mask);
+			set_irq_chip_and_handler(GIU_IRQ(pin),
+			                         &giuint_low_irq_chip,
+			                         handle_level_irq);
 		}
 		giu_write(GIUINTSTATL, mask);
 	} else if (pin < GIUINT_HIGH_MAX) {
@@ -311,9 +285,15 @@ void vr41xx_set_irq_trigger(unsigned int
 					break;
 				}
 			}
+			set_irq_chip_and_handler(GIU_IRQ(pin),
+			                         &giuint_high_irq_chip,
+			                         handle_edge_irq);
 		} else {
 			giu_clear(GIUINTTYPH, mask);
 			giu_clear(GIUINTHTSELH, mask);
+			set_irq_chip_and_handler(GIU_IRQ(pin),
+			                         &giuint_high_irq_chip,
+			                         handle_level_irq);
 		}
 		giu_write(GIUINTSTATH, mask);
 	}
@@ -617,10 +597,11 @@ static const struct file_operations gpio
 static int __devinit giu_probe(struct platform_device *dev)
 {
 	unsigned long start, size, flags = 0;
-	unsigned int nr_pins = 0;
+	unsigned int nr_pins = 0, trigger, i, pin;
 	struct resource *res1, *res2 = NULL;
 	void *base;
-	int retval, i;
+	struct irq_chip *chip;
+	int retval;
 
 	switch (current_cpu_data.cputype) {
 	case CPU_VR4111:
@@ -688,11 +669,20 @@ static int __devinit giu_probe(struct pl
 	giu_write(GIUINTENL, 0);
 	giu_write(GIUINTENH, 0);
 
+	trigger = giu_read(GIUINTTYPH) << 16;
+	trigger |= giu_read(GIUINTTYPL);
 	for (i = GIU_IRQ_BASE; i <= GIU_IRQ_LAST; i++) {
-		if (i < GIU_IRQ(GIUINT_HIGH_OFFSET))
-			irq_desc[i].chip = &giuint_low_irq_type;
+		pin = GPIO_PIN_OF_IRQ(i);
+		if (pin < GIUINT_HIGH_OFFSET)
+			chip = &giuint_low_irq_chip;
 		else
-			irq_desc[i].chip = &giuint_high_irq_type;
+			chip = &giuint_high_irq_chip;
+
+		if (trigger & (1 << pin))
+			set_irq_chip_and_handler(i, chip, handle_edge_irq);
+		else
+			set_irq_chip_and_handler(i, chip, handle_level_irq);
+
 	}
 
 	return cascade_irq(GIUINT_IRQ, giu_get_irq);
