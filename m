Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Mar 2011 22:10:53 +0100 (CET)
Received: from www.linutronix.de ([62.245.132.108]:47414 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491903Ab1CWVI4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Mar 2011 22:08:56 +0100
Received: from localhost ([127.0.0.1] helo=localhost6.localdomain6)
        by Galois.linutronix.de with esmtp (Exim 4.72)
        (envelope-from <tglx@linutronix.de>)
        id 1Q2VIP-0001vU-4C; Wed, 23 Mar 2011 22:08:50 +0100
Message-Id: <20110323210535.042979916@linutronix.de>
User-Agent: quilt/0.48-1
Date:   Wed, 23 Mar 2011 21:08:48 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>
Subject: [patch 05/38] mips: cavium-octeon: Convert to new irq_chip functions
References: <20110323210437.398062704@linutronix.de>
Content-Disposition: inline; filename=mips-cav-oct.patch
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29434
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
Precedence: bulk
X-list: linux-mips

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/mips/cavium-octeon/octeon-irq.c |  237 ++++++++++++++++-------------------
 arch/mips/pci/msi-octeon.c           |   20 +-
 2 files changed, 120 insertions(+), 137 deletions(-)

Index: linux-mips-next/arch/mips/cavium-octeon/octeon-irq.c
===================================================================
--- linux-mips-next.orig/arch/mips/cavium-octeon/octeon-irq.c
+++ linux-mips-next/arch/mips/cavium-octeon/octeon-irq.c
@@ -23,9 +23,9 @@ static int octeon_coreid_for_cpu(int cpu
 #endif
 }
 
-static void octeon_irq_core_ack(unsigned int irq)
+static void octeon_irq_core_ack(struct irq_data *d)
 {
-	unsigned int bit = irq - OCTEON_IRQ_SW0;
+	unsigned int bit = d->irq - OCTEON_IRQ_SW0;
 	/*
 	 * We don't need to disable IRQs to make these atomic since
 	 * they are already disabled earlier in the low level
@@ -37,17 +37,9 @@ static void octeon_irq_core_ack(unsigned
 		clear_c0_cause(0x100 << bit);
 }
 
-static void octeon_irq_core_eoi(unsigned int irq)
+static void octeon_irq_core_eoi(struct irq_data *d)
 {
-	struct irq_desc *desc = irq_to_desc(irq);
-	unsigned int bit = irq - OCTEON_IRQ_SW0;
-	/*
-	 * If an IRQ is being processed while we are disabling it the
-	 * handler will attempt to unmask the interrupt after it has
-	 * been disabled.
-	 */
-	if ((unlikely(desc->status & IRQ_DISABLED)))
-		return;
+	unsigned int bit = d->irq - OCTEON_IRQ_SW0;
 	/*
 	 * We don't need to disable IRQs to make these atomic since
 	 * they are already disabled earlier in the low level
@@ -56,10 +48,10 @@ static void octeon_irq_core_eoi(unsigned
 	set_c0_status(0x100 << bit);
 }
 
-static void octeon_irq_core_enable(unsigned int irq)
+static void octeon_irq_core_enable(struct irq_data *d)
 {
 	unsigned long flags;
-	unsigned int bit = irq - OCTEON_IRQ_SW0;
+	unsigned int bit = d->irq - OCTEON_IRQ_SW0;
 
 	/*
 	 * We need to disable interrupts to make sure our updates are
@@ -83,22 +75,23 @@ static void octeon_irq_core_disable_loca
 	local_irq_restore(flags);
 }
 
-static void octeon_irq_core_disable(unsigned int irq)
+static void octeon_irq_core_disable(struct irq_data *d)
 {
 #ifdef CONFIG_SMP
 	on_each_cpu((void (*)(void *)) octeon_irq_core_disable_local,
-		    (void *) (long) irq, 1);
+		    (void *) (long) d->irq, 1);
 #else
-	octeon_irq_core_disable_local(irq);
+	octeon_irq_core_disable_local(d->irq);
 #endif
 }
 
 static struct irq_chip octeon_irq_chip_core = {
 	.name = "Core",
-	.enable = octeon_irq_core_enable,
-	.disable = octeon_irq_core_disable,
-	.ack = octeon_irq_core_ack,
-	.eoi = octeon_irq_core_eoi,
+	.irq_enable = octeon_irq_core_enable,
+	.irq_disable = octeon_irq_core_disable,
+	.irq_ack = octeon_irq_core_ack,
+	.irq_eoi = octeon_irq_core_eoi,
+	.flags = IRQCHIP_EOI_IF_HANDLED,
 };
 
 
@@ -141,7 +134,7 @@ static void octeon_irq_ciu0_ack(unsigned
 	clear_c0_status(0x100 << 2);
 }
 
-static void octeon_irq_ciu0_eoi(unsigned int irq)
+static void octeon_irq_ciu0_eoi(struct irq_data *d)
 {
 	/*
 	 * Enable all CIU interrupts again.  We don't need to disable
@@ -151,17 +144,16 @@ static void octeon_irq_ciu0_eoi(unsigned
 	set_c0_status(0x100 << 2);
 }
 
-static int next_coreid_for_irq(struct irq_desc *desc)
+static int next_coreid_for_irq(struct irq_data *d)
 {
-
 #ifdef CONFIG_SMP
 	int coreid;
-	int weight = cpumask_weight(desc->affinity);
+	int weight = cpumask_weight(d->affinity);
 
 	if (weight > 1) {
 		int cpu = smp_processor_id();
 		for (;;) {
-			cpu = cpumask_next(cpu, desc->affinity);
+			cpu = cpumask_next(cpu, d->affinity);
 			if (cpu >= nr_cpu_ids) {
 				cpu = -1;
 				continue;
@@ -171,7 +163,7 @@ static int next_coreid_for_irq(struct ir
 		}
 		coreid = octeon_coreid_for_cpu(cpu);
 	} else if (weight == 1) {
-		coreid = octeon_coreid_for_cpu(cpumask_first(desc->affinity));
+		coreid = octeon_coreid_for_cpu(cpumask_first(d->affinity));
 	} else {
 		coreid = cvmx_get_core_num();
 	}
@@ -181,13 +173,12 @@ static int next_coreid_for_irq(struct ir
 #endif
 }
 
-static void octeon_irq_ciu0_enable(unsigned int irq)
+static void octeon_irq_ciu0_enable(struct irq_data *d)
 {
-	struct irq_desc *desc = irq_to_desc(irq);
-	int coreid = next_coreid_for_irq(desc);
+	int coreid = next_coreid_for_irq(d);
 	unsigned long flags;
 	uint64_t en0;
-	int bit = irq - OCTEON_IRQ_WORKQ0;	/* Bit 0-63 of EN0 */
+	int bit = d->irq - OCTEON_IRQ_WORKQ0;	/* Bit 0-63 of EN0 */
 
 	raw_spin_lock_irqsave(&octeon_irq_ciu0_lock, flags);
 	en0 = cvmx_read_csr(CVMX_CIU_INTX_EN0(coreid * 2));
@@ -197,12 +188,12 @@ static void octeon_irq_ciu0_enable(unsig
 	raw_spin_unlock_irqrestore(&octeon_irq_ciu0_lock, flags);
 }
 
-static void octeon_irq_ciu0_enable_mbox(unsigned int irq)
+static void octeon_irq_ciu0_enable_mbox(struct irq_data *d)
 {
 	int coreid = cvmx_get_core_num();
 	unsigned long flags;
 	uint64_t en0;
-	int bit = irq - OCTEON_IRQ_WORKQ0;	/* Bit 0-63 of EN0 */
+	int bit = d->irq - OCTEON_IRQ_WORKQ0;	/* Bit 0-63 of EN0 */
 
 	raw_spin_lock_irqsave(&octeon_irq_ciu0_lock, flags);
 	en0 = cvmx_read_csr(CVMX_CIU_INTX_EN0(coreid * 2));
@@ -212,9 +203,9 @@ static void octeon_irq_ciu0_enable_mbox(
 	raw_spin_unlock_irqrestore(&octeon_irq_ciu0_lock, flags);
 }
 
-static void octeon_irq_ciu0_disable(unsigned int irq)
+static void octeon_irq_ciu0_disable(struct irq_data *d)
 {
-	int bit = irq - OCTEON_IRQ_WORKQ0;	/* Bit 0-63 of EN0 */
+	int bit = d->irq - OCTEON_IRQ_WORKQ0;	/* Bit 0-63 of EN0 */
 	unsigned long flags;
 	uint64_t en0;
 	int cpu;
@@ -237,26 +228,22 @@ static void octeon_irq_ciu0_disable(unsi
  * Enable the irq on the next core in the affinity set for chips that
  * have the EN*_W1{S,C} registers.
  */
-static void octeon_irq_ciu0_enable_v2(unsigned int irq)
+static void octeon_irq_ciu0_enable_v2(struct irq_data *d)
 {
-	int index;
-	u64 mask = 1ull << (irq - OCTEON_IRQ_WORKQ0);
-	struct irq_desc *desc = irq_to_desc(irq);
+	u64 mask = 1ull << (d->irq - OCTEON_IRQ_WORKQ0);
+	int index = next_coreid_for_irq(d) * 2;
 
-	if ((desc->status & IRQ_DISABLED) == 0) {
-		index = next_coreid_for_irq(desc) * 2;
-		cvmx_write_csr(CVMX_CIU_INTX_EN0_W1S(index), mask);
-	}
+	cvmx_write_csr(CVMX_CIU_INTX_EN0_W1S(index), mask);
 }
 
 /*
  * Enable the irq on the current CPU for chips that
  * have the EN*_W1{S,C} registers.
  */
-static void octeon_irq_ciu0_enable_mbox_v2(unsigned int irq)
+static void octeon_irq_ciu0_enable_mbox_v2(struct irq_data *d)
 {
 	int index;
-	u64 mask = 1ull << (irq - OCTEON_IRQ_WORKQ0);
+	u64 mask = 1ull << (d->irq - OCTEON_IRQ_WORKQ0);
 
 	index = cvmx_get_core_num() * 2;
 	cvmx_write_csr(CVMX_CIU_INTX_EN0_W1S(index), mask);
@@ -297,23 +284,21 @@ static void octeon_irq_ciu0_ack_v2(unsig
  * Enable the irq on the current core for chips that have the EN*_W1{S,C}
  * registers.
  */
-static void octeon_irq_ciu0_eoi_mbox_v2(unsigned int irq)
+static void octeon_irq_ciu0_eoi_mbox_v2(struct irq_data *d)
 {
-	struct irq_desc *desc = irq_to_desc(irq);
 	int index = cvmx_get_core_num() * 2;
-	u64 mask = 1ull << (irq - OCTEON_IRQ_WORKQ0);
+	u64 mask = 1ull << (d->irq - OCTEON_IRQ_WORKQ0);
 
-	if (likely((desc->status & IRQ_DISABLED) == 0))
-		cvmx_write_csr(CVMX_CIU_INTX_EN0_W1S(index), mask);
+	cvmx_write_csr(CVMX_CIU_INTX_EN0_W1S(index), mask);
 }
 
 /*
  * Disable the irq on the all cores for chips that have the EN*_W1{S,C}
  * registers.
  */
-static void octeon_irq_ciu0_disable_all_v2(unsigned int irq)
+static void octeon_irq_ciu0_disable_all_v2(struct irq_data *d)
 {
-	u64 mask = 1ull << (irq - OCTEON_IRQ_WORKQ0);
+	u64 mask = 1ull << (d->irq - OCTEON_IRQ_WORKQ0);
 	int index;
 	int cpu;
 	for_each_online_cpu(cpu) {
@@ -323,13 +308,14 @@ static void octeon_irq_ciu0_disable_all_
 }
 
 #ifdef CONFIG_SMP
-static int octeon_irq_ciu0_set_affinity(unsigned int irq, const struct cpumask *dest)
+static int octeon_irq_ciu0_set_affinity(struct irq_data *d,
+					const struct cpumask *dest, bool force)
 {
 	int cpu;
-	struct irq_desc *desc = irq_to_desc(irq);
+	struct irq_desc *desc = irq_to_desc(d->irq);
 	int enable_one = (desc->status & IRQ_DISABLED) == 0;
 	unsigned long flags;
-	int bit = irq - OCTEON_IRQ_WORKQ0;	/* Bit 0-63 of EN0 */
+	int bit = d->irq - OCTEON_IRQ_WORKQ0;	/* Bit 0-63 of EN0 */
 
 	/*
 	 * For non-v2 CIU, we will allow only single CPU affinity.
@@ -366,14 +352,15 @@ static int octeon_irq_ciu0_set_affinity(
  * Set affinity for the irq for chips that have the EN*_W1{S,C}
  * registers.
  */
-static int octeon_irq_ciu0_set_affinity_v2(unsigned int irq,
-					   const struct cpumask *dest)
+static int octeon_irq_ciu0_set_affinity_v2(struct irq_data *d,
+					   const struct cpumask *dest,
+					   bool force)
 {
 	int cpu;
 	int index;
-	struct irq_desc *desc = irq_to_desc(irq);
+	struct irq_desc *desc = irq_to_desc(d->irq);
 	int enable_one = (desc->status & IRQ_DISABLED) == 0;
-	u64 mask = 1ull << (irq - OCTEON_IRQ_WORKQ0);
+	u64 mask = 1ull << (d->irq - OCTEON_IRQ_WORKQ0);
 
 	for_each_online_cpu(cpu) {
 		index = octeon_coreid_for_cpu(cpu) * 2;
@@ -393,37 +380,38 @@ static int octeon_irq_ciu0_set_affinity_
  */
 static struct irq_chip octeon_irq_chip_ciu0_v2 = {
 	.name = "CIU0",
-	.enable = octeon_irq_ciu0_enable_v2,
-	.disable = octeon_irq_ciu0_disable_all_v2,
-	.eoi = octeon_irq_ciu0_enable_v2,
+	.irq_enable = octeon_irq_ciu0_enable_v2,
+	.irq_disable = octeon_irq_ciu0_disable_all_v2,
+	.irq_eoi = octeon_irq_ciu0_enable_v2,
 #ifdef CONFIG_SMP
-	.set_affinity = octeon_irq_ciu0_set_affinity_v2,
+	.irq_set_affinity = octeon_irq_ciu0_set_affinity_v2,
 #endif
 };
 
 static struct irq_chip octeon_irq_chip_ciu0 = {
 	.name = "CIU0",
-	.enable = octeon_irq_ciu0_enable,
-	.disable = octeon_irq_ciu0_disable,
-	.eoi = octeon_irq_ciu0_eoi,
+	.irq_enable = octeon_irq_ciu0_enable,
+	.irq_disable = octeon_irq_ciu0_disable,
+	.irq_eoi = octeon_irq_ciu0_eoi,
 #ifdef CONFIG_SMP
-	.set_affinity = octeon_irq_ciu0_set_affinity,
+	.irq_set_affinity = octeon_irq_ciu0_set_affinity,
 #endif
 };
 
 /* The mbox versions don't do any affinity or round-robin. */
 static struct irq_chip octeon_irq_chip_ciu0_mbox_v2 = {
 	.name = "CIU0-M",
-	.enable = octeon_irq_ciu0_enable_mbox_v2,
-	.disable = octeon_irq_ciu0_disable,
-	.eoi = octeon_irq_ciu0_eoi_mbox_v2,
+	.irq_enable = octeon_irq_ciu0_enable_mbox_v2,
+	.irq_disable = octeon_irq_ciu0_disable,
+	.irq_eoi = octeon_irq_ciu0_eoi_mbox_v2,
+	.flags = IRQCHIP_EOI_IF_HANDLED,
 };
 
 static struct irq_chip octeon_irq_chip_ciu0_mbox = {
 	.name = "CIU0-M",
-	.enable = octeon_irq_ciu0_enable_mbox,
-	.disable = octeon_irq_ciu0_disable,
-	.eoi = octeon_irq_ciu0_eoi,
+	.irq_enable = octeon_irq_ciu0_enable_mbox,
+	.irq_disable = octeon_irq_ciu0_disable,
+	.irq_eoi = octeon_irq_ciu0_eoi,
 };
 
 static void octeon_irq_ciu1_ack(unsigned int irq)
@@ -440,7 +428,7 @@ static void octeon_irq_ciu1_ack(unsigned
 	clear_c0_status(0x100 << 3);
 }
 
-static void octeon_irq_ciu1_eoi(unsigned int irq)
+static void octeon_irq_ciu1_eoi(struct irq_data *d)
 {
 	/*
 	 * Enable all CIU interrupts again.  We don't need to disable
@@ -450,13 +438,12 @@ static void octeon_irq_ciu1_eoi(unsigned
 	set_c0_status(0x100 << 3);
 }
 
-static void octeon_irq_ciu1_enable(unsigned int irq)
+static void octeon_irq_ciu1_enable(struct irq_data *d)
 {
-	struct irq_desc *desc = irq_to_desc(irq);
-	int coreid = next_coreid_for_irq(desc);
+	int coreid = next_coreid_for_irq(d);
 	unsigned long flags;
 	uint64_t en1;
-	int bit = irq - OCTEON_IRQ_WDOG0;	/* Bit 0-63 of EN1 */
+	int bit = d->irq - OCTEON_IRQ_WDOG0;	/* Bit 0-63 of EN1 */
 
 	raw_spin_lock_irqsave(&octeon_irq_ciu1_lock, flags);
 	en1 = cvmx_read_csr(CVMX_CIU_INTX_EN1(coreid * 2 + 1));
@@ -470,11 +457,11 @@ static void octeon_irq_ciu1_enable(unsig
  * Watchdog interrupts are special.  They are associated with a single
  * core, so we hardwire the affinity to that core.
  */
-static void octeon_irq_ciu1_wd_enable(unsigned int irq)
+static void octeon_irq_ciu1_wd_enable(struct irq_data *d)
 {
 	unsigned long flags;
 	uint64_t en1;
-	int bit = irq - OCTEON_IRQ_WDOG0;	/* Bit 0-63 of EN1 */
+	int bit = d->irq - OCTEON_IRQ_WDOG0;	/* Bit 0-63 of EN1 */
 	int coreid = bit;
 
 	raw_spin_lock_irqsave(&octeon_irq_ciu1_lock, flags);
@@ -485,9 +472,9 @@ static void octeon_irq_ciu1_wd_enable(un
 	raw_spin_unlock_irqrestore(&octeon_irq_ciu1_lock, flags);
 }
 
-static void octeon_irq_ciu1_disable(unsigned int irq)
+static void octeon_irq_ciu1_disable(struct irq_data *d)
 {
-	int bit = irq - OCTEON_IRQ_WDOG0;	/* Bit 0-63 of EN1 */
+	int bit = d->irq - OCTEON_IRQ_WDOG0;	/* Bit 0-63 of EN1 */
 	unsigned long flags;
 	uint64_t en1;
 	int cpu;
@@ -510,33 +497,25 @@ static void octeon_irq_ciu1_disable(unsi
  * Enable the irq on the current core for chips that have the EN*_W1{S,C}
  * registers.
  */
-static void octeon_irq_ciu1_enable_v2(unsigned int irq)
+static void octeon_irq_ciu1_enable_v2(struct irq_data *d)
 {
-	int index;
-	u64 mask = 1ull << (irq - OCTEON_IRQ_WDOG0);
-	struct irq_desc *desc = irq_to_desc(irq);
+	u64 mask = 1ull << (d->irq - OCTEON_IRQ_WDOG0);
+	int index = next_coreid_for_irq(d) * 2 + 1;
 
-	if ((desc->status & IRQ_DISABLED) == 0) {
-		index = next_coreid_for_irq(desc) * 2 + 1;
-		cvmx_write_csr(CVMX_CIU_INTX_EN1_W1S(index), mask);
-	}
+	cvmx_write_csr(CVMX_CIU_INTX_EN1_W1S(index), mask);
 }
 
 /*
  * Watchdog interrupts are special.  They are associated with a single
  * core, so we hardwire the affinity to that core.
  */
-static void octeon_irq_ciu1_wd_enable_v2(unsigned int irq)
+static void octeon_irq_ciu1_wd_enable_v2(struct irq_data *d)
 {
-	int index;
-	int coreid = irq - OCTEON_IRQ_WDOG0;
-	u64 mask = 1ull << (irq - OCTEON_IRQ_WDOG0);
-	struct irq_desc *desc = irq_to_desc(irq);
+	int coreid = d->irq - OCTEON_IRQ_WDOG0;
+	u64 mask = 1ull << (d->irq - OCTEON_IRQ_WDOG0);
+	int index = coreid * 2 + 1;
 
-	if ((desc->status & IRQ_DISABLED) == 0) {
-		index = coreid * 2 + 1;
-		cvmx_write_csr(CVMX_CIU_INTX_EN1_W1S(index), mask);
-	}
+	cvmx_write_csr(CVMX_CIU_INTX_EN1_W1S(index), mask);
 }
 
 /*
@@ -555,9 +534,9 @@ static void octeon_irq_ciu1_ack_v2(unsig
  * Disable the irq on the all cores for chips that have the EN*_W1{S,C}
  * registers.
  */
-static void octeon_irq_ciu1_disable_all_v2(unsigned int irq)
+static void octeon_irq_ciu1_disable_all_v2(struct irq_data *d)
 {
-	u64 mask = 1ull << (irq - OCTEON_IRQ_WDOG0);
+	u64 mask = 1ull << (d->irq - OCTEON_IRQ_WDOG0);
 	int index;
 	int cpu;
 	for_each_online_cpu(cpu) {
@@ -567,14 +546,15 @@ static void octeon_irq_ciu1_disable_all_
 }
 
 #ifdef CONFIG_SMP
-static int octeon_irq_ciu1_set_affinity(unsigned int irq,
-					const struct cpumask *dest)
+static int octeon_irq_ciu1_set_affinity(struct irq_data *d,
+					const struct cpumask *dest,
+					bool force)
 {
 	int cpu;
-	struct irq_desc *desc = irq_to_desc(irq);
+	struct irq_desc *desc = irq_to_desc(d->irq);
 	int enable_one = (desc->status & IRQ_DISABLED) == 0;
 	unsigned long flags;
-	int bit = irq - OCTEON_IRQ_WDOG0;	/* Bit 0-63 of EN1 */
+	int bit = d->irq - OCTEON_IRQ_WDOG0;	/* Bit 0-63 of EN1 */
 
 	/*
 	 * For non-v2 CIU, we will allow only single CPU affinity.
@@ -611,14 +591,15 @@ static int octeon_irq_ciu1_set_affinity(
  * Set affinity for the irq for chips that have the EN*_W1{S,C}
  * registers.
  */
-static int octeon_irq_ciu1_set_affinity_v2(unsigned int irq,
-					   const struct cpumask *dest)
+static int octeon_irq_ciu1_set_affinity_v2(struct irq_data *d,
+					   const struct cpumask *dest,
+					   bool force)
 {
 	int cpu;
 	int index;
-	struct irq_desc *desc = irq_to_desc(irq);
+	struct irq_desc *desc = irq_to_desc(d->irq);
 	int enable_one = (desc->status & IRQ_DISABLED) == 0;
-	u64 mask = 1ull << (irq - OCTEON_IRQ_WDOG0);
+	u64 mask = 1ull << (d->irq - OCTEON_IRQ_WDOG0);
 	for_each_online_cpu(cpu) {
 		index = octeon_coreid_for_cpu(cpu) * 2 + 1;
 		if (cpumask_test_cpu(cpu, dest) && enable_one) {
@@ -637,36 +618,36 @@ static int octeon_irq_ciu1_set_affinity_
  */
 static struct irq_chip octeon_irq_chip_ciu1_v2 = {
 	.name = "CIU1",
-	.enable = octeon_irq_ciu1_enable_v2,
-	.disable = octeon_irq_ciu1_disable_all_v2,
-	.eoi = octeon_irq_ciu1_enable_v2,
+	.irq_enable = octeon_irq_ciu1_enable_v2,
+	.irq_disable = octeon_irq_ciu1_disable_all_v2,
+	.irq_eoi = octeon_irq_ciu1_enable_v2,
 #ifdef CONFIG_SMP
-	.set_affinity = octeon_irq_ciu1_set_affinity_v2,
+	.irq_set_affinity = octeon_irq_ciu1_set_affinity_v2,
 #endif
 };
 
 static struct irq_chip octeon_irq_chip_ciu1 = {
 	.name = "CIU1",
-	.enable = octeon_irq_ciu1_enable,
-	.disable = octeon_irq_ciu1_disable,
-	.eoi = octeon_irq_ciu1_eoi,
+	.irq_enable = octeon_irq_ciu1_enable,
+	.irq_disable = octeon_irq_ciu1_disable,
+	.irq_eoi = octeon_irq_ciu1_eoi,
 #ifdef CONFIG_SMP
-	.set_affinity = octeon_irq_ciu1_set_affinity,
+	.irq_set_affinity = octeon_irq_ciu1_set_affinity,
 #endif
 };
 
 static struct irq_chip octeon_irq_chip_ciu1_wd_v2 = {
 	.name = "CIU1-W",
-	.enable = octeon_irq_ciu1_wd_enable_v2,
-	.disable = octeon_irq_ciu1_disable_all_v2,
-	.eoi = octeon_irq_ciu1_wd_enable_v2,
+	.irq_enable = octeon_irq_ciu1_wd_enable_v2,
+	.irq_disable = octeon_irq_ciu1_disable_all_v2,
+	.irq_eoi = octeon_irq_ciu1_wd_enable_v2,
 };
 
 static struct irq_chip octeon_irq_chip_ciu1_wd = {
 	.name = "CIU1-W",
-	.enable = octeon_irq_ciu1_wd_enable,
-	.disable = octeon_irq_ciu1_disable,
-	.eoi = octeon_irq_ciu1_eoi,
+	.irq_enable = octeon_irq_ciu1_wd_enable,
+	.irq_disable = octeon_irq_ciu1_disable,
+	.irq_eoi = octeon_irq_ciu1_eoi,
 };
 
 static void (*octeon_ciu0_ack)(unsigned int);
@@ -793,6 +774,7 @@ void fixup_irqs(void)
 {
 	int irq;
 	struct irq_desc *desc;
+	struct irq_data *data;
 	cpumask_t new_affinity;
 	unsigned long flags;
 	int do_set_affinity;
@@ -805,11 +787,12 @@ void fixup_irqs(void)
 
 	for (irq = OCTEON_IRQ_WORKQ0; irq < OCTEON_IRQ_LAST; irq++) {
 		desc = irq_to_desc(irq);
+		data = irq_desc_get_irq_data(desc);
 		switch (irq) {
 		case OCTEON_IRQ_MBOX0:
 		case OCTEON_IRQ_MBOX1:
 			/* The eoi function will disable them on this CPU. */
-			desc->chip->eoi(irq);
+			data->chip->irq_eoi(data);
 			break;
 		case OCTEON_IRQ_WDOG0:
 		case OCTEON_IRQ_WDOG1:
@@ -839,14 +822,14 @@ void fixup_irqs(void)
 			 * must be migrated if it has affinity to this
 			 * cpu.
 			 */
-			if (desc->action && cpumask_test_cpu(cpu, desc->affinity)) {
-				if (cpumask_weight(desc->affinity) > 1) {
+			if (desc->action && cpumask_test_cpu(cpu, data->affinity)) {
+				if (cpumask_weight(data->affinity) > 1) {
 					/*
 					 * It has multi CPU affinity,
 					 * just remove this CPU from
 					 * the affinity set.
 					 */
-					cpumask_copy(&new_affinity, desc->affinity);
+					cpumask_copy(&new_affinity, data->affinity);
 					cpumask_clear_cpu(cpu, &new_affinity);
 				} else {
 					/*
Index: linux-mips-next/arch/mips/pci/msi-octeon.c
===================================================================
--- linux-mips-next.orig/arch/mips/pci/msi-octeon.c
+++ linux-mips-next/arch/mips/pci/msi-octeon.c
@@ -259,11 +259,11 @@ static DEFINE_RAW_SPINLOCK(octeon_irq_ms
 static u64 msi_rcv_reg[4];
 static u64 mis_ena_reg[4];
 
-static void octeon_irq_msi_enable_pcie(unsigned int irq)
+static void octeon_irq_msi_enable_pcie(struct irq_data *d)
 {
 	u64 en;
 	unsigned long flags;
-	int msi_number = irq - OCTEON_IRQ_MSI_BIT0;
+	int msi_number = d->irq - OCTEON_IRQ_MSI_BIT0;
 	int irq_index = msi_number >> 6;
 	int irq_bit = msi_number & 0x3f;
 
@@ -275,11 +275,11 @@ static void octeon_irq_msi_enable_pcie(u
 	raw_spin_unlock_irqrestore(&octeon_irq_msi_lock, flags);
 }
 
-static void octeon_irq_msi_disable_pcie(unsigned int irq)
+static void octeon_irq_msi_disable_pcie(struct irq_data *d))
 {
 	u64 en;
 	unsigned long flags;
-	int msi_number = irq - OCTEON_IRQ_MSI_BIT0;
+	int msi_number = d->irq - OCTEON_IRQ_MSI_BIT0;
 	int irq_index = msi_number >> 6;
 	int irq_bit = msi_number & 0x3f;
 
@@ -293,11 +293,11 @@ static void octeon_irq_msi_disable_pcie(
 
 static struct irq_chip octeon_irq_chip_msi_pcie = {
 	.name = "MSI",
-	.enable = octeon_irq_msi_enable_pcie,
-	.disable = octeon_irq_msi_disable_pcie,
+	.irq_enable = octeon_irq_msi_enable_pcie,
+	.irq_disable = octeon_irq_msi_disable_pcie,
 };
 
-static void octeon_irq_msi_enable_pci(unsigned int irq)
+static void octeon_irq_msi_enable_pci(struct irq_data *d)
 {
 	/*
 	 * Octeon PCI doesn't have the ability to mask/unmask MSI
@@ -308,15 +308,15 @@ static void octeon_irq_msi_enable_pci(un
 	 */
 }
 
-static void octeon_irq_msi_disable_pci(unsigned int irq)
+static void octeon_irq_msi_disable_pci(struct irq_data *d)
 {
 	/* See comment in enable */
 }
 
 static struct irq_chip octeon_irq_chip_msi_pci = {
 	.name = "MSI",
-	.enable = octeon_irq_msi_enable_pci,
-	.disable = octeon_irq_msi_disable_pci,
+	.irq_enable = octeon_irq_msi_enable_pci,
+	.irq_disable = octeon_irq_msi_disable_pci,
 };
 
 /*
