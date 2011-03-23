Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Mar 2011 22:21:47 +0100 (CET)
Received: from www.linutronix.de ([62.245.132.108]:47501 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491938Ab1CWVJU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Mar 2011 22:09:20 +0100
Received: from localhost ([127.0.0.1] helo=localhost6.localdomain6)
        by Galois.linutronix.de with esmtp (Exim 4.72)
        (envelope-from <tglx@linutronix.de>)
        id 1Q2VIo-0001x1-Iy; Wed, 23 Mar 2011 22:09:15 +0100
Message-Id: <20110323210537.691899621@linutronix.de>
User-Agent: quilt/0.48-1
Date:   Wed, 23 Mar 2011 21:09:14 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>
Subject: [patch 33/38] mips: sybyte: Convert to new irq_chip functions
References: <20110323210437.398062704@linutronix.de>
Content-Disposition: inline; filename=mips-sybyte.patch
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29462
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
Precedence: bulk
X-list: linux-mips

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/mips/sibyte/bcm1480/irq.c |   55 ++++++++++++++---------------------------
 arch/mips/sibyte/sb1250/irq.c  |   53 +++++++++++----------------------------
 2 files changed, 35 insertions(+), 73 deletions(-)

Index: linux-mips-next/arch/mips/sibyte/bcm1480/irq.c
===================================================================
--- linux-mips-next.orig/arch/mips/sibyte/bcm1480/irq.c
+++ linux-mips-next/arch/mips/sibyte/bcm1480/irq.c
@@ -44,31 +44,10 @@
  * for interrupt lines
  */
 
-
-static void end_bcm1480_irq(unsigned int irq);
-static void enable_bcm1480_irq(unsigned int irq);
-static void disable_bcm1480_irq(unsigned int irq);
-static void ack_bcm1480_irq(unsigned int irq);
-#ifdef CONFIG_SMP
-static int bcm1480_set_affinity(unsigned int irq, const struct cpumask *mask);
-#endif
-
 #ifdef CONFIG_PCI
 extern unsigned long ht_eoi_space;
 #endif
 
-static struct irq_chip bcm1480_irq_type = {
-	.name = "BCM1480-IMR",
-	.ack = ack_bcm1480_irq,
-	.mask = disable_bcm1480_irq,
-	.mask_ack = ack_bcm1480_irq,
-	.unmask = enable_bcm1480_irq,
-	.end = end_bcm1480_irq,
-#ifdef CONFIG_SMP
-	.set_affinity = bcm1480_set_affinity
-#endif
-};
-
 /* Store the CPU id (not the logical number) */
 int bcm1480_irq_owner[BCM1480_NR_IRQS];
 
@@ -109,12 +88,13 @@ void bcm1480_unmask_irq(int cpu, int irq
 }
 
 #ifdef CONFIG_SMP
-static int bcm1480_set_affinity(unsigned int irq, const struct cpumask *mask)
+static int bcm1480_set_affinity(struct irq_data *d, const struct cpumask *mask,
+				bool force)
 {
+	unsigned int irq_dirty, irq = d->irq;
 	int i = 0, old_cpu, cpu, int_on, k;
 	u64 cur_ints;
 	unsigned long flags;
-	unsigned int irq_dirty;
 
 	i = cpumask_first(mask);
 
@@ -156,21 +136,25 @@ static int bcm1480_set_affinity(unsigned
 
 /*****************************************************************************/
 
-static void disable_bcm1480_irq(unsigned int irq)
+static void disable_bcm1480_irq(struct irq_data *d)
 {
+	unsigned int irq = d->irq;
+
 	bcm1480_mask_irq(bcm1480_irq_owner[irq], irq);
 }
 
-static void enable_bcm1480_irq(unsigned int irq)
+static void enable_bcm1480_irq(struct irq_data *d)
 {
+	unsigned int irq = d->irq;
+
 	bcm1480_unmask_irq(bcm1480_irq_owner[irq], irq);
 }
 
 
-static void ack_bcm1480_irq(unsigned int irq)
+static void ack_bcm1480_irq(struct irq_data *d)
 {
+	unsigned int irq_dirty, irq = d->irq;
 	u64 pending;
-	unsigned int irq_dirty;
 	int k;
 
 	/*
@@ -217,14 +201,15 @@ static void ack_bcm1480_irq(unsigned int
 	bcm1480_mask_irq(bcm1480_irq_owner[irq], irq);
 }
 
-
-static void end_bcm1480_irq(unsigned int irq)
-{
-	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS))) {
-		bcm1480_unmask_irq(bcm1480_irq_owner[irq], irq);
-	}
-}
-
+static struct irq_chip bcm1480_irq_type = {
+	.name = "BCM1480-IMR",
+	.irq_mask_ack = ack_bcm1480_irq,
+	.irq_mask = disable_bcm1480_irq,
+	.irq_unmask = enable_bcm1480_irq,
+#ifdef CONFIG_SMP
+	.irq_set_affinity = bcm1480_set_affinity
+#endif
+};
 
 void __init init_bcm1480_irqs(void)
 {
Index: linux-mips-next/arch/mips/sibyte/sb1250/irq.c
===================================================================
--- linux-mips-next.orig/arch/mips/sibyte/sb1250/irq.c
+++ linux-mips-next/arch/mips/sibyte/sb1250/irq.c
@@ -43,31 +43,10 @@
  * for interrupt lines
  */
 
-
-static void end_sb1250_irq(unsigned int irq);
-static void enable_sb1250_irq(unsigned int irq);
-static void disable_sb1250_irq(unsigned int irq);
-static void ack_sb1250_irq(unsigned int irq);
-#ifdef CONFIG_SMP
-static int sb1250_set_affinity(unsigned int irq, const struct cpumask *mask);
-#endif
-
 #ifdef CONFIG_SIBYTE_HAS_LDT
 extern unsigned long ldt_eoi_space;
 #endif
 
-static struct irq_chip sb1250_irq_type = {
-	.name = "SB1250-IMR",
-	.ack = ack_sb1250_irq,
-	.mask = disable_sb1250_irq,
-	.mask_ack = ack_sb1250_irq,
-	.unmask = enable_sb1250_irq,
-	.end = end_sb1250_irq,
-#ifdef CONFIG_SMP
-	.set_affinity = sb1250_set_affinity
-#endif
-};
-
 /* Store the CPU id (not the logical number) */
 int sb1250_irq_owner[SB1250_NR_IRQS];
 
@@ -102,9 +81,11 @@ void sb1250_unmask_irq(int cpu, int irq)
 }
 
 #ifdef CONFIG_SMP
-static int sb1250_set_affinity(unsigned int irq, const struct cpumask *mask)
+static int sb1250_set_affinity(struct irq_data *d, const struct cpumask *mask,
+			       bool force)
 {
 	int i = 0, old_cpu, cpu, int_on;
+	unsigned int irq = d->irq;
 	u64 cur_ints;
 	unsigned long flags;
 
@@ -142,21 +123,17 @@ static int sb1250_set_affinity(unsigned 
 }
 #endif
 
-/*****************************************************************************/
-
-static void disable_sb1250_irq(unsigned int irq)
+static void enable_sb1250_irq(struct irq_data *d)
 {
-	sb1250_mask_irq(sb1250_irq_owner[irq], irq);
-}
+	unsigned int irq = d->irq;
 
-static void enable_sb1250_irq(unsigned int irq)
-{
 	sb1250_unmask_irq(sb1250_irq_owner[irq], irq);
 }
 
 
-static void ack_sb1250_irq(unsigned int irq)
+static void ack_sb1250_irq(struct irq_data *d)
 {
+	unsigned int irq = d->irq;
 #ifdef CONFIG_SIBYTE_HAS_LDT
 	u64 pending;
 
@@ -199,14 +176,14 @@ static void ack_sb1250_irq(unsigned int 
 	sb1250_mask_irq(sb1250_irq_owner[irq], irq);
 }
 
-
-static void end_sb1250_irq(unsigned int irq)
-{
-	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS))) {
-		sb1250_unmask_irq(sb1250_irq_owner[irq], irq);
-	}
-}
-
+static struct irq_chip sb1250_irq_type = {
+	.name = "SB1250-IMR",
+	.irq_mask_ack = ack_sb1250_irq,
+	.irq_unmask = enable_sb1250_irq,
+#ifdef CONFIG_SMP
+	.irq_set_affinity = sb1250_set_affinity
+#endif
+};
 
 void __init init_sb1250_irqs(void)
 {
