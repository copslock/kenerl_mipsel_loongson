Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Jun 2005 04:34:22 +0100 (BST)
Received: from sonicwall.montavista.co.jp ([IPv6:::ffff:202.232.97.131]:45422
	"EHLO yuubin.montavista.co.jp") by linux-mips.org with ESMTP
	id <S8225197AbVFVDdp>; Wed, 22 Jun 2005 04:33:45 +0100
Received: from localhost.localdomain (oreo.jp.mvista.com [10.200.16.31])
	by yuubin.montavista.co.jp (8.12.5/8.12.5) with SMTP id j5M3WWS5026712;
	Wed, 22 Jun 2005 12:32:32 +0900
Date:	Wed, 22 Jun 2005 12:34:17 +0900
From:	Hiroshi DOYU <Hiroshi_DOYU@montavista.co.jp>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org, mlachwani@mvista.com
Subject: [patch 2.6.12 1/1] tx4938: Added the new board support for Toshiba
 RBHMA4500(TX4938)
Message-Id: <20050622123417.25cd543c.Hiroshi_DOYU@montavista.co.jp>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <Hiroshi_DOYU@montavista.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8126
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Hiroshi_DOYU@montavista.co.jp
Precedence: bulk
X-list: linux-mips

Hello,

This patch is against 2.6.12 and it works fine. 
Please review it.

	Hiroshi DOYU

----
Added the new board support for Toshiba RBHMA4500(TX4938)

Signed-off-by: Manish Lachwani <mlachwani@mvista.com>
Signed-off-by: Hiroshi DOYU <Hiroshi_DOYU@montavista.co.jp>
----

 arch/mips/Kconfig                              |   17 
 arch/mips/Makefile                             |    7 
 arch/mips/pci/Makefile                         |    1 
 arch/mips/pci/fixup-tx4938.c                   |   95 ++
 arch/mips/pci/ops-tx4938.c                     |  199 ++++
 arch/mips/tx4938/common/Makefile               |   10 
 arch/mips/tx4938/common/irq.c                  |  447 ++++++++++
 arch/mips/tx4938/common/irq_handler.S          |   86 ++
 arch/mips/tx4938/common/prom.c                 |  129 +++
 arch/mips/tx4938/common/rtc_rx5c348.c          |  202 ++++
 arch/mips/tx4938/common/setup.c                |   97 ++
 arch/mips/tx4938/toshiba_rbtx4938/Makefile     |    9 
 arch/mips/tx4938/toshiba_rbtx4938/irq.c        |  275 ++++++
 arch/mips/tx4938/toshiba_rbtx4938/prom.c       |   78 +
 arch/mips/tx4938/toshiba_rbtx4938/setup.c      | 1034 +++++++++++++++++++++++++
 arch/mips/tx4938/toshiba_rbtx4938/spi_eeprom.c |  219 +++++
 arch/mips/tx4938/toshiba_rbtx4938/spi_txx9.c   |  159 +++
 drivers/net/ne.c                               |   15 
 include/asm-mips/bootinfo.h                    |    1 
 include/asm-mips/tx4938/rbtx4938.h             |  207 +++++
 include/asm-mips/tx4938/spi.h                  |   74 +
 include/asm-mips/tx4938/tx4938.h               |  706 +++++++++++++++++
 include/asm-mips/tx4938/tx4938_mips.h          |   54 +
 23 files changed, 4121 insertions(+)

Index: linux/arch/mips/Kconfig
===================================================================
--- linux.orig/arch/mips/Kconfig	2005-06-22 12:18:48.167088512 +0900
+++ linux/arch/mips/Kconfig	2005-06-22 12:25:09.887058256 +0900
@@ -628,6 +628,23 @@
 	  This Toshiba board is based on the TX4927 processor. Say Y here to
 	  support this machine type
 
+config TOSHIBA_RBTX4938
+	bool "Support for Toshiba RBTX4938 board"
+	select HAVE_STD_PC_SERIAL_PORT
+	select DMA_NONCOHERENT
+	select GENERIC_ISA_DMA
+	select HAS_TXX9_SERIAL
+	select HW_HAS_PCI
+	select I8259
+	select ISA
+	select SWAP_IO_SPACE
+	select SYS_SUPPORTS_32BIT_KERNEL
+	select SYS_SUPPORTS_LITTLE_ENDIAN
+	select TOSHIBA_BOARDS
+	help
+	  This Toshiba board is based on the TX4938 processor. Say Y here to
+	  support this machine type
+
 endchoice
 
 source "arch/mips/ddb5xxx/Kconfig"
Index: linux/arch/mips/Makefile
===================================================================
--- linux.orig/arch/mips/Makefile	2005-06-22 12:18:48.167088512 +0900
+++ linux/arch/mips/Makefile	2005-06-22 12:25:09.888058104 +0900
@@ -658,6 +658,13 @@
 core-$(CONFIG_TOSHIBA_RBTX4927)	+= arch/mips/tx4927/common/
 load-$(CONFIG_TOSHIBA_RBTX4927)	+= 0xffffffff80020000
 
+#
+# Toshiba RBTX4938 board
+#
+core-$(CONFIG_TOSHIBA_RBTX4938) += arch/mips/tx4938/toshiba_rbtx4938/
+core-$(CONFIG_TOSHIBA_RBTX4938) += arch/mips/tx4938/common/
+load-$(CONFIG_TOSHIBA_RBTX4938) += 0xffffffff80100000
+
 cflags-y			+= -Iinclude/asm-mips/mach-generic
 drivers-$(CONFIG_PCI)		+= arch/mips/pci/
 
Index: linux/arch/mips/pci/Makefile
===================================================================
--- linux.orig/arch/mips/pci/Makefile	2005-06-22 12:18:48.167088512 +0900
+++ linux/arch/mips/pci/Makefile	2005-06-22 12:25:09.888058104 +0900
@@ -50,5 +50,6 @@
 obj-$(CONFIG_TANBAC_TB0226)	+= fixup-tb0226.o
 obj-$(CONFIG_TOSHIBA_JMR3927)	+= fixup-jmr3927.o pci-jmr3927.o
 obj-$(CONFIG_TOSHIBA_RBTX4927)	+= fixup-rbtx4927.o ops-tx4927.o
+obj-$(CONFIG_TOSHIBA_RBTX4938)	+= fixup-tx4938.o ops-tx4938.o
 obj-$(CONFIG_VICTOR_MPC30X)	+= fixup-mpc30x.o
 obj-$(CONFIG_ZAO_CAPCELLA)	+= fixup-capcella.o
