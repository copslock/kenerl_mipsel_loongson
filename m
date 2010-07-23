Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Jul 2010 19:45:08 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:9761 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491991Ab0GWRoE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Jul 2010 19:44:04 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4c49d4fd0001>; Fri, 23 Jul 2010 10:44:29 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 23 Jul 2010 10:44:02 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 23 Jul 2010 10:44:02 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id o6NHhvI7024117;
        Fri, 23 Jul 2010 10:43:57 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id o6NHhun6024116;
        Fri, 23 Jul 2010 10:43:56 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 2/5] MIPS: Octeon: Improve interrupt handling.
Date:   Fri, 23 Jul 2010 10:43:46 -0700
Message-Id: <1279907029-24071-3-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.1.1
In-Reply-To: <1279907029-24071-1-git-send-email-ddaney@caviumnetworks.com>
References: <1279907029-24071-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 23 Jul 2010 17:44:02.0394 (UTC) FILETIME=[A3517BA0:01CB2A8E]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27446
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

The main change is to change most of the IRQs from handle_percpu_irq
to handle_fasteoi_irq.  This necessitates extracting all the .ack code
to common functions that are not exposed to the irq core.

The affinity code now acts more sanely, by doing round-robin
distribution instead of broadcasting.

Because of the change to handle_fasteoi_irq and affinity, some of the
IRQs had to be split into separate groups with their own struct
irq_chip to prevent undefined operations on specific IRQ lines.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/cavium-octeon/octeon-irq.c |  356 ++++++++++++++++++++++++----------
 1 files changed, 256 insertions(+), 100 deletions(-)

diff --git a/arch/mips/cavium-octeon/octeon-irq.c b/arch/mips/cavium-octeon/octeon-irq.c
index f4b901a..8fb9fb6 100644
--- a/arch/mips/cavium-octeon/octeon-irq.c
+++ b/arch/mips/cavium-octeon/octeon-irq.c
@@ -3,7 +3,7 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Copyright (C) 2004-2008 Cavium Networks
+ * Copyright (C) 2004-2008, 2009, 2010 Cavium Networks
  */
 #include <linux/irq.h>
 #include <linux/interrupt.h>
