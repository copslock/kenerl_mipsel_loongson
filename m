Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Aug 2006 15:00:32 +0100 (BST)
Received: from mo32.po.2iij.net ([210.128.50.17]:32272 "EHLO mo32.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20038732AbWHVN6s (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 22 Aug 2006 14:58:48 +0100
Received: by mo.po.2iij.net (mo32) id k7MDwkF4037048; Tue, 22 Aug 2006 22:58:46 +0900 (JST)
Received: from localhost.localdomain (191.28.30.125.dy.iij4u.or.jp [125.30.28.191])
	by mbox.po.2iij.net (mbox33) id k7MDwi9Q012207
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 22 Aug 2006 22:58:45 +0900 (JST)
Date:	Tue, 22 Aug 2006 22:42:10 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 5/12] added new common IRQ routines for GT64111/GT64120
Message-Id: <20060822224210.38d67695.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12401
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has added common IRQ routines for GT64111/GT64120.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/gt64120/cobalt/irq.c mips/arch/mips/gt64120/cobalt/irq.c
--- mips-orig/arch/mips/gt64120/cobalt/irq.c	2006-08-18 22:16:52.068534750 +0900
+++ mips/arch/mips/gt64120/cobalt/irq.c	2006-08-17 22:59:36.226694250 +0900
@@ -7,11 +7,10 @@
  *
  * Copyright (C) 1995, 1996, 1997, 2003 by Ralf Baechle
  */
-#include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/irq.h>
 #include <linux/interrupt.h>
-#include <linux/pci.h>
+#include <linux/irq.h>
+#include <linux/kernel.h>
 
 #include <asm/i8259.h>
 #include <asm/irq_cpu.h>
@@ -37,37 +36,11 @@
  * The VIA chip is a master/slave 8259 setup and has the following interrupts:
  *
  *     8  - RTC
- *     9  - PCI
+ *     9  - PCI slot
  *    14  - IDE0
  *    15  - IDE1
  */
 
