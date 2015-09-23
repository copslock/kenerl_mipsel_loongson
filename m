Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Sep 2015 16:51:44 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:59195 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008682AbbIWOuGmKnfn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Sep 2015 16:50:06 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 3D1DD19ED0E52;
        Wed, 23 Sep 2015 15:49:57 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 23 Sep 2015 15:50:00 +0100
Received: from qyousef-linux.le.imgtec.org (192.168.154.94) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 23 Sep 2015 15:49:59 +0100
From:   Qais Yousef <qais.yousef@imgtec.com>
To:     <linux-kernel@vger.kernel.org>, <tglx@linutronix.de>
CC:     <marc.zyngier@arm.com>, <jason@lakedaemon.net>,
        <jiang.liu@linux.intel.com>, <linux-mips@linux-mips.org>,
        Qais Yousef <qais.yousef@imgtec.com>
Subject: [PATCH 6/6] irqchip: mips-gic: use the new generic IPI API
Date:   Wed, 23 Sep 2015 15:49:18 +0100
Message-ID: <1443019758-20620-7-git-send-email-qais.yousef@imgtec.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1443019758-20620-1-git-send-email-qais.yousef@imgtec.com>
References: <1443019758-20620-1-git-send-email-qais.yousef@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.94]
Return-Path: <Qais.Yousef@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49344
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: qais.yousef@imgtec.com
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

Use the new IPI generic functions to implement smp IPIs.

For simplicity for now, I'm reserving the IPIs from the end of the available
hwirqs. But this could easily be changed to get a list of hwirqs to use as IPIs
from platform code or DT.

The implementation is meant as a demonstration of using the new IPI mechanism.
It is less efficient than before because of the added layer and the only
advantage is we have support for generic IPI reservation scheme.

How can we refactor this better?

Signed-off-by: Qais Yousef <qais.yousef@imgtec.com>
---
 arch/mips/kernel/smp-gic.c       | 37 ++++++++---------
 drivers/irqchip/irq-mips-gic.c   | 88 ++++++++++++++++++++++++++++++----------
 include/linux/irqchip/mips-gic.h |  3 +-
 3 files changed, 85 insertions(+), 43 deletions(-)

diff --git a/arch/mips/kernel/smp-gic.c b/arch/mips/kernel/smp-gic.c
index 5f0ab5bcd01e..ef9a80df1fcc 100644
--- a/arch/mips/kernel/smp-gic.c
+++ b/arch/mips/kernel/smp-gic.c
@@ -20,45 +20,40 @@
 
 void gic_send_ipi_single(int cpu, unsigned int action)
 {
-	unsigned long flags;
-	unsigned int intr;
-	unsigned int core = cpu_data[cpu].core;
+	gic_send_ipi_mask(cpumask_of(cpu), action);
+}
 