@@ -39,14 +39,14 @@ static void octeon_irq_core_ack(unsigned int irq)
 
 static void octeon_irq_core_eoi(unsigned int irq)
 {
-	struct irq_desc *desc = irq_desc + irq;
+	struct irq_desc *desc = irq_to_desc(irq);
 	unsigned int bit = irq - OCTEON_IRQ_SW0;
 	/*
 	 * If an IRQ is being processed while we are disabling it the
 	 * handler will attempt to unmask the interrupt after it has
 	 * been disabled.
 	 */
-	if (desc->status & IRQ_DISABLED)
+	if ((unlikely(desc->status & IRQ_DISABLED)))
 		return;
 	/*
 	 * We don't need to disable IRQs to make these atomic since
@@ -104,6 +104,29 @@ static struct irq_chip octeon_irq_chip_core = {
 
 static void octeon_irq_ciu0_ack(unsigned int irq)
 {
+	switch (irq) {
+	case OCTEON_IRQ_GMX_DRP0:
+	case OCTEON_IRQ_GMX_DRP1:
+	case OCTEON_IRQ_IPD_DRP:
+	case OCTEON_IRQ_KEY_ZERO:
+	case OCTEON_IRQ_TIMER0:
+	case OCTEON_IRQ_TIMER1:
+	case OCTEON_IRQ_TIMER2:
+	case OCTEON_IRQ_TIMER3:
+	{
+		int index = cvmx_get_core_num() * 2;
+		u64 mask = 1ull << (irq - OCTEON_IRQ_WORKQ0);
+		/*
+		 * CIU timer type interrupts must be acknoleged by
+		 * writing a '1' bit to their sum0 bit.
+		 */
+		cvmx_write_csr(CVMX_CIU_INTX_SUM0(index), mask);
+		break;
+	}
+	default:
+		break;
+	}
+
 	/*
 	 * In order to avoid any locking accessing the CIU, we
 	 * acknowledge CIU interrupts by disabling all of them.  This
@@ -128,8 +151,54 @@ static void octeon_irq_ciu0_eoi(unsigned int irq)
 	set_c0_status(0x100 << 2);
 }
 
+static int next_coreid_for_irq(struct irq_desc *desc)
+{
+
+#ifdef CONFIG_SMP
+	int coreid;
+	int weight = cpumask_weight(desc->affinity);
+
+	if (weight > 1) {
+		int cpu = smp_processor_id();
+		for (;;) {
+			cpu = cpumask_next(cpu, desc->affinity);
+			if (cpu >= nr_cpu_ids) {
+				cpu = -1;
+				continue;
+			} else if (cpumask_test_cpu(cpu, cpu_online_mask)) {
+				break;
+			}
+		}
+		coreid = octeon_coreid_for_cpu(cpu);
+	} else if (weight == 1) {
+		coreid = octeon_coreid_for_cpu(cpumask_first(desc->affinity));
+	} else {
+		coreid = cvmx_get_core_num();
+	}
+	return coreid;
+#else
+	return cvmx_get_core_num();
+#endif
+}
+
 static void octeon_irq_ciu0_enable(unsigned int irq)
 {
+	struct irq_desc *desc = irq_to_desc(irq);
+	int coreid = next_coreid_for_irq(desc);
+	unsigned long flags;
+	uint64_t en0;
+	int bit = irq - OCTEON_IRQ_WORKQ0;	/* Bit 0-63 of EN0 */
+
+	raw_spin_lock_irqsave(&octeon_irq_ciu0_lock, flags);
+	en0 = cvmx_read_csr(CVMX_CIU_INTX_EN0(coreid * 2));
+	en0 |= 1ull << bit;
+	cvmx_write_csr(CVMX_CIU_INTX_EN0(coreid * 2), en0);
+	cvmx_read_csr(CVMX_CIU_INTX_EN0(coreid * 2));
+	raw_spin_unlock_irqrestore(&octeon_irq_ciu0_lock, flags);
+}
+
+static void octeon_irq_ciu0_enable_mbox(unsigned int irq)
+{
 	int coreid = cvmx_get_core_num();
 	unsigned long flags;
 	uint64_t en0;
@@ -165,63 +234,76 @@ static void octeon_irq_ciu0_disable(unsigned int irq)
 }
 
 /*
- * Enable the irq on the current core for chips that have the EN*_W1{S,C}
- * registers.
+ * Enable the irq on the next core in the affinity set for chips that
+ * have the EN*_W1{S,C} registers.
  */
 static void octeon_irq_ciu0_enable_v2(unsigned int irq)
 {
-	int index = cvmx_get_core_num() * 2;
+	int index;
 	u64 mask = 1ull << (irq - OCTEON_IRQ_WORKQ0);
+	struct irq_desc *desc = irq_to_desc(irq);
 
-	cvmx_write_csr(CVMX_CIU_INTX_EN0_W1S(index), mask);
+	if ((desc->status & IRQ_DISABLED) == 0) {
+		index = next_coreid_for_irq(desc) * 2;
+		cvmx_write_csr(CVMX_CIU_INTX_EN0_W1S(index), mask);
+	}
 }
 
 /*
- * Disable the irq on the current core for chips that have the EN*_W1{S,C}
- * registers.
+ * Enable the irq on the current CPU for chips that
+ * have the EN*_W1{S,C} registers.
  */
