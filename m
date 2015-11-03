Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Nov 2015 12:17:31 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:1912 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012433AbbKCLNshG2N1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Nov 2015 12:13:48 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 92899D7A612CD;
        Tue,  3 Nov 2015 11:13:39 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Tue, 3 Nov 2015 11:13:41 +0000
Received: from qyousef-linux.le.imgtec.org (192.168.154.94) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Tue, 3 Nov 2015 11:13:41 +0000
From:   Qais Yousef <qais.yousef@imgtec.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>, <jiang.liu@linux.intel.com>,
        <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        Qais Yousef <qais.yousef@imgtec.com>,
        "James Hogan" <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 12/14] MIPS: Make smp CMP, CPS and MT use the new generic IPI functions
Date:   Tue, 3 Nov 2015 11:12:59 +0000
Message-ID: <1446549181-31788-13-git-send-email-qais.yousef@imgtec.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1446549181-31788-1-git-send-email-qais.yousef@imgtec.com>
References: <1446549181-31788-1-git-send-email-qais.yousef@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.94]
Return-Path: <Qais.Yousef@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49817
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

This commit does several things to avoid breaking bisectability.

	1- Remove IPI init code from irqchip/mips-gic
	2- Implement the new irqchip->send_ipi() in irqchip/mips-gic
	3- Select GENERIC_IRQ_IPI Kconfig symbol for MIPS_GIC
	4- Change MIPS SMP to use the generic IPI implementation

Only the SMP variants that use GIC were converted as it's the only irqchip that
will have the support for generic IPI for now.

Signed-off-by: Qais Yousef <qais.yousef@imgtec.com>
Cc: James Hogan <james.hogan@imgtec.com>
Cc: Paul Burton <paul.burton@imgtec.com>
---
 arch/mips/include/asm/smp-ops.h  |   5 +-
 arch/mips/kernel/smp-cmp.c       |   4 +-
 arch/mips/kernel/smp-cps.c       |   4 +-
 arch/mips/kernel/smp-mt.c        |   2 +-
 drivers/irqchip/Kconfig          |   1 +
 drivers/irqchip/irq-mips-gic.c   | 102 ++++++++-------------------------------
 include/linux/irqchip/mips-gic.h |   3 --
 7 files changed, 30 insertions(+), 91 deletions(-)

diff --git a/arch/mips/include/asm/smp-ops.h b/arch/mips/include/asm/smp-ops.h
index 6ba1fb8b11e2..db7c322f057f 100644
--- a/arch/mips/include/asm/smp-ops.h
+++ b/arch/mips/include/asm/smp-ops.h
@@ -44,8 +44,9 @@ static inline void plat_smp_setup(void)
 	mp_ops->smp_setup();
 }
 
-extern void gic_send_ipi_single(int cpu, unsigned int action);
-extern void gic_send_ipi_mask(const struct cpumask *mask, unsigned int action);
+extern void mips_smp_send_ipi_single(int cpu, unsigned int action);
+extern void mips_smp_send_ipi_mask(const struct cpumask *mask,
+				      unsigned int action);
 
 #else /* !CONFIG_SMP */
 
diff --git a/arch/mips/kernel/smp-cmp.c b/arch/mips/kernel/smp-cmp.c
index d5e0f949dc48..76923349b4fe 100644
--- a/arch/mips/kernel/smp-cmp.c
+++ b/arch/mips/kernel/smp-cmp.c
@@ -149,8 +149,8 @@ void __init cmp_prepare_cpus(unsigned int max_cpus)
 }
 
 struct plat_smp_ops cmp_smp_ops = {
-	.send_ipi_single	= gic_send_ipi_single,
-	.send_ipi_mask		= gic_send_ipi_mask,
+	.send_ipi_single	= mips_smp_send_ipi_single,
+	.send_ipi_mask		= mips_smp_send_ipi_mask,
 	.init_secondary		= cmp_init_secondary,
 	.smp_finish		= cmp_smp_finish,
 	.boot_secondary		= cmp_boot_secondary,
diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
index c88937745b4e..69d811e72f2b 100644
--- a/arch/mips/kernel/smp-cps.c
+++ b/arch/mips/kernel/smp-cps.c
@@ -444,8 +444,8 @@ static struct plat_smp_ops cps_smp_ops = {
 	.boot_secondary		= cps_boot_secondary,
 	.init_secondary		= cps_init_secondary,
 	.smp_finish		= cps_smp_finish,
-	.send_ipi_single	= gic_send_ipi_single,
-	.send_ipi_mask		= gic_send_ipi_mask,
+	.send_ipi_single	= mips_smp_send_ipi_single,
+	.send_ipi_mask		= mips_smp_send_ipi_mask,
 #ifdef CONFIG_HOTPLUG_CPU
 	.cpu_disable		= cps_cpu_disable,
 	.cpu_die		= cps_cpu_die,
diff --git a/arch/mips/kernel/smp-mt.c b/arch/mips/kernel/smp-mt.c
index 86311a164ef1..4f9570a57e8d 100644
--- a/arch/mips/kernel/smp-mt.c
+++ b/arch/mips/kernel/smp-mt.c
@@ -121,7 +121,7 @@ static void vsmp_send_ipi_single(int cpu, unsigned int action)
 
 #ifdef CONFIG_MIPS_GIC
 	if (gic_present) {
-		gic_send_ipi_single(cpu, action);
+		mips_smp_send_ipi_single(cpu, action);
 		return;
 	}
 #endif
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index e1dcfdffd2c7..590bc55f28da 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -168,6 +168,7 @@ config KEYSTONE_IRQ
 
 config MIPS_GIC
 	bool
+	select GENERIC_IRQ_IPI
 	select IRQ_DOMAIN_HIERARCHY
 	select MIPS_CM
 
diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index 9bcaa4e6f40c..456938a83050 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -266,9 +266,27 @@ static void gic_bind_eic_interrupt(int irq, int set)
 		  GIC_VPE_EIC_SS(irq), set);
 }
 
