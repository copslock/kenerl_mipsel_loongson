Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Feb 2016 11:04:06 +0100 (CET)
Received: from torg.zytor.com ([198.137.202.12]:44344 "EHLO terminus.zytor.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27013458AbcBYKD52rIIm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 25 Feb 2016 11:03:57 +0100
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTP id u1PA3a0c001376;
        Thu, 25 Feb 2016 02:03:41 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.14.8/Submit) id u1PA3al4001373;
        Thu, 25 Feb 2016 02:03:36 -0800
Date:   Thu, 25 Feb 2016 02:03:36 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Qais Yousef <tipbot@zytor.com>
Message-ID: <tip-3b8e29a82dd16c1f2061e0b955a71cd36eeb061b@git.kernel.org>
Cc:     marc.zyngier@arm.com, jiang.liu@linux.intel.com,
        ralf@linux-mips.org, linux-mips@linux-mips.org,
        qais.yousef@imgtec.com, hpa@zytor.com, lisa.parratt@imgtec.com,
        tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        jason@lakedaemon.net, qsyousef@gmail.com
Reply-To: linux-mips@linux-mips.org, qais.yousef@imgtec.com,
          marc.zyngier@arm.com, jiang.liu@linux.intel.com,
          ralf@linux-mips.org, jason@lakedaemon.net, qsyousef@gmail.com,
          hpa@zytor.com, lisa.parratt@imgtec.com, tglx@linutronix.de,
          mingo@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1449580830-23652-12-git-send-email-qais.yousef@imgtec.com>
References: <1449580830-23652-12-git-send-email-qais.yousef@imgtec.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] genirq: Implement ipi_send_mask/single()
Git-Commit-ID: 3b8e29a82dd16c1f2061e0b955a71cd36eeb061b
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Precedence: bulk
Return-Path: <tipbot@zytor.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52246
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tipbot@zytor.com
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

Commit-ID:  3b8e29a82dd16c1f2061e0b955a71cd36eeb061b
Gitweb:     http://git.kernel.org/tip/3b8e29a82dd16c1f2061e0b955a71cd36eeb061b
Author:     Qais Yousef <qais.yousef@imgtec.com>
AuthorDate: Tue, 8 Dec 2015 13:20:22 +0000
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 25 Feb 2016 10:56:57 +0100

genirq: Implement ipi_send_mask/single()

Add APIs to send IPIs from driver and arch code.

We have different functions because we allow architecture code to cache the
irq descriptor to avoid lookups. Driver code has to use the irq number and is
subject to more restrictive checks.

[ tglx: Polish the implementation ]

