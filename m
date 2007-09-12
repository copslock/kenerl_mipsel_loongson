Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Sep 2007 15:29:20 +0100 (BST)
Received: from mo32.po.2iij.NET ([210.128.50.17]:38948 "EHLO mo32.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20023396AbXILO3L (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 12 Sep 2007 15:29:11 +0100
Received: by mo.po.2iij.net (mo32) id l8CERrVv095081; Wed, 12 Sep 2007 23:27:53 +0900 (JST)
Received: from localhost.localdomain (221.25.30.125.dy.iij4u.or.jp [125.30.25.221])
	by mbox.po.2iij.net (po-mbox303) id l8CERofn014174
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 12 Sep 2007 23:27:51 +0900
Date:	Wed, 12 Sep 2007 23:27:50 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] add GT641xx IRQ routines
Message-Id: <20070912232750.645a980f.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16473
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Add GT641xx IRQ routines.

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/Kconfig mips/arch/mips/Kconfig
--- mips-orig/arch/mips/Kconfig	2007-09-11 10:54:34.603071750 +0900
+++ mips/arch/mips/Kconfig	2007-09-11 10:03:04.921978750 +0900
@@ -40,6 +40,7 @@ config MIPS_COBALT
 	select HW_HAS_PCI
 	select I8259
 	select IRQ_CPU
+	select IRQ_GT641XX
 	select PCI_GT64XXX_PCI0
 	select SYS_HAS_CPU_NEVADA
 	select SYS_HAS_EARLY_PRINTK
@@ -766,6 +767,9 @@ config IRQ_MSP_CIC
 config IRQ_TXX9
 	bool
 
+config IRQ_GT641XX
+	bool
+
 config MIPS_BOARDS_GEN
 	bool
 
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/cobalt/irq.c mips/arch/mips/cobalt/irq.c
--- mips-orig/arch/mips/cobalt/irq.c	2007-09-11 10:54:34.615072500 +0900
+++ mips/arch/mips/cobalt/irq.c	2007-09-11 10:03:04.957981000 +0900
@@ -15,102 +15,48 @@
 
 #include <asm/i8259.h>
 #include <asm/irq_cpu.h>
+#include <asm/irq_gt641xx.h>
 #include <asm/gt64120.h>
 
