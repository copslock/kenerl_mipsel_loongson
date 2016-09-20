Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Sep 2016 10:48:45 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:6114 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992161AbcITIrxkXL20 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Sep 2016 10:47:53 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id E733C8C886E82;
        Tue, 20 Sep 2016 09:47:33 +0100 (IST)
Received: from mredfearn-linux.le.imgtec.org (10.150.130.83) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Tue, 20 Sep 2016 09:47:36 +0100
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     <linux-mips@linux-mips.org>, <linux-remoteproc@vger.kernel.org>,
        <lisa.parratt@imgtec.com>, <linux-kernel@vger.kernel.org>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Jason Cooper <jason@lakedaemon.net>
Subject: [PATCH v2 1/6] irqchip: mips-gic: Add context saving for MIPS_REMOTEPROC
Date:   Tue, 20 Sep 2016 09:47:24 +0100
Message-ID: <1474361249-31064-2-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1474361249-31064-1-git-send-email-matt.redfearn@imgtec.com>
References: <1474361249-31064-1-git-send-email-matt.redfearn@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55194
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@imgtec.com
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

The MIPS remote processor driver allows non-Linux firmware to take
control of and execute on one of the systems VPEs. If that VPE is
brought back under Linux, it is necessary to ensure that all GIC
interrupts are routed and masked as Linux expects them, as the firmware
can have done anything it likes with the GIC configuration (hopefully
just for that VPEs local interrupt sources, but allow for shared
external interrupts as well).

The configuration of shared and local CPU interrupts is maintained and
updated every time a change is made. When a CPU is brought online, the
saved configuration is restored.

These functions will also be useful for restoring GIC context after a
suspend to RAM.

This patch depends on Paul Burton's recent patches:
irqchip: mips-gic: Implement activate op for device domain
irqchip: mips-gic: Cleanup chip & handler setup

Without these patches, the context saving will restore an incorrect map
to VPE value, since there is a route to not having the interrupt
affinity set.

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
---

Changes in v2:
Add dependence on additional patches to mips-gic in commit log
Incorporate changes from Marc Zynger's review:
- Remove CONTEXT_SAVING define.
- Make saved local state a per-cpu variable
- Make gic_save_* static functions when enabled, and do { } while(0)
  otherwise

 drivers/irqchip/irq-mips-gic.c | 217 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 210 insertions(+), 7 deletions(-)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index 83f498393a7f..4aafe09849c1 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -8,6 +8,7 @@
  */
 #include <linux/bitmap.h>
 #include <linux/clocksource.h>
+#include <linux/cpu.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
@@ -56,6 +57,79 @@ static unsigned int timer_cpu_pin;
 static struct irq_chip gic_level_irq_controller, gic_edge_irq_controller;
 DECLARE_BITMAP(ipi_resrv, GIC_MAX_INTRS);
 
