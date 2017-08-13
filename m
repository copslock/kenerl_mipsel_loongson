Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Aug 2017 06:50:55 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:61741 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994817AbdHMEsFU0sbd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 13 Aug 2017 06:48:05 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id B5B13B24AE598;
        Sun, 13 Aug 2017 05:47:56 +0100 (IST)
Received: from localhost (10.20.79.142) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Sun, 13 Aug
 2017 05:47:58 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 35/38] irqchip: mips-gic: Use pcpu_masks to avoid reading GIC_SH_MASK*
Date:   Sat, 12 Aug 2017 21:36:43 -0700
Message-ID: <20170813043646.25821-36-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.14.0
In-Reply-To: <20170813043646.25821-1-paul.burton@imgtec.com>
References: <20170813043646.25821-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.79.142]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59551
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

This patch avoids the need to read the GIC_SH_MASK* registers when
decoding shared interrupts by setting & clearing the interrupt's bit in
the appropriate CPU's pcpu_masks entry when masking or unmasking the
interrupt.

This effectively means that whilst an interrupt is masked we clear its
bit in all pcpu_masks, which causes gic_handle_shared_int() to ignore it
on all CPUs without needing to check GIC_SH_MASK*.

In essence, we add a little overhead to masking or unmasking interrupts
but in return reduce the overhead of the far more common task of
decoding interrupts.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mips@linux-mips.org
---

 drivers/irqchip/irq-mips-gic.c | 49 ++++++++++++++++++++++++------------------
 1 file changed, 28 insertions(+), 21 deletions(-)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index 00153231376a..7a42f0b3822f 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -55,6 +55,19 @@ static struct irq_chip gic_level_irq_controller, gic_edge_irq_controller;
 DECLARE_BITMAP(ipi_resrv, GIC_MAX_INTRS);
 DECLARE_BITMAP(ipi_available, GIC_MAX_INTRS);
 
+static void gic_setup_pcpu_mask(unsigned int intr, unsigned int cpu)
+{
+	unsigned int i;
+
+	/* Clear the interrupt's bit in all pcpu_masks */
+	for_each_possible_cpu(i)
+		clear_bit(intr, per_cpu_ptr(pcpu_masks, i));
+
+	/* Set the interrupt's bit in the appropriate CPU's mask */
+	if (cpu < NR_CPUS)
+		set_bit(intr, per_cpu_ptr(pcpu_masks, cpu));
+}
+
 static bool gic_local_irq_is_routable(int intr)
 {
 	u32 vpe_ctl;
@@ -133,24 +146,17 @@ static void gic_handle_shared_int(bool chained)
 	unsigned int intr, virq;
 	unsigned long *pcpu_mask;
 	DECLARE_BITMAP(pending, GIC_MAX_INTRS);
-	DECLARE_BITMAP(intrmask, GIC_MAX_INTRS);
 
 	/* Get per-cpu bitmaps */
 	pcpu_mask = this_cpu_ptr(pcpu_masks);
 
-	if (mips_cm_is64) {
+	if (mips_cm_is64)
 		__ioread64_copy(pending, addr_gic_pend(),
 				DIV_ROUND_UP(gic_shared_intrs, 64));
-		__ioread64_copy(intrmask, addr_gic_mask(),
-				DIV_ROUND_UP(gic_shared_intrs, 64));
-	} else {
+	else
 		__ioread32_copy(pending, addr_gic_pend(),
 				DIV_ROUND_UP(gic_shared_intrs, 32));
-		__ioread32_copy(intrmask, addr_gic_mask(),
-				DIV_ROUND_UP(gic_shared_intrs, 32));
-	}
 
-	bitmap_and(pending, pending, intrmask, gic_shared_intrs);
 	bitmap_and(pending, pending, pcpu_mask, gic_shared_intrs);
 
 	for_each_set_bit(intr, pending, gic_shared_intrs) {
@@ -165,12 +171,19 @@ static void gic_handle_shared_int(bool chained)
 
 static void gic_mask_irq(struct irq_data *d)
 {
-	write_gic_rmask(BIT(GIC_HWIRQ_TO_SHARED(d->hwirq)));
+	unsigned int intr = GIC_HWIRQ_TO_SHARED(d->hwirq);
+
+	write_gic_rmask(BIT(intr));
+	gic_setup_pcpu_mask(intr, NR_CPUS);
 }
 
 static void gic_unmask_irq(struct irq_data *d)
 {
-	write_gic_smask(BIT(GIC_HWIRQ_TO_SHARED(d->hwirq)));
+	struct cpumask *affinity = irq_data_get_affinity_mask(d);
+	unsigned int intr = GIC_HWIRQ_TO_SHARED(d->hwirq);
+
+	write_gic_smask(BIT(intr));
+	gic_setup_pcpu_mask(intr, cpumask_first_and(affinity, cpu_online_mask));
 }
 
 static void gic_ack_irq(struct irq_data *d)
@@ -239,7 +252,6 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *cpumask,
 	unsigned int irq = GIC_HWIRQ_TO_SHARED(d->hwirq);
 	cpumask_t	tmp = CPU_MASK_NONE;
 	unsigned long	flags;
-	int		i;
 
 	cpumask_and(&tmp, cpumask, cpu_online_mask);
 	if (cpumask_empty(&tmp))
@@ -252,9 +264,7 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *cpumask,
 	write_gic_map_vp(irq, BIT(mips_cm_vp_id(cpumask_first(&tmp))));
 
 	/* Update the pcpu_masks */
-	for (i = 0; i < min(gic_vpes, NR_CPUS); i++)
-		clear_bit(irq, per_cpu_ptr(pcpu_masks, i));
-	set_bit(irq, per_cpu_ptr(pcpu_masks, cpumask_first(&tmp)));
+	gic_setup_pcpu_mask(irq, read_gic_mask(irq) ? cpumask_first(&tmp) : NR_CPUS);
 
 	cpumask_copy(irq_data_get_affinity_mask(d), cpumask);
 	spin_unlock_irqrestore(&gic_lock, flags);
@@ -405,18 +415,15 @@ static int gic_local_irq_domain_map(struct irq_domain *d, unsigned int virq,
 }
 
 static int gic_shared_irq_domain_map(struct irq_domain *d, unsigned int virq,
-				     irq_hw_number_t hw, unsigned int vpe)
+				     irq_hw_number_t hw, unsigned int cpu)
 {
 	int intr = GIC_HWIRQ_TO_SHARED(hw);
 	unsigned long flags;
-	int i;
 
 	spin_lock_irqsave(&gic_lock, flags);
 	write_gic_map_pin(intr, GIC_MAP_PIN_MAP_TO_PIN | gic_cpu_pin);
-	write_gic_map_vp(intr, BIT(mips_cm_vp_id(vpe)));
-	for (i = 0; i < min(gic_vpes, NR_CPUS); i++)
-		clear_bit(intr, per_cpu_ptr(pcpu_masks, i));
-	set_bit(intr, per_cpu_ptr(pcpu_masks, vpe));
+	write_gic_map_vp(intr, BIT(mips_cm_vp_id(cpu)));
+	gic_setup_pcpu_mask(intr, cpu);
 	spin_unlock_irqrestore(&gic_lock, flags);
 
 	return 0;
-- 
2.14.0