Index: linux/arch/mips/pci/fixup-tx4938.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux/arch/mips/pci/fixup-tx4938.c	2005-06-22 12:25:09.888058104 +0900
@@ -0,0 +1,95 @@
+/*
+ * Toshiba rbtx4938 pci routines
+ * Copyright (C) 2000-2001 Toshiba Corporation
+ *
+ * 2003-2005 (c) MontaVista Software, Inc. This file is licensed under the
+ * terms of the GNU General Public License version 2. This program is
+ * licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ *
+ * Support for TX4938 in 2.6 - Manish Lachwani (mlachwani@mvista.com)
+ */
+
+#include <linux/config.h>
+
+#include <linux/types.h>
+#include <linux/pci.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+
+#include <asm/tx4938/rbtx4938.h>
+
+extern struct pci_controller tx4938_pci_controller[];
+
+int pci_get_irq(struct pci_dev *dev, int pin)
+{
+	int irq = pin;
+	u8 slot = PCI_SLOT(dev->devfn);
+	struct pci_controller *controller = (struct pci_controller *)dev->sysdata;
+
+	if (controller == &tx4938_pci_controller[1]) {
+		/* TX4938 PCIC1 */
+		switch (slot) {
+		case TX4938_PCIC_IDSEL_AD_TO_SLOT(31):
+			if (tx4938_ccfgptr->pcfg & TX4938_PCFG_ETH0_SEL)
+				return RBTX4938_IRQ_IRC + TX4938_IR_ETH0;
+			break;
+		case TX4938_PCIC_IDSEL_AD_TO_SLOT(30):
+			if (tx4938_ccfgptr->pcfg & TX4938_PCFG_ETH1_SEL)
+				return RBTX4938_IRQ_IRC + TX4938_IR_ETH1;
+			break;
+		}
+		return 0;
+	}
+
+	/* IRQ rotation */
+	irq--;	/* 0-3 */
+	if (dev->bus->parent == NULL &&
+	    (slot == TX4938_PCIC_IDSEL_AD_TO_SLOT(23))) {
+		/* PCI CardSlot (IDSEL=A23) */
+		/* PCIA => PCIA (IDSEL=A23) */
+		irq = (irq + 0 + slot) % 4;
+	} else {
+		/* PCI Backplane */
+		irq = (irq + 33 - slot) % 4;
+	}
+	irq++;	/* 1-4 */
+
+	switch (irq) {
+	case 1:
+		irq = RBTX4938_IRQ_IOC_PCIA;
+		break;
+	case 2:
+		irq = RBTX4938_IRQ_IOC_PCIB;
+		break;
+	case 3:
+		irq = RBTX4938_IRQ_IOC_PCIC;
+		break;
+	case 4:
+		irq = RBTX4938_IRQ_IOC_PCID;
+		break;
+	}
+	return irq;
+}
+
+int __init pcibios_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
+{
+	unsigned char irq = 0;
+
+	irq = pci_get_irq(dev, pin);
+
+	printk(KERN_INFO "PCI: 0x%02x:0x%02x(0x%02x,0x%02x) IRQ=%d\n",
+	       dev->bus->number, dev->devfn, PCI_SLOT(dev->devfn),
+	       PCI_FUNC(dev->devfn), irq);
+
+	return irq;
+}
+
+/*
+ * Do platform specific device initialization at pci_enable_device() time
+ */
+int pcibios_plat_dev_init(struct pci_dev *dev)
+{
+	return 0;
+}
+
Index: linux/arch/mips/pci/ops-tx4938.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux/arch/mips/pci/ops-tx4938.c	2005-06-22 12:25:09.889057952 +0900
@@ -0,0 +1,199 @@
+/*
+ * Define the pci_ops for the Toshiba rbtx4938
+ * Copyright (C) 2000-2001 Toshiba Corporation
+ *
+ * 2003-2005 (c) MontaVista Software, Inc. This file is licensed under the
+ * terms of the GNU General Public License version 2. This program is
+ * licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ *
+ * Support for TX4938 in 2.6 - Manish Lachwani (mlachwani@mvista.com)
+ */
+#include <linux/types.h>
+#include <linux/pci.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/config.h>
+
+#include <asm/addrspace.h>
+#include <asm/tx4938/rbtx4938.h>
+
+/* initialize in setup */
+struct resource pci_io_resource = {
+	.name	= "pci IO space",
+	.start	= 0,
+	.end	= 0,
+	.flags	= IORESOURCE_IO
+};
+
+/* initialize in setup */
+struct resource pci_mem_resource = {
+	.name	= "pci memory space",
+	.start	= 0,
+	.end	= 0,
+	.flags	= IORESOURCE_MEM
+};
+
+struct resource tx4938_pcic1_pci_io_resource = {
+       	.name	= "PCI1 IO",
+       	.start	= 0,
+       	.end	= 0,
+       	.flags	= IORESOURCE_IO
+};
+struct resource tx4938_pcic1_pci_mem_resource = {
+       	.name	= "PCI1 mem",
+       	.start	= 0,
+       	.end	= 0,
+       	.flags	= IORESOURCE_MEM
+};
+
+static int mkaddr(int bus, int dev_fn, int where, int *flagsp)
+{
+	if (bus > 0) {
+		/* Type 1 configuration */
+		tx4938_pcicptr->g2pcfgadrs = ((bus & 0xff) << 0x10) |
+		    ((dev_fn & 0xff) << 0x08) | (where & 0xfc) | 1;
+	} else {
+		if (dev_fn >= PCI_DEVFN(TX4938_PCIC_MAX_DEVNU, 0))
+			return -1;
+
+		/* Type 0 configuration */
+		tx4938_pcicptr->g2pcfgadrs = ((bus & 0xff) << 0x10) |
+		    ((dev_fn & 0xff) << 0x08) | (where & 0xfc);
+	}
+	/* clear M_ABORT and Disable M_ABORT Int. */
+	tx4938_pcicptr->pcistatus =
+	    (tx4938_pcicptr->pcistatus & 0x0000ffff) |
+	    (PCI_STATUS_REC_MASTER_ABORT << 16);
+	tx4938_pcicptr->pcimask &= ~PCI_STATUS_REC_MASTER_ABORT;
+
+	return 0;
+}
+
+static int check_abort(int flags)
+{
+	int code = PCIBIOS_SUCCESSFUL;
+	/* wait write cycle completion before checking error status */
+	while (tx4938_pcicptr->pcicstatus & TX4938_PCIC_PCICSTATUS_IWB)
+				;
+	if (tx4938_pcicptr->pcistatus & (PCI_STATUS_REC_MASTER_ABORT << 16)) {
+		tx4938_pcicptr->pcistatus =
+		    (tx4938_pcicptr->
+		     pcistatus & 0x0000ffff) | (PCI_STATUS_REC_MASTER_ABORT
+						<< 16);
+		tx4938_pcicptr->pcimask |= PCI_STATUS_REC_MASTER_ABORT;
+		code = PCIBIOS_DEVICE_NOT_FOUND;
+	}
+	return code;
+}
+
+static int tx4938_pcibios_read_config(struct pci_bus *bus, unsigned int devfn,
+					int where, int size, u32 * val)
+{
+	int flags, retval, dev, busno, func;
+
+	dev = PCI_SLOT(devfn);
+	func = PCI_FUNC(devfn);
+
+	/* check if the bus is top-level */
+	if (bus->parent != NULL)
+		busno = bus->number;
+	else {
+		busno = 0;
+	}
+
+	if (mkaddr(busno, devfn, where, &flags))
+		return -1;
+
+	switch (size) {
+	case 1:
+		*val = *(volatile u8 *) ((ulong) & tx4938_pcicptr->g2pcfgdata |
+#ifdef __BIG_ENDIAN
+			      ((where & 3) ^ 3));
+#else
+			      (where & 3));
+#endif
+		break;
+	case 2:
+		*val = *(volatile u16 *) ((ulong) & tx4938_pcicptr->g2pcfgdata |
+#ifdef __BIG_ENDIAN
+				((where & 3) ^ 2));
+#else
+				(where & 3));
+#endif
+		break;
+	case 4:
+		*val = tx4938_pcicptr->g2pcfgdata;
+		break;
+	}
+
+	retval = check_abort(flags);
+	if (retval == PCIBIOS_DEVICE_NOT_FOUND)
+		*val = 0xffffffff;
+
+	return retval;
+}
+
+static int tx4938_pcibios_write_config(struct pci_bus *bus, unsigned int devfn, int where,
+						int size, u32 val)
+{
+	int flags, dev, busno, func;
+
+	busno = bus->number;
+	dev = PCI_SLOT(devfn);
+	func = PCI_FUNC(devfn);
+
+	/* check if the bus is top-level */
+	if (bus->parent != NULL) {
+		busno = bus->number;
+	} else {
+		busno = 0;
+	}
+
+	if (mkaddr(busno, devfn, where, &flags))
+		return -1;
+
+	switch (size) {
+	case 1:
+		*(volatile u8 *) ((ulong) & tx4938_pcicptr->g2pcfgdata |
+#ifdef __BIG_ENDIAN
+			  ((where & 3) ^ 3)) = val;
+#else
+			  (where & 3)) = val;
+#endif
+		break;
+	case 2:
+		*(volatile u16 *) ((ulong) & tx4938_pcicptr->g2pcfgdata |
+#ifdef __BIG_ENDIAN
+			((where & 0x3) ^ 0x2)) = val;
+#else
+			(where & 3)) = val;
+#endif
+		break;
+	case 4:
+		tx4938_pcicptr->g2pcfgdata = val;
+		break;
+	}
+
+	return check_abort(flags);
+}
+
+struct pci_ops tx4938_pci_ops = {
+	tx4938_pcibios_read_config,
+	tx4938_pcibios_write_config
+};
+
+struct pci_controller tx4938_pci_controller[] = {
+	/* h/w only supports devices 0x00 to 0x14 */
+	{
+		.pci_ops        = &tx4938_pci_ops,
+		.io_resource    = &pci_io_resource,
+		.mem_resource   = &pci_mem_resource,
+	},
+	/* h/w only supports devices 0x00 to 0x14 */
+	{
+		.pci_ops        = &tx4938_pci_ops,
+		.io_resource    = &tx4938_pcic1_pci_io_resource,
+		.mem_resource   = &tx4938_pcic1_pci_mem_resource,
+        }
+};
Index: linux/arch/mips/tx4938/common/Makefile
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux/arch/mips/tx4938/common/Makefile	2005-06-22 12:25:09.889057952 +0900
@@ -0,0 +1,10 @@
+#
+# Makefile for common code for Toshiba TX4927 based systems
+#
+# Note! Dependencies are done automagically by 'make dep', which also
+# removes any old dependencies. DON'T put your own dependencies here
+# unless it's something special (ie not a .c file).
+#
+
+obj-y	+= prom.o setup.o irq.o irq_handler.o rtc_rx5c348.o
+
Index: linux/arch/mips/tx4938/common/irq.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux/arch/mips/tx4938/common/irq.c	2005-06-22 12:25:09.890057800 +0900
@@ -0,0 +1,447 @@
+/*
+ * linux/arch/mps/tx4938/common/irq.c
+ *
+ * Common tx4938 irq handler
+ * Copyright (C) 2000-2001 Toshiba Corporation
+ *
+ * 2003-2005 (c) MontaVista Software, Inc. This file is licensed under the
+ * terms of the GNU General Public License version 2. This program is
+ * licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ *
+ * Support for TX4938 in 2.6 - Manish Lachwani (mlachwani@mvista.com)
+ */
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/kernel_stat.h>
+#include <linux/module.h>
+#include <linux/signal.h>
+#include <linux/sched.h>
+#include <linux/types.h>
+#include <linux/interrupt.h>
+#include <linux/ioport.h>
+#include <linux/timex.h>
+#include <linux/slab.h>
+#include <linux/random.h>
+#include <linux/irq.h>
+#include <asm/bitops.h>
+#include <asm/bootinfo.h>
+#include <asm/io.h>
+#include <asm/irq.h>
+#include <asm/mipsregs.h>
+#include <asm/system.h>
+#include <asm/tx4938/rbtx4938.h>
+
+/**********************************************************************************/
+/* Forwad definitions for all pic's                                               */
+/**********************************************************************************/
+
+static unsigned int tx4938_irq_cp0_startup(unsigned int irq);
+static void tx4938_irq_cp0_shutdown(unsigned int irq);
+static void tx4938_irq_cp0_enable(unsigned int irq);
+static void tx4938_irq_cp0_disable(unsigned int irq);
+static void tx4938_irq_cp0_mask_and_ack(unsigned int irq);
+static void tx4938_irq_cp0_end(unsigned int irq);
+
+static unsigned int tx4938_irq_pic_startup(unsigned int irq);
+static void tx4938_irq_pic_shutdown(unsigned int irq);
+static void tx4938_irq_pic_enable(unsigned int irq);
+static void tx4938_irq_pic_disable(unsigned int irq);
+static void tx4938_irq_pic_mask_and_ack(unsigned int irq);
+static void tx4938_irq_pic_end(unsigned int irq);
+
+/**********************************************************************************/
+/* Kernel structs for all pic's                                                   */
+/**********************************************************************************/
+DEFINE_SPINLOCK(tx4938_cp0_lock);
+DEFINE_SPINLOCK(tx4938_pic_lock);
+
+#define TX4938_CP0_NAME "TX4938-CP0"
+static struct hw_interrupt_type tx4938_irq_cp0_type = {
+	.typename = TX4938_CP0_NAME,
+	.startup = tx4938_irq_cp0_startup,
+	.shutdown = tx4938_irq_cp0_shutdown,
+	.enable = tx4938_irq_cp0_enable,
+	.disable = tx4938_irq_cp0_disable,
+	.ack = tx4938_irq_cp0_mask_and_ack,
+	.end = tx4938_irq_cp0_end,
+	.set_affinity = NULL
+};
+
+#define TX4938_PIC_NAME "TX4938-PIC"
+static struct hw_interrupt_type tx4938_irq_pic_type = {
+	.typename = TX4938_PIC_NAME,
+	.startup = tx4938_irq_pic_startup,
+	.shutdown = tx4938_irq_pic_shutdown,
+	.enable = tx4938_irq_pic_enable,
+	.disable = tx4938_irq_pic_disable,
+	.ack = tx4938_irq_pic_mask_and_ack,
+	.end = tx4938_irq_pic_end,
+	.set_affinity = NULL
+};
+
+#define TX4938_PIC_ACTION(s) { no_action, 0, 0, s, NULL, NULL }
+static struct irqaction tx4938_irq_pic_action =
+TX4938_PIC_ACTION(TX4938_PIC_NAME);
+
+/**********************************************************************************/
+/* Functions for cp0                                                              */
+/**********************************************************************************/
+
+#define tx4938_irq_cp0_mask(irq) ( 1 << ( irq-TX4938_IRQ_CP0_BEG+8 ) )
+
+static void
+tx4938_irq_cp0_cause(unsigned clr_bits, unsigned set_bits)
+{
+	unsigned long val = read_c0_cause();
+
+	val &= (~clr_bits);
+	val |= (set_bits);
+
+	write_c0_cause(val);
+}
+
+static void
+tx4938_irq_cp0_status(unsigned clr_bits, unsigned set_bits)
+{
+	unsigned long val = read_c0_status();
+
+	val &= (~clr_bits);
+	val |= (set_bits);
+
+	write_c0_status(val);
+}
+
+static void __init
+tx4938_irq_cp0_init(void)
+{
+	int i;
+
+	for (i = TX4938_IRQ_CP0_BEG; i <= TX4938_IRQ_CP0_END; i++) {
+		irq_desc[i].status = IRQ_DISABLED;
+		irq_desc[i].action = 0;
+		irq_desc[i].depth = 1;
+		irq_desc[i].handler = &tx4938_irq_cp0_type;
+	}
+
+	return;
+}
+
+static unsigned int
+tx4938_irq_cp0_startup(unsigned int irq)
+{
+	tx4938_irq_cp0_enable(irq);
+
+	return (0);
+}
+
+static void
+tx4938_irq_cp0_shutdown(unsigned int irq)
+{
+	tx4938_irq_cp0_disable(irq);
+
+	return;
+}
+
+static void
+tx4938_irq_cp0_enable(unsigned int irq)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&tx4938_cp0_lock, flags);
+
+	tx4938_irq_cp0_status(0, tx4938_irq_cp0_mask(irq));
+
+	spin_unlock_irqrestore(&tx4938_cp0_lock, flags);
+
+	return;
+}
+
+static void
+tx4938_irq_cp0_disable(unsigned int irq)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&tx4938_cp0_lock, flags);
+
+	tx4938_irq_cp0_status(tx4938_irq_cp0_mask(irq), 0);
+
+	spin_unlock_irqrestore(&tx4938_cp0_lock, flags);
+
+	return;
+}
+
+static void
+tx4938_irq_cp0_mask_and_ack(unsigned int irq)
+{
+	tx4938_irq_cp0_disable(irq);
+
+	return;
+}
+
+static void
+tx4938_irq_cp0_end(unsigned int irq)
+{
+	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS))) {
+		tx4938_irq_cp0_enable(irq);
+	}
+
+	return;
+}
+
+/**********************************************************************************/
+/* Functions for pic                                                              */
+/**********************************************************************************/
+
+u32
+tx4938_irq_pic_addr(int irq)
+{
+	/* MVMCP -- need to formulize this */
+	irq -= TX4938_IRQ_PIC_BEG;
+
+	switch (irq) {
+	case 17:
+	case 16:
+	case 1:
+	case 0:{
+			return (TX4938_MKA(TX4938_IRC_IRLVL0));
+		}
+	case 19:
+	case 18:
+	case 3:
+	case 2:{
+			return (TX4938_MKA(TX4938_IRC_IRLVL1));
+		}
+	case 21:
+	case 20:
+	case 5:
+	case 4:{
+			return (TX4938_MKA(TX4938_IRC_IRLVL2));
+		}
+	case 23:
+	case 22:
+	case 7:
+	case 6:{
+			return (TX4938_MKA(TX4938_IRC_IRLVL3));
+		}
+	case 25:
+	case 24:
+	case 9:
+	case 8:{
+			return (TX4938_MKA(TX4938_IRC_IRLVL4));
+		}
+	case 27:
+	case 26:
+	case 11:
+	case 10:{
+			return (TX4938_MKA(TX4938_IRC_IRLVL5));
+		}
+	case 29:
+	case 28:
+	case 13:
+	case 12:{
+			return (TX4938_MKA(TX4938_IRC_IRLVL6));
+		}
+	case 31:
+	case 30:
+	case 15:
+	case 14:{
+			return (TX4938_MKA(TX4938_IRC_IRLVL7));
+		}
+	}
+
+	return (0);
+}
+
+u32
+tx4938_irq_pic_mask(int irq)
+{
+	/* MVMCP -- need to formulize this */
+	irq -= TX4938_IRQ_PIC_BEG;
+
+	switch (irq) {
+	case 31:
+	case 29:
+	case 27:
+	case 25:
+	case 23:
+	case 21:
+	case 19:
+	case 17:{
+			return (0x07000000);
+		}
+	case 30:
+	case 28:
+	case 26:
+	case 24:
+	case 22:
+	case 20:
+	case 18:
+	case 16:{
+			return (0x00070000);
+		}
+	case 15:
+	case 13:
+	case 11:
+	case 9:
+	case 7:
+	case 5:
+	case 3:
+	case 1:{
+			return (0x00000700);
+		}
+	case 14:
+	case 12:
+	case 10:
+	case 8:
+	case 6:
+	case 4:
+	case 2:
+	case 0:{
+			return (0x00000007);
+		}
+	}
+	return (0x00000000);
+}
+
+static void
+tx4938_irq_pic_modify(unsigned pic_reg, unsigned clr_bits, unsigned set_bits)
+{
+	unsigned long val = 0;
+
+	val = TX4938_RD(pic_reg);
+	val &= (~clr_bits);
+	val |= (set_bits);
+	TX4938_WR(pic_reg, val);
+	mmiowb();
+	TX4938_RD(pic_reg);
+
+	return;
+}
+
+static void __init
+tx4938_irq_pic_init(void)
+{
+	unsigned long flags;
+	int i;
+
+	for (i = TX4938_IRQ_PIC_BEG; i <= TX4938_IRQ_PIC_END; i++) {
+		irq_desc[i].status = IRQ_DISABLED;
+		irq_desc[i].action = 0;
+		irq_desc[i].depth = 2;
+		irq_desc[i].handler = &tx4938_irq_pic_type;
+	}
+
+	setup_irq(TX4938_IRQ_NEST_PIC_ON_CP0, &tx4938_irq_pic_action);
+
+	spin_lock_irqsave(&tx4938_pic_lock, flags);
+
+	TX4938_WR(0xff1ff640, 0x6);	/* irq level mask -- only accept hightest */
+	TX4938_WR(0xff1ff600, TX4938_RD(0xff1ff600) | 0x1);	/* irq enable */
+
+	spin_unlock_irqrestore(&tx4938_pic_lock, flags);
+
+	return;
+}
+
+static unsigned int
+tx4938_irq_pic_startup(unsigned int irq)
+{
+	tx4938_irq_pic_enable(irq);
+
+	return (0);
+}
+
+static void
+tx4938_irq_pic_shutdown(unsigned int irq)
+{
+	tx4938_irq_pic_disable(irq);
+
+	return;
+}
+
+static void
+tx4938_irq_pic_enable(unsigned int irq)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&tx4938_pic_lock, flags);
+
+	tx4938_irq_pic_modify(tx4938_irq_pic_addr(irq), 0,
+			      tx4938_irq_pic_mask(irq));
+
+	spin_unlock_irqrestore(&tx4938_pic_lock, flags);
+
+	return;
+}
+
+static void
+tx4938_irq_pic_disable(unsigned int irq)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&tx4938_pic_lock, flags);
+
+	tx4938_irq_pic_modify(tx4938_irq_pic_addr(irq),
+			      tx4938_irq_pic_mask(irq), 0);
+
+	spin_unlock_irqrestore(&tx4938_pic_lock, flags);
+
+	return;
+}
+
+static void
+tx4938_irq_pic_mask_and_ack(unsigned int irq)
+{
+	tx4938_irq_pic_disable(irq);
+
+	return;
+}
+
+static void
+tx4938_irq_pic_end(unsigned int irq)
+{
+	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS))) {
+		tx4938_irq_pic_enable(irq);
+	}
+
+	return;
+}
+
+/**********************************************************************************/
+/* Main init functions                                                            */
+/**********************************************************************************/
+
+void __init
+tx4938_irq_init(void)
+{
+	extern asmlinkage void tx4938_irq_handler(void);
+
+	tx4938_irq_cp0_init();
+	tx4938_irq_pic_init();
+	set_except_vector(0, tx4938_irq_handler);
+
+	return;
+}
+
+int
+tx4938_irq_nested(void)
+{
+	int sw_irq = 0;
+	u32 level2;
+
+	level2 = TX4938_RD(0xff1ff6a0);
+	if ((level2 & 0x10000) == 0) {
+		level2 &= 0x1f;
+		sw_irq = TX4938_IRQ_PIC_BEG + level2;
+		if (sw_irq == 26) {
+			{
+				extern int toshiba_rbtx4938_irq_nested(int sw_irq);
+				sw_irq = toshiba_rbtx4938_irq_nested(sw_irq);
+			}
+		}
+	}
+
+	wbflush();
+	return (sw_irq);
+}
Index: linux/arch/mips/tx4938/common/irq_handler.S
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux/arch/mips/tx4938/common/irq_handler.S	2005-06-22 12:25:09.890057800 +0900
@@ -0,0 +1,86 @@
+/*
+ * linux/arch/mips/tx4938/common/handler.S
+ *
+ * Primary interrupt handler for tx4938 based systems
+ * Copyright (C) 2000-2001 Toshiba Corporation
+ *
+ * 2003-2005 (c) MontaVista Software, Inc. This file is licensed under the
+ * terms of the GNU General Public License version 2. This program is
+ * licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ *
+ * Support for TX4938 in 2.6 - Manish Lachwani (mlachwani@mvista.com)
+ */
+#include <linux/config.h>
+#include <asm/asm.h>
+#include <asm/mipsregs.h>
+#include <asm/addrspace.h>
+#include <asm/regdef.h>
+#include <asm/stackframe.h>
+#include <asm/tx4938/rbtx4938.h>
+
+
+		.align	5
+		NESTED(tx4938_irq_handler, PT_SIZE, sp)
+		SAVE_ALL
+		CLI
+		.set	at
+
+		mfc0	t0, CP0_CAUSE
+		mfc0	t1, CP0_STATUS
+		and	t0, t1
+
+		andi	t1, t0, STATUSF_IP7	/* cpu timer */
+		bnez	t1, ll_ip7
+
+		/* IP6..IP3 multiplexed -- do not use */
+
+		andi	t1, t0, STATUSF_IP2	/* tx4938 pic */
+		bnez	t1, ll_ip2
+
+		andi	t1, t0, STATUSF_IP1	/* user line 1 */
+		bnez	t1, ll_ip1
+
+		andi	t1, t0, STATUSF_IP0	/* user line 0 */
+		bnez	t1, ll_ip0
+
+		.set	reorder
+
+		nop
+		END(tx4938_irq_handler)
+
+		.align	5
+
+
+ll_ip7:
+		li	a0, TX4938_IRQ_CPU_TIMER
+		move	a1, sp
+		jal	do_IRQ
+		j	ret_from_irq
+
+
+ll_ip2:
+		jal	tx4938_irq_nested
+		nop
+		beqz	v0, goto_spurious_interrupt
+		nop
+		move	a0, v0
+		move	a1, sp
+		jal	do_IRQ
+		j	ret_from_irq
+
+goto_spurious_interrupt:
+		nop
+		j	ret_from_irq
+
+ll_ip1:
+		li	a0, TX4938_IRQ_USER1
+		move	a1, sp
+		jal	do_IRQ
+		j	ret_from_irq
+
+ll_ip0:
+		li	a0, TX4938_IRQ_USER0
+		move	a1, sp
+		jal	do_IRQ
+		j	ret_from_irq
Index: linux/arch/mips/tx4938/common/prom.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux/arch/mips/tx4938/common/prom.c	2005-06-22 12:25:09.890057800 +0900
@@ -0,0 +1,129 @@
+/*
+ * linux/arch/mips/tx4938/common/prom.c
+ *
+ * common tx4938 memory interface
+ * Copyright (C) 2000-2001 Toshiba Corporation
+ *
+ * 2003-2005 (c) MontaVista Software, Inc. This file is licensed under the
+ * terms of the GNU General Public License version 2. This program is
+ * licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ *
+ * Support for TX4938 in 2.6 - Manish Lachwani (mlachwani@mvista.com)
+ */
+
+#include <linux/init.h>
+#include <linux/mm.h>
+#include <linux/sched.h>
+#include <linux/bootmem.h>
+
+#include <asm/addrspace.h>
+#include <asm/bootinfo.h>
+#include <asm/tx4938/tx4938.h>
+
+static unsigned int __init
+tx4938_process_sdccr(u64 * addr)
+{
+	u64 val;
+	unsigned int sdccr_ce;
+	unsigned int sdccr_rs;
+	unsigned int sdccr_cs;
+	unsigned int sdccr_mw;
+	unsigned int rs = 0;
+	unsigned int cs = 0;
+	unsigned int mw = 0;
+	unsigned int bc = 4;
+	unsigned int msize = 0;
+
+	val = (*((vu64 *) (addr)));
+
+	/* MVMCP -- need #defs for these bits masks */
+	sdccr_ce = ((val & (1 << 10)) >> 10);
+	sdccr_rs = ((val & (3 << 5)) >> 5);
+	sdccr_cs = ((val & (7 << 2)) >> 2);
+	sdccr_mw = ((val & (1 << 0)) >> 0);
+
+	if (sdccr_ce) {
+		switch (sdccr_rs) {
+		case 0:{
+				rs = 2048;
+				break;
+			}
+		case 1:{
+				rs = 4096;
+				break;
+			}
+		case 2:{
+				rs = 8192;
+				break;
+			}
+		default:{
+				rs = 0;
+				break;
+			}
+		}
+		switch (sdccr_cs) {
+		case 0:{
+				cs = 256;
+				break;
+			}
+		case 1:{
+				cs = 512;
+				break;
+			}
+		case 2:{
+				cs = 1024;
+				break;
+			}
+		case 3:{
+				cs = 2048;
+				break;
+			}
+		case 4:{
+				cs = 4096;
+				break;
+			}
+		default:{
+				cs = 0;
+				break;
+			}
+		}
+		switch (sdccr_mw) {
+		case 0:{
+				mw = 8;
+				break;
+			}	/* 8 bytes = 64 bits */
+		case 1:{
+				mw = 4;
+				break;
+			}	/* 4 bytes = 32 bits */
+		}
+	}
+
+	/*           bytes per chip    MB per chip          bank count */
+	msize = (((rs * cs * mw) / (1024 * 1024)) * (bc));
+
+	/* MVMCP -- bc hard coded to 4 from table 9.3.1     */
+	/*          boad supports bc=2 but no way to detect */
+
+	return (msize);
+}
+
+unsigned int __init
+tx4938_get_mem_size(void)
+{
+	unsigned int c0;
+	unsigned int c1;
+	unsigned int c2;
+	unsigned int c3;
+	unsigned int total;
+
+	/* MVMCP -- need #defs for these registers */
+	c0 = tx4938_process_sdccr((u64 *) 0xff1f8000);
+	c1 = tx4938_process_sdccr((u64 *) 0xff1f8008);
+	c2 = tx4938_process_sdccr((u64 *) 0xff1f8010);
+	c3 = tx4938_process_sdccr((u64 *) 0xff1f8018);
+	total = c0 + c1 + c2 + c3;
+
+	return (total);
+}
Index: linux/arch/mips/tx4938/common/rtc_rx5c348.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux/arch/mips/tx4938/common/rtc_rx5c348.c	2005-06-22 12:25:09.891057648 +0900
@@ -0,0 +1,202 @@
+/*
+ * RTC routines for RICOH Rx5C348 SPI chip.
+ * Copyright (C) 2000-2001 Toshiba Corporation
+ *
+ * 2003-2005 (c) MontaVista Software, Inc. This file is licensed under the
+ * terms of the GNU General Public License version 2. This program is
+ * licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ *
+ * Support for TX4938 in 2.6 - Manish Lachwani (mlachwani@mvista.com)
+ */
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/rtc.h>
+#include <linux/time.h>
+#include <asm/time.h>
+#include <asm/tx4938/spi.h>
+
+#define	EPOCH		2000
+
+/* registers */
+#define Rx5C348_REG_SECOND	0
+#define Rx5C348_REG_MINUTE	1
+#define Rx5C348_REG_HOUR	2
+#define Rx5C348_REG_WEEK	3
+#define Rx5C348_REG_DAY	4
+#define Rx5C348_REG_MONTH	5
+#define Rx5C348_REG_YEAR	6
+#define Rx5C348_REG_ADJUST	7
+#define Rx5C348_REG_ALARM_W_MIN	8
+#define Rx5C348_REG_ALARM_W_HOUR	9
+#define Rx5C348_REG_ALARM_W_WEEK	10
+#define Rx5C348_REG_ALARM_D_MIN	11
+#define Rx5C348_REG_ALARM_D_HOUR	12
+#define Rx5C348_REG_CTL1	14
+#define Rx5C348_REG_CTL2	15
+
+/* register bits */
+#define Rx5C348_BIT_PM	0x20	/* REG_HOUR */
+#define Rx5C348_BIT_Y2K	0x80	/* REG_MONTH */
+#define Rx5C348_BIT_24H	0x20	/* REG_CTL1 */
+#define Rx5C348_BIT_XSTP	0x10	/* REG_CTL2 */
+
+/* commands */
+#define Rx5C348_CMD_W(addr)	(((addr) << 4) | 0x08)	/* single write */
+#define Rx5C348_CMD_R(addr)	(((addr) << 4) | 0x0c)	/* single read */
+#define Rx5C348_CMD_MW(addr)	(((addr) << 4) | 0x00)	/* burst write */
+#define Rx5C348_CMD_MR(addr)	(((addr) << 4) | 0x04)	/* burst read */
+
+static struct spi_dev_desc srtc_dev_desc = {
+	.baud 		= 1000000,	/* 1.0Mbps @ Vdd 2.0V */
+	.tcss		= 31,
+	.tcsh		= 1,
+	.tcsr		= 62,
+	/* 31us for Tcss (62us for Tcsr) is required for carry operation) */
+	.byteorder	= 1,		/* MSB-First */
+	.polarity	= 0,		/* High-Active */
+	.phase		= 1,		/* Shift-Then-Sample */
+
+};
+static int srtc_chipid;
+static int srtc_24h;
+
+static inline int
+spi_rtc_io(unsigned char *inbuf, unsigned char *outbuf, unsigned int count)
+{
+	unsigned char *inbufs[1], *outbufs[1];
+	unsigned int incounts[2], outcounts[2];
+	inbufs[0] = inbuf;
+	incounts[0] = count;
+	incounts[1] = 0;
+	outbufs[0] = outbuf;
+	outcounts[0] = count;
+	outcounts[1] = 0;
+	return txx9_spi_io(srtc_chipid, &srtc_dev_desc,
+			   inbufs, incounts, outbufs, outcounts, 0);
+}
+
+/*
+ * Conversion between binary and BCD.
+ */
+#ifndef BCD_TO_BIN
+#define BCD_TO_BIN(val) ((val)=((val)&15) + ((val)>>4)*10)
+#endif
+
+#ifndef BIN_TO_BCD
+#define BIN_TO_BCD(val) ((val)=(((val)/10)<<4) + (val)%10)
+#endif
+
+/* RTC-dependent code for time.c */
+
+static int
+rtc_rx5c348_set_time(unsigned long t)
+{
+	unsigned char inbuf[8];
+	struct rtc_time tm;
+	u8 year, month, day, hour, minute, second, century;
+
+	/* convert */
+	to_tm(t, &tm);
+
+	year = tm.tm_year % 100;
+	month = tm.tm_mon+1;	/* tm_mon starts from 0 to 11 */
+	day = tm.tm_mday;
+	hour = tm.tm_hour;
+	minute = tm.tm_min;
+	second = tm.tm_sec;
+	century = tm.tm_year / 100;
+
+	inbuf[0] = Rx5C348_CMD_MW(Rx5C348_REG_SECOND);
+	BIN_TO_BCD(second);
+	inbuf[1] = second;
+	BIN_TO_BCD(minute);
+	inbuf[2] = minute;
+
+	if (srtc_24h) {
+		BIN_TO_BCD(hour);
+		inbuf[3] = hour;
+	} else {
+		/* hour 0 is AM12, noon is PM12 */
+		inbuf[3] = 0;
+		if (hour >= 12)
+			inbuf[3] = Rx5C348_BIT_PM;
+		hour = (hour + 11) % 12 + 1;
+		BIN_TO_BCD(hour);
+		inbuf[3] |= hour;
+	}
+	inbuf[4] = 0;	/* ignore week */
+	BIN_TO_BCD(day);
+	inbuf[5] = day;
+	BIN_TO_BCD(month);
+	inbuf[6] = month;
+	if (century >= 20)
+		inbuf[6] |= Rx5C348_BIT_Y2K;
+	BIN_TO_BCD(year);
+	inbuf[7] = year;
+	/* write in one transfer to avoid data inconsistency */
+	return spi_rtc_io(inbuf, NULL, 8);
+}
+
+static unsigned long
+rtc_rx5c348_get_time(void)
+{
+	unsigned char inbuf[8], outbuf[8];
+	unsigned int year, month, day, hour, minute, second;
+
+	inbuf[0] = Rx5C348_CMD_MR(Rx5C348_REG_SECOND);
+	memset(inbuf + 1, 0, 7);
+	/* read in one transfer to avoid data inconsistency */
+	if (spi_rtc_io(inbuf, outbuf, 8))
+		return 0;
+	second = outbuf[1];
+	BCD_TO_BIN(second);
+	minute = outbuf[2];
+	BCD_TO_BIN(minute);
+	if (srtc_24h) {
+		hour = outbuf[3];
+		BCD_TO_BIN(hour);
+	} else {
+		hour = outbuf[3] & ~Rx5C348_BIT_PM;
+		BCD_TO_BIN(hour);
+		hour %= 12;
+		if (outbuf[3] & Rx5C348_BIT_PM)
+			hour += 12;
+	}
+	day = outbuf[5];
+	BCD_TO_BIN(day);
+	month = outbuf[6] & ~Rx5C348_BIT_Y2K;
+	BCD_TO_BIN(month);
+	year = outbuf[7];
+	BCD_TO_BIN(year);
+	year += EPOCH;
+
+	return mktime(year, month, day, hour, minute, second);
+}
+
+void __init
+rtc_rx5c348_init(int chipid)
+{
+	unsigned char inbuf[2], outbuf[2];
+	srtc_chipid = chipid;
+	/* turn on RTC if it is not on */
+	inbuf[0] = Rx5C348_CMD_R(Rx5C348_REG_CTL2);
+	inbuf[1] = 0;
+	spi_rtc_io(inbuf, outbuf, 2);
+	if (outbuf[1] & Rx5C348_BIT_XSTP) {
+		inbuf[0] = Rx5C348_CMD_W(Rx5C348_REG_CTL2);
+		inbuf[1] = 0;
+		spi_rtc_io(inbuf, NULL, 2);
+	}
+
+	inbuf[0] = Rx5C348_CMD_R(Rx5C348_REG_CTL1);
+	inbuf[1] = 0;
+	spi_rtc_io(inbuf, outbuf, 2);
+	if (outbuf[1] & Rx5C348_BIT_24H)
+		srtc_24h = 1;
+
+	/* set the function pointers */
+	rtc_get_time = rtc_rx5c348_get_time;
+	rtc_set_time = rtc_rx5c348_set_time;
+}
Index: linux/arch/mips/tx4938/common/setup.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux/arch/mips/tx4938/common/setup.c	2005-06-22 12:25:09.891057648 +0900
@@ -0,0 +1,97 @@
+/*
+ * linux/arch/mips/tx4938/common/setup.c
+ *
+ * common tx4938 setup routines
+ *
+ * 2003-2005 (c) MontaVista Software, Inc. This file is licensed under the
+ * terms of the GNU General Public License version 2. This program is
+ * licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ *
+ * Support for TX4938 in 2.6 - Manish Lachwani (mlachwani@mvista.com)
+ */
+
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/kernel_stat.h>
+#include <linux/module.h>
+#include <linux/signal.h>
+#include <linux/sched.h>
+#include <linux/types.h>
+#include <linux/interrupt.h>
+#include <linux/ioport.h>
+#include <linux/timex.h>
+#include <linux/slab.h>
+#include <linux/random.h>
+#include <linux/irq.h>
+#include <asm/bitops.h>
+#include <asm/bootinfo.h>
+#include <asm/io.h>
+#include <asm/irq.h>
+#include <asm/mipsregs.h>
+#include <asm/system.h>
+#include <asm/time.h>
+#include <asm/time.h>
+#include <asm/tx4938/rbtx4938.h>
+
+extern void toshiba_rbtx4938_setup(void);
+extern void rbtx4938_time_init(void);
+
+void __init tx4938_setup(void);
+void __init tx4938_time_init(void);
+void __init tx4938_timer_setup(struct irqaction *irq);
+void dump_cp0(char *key);
+
+void (*__wbflush) (void);
+
+static void
+tx4938_write_buffer_flush(void)
+{
+	mmiowb();
+
+	__asm__ __volatile__(
+		".set	push\n\t"
+		".set	noreorder\n\t"
+		"lw	$0,%0\n\t"
+		"nop\n\t"
+		".set	pop"
+		: /* no output */
+		: "m" (*(int *)KSEG1)
+		: "memory");
+}
+
+void __init
+plat_setup(void)
+{
+	board_time_init = tx4938_time_init;
+	board_timer_setup = tx4938_timer_setup;
+	__wbflush = tx4938_write_buffer_flush;
+	toshiba_rbtx4938_setup();
+
+	return;
+}
+
+void __init
+tx4938_time_init(void)
+{
+	rbtx4938_time_init();
+	return;
+}
+
+void __init
+tx4938_timer_setup(struct irqaction *irq)
+{
+	u32 count;
+	u32 c1;
+	u32 c2;
+
+	setup_irq(TX4938_IRQ_CPU_TIMER, irq);
+
+	c1 = read_c0_count();
+	count = c1 + (mips_hpt_frequency / HZ);
+	write_c0_compare(count);
+	c2 = read_c0_count();
+
+	return;
+}
+
Index: linux/arch/mips/tx4938/toshiba_rbtx4938/Makefile
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux/arch/mips/tx4938/toshiba_rbtx4938/Makefile	2005-06-22 12:25:09.891057648 +0900
@@ -0,0 +1,9 @@
+#
+# Makefile for common code for Toshiba TX4927 based systems
+#
+# Note! Dependencies are done automagically by 'make dep', which also
+# removes any old dependencies. DON'T put your own dependencies here
+# unless it's something special (ie not a .c file).
+#
+
+obj-y	+= prom.o setup.o irq.o spi_eeprom.o spi_txx9.o
Index: linux/arch/mips/tx4938/toshiba_rbtx4938/irq.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux/arch/mips/tx4938/toshiba_rbtx4938/irq.c	2005-06-22 12:25:09.892057496 +0900
@@ -0,0 +1,275 @@
+/*
+ * linux/arch/mips/tx4938/toshiba_rbtx4938/irq.c
+ *
+ * Toshiba RBTX4938 specific interrupt handlers
+ * Copyright (C) 2000-2001 Toshiba Corporation
+ *
+ * 2003-2005 (c) MontaVista Software, Inc. This file is licensed under the
+ * terms of the GNU General Public License version 2. This program is
+ * licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ *
+ * Support for TX4938 in 2.6 - Manish Lachwani (mlachwani@mvista.com)
+ */
+
+/*
+IRQ  Device
+
+16   TX4938-CP0/00 Software 0
+17   TX4938-CP0/01 Software 1
+18   TX4938-CP0/02 Cascade TX4938-CP0
+19   TX4938-CP0/03 Multiplexed -- do not use
+20   TX4938-CP0/04 Multiplexed -- do not use
+21   TX4938-CP0/05 Multiplexed -- do not use
+22   TX4938-CP0/06 Multiplexed -- do not use
+23   TX4938-CP0/07 CPU TIMER
+
+24   TX4938-PIC/00
+25   TX4938-PIC/01
+26   TX4938-PIC/02 Cascade RBTX4938-IOC
+27   TX4938-PIC/03 RBTX4938 RTL-8019AS Ethernet
+28   TX4938-PIC/04
+29   TX4938-PIC/05 TX4938 ETH1
+30   TX4938-PIC/06 TX4938 ETH0
+31   TX4938-PIC/07
+32   TX4938-PIC/08 TX4938 SIO 0
+33   TX4938-PIC/09 TX4938 SIO 1
+34   TX4938-PIC/10 TX4938 DMA0
+35   TX4938-PIC/11 TX4938 DMA1
+36   TX4938-PIC/12 TX4938 DMA2
+37   TX4938-PIC/13 TX4938 DMA3
+38   TX4938-PIC/14
+39   TX4938-PIC/15
+40   TX4938-PIC/16 TX4938 PCIC
+41   TX4938-PIC/17 TX4938 TMR0
+42   TX4938-PIC/18 TX4938 TMR1
+43   TX4938-PIC/19 TX4938 TMR2
+44   TX4938-PIC/20
+45   TX4938-PIC/21
+46   TX4938-PIC/22 TX4938 PCIERR
+47   TX4938-PIC/23
+48   TX4938-PIC/24
+49   TX4938-PIC/25
+50   TX4938-PIC/26
+51   TX4938-PIC/27
+52   TX4938-PIC/28
+53   TX4938-PIC/29
+54   TX4938-PIC/30
+55   TX4938-PIC/31 TX4938 SPI
+
+56 RBTX4938-IOC/00 PCI-D
+57 RBTX4938-IOC/01 PCI-C
+58 RBTX4938-IOC/02 PCI-B
+59 RBTX4938-IOC/03 PCI-A
+60 RBTX4938-IOC/04 RTC
+61 RBTX4938-IOC/05 ATA
+62 RBTX4938-IOC/06 MODEM
+63 RBTX4938-IOC/07 SWINT
+*/
+
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/mm.h>
+#include <linux/swap.h>
+#include <linux/ioport.h>
+#include <linux/sched.h>
+#include <linux/interrupt.h>
+#include <linux/pci.h>
+#include <linux/timex.h>
+#include <asm/bootinfo.h>
+#include <asm/page.h>
+#include <asm/bootinfo.h>
+#include <asm/io.h>
+#include <asm/irq.h>
+#include <asm/pci.h>
+#include <asm/processor.h>
+#include <asm/ptrace.h>
+#include <asm/reboot.h>
+#include <asm/time.h>
+#include <linux/version.h>
+#include <linux/bootmem.h>
+#include <asm/tx4938/rbtx4938.h>
+
+static unsigned int toshiba_rbtx4938_irq_ioc_startup(unsigned int irq);
+static void toshiba_rbtx4938_irq_ioc_shutdown(unsigned int irq);
+static void toshiba_rbtx4938_irq_ioc_enable(unsigned int irq);
+static void toshiba_rbtx4938_irq_ioc_disable(unsigned int irq);
+static void toshiba_rbtx4938_irq_ioc_mask_and_ack(unsigned int irq);
+static void toshiba_rbtx4938_irq_ioc_end(unsigned int irq);
+
+DEFINE_SPINLOCK(toshiba_rbtx4938_ioc_lock);
+
+#define TOSHIBA_RBTX4938_IOC_NAME "RBTX4938-IOC"
+static struct hw_interrupt_type toshiba_rbtx4938_irq_ioc_type = {
+	.typename = TOSHIBA_RBTX4938_IOC_NAME,
+	.startup = toshiba_rbtx4938_irq_ioc_startup,
+	.shutdown = toshiba_rbtx4938_irq_ioc_shutdown,
+	.enable = toshiba_rbtx4938_irq_ioc_enable,
+	.disable = toshiba_rbtx4938_irq_ioc_disable,
+	.ack = toshiba_rbtx4938_irq_ioc_mask_and_ack,
+	.end = toshiba_rbtx4938_irq_ioc_end,
+	.set_affinity = NULL
+};
+
+#define TOSHIBA_RBTX4938_IOC_INTR_ENAB 0xb7f02000
+#define TOSHIBA_RBTX4938_IOC_INTR_STAT 0xb7f0200a
+
+u8
+last_bit2num(u8 num)
+{
+	u8 i = ((sizeof(num)*8)-1);
+
+	do
+	{
+		if ( num & (1<<i) )
+		{
+		  break;
+		}
+	} while ( --i );
+
+	return( i );
+}
+
+int
+toshiba_rbtx4938_irq_nested(int sw_irq)
+{
+	u8 level3;
+
+	level3 = reg_rd08(TOSHIBA_RBTX4938_IOC_INTR_STAT) & 0xff;
+	if (level3) {
+                /* must use last_bit2num so onboard ATA has priority */
+		sw_irq = TOSHIBA_RBTX4938_IRQ_IOC_BEG + last_bit2num(level3);
+	}
+
+	wbflush();
+	return (sw_irq);
+}
+
+#define TOSHIBA_RBTX4938_PIC_ACTION(s) { no_action, 0, 0, s, NULL, NULL }
+static struct irqaction toshiba_rbtx4938_irq_ioc_action =
+TOSHIBA_RBTX4938_PIC_ACTION(TOSHIBA_RBTX4938_IOC_NAME);
+
+/**********************************************************************************/
+/* Functions for ioc                                                              */
+/**********************************************************************************/
+static void __init
+toshiba_rbtx4938_irq_ioc_init(void)
+{
+	int i;
+
+	for (i = TOSHIBA_RBTX4938_IRQ_IOC_BEG;
+	     i <= TOSHIBA_RBTX4938_IRQ_IOC_END; i++) {
+		irq_desc[i].status = IRQ_DISABLED;
+		irq_desc[i].action = 0;
+		irq_desc[i].depth = 3;
+		irq_desc[i].handler = &toshiba_rbtx4938_irq_ioc_type;
+	}
+
+	setup_irq(RBTX4938_IRQ_IOCINT,
+		  &toshiba_rbtx4938_irq_ioc_action);
+
+	return;
+}
+
+static unsigned int
+toshiba_rbtx4938_irq_ioc_startup(unsigned int irq)
+{
+	toshiba_rbtx4938_irq_ioc_enable(irq);
+
+	return (0);
+}
+
+static void
+toshiba_rbtx4938_irq_ioc_shutdown(unsigned int irq)
+{
+	toshiba_rbtx4938_irq_ioc_disable(irq);
+
+	return;
+}
+
+static void
+toshiba_rbtx4938_irq_ioc_enable(unsigned int irq)
+{
+	unsigned long flags;
+	volatile unsigned char v;
+
+	spin_lock_irqsave(&toshiba_rbtx4938_ioc_lock, flags);
+
+	v = TX4938_RD08(TOSHIBA_RBTX4938_IOC_INTR_ENAB);
+	v |= (1 << (irq - TOSHIBA_RBTX4938_IRQ_IOC_BEG));
+	TX4938_WR08(TOSHIBA_RBTX4938_IOC_INTR_ENAB, v);
+	mmiowb();
+	TX4938_RD08(TOSHIBA_RBTX4938_IOC_INTR_ENAB);
+
+	spin_unlock_irqrestore(&toshiba_rbtx4938_ioc_lock, flags);
+
+	return;
+}
+
+static void
+toshiba_rbtx4938_irq_ioc_disable(unsigned int irq)
+{
+	unsigned long flags;
+	volatile unsigned char v;
+
+	spin_lock_irqsave(&toshiba_rbtx4938_ioc_lock, flags);
+
+	v = TX4938_RD08(TOSHIBA_RBTX4938_IOC_INTR_ENAB);
+	v &= ~(1 << (irq - TOSHIBA_RBTX4938_IRQ_IOC_BEG));
+	TX4938_WR08(TOSHIBA_RBTX4938_IOC_INTR_ENAB, v);
+	mmiowb();
+	TX4938_RD08(TOSHIBA_RBTX4938_IOC_INTR_ENAB);
+
+	spin_unlock_irqrestore(&toshiba_rbtx4938_ioc_lock, flags);
+
+
+	return;
+}
+
+static void
+toshiba_rbtx4938_irq_ioc_mask_and_ack(unsigned int irq)
+{
+	toshiba_rbtx4938_irq_ioc_disable(irq);
+
+	return;
+}
+
+static void
+toshiba_rbtx4938_irq_ioc_end(unsigned int irq)
+{
+	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS))) {
+		toshiba_rbtx4938_irq_ioc_enable(irq);
+	}
+
+	return;
+}
+
+extern void __init txx9_spi_irqinit(int irc_irq);
+
+void __init arch_init_irq(void)
+{
+	extern void tx4938_irq_init(void);
+
+	/* Now, interrupt control disabled, */
+	/* all IRC interrupts are masked, */
+	/* all IRC interrupt mode are Low Active. */
+
+	/* mask all IOC interrupts */
+	*rbtx4938_imask_ptr = 0;
+
+	/* clear SoftInt interrupts */
+	*rbtx4938_softint_ptr = 0;
+	tx4938_irq_init();
+	toshiba_rbtx4938_irq_ioc_init();
+	/* Onboard 10M Ether: High Active */
+	TX4938_WR(TX4938_MKA(TX4938_IRC_IRDM0), 0x00000040);
+
+	if (tx4938_ccfgptr->pcfg & TX4938_PCFG_SPI_SEL) {
+		txx9_spi_irqinit(RBTX4938_IRQ_IRC_SPI);
+        }
+
+	wbflush();
+	return;
+}
Index: linux/arch/mips/tx4938/toshiba_rbtx4938/prom.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux/arch/mips/tx4938/toshiba_rbtx4938/prom.c	2005-06-22 12:25:09.892057496 +0900
@@ -0,0 +1,78 @@
+/*
+ * linux/arch/mips/tx4938/toshiba_rbtx4938/prom.c
+ *
+ * rbtx4938 specific prom routines
+ * Copyright (C) 2000-2001 Toshiba Corporation
+ *
+ * 2003-2005 (c) MontaVista Software, Inc. This file is licensed under the
+ * terms of the GNU General Public License version 2. This program is
+ * licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ *
+ * Support for TX4938 in 2.6 - Manish Lachwani (mlachwani@mvista.com)
+ */
+
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/mm.h>
+#include <linux/sched.h>
+#include <linux/bootmem.h>
+
+#include <asm/addrspace.h>
+#include <asm/bootinfo.h>
+#include <asm/tx4938/tx4938.h>
+
+void __init prom_init_cmdline(void)
+{
+	int argc = (int) fw_arg0;
+	char **argv = (char **) fw_arg1;
+	int i;
+
+	/* ignore all built-in args if any f/w args given */
+	if (argc > 1) {
+		*arcs_cmdline = '\0';
+	}
+
+	for (i = 1; i < argc; i++) {
+		if (i != 1) {
+			strcat(arcs_cmdline, " ");
+		}
+		strcat(arcs_cmdline, argv[i]);
+	}
+}
+
+void __init prom_init(void)
+{
+	extern int tx4938_get_mem_size(void);
+	int msize;
+
+	prom_init_cmdline();
+
+	mips_machgroup = MACH_GROUP_TOSHIBA;
+	mips_machtype = MACH_TOSHIBA_RBTX4938;
+
+	msize = tx4938_get_mem_size();
+	add_memory_region(0, msize << 20, BOOT_MEM_RAM);
+
+	return;
+}
+
+unsigned long  __init prom_free_prom_memory(void)
+{
+	return 0;
+}
+
+void __init prom_fixup_mem_map(unsigned long start, unsigned long end)
+{
+	return;
+}
+
+const char *get_system_type(void)
+{
+	return "Toshiba RBTX4938";
+}
+
+char * __init prom_getcmdline(void)
+{
+	return &(arcs_cmdline[0]);
+}
Index: linux/arch/mips/tx4938/toshiba_rbtx4938/setup.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux/arch/mips/tx4938/toshiba_rbtx4938/setup.c	2005-06-22 12:25:09.894057192 +0900
@@ -0,0 +1,1034 @@
+/*
+ * linux/arch/mips/tx4938/toshiba_rbtx4938/setup.c
+ *
+ * Setup pointers to hardware-dependent routines.
+ * Copyright (C) 2000-2001 Toshiba Corporation
+ *
+ * 2003-2005 (c) MontaVista Software, Inc. This file is licensed under the
+ * terms of the GNU General Public License version 2. This program is
+ * licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ *
+ * Support for TX4938 in 2.6 - Manish Lachwani (mlachwani@mvista.com)
+ */
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/ioport.h>
+#include <linux/proc_fs.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/console.h>
+#include <linux/pci.h>
+#include <asm/wbflush.h>
+#include <asm/reboot.h>
+#include <asm/irq.h>
+#include <asm/time.h>
+#include <asm/uaccess.h>
+#include <asm/io.h>
+#include <asm/bootinfo.h>
+#include <asm/tx4938/rbtx4938.h>
+#ifdef CONFIG_SERIAL_TXX9
+#include <linux/tty.h>
+#include <linux/serial.h>
+#include <linux/serial_core.h>
+#endif
+
+extern void rbtx4938_time_init(void) __init;
+static inline void tx4938_report_pcic_status1(struct tx4938_pcic_reg *pcicptr);
+
+/* These functions are used for rebooting or halting the machine*/
+extern void rbtx4938_machine_restart(char *command);
+extern void rbtx4938_machine_halt(void);
+extern void rbtx4938_machine_power_off(void);
+
+/* clocks */
+unsigned int txx9_master_clock;
+unsigned int txx9_cpu_clock;
+unsigned int txx9_gbus_clock;
+
+unsigned long rbtx4938_ce_base[8];
+unsigned long rbtx4938_ce_size[8];
+int txboard_pci66_mode = 0;
+static int tx4938_ccfg_toeon = 1;
+static int tx4938_pcic_trdyto = 0;	/* default: disabled */
+static int tx4938_pcic_retryto = 0;	/* default: disabled */
+
+struct tx4938_pcic_reg *pcicptrs[4] = {
+       tx4938_pcicptr  /* default setting for TX4938 */
+};
+
+static struct {
+	unsigned long base;
+	unsigned long size;
+} phys_regions[16] __initdata;
+static int num_phys_regions  __initdata;
+
+#define PHYS_REGION_MINSIZE	0x10000
+
+void rbtx4938_machine_halt(void)
+{
+        printk(KERN_NOTICE "System Halted\n");
+	local_irq_disable();
+
+	while (1)
+		__asm__(".set\tmips3\n\t"
+			"wait\n\t"
+			".set\tmips0");
+}
+
+void rbtx4938_machine_power_off(void)
+{
+        rbtx4938_machine_halt();
+        /* no return */
+}
+
+void rbtx4938_machine_restart(char *command)
+{
+	local_irq_disable();
+
+	printk("Rebooting...");
+	*rbtx4938_softresetlock_ptr = 1;
+	*rbtx4938_sfvol_ptr = 1;
+	*rbtx4938_softreset_ptr = 1;
+	wbflush();
+
+	while(1);
+}
+
+void __init
+txboard_add_phys_region(unsigned long base, unsigned long size)
+{
+	if (num_phys_regions >= ARRAY_SIZE(phys_regions)) {
+		printk("phys_region overflow\n");
+		return;
+	}
+	phys_regions[num_phys_regions].base = base;
+	phys_regions[num_phys_regions].size = size;
+	num_phys_regions++;
+}
+unsigned long __init
+txboard_find_free_phys_region(unsigned long begin, unsigned long end,
+			      unsigned long size)
+{
+	unsigned long base;
+	int i;
+
+	for (base = begin / size * size; base < end; base += size) {
+		for (i = 0; i < num_phys_regions; i++) {
+			if (phys_regions[i].size &&
+			    base <= phys_regions[i].base + (phys_regions[i].size - 1) &&
+			    base + (size - 1) >= phys_regions[i].base)
+				break;
+		}
+		if (i == num_phys_regions)
+			return base;
+	}
+	return 0;
+}
+unsigned long __init
+txboard_find_free_phys_region_shrink(unsigned long begin, unsigned long end,
+				     unsigned long *size)
+{
+	unsigned long sz, base;
+	for (sz = *size; sz >= PHYS_REGION_MINSIZE; sz /= 2) {
+		base = txboard_find_free_phys_region(begin, end, sz);
+		if (base) {
+			*size = sz;
+			return base;
+		}
+	}
+	return 0;
+}
+unsigned long __init
+txboard_request_phys_region_range(unsigned long begin, unsigned long end,
+				  unsigned long size)
+{
+	unsigned long base;
+	base = txboard_find_free_phys_region(begin, end, size);
+	if (base)
+		txboard_add_phys_region(base, size);
+	return base;
+}
+unsigned long __init
+txboard_request_phys_region(unsigned long size)
+{
+	unsigned long base;
+	unsigned long begin = 0, end = 0x20000000;	/* search low 512MB */
+	base = txboard_find_free_phys_region(begin, end, size);
+	if (base)
+		txboard_add_phys_region(base, size);
+	return base;
+}
+unsigned long __init
+txboard_request_phys_region_shrink(unsigned long *size)
+{
+	unsigned long base;
+	unsigned long begin = 0, end = 0x20000000;	/* search low 512MB */
+	base = txboard_find_free_phys_region_shrink(begin, end, size);
+	if (base)
+		txboard_add_phys_region(base, *size);
+	return base;
+}
+
+#ifdef CONFIG_PCI
+void __init
+tx4938_pcic_setup(struct tx4938_pcic_reg *pcicptr,
+		  struct pci_controller *channel,
+		  unsigned long pci_io_base,
+		  int extarb)
+{
+	int i;
+
+	/* Disable All Initiator Space */
+	pcicptr->pciccfg &= ~(TX4938_PCIC_PCICCFG_G2PMEN(0)|
+			      TX4938_PCIC_PCICCFG_G2PMEN(1)|
+			      TX4938_PCIC_PCICCFG_G2PMEN(2)|
+			      TX4938_PCIC_PCICCFG_G2PIOEN);
+
+	/* GB->PCI mappings */
+	pcicptr->g2piomask = (channel->io_resource->end - channel->io_resource->start) >> 4;
+	pcicptr->g2piogbase = pci_io_base |
+#ifdef __BIG_ENDIAN
+		TX4938_PCIC_G2PIOGBASE_ECHG
+#else
+		TX4938_PCIC_G2PIOGBASE_BSDIS
+#endif
+		;
+	pcicptr->g2piopbase = 0;
+	for (i = 0; i < 3; i++) {
+		pcicptr->g2pmmask[i] = 0;
+		pcicptr->g2pmgbase[i] = 0;
+		pcicptr->g2pmpbase[i] = 0;
+	}
+	if (channel->mem_resource->end) {
+		pcicptr->g2pmmask[0] = (channel->mem_resource->end - channel->mem_resource->start) >> 4;
+		pcicptr->g2pmgbase[0] = channel->mem_resource->start |
+#ifdef __BIG_ENDIAN
+			TX4938_PCIC_G2PMnGBASE_ECHG
+#else
+			TX4938_PCIC_G2PMnGBASE_BSDIS
+#endif
+			;
+		pcicptr->g2pmpbase[0] = channel->mem_resource->start;
+	}
+	/* PCI->GB mappings (I/O 256B) */
+	pcicptr->p2giopbase = 0; /* 256B */
+	pcicptr->p2giogbase = 0;
+	/* PCI->GB mappings (MEM 512MB (64MB on R1.x)) */
+	pcicptr->p2gm0plbase = 0;
+	pcicptr->p2gm0pubase = 0;
+	pcicptr->p2gmgbase[0] = 0 |
+		TX4938_PCIC_P2GMnGBASE_TMEMEN |
+#ifdef __BIG_ENDIAN
+		TX4938_PCIC_P2GMnGBASE_TECHG
+#else
+		TX4938_PCIC_P2GMnGBASE_TBSDIS
+#endif
+		;
+	/* PCI->GB mappings (MEM 16MB) */
+	pcicptr->p2gm1plbase = 0xffffffff;
+	pcicptr->p2gm1pubase = 0xffffffff;
+	pcicptr->p2gmgbase[1] = 0;
+	/* PCI->GB mappings (MEM 1MB) */
+	pcicptr->p2gm2pbase = 0xffffffff; /* 1MB */
+	pcicptr->p2gmgbase[2] = 0;
+
+	pcicptr->pciccfg &= TX4938_PCIC_PCICCFG_GBWC_MASK;
+	/* Enable Initiator Memory Space */
+	if (channel->mem_resource->end)
+		pcicptr->pciccfg |= TX4938_PCIC_PCICCFG_G2PMEN(0);
+	/* Enable Initiator I/O Space */
+	if (channel->io_resource->end)
+		pcicptr->pciccfg |= TX4938_PCIC_PCICCFG_G2PIOEN;
+	/* Enable Initiator Config */
+	pcicptr->pciccfg |=
+		TX4938_PCIC_PCICCFG_ICAEN |
+		TX4938_PCIC_PCICCFG_TCAR;
+
+	/* Do not use MEMMUL, MEMINF: YMFPCI card causes M_ABORT. */
+	pcicptr->pcicfg1 = 0;
+
+	pcicptr->g2ptocnt &= ~0xffff;
+
+	if (tx4938_pcic_trdyto >= 0) {
+		pcicptr->g2ptocnt &= ~0xff;
+		pcicptr->g2ptocnt |= (tx4938_pcic_trdyto & 0xff);
+	}
+
+	if (tx4938_pcic_retryto >= 0) {
+		pcicptr->g2ptocnt &= ~0xff00;
+		pcicptr->g2ptocnt |= ((tx4938_pcic_retryto<<8) & 0xff00);
+	}
+
+	/* Clear All Local Bus Status */
+	pcicptr->pcicstatus = TX4938_PCIC_PCICSTATUS_ALL;
+	/* Enable All Local Bus Interrupts */
+	pcicptr->pcicmask = TX4938_PCIC_PCICSTATUS_ALL;
+	/* Clear All Initiator Status */
+	pcicptr->g2pstatus = TX4938_PCIC_G2PSTATUS_ALL;
+	/* Enable All Initiator Interrupts */
+	pcicptr->g2pmask = TX4938_PCIC_G2PSTATUS_ALL;
+	/* Clear All PCI Status Error */
+	pcicptr->pcistatus =
+		(pcicptr->pcistatus & 0x0000ffff) |
+		(TX4938_PCIC_PCISTATUS_ALL << 16);
+	/* Enable All PCI Status Error Interrupts */
+	pcicptr->pcimask = TX4938_PCIC_PCISTATUS_ALL;
+
+	if (!extarb) {
+		/* Reset Bus Arbiter */
+		pcicptr->pbacfg = TX4938_PCIC_PBACFG_RPBA;
+		pcicptr->pbabm = 0;
+		/* Enable Bus Arbiter */
+		pcicptr->pbacfg = TX4938_PCIC_PBACFG_PBAEN;
+	}
+
+      /* PCIC Int => IRC IRQ16 */
+	pcicptr->pcicfg2 =
+		    (pcicptr->pcicfg2 & 0xffffff00) | TX4938_IR_PCIC;
+
+	pcicptr->pcistatus = PCI_COMMAND_MASTER |
+		PCI_COMMAND_MEMORY |
+		PCI_COMMAND_PARITY | PCI_COMMAND_SERR;
+}
+
+int __init
+tx4938_report_pciclk(void)
+{
+	unsigned long pcode = TX4938_REV_PCODE();
+	int pciclk = 0;
+	printk("TX%lx PCIC --%s PCICLK:",
+	       pcode,
+	       (tx4938_ccfgptr->ccfg & TX4938_CCFG_PCI66) ? " PCI66" : "");
+	if (tx4938_ccfgptr->pcfg & TX4938_PCFG_PCICLKEN_ALL) {
+
+		switch ((unsigned long)tx4938_ccfgptr->ccfg & TX4938_CCFG_PCIDIVMODE_MASK) {
+		case TX4938_CCFG_PCIDIVMODE_4:
+			pciclk = txx9_cpu_clock / 4; break;
+		case TX4938_CCFG_PCIDIVMODE_4_5:
+			pciclk = txx9_cpu_clock * 2 / 9; break;
+		case TX4938_CCFG_PCIDIVMODE_5:
+			pciclk = txx9_cpu_clock / 5; break;
+		case TX4938_CCFG_PCIDIVMODE_5_5:
+			pciclk = txx9_cpu_clock * 2 / 11; break;
+		case TX4938_CCFG_PCIDIVMODE_8:
+			pciclk = txx9_cpu_clock / 8; break;
+		case TX4938_CCFG_PCIDIVMODE_9:
+			pciclk = txx9_cpu_clock / 9; break;
+		case TX4938_CCFG_PCIDIVMODE_10:
+			pciclk = txx9_cpu_clock / 10; break;
+		case TX4938_CCFG_PCIDIVMODE_11:
+			pciclk = txx9_cpu_clock / 11; break;
+		}
+		printk("Internal(%dMHz)", pciclk / 1000000);
+	} else {
+		printk("External");
+		pciclk = -1;
+	}
+	printk("\n");
+	return pciclk;
+}
+
+void __init set_tx4938_pcicptr(int ch, struct tx4938_pcic_reg *pcicptr)
+{
+	pcicptrs[ch] = pcicptr;
+}
+
+struct tx4938_pcic_reg *get_tx4938_pcicptr(int ch)
+{
+       return pcicptrs[ch];
+}
+
+static struct pci_dev *fake_pci_dev(struct pci_controller *hose,
+                                    int top_bus, int busnr, int devfn)
+{
+	static struct pci_dev dev;
+	static struct pci_bus bus;
+
+	dev.sysdata = (void *)hose;
+	dev.devfn = devfn;
+	bus.number = busnr;
+	bus.ops = hose->pci_ops;
+	bus.parent = NULL;
+	dev.bus = &bus;
+
+	return &dev;
+}
+
+#define EARLY_PCI_OP(rw, size, type)                                    \
+static int early_##rw##_config_##size(struct pci_controller *hose,      \
+        int top_bus, int bus, int devfn, int offset, type value)        \
+{                                                                       \
+        return pci_##rw##_config_##size(                                \
+                fake_pci_dev(hose, top_bus, bus, devfn),                \
+                offset, value);                                         \
+}
+
+EARLY_PCI_OP(read, word, u16 *)
+
+int txboard_pci66_check(struct pci_controller *hose, int top_bus, int current_bus)
+{
+	u32 pci_devfn;
+	unsigned short vid;
+	int devfn_start = 0;
+	int devfn_stop = 0xff;
+	int cap66 = -1;
+	u16 stat;
+
+	printk("PCI: Checking 66MHz capabilities...\n");
+
+	for (pci_devfn=devfn_start; pci_devfn<devfn_stop; pci_devfn++) {
+		early_read_config_word(hose, top_bus, current_bus, pci_devfn,
+				       PCI_VENDOR_ID, &vid);
+
+		if (vid == 0xffff) continue;
+
+		/* check 66MHz capability */
+		if (cap66 < 0)
+			cap66 = 1;
+		if (cap66) {
+			early_read_config_word(hose, top_bus, current_bus, pci_devfn,
+					       PCI_STATUS, &stat);
+			if (!(stat & PCI_STATUS_66MHZ)) {
+				printk(KERN_DEBUG "PCI: %02x:%02x not 66MHz capable.\n",
+				       current_bus, pci_devfn);
+				cap66 = 0;
+				break;
+			}
+		}
+	}
+	return cap66 > 0;
+}
+
+int __init
+tx4938_pciclk66_setup(void)
+{
+	int pciclk;
+
+	/* Assert M66EN */
+	tx4938_ccfgptr->ccfg |= TX4938_CCFG_PCI66;
+	/* Double PCICLK (if possible) */
+	if (tx4938_ccfgptr->pcfg & TX4938_PCFG_PCICLKEN_ALL) {
+		unsigned int pcidivmode = 0;
+		switch (pcidivmode) {
+		case TX4938_CCFG_PCIDIVMODE_8:
+		case TX4938_CCFG_PCIDIVMODE_4:
+			pcidivmode = TX4938_CCFG_PCIDIVMODE_4;
+			pciclk = txx9_cpu_clock / 4;
+			break;
+		case TX4938_CCFG_PCIDIVMODE_9:
+		case TX4938_CCFG_PCIDIVMODE_4_5:
+			pcidivmode = TX4938_CCFG_PCIDIVMODE_4_5;
+			pciclk = txx9_cpu_clock * 2 / 9;
+			break;
+		case TX4938_CCFG_PCIDIVMODE_10:
+		case TX4938_CCFG_PCIDIVMODE_5:
+			pcidivmode = TX4938_CCFG_PCIDIVMODE_5;
+			pciclk = txx9_cpu_clock / 5;
+			break;
+		case TX4938_CCFG_PCIDIVMODE_11:
+		case TX4938_CCFG_PCIDIVMODE_5_5:
+		default:
+			pcidivmode = TX4938_CCFG_PCIDIVMODE_5_5;
+			pciclk = txx9_cpu_clock * 2 / 11;
+			break;
+		}
+		tx4938_ccfgptr->ccfg =
+			(tx4938_ccfgptr->ccfg & ~TX4938_CCFG_PCIDIVMODE_MASK)
+			| pcidivmode;
+		printk(KERN_DEBUG "PCICLK: ccfg:%08lx\n",
+		       (unsigned long)tx4938_ccfgptr->ccfg);
+	} else {
+		pciclk = -1;
+	}
+	return pciclk;
+}
+
+extern struct pci_controller tx4938_pci_controller[];
+static int __init tx4938_pcibios_init(void)
+{
+	unsigned long mem_base[2];
+	unsigned long mem_size[2] = {TX4938_PCIMEM_SIZE_0,TX4938_PCIMEM_SIZE_1}; /* MAX 128M,64K */
+	unsigned long io_base[2];
+	unsigned long io_size[2] = {TX4938_PCIIO_SIZE_0,TX4938_PCIIO_SIZE_1}; /* MAX 16M,64K */
+	/* TX4938 PCIC1: 64K MEM/IO is enough for ETH0,ETH1 */
+	int extarb = !(tx4938_ccfgptr->ccfg & TX4938_CCFG_PCIXARB);
+
+	PCIBIOS_MIN_IO = 0x00001000UL;
+	PCIBIOS_MIN_MEM = 0x01000000UL;
+
+	mem_base[0] = txboard_request_phys_region_shrink(&mem_size[0]);
+	io_base[0] = txboard_request_phys_region_shrink(&io_size[0]);
+
+	printk("TX4938 PCIC -- DID:%04x VID:%04x RID:%02x Arbiter:%s\n",
+	       (unsigned short)(tx4938_pcicptr->pciid >> 16),
+	       (unsigned short)(tx4938_pcicptr->pciid & 0xffff),
+	       (unsigned short)(tx4938_pcicptr->pciccrev & 0xff),
+	       extarb ? "External" : "Internal");
+
+	/* setup PCI area */
+	tx4938_pci_controller[0].io_resource->start = io_base[0];
+	tx4938_pci_controller[0].io_resource->end = (io_base[0] + io_size[0]) - 1;
+	tx4938_pci_controller[0].mem_resource->start = mem_base[0];
+	tx4938_pci_controller[0].mem_resource->end = mem_base[0] + mem_size[0] - 1;
+
+	set_tx4938_pcicptr(0, tx4938_pcicptr);
+
+	register_pci_controller(&tx4938_pci_controller[0]);
+
+	if (tx4938_ccfgptr->ccfg & TX4938_CCFG_PCI66) {
+		printk("TX4938_CCFG_PCI66 already configured\n");
+		txboard_pci66_mode = -1; /* already configured */
+	}
+
+	/* Reset PCI Bus */
+	*rbtx4938_pcireset_ptr = 0;
+	/* Reset PCIC */
+	tx4938_ccfgptr->clkctr |= TX4938_CLKCTR_PCIRST;
+	if (txboard_pci66_mode > 0)
+		tx4938_pciclk66_setup();
+	mdelay(10);
+	/* clear PCIC reset */
+	tx4938_ccfgptr->clkctr &= ~TX4938_CLKCTR_PCIRST;
+	*rbtx4938_pcireset_ptr = 1;
+	wbflush();
+	tx4938_report_pcic_status1(tx4938_pcicptr);
+
+	tx4938_report_pciclk();
+	tx4938_pcic_setup(tx4938_pcicptr, &tx4938_pci_controller[0], io_base[0], extarb);
+	if (txboard_pci66_mode == 0 &&
+	    txboard_pci66_check(&tx4938_pci_controller[0], 0, 0)) {
+		/* Reset PCI Bus */
+		*rbtx4938_pcireset_ptr = 0;
+		/* Reset PCIC */
+		tx4938_ccfgptr->clkctr |= TX4938_CLKCTR_PCIRST;
+		tx4938_pciclk66_setup();
+		mdelay(10);
+		/* clear PCIC reset */
+		tx4938_ccfgptr->clkctr &= ~TX4938_CLKCTR_PCIRST;
+		*rbtx4938_pcireset_ptr = 1;
+		wbflush();
+		/* Reinitialize PCIC */
+		tx4938_report_pciclk();
+		tx4938_pcic_setup(tx4938_pcicptr, &tx4938_pci_controller[0], io_base[0], extarb);
+	}
+
+	mem_base[1] = txboard_request_phys_region_shrink(&mem_size[1]);
+	io_base[1] = txboard_request_phys_region_shrink(&io_size[1]);
+	/* Reset PCIC1 */
+	tx4938_ccfgptr->clkctr |= TX4938_CLKCTR_PCIC1RST;
+	/* PCI1DMD==0 => PCI1CLK==GBUSCLK/2 => PCI66 */
+	if (!(tx4938_ccfgptr->ccfg & TX4938_CCFG_PCI1DMD))
+		tx4938_ccfgptr->ccfg |= TX4938_CCFG_PCI1_66;
+	else
+		tx4938_ccfgptr->ccfg &= ~TX4938_CCFG_PCI1_66;
+	mdelay(10);
+	/* clear PCIC1 reset */
+	tx4938_ccfgptr->clkctr &= ~TX4938_CLKCTR_PCIC1RST;
+	tx4938_report_pcic_status1(tx4938_pcic1ptr);
+
+	printk("TX4938 PCIC1 -- DID:%04x VID:%04x RID:%02x",
+	       (unsigned short)(tx4938_pcic1ptr->pciid >> 16),
+	       (unsigned short)(tx4938_pcic1ptr->pciid & 0xffff),
+	       (unsigned short)(tx4938_pcic1ptr->pciccrev & 0xff));
+	printk("%s PCICLK:%dMHz\n",
+	       (tx4938_ccfgptr->ccfg & TX4938_CCFG_PCI1_66) ? " PCI66" : "",
+	       txx9_gbus_clock /
+	       ((tx4938_ccfgptr->ccfg & TX4938_CCFG_PCI1DMD) ? 4 : 2) /
+	       1000000);
+
+	/* assumption: CPHYSADDR(mips_io_port_base) == io_base[0] */
+	tx4938_pci_controller[1].io_resource->start =
+		io_base[1] - io_base[0];
+	tx4938_pci_controller[1].io_resource->end =
+		io_base[1] - io_base[0] + io_size[1] - 1;
+	tx4938_pci_controller[1].mem_resource->start = mem_base[1];
+	tx4938_pci_controller[1].mem_resource->end =
+		mem_base[1] + mem_size[1] - 1;
+	set_tx4938_pcicptr(1, tx4938_pcic1ptr);
+
+	register_pci_controller(&tx4938_pci_controller[1]);
+
+	tx4938_pcic_setup(tx4938_pcic1ptr, &tx4938_pci_controller[1], io_base[1], extarb);
+
+	/* map ioport 0 to PCI I/O space address 0 */
+	set_io_port_base(KSEG1 + io_base[0]);
+
+	return 0;
+}
+
+arch_initcall(tx4938_pcibios_init);
+
+#endif /* CONFIG_PCI */
+
+/* SPI support */
+
+/* chip select for SPI devices */
+#define	SEEPROM1_CS	7	/* PIO7 */
+#define	SEEPROM2_CS	0	/* IOC */
+#define	SEEPROM3_CS	1	/* IOC */
+#define	SRTC_CS	2	/* IOC */
+
+static int rbtx4938_spi_cs_func(int chipid, int on)
+{
+	unsigned char bit;
+	switch (chipid) {
+	case RBTX4938_SEEPROM1_CHIPID:
+		if (on)
+			tx4938_pioptr->dout &= ~(1 << SEEPROM1_CS);
+		else
+			tx4938_pioptr->dout |= (1 << SEEPROM1_CS);
+		return 0;
+		break;
+	case RBTX4938_SEEPROM2_CHIPID:
+		bit = (1 << SEEPROM2_CS);
+		break;
+	case RBTX4938_SEEPROM3_CHIPID:
+		bit = (1 << SEEPROM3_CS);
+		break;
+	case RBTX4938_SRTC_CHIPID:
+		bit = (1 << SRTC_CS);
+		break;
+	default:
+		return -ENODEV;
+	}
+	/* bit1,2,4 are low active, bit3 is high active */
+	*rbtx4938_spics_ptr =
+		(*rbtx4938_spics_ptr & ~bit) |
+		((on ? (bit ^ 0x0b) : ~(bit ^ 0x0b)) & bit);
+	return 0;
+}
+
+#ifdef CONFIG_PCI
+extern int spi_eeprom_read(int chipid, int address, unsigned char *buf, int len);
+
+int rbtx4938_get_tx4938_ethaddr(struct pci_dev *dev, unsigned char *addr)
+{
+	struct pci_controller *channel = (struct pci_controller *)dev->bus->sysdata;
+	static unsigned char dat[17];
+	static int read_dat = 0;
+	int ch = 0;
+
+	if (channel != &tx4938_pci_controller[1])
+		return -ENODEV;
+	/* TX4938 PCIC1 */
+	switch (PCI_SLOT(dev->devfn)) {
+	case TX4938_PCIC_IDSEL_AD_TO_SLOT(31):
+		ch = 0;
+		break;
+	case TX4938_PCIC_IDSEL_AD_TO_SLOT(30):
+		ch = 1;
+		break;
+	default:
+		return -ENODEV;
+	}
+	if (!read_dat) {
+		unsigned char sum;
+		int i;
+		read_dat = 1;
+		/* 0-3: "MAC\0", 4-9:eth0, 10-15:eth1, 16:sum */
+		if (spi_eeprom_read(RBTX4938_SEEPROM1_CHIPID,
+				    0, dat, sizeof(dat))) {
+			printk(KERN_ERR "seeprom: read error.\n");
+		} else {
+			if (strcmp(dat, "MAC") != 0)
+				printk(KERN_WARNING "seeprom: bad signature.\n");
+			for (i = 0, sum = 0; i < sizeof(dat); i++)
+				sum += dat[i];
+			if (sum)
+				printk(KERN_WARNING "seeprom: bad checksum.\n");
+		}
+	}
+	memcpy(addr, &dat[4 + 6 * ch], 6);
+	return 0;
+}
+#endif /* CONFIG_PCI */
+
+extern void __init txx9_spi_init(unsigned long base, int (*cs_func)(int chipid, int on));
+static void __init rbtx4938_spi_setup(void)
+{
+	/* set SPI_SEL */
+	tx4938_ccfgptr->pcfg |= TX4938_PCFG_SPI_SEL;
+	/* chip selects for SPI devices */
+	tx4938_pioptr->dout |= (1 << SEEPROM1_CS);
+	tx4938_pioptr->dir |= (1 << SEEPROM1_CS);
+	txx9_spi_init(TX4938_SPI_REG, rbtx4938_spi_cs_func);
+}
+
+static struct resource rbtx4938_fpga_resource;
+
+static char pcode_str[8];
+static struct resource tx4938_reg_resource = {
+	pcode_str, TX4938_REG_BASE, TX4938_REG_BASE+TX4938_REG_SIZE, IORESOURCE_MEM
+};
+
+void __init tx4938_board_setup(void)
+{
+	int i;
+	unsigned long divmode;
+	int cpuclk = 0;
+	unsigned long pcode = TX4938_REV_PCODE();
+
+	ioport_resource.start = 0x1000;
+	ioport_resource.end = 0xffffffff;
+	iomem_resource.start = 0x1000;
+	iomem_resource.end = 0xffffffff;	/* expand to 4GB */
+
+	sprintf(pcode_str, "TX%lx", pcode);
+	/* SDRAMC,EBUSC are configured by PROM */
+	for (i = 0; i < 8; i++) {
+		if (!(tx4938_ebuscptr->cr[i] & 0x8))
+			continue;	/* disabled */
+ 		rbtx4938_ce_base[i] = (unsigned long)TX4938_EBUSC_BA(i);
+		txboard_add_phys_region(rbtx4938_ce_base[i], TX4938_EBUSC_SIZE(i));
+	}
+
+	/* clocks */
+	if (txx9_master_clock) {
+		/* calculate gbus_clock and cpu_clock from master_clock */
+		divmode = (unsigned long)tx4938_ccfgptr->ccfg & TX4938_CCFG_DIVMODE_MASK;
+		switch (divmode) {
+		case TX4938_CCFG_DIVMODE_8:
+		case TX4938_CCFG_DIVMODE_10:
+		case TX4938_CCFG_DIVMODE_12:
+		case TX4938_CCFG_DIVMODE_16:
+		case TX4938_CCFG_DIVMODE_18:
+			txx9_gbus_clock = txx9_master_clock * 4; break;
+		default:
+			txx9_gbus_clock = txx9_master_clock;
+		}
+		switch (divmode) {
+		case TX4938_CCFG_DIVMODE_2:
+		case TX4938_CCFG_DIVMODE_8:
+			cpuclk = txx9_gbus_clock * 2; break;
+		case TX4938_CCFG_DIVMODE_2_5:
+		case TX4938_CCFG_DIVMODE_10:
+			cpuclk = txx9_gbus_clock * 5 / 2; break;
+		case TX4938_CCFG_DIVMODE_3:
+		case TX4938_CCFG_DIVMODE_12:
+			cpuclk = txx9_gbus_clock * 3; break;
+		case TX4938_CCFG_DIVMODE_4:
+		case TX4938_CCFG_DIVMODE_16:
+			cpuclk = txx9_gbus_clock * 4; break;
+		case TX4938_CCFG_DIVMODE_4_5:
+		case TX4938_CCFG_DIVMODE_18:
+			cpuclk = txx9_gbus_clock * 9 / 2; break;
+		}
+		txx9_cpu_clock = cpuclk;
+	} else {
+		if (txx9_cpu_clock == 0) {
+			txx9_cpu_clock = 300000000;	/* 300MHz */
+		}
+		/* calculate gbus_clock and master_clock from cpu_clock */
+		cpuclk = txx9_cpu_clock;
+		divmode = (unsigned long)tx4938_ccfgptr->ccfg & TX4938_CCFG_DIVMODE_MASK;
+		switch (divmode) {
+		case TX4938_CCFG_DIVMODE_2:
+		case TX4938_CCFG_DIVMODE_8:
+			txx9_gbus_clock = cpuclk / 2; break;
+		case TX4938_CCFG_DIVMODE_2_5:
+		case TX4938_CCFG_DIVMODE_10:
+			txx9_gbus_clock = cpuclk * 2 / 5; break;
+		case TX4938_CCFG_DIVMODE_3:
+		case TX4938_CCFG_DIVMODE_12:
+			txx9_gbus_clock = cpuclk / 3; break;
+		case TX4938_CCFG_DIVMODE_4:
+		case TX4938_CCFG_DIVMODE_16:
+			txx9_gbus_clock = cpuclk / 4; break;
+		case TX4938_CCFG_DIVMODE_4_5:
+		case TX4938_CCFG_DIVMODE_18:
+			txx9_gbus_clock = cpuclk * 2 / 9; break;
+		}
+		switch (divmode) {
+		case TX4938_CCFG_DIVMODE_8:
+		case TX4938_CCFG_DIVMODE_10:
+		case TX4938_CCFG_DIVMODE_12:
+		case TX4938_CCFG_DIVMODE_16:
+		case TX4938_CCFG_DIVMODE_18:
+			txx9_master_clock = txx9_gbus_clock / 4; break;
+		default:
+			txx9_master_clock = txx9_gbus_clock;
+		}
+	}
+	/* change default value to udelay/mdelay take reasonable time */
+	loops_per_jiffy = txx9_cpu_clock / HZ / 2;
+
+	/* CCFG */
+	/* clear WatchDogReset,BusErrorOnWrite flag (W1C) */
+	tx4938_ccfgptr->ccfg |= TX4938_CCFG_WDRST | TX4938_CCFG_BEOW;
+	/* clear PCIC1 reset */
+	if (tx4938_ccfgptr->clkctr & TX4938_CLKCTR_PCIC1RST)
+		tx4938_ccfgptr->clkctr &= ~TX4938_CLKCTR_PCIC1RST;
+
+	/* enable Timeout BusError */
+	if (tx4938_ccfg_toeon)
+		tx4938_ccfgptr->ccfg |= TX4938_CCFG_TOE;
+
+	/* DMA selection */
+	tx4938_ccfgptr->pcfg &= ~TX4938_PCFG_DMASEL_ALL;
+
+	/* Use external clock for external arbiter */
+	if (!(tx4938_ccfgptr->ccfg & TX4938_CCFG_PCIXARB))
+		tx4938_ccfgptr->pcfg &= ~TX4938_PCFG_PCICLKEN_ALL;
+
+	printk("%s -- %dMHz(M%dMHz) CRIR:%08lx CCFG:%Lx PCFG:%Lx\n",
+	       pcode_str,
+	       cpuclk / 1000000, txx9_master_clock / 1000000,
+	       (unsigned long)tx4938_ccfgptr->crir,
+	       tx4938_ccfgptr->ccfg,
+	       tx4938_ccfgptr->pcfg);
+
+	printk("%s SDRAMC --", pcode_str);
+	for (i = 0; i < 4; i++) {
+		unsigned long long cr = tx4938_sdramcptr->cr[i];
+		unsigned long ram_base, ram_size;
+		if (!((unsigned long)cr & 0x00000400))
+			continue;	/* disabled */
+		ram_base = (unsigned long)(cr >> 49) << 21;
+		ram_size = ((unsigned long)(cr >> 33) + 1) << 21;
+		if (ram_base >= 0x20000000)
+			continue;	/* high memory (ignore) */
+		printk(" CR%d:%016Lx", i, cr);
+		txboard_add_phys_region(ram_base, ram_size);
+	}
+	printk(" TR:%09Lx\n", tx4938_sdramcptr->tr);
+
+	/* SRAM */
+	if (pcode == 0x4938 && tx4938_sramcptr->cr & 1) {
+		unsigned int size = 0x800;
+		unsigned long base =
+			(tx4938_sramcptr->cr >> (39-11)) & ~(size - 1);
+		 txboard_add_phys_region(base, size);
+	}
+
+	/* IRC */
+	/* disable interrupt control */
+	tx4938_ircptr->cer = 0;
+
+	/* TMR */
+	/* disable all timers */
+	for (i = 0; i < TX4938_NR_TMR; i++) {
+		tx4938_tmrptr(i)->tcr  = 0x00000020;
+		tx4938_tmrptr(i)->tisr = 0;
+		tx4938_tmrptr(i)->cpra = 0xffffffff;
+		tx4938_tmrptr(i)->itmr = 0;
+		tx4938_tmrptr(i)->ccdr = 0;
+		tx4938_tmrptr(i)->pgmr = 0;
+	}
+
+	/* enable DMA */
+	TX4938_WR64(0xff1fb150, TX4938_DMA_MCR_MSTEN);
+	TX4938_WR64(0xff1fb950, TX4938_DMA_MCR_MSTEN);
+
+	/* PIO */
+	tx4938_pioptr->maskcpu = 0;
+	tx4938_pioptr->maskext = 0;
+
+	/* TX4938 internal registers */
+	if (request_resource(&iomem_resource, &tx4938_reg_resource))
+		printk("request resource for internal registers failed\n");
+}
+
+#ifdef CONFIG_PCI
+static inline void tx4938_report_pcic_status1(struct tx4938_pcic_reg *pcicptr)
+{
+	unsigned short pcistatus = (unsigned short)(pcicptr->pcistatus >> 16);
+	unsigned long g2pstatus = pcicptr->g2pstatus;
+	unsigned long pcicstatus = pcicptr->pcicstatus;
+	static struct {
+		unsigned long flag;
+		const char *str;
+	} pcistat_tbl[] = {
+		{ PCI_STATUS_DETECTED_PARITY,	"DetectedParityError" },
+		{ PCI_STATUS_SIG_SYSTEM_ERROR,	"SignaledSystemError" },
+		{ PCI_STATUS_REC_MASTER_ABORT,	"ReceivedMasterAbort" },
+		{ PCI_STATUS_REC_TARGET_ABORT,	"ReceivedTargetAbort" },
+		{ PCI_STATUS_SIG_TARGET_ABORT,	"SignaledTargetAbort" },
+		{ PCI_STATUS_PARITY,	"MasterParityError" },
+	}, g2pstat_tbl[] = {
+		{ TX4938_PCIC_G2PSTATUS_TTOE,	"TIOE" },
+		{ TX4938_PCIC_G2PSTATUS_RTOE,	"RTOE" },
+	}, pcicstat_tbl[] = {
+		{ TX4938_PCIC_PCICSTATUS_PME,	"PME" },
+		{ TX4938_PCIC_PCICSTATUS_TLB,	"TLB" },
+		{ TX4938_PCIC_PCICSTATUS_NIB,	"NIB" },
+		{ TX4938_PCIC_PCICSTATUS_ZIB,	"ZIB" },
+		{ TX4938_PCIC_PCICSTATUS_PERR,	"PERR" },
+		{ TX4938_PCIC_PCICSTATUS_SERR,	"SERR" },
+		{ TX4938_PCIC_PCICSTATUS_GBE,	"GBE" },
+		{ TX4938_PCIC_PCICSTATUS_IWB,	"IWB" },
+	};
+	int i;
+
+	printk("pcistat:%04x(", pcistatus);
+	for (i = 0; i < ARRAY_SIZE(pcistat_tbl); i++)
+		if (pcistatus & pcistat_tbl[i].flag)
+			printk("%s ", pcistat_tbl[i].str);
+	printk("), g2pstatus:%08lx(", g2pstatus);
+	for (i = 0; i < ARRAY_SIZE(g2pstat_tbl); i++)
+		if (g2pstatus & g2pstat_tbl[i].flag)
+			printk("%s ", g2pstat_tbl[i].str);
+	printk("), pcicstatus:%08lx(", pcicstatus);
+	for (i = 0; i < ARRAY_SIZE(pcicstat_tbl); i++)
+		if (pcicstatus & pcicstat_tbl[i].flag)
+			printk("%s ", pcicstat_tbl[i].str);
+	printk(")\n");
+}
+
+void tx4938_report_pcic_status(void)
+{
+	int i;
+	struct tx4938_pcic_reg *pcicptr;
+	for (i = 0; (pcicptr = get_tx4938_pcicptr(i)) != NULL; i++)
+		tx4938_report_pcic_status1(pcicptr);
+}
+
+#endif /* CONFIG_PCI */
+
+/* We use onchip r4k counter or TMR timer as our system wide timer
+ * interrupt running at 100HZ. */
+
+extern void __init rtc_rx5c348_init(int chipid);
+void __init rbtx4938_time_init(void)
+{
+	rtc_rx5c348_init(RBTX4938_SRTC_CHIPID);
+	mips_hpt_frequency = txx9_cpu_clock / 2;
+}
+
+void __init toshiba_rbtx4938_setup(void)
+{
+	unsigned long long pcfg;
+	char *argptr;
+
+	iomem_resource.end = 0xffffffff;	/* 4GB */
+
+	if (txx9_master_clock == 0)
+		txx9_master_clock = 25000000; /* 25MHz */
+	tx4938_board_setup();
+	/* setup irq stuff */
+	TX4938_WR(TX4938_MKA(TX4938_IRC_IRDM0), 0x00000000);	/* irq trigger */
+	TX4938_WR(TX4938_MKA(TX4938_IRC_IRDM1), 0x00000000);	/* irq trigger */
+	/* setup serial stuff */
+	TX4938_WR(0xff1ff314, 0x00000000);	/* h/w flow control off */
+	TX4938_WR(0xff1ff414, 0x00000000);	/* h/w flow control off */
+
+#ifndef CONFIG_PCI
+	set_io_port_base(RBTX4938_ETHER_BASE);
+#endif
+
+#ifdef CONFIG_SERIAL_TXX9
+	{
+		extern int early_serial_txx9_setup(struct uart_port *port);
+		int i;
+		struct uart_port req;
+		for(i = 0; i < 2; i++) {
+			memset(&req, 0, sizeof(req));
+			req.line = i;
+			req.iotype = UPIO_MEM;
+			req.membase = (char *)(0xff1ff300 + i * 0x100);
+			req.mapbase = 0xff1ff300 + i * 0x100;
+			req.irq = 32 + i;
+			req.flags |= UPF_BUGGY_UART /*HAVE_CTS_LINE*/;
+			req.uartclk = 50000000;
+			early_serial_txx9_setup(&req);
+		}
+	}
+#ifdef CONFIG_SERIAL_TXX9_CONSOLE
+        argptr = prom_getcmdline();
+        if (strstr(argptr, "console=") == NULL) {
+                strcat(argptr, " console=ttyS0,38400");
+        }
+#endif
+#endif
+
+#ifdef CONFIG_TOSHIBA_RBTX4938_MPLEX_PIO58_61
+	printk("PIOSEL: disabling both ata and nand selection\n");
+	tx
+	local_irq_disable();
+	4938_ccfgptr->pcfg &= ~(TX4938_PCFG_NDF_SEL | TX4938_PCFG_ATA_SEL);
+#endif
+
+#ifdef CONFIG_TOSHIBA_RBTX4938_MPLEX_NAND
+	printk("PIOSEL: enabling nand selection\n");
+	tx4938_ccfgptr->pcfg |= TX4938_PCFG_NDF_SEL;
+	tx4938_ccfgptr->pcfg &= ~TX4938_PCFG_ATA_SEL;
+#endif
+
+#ifdef CONFIG_TOSHIBA_RBTX4938_MPLEX_ATA
+	printk("PIOSEL: enabling ata selection\n");
+	tx4938_ccfgptr->pcfg |= TX4938_PCFG_ATA_SEL;
+	tx4938_ccfgptr->pcfg &= ~TX4938_PCFG_NDF_SEL;
+#endif
+
+#ifdef CONFIG_IP_PNP
+	argptr = prom_getcmdline();
+	if (strstr(argptr, "ip=") == NULL) {
+		strcat(argptr, " ip=any");
+	}
+#endif
+
+
+#ifdef CONFIG_FB
+	{
+		conswitchp = &dummy_con;
+	}
+#endif
+
+	rbtx4938_spi_setup();
+	pcfg = tx4938_ccfgptr->pcfg;	/* updated */
+	/* fixup piosel */
+	if ((pcfg & (TX4938_PCFG_ATA_SEL | TX4938_PCFG_NDF_SEL)) ==
+	    TX4938_PCFG_ATA_SEL) {
+		*rbtx4938_piosel_ptr = (*rbtx4938_piosel_ptr & 0x03) | 0x04;
+	}
+	else if ((pcfg & (TX4938_PCFG_ATA_SEL | TX4938_PCFG_NDF_SEL)) ==
+	    TX4938_PCFG_NDF_SEL) {
+		*rbtx4938_piosel_ptr = (*rbtx4938_piosel_ptr & 0x03) | 0x08;
+	}
+	else {
+		*rbtx4938_piosel_ptr &= ~(0x08 | 0x04);
+	}
+
+	rbtx4938_fpga_resource.name = "FPGA Registers";
+	rbtx4938_fpga_resource.start = CPHYSADDR(RBTX4938_FPGA_REG_ADDR);
+	rbtx4938_fpga_resource.end = CPHYSADDR(RBTX4938_FPGA_REG_ADDR) + 0xffff;
+	rbtx4938_fpga_resource.flags = IORESOURCE_MEM | IORESOURCE_BUSY;
+	if (request_resource(&iomem_resource, &rbtx4938_fpga_resource))
+		printk("request resource for fpga failed\n");
+
+	/* disable all OnBoard I/O interrupts */
+	*rbtx4938_imask_ptr = 0;
+
+	_machine_restart = rbtx4938_machine_restart;
+	_machine_halt = rbtx4938_machine_halt;
+	_machine_power_off = rbtx4938_machine_power_off;
+
+	*rbtx4938_led_ptr = 0xff;
+	printk("RBTX4938 --- FPGA(Rev %02x)", *rbtx4938_fpga_rev_ptr);
+	printk(" DIPSW:%02x,%02x\n",
+	       *rbtx4938_dipsw_ptr, *rbtx4938_bdipsw_ptr);
+}
+
+#ifdef CONFIG_PROC_FS
+extern void spi_eeprom_proc_create(struct proc_dir_entry *dir, int chipid);
+static int __init tx4938_spi_proc_setup(void)
+{
+	struct proc_dir_entry *tx4938_spi_eeprom_dir;
+
+	tx4938_spi_eeprom_dir = proc_mkdir("spi_eeprom", 0);
+
+	if (!tx4938_spi_eeprom_dir)
+		return -ENOMEM;
+
+	/* don't allow user access to RBTX4938_SEEPROM1_CHIPID
+	 * as it contains eth0 and eth1 MAC addresses
+	 */
+	spi_eeprom_proc_create(tx4938_spi_eeprom_dir, RBTX4938_SEEPROM2_CHIPID);
+	spi_eeprom_proc_create(tx4938_spi_eeprom_dir, RBTX4938_SEEPROM3_CHIPID);
+
+	return 0;
+}
+
+__initcall(tx4938_spi_proc_setup);
+#endif
Index: linux/arch/mips/tx4938/toshiba_rbtx4938/spi_eeprom.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux/arch/mips/tx4938/toshiba_rbtx4938/spi_eeprom.c	2005-06-22 12:25:09.894057192 +0900
@@ -0,0 +1,219 @@
+/*
+ * linux/arch/mips/tx4938/toshiba_rbtx4938/spi_eeprom.c
+ * Copyright (C) 2000-2001 Toshiba Corporation
+ *
+ * 2003-2005 (c) MontaVista Software, Inc. This file is licensed under the
+ * terms of the GNU General Public License version 2. This program is
+ * licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ *
+ * Support for TX4938 in 2.6 - Manish Lachwani (mlachwani@mvista.com)
+ */
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/proc_fs.h>
+#include <linux/spinlock.h>
+#include <asm/tx4938/spi.h>
+#include <asm/tx4938/tx4938.h>
+
+/* ATMEL 250x0 instructions */
+#define	ATMEL_WREN	0x06
+#define	ATMEL_WRDI	0x04
+#define ATMEL_RDSR	0x05
+#define ATMEL_WRSR	0x01
+#define	ATMEL_READ	0x03
+#define	ATMEL_WRITE	0x02
+
+#define ATMEL_SR_BSY	0x01
+#define ATMEL_SR_WEN	0x02
+#define ATMEL_SR_BP0	0x04
+#define ATMEL_SR_BP1	0x08
+
+DEFINE_SPINLOCK(spi_eeprom_lock);
+
+static struct spi_dev_desc seeprom_dev_desc = {
+	.baud 		= 1500000,	/* 1.5Mbps */
+	.tcss		= 1,
+	.tcsh		= 1,
+	.tcsr		= 1,
+	.byteorder	= 1,		/* MSB-First */
+	.polarity	= 0,		/* High-Active */
+	.phase		= 0,		/* Sample-Then-Shift */
+
+};
+static inline int
+spi_eeprom_io(int chipid,
+	      unsigned char **inbufs, unsigned int *incounts,
+	      unsigned char **outbufs, unsigned int *outcounts)
+{
+	return txx9_spi_io(chipid, &seeprom_dev_desc,
+			   inbufs, incounts, outbufs, outcounts, 0);
+}
+
+int spi_eeprom_write_enable(int chipid, int enable)
+{
+	unsigned char inbuf[1];
+	unsigned char *inbufs[1];
+	unsigned int incounts[2];
+	unsigned long flags;
+	int stat;
+	inbuf[0] = enable ? ATMEL_WREN : ATMEL_WRDI;
+	inbufs[0] = inbuf;
+	incounts[0] = sizeof(inbuf);
+	incounts[1] = 0;
+	spin_lock_irqsave(&spi_eeprom_lock, flags);
+	stat = spi_eeprom_io(chipid, inbufs, incounts, NULL, NULL);
+	spin_unlock_irqrestore(&spi_eeprom_lock, flags);
+	return stat;
+}
+
+static int spi_eeprom_read_status_nolock(int chipid)
+{
+	unsigned char inbuf[2], outbuf[2];
+	unsigned char *inbufs[1], *outbufs[1];
+	unsigned int incounts[2], outcounts[2];
+	int stat;
+	inbuf[0] = ATMEL_RDSR;
+	inbuf[1] = 0;
+	inbufs[0] = inbuf;
+	incounts[0] = sizeof(inbuf);
+	incounts[1] = 0;
+	outbufs[0] = outbuf;
+	outcounts[0] = sizeof(outbuf);
+	outcounts[1] = 0;
+	stat = spi_eeprom_io(chipid, inbufs, incounts, outbufs, outcounts);
+	if (stat < 0)
+		return stat;
+	return outbuf[1];
+}
+
+int spi_eeprom_read_status(int chipid)
+{
+	unsigned long flags;
+	int stat;
+	spin_lock_irqsave(&spi_eeprom_lock, flags);
+	stat = spi_eeprom_read_status_nolock(chipid);
+	spin_unlock_irqrestore(&spi_eeprom_lock, flags);
+	return stat;
+}
+
+int spi_eeprom_read(int chipid, int address, unsigned char *buf, int len)
+{
+	unsigned char inbuf[2];
+	unsigned char *inbufs[2], *outbufs[2];
+	unsigned int incounts[2], outcounts[3];
+	unsigned long flags;
+	int stat;
+	inbuf[0] = ATMEL_READ;
+	inbuf[1] = address;
+	inbufs[0] = inbuf;
+	inbufs[1] = NULL;
+	incounts[0] = sizeof(inbuf);
+	incounts[1] = 0;
+	outbufs[0] = NULL;
+	outbufs[1] = buf;
+	outcounts[0] = 2;
+	outcounts[1] = len;
+	outcounts[2] = 0;
+	spin_lock_irqsave(&spi_eeprom_lock, flags);
+	stat = spi_eeprom_io(chipid, inbufs, incounts, outbufs, outcounts);
+	spin_unlock_irqrestore(&spi_eeprom_lock, flags);
+	return stat;
+}
+
+int spi_eeprom_write(int chipid, int address, unsigned char *buf, int len)
+{
+	unsigned char inbuf[2];
+	unsigned char *inbufs[2];
+	unsigned int incounts[3];
+	unsigned long flags;
+	int i, stat;
+
+	if (address / 8 != (address + len - 1) / 8)
+		return -EINVAL;
+	stat = spi_eeprom_write_enable(chipid, 1);
+	if (stat < 0)
+		return stat;
+	stat = spi_eeprom_read_status(chipid);
+	if (stat < 0)
+		return stat;
+	if (!(stat & ATMEL_SR_WEN))
+		return -EPERM;
+
+	inbuf[0] = ATMEL_WRITE;
+	inbuf[1] = address;
+	inbufs[0] = inbuf;
+	inbufs[1] = buf;
+	incounts[0] = sizeof(inbuf);
+	incounts[1] = len;
+	incounts[2] = 0;
+	spin_lock_irqsave(&spi_eeprom_lock, flags);
+	stat = spi_eeprom_io(chipid, inbufs, incounts, NULL, NULL);
+	if (stat < 0)
+		goto unlock_return;
+
+	/* write start.  max 10ms */
+	for (i = 10; i > 0; i--) {
+		int stat = spi_eeprom_read_status_nolock(chipid);
+		if (stat < 0)
+			goto unlock_return;
+		if (!(stat & ATMEL_SR_BSY))
+			break;
+		mdelay(1);
+	}
+	spin_unlock_irqrestore(&spi_eeprom_lock, flags);
+	if (i == 0)
+		return -EIO;
+	return len;
+ unlock_return:
+	spin_unlock_irqrestore(&spi_eeprom_lock, flags);
+	return stat;
+}
+
+#ifdef CONFIG_PROC_FS
+#define MAX_SIZE	0x80	/* for ATMEL 25010 */
+static int spi_eeprom_read_proc(char *page, char **start, off_t off,
+				int count, int *eof, void *data)
+{
+	unsigned int size = MAX_SIZE;
+	if (spi_eeprom_read((int)data, 0, (unsigned char *)page, size) < 0)
+		size = 0;
+	return size;
+}
+
+static int spi_eeprom_write_proc(struct file *file, const char *buffer,
+				 unsigned long count, void *data)
+{
+	unsigned int size = MAX_SIZE;
+	int i;
+	if (file->f_pos >= size)
+		return -EIO;
+	if (file->f_pos + count > size)
+		count = size - file->f_pos;
+	for (i = 0; i < count; i += 8) {
+		int len = count - i < 8 ? count - i : 8;
+		if (spi_eeprom_write((int)data, file->f_pos,
+				     (unsigned char *)buffer, len) < 0) {
+			count = -EIO;
+			break;
+		}
+		buffer += len;
+		file->f_pos += len;
+	}
+	return count;
+}
+
+__init void spi_eeprom_proc_create(struct proc_dir_entry *dir, int chipid)
+{
+	struct proc_dir_entry *entry;
+	char name[128];
+	sprintf(name, "seeprom-%d", chipid);
+	entry = create_proc_entry(name, 0600, dir);
+	if (entry) {
+		entry->read_proc = spi_eeprom_read_proc;
+		entry->write_proc = spi_eeprom_write_proc;
+		entry->data = (void *)chipid;
+	}
+}
+#endif /* CONFIG_PROC_FS */
Index: linux/arch/mips/tx4938/toshiba_rbtx4938/spi_txx9.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux/arch/mips/tx4938/toshiba_rbtx4938/spi_txx9.c	2005-06-22 12:25:09.894057192 +0900
@@ -0,0 +1,159 @@
+/*
+ * linux/arch/mips/tx4938/toshiba_rbtx4938/spi_txx9.c
+ * Copyright (C) 2000-2001 Toshiba Corporation
+ *
+ * 2003-2005 (c) MontaVista Software, Inc. This file is licensed under the
+ * terms of the GNU General Public License version 2. This program is
+ * licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ *
+ * Support for TX4938 in 2.6 - Manish Lachwani (mlachwani@mvista.com)
+ */
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/sched.h>
+#include <linux/spinlock.h>
+#include <linux/wait.h>
+#include <asm/tx4938/spi.h>
+#include <asm/tx4938/tx4938.h>
+
+static int (*txx9_spi_cs_func)(int chipid, int on);
+static spinlock_t txx9_spi_lock = SPIN_LOCK_UNLOCKED;
+
+extern unsigned int txx9_gbus_clock;
+
+#define SPI_FIFO_SIZE	4
+
+void __init txx9_spi_init(unsigned long base, int (*cs_func)(int chipid, int on))
+{
+	txx9_spi_cs_func = cs_func;
+	/* enter config mode */
+	tx4938_spiptr->mcr = TXx9_SPMCR_CONFIG | TXx9_SPMCR_BCLR;
+}
+
+static DECLARE_WAIT_QUEUE_HEAD(txx9_spi_wait);
+static void txx9_spi_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+{
+	/* disable rx intr */
+	tx4938_spiptr->cr0 &= ~TXx9_SPCR0_RBSIE;
+	wake_up(&txx9_spi_wait);
+}
+static struct irqaction txx9_spi_action = {
+	txx9_spi_interrupt, 0, 0, "spi", NULL, NULL,
+};
+
+void __init txx9_spi_irqinit(int irc_irq)
+{
+	setup_irq(irc_irq, &txx9_spi_action);
+}
+
+int txx9_spi_io(int chipid, struct spi_dev_desc *desc,
+		unsigned char **inbufs, unsigned int *incounts,
+		unsigned char **outbufs, unsigned int *outcounts,
+		int cansleep)
+{
+	unsigned int incount, outcount;
+	unsigned char *inp, *outp;
+	int ret;
+	unsigned long flags;
+
+	spin_lock_irqsave(&txx9_spi_lock, flags);
+	if ((tx4938_spiptr->mcr & TXx9_SPMCR_OPMODE) == TXx9_SPMCR_ACTIVE) {
+		spin_unlock_irqrestore(&txx9_spi_lock, flags);
+		return -EBUSY;
+	}
+	/* enter config mode */
+	tx4938_spiptr->mcr = TXx9_SPMCR_CONFIG | TXx9_SPMCR_BCLR;
+	tx4938_spiptr->cr0 =
+		(desc->byteorder ? TXx9_SPCR0_SBOS : 0) |
+		(desc->polarity ? TXx9_SPCR0_SPOL : 0) |
+		(desc->phase ? TXx9_SPCR0_SPHA : 0) |
+		0x08;
+	tx4938_spiptr->cr1 =
+		(((TXX9_IMCLK + desc->baud) / (2 * desc->baud) - 1) << 8) |
+		0x08 /* 8 bit only */;
+	/* enter active mode */
+	tx4938_spiptr->mcr = TXx9_SPMCR_ACTIVE;
+	spin_unlock_irqrestore(&txx9_spi_lock, flags);
+
+	/* CS ON */
+	if ((ret = txx9_spi_cs_func(chipid, 1)) < 0) {
+		spin_unlock_irqrestore(&txx9_spi_lock, flags);
+		return ret;
+	}
+	udelay(desc->tcss);
+
+	/* do scatter IO */
+	inp = inbufs ? *inbufs : NULL;
+	outp = outbufs ? *outbufs : NULL;
+	incount = 0;
+	outcount = 0;
+	while (1) {
+		unsigned char data;
+		unsigned int count;
+		int i;
+		if (!incount) {
+			incount = incounts ? *incounts++ : 0;
+			inp = (incount && inbufs) ? *inbufs++ : NULL;
+		}
+		if (!outcount) {
+			outcount = outcounts ? *outcounts++ : 0;
+			outp = (outcount && outbufs) ? *outbufs++ : NULL;
+		}
+		if (!inp && !outp)
+			break;
+		count = SPI_FIFO_SIZE;
+		if (incount)
+			count = min(count, incount);
+		if (outcount)
+			count = min(count, outcount);
+
+		/* now tx must be idle... */
+		while (!(tx4938_spiptr->sr & TXx9_SPSR_SIDLE))
+			;
+
+		tx4938_spiptr->cr0 =
+			(tx4938_spiptr->cr0 & ~TXx9_SPCR0_RXIFL_MASK) |
+			((count - 1) << 12);
+		if (cansleep) {
+			/* enable rx intr */
+			tx4938_spiptr->cr0 |= TXx9_SPCR0_RBSIE;
+		}
+		/* send */
+		for (i = 0; i < count; i++)
+			tx4938_spiptr->dr = inp ? *inp++ : 0;
+		/* wait all rx data */
+		if (cansleep) {
+			wait_event(txx9_spi_wait,
+				   tx4938_spiptr->sr & TXx9_SPSR_SRRDY);
+		} else {
+			while (!(tx4938_spiptr->sr & TXx9_SPSR_RBSI))
+				;
+		}
+		/* receive */
+		for (i = 0; i < count; i++) {
+			data = tx4938_spiptr->dr;
+			if (outp)
+				*outp++ = data;
+		}
+		if (incount)
+			incount -= count;
+		if (outcount)
+			outcount -= count;
+	}
+
+	/* CS OFF */
+	udelay(desc->tcsh);
+	txx9_spi_cs_func(chipid, 0);
+	udelay(desc->tcsr);
+
+	spin_lock_irqsave(&txx9_spi_lock, flags);
+	/* enter config mode */
+	tx4938_spiptr->mcr = TXx9_SPMCR_CONFIG | TXx9_SPMCR_BCLR;
+	spin_unlock_irqrestore(&txx9_spi_lock, flags);
+
+	return 0;
+}
Index: linux/drivers/net/ne.c
===================================================================
--- linux.orig/drivers/net/ne.c	2005-06-22 12:18:48.169088208 +0900
+++ linux/drivers/net/ne.c	2005-06-22 12:25:09.895057040 +0900
@@ -54,6 +54,10 @@
 #include <asm/system.h>
 #include <asm/io.h>
 
