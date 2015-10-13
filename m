Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Oct 2015 12:19:28 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:12489 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009769AbbJMKQ76fxes (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Oct 2015 12:16:59 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 461E05CA9D154;
        Tue, 13 Oct 2015 11:16:52 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 13 Oct 2015 11:16:54 +0100
Received: from qyousef-linux.le.imgtec.org (192.168.154.94) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Tue, 13 Oct 2015 11:16:53 +0100
From:   Qais Yousef <qais.yousef@imgtec.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>, <jiang.liu@linux.intel.com>,
        <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        Qais Yousef <qais.yousef@imgtec.com>
Subject: [RFC v2 PATCH 08/14] irq: implement irq_send_ipi
Date:   Tue, 13 Oct 2015 11:16:16 +0100
Message-ID: <1444731382-19313-9-git-send-email-qais.yousef@imgtec.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1444731382-19313-1-git-send-email-qais.yousef@imgtec.com>
References: <1444731382-19313-1-git-send-email-qais.yousef@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.94]
Return-Path: <Qais.Yousef@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49505
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
 kernel/irq/manage.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index c3d0f26c3eff..32c740ac95b4 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -985,4 +985,7 @@ int irq_map_ipi(struct ipi_mapping *map,
 int irq_unmap_ipi(struct ipi_mapping *map,
 		  unsigned int cpu, irq_hw_number_t *hwirq);
 
+int __irq_desc_send_ipi(struct irq_desc *desc, const struct ipi_mask *dest);
+int irq_send_ipi(unsigned int virq, const struct ipi_mask *dest);
+
 #endif /* _LINUX_IRQ_H */
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 9a9bc0822c8f..f2425116a243 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1983,3 +1983,47 @@ int irq_unmap_ipi(struct ipi_mapping *map,
 
 	return 0;
 }
+
+int __irq_desc_send_ipi(struct irq_desc *desc, const struct ipi_mask *dest)
+{
+	struct irq_data *data = irq_desc_get_irq_data(desc);
+	struct irq_chip *chip = irq_data_get_irq_chip(data);
+
+	if (!chip || !chip->irq_send_ipi)
+		return -EINVAL;
+
+	/*
+	 * Do not validate the mask for IPIs marked global. These are
+	 * regular IPIs so we can avoid the operation as their target
+	 * mask is the cpu_possible_mask.
+	 */
+	if (!dest->global) {
+		if (!bitmap_subset(dest->cpumask, data->ipi_mask.cpumask,
+				   dest->nbits))
+			return -EINVAL;
+	}
+
+	chip->irq_send_ipi(data, dest);
+	return 0;
+}
+
+/**
+ * irq_send_ipi() - send an IPI to target CPU(s)
+ * @irq: linux irq number from irq_reserve_ipi()
+ * @dest: dest CPU(s), must be the same or a subset of the mask passed to
+ *	  irq_reserve_ipi()
+ *
+ * Sends an IPI to all cpus in dest mask.
+ *
+ * Returns 0 on success and errno otherwise..
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
+EXPORT_SYMBOL(irq_send_ipi);
-- 
2.1.0