-	pr_debug("CPU%d: %s cpu %d action %u status %08x\n",
-		 smp_processor_id(), __func__, cpu, action, read_c0_status());
+void gic_send_ipi_mask(const struct cpumask *mask, unsigned int action)
+{
+	unsigned long flags;
+	unsigned int core;
+	int cpu;
 
 	local_irq_save(flags);
 
 	switch (action) {
 	case SMP_CALL_FUNCTION:
-		intr = plat_ipi_call_int_xlate(cpu);
+		gic_send_call_ipi(mask);
 		break;
 
 	case SMP_RESCHEDULE_YOURSELF:
-		intr = plat_ipi_resched_int_xlate(cpu);
+		gic_send_resched_ipi(mask);
 		break;
 
 	default:
 		BUG();
 	}
 
-	gic_send_ipi(intr);
-
 	if (mips_cpc_present() && (core != current_cpu_data.core)) {
-		while (!cpumask_test_cpu(cpu, &cpu_coherent_mask)) {
-			mips_cpc_lock_other(core);
-			write_cpc_co_cmd(CPC_Cx_CMD_PWRUP);
-			mips_cpc_unlock_other();
+		for_each_cpu(cpu, mask) {
+			core = cpu_data[cpu].core;
+			while (!cpumask_test_cpu(cpu, &cpu_coherent_mask)) {
+				mips_cpc_lock_other(core);
+				write_cpc_co_cmd(CPC_Cx_CMD_PWRUP);
+				mips_cpc_unlock_other();
+			}
 		}
 	}
 
 	local_irq_restore(flags);
 }
-
-void gic_send_ipi_mask(const struct cpumask *mask, unsigned int action)
-{
-	unsigned int i;
-
-	for_each_cpu(i, mask)
-		gic_send_ipi_single(i, action);
-}
diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index 14e99ea0f963..ff9b79170e2f 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -15,6 +15,7 @@
 #include <linux/irqchip/mips-gic.h>
 #include <linux/of_address.h>
 #include <linux/sched.h>
+#include <linux/slab.h>
 #include <linux/smp.h>
 
 #include <asm/mips-cm.h>
@@ -39,6 +40,7 @@ static int gic_vpes;
 static unsigned int gic_cpu_pin;
 static unsigned int timer_cpu_pin;
 static struct irq_chip gic_level_irq_controller, gic_edge_irq_controller;
+DECLARE_BITMAP(ipi_intrs, GIC_MAX_INTRS);
 
 static void __gic_irq_dispatch(void);
 
@@ -264,7 +266,7 @@ static void gic_bind_eic_interrupt(int irq, int set)
 		  GIC_VPE_EIC_SS(irq), set);
 }
 
-void gic_send_ipi(unsigned int intr)
+static void gic_send_ipi(irq_hw_number_t intr)
 {
 	gic_write(GIC_REG(SHARED, GIC_SH_WEDGE), GIC_SH_WEDGE_SET(intr));
 }