+#ifdef CONFIG_MIPS_REMOTEPROC
+struct gic_local_state_t {
+	u8 mask;
+};
+
+DEFINE_PER_CPU(struct gic_local_state_t, gic_local_state);
+
+static void gic_save_local_rmask(int vpe, int mask)
+{
+	struct gic_local_state_t *state = per_cpu_ptr(&gic_local_state, vpe);
+
+	state->mask &= mask;
+}
+
+static void gic_save_local_smask(int vpe, int mask)
+{
+	struct gic_local_state_t *state = per_cpu_ptr(&gic_local_state, vpe);
+
+	state->mask |= mask;
+}
+
+static struct {
+	unsigned vpe:		8;
+	unsigned pin:		4;
+
+	unsigned polarity:	1;
+	unsigned trigger:	1;
+	unsigned dual_edge:	1;
+	unsigned mask:		1;
+} gic_shared_state[GIC_MAX_INTRS];
+
+static void gic_save_shared_vpe(int intr, int vpe)
+{
+	gic_shared_state[intr].vpe = vpe;
+}
+
+static void gic_save_shared_pin(int intr, int pin)
+{
+	gic_shared_state[intr].pin = pin;
+}
+
+static void gic_save_shared_polarity(int intr, int polarity)
+{
+	gic_shared_state[intr].polarity = polarity;
+}
+
+static void gic_save_shared_trigger(int intr, int trigger)
+{
+	gic_shared_state[intr].trigger = trigger;
+}
+
+static void gic_save_shared_dual_edge(int intr, int dual_edge)
+{
+	gic_shared_state[intr].dual_edge = dual_edge;
+}
+
+static void gic_save_shared_mask(int intr, int mask)
+{
+	gic_shared_state[intr].mask = mask;
+}
+
+#else
+#define gic_save_local_rmask(vpe, i)	do { } while (0)
+#define gic_save_local_smask(vpe, i)	do { } while (0)
+
+#define gic_save_shared_vpe(i, v)	do { } while (0)
+#define gic_save_shared_pin(i, p)	do { } while (0)
+#define gic_save_shared_polarity(i, p)	do { } while (0)
+#define gic_save_shared_trigger(i, t)	do { } while (0)
+#define gic_save_shared_dual_edge(i, d)	do { } while (0)
+#define gic_save_shared_mask(i, m)	do { } while (0)
+#endif /* CONFIG_MIPS_REMOTEPROC */
+
 static void __gic_irq_dispatch(void);
 
 static inline u32 gic_read32(unsigned int reg)
@@ -105,52 +179,94 @@ static inline void gic_update_bits(unsigned int reg, unsigned long mask,
 	gic_write(reg, regval);
 }
 
-static inline void gic_reset_mask(unsigned int intr)
+static inline void gic_write_reset_mask(unsigned int intr)
 {
 	gic_write(GIC_REG(SHARED, GIC_SH_RMASK) + GIC_INTR_OFS(intr),
 		  1ul << GIC_INTR_BIT(intr));
 }
 
-static inline void gic_set_mask(unsigned int intr)
+static inline void gic_reset_mask(unsigned int intr)
+{
+	gic_save_shared_mask(intr, 0);
+	gic_write_reset_mask(intr);
+}
+
+static inline void gic_write_set_mask(unsigned int intr)
 {
 	gic_write(GIC_REG(SHARED, GIC_SH_SMASK) + GIC_INTR_OFS(intr),
 		  1ul << GIC_INTR_BIT(intr));
 }
 
-static inline void gic_set_polarity(unsigned int intr, unsigned int pol)
+static inline void gic_set_mask(unsigned int intr)
+{
+	gic_save_shared_mask(intr, 1);
+	gic_write_set_mask(intr);
+}
+
+static inline void gic_write_polarity(unsigned int intr, unsigned int pol)
 {
 	gic_update_bits(GIC_REG(SHARED, GIC_SH_SET_POLARITY) +
 			GIC_INTR_OFS(intr), 1ul << GIC_INTR_BIT(intr),
 			(unsigned long)pol << GIC_INTR_BIT(intr));
 }
 
-static inline void gic_set_trigger(unsigned int intr, unsigned int trig)
+static inline void gic_set_polarity(unsigned int intr, unsigned int pol)
+{
+	gic_save_shared_polarity(intr, pol);
+	gic_write_polarity(intr, pol);
+}
+
+static inline void gic_write_trigger(unsigned int intr, unsigned int trig)
 {
 	gic_update_bits(GIC_REG(SHARED, GIC_SH_SET_TRIGGER) +
 			GIC_INTR_OFS(intr), 1ul << GIC_INTR_BIT(intr),
 			(unsigned long)trig << GIC_INTR_BIT(intr));
 }
 
