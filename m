Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Apr 2017 11:08:46 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:62248 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991867AbdDTJHwZ-Ysd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 20 Apr 2017 11:07:52 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 860F7AA142BDE;
        Thu, 20 Apr 2017 10:07:42 +0100 (IST)
Received: from mredfearn-linux.le.imgtec.org (10.150.130.83) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 20 Apr 2017 10:07:44 +0100
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Jason Cooper <jason@lakedaemon.net>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] irqchip: mips-gic: Remove device IRQ domain
Date:   Thu, 20 Apr 2017 10:07:35 +0100
Message-ID: <1492679256-14513-3-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1492679256-14513-1-git-send-email-matt.redfearn@imgtec.com>
References: <1492679256-14513-1-git-send-email-matt.redfearn@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57738
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

From: Paul Burton <paul.burton@imgtec.com>

In commit c98c1822ee13 ("irqchip/mips-gic: Add device hierarchy domain")
Qais indicates that he felt having a separate device IRQ domain was
cleaner, but along with everyone else I'm aware of touching this driver
I disagree.

Remove the separate device IRQ domain so that we simply have the main
GIC IRQ domain used for devices, and an IPI IRQ domain as a child. The
logic for handling the device interrupts & IPIs is cleanly separated
into the appropriate domain ops, making it much easier to reason about
what the driver is doing than the previous approach where the 2 child
domains had to call up to their parent, which had to handle both types
of interrupt & had all sorts of weird & wonderful duplication or
outright clobbering of setup performed by multiple domains.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
---

 drivers/irqchip/irq-mips-gic.c | 290 +++++++++++++----------------------------
 1 file changed, 93 insertions(+), 197 deletions(-)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index db058e10df00..eb448a1d57b4 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -29,25 +29,12 @@ struct gic_pcpu_mask {
 	DECLARE_BITMAP(pcpu_mask, GIC_MAX_INTRS);
 };
 
-struct gic_irq_spec {
-	enum {
-		GIC_DEVICE,
-		GIC_IPI
-	} type;
-
-	union {
-		struct cpumask *ipimask;
-		unsigned int hwirq;
-	};
-};
-
 static unsigned long __gic_base_addr;
 
 static void __iomem *gic_base;
 static struct gic_pcpu_mask pcpu_masks[NR_CPUS];
 static DEFINE_SPINLOCK(gic_lock);
 static struct irq_domain *gic_irq_domain;
-static struct irq_domain *gic_dev_domain;
 static struct irq_domain *gic_ipi_domain;
 static int gic_shared_intrs;
 static int gic_vpes;
@@ -694,132 +681,7 @@ static int gic_shared_irq_domain_map(struct irq_domain *d, unsigned int virq,
 	return 0;
 }
 
