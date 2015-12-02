Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Dec 2015 13:25:37 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:56299 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012011AbbLBMW3pmvNA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Dec 2015 13:22:29 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id AF44F72543B39;
        Wed,  2 Dec 2015 12:22:21 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Wed, 2 Dec 2015 12:22:23 +0000
Received: from qyousef-linux.le.imgtec.org (192.168.154.94) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 2 Dec 2015 12:22:23 +0000
From:   Qais Yousef <qais.yousef@imgtec.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>, <jiang.liu@linux.intel.com>,
        <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        Qais Yousef <qais.yousef@imgtec.com>
Subject: [PATCH v3 09/19] genirq: Add a new function to get IPI reverse mapping
Date:   Wed, 2 Dec 2015 12:21:50 +0000
Message-ID: <1449058920-21011-10-git-send-email-qais.yousef@imgtec.com>
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
X-archive-position: 50280
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

When dealing with coprocessors we need to find out the actual hwirqs values to
pass on to the firmware so that it knows what it needs to use to received and
send IPIs from and to us.

Signed-off-by: Qais Yousef <qais.yousef@imgtec.com>
---
 include/linux/irq.h |  2 ++
 kernel/irq/ipi.c    | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 7f6dd4eec207..1808ee4d42ec 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -981,4 +981,6 @@ int irq_unmap_ipi(struct ipi_mapping *map, unsigned int cpu);
 irq_hw_number_t irq_ipi_mapping_get_hwirq(struct ipi_mapping *map,
 					  unsigned int cpu);
 
+irq_hw_number_t ipi_get_hwirq(unsigned int irq, unsigned int cpu);
+
 #endif /* _LINUX_IRQ_H */
diff --git a/kernel/irq/ipi.c b/kernel/irq/ipi.c
index 250c1a96ca2d..814162b72aed 100644
--- a/kernel/irq/ipi.c
+++ b/kernel/irq/ipi.c
@@ -233,3 +233,40 @@ void irq_destroy_ipi(unsigned int irq)
 
 	irq_domain_free_irqs(irq, nr_irqs);
 }
+
+/**
+ * ipi_get_hwirq - get the hwirq associated with an IPI to a cpu
+ * @irq: linux irq number
+ * @cpu: the cpu to find the revmap for
+ *
+ * When dealing with coprocessors IPI, we need to inform it of the hwirq it
+ * needs to use to receive and send IPIs. This function provides the revmap
+ * to get this info to pass on to coprocessor firmware.
+ *
+ * Returns hwirq value on success and INVALID_HWIRQ on failure.
+ */
+irq_hw_number_t ipi_get_hwirq(unsigned int irq, unsigned int cpu)
+{
+	struct irq_data *data = irq_get_irq_data(irq);
+	struct cpumask *ipimask = data ? irq_data_get_affinity_mask(data) : NULL;
+	irq_hw_number_t hwirq;
+
+	if (!data || !ipimask)
+		return INVALID_HWIRQ;
+
+	if (cpu > nr_cpu_ids)
+		return INVALID_HWIRQ;
+
+	if (!cpumask_test_cpu(cpu, ipimask))
+		return INVALID_HWIRQ;
+
+	if (irq_domain_is_ipi_per_cpu(data->domain)) {
+		data = irq_get_irq_data(irq + cpu - data->common->ipi_offset);
+		hwirq = data ? irqd_to_hwirq(data) : INVALID_HWIRQ;
+	} else {
+		hwirq = irqd_to_hwirq(data) + cpu - data->common->ipi_offset;
+	}
+
+	return hwirq;
+}
+EXPORT_SYMBOL_GPL(ipi_get_hwirq);
-- 
2.1.0