+#if defined(CONFIG_TOSHIBA_RBTX4927) || defined(CONFIG_TOSHIBA_RBTX4938)
+#include <asm/tx4938/rbtx4938.h>
+#endif
+
 #include "8390.h"
 
 #define DRV_NAME "ne"
@@ -111,6 +115,9 @@
     {"E-LAN100", "E-LAN200", {0x00, 0x00, 0x5d}}, /* Broken ne1000 clones */
     {"PCM-4823", "PCM-4823", {0x00, 0xc0, 0x6c}}, /* Broken Advantech MoBo */
     {"REALTEK", "RTL8019", {0x00, 0x00, 0xe8}}, /* no-name with Realtek chip */
+#if defined(CONFIG_TOSHIBA_RBTX4927) || defined(CONFIG_TOSHIBA_RBTX4938)
+    {"RBHMA4X00-RTL8019", "RBHMA4X00/RTL8019", {0x00, 0x60, 0x0a}},  /* Toshiba built-in */
+#endif
     {"LCS-8834", "LCS-8836", {0x04, 0x04, 0x37}}, /* ShinyNet (SET) */
     {NULL,}
 };
@@ -226,6 +233,10 @@
 	sprintf(dev->name, "eth%d", unit);
 	netdev_boot_setup_check(dev);
 