-static void octeon_irq_ciu0_ack_v2(unsigned int irq)
+static void octeon_irq_ciu0_enable_mbox_v2(unsigned int irq)
 {
-	int index = cvmx_get_core_num() * 2;
+	int index;
 	u64 mask = 1ull << (irq - OCTEON_IRQ_WORKQ0);
 
-	cvmx_write_csr(CVMX_CIU_INTX_EN0_W1C(index), mask);
+	index = cvmx_get_core_num() * 2;
+	cvmx_write_csr(CVMX_CIU_INTX_EN0_W1S(index), mask);
 }
 
 /*
- * CIU timer type interrupts must be acknoleged by writing a '1' bit
- * to their sum0 bit.
+ * Disable the irq on the current core for chips that have the EN*_W1{S,C}
+ * registers.
  */
-static void octeon_irq_ciu0_timer_ack(unsigned int irq)
+static void octeon_irq_ciu0_ack_v2(unsigned int irq)
 {
 	int index = cvmx_get_core_num() * 2;
-	uint64_t mask = 1ull << (irq - OCTEON_IRQ_WORKQ0);
-	cvmx_write_csr(CVMX_CIU_INTX_SUM0(index), mask);
-}
+	u64 mask = 1ull << (irq - OCTEON_IRQ_WORKQ0);
 
-static void octeon_irq_ciu0_timer_ack_v1(unsigned int irq)
-{
-	octeon_irq_ciu0_timer_ack(irq);
-	octeon_irq_ciu0_ack(irq);
-}
+	switch (irq) {
+	case OCTEON_IRQ_GMX_DRP0:
+	case OCTEON_IRQ_GMX_DRP1:
+	case OCTEON_IRQ_IPD_DRP:
+	case OCTEON_IRQ_KEY_ZERO:
+	case OCTEON_IRQ_TIMER0:
+	case OCTEON_IRQ_TIMER1:
+	case OCTEON_IRQ_TIMER2:
+	case OCTEON_IRQ_TIMER3:
+		/*
+		 * CIU timer type interrupts must be acknoleged by
+		 * writing a '1' bit to their sum0 bit.
+		 */
+		cvmx_write_csr(CVMX_CIU_INTX_SUM0(index), mask);
+		break;
+	default:
+		break;
+	}
 
-static void octeon_irq_ciu0_timer_ack_v2(unsigned int irq)
-{
-	octeon_irq_ciu0_timer_ack(irq);
-	octeon_irq_ciu0_ack_v2(irq);
+	cvmx_write_csr(CVMX_CIU_INTX_EN0_W1C(index), mask);
 }
 
 /*
  * Enable the irq on the current core for chips that have the EN*_W1{S,C}
  * registers.
  */
-static void octeon_irq_ciu0_eoi_v2(unsigned int irq)
+static void octeon_irq_ciu0_eoi_mbox_v2(unsigned int irq)
 {
-	struct irq_desc *desc = irq_desc + irq;
+	struct irq_desc *desc = irq_to_desc(irq);
 	int index = cvmx_get_core_num() * 2;
 	u64 mask = 1ull << (irq - OCTEON_IRQ_WORKQ0);
 
-	if ((desc->status & IRQ_DISABLED) == 0)
+	if (likely((desc->status & IRQ_DISABLED) == 0))
 		cvmx_write_csr(CVMX_CIU_INTX_EN0_W1S(index), mask);
 }
 
