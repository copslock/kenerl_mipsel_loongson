Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jul 2005 16:18:56 +0100 (BST)
Received: from mo01.iij4u.or.jp ([IPv6:::ffff:210.130.0.20]:21744 "EHLO
	mo01.iij4u.or.jp") by linux-mips.org with ESMTP id <S8226727AbVGOPSj>;
	Fri, 15 Jul 2005 16:18:39 +0100
Received: MO(mo01)id j6FFJuoL000447; Sat, 16 Jul 2005 00:19:56 +0900 (JST)
Received: MDO(mdo00) id j6FFJugF010902; Sat, 16 Jul 2005 00:19:56 +0900 (JST)
Received: from stratos (h086.p498.iij4u.or.jp [210.149.242.86])
	by mbox.iij4u.or.jp (4U-MR/mbox01) id j6FFJtKQ013579
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NOT);
	Sat, 16 Jul 2005 00:19:55 +0900 (JST)
Date:	Sat, 16 Jul 2005 00:19:53 +0900
From:	Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yuasa@hh.iij4u.or.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 2.6] vr41xx: remove obsolete GIU driver
Message-Id: <20050716001953.7c5e7568.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8503
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has removed obsolete GIU driver for vr41xx.
Please apply this patch.

Yoichi

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff a-orig/arch/mips/vr41xx/Kconfig a/arch/mips/vr41xx/Kconfig
--- a-orig/arch/mips/vr41xx/Kconfig	2005-07-12 01:04:41.874172000 +0900
+++ a/arch/mips/vr41xx/Kconfig	2005-07-15 00:54:46.087700888 +0900
@@ -90,10 +90,6 @@
 	bool "Add PCI control unit support of NEC VR4100 series"
 	depends on MACH_VR41XX && PCI
 
-config GPIO_VR41XX
-	tristate "Add General-purpose I/O unit support of NEC VR4100 series"
-	depends on MACH_VR41XX
-
 config VRC4173
 	tristate "Add NEC VRC4173 companion chip support"
 	depends on MACH_VR41XX && PCI_VR41XX
diff -urN -X dontdiff a-orig/arch/mips/vr41xx/common/Makefile a/arch/mips/vr41xx/common/Makefile
--- a-orig/arch/mips/vr41xx/common/Makefile	2005-06-02 23:33:02.000000000 +0900
+++ a/arch/mips/vr41xx/common/Makefile	2005-07-15 00:54:10.118169088 +0900
@@ -3,7 +3,6 @@
 #
 
 obj-y				+= bcu.o cmu.o icu.o init.o int-handler.o irq.o pmu.o
-obj-$(CONFIG_GPIO_VR41XX)	+= giu.o
 obj-$(CONFIG_VRC4173)		+= vrc4173.o
 
 EXTRA_AFLAGS := $(CFLAGS)