@@ -328,8 +330,14 @@ static void gic_handle_shared_int(bool chained)
 
 	intr = find_first_bit(pending, gic_shared_intrs);
 	while (intr != gic_shared_intrs) {
-		virq = irq_linear_revmap(gic_irq_domain,
-					 GIC_SHARED_TO_HWIRQ(intr));
+		if (test_bit(intr, ipi_intrs)) {
+			virq = irq_linear_revmap(gic_ipi_domain,
+					GIC_SHARED_TO_HWIRQ(intr));
+		} else {
+			virq = irq_linear_revmap(gic_irq_domain,
+					GIC_SHARED_TO_HWIRQ(intr));
+		}
+
 		if (chained)
 			generic_handle_irq(virq);
 		else
@@ -593,37 +601,74 @@ static struct irqaction irq_call = {
 	.name		= "IPI call"
 };
 
-static __init void gic_ipi_init_one(unsigned int intr, int cpu,
+static __init void gic_ipi_init_one(unsigned int virq,
 				    struct irqaction *action)
 {
-	int virq = irq_create_mapping(gic_irq_domain,
-				      GIC_SHARED_TO_HWIRQ(intr));
-	int i;
-
-	gic_map_to_vpe(intr, cpu);
-	for (i = 0; i < NR_CPUS; i++)
-		clear_bit(intr, pcpu_masks[i].pcpu_mask);
-	set_bit(intr, pcpu_masks[cpu].pcpu_mask);
+	int ret;
 
-	irq_set_irq_type(virq, IRQ_TYPE_EDGE_RISING);
+	ret = irq_set_irq_type(virq, IRQ_TYPE_EDGE_RISING);
+	if (ret) {
+		pr_warn("Failed to set IPI irq type at %d\n", virq);
+		return;
+	}
 
 	irq_set_handler(virq, handle_percpu_irq);
-	setup_irq(virq, action);
+
+	ret = setup_irq(virq, action);
+	if (ret)
+		pr_warn("Failed to setup IPI at %d\n", virq);
 }
 
 static __init void gic_ipi_init(void)
 {
-	int i;
+	int cpu, i;
+	struct ipi_hwirq *h;
 
-	/* Use last 2 * NR_CPUS interrupts as IPIs */
-	gic_resched_int_base = gic_shared_intrs - nr_cpu_ids;
-	gic_call_int_base = gic_resched_int_base - nr_cpu_ids;
+	/* We should get a list of hwirqs to reserve from DT or platform code */
+	for (i = 1; i <= 2 * cpumask_weight(cpu_possible_mask); i++) {
+		h = kzalloc(sizeof(struct ipi_hwirq), GFP_KERNEL);
+		if (!h)
+			goto out_kzalloc;
+		h->hwirq = gic_shared_intrs - i;
+		bitmap_set(ipi_intrs, h->hwirq, 1);
+		irq_domain_put_ipi_hwirq(gic_ipi_domain, h);
+	}
+
+	gic_resched_int_base = irq_reserve_ipi(gic_ipi_domain,
+						cpu_possible_mask, NULL);
+	if (!gic_resched_int_base)
+		goto out_kzalloc;
+	gic_call_int_base = irq_reserve_ipi(gic_ipi_domain,
+						cpu_possible_mask, NULL);
+	if (!gic_call_int_base) {
+		goto out_call;
+	}
+
+	for_each_cpu(cpu, cpu_possible_mask) {
+		gic_ipi_init_one(gic_call_int_base + cpu, &irq_call);
+		gic_ipi_init_one(gic_resched_int_base + cpu, &irq_resched);
+	}
+
+	return;
 
-	for (i = 0; i < nr_cpu_ids; i++) {
-		gic_ipi_init_one(gic_call_int_base + i, i, &irq_call);
-		gic_ipi_init_one(gic_resched_int_base + i, i, &irq_resched);
+out_call:
+	irq_destroy_ipi(gic_resched_int_base, NULL);
+out_kzalloc:
+	while ((h = irq_domain_get_ipi_hwirq(gic_ipi_domain))) {
+		bitmap_clear(ipi_intrs, h->hwirq, 1);
+		kfree(h);
 	}
 }
+
+void gic_send_resched_ipi(const struct cpumask *cpumask)
+{
+	irq_send_ipi(gic_resched_int_base, cpumask, NULL);
+}
+
+void gic_send_call_ipi(const struct cpumask *cpumask)
+{
+	irq_send_ipi(gic_call_int_base, cpumask, NULL);
+}
 #else
 static inline void gic_ipi_init(void)
 {
@@ -857,6 +902,7 @@ void gic_ipi_domain_free(struct irq_domain *d, unsigned int virq,
 	while ((h = irq_domain_ipi_virq_rm_hwirq(v))) {
 		for_each_cpu(vpe, &h->cpumask)
 			clear_bit(h->hwirq, pcpu_masks[vpe].pcpu_mask);
+		bitmap_clear(ipi_intrs, h->hwirq, 1);
 		irq_domain_put_ipi_hwirq(d, h);
 	}
 }
diff --git a/include/linux/irqchip/mips-gic.h b/include/linux/irqchip/mips-gic.h
index 4e6861605050..57e794e7da12 100644
--- a/include/linux/irqchip/mips-gic.h
+++ b/include/linux/irqchip/mips-gic.h
@@ -258,7 +258,8 @@ extern void gic_write_compare(cycle_t cnt);
 extern void gic_write_cpu_compare(cycle_t cnt, int cpu);
 extern void gic_start_count(void);
 extern void gic_stop_count(void);
-extern void gic_send_ipi(unsigned int intr);
+extern void gic_send_resched_ipi(const struct cpumask *cpumask);
+extern void gic_send_call_ipi(const struct cpumask *cpumask);
 extern unsigned int plat_ipi_call_int_xlate(unsigned int);
 extern unsigned int plat_ipi_resched_int_xlate(unsigned int);
 extern int gic_get_c0_compare_int(void);
-- 
2.1.0
