Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Dec 2015 14:24:33 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:8736 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013378AbbLHNVmFInaZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Dec 2015 14:21:42 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id F20C86CC2D57C;
        Tue,  8 Dec 2015 13:18:29 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Tue, 8 Dec 2015 13:21:33 +0000
Received: from qyousef-linux.le.imgtec.org (192.168.154.94) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Tue, 8 Dec 2015 13:21:32 +0000
From:   Qais Yousef <qais.yousef@imgtec.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>, <jiang.liu@linux.intel.com>,
        <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        <lisa.parratt@imgtec.com>, Qais Yousef <qais.yousef@imgtec.com>
Subject: [PATCH v4 11/19] genirq: Implement ipi_send_{mask, single}()
Date:   Tue, 8 Dec 2015 13:20:22 +0000
Message-ID: <1449580830-23652-12-git-send-email-qais.yousef@imgtec.com>
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
X-archive-position: 50435
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

Add APIs to send IPIs from driver and arch code.

There is 2 version, the exported one which takes virq to be used by the drivers.
And the non exported version which takes irq_desc to be used by arch code.

The difference is in the error checking done. We do less checking with arch code
to reduce SMP IPIs overhead.

Signed-off-by: Qais Yousef <qais.yousef@imgtec.com>
---
 include/linux/irq.h |   5 ++
 kernel/irq/ipi.c    | 169 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 174 insertions(+)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index b0556c5787d7..f521f1ac36d4 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -988,4 +988,9 @@ irq_hw_number_t irq_ipi_mapping_get_hwirq(struct ipi_mapping *map,
 
 irq_hw_number_t ipi_get_hwirq(unsigned int irq, unsigned int cpu);
 
+int __ipi_send_single(struct irq_desc *desc, unsigned int cpu);
+int __ipi_send_mask(struct irq_desc *desc, const struct cpumask *dest);
+int ipi_send_single(unsigned int virq, unsigned int cpu);
+int ipi_send_mask(unsigned int virq, const struct cpumask *dest);
+
 #endif /* _LINUX_IRQ_H */
diff --git a/kernel/irq/ipi.c b/kernel/irq/ipi.c
index a389d7e6d593..7829bf89d759 100644
--- a/kernel/irq/ipi.c
+++ b/kernel/irq/ipi.c
@@ -270,3 +270,172 @@ irq_hw_number_t ipi_get_hwirq(unsigned int irq, unsigned int cpu)
 	return hwirq;
 }
 EXPORT_SYMBOL_GPL(ipi_get_hwirq);
