Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 27 Mar 2011 18:23:32 +0200 (CEST)
Received: from www.linutronix.de ([62.245.132.108]:40554 "EHLO linutronix.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491917Ab1C0QWK (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 27 Mar 2011 18:22:10 +0200
Received: from localhost ([127.0.0.1] helo=localhost6.localdomain6)
        by linutronix.de with esmtp (Exim 4.72)
        (envelope-from <tglx@linutronix.de>)
        id 1Q3sj7-00054w-1p; Sun, 27 Mar 2011 18:22:05 +0200
Message-Id: <20110327161118.737588559@linutronix.de>
User-Agent: quilt/0.48-1
Date:   Sun, 27 Mar 2011 16:22:04 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     David Daney <ddaney@caviumnetworks.com>, linux-mips@linux-mips.org
Subject: [patch 3/5] MIPS: Octeon: Simplify irq_cpu_on/offline irq chip
        functions
References: <20110327155637.623706071@linutronix.de>
Content-Disposition: inline; filename=mips-octeon-simplify.patch
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29576
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
Precedence: bulk
X-list: linux-mips

Make use of the IRQCHIP_ONOFFLINE_ENABLED flag and remove the
wrappers. Use irqd_irq_disabled() instead of desc->status, which will
go away.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/cavium-octeon/octeon-irq.c |   71 ++++++++---------------------------
 1 file changed, 17 insertions(+), 54 deletions(-)

Index: linux-2.6-tip/arch/mips/cavium-octeon/octeon-irq.c
===================================================================
--- linux-2.6-tip.orig/arch/mips/cavium-octeon/octeon-irq.c
+++ linux-2.6-tip/arch/mips/cavium-octeon/octeon-irq.c
@@ -152,19 +152,6 @@ static void octeon_irq_core_bus_sync_unl
 	mutex_unlock(&cd->core_irq_mutex);
 }
 
-
-static void octeon_irq_core_cpu_online(struct irq_data *data)
-{
-	if (irqd_irq_disabled(data))
-		octeon_irq_core_eoi(data);
-}
-
-static void octeon_irq_core_cpu_offline(struct irq_data *data)
-{
-	if (irqd_irq_disabled(data))
-		octeon_irq_core_ack(data);
-}
-
 static struct irq_chip octeon_irq_chip_core = {
 	.name = "Core",
 	.irq_enable = octeon_irq_core_enable,
@@ -174,8 +161,9 @@ static struct irq_chip octeon_irq_chip_c
 	.irq_bus_lock = octeon_irq_core_bus_lock,
 	.irq_bus_sync_unlock = octeon_irq_core_bus_sync_unlock,
 
-	.irq_cpu_online = octeon_irq_core_cpu_online,
-	.irq_cpu_offline = octeon_irq_core_cpu_offline,
+	.irq_cpu_online = octeon_irq_core_eoi,
+	.irq_cpu_offline = octeon_irq_core_ack,
+	.flags = IRQCHIP_ONOFFLINE_ENABLED,
 };
 
 static void __init octeon_irq_init_core(void)
@@ -517,30 +505,6 @@ static void octeon_irq_ciu_enable_all_v2
 	}
 }
 
-static void octeon_irq_cpu_online_mbox(struct irq_data *data)
-{
-	if (irqd_irq_disabled(data))
-		octeon_irq_ciu_enable_local(data);
-}
-
-static void octeon_irq_cpu_online_mbox_v2(struct irq_data *data)
-{
-	if (irqd_irq_disabled(data))
-		octeon_irq_ciu_enable_local_v2(data);
-}
-
-static void octeon_irq_cpu_offline_mbox(struct irq_data *data)
-{
-	if (irqd_irq_disabled(data))
-		octeon_irq_ciu_disable_local(data);
-}
-
-static void octeon_irq_cpu_offline_mbox_v2(struct irq_data *data)
-{
-	if (irqd_irq_disabled(data))
-		octeon_irq_ciu_disable_local_v2(data);
-}
-
 #ifdef CONFIG_SMP
 
 static void octeon_irq_cpu_offline_ciu(struct irq_data *data)