-static inline void galileo_irq(struct pt_regs *regs)
-{
-	unsigned int mask, pending, devfn;
-
-	mask = GT_READ(GT_INTRMASK_OFS);
-	pending = GT_READ(GT_INTRCAUSE_OFS) & mask;
-
-	if (pending & GALILEO_INTR_T3EXP) {
-
-		GT_WRITE(GT_INTRCAUSE_OFS, ~GALILEO_INTR_T3EXP);
-		do_IRQ(COBALT_GALILEO_IRQ, regs);
-
-	} else if (pending & GALILEO_INTR_RETRY_CTR) {
-
-		devfn = GT_READ(GT_PCI0_CFGADDR_OFS) >> 8;
-		GT_WRITE(GT_INTRCAUSE_OFS, ~GALILEO_INTR_RETRY_CTR);
-		printk(KERN_WARNING "Galileo: PCI retry count exceeded (%02x.%u)\n",
-			PCI_SLOT(devfn), PCI_FUNC(devfn));
-
-	} else {
-
-		GT_WRITE(GT_INTRMASK_OFS, mask & ~pending);
-		printk(KERN_WARNING "Galileo: masking unexpected interrupt %08x\n", pending);
-	}
-}
-
 static inline void via_pic_irq(struct pt_regs *regs)
 {
 	int irq;
@@ -79,55 +52,38 @@ static inline void via_pic_irq(struct pt
 
 asmlinkage void plat_irq_dispatch(struct pt_regs *regs)
 {
-	unsigned pending;
+	unsigned int pending;
 
-	pending = read_c0_status() & read_c0_cause();
+	pending = read_c0_status() & read_c0_cause() & ST0_IM;
 
 	if (pending & CAUSEF_IP2)			/* COBALT_GALILEO_IRQ (18) */
-
-		galileo_irq(regs);
-
+		gt641xx_irq_dispatch(regs);
 	else if (pending & CAUSEF_IP6)			/* COBALT_VIA_IRQ (22) */
-
 		via_pic_irq(regs);
-
 	else if (pending & CAUSEF_IP3)			/* COBALT_ETH0_IRQ (19) */
-
 		do_IRQ(COBALT_CPU_IRQ + 3, regs);
-
 	else if (pending & CAUSEF_IP4)			/* COBALT_ETH1_IRQ (20) */
-
 		do_IRQ(COBALT_CPU_IRQ + 4, regs);
-
 	else if (pending & CAUSEF_IP5)			/* COBALT_SERIAL_IRQ (21) */
-
 		do_IRQ(COBALT_CPU_IRQ + 5, regs);
-
 	else if (pending & CAUSEF_IP7)			/* IRQ 23 */
-
 		do_IRQ(COBALT_CPU_IRQ + 7, regs);
+	else
+		spurious_interrupt(regs);
 }
 
-static struct irqaction irq_via = {
-	no_action, 0, { { 0, } }, "cascade", NULL, NULL
+static struct irqaction cascade_irqaction = {
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
 	init_i8259_irqs();				/*  0 ... 15 */
 	mips_cpu_irq_init(COBALT_CPU_IRQ);		/* 16 ... 23 */
+	gt641xx_irq_init(COBALT_GT64111_IRQ);		/* 24 ... 55 */
 
-	/*
-	 * Mask all cpu interrupts
-	 *  (except IE4, we already masked those at VIA level)
-	 */
-	change_c0_status(ST0_IM, IE_IRQ4);
-
-	setup_irq(COBALT_VIA_IRQ, &irq_via);
+	setup_irq(COBALT_GALILEO_IRQ, &cascade_irqaction);
+	setup_irq(COBALT_VIA_IRQ, &cascade_irqaction);
 }
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/gt64120/cobalt/setup.c mips/arch/mips/gt64120/cobalt/setup.c
--- mips-orig/arch/mips/gt64120/cobalt/setup.c	2006-08-18 22:16:52.068534750 +0900
+++ mips/arch/mips/gt64120/cobalt/setup.c	2006-08-17 22:59:36.246695500 +0900
@@ -52,7 +52,7 @@ const char *get_system_type(void)
 void __init plat_timer_setup(struct irqaction *irq)
 {
 	/* Register interrupt */
-	setup_irq(COBALT_GALILEO_IRQ, irq);
+	setup_irq(COBALT_TIMER3_IRQ, irq);
 }
 
 extern struct pci_ops gt64120_pci_ops;
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/gt64120/common/Makefile mips/arch/mips/gt64120/common/Makefile
--- mips-orig/arch/mips/gt64120/common/Makefile	2006-08-18 22:16:52.068534750 +0900
+++ mips/arch/mips/gt64120/common/Makefile	2006-08-17 22:59:36.246695500 +0900
@@ -2,4 +2,4 @@
 # Makefile for common code of gt64120-based boards.
 #
 
-obj-y	+= time.o
+obj-y	+= irq.o time.o
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/gt64120/common/irq.c mips/arch/mips/gt64120/common/irq.c
--- mips-orig/arch/mips/gt64120/common/irq.c	1970-01-01 09:00:00.000000000 +0900
+++ mips/arch/mips/gt64120/common/irq.c	2006-08-18 05:59:20.299939500 +0900
@@ -0,0 +1,125 @@
+/*
+ *  Interrupt routines for Galileo GT64111/GT64120
+ *  
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
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+
+#include <asm/gt64120.h>
+
+static unsigned int gt641xx_irq_base;
+
+#define GT641XX_NR_IRQS		32
+#define GT641XX_IRQ_TO_BIT(irq)	(1U << ((irq) - gt641xx_irq_base))
+
+static unsigned int gt641xx_irq_startup(unsigned int irq)
+{
+	uint32_t mask;
+
+	GT_WRITE(GT_INTRCAUSE_OFS, ~GT641XX_IRQ_TO_BIT(irq));
+
+	mask = GT_READ(GT_INTRMASK_OFS);
+	mask |= GT641XX_IRQ_TO_BIT(irq);
+	GT_WRITE(GT_INTRMASK_OFS, mask);
+
+	return 0;
+}
+
+static void gt641xx_irq_shutdown(unsigned int irq)
+{
+	uint32_t mask;
+
+	mask = GT_READ(GT_INTRMASK_OFS);
+	mask &= ~GT641XX_IRQ_TO_BIT(irq);
+	GT_WRITE(GT_INTRMASK_OFS, mask);
+}
+
+static void gt641xx_irq_enable(unsigned int irq)
+{
+	uint32_t mask;
+
+	mask = GT_READ(GT_INTRMASK_OFS);
+	mask |= GT641XX_IRQ_TO_BIT(irq);
+	GT_WRITE(GT_INTRMASK_OFS, mask);
+}
+
+#define gt641xx_irq_disable	gt641xx_irq_shutdown
+
+static void gt641xx_irq_ack(unsigned int irq)
+{
+	uint32_t mask;
+
+	mask = GT_READ(GT_INTRMASK_OFS);
+	mask &= ~GT641XX_IRQ_TO_BIT(irq);
+	GT_WRITE(GT_INTRMASK_OFS, mask);
+	GT_WRITE(GT_INTRCAUSE_OFS, ~GT641XX_IRQ_TO_BIT(irq));
+}
+
+static void gt641xx_irq_end(unsigned int irq)
+{
+	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS))) {
+		uint32_t mask;
+
+		mask = GT_READ(GT_INTRMASK_OFS);
+		mask |= GT641XX_IRQ_TO_BIT(irq);
+		GT_WRITE(GT_INTRMASK_OFS, mask);
+	}
+}
+
+static struct irq_chip gt641xx_irq_chip = {
+	.typename	= "GT641xx",
+	.startup	= gt641xx_irq_startup,
+	.shutdown	= gt641xx_irq_shutdown,
+	.enable		= gt641xx_irq_enable,
+	.disable	= gt641xx_irq_disable,
+	.ack		= gt641xx_irq_ack,
+	.end		= gt641xx_irq_end,
+};
+
+void gt641xx_irq_dispatch(struct pt_regs *regs)
+{
+	uint32_t mask, pending;
+	int i;
+
+	mask = GT_READ(GT_INTRMASK_OFS);
+	pending = GT_READ(GT_INTRCAUSE_OFS);
+	pending &= mask;
+
+	for (i = 0; i < GT641XX_NR_IRQS; i++) {
+		if (pending & (1U << i)) {
+			do_IRQ(gt641xx_irq_base + i, regs);
+			break;
+		}
+	}
+}
+
+void  __init gt641xx_irq_init(unsigned int irq_base)
+{
+	int i;
+
+	if (irq_base >= NR_IRQS)
+		return;
+
+	gt641xx_irq_base = irq_base;
+
+	GT_WRITE(GT_INTRMASK_OFS, 0);
+	GT_WRITE(GT_INTRCAUSE_OFS, 0);
+
+	for (i = irq_base; i < irq_base + GT641XX_NR_IRQS; i++)
+		irq_desc[i].chip = &gt641xx_irq_chip;
+}
diff -pruN -X mips/Documentation/dontdiff mips-orig/include/asm-mips/gt64120.h mips/include/asm-mips/gt64120.h
--- mips-orig/include/asm-mips/gt64120.h	2006-08-18 22:16:52.068534750 +0900
+++ mips/include/asm-mips/gt64120.h	2006-08-17 22:59:36.246695500 +0900
@@ -573,6 +573,10 @@
 #define GT_READ(ofs)		le32_to_cpu(__GT_READ(ofs))
 #define GT_WRITE(ofs, data)	__GT_WRITE(ofs, cpu_to_le32(data))
 
+struct pt_regs;
+extern void gt641xx_irq_dispatch(struct pt_regs *regs);
+extern void gt641xx_irq_init(unsigned int irq_base);
+
 extern void gt641xx_timer3_init(void);
 extern void gt641xx_disable_alltimers(void);
 
diff -pruN -X mips/Documentation/dontdiff mips-orig/include/asm-mips/mach-cobalt/cobalt.h mips/include/asm-mips/mach-cobalt/cobalt.h
--- mips-orig/include/asm-mips/mach-cobalt/cobalt.h	2006-08-18 22:16:52.068534750 +0900
+++ mips/include/asm-mips/mach-cobalt/cobalt.h	2006-08-17 22:59:36.262696500 +0900
@@ -16,18 +16,18 @@
  * i8259 legacy interrupts used on Cobalt:
  *
  *     8  - RTC
- *     9  - PCI
+ *     9  - PCI slot
  *    14  - IDE0
  *    15  - IDE1
  */
 #define COBALT_QUBE_SLOT_IRQ	9
 
 /*
- * CPU IRQs  are 16 ... 23
+ * CPU IRQs are 16 ... 23
  */
 #define COBALT_CPU_IRQ		16
 
-#define COBALT_GALILEO_IRQ	(COBALT_CPU_IRQ + 2)
+#define COBALT_GALILEO_IRQ	(COBALT_CPU_IRQ + 2)	/* Chained to Galileo GT64111 */
 #define COBALT_SCC_IRQ          (COBALT_CPU_IRQ + 3)	/* pre-production has 85C30 */
 #define COBALT_RAQ_SCSI_IRQ	(COBALT_CPU_IRQ + 3)
 #define COBALT_ETH0_IRQ		(COBALT_CPU_IRQ + 3)
@@ -38,6 +38,13 @@
 #define COBALT_VIA_IRQ		(COBALT_CPU_IRQ + 6)	/* Chained to VIA ISA bridge */
 
 /*
+ * GT64111 IRQs are 24 ... 55
+ */
+#define COBALT_GT64111_IRQ	24
+
+#define COBALT_TIMER3_IRQ	(COBALT_GT64111_IRQ + 11)
+
+/*
  * PCI configuration space manifest constants.  These are wired into
  * the board layout according to the PCI spec to enable the software
  * to probe the hardware configuration space in a well defined manner.
