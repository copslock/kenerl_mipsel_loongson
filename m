Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Feb 2006 15:31:24 +0000 (GMT)
Received: from rtsoft3.corbina.net ([85.21.88.6]:53312 "EHLO
	buildserver.ru.mvista.com") by ftp.linux-mips.org with ESMTP
	id S8133500AbWBWPae (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 23 Feb 2006 15:30:34 +0000
Received: from 192.168.1.104 ([10.150.0.9])
	by buildserver.ru.mvista.com (8.11.6/8.11.6) with ESMTP id k1NFant16396
	for <linux-mips@linux-mips.org>; Thu, 23 Feb 2006 19:36:49 +0400
Subject: NEC VR5701 support
From:	Sergey Podstavin <spodstavin@ru.mvista.com>
Reply-To: spodstavin@ru.mvista.com
To:	linux-mips <linux-mips@linux-mips.org>
Content-Type: multipart/mixed; boundary="=-qiZv6RgBUHV2eBYR2Q3B"
Organization: MontaVista
Date:	Thu, 23 Feb 2006 18:36:50 +0300
Message-Id: <1140709010.5741.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Return-Path: <spodstavin@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10616
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: spodstavin@ru.mvista.com
Precedence: bulk
X-list: linux-mips


--=-qiZv6RgBUHV2eBYR2Q3B
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



--=-qiZv6RgBUHV2eBYR2Q3B
Content-Disposition: attachment; filename=pro_mips_nec_vr5701.patch
Content-Type: text/x-patch; name=pro_mips_nec_vr5701.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Source: MontaVista Software, Inc. Sergey Podstavin <spodstavin@ru.mvista.com>
MR: 11590
Type: Enhancement
Disposition: needs submitting to linuxmips-embedded mailing list
Signed-off-by: Sergey Podstavin <spodstavin@ru.mvista.com>
Description:
    NEC Electronics Corporation VR5701 SolutionGearII board LSP

Index: linux-2.6.10/arch/mips/vr5701/tcube/irq_vr5701.c
===================================================================
--- /dev/null
+++ linux-2.6.10/arch/mips/vr5701/tcube/irq_vr5701.c
@@ -0,0 +1,194 @@
+/*
+ * arch/mips/vr5701/tcube/irq_vr5701.c
+ *
+ * This file defines the irq handler for NEC Electronics Corporation VR5701 SolutionGearII
+ *
+ * Author: Sergey Podstavin <spodstavin@ru.mvista.com>
+ *
+ * 2005 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+/*
+ * NEC Electronics Corporation VR5701 SolutionGearII defines 32 IRQs.
+ *
+ */
+#include <linux/interrupt.h>
+#include <linux/types.h>
+#include <linux/ptrace.h>
+
+#include <asm/debug.h>
+#include <asm/tcube.h>
+
+static int vr5701_irq_base = -1;
+
+void ll_vr5701_irq_disable(int vr5701_irq, int ack);
+
+static void vr5701_irq_enable(unsigned int irq)
+{
+	ll_vr5701_irq_enable(irq - vr5701_irq_base);
+}
+
+static void vr5701_irq_disable(unsigned int irq)
+{
+	ll_vr5701_irq_disable(irq - vr5701_irq_base, 0);
+}
+
+static unsigned int vr5701_irq_startup(unsigned int irq)
+{
+	vr5701_irq_enable(irq);
+	return 0;
+}
+
+static void vr5701_irq_ack(unsigned int irq)
+{
+	unsigned long flags;
+	local_irq_save(flags);
+
+	/* clear the interrupt bit for edge trigger */
+	/* some irqs require the driver to clear the sources */
+	if (irq < vr5701_irq_base + NUM_5701_IRQ) {
+		ddb_out32(INT_CLR, 1 << (irq - vr5701_irq_base));
+	}
+	/* don't need for PCIs, for they are level triger */
+
+	/* disable interrupt - some handler will re-enable the irq
+	 * and if the interrupt is leveled, we will have infinite loop
+	 */
+	ll_vr5701_irq_disable(irq - vr5701_irq_base, 1);
+	local_irq_restore(flags);
+}
+
+static void vr5701_irq_end(unsigned int irq)
+{
+	unsigned long flags;
+	local_irq_save(flags);
+
+	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS))) {
+		ll_vr5701_irq_enable(irq - vr5701_irq_base);
+	}
+	local_irq_restore(flags);
+}
+
+struct hw_interrupt_type vr5701_irq_type = {
+	"vr5701_irq",
+	vr5701_irq_startup,
+	vr5701_irq_disable,
+	vr5701_irq_enable,
+	vr5701_irq_disable,
+	vr5701_irq_ack,
+	vr5701_irq_end,
+	NULL			/* no affinity stuff for UP */
+};
+
+void vr5701_irq_init(u32 irq_base)
+{
+	extern irq_desc_t irq_desc[];
+	u32 i;
+	vr5701_irq_base = irq_base;
+	for (i = irq_base;
+	     i < irq_base + NUM_5701_IRQ + NUM_EPCI_IRQ + NUM_IPCI_IRQ; i++) {
+		irq_desc[i].status = IRQ_DISABLED;
+		irq_desc[i].action = 0;
+		irq_desc[i].depth = 1;
+		irq_desc[i].handler = &vr5701_irq_type;
+	}
+}
+
+int vr5701_irq_to_irq(int irq)
+{
+	return irq + vr5701_irq_base;
+}
+
+void ll_vr5701_irq_route(int vr5701_irq, int ip)
+{
+	u32 reg_value;
+	u32 reg_bitmask;
+	u32 reg_index;
+
+	if (vr5701_irq >= NUM_5701_IRQ) {
+		if (vr5701_irq >= NUM_5701_IRQ + NUM_EPCI_IRQ) {
+			vr5701_irq = 7;
+		} else {
+			vr5701_irq = 6;
+		}
+	}
+	reg_index = INT_ROUTE0 + vr5701_irq / 8 * 4;
+	reg_value = ddb_in32(reg_index);
+	reg_bitmask = 7 << (vr5701_irq % 8 * 4);
+	reg_value &= ~reg_bitmask;
+	reg_value |= ip << (vr5701_irq % 8 * 4);
+	ddb_out32(reg_index, reg_value);
+}
+
+void ll_vr5701_irq_enable(int vr5701_irq)
+{
+	u16 reg_value;
+	u32 reg_bitmask;
+	unsigned long flags;
+
+	local_irq_save(flags);
+	irq_desc[vr5701_irq_base + vr5701_irq].depth++;
+
+	if (vr5701_irq >= NUM_5701_IRQ) {
+		if (vr5701_irq >= NUM_5701_IRQ + NUM_EPCI_IRQ) {
+			reg_value = ddb_in32(IPCI_INTM);
+			reg_bitmask =
+			    1 << (vr5701_irq - NUM_5701_IRQ - NUM_EPCI_IRQ);
+			ddb_out32(IPCI_INTM, reg_value | reg_bitmask);
+			vr5701_irq = 7;
+		} else {
+			reg_value = ddb_in32(EPCI_INTM);
+			reg_bitmask = 1 << (vr5701_irq - NUM_5701_IRQ);
+			ddb_out32(EPCI_INTM, reg_value | reg_bitmask);
+			vr5701_irq = 6;
+		}
+	}
+	reg_value = ddb_in32(INT_MASK);
+	ddb_out32(INT_MASK, reg_value | (1 << vr5701_irq));
+	local_irq_restore(flags);
+}
+
+void ll_vr5701_irq_disable(int vr5701_irq, int ack)
+{
+	u16 reg_value;
+	u32 udummy;
+	u32 reg_bitmask;
+	unsigned long flags;
+
+	local_irq_save(flags);
+	if (!ack) {
+		irq_desc[vr5701_irq_base + vr5701_irq].depth--;
+		if (irq_desc[vr5701_irq_base + vr5701_irq].depth) {
+			local_irq_restore(flags);
+			return;
+		}
+	}
+
+	if (vr5701_irq >= NUM_5701_IRQ) {
+		if (vr5701_irq >= NUM_5701_IRQ + NUM_EPCI_IRQ) {
+			goto DISABLE_IRQ_IPCI;
+		} else {
+			goto DISABLE_IRQ_EPCI;
+		}
+	}
+	reg_value = ddb_in32(INT_MASK);
+	ddb_out32(INT_MASK, reg_value & ~(1 << vr5701_irq));
+	udummy = ddb_in32(INT_MASK);
+	local_irq_restore(flags);
+	return;
+
+      DISABLE_IRQ_IPCI:
+	reg_value = ddb_in32(IPCI_INTM);
+	reg_bitmask = 1 << (vr5701_irq - NUM_5701_IRQ - NUM_EPCI_IRQ);
+	ddb_out32(IPCI_INTM, reg_value & ~reg_bitmask);
+	local_irq_restore(flags);
+	return;
+
+      DISABLE_IRQ_EPCI:
+	reg_value = ddb_in32(EPCI_INTM);
+	reg_bitmask = 1 << (vr5701_irq - NUM_5701_IRQ);
+	ddb_out32(EPCI_INTM, reg_value & ~reg_bitmask);
+	local_irq_restore(flags);
+}
Index: linux-2.6.10/arch/mips/pci/pci-tcube.c
===================================================================
--- /dev/null
+++ linux-2.6.10/arch/mips/pci/pci-tcube.c
@@ -0,0 +1,126 @@
+/*
+ * arch/mips/pci/pci-tcube.c
+ *
+ * A code for PCI controllers on NEC Electronics Corporation VR5701 SolutionGearII 
+ *
+ * Author: Sergey Podstavin <spodstavin@ru.mvista.com>
+ *
+ * 2005 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/pci.h>
+#include <asm/bootinfo.h>
+#include <asm/debug.h>
+#include <asm/byteorder.h>
+#include <asm/tcube.h>
+
+static struct resource extpci_io_resource = {
+	"ext pci IO space",
+	0x00001000,
+	0x007FFFFF,
+	IORESOURCE_IO
+};
+
+static struct resource extpci_mem_resource = {
+	"ext pci memory space",
+	0x10000000,
+	0x17FFFFFF,
+	IORESOURCE_MEM
+};
+
+static struct resource iopci_io_resource = {
+	"io pci IO space",
+	0x01000000,
+	0x017FFFFF,
+	IORESOURCE_IO
+};
+
+static struct resource iopci_mem_resource = {
+	"io pci memory space",
+	0x18800000,
+	0x18FFFFFF,
+	IORESOURCE_MEM
+};
+
+struct pci_controller VR5701_ext_controller = {
+	.pci_ops = &VR5701_ext_pci_ops,
+	.io_resource = &extpci_io_resource,
+	.mem_resource = &extpci_mem_resource
+};
+
+struct pci_controller VR5701_io_controller = {
+	.pci_ops = &VR5701_io_pci_ops,
+	.io_resource = &iopci_io_resource,
+	.mem_resource = &iopci_mem_resource
+};
+
+int __init pcibios_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
+{
+	int slot_num;
+	int k = 0;
+
+	slot_num = PCI_SLOT(dev->devfn);
+
+	if (dev->bus->number == 0) {	/* EPCI */
+		switch (slot_num) {
+		case 24 - 11:   /* INTD# */
+			k = NUM_5701_IRQS + 3;
+			break;
+		case 25 - 11:	/* INTC# */
+			k = NUM_5701_IRQS + 2;
+			break;
+		case 26 - 11:	/* INTB# */
+			k = NUM_5701_IRQS + 1;
+			break;
+		case 27 - 11:	/* INTA# */
+			k = NUM_5701_IRQS + 0;
+			break;
+		}
+	} else {		/* IPCI */
+		switch (slot_num) {
+		case 29 - 11:	/* INTC# */
+			k = NUM_5701_IRQS + NUM_5701_EPCI_IRQ + 2;
+			break;
+		case 30 - 11:	/* INTB# */
+			k = NUM_5701_IRQS + NUM_5701_EPCI_IRQ + 1;
+			break;
+		case 31 - 11:	/* INTA# */
+			k = NUM_5701_IRQS + NUM_5701_EPCI_IRQ + 0;
+			break;
+		}
+	}
+	pci_write_config_byte(dev, PCI_INTERRUPT_LINE, k);
+	dev->irq = k + 8;
+	return dev->irq;
+}
+
+void ddb_pci_reset_bus(void)
+{
+	u32 temp;
+
+	temp = ddb_in32(EPCI_CTRLH);
+	temp |= 0x80000000;
+	ddb_out32(EPCI_CTRLH, temp);
+	udelay(100);
+	temp &= ~0xc0000000;
+	ddb_out32(EPCI_CTRLH, temp);
+
+	temp = ddb_in32(IPCI_CTRLH);
+	temp |= 0x80000000;
+	ddb_out32(IPCI_CTRLH, temp);
+	udelay(100);
+	temp &= ~0xc0000000;
+	ddb_out32(IPCI_CTRLH, temp);
+}
+
+/* Do platform specific device initialization at pci_enable_device() time */
+int pcibios_plat_dev_init(struct pci_dev *dev)
+{
+	return 0;
+}
Index: linux-2.6.10/include/asm-mips/serial.h
===================================================================
--- linux-2.6.10.orig/include/asm-mips/serial.h
+++ linux-2.6.10/include/asm-mips/serial.h
@@ -412,6 +412,21 @@
 #define DDB5477_SERIAL_PORT_DEFNS
 #endif
 
+#ifdef CONFIG_TCUBE
+#include <asm/tcube.h>
+#define TCUBE_SERIAL_PORT_DEFNS                                   \
+	{ baud_base: BASE_BAUD, irq: 16, flags: STD_COM_FLAGS,          \
+	  iomem_base: (u8*)0xbe000a00, iomem_reg_shift: 3,              \
+	  io_type: SERIAL_IO_MEM},\
+	{ baud_base: BASE_BAUD, irq: 17, flags: STD_COM_FLAGS,          \
+	  iomem_base: (u8*)0xbe000a40, iomem_reg_shift: 3,              \
+	  io_type: SERIAL_IO_MEM},
+#else
+#define TCUBE_SERIAL_PORT_DEFNS
+#endif
+
+
+
 #ifdef CONFIG_SGI_IP32
 /*
  * The IP32 (SGI O2) has standard serial ports (UART 16550A) mapped in memory
@@ -439,6 +454,7 @@
 	MOMENCO_OCELOT_SERIAL_PORT_DEFNS		\
 	MOMENCO_OCELOT_3_SERIAL_PORT_DEFNS		\
 	TXX927_SERIAL_PORT_DEFNS                        \
-	AU1000_SERIAL_PORT_DEFNS
+	AU1000_SERIAL_PORT_DEFNS                        \
+	TCUBE_SERIAL_PORT_DEFNS
 
 #endif /* _ASM_SERIAL_H */
Index: linux-2.6.10/drivers/ide/pci/Makefile
===================================================================
--- linux-2.6.10.orig/drivers/ide/pci/Makefile
+++ linux-2.6.10/drivers/ide/pci/Makefile
@@ -28,6 +28,7 @@ obj-$(CONFIG_BLK_DEV_SLC90E66)		+= slc90
 obj-$(CONFIG_BLK_DEV_TRIFLEX)		+= triflex.o
 obj-$(CONFIG_BLK_DEV_TRM290)		+= trm290.o
 obj-$(CONFIG_BLK_DEV_VIA82CXXX)		+= via82cxxx.o
+obj-$(CONFIG_BLK_DEV_NEC_VR5701_SG2)	+= nec_vr5701_sg2.o
 
 # Must appear at the end of the block
 obj-$(CONFIG_BLK_DEV_GENERIC)          += generic.o
Index: linux-2.6.10/drivers/ide/pci/nec_vr5701_sg2.c
===================================================================
--- /dev/null
+++ linux-2.6.10/drivers/ide/pci/nec_vr5701_sg2.c
@@ -0,0 +1,111 @@
+/*
+ * drivers/ide/pci/nec_vr5701_sg2.c
+ *
+ * NEC Electronics Corporation VR5701 SolutionGearII IDE controller driver
+ *
+ * Author: Sergey Podstavin <spodstavin@ru.mvista.com>
+ *
+ * 2005 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+#include <linux/config.h>
+#include <linux/pci.h>
+#include <linux/ide.h>
+#include <linux/config.h>
+#include <linux/types.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/timer.h>
+#include <linux/mm.h>
+#include <linux/ioport.h>
+#include <linux/blkdev.h>
+#include <linux/hdreg.h>
+#include <linux/pci.h>
+#include <linux/ide.h>
+#include <linux/init.h>
+#include <asm/io.h>
+
+static unsigned int __init init_chipset_nec_vr5701(struct pci_dev *dev,
+						   const char *name)
+{
+	return 0;
+}
+
+static void __init init_hwif_nec_vr5701(ide_hwif_t * hwif)
+{
+	if (!(hwif->dma_base))
+		return;
+
+	hwif->atapi_dma = 1;
+	hwif->ultra_mask = 0x7f;
+	hwif->mwdma_mask = 0x07;
+	hwif->swdma_mask = 0x07;
+
+	if (!noautodma)
+		hwif->autodma = 1;
+	hwif->drives[0].autodma = hwif->autodma;
+	hwif->drives[1].autodma = hwif->autodma;
+}
+
+static ide_pci_device_t nec_vr5701_chipset __devinitdata = {
+	.name = "NEC Electronics Corporation VR5701 SolutionGearII",
+	.init_chipset = init_chipset_nec_vr5701,
+	.init_hwif = init_hwif_nec_vr5701,
+	.channels = 2,
+	.autodma = AUTODMA,
+	.bootable = ON_BOARD,
+};
+
+static int __devinit nec_vr5701_init_one(struct pci_dev *dev,
+					 const struct pci_device_id *id)
+{
+	ide_pci_device_t *d = &nec_vr5701_chipset;
+	u16 command;
+
+	if (dev->vendor == PCI_VENDOR_ID_NEC &&
+	    dev->device == PCI_DEVICE_ID_NEC_USB_AND_IDE &&
+	    dev->class == 0x0c0310)
+		return 1;
+	udelay(100);
+	pci_enable_device(dev);
+	*(volatile unsigned char *)0xb9001010 = 6;
+	asm("sync");
+	udelay(100);
+
+	pci_read_config_word(dev, PCI_COMMAND, &command);
+	if (!(command & PCI_COMMAND_IO)) {
+		printk(KERN_INFO "Skipping disabled %s IDE controller.\n",
+		       d->name);
+		return 1;
+	}
+	ide_setup_pci_device(dev, d);
+	return 0;
+}
+
+static struct pci_device_id nec_vr5701_pci_tbl[] = {
+	{PCI_VENDOR_ID_NEC, PCI_DEVICE_ID_NEC_USB_AND_IDE, PCI_ANY_ID,
+	 PCI_ANY_ID, 0x010185, 0xffffff, 0},
+	{0,},
+};
+
+MODULE_DEVICE_TABLE(pci, nec_vr5701_pci_tbl);
+
+static struct pci_driver driver = {
+	.name = "nec_vr5701_IDE",
+	.id_table = nec_vr5701_pci_tbl,
+	.probe = nec_vr5701_init_one,
+};
+
+static int nec_vr5701_ide_init(void)
+{
+	return ide_pci_register_driver(&driver);
+}
+
+module_init(nec_vr5701_ide_init);
+
+MODULE_AUTHOR("Sergey Podstavin");
+MODULE_DESCRIPTION("PCI driver module for NEC Electronics Corporation VR5701 SolutionGearII IDE");
+MODULE_LICENSE("GPL");
Index: linux-2.6.10/arch/mips/Makefile
===================================================================
--- linux-2.6.10.orig/arch/mips/Makefile
+++ linux-2.6.10/arch/mips/Makefile
@@ -183,6 +183,10 @@ cflags-$(CONFIG_CPU_R5432)	+= \
 			$(call set_gccflags,r5400,mips4,r5000,mips4,mips2) \
 			-Wa,--trap
 
+cflags-$(CONFIG_CPU_R5500)	+= \
+			$(call set_gccflags,mips32,mips4,r5000,mips4,mips2) \
+			-Wa,--trap
+
 cflags-$(CONFIG_CPU_NEVADA)	+= \
 			$(call set_gccflags,rm5200,mips4,r5000,mips4,mips2) \
 			-Wa,--trap
@@ -472,6 +476,13 @@ load-$(CONFIG_DDB5476)		+= 0xffffffff800
 core-$(CONFIG_DDB5477)		+= arch/mips/ddb5xxx/ddb5477/
 load-$(CONFIG_DDB5477)		+= 0xffffffff80100000
 
+#
+# NEC TCUBE
+#
+core-$(CONFIG_TCUBE)		+= arch/mips/vr5701/common/
+core-$(CONFIG_TCUBE)		+= arch/mips/vr5701/tcube/
+load-$(CONFIG_TCUBE)		+= 0xffffffff80080000
+
 core-$(CONFIG_LASAT)		+= arch/mips/lasat/
 cflags-$(CONFIG_LASAT)		+= -Iinclude/asm-mips/mach-lasat
 load-$(CONFIG_LASAT)		+= 0xffffffff80000000
Index: linux-2.6.10/include/asm-mips/tlb.h
===================================================================
--- linux-2.6.10.orig/include/asm-mips/tlb.h
+++ linux-2.6.10/include/asm-mips/tlb.h
@@ -6,7 +6,7 @@
  * we need to flush cache for area to be unmapped.
  */
 #ifdef CONFIG_PREEMPT_RT
-#ifdef CONFIG_CPU_MIPS32
+#if defined(CONFIG_CPU_MIPS32) || defined(CONFIG_CPU_R5500)
 /*
  * We need the cache flush in case of such processors, eg. MIPS Malta
  */
Index: linux-2.6.10/arch/mips/mm/Makefile
===================================================================
--- linux-2.6.10.orig/arch/mips/mm/Makefile
+++ linux-2.6.10/arch/mips/mm/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_CPU_R4300)		+= c-r4k.o cex-
 obj-$(CONFIG_CPU_R4X00)		+= c-r4k.o cex-gen.o pg-r4k.o tlb-r4k.o
 obj-$(CONFIG_CPU_R5000)		+= c-r4k.o cex-gen.o pg-r4k.o tlb-r4k.o
 obj-$(CONFIG_CPU_R5432)		+= c-r4k.o cex-gen.o pg-r4k.o tlb-r4k.o
+obj-$(CONFIG_CPU_R5500)		+= c-r4k.o cex-gen.o pg-r4k.o tlb-r4k.o
 obj-$(CONFIG_CPU_R8000)		+= c-r4k.o cex-gen.o pg-r4k.o tlb-r8k.o
 obj-$(CONFIG_CPU_RM7000)	+= c-r4k.o cex-gen.o pg-r4k.o tlb-r4k.o
 obj-$(CONFIG_CPU_RM9000)	+= c-r4k.o cex-gen.o pg-r4k.o tlb-r4k.o
Index: linux-2.6.10/include/asm-mips/vr5701.h
===================================================================
--- /dev/null
+++ linux-2.6.10/include/asm-mips/vr5701.h
@@ -0,0 +1,96 @@
+/*
+ * include/asm-mips/vr5701.h
+ *
+ * A header for NEC Electronics Corporation VR5701 SolutionGearII CPU
+ *
+ * Author: Sergey Podstavin <spodstavin@ru.mvista.com>
+ *
+ * 2005 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+#ifndef __VR5701_H
+#define __VR5701_H
+
+#define VR5701_IO_BASE	0xbe000000
+
+/* PADR registers */
+#define PADR_SDRAM01	0x40
+#define PADR_LOCALCS0	0x80
+#define PADR_PCIW0	0xC0
+#define PADR_PCIW1	0xC8
+#define PADR_EPCIW0	0xC0
+#define PADR_IOPCIW0	0xE0
+#define PADR_IOPCIW1	0xE8
+/* INT registers */
+#define INT0_STAT	0x100
+#define INT1_STAT	0x108
+#define INT2_STAT	0x110
+#define INT3_STAT	0x118
+#define INT4_STAT	0x120
+#define NMI_STAT	0x130
+#define INT_CLR		0x140
+#define INT_MASK	0x150
+#define INT_ROUTE0	0x160
+#define INT_ROUTE1	0x168
+#define INT_ROUTE2	0x170
+#define INT_ROUTE3	0x178
+/* LOCAL registers */
+#define LOCAL_CST0	0x400
+#define LOCAL_CFG	0x440
+/* EPCI registers */
+#define EPCI_CTRLH	0x604
+#define EPCI_INIT0	0x610
+#define EPCI_INIT1	0x618
+#define EPCI_ERR	0x628
+#define EPCI_INTS	0x630
+#define EPCI_INTM	0x638
+/* PCI registers */
+#define PCI_MLTIM	0x70D
+#define PCI_BAR_MEM01	0x710
+#define PCI_BAR_LCS0	0x740
+#define PCI_BAR_LCS1	0x748
+#define PCI_BAR_LCS2	0x750
+#define PCI_BAR_LCS3	0x758
+#define PCI_BAR_IPCIW0	0x7A0
+#define PCI_BAR_IPCIW1	0x7A8
+#define PCI_BAR_IREG	0x7C0
+
+/* PIB registers*/
+#define PIB_RESET	0x800
+#define PIB_MISC	0x830
+
+/* GPIO registers*/
+#define GIU_PIO0	0x940
+#define GIU_DIR0	0x950
+#define GIU_DIR1	0x958
+#define GIU_FUNCSEL0	0x960
+#define GIU_FUNCSEL1	0x968
+
+/* CSI1 registers*/
+#define CSI1_MODE	0xB80
+#define CSI1_SIRB	0xB88
+#define CSI1_SOTB	0xB90
+#define CSI1_SOTBF	0xBA0
+#define CSI1_CNT	0xBC0
+#define CSI1_INT	0xBC8
+
+/* IPCI registers*/
+#define IPCI_CTRLH	0xE04
+#define IPCI_INIT0	0xE10
+#define IPCI_INIT1	0xE18
+#define IPCI_ERR	0xE28
+#define IPCI_INTS	0xE30
+#define IPCI_INTM	0xE38
+/* PCI registers */
+#define IPCI_MLTIM	0xF0D
+#define IPCI_BAR_LCS0	0xF40
+#define IPCI_BAR_LCS1	0xF48
+#define IPCI_BAR_LCS2	0xF50
+#define IPCI_BAR_LCS3	0xF58
+#define IPCI_BAR_EPCIW0	0xF80
+#define IPCI_BAR_EPCIW1	0xF88
+#define IPCI_BAR_IREG	0xFC0
+
+#endif				/*  __VR5701_H */
Index: linux-2.6.10/arch/mips/vr5701/tcube/int-handler.S
===================================================================
--- /dev/null
+++ linux-2.6.10/arch/mips/vr5701/tcube/int-handler.S
@@ -0,0 +1,77 @@
+/*
+ * arch/mips/vr5701/tcube/int-handler.S
+ *
+ * First-level interrupt dispatcher for NEC Electronics Corporation VR5701 SolutionGearII
+ *
+ * Author: Sergey Podstavin <spodstavin@ru.mvista.com>
+ *
+ * 2005 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+#include <linux/config.h>
+#include <asm/asm.h>
+#include <asm/mipsregs.h>
+#include <asm/addrspace.h>
+#include <asm/regdef.h>
+#include <asm/stackframe.h>
+#include <asm/tcube.h>
+
+/*
+ * first level interrupt dispatcher for ocelot board -
+ * We check for the timer first, then check PCI ints A and D.
+ * Then check for serial IRQ and fall through.
+ */
+	.align	5
+	NESTED(tcube_handle_int, PT_SIZE, sp)
+	SAVE_ALL
+	CLI
+	.set	at
+	.set	noreorder
+	mfc0	t0, CP0_CAUSE  
+	mfc0	t2, CP0_STATUS
+
+	and	t0, t2
+       
+	andi	t1, t0, STATUSF_IP7	/* cpu timer */
+	bnez	t1, ll_cputimer_irq
+	andi	t1, t0, (STATUSF_IP2 | STATUSF_IP3 | STATUSF_IP4 | STATUSF_IP5 | STATUSF_IP6 ) 
+	bnez	t1, ll_tcube_irq
+	andi	t1, t0, STATUSF_IP0	/* software int 0 */
+	bnez	t1, ll_cpu_ip0
+	andi	t1, t0, STATUSF_IP1	/* software int 1 */
+	bnez	t1, ll_cpu_ip1
+	nop
+	.set	reorder
+
+	/* wrong alarm or masked ... */
+	j	spurious_interrupt
+	nop
+	END(tcube_handle_int)
+
+	.align	5
+
+ll_tcube_irq:	
+	move	a0, sp
+	jal	tcube_irq_dispatch
+	j	ret_from_irq
+
+ll_cputimer_irq:
+	li	a0, 7
+	move	a1, sp
+	jal	do_IRQ
+	j	ret_from_irq
+
+
+ll_cpu_ip0:	
+	li	a0, 0
+	move	a1, sp
+	jal	do_IRQ
+	j	ret_from_irq
+
+ll_cpu_ip1:	
+	li	a0, 1
+	move	a1, sp
+	jal	do_IRQ
+	j	ret_from_irq
Index: linux-2.6.10/include/asm-mips/tcube.h
===================================================================
--- /dev/null
+++ linux-2.6.10/include/asm-mips/tcube.h
@@ -0,0 +1,200 @@
+/*
+ * include/asm-mips/tcube.h
+ *
+ * Flash memory access on NEC Electronics Corporation VR5701 SolutionGearII board.
+ *
+ * Author: Sergey Podstavin <spodstavin@ru.mvista.com>
+ *
+ * 2005 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+#ifndef __TCUBE_H
+#define __TCUBE_H
+
+#include <asm/vr5701.h>
+
+#define TCUBE_SDRAM_SIZE 	0x10000000
+
+#ifndef __ASSEMBLY__
+#include <asm/delay.h>
+
+/*
+ *  PCI Master Registers
+ */
+
+#define DDB_PCICMD_IACK		0	/* PCI Interrupt Acknowledge */
+#define DDB_PCICMD_IO		1	/* PCI I/O Space */
+#define DDB_PCICMD_MEM		3	/* PCI Memory Space */
+#define DDB_PCICMD_CFG		5	/* PCI Configuration Space */
+
+/*
+ * additional options for pci init reg (no shifting needed)
+ */
+#define DDB_PCI_CFGTYPE1     	0x200	/* for pci init0/1 regs */
+#define DDB_PCI_ACCESS_32    	0x10	/* for pci init0/1 regs */
+#define NUM_5701_IRQS 	  	32
+#define NUM_5701_EPCI_IRQ 	4
+
+/* A Real Time Clock interface for Linux on NEC Electronics Corporation VR5701 SolutionGearII */
+#define SET_32_BIT		0xffffffff
+#define CLR_32_BIT		0x00000000
+
+#define GPIO_3_INTR		(0x1 <<  3)
+#define GPIO_4_CE		(0x1 <<  4)
+#define GPIO_25_S1CLK		(0x1 << 25)
+#define GPIO_26_S1DO		(0x1 << 26)
+#define GPIO_27_S1DI		(0x1 << 27)
+#define GPIO_CSI1_PIN	(GPIO_25_S1CLK | GPIO_26_S1DO | GPIO_27_S1DI)
+
+#define CSIn_MODE_CKP		(0x1 << 12)
+#define CSIn_MODE_DAP		(0x1 << 11)
+#define CSIn_MODE_CKS_MASK	(0x7 <<  8)
+#define CSIn_MODE_CKS_833333MHZ	(0x1 <<  8)
+#define CSIn_MODE_CKS_416667MHZ	(0x2 <<  8)
+#define CSIn_MODE_CKS_208333MHZ	(0x3 <<  8)
+#define CSIn_MODE_CKS_104167MHZ	(0x4 <<  8)
+#define CSIn_MODE_CKS_052083MHZ	(0x5 <<  8)
+#define CSIn_MODE_CKS_0260417HZ	(0x6 <<  8)	/* Default */
+#define CSIn_MODE_CSIE		(0x1 <<  7)
+#define CSIn_MODE_TRMD		(0x1 <<  6)
+#define CSIn_MODE_CCL_16	(0x1 <<  5)
+#define CSIn_MODE_DIR_LSB	(0x1 <<  4)
+#define CSIn_MODE_AUTO		(0x1 <<  2)
+#define CSIn_MODE_CSOT		(0x1 <<  0)
+
+#define CSIn_INT_CSIEND		(0x1 << 15)
+#define CSIn_INT_T_EMP		(0x1 <<  8)
+#define CSIn_INT_R_OVER		(0x1 <<  0)
+
+/* IRQs */
+#define ACTIVE_LOW		1
+#define ACTIVE_HIGH		0
+
+#define LEVEL_SENSE		2
+#define EDGE_TRIGGER		0
+
+#define NUM_5701_IRQS 		32
+#define NUM_5701_EPCI_IRQS 	4
+#define NUM_5701_IPCI_IRQS 	8
+#define NUM_5701_IRQ  		32
+#define NUM_EPCI_IRQ  		4
+#define NUM_IPCI_IRQ  		8
+
+#define INTA			0
+#define INTB			1
+#define INTC			2
+#define INTD			3
+#define INTE			4
+
+/* Timers */
+#define	CPU_COUNTER_FREQUENCY		166666666
+
+#define ddb_sync       		io_sync
+#define ddb_out32(x,y) 		io_out32(x,y)
+#define ddb_out16(x,y) 		io_out16(x,y)
+#define ddb_out8(x,y)  		io_out8(x,y)
+#define ddb_in32(x)    		io_in32(x)
+#define ddb_in16(x)    		io_in16(x)
+#define ddb_in8(x)     		io_in8(x)
+
+static inline void io_sync(void)
+{
+	asm("sync");
+}
+
+static inline void io_out32(u32 offset, u32 val)
+{
+	*(volatile u32 *)(VR5701_IO_BASE + offset) = val;
+	io_sync();
+}
+
+static inline u32 io_in32(u32 offset)
+{
+	u32 val = *(volatile u32 *)(VR5701_IO_BASE + offset);
+	io_sync();
+	return val;
+}
+
+static inline void io_out16(u32 offset, u16 val)
+{
+	*(volatile u16 *)(VR5701_IO_BASE + offset) = val;
+	io_sync();
+}
+
+static inline u16 io_in16(u32 offset)
+{
+	u16 val = *(volatile u16 *)(VR5701_IO_BASE + offset);
+	io_sync();
+	return val;
+}
+
+static inline void io_reset16(unsigned long adr,
+			      unsigned short val1,
+			      unsigned delay, unsigned short val2)
+{
+	io_out16(adr, val1);
+	__delay(delay);
+	io_out16(adr, val2);
+}
+
+static inline void io_out8(u32 offset, u8 val)
+{
+	*(volatile u8 *)(VR5701_IO_BASE + offset) = val;
+	io_sync();
+}
+
+static inline u8 io_in8(u32 offset)
+{
+	u8 val = *(volatile u8 *)(VR5701_IO_BASE + offset);
+	io_sync();
+	return val;
+}
+
+static inline void io_set16(u32 offset, u16 mask, u16 val)
+{
+	u16 val0 = io_in16(offset);
+	io_out16(offset, (val & mask) | (val0 & ~mask));
+}
+
+static inline void reg_set32(u32 offset, u32 mask, u32 val)
+{
+	u32 val0 = io_in32(offset);
+	io_out32(offset, (val & mask) | (val0 & ~mask));
+}
+
+static inline void csi1_reset(void)
+{
+	/* CSI1 reset */
+	reg_set32(CSI1_CNT, 0x00008000, SET_32_BIT);	/* set CSIRST bit */
+	__delay(100000);
+	reg_set32(CSI1_CNT, 0x00008000, CLR_32_BIT);	/* clear CSIRST bit */
+	/* set clock phase  */
+	while (io_in32(CSI1_MODE) & 1) ;
+	reg_set32(CSI1_MODE, CSIn_MODE_CSIE, CLR_32_BIT);
+	reg_set32(CSI1_MODE, CSIn_MODE_CKP, SET_32_BIT);
+	reg_set32(CSI1_MODE, CSIn_MODE_CKS_104167MHZ, SET_32_BIT);
+	reg_set32(CSI1_MODE, CSIn_MODE_CSIE, SET_32_BIT);
+	while (io_in32(CSI1_MODE) & CSIn_MODE_CSOT) ;
+}
+
+extern void ll_vr5701_irq_route(int vr5701_irq, int ip);
+extern void ll_vr5701_irq_enable(int vr5701_irq);
+extern void ddb_set_pdar(u32, u32, u32, int, int, int);
+extern void ddb_set_pmr(u32 pmr, u32 type, u32 addr, u32 options);
+extern void ddb_set_bar(u32 bar, u32 phys, int prefetchable);
+extern void ddb_pci_reset_bus(void);
+extern struct pci_ops VR5701_ext_pci_ops;
+extern struct pci_ops VR5701_io_pci_ops;
+extern struct pci_controller VR5701_ext_controller;
+extern struct pci_controller VR5701_io_controller;
+extern int shima_tcube_setup(void);
+extern void tcube_irq_init(u32 base);
+extern void mips_cpu_irq_init(u32 base);
+extern asmlinkage void tcube_handle_int(void);
+extern void vr5701_irq_init(u32 irq_base);
+extern int panic_timeout;
+
+#endif
+#endif
Index: linux-2.6.10/drivers/video/Makefile
===================================================================
--- linux-2.6.10.orig/drivers/video/Makefile
+++ linux-2.6.10/drivers/video/Makefile
@@ -36,6 +36,7 @@ obj-$(CONFIG_FB_I810)             += cfb
 				     vgastate.o
 obj-$(CONFIG_FB_INTEL)            += cfbfillrect.o cfbcopyarea.o \
 	                             cfbimgblt.o
+obj-$(CONFIG_FB_SM)               += smi/ cfbfillrect.o cfbcopyarea.o cfbimgblt.o
 
 obj-$(CONFIG_FB_RADEON_OLD)	  += radeonfb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
 obj-$(CONFIG_FB_NEOMAGIC)         += neofb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o vgastate.o
Index: linux-2.6.10/arch/mips/kernel/Makefile
===================================================================
--- linux-2.6.10.orig/arch/mips/kernel/Makefile
+++ linux-2.6.10/arch/mips/kernel/Makefile
@@ -34,6 +34,7 @@ obj-$(CONFIG_CPU_R4300)		+= r4k_fpu.o r4
 obj-$(CONFIG_CPU_R4X00)		+= r4k_fpu.o r4k_switch.o
 obj-$(CONFIG_CPU_R5000)		+= r4k_fpu.o r4k_switch.o
 obj-$(CONFIG_CPU_R5432)		+= r4k_fpu.o r4k_switch.o
+obj-$(CONFIG_CPU_R5500)		+= r4k_fpu.o r4k_switch.o
 obj-$(CONFIG_CPU_R8000)		+= r4k_fpu.o r4k_switch.o
 obj-$(CONFIG_CPU_RM7000)	+= r4k_fpu.o r4k_switch.o
 obj-$(CONFIG_CPU_RM9000)	+= r4k_fpu.o r4k_switch.o
Index: linux-2.6.10/arch/mips/pci/Makefile
===================================================================
--- linux-2.6.10.orig/arch/mips/pci/Makefile
+++ linux-2.6.10/arch/mips/pci/Makefile
@@ -52,3 +52,4 @@ obj-$(CONFIG_TOSHIBA_JMR3927)	+= fixup-j
 obj-$(CONFIG_TOSHIBA_RBTX4927)	+= fixup-rbtx4927.o ops-tx4927.o
 obj-$(CONFIG_VICTOR_MPC30X)	+= fixup-mpc30x.o
 obj-$(CONFIG_ZAO_CAPCELLA)	+= fixup-capcella.o
+obj-$(CONFIG_TCUBE)		+= pci-tcube.o ops-tcube.o
Index: linux-2.6.10/drivers/video/smi/smi_hw.c
===================================================================
--- /dev/null
+++ linux-2.6.10/drivers/video/smi/smi_hw.c
@@ -0,0 +1,188 @@
+/*
+ * drivers/video/smi/smi_hw.c
+ *
+ * LynxEM+/EM4+(Silicon Motion Inc.) fb driver for NEC Electronics Corporation VR5701 SolutionGearII
+ *
+ * Author: Sergey Podstavin <spodstavin@ru.mvista.com>
+ *
+ * 2005 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/fb.h>
+#include "smifb.h"
+#include "smi_hw.h"
+#include "smi_params.h"
+
+/*
+ * set mode registers
+ */
+void
+smi_set_moderegs(struct smifb_info *sinfo,
+		 int bpp, int width, int height,
+		 int hDisplaySize,
+		 int hDisplay, int hStart, int hEnd, int hTotal,
+		 int vDisplay, int vStart, int vEnd, int vTotal,
+		 int dotClock, int sync)
+{
+	int i;
+	int tmp_mode = SMI_DEFAULT_MODE;
+	int lineLength;
+	struct smi_mode_regs curMode;
+
+	pr_debug("smi_set_moderegs");
+	pr_debug("bpp = %d, width = %d, height = %d\n", bpp, width, height);
+	pr_debug("hDisplaySize = %d\n", hDisplaySize);
+	pr_debug("hDisplay = %d, hStart = %d, hEnd = %d, hTotal = %d\n",
+		 hDisplay, hStart, hEnd, hTotal);
+	pr_debug("vDisplay = %d, vStart = %d, vEnd = %d, vTotal = %d\n",
+		 vDisplay, vStart, vEnd, vTotal);
+	pr_debug("dotClock = %d\n", dotClock);
+
+	lineLength = width * bpp / 8;
+
+	switch (bpp) {
+#ifdef FBCON_HAS_CFB8
+	case 8:
+		if (hDisplaySize <= 640)
+			tmp_mode = DISPLAY_640x480x8;
+		else if (width <= 800)
+			tmp_mode = DISPLAY_800x600x8;
+		else if (width <= 1024)
+			tmp_mode = DISPLAY_1024x768x8;
+		else if (width <= 1280)
+			tmp_mode = DISPLAY_1280x1024x8;
+		reg_DPR10(sinfo) = (lineLength << 16) | lineLength;	/* RowPitch */
+		reg_DPR1E(sinfo) = 0x0005;
+		reg_DPR3C(sinfo) = (lineLength << 16) | lineLength;	/* Dst & Src Window Width */
+		reg_VPR00(sinfo) = 0x0 << 16;
+		break;
+#endif
+#ifdef FBCON_HAS_CFB16
+	case 16:
+		if (hDisplaySize <= 400)
+			tmp_mode = DISPLAY_LCD_400x232x16;
+		if (hDisplaySize <= 640)
+			tmp_mode = DISPLAY_640x480x16;
+		else if (width <= 800)
+			tmp_mode = DISPLAY_800x600x16;
+		else if (width <= 1024)
+			tmp_mode = DISPLAY_1024x768x16;
+		reg_DPR10(sinfo) = (lineLength / 2 << 16) | lineLength / 2;	/* RowPitch */
+		reg_DPR1E(sinfo) = 0x0015;
+		reg_DPR3C(sinfo) = (lineLength / 2 << 16) | lineLength / 2;	/* Dst & Src Window Width */
+		reg_VPR00(sinfo) = 0x2 << 16;
+		break;
+#endif
+#ifdef FBCON_HAS_CFB24
+	case 24:
+		if (hDisplaySize <= 640)
+			tmp_mode = DISPLAY_640x480x24;
+		else if (width <= 800)
+			tmp_mode = DISPLAY_800x600x24;
+		reg_DPR10(sinfo) = (lineLength / 3 << 16) | lineLength / 3;	/* RowPitch */
+		reg_DPR1E(sinfo) = 0x0035;
+		reg_DPR3C(sinfo) = (lineLength / 3 << 16) | lineLength / 3;	/* Dst & Src Window Width */
+		reg_VPR00(sinfo) = 0x4 << 16;
+		break;
+#endif
+	};
+
+	for (i = 0; i < modeNums; i++) {
+		if (ModeInitParams[i].mode == tmp_mode)
+			break;
+	}
+	if (i == modeNums)
+		tmp_mode = SMI_DEFAULT_MODE;
+
+	memcpy(&curMode, &ModeInitParams[tmp_mode],
+	       sizeof(struct smi_mode_regs));
+
+	/*
+	 * Override some Mode Params
+	 */
+	/* MISC Reg */
+	curMode.reg_MISC = 0x30 | (hDisplay == 640) ? 0x03 : 0x0b;
+	if (sync & FB_SYNC_HOR_HIGH_ACT)
+		curMode.reg_MISC |= 0x40;
+	if (sync & FB_SYNC_VERT_HIGH_ACT)
+		curMode.reg_MISC |= 0x80;
+
+	/* CRTC */
+	curMode.reg_CR00_CR18[0x00] = (u8) (hTotal - 4);
+	curMode.reg_CR00_CR18[0x01] = (u8) hDisplay;
+	curMode.reg_CR00_CR18[0x02] = (u8) hDisplay;
+	curMode.reg_CR00_CR18[0x03] = 0x00;
+	curMode.reg_CR00_CR18[0x04] = (u8) hStart;
+	curMode.reg_CR00_CR18[0x05] = (hEnd & 0x1f);
+	curMode.reg_CR00_CR18[0x06] = (u8) (vTotal & 0xff);
+	curMode.reg_CR00_CR18[0x07] = (u8) (((vStart >> 9) & 0x01) << 7)
+	    | (u8) (((vDisplay >> 9) & 0x01) << 6)
+	    | (u8) (((vTotal >> 9) & 0x01) << 5)
+	    | 1 << 4		/* D (LC) */
+	    | (u8) (((vStart >> 8) & 0x01) << 2)
+	    | (u8) (((vDisplay >> 8) & 0x01) << 1)
+	    | (u8) ((vTotal >> 8) & 0x01);
+
+	curMode.reg_CR00_CR18[0x09] = (u8) (vDisplay >> 9) << 5 | 1 << 6;	/* D (LC bit9) */
+	curMode.reg_CR00_CR18[0x10] = (u8) (vStart & 0xff);
+	curMode.reg_CR00_CR18[0x11] = (u8) (vEnd & 0xf);
+	curMode.reg_CR00_CR18[0x12] = (u8) (vDisplay & 0xff);
+	curMode.reg_CR00_CR18[0x13] = ((width / 8) * ((bpp + 1) / 8)) & 0xFF;
+	curMode.reg_CR00_CR18[0x15] = (u8) (vDisplay & 0xff);
+	curMode.reg_CR00_CR18[0x16] = 0x00;
+	curMode.reg_CR00_CR18[0x14] = (hDisplaySize > 1024) ? 0x00 : 0x40;	/* D *//* Underline Location */
+
+	/* Extended CRTC */
+	curMode.reg_CR30_CR4D[0x30 - 0x30] = (u8) (((vTotal >> 10) & 0x01) << 3)
+	    | (u8) (((vDisplay >> 10) & 0x01) << 1)
+	    | (u8) ((vStart >> 10) & 0x1);	/* D (CRTD) (CVDER) */
+
+	curMode.reg_SR30_SR75[0x32] = 0xff;	/* (Memory Type and Timig Control Reg) */
+
+	for (i = 0; i <= SIZE_SR00_SR04; i++)
+		regSR_write(sinfo->mmio, 0x00 + i, curMode.reg_SR00_SR04[i]);
+	for (i = 0; i <= SIZE_SR10_SR24; i++)
+		regSR_write(sinfo->mmio, 0x10 + i, curMode.reg_SR10_SR24[i]);
+	for (i = 0; i <= SIZE_SR30_SR75; i++) {
+		regSR_write(sinfo->mmio, 0x30 + i, curMode.reg_SR30_SR75[i]);
+	}
+	for (i = 0; i <= SIZE_SR80_SR93; i++)
+		regSR_write(sinfo->mmio, 0x80 + i, curMode.reg_SR80_SR93[i]);
+	for (i = 0; i <= SIZE_SRA0_SRAF; i++)
+		regSR_write(sinfo->mmio, 0xA0 + i, curMode.reg_SRA0_SRAF[i]);
+	for (i = 0; i <= SIZE_GR00_GR08; i++)
+		regGR_write(sinfo->mmio, 0x00 + i, curMode.reg_GR00_GR08[i]);
+	for (i = 0; i <= SIZE_AR00_AR14; i++)
+		regAR_write(sinfo->mmio, 0x00 + i, curMode.reg_AR00_AR14[i]);
+	for (i = 0; i <= SIZE_CR00_CR18; i++)
+		regCR_write(sinfo->mmio, 0x00 + i, curMode.reg_CR00_CR18[i]);
+	for (i = 0; i <= SIZE_CR30_CR4D; i++)
+		regCR_write(sinfo->mmio, 0x30 + i, curMode.reg_CR30_CR4D[i]);
+	for (i = 0; i <= SIZE_CR90_CRA7; i++)
+		regCR_write(sinfo->mmio, 0x90 + i, curMode.reg_CR90_CRA7[i]);
+
+	/* SetMemoryMapRegisters */
+	reg_DPR14(sinfo) = 0xffffffff;	/* FG color */
+	reg_DPR18(sinfo) = 0x00000000;	/* BG color */
+	reg_DPR24(sinfo) = 0xffffffff;	/* Color Mask */
+	reg_DPR28(sinfo) = 0xffff;	/* Masks */
+	reg_DPR2C(sinfo) = 0;
+	reg_DPR30(sinfo) = 0;
+	reg_DPR34(sinfo) = 0xffffffff;
+	reg_DPR38(sinfo) = 0xffffffff;
+	reg_DPR40(sinfo) = 0;
+	reg_DPR44(sinfo) = 0;
+	reg_VPR0C(sinfo) = 0;
+	reg_VPR10(sinfo) = ((lineLength / 8 + 2) << 16) | (lineLength / 8);
+	reg_VPR40(sinfo) = 0;
+	reg_VPR28(sinfo) = 0x00000000;
+	reg_VPR2C(sinfo) = ((hDisplaySize - 1) << 16) | (vDisplay);
+	reg_VPR30(sinfo) = 0x00000000;
+	reg_VPR34(sinfo) = (lineLength << 16) | lineLength;
+}
Index: linux-2.6.10/include/linux/pci_ids.h
===================================================================
--- linux-2.6.10.orig/include/linux/pci_ids.h
+++ linux-2.6.10/include/linux/pci_ids.h
@@ -555,6 +555,7 @@
 #define PCI_DEVICE_ID_MIRO_DC30PLUS	0xd801
 
 #define PCI_VENDOR_ID_NEC		0x1033
+#define PCI_DEVICE_ID_NEC_USB_AND_IDE	0x0000 /* USB 1.1 or IDE Controller*/
 #define PCI_DEVICE_ID_NEC_CBUS_1	0x0001 /* PCI-Cbus Bridge */
 #define PCI_DEVICE_ID_NEC_LOCAL		0x0002 /* Local Bridge */
 #define PCI_DEVICE_ID_NEC_ATM		0x0003 /* ATM LAN Controller */
@@ -1643,6 +1644,11 @@
 #define PCI_DEVICE_ID_SATSAGEM_PCR2101	0x5352
 #define PCI_DEVICE_ID_SATSAGEM_TELSATTURBO 0x5a4b
 
+#define PCI_VENDOR_ID_SMI		0x126f
+#define PCI_DEVICE_ID_SMI_LYNX_EM	0x0710
+#define PCI_DEVICE_ID_SMI_LYNX_EM_PLUS	0x0712
+#define PCI_DEVICE_ID_SMI_LYNX_3DM	0x0720
+
 #define PCI_VENDOR_ID_HUGHES		0x1273
 #define PCI_DEVICE_ID_HUGHES_DIRECPC	0x0002
 
Index: linux-2.6.10/drivers/video/smi/smi_base.c
===================================================================
--- /dev/null
+++ linux-2.6.10/drivers/video/smi/smi_base.c
@@ -0,0 +1,512 @@
+/*
+ * drivers/video/smi/smi_base.c
+ *
+ * LynxEM+/EM4+(Silicon Motion Inc.) fb driver	for NEC Electronics Corporation VR5701 SolutionGearII
+ *
+ * Author: Sergey Podstavin <spodstavin@ru.mvista.com>
+ *
+ * 2005 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/mm.h>
+#include <linux/selection.h>
+#include <linux/tty.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/fb.h>
+#include <linux/init.h>
+#include <linux/pci.h>
+#include <linux/console.h>
+#include "../console/fbcon.h"
+#include "smifb.h"
+#include "smi_hw.h"
+
+/*
+ * Card Identification
+ *
+ */
+static struct pci_device_id smifb_pci_tbl[] __devinitdata = {
+	{PCI_VENDOR_ID_SMI, PCI_DEVICE_ID_SMI_LYNX_EM_PLUS,
+	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},	/* Lynx EM+/EM4+ */
+	{PCI_VENDOR_ID_SMI, PCI_DEVICE_ID_SMI_LYNX_3DM,
+	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},	/* Lynx 3DM/3DM+/3DM4+ */
+	{0,}			/* terminate list */
+};
+
+MODULE_DEVICE_TABLE(pci, smifb_pci_tbl);
+
+/*
+ *
+ * global variables
+ *
+ */
+
+#ifdef CONFIG_DISPLAY_1024x768
+/* 1024x768, 16bpp, 60Hz */
+static struct fb_var_screeninfo smifb_default_var = {
+      xres:1024,
+      yres:768,
+      xres_virtual:1024,
+      yres_virtual:768,
+      xoffset:0,
+      yoffset:0,
+      bits_per_pixel:16,
+      grayscale:0,
+      red:{11, 5, 0},
+      green:{5, 6, 0},
+      blue:{0, 5, 0},
+      transp:{0, 0, 0},
+      nonstd:0,
+      activate:0,
+      height:-1,
+      width:-1,
+      accel_flags:0,
+      pixclock:39721,		/* D */
+      left_margin:138,
+      right_margin:24,
+      upper_margin:24,
+      lower_margin:4,
+      hsync_len:160,
+      vsync_len:6,
+      sync:0,
+      vmode:FB_VMODE_NONINTERLACED
+};
+#else
+/* 640x480, 16bpp, 60Hz */
+static struct fb_var_screeninfo smifb_default_var = {
+      xres:640,
+      yres:480,
+      xres_virtual:640,
+      yres_virtual:480,
+      xoffset:0,
+      yoffset:0,
+      bits_per_pixel:16,
+      grayscale:0,
+      red:{11, 5, 0},
+      green:{5, 6, 0},
+      blue:{0, 5, 0},
+      transp:{0, 0, 0},
+      nonstd:0,
+      activate:0,
+      height:-1,
+      width:-1,
+      accel_flags:0,
+      pixclock:39721,		/* D */
+      left_margin:82,
+      right_margin:16,
+      upper_margin:19,
+      lower_margin:1,
+      hsync_len:152,
+      vsync_len:4,
+      sync:0,
+      vmode:FB_VMODE_NONINTERLACED
+};
+#endif
+
+static char drvrname[] = "NEC video driver for SMI LynxEM+";
+
+/*
+ *
+ * general utility functions
+ *
+ */
+
+static void
+smi_load_video_mode(struct smifb_info *sinfo,
+		    struct fb_var_screeninfo *video_mode)
+{
+	int bpp, width, height;
+	int hDisplaySize, hDisplay, hStart, hEnd, hTotal;
+	int vDisplay, vStart, vEnd, vTotal;
+	int dotClock;
+
+	pr_debug("smi_load_video_mode: video_mode->xres = %d\n",
+		 video_mode->xres);
+	pr_debug("                   :             yres = %d\n",
+		 video_mode->yres);
+	pr_debug("                   :             xres_virtual = %d\n",
+		 video_mode->xres_virtual);
+	pr_debug("                   :             yres_virtual = %d\n",
+		 video_mode->yres_virtual);
+	pr_debug("                   :             xoffset = %d\n",
+		 video_mode->xoffset);
+	pr_debug("                   :             yoffset = %d\n",
+		 video_mode->yoffset);
+	pr_debug("                   :             bits_per_pixel = %d\n",
+		 video_mode->bits_per_pixel);
+
+	/* smifb_blank(1, (struct fb_info*)sinfo); */
+	bpp = video_mode->bits_per_pixel;
+	if (bpp == 16 && video_mode->green.length == 5)
+		bpp = 15;
+
+	/* horizontal params */
+	width = video_mode->xres_virtual;
+	hDisplaySize = video_mode->xres;	/* number of pixels for one horizontal line */
+	hDisplay = (hDisplaySize / 8) - 1;	/* number of character clocks */
+	hStart = (hDisplaySize + video_mode->right_margin) / 8 + 2;	/* h-blank start character clocks */
+	hEnd = (hDisplaySize + video_mode->right_margin + video_mode->hsync_len) / 8 - 1;	/* h-sync end */
+	hTotal = (hDisplaySize + video_mode->right_margin + video_mode->hsync_len + video_mode->left_margin) / 8 - 1;	/* character clock from h-sync to next h-sync */
+
+	/* vertical params */
+	height = video_mode->yres_virtual;
+	vDisplay = video_mode->yres - 1;	/* number of lines */
+	vStart = video_mode->yres + video_mode->lower_margin - 1;	/* v-sync pulse start */
+	vEnd = video_mode->yres + video_mode->lower_margin + video_mode->vsync_len - 1;	/* v-sync end */
+	vTotal = video_mode->yres + video_mode->lower_margin + video_mode->vsync_len + video_mode->upper_margin + 2;	/* number of scanlines (v-blank end) */
+
+	dotClock = 1000000000 / video_mode->pixclock;
+
+	smi_set_moderegs(sinfo, bpp, width, height,
+			 hDisplaySize,
+			 hDisplay, hStart, hEnd, hTotal,
+			 vDisplay, vStart, vEnd, vTotal,
+			 dotClock, video_mode->sync);
+}
+
+/*
+ *
+ * framebuffer operations
+ *
+ */
+static int
+smifb_get_fix(struct fb_fix_screeninfo *fix, int con, struct fb_info *info)
+{
+	struct smifb_info *sinfo = (struct smifb_info *)info;
+
+	pr_debug("smifb_get_fix");
+	fix->smem_start = sinfo->fb_base_phys;
+	fix->smem_len = sinfo->fbsize;
+	fix->mmio_start = sinfo->dpr_base_phys;
+	fix->mmio_len = sinfo->dpport_size;
+
+	fix->xpanstep = 0;	/* FIXME: no xpanstep for now */
+	fix->ypanstep = 1;	/* FIXME: no ypanstep for now */
+	fix->ywrapstep = 0;	/* FIXME: no ywrap for now */
+
+	return 0;
+}
+
+static int vgxfb_setcolreg(unsigned regno, unsigned red, unsigned green,
+			   unsigned blue, unsigned transp, struct fb_info *info)
+{
+	if (regno > 15)
+		return 1;
+
+	((u16 *) (info->pseudo_palette))[regno] =
+	    (red & 0xf800) | (green & 0xfc00 >> 5) | (blue & 0xf800 >> 11);
+	return 0;
+}
+
+/*
+ * Initialization helper functions
+ *
+ */
+/* kernel interface */
+static struct fb_ops smifb_ops = {
+	.owner = THIS_MODULE,
+	.fb_setcolreg = vgxfb_setcolreg,
+	.fb_fillrect = cfb_fillrect,
+	.fb_copyarea = cfb_copyarea,
+	.fb_imageblit = cfb_imageblit,
+	.fb_cursor = soft_cursor,
+};
+
+/*
+ * VGA registers
+ *
+ */
+static void Unlock(struct smifb_info *sinfo)
+{
+	pr_debug("Unlock");
+	regSR_write(sinfo->mmio, 0x33, regSR_read(sinfo->mmio, 0x33) & 0x20);
+}
+
+static void UnlockVGA(struct smifb_info *sinfo)
+{
+	pr_debug("UnlockVGA");
+	regCR_write(sinfo->mmio, 0x11, regCR_read(sinfo->mmio, 0x11) & 0x7f);
+}
+
+static struct fb_fix_screeninfo vgxfb_fix = {
+	.id = "vgxFB",
+	.type = FB_TYPE_PACKED_PIXELS,
+	.visual = FB_VISUAL_TRUECOLOR,
+#ifdef CONFIG_DISPLAY_1024x768
+	.line_length = 1024 * 2,
+#else
+	.line_length = 640 * 2,
+#endif
+	.accel = FB_ACCEL_NONE,
+};
+
+static u32 colreg[17];
+
+/*
+ * PCI bus
+ *
+ */
+static int __devinit
+smifb_probe(struct pci_dev *pd, const struct pci_device_id *ent)
+{
+	int len;
+	int res;
+	u16 cmd;
+	struct smifb_info *sinfo;
+	struct fb_info *info;
+
+	pr_debug("smifb_probe");
+
+	pr_debug("vendor id        %04x\n", pd->vendor);
+	pr_debug("device id        %04x\n", pd->device);
+	pr_debug("sub vendor id    %04x\n", pd->subsystem_vendor);
+	pr_debug("sub device id    %04x\n", pd->subsystem_device);
+
+	pr_debug("base0 start addr %08x\n",
+		 (unsigned int)pci_resource_start(pd, 0));
+	pr_debug("base0 end   addr %08x\n",
+		 (unsigned int)pci_resource_end(pd, 0));
+	pr_debug("base0 region len %08x\n",
+		 (unsigned int)pci_resource_len(pd, 0));
+	pr_debug("base0 flags      %08x\n",
+		 (unsigned int)pci_resource_flags(pd, 0));
+
+	pci_read_config_word(pd, PCI_STATUS, &cmd);
+	pr_debug("PCI status      %04x\n", cmd);
+
+	pci_read_config_word(pd, PCI_COMMAND, &cmd);
+	pr_debug("PCI command      %04x\n", cmd);
+
+	cmd |= PCI_COMMAND_MEMORY | PCI_COMMAND_IO;
+	pci_write_config_word(pd, PCI_COMMAND, cmd);
+
+	pci_read_config_word(pd, PCI_STATUS, &cmd);
+	pr_debug("PCI status      %04x\n", cmd);
+	pci_read_config_word(pd, PCI_COMMAND, &cmd);
+	pr_debug("PCI command      %04x\n", cmd);
+
+	/* allocate memory resources */
+	sinfo = kmalloc(sizeof(struct smifb_info), GFP_KERNEL);
+	if (!sinfo) {
+		goto err_out;
+	}
+	memset(sinfo, 0, sizeof(struct smifb_info));
+
+	/* driver name */
+	sinfo->drvr_name = drvrname;
+
+	sinfo->pd = pd;
+	sinfo->base_phys = pci_resource_start(sinfo->pd, 0);	/* Frame Buffer base address */
+	len = pci_resource_len(sinfo->pd, 0);
+	pr_debug("len = %lX\n", len);
+	if (!request_mem_region(sinfo->base_phys, len, "smifb")) {
+		printk(KERN_ERR "cannot reserve FrameBuffer and MMIO region\n");
+		goto err_out_kfree;
+	}
+
+	if ((res = pci_enable_device(sinfo->pd)) < 0) {
+		printk(KERN_ERR "smifb: failed to enable -- err %d\n", res);
+		goto err_out_free_base;
+	}
+
+	pci_read_config_word(pd, PCI_COMMAND, &cmd);
+	pr_debug(KERN_INFO "PCI command      %04x\n", cmd);
+
+	{
+		unsigned int pseudo_io, pseudo_io_len;
+		unsigned char *pseudo_io_p;
+
+		*(unsigned long *)0xbe000610 = 0x10000012;	/* CHANGE to PCI IO ACCESS */
+		asm("sync");
+		pseudo_io = pci_resource_start(sinfo->pd, 0);
+		pseudo_io_len = pci_resource_len(sinfo->pd, 0);
+		pseudo_io_p = ioremap(pseudo_io, pseudo_io_len);
+
+		VGA_WRITE8(pseudo_io_p, 0x3c3, 0x40);
+		regSR_write(pseudo_io_p, 0x00, 0x00);
+		regSR_write(pseudo_io_p, 0x17, 0xe2);
+		regSR_write(pseudo_io_p, 0x18, 0xff);
+
+		iounmap(pseudo_io_p);
+		*(unsigned long *)0xbe000610 = 0x10000016;	/* PCI MEM ACCESS */
+		asm("sync");
+	}
+	sinfo->base = ioremap(sinfo->base_phys, len);	/* FB+DPD+DPR+VPR+CPR+MMIO */
+	if (!sinfo->base) {
+		goto err_out_free_base;
+	}
+	switch ((sinfo->pd)->device) {
+	case PCI_DEVICE_ID_SMI_LYNX_EM_PLUS:
+		sinfo->dpport = (caddr_t) (sinfo->base + DPPORT_BASE_OFFSET);
+		sinfo->dpr = (caddr_t) (sinfo->base + DP_BASE_OFFSET);
+		sinfo->vpr = (caddr_t) (sinfo->base + VP_BASE_OFFSET);
+		sinfo->cpr = (caddr_t) (sinfo->base + CP_BASE_OFFSET);
+		sinfo->mmio = (caddr_t) (sinfo->base + IO_BASE_OFFSET);
+		sinfo->fb_base = (caddr_t) (sinfo->base + 0);
+		break;
+	case PCI_DEVICE_ID_SMI_LYNX_3DM:
+		sinfo->dpport =
+		    (caddr_t) (sinfo->base + LYNX3DM_DPPORT_BASE_OFFSET);
+		sinfo->dpr = (caddr_t) (sinfo->base + LYNX3DM_DP_BASE_OFFSET);
+		sinfo->vpr = (caddr_t) (sinfo->base + LYNX3DM_VP_BASE_OFFSET);
+		sinfo->cpr = (caddr_t) (sinfo->base + LYNX3DM_CP_BASE_OFFSET);
+		sinfo->mmio = (caddr_t) (sinfo->base + LYNX3DM_IO_BASE_OFFSET);
+		sinfo->fb_base =
+		    (caddr_t) (sinfo->base + LYNX3DM_FB_BASE_OFFSET);
+		break;
+	}
+	regSR_write(sinfo->mmio, 0x18, 0x11);
+
+	pr_debug("sinfo->dpport = 0x%08x\n", (u_int32_t) sinfo->dpport);
+	pr_debug("sinfo->dpr  = 0x%08x, sinfo->vpr   = 0x%08x\n",
+		 (unsigned int)sinfo->dpr, (unsigned int)sinfo->vpr);
+	pr_debug("sinfo->cpr  = 0x%08x, sinfo->mmio  = 0x%08x\n",
+		 (unsigned int)sinfo->cpr, (unsigned int)sinfo->mmio);
+
+	/* Set the chip in color mode and unlock the registers */
+	VGA_WRITE8(sinfo->mmio, 0x3c2, 0x2b);	/* Miscellaneous Output Register ( write 0x3c2, read 0x3cc ) */
+
+	Unlock(sinfo);
+	UnlockVGA(sinfo);
+
+	/* save the current chip status */
+	switch ((sinfo->pd)->device) {
+	case PCI_DEVICE_ID_SMI_LYNX_EM_PLUS:
+		regSR_write(sinfo->mmio, 0x62, 0xff);
+		regSR_write(sinfo->mmio, 0x6a, 0x0c);
+		regSR_write(sinfo->mmio, 0x6b, 0x02);
+
+		*(u32 *) (sinfo->fb_base + 4) = 0xaa551133;
+		pr_debug("       *(u32 *)(sinfo->fb_base +4) = 0x%08x\n",
+			 *(u32 *) (sinfo->fb_base + 4));
+		if (*(u32 *) (sinfo->fb_base + 4) != 0xaa551133) {
+			/* Program the MCLK to 130MHz */
+			regSR_write(sinfo->mmio, 0x6a, 0x10);
+			regSR_write(sinfo->mmio, 0x6b, 0x02);
+			regSR_write(sinfo->mmio, 0x62, 0x3e);
+			sinfo->fbsize = 2 * 1024 * 1024;	/* LynxEM+ */
+			pr_debug
+			    ("ChipID = LynxEM+. Force the MCLK to 85MHz and the memory size to 2MiB\n");
+		} else {
+			sinfo->fbsize = 4 * 1024 * 1024;	/* LynxEM4+ */
+			pr_debug
+			    ("ChipID = LynxEM4+. Force the MCLK to 85MHz and the memory size to 4MiB\n");
+		}
+		sinfo->fb_base_phys = sinfo->base_phys;
+		break;
+	case PCI_DEVICE_ID_SMI_LYNX_3DM:
+		{
+			int tmp;
+			int mem_table[4] = { 8, 16, 0, 4 };
+			tmp = (regSR_read(sinfo->mmio, 0x76) & 0xff);
+			pr_debug("%02x\n", tmp);
+			sinfo->fbsize = mem_table[(tmp >> 6)] * 1024 * 1024;
+
+			regSR_write(sinfo->mmio, 0x62, 0xff);
+			regSR_write(sinfo->mmio, 0x6a, 0x0c);
+			regSR_write(sinfo->mmio, 0x6b, 0x02);
+
+			sinfo->fb_base_phys =
+			    sinfo->base_phys + LYNX3DM_FB_BASE_OFFSET;
+		}
+		break;
+	default:
+		/* this driver supports only LynxEM+/EM4+ */
+		goto err_out_free_base;
+	};
+
+	info = &(sinfo->info);
+	smifb_get_fix(&vgxfb_fix, -1, info);
+
+	info->flags = FBINFO_FLAG_DEFAULT;
+	info->fbops = &smifb_ops;
+	info->var = smifb_default_var;
+	info->fix = vgxfb_fix;
+	info->pseudo_palette = colreg;
+	info->screen_base = sinfo->fb_base;
+
+	smi_load_video_mode(sinfo, &smifb_default_var);
+
+	if (register_framebuffer(&sinfo->info) < 0) {
+		goto err_out_free_base;
+	}
+	pci_set_drvdata(pd, sinfo);
+
+	printk(KERN_INFO "smifb: " "framebuffer (%s)\n", sinfo->drvr_name);
+
+	return 0;
+
+      err_out_free_base:
+	release_mem_region(sinfo->base_phys, len);
+      err_out_kfree:
+	kfree(sinfo);
+      err_out:
+	return -ENODEV;
+}
+
+static void __devexit smifb_remove(struct pci_dev *pd)
+{
+	struct smifb_info *sinfo = pci_get_drvdata(pd);
+	pr_debug("smifb_remove");
+
+	if (!sinfo)
+		return;
+
+	unregister_framebuffer(&sinfo->info);
+
+	/* stop the lynx chip */
+	release_mem_region(sinfo->base_phys, pci_resource_len(sinfo->pd, 0));
+	kfree(sinfo);
+	pci_set_drvdata(pd, NULL);
+}
+
+/*
+ * Initialization
+ *
+ */
+#ifndef MODULE
+int __init smifb_setup(char *options)
+{
+	pr_debug("smifb_setup");
+
+	if (!options || options)
+		return 0;
+	return 0;
+}
+#endif				/* not MODULE */
+
+static struct pci_driver smifb_driver = {
+	.name = "smifb",
+	.id_table = smifb_pci_tbl,
+	.probe = smifb_probe,
+	.remove = __devexit_p(smifb_remove),
+};
+
+/*
+ * Driver initialization
+ */
+int __init smifb_init(void)
+{
+	pr_debug("smifb_init");
+	return pci_module_init(&smifb_driver);
+}
+
+void __exit smifb_exit(void)
+{
+	pci_unregister_driver(&smifb_driver);
+}
+
+module_init(smifb_init);
+module_exit(smifb_exit);
+
+MODULE_AUTHOR("Sergey Podstavin");
+MODULE_DESCRIPTION("Framebuffer driver for NEC Electronics Corporation VR5701 SolutionGearII");
+MODULE_LICENSE("GPL");
Index: linux-2.6.10/drivers/video/smi/smi_hw.h
===================================================================
--- /dev/null
+++ linux-2.6.10/drivers/video/smi/smi_hw.h
@@ -0,0 +1,197 @@
+/*
+ * drivers/video/smi/smi_hw.h
+ *
+ * LynxEM+/EM4+(Silicon Motion Inc.) fb driver	for NEC Electronics Corporation VR5701 SolutionGearII
+ *
+ * Author: Sergey Podstavin <spodstavin@ru.mvista.com>
+ *
+ * 2005 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+#ifndef __SMI_HW_H__
+#define __SMI_HW_H__
+
+#include "smifb.h"
+
+#define DPPORT_BASE_OFFSET		0x400000
+#define DP_BASE_OFFSET			0x408000
+#define VP_BASE_OFFSET			0x40c000
+#define CP_BASE_OFFSET			0x40e000
+#define IO_BASE_OFFSET			0x700000
+
+#define DPPORT_REGION_SIZE		(32*1024)
+#define DPREG_REGION_SIZE		(16*1024)
+#define VPREG_REGION_SIZE		(8*1024)
+#define CPREG_REGION_SIZE		(8*1024)
+#define MMIO_REGION_SIZE		(1*1024*1024)
+
+#define LYNX3DM_DPPORT_BASE_OFFSET		0x100000
+#define LYNX3DM_DP_BASE_OFFSET			0x000000
+#define LYNX3DM_VP_BASE_OFFSET			0x000800
+#define LYNX3DM_CP_BASE_OFFSET			0x001000
+#define LYNX3DM_IO_BASE_OFFSET			0x0c0000
+#define LYNX3DM_FB_BASE_OFFSET			0x200000
+
+#define LYNX3DM_DPPORT_REGION_SIZE		(1024*1024)
+#define LYNX3DM_DPREG_REGION_SIZE		(2*1024)
+#define LYNX3DM_VPREG_REGION_SIZE		(2*1024)
+#define LYNX3DM_CPREG_REGION_SIZE		(2*1024)
+#define LYNX3DM_MMIO_REGION_SIZE		(256*1024)
+
+extern void smi_set_moderegs(struct smifb_info *sinfo,
+			     int bpp, int width, int height,
+			     int hDisplaySize,
+			     int hDisplay, int hStart, int hEnd, int hTotal,
+			     int vDisplay, int vStart, int vEnd, int vTotal,
+			     int dotClock, int sync);
+
+#define MMIO_OUT8(p, r, d)	(((volatile u8 *)(p))[r] = (d))
+#define MMIO_OUT16(p, r, d)	(((volatile u16 *)(p))[(r)>>1] = (d))
+#define MMIO_OUT32(p, r, d)	(((volatile u32 *)(p))[(r)>>2] = (d))
+#define MMIO_IN8(p, r)		(((volatile u8 *)(p))[(r)])
+#define MMIO_IN16(p, r)		(((volatile u16 *)(p))[(r)>>1])
+#define MMIO_IN32(p, r)		(((volatile u32 *)(p))[(r)>>2])
+
+static inline u8 VGA_READ8(u8 * base, uint reg)
+{
+	return MMIO_IN8(base, reg);
+}
+
+static inline void VGA_WRITE8(u8 * base, uint reg, u8 data)
+{
+	MMIO_OUT8(base, reg, data);
+}
+
+static inline u8 VGA_READ8_INDEX(u8 * base, u8 index)
+{
+	VGA_WRITE8(base, 0x3c4, index);
+	return VGA_READ8(base, 0x3c5);
+}
+
+static inline void VGA_WRITE8_INDEX(u8 * base, u8 index, u8 data)
+{
+	VGA_WRITE8(base, 0x3c4, index);
+	VGA_WRITE8(base, 0x3c5, data);
+}
+
+static inline u8 regSR_read(u8 * base, u8 index)
+{
+	VGA_WRITE8(base, 0x3c4, index);
+	return VGA_READ8(base, 0x3c5);
+}
+
+static inline void regSR_write(u8 * base, u8 index, u8 data)
+{
+	VGA_WRITE8(base, 0x3c4, index);
+	VGA_WRITE8(base, 0x3c5, data);
+}
+
+static inline u8 regCR_read(u8 * base, u8 index)
+{
+	VGA_WRITE8(base, 0x3d4, index);
+	return VGA_READ8(base, 0x3d5);
+}
+
+static inline void regCR_write(u8 * base, u8 index, u8 data)
+{
+	VGA_WRITE8(base, 0x3d4, index);
+	VGA_WRITE8(base, 0x3d5, data);
+}
+
+static inline u8 regGR_read(u8 * base, u8 index)
+{
+	VGA_WRITE8(base, 0x3ce, index);
+	return VGA_READ8(base, 0x3cf);
+}
+
+static inline void regGR_write(u8 * base, u8 index, u8 data)
+{
+	VGA_WRITE8(base, 0x3ce, index);
+	VGA_WRITE8(base, 0x3cf, data);
+}
+
+static inline u8 regAR_read(u8 * base, u8 index)
+{
+	(void)VGA_READ8(base, 0x3da);	/* reset flip-flop */
+	VGA_WRITE8(base, 0x3c0, index);
+	return VGA_READ8(base, 0x3c1);
+}
+
+static inline void regAR_write(u8 * base, u8 index, u8 data)
+{
+	(void)VGA_READ8(base, 0x3da);	/* reset flip-flop */
+	VGA_WRITE8(base, 0x3c0, index);
+	VGA_WRITE8(base, 0x3c0, data);
+}
+
+/*
+ * LynxEM+ registers
+ */
+
+/* Drawing Engine Control Registers */
+#define reg_DPR00(x)	*(u16 *)((x)->dpr+0x00)	/* Source Y or K2                                       */
+#define reg_DPR02(x)	*(u16 *)((x)->dpr+0x02)	/* Source X or K1                                       */
+#define reg_DPR04(x)	*(u16 *)((x)->dpr+0x04)	/* Destination Y or Start Y                             */
+#define reg_DPR06(x)	*(u16 *)((x)->dpr+0x06)	/* Destination X or Start X                             */
+#define reg_DPR08(x)	*(u16 *)((x)->dpr+0x08)	/* Dimension Y or Error Term                            */
+#define reg_DPR0A(x)	*(u16 *)((x)->dpr+0x0A)	/* Dimension X or Vector Length                         */
+#define reg_DPR0C(x)	*(u16 *)((x)->dpr+0x0C)	/* ROP and Miscellaneous Control                        */
+#define reg_DPR0E(x)	*(u16 *)((x)->dpr+0x0E)	/* Drawing Engine Commands and Control                  */
+#define reg_DPR10(x)	*(u16 *)((x)->dpr+0x10)	/* Source Row Pitch                                     */
+#define reg_DPR12(x)	*(u16 *)((x)->dpr+0x12)	/* Destination Row Picth                                */
+#define reg_DPR14(x)	*(u32 *)((x)->dpr+0x14)	/* Foreground Colors                                    */
+#define reg_DPR18(x)	*(u32 *)((x)->dpr+0x18)	/* Background Colors                                    */
+#define reg_DPR1C(x)	*(u16 *)((x)->dpr+0x1C)	/* Stretch Source Height Y                              */
+#define reg_DPR1E(x)	*(u16 *)((x)->dpr+0x1E)	/* Drawing Engine DataFormat and Location Format Select */
+#define reg_DPR20(x)	*(u32 *)((x)->dpr+0x20)	/* Color Compare                                        */
+#define reg_DPR24(x)	*(u32 *)((x)->dpr+0x24)	/* Color Compare Mask                                   */
+#define reg_DPR28(x)	*(u16 *)((x)->dpr+0x28)	/* Bit Mask                                             */
+#define reg_DPR2A(x)	*(u16 *)((x)->dpr+0x2A)	/* Byte Mask Enable                                     */
+#define reg_DPR2C(x)	*(u16 *)((x)->dpr+0x2C)	/* Scisors Left and Control                             */
+#define reg_DPR2E(x)	*(u16 *)((x)->dpr+0x2E)	/* Scisors Top                                          */
+#define reg_DPR30(x)	*(u16 *)((x)->dpr+0x30)	/* Scisors Right                                        */
+#define reg_DPR32(x)	*(u16 *)((x)->dpr+0x32)	/* Scisors Bottom                                       */
+#define reg_DPR34(x)	*(u32 *)((x)->dpr+0x34)	/* Mono Pattern Low                                     */
+#define reg_DPR38(x)	*(u32 *)((x)->dpr+0x38)	/* Mono Pattern High                                    */
+#define reg_DPR3C(x)	*(u32 *)((x)->dpr+0x3C)	/* XY Addressing Destination & Source Window Widths     */
+#define reg_DPR40(x)	*(u32 *)((x)->dpr+0x40)	/* Source Base Address                                  */
+#define reg_DPR44(x)	*(u32 *)((x)->dpr+0x44)	/* Destination Base Address                             */
+
+/* Video Processor Control Registers */
+#define reg_VPR00(x)	*(u32 *)((x)->vpr+0x00)	/* Miscellaneous Graphics and Video Control                 */
+#define reg_VPR04(x)	*(u32 *)((x)->vpr+0x04)	/* Color Keys                                               */
+#define reg_VPR08(x)	*(u32 *)((x)->vpr+0x08)	/* Color Key Masks                                          */
+#define reg_VPR0C(x)	*(u32 *)((x)->vpr+0x0C)	/* Data Source Start Address for Extended Graphics Modes    */
+#define reg_VPR10(x)	*(u32 *)((x)->vpr+0x10)	/* Data Source Width and Offset for Extended Graphics Modes */
+#define reg_VPR14(x)	*(u32 *)((x)->vpr+0x14)	/* Video Window I Left and Top Boundaries                   */
+#define reg_VPR18(x)	*(u32 *)((x)->vpr+0x18)	/* Video Window I Right and Bottom Boundaries               */
+#define reg_VPR1C(x)	*(u32 *)((x)->vpr+0x1C)	/* Video Window I Source Start Address                      */
+#define reg_VPR20(x)	*(u32 *)((x)->vpr+0x20)	/* Video Window I Source Width and Offset                   */
+#define reg_VPR24(x)	*(u32 *)((x)->vpr+0x24)	/* Video Window I Stretch Factor                            */
+#define reg_VPR28(x)	*(u32 *)((x)->vpr+0x28)	/* Video Window II Left and Top Boundaries              */
+#define reg_VPR2C(x)	*(u32 *)((x)->vpr+0x2C)	/* Video Window II Right and Bottom Boundaries              */
+#define reg_VPR30(x)	*(u32 *)((x)->vpr+0x30)	/* Video Window II Source Start Address                     */
+#define reg_VPR34(x)	*(u32 *)((x)->vpr+0x34)	/* Video Window II Source Width and Offset                  */
+#define reg_VPR38(x)	*(u32 *)((x)->vpr+0x38)	/* Video Window II Stretch Factor                           */
+#define reg_VPR3C(x)	*(u32 *)((x)->vpr+0x3C)	/* Graphics and Video Controll II                           */
+#define reg_VPR40(x)	*(u32 *)((x)->vpr+0x40)	/* Graphic Scale Factor                                     */
+#define reg_VPR54(x)	*(u32 *)((x)->vpr+0x54)	/* FIFO Priority Control                                    */
+#define reg_VPR58(x)	*(u32 *)((x)->vpr+0x58)	/* FIFO Empty Request level Control                         */
+#define reg_VPR5C(x)	*(u32 *)((x)->vpr+0x5C)	/* YUV to RGB Conversion Constant                           */
+#define reg_VPR60(x)	*(u32 *)((x)->vpr+0x60)	/* Current Scan Line Position                               */
+#define reg_VPR64(x)	*(u32 *)((x)->vpr+0x64)	/* Signature Analyzer Control and Status                    */
+#define reg_VPR68(x)	*(u32 *)((x)->vpr+0x68)	/* Video Window I Stretch Factor                            */
+#define reg_VPR6C(x)	*(u32 *)((x)->vpr+0x6C)	/* Video Window II Stretch Factor                           */
+
+/* Capture Processor Control Registers */
+#define reg_CPR00(x)	*(u32 *)((x)->cpr+0x00)	/* Capture Port Control                        */
+#define reg_CPR04(x)	*(u32 *)((x)->cpr+0x04)	/* Video Source Clipping Control               */
+#define reg_CPR08(x)	*(u32 *)((x)->cpr+0x08)	/* Video Source Capture Size Control           */
+#define reg_CPR0C(x)	*(u32 *)((x)->cpr+0x0C)	/* Capture Port Buffer I Source Start Address  */
+#define reg_CPR10(x)	*(u32 *)((x)->cpr+0x10)	/* Capture Port Buffer II Source Start Address */
+#define reg_CPR14(x)	*(u32 *)((x)->cpr+0x14)	/* Capture Port Source Offset Address          */
+#define reg_CPR18(x)	*(u32 *)((x)->cpr+0x18)	/* Capture FIFO Empty Request level Control    */
+
+#endif				/* __SMI_HW_H__ */
Index: linux-2.6.10/arch/mips/Kconfig
===================================================================
--- linux-2.6.10.orig/arch/mips/Kconfig
+++ linux-2.6.10/arch/mips/Kconfig
@@ -449,6 +449,17 @@ config DDB5477_BUS_FREQUENCY
 	depends on DDB5477
 	default 0
 
+config TCUBE
+	bool "Support for NEC Electronics Corporation VR5701 SolutionGearII"
+	select IRQ_CPU
+	select HW_HAS_PCI
+	select DMA_NONCOHERENT
+	help
+	  This enables support for the VR5500 - based NEC Electronics Corporation 
+	  VR5701 SolutionGearII evaluation board.
+
+
+
 config NEC_OSPREY
 	bool "Support for NEC Osprey board"
 	select DMA_NONCOHERENT
@@ -1204,6 +1215,11 @@ config CPU_R5000
 config CPU_R5432
 	bool "R5432"
 
+config CPU_R5500
+	bool "R5500"
+	help
+	  MIPS Technologies Vr5500 - series processors.
+
 config CPU_R6000
 	bool "R6000"
 	depends on MIPS32 && EXPERIMENTAL
Index: linux-2.6.10/arch/mips/vr5701/tcube/Makefile
===================================================================
--- /dev/null
+++ linux-2.6.10/arch/mips/vr5701/tcube/Makefile
@@ -0,0 +1,7 @@
+#
+# Makefile for the NEC Electronics Corporation VR5701 SolutionGearII specific kernel interface routines
+# under Linux.
+#
+
+obj-y += setup.o irq.o int-handler.o irq_vr5701.o 
+EXTRA_AFLAGS: = $(CFLAGS)
Index: linux-2.6.10/arch/mips/vr5701/common/rtc_rx5c348.c
===================================================================
--- /dev/null
+++ linux-2.6.10/arch/mips/vr5701/common/rtc_rx5c348.c
@@ -0,0 +1,182 @@
+/*
+ * arch/mips/vr5701/common/rtc_rx5c348.c Version 0.02 April 11, 2005
+ *
+ * A Real Time Clock interface for Linux on NEC Electronics Corporation VR5701 SolutionGearII
+ * (RICOH Co., Ltd., Rx5C348B)
+ *
+ * Author: Sergey Podstavin <spodstavin@ru.mvista.com>
+ *
+ * 2005 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/time.h>
+#include <linux/kernel.h>
+#include <linux/bcd.h>
+
+#include <asm/time.h>
+#include <asm/addrspace.h>
+#include <asm/delay.h>
+#include <asm/debug.h>
+#include <asm/tcube.h>
+
+#undef  DEBUG
+#undef RTC_DELAY
+
+void static rtc_set_ce(u32 val)
+{
+	pr_debug("rtc_set_ce(%d)\n", val);
+	reg_set32(GIU_PIO0, GPIO_4_CE, val ? SET_32_BIT : 0);
+#ifdef RTC_DELAY
+	__delay(100000);
+#endif
+}
+
+void static rtc_write_burst(int adr, unsigned char *data, int dataLen)
+{
+	int i;
+	for (i = 0; i < dataLen; i++)
+		pr_debug(" rtc_write_burst : data=%08x\n", data[i]);
+	pr_debug(" rtc_write_burst : adr=0x%02x\n", adr);
+	csi1_reset();
+	while (io_in32(CSI1_MODE) & CSIn_MODE_CSOT) ;
+	reg_set32(CSI1_MODE, CSIn_MODE_AUTO, SET_32_BIT);
+	reg_set32(CSI1_MODE, CSIn_MODE_TRMD, SET_32_BIT);
+	io_out32(CSI1_INT, CSIn_INT_CSIEND);
+	rtc_set_ce(1);
+
+	pr_debug(" rtc_write_burst : CSI1_MODE=%08x\n", io_in32(CSI1_MODE));
+	pr_debug(" rtc_write_burst : CSI1_CNT=%08x\n", io_in32(CSI1_CNT));
+	io_out32(CSI1_SOTBF, ((adr << 4) | 0x00));
+
+	for (i = 0; i < dataLen; i++) {
+		io_out32(CSI1_SOTB, data[i]);
+		while (!(io_in32(CSI1_INT) & CSIn_INT_CSIEND)) ;
+		io_out32(CSI1_INT, CSIn_INT_CSIEND);
+	}
+	while (io_in32(CSI1_MODE) & CSIn_MODE_CSOT) ;
+	rtc_set_ce(0);
+}
+
+void static rtc_read_burst(int adr, unsigned char *data, int dataLen)
+{
+	int i;
+	pr_debug(" rtc_read_burst : adr=0x%02x\n", adr);
+	while (io_in32(CSI1_MODE) & CSIn_MODE_CSOT) ;
+	reg_set32(CSI1_MODE, CSIn_MODE_AUTO, CLR_32_BIT);
+	reg_set32(CSI1_MODE, CSIn_MODE_TRMD, SET_32_BIT);
+	io_out32(CSI1_INT, CSIn_INT_CSIEND);
+	rtc_set_ce(1);
+
+	pr_debug(" rtc_read_burst : CSI1_MODE=%08x\n", io_in32(CSI1_MODE));
+	pr_debug(" rtc_read_burst : CSI1_CNT=%08x\n", io_in32(CSI1_CNT));
+	io_out32(CSI1_SOTB, (((adr & 0xf) << 4) | 0x04));
+	while (!(io_in32(CSI1_INT) & CSIn_INT_CSIEND)) ;
+
+	while (io_in32(CSI1_MODE) & CSIn_MODE_CSOT) ;
+	reg_set32(CSI1_MODE, CSIn_MODE_TRMD, CLR_32_BIT);
+	io_out32(CSI1_INT, CSIn_INT_CSIEND);
+
+	udelay(50);
+	pr_debug(" rtc_read_burst : CSI1_MODE=%08x\n", io_in32(CSI1_MODE));
+	pr_debug(" rtc_read_burst : CSI1_CNT=%08x\n", io_in32(CSI1_CNT));
+	io_in32(CSI1_SIRB);	/* dummy read */
+
+	for (i = 0; i < dataLen; i++) {
+		while (!(io_in32(CSI1_INT) & CSIn_INT_CSIEND)) ;
+		io_out32(CSI1_INT, CSIn_INT_CSIEND);
+		data[i] = io_in32(CSI1_SIRB);
+	}
+	while (io_in32(CSI1_MODE) & CSIn_MODE_CSOT) ;
+	rtc_set_ce(0);
+	for (i = 0; i < dataLen; i++)
+		pr_debug(" rtc_read_burst : data=%08x\n", data[i]);
+}
+
+static unsigned long rtc_ricoh_rx5c348_get_time(void)
+{
+	u8 date[7];
+	unsigned int year, month, day, hour, minute, second;
+
+	rtc_read_burst(0, date, sizeof(date));
+
+	year = BCD2BIN(date[6]) + (date[5] & 0x80 ? 2000 : 1900);
+	month = BCD2BIN(date[5] & 0x1f);
+	day = BCD2BIN(date[4]);
+	hour = BCD2BIN(date[2]);
+	minute = BCD2BIN(date[1]);
+	second = BCD2BIN(date[0]);
+
+	pr_debug(KERN_INFO
+		 "rtc_ricoh_rx5c348_get_time: %d/%02d/%02d %02d:%02d:%02d\n",
+		 year, month, day, hour, minute, second);
+	return mktime(year, month, day, hour, minute, second);
+}
+
+static int rtc_ricoh_rx5c348_set_time(unsigned long t)
+{
+	u8 date[7];
+	struct rtc_time tm;
+
+	to_tm(t, &tm);
+	date[0] = BIN2BCD(tm.tm_sec);
+	date[1] = BIN2BCD(tm.tm_min);
+	date[2] = BIN2BCD(tm.tm_hour);
+	date[4] = BIN2BCD(tm.tm_mday);
+	date[5] = BIN2BCD(tm.tm_mon + 1) + (tm.tm_year > 1999 ? 0x80 : 0);
+	date[6] =
+	    BIN2BCD(tm.tm_year > 1999 ? tm.tm_year - 2000 : tm.tm_year - 1900);
+
+	rtc_write_burst(0, date, 3);
+	rtc_write_burst(4, date + 4, 3);
+
+	pr_debug(KERN_INFO
+		 "rtc_ricoh_rx5c348_set_time:t=%ld %d/%02d/%02d %02d:%02d:%02d\n",
+		 t, tm.tm_year, tm.tm_mon + 1, tm.tm_mday, tm.tm_hour,
+		 tm.tm_min, tm.tm_sec);
+	return 0;
+}
+
+static int __devinit rtc_ricoh_rx5c348_init(void)
+{
+	unsigned char data;
+	/* CSI1 reset  */
+	io_set16(PIB_RESET, 0x40, 0xffff);
+	__delay(10000);
+	io_set16(PIB_RESET, 0x40, 0x0000);
+
+	/* set GPIO3 , GPIO4 */
+	reg_set32(GIU_FUNCSEL0, (GPIO_4_CE | GPIO_3_INTR), SET_32_BIT);
+	/* clear GPIO25 , GPIO26 , GPIO27 */
+	reg_set32(GIU_FUNCSEL0, GPIO_CSI1_PIN, CLR_32_BIT);
+	/* make GPIO4 output */
+	reg_set32(GIU_DIR0, GPIO_4_CE, SET_32_BIT);
+	/* make GPIO3 input  */
+	reg_set32(GIU_DIR0, GPIO_3_INTR, CLR_32_BIT);
+
+	csi1_reset();
+
+	rtc_read_burst(0x0e, &data, 1);
+	if ((data & 0x20) == 0) {	/* 24 hour */
+		data |= 0x20;
+		rtc_write_burst(0x0e, &data, 1);
+#ifdef RTC_DELAY
+		__delay(10000);
+#endif
+	}
+
+	/* set the function pointers */
+	rtc_get_time = rtc_ricoh_rx5c348_get_time;
+	rtc_set_time = rtc_ricoh_rx5c348_set_time;
+	return 0;
+}
+
+module_init(rtc_ricoh_rx5c348_init);
+
+MODULE_AUTHOR("Sergey Podstavin");
+MODULE_DESCRIPTION("Real Time Clock interface for Linux on NEC Electronics Corporation VR5701 SolutionGearII");
+MODULE_LICENSE("GPL");
Index: linux-2.6.10/drivers/pci/pci.ids
===================================================================
--- linux-2.6.10.orig/drivers/pci/pci.ids
+++ linux-2.6.10/drivers/pci/pci.ids
@@ -1451,7 +1451,7 @@
 	6057  MiroVideo DC10/DC30+
 1032  Compaq
 1033  NEC Corporation
-	0000  Vr4181A USB Host or Function Control Unit
+	0000  Vr4181A USB Host or IDE Controller
 	0001  PCI to 486-like bus Bridge
 	0002  PCI to VL98 Bridge
 	0003  ATM Controller
@@ -1491,7 +1491,7 @@
 		1033 8014  RCV56ACF 56k Voice Modem
 	009b  Vrc5476
 	00a5  VRC4173
-	00a6  VRC5477 AC97
+	00a6  VRC5477 or VR5701 AC97 Controller
 	00cd  IEEE 1394 [OrangeLink] Host Controller
 		12ee 8011  Root hub
 	00ce  IEEE 1394 Host Controller
Index: linux-2.6.10/drivers/video/smi/Makefile
===================================================================
--- /dev/null
+++ linux-2.6.10/drivers/video/smi/Makefile
@@ -0,0 +1,9 @@
+#
+# Makefile for LynxEM+/EM4+(Silicon Motion Inc.) fb driver for NEC Electronics Corporation VR5701 SolutionGearII
+# under Linux.
+#
+
+obj-$(CONFIG_FB_SM)	+= smfb.o
+
+smfb-objs	:= smi_base.o smi_hw.o 
+
Index: linux-2.6.10/arch/mips/vr5701/tcube/setup.c
===================================================================
--- /dev/null
+++ linux-2.6.10/arch/mips/vr5701/tcube/setup.c
@@ -0,0 +1,188 @@
+/*
+ * arch/mips/vr5701/tcube/setup.c
+ *
+ * Setup file for NEC Electronics Corporation VR5701 SolutionGearII
+ *
+ * Author: Sergey Podstavin <spodstavin@ru.mvista.com>
+ *
+ * 2005 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/kdev_t.h>
+#include <linux/types.h>
+#include <linux/console.h>
+#include <linux/sched.h>
+#include <linux/pci.h>
+#include <linux/fs.h>		/* for ROOT_DEV */
+#include <linux/ioport.h>
+#include <linux/param.h>	/* for HZ */
+#include <asm/bootinfo.h>
+#include <asm/addrspace.h>
+#include <asm/time.h>
+#include <asm/bcache.h>
+#include <asm/irq.h>
+#include <asm/reboot.h>
+#include <asm/gdb-stub.h>
+#include <asm/debug.h>
+#include <asm/tcube.h>
+
+static void tcube_machine_restart(char *command)
+{
+	static void (*back_to_prom) (void) = (void (*)(void))0xbfc00000;
+	back_to_prom();
+}
+
+static void tcube_machine_halt(void)
+{
+	printk(KERN_CRIT "NEC Electronics Corporation VR5701 SolutionGearII halted.\n");
+	while (1) ;
+}
+
+static void tcube_machine_power_off(void)
+{
+	printk(KERN_CRIT "NEC Electronics Corporation VR5701 SolutionGearII halted. Please turn off the power.\n");
+	while (1) ;
+}
+
+static void __init tcube_time_init(void)
+{
+	mips_hpt_frequency = CPU_COUNTER_FREQUENCY;
+}
+
+static void __init tcube_timer_setup(struct irqaction *irq)
+{
+	unsigned int count;
+	irq->flags |= SA_NODELAY;
+
+	/* we are using the cpu counter for timer interrupts */
+	setup_irq(7, irq);
+
+	/* to generate the first timer interrupt */
+	count = read_c0_count();
+	write_c0_compare(count + 10000);
+}
+
+#if defined(CONFIG_BLK_DEV_INITRD)
+extern unsigned long __rd_start, __rd_end, initrd_start, initrd_end;
+#endif
+
+static void chk_init_5701_reg(unsigned long addr, unsigned long data)
+{
+	unsigned long a = ddb_in32(addr);
+
+	if (a != data) {
+		printk(KERN_INFO
+		       "Unexpected 5701 reg : addr = %08lX, expected = %08lX, read = %08lX\n",
+		       addr + VR5701_IO_BASE, data, a);
+	}
+}
+
+static void __init tcube_board_init(void)
+{
+	chk_init_5701_reg(0, 0x1e00008f);
+	chk_init_5701_reg(PADR_SDRAM01, 0x000000a8);
+	chk_init_5701_reg(PADR_LOCALCS0, 0x1f00004c);
+	chk_init_5701_reg(LOCAL_CST0, 0x00088622);
+	chk_init_5701_reg(LOCAL_CFG, 0x000f0000);
+
+	/* setup PCI windows - window0 for MEM/config, window1 for IO */
+	ddb_set_pdar(PADR_PCIW0, 0x10000000, 0x08000000, 32, 0, 1);
+	ddb_set_pdar(PADR_PCIW1, 0x18000000, 0x00800000, 32, 0, 1);
+	ddb_set_pdar(PADR_IOPCIW0, 0x18800000, 0x00800000, 32, 0, 1);
+	ddb_set_pdar(PADR_IOPCIW1, 0x19000000, 0x00800000, 32, 0, 1);
+	/* ------------ reset PCI bus and BARs ----------------- */
+	ddb_pci_reset_bus();
+	/* Ext. PCI memory space */
+	ddb_out32(PCI_BAR_MEM01, 0x00000008);
+	ddb_out8(PCI_MLTIM, 0x40);
+
+	ddb_out32(PCI_BAR_LCS0, 0xffffffff);
+	ddb_out32(PCI_BAR_LCS1, 0xffffffff);
+	ddb_out32(PCI_BAR_LCS2, 0xffffffff);
+	ddb_out32(PCI_BAR_LCS3, 0xffffffff);
+	/* Int. PCI memory space */
+	ddb_out8(IPCI_MLTIM, 0x40);
+
+	ddb_out32(IPCI_BAR_LCS0, 0xffffffff);
+	ddb_out32(IPCI_BAR_LCS1, 0xffffffff);
+	ddb_out32(IPCI_BAR_LCS2, 0xffffffff);
+	ddb_out32(IPCI_BAR_LCS3, 0xffffffff);
+	ddb_out32(IPCI_BAR_IREG, 0xffffffff);
+
+	/*
+	 * We use pci master register 0  for memory space / config space
+	 * And we use register 1 for IO space.
+	 * Note that for memory space, we bump up the pci base address
+	 * so that we have 1:1 mapping between PCI memory and cpu physical.
+	 * For PCI IO space, it starts from 0 in PCI IO space but with
+	 * IO_BASE in CPU physical address space.
+	 */
+	ddb_set_pmr(EPCI_INIT0, DDB_PCICMD_MEM, 0x10000000, DDB_PCI_ACCESS_32);
+	ddb_set_pmr(EPCI_INIT1, DDB_PCICMD_IO, 0x00001000, DDB_PCI_ACCESS_32);
+	ddb_set_pmr(IPCI_INIT0, DDB_PCICMD_MEM, 0x18800000, DDB_PCI_ACCESS_32);
+	ddb_set_pmr(IPCI_INIT1, DDB_PCICMD_IO, 0x01000000, DDB_PCI_ACCESS_32);
+
+	/* PCI cross window should be set properly */
+	ddb_set_pdar(PCI_BAR_IPCIW0, 0x18800000, 0x00800000, 32, 0, 1);
+	ddb_set_pdar(PCI_BAR_IPCIW1, 0x19000000, 0x00800000, 32, 0, 1);
+	ddb_set_pdar(IPCI_BAR_EPCIW0, 0x10000000, 0x08000000, 32, 0, 1);
+	ddb_set_pdar(IPCI_BAR_EPCIW1, 0x18000000, 0x00800000, 32, 0, 1);
+
+	/* setup GPIO */
+	ddb_out32(GIU_DIR0, 0xf7ebffdf);
+	ddb_out32(GIU_DIR1, 0x000007fa);
+	ddb_out32(GIU_FUNCSEL0, 0xf1c1ffff);
+	ddb_out32(GIU_FUNCSEL1, 0x000007f0);
+	chk_init_5701_reg(GIU_DIR0, 0xf7ebffdf);
+	chk_init_5701_reg(GIU_DIR1, 0x000007fa);
+	chk_init_5701_reg(GIU_FUNCSEL0, 0xf1c1ffff);
+	chk_init_5701_reg(GIU_FUNCSEL1, 0x000007f0);
+
+	/* enable USB input buffers */
+	ddb_out32(PIB_MISC, (ddb_in32(PIB_MISC) | 0x00000031));
+}
+
+int __init shima_tcube_setup(void)
+{
+	set_io_port_base(0xB8000000);
+
+	board_time_init = tcube_time_init;
+	board_timer_setup = tcube_timer_setup;
+
+	_machine_restart = tcube_machine_restart;
+	_machine_halt = tcube_machine_halt;
+	_machine_power_off = tcube_machine_power_off;
+
+	/* setup resource limits */
+	ioport_resource.end = 0x02000000;
+	iomem_resource.end = 0xffffffff;
+
+	/* Reboot on panic */
+	panic_timeout = 30;
+
+#ifdef CONFIG_FB
+	conswitchp = &dummy_con;
+#endif
+
+	tcube_board_init();
+
+#if defined(CONFIG_BLK_DEV_INITRD)
+	initrd_start = (unsigned long)&__rd_start;
+	initrd_end = (unsigned long)&__rd_end;
+#endif
+	register_pci_controller(&VR5701_ext_controller);
+	register_pci_controller(&VR5701_io_controller);
+	return 0;
+}
+
+void __init bus_error_init(void)
+{
+	/* do nothing */
+}
+
+early_initcall(shima_tcube_setup);
Index: linux-2.6.10/drivers/ide/Kconfig
===================================================================
--- linux-2.6.10.orig/drivers/ide/Kconfig
+++ linux-2.6.10/drivers/ide/Kconfig
@@ -836,6 +836,13 @@ config BLK_DEV_GAYLE
 	  Note that you also have to enable Zorro bus support if you want to
 	  use Gayle IDE interfaces on the Zorro expansion bus.
 
+config BLK_DEV_NEC_VR5701_SG2
+	tristate "NEC Electronics Corporation VR5701 SolutionGearII IDE interface support"
+	depends on TCUBE
+	help
+	  This is the IDE driver for the NEC Electronics Corporation VR5701 
+	  SolutionGearII IDE interface. 
+
 config BLK_DEV_IDEDOUBLER
 	bool "Amiga IDE Doubler support (EXPERIMENTAL)"
 	depends on BLK_DEV_GAYLE && EXPERIMENTAL
Index: linux-2.6.10/arch/mips/vr5701/tcube/irq.c
===================================================================
--- /dev/null
+++ linux-2.6.10/arch/mips/vr5701/tcube/irq.c
@@ -0,0 +1,146 @@
+/*
+ * arch/mips/vr5701/tcube/irq.c
+ *
+ * The irq setup and misc routines for NEC Electronics Corporation VR5701 SolutionGearII
+ *
+ * Author: Sergey Podstavin <spodstavin@ru.mvista.com>
+ *
+ * 2005 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/types.h>
+#include <linux/ptrace.h>
+#include <asm/system.h>
+#include <asm/mipsregs.h>
+#include <asm/debug.h>
+#include <asm/tcube.h>
+/*
+ * IRQ mapping
+ *
+ *  0-7: 8 CPU interrupts
+ *	0 -	software interrupt 0
+ *	1 -	software interrupt 1
+ *	2 -	most Vrc5477 interrupts are routed to this pin
+ *	3 -	(optional) some other interrupts routed to this pin for debugg
+ *	4 -	not used
+ *	5 -	not used
+ *	6 -	not used
+ *	7 -	cpu timer (used by default)
+ *
+ */
+
+void tcube_irq_setup(void)
+{
+	pr_debug("NEC Electronics Corporation VR5701 SolutionGearII irq setup invoked.\n");
+
+	/* by default, we disable all interrupts and route all vr5701
+	 * interrupts to pin 0 (irq 2) */
+	ddb_out32(INT_ROUTE0, 0);
+	ddb_out32(INT_ROUTE1, 0);
+	ddb_out32(INT_ROUTE2, 0);
+	ddb_out32(INT_ROUTE3, 0);
+	ddb_out32(INT_MASK, 0);
+	ddb_out32(INT_CLR, ~0x0);
+
+	clear_c0_status(0xff00);
+	set_c0_status(0x0400);
+
+	ll_vr5701_irq_route(24, 1);
+	ll_vr5701_irq_enable(24);
+	ll_vr5701_irq_route(25, 1);
+	ll_vr5701_irq_enable(25);
+	ll_vr5701_irq_route(28, 1);
+	ll_vr5701_irq_enable(28);
+	ll_vr5701_irq_route(29, 1);
+	ll_vr5701_irq_enable(29);
+	ll_vr5701_irq_route(30, 1);
+	ll_vr5701_irq_enable(30);
+	ll_vr5701_irq_route(31, 1);
+	ll_vr5701_irq_enable(31);
+	set_c0_status(0x0800);
+	set_except_vector(0, tcube_handle_int);
+	/* init all controllers */
+	mips_cpu_irq_init(0);
+	vr5701_irq_init(8);
+}
+
+/*
+ * the first level int-handler will jump here if it is a vr7701 irq
+ */
+
+asmlinkage void tcube_irq_dispatch(struct pt_regs *regs)
+{
+	u32 intStatus;
+	u32 bitmask;
+	u32 i;
+	u32 intPCIStatus;
+	if (ddb_in32(INT1_STAT) != 0) {
+		printk(KERN_CRIT "NMI  = %x\n", ddb_in32(NMI_STAT));
+		printk(KERN_CRIT "INT0 = %x\n", ddb_in32(INT0_STAT));
+		printk(KERN_CRIT "INT1 = %x\n", ddb_in32(INT1_STAT));
+		printk(KERN_CRIT "INT2 = %x\n", ddb_in32(INT2_STAT));
+		printk(KERN_CRIT "INT3 = %x\n", ddb_in32(INT3_STAT));
+		printk(KERN_CRIT "INT4 = %x\n", ddb_in32(INT4_STAT));
+		printk(KERN_CRIT "EPCI_ERR = %x\n", ddb_in32(EPCI_ERR));
+		printk(KERN_CRIT "IPCI_ERR = %x\n", ddb_in32(IPCI_ERR));
+
+		panic("error interrupt has happened.");
+	}
+
+	intStatus = ddb_in32(INT0_STAT);
+
+	if (intStatus & 1 << 6)
+		goto IRQ_EPCI;
+
+	if (intStatus & 1 << 7)
+		goto IRQ_IPCI;
+
+      IRQ_OTHER:
+	for (i = 0, bitmask = 1; i <= NUM_5701_IRQS; bitmask <<= 1, i++) {
+		/* do we need to "and" with the int mask? */
+		if (intStatus & bitmask) {
+			do_IRQ(8 + i, regs);
+		}
+	}
+	return;
+
+      IRQ_EPCI:
+	intStatus &= ~(1 << 6);	/* unset Status flag */
+	intPCIStatus = ddb_in32(EPCI_INTS);
+	for (i = 0, bitmask = 1; i < NUM_5701_EPCI_IRQS; bitmask <<= 1, i++) {
+		if (intPCIStatus & bitmask) {
+			do_IRQ(8 + NUM_5701_IRQS + i, regs);
+		}
+	}
+	if (!intStatus)
+		return;
+
+      IRQ_IPCI:
+	intStatus &= ~(1 << 7);
+	intPCIStatus = ddb_in32(IPCI_INTS);
+	if (!intPCIStatus)
+		goto IRQ_OTHER;
+
+	for (i = 0, bitmask = 1; i < NUM_5701_IPCI_IRQS; bitmask <<= 1, i++) {
+		if (intPCIStatus & bitmask) {
+			do_IRQ(8 + NUM_5701_IRQS + NUM_5701_EPCI_IRQS + i,
+			       regs);
+		}
+	}
+
+	if (!intStatus)
+		return;
+
+	goto IRQ_OTHER;
+}
+
+void __init arch_init_irq(void)
+{
+	/* invoke board-specific irq setup */
+	tcube_irq_setup();
+}
Index: linux-2.6.10/arch/mips/pci/ops-tcube.c
===================================================================
--- /dev/null
+++ linux-2.6.10/arch/mips/pci/ops-tcube.c
@@ -0,0 +1,267 @@
+/*
+ * arch/mips/pci/ops-tcube.c
+ *
+ * A config access for PCI controllers on NEC Electronics Corporation VR5701 SolutionGearII 
+ *
+ * Author: Sergey Podstavin <spodstavin@ru.mvista.com>
+ *
+ * 2005 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#include <linux/pci.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <asm/addrspace.h>
+#include <asm/debug.h>
+#include <asm/tcube.h>
+
+/*
+ * config_swap structure records what set of pdar/pmr are used
+ * to access pci config space.  It also provides a place hold the
+ * original values for future restoring.
+ */
+struct pci_config_swap {
+	u32 pdar;
+	u32 pmr;
+	u32 config_base;
+	u32 config_size;
+	u32 pdar_backup;
+	u32 pmr_backup;
+};
+
+/*
+ * On VR5701-SG2, we have two sets of swap registers, for ext PCI and IOPCI.
+ */
+struct pci_config_swap ext_pci_swap = {
+	PADR_EPCIW0,
+	EPCI_INIT0,
+	0x10000000,
+	0x08000000
+};
+struct pci_config_swap io_pci_swap = {
+	PADR_IOPCIW0,
+	IPCI_INIT0,
+	0x18800000,
+	0x00800000
+};
+
+/*
+ * access config space
+ */
+static inline u32 ddb_access_config_base(struct pci_config_swap *swap, u32 bus,	/* 0 means top level bus */
+					 u32 slot_num)
+{
+	u32 pci_addr = 0;
+	u32 pciinit_offset = 0;
+	u32 virt_addr;
+	u32 option;
+
+	/* minimum pdar (window) size is 2MB */
+	db_assert(swap->config_size >= (2 << 20));
+	db_assert(slot_num < (1 << 5));
+	db_assert(bus < (1 << 8));
+
+	/* backup registers */
+	swap->pdar_backup = ddb_in32(swap->pdar);
+	swap->pmr_backup = ddb_in32(swap->pmr);
+
+	/* set the pdar (pci window) register */
+	ddb_set_pdar(swap->pdar, swap->config_base, swap->config_size, 32,	/* 32 bit wide */
+		     0,		/* not on local memory bus */
+		     0);	/* not visible from PCI bus (N/A) */
+
+	/*
+	 * calcuate the absolute pci config addr;
+	 * according to the spec, we start scanning from adr:11 (0x800)
+	 */
+	if (bus == 0) {
+		/* type 0 config */
+		pci_addr = 0x800 << slot_num;
+	} else {
+		/* type 1 config */
+		pci_addr = (bus << 16) | (slot_num << 11);
+	}
+
+	/*
+	 * if pci_addr is less than pci config window size,  we set
+	 * pciinit_offset to 0 and adjust the virt_address.
+	 * Otherwise we will try to adjust pciinit_offset.
+	 */
+	if (pci_addr < swap->config_size) {
+		virt_addr = KSEG1ADDR(swap->config_base + pci_addr);
+		pciinit_offset = 0;
+	} else {
+		db_assert((pci_addr & (swap->config_size - 1)) == 0);
+		virt_addr = KSEG1ADDR(swap->config_base);
+		pciinit_offset = pci_addr;
+	}
+
+	/* set the pmr register */
+	option = DDB_PCI_ACCESS_32;
+	if (bus != 0)
+		option |= DDB_PCI_CFGTYPE1;
+
+	ddb_out32(swap->pmr,
+		  (DDB_PCICMD_CFG << 1) | (pciinit_offset & 0xffe00000) |
+		  option);
+	ddb_out32(swap->pmr + 4, 0);
+
+	return virt_addr;
+}
+
+static inline void ddb_close_config_base(struct pci_config_swap *swap)
+{
+	ddb_out32(swap->pdar, swap->pdar_backup);
+	ddb_out32(swap->pmr, swap->pmr_backup);
+}
+
+static int read_config_dword(struct pci_config_swap *swap,
+			     struct pci_bus *bus, u32 devfn, u32 where,
+			     u32 * val)
+{
+	u32 bus_num, slot_num, func_num;
+	u32 base;
+
+	db_assert((where & 3) == 0);
+	db_assert(where < (1 << 8));
+
+	/* check if the bus is top-level */
+	if (bus->parent != NULL) {
+		bus_num = bus->number;
+		db_assert(bus_num != 0);
+	} else {
+		bus_num = 0;
+	}
+	slot_num = PCI_SLOT(devfn);
+	func_num = PCI_FUNC(devfn);
+	base = ddb_access_config_base(swap, bus_num, slot_num);
+	*val = *(volatile u32 *)(base + (func_num << 8) + where);
+	ddb_close_config_base(swap);
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int read_config_word(struct pci_config_swap *swap,
+			    struct pci_bus *bus, u32 devfn, u32 where,
+			    u16 * val)
+{
+	int status;
+	u32 result;
+
+	db_assert((where & 1) == 0);
+
+	status = read_config_dword(swap, bus, devfn, where & ~3, &result);
+	if (where & 2)
+		result >>= 16;
+	*val = result & 0xffff;
+	return status;
+}
+
+static int read_config_byte(struct pci_config_swap *swap,
+			    struct pci_bus *bus, u32 devfn, u32 where, u8 * val)
+{
+	int status;
+	u32 result;
+
+	status = read_config_dword(swap, bus, devfn, where & ~3, &result);
+	if (where & 1)
+		result >>= 8;
+	if (where & 2)
+		result >>= 16;
+	*val = result & 0xff;
+
+	return status;
+}
+
+static int write_config_dword(struct pci_config_swap *swap,
+			      struct pci_bus *bus, u32 devfn, u32 where,
+			      u32 val)
+{
+	u32 bus_num, slot_num, func_num;
+	u32 base;
+
+	db_assert((where & 3) == 0);
+	db_assert(where < (1 << 8));
+
+	/* check if the bus is top-level */
+	if (bus->parent != NULL) {
+		bus_num = bus->number;
+		db_assert(bus_num != 0);
+	} else {
+		bus_num = 0;
+	}
+
+	slot_num = PCI_SLOT(devfn);
+	func_num = PCI_FUNC(devfn);
+	base = ddb_access_config_base(swap, bus_num, slot_num);
+	*(volatile u32 *)(base + (func_num << 8) + where) = val;
+	ddb_close_config_base(swap);
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int write_config_word(struct pci_config_swap *swap,
+			     struct pci_bus *bus, u32 devfn, u32 where, u16 val)
+{
+	int status, shift = 0;
+	u32 result;
+
+	db_assert((where & 1) == 0);
+
+	status = read_config_dword(swap, bus, devfn, where & ~3, &result);
+	if (status != PCIBIOS_SUCCESSFUL)
+		return status;
+
+	if (where & 2)
+		shift += 16;
+	result &= ~(0xffff << shift);
+	result |= val << shift;
+	return write_config_dword(swap, bus, devfn, where & ~3, result);
+}
+
+static int write_config_byte(struct pci_config_swap *swap,
+			     struct pci_bus *bus, u32 devfn, u32 where, u8 val)
+{
+	int status, shift = 0;
+	u32 result;
+
+	status = read_config_dword(swap, bus, devfn, where & ~3, &result);
+	if (status != PCIBIOS_SUCCESSFUL)
+		return status;
+
+	if (where & 2)
+		shift += 16;
+	if (where & 1)
+		shift += 8;
+	result &= ~(0xff << shift);
+	result |= val << shift;
+	return write_config_dword(swap, bus, devfn, where & ~3, result);
+}
+
+#define        MAKE_PCI_OPS(prefix, rw, pciswap, star) \
+static int prefix##_##rw##_config(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 star val) \
+{ \
+	if (size == 1) \
+     		return rw##_config_byte(pciswap, bus, devfn, where, (u8 star)val); \
+	else if (size == 2) \
+     		return rw##_config_word(pciswap, bus, devfn, where, (u16 star)val); \
+	/* Size must be 4 */ \
+     	return rw##_config_dword(pciswap, bus, devfn, where, val); \
+}
+
+MAKE_PCI_OPS(extpci, read, &ext_pci_swap, *)
+    MAKE_PCI_OPS(extpci, write, &ext_pci_swap,)
+
+    MAKE_PCI_OPS(iopci, read, &io_pci_swap, *)
+    MAKE_PCI_OPS(iopci, write, &io_pci_swap,)
+
+struct pci_ops VR5701_ext_pci_ops = {
+	.read = extpci_read_config,
+	.write = extpci_write_config
+};
+
+struct pci_ops VR5701_io_pci_ops = {
+	.read = iopci_read_config,
+	.write = iopci_write_config
+};
Index: linux-2.6.10/arch/mips/vr5701/common/Makefile
===================================================================
--- /dev/null
+++ linux-2.6.10/arch/mips/vr5701/common/Makefile
@@ -0,0 +1,5 @@
+#
+# Makefile for the common code of NEC Electronics Corporation VR5701 SolutionGearII board
+#
+
+obj-y += nec_vrxxxx.o prom.o rtc_rx5c348.o
Index: linux-2.6.10/include/asm-mips/bootinfo.h
===================================================================
--- linux-2.6.10.orig/include/asm-mips/bootinfo.h
+++ linux-2.6.10/include/asm-mips/bootinfo.h
@@ -213,6 +213,12 @@
 #define MACH_GROUP_TITAN       22	/* PMC-Sierra Titan		*/
 #define  MACH_TITAN_YOSEMITE	1	/* PMC-Sierra Yosemite		*/
 
+/*
+ * Valid machtype for group SHIMA
+ */
+#define MACH_GROUP_SHIMA       24 /* SHIMAFUJI                              */
+#define MACH_SHIMA_TCUBE         0      /* SHIMAFUJI T-Cube(Vr5701) */
+
 #define CL_SIZE			COMMAND_LINE_SIZE
 
 const char *get_system_type(void);
Index: linux-2.6.10/drivers/video/smi/smifb.h
===================================================================
--- /dev/null
+++ linux-2.6.10/drivers/video/smi/smifb.h
@@ -0,0 +1,89 @@
+/*
+ * drivers/video/smi/smifb.h
+ *
+ * LynxEM+/EM4+(Silicon Motion Inc.) fb driver	for NEC Electronics Corporation VR5701 SolutionGearII
+ *
+ * Author: Sergey Podstavin <spodstavin@ru.mvista.com>
+ *
+ * 2005 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#ifndef __SMIFB_H__
+#define __SMIFB_H__
+
+#define FBCON_HAS_CFB16
+
+enum ScreenModes {
+	DISPLAY_640x480x16,
+	DISPLAY_800x600x16,
+	DISPLAY_1024x768x16,
+	DISPLAY_640x480x24,
+	DISPLAY_800x600x24,
+	DISPLAY_LCD_400x232x16,
+	modeNums,
+};
+
+#define SMI_DEFAULT_MODE	DISPLAY_640x480x16
+
+#define SIZE_SR00_SR04		(0x04 - 0x00 + 1)
+#define SIZE_SR10_SR24		(0x24 - 0x10 + 1)
+#define SIZE_SR30_SR75		(0x75 - 0x30 + 1)
+#define SIZE_SR80_SR93		(0x93 - 0x80 + 1)
+#define SIZE_SRA0_SRAF		(0xAF - 0xA0 + 1)
+#define SIZE_GR00_GR08		(0x08 - 0x00 + 1)
+#define SIZE_AR00_AR14		(0x14 - 0x00 + 1)
+#define SIZE_CR00_CR18		(0x18 - 0x00 + 1)
+#define SIZE_CR30_CR4D		(0x4D - 0x30 + 1)
+#define SIZE_CR90_CRA7		(0xA7 - 0x90 + 1)
+
+struct smi_mode_regs {
+	int mode;
+	u8 reg_MISC;
+	u8 reg_SR00_SR04[SIZE_SR00_SR04];	/* SEQ00--04 (SEQ) */
+	u8 reg_SR10_SR24[SIZE_SR10_SR24];	/* SCR10--1F, PDR20--24 (SYS),(PWR) */
+	u8 reg_SR30_SR75[SIZE_SR30_SR75];	/* FPR30--5A, MCR60--62, CCR65--6F  GPR70--75 (LCD),(MEM),(CLK),(GP) */
+	u8 reg_SR80_SR93[SIZE_SR80_SR93];	/* PHR80-81, POP82--86, HCR88-8D, POP90--93 (CURS),(ICON),(CURS),(ICON) */
+	u8 reg_SRA0_SRAF[SIZE_SRA0_SRAF];	/* FPRA0--AF (LCD) */
+	u8 reg_GR00_GR08[SIZE_GR00_GR08];	/* GR00--08 (GC) */
+	u8 reg_AR00_AR14[SIZE_AR00_AR14];	/* ATR00--14 (ATTR) */
+	u8 reg_CR00_CR18[SIZE_CR00_CR18];	/* CRT00--18 (CRTC) */
+	u8 reg_CR30_CR4D[SIZE_CR30_CR4D];	/* CRT30--3F, SVR40--4D (ECRTC),(SHADOW) */
+	u8 reg_CR90_CRA7[SIZE_CR90_CRA7];	/* CRT90--9B,9E,9F,A0--A5,A6,A7, (DDA),(EC2),(EC1)(VCLUT),(VC),(HC) */
+};
+
+typedef struct {
+	unsigned char red, green, blue, transp;
+} smi_cfb8_cmap_t;
+
+struct smifb_info;
+struct smifb_info {
+	struct fb_info info;	/* kernel framebuffer info */
+	const char *drvr_name;	/* Silicon Motion hardware board type */
+	struct pci_dev *pd;	/* descripbe the PCI device */
+	unsigned long base_phys;	/* physical base address                  */
+
+	/* PCI base physical addresses */
+	unsigned long fb_base_phys;	/* physical Frame Buffer base address                  */
+	unsigned long dpr_base_phys;	/* physical Drawing Processor base address             */
+	unsigned long vpr_base_phys;	/* physical Video Processor base address               */
+	unsigned long cpr_base_phys;	/* physical Capture Processor base address             */
+	unsigned long mmio_base_phys;	/* physical MMIO spase (VGA + SMI regs ?) base address */
+	unsigned long dpport_base_phys;	/* physical Drawing Processor Data Port base address   */
+	int dpport_size;	/* size of Drawin Processor Data Port memory space     */
+
+	/* PCI base virtual addresses */
+	caddr_t base;		/* address of base */
+	caddr_t fb_base;	/* address of frame buffer base */
+	caddr_t dpr;		/* Drawing Processor Registers  */
+	caddr_t vpr;		/* Video Processor Registers    */
+	caddr_t cpr;		/* Capture Processor Registers  */
+	caddr_t mmio;		/* Memory Mapped I/O Port       */
+	caddr_t dpport;		/* Drawing Processor Data       */
+
+	int fbsize;		/* Frame-Buffer memory size */
+};
+
+#endif				/* __SMIFB_H__ */
Index: linux-2.6.10/arch/mips/mm/tlbex.c
===================================================================
--- linux-2.6.10.orig/arch/mips/mm/tlbex.c
+++ linux-2.6.10/arch/mips/mm/tlbex.c
@@ -784,6 +784,7 @@ static __init void __attribute__((unused
 	case CPU_R5000:
 	case CPU_R5000A:
 	case CPU_NEVADA:
+	case CPU_R5500:
 		i_nop(p);
 		i_tlbp(p);
 		break;
@@ -831,6 +832,7 @@ static __init void build_tlb_write_entry
 	case CPU_R4600:
 	case CPU_R4700:
 	case CPU_R5000:
+	case CPU_R5500:             
 	case CPU_R5000A:
 	case CPU_5KC:
 	case CPU_TX49XX:
Index: linux-2.6.10/arch/mips/vr5701/common/prom.c
===================================================================
--- /dev/null
+++ linux-2.6.10/arch/mips/vr5701/common/prom.c
@@ -0,0 +1,53 @@
+/*
+ * arch/mips/vr5701/common/prom.c
+ *
+ * A code for prom routines on NEC Electronics Corporation VR5701 SolutionGearII 
+ *
+ * Author: Sergey Podstavin <spodstavin@ru.mvista.com>
+ *
+ * 2005 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/mm.h>
+#include <linux/sched.h>
+#include <linux/bootmem.h>
+#include <asm/addrspace.h>
+#include <asm/bootinfo.h>
+#include <asm/debug.h>
+#include <asm/tcube.h>
+
+const char *get_system_type(void)
+{
+	return "NEC Electronics Corporation VR5701 SolutionGearII";
+}
+
+void __init prom_init(void)
+{
+	int i;
+	int argc = fw_arg0;
+	char **arg = (char **)fw_arg1;
+
+	/* if user passes kernel args, ignore the default one */
+	if (argc > 1)
+		arcs_cmdline[0] = '\0';
+
+	/* arg[0] is "g", the rest is boot parameters */
+	for (i = 1; i < argc; i++) {
+		if (strlen(arcs_cmdline) + strlen(arg[i] + 1)
+		    >= sizeof(arcs_cmdline))
+			break;
+		strcat(arcs_cmdline, arg[i]);
+		strcat(arcs_cmdline, " ");
+	}
+	mips_machgroup = MACH_GROUP_SHIMA;
+	mips_machtype = MACH_SHIMA_TCUBE;
+	add_memory_region(0, TCUBE_SDRAM_SIZE, BOOT_MEM_RAM);
+}
+
+void __init prom_free_prom_memory(void)
+{
+}
Index: linux-2.6.10/arch/mips/lib-64/Makefile
===================================================================
--- linux-2.6.10.orig/arch/mips/lib-64/Makefile
+++ linux-2.6.10/arch/mips/lib-64/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_CPU_R4300)		+= dump_tlb.o
 obj-$(CONFIG_CPU_R4X00)		+= dump_tlb.o
 obj-$(CONFIG_CPU_R5000)		+= dump_tlb.o
 obj-$(CONFIG_CPU_R5432)		+= dump_tlb.o
+obj-$(CONFIG_CPU_R5500)		+= dump_tlb.o
 obj-$(CONFIG_CPU_R6000)		+=
 obj-$(CONFIG_CPU_R8000)		+=
 obj-$(CONFIG_CPU_RM7000)	+= dump_tlb.o
Index: linux-2.6.10/arch/mips/lib-32/Makefile
===================================================================
--- linux-2.6.10.orig/arch/mips/lib-32/Makefile
+++ linux-2.6.10/arch/mips/lib-32/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_CPU_R4300)		+= dump_tlb.o
 obj-$(CONFIG_CPU_R4X00)		+= dump_tlb.o
 obj-$(CONFIG_CPU_R5000)		+= dump_tlb.o
 obj-$(CONFIG_CPU_R5432)		+= dump_tlb.o
+obj-$(CONFIG_CPU_R5500)		+= dump_tlb.o
 obj-$(CONFIG_CPU_R6000)		+=
 obj-$(CONFIG_CPU_R8000)		+=
 obj-$(CONFIG_CPU_RM7000)	+= dump_tlb.o
Index: linux-2.6.10/sound/oss/Kconfig
===================================================================
--- linux-2.6.10.orig/sound/oss/Kconfig
+++ linux-2.6.10/sound/oss/Kconfig
@@ -233,6 +233,13 @@ config SOUND_VRC5477
 	  integrated, multi-function controller chip for MIPS CPUs.  Works
 	  with the AC97 codec.
 
+config SOUND_VR5701
+	tristate "NEC Electronics Corporation VR5701 SolutionGearII AC97 sound"
+	depends on SOUND_PRIME!=n && TCUBE && SOUND
+	help
+	  Say Y here to enable sound support for the NEC Electronics Corporation 
+	  VR5701 SolutionGearII AC97 sound. Works with the AC97 codec.
+
 config SOUND_AU1000
 	tristate "Au1000 Sound"
 	depends on SOUND_PRIME!=n && (SOC_AU1000 || SOC_AU1100 || SOC_AU1500) && SOUND
Index: linux-2.6.10/drivers/video/Kconfig
===================================================================
--- linux-2.6.10.orig/drivers/video/Kconfig
+++ linux-2.6.10/drivers/video/Kconfig
@@ -795,6 +795,25 @@ config FB_ATY_GX
 	  is at
 	  <http://support.ati.com/products/pc/mach64/graphics_xpression.html>.
 
+config FB_SM
+	tristate "Silicon Motion SM722 support"
+	depends on FB && PCI
+	help
+	  SM722
+
+choice
+	prompt "Display size"
+	depends on FB_SM
+	default DISPLAY_640x480
+
+config DISPLAY_640x480
+	bool "640x480"
+
+config DISPLAY_1024x768
+	bool "1024x768"
+
+endchoice
+
 config FB_SAVAGE
 	tristate "S3 Savage support"
 	depends on FB && PCI && EXPERIMENTAL
Index: linux-2.6.10/arch/mips/kernel/cpu-probe.c
===================================================================
--- linux-2.6.10.orig/arch/mips/kernel/cpu-probe.c
+++ linux-2.6.10/arch/mips/kernel/cpu-probe.c
@@ -98,6 +98,7 @@ static inline void check_wait(void)
 	case CPU_R4650:
 	case CPU_R4700:
 	case CPU_R5000:
+	case CPU_R5500:
 	case CPU_NEVADA:
 	case CPU_RM7000:
 	case CPU_RM9000:
Index: linux-2.6.10/drivers/video/smi/smi_params.h
===================================================================
--- /dev/null
+++ linux-2.6.10/drivers/video/smi/smi_params.h
@@ -0,0 +1,442 @@
+/*
+ * drivers/video/smi/smi_params.h
+ *
+ * LynxEM+/EM4+(Silicon Motion Inc.) fb driver	for NEC Electronics Corporation VR5701 SolutionGearII
+ *
+ * Author: Sergey Podstavin <spodstavin@ru.mvista.com>
+ *
+ * 2005 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#ifndef __SMI_REGS_H__
+#define __SMI_REGS_H__
+
+/* register settings */
+struct smi_mode_regs ModeInitParams[modeNums] = {
+	/* mode#4 640 x 480 16Bpp 60Hz */
+	{
+	 DISPLAY_640x480x16,
+	 /* reg_MISC */
+	 0xE3,
+	 /* reg_SR00_SR04 */
+	 {
+	  0x03, 0x01, 0x0F, 0x00, 0x0E,
+	  },
+	 /* reg_SR10_SR24 */
+	 {
+	  0x03, 0x00, 0x00, 0x00, 0x00, 0x0E, 0x10, 0x2C,
+	  0x59, 0x00, 0x20, 0x00, 0x00, 0x0F, 0x0F, 0x00,
+	  0xC4, 0x30, 0x02, 0x01, 0x01,
+	  },
+
+	 /* reg_SR30_SR75 */
+	 {
+	  0xAA, 0x03, 0xA0, 0x89, 0xC0, 0xAA, 0xAA, 0xAA,
+	  0xAA, 0xAA, 0xAA, 0xAA, 0x00, 0x00, 0x03, 0xFF,
+	  0x00, 0xFC, 0x00, 0x00, 0x20, 0x38, 0x00, 0xFC,
+	  0x20, 0x0C, 0x44, 0x20, 0x00, 0x00, 0x00, 0xAA,
+	  0x04, 0x24, 0x63, 0x4F, 0x52, 0x0B, 0xDF, 0xEA,
+	  0x04, 0x50, 0x19, 0xAA, 0xAA, 0x00, 0x00, 0xAA,
+	  0x01, 0x80, 0xFF, 0x1A, 0x1A, 0x00, 0x03, 0x00,
+	  0x50, 0x03, 0x0D, 0x02, 0x07, 0x82, 0x07, 0x04,
+	  0x00, 0x45, 0x30, 0x0C, 0x40, 0x30,
+	  },
+	 /* reg_SR80_SR93 */
+	 {
+	  0xFF, 0x07, 0x00, 0x6F, 0x7F, 0x7F, 0xFF, 0xAA,
+	  0x40, 0x01, 0xF0, 0x00, 0xFF, 0x00, 0xAA, 0xAA,
+	  0x00, 0x00, 0x00, 0x00,
+	  },
+	 /* reg_SRA0_SRAF */
+	 {
+	  0x00, 0xFF, 0xBF, 0xFF, 0xFF, 0xED, 0xED, 0xED,
+	  0x7B, 0xFF, 0xFF, 0xFF, 0xBF, 0xEF, 0xFF, 0xDF,
+	  },
+	 /* reg_GR00_GR08 */
+	 {
+	  0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x05, 0x0F,
+	  0xFF,
+	  },
+	 /* reg_AR00_AR14 */
+	 {
+	  0x3F, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
+	  0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F,
+	  0x10, 0x00, 0x12, 0x00, 0x04,
+	  },
+	 /* reg_CR00_CR18 */
+	 {
+	  0x5F, 0x4F, 0x4F, 0x00, 0x53, 0x1F, 0x0B, 0x3E,
+	  0x00, 0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	  0xEA, 0x0C, 0xDF, 0x50, 0x40, 0xDF, 0x00, 0xE3,
+	  0xFF,
+	  },
+	 /* reg_CR30_CR4D */
+	 {
+	  0x00, 0x00, 0x00, 0x00, 0x00, 0x55, 0x03, 0x20,
+	  0x00, 0x00, 0x00, 0x40, 0x00, 0xE7, 0xFF, 0xFD,
+	  0x5F, 0x4F, 0x00, 0x54, 0x00, 0x0B, 0xDF, 0x00,
+	  0xEA, 0x0C, 0x2E, 0x00, 0x4F, 0xDF,
+	  },
+	 /* reg_CR90_CRA7 */
+	 {
+	  0x56, 0xDD, 0x5E, 0xEA, 0x87, 0x44, 0x8F, 0x55,
+	  0x0A, 0x8F, 0x55, 0x0A, 0x00, 0x00, 0x18, 0x00,
+	  0x11, 0x10, 0x0B, 0x0A, 0x0A, 0x0A, 0x0A, 0x00,
+	  },
+	 },
+	/* mode#5 800 x 600 16Bpp 60Hz */
+	{
+	 DISPLAY_800x600x16,
+	 /* reg_MISC */
+	 0x2B,
+	 /* reg_SR00_SR04 */
+	 {
+	  0x03, 0x01, 0x0F, 0x03, 0x0E,
+	  },
+	 /* reg_SR10_SR24 */
+	 {
+	  0xFF, 0xBE, 0xEE, 0xFF, 0x00, 0x0E, 0x17, 0xe2,
+	  0xff, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	  0xC4, 0x30, 0x02, 0x01, 0x01,
+	  },
+	 /* reg_SR30_SR75 */
+	 {
+	  0x36, 0x03, 0x20, 0x09, 0xC0, 0x36, 0x36, 0x36,
+	  0x36, 0x36, 0x36, 0x36, 0x00, 0x00, 0x03, 0xFF,
+	  0x00, 0xFC, 0x00, 0x00, 0x20, 0x18, 0x00, 0xFC,
+	  0x20, 0x0C, 0x44, 0x20, 0x00, 0x36, 0x36, 0x36,
+	  0x04, 0x48, 0x83, 0x63, 0x68, 0x72, 0x57, 0x58,
+	  0x04, 0x55, 0x59, 0x36, 0x36, 0x00, 0x00, 0x36,
+	  0x01, 0x80, 0x7E, 0x1A, 0x1A, 0x00, 0x00, 0x00,
+	  0x50, 0x03, 0x74, 0x14, 0x1C, 0x85, 0x35, 0x13,
+	  0x02, 0x45, 0x30, 0x30, 0x40, 0x20,
+	  },
+	 /* reg_SR80_SR93 */
+	 {
+	  0xFF, 0x07, 0x00, 0x6F, 0x7F, 0x7F, 0xFF, 0x36,
+	  0xF7, 0x00, 0x00, 0x00, 0xEF, 0xFF, 0x36, 0x36,
+	  0x00, 0x00, 0x00, 0x00,
+	  },
+	 /* reg_SRA0_SRAF */
+	 {
+	  0x00, 0xFF, 0xBF, 0xFF, 0xFF, 0xED, 0xED, 0xED,
+	  0x7B, 0xFF, 0xFF, 0xFF, 0xBF, 0xEF, 0xBF, 0xDF,
+	  },
+	 /* reg_GR00_GR08 */
+	 {
+	  0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x05, 0x0F,
+	  0xFF,
+	  },
+	 /* reg_AR00_AR14 */
+	 {
+	  0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
+	  0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F,
+	  0x41, 0x00, 0x0F, 0x00, 0x00,
+	  },
+	 /* reg_CR00_CR18 */
+	 {
+	  0x7F, 0x63, 0x63, 0x00, 0x68, 0x18, 0x72, 0xF0,
+	  0x00, 0x60, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	  0x58, 0x0C, 0x57, 0x64, 0x40, 0x57, 0x00, 0xE3,
+	  0xFF,
+	  },
+	 /* reg_CR30_CR4D */
+	 {
+	  0x00, 0x00, 0x00, 0x00, 0x00, 0x33, 0x03, 0x20,
+	  0x00, 0x00, 0x00, 0x40, 0x00, 0xE7, 0xBF, 0xFD,
+	  0x7F, 0x63, 0x00, 0x69, 0x18, 0x72, 0x57, 0x00,
+	  0x58, 0x0C, 0xE0, 0x20, 0x63, 0x57,
+	  },
+	 /* reg_CR90_CRA7 */
+	 {
+	  0x56, 0x4B, 0x5E, 0x55, 0x86, 0x9D, 0x8E, 0xAA,
+	  0xDB, 0x2A, 0xDF, 0x33, 0x00, 0x00, 0x18, 0x00,
+	  0x20, 0x1F, 0x1A, 0x19, 0x0F, 0x0F, 0x0F, 0x00,
+	  },
+	 },
+	/* mode#6 1024 x 768 16Bpp 60Hz * */
+	{
+	 DISPLAY_1024x768x16,
+	 /* reg_MISC */
+	 0xEB,
+	 /* reg_SR00_SR04 */
+	 {
+	  0x03, 0x01, 0x0F, 0x03, 0x0E,
+	  },
+	 /* reg_SR10_SR24 */
+	 {
+	  0x03, 0x00, 0x00, 0x00, 0x00, 0x0E, 0x10, 0x2c,
+	  0x59, 0x02, 0x00, 0x00, 0x00, 0x0F, 0x0F, 0x00,
+	  0xC4, 0x30, 0x02, 0x01, 0x01,
+	  },
+	 /* reg_SR30_SR75 */
+	 {
+	  0xAA, 0x03, 0x20, 0x89, 0xC0, 0xAA, 0xAA, 0xAA,
+	  0xAA, 0xAA, 0xAA, 0xAA, 0x00, 0x00, 0x03, 0xFF,
+	  0x00, 0xFC, 0x00, 0x00, 0x20, 0x38, 0x00, 0xFC,
+	  0x20, 0x0C, 0x44, 0x20, 0x00, 0x00, 0x00, 0xAA,
+	  0x06, 0x68, 0xA7, 0x7F, 0x83, 0x24, 0xFF, 0x03,
+	  0x00, 0x60, 0x59, 0xAA, 0xAA, 0x00, 0x00, 0xAA,
+	  0x01, 0x80, 0xFF, 0x1A, 0x1A, 0x00, 0x03, 0x00,
+	  0x50, 0x03, 0x0D, 0x02, 0x12, 0x82, 0x09, 0x02,
+	  0x04, 0x45, 0x30, 0x0C, 0x40, 0x20,
+	  },
+	 /* reg_SR80_SR93 */
+	 {
+	  0xFF, 0x07, 0x00, 0xFF, 0xFF, 0xFF, 0xFF, 0xAA,
+	  0xF7, 0x00, 0x00, 0x00, 0xFF, 0xFF, 0xAA, 0xAA,
+	  0x00, 0x00, 0x00, 0x00,
+	  },
+	 /* reg_SRA0_SRAF */
+	 {
+	  0x00, 0xFB, 0x9F, 0x01, 0x00, 0xED, 0xED, 0xED,
+	  0x7B, 0xFB, 0xFF, 0xFF, 0x97, 0xEF, 0xBF, 0xDF,
+	  },
+	 /* reg_GR00_GR08 */
+	 {
+	  0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x05, 0x0F,
+	  0xFF,
+	  },
+	 /* reg_AR00_AR14 */
+	 {
+	  0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
+	  0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F,
+	  0x41, 0x11, 0x0F, 0x13, 0x00,
+	  },
+	 /* reg_CR00_CR18 */
+	 {
+	  0xA3, 0x7F, 0x7F, 0x00, 0x85, 0x16, 0x24, 0xF5,
+	  0x00, 0x60, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	  0x03, 0x09, 0xFF, 0x80, 0x40, 0xFF, 0x00, 0xE3,
+	  0xFF,
+	  },
+	 /* reg_CR30_CR4D */
+	 {
+	  0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0x02, 0x20,
+	  0x00, 0x00, 0x00, 0x40, 0x00, 0xFF, 0xBF, 0xFF,
+	  0xA3, 0x7F, 0x00, 0x86, 0x15, 0x24, 0xFF, 0x00,
+	  0x01, 0x07, 0xE5, 0x20, 0x7F, 0xFF,
+	  },
+	 /* reg_CR90_CRA7 */
+	 {
+	  0x55, 0xD9, 0x5D, 0xE1, 0x86, 0x1B, 0x8E, 0x26,
+	  0xDA, 0x8D, 0xDE, 0x94, 0x00, 0x00, 0x18, 0x00,
+	  0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x15, 0x03,
+	  },
+	 },
+	/* mode#7 640 x 480 24Bpp 60Hz */
+	{
+	 DISPLAY_640x480x24,
+	 /* reg_MISC */
+	 0xE3,
+	 /* reg_SR00_SR04 */
+	 {
+	  0x03, 0x01, 0x0F, 0x00, 0x0E,
+	  },
+	 /* reg_SR10_SR24 */
+	 {
+	  0xFF, 0xBE, 0xEF, 0xFF, 0x00, 0x0E, 0x17, 0xe2,
+	  0xff, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	  0xC4, 0x30, 0x02, 0x01, 0x01,
+	  },
+	 /* reg_SR30_SR75 */
+	 {
+	  0x32, 0x03, 0xA0, 0x09, 0xC0, 0x32, 0x32, 0x32,
+	  0x32, 0x32, 0x32, 0x32, 0x00, 0x00, 0x03, 0xFF,
+	  0x00, 0xFC, 0x00, 0x00, 0x20, 0x18, 0x00, 0xFC,
+	  0x20, 0x0C, 0x44, 0x20, 0x00, 0x32, 0x32, 0x32,
+	  0x04, 0x24, 0x63, 0x4F, 0x52, 0x0B, 0xDF, 0xEA,
+	  0x04, 0x50, 0x19, 0x32, 0x32, 0x00, 0x00, 0x32,
+	  0x01, 0x80, 0x7E, 0x1A, 0x1A, 0x00, 0x00, 0x00,
+	  0x50, 0x03, 0x74, 0x14, 0x07, 0x82, 0x07, 0x04,
+	  0x00, 0x45, 0x30, 0x30, 0x40, 0x30,
+	  },
+	 /* reg_SR80_SR93 */
+	 {
+	  0xFF, 0x07, 0x00, 0x6F, 0x7F, 0x7F, 0xFF, 0x32,
+	  0xF7, 0x00, 0x00, 0x00, 0xEF, 0xFF, 0x32, 0x32,
+	  0x00, 0x00, 0x00, 0x00,
+	  },
+	 /* reg_SRA0_SRAF */
+	 {
+	  0x00, 0xFF, 0xBF, 0xFF, 0xFF, 0xED, 0xED, 0xED,
+	  0x7B, 0xFF, 0xFF, 0xFF, 0xBF, 0xEF, 0xFF, 0xDF,
+	  },
+	 /* reg_GR00_GR08 */
+	 {
+	  0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x05, 0x0F,
+	  0xFF,
+	  },
+	 /* reg_AR00_AR14 */
+	 {
+	  0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
+	  0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F,
+	  0x41, 0x00, 0x0F, 0x00, 0x00,
+	  },
+	 /* reg_CR00_CR18 */
+	 {
+	  0x5F, 0x4F, 0x4F, 0x00, 0x53, 0x1F, 0x0B, 0x3E,
+	  0x00, 0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	  0xEA, 0x0C, 0xDF, 0x50, 0x40, 0xDF, 0x00, 0xE3,
+	  0xFF,
+	  },
+	 /* reg_CR30_CR4D */
+	 {
+	  0x00, 0x00, 0x00, 0x00, 0x00, 0x55, 0x03, 0x20,
+	  0x00, 0x00, 0x00, 0x40, 0x00, 0xE7, 0xFF, 0xFD,
+	  0x5F, 0x4F, 0x00, 0x54, 0x00, 0x0B, 0xDF, 0x00,
+	  0xEA, 0x0C, 0x2E, 0x00, 0x4F, 0xDF,
+	  },
+	 /* reg_CR90_CRA7 */
+	 {
+	  0x56, 0xDD, 0x5E, 0xEA, 0x87, 0x44, 0x8F, 0x55,
+	  0x0A, 0x8F, 0x55, 0x0A, 0x00, 0x00, 0x18, 0x00,
+	  0x11, 0x10, 0x0B, 0x0A, 0x0A, 0x0A, 0x0A, 0x00,
+	  },
+	 },
+	/* mode#8 800 x 600 24Bpp 60Hz */
+	{
+	 DISPLAY_800x600x24,
+	 /* reg_MISC */
+	 0x2B,
+	 /* reg_SR00_SR04 */
+	 {
+	  0x03, 0x01, 0x0F, 0x03, 0x0E,
+	  },
+	 /* reg_SR10_SR24 */
+	 {
+	  0xFF, 0xBE, 0xEE, 0xFF, 0x00, 0x0E, 0x17, 0xe2,
+	  0xff, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	  0xC4, 0x30, 0x02, 0x01, 0x01,
+	  },
+	 /* reg_SR30_SR75 */
+	 {
+	  0x36, 0x03, 0x20, 0x09, 0xC0, 0x36, 0x36, 0x36,
+	  0x36, 0x36, 0x36, 0x36, 0x00, 0x00, 0x03, 0xFF,
+	  0x00, 0xFC, 0x00, 0x00, 0x20, 0x18, 0x00, 0xFC,
+	  0x20, 0x0C, 0x44, 0x20, 0x00, 0x36, 0x36, 0x36,
+	  0x04, 0x48, 0x83, 0x63, 0x68, 0x72, 0x57, 0x58,
+	  0x04, 0x55, 0x59, 0x36, 0x36, 0x00, 0x00, 0x36,
+	  0x01, 0x80, 0x7E, 0x1A, 0x1A, 0x00, 0x00, 0x00,
+	  0x50, 0x03, 0x74, 0x14, 0x1C, 0x85, 0x35, 0x13,
+	  0x02, 0x45, 0x30, 0x30, 0x40, 0x20,
+	  },
+	 /* reg_SR80_SR93 */
+	 {
+	  0xFF, 0x07, 0x00, 0x6F, 0x7F, 0x7F, 0xFF, 0x36,
+	  0xF7, 0x00, 0x00, 0x00, 0xEF, 0xFF, 0x36, 0x36,
+	  0x00, 0x00, 0x00, 0x00,
+	  },
+	 /* reg_SRA0_SRAF */
+	 {
+	  0x00, 0xFF, 0xBF, 0xFF, 0xFF, 0xED, 0xED, 0xED,
+	  0x7B, 0xFF, 0xFF, 0xFF, 0xBF, 0xEF, 0xBF, 0xDF,
+	  },
+	 /* reg_GR00_GR08 */
+	 {
+	  0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x05, 0x0F,
+	  0xFF,
+	  },
+	 /* reg_AR00_AR14 */
+	 {
+	  0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
+	  0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F,
+	  0x41, 0x00, 0x0F, 0x00, 0x00,
+	  },
+	 /* reg_CR00_CR18 */
+	 {
+	  0x7F, 0x63, 0x63, 0x00, 0x68, 0x18, 0x72, 0xF0,
+	  0x00, 0x60, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	  0x58, 0x0C, 0x57, 0x64, 0x40, 0x57, 0x00, 0xE3,
+	  0xFF,
+	  },
+	 /* reg_CR30_CR4D */
+	 {
+	  0x00, 0x00, 0x00, 0x00, 0x00, 0x33, 0x03, 0x20,
+	  0x00, 0x00, 0x00, 0x40, 0x00, 0xE7, 0xBF, 0xFD,
+	  0x7F, 0x63, 0x00, 0x69, 0x18, 0x72, 0x57, 0x00,
+	  0x58, 0x0C, 0xE0, 0x20, 0x63, 0x57,
+	  },
+	 /* reg_CR90_CRA7 */
+	 {
+	  0x56, 0x4B, 0x5E, 0x55, 0x86, 0x9D, 0x8E, 0xAA,
+	  0xDB, 0x2A, 0xDF, 0x33, 0x00, 0x00, 0x18, 0x00,
+	  0x20, 0x1F, 0x1A, 0x19, 0x0F, 0x0F, 0x0F, 0x00,
+	  },
+	 },
+	/* mode#9 400 x 232 16Bpp 60Hz */
+	{
+	 DISPLAY_LCD_400x232x16,
+	 /* reg_MISC */
+	 0x2B,
+	 /* reg_SR00_SR04 */
+	 {
+	  0x03, 0x01, 0x0F, 0x03, 0x0E,
+	  },
+	 /* reg_SR10_SR24 */
+	 {
+	  0x03, 0x00, 0x00, 0x00, 0x00, 0x08, 0x10, 0x2C,
+	  0x59, 0x00, 0x00, 0x00, 0x00, 0x0F, 0x0F, 0x00,
+	  0x84, 0x00, 0x02, 0x00, 0x31,
+	  },
+	 /* reg_SR30_SR75 */
+	 {
+	  0xB7, 0x43, 0x98, 0x01, 0xC0, 0xB7, 0xB7, 0xB7,
+	  0xB7, 0xB7, 0xB7, 0xB7, 0x00, 0x00, 0x85, 0x2C,
+	  0xC0, 0xE1, 0x00, 0x00, 0x40, 0xF0, 0x80, 0xC4,
+	  0x40, 0x3C, 0xA1, 0x40, 0x00, 0x00, 0x01, 0xB7,
+	  0x02, 0x24, 0xD9, 0xC7, 0xCC, 0x31, 0x2C, 0x2D,
+	  0x07, 0x57, 0x19, 0xB7, 0xB7, 0x00, 0x00, 0xB7,
+	  0x01, 0x00, 0xFF, 0x1A, 0x1A, 0x01, 0x03, 0x00,
+	  0xD4, 0x07, 0x0D, 0x02, 0x23, 0x3F, 0x35, 0x13,
+	  0x83, 0xDD, 0x02, 0x0C, 0x05, 0x00,
+	  },
+	 /* reg_SR80_SR93 */
+	 {
+	  0xFF, 0x0F, 0x00, 0x00, 0x00, 0x00, 0x09, 0xB7,
+	  0x48, 0x00, 0x36, 0x00, 0xFF, 0x00, 0xB7, 0xB7,
+	  0x00, 0x00, 0x00, 0x00,
+	  },
+	 /* reg_SRA0_SRAF */
+	 {
+	  0x00, 0xFF, 0xBF, 0xFF, 0xFF, 0xED, 0xED, 0xED,
+	  0x7B, 0xFF, 0xFF, 0xFF, 0xBF, 0xEF, 0xBF, 0xDF,
+	  },
+	 /* reg_GR00_GR08 */
+	 {
+	  0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x05, 0x0F,
+	  0xFF,
+	  },
+	 /* reg_AR00_AR14 */
+	 {
+	  0x00, 0x02, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
+	  0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F,
+	  0x10, 0x00, 0x12, 0x00, 0x04,
+	  },
+	 /* reg_CR00_CR18 */
+	 {
+	  0x3B, 0x31, 0x31, 0x00, 0x3A, 0x00, 0x06, 0x11,
+	  0x00, 0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	  0xF1, 0x85, 0xE9, 0x32, 0x40, 0xE9, 0x00, 0xEB,
+	  0xFF,
+	  },
+	 /* reg_CR30_CR4D */
+	 {
+	  0x00, 0x00, 0x00, 0x00, 0x00, 0x88, 0x02, 0x10,
+	  0x00, 0x00, 0x00, 0x40, 0x00, 0x20, 0x00, 0x00,
+	  0x3B, 0x31, 0x00, 0x3A, 0x00, 0x06, 0xEA, 0x00,
+	  0xF2, 0x05, 0x01, 0x00, 0x31, 0xE9,
+	  },
+	 /* reg_CR90_CRA7 */
+	 {
+	  0x56, 0x4B, 0x5E, 0x55, 0x86, 0x9D, 0x8E, 0xAA,
+	  0xDB, 0x2A, 0xDF, 0x33, 0xFF, 0xFF, 0x1B, 0x00,
+	  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	  },
+	 },
+};
+
+#endif				/* __SMI_REGS_H__ */
Index: linux-2.6.10/arch/mips/vr5701/common/nec_vrxxxx.c
===================================================================
--- /dev/null
+++ linux-2.6.10/arch/mips/vr5701/common/nec_vrxxxx.c
@@ -0,0 +1,119 @@
+/*
+ * arch/mips/vr5701/common/nec_vrxxxx.c
+ *
+ * A code for low-level routines on NEC Electronics Corporation VR5701 SolutionGearII 
+ *
+ * Author: Sergey Podstavin <spodstavin@ru.mvista.com>
+ *
+ * 2005 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+#include <linux/config.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <asm/tcube.h>
+
+u32
+ddb_calc_pdar(u32 phys, u32 size, int width, int on_memory_bus, int pci_visible)
+{
+	u32 maskbits;
+	u32 widthbits;
+
+	switch (size) {
+	case 0x80000000:	/* 2 GB */
+		maskbits = 5;
+		break;
+	case 0x40000000:	/* 1 GB */
+		maskbits = 6;
+		break;
+	case 0x20000000:	/* 512 MB */
+		maskbits = 7;
+		break;
+	case 0x10000000:	/* 256 MB */
+		maskbits = 8;
+		break;
+	case 0x08000000:	/* 128 MB */
+		maskbits = 9;
+		break;
+	case 0x04000000:	/* 64 MB */
+		maskbits = 10;
+		break;
+	case 0x02000000:	/* 32 MB */
+		maskbits = 11;
+		break;
+	case 0x01000000:	/* 16 MB */
+		maskbits = 12;
+		break;
+	case 0x00800000:	/* 8 MB */
+		maskbits = 13;
+		break;
+	case 0x00400000:	/* 4 MB */
+		maskbits = 14;
+		break;
+	case 0x00200000:	/* 2 MB */
+		maskbits = 15;
+		break;
+	case 0:		/* OFF */
+		maskbits = 0;
+		break;
+	default:
+		panic("VR5701_set_pdar: unsupported size %p", (void *)size);
+	}
+	switch (width) {
+	case 8:
+		widthbits = 0;
+		break;
+	case 16:
+		widthbits = 1;
+		break;
+	case 32:
+		widthbits = 2;
+		break;
+	case 64:
+		widthbits = 3;
+		break;
+	default:
+		panic("VR5701_set_pdar: unsupported width %d", width);
+	}
+
+	return maskbits | (on_memory_bus ? 0x10 : 0) |
+	    (pci_visible ? 0x20 : 0) | (widthbits << 6) | (phys & 0xffe00000);
+}
+
+void
+ddb_set_pdar(u32 pdar, u32 phys, u32 size, int width,
+	     int on_memory_bus, int pci_visible)
+{
+	u32 temp = ddb_calc_pdar(phys, size, width, on_memory_bus, pci_visible);
+	ddb_out32(pdar, temp);
+	ddb_out32(pdar + 4, 0);
+	ddb_in32(pdar);
+	ddb_in32(pdar + 4);
+}
+
+/*
+ * routines that mess with PCIINITx registers
+ */
+
+void ddb_set_pmr(u32 pmr, u32 type, u32 addr, u32 options)
+{
+	switch (type) {
+	case DDB_PCICMD_IACK:	/* PCI Interrupt Acknowledge */
+	case DDB_PCICMD_IO:	/* PCI I/O Space */
+	case DDB_PCICMD_MEM:	/* PCI Memory Space */
+	case DDB_PCICMD_CFG:	/* PCI Configuration Space */
+		break;
+	default:
+		panic("VR5701_set_pmr: invalid type %d", type);
+	}
+	ddb_out32(pmr, (type << 1) | (addr & 0xffe00000) | options);
+	ddb_out32(pmr + 4, 0);
+}
+
+void ddb_set_bar(u32 bar, u32 phys, int prefetchable)
+{
+	ddb_out32(bar, (phys & 0xffe00000) | (!!prefetchable << 3));
+	ddb_out32(bar + 4, 0);
+}
Index: linux-2.6.10/sound/oss/nec_vr5701_sg2.c
===================================================================
--- /dev/null
+++ linux-2.6.10/sound/oss/nec_vr5701_sg2.c
@@ -0,0 +1,1368 @@
+/*
+ * sound/oss/nec_vr5701_sg2.c
+ *
+ * A sound driver for NEC Electronics Corporation VR5701 SolutionGearII.
+ * It works with AC97 codec. 
+ *
+ * Author: Sergey Podstavin <spodstavin@ru.mvista.com>
+ *
+ * 2005 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+#include "nec_vr5701_sg2.h"
+
+static LIST_HEAD(devs);
+
+static u16 rdcodec(struct ac97_codec *codec, u8 addr)
+{
+	struct vr5701_ac97_state *s =
+	    (struct vr5701_ac97_state *)codec->private_data;
+	unsigned long flags;
+	u32 result;
+
+	spin_lock_irqsave(&s->lock, flags);
+
+	/* wait until we can access codec registers */
+	while (inl(s->io + vr5701_CODEC_WR) & 0x80000000) ;
+
+	/* write the address and "read" command to codec */
+	addr = addr & 0x7f;
+	outl((addr << 16) | vr5701_CODEC_WR_RWC, s->io + vr5701_CODEC_WR);
+
+	/* get the return result */
+	udelay(100);		/* workaround hardware bug */
+	while ((result = inl(s->io + vr5701_CODEC_RD)) &
+	       (vr5701_CODEC_RD_RRDYA | vr5701_CODEC_RD_RRDYD)) {
+		/* we get either addr or data, or both */
+		if (result & vr5701_CODEC_RD_RRDYA) {
+			ASSERT(addr == ((result >> 16) & 0x7f));
+		}
+		if (result & vr5701_CODEC_RD_RRDYD) {
+			break;
+		}
+	}
+
+	spin_unlock_irqrestore(&s->lock, flags);
+
+	return result & 0xffff;
+}
+
+static void wrcodec(struct ac97_codec *codec, u8 addr, u16 data)
+{
+	struct vr5701_ac97_state *s =
+	    (struct vr5701_ac97_state *)codec->private_data;
+	unsigned long flags;
+
+	spin_lock_irqsave(&s->lock, flags);
+
+	/* wait until we can access codec registers */
+	while (inl(s->io + vr5701_CODEC_WR) & 0x80000000) ;
+
+	/* write the address and value to codec */
+	outl((addr << 16) | data, s->io + vr5701_CODEC_WR);
+
+	spin_unlock_irqrestore(&s->lock, flags);
+}
+
+static void waitcodec(struct ac97_codec *codec)
+{
+	struct vr5701_ac97_state *s =
+	    (struct vr5701_ac97_state *)codec->private_data;
+
+	/* wait until we can access codec registers */
+	while (inl(s->io + vr5701_CODEC_WR) & 0x80000000) ;
+}
+
+static void vr5701_ac97_delay(int msec)
+{
+	unsigned long tmo;
+	signed long tmo2;
+
+	if (in_interrupt())
+		return;
+
+	tmo = jiffies + (msec * HZ) / 1000;
+	for (;;) {
+		tmo2 = tmo - jiffies;
+		if (tmo2 <= 0)
+			break;
+		schedule_timeout(tmo2);
+	}
+}
+
+static void set_adc_rate(struct vr5701_ac97_state *s, unsigned rate)
+{
+	wrcodec(s->codec, AC97_PCM_LR_ADC_RATE, rate);
+	s->adcRate = rate;
+}
+
+static void set_dac_rate(struct vr5701_ac97_state *s, unsigned rate)
+{
+	if (s->extended_status & AC97_EXTSTAT_VRA) {
+		wrcodec(s->codec, AC97_PCM_FRONT_DAC_RATE, rate);
+		s->dacRate = rdcodec(s->codec, AC97_PCM_FRONT_DAC_RATE);
+	}
+}
+
+static int start_dac(struct vr5701_ac97_state *s)
+{
+	struct dmabuf *db = &s->dma_dac;
+	unsigned long flags;
+	u32 dmaLength;
+	u32 temp;
+
+	spin_lock_irqsave(&s->lock, flags);
+
+	if (!db->stopped) {
+		spin_unlock_irqrestore(&s->lock, flags);
+		return -1;
+	}
+
+	/* we should have some data to do the DMA trasnfer */
+	if(db->count < db->fragSize){
+		spin_unlock_irqrestore(&s->lock, flags);
+		return -1;
+	}
+
+	/* clear pending fales interrupts */
+	outl(vr5701_INT_MASK_DAC1END | vr5701_INT_MASK_DAC2END,
+	     s->io + vr5701_INT_CLR);
+
+	/* enable interrupts */
+	temp = inl(s->io + vr5701_INT_MASK);
+	temp |= vr5701_INT_MASK_DAC1END | vr5701_INT_MASK_DAC2END;
+	outl(temp, s->io + vr5701_INT_MASK);
+
+	/* setup dma base addr */
+	outl(db->lbufDma + db->nextOut, s->io + vr5701_DAC1_BADDR);
+	if (s->dacChannels == 1) {
+		outl(db->lbufDma + db->nextOut, s->io + vr5701_DAC2_BADDR);
+	} else {
+		outl(db->rbufDma + db->nextOut, s->io + vr5701_DAC2_BADDR);
+	}
+
+	/* set dma length, in the unit of 0x10 bytes */
+	dmaLength = db->fragSize >> 4;
+	outl(dmaLength, s->io + vr5701_DAC1L);
+	outl(dmaLength, s->io + vr5701_DAC2L);
+
+	/* activate dma */
+	outl(vr5701_DMA_ACTIVATION, s->io + vr5701_DAC1_CTRL);
+	outl(vr5701_DMA_ACTIVATION, s->io + vr5701_DAC2_CTRL);
+
+	/* enable dac slots - we should hear the music now! */
+	temp = inl(s->io + vr5701_CTRL);
+	temp |= (vr5701_CTRL_DAC1ENB | vr5701_CTRL_DAC2ENB);
+	outl(temp, s->io + vr5701_CTRL);
+
+	/* it is time to setup next dma transfer */
+	ASSERT(inl(s->io + vr5701_DAC1_CTRL) & vr5701_DMA_WIP);
+	ASSERT(inl(s->io + vr5701_DAC2_CTRL) & vr5701_DMA_WIP);
+
+	temp = db->nextOut + db->fragSize;
+	if (temp >= db->fragTotalSize) {
+		ASSERT(temp == db->fragTotalSize);
+		temp = 0;
+	}
+
+	outl(db->lbufDma + temp, s->io + vr5701_DAC1_BADDR);
+	if (s->dacChannels == 1) {
+		outl(db->lbufDma + temp, s->io + vr5701_DAC2_BADDR);
+	} else {
+		outl(db->rbufDma + temp, s->io + vr5701_DAC2_BADDR);
+	}
+
+	db->stopped = 0;
+
+#if defined(vr5701_AC97_VERBOSE_DEBUG)
+	outTicket = *(u16 *) (db->lbuf + db->nextOut);
+	if (db->count > db->fragSize) {
+		ASSERT((u16) (outTicket + 1) == *(u16 *) (db->lbuf + temp));
+	}
+#endif
+	spin_unlock_irqrestore(&s->lock, flags);
+	return 0;
+}
+
+static void start_adc(struct vr5701_ac97_state *s)
+{
+	struct dmabuf *db = &s->dma_adc;
+	unsigned long flags;
+	u32 dmaLength;
+	u32 temp;
+
+	spin_lock_irqsave(&s->lock, flags);
+
+	if (!db->stopped) {
+		spin_unlock_irqrestore(&s->lock, flags);
+		return;
+	}
+
+	/* we should at least have some free space in the buffer */
+	ASSERT(db->count < db->fragTotalSize - db->fragSize * 2);
+
+	/* clear pending ones */
+	outl(vr5701_INT_MASK_ADC1END | vr5701_INT_MASK_ADC2END,
+	     s->io + vr5701_INT_CLR);
+
+	/* enable interrupts */
+	temp = inl(s->io + vr5701_INT_MASK);
+	temp |= vr5701_INT_MASK_ADC1END | vr5701_INT_MASK_ADC2END;
+	outl(temp, s->io + vr5701_INT_MASK);
+
+	/* setup dma base addr */
+	outl(db->lbufDma + db->nextIn, s->io + vr5701_ADC1_BADDR);
+	outl(db->rbufDma + db->nextIn, s->io + vr5701_ADC2_BADDR);
+
+	/* setup dma length */
+	dmaLength = db->fragSize >> 4;
+	outl(dmaLength, s->io + vr5701_ADC1L);
+	outl(dmaLength, s->io + vr5701_ADC2L);
+
+	/* activate dma */
+	outl(vr5701_DMA_ACTIVATION, s->io + vr5701_ADC1_CTRL);
+	outl(vr5701_DMA_ACTIVATION, s->io + vr5701_ADC2_CTRL);
+
+	/* enable adc slots */
+	temp = inl(s->io + vr5701_CTRL);
+	temp |= (vr5701_CTRL_ADC1ENB | vr5701_CTRL_ADC2ENB);
+	outl(temp, s->io + vr5701_CTRL);
+
+	/* it is time to setup next dma transfer */
+	temp = db->nextIn + db->fragSize;
+	if (temp >= db->fragTotalSize) {
+		ASSERT(temp == db->fragTotalSize);
+		temp = 0;
+	}
+	outl(db->lbufDma + temp, s->io + vr5701_ADC1_BADDR);
+	outl(db->rbufDma + temp, s->io + vr5701_ADC2_BADDR);
+
+	db->stopped = 0;
+
+	spin_unlock_irqrestore(&s->lock, flags);
+}
+
+/* return the total bytes that is copied */
+static inline int
+copy_dac_from_user(struct vr5701_ac97_state *s,
+		   const char *buffer, size_t count, int avail)
+{
+	struct dmabuf *db = &s->dma_dac;
+	int copyCount = 0;
+	int copyFragCount = 0;
+	int totalCopyCount = 0;
+	int totalCopyFragCount = 0;
+	unsigned long flags;
+#if defined(vr5701_AC97_VERBOSE_DEBUG)
+	int i;
+#endif
+
+	/* adjust count to signel channel byte count */
+	count >>= s->dacChannels - 1;
+
+	/* we may have to "copy" twice as ring buffer wraps around */
+	for (; (avail > 0) && (count > 0);) {
+		/* determine max possible copy count for single channel */
+		copyCount = count;
+		if (copyCount > avail) {
+			copyCount = avail;
+		}
+		if (copyCount + db->nextIn > db->fragTotalSize) {
+			copyCount = db->fragTotalSize - db->nextIn;
+			ASSERT(copyCount > 0);
+		}
+
+		copyFragCount = copyCount;
+		ASSERT(copyFragCount >= copyCount);
+
+		/* we copy differently based on the number channels */
+		if (s->dacChannels == 1) {
+			if (copy_from_user(db->lbuf + db->nextIn,
+					   buffer, copyCount))
+				return -1;
+			/* fill gaps with 0 */
+			memset(db->lbuf + db->nextIn + copyCount,
+			       0, copyFragCount - copyCount);
+		} else {
+			/* we have demux the stream into two separate ones */
+			if (copy_two_channel_dac_from_user
+			    (s, buffer, copyCount))
+				return -1;
+			/* fill gaps with 0 */
+			memset(db->lbuf + db->nextIn + copyCount,
+			       0, copyFragCount - copyCount);
+			memset(db->rbuf + db->nextIn + copyCount,
+			       0, copyFragCount - copyCount);
+		}
+
+#if defined(vr5701_AC97_VERBOSE_DEBUG)
+		for (i = 0; i < copyFragCount; i += db->fragSize) {
+			*(u16 *) (db->lbuf + db->nextIn + i) = inTicket++;
+		}
+#endif
+
+		count -= copyCount;
+		totalCopyCount += copyCount;
+		avail -= copyFragCount;
+		totalCopyFragCount += copyFragCount;
+
+		buffer += copyCount << (s->dacChannels - 1);
+
+		db->nextIn += copyFragCount;
+		if (db->nextIn >= db->fragTotalSize) {
+			ASSERT(db->nextIn == db->fragTotalSize);
+			db->nextIn = 0;
+		}
+
+		ASSERT((count == 0) || (copyCount == copyFragCount));
+	}
+
+	spin_lock_irqsave(&s->lock, flags);
+	db->count += totalCopyFragCount;
+	if (db->stopped) 
+		if(start_dac(s)){
+			spin_unlock_irqrestore(&s->lock, flags);
+			return -1;
+	}
+
+	/* nextIn should not be equal to nextOut unless we are full */
+	if(!(((db->count == db->fragTotalSize) &&
+		(db->nextIn == db->nextOut)) ||
+	       ((db->count < db->fragTotalSize) &&
+		(db->nextIn != db->nextOut)))){
+			spin_unlock_irqrestore(&s->lock, flags);
+			return -1;
+			}
+	spin_unlock_irqrestore(&s->lock, flags);
+
+	return totalCopyCount << (s->dacChannels - 1);
+
+}
+
+static int prog_dmabuf(struct vr5701_ac97_state *s,
+		       struct dmabuf *db, unsigned rate)
+{
+	int order;
+	unsigned bufsize;
+
+	if (!db->lbuf) {
+		ASSERT(!db->rbuf);
+
+		db->ready = 0;
+		for (order = DMABUF_DEFAULTORDER;
+		     order >= DMABUF_MINORDER; order--) {
+			db->lbuf = pci_alloc_consistent(s->dev,
+							PAGE_SIZE << order,
+							&db->lbufDma);
+			db->rbuf = pci_alloc_consistent(s->dev,
+							PAGE_SIZE << order,
+							&db->rbufDma);
+			if (db->lbuf && db->rbuf)
+				break;
+			if (db->lbuf) {
+				ASSERT(!db->rbuf);
+				pci_free_consistent(s->dev,
+						    PAGE_SIZE << order,
+						    db->lbuf, db->lbufDma);
+			}
+		}
+		if (!db->lbuf) {
+			ASSERT(!db->rbuf);
+			return -ENOMEM;
+		}
+
+		db->bufOrder = order;
+	}
+
+	db->count = 0;
+	db->nextIn = db->nextOut = 0;
+
+	bufsize = PAGE_SIZE << db->bufOrder;
+	db->fragShift = ld2(rate * 2 / 100);
+	if (db->fragShift < 4)
+		db->fragShift = 4;
+
+	db->numFrag = bufsize >> db->fragShift;
+	while (db->numFrag < 4 && db->fragShift > 4) {
+		db->fragShift--;
+		db->numFrag = bufsize >> db->fragShift;
+	}
+	db->fragSize = 1 << db->fragShift;
+	db->fragTotalSize = db->numFrag << db->fragShift;
+	memset(db->lbuf, 0, db->fragTotalSize);
+	memset(db->rbuf, 0, db->fragTotalSize);
+
+	db->ready = 1;
+
+	return 0;
+}
+
+static irqreturn_t vr5701_ac97_interrupt(int irq, void *dev_id,
+					 struct pt_regs *regs)
+{
+	struct vr5701_ac97_state *s = (struct vr5701_ac97_state *)dev_id;
+	u32 irqStatus;
+	u32 adcInterrupts, dacInterrupts;
+
+	spin_lock(&s->lock);
+
+	/* get irqStatus and clear the detected ones */
+	irqStatus = inl(s->io + vr5701_INT_STATUS);
+	outl(irqStatus, s->io + vr5701_INT_CLR);
+
+	/* let us see what we get */
+	dacInterrupts = vr5701_INT_MASK_DAC1END | vr5701_INT_MASK_DAC2END;
+	adcInterrupts = vr5701_INT_MASK_ADC1END | vr5701_INT_MASK_ADC2END;
+	if (irqStatus & dacInterrupts) {
+		/* we should get both interrupts, but just in case ...  */
+		if (irqStatus & vr5701_INT_MASK_DAC1END) {
+			vr5701_ac97_dac_interrupt(s);
+		}
+		if ((irqStatus & dacInterrupts) != dacInterrupts) {
+			printk(KERN_WARNING
+			       "vr5701_ac97 : dac interrupts not in sync!!!\n");
+			stop_dac(s);
+			start_dac(s);
+		}
+	} else if (irqStatus & adcInterrupts) {
+		/* we should get both interrupts, but just in case ...  */
+		if (irqStatus & vr5701_INT_MASK_ADC1END) {
+			vr5701_ac97_adc_interrupt(s);
+		}
+		if ((irqStatus & adcInterrupts) != adcInterrupts) {
+			printk(KERN_WARNING
+			       "vr5701_ac97 : adc interrupts not in sync!!!\n");
+			stop_adc(s);
+			start_adc(s);
+		}
+	}
+
+	spin_unlock(&s->lock);
+	return IRQ_HANDLED;
+}
+
+static int vr5701_ac97_open_mixdev(struct inode *inode, struct file *file)
+{
+	int minor = iminor(inode);
+	struct list_head *list;
+	struct vr5701_ac97_state *s;
+
+	for (list = devs.next;; list = list->next) {
+		if (list == &devs)
+			return -ENODEV;
+		s = list_entry(list, struct vr5701_ac97_state, devs);
+		if (s->codec->dev_mixer == minor)
+			break;
+	}
+	file->private_data = s;
+	return nonseekable_open(inode, file);
+}
+
+static int vr5701_ac97_release_mixdev(struct inode *inode, struct file *file)
+{
+	return 0;
+}
+
+static int mixdev_ioctl(struct ac97_codec *codec, unsigned int cmd,
+			unsigned long arg)
+{
+	return codec->mixer_ioctl(codec, cmd, arg);
+}
+
+static int vr5701_ac97_ioctl_mixdev(struct inode *inode, struct file *file,
+				    unsigned int cmd, unsigned long arg)
+{
+	struct vr5701_ac97_state *s =
+	    (struct vr5701_ac97_state *)file->private_data;
+	struct ac97_codec *codec = s->codec;
+
+	return mixdev_ioctl(codec, cmd, arg);
+}
+
+static struct file_operations vr5701_ac97_mixer_fops = {
+	.owner = THIS_MODULE,
+	.llseek = no_llseek,
+	.ioctl = vr5701_ac97_ioctl_mixdev,
+	.open = vr5701_ac97_open_mixdev,
+	.release = vr5701_ac97_release_mixdev,
+};
+
+static int drain_dac(struct vr5701_ac97_state *s, int nonblock)
+{
+	unsigned long flags;
+	int count, tmo;
+
+	if (!s->dma_dac.ready)
+		return 0;
+
+	for (;;) {
+		spin_lock_irqsave(&s->lock, flags);
+		count = s->dma_dac.count;
+		spin_unlock_irqrestore(&s->lock, flags);
+		if (count <= 0)
+			break;
+		if (signal_pending(current))
+			break;
+		if (nonblock)
+			return -EBUSY;
+		tmo = 1000 * count / s->dacRate / 2;
+		vr5701_ac97_delay(tmo);
+	}
+	if (signal_pending(current))
+		return -ERESTARTSYS;
+	return 0;
+}
+
+static ssize_t
+vr5701_ac97_read(struct file *file, char *buffer, size_t count, loff_t * ppos)
+{
+	struct vr5701_ac97_state *s =
+	    (struct vr5701_ac97_state *)file->private_data;
+	struct dmabuf *db = &s->dma_adc;
+	ssize_t ret = 0;
+	unsigned long flags;
+	int copyCount;
+	size_t avail;
+
+	if (!access_ok(VERIFY_WRITE, buffer, count))
+		return -EFAULT;
+
+	ASSERT(db->ready);
+
+	while (count > 0) {
+		do {
+			spin_lock_irqsave(&s->lock, flags);
+			if (db->stopped)
+				start_adc(s);
+			avail = db->count;
+			spin_unlock_irqrestore(&s->lock, flags);
+			if (avail <= 0) {
+				if (file->f_flags & O_NONBLOCK) {
+					if (!ret)
+						ret = -EAGAIN;
+					return ret;
+				}
+				interruptible_sleep_on(&db->wait);
+				if (signal_pending(current)) {
+					if (!ret)
+						ret = -ERESTARTSYS;
+					return ret;
+				}
+			}
+		} while (avail <= 0);
+
+		ASSERT((avail % db->fragSize) == 0);
+		copyCount = copy_adc_to_user(s, buffer, count, avail);
+		if (copyCount <= 0) {
+			if (!ret)
+				ret = -EFAULT;
+			return ret;
+		}
+
+		count -= copyCount;
+		buffer += copyCount;
+		ret += copyCount;
+	}
+
+	return ret;
+}
+
+static ssize_t vr5701_ac97_write(struct file *file, const char *buffer,
+				 size_t count, loff_t * ppos)
+{
+	struct vr5701_ac97_state *s =
+	    (struct vr5701_ac97_state *)file->private_data;
+	struct dmabuf *db = &s->dma_dac;
+	ssize_t ret;
+	unsigned long flags;
+	int copyCount, avail;
+
+	if (!access_ok(VERIFY_READ, buffer, count))
+		return -EFAULT;
+	ret = 0;
+
+	while (count > 0) {
+		do {
+			spin_lock_irqsave(&s->lock, flags);
+			avail = db->fragTotalSize - db->count;
+			spin_unlock_irqrestore(&s->lock, flags);
+			if (avail <= 0) {
+				if (file->f_flags & O_NONBLOCK) {
+					if (!ret)
+						ret = -EAGAIN;
+					return ret;
+				}
+				interruptible_sleep_on(&db->wait);
+				if (signal_pending(current)) {
+					if (!ret)
+						ret = -ERESTARTSYS;
+					return ret;
+				}
+			}
+		} while (avail <= 0);
+
+		copyCount = copy_dac_from_user(s, buffer, count, avail);
+		if (copyCount < 0) {
+			if (!ret)
+				ret = -EFAULT;
+			stop_dac(s);
+			synchronize_irq(s->irq);
+			s->dma_dac.count = 0;
+			s->dma_dac.nextIn = s->dma_dac.nextOut = 0;
+			return ret;
+		}
+
+		count -= copyCount;
+		buffer += copyCount;
+		ret += copyCount;
+	}
+
+	return ret;
+}
+
+/* No kernel lock - we have our own spinlock */
+static unsigned int vr5701_ac97_poll(struct file *file,
+				     struct poll_table_struct *wait)
+{
+	struct vr5701_ac97_state *s =
+	    (struct vr5701_ac97_state *)file->private_data;
+	unsigned long flags;
+	unsigned int mask = 0;
+
+	if (file->f_mode & FMODE_WRITE)
+		poll_wait(file, &s->dma_dac.wait, wait);
+	if (file->f_mode & FMODE_READ)
+		poll_wait(file, &s->dma_adc.wait, wait);
+	spin_lock_irqsave(&s->lock, flags);
+	if (file->f_mode & FMODE_READ) {
+		if (s->dma_adc.count >= (signed)s->dma_adc.fragSize)
+			mask |= POLLIN | POLLRDNORM;
+	}
+	if (file->f_mode & FMODE_WRITE) {
+		if ((signed)s->dma_dac.fragTotalSize >=
+		    s->dma_dac.count + (signed)s->dma_dac.fragSize)
+			mask |= POLLOUT | POLLWRNORM;
+	}
+	spin_unlock_irqrestore(&s->lock, flags);
+	return mask;
+}
+
+#ifdef vr5701_AC97_DEBUG
+static struct ioctl_str_t {
+	unsigned int cmd;
+	const char *str;
+} ioctl_str[] = {
+	{
+	SNDCTL_DSP_RESET, "SNDCTL_DSP_RESET"}, {
+	SNDCTL_DSP_SYNC, "SNDCTL_DSP_SYNC"}, {
+	SNDCTL_DSP_SPEED, "SNDCTL_DSP_SPEED"}, {
+	SNDCTL_DSP_STEREO, "SNDCTL_DSP_STEREO"}, {
+	SNDCTL_DSP_GETBLKSIZE, "SNDCTL_DSP_GETBLKSIZE"}, {
+	SNDCTL_DSP_SETFMT, "SNDCTL_DSP_SETFMT"}, {
+	SNDCTL_DSP_SAMPLESIZE, "SNDCTL_DSP_SAMPLESIZE"}, {
+	SNDCTL_DSP_CHANNELS, "SNDCTL_DSP_CHANNELS"}, {
+	SOUND_PCM_WRITE_CHANNELS, "SOUND_PCM_WRITE_CHANNELS"}, {
+	SOUND_PCM_WRITE_FILTER, "SOUND_PCM_WRITE_FILTER"}, {
+	SNDCTL_DSP_POST, "SNDCTL_DSP_POST"}, {
+	SNDCTL_DSP_SUBDIVIDE, "SNDCTL_DSP_SUBDIVIDE"}, {
+	SNDCTL_DSP_SETFRAGMENT, "SNDCTL_DSP_SETFRAGMENT"}, {
+	SNDCTL_DSP_GETFMTS, "SNDCTL_DSP_GETFMTS"}, {
+	SNDCTL_DSP_GETOSPACE, "SNDCTL_DSP_GETOSPACE"}, {
+	SNDCTL_DSP_GETISPACE, "SNDCTL_DSP_GETISPACE"}, {
+	SNDCTL_DSP_NONBLOCK, "SNDCTL_DSP_NONBLOCK"}, {
+	SNDCTL_DSP_GETCAPS, "SNDCTL_DSP_GETCAPS"}, {
+	SNDCTL_DSP_GETTRIGGER, "SNDCTL_DSP_GETTRIGGER"}, {
+	SNDCTL_DSP_SETTRIGGER, "SNDCTL_DSP_SETTRIGGER"}, {
+	SNDCTL_DSP_GETIPTR, "SNDCTL_DSP_GETIPTR"}, {
+	SNDCTL_DSP_GETOPTR, "SNDCTL_DSP_GETOPTR"}, {
+	SNDCTL_DSP_MAPINBUF, "SNDCTL_DSP_MAPINBUF"}, {
+	SNDCTL_DSP_MAPOUTBUF, "SNDCTL_DSP_MAPOUTBUF"}, {
+	SNDCTL_DSP_SETSYNCRO, "SNDCTL_DSP_SETSYNCRO"}, {
+	SNDCTL_DSP_SETDUPLEX, "SNDCTL_DSP_SETDUPLEX"}, {
+	SNDCTL_DSP_GETODELAY, "SNDCTL_DSP_GETODELAY"}, {
+	SNDCTL_DSP_GETCHANNELMASK, "SNDCTL_DSP_GETCHANNELMASK"}, {
+	SNDCTL_DSP_BIND_CHANNEL, "SNDCTL_DSP_BIND_CHANNEL"}, {
+	OSS_GETVERSION, "OSS_GETVERSION"}, {
+	SOUND_PCM_READ_RATE, "SOUND_PCM_READ_RATE"}, {
+	SOUND_PCM_READ_CHANNELS, "SOUND_PCM_READ_CHANNELS"}, {
+	SOUND_PCM_READ_BITS, "SOUND_PCM_READ_BITS"}, {
+	SOUND_PCM_READ_FILTER, "SOUND_PCM_READ_FILTER"}
+};
+#endif
+
+static int vr5701_ac97_ioctl(struct inode *inode, struct file *file,
+			     unsigned int cmd, unsigned long arg)
+{
+	struct vr5701_ac97_state *s =
+	    (struct vr5701_ac97_state *)file->private_data;
+	unsigned long flags;
+	audio_buf_info abinfo;
+	int count;
+	int val, ret;
+
+#ifdef vr5701_AC97_DEBUG
+	for (count = 0; count < sizeof(ioctl_str) / sizeof(ioctl_str[0]);
+	     count++) {
+		if (ioctl_str[count].cmd == cmd)
+			break;
+	}
+	if (count < sizeof(ioctl_str) / sizeof(ioctl_str[0]))
+		printk(KERN_INFO PFX "ioctl %s\n", ioctl_str[count].str);
+	else
+		printk(KERN_INFO PFX "ioctl unknown, 0x%x\n", cmd);
+#endif
+
+	switch (cmd) {
+	case OSS_GETVERSION:
+		return put_user(SOUND_VERSION, (int *)arg);
+
+	case SNDCTL_DSP_SYNC:
+		if (file->f_mode & FMODE_WRITE)
+			return drain_dac(s, file->f_flags & O_NONBLOCK);
+		return 0;
+
+	case SNDCTL_DSP_SETDUPLEX:
+		return 0;
+
+	case SNDCTL_DSP_GETCAPS:
+		return put_user(DSP_CAP_DUPLEX, (int *)arg);
+
+	case SNDCTL_DSP_RESET:
+		if (file->f_mode & FMODE_WRITE) {
+			stop_dac(s);
+			synchronize_irq(s->irq);
+			s->dma_dac.count = 0;
+			s->dma_dac.nextIn = s->dma_dac.nextOut = 0;
+		}
+		if (file->f_mode & FMODE_READ) {
+			stop_adc(s);
+			synchronize_irq(s->irq);
+			s->dma_adc.count = 0;
+			s->dma_adc.nextIn = s->dma_adc.nextOut = 0;
+		}
+		return 0;
+
+	case SNDCTL_DSP_SPEED:
+		if (get_user(val, (int *)arg))
+			return -EFAULT;
+		if (val >= 0) {
+			if (file->f_mode & FMODE_READ) {
+				stop_adc(s);
+				set_adc_rate(s, val);
+				if ((ret = prog_dmabuf_adc(s)))
+					return ret;
+			}
+			if (file->f_mode & FMODE_WRITE) {
+				stop_dac(s);
+				set_dac_rate(s, val);
+				if ((ret = prog_dmabuf_dac(s)))
+					return ret;
+			}
+		}
+		return put_user((file->f_mode & FMODE_READ) ?
+				s->adcRate : s->dacRate, (int *)arg);
+
+	case SNDCTL_DSP_STEREO:
+		if (get_user(val, (int *)arg))
+			return -EFAULT;
+		if (file->f_mode & FMODE_READ) {
+			stop_adc(s);
+			if (val)
+				s->adcChannels = 2;
+			else
+				s->adcChannels = 1;
+			if ((ret = prog_dmabuf_adc(s)))
+				return ret;
+		}
+		if (file->f_mode & FMODE_WRITE) {
+			stop_dac(s);
+			if (val)
+				s->dacChannels = 2;
+			else
+				s->dacChannels = 1;
+			if ((ret = prog_dmabuf_dac(s)))
+				return ret;
+		}
+		return 0;
+
+	case SNDCTL_DSP_CHANNELS:
+		if (get_user(val, (int *)arg))
+			return -EFAULT;
+		if (val != 0) {
+			if ((val != 1) && (val != 2))
+				val = 2;
+
+			if (file->f_mode & FMODE_READ) {
+				stop_adc(s);
+				s->dacChannels = val;
+				if ((ret = prog_dmabuf_adc(s)))
+					return ret;
+			}
+			if (file->f_mode & FMODE_WRITE) {
+				stop_dac(s);
+				s->dacChannels = val;
+				if ((ret = prog_dmabuf_dac(s)))
+					return ret;
+			}
+		}
+		return put_user(val, (int *)arg);
+
+	case SNDCTL_DSP_GETFMTS:	/* Returns a mask */
+		return put_user(AFMT_S16_LE, (int *)arg);
+
+	case SNDCTL_DSP_SETFMT:	/* Selects ONE fmt */
+		if (get_user(val, (int *)arg))
+			return -EFAULT;
+		if (val != AFMT_QUERY) {
+			if (val != AFMT_S16_LE)
+				return -EINVAL;
+			if (file->f_mode & FMODE_READ) {
+				stop_adc(s);
+				if ((ret = prog_dmabuf_adc(s)))
+					return ret;
+			}
+			if (file->f_mode & FMODE_WRITE) {
+				stop_dac(s);
+				if ((ret = prog_dmabuf_dac(s)))
+					return ret;
+			}
+		} else {
+			val = AFMT_S16_LE;
+		}
+		return put_user(val, (int *)arg);
+
+	case SNDCTL_DSP_POST:
+		return 0;
+
+	case SNDCTL_DSP_GETTRIGGER:
+	case SNDCTL_DSP_SETTRIGGER:
+		/* NO trigger */
+		return -EINVAL;
+
+	case SNDCTL_DSP_GETOSPACE:
+		if (!(file->f_mode & FMODE_WRITE))
+			return -EINVAL;
+		abinfo.fragsize = s->dma_dac.fragSize << (s->dacChannels - 1);
+		spin_lock_irqsave(&s->lock, flags);
+		count = s->dma_dac.count;
+		spin_unlock_irqrestore(&s->lock, flags);
+		abinfo.bytes = (s->dma_dac.fragTotalSize - count) <<
+		    (s->dacChannels - 1);
+		abinfo.fragstotal = s->dma_dac.numFrag;
+		abinfo.fragments = abinfo.bytes >> s->dma_dac.fragShift >>
+		    (s->dacChannels - 1);
+		return copy_to_user((void *)arg, &abinfo,
+				    sizeof(abinfo)) ? -EFAULT : 0;
+
+	case SNDCTL_DSP_GETISPACE:
+		if (!(file->f_mode & FMODE_READ))
+			return -EINVAL;
+		abinfo.fragsize = s->dma_adc.fragSize << (s->adcChannels - 1);
+		spin_lock_irqsave(&s->lock, flags);
+		count = s->dma_adc.count;
+		spin_unlock_irqrestore(&s->lock, flags);
+		if (count < 0)
+			count = 0;
+		abinfo.bytes = count << (s->adcChannels - 1);
+		abinfo.fragstotal = s->dma_adc.numFrag;
+		abinfo.fragments = (abinfo.bytes >> s->dma_adc.fragShift) >>
+		    (s->adcChannels - 1);
+		return copy_to_user((void *)arg, &abinfo,
+				    sizeof(abinfo)) ? -EFAULT : 0;
+
+	case SNDCTL_DSP_NONBLOCK:
+		file->f_flags |= O_NONBLOCK;
+		return 0;
+
+	case SNDCTL_DSP_GETODELAY:
+		if (!(file->f_mode & FMODE_WRITE))
+			return -EINVAL;
+		spin_lock_irqsave(&s->lock, flags);
+		count = s->dma_dac.count;
+		spin_unlock_irqrestore(&s->lock, flags);
+		return put_user(count, (int *)arg);
+
+	case SNDCTL_DSP_GETIPTR:
+	case SNDCTL_DSP_GETOPTR:
+		/* we cannot get DMA ptr */
+		return -EINVAL;
+
+	case SNDCTL_DSP_GETBLKSIZE:
+		if (file->f_mode & FMODE_WRITE)
+			return put_user(s->dma_dac.
+					fragSize << (s->dacChannels - 1),
+					(int *)arg);
+		else
+			return put_user(s->dma_adc.
+					fragSize << (s->adcChannels - 1),
+					(int *)arg);
+
+	case SNDCTL_DSP_SETFRAGMENT:
+		/* we ignore fragment size request */
+		return 0;
+
+	case SNDCTL_DSP_SUBDIVIDE:
+		/* what is this for? [jsun] */
+		return 0;
+
+	case SOUND_PCM_READ_RATE:
+		return put_user((file->f_mode & FMODE_READ) ?
+				s->adcRate : s->dacRate, (int *)arg);
+
+	case SOUND_PCM_READ_CHANNELS:
+		if (file->f_mode & FMODE_READ)
+			return put_user(s->adcChannels, (int *)arg);
+		else
+			return put_user(s->dacChannels ? 2 : 1, (int *)arg);
+
+	case SOUND_PCM_READ_BITS:
+		return put_user(16, (int *)arg);
+
+	case SOUND_PCM_WRITE_FILTER:
+	case SNDCTL_DSP_SETSYNCRO:
+	case SOUND_PCM_READ_FILTER:
+		return -EINVAL;
+	}
+
+	return mixdev_ioctl(s->codec, cmd, arg);
+}
+
+static int vr5701_ac97_open(struct inode *inode, struct file *file)
+{
+	int minor = iminor(inode);
+	DECLARE_WAITQUEUE(wait, current);
+	unsigned long flags;
+	struct list_head *list;
+	struct vr5701_ac97_state *s;
+	int ret = 0;
+
+	nonseekable_open(inode, file);
+	for (list = devs.next;; list = list->next) {
+		if (list == &devs)
+			return -ENODEV;
+		s = list_entry(list, struct vr5701_ac97_state, devs);
+		if (!((s->dev_audio ^ minor) & ~0xf))
+			break;
+	}
+	file->private_data = s;
+
+	/* wait for device to become free */
+	down(&s->open_sem);
+	while (s->open_mode & file->f_mode) {
+
+		if (file->f_flags & O_NONBLOCK) {
+			up(&s->open_sem);
+			return -EBUSY;
+		}
+		add_wait_queue(&s->open_wait, &wait);
+		__set_current_state(TASK_INTERRUPTIBLE);
+		up(&s->open_sem);
+		schedule();
+		remove_wait_queue(&s->open_wait, &wait);
+		set_current_state(TASK_RUNNING);
+		if (signal_pending(current))
+			return -ERESTARTSYS;
+		down(&s->open_sem);
+	}
+
+	spin_lock_irqsave(&s->lock, flags);
+
+	if (file->f_mode & FMODE_READ) {
+		/* set default settings */
+		set_adc_rate(s, 48000);
+		s->adcChannels = 2;
+
+		ret = prog_dmabuf_adc(s);
+		if (ret)
+			goto bailout;
+	}
+	if (file->f_mode & FMODE_WRITE) {
+		/* set default settings */
+		set_dac_rate(s, 48000);
+		s->dacChannels = 2;
+
+		ret = prog_dmabuf_dac(s);
+		if (ret)
+			goto bailout;
+	}
+
+	s->open_mode |= file->f_mode & (FMODE_READ | FMODE_WRITE);
+
+      bailout:
+	spin_unlock_irqrestore(&s->lock, flags);
+
+	up(&s->open_sem);
+	return ret;
+}
+
+static int vr5701_ac97_release(struct inode *inode, struct file *file)
+{
+	struct vr5701_ac97_state *s =
+	    (struct vr5701_ac97_state *)file->private_data;
+
+	lock_kernel();
+	if (file->f_mode & FMODE_WRITE)
+		drain_dac(s, file->f_flags & O_NONBLOCK);
+	down(&s->open_sem);
+	if (file->f_mode & FMODE_WRITE) {
+		stop_dac(s);
+		dealloc_dmabuf(s, &s->dma_dac);
+	}
+	if (file->f_mode & FMODE_READ) {
+		stop_adc(s);
+		dealloc_dmabuf(s, &s->dma_adc);
+	}
+	s->open_mode &= (~file->f_mode) & (FMODE_READ | FMODE_WRITE);
+	up(&s->open_sem);
+	wake_up(&s->open_wait);
+	unlock_kernel();
+	return 0;
+}
+
+static struct file_operations vr5701_ac97_audio_fops = {
+	.owner = THIS_MODULE,
+	.llseek = no_llseek,
+	.read = vr5701_ac97_read,
+	.write = vr5701_ac97_write,
+	.poll = vr5701_ac97_poll,
+	.ioctl = vr5701_ac97_ioctl,
+	.open = vr5701_ac97_open,
+	.release = vr5701_ac97_release,
+};
+
+/*
+ * for debugging purposes, we'll create a proc device that dumps the
+ * CODEC chipstate
+ */
+
+#ifdef vr5701_AC97_DEBUG
+
+struct {
+	const char *regname;
+	unsigned regaddr;
+} vr5701_ac97_regs[] = {
+	{
+	"vr5701_INT_STATUS", vr5701_INT_STATUS}, {
+	"vr5701_CODEC_WR", vr5701_CODEC_WR}, {
+	"vr5701_CODEC_RD", vr5701_CODEC_RD}, {
+	"vr5701_CTRL", vr5701_CTRL}, {
+	"vr5701_ACLINK_CTRL", vr5701_ACLINK_CTRL}, {
+	"vr5701_INT_MASK", vr5701_INT_MASK}, {
+	"vr5701_DAC1_CTRL", vr5701_DAC1_CTRL}, {
+	"vr5701_DAC1L", vr5701_DAC1L}, {
+	"vr5701_DAC1_BADDR", vr5701_DAC1_BADDR}, {
+	"vr5701_DAC2_CTRL", vr5701_DAC2_CTRL}, {
+	"vr5701_DAC2L", vr5701_DAC2L}, {
+	"vr5701_DAC2_BADDR", vr5701_DAC2_BADDR}, {
+	"vr5701_DAC3_CTRL", vr5701_DAC3_CTRL}, {
+	"vr5701_DAC3L", vr5701_DAC3L}, {
+	"vr5701_DAC3_BADDR", vr5701_DAC3_BADDR}, {
+	"vr5701_ADC1_CTRL", vr5701_ADC1_CTRL}, {
+	"vr5701_ADC1L", vr5701_ADC1L}, {
+	"vr5701_ADC1_BADDR", vr5701_ADC1_BADDR}, {
+	"vr5701_ADC2_CTRL", vr5701_ADC2_CTRL}, {
+	"vr5701_ADC2L", vr5701_ADC2L}, {
+	"vr5701_ADC2_BADDR", vr5701_ADC2_BADDR}, {
+	"vr5701_ADC3_CTRL", vr5701_ADC3_CTRL}, {
+	"vr5701_ADC3L", vr5701_ADC3L}, {
+	"vr5701_ADC3_BADDR", vr5701_ADC3_BADDR}, {
+	NULL, 0x0}
+};
+
+static int proc_vr5701_ac97_dump(char *buf, char **start, off_t fpos,
+				 int length, int *eof, void *data)
+{
+	struct vr5701_ac97_state *s;
+	int cnt, len = 0;
+
+	if (list_empty(&devs))
+		return 0;
+	s = list_entry(devs.next, struct vr5701_ac97_state, devs);
+
+	/* print out header */
+	len += sprintf(buf + len, "\n\t\tvr5701 Audio Debug\n\n");
+
+	len += sprintf(buf + len, "NEC Electronics Corporation VR5701 SolutionGearII Audio Controller registers\n");
+	len += sprintf(buf + len, "---------------------------------\n");
+	for (cnt = 0; vr5701_ac97_regs[cnt].regname != NULL; cnt++) {
+		len += sprintf(buf + len, "%-20s = %08x\n",
+			       vr5701_ac97_regs[cnt].regname,
+			       inl(s->io + vr5701_ac97_regs[cnt].regaddr));
+	}
+
+	/* print out driver state */
+	len += sprintf(buf + len, "NEC Electronics Corporation VR5701 SolutionGearII Audio driver states\n");
+	len += sprintf(buf + len, "---------------------------------\n");
+	len += sprintf(buf + len, "dacChannels  = %d\n", s->dacChannels);
+	len += sprintf(buf + len, "adcChannels  = %d\n", s->adcChannels);
+	len += sprintf(buf + len, "dacRate  = %d\n", s->dacRate);
+	len += sprintf(buf + len, "adcRate  = %d\n", s->adcRate);
+
+	len += sprintf(buf + len, "dma_dac is %s ready\n",
+		       s->dma_dac.ready ? "" : "not");
+	if (s->dma_dac.ready) {
+		len += sprintf(buf + len, "dma_dac is %s stopped.\n",
+			       s->dma_dac.stopped ? "" : "not");
+		len += sprintf(buf + len, "dma_dac.fragSize = %x\n",
+			       s->dma_dac.fragSize);
+		len += sprintf(buf + len, "dma_dac.fragShift = %x\n",
+			       s->dma_dac.fragShift);
+		len += sprintf(buf + len, "dma_dac.numFrag = %x\n",
+			       s->dma_dac.numFrag);
+		len += sprintf(buf + len, "dma_dac.fragTotalSize = %x\n",
+			       s->dma_dac.fragTotalSize);
+		len += sprintf(buf + len, "dma_dac.nextIn = %x\n",
+			       s->dma_dac.nextIn);
+		len += sprintf(buf + len, "dma_dac.nextOut = %x\n",
+			       s->dma_dac.nextOut);
+		len += sprintf(buf + len, "dma_dac.count = %x\n",
+			       s->dma_dac.count);
+	}
+
+	len += sprintf(buf + len, "dma_adc is %s ready\n",
+		       s->dma_adc.ready ? "" : "not");
+	if (s->dma_adc.ready) {
+		len += sprintf(buf + len, "dma_adc is %s stopped.\n",
+			       s->dma_adc.stopped ? "" : "not");
+		len += sprintf(buf + len, "dma_adc.fragSize = %x\n",
+			       s->dma_adc.fragSize);
+		len += sprintf(buf + len, "dma_adc.fragShift = %x\n",
+			       s->dma_adc.fragShift);
+		len += sprintf(buf + len, "dma_adc.numFrag = %x\n",
+			       s->dma_adc.numFrag);
+		len += sprintf(buf + len, "dma_adc.fragTotalSize = %x\n",
+			       s->dma_adc.fragTotalSize);
+		len += sprintf(buf + len, "dma_adc.nextIn = %x\n",
+			       s->dma_adc.nextIn);
+		len += sprintf(buf + len, "dma_adc.nextOut = %x\n",
+			       s->dma_adc.nextOut);
+		len += sprintf(buf + len, "dma_adc.count = %x\n",
+			       s->dma_adc.count);
+	}
+
+	/* print out CODEC state */
+	len += sprintf(buf + len, "\nAC97 CODEC registers\n");
+	len += sprintf(buf + len, "----------------------\n");
+	for (cnt = 0; cnt <= 0x7e; cnt = cnt + 2)
+		len += sprintf(buf + len, "reg %02x = %04x\n",
+			       cnt, rdcodec(s->codec, cnt));
+
+	if (fpos >= len) {
+		*start = buf;
+		*eof = 1;
+		return 0;
+	}
+	*start = buf + fpos;
+	if ((len -= fpos) > length)
+		return length;
+	*eof = 1;
+	return len;
+
+}
+#endif				/* vr5701_AC97_DEBUG */
+
+static unsigned int devindex;
+
+MODULE_AUTHOR("Sergey Podstavin");
+MODULE_DESCRIPTION("NEC Electronics Corporation VR5701 SolutionGearII audio (AC97) Driver");
+MODULE_LICENSE("GPL");
+
+static int __devinit vr5701_ac97_probe(struct pci_dev *pcidev,
+				       const struct pci_device_id *pciid)
+{
+	struct vr5701_ac97_state *s;
+#ifdef vr5701_AC97_DEBUG
+	char proc_str[80];
+#endif
+
+	if (pcidev->irq == 0)
+		return -1;
+
+	if (!(s = kmalloc(sizeof(struct vr5701_ac97_state), GFP_KERNEL))) {
+		printk(KERN_ERR PFX "alloc of device struct failed\n");
+		return -1;
+	}
+	memset(s, 0, sizeof(struct vr5701_ac97_state));
+
+	init_waitqueue_head(&s->dma_adc.wait);
+	init_waitqueue_head(&s->dma_dac.wait);
+	init_waitqueue_head(&s->open_wait);
+	init_MUTEX(&s->open_sem);
+	spin_lock_init(&s->lock);
+
+	s->dev = pcidev;
+	s->io = pci_resource_start(pcidev, 0);
+	s->irq = pcidev->irq;
+
+	s->codec = ac97_alloc_codec();
+
+	s->codec->private_data = s;
+	s->codec->id = 0;
+	s->codec->codec_read = rdcodec;
+	s->codec->codec_write = wrcodec;
+	s->codec->codec_wait = waitcodec;
+
+	/* setting some other default values such as
+	 * adcChannels, adcRate is done in open() so that
+	 * no persistent state across file opens.
+	 */
+
+	if (!request_region(s->io, pci_resource_len(pcidev, 0),
+			    vr5701_AC97_MODULE_NAME)) {
+		printk(KERN_ERR PFX "io ports %#lx->%#lx in use\n",
+		       s->io, s->io + pci_resource_len(pcidev, 0) - 1);
+		goto err_region;
+	}
+	if (request_irq(s->irq, vr5701_ac97_interrupt, SA_INTERRUPT,
+			vr5701_AC97_MODULE_NAME, s)) {
+		printk(KERN_ERR PFX "irq %u in use\n", s->irq);
+		goto err_irq;
+	}
+
+	printk(KERN_INFO PFX "IO at %#lx, IRQ %d\n", s->io, s->irq);
+
+	/* register devices */
+	if ((s->dev_audio =
+	     register_sound_dsp(&vr5701_ac97_audio_fops, -1)) < 0)
+		goto err_dev1;
+	if ((s->codec->dev_mixer =
+	     register_sound_mixer(&vr5701_ac97_mixer_fops, -1)) < 0)
+		goto err_dev2;
+
+#ifdef vr5701_AC97_DEBUG
+	/* initialize the debug proc device */
+	s->ps = create_proc_read_entry(vr5701_AC97_MODULE_NAME, 0, NULL,
+				       proc_vr5701_ac97_dump, NULL);
+#endif				/* vr5701_AC97_DEBUG */
+
+	/* enable pci io and bus mastering */
+	if (pci_enable_device(pcidev))
+		goto err_dev3;
+	pci_set_master(pcidev);
+
+	/* cold reset the AC97 */
+	outl(vr5701_ACLINK_CTRL_RST_ON | vr5701_ACLINK_CTRL_RST_TIME,
+	     s->io + vr5701_ACLINK_CTRL);
+	while (inl(s->io + vr5701_ACLINK_CTRL) & vr5701_ACLINK_CTRL_RST_ON) ;
+
+	/* codec init */
+	if (!ac97_probe_codec(s->codec))
+		goto err_dev3;
+
+#ifdef vr5701_AC97_DEBUG
+	sprintf(proc_str, "driver/%s/%d/ac97",
+		vr5701_AC97_MODULE_NAME, s->codec->id);
+	s->ac97_ps = create_proc_read_entry(proc_str, 0, NULL,
+					    ac97_read_proc, s->codec);
+	/* TODO : why this proc file does not show up? */
+#endif
+
+	/* Try to enable variable rate audio mode. */
+	wrcodec(s->codec, AC97_EXTENDED_STATUS,
+		rdcodec(s->codec, AC97_EXTENDED_STATUS) | AC97_EXTSTAT_VRA);
+	/* Did we enable it? */
+	if (rdcodec(s->codec, AC97_EXTENDED_STATUS) & AC97_EXTSTAT_VRA)
+		s->extended_status |= AC97_EXTSTAT_VRA;
+	else {
+		s->dacRate = 48000;
+		printk(KERN_INFO PFX "VRA mode not enabled; rate fixed at %d.",
+		       s->dacRate);
+	}
+
+	/* let us get the default volumne louder */
+	wrcodec(s->codec, 0x2, 0x1010);	/* master volume, middle */
+	wrcodec(s->codec, 0xc, 0x10);	/* phone volume, middle */
+	wrcodec(s->codec, 0x10, 0x8000);	/* line-in 2 line-out disable */
+	wrcodec(s->codec, 0x18, 0x0707);	/* PCM out (line out) middle */
+
+	/* by default we select line in the input */
+	wrcodec(s->codec, 0xe, 0x10);	/* misc volume, middle */
+	wrcodec(s->codec, 0x1a, 0x0000);	/* default line is Line_mic */
+	/*	wrcodec(s->codec, 0x1a, 0x0404); *//* default line is Line_in */
+	wrcodec(s->codec, 0x1c, 0x0f0f);
+	wrcodec(s->codec, 0x1e, 0x07);
+
+	/* enable the master interrupt but disable all others */
+	outl(vr5701_INT_MASK_NMASK, s->io + vr5701_INT_MASK);
+
+	/* store it in the driver field */
+	pci_set_drvdata(pcidev, s);
+	pcidev->dma_mask = 0xffffffff;
+	/* put it into driver list */
+	list_add_tail(&s->devs, &devs);
+	/* increment devindex */
+	if (devindex < NR_DEVICE - 1)
+		devindex++;
+	return 0;
+
+      err_dev3:
+	unregister_sound_mixer(s->codec->dev_mixer);
+      err_dev2:
+	unregister_sound_dsp(s->dev_audio);
+      err_dev1:
+	printk(KERN_ERR PFX "cannot register misc device\n");
+	free_irq(s->irq, s);
+
+      err_irq:
+	release_region(s->io, pci_resource_len(pcidev, 0));
+      err_region:
+	ac97_release_codec(s->codec);
+	kfree(s);
+	return -1;
+}
+
+static void __devexit vr5701_ac97_remove(struct pci_dev *dev)
+{
+	struct vr5701_ac97_state *s = pci_get_drvdata(dev);
+
+	if (!s)
+		return;
+	list_del(&s->devs);
+
+#ifdef vr5701_AC97_DEBUG
+	if (s->ps)
+		remove_proc_entry(vr5701_AC97_MODULE_NAME, NULL);
+#endif				/* vr5701_AC97_DEBUG */
+
+	synchronize_irq();
+	free_irq(s->irq, s);
+	release_region(s->io, pci_resource_len(dev, 0));
+	unregister_sound_dsp(s->dev_audio);
+	unregister_sound_mixer(s->codec->dev_mixer);
+	ac97_release_codec(s->codec);
+	kfree(s);
+	pci_set_drvdata(dev, NULL);
+}
+
+static struct pci_device_id id_table[] = {
+	{PCI_VENDOR_ID_NEC, PCI_DEVICE_ID_NEC_VRC5477_AC97,
+	 PCI_ANY_ID, PCI_ANY_ID, 0, 0},
+	{0,}
+};
+
+MODULE_DEVICE_TABLE(pci, id_table);
+
+static struct pci_driver vr5701_ac97_driver = {
+	.name = vr5701_AC97_MODULE_NAME,
+	.id_table = id_table,
+	.probe = vr5701_ac97_probe,
+	.remove = __devexit_p(vr5701_ac97_remove)
+};
+
+static int __init init_vr5701_ac97(void)
+{
+	printk(KERN_INFO "NEC Electronics Corporation VR5701 SolutionGearII AC97 driver: time " __TIME__ " " __DATE__
+	       " by Sergey Podstavin\n");
+	return pci_module_init(&vr5701_ac97_driver);
+}
+
+static void __exit cleanup_vr5701_ac97(void)
+{
+	printk(KERN_INFO PFX "unloading\n");
+	pci_unregister_driver(&vr5701_ac97_driver);
+}
+
+module_init(init_vr5701_ac97);
+module_exit(cleanup_vr5701_ac97);
Index: linux-2.6.10/sound/oss/nec_vr5701_sg2.h
===================================================================
--- /dev/null
+++ linux-2.6.10/sound/oss/nec_vr5701_sg2.h
@@ -0,0 +1,531 @@
+/*
+ * sound/oss/nec_vr5701_sg2.h
+ *
+ * A sound driver for NEC Electronics Corporation VR5701 SolutionGearII.
+ * It works with AC97 codec.
+ *
+ * Author: Sergey Podstavin <spodstavin@ru.mvista.com>
+ *
+ * 2005 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+#include <linux/module.h>
+#include <linux/string.h>
+#include <linux/kernel.h>
+#include <linux/ioport.h>
+#include <linux/sched.h>
+#include <linux/delay.h>
+#include <linux/sound.h>
+#include <linux/slab.h>
+#include <linux/soundcard.h>
+#include <linux/pci.h>
+#include <linux/init.h>
+#include <linux/poll.h>
+#include <linux/bitops.h>
+#include <linux/proc_fs.h>
+#include <linux/spinlock.h>
+#include <linux/smp_lock.h>
+#include <linux/ac97_codec.h>
+#include <linux/interrupt.h>
+#include <asm/hardirq.h>
+#include <asm/io.h>
+#include <asm/dma.h>
+#include <asm/uaccess.h>
+
+#define         vr5701_INT_CLR         0x0
+#define         vr5701_INT_STATUS	0x0
+#define         vr5701_CODEC_WR        0x4
+#define         vr5701_CODEC_RD        0x8
+#define         vr5701_CTRL            0x18
+#define         vr5701_ACLINK_CTRL     0x1c
+#define         vr5701_INT_MASK        0x24
+
+#define		vr5701_DAC1_CTRL	0x30
+#define		vr5701_DAC1L		0x34
+#define		vr5701_DAC1_BADDR	0x38
+#define		vr5701_DAC2_CTRL	0x3c
+#define		vr5701_DAC2L		0x40
+#define		vr5701_DAC2_BADDR	0x44
+#define		vr5701_DAC3_CTRL	0x48
+#define		vr5701_DAC3L		0x4c
+#define		vr5701_DAC3_BADDR	0x50
+
+#define		vr5701_ADC1_CTRL	0x54
+#define		vr5701_ADC1L		0x58
+#define		vr5701_ADC1_BADDR	0x5c
+#define		vr5701_ADC2_CTRL	0x60
+#define		vr5701_ADC2L		0x64
+#define		vr5701_ADC2_BADDR	0x68
+#define		vr5701_ADC3_CTRL	0x6c
+#define		vr5701_ADC3L		0x70
+#define		vr5701_ADC3_BADDR	0x74
+
+#define		vr5701_CODEC_WR_RWC	(1 << 23)
+
+#define		vr5701_CODEC_RD_RRDYA	(1 << 31)
+#define		vr5701_CODEC_RD_RRDYD	(1 << 30)
+
+#define		vr5701_ACLINK_CTRL_RST_ON	(1 << 15)
+#define		vr5701_ACLINK_CTRL_RST_TIME	0x7f
+#define		vr5701_ACLINK_CTRL_SYNC_ON	(1 << 30)
+#define		vr5701_ACLINK_CTRL_CK_STOP_ON	(1 << 31)
+
+#define		vr5701_CTRL_DAC2ENB		(1 << 15)
+#define		vr5701_CTRL_ADC2ENB		(1 << 14)
+#define		vr5701_CTRL_DAC1ENB		(1 << 13)
+#define		vr5701_CTRL_ADC1ENB		(1 << 12)
+
+#define		vr5701_INT_MASK_NMASK		(1 << 31)
+#define		vr5701_INT_MASK_DAC1END	(1 << 5)
+#define		vr5701_INT_MASK_DAC2END	(1 << 4)
+#define		vr5701_INT_MASK_DAC3END	(1 << 3)
+#define		vr5701_INT_MASK_ADC1END	(1 << 2)
+#define		vr5701_INT_MASK_ADC2END	(1 << 1)
+#define		vr5701_INT_MASK_ADC3END	(1 << 0)
+
+#define		vr5701_DMA_ACTIVATION		(1 << 31)
+#define		vr5701_DMA_WIP			(1 << 30)
+
+#define vr5701_AC97_MODULE_NAME "NEC_vr5701_audio"
+#define PFX vr5701_AC97_MODULE_NAME ": "
+#define	WORK_BUF_SIZE	2048
+
+#define DMABUF_DEFAULTORDER (16-PAGE_SHIFT)
+#define DMABUF_MINORDER 1
+
+/* maximum number of devices; only used for command line params */
+#define NR_DEVICE 5
+/* -------------------debug macros -------------------------------------- */
+#undef vr5701_AC97_DEBUG
+
+#undef vr5701_AC97_VERBOSE_DEBUG
+
+#if defined(vr5701_AC97_VERBOSE_DEBUG)
+#define vr5701_AC97_DEBUG
+#endif
+
+#if defined(vr5701_AC97_DEBUG)
+#define ASSERT(x)  if (!(x)) { \
+	panic("assertion failed at %s:%d: %s\n", __FILE__, __LINE__, #x); }
+#else
+#define	ASSERT(x)
+#endif				/* vr5701_AC97_DEBUG */
+
+static inline unsigned ld2(unsigned int x)
+{
+	unsigned r = 0;
+
+	if (x >= 0x10000) {
+		x >>= 16;
+		r += 16;
+	}
+	if (x >= 0x100) {
+		x >>= 8;
+		r += 8;
+	}
+	if (x >= 0x10) {
+		x >>= 4;
+		r += 4;
+	}
+	if (x >= 4) {
+		x >>= 2;
+		r += 2;
+	}
+	if (x >= 2)
+		r++;
+	return r;
+}
+
+#if defined(vr5701_AC97_VERBOSE_DEBUG)
+static u16 inTicket;		/* check sync between intr & write */
+static u16 outTicket;
+#endif
+
+#undef OSS_DOCUMENTED_MIXER_SEMANTICS
+
+static const unsigned sample_shift[] = { 0, 1, 1, 2 };
+
+struct vr5701_ac97_state {
+	/* list of vr5701_ac97 devices */
+	struct list_head devs;
+
+	/* the corresponding pci_dev structure */
+	struct pci_dev *dev;
+
+	/* soundcore stuff */
+	int dev_audio;
+
+	/* hardware resources */
+	unsigned long io;
+	unsigned int irq;
+
+#ifdef vr5701_AC97_DEBUG
+	/* debug /proc entry */
+	struct proc_dir_entry *ps;
+	struct proc_dir_entry *ac97_ps;
+#endif				/* vr5701_AC97_DEBUG */
+
+	struct ac97_codec *codec;
+
+	unsigned dacChannels, adcChannels;
+	unsigned short dacRate, adcRate;
+	unsigned short extended_status;
+
+	spinlock_t lock;
+	struct semaphore open_sem;
+	mode_t open_mode;
+	wait_queue_head_t open_wait;
+
+	struct dmabuf {
+		void *lbuf, *rbuf;
+		dma_addr_t lbufDma, rbufDma;
+		unsigned bufOrder;
+		unsigned numFrag;
+		unsigned fragShift;
+		unsigned fragSize;	/* redundant */
+		unsigned fragTotalSize;	/* = numFrag * fragSize(real)  */
+		unsigned nextIn;
+		unsigned nextOut;
+		int count;
+		unsigned error;	/* over/underrun */
+		wait_queue_head_t wait;
+		/* OSS stuff */
+		unsigned stopped:1;
+		unsigned ready:1;
+	} dma_dac, dma_adc;
+
+	struct {
+		u16 lchannel;
+		u16 rchannel;
+	} workBuf[WORK_BUF_SIZE / 4];
+};
+static inline void stop_dac(struct vr5701_ac97_state *s)
+{
+	struct dmabuf *db = &s->dma_dac;
+	unsigned long flags;
+	u32 temp;
+
+	spin_lock_irqsave(&s->lock, flags);
+
+	if (db->stopped) {
+		spin_unlock_irqrestore(&s->lock, flags);
+		return;
+	}
+
+	/* deactivate the dma */
+	outl(0, s->io + vr5701_DAC1_CTRL);
+	outl(0, s->io + vr5701_DAC2_CTRL);
+
+	/* wait for DAM completely stop */
+	while (inl(s->io + vr5701_DAC1_CTRL) & vr5701_DMA_WIP) ;
+	while (inl(s->io + vr5701_DAC2_CTRL) & vr5701_DMA_WIP) ;
+
+	/* disable dac slots in aclink */
+	temp = inl(s->io + vr5701_CTRL);
+	temp &= ~(vr5701_CTRL_DAC1ENB | vr5701_CTRL_DAC2ENB);
+	outl(temp, s->io + vr5701_CTRL);
+
+	/* disable interrupts */
+	temp = inl(s->io + vr5701_INT_MASK);
+	temp &= ~(vr5701_INT_MASK_DAC1END | vr5701_INT_MASK_DAC2END);
+	outl(temp, s->io + vr5701_INT_MASK);
+
+	/* clear pending ones */
+	outl(vr5701_INT_MASK_DAC1END | vr5701_INT_MASK_DAC2END,
+	     s->io + vr5701_INT_CLR);
+
+	db->stopped = 1;
+
+	spin_unlock_irqrestore(&s->lock, flags);
+}
+
+static inline void stop_adc(struct vr5701_ac97_state *s)
+{
+	struct dmabuf *db = &s->dma_adc;
+	unsigned long flags;
+	u32 temp;
+
+	spin_lock_irqsave(&s->lock, flags);
+
+	if (db->stopped) {
+		spin_unlock_irqrestore(&s->lock, flags);
+		return;
+	}
+
+	/* deactivate the dma */
+	outl(0, s->io + vr5701_ADC1_CTRL);
+	outl(0, s->io + vr5701_ADC2_CTRL);
+
+	/* disable adc slots in aclink */
+	temp = inl(s->io + vr5701_CTRL);
+	temp &= ~(vr5701_CTRL_ADC1ENB | vr5701_CTRL_ADC2ENB);
+	outl(temp, s->io + vr5701_CTRL);
+
+	/* disable interrupts */
+	temp = inl(s->io + vr5701_INT_MASK);
+	temp &= ~(vr5701_INT_MASK_ADC1END | vr5701_INT_MASK_ADC2END);
+	outl(temp, s->io + vr5701_INT_MASK);
+
+	/* clear pending ones */
+	outl(vr5701_INT_MASK_ADC1END | vr5701_INT_MASK_ADC2END,
+	     s->io + vr5701_INT_CLR);
+
+	db->stopped = 1;
+
+	spin_unlock_irqrestore(&s->lock, flags);
+}
+
+static inline void dealloc_dmabuf(struct vr5701_ac97_state *s,
+				  struct dmabuf *db)
+{
+	if (db->lbuf) {
+		ASSERT(db->rbuf);
+		pci_free_consistent(s->dev, PAGE_SIZE << db->bufOrder,
+				    db->lbuf, db->lbufDma);
+		pci_free_consistent(s->dev, PAGE_SIZE << db->bufOrder,
+				    db->rbuf, db->rbufDma);
+		db->lbuf = db->rbuf = NULL;
+	}
+	db->nextIn = db->nextOut = 0;
+	db->ready = 0;
+}
+
+static inline int prog_dmabuf_adc(struct vr5701_ac97_state *s)
+{
+	stop_adc(s);
+	return prog_dmabuf(s, &s->dma_adc, s->adcRate);
+}
+
+static inline int prog_dmabuf_dac(struct vr5701_ac97_state *s)
+{
+	stop_dac(s);
+	return prog_dmabuf(s, &s->dma_dac, s->dacRate);
+}
+
+static inline void vr5701_ac97_adc_interrupt(struct vr5701_ac97_state *s)
+{
+	struct dmabuf *adc = &s->dma_adc;
+	unsigned temp;
+
+	/* we need two frags avaiable because one is already being used
+	 * and the other will be used when next interrupt happens.
+	 */
+	if (adc->count >= adc->fragTotalSize - adc->fragSize) {
+		stop_adc(s);
+		adc->error++;
+		printk(KERN_INFO PFX "adc overrun\n");
+		return;
+	}
+
+	/* set the base addr for next DMA transfer */
+	temp = adc->nextIn + 2 * adc->fragSize;
+	if (temp >= adc->fragTotalSize) {
+		ASSERT((temp == adc->fragTotalSize) ||
+		       (temp == adc->fragTotalSize + adc->fragSize));
+		temp -= adc->fragTotalSize;
+	}
+	outl(adc->lbufDma + temp, s->io + vr5701_ADC1_BADDR);
+	outl(adc->rbufDma + temp, s->io + vr5701_ADC2_BADDR);
+
+	/* adjust nextIn */
+	adc->nextIn += adc->fragSize;
+	if (adc->nextIn >= adc->fragTotalSize) {
+		ASSERT(adc->nextIn == adc->fragTotalSize);
+		adc->nextIn = 0;
+	}
+
+	/* adjust count */
+	adc->count += adc->fragSize;
+
+	/* wake up anybody listening */
+	if (waitqueue_active(&adc->wait)) {
+		wake_up_interruptible(&adc->wait);
+	}
+}
+
+static inline void vr5701_ac97_dac_interrupt(struct vr5701_ac97_state *s)
+{
+	struct dmabuf *dac = &s->dma_dac;
+	unsigned temp;
+
+	/* let us set for next next DMA transfer */
+	temp = dac->nextOut + dac->fragSize * 2;
+	if (temp >= dac->fragTotalSize) {
+		ASSERT((temp == dac->fragTotalSize) ||
+		       (temp == dac->fragTotalSize + dac->fragSize));
+		temp -= dac->fragTotalSize;
+	}
+	outl(dac->lbufDma + temp, s->io + vr5701_DAC1_BADDR);
+	if (s->dacChannels == 1) {
+		outl(dac->lbufDma + temp, s->io + vr5701_DAC2_BADDR);
+	} else {
+		outl(dac->rbufDma + temp, s->io + vr5701_DAC2_BADDR);
+	}
+
+#if defined(vr5701_AC97_VERBOSE_DEBUG)
+	if (*(u16 *) (dac->lbuf + dac->nextOut) != outTicket) {
+		printk(KERN_ERR "assert fail: - %d vs %d\n",
+		       *(u16 *) (dac->lbuf + dac->nextOut), outTicket);
+		ASSERT(1 == 0);
+	}
+#endif
+
+	/* adjust nextOut pointer */
+	dac->nextOut += dac->fragSize;
+	if (dac->nextOut >= dac->fragTotalSize) {
+		ASSERT(dac->nextOut == dac->fragTotalSize);
+		dac->nextOut = 0;
+	}
+
+	/* adjust count */
+	dac->count -= dac->fragSize;
+	if (dac->count <= 0) {
+		/* buffer under run */
+		dac->count = 0;
+		dac->nextIn = dac->nextOut;
+		stop_dac(s);
+	}
+#if defined(vr5701_AC97_VERBOSE_DEBUG)
+	if (dac->count) {
+		outTicket++;
+		ASSERT(*(u16 *) (dac->lbuf + dac->nextOut) == outTicket);
+	}
+#endif
+
+	/* we cannot have both under run and someone is waiting on us */
+	ASSERT(!(waitqueue_active(&dac->wait) && (dac->count <= 0)));
+
+	/* wake up anybody listening */
+	if (waitqueue_active(&dac->wait))
+		wake_up_interruptible(&dac->wait);
+}
+
+static inline int
+copy_two_channel_adc_to_user(struct vr5701_ac97_state *s,
+			     char *buffer, int copyCount)
+{
+	struct dmabuf *db = &s->dma_adc;
+	int bufStart = db->nextOut;
+	for (; copyCount > 0;) {
+		int i;
+		int count = copyCount;
+		if (count > WORK_BUF_SIZE / 2)
+			count = WORK_BUF_SIZE / 2;
+		for (i = 0; i < count / 2; i++) {
+			s->workBuf[i].lchannel =
+			    *(u16 *) (db->lbuf + bufStart + i * 2);
+			s->workBuf[i].rchannel =
+			    *(u16 *) (db->rbuf + bufStart + i * 2);
+		}
+		if (copy_to_user(buffer, s->workBuf, count * 2)) {
+			return -1;
+		}
+
+		copyCount -= count;
+		bufStart += count;
+		ASSERT(bufStart <= db->fragTotalSize);
+		buffer += count * 2;
+	}
+	return 0;
+}
+
+/* return the total bytes that is copied */
+static inline int
+copy_adc_to_user(struct vr5701_ac97_state *s,
+		 char *buffer, size_t count, int avail)
+{
+	struct dmabuf *db = &s->dma_adc;
+	int copyCount = 0;
+	int copyFragCount = 0;
+	int totalCopyCount = 0;
+	int totalCopyFragCount = 0;
+	unsigned long flags;
+
+	/* adjust count to signel channel byte count */
+	count >>= s->adcChannels - 1;
+
+	/* we may have to "copy" twice as ring buffer wraps around */
+	for (; (avail > 0) && (count > 0);) {
+		/* determine max possible copy count for single channel */
+		copyCount = count;
+		if (copyCount > avail) {
+			copyCount = avail;
+		}
+		if (copyCount + db->nextOut > db->fragTotalSize) {
+			copyCount = db->fragTotalSize - db->nextOut;
+			ASSERT((copyCount % db->fragSize) == 0);
+		}
+
+		copyFragCount = (copyCount - 1) >> db->fragShift;
+		copyFragCount = (copyFragCount + 1) << db->fragShift;
+		ASSERT(copyFragCount >= copyCount);
+
+		/* we copy differently based on adc channels */
+		if (s->adcChannels == 1) {
+			if (copy_to_user(buffer,
+					 db->lbuf + db->nextOut, copyCount))
+				return -1;
+		} else {
+			/* *sigh* we have to mix two streams into one  */
+			if (copy_two_channel_adc_to_user(s, buffer, copyCount))
+				return -1;
+		}
+
+		count -= copyCount;
+		totalCopyCount += copyCount;
+		avail -= copyFragCount;
+		totalCopyFragCount += copyFragCount;
+
+		buffer += copyCount << (s->adcChannels - 1);
+
+		db->nextOut += copyFragCount;
+		if (db->nextOut >= db->fragTotalSize) {
+			ASSERT(db->nextOut == db->fragTotalSize);
+			db->nextOut = 0;
+		}
+
+		ASSERT((copyFragCount % db->fragSize) == 0);
+		ASSERT((count == 0) || (copyCount == copyFragCount));
+	}
+
+	spin_lock_irqsave(&s->lock, flags);
+	db->count -= totalCopyFragCount;
+	spin_unlock_irqrestore(&s->lock, flags);
+
+	return totalCopyCount << (s->adcChannels - 1);
+}
+
+static inline int
+copy_two_channel_dac_from_user(struct vr5701_ac97_state *s,
+			       const char *buffer, int copyCount)
+{
+	struct dmabuf *db = &s->dma_dac;
+	int bufStart = db->nextIn;
+
+	ASSERT(db->ready);
+
+	for (; copyCount > 0;) {
+		int i;
+		int count = copyCount;
+		if (count > WORK_BUF_SIZE / 2)
+			count = WORK_BUF_SIZE / 2;
+		if (copy_from_user(s->workBuf, buffer, count * 2)) {
+			return -1;
+		}
+		for (i = 0; i < count / 2; i++) {
+			*(u16 *) (db->lbuf + bufStart + i * 2) =
+			    s->workBuf[i].lchannel;
+			*(u16 *) (db->rbuf + bufStart + i * 2) =
+			    s->workBuf[i].rchannel;
+		}
+
+		copyCount -= count;
+		bufStart += count;
+		ASSERT(bufStart <= db->fragTotalSize);
+		buffer += count * 2;
+	}
+	return 0;
+
+}
Index: linux-2.6.10/sound/oss/Makefile
===================================================================
--- linux-2.6.10.orig/sound/oss/Makefile
+++ linux-2.6.10/sound/oss/Makefile
@@ -67,6 +67,7 @@ endif
 obj-$(CONFIG_SOUND_ES1370)	+= es1370.o
 obj-$(CONFIG_SOUND_ES1371)	+= es1371.o ac97_codec.o
 obj-$(CONFIG_SOUND_VRC5477)	+= nec_vrc5477.o ac97_codec.o
+obj-$(CONFIG_SOUND_VR5701)	+= nec_vr5701_sg2.o ac97_codec.o
 obj-$(CONFIG_SOUND_AU1000)	+= au1000.o ac97_codec.o  
 obj-$(CONFIG_SOUND_AU1550_AC97)	+= au1550_ac97.o ac97_codec.o  
 obj-$(CONFIG_SOUND_ESSSOLO1)	+= esssolo1.o
Index: linux-2.6.10/arch/mips/configs/nec_vr5701_defconfig
===================================================================
--- /dev/null
+++ linux-2.6.10/arch/mips/configs/nec_vr5701_defconfig
@@ -0,0 +1,1250 @@
+#
+# Automatically generated make config: don't edit
+# Linux kernel version: 2.6.10_dev
+# Thu Aug  4 14:29:56 2005
+#
+CONFIG_MIPS=y
+# CONFIG_MIPS64 is not set
+# CONFIG_64BIT is not set
+CONFIG_MIPS32=y
+
+#
+# Code maturity level options
+#
+CONFIG_EXPERIMENTAL=y
+CONFIG_CLEAN_COMPILE=y
+CONFIG_BROKEN_ON_SMP=y
+CONFIG_LOCK_KERNEL=y
+
+#
+# General setup
+#
+CONFIG_LOCALVERSION=""
+CONFIG_SWAP=y
+CONFIG_SYSVIPC=y
+CONFIG_SYSVIPC_SEMMNI=128
+CONFIG_SYSVIPC_SEMMSL=250
+# CONFIG_POSIX_MQUEUE is not set
+# CONFIG_BSD_PROCESS_ACCT is not set
+CONFIG_SYSCTL=y
+# CONFIG_AUDIT is not set
+CONFIG_LOG_BUF_SHIFT=14
+CONFIG_HOTPLUG=y
+CONFIG_KOBJECT_UEVENT=y
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y
+CONFIG_EMBEDDED=y
+CONFIG_KALLSYMS=y
+# CONFIG_KALLSYMS_EXTRA_PASS is not set
+CONFIG_FUTEX=y
+CONFIG_EPOLL=y
+# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
+CONFIG_SHMEM=y
+CONFIG_CC_ALIGN_FUNCTIONS=0
+CONFIG_CC_ALIGN_LABELS=0
+CONFIG_CC_ALIGN_LOOPS=0
+CONFIG_CC_ALIGN_JUMPS=0
+# CONFIG_BOOT_FLIGHT_RECORDER is not set
+CONFIG_LOCKLESS=y
+CONFIG_BOOT_FLIGHT_BUFFERS=4
+CONFIG_BOOT_FLIGHT_SIZE=524288
+CONFIG_FLIGHT_PROC_BUFFERS=8
+CONFIG_FLIGHT_PROC_SIZE=8192
+CONFIG_NEWEV=y
+CONFIG_CSTM=y
+# CONFIG_TINY_SHMEM is not set
+
+#
+# Loadable module support
+#
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_MODULE_FORCE_UNLOAD=y
+CONFIG_OBSOLETE_MODPARM=y
+CONFIG_MODVERSIONS=y
+# CONFIG_MODULE_SRCVERSION_ALL is not set
+CONFIG_KMOD=y
+
+#
+# Machine selection
+#
+# CONFIG_MACH_JAZZ is not set
+# CONFIG_MACH_VR41XX is not set
+# CONFIG_TOSHIBA_JMR3927 is not set
+# CONFIG_MIPS_COBALT is not set
+# CONFIG_MACH_DECSTATION is not set
+# CONFIG_MIPS_EV64120 is not set
+# CONFIG_MIPS_EV96100 is not set
+# CONFIG_MIPS_IVR is not set
+# CONFIG_LASAT is not set
+# CONFIG_MIPS_ITE8172 is not set
+# CONFIG_MIPS_ATLAS is not set
+# CONFIG_MIPS_MALTA is not set
+# CONFIG_MIPS_SEAD is not set
+# CONFIG_MOMENCO_OCELOT is not set
+# CONFIG_MOMENCO_OCELOT_G is not set
+# CONFIG_MOMENCO_OCELOT_C is not set
+# CONFIG_MOMENCO_OCELOT_3 is not set
+# CONFIG_MOMENCO_JAGUAR_ATX is not set
+# CONFIG_PMC_YOSEMITE is not set
+# CONFIG_DDB5074 is not set
+# CONFIG_DDB5476 is not set
+# CONFIG_DDB5477 is not set
+CONFIG_TCUBE=y
+# CONFIG_NEC_OSPREY is not set
+# CONFIG_SGI_IP22 is not set
+# CONFIG_SOC_AU1X00 is not set
+# CONFIG_SIBYTE_SB1xxx_SOC is not set
+# CONFIG_SNI_RM200_PCI is not set
+# CONFIG_TOSHIBA_RBTX4927 is not set
+# CONFIG_PREEMPT_NONE is not set
+# CONFIG_PREEMPT_VOLUNTARY is not set
+CONFIG_PREEMPT_DESKTOP=y
+# CONFIG_PREEMPT_RT is not set
+CONFIG_PREEMPT=y
+# CONFIG_PREEMPT_SOFTIRQS is not set
+# CONFIG_PREEMPT_HARDIRQS is not set
+# CONFIG_PREEMPT_RCU is not set
+# CONFIG_SPINLOCK_BKL is not set
+CONFIG_PREEMPT_BKL=y
+CONFIG_RWSEM_GENERIC_SPINLOCK=y
+CONFIG_ASM_SEMAPHORES=y
+CONFIG_HAVE_DEC_LOCK=y
+CONFIG_DMA_NONCOHERENT=y
+CONFIG_CPU_LITTLE_ENDIAN=y
+CONFIG_IRQ_CPU=y
+CONFIG_MIPS_L1_CACHE_SHIFT=5
+
+#
+# CPU selection
+#
+# CONFIG_CPU_MIPS32 is not set
+# CONFIG_CPU_MIPS64 is not set
+# CONFIG_CPU_R3000 is not set
+# CONFIG_CPU_TX39XX is not set
+# CONFIG_CPU_VR41XX is not set
+# CONFIG_CPU_R4300 is not set
+# CONFIG_CPU_R4X00 is not set
+# CONFIG_CPU_TX49XX is not set
+# CONFIG_CPU_R5000 is not set
+# CONFIG_CPU_R5432 is not set
+CONFIG_CPU_R5500=y
+# CONFIG_CPU_R6000 is not set
+# CONFIG_CPU_NEVADA is not set
+# CONFIG_CPU_R8000 is not set
+# CONFIG_CPU_R10000 is not set
+# CONFIG_CPU_RM7000 is not set
+# CONFIG_CPU_RM9000 is not set
+# CONFIG_CPU_SB1 is not set
+CONFIG_PAGE_SIZE_4KB=y
+# CONFIG_PAGE_SIZE_8KB is not set
+# CONFIG_PAGE_SIZE_16KB is not set
+# CONFIG_PAGE_SIZE_64KB is not set
+CONFIG_CPU_ADVANCED=y
+CONFIG_CPU_HAS_LLSC=y
+# CONFIG_CPU_HAS_LLDSCD is not set
+# CONFIG_CPU_HAS_WB is not set
+CONFIG_CPU_HAS_SYNC=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_HIGH_RES_RESOLUTION=10000
+CONFIG_CPU_TIMER=y
+
+#
+# Bus options (PCI, PCMCIA, EISA, ISA, TC)
+#
+CONFIG_HW_HAS_PCI=y
+CONFIG_PCI=y
+# CONFIG_PCI_LEGACY_PROC is not set
+CONFIG_PCI_NAMES=y
+CONFIG_MMU=y
+
+#
+# PCCARD (PCMCIA/CardBus) support
+#
+# CONFIG_PCCARD is not set
+
+#
+# PC-card bridges
+#
+
+#
+# PCI Hotplug Support
+#
+# CONFIG_HOTPLUG_PCI is not set
+
+#
+# Executable file formats
+#
+CONFIG_BINFMT_ELF=y
+# CONFIG_BINFMT_MISC is not set
+CONFIG_TRAD_SIGNALS=y
+
+#
+# Device Drivers
+#
+
+#
+# Generic Driver Options
+#
+CONFIG_STANDALONE=y
+CONFIG_PREVENT_FIRMWARE_BUILD=y
+# CONFIG_FW_LOADER is not set
+
+#
+# Memory Technology Devices (MTD)
+#
+CONFIG_MTD=y
+# CONFIG_MTD_DEBUG is not set
+CONFIG_MTD_PARTITIONS=y
+CONFIG_MTD_CONCAT=y
+# CONFIG_MTD_REDBOOT_PARTS is not set
+# CONFIG_MTD_CMDLINE_PARTS is not set
+
+#
+# User Modules And Translation Layers
+#
+CONFIG_MTD_CHAR=y
+CONFIG_MTD_BLOCK=y
+# CONFIG_FTL is not set
+# CONFIG_NFTL is not set
+# CONFIG_INFTL is not set
+
+#
+# RAM/ROM/Flash chip drivers
+#
+CONFIG_MTD_CFI=y
+# CONFIG_MTD_JEDECPROBE is not set
+CONFIG_MTD_GEN_PROBE=y
+# CONFIG_MTD_CFI_ADV_OPTIONS is not set
+CONFIG_MTD_MAP_BANK_WIDTH_1=y
+CONFIG_MTD_MAP_BANK_WIDTH_2=y
+CONFIG_MTD_MAP_BANK_WIDTH_4=y
+# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
+CONFIG_MTD_CFI_I1=y
+CONFIG_MTD_CFI_I2=y
+# CONFIG_MTD_CFI_I4 is not set
+# CONFIG_MTD_CFI_I8 is not set
+CONFIG_MTD_CFI_INTELEXT=y
+# CONFIG_MTD_CFI_AMDSTD is not set
+# CONFIG_MTD_CFI_STAA is not set
+CONFIG_MTD_CFI_UTIL=y
+# CONFIG_MTD_RAM is not set
+CONFIG_MTD_ROM=y
+# CONFIG_MTD_ABSENT is not set
+# CONFIG_MTD_XIP is not set
+
+#
+# Mapping drivers for chip access
+#
+# CONFIG_MTD_COMPLEX_MAPPINGS is not set
+CONFIG_MTD_PHYSMAP=y
+CONFIG_MTD_PHYSMAP_START=0x1C000000
+CONFIG_MTD_PHYSMAP_LEN=0x01a00000
+CONFIG_MTD_PHYSMAP_BANKWIDTH=2
+
+#
+# Self-contained MTD device drivers
+#
+# CONFIG_MTD_PMC551 is not set
+# CONFIG_MTD_SLRAM is not set
+# CONFIG_MTD_PHRAM is not set
+# CONFIG_MTD_MTDRAM is not set
+# CONFIG_MTD_BLKMTD is not set
+
+#
+# Disk-On-Chip Device Drivers
+#
+# CONFIG_MTD_DOC2000 is not set
+# CONFIG_MTD_DOC2001 is not set
+# CONFIG_MTD_DOC2001PLUS is not set
+
+#
+# NAND Flash Device Drivers
+#
+CONFIG_MTD_NAND=y
+# CONFIG_MTD_NAND_VERIFY_WRITE is not set
+CONFIG_MTD_NAND_IDS=y
+# CONFIG_MTD_NAND_DISKONCHIP is not set
+# CONFIG_MTD_NAND_NANDSIM is not set
+
+#
+# Parallel port support
+#
+# CONFIG_PARPORT is not set
+
+#
+# Plug and Play support
+#
+
+#
+# Block devices
+#
+# CONFIG_BLK_DEV_FD is not set
+# CONFIG_BLK_CPQ_DA is not set
+# CONFIG_BLK_CPQ_CISS_DA is not set
+# CONFIG_BLK_DEV_DAC960 is not set
+# CONFIG_BLK_DEV_UMEM is not set
+CONFIG_BLK_DEV_LOOP=m
+# CONFIG_BLK_DEV_CRYPTOLOOP is not set
+# CONFIG_BLK_DEV_NBD is not set
+# CONFIG_BLK_DEV_SX8 is not set
+# CONFIG_BLK_DEV_UB is not set
+# CONFIG_BLK_DEV_RAM is not set
+CONFIG_BLK_DEV_RAM_COUNT=16
+CONFIG_INITRAMFS_SOURCE=""
+# CONFIG_LBD is not set
+# CONFIG_CDROM_PKTCDVD is not set
+
+#
+# IO Schedulers
+#
+CONFIG_IOSCHED_NOOP=y
+CONFIG_IOSCHED_AS=y
+CONFIG_IOSCHED_DEADLINE=y
+CONFIG_IOSCHED_CFQ=y
+
+#
+# ATA/ATAPI/MFM/RLL support
+#
+CONFIG_IDE=y
+CONFIG_BLK_DEV_IDE=y
+
+#
+# Please see Documentation/ide.txt for help/info on IDE drives
+#
+# CONFIG_BLK_DEV_IDE_SATA is not set
+CONFIG_BLK_DEV_IDEDISK=y
+# CONFIG_IDEDISK_MULTI_MODE is not set
+# CONFIG_BLK_DEV_IDECD is not set
+# CONFIG_BLK_DEV_IDETAPE is not set
+# CONFIG_BLK_DEV_IDEFLOPPY is not set
+# CONFIG_BLK_DEV_IDESCSI is not set
+# CONFIG_IDE_TASK_IOCTL is not set
+
+#
+# IDE chipset support/bugfixes
+#
+CONFIG_IDE_GENERIC=y
+CONFIG_BLK_DEV_IDEPCI=y
+# CONFIG_IDEPCI_SHARE_IRQ is not set
+# CONFIG_BLK_DEV_OFFBOARD is not set
+CONFIG_BLK_DEV_GENERIC=y
+# CONFIG_BLK_DEV_OPTI621 is not set
+CONFIG_BLK_DEV_IDEDMA_PCI=y
+# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
+CONFIG_IDEDMA_PCI_AUTO=y
+# CONFIG_IDEDMA_ONLYDISK is not set
+# CONFIG_BLK_DEV_AEC62XX is not set
+# CONFIG_BLK_DEV_ALI15X3 is not set
+# CONFIG_BLK_DEV_AMD74XX is not set
+# CONFIG_BLK_DEV_CMD64X is not set
+# CONFIG_BLK_DEV_TRIFLEX is not set
+# CONFIG_BLK_DEV_CY82C693 is not set
+# CONFIG_BLK_DEV_CS5520 is not set
+# CONFIG_BLK_DEV_CS5530 is not set
+# CONFIG_BLK_DEV_HPT34X is not set
+# CONFIG_BLK_DEV_HPT366 is not set
+# CONFIG_BLK_DEV_SC1200 is not set
+# CONFIG_BLK_DEV_PIIX is not set
+# CONFIG_BLK_DEV_NS87415 is not set
+# CONFIG_BLK_DEV_PDC202XX_OLD is not set
+# CONFIG_BLK_DEV_PDC202XX_NEW is not set
+# CONFIG_BLK_DEV_SVWKS is not set
+# CONFIG_BLK_DEV_SIIMAGE is not set
+# CONFIG_BLK_DEV_SLC90E66 is not set
+# CONFIG_BLK_DEV_TRM290 is not set
+# CONFIG_BLK_DEV_VIA82CXXX is not set
+# CONFIG_IDE_ARM is not set
+CONFIG_BLK_DEV_NEC_VR5701_SG2=y
+CONFIG_BLK_DEV_IDEDMA=y
+# CONFIG_IDEDMA_IVB is not set
+CONFIG_IDEDMA_AUTO=y
+# CONFIG_BLK_DEV_HD is not set
+
+#
+# SCSI device support
+#
+CONFIG_SCSI=y
+CONFIG_SCSI_PROC_FS=y
+
+#
+# SCSI support type (disk, tape, CD-ROM)
+#
+CONFIG_BLK_DEV_SD=y
+CONFIG_CHR_DEV_ST=y
+CONFIG_CHR_DEV_OSST=y
+CONFIG_BLK_DEV_SR=y
+CONFIG_BLK_DEV_SR_VENDOR=y
+CONFIG_CHR_DEV_SG=y
+
+#
+# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
+#
+# CONFIG_SCSI_MULTI_LUN is not set
+CONFIG_SCSI_CONSTANTS=y
+CONFIG_SCSI_LOGGING=y
+
+#
+# SCSI Transport Attributes
+#
+CONFIG_SCSI_SPI_ATTRS=y
+CONFIG_SCSI_FC_ATTRS=y
+
+#
+# SCSI low-level drivers
+#
+# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
+# CONFIG_SCSI_3W_9XXX is not set
+# CONFIG_SCSI_ACARD is not set
+# CONFIG_SCSI_AACRAID is not set
+# CONFIG_SCSI_AIC7XXX is not set
+# CONFIG_SCSI_AIC7XXX_OLD is not set
+# CONFIG_SCSI_AIC79XX is not set
+# CONFIG_SCSI_ADP94XX is not set
+# CONFIG_SCSI_DPT_I2O is not set
+# CONFIG_MEGARAID_NEWGEN is not set
+# CONFIG_MEGARAID_LEGACY is not set
+# CONFIG_SCSI_SATA is not set
+# CONFIG_SCSI_BUSLOGIC is not set
+# CONFIG_SCSI_DMX3191D is not set
+# CONFIG_SCSI_EATA is not set
+# CONFIG_SCSI_EATA_PIO is not set
+# CONFIG_SCSI_FUTURE_DOMAIN is not set
+# CONFIG_SCSI_GDTH is not set
+# CONFIG_SCSI_IPS is not set
+# CONFIG_SCSI_INITIO is not set
+# CONFIG_SCSI_INIA100 is not set
+# CONFIG_SCSI_SYM53C8XX_2 is not set
+# CONFIG_SCSI_IPR is not set
+# CONFIG_SCSI_QLOGIC_ISP is not set
+# CONFIG_SCSI_QLOGIC_FC is not set
+# CONFIG_SCSI_QLOGIC_1280 is not set
+CONFIG_SCSI_QLA2XXX=y
+# CONFIG_SCSI_QLA21XX is not set
+# CONFIG_SCSI_QLA22XX is not set
+# CONFIG_SCSI_QLA2300 is not set
+# CONFIG_SCSI_QLA2322 is not set
+# CONFIG_SCSI_QLA6312 is not set
+# CONFIG_SCSI_QLA6322 is not set
+# CONFIG_SCSI_DC395x is not set
+# CONFIG_SCSI_DC390T is not set
+# CONFIG_SCSI_NSP32 is not set
+# CONFIG_SCSI_DEBUG is not set
+
+#
+# Multi-device support (RAID and LVM)
+#
+# CONFIG_MD is not set
+
+#
+# Fusion MPT device support
+#
+# CONFIG_FUSION is not set
+
+#
+# IEEE 1394 (FireWire) support
+#
+# CONFIG_IEEE1394 is not set
+
+#
+# I2O device support
+#
+# CONFIG_I2O is not set
+
+#
+# Networking support
+#
+CONFIG_NET=y
+
+#
+# Networking options
+#
+CONFIG_PACKET=y
+CONFIG_PACKET_MMAP=y
+CONFIG_NETLINK_DEV=y
+CONFIG_UNIX=y
+# CONFIG_NET_KEY is not set
+CONFIG_USE_POLICY_FWD=y
+CONFIG_INET=y
+CONFIG_IP_MULTICAST=y
+# CONFIG_IP_ADVANCED_ROUTER is not set
+CONFIG_IP_PNP=y
+# CONFIG_IP_PNP_DHCP is not set
+CONFIG_IP_PNP_BOOTP=y
+# CONFIG_IP_PNP_RARP is not set
+# CONFIG_NET_IPIP is not set
+# CONFIG_NET_IPGRE is not set
+# CONFIG_IP_MROUTE is not set
+# CONFIG_ARPD is not set
+# CONFIG_SYN_COOKIES is not set
+# CONFIG_INET_AH is not set
+# CONFIG_INET_ESP is not set
+# CONFIG_INET_IPCOMP is not set
+# CONFIG_INET_TUNNEL is not set
+CONFIG_IP_TCPDIAG=y
+# CONFIG_IP_TCPDIAG_IPV6 is not set
+
+#
+# IP: Virtual Server Configuration
+#
+# CONFIG_IP_VS is not set
+CONFIG_IPV6=m
+# CONFIG_IPV6_PRIVACY is not set
+# CONFIG_IPV6_ROUTER_PREF is not set
+# CONFIG_INET6_AH is not set
+# CONFIG_INET6_ESP is not set
+# CONFIG_INET6_IPCOMP is not set
+# CONFIG_INET6_TUNNEL is not set
+# CONFIG_IPV6_TUNNEL is not set
+# CONFIG_IPV6_ADVANCED_ROUTER is not set
+# CONFIG_IPV6_MIP6 is not set
+CONFIG_NETFILTER=y
+# CONFIG_NETFILTER_DEBUG is not set
+
+#
+# IP: Netfilter Configuration
+#
+# CONFIG_IP_NF_CONNTRACK is not set
+# CONFIG_IP_NF_CONNTRACK_MARK is not set
+# CONFIG_IP_NF_QUEUE is not set
+# CONFIG_IP_NF_IPTABLES is not set
+# CONFIG_IP_NF_ARPTABLES is not set
+# CONFIG_IP_NF_COMPAT_IPCHAINS is not set
+# CONFIG_IP_NF_COMPAT_IPFWADM is not set
+
+#
+# IPv6: Netfilter Configuration
+#
+# CONFIG_IP6_NF_QUEUE is not set
+# CONFIG_IP6_NF_IPTABLES is not set
+# CONFIG_IP6_NF_CONNTRACK is not set
+
+#
+# SCTP Configuration (EXPERIMENTAL)
+#
+# CONFIG_IP_SCTP is not set
+# CONFIG_ATM is not set
+# CONFIG_BRIDGE is not set
+# CONFIG_VLAN_8021Q is not set
+# CONFIG_DECNET is not set
+# CONFIG_LLC2 is not set
+# CONFIG_IPX is not set
+# CONFIG_ATALK is not set
+# CONFIG_X25 is not set
+# CONFIG_LAPB is not set
+# CONFIG_NET_DIVERT is not set
+# CONFIG_ECONET is not set
+# CONFIG_WAN_ROUTER is not set
+
+#
+# QoS and/or fair queueing
+#
+# CONFIG_NET_SCHED is not set
+# CONFIG_NET_CLS_ROUTE is not set
+
+#
+# Network testing
+#
+# CONFIG_NET_PKTGEN is not set
+# CONFIG_NETPOLL is not set
+# CONFIG_NET_POLL_CONTROLLER is not set
+# CONFIG_HAMRADIO is not set
+# CONFIG_IRDA is not set
+# CONFIG_BT is not set
+CONFIG_NETDEVICES=y
+# CONFIG_DUMMY is not set
+# CONFIG_BONDING is not set
+# CONFIG_EQUALIZER is not set
+CONFIG_TUN=m
+# CONFIG_ETHERTAP is not set
+
+#
+# ARCnet devices
+#
+# CONFIG_ARCNET is not set
+
+#
+# Ethernet (10 or 100Mbit)
+#
+CONFIG_NET_ETHERNET=y
+CONFIG_MII=y
+# CONFIG_HAPPYMEAL is not set
+# CONFIG_SUNGEM is not set
+# CONFIG_NET_VENDOR_3COM is not set
+
+#
+# Tulip family network device support
+#
+# CONFIG_NET_TULIP is not set
+# CONFIG_HP100 is not set
+CONFIG_NET_PCI=y
+# CONFIG_PCNET32 is not set
+# CONFIG_AMD8111_ETH is not set
+# CONFIG_ADAPTEC_STARFIRE is not set
+# CONFIG_B44 is not set
+# CONFIG_FORCEDETH is not set
+# CONFIG_DGRS is not set
+# CONFIG_EEPRO100 is not set
+CONFIG_E100=y
+# CONFIG_E100_NAPI is not set
+# CONFIG_FEALNX is not set
+# CONFIG_NATSEMI is not set
+# CONFIG_NE2K_PCI is not set
+# CONFIG_8139CP is not set
+# CONFIG_8139TOO is not set
+# CONFIG_SIS900 is not set
+# CONFIG_EPIC100 is not set
+# CONFIG_SUNDANCE is not set
+# CONFIG_TLAN is not set
+# CONFIG_VIA_RHINE is not set
+# CONFIG_LAN_SAA9730 is not set
+
+#
+# Ethernet (1000 Mbit)
+#
+# CONFIG_ACENIC is not set
+# CONFIG_DL2K is not set
+# CONFIG_E1000 is not set
+# CONFIG_NS83820 is not set
+# CONFIG_HAMACHI is not set
+# CONFIG_YELLOWFIN is not set
+# CONFIG_R8169 is not set
+# CONFIG_SK98LIN is not set
+# CONFIG_VIA_VELOCITY is not set
+# CONFIG_TIGON3 is not set
+
+#
+# Ethernet (10000 Mbit)
+#
+# CONFIG_IXGB is not set
+# CONFIG_S2IO is not set
+
+#
+# Token Ring devices
+#
+# CONFIG_TR is not set
+
+#
+# Wireless LAN (non-hamradio)
+#
+# CONFIG_NET_RADIO is not set
+
+#
+# Wan interfaces
+#
+# CONFIG_WAN is not set
+# CONFIG_FDDI is not set
+# CONFIG_HIPPI is not set
+CONFIG_PPP=m
+# CONFIG_PPP_MULTILINK is not set
+# CONFIG_PPP_FILTER is not set
+CONFIG_PPP_ASYNC=m
+CONFIG_PPP_SYNC_TTY=m
+CONFIG_PPP_DEFLATE=m
+# CONFIG_PPP_BSDCOMP is not set
+# CONFIG_PPPOE is not set
+# CONFIG_SLIP is not set
+# CONFIG_NET_FC is not set
+# CONFIG_SHAPER is not set
+# CONFIG_NETCONSOLE is not set
+
+#
+# ISDN subsystem
+#
+# CONFIG_ISDN is not set
+
+#
+# Telephony Support
+#
+# CONFIG_PHONE is not set
+
+#
+# Input device support
+#
+CONFIG_INPUT=y
+
+#
+# Userland interfaces
+#
+# CONFIG_INPUT_MOUSEDEV is not set
+# CONFIG_INPUT_JOYDEV is not set
+# CONFIG_INPUT_TSDEV is not set
+# CONFIG_INPUT_TSLIBDEV is not set
+CONFIG_INPUT_EVDEV=m
+# CONFIG_INPUT_EVBUG is not set
+
+#
+# Input I/O drivers
+#
+# CONFIG_GAMEPORT is not set
+CONFIG_SOUND_GAMEPORT=y
+CONFIG_SERIO=y
+CONFIG_SERIO_I8042=y
+CONFIG_SERIO_SERPORT=y
+# CONFIG_SERIO_CT82C710 is not set
+# CONFIG_SERIO_PCIPS2 is not set
+# CONFIG_SERIO_RAW is not set
+
+#
+# Input Device Drivers
+#
+# CONFIG_INPUT_KEYBOARD is not set
+# CONFIG_INPUT_MOUSE is not set
+# CONFIG_INPUT_JOYSTICK is not set
+# CONFIG_INPUT_TOUCHSCREEN is not set
+# CONFIG_INPUT_MISC is not set
+
+#
+# Character devices
+#
+CONFIG_VT=y
+CONFIG_VT_CONSOLE=y
+CONFIG_HW_CONSOLE=y
+# CONFIG_SERIAL_NONSTANDARD is not set
+
+#
+# Serial drivers
+#
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_NR_UARTS=4
+# CONFIG_SERIAL_8250_EXTENDED is not set
+
+#
+# Non-8250 serial port support
+#
+CONFIG_SERIAL_CORE=y
+CONFIG_SERIAL_CORE_CONSOLE=y
+CONFIG_UNIX98_PTYS=y
+CONFIG_LEGACY_PTYS=y
+CONFIG_LEGACY_PTY_COUNT=256
+
+#
+# IPMI
+#
+# CONFIG_IPMI_HANDLER is not set
+
+#
+# Watchdog Cards
+#
+# CONFIG_WATCHDOG is not set
+# CONFIG_RTC is not set
+# CONFIG_BLOCKER is not set
+CONFIG_GEN_RTC=y
+CONFIG_GEN_RTC_X=y
+# CONFIG_DTLK is not set
+# CONFIG_R3964 is not set
+# CONFIG_APPLICOM is not set
+
+#
+# Ftape, the floppy tape device driver
+#
+# CONFIG_DRM is not set
+# CONFIG_RAW_DRIVER is not set
+
+#
+# I2C support
+#
+# CONFIG_I2C is not set
+
+#
+# Dallas's 1-wire bus
+#
+# CONFIG_W1 is not set
+
+#
+# Misc devices
+#
+
+#
+# Multimedia Capabilities Port drivers
+#
+
+#
+# Multimedia devices
+#
+# CONFIG_VIDEO_DEV is not set
+
+#
+# Digital Video Broadcasting Devices
+#
+# CONFIG_DVB is not set
+
+#
+# Graphics support
+#
+CONFIG_FB=y
+# CONFIG_FB_MODE_HELPERS is not set
+# CONFIG_FB_TILEBLITTING is not set
+# CONFIG_FB_CIRRUS is not set
+# CONFIG_FB_PM2 is not set
+# CONFIG_FB_CYBER2000 is not set
+# CONFIG_FB_ASILIANT is not set
+# CONFIG_FB_IMSTT is not set
+# CONFIG_FB_RIVA is not set
+# CONFIG_FB_MATROX is not set
+# CONFIG_FB_RADEON_OLD is not set
+# CONFIG_FB_RADEON is not set
+# CONFIG_FB_ATY128 is not set
+# CONFIG_FB_ATY is not set
+CONFIG_FB_SM=y
+# CONFIG_DISPLAY_640x480 is not set
+CONFIG_DISPLAY_1024x768=y
+# CONFIG_FB_SAVAGE is not set
+# CONFIG_FB_SIS is not set
+# CONFIG_FB_NEOMAGIC is not set
+# CONFIG_FB_KYRO is not set
+# CONFIG_FB_3DFX is not set
+# CONFIG_FB_VOODOO1 is not set
+# CONFIG_FB_TRIDENT is not set
+# CONFIG_FB_E1356 is not set
+# CONFIG_FB_VIRTUAL is not set
+
+#
+# Console display driver support
+#
+# CONFIG_VGA_CONSOLE is not set
+CONFIG_DUMMY_CONSOLE=y
+# CONFIG_FRAMEBUFFER_CONSOLE is not set
+
+#
+# Logo configuration
+#
+# CONFIG_LOGO is not set
+
+#
+# Sound
+#
+CONFIG_SOUND=y
+
+#
+# Advanced Linux Sound Architecture
+#
+CONFIG_SND=y
+CONFIG_SND_TIMER=y
+CONFIG_SND_PCM=y
+CONFIG_SND_SEQUENCER=y
+# CONFIG_SND_SEQ_DUMMY is not set
+CONFIG_SND_OSSEMUL=y
+CONFIG_SND_MIXER_OSS=y
+CONFIG_SND_PCM_OSS=y
+CONFIG_SND_SEQUENCER_OSS=y
+# CONFIG_SND_VERBOSE_PRINTK is not set
+# CONFIG_SND_DEBUG is not set
+
+#
+# Generic devices
+#
+# CONFIG_SND_DUMMY is not set
+# CONFIG_SND_VIRMIDI is not set
+# CONFIG_SND_MTPAV is not set
+# CONFIG_SND_SERIAL_U16550 is not set
+# CONFIG_SND_MPU401 is not set
+
+#
+# PCI devices
+#
+CONFIG_SND_AC97_CODEC=y
+# CONFIG_SND_ALI5451 is not set
+# CONFIG_SND_ATIIXP is not set
+# CONFIG_SND_ATIIXP_MODEM is not set
+# CONFIG_SND_AU8810 is not set
+# CONFIG_SND_AU8820 is not set
+# CONFIG_SND_AU8830 is not set
+# CONFIG_SND_AZT3328 is not set
+# CONFIG_SND_BT87X is not set
+# CONFIG_SND_CS46XX is not set
+# CONFIG_SND_CS4281 is not set
+# CONFIG_SND_EMU10K1 is not set
+# CONFIG_SND_KORG1212 is not set
+# CONFIG_SND_MIXART is not set
+# CONFIG_SND_NM256 is not set
+# CONFIG_SND_RME32 is not set
+# CONFIG_SND_RME96 is not set
+# CONFIG_SND_RME9652 is not set
+# CONFIG_SND_HDSP is not set
+# CONFIG_SND_TRIDENT is not set
+CONFIG_SND_VR5701=y
+# CONFIG_SND_YMFPCI is not set
+# CONFIG_SND_ALS4000 is not set
+# CONFIG_SND_CMIPCI is not set
+# CONFIG_SND_ENS1370 is not set
+# CONFIG_SND_ENS1371 is not set
+# CONFIG_SND_ES1938 is not set
+# CONFIG_SND_ES1968 is not set
+# CONFIG_SND_MAESTRO3 is not set
+# CONFIG_SND_FM801 is not set
+# CONFIG_SND_ICE1712 is not set
+# CONFIG_SND_ICE1724 is not set
+# CONFIG_SND_INTEL8X0 is not set
+# CONFIG_SND_INTEL8X0M is not set
+# CONFIG_SND_SONICVIBES is not set
+# CONFIG_SND_VIA82XX is not set
+# CONFIG_SND_VX222 is not set
+
+#
+# ALSA MIPS devices
+#
+
+#
+# USB devices
+#
+# CONFIG_SND_USB_AUDIO is not set
+# CONFIG_SND_USB_USX2Y is not set
+
+#
+# Open Sound System
+#
+# CONFIG_SOUND_PRIME is not set
+
+#
+# USB support
+#
+CONFIG_USB=y
+# CONFIG_USB_DEBUG is not set
+
+#
+# Miscellaneous USB options
+#
+CONFIG_USB_DEVICEFS=y
+# CONFIG_USB_BANDWIDTH is not set
+# CONFIG_USB_DYNAMIC_MINORS is not set
+# CONFIG_USB_OTG is not set
+CONFIG_USB_ARCH_HAS_HCD=y
+CONFIG_USB_ARCH_HAS_OHCI=y
+
+#
+# USB Host Controller Drivers
+#
+CONFIG_USB_EHCI_HCD=y
+# CONFIG_USB_EHCI_SPLIT_ISO is not set
+# CONFIG_USB_EHCI_ROOT_HUB_TT is not set
+CONFIG_USB_OHCI_HCD=y
+# CONFIG_USB_UHCI_HCD is not set
+# CONFIG_USB_SL811_HCD is not set
+
+#
+# USB Device Class drivers
+#
+# CONFIG_USB_AUDIO is not set
+# CONFIG_USB_BLUETOOTH_TTY is not set
+# CONFIG_USB_MIDI is not set
+# CONFIG_USB_ACM is not set
+# CONFIG_USB_PRINTER is not set
+
+#
+# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support' may also be needed; see USB_STORAGE Help for more information
+#
+CONFIG_USB_STORAGE=y
+# CONFIG_USB_STORAGE_DEBUG is not set
+CONFIG_USB_STORAGE_RW_DETECT=y
+# CONFIG_USB_STORAGE_DATAFAB is not set
+# CONFIG_USB_STORAGE_FREECOM is not set
+# CONFIG_USB_STORAGE_ISD200 is not set
+# CONFIG_USB_STORAGE_DPCM is not set
+# CONFIG_USB_STORAGE_HP8200e is not set
+# CONFIG_USB_STORAGE_SDDR09 is not set
+# CONFIG_USB_STORAGE_SDDR55 is not set
+# CONFIG_USB_STORAGE_JUMPSHOT is not set
+
+#
+# USB Input Devices
+#
+CONFIG_USB_HID=y
+CONFIG_USB_HIDINPUT=y
+# CONFIG_HID_FF is not set
+# CONFIG_USB_HIDDEV is not set
+# CONFIG_USB_AIPTEK is not set
+# CONFIG_USB_WACOM is not set
+# CONFIG_USB_KBTAB is not set
+# CONFIG_USB_POWERMATE is not set
+# CONFIG_USB_MTOUCH is not set
+# CONFIG_USB_EGALAX is not set
+# CONFIG_USB_XPAD is not set
+# CONFIG_USB_ATI_REMOTE is not set
+
+#
+# USB Imaging devices
+#
+# CONFIG_USB_MDC800 is not set
+# CONFIG_USB_MICROTEK is not set
+# CONFIG_USB_HPUSBSCSI is not set
+
+#
+# USB Multimedia devices
+#
+# CONFIG_USB_DABUSB is not set
+
+#
+# Video4Linux support is needed for USB Multimedia device support
+#
+
+#
+# USB Network Adapters
+#
+# CONFIG_USB_CATC is not set
+# CONFIG_USB_KAWETH is not set
+# CONFIG_USB_PEGASUS is not set
+# CONFIG_USB_RTL8150 is not set
+# CONFIG_USB_USBNET is not set
+
+#
+# USB port drivers
+#
+
+#
+# USB Serial Converter support
+#
+# CONFIG_USB_SERIAL is not set
+
+#
+# USB Miscellaneous drivers
+#
+# CONFIG_USB_EMI62 is not set
+# CONFIG_USB_EMI26 is not set
+# CONFIG_USB_TIGL is not set
+# CONFIG_USB_AUERSWALD is not set
+# CONFIG_USB_RIO500 is not set
+# CONFIG_USB_LEGOTOWER is not set
+# CONFIG_USB_LCD is not set
+# CONFIG_USB_LED is not set
+# CONFIG_USB_CYTHERM is not set
+# CONFIG_USB_PHIDGETKIT is not set
+# CONFIG_USB_PHIDGETSERVO is not set
+# CONFIG_USB_TEST is not set
+
+#
+# USB ATM/DSL drivers
+#
+
+#
+# USB Gadget Support
+#
+# CONFIG_USB_GADGET is not set
+
+#
+# MMC/SD Card support
+#
+# CONFIG_MMC is not set
+
+#
+# Synchronous Serial Interfaces (SSI)
+#
+
+#
+# File systems
+#
+CONFIG_EXT2_FS=y
+CONFIG_EXT2_FS_XATTR=y
+# CONFIG_EXT2_FS_POSIX_ACL is not set
+# CONFIG_EXT2_FS_SECURITY is not set
+CONFIG_EXT3_FS=y
+CONFIG_EXT3_FS_XATTR=y
+# CONFIG_EXT3_FS_POSIX_ACL is not set
+# CONFIG_EXT3_FS_SECURITY is not set
+CONFIG_JBD=y
+CONFIG_JBD_DEBUG=y
+CONFIG_FS_MBCACHE=y
+# CONFIG_REISERFS_FS is not set
+CONFIG_JFS_FS=y
+# CONFIG_JFS_POSIX_ACL is not set
+# CONFIG_JFS_DEBUG is not set
+# CONFIG_JFS_STATISTICS is not set
+CONFIG_XFS_FS=m
+# CONFIG_XFS_RT is not set
+# CONFIG_XFS_QUOTA is not set
+# CONFIG_XFS_SECURITY is not set
+# CONFIG_XFS_POSIX_ACL is not set
+# CONFIG_MINIX_FS is not set
+CONFIG_ROMFS_FS=y
+# CONFIG_QUOTA is not set
+# CONFIG_DNOTIFY is not set
+CONFIG_AUTOFS_FS=y
+CONFIG_AUTOFS4_FS=y
+
+#
+# CD-ROM/DVD Filesystems
+#
+# CONFIG_ISO9660_FS is not set
+# CONFIG_UDF_FS is not set
+
+#
+# DOS/FAT/NT Filesystems
+#
+CONFIG_FAT_FS=y
+CONFIG_MSDOS_FS=y
+CONFIG_VFAT_FS=y
+CONFIG_FAT_DEFAULT_CODEPAGE=437
+CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
+# CONFIG_NTFS_FS is not set
+
+#
+# Pseudo filesystems
+#
+CONFIG_PROC_FS=y
+CONFIG_PROC_KCORE=y
+CONFIG_SYSFS=y
+# CONFIG_DEVFS_FS is not set
+CONFIG_DEVPTS_FS_XATTR=y
+CONFIG_DEVPTS_FS_SECURITY=y
+CONFIG_TMPFS=y
+# CONFIG_TMPFS_XATTR is not set
+# CONFIG_HUGETLB_PAGE is not set
+CONFIG_RAMFS=y
+# CONFIG_RELAYFS_FS is not set
+
+#
+# Miscellaneous filesystems
+#
+# CONFIG_ADFS_FS is not set
+# CONFIG_AFFS_FS is not set
+# CONFIG_HFS_FS is not set
+# CONFIG_HFSPLUS_FS is not set
+# CONFIG_BEFS_FS is not set
+# CONFIG_BFS_FS is not set
+# CONFIG_EFS_FS is not set
+CONFIG_JFFS_FS=y
+CONFIG_JFFS_FS_VERBOSE=0
+CONFIG_JFFS_PROC_FS=y
+CONFIG_JFFS2_FS=y
+CONFIG_JFFS2_FS_DEBUG=0
+CONFIG_JFFS2_FS_NAND=y
+# CONFIG_JFFS2_FS_NOR_ECC is not set
+# CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
+CONFIG_JFFS2_ZLIB=y
+CONFIG_JFFS2_RTIME=y
+# CONFIG_JFFS2_RUBIN is not set
+CONFIG_CRAMFS=y
+# CONFIG_CRAMFS_LINEAR is not set
+# CONFIG_VXFS_FS is not set
+# CONFIG_HPFS_FS is not set
+# CONFIG_QNX4FS_FS is not set
+# CONFIG_SYSV_FS is not set
+# CONFIG_UFS_FS is not set
+# CONFIG_YAFFS_FS is not set
+
+#
+# Network File Systems
+#
+CONFIG_NFS_FS=y
+# CONFIG_NFS_V3 is not set
+# CONFIG_NFS_V4 is not set
+# CONFIG_NFS_DIRECTIO is not set
+CONFIG_NFSD=m
+# CONFIG_NFSD_V3 is not set
+CONFIG_NFSD_TCP=y
+CONFIG_ROOT_NFS=y
+CONFIG_LOCKD=y
+CONFIG_EXPORTFS=m
+CONFIG_SUNRPC=y
+# CONFIG_RPCSEC_GSS_KRB5 is not set
+# CONFIG_RPCSEC_GSS_SPKM3 is not set
+CONFIG_SMB_FS=m
+# CONFIG_SMB_NLS_DEFAULT is not set
+# CONFIG_CIFS is not set
+# CONFIG_NCP_FS is not set
+# CONFIG_CODA_FS is not set
+# CONFIG_AFS_FS is not set
+
+#
+# Partition Types
+#
+# CONFIG_PARTITION_ADVANCED is not set
+CONFIG_MSDOS_PARTITION=y
+
+#
+# Native Language Support
+#
+CONFIG_NLS=y
+CONFIG_NLS_DEFAULT="iso8859-1"
+CONFIG_NLS_CODEPAGE_437=y
+# CONFIG_NLS_CODEPAGE_737 is not set
+# CONFIG_NLS_CODEPAGE_775 is not set
+CONFIG_NLS_CODEPAGE_850=y
+CONFIG_NLS_CODEPAGE_852=y
+CONFIG_NLS_CODEPAGE_855=y
+# CONFIG_NLS_CODEPAGE_857 is not set
+# CONFIG_NLS_CODEPAGE_860 is not set
+# CONFIG_NLS_CODEPAGE_861 is not set
+# CONFIG_NLS_CODEPAGE_862 is not set
+# CONFIG_NLS_CODEPAGE_863 is not set
+# CONFIG_NLS_CODEPAGE_864 is not set
+# CONFIG_NLS_CODEPAGE_865 is not set
+# CONFIG_NLS_CODEPAGE_866 is not set
+# CONFIG_NLS_CODEPAGE_869 is not set
+# CONFIG_NLS_CODEPAGE_936 is not set
+# CONFIG_NLS_CODEPAGE_950 is not set
+# CONFIG_NLS_CODEPAGE_932 is not set
+# CONFIG_NLS_CODEPAGE_949 is not set
+# CONFIG_NLS_CODEPAGE_874 is not set
+# CONFIG_NLS_ISO8859_8 is not set
+# CONFIG_NLS_CODEPAGE_1250 is not set
+# CONFIG_NLS_CODEPAGE_1251 is not set
+CONFIG_NLS_ASCII=y
+CONFIG_NLS_ISO8859_1=y
+CONFIG_NLS_ISO8859_2=y
+CONFIG_NLS_ISO8859_3=y
+CONFIG_NLS_ISO8859_4=y
+CONFIG_NLS_ISO8859_5=y
+# CONFIG_NLS_ISO8859_6 is not set
+# CONFIG_NLS_ISO8859_7 is not set
+# CONFIG_NLS_ISO8859_9 is not set
+# CONFIG_NLS_ISO8859_13 is not set
+# CONFIG_NLS_ISO8859_14 is not set
+# CONFIG_NLS_ISO8859_15 is not set
+# CONFIG_NLS_KOI8_R is not set
+# CONFIG_NLS_KOI8_U is not set
+CONFIG_NLS_UTF8=m
+
+#
+# MontaVista System tools
+#
+# CONFIG_ILATENCY is not set
+
+#
+# Profiling support
+#
+# CONFIG_PROFILING is not set
+
+#
+# Kernel hacking
+#
+# CONFIG_DEBUG_KERNEL is not set
+# CONFIG_DEBUG_PREEMPT is not set
+# CONFIG_WAKEUP_TIMING is not set
+# CONFIG_CRITICAL_PREEMPT_TIMING is not set
+# CONFIG_CRITICAL_IRQSOFF_TIMING is not set
+CONFIG_CROSSCOMPILE=y
+CONFIG_CMDLINE="console=ttyS0,115200 root=/dev/nfs rw "
+
+#
+# Security options
+#
+# CONFIG_KEYS is not set
+# CONFIG_SECURITY is not set
+
+#
+# Cryptographic options
+#
+# CONFIG_CRYPTO is not set
+
+#
+# Library routines
+#
+CONFIG_CRC_CCITT=m
+CONFIG_CRC32=y
+# CONFIG_LIBCRC32C is not set
+CONFIG_ZLIB_INFLATE=y
+CONFIG_ZLIB_DEFLATE=y
+
+#
+# Fast Real-Time Domain
+#
+
+#
+# Fast Real-Time Domain Advanced Options
+#
+CONFIG_GENERIC_HARDIRQS=y
+CONFIG_GENERIC_IRQ_PROBE=y
Index: linux-2.6.10/sound/pci/Makefile
===================================================================
--- linux-2.6.10.orig/sound/pci/Makefile
+++ linux-2.6.10/sound/pci/Makefile
@@ -57,4 +57,5 @@ obj-$(CONFIG_SND) += \
 	rme9652/ \
 	trident/ \
 	ymfpci/ \
+	vr5701/ \
 	vx222/
Index: linux-2.6.10/sound/pci/Kconfig
===================================================================
--- linux-2.6.10.orig/sound/pci/Kconfig
+++ linux-2.6.10/sound/pci/Kconfig
@@ -262,6 +262,16 @@ config SND_TRIDENT
 	  To compile this driver as a module, choose M here: the module
 	  will be called snd-trident.
 
+config SND_VR5701
+	tristate "NEC VR5701-SG2 Audio"
+	depends on SND
+	select SND_AC97_CODEC
+	help
+	  Say Y here to include support for NEC VR5701-SG2 Audio.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called nec_vr5701_sg2.
+
 config SND_YMFPCI
 	tristate "Yamaha YMF724/740/744/754"
 	depends on SND
Index: linux-2.6.10/sound/pci/vr5701/nec_vr5701_sg2.c
===================================================================
--- /dev/null
+++ linux-2.6.10/sound/pci/vr5701/nec_vr5701_sg2.c
@@ -0,0 +1,795 @@
+/*
+ * sound/pci/vr5701/nec_vr5701_sg2.c
+ *
+ * An ALSA sound driver for 
+ * NEC Electronics Corporation VR5701 SolutionGearII.
+ * It works with AC97 codec.
+ *
+ * Author: Sergey Podstavin <spodstavin@ru.mvista.com>
+ *
+ * 2005 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#include "nec_vr5701_sg2.h"
+
+static unsigned short snd_vr5701_ac97_read(ac97_t *ac97,
+                                             unsigned short reg)
+{
+	vr5701_t *chip = ac97->private_data;
+	u32 the_register_value;
+	
+	/* wait until we can access codec registers */
+	while (inl(chip->port + vr5701_CODEC_WR) & 0x80000000) ;
+
+	/* write the address and "read" command to codec */
+	reg = reg & 0x7f;
+	outl((reg << 16) | vr5701_CODEC_WR_RWC, chip->port + vr5701_CODEC_WR);
+
+	/* get the return result */
+	udelay(100);		/* workaround hardware bug */
+	while ((the_register_value = inl(chip->port + vr5701_CODEC_RD)) &
+		(vr5701_CODEC_RD_RRDYA | vr5701_CODEC_RD_RRDYD)) {
+		/* we get either addr or data, or both */
+		if (the_register_value & vr5701_CODEC_RD_RRDYD) {
+			break;
+		}
+	}
+
+	return the_register_value & 0xffff;
+}
+
+static void snd_vr5701_ac97_write(ac97_t *ac97,
+                                   unsigned short reg, unsigned short val)
+{
+	vr5701_t *chip = ac97->private_data;
+
+	/* wait until we can access codec registers */
+	while (inl(chip->port + vr5701_CODEC_WR) & 0x80000000) ;
+
+	/* write the address and value to codec */
+	outl((reg << 16) | val, chip->port + vr5701_CODEC_WR);
+}
+
+static void snd_vr5701_ac97_reset(ac97_t *ac97)
+{
+	vr5701_t *chip = ac97->private_data;
+	outl(vr5701_ACLINK_CTRL_RST_ON | vr5701_ACLINK_CTRL_RST_TIME,
+		chip->port + vr5701_ACLINK_CTRL);
+	while (inl(chip->port + vr5701_ACLINK_CTRL) & vr5701_ACLINK_CTRL_RST_ON) ;
+	return;
+}
+
+static void snd_vr5701_ac97_wait(ac97_t *ac97)
+{
+	vr5701_t *chip = ac97->private_data;
+
+	/* wait until we can access codec registers */
+	while (inl(chip->port + vr5701_CODEC_WR) & 0x80000000) ;
+}
+
+static int snd_vr5701_ac97(vr5701_t *chip)
+{
+	ac97_bus_t *bus;
+	ac97_template_t ac97;
+	int err;
+	static ac97_bus_ops_t ops = {
+		.write = snd_vr5701_ac97_write,
+		.read = snd_vr5701_ac97_read,
+		.reset = snd_vr5701_ac97_reset,
+		.wait = snd_vr5701_ac97_wait,
+	};
+
+	if ((err = snd_ac97_bus(chip->card, 0, &ops, NULL, &bus)) < 0)
+		return err;
+	memset(&ac97, 0, sizeof(ac97));
+	ac97.private_data = chip;
+	return snd_ac97_mixer(bus, &ac97, &chip->ac97);
+}
+
+/* open callback */
+static int snd_vr5701_playback_open(snd_pcm_substream_t *substream)
+{
+	vr5701_t *chip = snd_pcm_substream_chip(substream);
+	chip->substream[PLAYBACK] = substream;
+	substream->runtime->hw = snd_vr5701_playback_hw;
+	chip->next_playback = 0;
+
+	return (snd_pcm_hw_constraint_list(substream->runtime, 0,
+		SNDRV_PCM_HW_PARAM_RATE, &hw_constraints_rates) < 0); 
+}
+
+
+/* open callback */
+static int snd_vr5701_capture_open(snd_pcm_substream_t *substream)
+{
+	vr5701_t *chip = snd_pcm_substream_chip(substream);
+	chip->substream[CAPTURE] = substream;
+	substream->runtime->hw = snd_vr5701_capture_hw;
+	chip->next_capture = 0;
+
+	return (snd_pcm_hw_constraint_list(substream->runtime, 0,
+		SNDRV_PCM_HW_PARAM_RATE, &hw_constraints_rates) < 0);
+}
+
+/* hw_params callback */
+static int snd_vr5701_pcm_hw_params(snd_pcm_substream_t *substream,
+                               snd_pcm_hw_params_t * hw_params)
+{
+	return snd_pcm_lib_malloc_pages(substream,
+		params_buffer_bytes(hw_params));
+}
+
+/* hw_free callback */
+static int snd_vr5701_pcm_hw_free(snd_pcm_substream_t *substream)
+{
+	return snd_pcm_lib_free_pages(substream);
+}
+
+/* playback prepare callback */
+static int snd_vr5701_pcm_prepare_playback(snd_pcm_substream_t *substream)
+{
+	vr5701_t *chip = snd_pcm_substream_chip(substream);
+	snd_pcm_runtime_t *runtime = substream->runtime;
+	snd_ac97_set_rate(chip->ac97, AC97_PCM_FRONT_DAC_RATE, runtime->rate);
+	return 0;
+}
+
+/* capture prepare callback */
+static int snd_vr5701_pcm_prepare_capture(snd_pcm_substream_t *substream)
+{
+	vr5701_t *chip = snd_pcm_substream_chip(substream);
+	snd_pcm_runtime_t *runtime = substream->runtime;
+	snd_ac97_set_rate(chip->ac97, AC97_PCM_LR_ADC_RATE, runtime->rate);
+	return 0;
+}
+
+static void vr5701_dma_stop_playback(snd_pcm_substream_t *substream)
+{
+	u32 temp;
+	vr5701_t *chip = snd_pcm_substream_chip(substream);
+	chip->next_playback = 0;
+
+	/* deactivate the dma */
+	outl(0, chip->port + vr5701_DAC1_CTRL);
+	outl(0, chip->port + vr5701_DAC2_CTRL);
+
+	/* wait for DMA completely stop */
+	while (inl(chip->port + vr5701_DAC1_CTRL) & vr5701_DMA_WIP);
+	while (inl(chip->port + vr5701_DAC2_CTRL) & vr5701_DMA_WIP);
+
+	/* disable dac slots in aclink */
+	temp = inl(chip->port + vr5701_CTRL);
+	temp &= ~(vr5701_CTRL_DAC1ENB | vr5701_CTRL_DAC2ENB);
+	outl(temp, chip->port + vr5701_CTRL);
+
+	/* disable interrupts */
+	temp = inl(chip->port + vr5701_INT_MASK);
+	temp &= ~(vr5701_INT_MASK_DAC1END | vr5701_INT_MASK_DAC2END);
+	outl(temp, chip->port + vr5701_INT_MASK);
+
+	/* clear pending ones */
+	outl(vr5701_INT_MASK_DAC1END | vr5701_INT_MASK_DAC2END,
+		chip->port + vr5701_INT_CLR);
+
+}
+
+/* close callback */
+static int snd_vr5701_playback_close(snd_pcm_substream_t *substream)
+{
+	vr5701_dma_stop_playback(substream);
+	return 0;
+}
+
+static void vr5701_dma_stop_capture(snd_pcm_substream_t *substream)
+{
+	u32 temp;
+	vr5701_t *chip = snd_pcm_substream_chip(substream);
+	chip->next_capture = 0;
+
+	/* deactivate the dma */
+	outl(0, chip->port + vr5701_ADC1_CTRL);
+	outl(0, chip->port + vr5701_ADC2_CTRL);
+
+	/* disable dac slots in aclink */
+	temp = inl(chip->port + vr5701_CTRL);
+	temp &= ~(vr5701_CTRL_ADC1ENB | vr5701_CTRL_ADC2ENB);
+	outl(temp, chip->port + vr5701_CTRL);
+
+	/* disable interrupts */
+	temp = inl(chip->port + vr5701_INT_MASK);
+	temp &= ~(vr5701_INT_MASK_ADC1END | vr5701_INT_MASK_ADC2END);
+	outl(temp, chip->port + vr5701_INT_MASK);
+
+	/* clear pending ones */
+	outl(vr5701_INT_MASK_ADC1END | vr5701_INT_MASK_ADC2END,
+		chip->port + vr5701_INT_CLR);
+}
+
+/* close callback */
+static int snd_vr5701_capture_close(snd_pcm_substream_t *substream)
+{
+	vr5701_dma_stop_capture(substream);
+	return 0;
+}
+
+static void vr5701_dma_start_playback(snd_pcm_substream_t *substream)
+{
+	u32 temp;
+	vr5701_t *chip = snd_pcm_substream_chip(substream);
+	unsigned long period_size;
+
+	/* clear pending fales interrupts */
+	outl(vr5701_INT_MASK_DAC1END | vr5701_INT_MASK_DAC2END,
+		chip->port + vr5701_INT_CLR);
+
+	/* enable interrupts */
+	temp = inl(chip->port + vr5701_INT_MASK);
+	temp |= vr5701_INT_MASK_DAC1END | vr5701_INT_MASK_DAC2END;
+	outl(temp, chip->port + vr5701_INT_MASK);
+
+	/* setup dma base addr */
+	if (substream->runtime->channels == 1) {
+		outl(substream->runtime->dma_addr + chip->next_playback, 
+						chip->port + vr5701_DAC1_BADDR);
+		outl(substream->runtime->dma_addr + chip->next_playback, 
+						chip->port + vr5701_DAC2_BADDR);
+	} else {
+		outl(substream->runtime->dma_addr + chip->next_playback, 
+						chip->port + vr5701_DAC1_BADDR);
+		outl(substream->runtime->dma_addr + substream->runtime->dma_bytes/2 
+				+ chip->next_playback, chip->port + vr5701_DAC2_BADDR);
+	}
+
+	/* set dma length, in the unit of 0x10 bytes */
+	period_size = (frames_to_bytes(substream->runtime, 
+			substream->runtime->period_size)) >> 4;
+	outl(period_size, chip->port + vr5701_DAC1L);
+	outl(period_size, chip->port + vr5701_DAC2L);
+
+	/* activate dma */
+	outl(vr5701_DMA_ACTIVATION, chip->port + vr5701_DAC1_CTRL);
+	outl(vr5701_DMA_ACTIVATION, chip->port + vr5701_DAC2_CTRL);
+
+	/* enable dac slots - we should hear the music now! */
+	temp = inl(chip->port + vr5701_CTRL);
+	temp |= (vr5701_CTRL_DAC1ENB | vr5701_CTRL_DAC2ENB);
+	outl(temp, chip->port + vr5701_CTRL);
+
+	/* it is time to setup next dma transfer */
+	temp = chip->next_playback + frames_to_bytes(substream->runtime, 
+			substream->runtime->period_size);
+
+	if (substream->runtime->channels == 1) {
+		if (temp >= substream->runtime->dma_bytes) {
+			temp = 0;
+		}
+		outl(substream->runtime->dma_addr + temp, 
+				chip->port + vr5701_DAC1_BADDR);
+		outl(substream->runtime->dma_addr + temp, 
+				chip->port + vr5701_DAC2_BADDR);
+	} else {
+		if (temp >= substream->runtime->dma_bytes/2) {
+			temp = 0;
+		}
+		outl(substream->runtime->dma_addr + temp, 
+				chip->port + vr5701_DAC1_BADDR);
+		outl(substream->runtime->dma_addr + substream->runtime->dma_bytes/2
+						+ temp, chip->port + vr5701_DAC2_BADDR);
+	}
+	return ;
+}
+
+static void vr5701_dma_start_capture(snd_pcm_substream_t *substream)
+{
+	u32 temp;
+	vr5701_t *chip = snd_pcm_substream_chip(substream);
+	unsigned long period_size;
+
+	/* clear pending fales interrupts */
+	outl(vr5701_INT_MASK_ADC1END | vr5701_INT_MASK_ADC2END,
+		chip->port + vr5701_INT_CLR);
+
+	/* enable interrupts */
+	temp = inl(chip->port + vr5701_INT_MASK);
+	temp |= vr5701_INT_MASK_ADC1END | vr5701_INT_MASK_ADC2END;
+	outl(temp, chip->port + vr5701_INT_MASK);
+
+	/* setup dma base addr */
+	if (substream->runtime->channels == 1) {
+		outl(substream->runtime->dma_addr + chip->next_capture, 
+					chip->port + vr5701_ADC1_BADDR);
+	} else {
+		outl(substream->runtime->dma_addr+ chip->next_capture, 
+					chip->port + vr5701_ADC1_BADDR);
+		outl(substream->runtime->dma_addr + substream->runtime->dma_bytes/2 
+				+ chip->next_capture, chip->port + vr5701_ADC2_BADDR);
+	}
+
+	/* set dma length, in the unit of 0x10 bytes */
+	period_size = (frames_to_bytes(substream->runtime, 
+			substream->runtime->period_size))  >> 4;
+	if (substream->runtime->channels == 1) {
+		outl(period_size, chip->port + vr5701_ADC1L);
+	} else {
+		outl(period_size, chip->port + vr5701_ADC1L);
+		outl(period_size, chip->port + vr5701_ADC2L);
+	}
+
+	/* activate dma */
+	if (substream->runtime->channels == 1) {
+		outl(vr5701_DMA_ACTIVATION, chip->port + vr5701_ADC1_CTRL);
+	} else {
+		outl(vr5701_DMA_ACTIVATION, chip->port + vr5701_ADC1_CTRL);
+		outl(vr5701_DMA_ACTIVATION, chip->port + vr5701_ADC2_CTRL);
+	}
+
+	/* enable adc slots */
+	temp = inl(chip->port + vr5701_CTRL);
+	temp |= (vr5701_CTRL_ADC1ENB | vr5701_CTRL_ADC2ENB);
+	outl(temp, chip->port + vr5701_CTRL);
+
+	/* it is time to setup next dma transfer */
+	temp = chip->next_capture + frames_to_bytes(substream->runtime, 
+			substream->runtime->period_size);
+	if (substream->runtime->channels == 1) {
+		if (temp >= substream->runtime->dma_bytes) {
+			temp = 0;
+		}
+		outl(substream->runtime->dma_addr + temp, 
+				chip->port + vr5701_ADC1_BADDR);
+	} else {
+		if (temp >= substream->runtime->dma_bytes/2) {
+			temp = 0;
+		}
+		outl(substream->runtime->dma_addr + temp, 
+				chip->port + vr5701_ADC1_BADDR);
+		outl(substream->runtime->dma_addr + substream->runtime->dma_bytes/2
+						+ temp,	chip->port + vr5701_ADC2_BADDR);
+	}
+	return ;
+}
+
+/* trigger callback */
+static int snd_vr5701_pcm_trigger(snd_pcm_substream_t *substream,
+                                    int cmd)
+{
+	int err = 0;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+		if (substream->stream) {
+			vr5701_dma_start_capture(substream);
+		}
+		else {
+			vr5701_dma_start_playback(substream);
+		}
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+		if (substream->stream)
+			vr5701_dma_stop_capture(substream);
+		else
+			vr5701_dma_stop_playback(substream);
+		break;
+	default:
+		err = -EINVAL;
+		printk(KERN_WARNING
+			"vr5701_ac97 : wrong trigger callback!!!\n");
+		break;
+	}
+	return err;
+}
+
+/* playback pointer callback */
+static snd_pcm_uframes_t
+snd_vr5701_pcm_pointer_playback(snd_pcm_substream_t *substream)
+{
+	vr5701_t *chip = snd_pcm_substream_chip(substream);
+	return 	 bytes_to_frames(substream->runtime, 
+					chip->next_playback);	
+}
+
+/* capture pointer callback */
+static snd_pcm_uframes_t
+snd_vr5701_pcm_pointer_capture(snd_pcm_substream_t *substream)
+{
+	vr5701_t *chip = snd_pcm_substream_chip(substream);
+	return 	 bytes_to_frames(substream->runtime, 
+					chip->next_capture);	
+}
+/* operators */
+static snd_pcm_ops_t snd_vr5701_playback_ops = {
+	.open =        snd_vr5701_playback_open,
+	.close =       snd_vr5701_playback_close,
+	.ioctl =       snd_pcm_lib_ioctl,
+	.hw_params =   snd_vr5701_pcm_hw_params,
+	.hw_free =     snd_vr5701_pcm_hw_free,
+	.prepare =     snd_vr5701_pcm_prepare_playback,
+	.trigger =     snd_vr5701_pcm_trigger,
+	.pointer =     snd_vr5701_pcm_pointer_playback,
+};
+
+/* operators */
+static snd_pcm_ops_t snd_vr5701_capture_ops = {
+	.open =        snd_vr5701_capture_open,
+	.close =       snd_vr5701_capture_close,
+	.ioctl =       snd_pcm_lib_ioctl,
+	.hw_params =   snd_vr5701_pcm_hw_params,
+	.hw_free =     snd_vr5701_pcm_hw_free,
+	.prepare =     snd_vr5701_pcm_prepare_capture,
+	.trigger =     snd_vr5701_pcm_trigger,
+	.pointer =     snd_vr5701_pcm_pointer_capture,
+};
+
+/* create a pcm device */
+static int __devinit snd_vr5701_new_pcm(vr5701_t *chip)
+{
+	snd_pcm_t *pcm;
+	int err;
+	if ((err = snd_pcm_new(chip->card, vr5701_AC97_MODULE_NAME, 0, 1, 1,
+		&pcm)) < 0) 
+			return err;
+	pcm->private_data = chip;
+	strcpy(pcm->name, vr5701_AC97_MODULE_NAME);
+	chip->pcm = pcm;
+
+	/* set operators */
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK,
+		&snd_vr5701_playback_ops);
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE,
+		&snd_vr5701_capture_ops);
+	
+	/* pre-allocation of buffers */
+	/* NOTE: this may fail */
+	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
+		snd_dma_pci_data(chip->pci), 64*1024, 64*1024);
+	return 0;
+}
+          
+/* chip-specific destructor
+ */
+static int snd_vr5701_free(vr5701_t *chip)
+{
+	/* release the irq */
+	if (chip->irq >= 0)
+		free_irq(chip->irq, (void *)chip);
+	
+	/* release the i/o ports & memory */
+	pci_release_regions(chip->pci);
+	
+	/* disable the PCI entry */
+	pci_disable_device(chip->pci);
+	
+	/* release the data */
+	kfree(chip);
+	return 0;
+}
+
+/* component-destructor
+ */
+static int snd_vr5701_dev_free(snd_device_t *device)
+{
+	vr5701_t *chip = device->device_data;
+	return snd_vr5701_free(chip);
+}
+static void vr5701_ac97_adc_interrupt(struct snd_vr5701 *chip)
+{
+	unsigned temp;
+
+	/* set the base addr for next DMA transfer */
+	temp = chip->next_capture + 2*(frames_to_bytes(chip->substream[CAPTURE]->runtime, 
+			chip->substream[CAPTURE]->runtime->period_size));
+	if (chip->substream[CAPTURE]->runtime->channels == 1) {
+		if (temp >= chip->substream[CAPTURE]->runtime->dma_bytes) {
+			temp -= chip->substream[CAPTURE]->runtime->dma_bytes;
+		}
+	} else {
+		if (temp >= chip->substream[CAPTURE]->runtime->dma_bytes/2) {
+			temp -= chip->substream[CAPTURE]->runtime->dma_bytes/2;
+		}
+	}
+
+	if (chip->substream[CAPTURE]->runtime->channels == 1) {
+		outl(chip->substream[CAPTURE]->runtime->dma_addr 
+				+ temp, chip->port + vr5701_ADC1_BADDR);
+	} else {
+		outl(chip->substream[CAPTURE]->runtime->dma_addr 
+				+ temp, chip->port + vr5701_ADC1_BADDR);
+		outl(chip->substream[CAPTURE]->runtime->dma_addr 
+		+ chip->substream[CAPTURE]->runtime->dma_bytes/2+ temp, 
+						chip->port + vr5701_ADC2_BADDR);
+	}
+
+	/* adjust next pointer */
+	chip->next_capture += frames_to_bytes(chip->substream[CAPTURE]->runtime, 
+					chip->substream[CAPTURE]->runtime->period_size);
+	if (chip->substream[CAPTURE]->runtime->channels == 1) {
+		if (chip->next_capture >= chip->substream[CAPTURE]->runtime->dma_bytes){
+			chip->next_capture = 0;
+		}
+	} else {
+		if (chip->next_capture >= chip->substream[CAPTURE]->runtime->dma_bytes/2){
+			chip->next_capture = 0;
+		}
+	}
+}
+
+static void vr5701_ac97_dac_interrupt(struct snd_vr5701 *chip)
+{
+	unsigned temp;
+
+	/* let us set for next next DMA transfer */
+	temp = chip->next_playback + 2*(frames_to_bytes(chip->substream[PLAYBACK]->runtime, 
+			chip->substream[PLAYBACK]->runtime->period_size));
+	if (chip->substream[PLAYBACK]->runtime->channels == 1) {
+		if (temp >= chip->substream[PLAYBACK]->runtime->dma_bytes) {
+			temp -= chip->substream[PLAYBACK]->runtime->dma_bytes;
+		}
+	} else {
+		if (temp >= chip->substream[PLAYBACK]->runtime->dma_bytes/2) {
+			temp -= chip->substream[PLAYBACK]->runtime->dma_bytes/2;
+		}
+	}
+
+	if (chip->substream[PLAYBACK]->runtime->channels == 1) {
+		outl(chip->substream[PLAYBACK]->runtime->dma_addr 
+				+ temp, chip->port + vr5701_DAC1_BADDR);
+		outl(chip->substream[PLAYBACK]->runtime->dma_addr 
+				+ temp, chip->port + vr5701_DAC2_BADDR);
+	} else {
+		outl(chip->substream[PLAYBACK]->runtime->dma_addr 
+				+ temp, chip->port + vr5701_DAC1_BADDR);
+		outl(chip->substream[PLAYBACK]->runtime->dma_addr 
+			+ chip->substream[PLAYBACK]->runtime->dma_bytes/2
+				+ temp,	chip->port + vr5701_DAC2_BADDR);
+	}
+
+	/* adjust next pointer */
+	chip->next_playback += frames_to_bytes(chip->substream[PLAYBACK]->runtime, 
+					chip->substream[PLAYBACK]->runtime->period_size);
+	if (chip->substream[PLAYBACK]->runtime->channels == 1) {
+		if (chip->next_playback >= chip->substream[PLAYBACK]->runtime->dma_bytes){
+			chip->next_playback = 0;
+		}
+	} else {
+		if (chip->next_playback >= chip->substream[PLAYBACK]->runtime->dma_bytes/2){
+			chip->next_playback = 0;
+		}
+	}
+}
+static irqreturn_t snd_vr5701_interrupt(int irq, void *dev_id,
+                                          struct pt_regs *regs)
+{
+	vr5701_t *chip = dev_id;
+	u32 irqStatus;
+	u32 adcInterrupts, dacInterrupts;
+
+	/* get irqStatus and clear the detected ones */
+	irqStatus = inl(chip->port + vr5701_INT_STATUS);
+	outl(irqStatus, chip->port + vr5701_INT_CLR);
+
+	/* let us see what we get */
+	dacInterrupts = vr5701_INT_MASK_DAC1END | vr5701_INT_MASK_DAC2END;
+	adcInterrupts = vr5701_INT_MASK_ADC1END | vr5701_INT_MASK_ADC2END;
+	if (irqStatus & dacInterrupts) {
+		/* we should get both interrupts */
+		if (irqStatus & vr5701_INT_MASK_DAC1END) {
+			vr5701_ac97_dac_interrupt(chip);
+		}
+		if ((irqStatus & dacInterrupts) != dacInterrupts) {
+			printk(KERN_WARNING
+			       "vr5701_ac97 : playback interrupts not in sync!!!\n");
+			vr5701_dma_stop_playback(chip->substream[PLAYBACK]);
+			vr5701_dma_start_playback(chip->substream[PLAYBACK]);
+		}
+		snd_pcm_period_elapsed(chip->substream[PLAYBACK]);
+	} else if (irqStatus & adcInterrupts) {
+		/* we should get both interrupts, but just in stereo case */
+		if (irqStatus & vr5701_INT_MASK_ADC1END) {
+			vr5701_ac97_adc_interrupt(chip);
+		}
+		if (((irqStatus & adcInterrupts) != adcInterrupts)
+			&&(chip->substream[CAPTURE]->runtime->channels == 2)) {
+			printk(KERN_WARNING
+			       "vr5701_ac97 : capture interrupts not in sync!!!\n");
+			vr5701_dma_stop_capture(chip->substream[CAPTURE]);
+			vr5701_dma_start_capture(chip->substream[CAPTURE]);
+		}
+		snd_pcm_period_elapsed(chip->substream[CAPTURE]);
+	}
+	
+	return IRQ_HANDLED;
+}
+
+/* chip-specific constructor
+ */
+static int __devinit snd_vr5701_create(snd_card_t *card,
+	struct pci_dev *pci, vr5701_t **rchip)
+{
+	vr5701_t *chip;
+	int err;
+	static snd_device_ops_t ops = {
+		.dev_free = snd_vr5701_dev_free,
+	};
+
+	*rchip = NULL;
+
+	/* initialize the PCI entry */
+	if ((err = pci_enable_device(pci)) < 0)
+		return err;
+	pci_set_master(pci);
+
+	/* check PCI availability (28bit DMA) */
+	if (pci_set_dma_mask(pci, 0x0fffffff) < 0 ||
+		pci_set_consistent_dma_mask(pci, 0x0fffffff) < 0) {
+			printk(KERN_ERR "error to set 28bit mask DMA\n");
+			pci_disable_device(pci);
+			return -ENXIO;
+	}
+
+	/* allocate a chip-specific data with zero filled */
+	chip = kcalloc(1, sizeof(*chip), GFP_KERNEL);
+	if (chip == NULL) {
+		pci_disable_device(pci);
+		return -ENOMEM;
+	}
+
+	/* initialize the stuff */
+	chip->card = card;
+	chip->pci = pci;
+	chip->irq = -1;
+
+	/* so that snd_chip_free will work as intended */
+	chip->card->private_data = chip;
+
+	/* PCI resource allocation */
+	if ((err = pci_request_regions(pci, vr5701_AC97_MODULE_NAME)) < 0) {
+		kfree(chip);
+		pci_disable_device(pci);
+		return err;
+	}
+	chip->port = pci_resource_start(pci, 0);
+	if (request_irq(pci->irq, snd_vr5701_interrupt,
+		SA_INTERRUPT|SA_SHIRQ, vr5701_AC97_MODULE_NAME,
+			(void *)chip)) {
+				printk(KERN_ERR "cannot grab irq %d\n", pci->irq);
+				snd_vr5701_free(chip);
+				return -EBUSY;
+	}
+	chip->irq = pci->irq;
+
+	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL,
+		chip, &ops)) < 0) {
+			snd_vr5701_free(chip);
+			return err;
+	}
+
+	snd_card_set_dev(card, &pci->dev);
+
+	*rchip = chip;
+	return 0;
+}
+
+/* constructor */
+static int __devinit snd_vr5701_probe(struct pci_dev *pci,
+                               const struct pci_device_id *pci_id)
+{
+	static int dev;
+	snd_card_t *card;
+	vr5701_t *chip;
+	int err;
+
+	if (dev >= SNDRV_CARDS)
+		return -ENODEV;
+	if (!enable[dev]) {
+		dev++;
+		return -ENOENT;
+	}
+
+	card = snd_card_new(index[dev], id[dev], THIS_MODULE, 0);
+	if (card == NULL)
+		return -ENOMEM;
+
+	if ((err = snd_vr5701_create(card, pci, &chip)) < 0) {
+		snd_card_free(card);
+		return err;
+	}
+
+	strcpy(card->driver, vr5701_AC97_MODULE_NAME);
+	strcpy(card->shortname, "NEC Electronics Corporation ");
+	sprintf(card->longname, "%s at 0x%lx irq %i",
+		card->shortname, chip->port, chip->irq);
+
+	printk(KERN_INFO "IO at %#lx, IRQ %d\n", chip->port, chip->irq);
+ 
+	/* codec init */
+	if ((err = snd_vr5701_ac97(chip)) < 0)
+		return err;
+
+	snd_vr5701_ac97_reset(chip->ac97);
+	
+	/* Try to enable variable rate audio mode. */
+	snd_vr5701_ac97_write(chip->ac97, AC97_EXTENDED_STATUS,
+		snd_vr5701_ac97_read(chip->ac97, AC97_EXTENDED_STATUS) | AC97_EI_VRA);
+
+	/* Did we enable it? */
+	if (!(snd_vr5701_ac97_read(chip->ac97, AC97_EXTENDED_STATUS) & AC97_EI_VRA))
+		printk(KERN_INFO "VRA mode not enabled; rate fixed at %d.",
+		       48000);
+
+	/* let us get the default volumne louder */
+	snd_vr5701_ac97_write(chip->ac97, 0x2, 0x1010);	/* master volume, middle */
+	snd_vr5701_ac97_write(chip->ac97, 0xc, 0x10);	/* phone volume, middle */
+	snd_vr5701_ac97_write(chip->ac97, 0x10, 0x8000);/* line-in 2 line-out disable */
+	snd_vr5701_ac97_write(chip->ac97, 0x18, 0x0707);/* PCM out (line out) middle */
+
+	/* by default we select line in the input */
+	snd_vr5701_ac97_write(chip->ac97, 0xe, 0x10);	/* misc volume, middle */
+	snd_vr5701_ac97_write(chip->ac97, 0x1a, 0x0000);/* default line is Line_mic */
+	snd_vr5701_ac97_write(chip->ac97, 0x1c, 0x0f0f);
+	snd_vr5701_ac97_write(chip->ac97, 0x1e, 0x07);
+
+	/* enable the master interrupt but disable all others */
+	outl(vr5701_INT_MASK_NMASK, chip->port + vr5701_INT_MASK);
+
+	if ((err = snd_vr5701_new_pcm(chip)) < 0) {
+		snd_card_free(card);
+		return err;
+	}
+
+	if ((err = snd_card_register(card)) < 0) {
+		snd_card_free(card);
+		return err;
+	}
+
+	pci_set_drvdata(pci, card);
+	dev++;
+	return 0;
+}
+
+/* destructor */
+static void __devexit snd_vr5701_remove(struct pci_dev *pci)
+{
+	snd_card_free(pci_get_drvdata(pci));
+	pci_set_drvdata(pci, NULL);
+}
+
+/* PCI IDs */
+static struct pci_device_id snd_vr5701_ids[] = {
+	{ PCI_VENDOR_ID_NEC, PCI_DEVICE_ID_NEC_VRC5477_AC97,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },
+	{ 0, }
+};
+MODULE_DEVICE_TABLE(pci, snd_vr5701_ids);
+
+/* pci_driver definition */
+static struct pci_driver driver = {
+	.name = vr5701_AC97_MODULE_NAME,
+	.id_table = snd_vr5701_ids,
+	.probe = snd_vr5701_probe,
+	.remove = __devexit_p(snd_vr5701_remove),
+	SND_PCI_PM_CALLBACKS
+};
+
+/* initialization of the module */
+static int __init alsa_card_vr5701_init(void)
+{
+	printk(KERN_INFO "ALSA NEC Electronics Corporation VR5701 SolutionGearII AC97 driver: time "
+					 __TIME__ " " __DATE__" by Sergey Podstavin\n");
+	return pci_register_driver(&driver);
+}
+
+/* clean up the module */
+static void __exit alsa_card_vr5701_exit(void)
+{
+	pci_unregister_driver(&driver);
+}
+
+module_init(alsa_card_vr5701_init)
+module_exit(alsa_card_vr5701_exit)
+
+MODULE_AUTHOR("Sergey Podstavin");
+MODULE_DESCRIPTION("NEC Electronics Corporation VR5701 SolutionGearII audio (AC97) Driver");
+MODULE_LICENSE("GPL");
Index: linux-2.6.10/sound/pci/vr5701/nec_vr5701_sg2.h
===================================================================
--- /dev/null
+++ linux-2.6.10/sound/pci/vr5701/nec_vr5701_sg2.h
@@ -0,0 +1,155 @@
+/*
+ * sound/pci/vr5701/nec_vr5701_sg2.h
+ *
+ * An ALSA sound driver for 
+ * NEC Electronics Corporation VR5701 SolutionGearII.
+ * It works with AC97 codec.
+ *
+ * Author: Sergey Podstavin <spodstavin@ru.mvista.com>
+ *
+ * 2005 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#include <sound/driver.h>
+#include <linux/init.h>
+#include <linux/pci.h>
+#include <linux/slab.h>
+#include <sound/core.h>
+#include <sound/initval.h>
+#include <sound/pcm.h>
+#include <sound/ac97_codec.h>
+#include <linux/interrupt.h>
+#include <linux/delay.h>
+#include <asm/io.h>
+#include <asm/dma.h>
+#include <sound/pcm_params.h>
+
+#define         vr5701_INT_CLR         	0x0
+#define         vr5701_INT_STATUS	0x0
+#define         vr5701_CODEC_WR        	0x4
+#define         vr5701_CODEC_RD        	0x8
+#define         vr5701_CTRL            	0x18
+#define         vr5701_ACLINK_CTRL     	0x1c
+#define         vr5701_INT_MASK        	0x24
+
+#define		vr5701_DAC1_CTRL	0x30
+#define		vr5701_DAC1L		0x34
+#define		vr5701_DAC1_BADDR	0x38
+#define		vr5701_DAC2_CTRL	0x3c
+#define		vr5701_DAC2L		0x40
+#define		vr5701_DAC2_BADDR	0x44
+#define		vr5701_DAC3_CTRL	0x48
+#define		vr5701_DAC3L		0x4c
+#define		vr5701_DAC3_BADDR	0x50
+
+#define		vr5701_ADC1_CTRL	0x54
+#define		vr5701_ADC1L		0x58
+#define		vr5701_ADC1_BADDR	0x5c
+#define		vr5701_ADC2_CTRL	0x60
+#define		vr5701_ADC2L		0x64
+#define		vr5701_ADC2_BADDR	0x68
+#define		vr5701_ADC3_CTRL	0x6c
+#define		vr5701_ADC3L		0x70
+#define		vr5701_ADC3_BADDR	0x74
+
+#define		vr5701_CODEC_WR_RWC	(1 << 23)
+
+#define		vr5701_CODEC_RD_RRDYA	(1 << 31)
+#define		vr5701_CODEC_RD_RRDYD	(1 << 30)
+
+#define		vr5701_ACLINK_CTRL_RST_ON	(1 << 15)
+#define		vr5701_ACLINK_CTRL_RST_TIME	0x7f
+#define		vr5701_ACLINK_CTRL_SYNC_ON	(1 << 30)
+#define		vr5701_ACLINK_CTRL_CK_STOP_ON	(1 << 31)
+
+#define		vr5701_CTRL_DAC2ENB		(1 << 15)
+#define		vr5701_CTRL_ADC2ENB		(1 << 14)
+#define		vr5701_CTRL_DAC1ENB		(1 << 13)
+#define		vr5701_CTRL_ADC1ENB		(1 << 12)
+
+#define		vr5701_INT_MASK_NMASK		(1 << 31)
+#define		vr5701_INT_MASK_DAC1END		(1 << 5)
+#define		vr5701_INT_MASK_DAC2END		(1 << 4)
+#define		vr5701_INT_MASK_DAC3END		(1 << 3)
+#define		vr5701_INT_MASK_ADC1END		(1 << 2)
+#define		vr5701_INT_MASK_ADC2END		(1 << 1)
+#define		vr5701_INT_MASK_ADC3END		(1 << 0)
+
+#define		vr5701_DMA_ACTIVATION		(1 << 31)
+#define		vr5701_DMA_WIP			(1 << 30)
+
+#define vr5701_AC97_MODULE_NAME "NEC_vr5701_audio"
+#define PLAYBACK 0
+#define CAPTURE  1
+
+/* module parameters */
+static int index[SNDRV_CARDS]  = SNDRV_DEFAULT_IDX;
+static char *id[SNDRV_CARDS]   = SNDRV_DEFAULT_STR;
+static int enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE_PNP;
+
+/* definition of the chip-specific record */
+typedef struct snd_vr5701 vr5701_t;
+
+struct snd_vr5701 {
+        snd_card_t *card;
+        struct pci_dev *pci;
+	ac97_t *ac97;      
+        unsigned long port; 
+        int irq;  
+	snd_pcm_t	*pcm;
+	snd_pcm_substream_t * substream[2]; 
+	unsigned next_playback;
+	unsigned next_capture;
+};
+
+static unsigned int rates[] = {
+	8000,  11025, 16000, 22050,
+	32000, 44100, 48000,
+};
+
+static snd_pcm_hw_constraint_list_t hw_constraints_rates = {
+	.count	= ARRAY_SIZE(rates),
+	.list	= rates,
+	.mask	= 0,
+};
+
+/* hardware definition */
+static snd_pcm_hardware_t snd_vr5701_playback_hw = {
+	.info = (  SNDRV_PCM_INFO_MMAP |
+                   SNDRV_PCM_INFO_NONINTERLEAVED |
+                   SNDRV_PCM_INFO_BLOCK_TRANSFER |
+                   SNDRV_PCM_INFO_MMAP_VALID),
+	.formats =          SNDRV_PCM_FMTBIT_S16_LE,
+	.rates =            SNDRV_PCM_RATE_8000_48000,
+	.rate_min =         8000,
+	.rate_max =         48000,
+	.channels_min =     1,
+	.channels_max =     2,
+	.buffer_bytes_max = (128*1024),
+	.period_bytes_min = 32,
+	.period_bytes_max = (128*1024),
+	.periods_min =      1,
+	.periods_max =      1024,
+};
+
+/* hardware definition */
+static snd_pcm_hardware_t snd_vr5701_capture_hw = {
+	.info = (SNDRV_PCM_INFO_MMAP |
+                   SNDRV_PCM_INFO_INTERLEAVED |
+                   SNDRV_PCM_INFO_BLOCK_TRANSFER |
+                   SNDRV_PCM_INFO_MMAP_VALID),
+	.formats =          SNDRV_PCM_FMTBIT_S16_LE,
+	.rates =            SNDRV_PCM_RATE_8000_48000,
+	.rate_min =         8000,
+	.rate_max =         48000,
+	.channels_min =     1,
+	.channels_max =     2,
+	.buffer_bytes_max = (128*1024),
+	.period_bytes_min = 32,
+	.period_bytes_max = (128*1024),
+	.periods_min =      1,
+	.periods_max =      1024,
+};
Index: linux-2.6.10/sound/pci/vr5701/Makefile
===================================================================
--- /dev/null
+++ linux-2.6.10/sound/pci/vr5701/Makefile
@@ -0,0 +1,16 @@
+#
+# sound/pci/vr5701/Makefile
+#
+# Makefile for ALSA
+#
+# Author: Sergey Podstavin <spodstavin@ru.mvista.com>
+#
+# 2005 (c) MontaVista Software, Inc. This file is licensed under
+# the terms of the GNU General Public License version 2. This program
+# is licensed "as is" without any warranty of any kind, whether express
+# or implied.
+#
+
+snd-nec_vr5701_sg2-objs := nec_vr5701_sg2.o
+
+obj-$(CONFIG_SND_VR5701) += snd-nec_vr5701_sg2.o
Index: linux-2.6.10/mvl_patches/pro-0004.c
===================================================================
--- /dev/null
+++ linux-2.6.10/mvl_patches/pro-0004.c
@@ -0,0 +1,16 @@
+/*
+ * Author: MontaVista Software, Inc. <source@mvista.com>
+ *
+ * 2005 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+#include <linux/init.h>
+#include <linux/mvl_patch.h>
+
+static __init int regpatch(void)
+{
+        return mvl_register_patch(4);
+}
+module_init(regpatch);
Index: linux-2.6.10/include/linux/lsppatchlevel.h
===================================================================
--- linux-2.6.10.orig/include/linux/lsppatchlevel.h
+++ linux-2.6.10/include/linux/lsppatchlevel.h
@@ -6,4 +6,4 @@
  * is licensed "as is" without any warranty of any kind, whether express
  * or implied.
  */
-#define LSP_PATCH_LEVEL "3"
+#define LSP_PATCH_LEVEL "4"

--=-qiZv6RgBUHV2eBYR2Q3B--
