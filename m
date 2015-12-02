Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Dec 2015 13:25:21 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:28109 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012003AbbLBMW23-eOA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Dec 2015 13:22:28 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id DEBECC2B523DB;
        Wed,  2 Dec 2015 12:22:19 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Wed, 2 Dec 2015 12:22:22 +0000
Received: from qyousef-linux.le.imgtec.org (192.168.154.94) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 2 Dec 2015 12:22:21 +0000
From:   Qais Yousef <qais.yousef@imgtec.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>, <jiang.liu@linux.intel.com>,
        <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        Qais Yousef <qais.yousef@imgtec.com>
Subject: [PATCH v3 08/19] genirq: Add a new generic IPI reservation code to irq core
Date:   Wed, 2 Dec 2015 12:21:49 +0000
Message-ID: <1449058920-21011-9-git-send-email-qais.yousef@imgtec.com>
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
X-archive-position: 50279
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
 include/linux/irqdomain.h |   6 +++
 kernel/irq/ipi.c          | 126 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 132 insertions(+)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index fcafae8e3aaf..4277b2918052 100644
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
+			     const struct cpumask *dest);
+void irq_destroy_ipi(unsigned int irq);
+
 /* V2 interfaces to support hierarchy IRQ domains. */
 extern struct irq_data *irq_domain_get_irq_data(struct irq_domain *domain,
 						unsigned int virq);
diff --git a/kernel/irq/ipi.c b/kernel/irq/ipi.c
index 8cf76852982f..250c1a96ca2d 100644
--- a/kernel/irq/ipi.c
+++ b/kernel/irq/ipi.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/irq.h>
+#include <linux/irqdomain.h>
 #include <linux/slab.h>
 
 /**
@@ -107,3 +108,128 @@ irq_hw_number_t irq_ipi_mapping_get_hwirq(struct ipi_mapping *map,
 
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
+			     const struct cpumask *dest)
+{
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
+	if (!cpumask_subset(dest, cpu_possible_mask)) {
+		pr_warn("Can't reserve an IPI outside cpu_possible_mask range\n");
+		return 0;
+	}
+
+	nr_irqs = cpumask_weight(dest);
+	if (!nr_irqs) {
+		pr_warn("Can't reserve an IPI for an empty mask\n");
+		return 0;
+	}
+
+	if (irq_domain_is_ipi_single(domain))
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
+	for_each_cpu(cpu, dest) {
+		if (prev_cpu == -1) {
+			/* while at it save the offset */
+			offset = cpu;
+			prev_cpu = cpu;
+			continue;
+		}
+
+		if (prev_cpu - cpu > 1) {
+			pr_err("Can't allocate IPIs using non consecutive mask\n");
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
+	for (i = 0; i < nr_irqs; i++) {
+		data = irq_get_irq_data(virq + i);
+		cpumask_copy(data->common->affinity, dest);
+		data->common->ipi_offset = offset;
+	}
+
+	return virq;
+
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
+	struct cpumask *ipimask = data ? irq_data_get_affinity_mask(data) : NULL;
+	struct irq_domain *domain;
+	unsigned int nr_irqs;
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
+		nr_irqs = cpumask_weight(ipimask);
+	else
+		nr_irqs = 1;
+
+	irq_domain_free_irqs(irq, nr_irqs);
+}
-- 
2.1.0
