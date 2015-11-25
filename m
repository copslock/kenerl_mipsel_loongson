Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Nov 2015 13:08:48 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:21830 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012722AbbKYMH6rY8df (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Nov 2015 13:07:58 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id D48107921CCA2;
        Wed, 25 Nov 2015 12:07:50 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Wed, 25 Nov 2015 12:07:52 +0000
Received: from qyousef-linux.le.imgtec.org (192.168.154.94) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 25 Nov 2015 12:07:51 +0000
From:   Qais Yousef <qais.yousef@imgtec.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>, <jiang.liu@linux.intel.com>,
        <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        Qais Yousef <qais.yousef@imgtec.com>
Subject: [PATCH v2 04/19] genirq: Add new struct ipi_mask and helper functions
Date:   Wed, 25 Nov 2015 12:06:42 +0000
Message-ID: <1448453217-3874-5-git-send-email-qais.yousef@imgtec.com>
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
X-archive-position: 50089
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

cpumask is limited to NR_CPUS. Introduce ipi_mask which allows us to address
cpu range that is higher than NR_CPUS which is required for drivers to send
IPIs for coprocessor that are outside Linux CPU range.

Signed-off-by: Qais Yousef <qais.yousef@imgtec.com>
---
 include/linux/irq.h | 84 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 3c1c96786248..7d8c3d88f16f 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -19,6 +19,7 @@
 #include <linux/irqreturn.h>
 #include <linux/irqnr.h>
 #include <linux/errno.h>
+#include <linux/slab.h>
 #include <linux/topology.h>
 #include <linux/wait.h>
 #include <linux/io.h>
@@ -128,6 +129,29 @@ struct msi_desc;
 struct irq_domain;
 
 /**
+ * struct ipi_mask - IPI mask information
+ * @nbits: number of bits in cpumask
+ * @offset: the starting position at which the first cpu is set in the mask
+ *	    this is only required by generic code to manage per_cpu IPIs.
+ * @global: whether the mask is SMP IPI ie: subset of cpu_possible_mask or not
+ * @cpumask: cpumask to be used when the ipi_mask is global
+ * @cpu_bitmap: the cpu bitmap to use when the ipi_mask is not global
+ *
+ * ipi_mask is similar to cpumask, but it provides nbits that's configurable
+ * rather than fixed to NR_CPUS. We need that to describe IPI masks to
+ * coprocessors that are outside the NR_CPUS range.
+ */
+struct ipi_mask {
+	unsigned int	nbits;
+	unsigned int	offset;
+	bool		global;
+	union {
+		struct cpumask	cpumask;
+		unsigned long	cpu_bitmap[0];
+	};
+};
+
+/**
  * struct irq_common_data - per irq data shared by all irqchips
  * @state_use_accessors: status information for irq chip functions.
  *			Use accessor functions to deal with it
@@ -934,4 +958,64 @@ static inline u32 irq_reg_readl(struct irq_chip_generic *gc,
 		return readl(gc->reg_base + reg_offset);
 }
 
+static inline const unsigned long *ipi_mask_bits(const struct ipi_mask *ipimask)
+{
+	if (ipimask->global)
+		return cpumask_bits(&ipimask->cpumask);
+	else
+		return ipimask->cpu_bitmap;
+}
+
+static inline unsigned int ipi_mask_weight(const struct ipi_mask *ipimask)
+{
+	if (ipimask->global)
+		return cpumask_weight(&ipimask->cpumask);
+	else
+		return bitmap_weight(ipimask->cpu_bitmap, ipimask->nbits);
+}
+
+static inline void ipi_mask_copy(struct ipi_mask *dst,
+				 const struct ipi_mask *src)
+{
+	dst->nbits = src->nbits;
+	dst->global = src->global;
+
+	if (src->global)
+		return cpumask_copy(&dst->cpumask, &src->cpumask);
+	else
+		return bitmap_copy(dst->cpu_bitmap,
+					src->cpu_bitmap, src->nbits);
+}
+
+static inline struct ipi_mask *ipi_mask_alloc(unsigned int nbits)
+{
+	size_t size = sizeof(struct ipi_mask) + BITS_TO_LONGS(nbits);
+	return kzalloc(size, GFP_KERNEL);
+}
+
+static inline void ipi_mask_free(struct ipi_mask *ipimask)
+{
+	kfree(ipimask);
+}
+
+static inline void ipi_mask_set_cpumask(struct ipi_mask *ipimask,
+					const struct cpumask *cpumask)
+{
+	ipimask->nbits = nr_cpu_ids;
+	ipimask->global = true;
+	cpumask_copy(&ipimask->cpumask, cpumask);
+}
+
+static inline void ipi_mask_set_offset(struct ipi_mask *ipimask,
+				       unsigned int offset)
+{
+	ipimask->offset = offset;
+}
+
+#define ipi_mask_for_each_cpu(cpu, mask)			\
+	for ((cpu) = -1;					\
+		(cpu) = find_next_bit(ipi_mask_bits(mask),	\
+				      (mask)->nbits, (cpu)+1),	\
+		(cpu) < (mask)->nbits;)
+
 #endif /* _LINUX_IRQ_H */
-- 
2.1.0
