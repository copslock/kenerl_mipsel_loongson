Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Dec 2015 13:26:36 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:59471 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011789AbbLBMWfcUTpA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Dec 2015 13:22:35 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id 2B029B9270520;
        Wed,  2 Dec 2015 12:22:27 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Wed, 2 Dec 2015 12:22:29 +0000
Received: from qyousef-linux.le.imgtec.org (192.168.154.94) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 2 Dec 2015 12:22:28 +0000
From:   Qais Yousef <qais.yousef@imgtec.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>, <jiang.liu@linux.intel.com>,
        <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        Qais Yousef <qais.yousef@imgtec.com>
Subject: [PATCH v3 13/19] irqchip/mips-gic: Add device hierarchy domain
Date:   Wed, 2 Dec 2015 12:21:54 +0000
Message-ID: <1449058920-21011-14-git-send-email-qais.yousef@imgtec.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1449058920-21011-1-git-send-email-qais.yousef@imgtec.com>
References: <1449058920-21011-1-git-send-email-qais.yousef@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.94]
Return-Path: <Qais.Yousef@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50283
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

Now the root gic_irq_domain is split into device and IPI domains.

This form provides a better representation of how the root domain is split into
2. One for devices and one for IPIs.

Signed-off-by: Qais Yousef <qais.yousef@imgtec.com>
---
 drivers/irqchip/irq-mips-gic.c | 103 +++++++++++++++++++++++++++++++++--------
 1 file changed, 83 insertions(+), 20 deletions(-)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index a4e5b17f56f1..41ccc84c68ba 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -45,6 +45,7 @@ static void __iomem *gic_base;
 static struct gic_pcpu_mask pcpu_masks[NR_CPUS];
 static DEFINE_SPINLOCK(gic_lock);
 static struct irq_domain *gic_irq_domain;
+static struct irq_domain *gic_dev_domain;
 static struct irq_domain *gic_ipi_domain;
 static int gic_shared_intrs;
 static int gic_vpes;
@@ -780,25 +781,6 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int virq,
 	return gic_shared_irq_domain_map(d, virq, hw, 0);
 }
 
-static int gic_irq_domain_xlate(struct irq_domain *d, struct device_node *ctrlr,
-				const u32 *intspec, unsigned int intsize,
-				irq_hw_number_t *out_hwirq,
-				unsigned int *out_type)
-{
-	if (intsize != 3)
-		return -EINVAL;
-
-	if (intspec[0] == GIC_SHARED)
-		*out_hwirq = GIC_SHARED_TO_HWIRQ(intspec[1]);
-	else if (intspec[0] == GIC_LOCAL)
-		*out_hwirq = GIC_LOCAL_TO_HWIRQ(intspec[1]);
-	else
-		return -EINVAL;
-	*out_type = intspec[2] & IRQ_TYPE_SENSE_MASK;
-
-	return 0;
-}
-
 static int gic_irq_domain_alloc(struct irq_domain *d, unsigned int virq,
 				unsigned int nr_irqs, void *arg)
 {
@@ -868,11 +850,86 @@ void gic_irq_domain_free(struct irq_domain *d, unsigned int virq,
 	bitmap_set(ipi_resrv, base_hwirq, nr_irqs);
 }
 
+int gic_irq_domain_match(struct irq_domain *d, struct device_node *node,
+			 enum irq_domain_bus_token bus_token)
+{
+	/* this domain should'nt be accessed directly */
+	return 0;
+}
+
 static const struct irq_domain_ops gic_irq_domain_ops = {
 	.map = gic_irq_domain_map,
-	.xlate = gic_irq_domain_xlate,
 	.alloc = gic_irq_domain_alloc,
 	.free = gic_irq_domain_free,
+	.match = gic_irq_domain_match,
+};
+
+static int gic_dev_domain_xlate(struct irq_domain *d, struct device_node *ctrlr,
+				const u32 *intspec, unsigned int intsize,
+				irq_hw_number_t *out_hwirq,
+				unsigned int *out_type)
+{
+	if (intsize != 3)
+		return -EINVAL;
+
+	if (intspec[0] == GIC_SHARED)
+		*out_hwirq = GIC_SHARED_TO_HWIRQ(intspec[1]);
+	else if (intspec[0] == GIC_LOCAL)
+		*out_hwirq = GIC_LOCAL_TO_HWIRQ(intspec[1]);
+	else
+		return -EINVAL;
+	*out_type = intspec[2] & IRQ_TYPE_SENSE_MASK;
+
+	return 0;
+}
+
+static int gic_dev_domain_alloc(struct irq_domain *d, unsigned int virq,
+				unsigned int nr_irqs, void *arg)
+{
+	struct irq_fwspec *fwspec = arg;
+	struct gic_irq_spec spec = {
+		.type = GIC_DEVICE,
+		.hwirq = fwspec->param[1],
+	};
+	int i, ret;
+	bool is_shared = fwspec->param[0] == GIC_SHARED;
+
+	if (is_shared) {
+		ret = irq_domain_alloc_irqs_parent(d, virq, nr_irqs, &spec);
+		if (ret)
+			return ret;
+	}
+
+	for (i = 0; i < nr_irqs; i++) {
+		irq_hw_number_t hwirq;
+
+		if (is_shared)
+			hwirq = GIC_SHARED_TO_HWIRQ(spec.hwirq + i);
+		else
+			hwirq = GIC_LOCAL_TO_HWIRQ(spec.hwirq + i);
+
+		ret = irq_domain_set_hwirq_and_chip(d, virq + i,
+						    hwirq,
+						    &gic_level_irq_controller,
+						    NULL);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+void gic_dev_domain_free(struct irq_domain *d, unsigned int virq,
+			 unsigned int nr_irqs)
+{
+	/* no real allocation is done for dev irqs, so no need to free anything */
+	return;
+}
+
+static struct irq_domain_ops gic_dev_domain_ops = {
+	.xlate = gic_dev_domain_xlate,
+	.alloc = gic_dev_domain_alloc,
+	.free = gic_dev_domain_free,
 };
 
 static int gic_ipi_domain_xlate(struct irq_domain *d, struct device_node *ctrlr,
@@ -1011,6 +1068,12 @@ static void __init __gic_init(unsigned long gic_base_addr,
 	if (!gic_irq_domain)
 		panic("Failed to add GIC IRQ domain");
 
+	gic_dev_domain = irq_domain_add_hierarchy(gic_irq_domain, 0,
+						  GIC_NUM_LOCAL_INTRS + gic_shared_intrs,
+						  node, &gic_dev_domain_ops, NULL);
+	if (!gic_dev_domain)
+		panic("Failed to add GIC DEV domain");
+
 	gic_ipi_domain = irq_domain_add_hierarchy(gic_irq_domain,
 						  IRQ_DOMAIN_FLAG_IPI_PER_CPU,
 						  GIC_NUM_LOCAL_INTRS + gic_shared_intrs,
-- 
2.1.0
