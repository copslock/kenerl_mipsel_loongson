Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Aug 2006 14:59:14 +0100 (BST)
Received: from mo30.po.2iij.net ([210.128.50.53]:27694 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20038725AbWHVN6q (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 22 Aug 2006 14:58:46 +0100
Received: by mo.po.2iij.net (mo30) id k7MDwhCB013043; Tue, 22 Aug 2006 22:58:43 +0900 (JST)
Received: from localhost.localdomain (191.28.30.125.dy.iij4u.or.jp [125.30.28.191])
	by mbox.po.2iij.net (mbox33) id k7MDwejs012153
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 22 Aug 2006 22:58:40 +0900 (JST)
Date:	Tue, 22 Aug 2006 22:32:53 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 1/12] rewrote GALILEO_INL/GALILEO_OUTL  to GT_READ/GT_WRITE
Message-Id: <20060822223253.3e642dcd.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12398
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has rewritten GALILEO_INL/GALILEO_OUTL using GT_READ/GT_WRITE.
This patch tested on Cobalt Qube2.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/cobalt/irq.c mips/arch/mips/cobalt/irq.c
--- mips-orig/arch/mips/cobalt/irq.c	2006-07-16 23:19:10.251102000 +0900
+++ mips/arch/mips/cobalt/irq.c	2006-07-16 23:46:55.267159000 +0900
@@ -46,24 +46,24 @@ static inline void galileo_irq(struct pt
 {
 	unsigned int mask, pending, devfn;
 
-	mask = GALILEO_INL(GT_INTRMASK_OFS);
-	pending = GALILEO_INL(GT_INTRCAUSE_OFS) & mask;
+	mask = GT_READ(GT_INTRMASK_OFS);
+	pending = GT_READ(GT_INTRCAUSE_OFS) & mask;
 
 	if (pending & GALILEO_INTR_T0EXP) {
 
-		GALILEO_OUTL(~GALILEO_INTR_T0EXP, GT_INTRCAUSE_OFS);
+		GT_WRITE(GT_INTRCAUSE_OFS, ~GALILEO_INTR_T0EXP);
 		do_IRQ(COBALT_GALILEO_IRQ, regs);
 
 	} else if (pending & GALILEO_INTR_RETRY_CTR) {
 
-		devfn = GALILEO_INL(GT_PCI0_CFGADDR_OFS) >> 8;
-		GALILEO_OUTL(~GALILEO_INTR_RETRY_CTR, GT_INTRCAUSE_OFS);
+		devfn = GT_READ(GT_PCI0_CFGADDR_OFS) >> 8;
+		GT_WRITE(GT_INTRCAUSE_OFS, ~GALILEO_INTR_RETRY_CTR);
 		printk(KERN_WARNING "Galileo: PCI retry count exceeded (%02x.%u)\n",
 			PCI_SLOT(devfn), PCI_FUNC(devfn));
 
 	} else {
 
-		GALILEO_OUTL(mask & ~pending, GT_INTRMASK_OFS);
+		GT_WRITE(GT_INTRMASK_OFS, mask & ~pending);
 		printk(KERN_WARNING "Galileo: masking unexpected interrupt %08x\n", pending);
 	}
 }
@@ -118,7 +118,7 @@ void __init arch_init_irq(void)
 	 * Mask all Galileo interrupts. The Galileo
 	 * handler is set in cobalt_timer_setup()
 	 */
-	GALILEO_OUTL(0, GT_INTRMASK_OFS);
+	GT_WRITE(GT_INTRMASK_OFS, 0);
 
 	init_i8259_irqs();				/*  0 ... 15 */
 	mips_cpu_irq_init(COBALT_CPU_IRQ);		/* 16 ... 23 */
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/cobalt/setup.c mips/arch/mips/cobalt/setup.c
--- mips-orig/arch/mips/cobalt/setup.c	2006-07-16 23:19:10.251102000 +0900
+++ mips/arch/mips/cobalt/setup.c	2006-07-16 23:46:55.279159750 +0900
@@ -52,23 +52,23 @@ const char *get_system_type(void)
 void __init plat_timer_setup(struct irqaction *irq)
 {
 	/* Load timer value for 1KHz (TCLK is 50MHz) */
-	GALILEO_OUTL(50*1000*1000 / 1000, GT_TC0_OFS);
+	GT_WRITE(GT_TC0_OFS, 50*1000*1000 / 1000);
 
 	/* Enable timer */
-	GALILEO_OUTL(GALILEO_ENTC0 | GALILEO_SELTC0, GT_TC_CONTROL_OFS);
+	GT_WRITE(GT_TC_CONTROL_OFS, GALILEO_ENTC0 | GALILEO_SELTC0);
 
 	/* Register interrupt */
 	setup_irq(COBALT_GALILEO_IRQ, irq);
 
 	/* Enable interrupt */
-	GALILEO_OUTL(GALILEO_INTR_T0EXP | GALILEO_INL(GT_INTRMASK_OFS), GT_INTRMASK_OFS);
+	GT_WRITE(GT_INTRMASK_OFS, GALILEO_INTR_T0EXP | GT_READ(GT_INTRMASK_OFS));
 }
 
 extern struct pci_ops gt64111_pci_ops;
 
 static struct resource cobalt_mem_resource = {
-	.start	= GT64111_MEM_BASE,
-	.end	= GT64111_MEM_END,
+	.start	= GT_DEF_PCI0_MEM0_BASE,
+	.end	= GT_DEF_PCI0_MEM0_BASE + GT_DEF_PCI0_MEM0_SIZE - 1,
 	.name	= "PCI memory",
 	.flags	= IORESOURCE_MEM
 };
@@ -116,7 +116,7 @@ static struct pci_controller cobalt_pci_
 	.mem_resource	= &cobalt_mem_resource,
 	.mem_offset	= 0,
 	.io_resource	= &cobalt_io_resource,
-	.io_offset	= 0 - GT64111_IO_BASE
+	.io_offset	= 0 - GT_DEF_PCI0_IO_BASE,
 };
 
 void __init plat_mem_setup(void)
@@ -129,7 +129,7 @@ void __init plat_mem_setup(void)
 	_machine_halt = cobalt_machine_halt;
 	pm_power_off = cobalt_machine_power_off;
 
-        set_io_port_base(CKSEG1ADDR(GT64111_IO_BASE));
+        set_io_port_base(CKSEG1ADDR(GT_DEF_PCI0_IO_BASE));
 
 	/* I/O port resource must include UART and LCD/buttons */
 	ioport_resource.end = 0x0fffffff;
@@ -140,7 +140,7 @@ void __init plat_mem_setup(void)
 
         /* Read the cobalt id register out of the PCI config space */
         PCI_CFG_SET(devfn, (VIA_COBALT_BRD_ID_REG & ~0x3));
-        cobalt_board_id = GALILEO_INL(GT_PCI0_CFGDATA_OFS);
+        cobalt_board_id = GT_READ(GT_PCI0_CFGDATA_OFS);
         cobalt_board_id >>= ((VIA_COBALT_BRD_ID_REG & 3) * 8);
         cobalt_board_id = VIA_COBALT_BRD_REG_to_ID(cobalt_board_id);
 
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/pci/fixup-cobalt.c mips/arch/mips/pci/fixup-cobalt.c
--- mips-orig/arch/mips/pci/fixup-cobalt.c	2006-07-16 23:19:10.511118250 +0900
+++ mips/arch/mips/pci/fixup-cobalt.c	2006-07-16 23:46:55.279159750 +0900
@@ -94,22 +94,21 @@ static void qube_raq_galileo_fixup(struc
 #if 0
 	if (galileo_id >= 0x10) {
 		/* New Galileo, assumes PCI stop line to VIA is connected. */
-		GALILEO_OUTL(0x4020, GT_PCI0_TOR_OFS);
+		GT_WRITE(GT_PCI0_TOR_OFS, 0x4020);
 	} else if (galileo_id == 0x1 || galileo_id == 0x2)
 #endif
 	{
 		signed int timeo;
 		/* XXX WE MUST DO THIS ELSE GALILEO LOCKS UP! -DaveM */
-		timeo = GALILEO_INL(GT_PCI0_TOR_OFS);
+		timeo = GT_READ(GT_PCI0_TOR_OFS);
 		/* Old Galileo, assumes PCI STOP line to VIA is disconnected. */
-		GALILEO_OUTL(
+		GT_WRITE(GT_PCI0_TOR_OFS,
 			(0xff << 16) |		/* retry count */
 			(0xff << 8) |		/* timeout 1   */
-			0xff,			/* timeout 0   */
-			GT_PCI0_TOR_OFS);
+			0xff);			/* timeout 0   */
 
 		/* enable PCI retry exceeded interrupt */
-		GALILEO_OUTL(GALILEO_INTR_RETRY_CTR | GALILEO_INL(GT_INTRMASK_OFS), GT_INTRMASK_OFS);
+		GT_WRITE(GT_INTRMASK_OFS, GALILEO_INTR_RETRY_CTR | GT_READ(GT_INTRMASK_OFS));
 	}
 }
 
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/pci/ops-gt64111.c mips/arch/mips/pci/ops-gt64111.c
--- mips-orig/arch/mips/pci/ops-gt64111.c	2006-07-16 23:19:10.519118750 +0900
+++ mips/arch/mips/pci/ops-gt64111.c	2006-07-16 23:46:55.311161750 +0900
@@ -38,18 +38,18 @@ static int gt64111_pci_read_config(struc
 	switch (size) {
 	case 4:
 		PCI_CFG_SET(devfn, where);
-		*val = GALILEO_INL(GT_PCI0_CFGDATA_OFS);
+		*val = GT_READ(GT_PCI0_CFGDATA_OFS);
 		return PCIBIOS_SUCCESSFUL;
 
 	case 2:
 		PCI_CFG_SET(devfn, (where & ~0x3));
-		*val = GALILEO_INL(GT_PCI0_CFGDATA_OFS)
+		*val = GT_READ(GT_PCI0_CFGDATA_OFS)
 		    >> ((where & 3) * 8);
 		return PCIBIOS_SUCCESSFUL;
 
 	case 1:
 		PCI_CFG_SET(devfn, (where & ~0x3));
-		*val = GALILEO_INL(GT_PCI0_CFGDATA_OFS)
+		*val = GT_READ(GT_PCI0_CFGDATA_OFS)
 		    >> ((where & 3) * 8);
 		return PCIBIOS_SUCCESSFUL;
 	}
@@ -68,25 +68,25 @@ static int gt64111_pci_write_config(stru
 	switch (size) {
 	case 4:
 		PCI_CFG_SET(devfn, where);
-		GALILEO_OUTL(val, GT_PCI0_CFGDATA_OFS);
+		GT_WRITE(GT_PCI0_CFGDATA_OFS, val);
 
 		return PCIBIOS_SUCCESSFUL;
 
 	case 2:
 		PCI_CFG_SET(devfn, (where & ~0x3));
-		tmp = GALILEO_INL(GT_PCI0_CFGDATA_OFS);
+		tmp = GT_READ(GT_PCI0_CFGDATA_OFS);
 		tmp &= ~(0xffff << ((where & 0x3) * 8));
 		tmp |= (val << ((where & 0x3) * 8));
-		GALILEO_OUTL(tmp, GT_PCI0_CFGDATA_OFS);
+		GT_WRITE(GT_PCI0_CFGDATA_OFS, tmp);
 
 		return PCIBIOS_SUCCESSFUL;
 
 	case 1:
 		PCI_CFG_SET(devfn, (where & ~0x3));
-		tmp = GALILEO_INL(GT_PCI0_CFGDATA_OFS);
+		tmp = GT_READ(GT_PCI0_CFGDATA_OFS);
 		tmp &= ~(0xff << ((where & 0x3) * 8));
 		tmp |= (val << ((where & 0x3) * 8));
-		GALILEO_OUTL(tmp, GT_PCI0_CFGDATA_OFS);
+		GT_WRITE(GT_PCI0_CFGDATA_OFS, tmp);
 
 		return PCIBIOS_SUCCESSFUL;
 	}
diff -pruN -X mips/Documentation/dontdiff mips-orig/include/asm-mips/mach-cobalt/cobalt.h mips/include/asm-mips/mach-cobalt/cobalt.h
--- mips-orig/include/asm-mips/mach-cobalt/cobalt.h	2006-07-16 23:19:24.579997500 +0900
+++ mips/include/asm-mips/mach-cobalt/cobalt.h	2006-07-16 23:46:55.311161750 +0900
@@ -67,25 +67,6 @@
 #define COBALT_BRD_ID_QUBE2    0x5
 #define COBALT_BRD_ID_RAQ2     0x6
 
-/*
- * Galileo chipset access macros for the Cobalt. The base address for
- * the GT64111 chip is 0x14000000
- *
- * Most of this really should go into a separate GT64111 header file.
- */
-#define GT64111_IO_BASE		0x10000000UL
-#define GT64111_IO_END		0x11ffffffUL
-#define GT64111_MEM_BASE	0x12000000UL
-#define GT64111_MEM_END		0x13ffffffUL
-#define GT64111_BASE		0x14000000UL
-#define GALILEO_REG(ofs)	CKSEG1ADDR(GT64111_BASE + (unsigned long)(ofs))
-
-#define GALILEO_INL(port)	(*(volatile unsigned int *) GALILEO_REG(port))
-#define GALILEO_OUTL(val, port)						\
-do {									\
-	*(volatile unsigned int *) GALILEO_REG(port) = (val);		\
-} while (0)
-
 #define GALILEO_INTR_T0EXP	(1 << 8)
 #define GALILEO_INTR_RETRY_CTR	(1 << 20)
 
@@ -93,8 +74,8 @@ do {									\
 #define GALILEO_SELTC0		0x02
 
 #define PCI_CFG_SET(devfn,where)					\
-	GALILEO_OUTL((0x80000000 | (PCI_SLOT (devfn) << 11) |		\
-		(PCI_FUNC (devfn) << 8) | (where)), GT_PCI0_CFGADDR_OFS)
+	GT_WRITE(GT_PCI0_CFGADDR_OFS, (0x80000000 | (PCI_SLOT (devfn) << 11) |		\
+		(PCI_FUNC (devfn) << 8) | (where)))
 
 #define COBALT_LED_PORT		(*(volatile unsigned char *) CKSEG1ADDR(0x1c000000))
 # define COBALT_LED_BAR_LEFT	(1 << 0)	/* Qube */
diff -pruN -X mips/Documentation/dontdiff mips-orig/include/asm-mips/mach-cobalt/mach-gt64120.h mips/include/asm-mips/mach-cobalt/mach-gt64120.h
--- mips-orig/include/asm-mips/mach-cobalt/mach-gt64120.h	2006-07-16 23:19:24.579997500 +0900
+++ mips/include/asm-mips/mach-cobalt/mach-gt64120.h	2006-07-17 00:10:33.498271750 +0900
@@ -1 +1,28 @@
-/* there's something here ... in the dark */
+/*
+ *  Copyright (C) 2006  Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
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
+ *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+#ifndef _COBALT_MACH_GT64120_H
+#define _COBALT_MACH_GT64120_H
+
+/*
+ * Cobalt uses GT64111. GT64111 is almost the same as GT64120.
+ */
+
+#define GT64120_BASE	CKSEG1ADDR(GT_DEF_BASE)
+
+#endif /* _COBALT_MACH_GT64120_H */
+
