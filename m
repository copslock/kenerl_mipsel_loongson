Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Nov 2015 12:15:50 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:1967 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012417AbbKCLNnsEWF1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Nov 2015 12:13:43 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 12B7534390EE;
        Tue,  3 Nov 2015 11:13:36 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Tue, 3 Nov 2015 11:13:37 +0000
Received: from qyousef-linux.le.imgtec.org (192.168.154.94) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Tue, 3 Nov 2015 11:13:36 +0000
From:   Qais Yousef <qais.yousef@imgtec.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>, <jiang.liu@linux.intel.com>,
        <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        Qais Yousef <qais.yousef@imgtec.com>
Subject: [PATCH 07/14] genirq: Add a new generic IPI reservation code to irq core
Date:   Tue, 3 Nov 2015 11:12:54 +0000
Message-ID: <1446549181-31788-8-git-send-email-qais.yousef@imgtec.com>
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
X-archive-position: 49811
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

Add a generic mechanism to dynamically allocate an IPI.

With this change the user can call irq_reserve_ipi() to dynamically allocate an
IPI and use the associated virq to send one to 1 or more cpus.

Signed-off-by: Qais Yousef <qais.yousef@imgtec.com>
---
 include/linux/irqdomain.h |  6 +++
 kernel/irq/irqdomain.c    | 98 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 104 insertions(+)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 422b6a1617b8..9ba67bfe8ad2 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -39,6 +39,7 @@ struct irq_domain;
 struct of_device_id;
 struct irq_chip;
 struct irq_data;
+struct ipi_mask;
 
 /* Number of irqs reserved for a legacy isa controller */
 #define NUM_ISA_INTERRUPTS	16
@@ -333,6 +334,11 @@ int irq_domain_xlate_onetwocell(struct irq_domain *d, struct device_node *ctrlr,
 			const u32 *intspec, unsigned int intsize,
 			irq_hw_number_t *out_hwirq, unsigned int *out_type);
 
+/* IPI functions */
+unsigned int irq_reserve_ipi(struct irq_domain *domain,
+			     const struct ipi_mask *dest);
+void irq_destroy_ipi(unsigned int irq);
+
 /* V2 interfaces to support hierarchy IRQ domains. */
 extern struct irq_data *irq_domain_get_irq_data(struct irq_domain *domain,
 						unsigned int virq);
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 22aa9612ef7c..dd240914301d 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -852,6 +852,104 @@ static int irq_domain_alloc_descs(int virq, unsigned int cnt,
 	return virq;
 }
 
+/**
+ * irq_reserve_ipi() - setup an IPI to destination cpumask
+ * @domain: IPI domain
+ * @dest: cpumask of cpus to receive the IPI
+ *
+ * Allocate a virq that can be used to send IPI to any CPU in dest mask.
+ *
+ * On success it'll return linux irq number and 0 on failure
+ */
+unsigned int irq_reserve_ipi(struct irq_domain *domain,
+			     const struct ipi_mask *dest)
+{
+	struct irq_data *data;
+	unsigned int nr_irqs;
+	int virq, i;
+
+	if (domain == NULL) {
+		pr_warn("Must provide a valid IPI domain!\n");
+		return 0;
+	}
+
+	if (!irq_domain_is_ipi(domain)) {
+		pr_warn("Not an IPI domain!\n");
+		return 0;
+	}
+
+	/* always allocate a virq per cpu */
+	nr_irqs = ipi_mask_weight(dest);
+
+	virq = irq_domain_alloc_descs(-1, nr_irqs, 0, NUMA_NO_NODE);
+	if (virq <= 0) {
+		pr_warn("Can't reserve IPI, failed to alloc descs\n");
+		return 0;
+	}
+
+	virq = __irq_domain_alloc_irqs(domain, virq, nr_irqs, NUMA_NO_NODE,
+					(void *) dest, true);
+	if (virq <= 0) {
+		pr_warn("Can't reserve IPI, failed to alloc irqs\n");
+		goto free_descs;
+	}
+
+	for (i = virq; i < virq + nr_irqs; i++) {
+		data = irq_get_irq_data(i);
+		data->common->ipi_mask = ipi_mask_alloc(dest->nbits);
+		if (!data->common->ipi_mask)
+			goto free_ipi_mask;
+		ipi_mask_copy(data->common->ipi_mask, dest);
+	}
+
+	return virq;
+
+free_ipi_mask:
+	for (i = virq; i < virq + nr_irqs; i++) {
+		data = irq_get_irq_data(i);
+		ipi_mask_free(data->common->ipi_mask);
+	}
+free_descs:
+	irq_free_descs(virq, nr_irqs);
+	return 0;
+}
+
+/**
+ * irq_destroy_ipi() - unreserve an IPI that was previously allocated
+ * @irq: linux irq number to be destroyed
+ *
+ * Return the IPIs allocated with irq_reserve_ipi() to the system destroying all
+ * virqs associated with them.
+ */
+void irq_destroy_ipi(unsigned int irq)
+{
+	struct irq_data *data = irq_get_irq_data(irq);
+	struct irq_domain *domain;
+	unsigned int nr_irqs, i;
+
+	if (!irq || !data)
+		return;
+
+	domain = data->domain;
+	if (WARN_ON(domain == NULL))
+		return;
+
+	if (!irq_domain_is_ipi(domain)) {
+		pr_warn("Not an IPI domain!\n");
+		return;
+	}
+
+	nr_irqs = ipi_mask_weight(data->common->ipi_mask);
+	ipi_mask_free(data->common->ipi_mask);
+
+	for (i = irq + 1; i < irq + nr_irqs; i++) {
+		data = irq_get_irq_data(i);
+		ipi_mask_free(data->common->ipi_mask);
+	}
+
+	irq_domain_free_irqs(irq, nr_irqs);
+}
+
 #ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
 /**
  * irq_domain_create_hierarchy - Add a irqdomain into the hierarchy
-- 
2.1.0
