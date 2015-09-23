Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Sep 2015 16:51:04 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:9952 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008665AbbIWOuCNyosn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Sep 2015 16:50:02 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id E286871DE57BA;
        Wed, 23 Sep 2015 15:49:52 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 23 Sep 2015 15:49:55 +0100
Received: from qyousef-linux.le.imgtec.org (192.168.154.94) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 23 Sep 2015 15:49:55 +0100
From:   Qais Yousef <qais.yousef@imgtec.com>
To:     <linux-kernel@vger.kernel.org>, <tglx@linutronix.de>
CC:     <marc.zyngier@arm.com>, <jason@lakedaemon.net>,
        <jiang.liu@linux.intel.com>, <linux-mips@linux-mips.org>,
        Qais Yousef <qais.yousef@imgtec.com>
Subject: [PATCH 4/6] irq: add a new generic IPI handling code to irq core
Date:   Wed, 23 Sep 2015 15:49:16 +0100
Message-ID: <1443019758-20620-5-git-send-email-qais.yousef@imgtec.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1443019758-20620-1-git-send-email-qais.yousef@imgtec.com>
References: <1443019758-20620-1-git-send-email-qais.yousef@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.94]
Return-Path: <Qais.Yousef@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49342
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
IPI and use the associate virq to send one to 1 or more cpus.

No irq_get_irq_hwcfg() as I hope we can provide an implementation without
hardware specific part. Hopefully I'm not being too optimistic :)

