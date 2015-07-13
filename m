Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jul 2015 22:47:37 +0200 (CEST)
Received: from www.linutronix.de ([62.245.132.108]:56979 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011074AbbGMUqHt0W-V (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Jul 2015 22:46:07 +0200
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ZEkc2-0006Vc-C6; Mon, 13 Jul 2015 22:46:06 +0200
Message-Id: <20150713200714.859821913@linutronix.de>
User-Agent: quilt/0.63-1
Date:   Mon, 13 Jul 2015 20:45:59 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Jiang Liu <jiang.liu@linux.intel.com>,
        linux-mips@linux-mips.org
Subject: [patch 05/12] MIPS/irq: Use access helper irq_data_get_affinity_mask()
References: <20150713200602.799079101@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline;
 filename=mips-irq-Use-access-helper-irq_data_get_affinity_mas.patch
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001,URIBL_BLOCKED=0.001
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48237
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

From: Jiang Liu <jiang.liu@linux.intel.com>

This is a preparatory patch for moving irq_data struct members.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/mips/bcm63xx/irq.c              |    2 +-
 arch/mips/cavium-octeon/octeon-irq.c |   14 ++++++++------
 arch/mips/pmcs-msp71xx/msp_irq_cic.c |    3 ++-
 3 files changed, 11 insertions(+), 8 deletions(-)

Index: tip/arch/mips/bcm63xx/irq.c
===================================================================
--- tip.orig/arch/mips/bcm63xx/irq.c
+++ tip/arch/mips/bcm63xx/irq.c
@@ -60,7 +60,7 @@ static inline int enable_irq_for_cpu(int
 	if (m)
 		enable &= cpumask_test_cpu(cpu, m);
 	else if (irqd_affinity_was_set(d))
-		enable &= cpumask_test_cpu(cpu, d->affinity);
+		enable &= cpumask_test_cpu(cpu, irq_data_get_affinity_mask(d));
 #endif
 	return enable;
 }
Index: tip/arch/mips/cavium-octeon/octeon-irq.c
===================================================================
--- tip.orig/arch/mips/cavium-octeon/octeon-irq.c
+++ tip/arch/mips/cavium-octeon/octeon-irq.c
@@ -225,13 +225,14 @@ static int next_cpu_for_irq(struct irq_d
 
 #ifdef CONFIG_SMP
 	int cpu;
-	int weight = cpumask_weight(data->affinity);
+	struct cpumask *mask = irq_data_get_affinity_mask(data);
+	int weight = cpumask_weight(mask);
 	struct octeon_ciu_chip_data *cd = irq_data_get_irq_chip_data(data);
 
 	if (weight > 1) {
 		cpu = cd->current_cpu;
 		for (;;) {
-			cpu = cpumask_next(cpu, data->affinity);
+			cpu = cpumask_next(cpu, mask);
 			if (cpu >= nr_cpu_ids) {
 				cpu = -1;
 				continue;
@@ -240,7 +241,7 @@ static int next_cpu_for_irq(struct irq_d
 			}
 		}
 	} else if (weight == 1) {
-		cpu = cpumask_first(data->affinity);
+		cpu = cpumask_first(mask);
 	} else {
 		cpu = smp_processor_id();
 	}
@@ -712,16 +713,17 @@ static void octeon_irq_cpu_offline_ciu(s
 {
 	int cpu = smp_processor_id();
 	cpumask_t new_affinity;
+	struct cpumask *mask = irq_data_get_affinity_mask(data);
 
-	if (!cpumask_test_cpu(cpu, data->affinity))
+	if (!cpumask_test_cpu(cpu, mask))
 		return;
 
-	if (cpumask_weight(data->affinity) > 1) {
+	if (cpumask_weight(mask) > 1) {
 		/*
 		 * It has multi CPU affinity, just remove this CPU
 		 * from the affinity set.
 		 */
-		cpumask_copy(&new_affinity, data->affinity);
+		cpumask_copy(&new_affinity, mask);
 		cpumask_clear_cpu(cpu, &new_affinity);
 	} else {
 		/* Otherwise, put it on lowest numbered online CPU. */
Index: tip/arch/mips/pmcs-msp71xx/msp_irq_cic.c
===================================================================
--- tip.orig/arch/mips/pmcs-msp71xx/msp_irq_cic.c
+++ tip/arch/mips/pmcs-msp71xx/msp_irq_cic.c
@@ -88,7 +88,8 @@ static void unmask_cic_irq(struct irq_da
 	* Make sure we have IRQ affinity.  It may have changed while
 	* we were processing the IRQ.
 	*/
-	if (!cpumask_test_cpu(smp_processor_id(), d->affinity))
+	if (!cpumask_test_cpu(smp_processor_id(),
+			      irq_data_get_affinity_mask(d)))
 		return;
 #endif
 
