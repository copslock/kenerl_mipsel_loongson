Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 10 Apr 2005 14:09:04 +0100 (BST)
Received: from i-83-67-53-76.freedom2surf.net ([IPv6:::ffff:83.67.53.76]:27521
	"EHLO skeleton-jack.localnet") by linux-mips.org with ESMTP
	id <S8225942AbVDJNIr>; Sun, 10 Apr 2005 14:08:47 +0100
Received: from pdh by skeleton-jack.localnet with local (Exim 3.36 #1 (Debian))
	id 1DKcBG-0005Nq-00; Sun, 10 Apr 2005 14:08:50 +0100
Date:	Sun, 10 Apr 2005 14:08:50 +0100
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: [PATCH Cobalt 2/3] interrupt cleanup
Message-ID: <20050410130850.GA20623@skeleton-jack>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
From:	Peter Horton <pdh@colonel-panic.org>
Return-Path: <pdh@colonel-panic.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7670
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pdh@colonel-panic.org
Precedence: bulk
X-list: linux-mips

Tidy up the Cobalt interrupt handling code.

--

Index: linux/include/asm-mips/cobalt/cobalt.h
===================================================================
--- linux.orig/include/asm-mips/cobalt/cobalt.h	2005-03-04 15:13:37.000000000 +0000
+++ linux/include/asm-mips/cobalt/cobalt.h	2005-04-06 22:43:05.000000000 +0100
@@ -25,15 +25,17 @@
 /*
  * CPU IRQs  are 16 ... 23
  */
-#define COBALT_TIMER_IRQ	18
-#define COBALT_SCC_IRQ          19		/* pre-production has 85C30 */
-#define COBALT_RAQ_SCSI_IRQ	19
-#define COBALT_ETH0_IRQ		19
-#define COBALT_QUBE1_ETH0_IRQ	20
-#define COBALT_ETH1_IRQ		20
-#define COBALT_SERIAL_IRQ	21
-#define COBALT_SCSI_IRQ         21
-#define COBALT_VIA_IRQ		22		/* Chained to VIA ISA bridge */
+#define COBALT_CPU_IRQ		16
+
+#define COBALT_GALILEO_IRQ	(COBALT_CPU_IRQ + 2)
+#define COBALT_SCC_IRQ          (COBALT_CPU_IRQ + 3)	/* pre-production has 85C30 */
+#define COBALT_RAQ_SCSI_IRQ	(COBALT_CPU_IRQ + 3)
+#define COBALT_ETH0_IRQ		(COBALT_CPU_IRQ + 3)
+#define COBALT_QUBE1_ETH0_IRQ	(COBALT_CPU_IRQ + 4)
+#define COBALT_ETH1_IRQ		(COBALT_CPU_IRQ + 4)
+#define COBALT_SERIAL_IRQ	(COBALT_CPU_IRQ + 5)
+#define COBALT_SCSI_IRQ         (COBALT_CPU_IRQ + 5)
+#define COBALT_VIA_IRQ		(COBALT_CPU_IRQ + 6)	/* Chained to VIA ISA bridge */
 
 /*
  * PCI configuration space manifest constants.  These are wired into
@@ -84,7 +86,8 @@
 	*(volatile unsigned int *) GALILEO_REG(port) = (val);		\
 } while (0)
 
-#define GALILEO_T0EXP		0x0100
+#define GALILEO_INTR_T0EXP	(1 << 8)
+
 #define GALILEO_ENTC0		0x01
 #define GALILEO_SELTC0		0x02
 
Index: linux/arch/mips/cobalt/setup.c
===================================================================
--- linux.orig/arch/mips/cobalt/setup.c	2005-03-04 15:13:37.000000000 +0000
+++ linux/arch/mips/cobalt/setup.c	2005-04-06 22:43:05.000000000 +0100
@@ -50,16 +50,17 @@
 
 static void __init cobalt_timer_setup(struct irqaction *irq)
 {
-	/* Load timer value for 1KHz */
+	/* Load timer value for 1KHz (TCLK is 50MHz) */
 	GALILEO_OUTL(50*1000*1000 / 1000, GT_TC0_OFS);
 
-	/* Register our timer interrupt */
-	setup_irq(COBALT_TIMER_IRQ, irq);
+	/* Enable timer */
+	GALILEO_OUTL(GALILEO_ENTC0 | GALILEO_SELTC0, GT_TC_CONTROL_OFS);
 
-	/* Enable timer ints */
-	GALILEO_OUTL((GALILEO_ENTC0 | GALILEO_SELTC0), GT_TC_CONTROL_OFS);
-	/* Unmask timer int */
-	GALILEO_OUTL(GALILEO_T0EXP, GT_INTRMASK_OFS);
+	/* Register interrupt */
+	setup_irq(COBALT_GALILEO_IRQ, irq);
+
+	/* Enable interrupt */
+	GALILEO_OUTL(GALILEO_INTR_T0EXP | GALILEO_INL(GT_INTRMASK_OFS), GT_INTRMASK_OFS);
 }
 
 extern struct pci_ops gt64111_pci_ops;
