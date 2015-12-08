Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Dec 2015 14:24:53 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:23185 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013383AbbLHNVmHKYQZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Dec 2015 14:21:42 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 81A7CE9C9B419;
        Tue,  8 Dec 2015 13:18:31 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Tue, 8 Dec 2015 13:21:34 +0000
Received: from qyousef-linux.le.imgtec.org (192.168.154.94) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Tue, 8 Dec 2015 13:21:34 +0000
From:   Qais Yousef <qais.yousef@imgtec.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>, <jiang.liu@linux.intel.com>,
        <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        <lisa.parratt@imgtec.com>, Qais Yousef <qais.yousef@imgtec.com>
Subject: [PATCH v4 12/19] irqchip/mips-gic: Add a IPI hierarchy domain
Date:   Tue, 8 Dec 2015 13:20:23 +0000
Message-ID: <1449580830-23652-13-git-send-email-qais.yousef@imgtec.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1449580830-23652-1-git-send-email-qais.yousef@imgtec.com>
References: <1449580830-23652-1-git-send-email-qais.yousef@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.94]
Return-Path: <Qais.Yousef@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50436
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
 drivers/irqchip/irq-mips-gic.c | 184 +++++++++++++++++++++++++++++++++++++++--
 2 files changed, 180 insertions(+), 5 deletions(-)

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
index 9e17ef27a183..3c10ff6c2e12 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -29,16 +29,31 @@ struct gic_pcpu_mask {
 	DECLARE_BITMAP(pcpu_mask, GIC_MAX_INTRS);
 };
 
+struct gic_irq_spec {
+	enum {
+		GIC_DEVICE,
+		GIC_IPI
+	} type;
+
+	union {
+		struct cpumask *ipimask;
+		unsigned int hwirq;
+	};
+};
+
 static unsigned long __gic_base_addr;
+
 static void __iomem *gic_base;
 static struct gic_pcpu_mask pcpu_masks[NR_CPUS];
 static DEFINE_SPINLOCK(gic_lock);
 static struct irq_domain *gic_irq_domain;
+static struct irq_domain *gic_ipi_domain;
 static int gic_shared_intrs;
 static int gic_vpes;
 static unsigned int gic_cpu_pin;
 static unsigned int timer_cpu_pin;
 static struct irq_chip gic_level_irq_controller, gic_edge_irq_controller;
+DECLARE_BITMAP(ipi_resrv, GIC_MAX_INTRS);
 
 static void __gic_irq_dispatch(void);
 