-void gic_send_ipi(unsigned int intr)
+static void gic_send_ipi(struct irq_data *d, const struct ipi_mask *ipimask)
 {
-	gic_write(GIC_REG(SHARED, GIC_SH_WEDGE), GIC_SH_WEDGE_SET(intr));
+	struct ipi_mapping *map = irq_data_get_irq_chip_data(d);
+	const unsigned long *bits;
+	irq_hw_number_t intr;
+	int vpe;
+
+	if (!map)
+		return;
+
+	bits = ipi_mask_bits(ipimask);
+
+	vpe = find_first_bit(bits, ipimask->nbits);
+	while (vpe != ipimask->nbits) {
+		intr = map->cpumap[vpe];
+		if (intr == INVALID_HWIRQ)
+			continue;
+		gic_write(GIC_REG(SHARED, GIC_SH_WEDGE), GIC_SH_WEDGE_SET(intr));
+
+		vpe = find_next_bit(bits, ipimask->nbits, vpe + 1);
+	}
 }
 
 int gic_get_c0_compare_int(void)
@@ -476,6 +494,7 @@ static struct irq_chip gic_edge_irq_controller = {
 #ifdef CONFIG_SMP
 	.irq_set_affinity	=	gic_set_affinity,
 #endif
+	.irq_send_ipi		=	gic_send_ipi,
 };
 
 static void gic_handle_local_int(bool chained)
@@ -569,83 +588,6 @@ static void gic_irq_dispatch(struct irq_desc *desc)
 	gic_handle_shared_int(true);
 }
 
-#ifdef CONFIG_MIPS_GIC_IPI
-static int gic_resched_int_base;
-static int gic_call_int_base;
-
-unsigned int plat_ipi_resched_int_xlate(unsigned int cpu)
-{
-	return gic_resched_int_base + cpu;
-}
-
-unsigned int plat_ipi_call_int_xlate(unsigned int cpu)
-{
-	return gic_call_int_base + cpu;
-}
-
-static irqreturn_t ipi_resched_interrupt(int irq, void *dev_id)
-{
-	scheduler_ipi();
-
-	return IRQ_HANDLED;
-}
-
-static irqreturn_t ipi_call_interrupt(int irq, void *dev_id)
-{
-	generic_smp_call_function_interrupt();
-
-	return IRQ_HANDLED;
-}
-
-static struct irqaction irq_resched = {
-	.handler	= ipi_resched_interrupt,
-	.flags		= IRQF_PERCPU,
-	.name		= "IPI resched"
-};
-
-static struct irqaction irq_call = {
-	.handler	= ipi_call_interrupt,
-	.flags		= IRQF_PERCPU,
-	.name		= "IPI call"
-};
-
-static __init void gic_ipi_init_one(unsigned int intr, int cpu,
-				    struct irqaction *action)
-{
-	int virq = irq_create_mapping(gic_irq_domain,
-				      GIC_SHARED_TO_HWIRQ(intr));
-	int i;
-
-	gic_map_to_vpe(intr, mips_cm_vp_id(cpu));
-	for (i = 0; i < NR_CPUS; i++)
-		clear_bit(intr, pcpu_masks[i].pcpu_mask);
-	set_bit(intr, pcpu_masks[cpu].pcpu_mask);
-
-	irq_set_irq_type(virq, IRQ_TYPE_EDGE_RISING);
-
-	irq_set_handler(virq, handle_percpu_irq);
-	setup_irq(virq, action);
-}
-
-static __init void gic_ipi_init(void)
-{
-	int i;
-
-	/* Use last 2 * NR_CPUS interrupts as IPIs */
-	gic_resched_int_base = gic_shared_intrs - nr_cpu_ids;
-	gic_call_int_base = gic_resched_int_base - nr_cpu_ids;
-
-	for (i = 0; i < nr_cpu_ids; i++) {
-		gic_ipi_init_one(gic_call_int_base + i, i, &irq_call);
-		gic_ipi_init_one(gic_resched_int_base + i, i, &irq_resched);
-	}
-}
-#else
-static inline void gic_ipi_init(void)
-{
-}
-#endif
-
 static void __init gic_basic_init(void)
 {
 	unsigned int i;
@@ -979,8 +921,6 @@ static void __init __gic_init(unsigned long gic_base_addr,
 	bitmap_set(ipi_resrv, gic_shared_intrs - 2 * NR_CPUS, 2 * NR_CPUS);
 
 	gic_basic_init();
-
-	gic_ipi_init();
 }
 
 void __init gic_init(unsigned long gic_base_addr,
diff --git a/include/linux/irqchip/mips-gic.h b/include/linux/irqchip/mips-gic.h
index 4e6861605050..321278767506 100644
--- a/include/linux/irqchip/mips-gic.h
+++ b/include/linux/irqchip/mips-gic.h
@@ -258,9 +258,6 @@ extern void gic_write_compare(cycle_t cnt);
 extern void gic_write_cpu_compare(cycle_t cnt, int cpu);
 extern void gic_start_count(void);
 extern void gic_stop_count(void);
-extern void gic_send_ipi(unsigned int intr);
-extern unsigned int plat_ipi_call_int_xlate(unsigned int);
-extern unsigned int plat_ipi_resched_int_xlate(unsigned int);
 extern int gic_get_c0_compare_int(void);
 extern int gic_get_c0_perfcount_int(void);
 extern int gic_get_c0_fdc_int(void);
-- 
2.1.0