Signed-off-by: Qais Yousef <qais.yousef@imgtec.com>
---
 include/linux/irqdomain.h |   4 ++
 kernel/irq/irqdomain.c    | 161 +++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 164 insertions(+), 1 deletion(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 76a0e7aaa8df..4bdd7b48d205 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -329,6 +329,10 @@ extern struct ipi_virq *irq_domain_find_ipi_virq(struct irq_domain *d,
 extern int irq_domain_ipi_virq_add_hwirq(struct ipi_virq *v,
 					 struct ipi_hwirq *h);
 extern struct ipi_hwirq *irq_domain_ipi_virq_rm_hwirq(struct ipi_virq *v);
+extern unsigned int irq_reserve_ipi(struct irq_domain *domain,
+				const struct cpumask *dest, void *devid);
+extern void irq_destroy_ipi(unsigned int irq, void *devid);
+extern void irq_send_ipi(unsigned int irq, const struct cpumask *dest, void *devid);
 
 /* V2 interfaces to support hierarchy IRQ domains. */
 extern struct irq_data *irq_domain_get_irq_data(struct irq_domain *domain,
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 6d911fc8fa52..d38d78a994ca 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -873,7 +873,7 @@ struct ipi_virq *irq_domain_find_ipi_virq(struct irq_domain *d,
  * returns a pointer to ipi_virq struct on success and NULL on failure
  */
 static struct ipi_virq *irq_domain_alloc_ipi_virq(unsigned int virq,
-				struct cpumask *cpumask, void *devid)
+				const struct cpumask *cpumask, void *devid)
 {
 	struct ipi_virq *v;
 
@@ -942,6 +942,165 @@ struct ipi_hwirq *irq_domain_ipi_virq_rm_hwirq(struct ipi_virq *v)
 	return h;
 }
 
+/**
+ * irq_reserve_ipi() - setup an IPI to destination cpumask
+ * @domain: IPI domain
+ * @dest: cpumask of cpus to receive the IPI
+ * @devid: devid that requested the reservation
+ *
+ * Allocate a virq that can be used to send IPI to any CPU in dest mask.
+ *
+ * On success it'll return linux irq number and 0 on failure
+ */
+unsigned int irq_reserve_ipi(struct irq_domain *domain,
+			     const struct cpumask *dest, void *devid)
+{
+	int virq, ret;
+	unsigned int nr_irqs;
+	struct ipi_virq *v;
+
+	if (domain == NULL)
+		domain = irq_default_domain; /* need a separate ipi_default_domain? */
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
+	if (cpumask_empty(dest)) {
+		pr_warn("Can't reserve IPI due to empty cpumask\n");
+		return 0;
+	}
+
+	/* always allocate a virq per cpu */
+	nr_irqs = cpumask_weight(dest);
+
+	virq = irq_domain_alloc_descs(-1, nr_irqs, 0, NUMA_NO_NODE);
+	if (virq <= 0) {
+		pr_warn("Can't reserve IPI, failed to alloc descs\n");
+		return 0;
+	}
+
+	v = irq_domain_alloc_ipi_virq(virq, dest, devid);
+	if (!v) {
+		pr_warn("Can't reserve IPI, failed to alloc ipi_virq\n");
+		goto free_descs;
+	}
+
+	/* we are reusing hierarchy alloc function, should we create another one? */
+	virq = __irq_domain_alloc_irqs(domain, virq, nr_irqs, NUMA_NO_NODE,
+					v, true);
+	if (virq <= 0) {
+		pr_warn("Can't reserve IPI, failed to alloc irqs\n");
+		goto free_ipi;
+	}
+
+	ret = irq_domain_add_ipi_virq(domain, v);
+	if (ret) {
+		pr_warn("Can't reserve IPI, failed to add ipi_virq\n");
+		goto free_ipi;
+	}
+
+	return virq;
+
+free_ipi:
+	irq_domain_free_ipi_virq(v);
+free_descs:
+	irq_free_descs(virq, nr_irqs);
+	return 0;
+}
+
+/**
+ * irq_destroy_ipi() - unreserve an IPI that was previously allocated
+ * @irq: linux irq number to be destroyed
+ * @devid: devid that reserved the IPI
+ *
+ * Return an IPI allocated with irq_reserve_ipi() to the system.
+ */
+void irq_destroy_ipi(unsigned int irq, void *devid)
+{
+	struct irq_data *irq_data = irq_get_irq_data(irq);
+	struct irq_domain *domain;
+	struct ipi_virq *v;
+
+	if (!irq || !irq_data)
+		return;
+
+	domain = irq_data->domain;
+	if (WARN_ON(domain == NULL))
+		return;
+
+	if (!irq_domain_is_ipi(domain)) {
+		pr_warn("Not an IPI domain!\n");
+		return;
+	}
+
+	v = irq_domain_find_ipi_virq(domain, irq);
+	if (!v)
+		return;
+
+	if (v->devid != devid) {
+		pr_warn("Only the device that allocated the IPI can destroy it\n");
+		return;
+	}
+
+	irq_domain_free_irqs(irq, cpumask_weight(&v->cpumask));
+
+	v = irq_domain_rm_ipi_virq(domain, irq);
+	irq_domain_free_ipi_virq(v);
+}
+
+/**
+ * irq_send_ipi() - send an IPI to target CPU(s)
+ * @irq: linux irq number from irq_reserve_ipi()
+ * @dest: dest CPU(s), must be the same or a subset of the mask past to
+ *	  irq_reserve_ipi()
+ * @devid: devid that reserved the IPI
+ *
+ * Sends an IPI to all cpus in dest mask
+ */
+void irq_send_ipi(unsigned int irq, const struct cpumask *dest, void *devid)
+{
+	struct irq_data *irq_data = irq_get_irq_data(irq);
+	struct irq_domain *domain;
+	struct ipi_virq *v;
+	struct ipi_hwirq *h;
+
+	if (!irq || !irq_data)
+		return;
+
+	domain = irq_data->domain;
+	if (WARN_ON(domain == NULL))
+		return;
+
+	if (!irq_domain_is_ipi(domain)) {
+		pr_warn("Not an IPI domain!\n");
+		return;
+	}
+
+	v = irq_domain_find_ipi_virq(domain, irq);
+	if (!v)
+		return;
+
+	if (v->devid != devid) {
+		pr_warn("Only the device that allocated the IPI can send one\n");
+		return;
+	}
+
+	if (!cpumask_intersects(&v->cpumask, dest))
+		return;
+
+	list_for_each_entry(h, &v->mapped_hwirq, link) {
+		if (cpumask_intersects(&h->cpumask, dest))
+			domain->ops->send_ipi(h->hwirq);
+	}
+}
+
 #ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
 /**
  * irq_domain_add_hierarchy - Add a irqdomain into the hierarchy
-- 
2.1.0
