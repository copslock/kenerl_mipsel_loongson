Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Nov 2015 13:10:51 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:33197 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012765AbbKYMIKvvO7f (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Nov 2015 13:08:10 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id A4D4C2527ED2;
        Wed, 25 Nov 2015 12:08:01 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Wed, 25 Nov 2015 12:08:04 +0000
Received: from qyousef-linux.le.imgtec.org (192.168.154.94) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 25 Nov 2015 12:08:03 +0000
From:   Qais Yousef <qais.yousef@imgtec.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>, <jiang.liu@linux.intel.com>,
        <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        Qais Yousef <qais.yousef@imgtec.com>
Subject: [PATCH v2 11/19] genirq: Implement ipi_send_{mask, single}()
Date:   Wed, 25 Nov 2015 12:06:49 +0000
Message-ID: <1448453217-3874-12-git-send-email-qais.yousef@imgtec.com>
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
X-archive-position: 50096
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

Add APIs to send single or mask IPI. We have 2 variants, one that uses cpumask
and to be used by arch code to send regular SMP IPIs. And another that uses
ipi_mask to be used by drivers to send IPIs to coprocessors.

Signed-off-by: Qais Yousef <qais.yousef@imgtec.com>
---
 include/linux/irq.h |   5 ++
 kernel/irq/ipi.c    | 192 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 197 insertions(+)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index ee01e89c2140..eee522a04a7c 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -1081,4 +1081,9 @@ irq_hw_number_t irq_ipi_mapping_get_hwirq(struct ipi_mapping *map,
 
 irq_hw_number_t ipi_get_hwirq(unsigned int irq, unsigned int cpu);
 
+int ipi_send_single(struct irq_desc *desc, unsigned int cpu);
+int ipi_send_mask(struct irq_desc *desc, const struct cpumask *dest);
+int ipi_send_coproc_single(unsigned int virq, unsigned int cpu);
+int ipi_send_coproc_mask(unsigned int virq, const struct ipi_mask *dest);
+
 #endif /* _LINUX_IRQ_H */
diff --git a/kernel/irq/ipi.c b/kernel/irq/ipi.c
index d6faa0e768b8..e07642d0e59a 100644
--- a/kernel/irq/ipi.c
+++ b/kernel/irq/ipi.c
@@ -284,3 +284,195 @@ irq_hw_number_t ipi_get_hwirq(unsigned int irq, unsigned int cpu)
 	return hwirq;
 }
 EXPORT_SYMBOL_GPL(ipi_get_hwirq);
+
+/**
+ * ipi_send_single - send an IPI to a target Linux SMP CPU
+ * @desc: pointer to irq_desc of the IRQ
+ * @cpu: dest CPU, must be the same or a subset of the mask passed to
+ *        irq_reserve_ipi()
+ *
+ * Sends an IPI to a single smp cpu
+ * This function is meant to be used from arch code to send single SMP IPI.
+ *
+ * Returns zero on success and negative error number on failure.
+ */
+int ipi_send_single(struct irq_desc *desc, unsigned int cpu)
+{
+	struct irq_data *data = desc ? irq_desc_get_irq_data(desc) : NULL;
+	struct irq_chip *chip = data ? irq_data_get_irq_chip(data) : NULL;
+	struct ipi_mask *ipimask = data ? irq_data_get_ipi_mask(data) : NULL;
+	const struct cpumask *dest = cpumask_of(cpu);
+
+	/* do we want to make the checks below optional to reduce the overhead
+	 * since the only user of this function is arch code? */
+	if (!chip || !ipimask)
+		return -EINVAL;
+
+	if (!chip->ipi_send_single && !chip->ipi_send_mask)
+		return -EINVAL;
+
+	if (!ipimask->global || cpu > nr_cpu_ids)
+		return -EINVAL;
+
+	if (!cpumask_subset(dest, &ipimask->cpumask))
+		return -EINVAL;
+
+	if (chip->ipi_send_single)
+		chip->ipi_send_single(data, cpu);
+	else
+		chip->ipi_send_mask(data, dest);
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
+int ipi_send_mask(struct irq_desc *desc, const struct cpumask *dest)
+{
+	struct irq_data *data = desc ? irq_desc_get_irq_data(desc) : NULL;
+	struct irq_chip *chip = data ? irq_data_get_irq_chip(data) : NULL;
+	struct ipi_mask *ipimask = data ? irq_data_get_ipi_mask(data) : NULL;
+	unsigned int cpu;
+
+	/* do we want to make the checks below optional to reduce the overhead
+	 * since the only user of this function is arch code? */
+	if (!chip || !ipimask)
+		return -EINVAL;
+
+	if (!chip->ipi_send_single && !chip->ipi_send_mask)
+		return -EINVAL;
+
+	if (!ipimask->global)
+		return -EINVAL;
+
+	if (!cpumask_subset(dest, &ipimask->cpumask))
+		return -EINVAL;
+
+	if (chip->ipi_send_mask) {
+		chip->ipi_send_mask(data, dest);
+		return 0;
+	}
+
+	if (irq_domain_is_ipi_per_cpu(data->domain)) {
+		unsigned int base_virq = data->irq;
+		for_each_cpu(cpu, dest) {
+			data = irq_get_irq_data(base_virq + cpu - ipimask->offset);
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
+ * ipi_send_coproc_single - send an IPI to a single coprocessor
+ * @virq: linux irq number from irq_reserve_ipi()
+ * @cpu: cpu value of coprocessor.
+ *	 Must be a subset of the mask passed to irq_reserve_ipi()
+ *
+ * Sends an IPI to single coprcessor
+ *
+ * Returns zero on success and negative error number on failure.
+ */
+int ipi_send_coproc_single(unsigned int virq, unsigned int cpu)
+{
+	struct irq_desc *desc = irq_to_desc(virq);
+	struct irq_data *data = desc ? irq_desc_get_irq_data(desc) : NULL;
+	struct irq_chip *chip = data ? irq_data_get_irq_chip(data) : NULL;
+	struct ipi_mask *ipimask = data ? irq_data_get_ipi_mask(data) : NULL;
+
+	if (!chip || !ipimask)
+		return -EINVAL;
+
+	if (!chip->ipi_send_coproc_single && !chip->ipi_send_coproc_mask)
+		return -EINVAL;
+
+	if (cpu > ipimask->nbits)
+		return -EINVAL;
+
+	if (ipimask->global)
+		return -EINVAL;
+
+	if (!test_bit(cpu, ipimask->cpu_bitmap))
+		return -EINVAL;
+
+	if (chip->ipi_send_single) {
+		chip->ipi_send_coproc_single(data, cpu);
+	} else {
+		struct ipi_mask *dest = ipi_mask_alloc(cpu);
+		if (!dest)
+			return -ENOMEM;
+		set_bit(cpu, dest->cpu_bitmap);
+		chip->ipi_send_coproc_mask(data, dest);
+		ipi_mask_free(dest);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ipi_send_coproc_single);
+
+/**
+ * ipi_send_coproc_mask - send an IPI to target coprocessor(s)
+ * @virq: linux irq number from irq_reserve_ipi()
+ * @dest: dest CPU(s), must be the same or a subset of the mask passed to
+ *        irq_reserve_ipi()
+ *
+ * Sends an IPI to all coprcessors in dest mask.
+ *
+ * Returns zero on success and negative error number on failure.
+ */
+int ipi_send_coproc_mask(unsigned int virq, const struct ipi_mask *dest)
+{
+	struct irq_desc *desc = irq_to_desc(virq);
+	struct irq_data *data = desc ? irq_desc_get_irq_data(desc) : NULL;
+	struct irq_chip *chip = data ? irq_data_get_irq_chip(data) : NULL;
+	struct ipi_mask *ipimask = data ? irq_data_get_ipi_mask(data) : NULL;
+	unsigned int cpu;
+
+	if (!chip || !ipimask)
+		return -EINVAL;
+
+	if (!chip->ipi_send_coproc_single && !chip->ipi_send_coproc_mask)
+		return -EINVAL;
+
+	if (dest->nbits > ipimask->nbits)
+		return -EINVAL;
+
+	if (ipimask->global || dest->global)
+		return -EINVAL;
+
+	if (!bitmap_subset(dest->cpu_bitmap,
+			   ipimask->cpu_bitmap,
+			   dest->nbits))
+		return -EINVAL;
+
+	if (chip->ipi_send_mask) {
+		chip->ipi_send_coproc_mask(data, dest);
+		return 0;
+	}
+
+	if (irq_domain_is_ipi_per_cpu(data->domain)) {
+		unsigned int base_virq = data->irq;
+		ipi_mask_for_each_cpu(cpu, dest) {
+			data = irq_get_irq_data(base_virq + cpu - ipimask->offset);
+			chip->ipi_send_coproc_single(data, cpu);
+		}
+	} else {
+		ipi_mask_for_each_cpu(cpu, dest)
+			chip->ipi_send_coproc_single(data, cpu);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ipi_send_coproc_mask);
-- 
2.1.0