-#include <cobalt.h>
-
-/*
- * We have two types of interrupts that we handle, ones that come in through
- * the CPU interrupt lines, and ones that come in on the via chip. The CPU
- * mappings are:
- *
- *    16   - Software interrupt 0 (unused)	IE_SW0
- *    17   - Software interrupt 1 (unused)	IE_SW1
- *    18   - Galileo chip (timer)		IE_IRQ0
- *    19   - Tulip 0 + NCR SCSI			IE_IRQ1
- *    20   - Tulip 1				IE_IRQ2
- *    21   - 16550 UART				IE_IRQ3
- *    22   - VIA southbridge PIC		IE_IRQ4
- *    23   - unused				IE_IRQ5
- *
- * The VIA chip is a master/slave 8259 setup and has the following interrupts:
- *
- *     8  - RTC
- *     9  - PCI
- *    14  - IDE0
- *    15  - IDE1
- */
-
-static inline void galileo_irq(void)
-{
-	unsigned int mask, pending, devfn;
-
-	mask = GT_READ(GT_INTRMASK_OFS);
-	pending = GT_READ(GT_INTRCAUSE_OFS) & mask;
-
-	if (pending & GT_INTR_T0EXP_MSK) {
-		GT_WRITE(GT_INTRCAUSE_OFS, ~GT_INTR_T0EXP_MSK);
-		do_IRQ(COBALT_GALILEO_IRQ);
-	} else if (pending & GT_INTR_RETRYCTR0_MSK) {
-		devfn = GT_READ(GT_PCI0_CFGADDR_OFS) >> 8;
-		GT_WRITE(GT_INTRCAUSE_OFS, ~GT_INTR_RETRYCTR0_MSK);
-		printk(KERN_WARNING
-		       "Galileo: PCI retry count exceeded (%02x.%u)\n",
-		       PCI_SLOT(devfn), PCI_FUNC(devfn));
-	} else {
-		GT_WRITE(GT_INTRMASK_OFS, mask & ~pending);
-		printk(KERN_WARNING
-		       "Galileo: masking unexpected interrupt %08x\n", pending);
-	}
-}
-
-static inline void via_pic_irq(void)
-{
-	int irq;
-
-	irq = i8259_irq();
-	if (irq >= 0)
-		do_IRQ(irq);
-}
+#include <irq.h>
 
 asmlinkage void plat_irq_dispatch(void)
 {
-	unsigned pending = read_c0_status() & read_c0_cause();
+	unsigned pending = read_c0_status() & read_c0_cause() & ST0_IM;
+	int irq;
 
-	if (pending & CAUSEF_IP2)		/* COBALT_GALILEO_IRQ (18) */
-		galileo_irq();
-	else if (pending & CAUSEF_IP6)		/* COBALT_VIA_IRQ (22) */
-		via_pic_irq();
-	else if (pending & CAUSEF_IP3)		/* COBALT_ETH0_IRQ (19) */
-		do_IRQ(COBALT_CPU_IRQ + 3);
-	else if (pending & CAUSEF_IP4)		/* COBALT_ETH1_IRQ (20) */
-		do_IRQ(COBALT_CPU_IRQ + 4);
-	else if (pending & CAUSEF_IP5)		/* COBALT_SERIAL_IRQ (21) */
-		do_IRQ(COBALT_CPU_IRQ + 5);
-	else if (pending & CAUSEF_IP7)		/* IRQ 23 */
-		do_IRQ(COBALT_CPU_IRQ + 7);
+	if (pending & CAUSEF_IP2)
+		gt641xx_irq_dispatch();
+	else if (pending & CAUSEF_IP6) {
+		irq = i8259_irq();
+		if (irq < 0)
+			spurious_interrupt();
+		else
+			do_IRQ(irq);
+	} else if (pending & CAUSEF_IP3)
+		do_IRQ(MIPS_CPU_IRQ_BASE + 3);
+	else if (pending & CAUSEF_IP4)
+		do_IRQ(MIPS_CPU_IRQ_BASE + 4);
+	else if (pending & CAUSEF_IP5)
+		do_IRQ(MIPS_CPU_IRQ_BASE + 5);
+	else if (pending & CAUSEF_IP7)
+		do_IRQ(MIPS_CPU_IRQ_BASE + 7);
+	else
+		spurious_interrupt();
 }
 
-static struct irqaction irq_via = {
-	no_action, 0, { { 0, } }, "cascade", NULL, NULL
+static struct irqaction cascade = {
+	.handler	= no_action,
+	.mask		= CPU_MASK_NONE,
+	.name		= "cascade",
 };
 
 void __init arch_init_irq(void)
 {
-	/*
-	 * Mask all Galileo interrupts. The Galileo
-	 * handler is set in cobalt_timer_setup()
-	 */
-	GT_WRITE(GT_INTRMASK_OFS, 0);
-
-	init_i8259_irqs();				/*  0 ... 15 */
-	mips_cpu_irq_init();		/* 16 ... 23 */
-
-	/*
-	 * Mask all cpu interrupts
-	 *  (except IE4, we already masked those at VIA level)
-	 */
-	change_c0_status(ST0_IM, IE_IRQ4);
+	mips_cpu_irq_init();
+	gt641xx_irq_init();
+	init_i8259_irqs();
 
-	setup_irq(COBALT_VIA_IRQ, &irq_via);
+	setup_irq(GT641XX_CASCADE_IRQ, &cascade);
+	setup_irq(I8259_CASCADE_IRQ, &cascade);
 }
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/cobalt/rtc.c mips/arch/mips/cobalt/rtc.c
--- mips-orig/arch/mips/cobalt/rtc.c	2007-09-11 10:54:34.639074000 +0900
+++ mips/arch/mips/cobalt/rtc.c	2007-09-11 10:58:00.359930750 +0900
@@ -20,6 +20,7 @@
 #include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/ioport.h>
+#include <linux/mc146818rtc.h>
 #include <linux/platform_device.h>
 
 static struct resource cobalt_rtc_resource[] __initdata = {
@@ -29,8 +30,8 @@ static struct resource cobalt_rtc_resour
 		.flags	= IORESOURCE_IO,
 	},
 	{
-		.start	= 8,
-		.end	= 8,
+		.start	= RTC_IRQ,
+		.end	= RTC_IRQ,
 		.flags	= IORESOURCE_IRQ,
 	},
 };
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/cobalt/serial.c mips/arch/mips/cobalt/serial.c
--- mips-orig/arch/mips/cobalt/serial.c	2007-09-11 10:54:34.651074750 +0900
+++ mips/arch/mips/cobalt/serial.c	2007-09-11 10:03:05.033985750 +0900
@@ -24,6 +24,7 @@
 #include <linux/serial_8250.h>
 
 #include <cobalt.h>