@@ -244,18 +326,30 @@ static void octeon_irq_ciu0_disable_all_v2(unsigned int irq)
 static int octeon_irq_ciu0_set_affinity(unsigned int irq, const struct cpumask *dest)
 {
 	int cpu;
+	struct irq_desc *desc = irq_to_desc(irq);
+	int enable_one = (desc->status & IRQ_DISABLED) == 0;
 	unsigned long flags;
 	int bit = irq - OCTEON_IRQ_WORKQ0;	/* Bit 0-63 of EN0 */
 
+	/*
+	 * For non-v2 CIU, we will allow only single CPU affinity.
+	 * This removes the need to do locking in the .ack/.eoi
+	 * functions.
+	 */
+	if (cpumask_weight(dest) != 1)
+		return -EINVAL;
+
 	raw_spin_lock_irqsave(&octeon_irq_ciu0_lock, flags);
 	for_each_online_cpu(cpu) {
 		int coreid = octeon_coreid_for_cpu(cpu);
 		uint64_t en0 =
 			cvmx_read_csr(CVMX_CIU_INTX_EN0(coreid * 2));
-		if (cpumask_test_cpu(cpu, dest))
+		if (cpumask_test_cpu(cpu, dest) && enable_one) {
+			enable_one = 0;
 			en0 |= 1ull << bit;
-		else
+		} else {
 			en0 &= ~(1ull << bit);
+		}
 		cvmx_write_csr(CVMX_CIU_INTX_EN0(coreid * 2), en0);
 	}
 	/*
@@ -277,13 +371,18 @@ static int octeon_irq_ciu0_set_affinity_v2(unsigned int irq,
 {
 	int cpu;
 	int index;
+	struct irq_desc *desc = irq_to_desc(irq);
+	int enable_one = (desc->status & IRQ_DISABLED) == 0;
 	u64 mask = 1ull << (irq - OCTEON_IRQ_WORKQ0);
+
 	for_each_online_cpu(cpu) {
 		index = octeon_coreid_for_cpu(cpu) * 2;
-		if (cpumask_test_cpu(cpu, dest))
+		if (cpumask_test_cpu(cpu, dest) && enable_one) {
+			enable_one = 0;
 			cvmx_write_csr(CVMX_CIU_INTX_EN0_W1S(index), mask);
-		else
+		} else {
 			cvmx_write_csr(CVMX_CIU_INTX_EN0_W1C(index), mask);
+		}
 	}
 	return 0;
 }
@@ -296,8 +395,7 @@ static struct irq_chip octeon_irq_chip_ciu0_v2 = {
 	.name = "CIU0",
 	.enable = octeon_irq_ciu0_enable_v2,
 	.disable = octeon_irq_ciu0_disable_all_v2,
-	.ack = octeon_irq_ciu0_ack_v2,
-	.eoi = octeon_irq_ciu0_eoi_v2,
+	.eoi = octeon_irq_ciu0_enable_v2,
 #ifdef CONFIG_SMP
 	.set_affinity = octeon_irq_ciu0_set_affinity_v2,
 #endif
@@ -307,36 +405,27 @@ static struct irq_chip octeon_irq_chip_ciu0 = {
 	.name = "CIU0",
 	.enable = octeon_irq_ciu0_enable,
 	.disable = octeon_irq_ciu0_disable,
-	.ack = octeon_irq_ciu0_ack,
 	.eoi = octeon_irq_ciu0_eoi,
 #ifdef CONFIG_SMP
 	.set_affinity = octeon_irq_ciu0_set_affinity,
 #endif
 };
 
-static struct irq_chip octeon_irq_chip_ciu0_timer_v2 = {
-	.name = "CIU0-T",
-	.enable = octeon_irq_ciu0_enable_v2,
-	.disable = octeon_irq_ciu0_disable_all_v2,
-	.ack = octeon_irq_ciu0_timer_ack_v2,
-	.eoi = octeon_irq_ciu0_eoi_v2,
-#ifdef CONFIG_SMP
-	.set_affinity = octeon_irq_ciu0_set_affinity_v2,
-#endif
+/* The mbox versions don't do any affinity or round-robin. */
+static struct irq_chip octeon_irq_chip_ciu0_mbox_v2 = {
+	.name = "CIU0-M",
+	.enable = octeon_irq_ciu0_enable_mbox_v2,
+	.disable = octeon_irq_ciu0_disable,
+	.eoi = octeon_irq_ciu0_eoi_mbox_v2,
 };
 
-static struct irq_chip octeon_irq_chip_ciu0_timer = {
-	.name = "CIU0-T",
-	.enable = octeon_irq_ciu0_enable,
+static struct irq_chip octeon_irq_chip_ciu0_mbox = {
+	.name = "CIU0-M",
+	.enable = octeon_irq_ciu0_enable_mbox,
 	.disable = octeon_irq_ciu0_disable,
-	.ack = octeon_irq_ciu0_timer_ack_v1,
 	.eoi = octeon_irq_ciu0_eoi,
-#ifdef CONFIG_SMP
-	.set_affinity = octeon_irq_ciu0_set_affinity,
-#endif
 };
 
-
 static void octeon_irq_ciu1_ack(unsigned int irq)
 {
 	/*
@@ -363,7 +452,8 @@ static void octeon_irq_ciu1_eoi(unsigned int irq)
 
 static void octeon_irq_ciu1_enable(unsigned int irq)
 {
-	int coreid = cvmx_get_core_num();
+	struct irq_desc *desc = irq_to_desc(irq);
+	int coreid = next_coreid_for_irq(desc);
 	unsigned long flags;
 	uint64_t en1;
 	int bit = irq - OCTEON_IRQ_WDOG0;	/* Bit 0-63 of EN1 */
@@ -376,6 +466,25 @@ static void octeon_irq_ciu1_enable(unsigned int irq)
 	raw_spin_unlock_irqrestore(&octeon_irq_ciu1_lock, flags);
 }
 
+/*
+ * Watchdog interrupts are special.  They are associated with a single
+ * core, so we hardwire the affinity to that core.
+ */
+static void octeon_irq_ciu1_wd_enable(unsigned int irq)
+{
+	unsigned long flags;
+	uint64_t en1;
+	int bit = irq - OCTEON_IRQ_WDOG0;	/* Bit 0-63 of EN1 */
+	int coreid = bit;
+
+	raw_spin_lock_irqsave(&octeon_irq_ciu1_lock, flags);
+	en1 = cvmx_read_csr(CVMX_CIU_INTX_EN1(coreid * 2 + 1));
+	en1 |= 1ull << bit;
+	cvmx_write_csr(CVMX_CIU_INTX_EN1(coreid * 2 + 1), en1);
+	cvmx_read_csr(CVMX_CIU_INTX_EN1(coreid * 2 + 1));
+	raw_spin_unlock_irqrestore(&octeon_irq_ciu1_lock, flags);
+}
+
 static void octeon_irq_ciu1_disable(unsigned int irq)
 {
 	int bit = irq - OCTEON_IRQ_WDOG0;	/* Bit 0-63 of EN1 */
@@ -403,36 +512,43 @@ static void octeon_irq_ciu1_disable(unsigned int irq)
  */
 static void octeon_irq_ciu1_enable_v2(unsigned int irq)
 {
-	int index = cvmx_get_core_num() * 2 + 1;
+	int index;
 	u64 mask = 1ull << (irq - OCTEON_IRQ_WDOG0);
+	struct irq_desc *desc = irq_to_desc(irq);
 
-	cvmx_write_csr(CVMX_CIU_INTX_EN1_W1S(index), mask);
+	if ((desc->status & IRQ_DISABLED) == 0) {
+		index = next_coreid_for_irq(desc) * 2 + 1;
+		cvmx_write_csr(CVMX_CIU_INTX_EN1_W1S(index), mask);
+	}
 }
 
 /*
- * Disable the irq on the current core for chips that have the EN*_W1{S,C}
- * registers.
+ * Watchdog interrupts are special.  They are associated with a single
+ * core, so we hardwire the affinity to that core.
  */
-static void octeon_irq_ciu1_ack_v2(unsigned int irq)
+static void octeon_irq_ciu1_wd_enable_v2(unsigned int irq)
 {
-	int index = cvmx_get_core_num() * 2 + 1;
+	int index;
+	int coreid = irq - OCTEON_IRQ_WDOG0;
 	u64 mask = 1ull << (irq - OCTEON_IRQ_WDOG0);
+	struct irq_desc *desc = irq_to_desc(irq);
 
-	cvmx_write_csr(CVMX_CIU_INTX_EN1_W1C(index), mask);
+	if ((desc->status & IRQ_DISABLED) == 0) {
+		index = coreid * 2 + 1;
+		cvmx_write_csr(CVMX_CIU_INTX_EN1_W1S(index), mask);
+	}
 }
 
 /*
- * Enable the irq on the current core for chips that have the EN*_W1{S,C}
+ * Disable the irq on the current core for chips that have the EN*_W1{S,C}
  * registers.
  */
-static void octeon_irq_ciu1_eoi_v2(unsigned int irq)
+static void octeon_irq_ciu1_ack_v2(unsigned int irq)
 {
-	struct irq_desc *desc = irq_desc + irq;
 	int index = cvmx_get_core_num() * 2 + 1;
 	u64 mask = 1ull << (irq - OCTEON_IRQ_WDOG0);
 
-	if ((desc->status & IRQ_DISABLED) == 0)
-		cvmx_write_csr(CVMX_CIU_INTX_EN1_W1S(index), mask);
+	cvmx_write_csr(CVMX_CIU_INTX_EN1_W1C(index), mask);
 }
 
 /*
@@ -455,19 +571,30 @@ static int octeon_irq_ciu1_set_affinity(unsigned int irq,
 					const struct cpumask *dest)
 {
 	int cpu;
+	struct irq_desc *desc = irq_to_desc(irq);
+	int enable_one = (desc->status & IRQ_DISABLED) == 0;
 	unsigned long flags;
 	int bit = irq - OCTEON_IRQ_WDOG0;	/* Bit 0-63 of EN1 */
 
+	/*
+	 * For non-v2 CIU, we will allow only single CPU affinity.
+	 * This removes the need to do locking in the .ack/.eoi
+	 * functions.
+	 */
+	if (cpumask_weight(dest) != 1)
+		return -EINVAL;
+
 	raw_spin_lock_irqsave(&octeon_irq_ciu1_lock, flags);
 	for_each_online_cpu(cpu) {
 		int coreid = octeon_coreid_for_cpu(cpu);
 		uint64_t en1 =
-			cvmx_read_csr(CVMX_CIU_INTX_EN1
-				(coreid * 2 + 1));
-		if (cpumask_test_cpu(cpu, dest))
+			cvmx_read_csr(CVMX_CIU_INTX_EN1(coreid * 2 + 1));
+		if (cpumask_test_cpu(cpu, dest) && enable_one) {
+			enable_one = 0;
 			en1 |= 1ull << bit;
-		else
+		} else {
 			en1 &= ~(1ull << bit);
+		}
 		cvmx_write_csr(CVMX_CIU_INTX_EN1(coreid * 2 + 1), en1);
 	}
 	/*
@@ -489,13 +616,17 @@ static int octeon_irq_ciu1_set_affinity_v2(unsigned int irq,
 {
 	int cpu;
 	int index;
+	struct irq_desc *desc = irq_to_desc(irq);
+	int enable_one = (desc->status & IRQ_DISABLED) == 0;
 	u64 mask = 1ull << (irq - OCTEON_IRQ_WDOG0);
 	for_each_online_cpu(cpu) {
 		index = octeon_coreid_for_cpu(cpu) * 2 + 1;
-		if (cpumask_test_cpu(cpu, dest))
+		if (cpumask_test_cpu(cpu, dest) && enable_one) {
+			enable_one = 0;
 			cvmx_write_csr(CVMX_CIU_INTX_EN1_W1S(index), mask);
-		else
+		} else {
 			cvmx_write_csr(CVMX_CIU_INTX_EN1_W1C(index), mask);
+		}
 	}
 	return 0;
 }
@@ -505,11 +636,10 @@ static int octeon_irq_ciu1_set_affinity_v2(unsigned int irq,
  * Newer octeon chips have support for lockless CIU operation.
  */
 static struct irq_chip octeon_irq_chip_ciu1_v2 = {
-	.name = "CIU0",
+	.name = "CIU1",
 	.enable = octeon_irq_ciu1_enable_v2,
 	.disable = octeon_irq_ciu1_disable_all_v2,
-	.ack = octeon_irq_ciu1_ack_v2,
-	.eoi = octeon_irq_ciu1_eoi_v2,
+	.eoi = octeon_irq_ciu1_enable_v2,
 #ifdef CONFIG_SMP
 	.set_affinity = octeon_irq_ciu1_set_affinity_v2,
 #endif
@@ -519,19 +649,36 @@ static struct irq_chip octeon_irq_chip_ciu1 = {
 	.name = "CIU1",
 	.enable = octeon_irq_ciu1_enable,
 	.disable = octeon_irq_ciu1_disable,
-	.ack = octeon_irq_ciu1_ack,
 	.eoi = octeon_irq_ciu1_eoi,
 #ifdef CONFIG_SMP
 	.set_affinity = octeon_irq_ciu1_set_affinity,
 #endif
 };
 
+static struct irq_chip octeon_irq_chip_ciu1_wd_v2 = {
+	.name = "CIU1-W",
+	.enable = octeon_irq_ciu1_wd_enable_v2,
+	.disable = octeon_irq_ciu1_disable_all_v2,
+	.eoi = octeon_irq_ciu1_wd_enable_v2,
+};
+
+static struct irq_chip octeon_irq_chip_ciu1_wd = {
+	.name = "CIU1-W",
+	.enable = octeon_irq_ciu1_wd_enable,
+	.disable = octeon_irq_ciu1_disable,
+	.eoi = octeon_irq_ciu1_eoi,
+};
+
+static void (*octeon_ciu0_ack)(unsigned int);
+static void (*octeon_ciu1_ack)(unsigned int);
+
 void __init arch_init_irq(void)
 {
-	int irq;
+	unsigned int irq;
 	struct irq_chip *chip0;
-	struct irq_chip *chip0_timer;
+	struct irq_chip *chip0_mbox;
 	struct irq_chip *chip1;
+	struct irq_chip *chip1_wd;
 
 #ifdef CONFIG_SMP
 	/* Set the default affinity to the boot cpu. */
@@ -545,13 +692,19 @@ void __init arch_init_irq(void)
 	if (OCTEON_IS_MODEL(OCTEON_CN58XX_PASS2_X) ||
 	    OCTEON_IS_MODEL(OCTEON_CN56XX_PASS2_X) ||
 	    OCTEON_IS_MODEL(OCTEON_CN52XX_PASS2_X)) {
+		octeon_ciu0_ack = octeon_irq_ciu0_ack_v2;
+		octeon_ciu1_ack = octeon_irq_ciu1_ack_v2;
 		chip0 = &octeon_irq_chip_ciu0_v2;
-		chip0_timer = &octeon_irq_chip_ciu0_timer_v2;
+		chip0_mbox = &octeon_irq_chip_ciu0_mbox_v2;
 		chip1 = &octeon_irq_chip_ciu1_v2;
+		chip1_wd = &octeon_irq_chip_ciu1_wd_v2;
 	} else {
+		octeon_ciu0_ack = octeon_irq_ciu0_ack;
+		octeon_ciu1_ack = octeon_irq_ciu1_ack;
 		chip0 = &octeon_irq_chip_ciu0;
-		chip0_timer = &octeon_irq_chip_ciu0_timer;
+		chip0_mbox = &octeon_irq_chip_ciu0_mbox;
 		chip1 = &octeon_irq_chip_ciu1;
+		chip1_wd = &octeon_irq_chip_ciu1_wd;
 	}
 
 	/* 0 - 15 reserved for i8259 master and slave controller. */
@@ -565,26 +718,22 @@ void __init arch_init_irq(void)
 	/* 24 - 87 CIU_INT_SUM0 */
 	for (irq = OCTEON_IRQ_WORKQ0; irq <= OCTEON_IRQ_BOOTDMA; irq++) {
 		switch (irq) {
-		case OCTEON_IRQ_GMX_DRP0:
-		case OCTEON_IRQ_GMX_DRP1:
-		case OCTEON_IRQ_IPD_DRP:
-		case OCTEON_IRQ_KEY_ZERO:
-		case OCTEON_IRQ_TIMER0:
-		case OCTEON_IRQ_TIMER1:
-		case OCTEON_IRQ_TIMER2:
-		case OCTEON_IRQ_TIMER3:
-			set_irq_chip_and_handler(irq, chip0_timer, handle_percpu_irq);
+		case OCTEON_IRQ_MBOX0:
+		case OCTEON_IRQ_MBOX1:
+			set_irq_chip_and_handler(irq, chip0_mbox, handle_percpu_irq);
 			break;
 		default:
-			set_irq_chip_and_handler(irq, chip0, handle_percpu_irq);
+			set_irq_chip_and_handler(irq, chip0, handle_fasteoi_irq);
 			break;
 		}
 	}
 
 	/* 88 - 151 CIU_INT_SUM1 */
-	for (irq = OCTEON_IRQ_WDOG0; irq <= OCTEON_IRQ_RESERVED151; irq++) {
-		set_irq_chip_and_handler(irq, chip1, handle_percpu_irq);
-	}
+	for (irq = OCTEON_IRQ_WDOG0; irq <= OCTEON_IRQ_WDOG15; irq++)
+		set_irq_chip_and_handler(irq, chip1_wd, handle_fasteoi_irq);
+
+	for (irq = OCTEON_IRQ_UART2; irq <= OCTEON_IRQ_RESERVED151; irq++)
+		set_irq_chip_and_handler(irq, chip1, handle_fasteoi_irq);
 
 	set_c0_status(0x300 << 2);
 }
@@ -600,6 +749,7 @@ asmlinkage void plat_irq_dispatch(void)
 	unsigned long cop0_status;
 	uint64_t ciu_en;
 	uint64_t ciu_sum;
+	unsigned int irq;
 
 	while (1) {
 		cop0_cause = read_c0_cause();
@@ -611,18 +761,24 @@ asmlinkage void plat_irq_dispatch(void)
 			ciu_sum = cvmx_read_csr(ciu_sum0_address);
 			ciu_en = cvmx_read_csr(ciu_en0_address);
 			ciu_sum &= ciu_en;
-			if (likely(ciu_sum))
-				do_IRQ(fls64(ciu_sum) + OCTEON_IRQ_WORKQ0 - 1);
-			else
+			if (likely(ciu_sum)) {
+				irq = fls64(ciu_sum) + OCTEON_IRQ_WORKQ0 - 1;
+				octeon_ciu0_ack(irq);
+				do_IRQ(irq);
+			} else {
 				spurious_interrupt();
+			}
 		} else if (unlikely(cop0_cause & STATUSF_IP3)) {
 			ciu_sum = cvmx_read_csr(ciu_sum1_address);
 			ciu_en = cvmx_read_csr(ciu_en1_address);
 			ciu_sum &= ciu_en;
-			if (likely(ciu_sum))
-				do_IRQ(fls64(ciu_sum) + OCTEON_IRQ_WDOG0 - 1);
-			else
+			if (likely(ciu_sum)) {
+				irq = fls64(ciu_sum) + OCTEON_IRQ_WDOG0 - 1;
+				octeon_ciu1_ack(irq);
+				do_IRQ(irq);
+			} else {
 				spurious_interrupt();
+			}
 		} else if (likely(cop0_cause)) {
 			do_IRQ(fls(cop0_cause) - 9 + MIPS_CPU_IRQ_BASE);
 		} else {
-- 
1.7.1.1
