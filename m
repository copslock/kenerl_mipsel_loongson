Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Nov 2015 13:09:58 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:4453 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012743AbbKYMIE6xXdf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Nov 2015 13:08:04 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 274FD189A3012;
        Wed, 25 Nov 2015 12:07:57 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Wed, 25 Nov 2015 12:07:58 +0000
Received: from qyousef-linux.le.imgtec.org (192.168.154.94) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 25 Nov 2015 12:07:58 +0000
From:   Qais Yousef <qais.yousef@imgtec.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>, <jiang.liu@linux.intel.com>,
        <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        Qais Yousef <qais.yousef@imgtec.com>
Subject: [PATCH v2 08/19] genirq: Add a new generic IPI reservation code to irq core
Date:   Wed, 25 Nov 2015 12:06:46 +0000
Message-ID: <1448453217-3874-9-git-send-email-qais.yousef@imgtec.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1448453217-3874-1-git-send-email-qais.yousef@imgtec.com>
References: <1448453217-3874-1-git-send-email-qais.yousef@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.94]
Return-Path: <Qais.Yousef@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50093
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
 include/linux/irqdomain.h |   6 ++
 kernel/irq/ipi.c          | 143 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 149 insertions(+)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index fcafae8e3aaf..d2eb6c266522 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -39,6 +39,7 @@ struct irq_domain;
 struct of_device_id;
 struct irq_chip;
 struct irq_data;
+struct ipi_mask;
 
 /* Number of irqs reserved for a legacy isa controller */
 #define NUM_ISA_INTERRUPTS	16
@@ -338,6 +339,11 @@ int irq_domain_xlate_onetwocell(struct irq_domain *d, struct device_node *ctrlr,
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
diff --git a/kernel/irq/ipi.c b/kernel/irq/ipi.c
index d07325498707..f2dc8c73965c 100644
--- a/kernel/irq/ipi.c
+++ b/kernel/irq/ipi.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/irq.h>
+#include <linux/irqdomain.h>
 
 /**
  * irq_alloc_ipi_mapping - allocate memory for struct ipi_mapping
@@ -104,3 +105,145 @@ irq_hw_number_t irq_ipi_mapping_get_hwirq(struct ipi_mapping *map,
 
 	return map->cpumap[cpu];
 }
+
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
+	struct ipi_mask *ipimask;
+	struct irq_data *data;
+	unsigned int nr_irqs, offset = 0;
+	int prev_cpu = -1, cpu;
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
+	if (irq_domain_is_ipi_per_cpu(domain))
+		nr_irqs = ipi_mask_weight(dest);
+	else
+		nr_irqs = 1;
+
+	/*
+	 * Disallow holes in the ipi_mask.
+	 * Holes makes it difficult to manage code in generic way. So we always
+	 * assume a consecutive ipi_mask. It's easy for the user to split
+	 * an ipi_mask with a hole into 2 consecutive ipi_masks and manage
+	 * which virq to use locally than adding generic support that would
+	 * complicate the generic code.
+	 */
+	ipi_mask_for_each_cpu(cpu, dest) {
+		if (prev_cpu == -1) {
+			/* while at it save the offset */
+			offset = cpu;
+			prev_cpu = cpu;
+			continue;
+		}
+
+		if (prev_cpu - cpu > 1) {
+			pr_err("Can't allocate IPIs using non consecutive ipi_mask\n");
+			return 0;
+		}
+
+		prev_cpu = cpu;
+	}
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
+	/* The generic code will only need the ipi_mask in the base virq.
+	 * We can save memory by storing it once only there.
+	 *
+	 * Do we need to keep the per virq ipi_mask for the irqchip? */
+	for (i = 0; i < nr_irqs; i++) {
+		data = irq_get_irq_data(virq + i);
+		ipimask = ipi_mask_alloc(dest->nbits);
+		if (!ipimask)
+			goto free_ipi_mask;
+		ipi_mask_copy(ipimask, dest);
+		ipi_mask_set_offset(ipimask, offset);
+		irq_data_set_ipi_mask(data, ipimask);
+	}
+
+	return virq;
+
+free_ipi_mask:
+	for (i = 0; i < nr_irqs; i++) {
+		data = irq_get_irq_data(virq + i);
+		ipimask = irq_data_get_ipi_mask(data);
+		ipi_mask_free(ipimask);
+		irq_data_set_ipi_mask(data, NULL);
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
+	struct ipi_mask *ipimask = data ? irq_data_get_ipi_mask(data) : NULL;
+	struct irq_domain *domain;
+	unsigned int nr_irqs, i;
+
+	if (!irq || !data || !ipimask)
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
+	if (irq_domain_is_ipi_per_cpu(domain))
+		nr_irqs = ipi_mask_weight(ipimask);
+	else
+		nr_irqs = 1;
+
+	ipi_mask_free(ipimask);
+	irq_data_set_ipi_mask(data, NULL);
+
+	for (i = 1; i < nr_irqs; i++) {
+		data = irq_get_irq_data(irq + i);
+		ipimask = irq_data_get_ipi_mask(data);
+		ipi_mask_free(ipimask);
+		irq_data_set_ipi_mask(data, NULL);
+	}
+
+	irq_domain_free_irqs(irq, nr_irqs);
+}
-- 
2.1.0