-static inline void gic_set_dual_edge(unsigned int intr, unsigned int dual)
+static inline void gic_set_trigger(unsigned int intr, unsigned int trig)
+{
+	gic_save_shared_trigger(intr, trig);
+	gic_write_trigger(intr, trig);
+}
+
+static inline void gic_write_dual_edge(unsigned int intr, unsigned int dual)
 {
 	gic_update_bits(GIC_REG(SHARED, GIC_SH_SET_DUAL) + GIC_INTR_OFS(intr),
 			1ul << GIC_INTR_BIT(intr),
 			(unsigned long)dual << GIC_INTR_BIT(intr));
 }
 
-static inline void gic_map_to_pin(unsigned int intr, unsigned int pin)
+static inline void gic_set_dual_edge(unsigned int intr, unsigned int dual)
+{
+	gic_save_shared_dual_edge(intr, dual);
+	gic_write_dual_edge(intr, dual);
+}
+
+static inline void gic_write_map_to_pin(unsigned int intr, unsigned int pin)
 {
 	gic_write32(GIC_REG(SHARED, GIC_SH_INTR_MAP_TO_PIN_BASE) +
 		    GIC_SH_MAP_TO_PIN(intr), GIC_MAP_TO_PIN_MSK | pin);
 }
 
-static inline void gic_map_to_vpe(unsigned int intr, unsigned int vpe)
+static inline void gic_map_to_pin(unsigned int intr, unsigned int pin)
+{
+	gic_save_shared_pin(intr, pin);
+	gic_write_map_to_pin(intr, pin);
+}
+
+static inline void gic_write_map_to_vpe(unsigned int intr, unsigned int vpe)
 {
 	gic_write(GIC_REG(SHARED, GIC_SH_INTR_MAP_TO_VPE_BASE) +
 		  GIC_SH_MAP_TO_VPE_REG_OFF(intr, vpe),
 		  GIC_SH_MAP_TO_VPE_REG_BIT(vpe));
 }
 
