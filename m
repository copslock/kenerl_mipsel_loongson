Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Oct 2015 12:19:50 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:12489 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006648AbbJMKRBKZf6s (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Oct 2015 12:17:01 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id D9FBC517F284B;
        Tue, 13 Oct 2015 11:16:57 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 13 Oct 2015 11:16:59 +0100
Received: from qyousef-linux.le.imgtec.org (192.168.154.94) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Tue, 13 Oct 2015 11:16:58 +0100
From:   Qais Yousef <qais.yousef@imgtec.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>, <jiang.liu@linux.intel.com>,
        <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        Qais Yousef <qais.yousef@imgtec.com>
Subject: [RFC v2 PATCH 12/14] irqchip: mips-gic: add a IPI hierarchy domain
Date:   Tue, 13 Oct 2015 11:16:20 +0100
Message-ID: <1444731382-19313-13-git-send-email-qais.yousef@imgtec.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1444731382-19313-1-git-send-email-qais.yousef@imgtec.com>
References: <1444731382-19313-1-git-send-email-qais.yousef@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.94]
Return-Path: <Qais.Yousef@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49506
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

Add a new ipi domain on top of the normal domain.

We set it as the default domain to allow arch code to use it without looking up
DT.

Signed-off-by: Qais Yousef <qais.yousef@imgtec.com>
---
 drivers/irqchip/Kconfig        |   2 +
 drivers/irqchip/irq-mips-gic.c | 126 ++++++++++++++++++++++++++++++++++++++---
 2 files changed, 121 insertions(+), 7 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 27b52c8729cd..d9a9c8c8cbe1 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -167,6 +167,8 @@ config KEYSTONE_IRQ
 
 config MIPS_GIC
 	bool
+	select GENERIC_IRQ_IPI
+	select IRQ_DOMAIN_HIERARCHY
 	select MIPS_CM
 
 config INGENIC_IRQ
diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index aeaa061f0dbf..9c8ece1d90f2 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -33,11 +33,14 @@ static void __iomem *gic_base;
 static struct gic_pcpu_mask pcpu_masks[NR_CPUS];
 static DEFINE_SPINLOCK(gic_lock);
 static struct irq_domain *gic_irq_domain;
+static struct irq_domain *gic_ipi_domain;
 static int gic_shared_intrs;
 static int gic_vpes;
 static unsigned int gic_cpu_pin;
 static unsigned int timer_cpu_pin;
 static struct irq_chip gic_level_irq_controller, gic_edge_irq_controller;
+DECLARE_BITMAP(ipi_intrs, GIC_MAX_INTRS);
+DECLARE_BITMAP(ipi_resrv, GIC_MAX_INTRS);
 
 static void __gic_irq_dispatch(void);
 