+
+/**
+ * __ipi_send_single - send an IPI to a target Linux SMP CPU
+ * @desc: pointer to irq_desc of the IRQ
+ * @cpu: dest CPU, must be the same or a subset of the mask passed to
+ *        irq_reserve_ipi()
+ *
+ * Sends an IPI to a single smp cpu
+ * This function is meant to be used from arch code to send single SMP IPI.
+ *
+ * Returns zero on success and negative error number on failure.
+ */
+int __ipi_send_single(struct irq_desc *desc, unsigned int cpu)
+{
+	struct irq_data *data = irq_desc_get_irq_data(desc);
+	struct irq_chip *chip = irq_data_get_irq_chip(data);
+	const struct cpumask *dest = cpumask_of(cpu);
+
+#ifdef DEBUG
+	/*
+	 * Minimise the overhead by omitting the checks for Linux SMP IPIs.
+	 * Since the callers should be ARCH code which is generally trusted,
+	 * only check for errors when debugging.
+	 */
+	struct cpumask *ipimask = data ? irq_data_get_affinity_mask(data) : NULL;
+
+	if (!chip || !ipimask)
+		return -EINVAL;
+
+	if (!chip->ipi_send_single && !chip->ipi_send_mask)
+		return -EINVAL;
+
+	if (cpu > nr_cpu_ids)
+		return -EINVAL;
+
+	if (!cpumask_test_cpu(cpu, ipimask))
+		return -EINVAL;
+#endif
+
+
+	if (chip->ipi_send_single) {
+		/* use the correct data for that cpu */
+		data = irq_get_irq_data(data->irq + cpu - data->common->ipi_offset);
+		chip->ipi_send_single(data, cpu);
+	} else {
+		chip->ipi_send_mask(data, dest);
+	}
+	return 0;
+}
+
+/**
+ * ipi_send_mask - send an IPI to target Linux SMP CPU(s)
+ * @desc: pointer to irq_desc of the IRQ
+ * @dest: dest CPU(s), must be the same or a subset of the mask passed to
+ *        irq_reserve_ipi()
+ *
+ * Sends an IPI to all smp cpus in dest mask.
+ * This function is meant to be used from arch code to send SMP IPIs.
+ *
+ * Returns zero on success and negative error number on failure.
+ */
+int __ipi_send_mask(struct irq_desc *desc, const struct cpumask *dest)
+{
+	struct irq_data *data = irq_desc_get_irq_data(desc);
+	struct irq_chip *chip = irq_data_get_irq_chip(data);
+	unsigned int cpu;
+
+#ifdef DEBUG
+	/*
+	 * Minimise the overhead by omitting the checks for Linux SMP IPIs.
+	 * Since the callers should be ARCH code which is generally trusted,
+	 * only check for errors when debugging.
+	 */
+	struct cpumask *ipimask = data ? irq_data_get_affinity_mask(data) : NULL;
+
+	if (!chip || !ipimask)
+		return -EINVAL;
+
+	if (!chip->ipi_send_single && !chip->ipi_send_mask)
+		return -EINVAL;
+
+	if (!cpumask_subset(dest, ipimask))
+		return -EINVAL;
+#endif
+
+	if (chip->ipi_send_mask) {
+		chip->ipi_send_mask(data, dest);
+		return 0;
+	}
+
+	if (irq_domain_is_ipi_per_cpu(data->domain)) {
+		unsigned int base_virq = data->irq;
+		for_each_cpu(cpu, dest) {
+			data = irq_get_irq_data(base_virq + cpu - data->common->ipi_offset);
+			chip->ipi_send_single(data, cpu);
+		}
+	} else {
+		for_each_cpu(cpu, dest)
+			chip->ipi_send_single(data, cpu);
+	}
+
+	return 0;
+}
+
+/**
+ * ipi_send_single - send an IPI to a single CPU
+ * @virq: linux irq number from irq_reserve_ipi()
+ * @cpu: CPU ID. Must be a subset of the mask passed to irq_reserve_ipi()
+ *
+ * Sends an IPI to destination CPU
+ *
+ * Returns zero on success and negative error number on failure.
+ */
+int ipi_send_single(unsigned int virq, unsigned int cpu)
+{
+	struct irq_desc *desc = irq_to_desc(virq);
+	struct irq_data *data = desc ? irq_desc_get_irq_data(desc) : NULL;
+	struct irq_chip *chip = data ? irq_data_get_irq_chip(data) : NULL;
+	struct cpumask *ipimask = data ? irq_data_get_affinity_mask(data) : NULL;
+
+	if (!chip || !ipimask)
+		return -EINVAL;
+
+	if (!chip->ipi_send_single && !chip->ipi_send_mask)
+		return -EINVAL;
+
+	if (cpu > nr_cpu_ids)
+		return -EINVAL;
+
+	if (!cpumask_test_cpu(cpu, ipimask))
+		return -EINVAL;
+
+	__ipi_send_single(desc, cpu);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ipi_send_single);
+
+/**
+ * ipi_send_mask - send an IPI to target CPU(s)
+ * @virq: linux irq number from irq_reserve_ipi()
+ * @dest: dest CPU(s), must be the same or a subset of the mask passed to
+ *        irq_reserve_ipi()
+ *
+ * Sends an IPI to all prcessors in dest mask.
+ *
+ * Returns zero on success and negative error number on failure.
+ */
+int ipi_send_mask(unsigned int virq, const struct cpumask *dest)
+{
+	struct irq_desc *desc = irq_to_desc(virq);
+	struct irq_data *data = desc ? irq_desc_get_irq_data(desc) : NULL;
+	struct irq_chip *chip = data ? irq_data_get_irq_chip(data) : NULL;
+	struct cpumask *ipimask = data ? irq_data_get_affinity_mask(data) : NULL;
+
+	if (!chip || !ipimask)
+		return -EINVAL;
+
+	if (!chip->ipi_send_single && !chip->ipi_send_mask)
+		return -EINVAL;
+
+	if (!cpumask_subset(dest, ipimask))
+		return -EINVAL;
+
+	__ipi_send_mask(desc, dest);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ipi_send_mask);
-- 
2.1.0
