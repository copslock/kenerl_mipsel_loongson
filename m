Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Jul 2008 14:45:35 +0100 (BST)
Received: from mo30.po.2iij.net ([210.128.50.53]:2055 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20031134AbYGKNpd (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 11 Jul 2008 14:45:33 +0100
Received: by mo.po.2iij.net (mo30) id m6BDjTPd084960; Fri, 11 Jul 2008 22:45:29 +0900 (JST)
Received: from delta (61.25.30.125.dy.iij4u.or.jp [125.30.25.61])
	by mbox.po.2iij.net (po-mbox303) id m6BDjLWG031845
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 11 Jul 2008 22:45:22 +0900
Date:	Fri, 11 Jul 2008 22:45:21 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] remove cmbvr4133 support
Message-Id: <20080711224521.25dceb40.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.9; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19777
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Remove cmbvr4133 support.

It cannot be built for a long time.
And, no one maintains it.

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/arch/mips/Makefile linux/arch/mips/Makefile
--- linux-orig/arch/mips/Makefile	2008-07-11 16:02:13.932539521 +0900
+++ linux/arch/mips/Makefile	2008-07-11 16:01:33.698371561 +0900
@@ -355,12 +355,6 @@ core-$(CONFIG_MACH_VR41XX)	+= arch/mips/
 cflags-$(CONFIG_MACH_VR41XX)	+= -Iinclude/asm-mips/mach-vr41xx
 
 #
-# NEC VR4133
-#
-core-$(CONFIG_NEC_CMBVR4133)	+= arch/mips/vr41xx/nec-cmbvr4133/
-load-$(CONFIG_NEC_CMBVR4133)	+= 0xffffffff80100000
-
-#
 # ZAO Networks Capcella (VR4131)
 #
 load-$(CONFIG_ZAO_CAPCELLA)	+= 0xffffffff80000000
diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/arch/mips/pci/Makefile linux/arch/mips/pci/Makefile
--- linux-orig/arch/mips/pci/Makefile	2008-07-11 16:02:13.936537748 +0900
+++ linux/arch/mips/pci/Makefile	2008-07-11 16:01:33.706368013 +0900
@@ -13,7 +13,6 @@ obj-$(CONFIG_MIPS_MSC)		+= ops-msc.o
 obj-$(CONFIG_MIPS_NILE4)	+= ops-nile4.o
 obj-$(CONFIG_MIPS_TX3927)	+= ops-tx3927.o
 obj-$(CONFIG_PCI_VR41XX)	+= ops-vr41xx.o pci-vr41xx.o
-obj-$(CONFIG_NEC_CMBVR4133)	+= fixup-vr4133.o
 obj-$(CONFIG_MARKEINS)		+= ops-emma2rh.o pci-emma2rh.o fixup-emma2rh.o
 obj-$(CONFIG_PCI_TX3927)	+= ops-tx3927.o
 obj-$(CONFIG_PCI_TX4927)	+= ops-tx4927.o
diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/arch/mips/pci/fixup-vr4133.c linux/arch/mips/pci/fixup-vr4133.c
--- linux-orig/arch/mips/pci/fixup-vr4133.c	2008-07-11 16:02:13.980518253 +0900
+++ linux/arch/mips/pci/fixup-vr4133.c	1970-01-01 09:00:00.000000000 +0900
@@ -1,194 +0,0 @@
-/*
- * arch/mips/pci/fixup-vr4133.c
- *
- * The NEC CMB-VR4133 Board specific PCI fixups.
- *
- * Author: Yoichi Yuasa <yyuasa@mvista.com, or source@mvista.com> and
- *         Alex Sapkov <asapkov@ru.mvista.com>
- *
- * 2003-2004 (c) MontaVista, Software, Inc. This file is licensed under
- * the terms of the GNU General Public License version 2. This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
- *
- * Modified for support in 2.6
- * Author: Manish Lachwani (mlachwani@mvista.com)
- *
- */
-#include <linux/init.h>
-#include <linux/pci.h>
-#include <linux/kernel.h>
-
-#include <asm/io.h>
-#include <asm/i8259.h>
-#include <asm/vr41xx/cmbvr4133.h>
-
-extern int vr4133_rockhopper;
-extern void ali_m1535plus_init(struct pci_dev *dev);
-extern void ali_m5229_init(struct pci_dev *dev);
-
-/* Do platform specific device initialization at pci_enable_device() time */
-int pcibios_plat_dev_init(struct pci_dev *dev)
-{
-	/*
-	 * We have to reset AMD PCnet adapter on Rockhopper since
-	 * PMON leaves it enabled and generating interrupts. This leads
-	 * to a lock if some PCI device driver later enables the IRQ line
-	 * shared with PCnet and there is no AMD PCnet driver to catch its
-	 * interrupts.
-	 */
-#ifdef CONFIG_ROCKHOPPER
-	if (dev->vendor == PCI_VENDOR_ID_AMD &&
-		dev->device == PCI_DEVICE_ID_AMD_LANCE) {
-		inl(pci_resource_start(dev, 0) + 0x18);
-	}
-#endif
-
-	/*
-	 * we have to open the bridges' windows down to 0 because otherwise
-	 * we cannot access ISA south bridge I/O registers that get mapped from
-	 * 0. for example, 8259 PIC would be unaccessible without that
-	 */
-	if(dev->vendor == PCI_VENDOR_ID_INTEL && dev->device == PCI_DEVICE_ID_INTEL_S21152BB) {
-		pci_write_config_byte(dev, PCI_IO_BASE, 0);
-		if(dev->bus->number == 0) {
-			pci_write_config_word(dev, PCI_IO_BASE_UPPER16, 0);
-		} else {
-			pci_write_config_word(dev, PCI_IO_BASE_UPPER16, 1);
-		}
-	}
-
-	return 0;
-}
-
-/*
- * M1535 IRQ mapping
- * Feel free to change this, although it shouldn't be needed
- */
-#define M1535_IRQ_INTA  7
-#define M1535_IRQ_INTB  9
-#define M1535_IRQ_INTC  10
-#define M1535_IRQ_INTD  11
-
-#define M1535_IRQ_USB   9
-#define M1535_IRQ_IDE   14
-#define M1535_IRQ_IDE2  15
-#define M1535_IRQ_PS2   12
-#define M1535_IRQ_RTC   8
-#define M1535_IRQ_FDC   6
-#define M1535_IRQ_AUDIO 5
-#define M1535_IRQ_COM1  4
-#define M1535_IRQ_COM2  4
-#define M1535_IRQ_IRDA  3
-#define M1535_IRQ_KBD   1
-#define M1535_IRQ_TMR   0
-
-/* Rockhopper "slots" assignment; this is hard-coded ... */
-#define ROCKHOPPER_M5451_SLOT  1
-#define ROCKHOPPER_M1535_SLOT  2
-#define ROCKHOPPER_M5229_SLOT  11
-#define ROCKHOPPER_M5237_SLOT  15
-#define ROCKHOPPER_PMU_SLOT    12
-/* ... and hard-wired. */
-#define ROCKHOPPER_PCI1_SLOT   3
-#define ROCKHOPPER_PCI2_SLOT   4
-#define ROCKHOPPER_PCI3_SLOT   5
-#define ROCKHOPPER_PCI4_SLOT   6
-#define ROCKHOPPER_PCNET_SLOT  1
-
-#define M1535_IRQ_MASK(n) (1 << (n))
-
-#define M1535_IRQ_EDGE  (M1535_IRQ_MASK(M1535_IRQ_TMR)  | \
-                         M1535_IRQ_MASK(M1535_IRQ_KBD)  | \
-                         M1535_IRQ_MASK(M1535_IRQ_COM1) | \
-                         M1535_IRQ_MASK(M1535_IRQ_COM2) | \
-                         M1535_IRQ_MASK(M1535_IRQ_IRDA) | \
-                         M1535_IRQ_MASK(M1535_IRQ_RTC)  | \
-                         M1535_IRQ_MASK(M1535_IRQ_FDC)  | \
-                         M1535_IRQ_MASK(M1535_IRQ_PS2))
-
-#define M1535_IRQ_LEVEL (M1535_IRQ_MASK(M1535_IRQ_IDE)  | \
-                         M1535_IRQ_MASK(M1535_IRQ_USB)  | \
-                         M1535_IRQ_MASK(M1535_IRQ_INTA) | \
-                         M1535_IRQ_MASK(M1535_IRQ_INTB) | \
-                         M1535_IRQ_MASK(M1535_IRQ_INTC) | \
-                         M1535_IRQ_MASK(M1535_IRQ_INTD))
-
-struct irq_map_entry {
-	u16 bus;
-	u8 slot;
-	u8 irq;
-};
-static struct irq_map_entry int_map[] = {
-	{1, ROCKHOPPER_M5451_SLOT, M1535_IRQ_AUDIO},	/* Audio controller */
-	{1, ROCKHOPPER_PCI1_SLOT, M1535_IRQ_INTD},	/* PCI slot #1 */
-	{1, ROCKHOPPER_PCI2_SLOT, M1535_IRQ_INTC},	/* PCI slot #2 */
-	{1, ROCKHOPPER_M5237_SLOT, M1535_IRQ_USB},	/* USB host controller */
-	{1, ROCKHOPPER_M5229_SLOT, IDE_PRIMARY_IRQ},	/* IDE controller */
-	{2, ROCKHOPPER_PCNET_SLOT, M1535_IRQ_INTD},	/* AMD Am79c973 on-board
-							   ethernet */
-	{2, ROCKHOPPER_PCI3_SLOT, M1535_IRQ_INTB},	/* PCI slot #3 */
-	{2, ROCKHOPPER_PCI4_SLOT, M1535_IRQ_INTC}	/* PCI slot #4 */
-};
-
-static int pci_intlines[] =
-    { M1535_IRQ_INTA, M1535_IRQ_INTB, M1535_IRQ_INTC, M1535_IRQ_INTD };
-
-/* Determine the Rockhopper IRQ line number for the PCI device */
-int rockhopper_get_irq(struct pci_dev *dev, u8 pin, u8 slot)
-{
-	struct pci_bus *bus;
-	int i;
-
-	bus = dev->bus;
-	if (bus == NULL)
-		return -1;
-
-	for (i = 0; i < ARRAY_SIZE(int_map); i++) {
-		if (int_map[i].bus == bus->number && int_map[i].slot == slot) {
-			int line;
-			for (line = 0; line < 4; line++)
-				if (pci_intlines[line] == int_map[i].irq)
-					break;
-			if (line < 4)
-				return pci_intlines[(line + (pin - 1)) % 4];
-			else
-				return int_map[i].irq;
-		}
-	}
-	return -1;
-}
-
-#ifdef CONFIG_ROCKHOPPER
-void i8259_init(void)
-{
-	init_i8259_irqs();
-
-	outb(0x00, 0x4d0);
-	outb(0x02, 0x4d1);	/* USB IRQ9 is level */
-}
-#endif
-
-int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
-{
-	pci_probe_only = 1;
-
-#ifdef CONFIG_ROCKHOPPER
-	if( dev->bus->number == 1 && vr4133_rockhopper )  {
-		if(slot == ROCKHOPPER_PCI1_SLOT || slot == ROCKHOPPER_PCI2_SLOT)
-			dev->irq = CMBVR41XX_INTA_IRQ;
-		else
-			dev->irq = rockhopper_get_irq(dev, pin, slot);
-	} else
-		dev->irq = CMBVR41XX_INTA_IRQ;
-#else
-	dev->irq = CMBVR41XX_INTA_IRQ;
-#endif
-
-	return dev->irq;
-}
-
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M1533, ali_m1535plus_init);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M5229, ali_m5229_init);
-
-
diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/arch/mips/vr41xx/Kconfig linux/arch/mips/vr41xx/Kconfig
--- linux-orig/arch/mips/vr41xx/Kconfig	2008-07-11 16:02:13.984516482 +0900
+++ linux/arch/mips/vr41xx/Kconfig	2008-07-11 16:01:33.714364468 +0900
@@ -23,16 +23,6 @@ config IBM_WORKPAD
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 
-config NEC_CMBVR4133
-	bool "NEC CMB-VR4133"
-	select CEVT_R4K
-	select CSRC_R4K
-	select DMA_NONCOHERENT
-	select IRQ_CPU
-	select HW_HAS_PCI
-	select SYS_SUPPORTS_32BIT_KERNEL
-	select SYS_SUPPORTS_LITTLE_ENDIAN
-
 config TANBAC_TB022X
 	bool "TANBAC VR4131 multichip module and TANBAC VR4131DIMM"
 	select CEVT_R4K