+#ifdef CONFIG_TOSHIBA_RBTX4938
+	dev->base_addr = 0x07f20280;
+	dev->irq = RBTX4938_RTL_8019_IRQ;
+#endif
 	err = do_ne_probe(dev);
 	if (err)
 		goto out;
@@ -511,6 +522,10 @@
 	ei_status.name = name;
 	ei_status.tx_start_page = start_page;
 	ei_status.stop_page = stop_page;
+#if defined(CONFIG_TOSHIBA_RBTX4927) || defined(CONFIG_TOSHIBA_RBTX4938)
+	wordlength = 1;
+#endif
+
 #ifdef CONFIG_PLAT_OAKS32R
 	ei_status.word16 = 0;
 #else
Index: linux/include/asm-mips/bootinfo.h
===================================================================
--- linux.orig/include/asm-mips/bootinfo.h	2005-06-22 12:18:48.169088208 +0900
+++ linux/include/asm-mips/bootinfo.h	2005-06-22 12:25:09.896056888 +0900
@@ -159,6 +159,7 @@
 #define  MACH_TOSHIBA_JMR3927	3	/* JMR-TX3927 CPU/IO board */
 #define  MACH_TOSHIBA_RBTX4927	4
 #define  MACH_TOSHIBA_RBTX4937	5
