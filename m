Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Sep 2015 16:51:21 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:31768 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008675AbbIWOuE2krkn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Sep 2015 16:50:04 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 3A26963CFABE6;
        Wed, 23 Sep 2015 15:49:55 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 23 Sep 2015 15:49:58 +0100
Received: from qyousef-linux.le.imgtec.org (192.168.154.94) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 23 Sep 2015 15:49:57 +0100
From:   Qais Yousef <qais.yousef@imgtec.com>
To:     <linux-kernel@vger.kernel.org>, <tglx@linutronix.de>
CC:     <marc.zyngier@arm.com>, <jason@lakedaemon.net>,
        <jiang.liu@linux.intel.com>, <linux-mips@linux-mips.org>,
        Qais Yousef <qais.yousef@imgtec.com>
Subject: [PATCH 5/6] irqchip: mips-gic: add a IPI hierarchy domain
Date:   Wed, 23 Sep 2015 15:49:17 +0100
Message-ID: <1443019758-20620-6-git-send-email-qais.yousef@imgtec.com>
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
X-archive-position: 49343
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

The only reason this domain needs to be hierarchal is because we need to use
the alloc function to allocate the IPI.

Should we make the gic IPI a completely different irqchip?

Signed-off-by: Qais Yousef <qais.yousef@imgtec.com>
---
 drivers/irqchip/Kconfig        |   1 +
 drivers/irqchip/irq-mips-gic.c | 101 +++++++++++++++++++++++++++++++++++++++--
 2 files changed, 97 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 27b52c8729cd..e07593f4860d 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -167,6 +167,7 @@ config KEYSTONE_IRQ
 
 config MIPS_GIC
 	bool
+	select IRQ_DOMAIN_HIERARCHY
 	select MIPS_CM
 
 config INGENIC_IRQ
diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index af2f16bb8a94..14e99ea0f963 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -33,6 +33,7 @@ static void __iomem *gic_base;
 static struct gic_pcpu_mask pcpu_masks[NR_CPUS];
 static DEFINE_SPINLOCK(gic_lock);
 static struct irq_domain *gic_irq_domain;
+static struct irq_domain *gic_ipi_domain;
 static int gic_shared_intrs;
 static int gic_vpes;
 static unsigned int gic_cpu_pin;
@@ -733,7 +734,7 @@ static int gic_local_irq_domain_map(struct irq_domain *d, unsigned int virq,
 }
 
 static int gic_shared_irq_domain_map(struct irq_domain *d, unsigned int virq,
-				     irq_hw_number_t hw)
+				     irq_hw_number_t hw, unsigned int vpe)
 {
 	int intr = GIC_HWIRQ_TO_SHARED(hw);
 	unsigned long flags;
@@ -743,9 +744,8 @@ static int gic_shared_irq_domain_map(struct irq_domain *d, unsigned int virq,
 
 	spin_lock_irqsave(&gic_lock, flags);
 	gic_map_to_pin(intr, gic_cpu_pin);
-	/* Map to VPE 0 by default */
-	gic_map_to_vpe(intr, 0);
-	set_bit(intr, pcpu_masks[0].pcpu_mask);
+	gic_map_to_vpe(intr, vpe);
+	set_bit(intr, pcpu_masks[vpe].pcpu_mask);
 	spin_unlock_irqrestore(&gic_lock, flags);
 
 	return 0;
@@ -756,7 +756,7 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int virq,
 {
 	if (GIC_HWIRQ_TO_LOCAL(hw) < GIC_NUM_LOCAL_INTRS)
 		return gic_local_irq_domain_map(d, virq, hw);
-	return gic_shared_irq_domain_map(d, virq, hw);
+	return gic_shared_irq_domain_map(d, virq, hw, 0);
 }
 
 static int gic_irq_domain_xlate(struct irq_domain *d, struct device_node *ctrlr,
@@ -783,6 +783,91 @@ static const struct irq_domain_ops gic_irq_domain_ops = {
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
+	int vpe, ret;
+	struct ipi_virq *v = arg;
+	struct ipi_hwirq *h;
+	irq_hw_number_t hwirq;
+
+	for_each_cpu(vpe, &v->cpumask) {
+		/* we need a GIC shared hwirq for each vpe */
+		h = irq_domain_get_ipi_hwirq(d);
+		if (!h) {
+			ret = -EINVAL;
+			goto error;
+		}
+		cpumask_set_cpu(vpe, &h->cpumask);
+
+		/* add this hwirq to the virq mapping list */
+		ret = irq_domain_ipi_virq_add_hwirq(v, h);
+		if (ret)
+			goto error;
+
+		hwirq = GIC_SHARED_TO_HWIRQ(h->hwirq);
+		ret = irq_domain_set_hwirq_and_chip(d, virq + vpe, hwirq,
+						NULL, NULL);
+		if (ret)
+			goto error;
+
+		ret = gic_shared_irq_domain_map(d, virq + vpe, hwirq, vpe);
+		if (ret)
+			goto error;
+	}
+
+	return 0;
+error:
+	while ((h = irq_domain_ipi_virq_rm_hwirq(v))) {
+		for_each_cpu(vpe, &h->cpumask)
+			clear_bit(h->hwirq, pcpu_masks[vpe].pcpu_mask);
+		irq_domain_put_ipi_hwirq(d, h);
+	}
+
+	return ret;
+}
+
+void gic_ipi_domain_free(struct irq_domain *d, unsigned int virq,
+			 unsigned int nr_irqs)
+{
+	struct ipi_hwirq *h;
+	struct ipi_virq *v;
+	int vpe;
+
+	v = irq_domain_find_ipi_virq(d, virq);
+	if (!v)
+		return;
+
+	/* return all allocated hwirqs to the IPI domain */
+	while ((h = irq_domain_ipi_virq_rm_hwirq(v))) {
+		for_each_cpu(vpe, &h->cpumask)
+			clear_bit(h->hwirq, pcpu_masks[vpe].pcpu_mask);
+		irq_domain_put_ipi_hwirq(d, h);
+	}
+}
+
+static struct irq_domain_ops gic_ipi_domain_ops = {
+	.xlate = gic_ipi_domain_xlate,
+	.alloc = gic_ipi_domain_alloc,
+	.free = gic_ipi_domain_free,
+	.send_ipi = gic_send_ipi,
+};
+
 static void __init __gic_init(unsigned long gic_base_addr,
 			      unsigned long gic_addrspace_size,
 			      unsigned int cpu_vec, unsigned int irqbase,
@@ -842,6 +927,12 @@ static void __init __gic_init(unsigned long gic_base_addr,
 	if (!gic_irq_domain)
 		panic("Failed to add GIC IRQ domain");
 
+	gic_ipi_domain = irq_domain_add_hierarchy(gic_irq_domain, IRQ_DOMAIN_FLAG_IPI,
+						  GIC_NUM_LOCAL_INTRS + gic_shared_intrs,
+						  NULL, &gic_ipi_domain_ops, NULL);
+	if (!gic_ipi_domain)
+		panic("Failed to add GIC IPI domain");
+
 	gic_basic_init();
 
 	gic_ipi_init();
-- 
2.1.0