@@ -73,13 +63,6 @@ config ZAO_CAPCELLA
 
 endchoice
 
-config ROCKHOPPER
-	bool "Support for Rockhopper base board"
-	depends on NEC_CMBVR4133
-	select PCI_VR41XX
-	select I8259
-	select HAVE_STD_PC_SERIAL_PORT
-
 choice
 	prompt "Base board type"
 	depends on TANBAC_TB022X
diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/arch/mips/vr41xx/nec-cmbvr4133/Makefile linux/arch/mips/vr41xx/nec-cmbvr4133/Makefile
--- linux-orig/arch/mips/vr41xx/nec-cmbvr4133/Makefile	2008-07-11 16:02:13.988514714 +0900
+++ linux/arch/mips/vr41xx/nec-cmbvr4133/Makefile	1970-01-01 09:00:00.000000000 +0900
@@ -1,8 +0,0 @@
-#
-# Makefile for the NEC-CMBVR4133
-#
-
-obj-y				:= init.o setup.o
-
-obj-$(CONFIG_PCI)		+= m1535plus.o
-obj-$(CONFIG_ROCKHOPPER)	+= irq.o
diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/arch/mips/vr41xx/nec-cmbvr4133/init.c linux/arch/mips/vr41xx/nec-cmbvr4133/init.c
--- linux-orig/arch/mips/vr41xx/nec-cmbvr4133/init.c	2008-07-11 16:02:13.992512943 +0900
+++ linux/arch/mips/vr41xx/nec-cmbvr4133/init.c	1970-01-01 09:00:00.000000000 +0900
@@ -1,65 +0,0 @@
-/*
- * arch/mips/vr41xx/nec-cmbvr4133/init.c
- *
- * PROM library initialisation code for NEC CMB-VR4133 board.
- *
- * Author: Yoichi Yuasa <yyuasa@mvista.com, or source@mvista.com> and
- *         Jun Sun <jsun@mvista.com, or source@mvista.com> and
- *         Alex Sapkov <asapkov@ru.mvista.com>
- *
- * 2001-2004 (c) MontaVista, Software, Inc. This file is licensed under
- * the terms of the GNU General Public License version 2. This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
- *
- * Support for NEC-CMBVR4133 in 2.6
- * Manish Lachwani (mlachwani@mvista.com)
- */
-
-#ifdef CONFIG_ROCKHOPPER
-#include <asm/io.h>
-#include <linux/pci.h>
-
-#define PCICONFDREG	0xaf000c14
-#define PCICONFAREG	0xaf000c18
-
-void disable_pcnet(void)
-{
-	u32 data;
-
-	/*
-	 * Workaround for the bug in PMON on VR4133. PMON leaves
-	 * AMD PCNet controller (on Rockhopper) initialized and running in
-	 * bus master mode. We have do disable it before doing any
-	 * further initialization. Or we get problems with PCI bus 2
-	 * and random lockups and crashes.
-	 */
-
-	writel((2 << 16)		|
-	       (PCI_DEVFN(1, 0) << 8)	|
-	       (0 & 0xfc)		|
-               1UL,
-	       PCICONFAREG);
-
-	data = readl(PCICONFDREG);
-
-	writel((2 << 16)		|
-	       (PCI_DEVFN(1, 0) << 8)	|
-	       (4 & 0xfc)		|
-               1UL,
-	       PCICONFAREG);
-
-	data = readl(PCICONFDREG);
-
-	writel((2 << 16)		|
-	       (PCI_DEVFN(1, 0) << 8)	|
-	       (4 & 0xfc)		|
-               1UL,
-	       PCICONFAREG);
-
-	data &= ~4;
-
-	writel(data, PCICONFDREG);
-}
-#endif
-
diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/arch/mips/vr41xx/nec-cmbvr4133/irq.c linux/arch/mips/vr41xx/nec-cmbvr4133/irq.c
--- linux-orig/arch/mips/vr41xx/nec-cmbvr4133/irq.c	2008-07-11 16:02:13.996511166 +0900
+++ linux/arch/mips/vr41xx/nec-cmbvr4133/irq.c	1970-01-01 09:00:00.000000000 +0900
@@ -1,46 +0,0 @@
-/*
- * arch/mips/vr41xx/nec-cmbvr4133/irq.c
- *
- * Interrupt routines for the NEC CMB-VR4133 board.
- *
- * Author: Yoichi Yuasa <yyuasa@mvista.com, or source@mvista.com> and
- *         Alex Sapkov <asapkov@ru.mvista.com>
- *
- * 2003-2004 (c) MontaVista, Software, Inc. This file is licensed under
- * the terms of the GNU General Public License version 2. This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
- *
- * Support for NEC-CMBVR4133 in 2.6
- * Manish Lachwani (mlachwani@mvista.com)
- */
-#include <linux/bitops.h>
-#include <linux/errno.h>
-#include <linux/init.h>
-#include <linux/ioport.h>
-#include <linux/interrupt.h>
-
-#include <asm/io.h>
-#include <asm/i8259.h>
-#include <asm/vr41xx/cmbvr4133.h>
-
-extern int vr4133_rockhopper;
-
-static int i8259_get_irq_number(int irq)
-{
-	return i8259_irq();
-}
-
-void __init rockhopper_init_irq(void)
-{
-	int i;
-
-	if(!vr4133_rockhopper) {
-		printk(KERN_ERR "Not a Rockhopper Board \n");
-		return;
-	}
-
-	vr41xx_set_irq_trigger(CMBVR41XX_INTC_PIN, TRIGGER_LEVEL, SIGNAL_THROUGH);
-	vr41xx_set_irq_level(CMBVR41XX_INTC_PIN, LEVEL_HIGH);
-	vr41xx_cascade_irq(CMBVR41XX_INTC_IRQ, i8259_get_irq_number);
-}
diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/arch/mips/vr41xx/nec-cmbvr4133/m1535plus.c linux/arch/mips/vr41xx/nec-cmbvr4133/m1535plus.c
--- linux-orig/arch/mips/vr41xx/nec-cmbvr4133/m1535plus.c	2008-07-11 16:02:14.000509391 +0900
+++ linux/arch/mips/vr41xx/nec-cmbvr4133/m1535plus.c	1970-01-01 09:00:00.000000000 +0900
@@ -1,249 +0,0 @@
-/*
- * arch/mips/vr41xx/nec-cmbvr4133/m1535plus.c
- *
- * Initialize for ALi M1535+(included M5229 and M5237).
- *
- * Author: Yoichi Yuasa <yyuasa@mvista.com, or source@mvista.com> and
- *         Alex Sapkov <asapkov@ru.mvista.com>
- *
- * 2003-2004 (c) MontaVista, Software, Inc. This file is licensed under
- * the terms of the GNU General Public License version 2. This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
- *
- * Support for NEC-CMBVR4133 in 2.6
- * Author: Manish Lachwani (mlachwani@mvista.com)
- */
-#include <linux/init.h>
-#include <linux/types.h>
-#include <linux/serial.h>
-
-#include <asm/vr41xx/cmbvr4133.h>
-#include <linux/pci.h>
-#include <asm/io.h>
-
-#define CONFIG_PORT(port)	((port) ? 0x3f0 : 0x370)
-#define DATA_PORT(port)		((port) ? 0x3f1 : 0x371)
-#define INDEX_PORT(port)	CONFIG_PORT(port)
-
-#define ENTER_CONFIG_MODE(port)				\
-	do {						\
-		outb_p(0x51, CONFIG_PORT(port));	\
-		outb_p(0x23, CONFIG_PORT(port));	\
-	} while(0)
-
-#define SELECT_LOGICAL_DEVICE(port, dev_no)		\
-	do {						\
-		outb_p(0x07, INDEX_PORT(port));		\
-		outb_p((dev_no), DATA_PORT(port));	\
-	} while(0)
-
-#define WRITE_CONFIG_DATA(port, index, data)		\
-	do {						\
-		outb_p((index), INDEX_PORT(port));	\
-		outb_p((data), DATA_PORT(port));	\
-	} while(0)
-
-#define EXIT_CONFIG_MODE(port)	outb(0xbb, CONFIG_PORT(port))
-
-#define PCI_CONFIG_ADDR	KSEG1ADDR(0x0f000c18)
-#define PCI_CONFIG_DATA	KSEG1ADDR(0x0f000c14)
-
-#ifdef CONFIG_BLK_DEV_FD
-
-void __devinit ali_m1535plus_fdc_init(int port)
-{
-	ENTER_CONFIG_MODE(port);
-	SELECT_LOGICAL_DEVICE(port, 0);		/* FDC */
-	WRITE_CONFIG_DATA(port, 0x30, 0x01);	/* FDC: enable */
-	WRITE_CONFIG_DATA(port, 0x60, 0x03);	/* I/O port base: 0x3f0 */
-	WRITE_CONFIG_DATA(port, 0x61, 0xf0);
-	WRITE_CONFIG_DATA(port, 0x70, 0x06);	/* IRQ: 6 */
-	WRITE_CONFIG_DATA(port, 0x74, 0x02);	/* DMA: channel 2 */
-	WRITE_CONFIG_DATA(port, 0xf0, 0x08);
-	WRITE_CONFIG_DATA(port, 0xf1, 0x00);
-	WRITE_CONFIG_DATA(port, 0xf2, 0xff);
-	WRITE_CONFIG_DATA(port, 0xf4, 0x00);
-	EXIT_CONFIG_MODE(port);
-}
-
-#endif
-
-void __devinit ali_m1535plus_parport_init(int port)
-{
-	ENTER_CONFIG_MODE(port);
-	SELECT_LOGICAL_DEVICE(port, 3);		/* Parallel Port */
-	WRITE_CONFIG_DATA(port, 0x30, 0x01);
-	WRITE_CONFIG_DATA(port, 0x60, 0x03);	/* I/O port base: 0x378 */
-	WRITE_CONFIG_DATA(port, 0x61, 0x78);
-	WRITE_CONFIG_DATA(port, 0x70, 0x07);	/* IRQ: 7 */
-	WRITE_CONFIG_DATA(port, 0x74, 0x04);	/* DMA: None */
-	WRITE_CONFIG_DATA(port, 0xf0, 0x8c);	/* IRQ polarity: Active Low */
-	WRITE_CONFIG_DATA(port, 0xf1, 0xc5);
-	EXIT_CONFIG_MODE(port);
-}
-
-void __devinit ali_m1535plus_keyboard_init(int port)
-{
-	ENTER_CONFIG_MODE(port);
-	SELECT_LOGICAL_DEVICE(port, 7);		/* KEYBOARD */
-	WRITE_CONFIG_DATA(port, 0x30, 0x01);	/* KEYBOARD: eable */
-	WRITE_CONFIG_DATA(port, 0x70, 0x01);	/* IRQ: 1 */
-	WRITE_CONFIG_DATA(port, 0x72, 0x0c);	/* PS/2 Mouse IRQ: 12 */
-	WRITE_CONFIG_DATA(port, 0xf0, 0x00);
-	EXIT_CONFIG_MODE(port);
-}
-
-void __devinit ali_m1535plus_hotkey_init(int port)
-{
-	ENTER_CONFIG_MODE(port);
-	SELECT_LOGICAL_DEVICE(port, 0xc);	/* HOTKEY */
-	WRITE_CONFIG_DATA(port, 0x30, 0x00);
-	WRITE_CONFIG_DATA(port, 0xf0, 0x35);
-	WRITE_CONFIG_DATA(port, 0xf1, 0x14);
-	WRITE_CONFIG_DATA(port, 0xf2, 0x11);
-	WRITE_CONFIG_DATA(port, 0xf3, 0x71);
-	WRITE_CONFIG_DATA(port, 0xf5, 0x05);
-	EXIT_CONFIG_MODE(port);
-}
-
-void ali_m1535plus_init(struct pci_dev *dev)
-{
-	pci_write_config_byte(dev, 0x40, 0x18); /* PCI Interface Control */
-	pci_write_config_byte(dev, 0x41, 0xc0); /* PS2 keyb & mouse enable */
-	pci_write_config_byte(dev, 0x42, 0x41); /* ISA bus cycle control */
-	pci_write_config_byte(dev, 0x43, 0x00); /* ISA bus cycle control 2 */
-	pci_write_config_byte(dev, 0x44, 0x5d); /* IDE enable & IRQ 14 */
-	pci_write_config_byte(dev, 0x45, 0x0b); /* PCI int polling mode */
-	pci_write_config_byte(dev, 0x47, 0x00); /* BIOS chip select control */
-
-	/* IRQ routing */
-	pci_write_config_byte(dev, 0x48, 0x03); /* INTA IRQ10, INTB disable */
-	pci_write_config_byte(dev, 0x49, 0x00); /* INTC and INTD disable */
-	pci_write_config_byte(dev, 0x4a, 0x00); /* INTE and INTF disable */
-	pci_write_config_byte(dev, 0x4b, 0x90); /* Audio IRQ11, Modem disable */
-
-	pci_write_config_word(dev, 0x50, 0x4000); /* Parity check IDE enable */
-	pci_write_config_word(dev, 0x52, 0x0000); /* USB & RTC disable */
-	pci_write_config_word(dev, 0x54, 0x0002); /* ??? no info */
-	pci_write_config_word(dev, 0x56, 0x0002); /* PCS1J signal disable */
-
-	pci_write_config_byte(dev, 0x59, 0x00); /* PCSDS */
-	pci_write_config_byte(dev, 0x5a, 0x00);
-	pci_write_config_byte(dev, 0x5b, 0x00);
-	pci_write_config_word(dev, 0x5c, 0x0000);
-	pci_write_config_byte(dev, 0x5e, 0x00);
-	pci_write_config_byte(dev, 0x5f, 0x00);
-	pci_write_config_word(dev, 0x60, 0x0000);
-
-	pci_write_config_byte(dev, 0x6c, 0x00);
-	pci_write_config_byte(dev, 0x6d, 0x48); /* ROM address mapping */
-	pci_write_config_byte(dev, 0x6e, 0x00); /* ??? what for? */
-
-	pci_write_config_byte(dev, 0x70, 0x12); /* Serial IRQ control */
-	pci_write_config_byte(dev, 0x71, 0xEF); /* DMA channel select */
-	pci_write_config_byte(dev, 0x72, 0x03); /* USB IDSEL */
-	pci_write_config_byte(dev, 0x73, 0x00); /* ??? no info */
-
-	/*
-	 * IRQ setup ALi M5237 USB Host Controller
-	 * IRQ: 9
-	 */
-	pci_write_config_byte(dev, 0x74, 0x01); /* USB IRQ9 */
-
-	pci_write_config_byte(dev, 0x75, 0x1f); /* IDE2 IRQ 15  */
-	pci_write_config_byte(dev, 0x76, 0x80); /* ACPI disable */
-	pci_write_config_byte(dev, 0x77, 0x40); /* Modem disable */
-	pci_write_config_dword(dev, 0x78, 0x20000000); /* Pin select 2 */
-	pci_write_config_byte(dev, 0x7c, 0x00); /* Pin select 3 */
-	pci_write_config_byte(dev, 0x81, 0x00); /* ID read/write control */
-	pci_write_config_byte(dev, 0x90, 0x00); /* PCI PM block control */
-	pci_write_config_word(dev, 0xa4, 0x0000); /* PMSCR */
-
-#ifdef CONFIG_BLK_DEV_FD
-	ali_m1535plus_fdc_init(1);
-#endif
-
-	ali_m1535plus_keyboard_init(1);
-	ali_m1535plus_hotkey_init(1);
-}
-
-static inline void ali_config_writeb(u8 reg, u8 val, int devfn)
-{
-	u32 data;
-	int shift;
-
-	writel((1 << 16) | (devfn << 8) | (reg & 0xfc) | 1UL, PCI_CONFIG_ADDR);
-        data = readl(PCI_CONFIG_DATA);
-
-	shift = (reg & 3) << 3;
-	data &= ~(0xff << shift);
-	data |= (((u32)val) << shift);
-
-	writel(data, PCI_CONFIG_DATA);
-}
-
-static inline u8 ali_config_readb(u8 reg, int devfn)
-{
-	u32 data;
-
-	writel((1 << 16) | (devfn << 8) | (reg & 0xfc) | 1UL, PCI_CONFIG_ADDR);
-	data = readl(PCI_CONFIG_DATA);
-
-	return (u8)(data >> ((reg & 3) << 3));
-}
-
-static inline u16 ali_config_readw(u8 reg, int devfn)
-{
-	u32 data;
-
-	writel((1 << 16) | (devfn << 8) | (reg & 0xfc) | 1UL, PCI_CONFIG_ADDR);
-	data = readl(PCI_CONFIG_DATA);
-
-	return (u16)(data >> ((reg & 2) << 3));
-}
-
-int vr4133_rockhopper = 0;
-void __init ali_m5229_preinit(void)
-{
-	if (ali_config_readw(PCI_VENDOR_ID, 16) == PCI_VENDOR_ID_AL &&
-	    ali_config_readw(PCI_DEVICE_ID, 16) == PCI_DEVICE_ID_AL_M1533) {
-		printk(KERN_INFO "Found an NEC Rockhopper \n");
-		vr4133_rockhopper = 1;
-		/*
-		 * Enable ALi M5229 IDE Controller (both channels)
-		 * IDSEL: A27
-		 */
-		ali_config_writeb(0x58, 0x4c, 16);
-	}
-}
-
-void __init ali_m5229_init(struct pci_dev *dev)
-{
-	/*
-	 * Enable Primary/Secondary Channel Cable Detect 40-Pin
-	 */
-	pci_write_config_word(dev, 0x4a, 0xc023);
-
-	/*
-	 * Set only the 3rd byteis for the master IDE's cycle and
-	 * enable Internal IDE Function
-	 */
-	pci_write_config_byte(dev, 0x50, 0x23); /* Class code attr register */
-
-	pci_write_config_byte(dev, 0x09, 0xff); /* Set native mode & stuff */
-	pci_write_config_byte(dev, 0x52, 0x00); /* use timing registers */
-	pci_write_config_byte(dev, 0x58, 0x02); /* Primary addr setup timing */
-	pci_write_config_byte(dev, 0x59, 0x22); /* Primary cmd block timing */
-	pci_write_config_byte(dev, 0x5a, 0x22); /* Pr drv 0 R/W timing */
-	pci_write_config_byte(dev, 0x5b, 0x22); /* Pr drv 1 R/W timing */
-	pci_write_config_byte(dev, 0x5c, 0x02); /* Sec addr setup timing */
-	pci_write_config_byte(dev, 0x5d, 0x22); /* Sec cmd block timing */
-	pci_write_config_byte(dev, 0x5e, 0x22); /* Sec drv 0 R/W timing */
-	pci_write_config_byte(dev, 0x5f, 0x22); /* Sec drv 1 R/W timing */
-	pci_write_config_byte(dev, PCI_LATENCY_TIMER, 0x20);
-	pci_write_config_word(dev, PCI_COMMAND,
-	                           PCI_COMMAND_PARITY | PCI_COMMAND_MASTER |
-				   PCI_COMMAND_IO);
-}
-
diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/arch/mips/vr41xx/nec-cmbvr4133/setup.c linux/arch/mips/vr41xx/nec-cmbvr4133/setup.c
--- linux-orig/arch/mips/vr41xx/nec-cmbvr4133/setup.c	2008-07-11 16:02:14.008505853 +0900
+++ linux/arch/mips/vr41xx/nec-cmbvr4133/setup.c	1970-01-01 09:00:00.000000000 +0900
@@ -1,89 +0,0 @@
-/*
- * arch/mips/vr41xx/nec-cmbvr4133/setup.c
- *
- * Setup for the NEC CMB-VR4133.
- *
- * Author: Yoichi Yuasa <yyuasa@mvista.com, or source@mvista.com> and
- *         Alex Sapkov <asapkov@ru.mvista.com>
- *
- * 2001-2004 (c) MontaVista, Software, Inc. This file is licensed under
- * the terms of the GNU General Public License version 2. This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
- *
- * Support for CMBVR4133 board in 2.6
- * Author: Manish Lachwani (mlachwani@mvista.com)
- */
-#include <linux/init.h>
-#include <linux/ide.h>
-#include <linux/ioport.h>
-
-#include <asm/reboot.h>
-#include <asm/time.h>
-#include <asm/vr41xx/cmbvr4133.h>
-#include <asm/bootinfo.h>
-
-#ifdef CONFIG_MTD
-#include <linux/mtd/physmap.h>
-#include <linux/mtd/partitions.h>
-#include <linux/mtd/mtd.h>
-#include <linux/mtd/map.h>
-
-static struct mtd_partition cmbvr4133_mtd_parts[] = {
-	{
-		.name =		"User FS",
-		.size =		0x1be0000,
-		.offset =	0,
-		.mask_flags = 	0,
-	},
-	{
-		.name =		"PMON",
-		.size =		0x140000,
-		.offset =	MTDPART_OFS_APPEND,
-		.mask_flags =	MTD_WRITEABLE,  /* force read-only */
-	},
-	{
-		.name =		"User FS2",
-		.size =		MTDPART_SIZ_FULL,
-		.offset =	MTDPART_OFS_APPEND,
-		.mask_flags = 	0,
-	}
-};
-
-#define number_partitions ARRAY_SIZE(cmbvr4133_mtd_parts)
-#endif
-
-extern void i8259_init(void);
-
-static void __init nec_cmbvr4133_setup(void)
-{
-#ifdef CONFIG_ROCKHOPPER
-	extern void disable_pcnet(void);
-
-	disable_pcnet();
-#endif
-	set_io_port_base(KSEG1ADDR(0x16000000));
-
-#ifdef CONFIG_PCI
-#ifdef CONFIG_ROCKHOPPER
-	ali_m5229_preinit();
-#endif
-#endif
-
-#ifdef CONFIG_ROCKHOPPER
-	rockhopper_init_irq();
-#endif
-
-#ifdef CONFIG_MTD
-	/* we use generic physmap mapping driver and we use partitions */
-	physmap_configure(0x1C000000, 0x02000000, 4, NULL);
-	physmap_set_partitions(cmbvr4133_mtd_parts, number_partitions);
-#endif
-
-	/* 128 MB memory support */
-	add_memory_region(0, 0x08000000, BOOT_MEM_RAM);
-
-#ifdef CONFIG_ROCKHOPPER
-	i8259_init();
-#endif
-}
diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/include/asm-mips/mach-vr41xx/irq.h linux/include/asm-mips/mach-vr41xx/irq.h
--- linux-orig/include/asm-mips/mach-vr41xx/irq.h	2008-07-11 16:02:14.016502307 +0900
+++ linux/include/asm-mips/mach-vr41xx/irq.h	2008-07-11 16:01:33.722360927 +0900
@@ -2,9 +2,6 @@
 #define __ASM_MACH_VR41XX_IRQ_H
 
 #include <asm/vr41xx/irq.h> /* for MIPS_CPU_IRQ_BASE */