+static inline void gic_map_to_vpe(unsigned int intr, unsigned int vpe)
+{
+	gic_save_shared_vpe(intr, vpe);
+	gic_write_map_to_vpe(intr, vpe);
+}
+
 #ifdef CONFIG_CLKSRC_MIPS_GIC
 cycle_t gic_read_count(void)
 {
@@ -537,6 +653,7 @@ static void gic_mask_local_irq(struct irq_data *d)
 {
 	int intr = GIC_HWIRQ_TO_LOCAL(d->hwirq);
 
+	gic_save_local_rmask(smp_processor_id(), (1 << intr));
 	gic_write32(GIC_REG(VPE_LOCAL, GIC_VPE_RMASK), 1 << intr);
 }
 
@@ -544,6 +661,7 @@ static void gic_unmask_local_irq(struct irq_data *d)
 {
 	int intr = GIC_HWIRQ_TO_LOCAL(d->hwirq);
 
+	gic_save_local_smask(smp_processor_id(), (1 << intr));
 	gic_write32(GIC_REG(VPE_LOCAL, GIC_VPE_SMASK), 1 << intr);
 }
 
@@ -561,6 +679,7 @@ static void gic_mask_local_irq_all_vpes(struct irq_data *d)
 
 	spin_lock_irqsave(&gic_lock, flags);
 	for (i = 0; i < gic_vpes; i++) {
+		gic_save_local_rmask(mips_cm_vp_id(i), 1 << intr);
 		gic_write(GIC_REG(VPE_LOCAL, GIC_VPE_OTHER_ADDR),
 			  mips_cm_vp_id(i));
 		gic_write32(GIC_REG(VPE_OTHER, GIC_VPE_RMASK), 1 << intr);
@@ -576,6 +695,7 @@ static void gic_unmask_local_irq_all_vpes(struct irq_data *d)
 
 	spin_lock_irqsave(&gic_lock, flags);
 	for (i = 0; i < gic_vpes; i++) {
+		gic_save_local_smask(mips_cm_vp_id(i), 1 << intr);
 		gic_write(GIC_REG(VPE_LOCAL, GIC_VPE_OTHER_ADDR),
 			  mips_cm_vp_id(i));
 		gic_write32(GIC_REG(VPE_OTHER, GIC_VPE_SMASK), 1 << intr);
@@ -983,6 +1103,85 @@ static struct irq_domain_ops gic_ipi_domain_ops = {
 	.match = gic_ipi_domain_match,
 };
 
+#ifdef CONFIG_MIPS_REMOTEPROC
+static void gic_restore_shared(void)
+{
+	unsigned long flags;
+	int i;
+
+	spin_lock_irqsave(&gic_lock, flags);
+	for (i = 0; i < gic_shared_intrs; i++) {
+		gic_write_polarity(i, gic_shared_state[i].polarity);
+		gic_write_trigger(i, gic_shared_state[i].trigger);
+		gic_write_dual_edge(i, gic_shared_state[i].dual_edge);
+		gic_write_map_to_vpe(i, gic_shared_state[i].vpe);
+		gic_write_map_to_pin(i, gic_shared_state[i].pin);
+
+		if (gic_shared_state[i].mask)
+			gic_write_set_mask(i);
+		else
+			gic_write_reset_mask(i);
+	}
+	spin_unlock_irqrestore(&gic_lock, flags);
+}
+
+static void gic_restore_local(unsigned int vpe)
+{
+	struct gic_local_state_t state;
+	int hw, virq, intr, mask;
+	unsigned long flags;
+
+	for (hw = 0; hw < GIC_NUM_LOCAL_INTRS; hw++) {
+		intr = GIC_LOCAL_TO_HWIRQ(hw);
+		virq = irq_linear_revmap(gic_irq_domain, intr);
+		gic_local_irq_domain_map(gic_irq_domain, virq, hw);
+	}
+
+	local_irq_save(flags);
+	gic_write(GIC_REG(VPE_LOCAL, GIC_VPE_OTHER_ADDR), vpe);
+
+	/* Enable EIC mode if necessary */
+	gic_write32(GIC_REG(VPE_OTHER, GIC_VPE_CTL), cpu_has_veic);
+
+	/* Restore interrupt masks */
+	state = per_cpu(gic_local_state, vpe);
+	mask = state.mask;
+	gic_write32(GIC_REG(VPE_OTHER, GIC_VPE_RMASK), ~mask);
+	gic_write32(GIC_REG(VPE_OTHER, GIC_VPE_SMASK), mask);
+
+	local_irq_restore(flags);
+}
+
+/*
+ * The MIPS remote processor driver allows non-Linux firmware to take control
+ * of and execute on one of the systems VPEs. If that VPE is brought back under
+ * Linux, it is necessary to ensure that all GIC interrupts are routed and
+ * masked as Linux expects them, as the firmware can have done anything it
+ * likes with the GIC configuration (hopefully just for that VPEs local
+ * interrupt sources, but allow for shared external interrupts as well).
+ */
+static int gic_cpu_notify(struct notifier_block *nfb, unsigned long action,
+			       void *hcpu)
+{
+	unsigned int cpu = mips_cm_vp_id((unsigned long)hcpu);
+
+	switch (action) {
+	case CPU_UP_PREPARE:
+	case CPU_DOWN_FAILED:
+		gic_restore_shared();
+		gic_restore_local(cpu);
+	default:
+		break;
+	}
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block gic_cpu_notifier __refdata = {
+	.notifier_call = gic_cpu_notify
+};
+#endif /* CONFIG_MIPS_REMOTEPROC */
+
 static void __init __gic_init(unsigned long gic_base_addr,
 			      unsigned long gic_addrspace_size,
 			      unsigned int cpu_vec, unsigned int irqbase,
@@ -1082,6 +1281,10 @@ static void __init __gic_init(unsigned long gic_base_addr,
 	}
 
 	gic_basic_init();
+
+#ifdef CONFIG_MIPS_REMOTEPROC
+	register_hotcpu_notifier(&gic_cpu_notifier);
+#endif /* CONFIG_MIPS_REMOTEPROC */
 }
 
 void __init gic_init(unsigned long gic_base_addr,
-- 
2.7.4
