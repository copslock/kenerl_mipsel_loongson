Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Nov 2015 12:16:57 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:25730 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012424AbbKCLNqZADm1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Nov 2015 12:13:46 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id D75E0AE975C71;
        Tue,  3 Nov 2015 11:13:37 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Tue, 3 Nov 2015 11:13:39 +0000
Received: from qyousef-linux.le.imgtec.org (192.168.154.94) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Tue, 3 Nov 2015 11:13:39 +0000
From:   Qais Yousef <qais.yousef@imgtec.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>, <jiang.liu@linux.intel.com>,
        <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        Qais Yousef <qais.yousef@imgtec.com>
Subject: [PATCH 10/14] irqchip/mips-gic: Add a IPI hierarchy domain
Date:   Tue, 3 Nov 2015 11:12:57 +0000
Message-ID: <1446549181-31788-11-git-send-email-qais.yousef@imgtec.com>
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
X-archive-position: 49815
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

MIPS GIC now supports dynamic allocation of an IPI.

Signed-off-by: Qais Yousef <qais.yousef@imgtec.com>
---
 drivers/irqchip/Kconfig        |   1 +
 drivers/irqchip/irq-mips-gic.c | 142 +++++++++++++++++++++++++++++++++++++++--
 2 files changed, 136 insertions(+), 7 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 4d7294e5d982..e1dcfdffd2c7 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -168,6 +168,7 @@ config KEYSTONE_IRQ
 
 config MIPS_GIC
 	bool
+	select IRQ_DOMAIN_HIERARCHY
 	select MIPS_CM
 
 config INGENIC_IRQ
diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index aeaa061f0dbf..9bcaa4e6f40c 100644
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
@@ -791,6 +799,115 @@ static const struct irq_domain_ops gic_irq_domain_ops = {
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
+	struct ipi_mask *ipimask = arg;
+	const unsigned long *bits;
+	struct ipi_mapping *map;
+	irq_hw_number_t hwirq;
+	int cpu, ret;
+
+	map = irq_alloc_ipi_mapping(gic_vpes);
+	if (!map)
+		return -ENOMEM;
+
+	bits = ipi_mask_bits(ipimask);
+
+	cpu = find_first_bit(bits, ipimask->nbits);
+	while (cpu != ipimask->nbits) {
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
+		cpu = find_next_bit(bits, ipimask->nbits, cpu + 1);
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
+int gic_ipi_domain_match(struct irq_domain *d, struct device_node *node,
+			 enum irq_domain_bus_token bus_token)
+{
+	bool is_ipi = true;
+
+	switch (bus_token) {
+	case DOMAIN_BUS_IPI:
+		is_ipi = d->bus_token == bus_token;
+	case DOMAIN_BUS_ANY:
+		return to_of_node(d->fwnode) == node && is_ipi;
+		break;
+	default:
+		return 0;
+	}
+}
+
+static struct irq_domain_ops gic_ipi_domain_ops = {
+	.xlate = gic_ipi_domain_xlate,
+	.alloc = gic_ipi_domain_alloc,
+	.free = gic_ipi_domain_free,
+	.match = gic_ipi_domain_match,
+};
+
 static void __init __gic_init(unsigned long gic_base_addr,
 			      unsigned long gic_addrspace_size,
 			      unsigned int cpu_vec, unsigned int irqbase,
@@ -850,6 +967,17 @@ static void __init __gic_init(unsigned long gic_base_addr,
 	if (!gic_irq_domain)
 		panic("Failed to add GIC IRQ domain");
 
+	gic_ipi_domain = irq_domain_add_hierarchy(gic_irq_domain, IRQ_DOMAIN_FLAG_IPI,
+						  GIC_NUM_LOCAL_INTRS + gic_shared_intrs,
+						  node, &gic_ipi_domain_ops, NULL);
+	if (!gic_ipi_domain)
+		panic("Failed to add GIC IPI domain");
+
+	gic_ipi_domain->bus_token = DOMAIN_BUS_IPI;
+
+	/* Make the last 2 * NR_CPUS available for IPIs */
+	bitmap_set(ipi_resrv, gic_shared_intrs - 2 * NR_CPUS, 2 * NR_CPUS);
+
 	gic_basic_init();
 
 	gic_ipi_init();
-- 
2.1.0