-#ifdef CONFIG_NEC_CMBVR4133
-#include <asm/vr41xx/cmbvr4133.h> /* for I8259A_IRQ_BASE */
-#endif
 
 #include_next <irq.h>
 
diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/include/asm-mips/vr41xx/cmbvr4133.h linux/include/asm-mips/vr41xx/cmbvr4133.h
--- linux-orig/include/asm-mips/vr41xx/cmbvr4133.h	2008-07-11 16:02:14.020500534 +0900
+++ linux/include/asm-mips/vr41xx/cmbvr4133.h	1970-01-01 09:00:00.000000000 +0900
@@ -1,56 +0,0 @@
-/*
- * include/asm-mips/vr41xx/cmbvr4133.h
- *
- * Include file for NEC CMB-VR4133.
- *
- * Author: Yoichi Yuasa <yyuasa@mvista.com, or source@mvista.com> and
- *         Jun Sun <jsun@mvista.com, or source@mvista.com> and
- *         Alex Sapkov <asapkov@ru.mvista.com>
- *
- * 2002-2004 (c) MontaVista, Software, Inc. This file is licensed under
- * the terms of the GNU General Public License version 2. This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
- */
-#ifndef __NEC_CMBVR4133_H
-#define __NEC_CMBVR4133_H
-
-#include <asm/vr41xx/irq.h>
-
-/*
- * General-Purpose I/O Pin Number
- */
-#define CMBVR41XX_INTA_PIN		1
-#define CMBVR41XX_INTB_PIN		1
-#define CMBVR41XX_INTC_PIN		3
-#define CMBVR41XX_INTD_PIN		1
-#define CMBVR41XX_INTE_PIN		1
-
-/*
- * Interrupt Number
- */
-#define CMBVR41XX_INTA_IRQ		GIU_IRQ(CMBVR41XX_INTA_PIN)
-#define CMBVR41XX_INTB_IRQ		GIU_IRQ(CMBVR41XX_INTB_PIN)
-#define CMBVR41XX_INTC_IRQ		GIU_IRQ(CMBVR41XX_INTC_PIN)
-#define CMBVR41XX_INTD_IRQ		GIU_IRQ(CMBVR41XX_INTD_PIN)
-#define CMBVR41XX_INTE_IRQ		GIU_IRQ(CMBVR41XX_INTE_PIN)
-
-#define I8259A_IRQ_BASE			72
-#define I8259_IRQ(x)			(I8259A_IRQ_BASE + (x))
-#define TIMER_IRQ			I8259_IRQ(0)
-#define KEYBOARD_IRQ			I8259_IRQ(1)
-#define I8259_SLAVE_IRQ			I8259_IRQ(2)
-#define UART3_IRQ			I8259_IRQ(3)
-#define UART1_IRQ			I8259_IRQ(4)
-#define UART2_IRQ			I8259_IRQ(5)
-#define FDC_IRQ				I8259_IRQ(6)
-#define PARPORT_IRQ			I8259_IRQ(7)
-#define RTC_IRQ				I8259_IRQ(8)
-#define USB_IRQ				I8259_IRQ(9)
-#define I8259_INTA_IRQ			I8259_IRQ(10)
-#define AUDIO_IRQ			I8259_IRQ(11)
-#define AUX_IRQ				I8259_IRQ(12)
-#define IDE_PRIMARY_IRQ			I8259_IRQ(14)
-#define IDE_SECONDARY_IRQ		I8259_IRQ(15)
-
-#endif /* __NEC_CMBVR4133_H */
