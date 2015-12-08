Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Dec 2015 14:22:19 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:36291 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013367AbbLHNVLX0H6Z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Dec 2015 14:21:11 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id AC4E5DF56CDFF;
        Tue,  8 Dec 2015 13:21:02 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Tue, 8 Dec 2015 13:21:04 +0000
Received: from qyousef-linux.le.imgtec.org (192.168.154.94) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Tue, 8 Dec 2015 13:21:04 +0000
From:   Qais Yousef <qais.yousef@imgtec.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>, <jiang.liu@linux.intel.com>,
        <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        <lisa.parratt@imgtec.com>, Qais Yousef <qais.yousef@imgtec.com>
Subject: [PATCH v4 04/19] genirq: Add struct ipi_mapping and its helper functions
Date:   Tue, 8 Dec 2015 13:20:15 +0000
Message-ID: <1449580830-23652-5-git-send-email-qais.yousef@imgtec.com>
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
X-archive-position: 50428
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

struct ipi_mapping will provide a mechanism for irqchip code to fill out the
mapping at reservation and to look it up when sending.

The use of this mapping mechanism is optional. Irqchips might have better and
simpler ways to represent the mapping without using this.

Signed-off-by: Qais Yousef <qais.yousef@imgtec.com>
---
 include/linux/irq.h |  43 +++++++++++++++++++++
 kernel/irq/Makefile |   1 +
 kernel/irq/ipi.c    | 109 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 153 insertions(+)
 create mode 100644 kernel/irq/ipi.c

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 3c1c96786248..14f1c036119c 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -128,6 +128,18 @@ struct msi_desc;
 struct irq_domain;
 
 /**
+ * struct ipi_mapping - IPI mapping information object
+ * @nr_hwirqs: number of hwirqs mapped
+ * @nr_cpus: number of cpus the controller can talk to
+ * @cpumap: per cpu hwirq mapping table
+ */
+struct ipi_mapping {
+	unsigned int nr_hwirqs;
+	unsigned int nr_cpus;
+	unsigned int cpumap[];
+};
+
+/**
  * struct irq_common_data - per irq data shared by all irqchips
  * @state_use_accessors: status information for irq chip functions.
  *			Use accessor functions to deal with it
@@ -135,6 +147,9 @@ struct irq_domain;
  * @handler_data:	per-IRQ data for the irq_chip methods
  * @affinity:		IRQ affinity on SMP
  * @msi_desc:		MSI descriptor
+ * @ipi_mapping:	Contains the hwirq mapping of IPIs.
+ *			The use of this struct is optional and not all irqchips
+ *			will use it.
  */
 struct irq_common_data {
 	unsigned int		state_use_accessors;
@@ -144,6 +159,9 @@ struct irq_common_data {
 	void			*handler_data;
 	struct msi_desc		*msi_desc;
 	cpumask_var_t		affinity;
+#ifdef CONFIG_GENERIC_IRQ_IPI
+	struct ipi_mapping	*ipi_map;
+#endif
 };
 
 /**
@@ -681,6 +699,21 @@ static inline struct cpumask *irq_data_get_affinity_mask(struct irq_data *d)
 	return d->common->affinity;
 }
 
+#ifdef CONFIG_GENERIC_IRQ_IPI
+
+static inline struct ipi_mapping *irq_data_get_ipi_map(struct irq_data *d)
+{
+	return d->common->ipi_map;
+}
+
+static inline void irq_data_set_ipi_map(struct irq_data *d,
+					struct ipi_mapping *map)
+{
+	d->common->ipi_map = map;
+}
+
+#endif
+
 unsigned int arch_dynirq_lower_bound(unsigned int from);
 
 int __irq_alloc_descs(int irq, unsigned int from, unsigned int cnt, int node,
@@ -934,4 +967,14 @@ static inline u32 irq_reg_readl(struct irq_chip_generic *gc,
 		return readl(gc->reg_base + reg_offset);
 }
 
+#define INVALID_HWIRQ	-1
+
+struct ipi_mapping *irq_alloc_ipi_mapping(unsigned int nr_cpus);
+void irq_free_ipi_mapping(struct ipi_mapping *map);
+int irq_map_ipi(struct ipi_mapping *map,
+		unsigned int cpu, irq_hw_number_t hwirq);
+int irq_unmap_ipi(struct ipi_mapping *map, unsigned int cpu);
+irq_hw_number_t irq_ipi_mapping_get_hwirq(struct ipi_mapping *map,
+					  unsigned int cpu);
+
 #endif /* _LINUX_IRQ_H */
diff --git a/kernel/irq/Makefile b/kernel/irq/Makefile
index 2fc9cbdf35b6..2ee42e95a3ce 100644
--- a/kernel/irq/Makefile
+++ b/kernel/irq/Makefile
@@ -8,3 +8,4 @@ obj-$(CONFIG_GENERIC_PENDING_IRQ) += migration.o
 obj-$(CONFIG_GENERIC_IRQ_MIGRATION) += cpuhotplug.o
 obj-$(CONFIG_PM_SLEEP) += pm.o
 obj-$(CONFIG_GENERIC_MSI_IRQ) += msi.o
+obj-$(CONFIG_GENERIC_IRQ_IPI) += ipi.o
diff --git a/kernel/irq/ipi.c b/kernel/irq/ipi.c
new file mode 100644
index 000000000000..8cf76852982f
--- /dev/null
+++ b/kernel/irq/ipi.c
@@ -0,0 +1,109 @@
+/*
+ * linux/kernel/irq/ipi.c
+ *
+ * Copyright (C) 2015 Imagination Technologies Ltd
+ * Author: Qais Yousef <qais.yousef@imgtec.com>
+ *
+ * This file contains driver APIs to the IPI subsystem.
+ */
+
+#include <linux/irq.h>
+#include <linux/slab.h>
+
+/**
+ * irq_alloc_ipi_mapping - allocate memory for struct ipi_mapping
+ * @nr_cpus: number of CPUs the mapping will have
+ *
+ * Will allocate and setup ipi_mapping structure.
+ *
+ * Returns a valid ipi_mapping pointer on success and NULL on error.
+ */
+struct ipi_mapping *irq_alloc_ipi_mapping(unsigned int nr_cpus)
+{
+	struct ipi_mapping *map;
+	size_t size;
+
+	size = sizeof(struct ipi_mapping) + BITS_TO_LONGS(nr_cpus) * sizeof(long);
+
+	map = kzalloc(size, GFP_KERNEL);
+	if (!map)
+		return NULL;
+
+	map->nr_cpus = nr_cpus;
+
+	memset(map->cpumap, INVALID_HWIRQ, size);
+
+	return map;
+}
+
+/**
+ * irq_free_ipi_mapping - release mempry associated with ipi_mapping struct
+ * @map: pointer to struct ipi_mapping to be freed
+ *
+ * Release the memory allocated for sturct ipi_mapping to the system.
+ */
+void irq_free_ipi_mapping(struct ipi_mapping *map)
+{
+	kfree(map);
+}
+
+/**
+ * irq_map_ipi - create a CPU to HWIRQ mapping for an IPI
+ * @map: pointer to the mapping structure
+ * @cpu: the CPU to map
+ * @hwirq: the HWIRQ to associate with @cpu
+ *
+ * Returns zero on success and negative error number on failure.
+ */
+int irq_map_ipi(struct ipi_mapping *map,
+		unsigned int cpu, irq_hw_number_t hwirq)
+{
+	if (cpu >= map->nr_cpus)
+		return -EINVAL;
+
+	map->cpumap[cpu] = hwirq;
+	map->nr_hwirqs++;
+
+	return 0;
+}
+
+/**
+ * irq_unmap_ipi - remove the CPU mapping of an IPI
+ * @map: pointer to the mapping structure
+ * @cpu: the CPU to be unmapped
+ *
+ * Mark the IPI mapping of a CPU to INVALID_HWIRQ.
+ *
+ * Returns zero on success and negative error number on failure.
+ */
+int irq_unmap_ipi(struct ipi_mapping *map, unsigned int cpu)
+{
+	if (cpu >= map->nr_cpus)
+		return -EINVAL;
+
+	if (map->cpumap[cpu] == INVALID_HWIRQ)
+		return -EINVAL;
+
+	map->cpumap[cpu] = INVALID_HWIRQ;
+	map->nr_hwirqs--;
+
+	return 0;
+}
+
+/**
+ * irq_ipi_mapping_get_hwirq - get the value of hwirq associated with @cpu
+ * @map: pointer to the mapping structure
+ * @cpu: the CPU to get its associated hwirq
+ *
+ * Return the hwiq asocaited with a @cpu
+ *
+ * Returns hwirq value on success and INVALID_HWIRQ on failure.
+ */
+irq_hw_number_t irq_ipi_mapping_get_hwirq(struct ipi_mapping *map,
+					  unsigned int cpu)
+{
+	if (cpu >= map->nr_cpus)
+		return INVALID_HWIRQ;
+
+	return map->cpumap[cpu];
+}
-- 
2.1.0
