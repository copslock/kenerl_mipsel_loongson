Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Jul 2010 19:45:33 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:9762 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492580Ab0GWRoF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Jul 2010 19:44:05 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4c49d4ff0000>; Fri, 23 Jul 2010 10:44:31 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 23 Jul 2010 10:44:03 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 23 Jul 2010 10:44:03 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id o6NHhxff024121;
        Fri, 23 Jul 2010 10:43:59 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id o6NHhv4W024120;
        Fri, 23 Jul 2010 10:43:57 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 3/5] MIPS: Octeon: Fix fixup_irqs for HOTPLUG_CPU
Date:   Fri, 23 Jul 2010 10:43:47 -0700
Message-Id: <1279907029-24071-4-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.1.1
In-Reply-To: <1279907029-24071-1-git-send-email-ddaney@caviumnetworks.com>
References: <1279907029-24071-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 23 Jul 2010 17:44:03.0675 (UTC) FILETIME=[A414F2B0:01CB2A8E]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27447
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

The original version went behind the back of everything, leaving
things in an inconsistent state.

Now we use the irq_set_affinity() to do the work for us.  This has the
advantage that the IRQ core's view of the affinity stays consistent.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/cavium-octeon/octeon-irq.c |  108 +++++++++++++++++++++------------
 1 files changed, 69 insertions(+), 39 deletions(-)

diff --git a/arch/mips/cavium-octeon/octeon-irq.c b/arch/mips/cavium-octeon/octeon-irq.c
index 8fb9fb6..ce7500c 100644
--- a/arch/mips/cavium-octeon/octeon-irq.c
+++ b/arch/mips/cavium-octeon/octeon-irq.c
@@ -788,54 +788,84 @@ asmlinkage void plat_irq_dispatch(void)
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
-static int is_irq_enabled_on_cpu(unsigned int irq, unsigned int cpu)
-{
-	unsigned int isset;
-	int coreid = octeon_coreid_for_cpu(cpu);
-	int bit = (irq < OCTEON_IRQ_WDOG0) ?
-		   irq - OCTEON_IRQ_WORKQ0 : irq - OCTEON_IRQ_WDOG0;
-       if (irq < 64) {
-		isset = (cvmx_read_csr(CVMX_CIU_INTX_EN0(coreid * 2)) &
-			(1ull << bit)) >> bit;
-       } else {
-	       isset = (cvmx_read_csr(CVMX_CIU_INTX_EN1(coreid * 2 + 1)) &
-			(1ull << bit)) >> bit;
-       }
-       return isset;
-}
 
 void fixup_irqs(void)
 {
-       int irq;
+	int irq;
+	struct irq_desc *desc;
+	cpumask_t new_affinity;
+	unsigned long flags;
+	int do_set_affinity;
+	int cpu;
+
+	cpu = smp_processor_id();
 
 	for (irq = OCTEON_IRQ_SW0; irq <= OCTEON_IRQ_TIMER; irq++)
 		octeon_irq_core_disable_local(irq);
 
-	for (irq = OCTEON_IRQ_WORKQ0; irq <= OCTEON_IRQ_GPIO15; irq++) {
-		if (is_irq_enabled_on_cpu(irq, smp_processor_id())) {
-			/* ciu irq migrates to next cpu */
-			octeon_irq_chip_ciu0.disable(irq);
-			octeon_irq_ciu0_set_affinity(irq, &cpu_online_map);
-		}
-	}
+	for (irq = OCTEON_IRQ_WORKQ0; irq < OCTEON_IRQ_LAST; irq++) {
+		desc = irq_to_desc(irq);
+		switch (irq) {
+		case OCTEON_IRQ_MBOX0:
+		case OCTEON_IRQ_MBOX1:
+			/* The eoi function will disable them on this CPU. */
+			desc->chip->eoi(irq);
+			break;
+		case OCTEON_IRQ_WDOG0:
+		case OCTEON_IRQ_WDOG1:
+		case OCTEON_IRQ_WDOG2:
+		case OCTEON_IRQ_WDOG3:
+		case OCTEON_IRQ_WDOG4:
+		case OCTEON_IRQ_WDOG5:
+		case OCTEON_IRQ_WDOG6:
+		case OCTEON_IRQ_WDOG7:
+		case OCTEON_IRQ_WDOG8:
+		case OCTEON_IRQ_WDOG9:
+		case OCTEON_IRQ_WDOG10:
+		case OCTEON_IRQ_WDOG11:
+		case OCTEON_IRQ_WDOG12:
+		case OCTEON_IRQ_WDOG13:
+		case OCTEON_IRQ_WDOG14:
+		case OCTEON_IRQ_WDOG15:
+			/*
+			 * These have special per CPU semantics and
+			 * are handled in the watchdog driver.
+			 */
+			break;
+		default:
+			raw_spin_lock_irqsave(&desc->lock, flags);
+			/*
+			 * If this irq has an action, it is in use and
+			 * must be migrated if it has affinity to this
+			 * cpu.
+			 */
+			if (desc->action && cpumask_test_cpu(cpu, desc->affinity)) {
+				if (cpumask_weight(desc->affinity) > 1) {
+					/*
+					 * It has multi CPU affinity,
+					 * just remove this CPU from
+					 * the affinity set.
+					 */
+					cpumask_copy(&new_affinity, desc->affinity);
+					cpumask_clear_cpu(cpu, &new_affinity);
+				} else {
+					/*
+					 * Otherwise, put it on lowest
+					 * numbered online CPU.
+					 */
+					cpumask_clear(&new_affinity);
+					cpumask_set_cpu(cpumask_first(cpu_online_mask), &new_affinity);
+				}
+				do_set_affinity = 1;
+			} else {
+				do_set_affinity = 0;
+			}
+			raw_spin_unlock_irqrestore(&desc->lock, flags);
 
-#if 0
-	for (irq = OCTEON_IRQ_MBOX0; irq <= OCTEON_IRQ_MBOX1; irq++)
-		octeon_irq_mailbox_mask(irq);
-#endif
-	for (irq = OCTEON_IRQ_UART0; irq <= OCTEON_IRQ_BOOTDMA; irq++) {
-		if (is_irq_enabled_on_cpu(irq, smp_processor_id())) {
-			/* ciu irq migrates to next cpu */
-			octeon_irq_chip_ciu0.disable(irq);
-			octeon_irq_ciu0_set_affinity(irq, &cpu_online_map);
-		}
-	}
+			if (do_set_affinity)
+				irq_set_affinity(irq, &new_affinity);
 
-	for (irq = OCTEON_IRQ_UART2; irq <= OCTEON_IRQ_RESERVED135; irq++) {
-		if (is_irq_enabled_on_cpu(irq, smp_processor_id())) {
-			/* ciu irq migrates to next cpu */
-			octeon_irq_chip_ciu1.disable(irq);
-			octeon_irq_ciu1_set_affinity(irq, &cpu_online_map);
+			break;
 		}
 	}
 }
-- 
1.7.1.1
