Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Jun 2009 04:16:04 +0200 (CEST)
Received: from mail-px0-f188.google.com ([209.85.216.188]:58384 "EHLO
	mail-px0-f188.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1491789AbZF2CP6 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 29 Jun 2009 04:15:58 +0200
Received: by pxi26 with SMTP id 26so2786188pxi.22
        for <multiple recipients>; Sun, 28 Jun 2009 19:11:05 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=D81BRzgoYOy3uOuq4EvzaF2KUzfTUXknnmP9p2y7/Bc=;
        b=bxRoHhn3oF9sGRf+GRqrORF1F+vqUFBGIAK4StQu9HcVMJ2kPPG7/30KlIYEOG00no
         frQPZJ+neHcczRgZr6xUsSzhebabdQekK1u1Uz7XcDctjqFy0zAOepZRG3vLwOUHZGIO
         XcXIF2HnFt3ftzcyd95Sk3Lnb1HLvzxMKJacI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=lehMYEtJszWDW1wkaoWKV9yG4ejWe10aav6tLHQp6uZafMAwlqAM2yO34mSr0f0u06
         2MW2KqyZ/yzdV9uik0QCGdXJES7MIJjS8IDSCMd92nbcl1S2PEdKiXpX65+QF7u0yQex
         jyUPsfL7R4EFu3HOPOuRJJbj0IbLCGFNgrfsw=
Received: by 10.114.103.1 with SMTP id a1mr10496512wac.218.1246241465454;
        Sun, 28 Jun 2009 19:11:05 -0700 (PDT)
Received: from fulvia (65.126.232.202.bf.2iij.net [202.232.126.65])
        by mx.google.com with ESMTPS id j26sm7905168waf.63.2009.06.28.19.11.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 28 Jun 2009 19:11:04 -0700 (PDT)
Date:	Mon, 29 Jun 2009 11:11:05 +0900
From:	Yoichi Yuasa <yyuasa@linux.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-mips <linux-mips@linux-mips.org>, yyuasa@linux.com
Subject: [PATCH v2] update vr41xx GPIO driver using gpiolib
Message-Id: <20090629111105.9ff024bf.yyuasa@linux.com>
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.12; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yyuasa@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23527
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yyuasa@linux.com
Precedence: bulk
X-list: linux-mips

checked by checkpatch.pl .

Signed-off-by: Yoichi Yuasa <yyuasa@linux.com>

diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/arch/mips/Kconfig linux/arch/mips/Kconfig
--- linux-orig/arch/mips/Kconfig	2009-06-29 10:04:07.713177730 +0900
+++ linux/arch/mips/Kconfig	2009-06-29 10:08:14.249177534 +0900
@@ -247,6 +247,7 @@ config MACH_VR41XX
 	select CEVT_R4K
 	select CSRC_R4K
 	select SYS_HAS_CPU_VR41XX
+	select ARCH_REQUIRE_GPIOLIB
 
 config NXP_STB220
 	bool "NXP STB220 board"
diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/arch/mips/include/asm/vr41xx/giu.h linux/arch/mips/include/asm/vr41xx/giu.h
--- linux-orig/arch/mips/include/asm/vr41xx/giu.h	2009-06-29 10:04:09.401177557 +0900
+++ linux/arch/mips/include/asm/vr41xx/giu.h	2009-06-29 10:08:15.609177650 +0900
@@ -1,7 +1,7 @@
 /*
  *  Include file for NEC VR4100 series General-purpose I/O Unit.
  *
- *  Copyright (C) 2005  Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
+ *  Copyright (C) 2005-2009  Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -41,7 +41,8 @@ typedef enum {
 	IRQ_SIGNAL_HOLD,
 } irq_signal_t;
 
-extern void vr41xx_set_irq_trigger(unsigned int pin, irq_trigger_t trigger, irq_signal_t signal);
+extern void vr41xx_set_irq_trigger(unsigned int pin, irq_trigger_t trigger,
+				   irq_signal_t signal);
 
 typedef enum {
 	IRQ_LEVEL_LOW,
@@ -51,23 +52,6 @@ typedef enum {
 extern void vr41xx_set_irq_level(unsigned int pin, irq_level_t level);
 
 typedef enum {
-	GPIO_DATA_LOW,
-	GPIO_DATA_HIGH,
-	GPIO_DATA_INVAL,
-} gpio_data_t;
-
-extern gpio_data_t vr41xx_gpio_get_pin(unsigned int pin);
-extern int vr41xx_gpio_set_pin(unsigned int pin, gpio_data_t data);
-
-typedef enum {
-	GPIO_INPUT,
-	GPIO_OUTPUT,
-	GPIO_OUTPUT_DISABLE,
-} gpio_direction_t;
-
-extern int vr41xx_gpio_set_direction(unsigned int pin, gpio_direction_t dir);
-
-typedef enum {
 	GPIO_PULL_DOWN,
 	GPIO_PULL_UP,
 	GPIO_PULL_DISABLE,
diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/drivers/char/Kconfig linux/drivers/char/Kconfig
--- linux-orig/drivers/char/Kconfig	2009-06-29 10:06:56.837177724 +0900
+++ linux/drivers/char/Kconfig	2009-06-29 10:08:16.025177567 +0900
@@ -1029,10 +1029,6 @@ config CS5535_GPIO
 
 	  If compiled as a module, it will be called cs5535_gpio.
 
-config GPIO_VR41XX
-	tristate "NEC VR4100 series General-purpose I/O Unit support"
-	depends on CPU_VR41XX
-
 config RAW_DRIVER
 	tristate "RAW driver (/dev/raw/rawN)"
 	depends on BLOCK
diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/drivers/char/Makefile linux/drivers/char/Makefile
--- linux-orig/drivers/char/Makefile	2009-06-29 10:06:56.837177724 +0900
+++ linux/drivers/char/Makefile	2009-06-29 10:08:17.297177661 +0900
@@ -95,7 +95,6 @@ obj-$(CONFIG_SCx200_GPIO)	+= scx200_gpio
 obj-$(CONFIG_PC8736x_GPIO)	+= pc8736x_gpio.o
 obj-$(CONFIG_NSC_GPIO)		+= nsc_gpio.o
 obj-$(CONFIG_CS5535_GPIO)	+= cs5535_gpio.o
-obj-$(CONFIG_GPIO_VR41XX)	+= vr41xx_giu.o
 obj-$(CONFIG_GPIO_TB0219)	+= tb0219.o
 obj-$(CONFIG_TELCLOCK)		+= tlclk.o
 
diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/drivers/char/vr41xx_giu.c linux/drivers/char/vr41xx_giu.c
--- linux-orig/drivers/char/vr41xx_giu.c	2009-06-29 10:06:58.329177629 +0900
+++ linux/drivers/char/vr41xx_giu.c	1970-01-01 09:00:00.000000000 +0900
@@ -1,680 +0,0 @@
-/*
- *  Driver for NEC VR4100 series General-purpose I/O Unit.
- *
- *  Copyright (C) 2002 MontaVista Software Inc.
- *	Author: Yoichi Yuasa <yyuasa@mvista.com or source@mvista.com>
- *  Copyright (C) 2003-2007  Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-#include <linux/errno.h>
-#include <linux/fs.h>
-#include <linux/init.h>
-#include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/platform_device.h>
-#include <linux/smp_lock.h>
-#include <linux/spinlock.h>
-#include <linux/types.h>
-
-#include <asm/io.h>
-#include <asm/vr41xx/giu.h>
-#include <asm/vr41xx/irq.h>
-#include <asm/vr41xx/vr41xx.h>
-
-MODULE_AUTHOR("Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>");
-MODULE_DESCRIPTION("NEC VR4100 series General-purpose I/O Unit driver");
-MODULE_LICENSE("GPL");
-
-static int major;	/* default is dynamic major device number */
-module_param(major, int, 0);
-MODULE_PARM_DESC(major, "Major device number");
-
-#define GIUIOSELL	0x00
-#define GIUIOSELH	0x02
-#define GIUPIODL	0x04
-#define GIUPIODH	0x06
-#define GIUINTSTATL	0x08
-#define GIUINTSTATH	0x0a
-#define GIUINTENL	0x0c
-#define GIUINTENH	0x0e
-#define GIUINTTYPL	0x10
-#define GIUINTTYPH	0x12
-#define GIUINTALSELL	0x14
-#define GIUINTALSELH	0x16
-#define GIUINTHTSELL	0x18
-#define GIUINTHTSELH	0x1a
-#define GIUPODATL	0x1c
-#define GIUPODATEN	0x1c
-#define GIUPODATH	0x1e
- #define PIOEN0		0x0100
- #define PIOEN1		0x0200
-#define GIUPODAT	0x1e
-#define GIUFEDGEINHL	0x20
-#define GIUFEDGEINHH	0x22
-#define GIUREDGEINHL	0x24
-#define GIUREDGEINHH	0x26
-
-#define GIUUSEUPDN	0x1e0
-#define GIUTERMUPDN	0x1e2
-
-#define GPIO_HAS_PULLUPDOWN_IO		0x0001
-#define GPIO_HAS_OUTPUT_ENABLE		0x0002
-#define GPIO_HAS_INTERRUPT_EDGE_SELECT	0x0100
-
-static spinlock_t giu_lock;
-static unsigned long giu_flags;
-static unsigned int giu_nr_pins;
-
-static void __iomem *giu_base;
-
-#define giu_read(offset)		readw(giu_base + (offset))
-#define giu_write(offset, value)	writew((value), giu_base + (offset))
-
-#define GPIO_PIN_OF_IRQ(irq)	((irq) - GIU_IRQ_BASE)
-#define GIUINT_HIGH_OFFSET	16
-#define GIUINT_HIGH_MAX		32
-
-static inline uint16_t giu_set(uint16_t offset, uint16_t set)
-{
-	uint16_t data;
-
-	data = giu_read(offset);
-	data |= set;
-	giu_write(offset, data);
-
-	return data;
-}
-
-static inline uint16_t giu_clear(uint16_t offset, uint16_t clear)
-{
-	uint16_t data;
-
-	data = giu_read(offset);
-	data &= ~clear;
-	giu_write(offset, data);
-
-	return data;
-}
-
-static void ack_giuint_low(unsigned int irq)
-{
-	giu_write(GIUINTSTATL, 1 << GPIO_PIN_OF_IRQ(irq));
-}
-
-static void mask_giuint_low(unsigned int irq)
-{
-	giu_clear(GIUINTENL, 1 << GPIO_PIN_OF_IRQ(irq));
-}
-
-static void mask_ack_giuint_low(unsigned int irq)
-{
-	unsigned int pin;
-
-	pin = GPIO_PIN_OF_IRQ(irq);
-	giu_clear(GIUINTENL, 1 << pin);
-	giu_write(GIUINTSTATL, 1 << pin);
-}
-
-static void unmask_giuint_low(unsigned int irq)
-{
-	giu_set(GIUINTENL, 1 << GPIO_PIN_OF_IRQ(irq));
-}
-
-static struct irq_chip giuint_low_irq_chip = {
-	.name		= "GIUINTL",
-	.ack		= ack_giuint_low,
-	.mask		= mask_giuint_low,
-	.mask_ack	= mask_ack_giuint_low,
-	.unmask		= unmask_giuint_low,
-};
-
-static void ack_giuint_high(unsigned int irq)
-{
-	giu_write(GIUINTSTATH, 1 << (GPIO_PIN_OF_IRQ(irq) - GIUINT_HIGH_OFFSET));
-}
-
-static void mask_giuint_high(unsigned int irq)
-{
-	giu_clear(GIUINTENH, 1 << (GPIO_PIN_OF_IRQ(irq) - GIUINT_HIGH_OFFSET));
-}
-
-static void mask_ack_giuint_high(unsigned int irq)
-{
-	unsigned int pin;
-
-	pin = GPIO_PIN_OF_IRQ(irq) - GIUINT_HIGH_OFFSET;
-	giu_clear(GIUINTENH, 1 << pin);
-	giu_write(GIUINTSTATH, 1 << pin);
-}
-
-static void unmask_giuint_high(unsigned int irq)
-{
-	giu_set(GIUINTENH, 1 << (GPIO_PIN_OF_IRQ(irq) - GIUINT_HIGH_OFFSET));
-}
-
-static struct irq_chip giuint_high_irq_chip = {
-	.name		= "GIUINTH",
-	.ack		= ack_giuint_high,
-	.mask		= mask_giuint_high,
-	.mask_ack	= mask_ack_giuint_high,
-	.unmask		= unmask_giuint_high,
-};
-
-static int giu_get_irq(unsigned int irq)
-{
-	uint16_t pendl, pendh, maskl, maskh;
-	int i;
-
-	pendl = giu_read(GIUINTSTATL);
-	pendh = giu_read(GIUINTSTATH);
-	maskl = giu_read(GIUINTENL);
-	maskh = giu_read(GIUINTENH);
-
-	maskl &= pendl;
-	maskh &= pendh;
-
-	if (maskl) {
-		for (i = 0; i < 16; i++) {
-			if (maskl & (1 << i))
-				return GIU_IRQ(i);
-		}
-	} else if (maskh) {
-		for (i = 0; i < 16; i++) {
-			if (maskh & (1 << i))
-				return GIU_IRQ(i + GIUINT_HIGH_OFFSET);
-		}
-	}
-
-	printk(KERN_ERR "spurious GIU interrupt: %04x(%04x),%04x(%04x)\n",
-	       maskl, pendl, maskh, pendh);
-
-	atomic_inc(&irq_err_count);
-
-	return -EINVAL;
-}
-
-void vr41xx_set_irq_trigger(unsigned int pin, irq_trigger_t trigger, irq_signal_t signal)
-{
-	uint16_t mask;
-
-	if (pin < GIUINT_HIGH_OFFSET) {
-		mask = 1 << pin;
-		if (trigger != IRQ_TRIGGER_LEVEL) {
-        		giu_set(GIUINTTYPL, mask);
-			if (signal == IRQ_SIGNAL_HOLD)
-				giu_set(GIUINTHTSELL, mask);
-			else
-				giu_clear(GIUINTHTSELL, mask);
-			if (giu_flags & GPIO_HAS_INTERRUPT_EDGE_SELECT) {
-				switch (trigger) {
-				case IRQ_TRIGGER_EDGE_FALLING:
-					giu_set(GIUFEDGEINHL, mask);
-					giu_clear(GIUREDGEINHL, mask);
-					break;
-				case IRQ_TRIGGER_EDGE_RISING:
-					giu_clear(GIUFEDGEINHL, mask);
-					giu_set(GIUREDGEINHL, mask);
-					break;
-				default:
-					giu_set(GIUFEDGEINHL, mask);
-					giu_set(GIUREDGEINHL, mask);
-					break;
-				}
-			}
-			set_irq_chip_and_handler(GIU_IRQ(pin),
-			                         &giuint_low_irq_chip,
-			                         handle_edge_irq);
-		} else {
-			giu_clear(GIUINTTYPL, mask);
-			giu_clear(GIUINTHTSELL, mask);
-			set_irq_chip_and_handler(GIU_IRQ(pin),
-			                         &giuint_low_irq_chip,
-			                         handle_level_irq);
-		}
-		giu_write(GIUINTSTATL, mask);
-	} else if (pin < GIUINT_HIGH_MAX) {
-		mask = 1 << (pin - GIUINT_HIGH_OFFSET);
-		if (trigger != IRQ_TRIGGER_LEVEL) {
-			giu_set(GIUINTTYPH, mask);
-			if (signal == IRQ_SIGNAL_HOLD)
-				giu_set(GIUINTHTSELH, mask);
-			else
-				giu_clear(GIUINTHTSELH, mask);
-			if (giu_flags & GPIO_HAS_INTERRUPT_EDGE_SELECT) {
-				switch (trigger) {
-				case IRQ_TRIGGER_EDGE_FALLING:
-					giu_set(GIUFEDGEINHH, mask);
-					giu_clear(GIUREDGEINHH, mask);
-					break;
-				case IRQ_TRIGGER_EDGE_RISING:
-					giu_clear(GIUFEDGEINHH, mask);
-					giu_set(GIUREDGEINHH, mask);
-					break;
-				default:
-					giu_set(GIUFEDGEINHH, mask);
-					giu_set(GIUREDGEINHH, mask);
-					break;
-				}
-			}
-			set_irq_chip_and_handler(GIU_IRQ(pin),
-			                         &giuint_high_irq_chip,
-			                         handle_edge_irq);
-		} else {
-			giu_clear(GIUINTTYPH, mask);
-			giu_clear(GIUINTHTSELH, mask);
-			set_irq_chip_and_handler(GIU_IRQ(pin),
-			                         &giuint_high_irq_chip,
-			                         handle_level_irq);
-		}
-		giu_write(GIUINTSTATH, mask);
-	}
-}
-EXPORT_SYMBOL_GPL(vr41xx_set_irq_trigger);
-
-void vr41xx_set_irq_level(unsigned int pin, irq_level_t level)
-{
-	uint16_t mask;
-
-	if (pin < GIUINT_HIGH_OFFSET) {
-		mask = 1 << pin;
-		if (level == IRQ_LEVEL_HIGH)
-			giu_set(GIUINTALSELL, mask);
-		else
-			giu_clear(GIUINTALSELL, mask);
-		giu_write(GIUINTSTATL, mask);
-	} else if (pin < GIUINT_HIGH_MAX) {
-		mask = 1 << (pin - GIUINT_HIGH_OFFSET);
-		if (level == IRQ_LEVEL_HIGH)
-			giu_set(GIUINTALSELH, mask);
-		else
-			giu_clear(GIUINTALSELH, mask);
-		giu_write(GIUINTSTATH, mask);
-	}
-}
-EXPORT_SYMBOL_GPL(vr41xx_set_irq_level);
-
-gpio_data_t vr41xx_gpio_get_pin(unsigned int pin)
-{
-	uint16_t reg, mask;
-
-	if (pin >= giu_nr_pins)
-		return GPIO_DATA_INVAL;
-
-	if (pin < 16) {
-		reg = giu_read(GIUPIODL);
-		mask = (uint16_t)1 << pin;
-	} else if (pin < 32) {
-		reg = giu_read(GIUPIODH);
-		mask = (uint16_t)1 << (pin - 16);
-	} else if (pin < 48) {
-		reg = giu_read(GIUPODATL);
-		mask = (uint16_t)1 << (pin - 32);
-	} else {
-		reg = giu_read(GIUPODATH);
-		mask = (uint16_t)1 << (pin - 48);
-	}
-
-	if (reg & mask)
-		return GPIO_DATA_HIGH;
-
-	return GPIO_DATA_LOW;
-}
-EXPORT_SYMBOL_GPL(vr41xx_gpio_get_pin);
-
-int vr41xx_gpio_set_pin(unsigned int pin, gpio_data_t data)
-{
-	uint16_t offset, mask, reg;
-	unsigned long flags;
-
-	if (pin >= giu_nr_pins)
-		return -EINVAL;
-
-	if (pin < 16) {
-		offset = GIUPIODL;
-		mask = (uint16_t)1 << pin;
-	} else if (pin < 32) {
-		offset = GIUPIODH;
-		mask = (uint16_t)1 << (pin - 16);
-	} else if (pin < 48) {
-		offset = GIUPODATL;
-		mask = (uint16_t)1 << (pin - 32);
-	} else {
-		offset = GIUPODATH;
-		mask = (uint16_t)1 << (pin - 48);
-	}
-
-	spin_lock_irqsave(&giu_lock, flags);
-
-	reg = giu_read(offset);
-	if (data == GPIO_DATA_HIGH)
-		reg |= mask;
-	else
-		reg &= ~mask;
-	giu_write(offset, reg);
-
-	spin_unlock_irqrestore(&giu_lock, flags);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(vr41xx_gpio_set_pin);
-
-int vr41xx_gpio_set_direction(unsigned int pin, gpio_direction_t dir)
-{
-	uint16_t offset, mask, reg;
-	unsigned long flags;
-
-	if (pin >= giu_nr_pins)
-		return -EINVAL;
-
-	if (pin < 16) {
-		offset = GIUIOSELL;
-		mask = (uint16_t)1 << pin;
-	} else if (pin < 32) {
-		offset = GIUIOSELH;
-		mask = (uint16_t)1 << (pin - 16);
-	} else {
-		if (giu_flags & GPIO_HAS_OUTPUT_ENABLE) {
-			offset = GIUPODATEN;
-			mask = (uint16_t)1 << (pin - 32);
-		} else {
-			switch (pin) {
-			case 48:
-				offset = GIUPODATH;
-				mask = PIOEN0;
-				break;
-			case 49:
-				offset = GIUPODATH;
-				mask = PIOEN1;
-				break;
-			default:
-				return -EINVAL;
-			}
-		}
-	}
-
-	spin_lock_irqsave(&giu_lock, flags);
-
-	reg = giu_read(offset);
-	if (dir == GPIO_OUTPUT)
-		reg |= mask;
-	else
-		reg &= ~mask;
-	giu_write(offset, reg);
-
-	spin_unlock_irqrestore(&giu_lock, flags);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(vr41xx_gpio_set_direction);
-
-int vr41xx_gpio_pullupdown(unsigned int pin, gpio_pull_t pull)
-{
-	uint16_t reg, mask;
-	unsigned long flags;
-
-	if ((giu_flags & GPIO_HAS_PULLUPDOWN_IO) != GPIO_HAS_PULLUPDOWN_IO)
-		return -EPERM;
-
-	if (pin >= 15)
-		return -EINVAL;
-
-	mask = (uint16_t)1 << pin;
-
-	spin_lock_irqsave(&giu_lock, flags);
-
-	if (pull == GPIO_PULL_UP || pull == GPIO_PULL_DOWN) {
-		reg = giu_read(GIUTERMUPDN);
-		if (pull == GPIO_PULL_UP)
-			reg |= mask;
-		else
-			reg &= ~mask;
-		giu_write(GIUTERMUPDN, reg);
-
-		reg = giu_read(GIUUSEUPDN);
-		reg |= mask;
-		giu_write(GIUUSEUPDN, reg);
-	} else {
-		reg = giu_read(GIUUSEUPDN);
-		reg &= ~mask;
-		giu_write(GIUUSEUPDN, reg);
-	}
-
-	spin_unlock_irqrestore(&giu_lock, flags);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(vr41xx_gpio_pullupdown);
-
-static ssize_t gpio_read(struct file *file, char __user *buf, size_t len,
-                         loff_t *ppos)
-{
-	unsigned int pin;
-	char value = '0';
-
-	pin = iminor(file->f_path.dentry->d_inode);
-	if (pin >= giu_nr_pins)
-		return -EBADF;
-
-	if (vr41xx_gpio_get_pin(pin) == GPIO_DATA_HIGH)
-		value = '1';
-
-	if (len <= 0)
-		return -EFAULT;
-
-	if (put_user(value, buf))
-		return -EFAULT;
-
-	return 1;
-}
-
-static ssize_t gpio_write(struct file *file, const char __user *data,
-                          size_t len, loff_t *ppos)
-{
-	unsigned int pin;
-	size_t i;
-	char c;
-	int retval = 0;
-
-	pin = iminor(file->f_path.dentry->d_inode);
-	if (pin >= giu_nr_pins)
-		return -EBADF;
-
-	for (i = 0; i < len; i++) {
-		if (get_user(c, data + i))
-			return -EFAULT;
-
-		switch (c) {
-		case '0':
-			retval = vr41xx_gpio_set_pin(pin, GPIO_DATA_LOW);
-			break;
-		case '1':
-			retval = vr41xx_gpio_set_pin(pin, GPIO_DATA_HIGH);
-			break;
-		case 'D':
-			printk(KERN_INFO "GPIO%d: pull down\n", pin);
-			retval = vr41xx_gpio_pullupdown(pin, GPIO_PULL_DOWN);
-			break;
-		case 'd':
-			printk(KERN_INFO "GPIO%d: pull up/down disable\n", pin);
-			retval = vr41xx_gpio_pullupdown(pin, GPIO_PULL_DISABLE);
-			break;
-		case 'I':
-			printk(KERN_INFO "GPIO%d: input\n", pin);
-			retval = vr41xx_gpio_set_direction(pin, GPIO_INPUT);
-			break;
-		case 'O':
-			printk(KERN_INFO "GPIO%d: output\n", pin);
-			retval = vr41xx_gpio_set_direction(pin, GPIO_OUTPUT);
-			break;
-		case 'o':
-			printk(KERN_INFO "GPIO%d: output disable\n", pin);
-			retval = vr41xx_gpio_set_direction(pin, GPIO_OUTPUT_DISABLE);
-			break;
-		case 'P':
-			printk(KERN_INFO "GPIO%d: pull up\n", pin);
-			retval = vr41xx_gpio_pullupdown(pin, GPIO_PULL_UP);
-			break;
-		case 'p':
-			printk(KERN_INFO "GPIO%d: pull up/down disable\n", pin);
-			retval = vr41xx_gpio_pullupdown(pin, GPIO_PULL_DISABLE);
-			break;
-		default:
-			break;
-		}
-
-		if (retval < 0)
-			break;
-	}
-
-	return i;
-}
-
-static int gpio_open(struct inode *inode, struct file *file)
-{
-	unsigned int pin;
-
-	cycle_kernel_lock();
-	pin = iminor(inode);
-	if (pin >= giu_nr_pins)
-		return -EBADF;
-
-	return nonseekable_open(inode, file);
-}
-
-static int gpio_release(struct inode *inode, struct file *file)
-{
-	unsigned int pin;
-
-	pin = iminor(inode);
-	if (pin >= giu_nr_pins)
-		return -EBADF;
-
-	return 0;
-}
-
-static const struct file_operations gpio_fops = {
-	.owner		= THIS_MODULE,
-	.read		= gpio_read,
-	.write		= gpio_write,
-	.open		= gpio_open,
-	.release	= gpio_release,
-};
-
-static int __devinit giu_probe(struct platform_device *dev)
-{
-	struct resource *res;
-	unsigned int trigger, i, pin;
-	struct irq_chip *chip;
-	int irq, retval;
-
-	switch (dev->id) {
-	case GPIO_50PINS_PULLUPDOWN:
-		giu_flags = GPIO_HAS_PULLUPDOWN_IO;
-		giu_nr_pins = 50;
-		break;
-	case GPIO_36PINS:
-		giu_nr_pins = 36;
-		break;
-	case GPIO_48PINS_EDGE_SELECT:
-		giu_flags = GPIO_HAS_INTERRUPT_EDGE_SELECT;
-		giu_nr_pins = 48;
-		break;
-	default:
-		printk(KERN_ERR "GIU: unknown ID %d\n", dev->id);
-		return -ENODEV;
-	}
-
-	res = platform_get_resource(dev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -EBUSY;
-
-	giu_base = ioremap(res->start, res->end - res->start + 1);
-	if (!giu_base)
-		return -ENOMEM;
-
-	retval = register_chrdev(major, "GIU", &gpio_fops);
-	if (retval < 0) {
-		iounmap(giu_base);
-		giu_base = NULL;
-		return retval;
-	}
-
-	if (major == 0) {
-		major = retval;
-		printk(KERN_INFO "GIU: major number %d\n", major);
-	}
-
-	spin_lock_init(&giu_lock);
-
-	giu_write(GIUINTENL, 0);
-	giu_write(GIUINTENH, 0);
-
-	trigger = giu_read(GIUINTTYPH) << 16;
-	trigger |= giu_read(GIUINTTYPL);
-	for (i = GIU_IRQ_BASE; i <= GIU_IRQ_LAST; i++) {
-		pin = GPIO_PIN_OF_IRQ(i);
-		if (pin < GIUINT_HIGH_OFFSET)
-			chip = &giuint_low_irq_chip;
-		else
-			chip = &giuint_high_irq_chip;
-
-		if (trigger & (1 << pin))
-			set_irq_chip_and_handler(i, chip, handle_edge_irq);
-		else
-			set_irq_chip_and_handler(i, chip, handle_level_irq);
-
-	}
-
-	irq = platform_get_irq(dev, 0);
-	if (irq < 0 || irq >= nr_irqs)
-		return -EBUSY;
-
-	return cascade_irq(irq, giu_get_irq);
-}
-
-static int __devexit giu_remove(struct platform_device *dev)
-{
-	if (giu_base) {
-		iounmap(giu_base);
-		giu_base = NULL;
-	}
-
-	return 0;
-}
-
-static struct platform_driver giu_device_driver = {
-	.probe		= giu_probe,
-	.remove		= __devexit_p(giu_remove),
-	.driver		= {
-		.name	= "GIU",
-		.owner	= THIS_MODULE,
-	},
-};
-
-static int __init vr41xx_giu_init(void)
-{
-	return platform_driver_register(&giu_device_driver);
-}
-
-static void __exit vr41xx_giu_exit(void)
-{
-	platform_driver_unregister(&giu_device_driver);
-}
-
-module_init(vr41xx_giu_init);
-module_exit(vr41xx_giu_exit);
diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/drivers/gpio/Kconfig linux/drivers/gpio/Kconfig
--- linux-orig/drivers/gpio/Kconfig	2009-06-29 10:06:58.481177708 +0900
+++ linux/drivers/gpio/Kconfig	2009-06-29 10:08:25.905177556 +0900
@@ -79,6 +79,12 @@ config GPIO_XILINX
 	help
 	  Say yes here to support the Xilinx FPGA GPIO device
 
+config GPIO_VR41XX
+	tristate "NEC VR4100 series General-purpose I/O Uint support"
+	depends on CPU_VR41XX
+	help
+	  Say yes here to support the NEC VR4100 series General-purpose I/O Uint
+
 comment "I2C GPIO expanders:"
 
 config GPIO_MAX732X
diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/drivers/gpio/Makefile linux/drivers/gpio/Makefile
--- linux-orig/drivers/gpio/Makefile	2009-06-29 10:06:58.481177708 +0900
+++ linux/drivers/gpio/Makefile	2009-06-29 10:08:30.097177560 +0900
@@ -13,3 +13,4 @@ obj-$(CONFIG_GPIO_PL061)	+= pl061.o
 obj-$(CONFIG_GPIO_TWL4030)	+= twl4030-gpio.o
 obj-$(CONFIG_GPIO_XILINX)	+= xilinx_gpio.o
 obj-$(CONFIG_GPIO_BT8XX)	+= bt8xxgpio.o
+obj-$(CONFIG_GPIO_VR41XX)	+= vr41xx_giu.o
diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/drivers/gpio/vr41xx_giu.c linux/drivers/gpio/vr41xx_giu.c
--- linux-orig/drivers/gpio/vr41xx_giu.c	1970-01-01 09:00:00.000000000 +0900
+++ linux/drivers/gpio/vr41xx_giu.c	2009-06-29 10:14:11.961177585 +0900
@@ -0,0 +1,586 @@
+/*
+ *  Driver for NEC VR4100 series General-purpose I/O Unit.
+ *
+ *  Copyright (C) 2002 MontaVista Software Inc.
+ *	Author: Yoichi Yuasa <yyuasa@mvista.com or source@mvista.com>
+ *  Copyright (C) 2003-2009  Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
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
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+#include <linux/errno.h>
+#include <linux/fs.h>
+#include <linux/gpio.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/smp_lock.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+
+#include <asm/io.h>
+#include <asm/vr41xx/giu.h>
+#include <asm/vr41xx/irq.h>
+#include <asm/vr41xx/vr41xx.h>
+
+MODULE_AUTHOR("Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>");
+MODULE_DESCRIPTION("NEC VR4100 series General-purpose I/O Unit driver");
+MODULE_LICENSE("GPL");
+
+#define GIUIOSELL	0x00
+#define GIUIOSELH	0x02
+#define GIUPIODL	0x04
+#define GIUPIODH	0x06
+#define GIUINTSTATL	0x08
+#define GIUINTSTATH	0x0a
+#define GIUINTENL	0x0c
+#define GIUINTENH	0x0e
+#define GIUINTTYPL	0x10
+#define GIUINTTYPH	0x12
+#define GIUINTALSELL	0x14
+#define GIUINTALSELH	0x16
+#define GIUINTHTSELL	0x18
+#define GIUINTHTSELH	0x1a
+#define GIUPODATL	0x1c
+#define GIUPODATEN	0x1c
+#define GIUPODATH	0x1e
+ #define PIOEN0		0x0100
+ #define PIOEN1		0x0200
+#define GIUPODAT	0x1e
+#define GIUFEDGEINHL	0x20
+#define GIUFEDGEINHH	0x22
+#define GIUREDGEINHL	0x24
+#define GIUREDGEINHH	0x26
+
+#define GIUUSEUPDN	0x1e0
+#define GIUTERMUPDN	0x1e2
+
+#define GPIO_HAS_PULLUPDOWN_IO		0x0001
+#define GPIO_HAS_OUTPUT_ENABLE		0x0002
+#define GPIO_HAS_INTERRUPT_EDGE_SELECT	0x0100
+
+enum {
+	GPIO_INPUT,
+	GPIO_OUTPUT,
+};
+
+static DEFINE_SPINLOCK(giu_lock);
+static unsigned long giu_flags;
+
+static void __iomem *giu_base;
+
+#define giu_read(offset)		readw(giu_base + (offset))
+#define giu_write(offset, value)	writew((value), giu_base + (offset))
+
+#define GPIO_PIN_OF_IRQ(irq)	((irq) - GIU_IRQ_BASE)
+#define GIUINT_HIGH_OFFSET	16
+#define GIUINT_HIGH_MAX		32
+
+static inline u16 giu_set(u16 offset, u16 set)
+{
+	u16 data;
+
+	data = giu_read(offset);
+	data |= set;
+	giu_write(offset, data);
+
+	return data;
+}
+
+static inline u16 giu_clear(u16 offset, u16 clear)
+{
+	u16 data;
+
+	data = giu_read(offset);
+	data &= ~clear;
+	giu_write(offset, data);
+
+	return data;
+}
+
+static void ack_giuint_low(unsigned int irq)
+{
+	giu_write(GIUINTSTATL, 1 << GPIO_PIN_OF_IRQ(irq));
+}
+
+static void mask_giuint_low(unsigned int irq)
+{
+	giu_clear(GIUINTENL, 1 << GPIO_PIN_OF_IRQ(irq));
+}
+
+static void mask_ack_giuint_low(unsigned int irq)
+{
+	unsigned int pin;
+
+	pin = GPIO_PIN_OF_IRQ(irq);
+	giu_clear(GIUINTENL, 1 << pin);
+	giu_write(GIUINTSTATL, 1 << pin);
+}
+
+static void unmask_giuint_low(unsigned int irq)
+{
+	giu_set(GIUINTENL, 1 << GPIO_PIN_OF_IRQ(irq));
+}
+
+static struct irq_chip giuint_low_irq_chip = {
+	.name		= "GIUINTL",
+	.ack		= ack_giuint_low,
+	.mask		= mask_giuint_low,
+	.mask_ack	= mask_ack_giuint_low,
+	.unmask		= unmask_giuint_low,
+};
+
+static void ack_giuint_high(unsigned int irq)
+{
+	giu_write(GIUINTSTATH,
+		  1 << (GPIO_PIN_OF_IRQ(irq) - GIUINT_HIGH_OFFSET));
+}
+
+static void mask_giuint_high(unsigned int irq)
+{
+	giu_clear(GIUINTENH, 1 << (GPIO_PIN_OF_IRQ(irq) - GIUINT_HIGH_OFFSET));
+}
+
+static void mask_ack_giuint_high(unsigned int irq)
+{
+	unsigned int pin;
+
+	pin = GPIO_PIN_OF_IRQ(irq) - GIUINT_HIGH_OFFSET;
+	giu_clear(GIUINTENH, 1 << pin);
+	giu_write(GIUINTSTATH, 1 << pin);
+}
+
+static void unmask_giuint_high(unsigned int irq)
+{
+	giu_set(GIUINTENH, 1 << (GPIO_PIN_OF_IRQ(irq) - GIUINT_HIGH_OFFSET));
+}
+
+static struct irq_chip giuint_high_irq_chip = {
+	.name		= "GIUINTH",
+	.ack		= ack_giuint_high,
+	.mask		= mask_giuint_high,
+	.mask_ack	= mask_ack_giuint_high,
+	.unmask		= unmask_giuint_high,
+};
+
+static int giu_get_irq(unsigned int irq)
+{
+	u16 pendl, pendh, maskl, maskh;
+	int i;
+
+	pendl = giu_read(GIUINTSTATL);
+	pendh = giu_read(GIUINTSTATH);
+	maskl = giu_read(GIUINTENL);
+	maskh = giu_read(GIUINTENH);
+
+	maskl &= pendl;
+	maskh &= pendh;
+
+	if (maskl) {
+		for (i = 0; i < 16; i++) {
+			if (maskl & (1 << i))
+				return GIU_IRQ(i);
+		}
+	} else if (maskh) {
+		for (i = 0; i < 16; i++) {
+			if (maskh & (1 << i))
+				return GIU_IRQ(i + GIUINT_HIGH_OFFSET);
+		}
+	}
+
+	printk(KERN_ERR "spurious GIU interrupt: %04x(%04x),%04x(%04x)\n",
+	       maskl, pendl, maskh, pendh);
+
+	atomic_inc(&irq_err_count);
+
+	return -EINVAL;
+}
+
+void vr41xx_set_irq_trigger(unsigned int pin, irq_trigger_t trigger,
+			    irq_signal_t signal)
+{
+	u16 mask;
+
+	if (pin < GIUINT_HIGH_OFFSET) {
+		mask = 1 << pin;
+		if (trigger != IRQ_TRIGGER_LEVEL) {
+			giu_set(GIUINTTYPL, mask);
+			if (signal == IRQ_SIGNAL_HOLD)
+				giu_set(GIUINTHTSELL, mask);
+			else
+				giu_clear(GIUINTHTSELL, mask);
+			if (giu_flags & GPIO_HAS_INTERRUPT_EDGE_SELECT) {
+				switch (trigger) {
+				case IRQ_TRIGGER_EDGE_FALLING:
+					giu_set(GIUFEDGEINHL, mask);
+					giu_clear(GIUREDGEINHL, mask);
+					break;
+				case IRQ_TRIGGER_EDGE_RISING:
+					giu_clear(GIUFEDGEINHL, mask);
+					giu_set(GIUREDGEINHL, mask);
+					break;
+				default:
+					giu_set(GIUFEDGEINHL, mask);
+					giu_set(GIUREDGEINHL, mask);
+					break;
+				}
+			}
+			set_irq_chip_and_handler(GIU_IRQ(pin),
+						 &giuint_low_irq_chip,
+						 handle_edge_irq);
+		} else {
+			giu_clear(GIUINTTYPL, mask);
+			giu_clear(GIUINTHTSELL, mask);
+			set_irq_chip_and_handler(GIU_IRQ(pin),
+						 &giuint_low_irq_chip,
+						 handle_level_irq);
+		}
+		giu_write(GIUINTSTATL, mask);
+	} else if (pin < GIUINT_HIGH_MAX) {
+		mask = 1 << (pin - GIUINT_HIGH_OFFSET);
+		if (trigger != IRQ_TRIGGER_LEVEL) {
+			giu_set(GIUINTTYPH, mask);
+			if (signal == IRQ_SIGNAL_HOLD)
+				giu_set(GIUINTHTSELH, mask);
+			else
+				giu_clear(GIUINTHTSELH, mask);
+			if (giu_flags & GPIO_HAS_INTERRUPT_EDGE_SELECT) {
+				switch (trigger) {
+				case IRQ_TRIGGER_EDGE_FALLING:
+					giu_set(GIUFEDGEINHH, mask);
+					giu_clear(GIUREDGEINHH, mask);
+					break;
+				case IRQ_TRIGGER_EDGE_RISING:
+					giu_clear(GIUFEDGEINHH, mask);
+					giu_set(GIUREDGEINHH, mask);
+					break;
+				default:
+					giu_set(GIUFEDGEINHH, mask);
+					giu_set(GIUREDGEINHH, mask);
+					break;
+				}
+			}
+			set_irq_chip_and_handler(GIU_IRQ(pin),
+						 &giuint_high_irq_chip,
+						 handle_edge_irq);
+		} else {
+			giu_clear(GIUINTTYPH, mask);
+			giu_clear(GIUINTHTSELH, mask);
+			set_irq_chip_and_handler(GIU_IRQ(pin),
+						 &giuint_high_irq_chip,
+						 handle_level_irq);
+		}
+		giu_write(GIUINTSTATH, mask);
+	}
+}
+EXPORT_SYMBOL_GPL(vr41xx_set_irq_trigger);
+
+void vr41xx_set_irq_level(unsigned int pin, irq_level_t level)
+{
+	u16 mask;
+
+	if (pin < GIUINT_HIGH_OFFSET) {
+		mask = 1 << pin;
+		if (level == IRQ_LEVEL_HIGH)
+			giu_set(GIUINTALSELL, mask);
+		else
+			giu_clear(GIUINTALSELL, mask);
+		giu_write(GIUINTSTATL, mask);
+	} else if (pin < GIUINT_HIGH_MAX) {
+		mask = 1 << (pin - GIUINT_HIGH_OFFSET);
+		if (level == IRQ_LEVEL_HIGH)
+			giu_set(GIUINTALSELH, mask);
+		else
+			giu_clear(GIUINTALSELH, mask);
+		giu_write(GIUINTSTATH, mask);
+	}
+}
+EXPORT_SYMBOL_GPL(vr41xx_set_irq_level);
+
+static int giu_set_direction(struct gpio_chip *chip, unsigned pin, int dir)
+{
+	u16 offset, mask, reg;
+	unsigned long flags;
+
+	if (pin >= chip->ngpio)
+		return -EINVAL;
+
+	if (pin < 16) {
+		offset = GIUIOSELL;
+		mask = 1 << pin;
+	} else if (pin < 32) {
+		offset = GIUIOSELH;
+		mask = 1 << (pin - 16);
+	} else {
+		if (giu_flags & GPIO_HAS_OUTPUT_ENABLE) {
+			offset = GIUPODATEN;
+			mask = 1 << (pin - 32);
+		} else {
+			switch (pin) {
+			case 48:
+				offset = GIUPODATH;
+				mask = PIOEN0;
+				break;
+			case 49:
+				offset = GIUPODATH;
+				mask = PIOEN1;
+				break;
+			default:
+				return -EINVAL;
+			}
+		}
+	}
+
+	spin_lock_irqsave(&giu_lock, flags);
+
+	reg = giu_read(offset);
+	if (dir == GPIO_OUTPUT)
+		reg |= mask;
+	else
+		reg &= ~mask;
+	giu_write(offset, reg);
+
+	spin_unlock_irqrestore(&giu_lock, flags);
+
+	return 0;
+}
+
+int vr41xx_gpio_pullupdown(unsigned int pin, gpio_pull_t pull)
+{
+	u16 reg, mask;
+	unsigned long flags;
+
+	if ((giu_flags & GPIO_HAS_PULLUPDOWN_IO) != GPIO_HAS_PULLUPDOWN_IO)
+		return -EPERM;
+
+	if (pin >= 15)
+		return -EINVAL;
+
+	mask = 1 << pin;
+
+	spin_lock_irqsave(&giu_lock, flags);
+
+	if (pull == GPIO_PULL_UP || pull == GPIO_PULL_DOWN) {
+		reg = giu_read(GIUTERMUPDN);
+		if (pull == GPIO_PULL_UP)
+			reg |= mask;
+		else
+			reg &= ~mask;
+		giu_write(GIUTERMUPDN, reg);
+
+		reg = giu_read(GIUUSEUPDN);
+		reg |= mask;
+		giu_write(GIUUSEUPDN, reg);
+	} else {
+		reg = giu_read(GIUUSEUPDN);
+		reg &= ~mask;
+		giu_write(GIUUSEUPDN, reg);
+	}
+
+	spin_unlock_irqrestore(&giu_lock, flags);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(vr41xx_gpio_pullupdown);
+
+static int vr41xx_gpio_get(struct gpio_chip *chip, unsigned pin)
+{
+	u16 reg, mask;
+
+	if (pin >= chip->ngpio)
+		return -EINVAL;
+
+	if (pin < 16) {
+		reg = giu_read(GIUPIODL);
+		mask = 1 << pin;
+	} else if (pin < 32) {
+		reg = giu_read(GIUPIODH);
+		mask = 1 << (pin - 16);
+	} else if (pin < 48) {
+		reg = giu_read(GIUPODATL);
+		mask = 1 << (pin - 32);
+	} else {
+		reg = giu_read(GIUPODATH);
+		mask = 1 << (pin - 48);
+	}
+
+	if (reg & mask)
+		return 1;
+
+	return 0;
+}
+
+static void vr41xx_gpio_set(struct gpio_chip *chip, unsigned pin,
+			    int value)
+{
+	u16 offset, mask, reg;
+	unsigned long flags;
+
+	if (pin >= chip->ngpio)
+		return;
+
+	if (pin < 16) {
+		offset = GIUPIODL;
+		mask = 1 << pin;
+	} else if (pin < 32) {
+		offset = GIUPIODH;
+		mask = 1 << (pin - 16);
+	} else if (pin < 48) {
+		offset = GIUPODATL;
+		mask = 1 << (pin - 32);
+	} else {
+		offset = GIUPODATH;
+		mask = 1 << (pin - 48);
+	}
+
+	spin_lock_irqsave(&giu_lock, flags);
+
+	reg = giu_read(offset);
+	if (value)
+		reg |= mask;
+	else
+		reg &= ~mask;
+	giu_write(offset, reg);
+
+	spin_unlock_irqrestore(&giu_lock, flags);
+}
+
+
+static int vr41xx_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
+{
+	return giu_set_direction(chip, offset, GPIO_INPUT);
+}
+
+static int vr41xx_gpio_direction_output(struct gpio_chip *chip, unsigned offset,
+				int value)
+{
+	vr41xx_gpio_set(chip, offset, value);
+
+	return giu_set_direction(chip, offset, GPIO_OUTPUT);
+}
+
+static int vr41xx_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
+{
+	if (offset >= chip->ngpio)
+		return -EINVAL;
+
+	return GIU_IRQ_BASE + offset;
+}
+
+static struct gpio_chip vr41xx_gpio_chip = {
+	.label			= "vr41xx",
+	.owner			= THIS_MODULE,
+	.direction_input	= vr41xx_gpio_direction_input,
+	.get			= vr41xx_gpio_get,
+	.direction_output	= vr41xx_gpio_direction_output,
+	.set			= vr41xx_gpio_set,
+	.to_irq			= vr41xx_gpio_to_irq,
+};
+
+static int __devinit giu_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+	unsigned int trigger, i, pin;
+	struct irq_chip *chip;
+	int irq, retval;
+
+	switch (pdev->id) {
+	case GPIO_50PINS_PULLUPDOWN:
+		giu_flags = GPIO_HAS_PULLUPDOWN_IO;
+		vr41xx_gpio_chip.ngpio = 50;
+		break;
+	case GPIO_36PINS:
+		vr41xx_gpio_chip.ngpio = 36;
+		break;
+	case GPIO_48PINS_EDGE_SELECT:
+		giu_flags = GPIO_HAS_INTERRUPT_EDGE_SELECT;
+		vr41xx_gpio_chip.ngpio = 48;
+		break;
+	default:
+		dev_err(&pdev->dev, "GIU: unknown ID %d\n", pdev->id);
+		return -ENODEV;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -EBUSY;
+
+	giu_base = ioremap(res->start, res->end - res->start + 1);
+	if (!giu_base)
+		return -ENOMEM;
+
+	vr41xx_gpio_chip.dev = &pdev->dev;
+
+	retval = gpiochip_add(&vr41xx_gpio_chip);
+
+	giu_write(GIUINTENL, 0);
+	giu_write(GIUINTENH, 0);
+
+	trigger = giu_read(GIUINTTYPH) << 16;
+	trigger |= giu_read(GIUINTTYPL);
+	for (i = GIU_IRQ_BASE; i <= GIU_IRQ_LAST; i++) {
+		pin = GPIO_PIN_OF_IRQ(i);
+		if (pin < GIUINT_HIGH_OFFSET)
+			chip = &giuint_low_irq_chip;
+		else
+			chip = &giuint_high_irq_chip;
+
+		if (trigger & (1 << pin))
+			set_irq_chip_and_handler(i, chip, handle_edge_irq);
+		else
+			set_irq_chip_and_handler(i, chip, handle_level_irq);
+
+	}
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0 || irq >= nr_irqs)
+		return -EBUSY;
+
+	return cascade_irq(irq, giu_get_irq);
+}
+
+static int __devexit giu_remove(struct platform_device *pdev)
+{
+	if (giu_base) {
+		iounmap(giu_base);
+		giu_base = NULL;
+	}
+
+	return 0;
+}
+
+static struct platform_driver giu_device_driver = {
+	.probe		= giu_probe,
+	.remove		= __devexit_p(giu_remove),
+	.driver		= {
+		.name	= "GIU",
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int __init vr41xx_giu_init(void)
+{
+	return platform_driver_register(&giu_device_driver);
+}
+
+static void __exit vr41xx_giu_exit(void)
+{
+	platform_driver_unregister(&giu_device_driver);
+}
+
+module_init(vr41xx_giu_init);
+module_exit(vr41xx_giu_exit);