Index: linux/arch/mips/cobalt/irq.c
===================================================================
--- linux.orig/arch/mips/cobalt/irq.c	2005-02-21 16:41:55.000000000 +0000
+++ linux/arch/mips/cobalt/irq.c	2005-04-06 22:43:34.000000000 +0100
@@ -43,49 +43,63 @@
  *    15  - IDE1
  */
 
-asmlinkage void cobalt_irq(struct pt_regs *regs)
+static inline void galileo_irq(struct pt_regs *regs)
 {
-	unsigned int pending = read_c0_status() & read_c0_cause();
+	unsigned int mask, pending;
 
-	if (pending & CAUSEF_IP2) {			/* int 18 */
-		unsigned long irq_src = GALILEO_INL(GT_INTRCAUSE_OFS);
+	mask = GALILEO_INL(GT_INTRMASK_OFS);
+	pending = GALILEO_INL(GT_INTRCAUSE_OFS) & mask;
 
-		/* Check for timer irq ... */
-		if (irq_src & GALILEO_T0EXP) {
-			/* Clear the int line */
-			GALILEO_OUTL(0, GT_INTRCAUSE_OFS);
-			do_IRQ(COBALT_TIMER_IRQ, regs);
-		}
-		return;
-	}
+	if (pending & GALILEO_INTR_T0EXP) {
 
-	if (pending & CAUSEF_IP6) {			/* int 22 */
-		int irq = i8259_irq();
+		GALILEO_OUTL(~GALILEO_INTR_T0EXP, GT_INTRCAUSE_OFS);
+		do_IRQ(COBALT_GALILEO_IRQ, regs);
 
-		if (irq >= 0)
-			do_IRQ(irq, regs);
-		return;
-	}
+	} else {
 
-	if (pending & CAUSEF_IP3) {			/* int 19 */
-		do_IRQ(COBALT_ETH0_IRQ, regs);
-		return;
+		GALILEO_OUTL(mask & ~pending, GT_INTRMASK_OFS);
+		printk(KERN_WARNING "Galileo: masking unexpected interrupt %08x\n", pending);
 	}
+}
 
-	if (pending & CAUSEF_IP4) {			/* int 20 */
-		do_IRQ(COBALT_ETH1_IRQ, regs);
-		return;
-	}
+static inline void via_pic_irq(struct pt_regs *regs)
+{
+	int irq;
 
-	if (pending & CAUSEF_IP5) {			/* int 21 */
-		do_IRQ(COBALT_SERIAL_IRQ, regs);
-		return;
-	}
+	irq = i8259_irq();
+	if (irq >= 0)
+		do_IRQ(irq, regs);
+}
 
-	if (pending & CAUSEF_IP7) {			/* int 23 */
-		do_IRQ(23, regs);
-		return;
-	}
+asmlinkage void cobalt_irq(struct pt_regs *regs)
+{
+	unsigned pending;
+
+	pending = read_c0_status() & read_c0_cause();
+
+	if (pending & CAUSEF_IP2)			/* COBALT_GALILEO_IRQ (18) */
+
+		galileo_irq(regs);
+
+	else if (pending & CAUSEF_IP6)			/* COBALT_VIA_IRQ (22) */
+
+		via_pic_irq(regs);
+
+	else if (pending & CAUSEF_IP3)			/* COBALT_ETH0_IRQ (19) */
+
+		do_IRQ(COBALT_CPU_IRQ + 3, regs);
+
+	else if (pending & CAUSEF_IP4)			/* COBALT_ETH1_IRQ (20) */
+
+		do_IRQ(COBALT_CPU_IRQ + 4, regs);
+
+	else if (pending & CAUSEF_IP5)			/* COBALT_SERIAL_IRQ (21) */
+
+		do_IRQ(COBALT_CPU_IRQ + 5, regs);
+
+	else if (pending & CAUSEF_IP7)			/* IRQ 23 */
+
+		do_IRQ(COBALT_CPU_IRQ + 7, regs);
 }
 
 static struct irqaction irq_via = {
@@ -94,10 +108,16 @@
  
 void __init arch_init_irq(void)
 {
+	/*
+	 * Mask all Galileo interrupts. The Galileo
+	 * handler is set in cobalt_timer_setup()
+	 */
+	GALILEO_OUTL(0, GT_INTRMASK_OFS);
+
 	set_except_vector(0, cobalt_handle_int);
 
 	init_i8259_irqs();				/*  0 ... 15 */
-	mips_cpu_irq_init(16);				/* 16 ... 23 */
+	mips_cpu_irq_init(COBALT_CPU_IRQ);		/* 16 ... 23 */
 
 	/*
 	 * Mask all cpu interrupts
