Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Oct 2017 17:43:17 +0100 (CET)
Received: from 19pmail.ess.barracuda.com ([64.235.154.231]:57888 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992339AbdJaQnHRMW3A (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 31 Oct 2017 17:43:07 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1411.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Tue, 31 Oct 2017 16:42:52 +0000
Received: from pburton-laptop.mipstec.com (10.20.1.18) by mips01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server id 14.3.361.1; Tue, 31 Oct 2017
 09:41:00 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>,
        Paul Burton <paul.burton@mips.com>
Subject: [PATCH v2 2/8] irqchip: mips-gic: Use irq_cpu_online to (un)mask all-VP(E) IRQs
Date:   Tue, 31 Oct 2017 09:41:45 -0700
Message-ID: <20171031164151.6357-3-paul.burton@mips.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20171031164151.6357-1-paul.burton@mips.com>
References: <867evc5cc9.fsf@arm.com>
 <20171031164151.6357-1-paul.burton@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-BESS-ID: 1509468105-452059-3093-416304-4
X-BESS-VER: 2017.12.1-r1710261623
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186454
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Paul.Burton@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60604
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@mips.com
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

The gic_all_vpes_local_irq_controller chip currently attempts to operate
on all CPUs/VPs in the system when masking or unmasking an interrupt.
This has a few drawbacks:

 - In multi-cluster systems we may not always have access to all CPUs in
   the system. When all CPUs in a cluster are powered down that
   cluster's GIC may also power down, in which case we cannot configure
   its state.

 - Relatedly, if we power down a cluster after having configured
   interrupts for CPUs within it then the cluster's GIC may lose state &
   we need to reconfigure it. The current approach doesn't take this
   into account.

 - It's wasteful if we run Linux on fewer VPs than are present in the
   system. For example if we run a uniprocessor kernel on CPU0 of a
   system with 16 CPUs then there's no point in us configuring CPUs
   1-15.

 - The implementation is also lacking in that it expects the range
   0..gic_vpes-1 to represent valid Linux CPU numbers which may not
   always be the case - for example if we run on a system with more VPs
   than the kernel is configured to support.

Fix all of these issues by only configuring the affected interrupts for
CPUs which are online at the time, and recording the configuration in a
new struct gic_all_vpes_chip_data for later use by CPUs being brought
online. We register a CPU hotplug state (reusing
CPUHP_AP_IRQ_GIC_STARTING which the ARM GIC driver uses, and which seems
suitably generic for reuse with the MIPS GIC) and execute
irq_cpu_online() in order to configure the interrupts on the newly
onlined CPU.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mips@linux-mips.org

---

Changes in v2:
- Add & use CPUHP_AP_IRQ_MIPS_GIC_STARTING state rather than reusing
  the generically-named CPUHP_AP_IRQ_GIC_STARTING used for the ARM GIC.

 drivers/irqchip/irq-mips-gic.c | 72 ++++++++++++++++++++++++++++++++----------
 include/linux/cpuhotplug.h     |  1 +
 2 files changed, 57 insertions(+), 16 deletions(-)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index 6fdcc1552fab..60f644279803 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -8,6 +8,7 @@
  */
 #include <linux/bitmap.h>
 #include <linux/clocksource.h>
+#include <linux/cpuhotplug.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
@@ -55,6 +56,11 @@ static struct irq_chip gic_level_irq_controller, gic_edge_irq_controller;
 DECLARE_BITMAP(ipi_resrv, GIC_MAX_INTRS);
 DECLARE_BITMAP(ipi_available, GIC_MAX_INTRS);
 
+static struct gic_all_vpes_chip_data {
+	u32	map;
+	bool	mask;
+} gic_all_vpes_chip_data[GIC_NUM_LOCAL_INTRS];
+
 static void gic_clear_pcpu_masks(unsigned int intr)
 {
 	unsigned int i;
@@ -338,13 +344,17 @@ static struct irq_chip gic_local_irq_controller = {
 
 static void gic_mask_local_irq_all_vpes(struct irq_data *d)
 {
-	int intr = GIC_HWIRQ_TO_LOCAL(d->hwirq);
-	int i;
+	struct gic_all_vpes_chip_data *cd;
 	unsigned long flags;
+	int intr, cpu;
+
+	intr = GIC_HWIRQ_TO_LOCAL(d->hwirq);
+	cd = irq_data_get_irq_chip_data(d);
+	cd->mask = false;
 
 	spin_lock_irqsave(&gic_lock, flags);
-	for (i = 0; i < gic_vpes; i++) {
-		write_gic_vl_other(mips_cm_vp_id(i));
+	for_each_online_cpu(cpu) {
+		write_gic_vl_other(mips_cm_vp_id(cpu));
 		write_gic_vo_rmask(BIT(intr));
 	}
 	spin_unlock_irqrestore(&gic_lock, flags);
@@ -352,22 +362,40 @@ static void gic_mask_local_irq_all_vpes(struct irq_data *d)
 
 static void gic_unmask_local_irq_all_vpes(struct irq_data *d)
 {
-	int intr = GIC_HWIRQ_TO_LOCAL(d->hwirq);
-	int i;
+	struct gic_all_vpes_chip_data *cd;
 	unsigned long flags;
+	int intr, cpu;
+
+	intr = GIC_HWIRQ_TO_LOCAL(d->hwirq);
+	cd = irq_data_get_irq_chip_data(d);
+	cd->mask = true;
 
 	spin_lock_irqsave(&gic_lock, flags);
-	for (i = 0; i < gic_vpes; i++) {
-		write_gic_vl_other(mips_cm_vp_id(i));
+	for_each_online_cpu(cpu) {
+		write_gic_vl_other(mips_cm_vp_id(cpu));
 		write_gic_vo_smask(BIT(intr));
 	}
 	spin_unlock_irqrestore(&gic_lock, flags);
 }
 
+static void gic_all_vpes_irq_cpu_online(struct irq_data *d)
+{
+	struct gic_all_vpes_chip_data *cd;
+	unsigned int intr;
+
+	intr = GIC_HWIRQ_TO_LOCAL(d->hwirq);
+	cd = irq_data_get_irq_chip_data(d);
+
+	write_gic_vl_map(intr, cd->map);
+	if (cd->mask)
+		write_gic_vl_smask(BIT(intr));
+}
+
 static struct irq_chip gic_all_vpes_local_irq_controller = {
-	.name			=	"MIPS GIC Local",
-	.irq_mask		=	gic_mask_local_irq_all_vpes,
-	.irq_unmask		=	gic_unmask_local_irq_all_vpes,
+	.name			= "MIPS GIC Local",
+	.irq_mask		= gic_mask_local_irq_all_vpes,
+	.irq_unmask		= gic_unmask_local_irq_all_vpes,
+	.irq_cpu_online		= gic_all_vpes_irq_cpu_online,
 };
 
 static void __gic_irq_dispatch(void)
@@ -424,9 +452,10 @@ static int gic_irq_domain_xlate(struct irq_domain *d, struct device_node *ctrlr,
 static int gic_irq_domain_map(struct irq_domain *d, unsigned int virq,
 			      irq_hw_number_t hwirq)
 {
+	struct gic_all_vpes_chip_data *cd;
 	unsigned long flags;
 	unsigned int intr;
-	int err, i;
+	int err, cpu;
 	u32 map;
 
 	if (hwirq >= GIC_SHARED_HWIRQ_BASE) {
@@ -459,9 +488,11 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int virq,
 		 * the rest of the MIPS kernel code does not use the
 		 * percpu IRQ API for them.
 		 */
+		cd = &gic_all_vpes_chip_data[intr];
+		cd->map = map;
 		err = irq_domain_set_hwirq_and_chip(d, virq, hwirq,
 						    &gic_all_vpes_local_irq_controller,
-						    NULL);
+						    cd);
 		if (err)
 			return err;
 
@@ -484,8 +515,8 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int virq,
 		return -EPERM;
 
 	spin_lock_irqsave(&gic_lock, flags);
-	for (i = 0; i < gic_vpes; i++) {
-		write_gic_vl_other(mips_cm_vp_id(i));
+	for_each_online_cpu(cpu) {
+		write_gic_vl_other(mips_cm_vp_id(cpu));
 		write_gic_vo_map(intr, map);
 	}
 	spin_unlock_irqrestore(&gic_lock, flags);
@@ -622,6 +653,13 @@ static const struct irq_domain_ops gic_ipi_domain_ops = {
 	.match = gic_ipi_domain_match,
 };
 
+static int gic_cpu_startup(unsigned int cpu)
+{
+	/* Invoke irq_cpu_online callbacks to enable desired interrupts */
+	irq_cpu_online();
+
+	return 0;
+}
 
 static int __init gic_of_init(struct device_node *node,
 			      struct device_node *parent)
@@ -768,6 +806,8 @@ static int __init gic_of_init(struct device_node *node,
 		}
 	}
 
-	return 0;
+	return cpuhp_setup_state(CPUHP_AP_IRQ_MIPS_GIC_STARTING,
+				 "irqchip/mips/gic:starting",
+				 gic_cpu_startup, NULL);
 }
 IRQCHIP_DECLARE(mips_gic, "mti,gic", gic_of_init);
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 6d508767e144..1966a45bc453 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -98,6 +98,7 @@ enum cpuhp_state {
 	CPUHP_AP_IRQ_HIP04_STARTING,
 	CPUHP_AP_IRQ_ARMADA_XP_STARTING,
 	CPUHP_AP_IRQ_BCM2836_STARTING,
+	CPUHP_AP_IRQ_MIPS_GIC_STARTING,
 	CPUHP_AP_ARM_MVEBU_COHERENCY,
 	CPUHP_AP_PERF_X86_AMD_UNCORE_STARTING,
 	CPUHP_AP_PERF_X86_STARTING,
-- 
2.14.3