+#define  MACH_TOSHIBA_RBTX4938	6
 
 #define GROUP_TOSHIBA_NAMES	{ "Pallas", "TopasCE", "JMR", "JMR TX3927", \
 				  "RBTX4927", "RBTX4937" }
Index: linux/include/asm-mips/tx4938/rbtx4938.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux/include/asm-mips/tx4938/rbtx4938.h	2005-06-22 12:25:09.896056888 +0900
@@ -0,0 +1,207 @@
+/*
+ * linux/include/asm-mips/tx4938/rbtx4938.h
+ * Definitions for TX4937/TX4938
+ *
+ * 2003-2005 (c) MontaVista Software, Inc. This file is licensed under the
+ * terms of the GNU General Public License version 2. This program is
+ * licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ *
+ * Support for TX4938 in 2.6 - Manish Lachwani (mlachwani@mvista.com)
+ */
+#ifndef __ASM_TX_BOARDS_RBTX4938_H
+#define __ASM_TX_BOARDS_RBTX4938_H
+
+#include <asm/addrspace.h>
+#include <asm/tx4938/tx4938.h>
+
+/* CS */
+#define RBTX4938_CE0	0x1c000000	/* 64M */
+#define RBTX4938_CE2	0x17f00000	/* 1M */
+
+/* Address map */
+#define RBTX4938_FPGA_REG_ADDR	(KSEG1 + RBTX4938_CE2 + 0x00000000)
+#define RBTX4938_FPGA_REV_ADDR	(KSEG1 + RBTX4938_CE2 + 0x00000002)
+#define RBTX4938_CONFIG1_ADDR	(KSEG1 + RBTX4938_CE2 + 0x00000004)
+#define RBTX4938_CONFIG2_ADDR	(KSEG1 + RBTX4938_CE2 + 0x00000006)
+#define RBTX4938_CONFIG3_ADDR	(KSEG1 + RBTX4938_CE2 + 0x00000008)
+#define RBTX4938_LED_ADDR	(KSEG1 + RBTX4938_CE2 + 0x00001000)
+#define RBTX4938_DIPSW_ADDR	(KSEG1 + RBTX4938_CE2 + 0x00001002)
+#define RBTX4938_BDIPSW_ADDR	(KSEG1 + RBTX4938_CE2 + 0x00001004)
+#define RBTX4938_IMASK_ADDR	(KSEG1 + RBTX4938_CE2 + 0x00002000)
+#define RBTX4938_IMASK2_ADDR	(KSEG1 + RBTX4938_CE2 + 0x00002002)
+#define RBTX4938_INTPOL_ADDR	(KSEG1 + RBTX4938_CE2 + 0x00002004)
+#define RBTX4938_ISTAT_ADDR	(KSEG1 + RBTX4938_CE2 + 0x00002006)
+#define RBTX4938_ISTAT2_ADDR	(KSEG1 + RBTX4938_CE2 + 0x00002008)
+#define RBTX4938_IMSTAT_ADDR	(KSEG1 + RBTX4938_CE2 + 0x0000200a)
+#define RBTX4938_IMSTAT2_ADDR	(KSEG1 + RBTX4938_CE2 + 0x0000200c)
+#define RBTX4938_SOFTINT_ADDR	(KSEG1 + RBTX4938_CE2 + 0x00003000)
+#define RBTX4938_PIOSEL_ADDR	(KSEG1 + RBTX4938_CE2 + 0x00005000)
+#define RBTX4938_SPICS_ADDR	(KSEG1 + RBTX4938_CE2 + 0x00005002)
+#define RBTX4938_SFPWR_ADDR	(KSEG1 + RBTX4938_CE2 + 0x00005008)
+#define RBTX4938_SFVOL_ADDR	(KSEG1 + RBTX4938_CE2 + 0x0000500a)
+#define RBTX4938_SOFTRESET_ADDR	(KSEG1 + RBTX4938_CE2 + 0x00007000)
+#define RBTX4938_SOFTRESETLOCK_ADDR	(KSEG1 + RBTX4938_CE2 + 0x00007002)
+#define RBTX4938_PCIRESET_ADDR	(KSEG1 + RBTX4938_CE2 + 0x00007004)
+#define RBTX4938_ETHER_BASE	(KSEG1 + RBTX4938_CE2 + 0x00020000)
+
+/* Ethernet port address (Jumperless Mode (W12:Open)) */
+#define RBTX4938_ETHER_ADDR	(RBTX4938_ETHER_BASE + 0x280)
+
+/* bits for ISTAT/IMASK/IMSTAT */
+#define RBTX4938_INTB_PCID	0
+#define RBTX4938_INTB_PCIC	1
+#define RBTX4938_INTB_PCIB	2
+#define RBTX4938_INTB_PCIA	3
+#define RBTX4938_INTB_RTC	4
+#define RBTX4938_INTB_ATA	5
+#define RBTX4938_INTB_MODEM	6
+#define RBTX4938_INTB_SWINT	7
+#define RBTX4938_INTF_PCID	(1 << RBTX4938_INTB_PCID)
+#define RBTX4938_INTF_PCIC	(1 << RBTX4938_INTB_PCIC)
+#define RBTX4938_INTF_PCIB	(1 << RBTX4938_INTB_PCIB)
+#define RBTX4938_INTF_PCIA	(1 << RBTX4938_INTB_PCIA)
+#define RBTX4938_INTF_RTC	(1 << RBTX4938_INTB_RTC)
+#define RBTX4938_INTF_ATA	(1 << RBTX4938_INTB_ATA)
+#define RBTX4938_INTF_MODEM	(1 << RBTX4938_INTB_MODEM)
+#define RBTX4938_INTF_SWINT	(1 << RBTX4938_INTB_SWINT)
+
+#define rbtx4938_fpga_rev_ptr	\
+	((volatile unsigned char *)RBTX4938_FPGA_REV_ADDR)
+#define rbtx4938_led_ptr	\
+	((volatile unsigned char *)RBTX4938_LED_ADDR)
+#define rbtx4938_dipsw_ptr	\
+	((volatile unsigned char *)RBTX4938_DIPSW_ADDR)
+#define rbtx4938_bdipsw_ptr	\
+	((volatile unsigned char *)RBTX4938_BDIPSW_ADDR)
+#define rbtx4938_imask_ptr	\
+	((volatile unsigned char *)RBTX4938_IMASK_ADDR)
+#define rbtx4938_imask2_ptr	\
+	((volatile unsigned char *)RBTX4938_IMASK2_ADDR)
+#define rbtx4938_intpol_ptr	\
+	((volatile unsigned char *)RBTX4938_INTPOL_ADDR)
+#define rbtx4938_istat_ptr	\
+	((volatile unsigned char *)RBTX4938_ISTAT_ADDR)
+#define rbtx4938_istat2_ptr	\
+	((volatile unsigned char *)RBTX4938_ISTAT2_ADDR)
+#define rbtx4938_imstat_ptr	\
+	((volatile unsigned char *)RBTX4938_IMSTAT_ADDR)
+#define rbtx4938_imstat2_ptr	\
+	((volatile unsigned char *)RBTX4938_IMSTAT2_ADDR)
+#define rbtx4938_softint_ptr	\
+	((volatile unsigned char *)RBTX4938_SOFTINT_ADDR)
+#define rbtx4938_piosel_ptr	\
+	((volatile unsigned char *)RBTX4938_PIOSEL_ADDR)
+#define rbtx4938_spics_ptr	\
+	((volatile unsigned char *)RBTX4938_SPICS_ADDR)
+#define rbtx4938_sfpwr_ptr	\
+	((volatile unsigned char *)RBTX4938_SFPWR_ADDR)
+#define rbtx4938_sfvol_ptr	\
+	((volatile unsigned char *)RBTX4938_SFVOL_ADDR)
+#define rbtx4938_softreset_ptr	\
+	((volatile unsigned char *)RBTX4938_SOFTRESET_ADDR)
+#define rbtx4938_softresetlock_ptr	\
+	((volatile unsigned char *)RBTX4938_SOFTRESETLOCK_ADDR)
+#define rbtx4938_pcireset_ptr	\
+	((volatile unsigned char *)RBTX4938_PCIRESET_ADDR)
+
+/* SPI */
+#define RBTX4938_SEEPROM1_CHIPID	0
+#define RBTX4938_SEEPROM2_CHIPID	1
+#define RBTX4938_SEEPROM3_CHIPID	2
+#define RBTX4938_SRTC_CHIPID	3
+
+/*
+ * IRQ mappings
+ */
+
+#define RBTX4938_SOFT_INT0	0	/* not used */
+#define RBTX4938_SOFT_INT1	1	/* not used */
+#define RBTX4938_IRC_INT	2
+#define RBTX4938_TIMER_INT	7
+
+/* These are the virtual IRQ numbers, we divide all IRQ's into
+ * 'spaces', the 'space' determines where and how to enable/disable
+ * that particular IRQ on an RBTX4938 machine.  Add new 'spaces' as new
+ * IRQ hardware is supported.
+ */
+#define RBTX4938_NR_IRQ_LOCAL	8
+#define RBTX4938_NR_IRQ_IRC	32	/* On-Chip IRC */
+#define RBTX4938_NR_IRQ_IOC	8
+
+#define MI8259_IRQ_ISA_RAW_BEG   0	/* optional backplane i8259 */
+#define MI8259_IRQ_ISA_RAW_END  15
+#define TX4938_IRQ_CP0_RAW_BEG   0	/* tx4938 cpu built-in cp0 */
+#define TX4938_IRQ_CP0_RAW_END   7
+#define TX4938_IRQ_PIC_RAW_BEG   0	/* tx4938 cpu build-in pic */
+#define TX4938_IRQ_PIC_RAW_END  31
+
+#define MI8259_IRQ_ISA_BEG                          MI8259_IRQ_ISA_RAW_BEG	/*  0 */
+#define MI8259_IRQ_ISA_END                          MI8259_IRQ_ISA_RAW_END	/* 15 */
+
+#define TX4938_IRQ_CP0_BEG  ((MI8259_IRQ_ISA_END+1)+TX4938_IRQ_CP0_RAW_BEG)	/* 16 */
+#define TX4938_IRQ_CP0_END  ((MI8259_IRQ_ISA_END+1)+TX4938_IRQ_CP0_RAW_END)	/* 23 */
+
+#define TX4938_IRQ_PIC_BEG  ((TX4938_IRQ_CP0_END+1)+TX4938_IRQ_PIC_RAW_BEG)	/* 24 */
+#define TX4938_IRQ_PIC_END  ((TX4938_IRQ_CP0_END+1)+TX4938_IRQ_PIC_RAW_END)	/* 55 */
+#define TX4938_IRQ_NEST_EXT_ON_PIC  (TX4938_IRQ_PIC_BEG+2)
+#define TX4938_IRQ_NEST_PIC_ON_CP0  (TX4938_IRQ_CP0_BEG+2)
+#define TX4938_IRQ_USER0            (TX4938_IRQ_CP0_BEG+0)
+#define TX4938_IRQ_USER1            (TX4938_IRQ_CP0_BEG+1)
+#define TX4938_IRQ_CPU_TIMER        (TX4938_IRQ_CP0_BEG+7)
+
+#define TOSHIBA_RBTX4938_IRQ_IOC_RAW_BEG   0
+#define TOSHIBA_RBTX4938_IRQ_IOC_RAW_END   7
+
+#define TOSHIBA_RBTX4938_IRQ_IOC_BEG  ((TX4938_IRQ_PIC_END+1)+TOSHIBA_RBTX4938_IRQ_IOC_RAW_BEG) /* 56 */
+#define TOSHIBA_RBTX4938_IRQ_IOC_END  ((TX4938_IRQ_PIC_END+1)+TOSHIBA_RBTX4938_IRQ_IOC_RAW_END) /* 63 */
+#define RBTX4938_IRQ_LOCAL	TX4938_IRQ_CP0_BEG
+#define RBTX4938_IRQ_IRC	(RBTX4938_IRQ_LOCAL + RBTX4938_NR_IRQ_LOCAL)
+#define RBTX4938_IRQ_IOC	(RBTX4938_IRQ_IRC + RBTX4938_NR_IRQ_IRC)
+#define RBTX4938_IRQ_END	(RBTX4938_IRQ_IOC + RBTX4938_NR_IRQ_IOC)
+
+#define RBTX4938_IRQ_LOCAL_SOFT0	(RBTX4938_IRQ_LOCAL + RBTX4938_SOFT_INT0)
+#define RBTX4938_IRQ_LOCAL_SOFT1	(RBTX4938_IRQ_LOCAL + RBTX4938_SOFT_INT1)
+#define RBTX4938_IRQ_LOCAL_IRC	(RBTX4938_IRQ_LOCAL + RBTX4938_IRC_INT)
+#define RBTX4938_IRQ_LOCAL_TIMER	(RBTX4938_IRQ_LOCAL + RBTX4938_TIMER_INT)
+#define RBTX4938_IRQ_IRC_ECCERR	(RBTX4938_IRQ_IRC + TX4938_IR_ECCERR)
+#define RBTX4938_IRQ_IRC_WTOERR	(RBTX4938_IRQ_IRC + TX4938_IR_WTOERR)
+#define RBTX4938_IRQ_IRC_INT(n)	(RBTX4938_IRQ_IRC + TX4938_IR_INT(n))
+#define RBTX4938_IRQ_IRC_SIO(n)	(RBTX4938_IRQ_IRC + TX4938_IR_SIO(n))
+#define RBTX4938_IRQ_IRC_DMA(ch,n)	(RBTX4938_IRQ_IRC + TX4938_IR_DMA(ch,n))
+#define RBTX4938_IRQ_IRC_PIO	(RBTX4938_IRQ_IRC + TX4938_IR_PIO)
+#define RBTX4938_IRQ_IRC_PDMAC	(RBTX4938_IRQ_IRC + TX4938_IR_PDMAC)
+#define RBTX4938_IRQ_IRC_PCIC	(RBTX4938_IRQ_IRC + TX4938_IR_PCIC)
+#define RBTX4938_IRQ_IRC_TMR(n)	(RBTX4938_IRQ_IRC + TX4938_IR_TMR(n))
+#define RBTX4938_IRQ_IRC_NDFMC	(RBTX4938_IRQ_IRC + TX4938_IR_NDFMC)
+#define RBTX4938_IRQ_IRC_PCIERR	(RBTX4938_IRQ_IRC + TX4938_IR_PCIERR)
+#define RBTX4938_IRQ_IRC_PCIPME	(RBTX4938_IRQ_IRC + TX4938_IR_PCIPME)
+#define RBTX4938_IRQ_IRC_ACLC	(RBTX4938_IRQ_IRC + TX4938_IR_ACLC)
+#define RBTX4938_IRQ_IRC_ACLCPME	(RBTX4938_IRQ_IRC + TX4938_IR_ACLCPME)
+#define RBTX4938_IRQ_IRC_PCIC1	(RBTX4938_IRQ_IRC + TX4938_IR_PCIC1)
+#define RBTX4938_IRQ_IRC_SPI	(RBTX4938_IRQ_IRC + TX4938_IR_SPI)
+#define RBTX4938_IRQ_IOC_PCID	(RBTX4938_IRQ_IOC + RBTX4938_INTB_PCID)
+#define RBTX4938_IRQ_IOC_PCIC	(RBTX4938_IRQ_IOC + RBTX4938_INTB_PCIC)
+#define RBTX4938_IRQ_IOC_PCIB	(RBTX4938_IRQ_IOC + RBTX4938_INTB_PCIB)
+#define RBTX4938_IRQ_IOC_PCIA	(RBTX4938_IRQ_IOC + RBTX4938_INTB_PCIA)
+#define RBTX4938_IRQ_IOC_RTC	(RBTX4938_IRQ_IOC + RBTX4938_INTB_RTC)
+#define RBTX4938_IRQ_IOC_ATA	(RBTX4938_IRQ_IOC + RBTX4938_INTB_ATA)
+#define RBTX4938_IRQ_IOC_MODEM	(RBTX4938_IRQ_IOC + RBTX4938_INTB_MODEM)
+#define RBTX4938_IRQ_IOC_SWINT	(RBTX4938_IRQ_IOC + RBTX4938_INTB_SWINT)
+
+
+/* IOC (PCI, etc) */
+#define RBTX4938_IRQ_IOCINT	(TX4938_IRQ_NEST_EXT_ON_PIC)
+/* Onboard 10M Ether */
+#define RBTX4938_IRQ_ETHER	(TX4938_IRQ_NEST_EXT_ON_PIC + 1)
+
+#define RBTX4938_RTL_8019_BASE (RBTX4938_ETHER_ADDR - mips_io_port_base)
+#define RBTX4938_RTL_8019_IRQ  (RBTX4938_IRQ_ETHER)
+
+/* IRCR : Int. Control */
+#define TX4938_IRCR_LOW  0x00000000
+#define TX4938_IRCR_HIGH 0x00000001
+#define TX4938_IRCR_DOWN 0x00000002
+#define TX4938_IRCR_UP   0x00000003
+
+#endif /* __ASM_TX_BOARDS_RBTX4938_H */
Index: linux/include/asm-mips/tx4938/spi.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux/include/asm-mips/tx4938/spi.h	2005-06-22 12:25:09.897056736 +0900
@@ -0,0 +1,74 @@
+/*
+ * linux/include/asm-mips/tx4938/spi.h
+ * Definitions for TX4937/TX4938 SPI
+ *
+ * Copyright (C) 2000-2001 Toshiba Corporation
+ *
+ * 2003-2005 (c) MontaVista Software, Inc. This file is licensed under the
+ * terms of the GNU General Public License version 2. This program is
+ * licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ *
+ * Support for TX4938 in 2.6 - Manish Lachwani (mlachwani@mvista.com)
+ */
+#ifndef __ASM_TX_BOARDS_TX4938_SPI_H
+#define __ASM_TX_BOARDS_TX4938_SPI_H
+
+/* SPI */
+struct spi_dev_desc {
+	unsigned int baud;
+	unsigned short tcss, tcsh, tcsr; /* CS setup/hold/recovery time */
+	unsigned int byteorder:1;	/* 0:LSB-First, 1:MSB-First */
+	unsigned int polarity:1;	/* 0:High-Active */
+	unsigned int phase:1;		/* 0:Sample-Then-Shift */
+};
+
+extern void txx9_spi_init(unsigned long base, int (*cs_func)(int chipid, int on)) __init;
+extern void txx9_spi_irqinit(int irc_irq) __init;
+extern int txx9_spi_io(int chipid, struct spi_dev_desc *desc,
+		       unsigned char **inbufs, unsigned int *incounts,
+		       unsigned char **outbufs, unsigned int *outcounts,
+		       int cansleep);
+extern int spi_eeprom_write_enable(int chipid, int enable);
+extern int spi_eeprom_read_status(int chipid);
+extern int spi_eeprom_read(int chipid, int address, unsigned char *buf, int len);
+extern int spi_eeprom_write(int chipid, int address, unsigned char *buf, int len);
+extern void spi_eeprom_proc_create(struct proc_dir_entry *dir, int chipid) __init;
+
+#define TXX9_IMCLK     (txx9_gbus_clock / 2)
+
+/*
+* SPI
+*/
+
+/* SPMCR : SPI Master Control */
+#define TXx9_SPMCR_OPMODE	0xc0
+#define TXx9_SPMCR_CONFIG	0x40
+#define TXx9_SPMCR_ACTIVE	0x80
+#define TXx9_SPMCR_SPSTP	0x02
+#define TXx9_SPMCR_BCLR	0x01
+
+/* SPCR0 : SPI Status */
+#define TXx9_SPCR0_TXIFL_MASK	0xc000
+#define TXx9_SPCR0_RXIFL_MASK	0x3000
+#define TXx9_SPCR0_SIDIE	0x0800
+#define TXx9_SPCR0_SOEIE	0x0400
+#define TXx9_SPCR0_RBSIE	0x0200
+#define TXx9_SPCR0_TBSIE	0x0100
+#define TXx9_SPCR0_IFSPSE	0x0010
+#define TXx9_SPCR0_SBOS	0x0004
+#define TXx9_SPCR0_SPHA	0x0002
+#define TXx9_SPCR0_SPOL	0x0001
+
+/* SPSR : SPI Status */
+#define TXx9_SPSR_TBSI	0x8000
+#define TXx9_SPSR_RBSI	0x4000
+#define TXx9_SPSR_TBS_MASK	0x3800
+#define TXx9_SPSR_RBS_MASK	0x0700
+#define TXx9_SPSR_SPOE	0x0080
+#define TXx9_SPSR_IFSD	0x0008
+#define TXx9_SPSR_SIDLE	0x0004
+#define TXx9_SPSR_STRDY	0x0002
+#define TXx9_SPSR_SRRDY	0x0001
+
+#endif /* __ASM_TX_BOARDS_TX4938_SPI_H */
Index: linux/include/asm-mips/tx4938/tx4938.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux/include/asm-mips/tx4938/tx4938.h	2005-06-22 12:25:09.898056584 +0900
@@ -0,0 +1,706 @@
+/*
+ * linux/include/asm-mips/tx4938/tx4938.h
+ * Definitions for TX4937/TX4938
+ * Copyright (C) 2000-2001 Toshiba Corporation
+ *
+ * 2003-2005 (c) MontaVista Software, Inc. This file is licensed under the
+ * terms of the GNU General Public License version 2. This program is
+ * licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ *
+ * Support for TX4938 in 2.6 - Manish Lachwani (mlachwani@mvista.com)
+ */
+#ifndef __ASM_TX_BOARDS_TX4938_H
+#define __ASM_TX_BOARDS_TX4938_H
+
+#include <asm/tx4938/tx4938_mips.h>
+
+#define tx4938_read_nfmc(addr) (*(volatile unsigned int *)(addr))
+#define tx4938_write_nfmc(b,addr) (*(volatile unsigned int *)(addr)) = (b)
+
+#define TX4938_NR_IRQ_LOCAL     TX4938_IRQ_PIC_BEG
+
+#define TX4938_IRQ_IRC_PCIC     (TX4938_NR_IRQ_LOCAL + TX4938_IR_PCIC)
+#define TX4938_IRQ_IRC_PCIERR   (TX4938_NR_IRQ_LOCAL + TX4938_IR_PCIERR)
+
+#define TX4938_PCIIO_0 0x10000000
+#define TX4938_PCIIO_1 0x01010000
+#define TX4938_PCIMEM_0 0x08000000
+#define TX4938_PCIMEM_1 0x11000000
+
+#define TX4938_PCIIO_SIZE_0 0x01000000
+#define TX4938_PCIIO_SIZE_1 0x00010000
+#define TX4938_PCIMEM_SIZE_0 0x08000000
+#define TX4938_PCIMEM_SIZE_1 0x00010000
+
+#define TX4938_REG_BASE	0xff1f0000 /* == TX4937_REG_BASE */
+#define TX4938_REG_SIZE	0x00010000 /* == TX4937_REG_SIZE */
+
+/* NDFMC, SRAMC, PCIC1, SPIC: TX4938 only */
+#define TX4938_NDFMC_REG	(TX4938_REG_BASE + 0x5000)
+#define TX4938_SRAMC_REG	(TX4938_REG_BASE + 0x6000)
+#define TX4938_PCIC1_REG	(TX4938_REG_BASE + 0x7000)
+#define TX4938_SDRAMC_REG	(TX4938_REG_BASE + 0x8000)
+#define TX4938_EBUSC_REG	(TX4938_REG_BASE + 0x9000)
+#define TX4938_DMA_REG(ch)	(TX4938_REG_BASE + 0xb000 + (ch) * 0x800)
+#define TX4938_PCIC_REG		(TX4938_REG_BASE + 0xd000)
+#define TX4938_CCFG_REG		(TX4938_REG_BASE + 0xe000)
+#define TX4938_NR_TMR	3
+#define TX4938_TMR_REG(ch)	((TX4938_REG_BASE + 0xf000) + (ch) * 0x100)
+#define TX4938_NR_SIO	2
+#define TX4938_SIO_REG(ch)	((TX4938_REG_BASE + 0xf300) + (ch) * 0x100)
+#define TX4938_PIO_REG		(TX4938_REG_BASE + 0xf500)
+#define TX4938_IRC_REG		(TX4938_REG_BASE + 0xf600)
+#define TX4938_ACLC_REG		(TX4938_REG_BASE + 0xf700)
+#define TX4938_SPI_REG		(TX4938_REG_BASE + 0xf800)
+
+#ifndef _LANGUAGE_ASSEMBLY
+#include <asm/byteorder.h>
+
+#define TX4938_MKA(x) ((u32)( ((u32)(TX4938_REG_BASE)) | ((u32)(x)) ))
+
+#define TX4938_RD08( reg      )   (*(vu08*)(reg))
+#define TX4938_WR08( reg, val )  ((*(vu08*)(reg))=(val))
+
+#define TX4938_RD16( reg      )   (*(vu16*)(reg))
+#define TX4938_WR16( reg, val )  ((*(vu16*)(reg))=(val))
+
+#define TX4938_RD32( reg      )   (*(vu32*)(reg))
+#define TX4938_WR32( reg, val )  ((*(vu32*)(reg))=(val))
+
+#define TX4938_RD64( reg      )   (*(vu64*)(reg))
+#define TX4938_WR64( reg, val )  ((*(vu64*)(reg))=(val))
+
+#define TX4938_RD( reg      ) TX4938_RD32( reg )
+#define TX4938_WR( reg, val ) TX4938_WR32( reg, val )
+
+#endif /* !__ASSEMBLY__ */
+
+#ifdef __ASSEMBLY__
+#define _CONST64(c)	c
+#else
+#define _CONST64(c)	c##ull
+
+#include <asm/byteorder.h>
+
+#ifdef __BIG_ENDIAN
+#define endian_def_l2(e1,e2)	\
+	volatile unsigned long e1,e2
+#define endian_def_s2(e1,e2)	\
+	volatile unsigned short e1,e2
+#define endian_def_sb2(e1,e2,e3)	\
+	volatile unsigned short e1;volatile unsigned char e2,e3
+#define endian_def_b2s(e1,e2,e3)	\
+	volatile unsigned char e1,e2;volatile unsigned short e3
+#define endian_def_b4(e1,e2,e3,e4)	\
+	volatile unsigned char e1,e2,e3,e4
+#else
+#define endian_def_l2(e1,e2)	\
+	volatile unsigned long e2,e1
+#define endian_def_s2(e1,e2)	\
+	volatile unsigned short e2,e1
+#define endian_def_sb2(e1,e2,e3)	\
+	volatile unsigned char e3,e2;volatile unsigned short e1
+#define endian_def_b2s(e1,e2,e3)	\
+	volatile unsigned short e3;volatile unsigned char e2,e1
+#define endian_def_b4(e1,e2,e3,e4)	\
+	volatile unsigned char e4,e3,e2,e1
+#endif
+
+
+struct tx4938_sdramc_reg {
+	volatile unsigned long long cr[4];
+	volatile unsigned long long unused0[4];
+	volatile unsigned long long tr;
+	volatile unsigned long long unused1[2];
+	volatile unsigned long long cmd;
+	volatile unsigned long long sfcmd;
+};
+
+struct tx4938_ebusc_reg {
+	volatile unsigned long long cr[8];
+};
+
+struct tx4938_dma_reg {
+	struct tx4938_dma_ch_reg {
+		volatile unsigned long long cha;
+		volatile unsigned long long sar;
+		volatile unsigned long long dar;
+		endian_def_l2(unused0, cntr);
+		endian_def_l2(unused1, sair);
+		endian_def_l2(unused2, dair);
+		endian_def_l2(unused3, ccr);
+		endian_def_l2(unused4, csr);
+	} ch[4];
+	volatile unsigned long long dbr[8];
+	volatile unsigned long long tdhr;
+	volatile unsigned long long midr;
+	endian_def_l2(unused0, mcr);
+};
+
+struct tx4938_pcic_reg {
+	volatile unsigned long pciid;
+	volatile unsigned long pcistatus;
+	volatile unsigned long pciccrev;
+	volatile unsigned long pcicfg1;
+	volatile unsigned long p2gm0plbase;		/* +10 */
+	volatile unsigned long p2gm0pubase;
+	volatile unsigned long p2gm1plbase;
+	volatile unsigned long p2gm1pubase;
+	volatile unsigned long p2gm2pbase;		/* +20 */
+	volatile unsigned long p2giopbase;
+	volatile unsigned long unused0;
+	volatile unsigned long pcisid;
+	volatile unsigned long unused1;		/* +30 */
+	volatile unsigned long pcicapptr;
+	volatile unsigned long unused2;
+	volatile unsigned long pcicfg2;
+	volatile unsigned long g2ptocnt;		/* +40 */
+	volatile unsigned long unused3[15];
+	volatile unsigned long g2pstatus;		/* +80 */
+	volatile unsigned long g2pmask;
+	volatile unsigned long pcisstatus;
+	volatile unsigned long pcimask;
+	volatile unsigned long p2gcfg;		/* +90 */
+	volatile unsigned long p2gstatus;
+	volatile unsigned long p2gmask;
+	volatile unsigned long p2gccmd;
+	volatile unsigned long unused4[24];		/* +a0 */
+	volatile unsigned long pbareqport;		/* +100 */
+	volatile unsigned long pbacfg;
+	volatile unsigned long pbastatus;
+	volatile unsigned long pbamask;
+	volatile unsigned long pbabm;		/* +110 */
+	volatile unsigned long pbacreq;
+	volatile unsigned long pbacgnt;
+	volatile unsigned long pbacstate;
+	volatile unsigned long long g2pmgbase[3];		/* +120 */
+	volatile unsigned long long g2piogbase;
+	volatile unsigned long g2pmmask[3];		/* +140 */
+	volatile unsigned long g2piomask;
+	volatile unsigned long long g2pmpbase[3];		/* +150 */
+	volatile unsigned long long g2piopbase;
+	volatile unsigned long pciccfg;		/* +170 */
+	volatile unsigned long pcicstatus;
+	volatile unsigned long pcicmask;
+	volatile unsigned long unused5;
+	volatile unsigned long long p2gmgbase[3];		/* +180 */
+	volatile unsigned long long p2giogbase;
+	volatile unsigned long g2pcfgadrs;		/* +1a0 */
+	volatile unsigned long g2pcfgdata;
+	volatile unsigned long unused6[8];
+	volatile unsigned long g2pintack;
+	volatile unsigned long g2pspc;
+	volatile unsigned long unused7[12];		/* +1d0 */
+	volatile unsigned long long pdmca;		/* +200 */
+	volatile unsigned long long pdmga;
+	volatile unsigned long long pdmpa;
+	volatile unsigned long long pdmctr;
+	volatile unsigned long long pdmcfg;		/* +220 */
+	volatile unsigned long long pdmsts;
+};
+
+struct tx4938_aclc_reg {
+	volatile unsigned long acctlen;
+	volatile unsigned long acctldis;
+	volatile unsigned long acregacc;
+	volatile unsigned long unused0;
+	volatile unsigned long acintsts;
+	volatile unsigned long acintmsts;
+	volatile unsigned long acinten;
+	volatile unsigned long acintdis;
+	volatile unsigned long acsemaph;
+	volatile unsigned long unused1[7];
+	volatile unsigned long acgpidat;
+	volatile unsigned long acgpodat;
+	volatile unsigned long acslten;
+	volatile unsigned long acsltdis;
+	volatile unsigned long acfifosts;
+	volatile unsigned long unused2[11];
+	volatile unsigned long acdmasts;
+	volatile unsigned long acdmasel;
+	volatile unsigned long unused3[6];
+	volatile unsigned long acaudodat;
+	volatile unsigned long acsurrdat;
+	volatile unsigned long accentdat;
+	volatile unsigned long aclfedat;
+	volatile unsigned long acaudiat;
+	volatile unsigned long unused4;
+	volatile unsigned long acmodoat;
+	volatile unsigned long acmodidat;
+	volatile unsigned long unused5[15];
+	volatile unsigned long acrevid;
+};
+
+
+struct tx4938_tmr_reg {
+	volatile unsigned long tcr;
+	volatile unsigned long tisr;
+	volatile unsigned long cpra;
+	volatile unsigned long cprb;
+	volatile unsigned long itmr;
+	volatile unsigned long unused0[3];
+	volatile unsigned long ccdr;
+	volatile unsigned long unused1[3];
+	volatile unsigned long pgmr;
+	volatile unsigned long unused2[3];
+	volatile unsigned long wtmr;
+	volatile unsigned long unused3[43];
+	volatile unsigned long trr;
+};
+
+struct tx4938_sio_reg {
+	volatile unsigned long lcr;
+	volatile unsigned long dicr;
+	volatile unsigned long disr;
+	volatile unsigned long cisr;
+	volatile unsigned long fcr;
+	volatile unsigned long flcr;
+	volatile unsigned long bgr;
+	volatile unsigned long tfifo;
+	volatile unsigned long rfifo;
+};
+
+struct tx4938_pio_reg {
+	volatile unsigned long dout;
+	volatile unsigned long din;
+	volatile unsigned long dir;
+	volatile unsigned long od;
+	volatile unsigned long flag[2];
+	volatile unsigned long pol;
+	volatile unsigned long intc;
+	volatile unsigned long maskcpu;
+	volatile unsigned long maskext;
+};
+struct tx4938_irc_reg {
+	volatile unsigned long cer;
+	volatile unsigned long cr[2];
+	volatile unsigned long unused0;
+	volatile unsigned long ilr[8];
+	volatile unsigned long unused1[4];
+	volatile unsigned long imr;
+	volatile unsigned long unused2[7];
+	volatile unsigned long scr;
+	volatile unsigned long unused3[7];
+	volatile unsigned long ssr;
+	volatile unsigned long unused4[7];
+	volatile unsigned long csr;
+};
+
+struct tx4938_ndfmc_reg {
+	endian_def_l2(unused0, dtr);
+	endian_def_l2(unused1, mcr);
+	endian_def_l2(unused2, sr);
+	endian_def_l2(unused3, isr);
+	endian_def_l2(unused4, imr);
+	endian_def_l2(unused5, spr);
+	endian_def_l2(unused6, rstr);
+};
+
+struct tx4938_spi_reg {
+	volatile unsigned long mcr;
+	volatile unsigned long cr0;
+	volatile unsigned long cr1;
+	volatile unsigned long fs;
+	volatile unsigned long unused1;
+	volatile unsigned long sr;
+	volatile unsigned long dr;
+	volatile unsigned long unused2;
+};
+
+struct tx4938_sramc_reg {
+	volatile unsigned long long cr;
+};
+
+struct tx4938_ccfg_reg {
+	volatile unsigned long long ccfg;
+	volatile unsigned long long crir;
+	volatile unsigned long long pcfg;
+	volatile unsigned long long tear;
+	volatile unsigned long long clkctr;
+	volatile unsigned long long unused0;
+	volatile unsigned long long garbc;
+	volatile unsigned long long unused1;
+	volatile unsigned long long unused2;
+	volatile unsigned long long ramp;
+	volatile unsigned long long unused3;
+	volatile unsigned long long jmpadr;
+};
+
+#undef endian_def_l2
+#undef endian_def_s2
+#undef endian_def_sb2
+#undef endian_def_b2s
+#undef endian_def_b4
+
+#endif /* __ASSEMBLY__ */
+
+/*
+ * NDFMC
+ */
+
+/* NDFMCR : NDFMC Mode Control */
+#define TX4938_NDFMCR_WE	0x80
+#define TX4938_NDFMCR_ECC_ALL	0x60
+#define TX4938_NDFMCR_ECC_RESET	0x60
+#define TX4938_NDFMCR_ECC_READ	0x40
+#define TX4938_NDFMCR_ECC_ON	0x20
+#define TX4938_NDFMCR_ECC_OFF	0x00
+#define TX4938_NDFMCR_CE	0x10
+#define TX4938_NDFMCR_BSPRT	0x04
+#define TX4938_NDFMCR_ALE	0x02
+#define TX4938_NDFMCR_CLE	0x01
+
+/* NDFMCR : NDFMC Status */
+#define TX4938_NDFSR_BUSY	0x80
+
+/* NDFMCR : NDFMC Reset */
+#define TX4938_NDFRSTR_RST	0x01
+
+/*
+ * IRC
+ */
+
+#define TX4938_IR_ECCERR	0
+#define TX4938_IR_WTOERR	1
+#define TX4938_NUM_IR_INT	6
+#define TX4938_IR_INT(n)	(2 + (n))
+#define TX4938_NUM_IR_SIO	2
+#define TX4938_IR_SIO(n)	(8 + (n))
+#define TX4938_NUM_IR_DMA	4
+#define TX4938_IR_DMA(ch,n)	((ch ? 27 : 10) + (n)) /* 10-13,27-30 */
+#define TX4938_IR_PIO	14
+#define TX4938_IR_PDMAC	15
+#define TX4938_IR_PCIC	16
+#define TX4938_NUM_IR_TMR	3
+#define TX4938_IR_TMR(n)	(17 + (n))
+#define TX4938_IR_NDFMC	21
+#define TX4938_IR_PCIERR	22
+#define TX4938_IR_PCIPME	23
+#define TX4938_IR_ACLC	24
+#define TX4938_IR_ACLCPME	25
+#define TX4938_IR_PCIC1	26
+#define TX4938_IR_SPI	31
+#define TX4938_NUM_IR	32
+/* multiplex */
+#define TX4938_IR_ETH0	TX4938_IR_INT(4)
+#define TX4938_IR_ETH1	TX4938_IR_INT(3)
+
+/*
+ * CCFG
+ */
+/* CCFG : Chip Configuration */
+#define TX4938_CCFG_WDRST	_CONST64(0x0000020000000000)
+#define TX4938_CCFG_WDREXEN	_CONST64(0x0000010000000000)
+#define TX4938_CCFG_BCFG_MASK	_CONST64(0x000000ff00000000)
+#define TX4938_CCFG_TINTDIS	0x01000000
+#define TX4938_CCFG_PCI66	0x00800000
+#define TX4938_CCFG_PCIMODE	0x00400000
+#define TX4938_CCFG_PCI1_66	0x00200000
+#define TX4938_CCFG_DIVMODE_MASK	0x001e0000
+#define TX4938_CCFG_DIVMODE_2	(0x4 << 17)
+#define TX4938_CCFG_DIVMODE_2_5	(0xf << 17)
+#define TX4938_CCFG_DIVMODE_3	(0x5 << 17)
+#define TX4938_CCFG_DIVMODE_4	(0x6 << 17)
+#define TX4938_CCFG_DIVMODE_4_5	(0xd << 17)
+#define TX4938_CCFG_DIVMODE_8	(0x0 << 17)
+#define TX4938_CCFG_DIVMODE_10	(0xb << 17)
+#define TX4938_CCFG_DIVMODE_12	(0x1 << 17)
+#define TX4938_CCFG_DIVMODE_16	(0x2 << 17)
+#define TX4938_CCFG_DIVMODE_18	(0x9 << 17)
+#define TX4938_CCFG_BEOW	0x00010000
+#define TX4938_CCFG_WR	0x00008000
+#define TX4938_CCFG_TOE	0x00004000
+#define TX4938_CCFG_PCIXARB	0x00002000
+#define TX4938_CCFG_PCIDIVMODE_MASK	0x00001c00
+#define TX4938_CCFG_PCIDIVMODE_4	(0x1 << 10)
+#define TX4938_CCFG_PCIDIVMODE_4_5	(0x3 << 10)
+#define TX4938_CCFG_PCIDIVMODE_5	(0x5 << 10)
+#define TX4938_CCFG_PCIDIVMODE_5_5	(0x7 << 10)
+#define TX4938_CCFG_PCIDIVMODE_8	(0x0 << 10)
+#define TX4938_CCFG_PCIDIVMODE_9	(0x2 << 10)
+#define TX4938_CCFG_PCIDIVMODE_10	(0x4 << 10)
+#define TX4938_CCFG_PCIDIVMODE_11	(0x6 << 10)
+#define TX4938_CCFG_PCI1DMD	0x00000100
+#define TX4938_CCFG_SYSSP_MASK	0x000000c0
+#define TX4938_CCFG_ENDIAN	0x00000004
+#define TX4938_CCFG_HALT	0x00000002
+#define TX4938_CCFG_ACEHOLD	0x00000001
+
+/* PCFG : Pin Configuration */
+#define TX4938_PCFG_ETH0_SEL	_CONST64(0x8000000000000000)
+#define TX4938_PCFG_ETH1_SEL	_CONST64(0x4000000000000000)
+#define TX4938_PCFG_ATA_SEL	_CONST64(0x2000000000000000)
+#define TX4938_PCFG_ISA_SEL	_CONST64(0x1000000000000000)
+#define TX4938_PCFG_SPI_SEL	_CONST64(0x0800000000000000)
+#define TX4938_PCFG_NDF_SEL	_CONST64(0x0400000000000000)
+#define TX4938_PCFG_SDCLKDLY_MASK	0x30000000
+#define TX4938_PCFG_SDCLKDLY(d)	((d)<<28)
+#define TX4938_PCFG_SYSCLKEN	0x08000000
+#define TX4938_PCFG_SDCLKEN_ALL	0x07800000
+#define TX4938_PCFG_SDCLKEN(ch)	(0x00800000<<(ch))
+#define TX4938_PCFG_PCICLKEN_ALL	0x003f0000
+#define TX4938_PCFG_PCICLKEN(ch)	(0x00010000<<(ch))
+#define TX4938_PCFG_SEL2	0x00000200
+#define TX4938_PCFG_SEL1	0x00000100
+#define TX4938_PCFG_DMASEL_ALL	0x0000000f
+#define TX4938_PCFG_DMASEL0_DRQ0	0x00000000
+#define TX4938_PCFG_DMASEL0_SIO1	0x00000001
+#define TX4938_PCFG_DMASEL1_DRQ1	0x00000000
+#define TX4938_PCFG_DMASEL1_SIO1	0x00000002
+#define TX4938_PCFG_DMASEL2_DRQ2	0x00000000
+#define TX4938_PCFG_DMASEL2_SIO0	0x00000004
+#define TX4938_PCFG_DMASEL3_DRQ3	0x00000000
+#define TX4938_PCFG_DMASEL3_SIO0	0x00000008
+
+/* CLKCTR : Clock Control */
+#define TX4938_CLKCTR_NDFCKD	_CONST64(0x0001000000000000)
+#define TX4938_CLKCTR_NDFRST	_CONST64(0x0000000100000000)
+#define TX4938_CLKCTR_ETH1CKD	0x80000000
+#define TX4938_CLKCTR_ETH0CKD	0x40000000
+#define TX4938_CLKCTR_SPICKD	0x20000000
+#define TX4938_CLKCTR_SRAMCKD	0x10000000
+#define TX4938_CLKCTR_PCIC1CKD	0x08000000
+#define TX4938_CLKCTR_DMA1CKD	0x04000000
+#define TX4938_CLKCTR_ACLCKD	0x02000000
+#define TX4938_CLKCTR_PIOCKD	0x01000000
+#define TX4938_CLKCTR_DMACKD	0x00800000
+#define TX4938_CLKCTR_PCICKD	0x00400000
+#define TX4938_CLKCTR_TM0CKD	0x00100000
+#define TX4938_CLKCTR_TM1CKD	0x00080000
+#define TX4938_CLKCTR_TM2CKD	0x00040000
+#define TX4938_CLKCTR_SIO0CKD	0x00020000
+#define TX4938_CLKCTR_SIO1CKD	0x00010000
+#define TX4938_CLKCTR_ETH1RST	0x00008000
+#define TX4938_CLKCTR_ETH0RST	0x00004000
+#define TX4938_CLKCTR_SPIRST	0x00002000
+#define TX4938_CLKCTR_SRAMRST	0x00001000
+#define TX4938_CLKCTR_PCIC1RST	0x00000800
+#define TX4938_CLKCTR_DMA1RST	0x00000400
+#define TX4938_CLKCTR_ACLRST	0x00000200
+#define TX4938_CLKCTR_PIORST	0x00000100
+#define TX4938_CLKCTR_DMARST	0x00000080
+#define TX4938_CLKCTR_PCIRST	0x00000040
+#define TX4938_CLKCTR_TM0RST	0x00000010
+#define TX4938_CLKCTR_TM1RST	0x00000008
+#define TX4938_CLKCTR_TM2RST	0x00000004
+#define TX4938_CLKCTR_SIO0RST	0x00000002
+#define TX4938_CLKCTR_SIO1RST	0x00000001
+
+/* bits for G2PSTATUS/G2PMASK */
+#define TX4938_PCIC_G2PSTATUS_ALL	0x00000003
+#define TX4938_PCIC_G2PSTATUS_TTOE	0x00000002
+#define TX4938_PCIC_G2PSTATUS_RTOE	0x00000001
+
+/* bits for PCIMASK (see also PCI_STATUS_XXX in linux/pci.h */
+#define TX4938_PCIC_PCISTATUS_ALL	0x0000f900
+
+/* bits for PBACFG */
+#define TX4938_PCIC_PBACFG_FIXPA	0x00000008
+#define TX4938_PCIC_PBACFG_RPBA	0x00000004
+#define TX4938_PCIC_PBACFG_PBAEN	0x00000002
+#define TX4938_PCIC_PBACFG_BMCEN	0x00000001
+
+/* bits for G2PMnGBASE */
+#define TX4938_PCIC_G2PMnGBASE_BSDIS	_CONST64(0x0000002000000000)
+#define TX4938_PCIC_G2PMnGBASE_ECHG	_CONST64(0x0000001000000000)
+
+/* bits for G2PIOGBASE */
+#define TX4938_PCIC_G2PIOGBASE_BSDIS	_CONST64(0x0000002000000000)
+#define TX4938_PCIC_G2PIOGBASE_ECHG	_CONST64(0x0000001000000000)
+
+/* bits for PCICSTATUS/PCICMASK */
+#define TX4938_PCIC_PCICSTATUS_ALL	0x000007b8
+#define TX4938_PCIC_PCICSTATUS_PME	0x00000400
+#define TX4938_PCIC_PCICSTATUS_TLB	0x00000200
+#define TX4938_PCIC_PCICSTATUS_NIB	0x00000100
+#define TX4938_PCIC_PCICSTATUS_ZIB	0x00000080
+#define TX4938_PCIC_PCICSTATUS_PERR	0x00000020
+#define TX4938_PCIC_PCICSTATUS_SERR	0x00000010
+#define TX4938_PCIC_PCICSTATUS_GBE	0x00000008
+#define TX4938_PCIC_PCICSTATUS_IWB	0x00000002
+#define TX4938_PCIC_PCICSTATUS_E2PDONE	0x00000001
+
+/* bits for PCICCFG */
+#define TX4938_PCIC_PCICCFG_GBWC_MASK	0x0fff0000
+#define TX4938_PCIC_PCICCFG_HRST	0x00000800
+#define TX4938_PCIC_PCICCFG_SRST	0x00000400
+#define TX4938_PCIC_PCICCFG_IRBER	0x00000200
+#define TX4938_PCIC_PCICCFG_G2PMEN(ch)	(0x00000100>>(ch))
+#define TX4938_PCIC_PCICCFG_G2PM0EN	0x00000100
+#define TX4938_PCIC_PCICCFG_G2PM1EN	0x00000080
+#define TX4938_PCIC_PCICCFG_G2PM2EN	0x00000040
+#define TX4938_PCIC_PCICCFG_G2PIOEN	0x00000020
+#define TX4938_PCIC_PCICCFG_TCAR	0x00000010
+#define TX4938_PCIC_PCICCFG_ICAEN	0x00000008
+
+/* bits for P2GMnGBASE */
+#define TX4938_PCIC_P2GMnGBASE_TMEMEN	_CONST64(0x0000004000000000)
+#define TX4938_PCIC_P2GMnGBASE_TBSDIS	_CONST64(0x0000002000000000)
+#define TX4938_PCIC_P2GMnGBASE_TECHG	_CONST64(0x0000001000000000)
+
+/* bits for P2GIOGBASE */
+#define TX4938_PCIC_P2GIOGBASE_TIOEN	_CONST64(0x0000004000000000)
+#define TX4938_PCIC_P2GIOGBASE_TBSDIS	_CONST64(0x0000002000000000)
+#define TX4938_PCIC_P2GIOGBASE_TECHG	_CONST64(0x0000001000000000)
+
+#define TX4938_PCIC_IDSEL_AD_TO_SLOT(ad)	((ad) - 11)
+#define TX4938_PCIC_MAX_DEVNU	TX4938_PCIC_IDSEL_AD_TO_SLOT(32)
+
+/* bits for PDMCFG */
+#define TX4938_PCIC_PDMCFG_RSTFIFO	0x00200000
+#define TX4938_PCIC_PDMCFG_EXFER	0x00100000
+#define TX4938_PCIC_PDMCFG_REQDLY_MASK	0x00003800
+#define TX4938_PCIC_PDMCFG_REQDLY_NONE	(0 << 11)
+#define TX4938_PCIC_PDMCFG_REQDLY_16	(1 << 11)
+#define TX4938_PCIC_PDMCFG_REQDLY_32	(2 << 11)
+#define TX4938_PCIC_PDMCFG_REQDLY_64	(3 << 11)
+#define TX4938_PCIC_PDMCFG_REQDLY_128	(4 << 11)
+#define TX4938_PCIC_PDMCFG_REQDLY_256	(5 << 11)
+#define TX4938_PCIC_PDMCFG_REQDLY_512	(6 << 11)
+#define TX4938_PCIC_PDMCFG_REQDLY_1024	(7 << 11)
+#define TX4938_PCIC_PDMCFG_ERRIE	0x00000400
+#define TX4938_PCIC_PDMCFG_NCCMPIE	0x00000200
+#define TX4938_PCIC_PDMCFG_NTCMPIE	0x00000100
+#define TX4938_PCIC_PDMCFG_CHNEN	0x00000080
+#define TX4938_PCIC_PDMCFG_XFRACT	0x00000040
+#define TX4938_PCIC_PDMCFG_BSWAP	0x00000020
+#define TX4938_PCIC_PDMCFG_XFRSIZE_MASK	0x0000000c
+#define TX4938_PCIC_PDMCFG_XFRSIZE_1DW	0x00000000
+#define TX4938_PCIC_PDMCFG_XFRSIZE_1QW	0x00000004
+#define TX4938_PCIC_PDMCFG_XFRSIZE_4QW	0x00000008
+#define TX4938_PCIC_PDMCFG_XFRDIRC	0x00000002
+#define TX4938_PCIC_PDMCFG_CHRST	0x00000001
+
+/* bits for PDMSTS */
+#define TX4938_PCIC_PDMSTS_REQCNT_MASK	0x3f000000
+#define TX4938_PCIC_PDMSTS_FIFOCNT_MASK	0x00f00000
+#define TX4938_PCIC_PDMSTS_FIFOWP_MASK	0x000c0000
+#define TX4938_PCIC_PDMSTS_FIFORP_MASK	0x00030000
+#define TX4938_PCIC_PDMSTS_ERRINT	0x00000800
+#define TX4938_PCIC_PDMSTS_DONEINT	0x00000400
+#define TX4938_PCIC_PDMSTS_CHNEN	0x00000200
+#define TX4938_PCIC_PDMSTS_XFRACT	0x00000100
+#define TX4938_PCIC_PDMSTS_ACCMP	0x00000080
+#define TX4938_PCIC_PDMSTS_NCCMP	0x00000040
+#define TX4938_PCIC_PDMSTS_NTCMP	0x00000020
+#define TX4938_PCIC_PDMSTS_CFGERR	0x00000008
+#define TX4938_PCIC_PDMSTS_PCIERR	0x00000004
+#define TX4938_PCIC_PDMSTS_CHNERR	0x00000002
+#define TX4938_PCIC_PDMSTS_DATAERR	0x00000001
+#define TX4938_PCIC_PDMSTS_ALL_CMP	0x000000e0
+#define TX4938_PCIC_PDMSTS_ALL_ERR	0x0000000f
+
+/*
+ * DMA
+ */
+/* bits for MCR */
+#define TX4938_DMA_MCR_EIS(ch)	(0x10000000<<(ch))
+#define TX4938_DMA_MCR_DIS(ch)	(0x01000000<<(ch))
+#define TX4938_DMA_MCR_RSFIF	0x00000080
+#define TX4938_DMA_MCR_FIFUM(ch)	(0x00000008<<(ch))
+#define TX4938_DMA_MCR_RPRT	0x00000002
+#define TX4938_DMA_MCR_MSTEN	0x00000001
+
+/* bits for CCRn */
+#define TX4938_DMA_CCR_IMMCHN	0x20000000
+#define TX4938_DMA_CCR_USEXFSZ	0x10000000
+#define TX4938_DMA_CCR_LE	0x08000000
+#define TX4938_DMA_CCR_DBINH	0x04000000
+#define TX4938_DMA_CCR_SBINH	0x02000000
+#define TX4938_DMA_CCR_CHRST	0x01000000
+#define TX4938_DMA_CCR_RVBYTE	0x00800000
+#define TX4938_DMA_CCR_ACKPOL	0x00400000
+#define TX4938_DMA_CCR_REQPL	0x00200000
+#define TX4938_DMA_CCR_EGREQ	0x00100000
+#define TX4938_DMA_CCR_CHDN	0x00080000
+#define TX4938_DMA_CCR_DNCTL	0x00060000
+#define TX4938_DMA_CCR_EXTRQ	0x00010000
+#define TX4938_DMA_CCR_INTRQD	0x0000e000
+#define TX4938_DMA_CCR_INTENE	0x00001000
+#define TX4938_DMA_CCR_INTENC	0x00000800
+#define TX4938_DMA_CCR_INTENT	0x00000400
+#define TX4938_DMA_CCR_CHNEN	0x00000200
+#define TX4938_DMA_CCR_XFACT	0x00000100
+#define TX4938_DMA_CCR_SMPCHN	0x00000020
+#define TX4938_DMA_CCR_XFSZ(order)	(((order) << 2) & 0x0000001c)
+#define TX4938_DMA_CCR_XFSZ_1W	TX4938_DMA_CCR_XFSZ(2)
+#define TX4938_DMA_CCR_XFSZ_2W	TX4938_DMA_CCR_XFSZ(3)
+#define TX4938_DMA_CCR_XFSZ_4W	TX4938_DMA_CCR_XFSZ(4)
+#define TX4938_DMA_CCR_XFSZ_8W	TX4938_DMA_CCR_XFSZ(5)
+#define TX4938_DMA_CCR_XFSZ_16W	TX4938_DMA_CCR_XFSZ(6)
+#define TX4938_DMA_CCR_XFSZ_32W	TX4938_DMA_CCR_XFSZ(7)
+#define TX4938_DMA_CCR_MEMIO	0x00000002
+#define TX4938_DMA_CCR_SNGAD	0x00000001
+
+/* bits for CSRn */
+#define TX4938_DMA_CSR_CHNEN	0x00000400
+#define TX4938_DMA_CSR_STLXFER	0x00000200
+#define TX4938_DMA_CSR_CHNACT	0x00000100
+#define TX4938_DMA_CSR_ABCHC	0x00000080
+#define TX4938_DMA_CSR_NCHNC	0x00000040
+#define TX4938_DMA_CSR_NTRNFC	0x00000020
+#define TX4938_DMA_CSR_EXTDN	0x00000010
+#define TX4938_DMA_CSR_CFERR	0x00000008
+#define TX4938_DMA_CSR_CHERR	0x00000004
+#define TX4938_DMA_CSR_DESERR	0x00000002
+#define TX4938_DMA_CSR_SORERR	0x00000001
+
+/* TX4938 Interrupt Controller (32-bit registers) */
+#define TX4938_IRC_BASE                 0xf510
+#define TX4938_IRC_IRFLAG0              0xf510
+#define TX4938_IRC_IRFLAG1              0xf514
+#define TX4938_IRC_IRPOL                0xf518
+#define TX4938_IRC_IRRCNT               0xf51c
+#define TX4938_IRC_IRMASKINT            0xf520
+#define TX4938_IRC_IRMASKEXT            0xf524
+#define TX4938_IRC_IRDEN                0xf600
+#define TX4938_IRC_IRDM0                0xf604
+#define TX4938_IRC_IRDM1                0xf608
+#define TX4938_IRC_IRLVL0               0xf610
+#define TX4938_IRC_IRLVL1               0xf614
+#define TX4938_IRC_IRLVL2               0xf618
+#define TX4938_IRC_IRLVL3               0xf61c
+#define TX4938_IRC_IRLVL4               0xf620
+#define TX4938_IRC_IRLVL5               0xf624
+#define TX4938_IRC_IRLVL6               0xf628
+#define TX4938_IRC_IRLVL7               0xf62c
+#define TX4938_IRC_IRMSK                0xf640
+#define TX4938_IRC_IREDC                0xf660
+#define TX4938_IRC_IRPND                0xf680
+#define TX4938_IRC_IRCS                 0xf6a0
+#define TX4938_IRC_LIMIT                0xf6ff
+
+
+#ifndef __ASSEMBLY__
+
+#define tx4938_sdramcptr	((struct tx4938_sdramc_reg *)TX4938_SDRAMC_REG)
+#define tx4938_ebuscptr         ((struct tx4938_ebusc_reg *)TX4938_EBUSC_REG)
+#define tx4938_dmaptr(ch)	((struct tx4938_dma_reg *)TX4938_DMA_REG(ch))
+#define tx4938_ndfmcptr		((struct tx4938_ndfmc_reg *)TX4938_NDFMC_REG)
+#define tx4938_ircptr		((struct tx4938_irc_reg *)TX4938_IRC_REG)
+#define tx4938_pcicptr		((struct tx4938_pcic_reg *)TX4938_PCIC_REG)
+#define tx4938_pcic1ptr		((struct tx4938_pcic_reg *)TX4938_PCIC1_REG)
+#define tx4938_ccfgptr		((struct tx4938_ccfg_reg *)TX4938_CCFG_REG)
+#define tx4938_tmrptr(ch)	((struct tx4938_tmr_reg *)TX4938_TMR_REG(ch))
+#define tx4938_sioptr(ch)	((struct tx4938_sio_reg *)TX4938_SIO_REG(ch))
+#define tx4938_pioptr		((struct tx4938_pio_reg *)TX4938_PIO_REG)
+#define tx4938_aclcptr		((struct tx4938_aclc_reg *)TX4938_ACLC_REG)
+#define tx4938_spiptr		((struct tx4938_spi_reg *)TX4938_SPI_REG)
+#define tx4938_sramcptr		((struct tx4938_sramc_reg *)TX4938_SRAMC_REG)
+
+
+#define TX4938_REV_MAJ_MIN()	((unsigned long)tx4938_ccfgptr->crir & 0x00ff)
+#define TX4938_REV_PCODE()	((unsigned long)tx4938_ccfgptr->crir >> 16)
+
+#define TX4938_SDRAMC_BA(ch)	((tx4938_sdramcptr->cr[ch] >> 49) << 21)
+#define TX4938_SDRAMC_SIZE(ch)	(((tx4938_sdramcptr->cr[ch] >> 33) + 1) << 21)
+
+#define TX4938_EBUSC_BA(ch)	((tx4938_ebuscptr->cr[ch] >> 48) << 20)
+#define TX4938_EBUSC_SIZE(ch)	\
+	(0x00100000 << ((unsigned long)(tx4938_ebuscptr->cr[ch] >> 8) & 0xf))
+
+
+#endif /* !__ASSEMBLY__ */
+
+#endif
Index: linux/include/asm-mips/tx4938/tx4938_mips.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux/include/asm-mips/tx4938/tx4938_mips.h	2005-06-22 12:25:09.898056584 +0900
@@ -0,0 +1,54 @@
+/*
+ * linux/include/asm-mips/tx4938/tx4938_bitmask.h
+ * Generic bitmask definitions
+ *
+ * 2003-2005 (c) MontaVista Software, Inc. This file is licensed under the
+ * terms of the GNU General Public License version 2. This program is
+ * licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ *
+ * Support for TX4938 in 2.6 - Manish Lachwani (mlachwani@mvista.com)
+ */
+
+#ifndef TX4938_TX4938_MIPS_H
+#define TX4938_TX4938_MIPS_H
+#ifndef __ASSEMBLY__
+
+#define reg_rd08(r)    ((u8 )(*((vu8 *)(r))))
+#define reg_rd16(r)    ((u16)(*((vu16*)(r))))
+#define reg_rd32(r)    ((u32)(*((vu32*)(r))))
+#define reg_rd64(r)    ((u64)(*((vu64*)(r))))
+
+#define reg_wr08(r,v)  ((*((vu8 *)(r)))=((u8 )(v)))
+#define reg_wr16(r,v)  ((*((vu16*)(r)))=((u16)(v)))
+#define reg_wr32(r,v)  ((*((vu32*)(r)))=((u32)(v)))
+#define reg_wr64(r,v)  ((*((vu64*)(r)))=((u64)(v)))
+
+typedef volatile __signed char vs8;
+typedef volatile unsigned char vu8;
+
+typedef volatile __signed short vs16;
+typedef volatile unsigned short vu16;
+
+typedef volatile __signed int vs32;
+typedef volatile unsigned int vu32;
+
+typedef s8 s08;
+typedef vs8 vs08;
+
+typedef u8 u08;
+typedef vu8 vu08;
+
+#if (_MIPS_SZLONG == 64)
+
+typedef volatile __signed__ long vs64;
+typedef volatile unsigned long vu64;
+
+#else
+
+typedef volatile __signed__ long long vs64;
+typedef volatile unsigned long long vu64;
+
+#endif
+#endif
+#endif