diff -urN -X dontdiff a-orig/arch/mips/vr41xx/common/giu.c a/arch/mips/vr41xx/common/giu.c
--- a-orig/arch/mips/vr41xx/common/giu.c	2005-06-02 23:33:02.000000000 +0900
+++ a/arch/mips/vr41xx/common/giu.c	1970-01-01 09:00:00.000000000 +0900
@@ -1,363 +0,0 @@
-/*
- *  giu.c, General-purpose I/O Unit Interrupt routines for NEC VR4100 series.
- *
- *  Copyright (C) 2002 MontaVista Software Inc.
- *    Author: Yoichi Yuasa <yyuasa@mvista.com or source@mvista.com>
- *  Copyright (C) 2003-2005  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
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
-/*
- * Changes:
- *  MontaVista Software Inc. <yyuasa@mvista.com> or <source@mvista.com>
- *  - New creation, NEC VR4111, VR4121, VR4122 and VR4131 are supported.
- *
- *  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
- *  - Added support for NEC VR4133.
- *  - Removed board_irq_init.
- */
-#include <linux/errno.h>
-#include <linux/init.h>
-#include <linux/irq.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/smp.h>
-#include <linux/types.h>
-
-#include <asm/cpu.h>
-#include <asm/io.h>
-#include <asm/vr41xx/vr41xx.h>
-
-#define GIUIOSELL_TYPE1	KSEG1ADDR(0x0b000100)
-#define GIUIOSELL_TYPE2	KSEG1ADDR(0x0f000140)
-
-#define GIUIOSELL	0x00
-#define GIUIOSELH	0x02
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
-#define GIUFEDGEINHL	0x20
-#define GIUFEDGEINHH	0x22
-#define GIUREDGEINHL	0x24
-#define GIUREDGEINHH	0x26
-
-static uint32_t giu_base;
-
-#define read_giuint(offset)		readw(giu_base + (offset))
-#define write_giuint(val, offset)	writew((val), giu_base + (offset))
-
-#define GIUINT_HIGH_OFFSET	16
-
-static inline uint16_t set_giuint(uint8_t offset, uint16_t set)
-{
-	uint16_t res;
-
-	res = read_giuint(offset);
-	res |= set;
-	write_giuint(res, offset);
-
-	return res;
-}
-
-static inline uint16_t clear_giuint(uint8_t offset, uint16_t clear)
-{
-	uint16_t res;
-
-	res = read_giuint(offset);
-	res &= ~clear;
-	write_giuint(res, offset);
-
-	return res;
-}
-
-static unsigned int startup_giuint_low_irq(unsigned int irq)
-{
-	unsigned int pin;
-
-	pin = GIU_IRQ_TO_PIN(irq);
-	write_giuint((uint16_t)1 << pin, GIUINTSTATL);
-	set_giuint(GIUINTENL, (uint16_t)1 << pin);
-
-	return 0;
-}
-
-static void shutdown_giuint_low_irq(unsigned int irq)
-{
-	clear_giuint(GIUINTENL, (uint16_t)1 << GIU_IRQ_TO_PIN(irq));
-}
-
-static void enable_giuint_low_irq(unsigned int irq)
-{
-	set_giuint(GIUINTENL, (uint16_t)1 << GIU_IRQ_TO_PIN(irq));
-}
-
-#define disable_giuint_low_irq	shutdown_giuint_low_irq
-
-static void ack_giuint_low_irq(unsigned int irq)
-{
-	unsigned int pin;
-
-	pin = GIU_IRQ_TO_PIN(irq);
-	clear_giuint(GIUINTENL, (uint16_t)1 << pin);
-	write_giuint((uint16_t)1 << pin, GIUINTSTATL);
-}
-
-static void end_giuint_low_irq(unsigned int irq)
-{
-	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS)))
-		set_giuint(GIUINTENL, (uint16_t)1 << GIU_IRQ_TO_PIN(irq));
-}
-
-static struct hw_interrupt_type giuint_low_irq_type = {
-	.typename	= "GIUINTL",
-	.startup	= startup_giuint_low_irq,
-	.shutdown	= shutdown_giuint_low_irq,
-	.enable		= enable_giuint_low_irq,
-	.disable	= disable_giuint_low_irq,
-	.ack		= ack_giuint_low_irq,
-	.end		= end_giuint_low_irq,
-};
-
-static unsigned int startup_giuint_high_irq(unsigned int irq)
-{
-	unsigned int pin;
-
-	pin = GIU_IRQ_TO_PIN(irq - GIUINT_HIGH_OFFSET);
-	write_giuint((uint16_t)1 << pin, GIUINTSTATH);
-	set_giuint(GIUINTENH, (uint16_t)1 << pin);
-
-	return 0;
-}
-
-static void shutdown_giuint_high_irq(unsigned int irq)
-{
-	clear_giuint(GIUINTENH, (uint16_t)1 << GIU_IRQ_TO_PIN(irq - GIUINT_HIGH_OFFSET));
-}
-
-static void enable_giuint_high_irq(unsigned int irq)
-{
-	set_giuint(GIUINTENH, (uint16_t)1 << GIU_IRQ_TO_PIN(irq - GIUINT_HIGH_OFFSET));
-}
-
-#define disable_giuint_high_irq	shutdown_giuint_high_irq
-
-static void ack_giuint_high_irq(unsigned int irq)
-{
-	unsigned int pin;
-
-	pin = GIU_IRQ_TO_PIN(irq - GIUINT_HIGH_OFFSET);
-	clear_giuint(GIUINTENH, (uint16_t)1 << pin);
-	write_giuint((uint16_t)1 << pin, GIUINTSTATH);
-}
-
-static void end_giuint_high_irq(unsigned int irq)
-{
-	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS)))
-		set_giuint(GIUINTENH, (uint16_t)1 << GIU_IRQ_TO_PIN(irq - GIUINT_HIGH_OFFSET));
-}
-
-static struct hw_interrupt_type giuint_high_irq_type = {
-	.typename	= "GIUINTH",
-	.startup	= startup_giuint_high_irq,
-	.shutdown	= shutdown_giuint_high_irq,
-	.enable		= enable_giuint_high_irq,
-	.disable	= disable_giuint_high_irq,
-	.ack		= ack_giuint_high_irq,
-	.end		= end_giuint_high_irq,
-};
-
-void vr41xx_enable_giuint(unsigned int pin)
-{
-	if (pin < GIUINT_HIGH_OFFSET)
-		enable_giuint_low_irq(GIU_IRQ(pin));
-	else
-		enable_giuint_high_irq(GIU_IRQ(pin));
-}
-
-void vr41xx_disable_giuint(unsigned int pin)
-{
-	if (pin < GIUINT_HIGH_OFFSET)
-		disable_giuint_low_irq(GIU_IRQ(pin));
-	else
-		disable_giuint_high_irq(GIU_IRQ(pin));
-}
-
-void vr41xx_set_irq_trigger(int pin, int trigger, int hold)
-{
-	uint16_t mask;
-
-	if (pin < GIUINT_HIGH_OFFSET) {
-		mask = (uint16_t)1 << pin;
-		if (trigger != TRIGGER_LEVEL) {
-        		set_giuint(GIUINTTYPL, mask);
-			if (hold == SIGNAL_HOLD)
-				set_giuint(GIUINTHTSELL, mask);
-			else
-				clear_giuint(GIUINTHTSELL, mask);
-			if (current_cpu_data.cputype == CPU_VR4133) {
-				switch (trigger) {
-				case TRIGGER_EDGE_FALLING:
-					set_giuint(GIUFEDGEINHL, mask);
-					clear_giuint(GIUREDGEINHL, mask);
-					break;
-				case TRIGGER_EDGE_RISING:
-					clear_giuint(GIUFEDGEINHL, mask);
-					set_giuint(GIUREDGEINHL, mask);
-					break;
-				default:
-					set_giuint(GIUFEDGEINHL, mask);
-					set_giuint(GIUREDGEINHL, mask);
-					break;
-				}
-			}
-		} else {
-			clear_giuint(GIUINTTYPL, mask);
-			clear_giuint(GIUINTHTSELL, mask);
-		}
-		write_giuint(mask, GIUINTSTATL);
-	} else {
-		mask = (uint16_t)1 << (pin - GIUINT_HIGH_OFFSET);
-		if (trigger != TRIGGER_LEVEL) {
-			set_giuint(GIUINTTYPH, mask);
-			if (hold == SIGNAL_HOLD)
-				set_giuint(GIUINTHTSELH, mask);
-			else
-				clear_giuint(GIUINTHTSELH, mask);
-			if (current_cpu_data.cputype == CPU_VR4133) {
-				switch (trigger) {
-				case TRIGGER_EDGE_FALLING:
-					set_giuint(GIUFEDGEINHH, mask);
-					clear_giuint(GIUREDGEINHH, mask);
-					break;
-				case TRIGGER_EDGE_RISING:
-					clear_giuint(GIUFEDGEINHH, mask);
-					set_giuint(GIUREDGEINHH, mask);
-					break;
-				default:
-					set_giuint(GIUFEDGEINHH, mask);
-					set_giuint(GIUREDGEINHH, mask);
-					break;
-				}
-			}
-		} else {
-			clear_giuint(GIUINTTYPH, mask);
-			clear_giuint(GIUINTHTSELH, mask);
-		}
-		write_giuint(mask, GIUINTSTATH);
-	}
-}
-
-EXPORT_SYMBOL(vr41xx_set_irq_trigger);
-
-void vr41xx_set_irq_level(int pin, int level)
-{
-	uint16_t mask;
-
-	if (pin < GIUINT_HIGH_OFFSET) {
-		mask = (uint16_t)1 << pin;
-		if (level == LEVEL_HIGH)
-			set_giuint(GIUINTALSELL, mask);
-		else
-			clear_giuint(GIUINTALSELL, mask);
-		write_giuint(mask, GIUINTSTATL);
-	} else {
-		mask = (uint16_t)1 << (pin - GIUINT_HIGH_OFFSET);
-		if (level == LEVEL_HIGH)
-			set_giuint(GIUINTALSELH, mask);
-		else
-			clear_giuint(GIUINTALSELH, mask);
-		write_giuint(mask, GIUINTSTATH);
-	}
-}
-
-EXPORT_SYMBOL(vr41xx_set_irq_level);
-
-static int giu_get_irq(unsigned int irq, struct pt_regs *regs)
-{
-	uint16_t pendl, pendh, maskl, maskh;
-	int i;
-
-	pendl = read_giuint(GIUINTSTATL);
-	pendh = read_giuint(GIUINTSTATH);
-	maskl = read_giuint(GIUINTENL);
-	maskh = read_giuint(GIUINTENH);
-
-	maskl &= pendl;
-	maskh &= pendh;
-
-	if (maskl) {
-		for (i = 0; i < 16; i++) {
-			if (maskl & ((uint16_t)1 << i))
-				return GIU_IRQ(i);
-		}
-	} else if (maskh) {
-		for (i = 0; i < 16; i++) {
-			if (maskh & ((uint16_t)1 << i))
-				return GIU_IRQ(i + GIUINT_HIGH_OFFSET);
-		}
-	}
-
-	printk(KERN_ERR "spurious GIU interrupt: %04x(%04x),%04x(%04x)\n",
-	       maskl, pendl, maskh, pendh);
-
-	atomic_inc(&irq_err_count);
-
-	return -1;
-}
-
-static int  __init vr41xx_giu_init(void)
-{
-	int i;
-
-	switch (current_cpu_data.cputype) {
-	case CPU_VR4111:
-	case CPU_VR4121:
-		giu_base = GIUIOSELL_TYPE1;
-		break;
-	case CPU_VR4122:
-	case CPU_VR4131:
-	case CPU_VR4133:
-		giu_base = GIUIOSELL_TYPE2;
-		break;
-	default:
-		printk(KERN_ERR "GIU: Unexpected CPU of NEC VR4100 series\n");
-		return -ENODEV;
-	}
-
-	for (i = 0; i < 32; i++) {
-		if (i < GIUINT_HIGH_OFFSET)
-			clear_giuint(GIUINTENL, (uint16_t)1 << i);
-		else
-			clear_giuint(GIUINTENH, (uint16_t)1 << (i - GIUINT_HIGH_OFFSET));
-	}
-
-	for (i = GIU_IRQ_BASE; i <= GIU_IRQ_LAST; i++) {
-		if (i < (GIU_IRQ_BASE + GIUINT_HIGH_OFFSET))
-			irq_desc[i].handler = &giuint_low_irq_type;
-		else
-			irq_desc[i].handler = &giuint_high_irq_type;
-	}
-
-	return cascade_irq(GIUINT_IRQ, giu_get_irq);
-}
-
-postcore_initcall(vr41xx_giu_init);