+#include <irq.h>
 
 static struct resource cobalt_uart_resource[] __initdata = {
 	{
@@ -32,15 +33,15 @@ static struct resource cobalt_uart_resou
 		.flags	= IORESOURCE_MEM,
 	},
 	{
-		.start	= COBALT_SERIAL_IRQ,
-		.end	= COBALT_SERIAL_IRQ,
+		.start	= SERIAL_IRQ,
+		.end	= SERIAL_IRQ,
 		.flags	= IORESOURCE_IRQ,
 	},
 };
 
 static struct plat_serial8250_port cobalt_serial8250_port[] = {
 	{
-		.irq		= COBALT_SERIAL_IRQ,
+		.irq		= SERIAL_IRQ,
 		.uartclk	= 18432000,
 		.iotype		= UPIO_MEM,
 		.flags		= UPF_IOREMAP | UPF_BOOT_AUTOCONF | UPF_SKIP_TEST,
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/cobalt/setup.c mips/arch/mips/cobalt/setup.c
--- mips-orig/arch/mips/cobalt/setup.c	2007-09-11 10:54:34.663075500 +0900
+++ mips/arch/mips/cobalt/setup.c	2007-09-11 10:03:05.033985750 +0900
@@ -20,6 +20,7 @@
 #include <asm/gt64120.h>
 
 #include <cobalt.h>
+#include <irq.h>
 
 extern void cobalt_machine_restart(char *command);
 extern void cobalt_machine_halt(void);
@@ -45,14 +46,10 @@ void __init plat_timer_setup(struct irqa
 	/* Load timer value for HZ (TCLK is 50MHz) */
 	GT_WRITE(GT_TC0_OFS, 50*1000*1000 / HZ);
 
-	/* Enable timer */
+	/* Enable timer0 */
 	GT_WRITE(GT_TC_CONTROL_OFS, GT_TC_CONTROL_ENTC0_MSK | GT_TC_CONTROL_SELTC0_MSK);
 
-	/* Register interrupt */
-	setup_irq(COBALT_GALILEO_IRQ, irq);
-
-	/* Enable interrupt */
-	GT_WRITE(GT_INTRMASK_OFS, GT_INTR_T0EXP_MSK | GT_READ(GT_INTRMASK_OFS));
+	setup_irq(GT641XX_TIMER0_IRQ, irq);
 }
 
 /*
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/kernel/Makefile mips/arch/mips/kernel/Makefile
--- mips-orig/arch/mips/kernel/Makefile	2007-09-11 10:54:34.675076250 +0900
+++ mips/arch/mips/kernel/Makefile	2007-09-11 10:03:05.077988500 +0900
@@ -51,6 +51,7 @@ obj-$(CONFIG_IRQ_CPU_RM7K)	+= irq-rm7000
 obj-$(CONFIG_IRQ_CPU_RM9K)	+= irq-rm9000.o
 obj-$(CONFIG_MIPS_BOARDS_GEN)	+= irq-msc01.o
 obj-$(CONFIG_IRQ_TXX9)		+= irq_txx9.o
+obj-$(CONFIG_IRQ_GT641XX)	+= irq-gt641xx.o
 
 obj-$(CONFIG_32BIT)		+= scall32-o32.o
 obj-$(CONFIG_64BIT)		+= scall64-64.o
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/kernel/irq-gt641xx.c mips/arch/mips/kernel/irq-gt641xx.c
--- mips-orig/arch/mips/kernel/irq-gt641xx.c	1970-01-01 09:00:00.000000000 +0900
+++ mips/arch/mips/kernel/irq-gt641xx.c	2007-09-11 10:03:05.077988500 +0900
@@ -0,0 +1,116 @@
+/*
+ *  GT641xx IRQ routines.
+ *
+ *  Copyright (C) 2007  Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
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
+#include <linux/hardirq.h>
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <linux/types.h>
+
+#include <asm/gt64120.h>
+
+#define GT641XX_IRQ_TO_BIT(irq)	(1U << (irq - GT641XX_IRQ_BASE))
+
+static void ack_gt641xx_irq(unsigned int irq)
+{
+	u32 cause;
+
+	cause = GT_READ(GT_INTRCAUSE_OFS);
+	cause &= ~GT641XX_IRQ_TO_BIT(irq);
+	GT_WRITE(GT_INTRCAUSE_OFS, cause);
+}
+
+static void mask_gt641xx_irq(unsigned int irq)
+{
+	u32 mask;
+
+	mask = GT_READ(GT_INTRMASK_OFS);
+	mask &= ~GT641XX_IRQ_TO_BIT(irq);
+	GT_WRITE(GT_INTRMASK_OFS, mask);
+}
+
+static void mask_ack_gt641xx_irq(unsigned int irq)
+{
+	u32 cause, mask;
+
+	mask = GT_READ(GT_INTRMASK_OFS);
+	mask &= ~GT641XX_IRQ_TO_BIT(irq);
+	GT_WRITE(GT_INTRMASK_OFS, mask);
+
+	cause = GT_READ(GT_INTRCAUSE_OFS);
+	cause &= ~GT641XX_IRQ_TO_BIT(irq);
+	GT_WRITE(GT_INTRCAUSE_OFS, cause);
+}
+
+static void unmask_gt641xx_irq(unsigned int irq)
+{
+	u32 mask;
+
+	mask = GT_READ(GT_INTRMASK_OFS);
+	mask |= GT641XX_IRQ_TO_BIT(irq);
+	GT_WRITE(GT_INTRMASK_OFS, mask);
+}
+
+static struct irq_chip gt641xx_irq_chip = {
+	.name		= "GT641xx",
+	.ack		= ack_gt641xx_irq,
+	.mask		= mask_gt641xx_irq,
+	.mask_ack	= mask_ack_gt641xx_irq,
+	.unmask		= unmask_gt641xx_irq,
+};
+
+void gt641xx_irq_dispatch(void)
+{
+	u32 cause, mask;
+	int i;
+
+	cause = GT_READ(GT_INTRCAUSE_OFS);
+	mask = GT_READ(GT_INTRMASK_OFS);
+	cause &= mask;
+
+	/*
+	 * bit0 : logical or of all the interrupt bits.
+	 * bit30: logical or of bits[29:26,20:1].
+	 * bit31: logical or of bits[25:1].
+	 */
+	for (i = 1; i < 30; i++) {
+		if (cause & (1U << i)) {
+			do_IRQ(GT641XX_IRQ_BASE + i);
+			return;
+		}
+	}
+
+	atomic_inc(&irq_err_count);
+}
+
+void __init gt641xx_irq_init(void)
+{
+	int i;
+
+	GT_WRITE(GT_INTRMASK_OFS, 0);
+	GT_WRITE(GT_INTRCAUSE_OFS, 0);
+
+	/*
+	 * bit0 : logical or of all the interrupt bits.
+	 * bit30: logical or of bits[29:26,20:1].
+	 * bit31: logical or of bits[25:1].
+	 */
+	for (i = 1; i < 30; i++)
+		set_irq_chip_and_handler(GT641XX_IRQ_BASE + i,
+		                         &gt641xx_irq_chip, handle_level_irq);
+}
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/pci/fixup-cobalt.c mips/arch/mips/pci/fixup-cobalt.c
--- mips-orig/arch/mips/pci/fixup-cobalt.c	2007-09-11 10:54:34.703078000 +0900
+++ mips/arch/mips/pci/fixup-cobalt.c	2007-09-11 10:03:28.043423750 +0900
@@ -18,6 +18,7 @@
 #include <asm/gt64120.h>
 
 #include <cobalt.h>
+#include <irq.h>
 
 static void qube_raq_galileo_early_fixup(struct pci_dev *dev)
 {
@@ -132,29 +133,29 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_V
 
 static char irq_tab_qube1[] __initdata = {
   [COBALT_PCICONF_CPU]     = 0,
-  [COBALT_PCICONF_ETH0]    = COBALT_QUBE1_ETH0_IRQ,
-  [COBALT_PCICONF_RAQSCSI] = COBALT_SCSI_IRQ,
+  [COBALT_PCICONF_ETH0]    = QUBE1_ETH0_IRQ,
+  [COBALT_PCICONF_RAQSCSI] = SCSI_IRQ,
   [COBALT_PCICONF_VIA]     = 0,
-  [COBALT_PCICONF_PCISLOT] = COBALT_QUBE_SLOT_IRQ,
+  [COBALT_PCICONF_PCISLOT] = PCISLOT_IRQ,
   [COBALT_PCICONF_ETH1]    = 0
 };
 
 static char irq_tab_cobalt[] __initdata = {
   [COBALT_PCICONF_CPU]     = 0,
-  [COBALT_PCICONF_ETH0]    = COBALT_ETH0_IRQ,
-  [COBALT_PCICONF_RAQSCSI] = COBALT_SCSI_IRQ,
+  [COBALT_PCICONF_ETH0]    = ETH0_IRQ,
+  [COBALT_PCICONF_RAQSCSI] = SCSI_IRQ,
   [COBALT_PCICONF_VIA]     = 0,
-  [COBALT_PCICONF_PCISLOT] = COBALT_QUBE_SLOT_IRQ,
-  [COBALT_PCICONF_ETH1]    = COBALT_ETH1_IRQ
+  [COBALT_PCICONF_PCISLOT] = PCISLOT_IRQ,
+  [COBALT_PCICONF_ETH1]    = ETH1_IRQ
 };
 
 static char irq_tab_raq2[] __initdata = {
   [COBALT_PCICONF_CPU]     = 0,
-  [COBALT_PCICONF_ETH0]    = COBALT_ETH0_IRQ,
-  [COBALT_PCICONF_RAQSCSI] = COBALT_RAQ_SCSI_IRQ,
+  [COBALT_PCICONF_ETH0]    = ETH0_IRQ,
+  [COBALT_PCICONF_RAQSCSI] = RAQ2_SCSI_IRQ,
   [COBALT_PCICONF_VIA]     = 0,
-  [COBALT_PCICONF_PCISLOT] = COBALT_QUBE_SLOT_IRQ,
-  [COBALT_PCICONF_ETH1]    = COBALT_ETH1_IRQ
+  [COBALT_PCICONF_PCISLOT] = PCISLOT_IRQ,
+  [COBALT_PCICONF_ETH1]    = ETH1_IRQ
 };
 
 int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
diff -pruN -X mips/Documentation/dontdiff mips-orig/include/asm-mips/irq_gt641xx.h mips/include/asm-mips/irq_gt641xx.h
--- mips-orig/include/asm-mips/irq_gt641xx.h	1970-01-01 09:00:00.000000000 +0900
+++ mips/include/asm-mips/irq_gt641xx.h	2007-09-11 10:03:05.113990750 +0900
@@ -0,0 +1,60 @@
+/*
+ *  Galileo/Marvell GT641xx IRQ definitions.
+ *
+ *  Copyright (C) 2007  Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
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
+#ifndef _ASM_IRQ_GT641XX_H
+#define _ASM_IRQ_GT641XX_H
+
+#ifndef GT641XX_IRQ_BASE
+#define GT641XX_IRQ_BASE		8
+#endif
+
+#define GT641XX_MEMORY_OUT_OF_RANGE_IRQ		(GT641XX_IRQ_BASE + 1)
+#define GT641XX_DMA_OUT_OF_RANGE_IRQ		(GT641XX_IRQ_BASE + 2)
+#define GT641XX_CPU_ACCESS_OUT_OF_RANGE_IRQ	(GT641XX_IRQ_BASE + 3)
+#define GT641XX_DMA0_IRQ			(GT641XX_IRQ_BASE + 4)
+#define GT641XX_DMA1_IRQ			(GT641XX_IRQ_BASE + 5)
+#define GT641XX_DMA2_IRQ			(GT641XX_IRQ_BASE + 6)
+#define GT641XX_DMA3_IRQ			(GT641XX_IRQ_BASE + 7)
+#define GT641XX_TIMER0_IRQ			(GT641XX_IRQ_BASE + 8)
+#define GT641XX_TIMER1_IRQ			(GT641XX_IRQ_BASE + 9)
+#define GT641XX_TIMER2_IRQ			(GT641XX_IRQ_BASE + 10)
+#define GT641XX_TIMER3_IRQ			(GT641XX_IRQ_BASE + 11)
+#define GT641XX_PCI_0_MASTER_READ_ERROR_IRQ	(GT641XX_IRQ_BASE + 12)
+#define GT641XX_PCI_0_SLAVE_WRITE_ERROR_IRQ	(GT641XX_IRQ_BASE + 13)
+#define GT641XX_PCI_0_MASTER_WRITE_ERROR_IRQ	(GT641XX_IRQ_BASE + 14)
+#define GT641XX_PCI_0_SLAVE_READ_ERROR_IRQ	(GT641XX_IRQ_BASE + 15)
+#define GT641XX_PCI_0_ADDRESS_ERROR_IRQ		(GT641XX_IRQ_BASE + 16)
+#define GT641XX_MEMORY_ERROR_IRQ		(GT641XX_IRQ_BASE + 17)
+#define GT641XX_PCI_0_MASTER_ABORT_IRQ		(GT641XX_IRQ_BASE + 18)
+#define GT641XX_PCI_0_TARGET_ABORT_IRQ		(GT641XX_IRQ_BASE + 19)
+#define GT641XX_PCI_0_RETRY_TIMEOUT_IRQ		(GT641XX_IRQ_BASE + 20)
+#define GT641XX_CPU_INT0_IRQ			(GT641XX_IRQ_BASE + 21)
+#define GT641XX_CPU_INT1_IRQ			(GT641XX_IRQ_BASE + 22)
+#define GT641XX_CPU_INT2_IRQ			(GT641XX_IRQ_BASE + 23)
+#define GT641XX_CPU_INT3_IRQ			(GT641XX_IRQ_BASE + 24)
+#define GT641XX_CPU_INT4_IRQ			(GT641XX_IRQ_BASE + 25)
+#define GT641XX_PCI_INT0_IRQ			(GT641XX_IRQ_BASE + 26)
+#define GT641XX_PCI_INT1_IRQ			(GT641XX_IRQ_BASE + 27)
+#define GT641XX_PCI_INT2_IRQ			(GT641XX_IRQ_BASE + 28)
+#define GT641XX_PCI_INT3_IRQ			(GT641XX_IRQ_BASE + 29)
+
+extern void gt641xx_irq_dispatch(void);
+extern void gt641xx_irq_init(void);
+
+#endif /* _ASM_IRQ_GT641XX_H */
diff -pruN -X mips/Documentation/dontdiff mips-orig/include/asm-mips/mach-cobalt/cobalt.h mips/include/asm-mips/mach-cobalt/cobalt.h
--- mips-orig/include/asm-mips/mach-cobalt/cobalt.h	2007-09-11 10:54:34.723079250 +0900
+++ mips/include/asm-mips/mach-cobalt/cobalt.h	2007-09-11 10:03:28.059424750 +0900
@@ -12,32 +12,6 @@
 #ifndef __ASM_COBALT_H
 #define __ASM_COBALT_H
 
-#include <irq.h>
-
-/*
- * i8259 legacy interrupts used on Cobalt:
- *
- *     8  - RTC
- *     9  - PCI
- *    14  - IDE0
- *    15  - IDE1
- */
-#define COBALT_QUBE_SLOT_IRQ	9
-
-/*
- * CPU IRQs  are 16 ... 23
- */
-#define COBALT_CPU_IRQ		MIPS_CPU_IRQ_BASE
-
-#define COBALT_GALILEO_IRQ	(COBALT_CPU_IRQ + 2)
-#define COBALT_RAQ_SCSI_IRQ	(COBALT_CPU_IRQ + 3)
-#define COBALT_ETH0_IRQ		(COBALT_CPU_IRQ + 3)
-#define COBALT_QUBE1_ETH0_IRQ	(COBALT_CPU_IRQ + 4)
-#define COBALT_ETH1_IRQ		(COBALT_CPU_IRQ + 4)
-#define COBALT_SERIAL_IRQ	(COBALT_CPU_IRQ + 5)
-#define COBALT_SCSI_IRQ         (COBALT_CPU_IRQ + 5)
-#define COBALT_VIA_IRQ		(COBALT_CPU_IRQ + 6)	/* Chained to VIA ISA bridge */
-
 /*
  * PCI configuration space manifest constants.  These are wired into
  * the board layout according to the PCI spec to enable the software
diff -pruN -X mips/Documentation/dontdiff mips-orig/include/asm-mips/mach-cobalt/irq.h mips/include/asm-mips/mach-cobalt/irq.h
--- mips-orig/include/asm-mips/mach-cobalt/irq.h	1970-01-01 09:00:00.000000000 +0900
+++ mips/include/asm-mips/mach-cobalt/irq.h	2007-09-11 10:54:00.292927500 +0900
@@ -0,0 +1,58 @@
+/*
+ * Cobalt IRQ definitions.
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 1997 Cobalt Microserver
+ * Copyright (C) 1997, 2003 Ralf Baechle
+ * Copyright (C) 2001-2003 Liam Davies (ldavies@agile.tv)
+ * Copyright (C) 2007 Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
+ */
+#ifndef _ASM_COBALT_IRQ_H
+#define _ASM_COBALT_IRQ_H
+
+/*
+ * i8259 interrupts used on Cobalt:
+ *
+ *	8  - RTC
+ *	9  - PCI slot
+ *	14 - IDE0
+ *	15 - IDE1(no connector on board)
+ */
+#define I8259A_IRQ_BASE			0
+
+#define PCISLOT_IRQ			(I8259A_IRQ_BASE + 9)
+
+/*
+ * CPU interrupts used on Cobalt:
+ *
+ *	0 - Software interrupt 0 (unused)
+ *	1 - Software interrupt 0 (unused)
+ *	2 - cascade GT64111
+ *	3 - ethernet or SCSI host controller
+ *	4 - ehternet 
+ *	5 - 16550 UART
+ *	6 - cascade i8259
+ *	7 - CP0 counter (unused)
+ */
+#define MIPS_CPU_IRQ_BASE		16
+
+#define GT641XX_CASCADE_IRQ		(MIPS_CPU_IRQ_BASE + 2)
+#define RAQ2_SCSI_IRQ			(MIPS_CPU_IRQ_BASE + 3)
+#define ETH0_IRQ			(MIPS_CPU_IRQ_BASE + 3)
+#define QUBE1_ETH0_IRQ			(MIPS_CPU_IRQ_BASE + 4)
+#define ETH1_IRQ			(MIPS_CPU_IRQ_BASE + 4)
+#define SERIAL_IRQ			(MIPS_CPU_IRQ_BASE + 5)
+#define SCSI_IRQ			(MIPS_CPU_IRQ_BASE + 5)
+#define I8259_CASCADE_IRQ		(MIPS_CPU_IRQ_BASE + 6)
+
+
+#define GT641XX_IRQ_BASE		24
+
+#include <asm/irq_gt641xx.h>
+
+#define NR_IRQS					(GT641XX_PCI_INT3_IRQ + 1)
+
+#endif /* _ASM_COBALT_IRQ_H */
