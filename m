Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Feb 2016 11:03:05 +0100 (CET)
Received: from torg.zytor.com ([198.137.202.12]:44262 "EHLO terminus.zytor.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27010007AbcBYKDDGBqfm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 25 Feb 2016 11:03:03 +0100
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTP id u1PA2bxp000865;
        Thu, 25 Feb 2016 02:02:42 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.14.8/Submit) id u1PA2bu1000862;
        Thu, 25 Feb 2016 02:02:37 -0800
Date:   Thu, 25 Feb 2016 02:02:37 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Qais Yousef <tipbot@zytor.com>
Message-ID: <tip-d17bf24e695290d3fe7943aca52ab48098a10653@git.kernel.org>
Cc:     jason@lakedaemon.net, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de,
        mingo@kernel.org, qsyousef@gmail.com, ralf@linux-mips.org,
        lisa.parratt@imgtec.com, qais.yousef@imgtec.com,
        jiang.liu@linux.intel.com, marc.zyngier@arm.com
Reply-To: jason@lakedaemon.net, linux-mips@linux-mips.org,
          linux-kernel@vger.kernel.org, mingo@kernel.org, hpa@zytor.com,
          tglx@linutronix.de, qsyousef@gmail.com, ralf@linux-mips.org,
          marc.zyngier@arm.com, jiang.liu@linux.intel.com,
          lisa.parratt@imgtec.com, qais.yousef@imgtec.com
In-Reply-To: <1449580830-23652-9-git-send-email-qais.yousef@imgtec.com>
References: <1449580830-23652-9-git-send-email-qais.yousef@imgtec.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] genirq: Add a new generic IPI reservation code to
 irq core
Git-Commit-ID: d17bf24e695290d3fe7943aca52ab48098a10653
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
X-archive-position: 52243
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

Commit-ID:  d17bf24e695290d3fe7943aca52ab48098a10653
Gitweb:     http://git.kernel.org/tip/d17bf24e695290d3fe7943aca52ab48098a10653
Author:     Qais Yousef <qais.yousef@imgtec.com>
AuthorDate: Tue, 8 Dec 2015 13:20:19 +0000
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 25 Feb 2016 10:56:56 +0100

genirq: Add a new generic IPI reservation code to irq core

Add a generic mechanism to dynamically allocate an IPI. Depending on the
underlying implementation this creates either a single Linux irq or a
consective range of Linux irqs. The Linux irq is used later to send IPIs to
other CPUs.

[ tglx: Massaged the code and removed the 'consecutive mask' restriction for
  	the single IRQ case ]

Signed-off-by: Qais Yousef <qais.yousef@imgtec.com>
Cc: <jason@lakedaemon.net>
Cc: <marc.zyngier@arm.com>
Cc: <jiang.liu@linux.intel.com>
Cc: <ralf@linux-mips.org>
Cc: <linux-mips@linux-mips.org>
Cc: <lisa.parratt@imgtec.com>
Cc: Qais Yousef <qsyousef@gmail.com>
Link: http://lkml.kernel.org/r/1449580830-23652-9-git-send-email-qais.yousef@imgtec.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/irq.h       |   3 +
 include/linux/irqdomain.h |   5 ++
 kernel/irq/Makefile       |   1 +
 kernel/irq/ipi.c          | 137 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 146 insertions(+)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index a32b47f..95f4f66 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -940,4 +940,7 @@ static inline u32 irq_reg_readl(struct irq_chip_generic *gc,
 		return readl(gc->reg_base + reg_offset);
 }
 
+/* Contrary to Linux irqs, for hardware irqs the irq number 0 is valid */
+#define INVALID_HWIRQ	(~0UL)
+
 #endif /* _LINUX_IRQ_H */
diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index c466cc1..ed48594 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -344,6 +344,11 @@ int irq_domain_xlate_onetwocell(struct irq_domain *d, struct device_node *ctrlr,
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
diff --git a/kernel/irq/Makefile b/kernel/irq/Makefile
index 2fc9cbd..2ee42e9 100644
--- a/kernel/irq/Makefile
+++ b/kernel/irq/Makefile
@@ -8,3 +8,4 @@ obj-$(CONFIG_GENERIC_PENDING_IRQ) += migration.o
 obj-$(CONFIG_GENERIC_IRQ_MIGRATION) += cpuhotplug.o
 obj-$(CONFIG_PM_SLEEP) += pm.o
 obj-$(CONFIG_GENERIC_MSI_IRQ) += msi.o
+obj-$(CONFIG_GENERIC_IRQ_IPI) += ipi.o
diff --git a/kernel/irq/ipi.c b/kernel/irq/ipi.c
new file mode 100644
index 0000000..340af27
--- /dev/null
+++ b/kernel/irq/ipi.c
@@ -0,0 +1,137 @@
+/*
+ * linux/kernel/irq/ipi.c
+ *
+ * Copyright (C) 2015 Imagination Technologies Ltd
+ * Author: Qais Yousef <qais.yousef@imgtec.com>
+ *
+ * This file contains driver APIs to the IPI subsystem.
+ */
+
+#define pr_fmt(fmt) "genirq/ipi: " fmt
+
+#include <linux/irqdomain.h>
+#include <linux/irq.h>
+
+/**
+ * irq_reserve_ipi() - Setup an IPI to destination cpumask
+ * @domain:	IPI domain
+ * @dest:	cpumask of cpus which can receive the IPI
+ *
+ * Allocate a virq that can be used to send IPI to any CPU in dest mask.
+ *
+ * On success it'll return linux irq number and 0 on failure
+ */
+unsigned int irq_reserve_ipi(struct irq_domain *domain,
+			     const struct cpumask *dest)
+{
+	unsigned int nr_irqs, offset;
+	struct irq_data *data;
+	int virq, i;
+
+	if (!domain ||!irq_domain_is_ipi(domain)) {
+		pr_warn("Reservation on a non IPI domain\n");
+		return 0;
+	}
+
+	if (!cpumask_subset(dest, cpu_possible_mask)) {
+		pr_warn("Reservation is not in possible_cpu_mask\n");
+		return 0;
+	}
+
+	nr_irqs = cpumask_weight(dest);
+	if (!nr_irqs) {
+		pr_warn("Reservation for empty destination mask\n");
+		return 0;
+	}
+
+	if (irq_domain_is_ipi_single(domain)) {
+		/*
+		 * If the underlying implementation uses a single HW irq on
+		 * all cpus then we only need a single Linux irq number for
+		 * it. We have no restrictions vs. the destination mask. The
+		 * underlying implementation can deal with holes nicely.
+		 */
+		nr_irqs = 1;
+		offset = 0;
+	} else {
+		unsigned int next;
+
+		/*
+		 * The IPI requires a seperate HW irq on each CPU. We require
+		 * that the destination mask is consecutive. If an
+		 * implementation needs to support holes, it can reserve
+		 * several IPI ranges.
+		 */
+		offset = cpumask_first(dest);
+		/*
+		 * Find a hole and if found look for another set bit after the
+		 * hole. For now we don't support this scenario.
+		 */
+		next = cpumask_next_zero(offset, dest);
+		if (next < nr_cpu_ids)
+			next = cpumask_next(next, dest);
+		if (next < nr_cpu_ids) {
+			pr_warn("Destination mask has holes\n");
+			return 0;
+		}
+	}
+
+	virq = irq_domain_alloc_descs(-1, nr_irqs, 0, NUMA_NO_NODE);
+	if (virq <= 0) {
+		pr_warn("Can't reserve IPI, failed to alloc descs\n");
+		return 0;
+	}
+
+	virq = __irq_domain_alloc_irqs(domain, virq, nr_irqs, NUMA_NO_NODE,
+				       (void *) dest, true);
+
+	if (virq <= 0) {
+		pr_warn("Can't reserve IPI, failed to alloc hw irqs\n");
+		goto free_descs;
+	}
+
+	for (i = 0; i < nr_irqs; i++) {
+		data = irq_get_irq_data(virq + i);
+		cpumask_copy(data->common->affinity, dest);
+		data->common->ipi_offset = offset;
+	}
+	return virq;
+
+free_descs:
+	irq_free_descs(virq, nr_irqs);
+	return 0;
+}
+
+/**
+ * irq_destroy_ipi() - unreserve an IPI that was previously allocated
+ * @irq:	linux irq number to be destroyed
+ *
+ * Return the IPIs allocated with irq_reserve_ipi() to the system destroying
+ * all virqs associated with them.
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
+		pr_warn("Trying to destroy a non IPI domain!\n");
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