-static int gic_setup_dev_chip(struct irq_domain *d, unsigned int virq,
-			      unsigned int hwirq)
-{
-	struct irq_chip *chip;
-	int err;
-
-	if (hwirq >= GIC_SHARED_HWIRQ_BASE) {
-		err = irq_domain_set_hwirq_and_chip(d, virq, hwirq,
-						    &gic_level_irq_controller,
-						    NULL);
-	} else {
-		switch (GIC_HWIRQ_TO_LOCAL(hwirq)) {
-		case GIC_LOCAL_INT_TIMER:
-		case GIC_LOCAL_INT_PERFCTR:
-		case GIC_LOCAL_INT_FDC:
-			/*
-			 * HACK: These are all really percpu interrupts, but
-			 * the rest of the MIPS kernel code does not use the
-			 * percpu IRQ API for them.
-			 */
-			chip = &gic_all_vpes_local_irq_controller;
-			irq_set_handler(virq, handle_percpu_irq);
-			break;
-
-		default:
-			chip = &gic_local_irq_controller;
-			irq_set_handler(virq, handle_percpu_devid_irq);
-			irq_set_percpu_devid(virq);
-			break;
-		}
-
-		err = irq_domain_set_hwirq_and_chip(d, virq, hwirq,
-						    chip, NULL);
-	}
-
-	return err;
-}
-
-static int gic_irq_domain_alloc(struct irq_domain *d, unsigned int virq,
-				unsigned int nr_irqs, void *arg)
-{
-	struct gic_irq_spec *spec = arg;
-	irq_hw_number_t hwirq, base_hwirq;
-	int cpu, ret, i;
-
-	if (spec->type == GIC_DEVICE) {
-		/* verify that shared irqs don't conflict with an IPI irq */
-		if ((spec->hwirq >= GIC_SHARED_HWIRQ_BASE) &&
-		    test_bit(GIC_HWIRQ_TO_SHARED(spec->hwirq), ipi_resrv))
-			return -EBUSY;
-
-		return gic_setup_dev_chip(d, virq, spec->hwirq);
-	} else {
-		base_hwirq = find_first_bit(ipi_available, gic_shared_intrs);
-		if (base_hwirq == gic_shared_intrs) {
-			return -ENOMEM;
-		}
-
-		/* check that we have enough space */
-		for (i = base_hwirq; i < nr_irqs; i++) {
-			if (!test_bit(i, ipi_available))
-				return -EBUSY;
-		}
-		bitmap_clear(ipi_available, base_hwirq, nr_irqs);
-
-		/* map the hwirq for each cpu consecutively */
-		i = 0;
-		for_each_cpu(cpu, spec->ipimask) {
-			hwirq = GIC_SHARED_TO_HWIRQ(base_hwirq + i);
-
-			ret = irq_domain_set_hwirq_and_chip(d, virq + i, hwirq,
-							    &gic_level_irq_controller,
-							    NULL);
-			if (ret)
-				goto error;
-
-			irq_set_handler(virq + i, handle_level_irq);
-
-			ret = gic_shared_irq_domain_map(d, virq + i, hwirq, cpu);
-			if (ret)
-				goto error;
-
-			i++;
-		}
-
-		/*
-		 * tell the parent about the base hwirq we allocated so it can
-		 * set its own domain data
-		 */
-		spec->hwirq = base_hwirq;
-	}
-
-	return 0;
-error:
-	bitmap_set(ipi_available, base_hwirq, nr_irqs);
-	return ret;
-}
-
-void gic_irq_domain_free(struct irq_domain *d, unsigned int virq,
-			 unsigned int nr_irqs)
-{
-	irq_hw_number_t base_hwirq;
-	struct irq_data *data;
-
-	data = irq_get_irq_data(virq);
-	if (!data)
-		return;
-
-	base_hwirq = GIC_HWIRQ_TO_SHARED(irqd_to_hwirq(data));
-	bitmap_set(ipi_available, base_hwirq, nr_irqs);
-}
-
-int gic_irq_domain_match(struct irq_domain *d, struct device_node *node,
-			 enum irq_domain_bus_token bus_token)
-{
-	/* this domain should'nt be accessed directly */
-	return 0;
-}
-
-static const struct irq_domain_ops gic_irq_domain_ops = {
-	.alloc = gic_irq_domain_alloc,
-	.free = gic_irq_domain_free,
-	.match = gic_irq_domain_match,
-};
-
-static int gic_dev_domain_xlate(struct irq_domain *d, struct device_node *ctrlr,
+static int gic_irq_domain_xlate(struct irq_domain *d, struct device_node *ctrlr,
 				const u32 *intspec, unsigned int intsize,
 				irq_hw_number_t *out_hwirq,
 				unsigned int *out_type)
@@ -838,58 +700,73 @@ static int gic_dev_domain_xlate(struct irq_domain *d, struct device_node *ctrlr,
 	return 0;
 }
 
-static int gic_dev_domain_alloc(struct irq_domain *d, unsigned int virq,
+static int gic_irq_domain_alloc(struct irq_domain *d, unsigned int virq,
 				unsigned int nr_irqs, void *arg)
 {
 	struct irq_fwspec *fwspec = arg;
-	struct gic_irq_spec spec = {
-		.type = GIC_DEVICE,
-	};
-	int i, ret;
+	irq_hw_number_t hwirq;
+	int err;
 
-	if (fwspec->param[0] == GIC_SHARED)
-		spec.hwirq = GIC_SHARED_TO_HWIRQ(fwspec->param[1]);
-	else
-		spec.hwirq = GIC_LOCAL_TO_HWIRQ(fwspec->param[1]);
+	if (fwspec->param[0] == GIC_SHARED) {
+		hwirq = GIC_SHARED_TO_HWIRQ(fwspec->param[1]);
 
-	ret = irq_domain_alloc_irqs_parent(d, virq, nr_irqs, &spec);
-	if (ret)
-		return ret;
+		/* verify that shared irqs don't conflict with an IPI irq */
+		if (test_bit(GIC_HWIRQ_TO_SHARED(hwirq), ipi_resrv))
+			return -EBUSY;
 
-	for (i = 0; i < nr_irqs; i++) {
-		ret = gic_setup_dev_chip(d, virq + i, spec.hwirq + i);
-		if (ret)
-			goto error;
+		err = irq_domain_set_hwirq_and_chip(d, virq, hwirq,
+						    &gic_level_irq_controller,
+						    NULL);
+		if (err)
+			return err;
+
+		return gic_shared_irq_domain_map(d, virq, hwirq, 0);
 	}
 
-	return 0;
+	hwirq = GIC_LOCAL_TO_HWIRQ(fwspec->param[1]);
 
-error:
-	irq_domain_free_irqs_parent(d, virq, nr_irqs);
-	return ret;
-}
+	switch (GIC_HWIRQ_TO_LOCAL(hwirq)) {
+	case GIC_LOCAL_INT_TIMER:
+	case GIC_LOCAL_INT_PERFCTR:
+	case GIC_LOCAL_INT_FDC:
+		/*
+		 * HACK: These are all really percpu interrupts, but
+		 * the rest of the MIPS kernel code does not use the
+		 * percpu IRQ API for them.
+		 */
+		err = irq_domain_set_hwirq_and_chip(d, virq, hwirq,
+						    &gic_all_vpes_local_irq_controller,
+						    NULL);
+		if (err)
+			return err;
 
-void gic_dev_domain_free(struct irq_domain *d, unsigned int virq,
-			 unsigned int nr_irqs)
-{
-	/* no real allocation is done for dev irqs, so no need to free anything */
-	return;
+		irq_set_handler(virq, handle_percpu_irq);
+		break;
+
+	default:
+		err = irq_domain_set_hwirq_and_chip(d, virq, hwirq,
+						    &gic_local_irq_controller,
+						    NULL);
+		if (err)
+			return err;
+
+		irq_set_handler(virq, handle_percpu_devid_irq);
+		irq_set_percpu_devid(virq);
+		break;
+	}
+
+	return gic_local_irq_domain_map(d, virq, hwirq);
 }
 
-static void gic_dev_domain_activate(struct irq_domain *domain,
-				    struct irq_data *d)
+void gic_irq_domain_free(struct irq_domain *d, unsigned int virq,
+			 unsigned int nr_irqs)
 {
-	if (GIC_HWIRQ_TO_LOCAL(d->hwirq) < GIC_NUM_LOCAL_INTRS)
-		gic_local_irq_domain_map(domain, d->irq, d->hwirq);
-	else
-		gic_shared_irq_domain_map(domain, d->irq, d->hwirq, 0);
 }
 
-static struct irq_domain_ops gic_dev_domain_ops = {
-	.xlate = gic_dev_domain_xlate,
-	.alloc = gic_dev_domain_alloc,
-	.free = gic_dev_domain_free,
-	.activate = gic_dev_domain_activate,
+static const struct irq_domain_ops gic_irq_domain_ops = {
+	.xlate = gic_irq_domain_xlate,
+	.alloc = gic_irq_domain_alloc,
+	.free = gic_irq_domain_free,
 };
 
 static int gic_ipi_domain_xlate(struct irq_domain *d, struct device_node *ctrlr,
@@ -911,20 +788,32 @@ static int gic_ipi_domain_alloc(struct irq_domain *d, unsigned int virq,
 				unsigned int nr_irqs, void *arg)
 {
 	struct cpumask *ipimask = arg;
-	struct gic_irq_spec spec = {
-		.type = GIC_IPI,
-		.ipimask = ipimask
-	};
-	int ret, i;
+	irq_hw_number_t hwirq, base_hwirq;
+	int cpu, ret, i;
+
+	base_hwirq = find_first_bit(ipi_available, gic_shared_intrs);
+	if (base_hwirq == gic_shared_intrs)
+		return -ENOMEM;
 
-	ret = irq_domain_alloc_irqs_parent(d, virq, nr_irqs, &spec);
-	if (ret)
-		return ret;
+	/* check that we have enough space */
+	for (i = base_hwirq; i < nr_irqs; i++) {
+		if (!test_bit(i, ipi_available))
+			return -EBUSY;
+	}
+	bitmap_clear(ipi_available, base_hwirq, nr_irqs);
+
+	/* map the hwirq for each cpu consecutively */
+	i = 0;
+	for_each_cpu(cpu, ipimask) {
+		hwirq = GIC_SHARED_TO_HWIRQ(base_hwirq + i);
+
+		ret = irq_domain_set_hwirq_and_chip(d, virq + i, hwirq,
+						    &gic_edge_irq_controller,
+						    NULL);
+		if (ret)
+			goto error;
 
-	/* the parent should have set spec.hwirq to the base_hwirq it allocated */
-	for (i = 0; i < nr_irqs; i++) {
-		ret = irq_domain_set_hwirq_and_chip(d, virq + i,
-						    GIC_SHARED_TO_HWIRQ(spec.hwirq + i),
+		ret = irq_domain_set_hwirq_and_chip(d->parent, virq + i, hwirq,
 						    &gic_edge_irq_controller,
 						    NULL);
 		if (ret)
@@ -933,18 +822,32 @@ static int gic_ipi_domain_alloc(struct irq_domain *d, unsigned int virq,
 		ret = irq_set_irq_type(virq + i, IRQ_TYPE_EDGE_RISING);
 		if (ret)
 			goto error;
+
+		ret = gic_shared_irq_domain_map(d, virq + i, hwirq, cpu);
+		if (ret)
+			goto error;
+
+		i++;
 	}
 
 	return 0;
 error:
-	irq_domain_free_irqs_parent(d, virq, nr_irqs);
+	bitmap_set(ipi_available, base_hwirq, nr_irqs);
 	return ret;
 }
 
 void gic_ipi_domain_free(struct irq_domain *d, unsigned int virq,
 			 unsigned int nr_irqs)
 {
-	irq_domain_free_irqs_parent(d, virq, nr_irqs);
+	irq_hw_number_t base_hwirq;
+	struct irq_data *data;
+
+	data = irq_get_irq_data(virq);
+	if (!data)
+		return;
+
+	base_hwirq = GIC_HWIRQ_TO_SHARED(irqd_to_hwirq(data));
+	bitmap_set(ipi_available, base_hwirq, nr_irqs);
 }
 
 int gic_ipi_domain_match(struct irq_domain *d, struct device_node *node,
@@ -1072,13 +975,6 @@ static void __init __gic_init(unsigned long gic_base_addr,
 		panic("Failed to add GIC IRQ domain");
 	gic_irq_domain->name = "mips-gic-irq";
 
-	gic_dev_domain = irq_domain_add_hierarchy(gic_irq_domain, 0,
-						  GIC_NUM_LOCAL_INTRS + gic_shared_intrs,
-						  node, &gic_dev_domain_ops, NULL);
-	if (!gic_dev_domain)
-		panic("Failed to add GIC DEV domain");
-	gic_dev_domain->name = "mips-gic-dev";
-
 	gic_ipi_domain = irq_domain_add_hierarchy(gic_irq_domain,
 						  IRQ_DOMAIN_FLAG_IPI_PER_CPU,
 						  GIC_NUM_LOCAL_INTRS + gic_shared_intrs,
-- 
2.7.4