Signed-off-by: Qais Yousef <qais.yousef@imgtec.com>
Cc: <jason@lakedaemon.net>
Cc: <marc.zyngier@arm.com>
Cc: <jiang.liu@linux.intel.com>
Cc: <ralf@linux-mips.org>
Cc: <linux-mips@linux-mips.org>
Cc: <lisa.parratt@imgtec.com>
Cc: Qais Yousef <qsyousef@gmail.com>
Link: http://lkml.kernel.org/r/1449580830-23652-12-git-send-email-qais.yousef@imgtec.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/irq.h |   4 ++
 kernel/irq/ipi.c    | 157 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 160 insertions(+), 1 deletion(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 3b3a5b8..d5ebd94 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -948,5 +948,9 @@ static inline u32 irq_reg_readl(struct irq_chip_generic *gc,
 /* Contrary to Linux irqs, for hardware irqs the irq number 0 is valid */
 #define INVALID_HWIRQ	(~0UL)
 irq_hw_number_t ipi_get_hwirq(unsigned int irq, unsigned int cpu);
+int __ipi_send_single(struct irq_desc *desc, unsigned int cpu);
+int __ipi_send_mask(struct irq_desc *desc, const struct cpumask *dest);
+int ipi_send_single(unsigned int virq, unsigned int cpu);
+int ipi_send_mask(unsigned int virq, const struct cpumask *dest);
 
 #endif /* _LINUX_IRQ_H */
diff --git a/kernel/irq/ipi.c b/kernel/irq/ipi.c
index 6f34f29..c37f34b 100644
--- a/kernel/irq/ipi.c
+++ b/kernel/irq/ipi.c
@@ -161,7 +161,7 @@ irq_hw_number_t ipi_get_hwirq(unsigned int irq, unsigned int cpu)
 	 * Get the real hardware irq number if the underlying implementation
 	 * uses a seperate irq per cpu. If the underlying implementation uses
 	 * a single hardware irq for all cpus then the IPI send mechanism
-	 * needs to take care of this.
+	 * needs to take care of the cpu destinations.
 	 */
 	if (irq_domain_is_ipi_per_cpu(data->domain))
 		data = irq_get_irq_data(irq + cpu - data->common->ipi_offset);
@@ -169,3 +169,158 @@ irq_hw_number_t ipi_get_hwirq(unsigned int irq, unsigned int cpu)
 	return data ? irqd_to_hwirq(data) : INVALID_HWIRQ;
 }
 EXPORT_SYMBOL_GPL(ipi_get_hwirq);
+
+static int ipi_send_verify(struct irq_chip *chip, struct irq_data *data,
+			   const struct cpumask *dest, unsigned int cpu)
+{
+	struct cpumask *ipimask = irq_data_get_affinity_mask(data);
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
+	if (dest) {
+		if (!cpumask_subset(dest, ipimask))
+			return -EINVAL;
+	} else {
+		if (!cpumask_test_cpu(cpu, ipimask))
+			return -EINVAL;
+	}
+	return 0;
+}
+
+/**
+ * __ipi_send_single - send an IPI to a target Linux SMP CPU
+ * @desc:	pointer to irq_desc of the IRQ
+ * @cpu:	destination CPU, must in the destination mask passed to
+ *		irq_reserve_ipi()
+ *
+ * This function is for architecture or core code to speed up IPI sending. Not
+ * usable from driver code.
+ *
+ * Returns zero on success and negative error number on failure.
+ */
+int __ipi_send_single(struct irq_desc *desc, unsigned int cpu)
+{
+	struct irq_data *data = irq_desc_get_irq_data(desc);
+	struct irq_chip *chip = irq_data_get_irq_chip(data);
+
+#ifdef DEBUG
+	/*
+	 * Minimise the overhead by omitting the checks for Linux SMP IPIs.
+	 * Since the callers should be arch or core code which is generally
+	 * trusted, only check for errors when debugging.
+	 */
+	if (WARN_ON_ONCE(ipi_send_verify(chip, data, NULL, cpu)))
+		return -EINVAL;
+#endif
+	if (!chip->ipi_send_single) {
+		chip->ipi_send_mask(data, cpumask_of(cpu));
+		return 0;
+	}
+
+	/* FIXME: Store this information in irqdata flags */
+	if (irq_domain_is_ipi_per_cpu(data->domain) &&
+	    cpu != data->common->ipi_offset) {
+		/* use the correct data for that cpu */
+		unsigned irq = data->irq + cpu - data->common->ipi_offset;
+
+		data = irq_get_irq_data(irq);
+	}
+	chip->ipi_send_single(data, cpu);
+	return 0;
+}
+
+/**
+ * ipi_send_mask - send an IPI to target Linux SMP CPU(s)
+ * @desc:	pointer to irq_desc of the IRQ
+ * @dest:	dest CPU(s), must be a subset of the mask passed to
+ *		irq_reserve_ipi()
+ *
+ * This function is for architecture or core code to speed up IPI sending. Not
+ * usable from driver code.
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
+	 * Since the callers should be arch or core code which is generally
+	 * trusted, only check for errors when debugging.
+	 */
+	if (WARN_ON_ONCE(ipi_send_verify(chip, data, dest, 0)))
+		return -EINVAL;
+#endif
+	if (chip->ipi_send_mask) {
+		chip->ipi_send_mask(data, dest);
+		return 0;
+	}
+
+	if (irq_domain_is_ipi_per_cpu(data->domain)) {
+		unsigned int base = data->irq;
+
+		for_each_cpu(cpu, dest) {
+			unsigned irq = base + cpu - data->common->ipi_offset;
+
+			data = irq_get_irq_data(irq);
+			chip->ipi_send_single(data, cpu);
+		}
+	} else {
+		for_each_cpu(cpu, dest)
+			chip->ipi_send_single(data, cpu);
+	}
+	return 0;
+}
+
+/**
+ * ipi_send_single - Send an IPI to a single CPU
+ * @virq:	linux irq number from irq_reserve_ipi()
+ * @cpu:	destination CPU, must in the destination mask passed to
+ *		irq_reserve_ipi()
+ *
+ * Returns zero on success and negative error number on failure.
+ */
+int ipi_send_single(unsigned int virq, unsigned int cpu)
+{
+	struct irq_desc *desc = irq_to_desc(virq);
+	struct irq_data *data = desc ? irq_desc_get_irq_data(desc) : NULL;
+	struct irq_chip *chip = data ? irq_data_get_irq_chip(data) : NULL;
+
+	if (WARN_ON_ONCE(ipi_send_verify(chip, data, NULL, cpu)))
+		return -EINVAL;
+
+	return __ipi_send_single(desc, cpu);
+}
+EXPORT_SYMBOL_GPL(ipi_send_single);
+
+/**
+ * ipi_send_mask - Send an IPI to target CPU(s)
+ * @virq:	linux irq number from irq_reserve_ipi()
+ * @dest:	dest CPU(s), must be a subset of the mask passed to
+ *		irq_reserve_ipi()
+ *
+ * Returns zero on success and negative error number on failure.
+ */
+int ipi_send_mask(unsigned int virq, const struct cpumask *dest)
+{
+	struct irq_desc *desc = irq_to_desc(virq);
+	struct irq_data *data = desc ? irq_desc_get_irq_data(desc) : NULL;
+	struct irq_chip *chip = data ? irq_data_get_irq_chip(data) : NULL;
+
+	if (WARN_ON_ONCE(ipi_send_verify(chip, data, dest, 0)))
+		return -EINVAL;
+
+	return __ipi_send_mask(desc, dest);
+}
+EXPORT_SYMBOL_GPL(ipi_send_mask);