@@ -335,8 +338,14 @@ static void gic_handle_shared_int(bool chained)
 
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
@@ -741,7 +750,7 @@ static int gic_local_irq_domain_map(struct irq_domain *d, unsigned int virq,
 }
 
 static int gic_shared_irq_domain_map(struct irq_domain *d, unsigned int virq,
-				     irq_hw_number_t hw)
+				     irq_hw_number_t hw, unsigned int vpe)
 {
 	int intr = GIC_HWIRQ_TO_SHARED(hw);
 	unsigned long flags;
@@ -751,9 +760,8 @@ static int gic_shared_irq_domain_map(struct irq_domain *d, unsigned int virq,
 
 	spin_lock_irqsave(&gic_lock, flags);
 	gic_map_to_pin(intr, gic_cpu_pin);
-	/* Map to VPE 0 by default */
-	gic_map_to_vpe(intr, 0);
-	set_bit(intr, pcpu_masks[0].pcpu_mask);
+	gic_map_to_vpe(intr, vpe);
+	set_bit(intr, pcpu_masks[vpe].pcpu_mask);
 	spin_unlock_irqrestore(&gic_lock, flags);
 
 	return 0;
@@ -764,7 +772,7 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int virq,
 {
 	if (GIC_HWIRQ_TO_LOCAL(hw) < GIC_NUM_LOCAL_INTRS)
 		return gic_local_irq_domain_map(d, virq, hw);
-	return gic_shared_irq_domain_map(d, virq, hw);
+	return gic_shared_irq_domain_map(d, virq, hw, 0);
 }
 
 static int gic_irq_domain_xlate(struct irq_domain *d, struct device_node *ctrlr,
@@ -791,6 +799,98 @@ static const struct irq_domain_ops gic_irq_domain_ops = {
 	.xlate = gic_irq_domain_xlate,
 };
 
+static int gic_ipi_domain_xlate(struct irq_domain *d, struct device_node *ctrlr,
+				const u32 *intspec, unsigned int intsize,
+				irq_hw_number_t *out_hwirq,
+				unsigned int *out_type)
+{
+	/*
+	 * There's nothing to translate here. hwirq is dynamically allocated and
+	 * the irq type is always edge triggered.
+	 * */
+	*out_hwirq = 0;
+	*out_type = IRQ_TYPE_EDGE_RISING;
+
+	return 0;
+}
+
+static int gic_ipi_domain_alloc(struct irq_domain *d, unsigned int virq,
+				unsigned int nr_irqs, void *arg)
+{
+	struct ipi_mask *cpumask = arg;
+	int cpu, ret;
+	irq_hw_number_t hwirq;
+	struct ipi_mapping *map;
+
+	map = irq_alloc_ipi_mapping(gic_vpes);
+	if (!map)
+		return -ENOMEM;
+
+	if (cpumask->nbits > map->nr_cpus)
+		return -EINVAL;
+
+	cpu = find_first_bit(cpumask->cpumask, cpumask->nbits);
+	while (cpu != cpumask->nbits) {
+		hwirq = find_first_bit(ipi_resrv, gic_shared_intrs);
+		if (hwirq == gic_shared_intrs) {
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		bitmap_clear(ipi_resrv, hwirq, 1);
+		bitmap_set(ipi_intrs, hwirq, 1);
+
+		ret = irq_map_ipi(map, cpu, hwirq);
+		if (ret)
+			goto out;
+
+		hwirq = GIC_SHARED_TO_HWIRQ(hwirq);
+		ret = irq_domain_set_hwirq_and_chip(d, virq + cpu, hwirq,
+						&gic_edge_irq_controller, map);
+		if (ret)
+			goto out;
+
+		ret = gic_shared_irq_domain_map(d, virq + cpu, hwirq, cpu);
+		if (ret)
+			goto out;
+
+		ret = irq_set_irq_type(virq + cpu, IRQ_TYPE_EDGE_RISING);
+		if (ret)
+			goto out;
+
+		cpu = find_next_bit(cpumask->cpumask, cpumask->nbits, cpu + 1);
+	}
+
+	return 0;
+out:
+	irq_free_ipi_mapping(map);
+	return ret;
+}
+
+void gic_ipi_domain_free(struct irq_domain *d, unsigned int virq,
+			 unsigned int nr_irqs)
+{
+	struct ipi_mapping *map = irq_get_chip_data(virq);
+	irq_hw_number_t hwirq;
+	int ret, cpu;
+
+	for (cpu = 0; cpu < map->nr_cpus; cpu++) {
+		ret = irq_unmap_ipi(map, cpu, &hwirq);
+		if (!ret) {
+			bitmap_set(ipi_resrv, hwirq, 1);
+			bitmap_clear(ipi_intrs, hwirq, 1);
+		}
+	}
+
+	irq_free_ipi_mapping(map);
+}
+
+static struct irq_domain_ops gic_ipi_domain_ops = {
+	.xlate = gic_ipi_domain_xlate,
+	.alloc = gic_ipi_domain_alloc,
+	.free = gic_ipi_domain_free,
+};
+
 static void __init __gic_init(unsigned long gic_base_addr,
 			      unsigned long gic_addrspace_size,
 			      unsigned int cpu_vec, unsigned int irqbase,
@@ -850,6 +950,18 @@ static void __init __gic_init(unsigned long gic_base_addr,
 	if (!gic_irq_domain)
 		panic("Failed to add GIC IRQ domain");
 
+	gic_ipi_domain = irq_domain_add_hierarchy(gic_irq_domain, IRQ_DOMAIN_FLAG_IPI,
+						  GIC_NUM_LOCAL_INTRS + gic_shared_intrs,
+						  NULL, &gic_ipi_domain_ops, NULL);
+	if (!gic_ipi_domain)
+		panic("Failed to add GIC IPI domain");
+
+	/* set IPI domain as default */
+	irq_set_default_host(gic_ipi_domain);
+
+	/* Make the last 2 * NR_CPUS available for IPIs */
+	bitmap_set(ipi_resrv, gic_shared_intrs - 2 * NR_CPUS, 2 * NR_CPUS);
+
 	gic_basic_init();
 
 	gic_ipi_init();
-- 
2.1.0