@@ -570,8 +534,7 @@ static int octeon_irq_ciu_set_affinity(s
 				       const struct cpumask *dest, bool force)
 {
 	int cpu;
-	struct irq_desc *desc = irq_to_desc(data->irq);
-	int enable_one = (desc->status & IRQ_DISABLED) == 0;
+	bool enable_one = !irqd_irq_disabled(data);
 	unsigned long flags;
 	union octeon_ciu_chip_data cd;
 
@@ -585,7 +548,7 @@ static int octeon_irq_ciu_set_affinity(s
 	if (cpumask_weight(dest) != 1)
 		return -EINVAL;
 
-	if (desc->status & IRQ_DISABLED)
+	if (!enable_one)
 		return 0;
 
 	if (cd.s.line == 0) {
@@ -595,7 +558,7 @@ static int octeon_irq_ciu_set_affinity(s
 			unsigned long *pen = &per_cpu(octeon_irq_ciu0_en_mirror, cpu);
 
 			if (cpumask_test_cpu(cpu, dest) && enable_one) {
-				enable_one = 0;
+				enable_one = false;
 				set_bit(cd.s.bit, pen);
 			} else {
 				clear_bit(cd.s.bit, pen);
@@ -610,7 +573,7 @@ static int octeon_irq_ciu_set_affinity(s
 			unsigned long *pen = &per_cpu(octeon_irq_ciu1_en_mirror, cpu);
 
 			if (cpumask_test_cpu(cpu, dest) && enable_one) {
-				enable_one = 0;
+				enable_one = false;
 				set_bit(cd.s.bit, pen);
 			} else {
 				clear_bit(cd.s.bit, pen);
@@ -631,12 +594,11 @@ static int octeon_irq_ciu_set_affinity_v
 					  bool force)
 {
 	int cpu;
-	struct irq_desc *desc = irq_to_desc(data->irq);
-	int enable_one = (desc->status & IRQ_DISABLED) == 0;
+	bool enable_one = !irqd_irq_disabled(data);
 	u64 mask;
 	union octeon_ciu_chip_data cd;
 
-	if (desc->status & IRQ_DISABLED)
+	if (!enable_one)
 		return 0;
 
 	cd.p = data->chip_data;
@@ -647,7 +609,7 @@ static int octeon_irq_ciu_set_affinity_v
 			unsigned long *pen = &per_cpu(octeon_irq_ciu0_en_mirror, cpu);
 			int index = octeon_coreid_for_cpu(cpu) * 2;
 			if (cpumask_test_cpu(cpu, dest) && enable_one) {
-				enable_one = 0;
+				enable_one = false;
 				set_bit(cd.s.bit, pen);
 				cvmx_write_csr(CVMX_CIU_INTX_EN0_W1S(index), mask);
 			} else {
@@ -660,7 +622,7 @@ static int octeon_irq_ciu_set_affinity_v
 			unsigned long *pen = &per_cpu(octeon_irq_ciu1_en_mirror, cpu);
 			int index = octeon_coreid_for_cpu(cpu) * 2 + 1;
 			if (cpumask_test_cpu(cpu, dest) && enable_one) {
-				enable_one = 0;
+				enable_one = false;
 				set_bit(cd.s.bit, pen);
 				cvmx_write_csr(CVMX_CIU_INTX_EN1_W1S(index), mask);
 			} else {
@@ -679,7 +641,6 @@ static int octeon_irq_ciu_set_affinity_v
  */
 static void octeon_irq_dummy_mask(struct irq_data *data)
 {
-	return;
 }
 
 /*
@@ -741,8 +702,9 @@ static struct irq_chip octeon_irq_chip_c
 	.irq_ack = octeon_irq_ciu_disable_local_v2,
 	.irq_eoi = octeon_irq_ciu_enable_local_v2,
 
-	.irq_cpu_online = octeon_irq_cpu_online_mbox_v2,
-	.irq_cpu_offline = octeon_irq_cpu_offline_mbox_v2,
+	.irq_cpu_online = octeon_irq_ciu_enable_local_v2,
+	.irq_cpu_offline = octeon_irq_ciu_disable_local_v2,
+	.flags = IRQCHIP_ONOFFLINE_ENABLED,
 };
 
 static struct irq_chip octeon_irq_chip_ciu_mbox = {
@@ -750,8 +712,9 @@ static struct irq_chip octeon_irq_chip_c
 	.irq_enable = octeon_irq_ciu_enable_all,
 	.irq_disable = octeon_irq_ciu_disable_all,
 
-	.irq_cpu_online = octeon_irq_cpu_online_mbox,
-	.irq_cpu_offline = octeon_irq_cpu_offline_mbox,
+	.irq_cpu_online = octeon_irq_ciu_enable_local,
+	.irq_cpu_offline = octeon_irq_ciu_disable_local,
+	.flags = IRQCHIP_ONOFFLINE_ENABLED,
 };
 
 /*