@@ -753,7 +768,7 @@ static int gic_local_irq_domain_map(struct irq_domain *d, unsigned int virq,
 }
 
 static int gic_shared_irq_domain_map(struct irq_domain *d, unsigned int virq,
-				     irq_hw_number_t hw)
+				     irq_hw_number_t hw, unsigned int vpe)
 {
 	int intr = GIC_HWIRQ_TO_SHARED(hw);
 	unsigned long flags;
@@ -763,9 +778,8 @@ static int gic_shared_irq_domain_map(struct irq_domain *d, unsigned int virq,
 
 	spin_lock_irqsave(&gic_lock, flags);
 	gic_map_to_pin(intr, gic_cpu_pin);
-	/* Map to VPE 0 by default */
-	gic_map_to_vpe(intr, 0);
-	set_bit(intr, pcpu_masks[0].pcpu_mask);
+	gic_map_to_vpe(intr, vpe);
+	set_bit(intr, pcpu_masks[vpe].pcpu_mask);
 	spin_unlock_irqrestore(&gic_lock, flags);
 
 	return 0;
@@ -776,7 +790,7 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int virq,
 {
 	if (GIC_HWIRQ_TO_LOCAL(hw) < GIC_NUM_LOCAL_INTRS)
 		return gic_local_irq_domain_map(d, virq, hw);
-	return gic_shared_irq_domain_map(d, virq, hw);
+	return gic_shared_irq_domain_map(d, virq, hw, 0);
 }
 
 static int gic_irq_domain_xlate(struct irq_domain *d, struct device_node *ctrlr,
@@ -798,9 +812,157 @@ static int gic_irq_domain_xlate(struct irq_domain *d, struct device_node *ctrlr,
 	return 0;
 }
 
+static int gic_irq_domain_alloc(struct irq_domain *d, unsigned int virq,
+				unsigned int nr_irqs, void *arg)
+{
+	struct gic_irq_spec *spec = arg;
+	irq_hw_number_t hwirq, base_hwirq;
+	int cpu, ret, i;
+
+	if (spec->type == GIC_DEVICE) {
+		/* verify that it doesn't conflict with an IPI irq */
+		if (test_bit(spec->hwirq, ipi_resrv))
+			return -EBUSY;
+	} else {
+		base_hwirq = find_first_bit(ipi_resrv, gic_shared_intrs);
+		if (base_hwirq == gic_shared_intrs) {
+			return -ENOMEM;
+		}
+
+		/* check that we have enough space */
+		for (i = base_hwirq; i < nr_irqs; i++) {
+			if (!test_bit(i, ipi_resrv))
+				return -EBUSY;
+		}
+		bitmap_clear(ipi_resrv, base_hwirq, nr_irqs);
+
+		/* map the hwirq for each cpu consecutively */
+		i = 0;
+		for_each_cpu(cpu, spec->ipimask) {
+			hwirq = GIC_SHARED_TO_HWIRQ(base_hwirq + i);
+
+			ret = irq_domain_set_hwirq_and_chip(d, virq + i, hwirq,
+							    &gic_edge_irq_controller,
+							    NULL);
+			if (ret)
+				goto error;
+
+			ret = gic_shared_irq_domain_map(d, virq + i, hwirq, cpu);
+			if (ret)
+				goto error;
+
+			i++;
+		}
+
+		/*
+		 * tell the parent about the base hwirq we allocated so it can
+		 * set its own domain data
+		 */
+		spec->hwirq = base_hwirq;
+	}
+
+	return 0;
+error:
+	bitmap_set(ipi_resrv, base_hwirq, nr_irqs);
+	return ret;
+}
+
+void gic_irq_domain_free(struct irq_domain *d, unsigned int virq,
+			 unsigned int nr_irqs)
+{
+	irq_hw_number_t base_hwirq;
+	struct irq_data *data;
+
+	data = irq_get_irq_data(virq);
+	if (!data)
+		return;
+
+	base_hwirq = irqd_to_hwirq(data);
+	bitmap_set(ipi_resrv, base_hwirq, nr_irqs);
+}
+
 static const struct irq_domain_ops gic_irq_domain_ops = {
 	.map = gic_irq_domain_map,
 	.xlate = gic_irq_domain_xlate,
+	.alloc = gic_irq_domain_alloc,
+	.free = gic_irq_domain_free,
+};
+
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
+	struct cpumask *ipimask = arg;
+	struct gic_irq_spec spec = {
+		.type = GIC_IPI,
+		.ipimask = ipimask
+	};
+	int ret, i;
+
+	ret = irq_domain_alloc_irqs_parent(d, virq, nr_irqs, &spec);
+	if (ret)
+		return ret;
+
+	/* the parent should have set spec.hwirq to the base_hwirq it allocated */
+	for (i = 0; i < nr_irqs; i++) {
+		ret = irq_domain_set_hwirq_and_chip(d, virq + i,
+						    GIC_SHARED_TO_HWIRQ(spec.hwirq + i),
+						    &gic_edge_irq_controller,
+						    NULL);
+		if (ret)
+			goto error;
+
+		ret = irq_set_irq_type(virq + i, IRQ_TYPE_EDGE_RISING);
+		if (ret)
+			goto error;
+	}
+
+	return 0;
+error:
+	irq_domain_free_irqs_parent(d, virq, nr_irqs);
+	return ret;
+}
+
+void gic_ipi_domain_free(struct irq_domain *d, unsigned int virq,
+			 unsigned int nr_irqs)
+{
+	irq_domain_free_irqs_parent(d, virq, nr_irqs);
+}
+
+int gic_ipi_domain_match(struct irq_domain *d, struct device_node *node,
+			 enum irq_domain_bus_token bus_token)
+{
+	bool is_ipi;
+
+	switch (bus_token) {
+	case DOMAIN_BUS_IPI:
+		is_ipi = d->bus_token == bus_token;
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
 };
 
 static void __init __gic_init(unsigned long gic_base_addr,
@@ -864,6 +1026,18 @@ static void __init __gic_init(unsigned long gic_base_addr,
 	if (!gic_irq_domain)
 		panic("Failed to add GIC IRQ domain");
 
+	gic_ipi_domain = irq_domain_add_hierarchy(gic_irq_domain,
+						  IRQ_DOMAIN_FLAG_IPI_PER_CPU,
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
