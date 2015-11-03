Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Nov 2015 12:17:15 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:15237 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012428AbbKCLNq0qnr1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Nov 2015 12:13:46 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 980CBB66B570F;
        Tue,  3 Nov 2015 11:13:37 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Tue, 3 Nov 2015 11:13:39 +0000
Received: from qyousef-linux.le.imgtec.org (192.168.154.94) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Tue, 3 Nov 2015 11:13:38 +0000
From:   Qais Yousef <qais.yousef@imgtec.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>, <jiang.liu@linux.intel.com>,
        <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        Qais Yousef <qais.yousef@imgtec.com>
Subject: [PATCH 09/14] genirq: Implement irq_send_ipi() to be used by drivers
Date:   Tue, 3 Nov 2015 11:12:56 +0000
Message-ID: <1446549181-31788-10-git-send-email-qais.yousef@imgtec.com>
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
X-archive-position: 49816
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

There are 2 variants. __irq_desc_send_ipi() is meant to be used by arch code to
save the desc lookup when doing SMP IPIs.

irq_send_ipi() is meant for drivers that want to send IPIs to coprocessors they
interact with.

Signed-off-by: Qais Yousef <qais.yousef@imgtec.com>
---
 include/linux/irq.h |  3 +++
 kernel/irq/manage.c | 67 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 3b2f448b7ac3..680bee078879 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -1032,4 +1032,7 @@ int irq_map_ipi(struct ipi_mapping *map,
 int irq_unmap_ipi(struct ipi_mapping *map,
 		  unsigned int cpu, irq_hw_number_t *hwirq);
 
+int __irq_desc_send_ipi(struct irq_desc *desc, const struct ipi_mask *dest);
+int irq_send_ipi(unsigned int virq, const struct ipi_mask *dest);
+
 #endif /* _LINUX_IRQ_H */
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 67a71667a359..4bdf6df95b45 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -2013,7 +2013,6 @@ EXPORT_SYMBOL_GPL(irq_set_irqchip_state);
 struct ipi_mapping *irq_alloc_ipi_mapping(unsigned int nr_cpus)
 {
 	struct ipi_mapping *map;
-	int i;
 
 	map = kzalloc(sizeof(struct ipi_mapping) +
 			BITS_TO_LONGS(nr_cpus), GFP_KERNEL);
@@ -2087,3 +2086,69 @@ int irq_unmap_ipi(struct ipi_mapping *map,
 
 	return 0;
 }
+
+/**
+ *	__irq_desc_send_ipi - send an IPI to target CPU(s)
+ *	@irq_desc: pointer to irq_desc of the IRQ
+ *	@dest: dest CPU(s), must be the same or a subset of the mask passed to
+ *	       irq_reserve_ipi()
+ *
+ *	Sends an IPI to all cpus in dest mask.
+ *	This function is meant to be used from arch code to save the need to do
+ *	desc lookup that happens in the generic irq_send_ipi().
+ *
+ *	Returns zero on success and negative error number on failure.
+ */
+int __irq_desc_send_ipi(struct irq_desc *desc, const struct ipi_mask *dest)
+{
+	struct irq_data *data = irq_desc_get_irq_data(desc);
+	struct irq_chip *chip = irq_data_get_irq_chip(data);
+
+	if (!chip || !chip->irq_send_ipi)
+		return -EINVAL;
+
+	if (dest->nbits > data->common->ipi_mask->nbits)
+		return -EINVAL;
+
+	/*
+	 * Do not validate the mask for IPIs marked global. These are
+	 * regular IPIs so we can avoid the operation as their target
+	 * mask is the cpu_possible_mask.
+	 */
+	if (!data->common->ipi_mask->global) {
+		if (dest->global)
+			return -EINVAL;
+
+		if (!bitmap_subset(dest->cpu_bitmap,
+				   data->common->ipi_mask->cpu_bitmap,
+				   dest->nbits))
+			return -EINVAL;
+	} else {
+		if (!dest->global)
+			return -EINVAL;
+	}
+
+	chip->irq_send_ipi(data, dest);
+	return 0;
+}
+
+/**
+ *	irq_send_ipi - send an IPI to target CPU(s)
+ *	@irq: linux irq number from irq_reserve_ipi()
+ *	@dest: dest CPU(s), must be the same or a subset of the mask passed to
+ *	       irq_reserve_ipi()
+ *
+ *	Sends an IPI to all cpus in dest mask.
+ *
+ *	Returns zero on success and negative error number on failure.
+ */
+int irq_send_ipi(unsigned int virq, const struct ipi_mask *dest)
+{
+	struct irq_desc *desc = irq_to_desc(virq);
+
+	if (!desc)
+		return -EINVAL;
+
+	return __irq_desc_send_ipi(desc, dest);
+}
+EXPORT_SYMBOL_GPL(irq_send_ipi);
-- 
2.1.0
