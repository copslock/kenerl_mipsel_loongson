Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Sep 2015 16:50:41 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:33477 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008670AbbIWOt6YZ5ln (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Sep 2015 16:49:58 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 4DB8AEA576B46;
        Wed, 23 Sep 2015 15:49:48 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 23 Sep 2015 15:49:51 +0100
Received: from qyousef-linux.le.imgtec.org (192.168.154.94) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 23 Sep 2015 15:49:50 +0100
From:   Qais Yousef <qais.yousef@imgtec.com>
To:     <linux-kernel@vger.kernel.org>, <tglx@linutronix.de>
CC:     <marc.zyngier@arm.com>, <jason@lakedaemon.net>,
        <jiang.liu@linux.intel.com>, <linux-mips@linux-mips.org>,
        Qais Yousef <qais.yousef@imgtec.com>
Subject: [PATCH 3/6] irqdomain: add struct irq_hwcfg and helper functions
Date:   Wed, 23 Sep 2015 15:49:15 +0100
Message-ID: <1443019758-20620-4-git-send-email-qais.yousef@imgtec.com>
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
X-archive-position: 49341
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

struct irq_hwcfg is used to describe hardware IPI setup.

From ThomasG suggestion, there's generic parts and a union of hardware
specific part. Assuming that virq and hwirq are enough to describe different
sort of hardwares as so far they are all that was needed, I'm hoping this
implementation will render the need for a platform specific part unnecessary.

The idea is for the irqdomain alloc function to take a hwirq from the available
list, do the necessary mapping to CPU(s), setting ipi_hwirq cpumask, and then
adding this hwirq to the mapped_hwirq list in ipi_virq struct.

Hopefully the code and documentation is self explanatory.

Next commit implements the actual reserve, destroy, and send IPI using these functions.

Signed-off-by: Qais Yousef <qais.yousef@imgtec.com>
---
 include/linux/irqdomain.h |  49 ++++++++++++
 kernel/irq/irqdomain.c    | 193 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 242 insertions(+)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index cef9e6158be0..76a0e7aaa8df 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -100,6 +100,45 @@ extern struct irq_domain_ops irq_generic_chip_ops;
 struct irq_domain_chip_generic;
 
 /**
+ * struct ipi_hwirq - IPI hwirq information object
+ * @link: Element in struct ipi_hwirq list
+ * @hwirq: hardware irq value
+ * @cpumask: cpumask where this hwirq is mapped to
+ */
+struct ipi_hwirq {
+	struct list_head link;
+	irq_hw_number_t hwirq;
+	struct cpumask cpumask;
+};
+
+/**
+ * struct ipi_virq - IPI virq information object
+ * @link: Element in struct ipi_virq list
+ * @virq: alocated linux irq number
+ * @cpumask: cpumask where this virq can send IPIs
+ * @devid: devid of device owning this virq
+ * @mapped_hwirq: list of ipi_hwirq that this virq is mapped to
+ */
+struct ipi_virq {
+	struct list_head link;
+	unsigned int virq;
+	struct cpumask cpumask;
+	void *devid;
+
+	struct list_head mapped_hwirq;
+};
+
+/**
+ * struct irq_hwcfg - IPI hardware allocation and translation object
+ * @available_ipis: a list of hwirq that can be allocated for IPIs
+ * @alloced_virqs: a list of virqs that were allocated and their mapping
+ */
+struct irq_hwcfg {
+	struct list_head available_ipis;
+	struct list_head alloced_virqs;
+};
+
+/**
  * struct irq_domain - Hardware interrupt number translation object
  * @link: Element in global irq_domain list.
  * @name: Name of interrupt domain
@@ -137,6 +176,7 @@ struct irq_domain {
 #ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
 	struct irq_domain *parent;
 #endif
+	struct irq_hwcfg ipi_hwcfg;
 
 	/* reverse map data. The linear map gets appended to the irq_domain */
 	irq_hw_number_t hwirq_max;
@@ -281,6 +321,15 @@ int irq_domain_xlate_onetwocell(struct irq_domain *d, struct device_node *ctrlr,
 			const u32 *intspec, unsigned int intsize,
 			irq_hw_number_t *out_hwirq, unsigned int *out_type);
 
+/* irq_hwcfg functions */
+extern int irq_domain_put_ipi_hwirq(struct irq_domain *d, struct ipi_hwirq *h);
+extern struct ipi_hwirq *irq_domain_get_ipi_hwirq(struct irq_domain *d);
+extern struct ipi_virq *irq_domain_find_ipi_virq(struct irq_domain *d,
+						unsigned int virq);
+extern int irq_domain_ipi_virq_add_hwirq(struct ipi_virq *v,
+					 struct ipi_hwirq *h);
+extern struct ipi_hwirq *irq_domain_ipi_virq_rm_hwirq(struct ipi_virq *v);
+
 /* V2 interfaces to support hierarchy IRQ domains. */
 extern struct irq_data *irq_domain_get_irq_data(struct irq_domain *domain,
 						unsigned int virq);
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index dc9d27c0c158..6d911fc8fa52 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -61,6 +61,8 @@ struct irq_domain *__irq_domain_add(struct device_node *of_node, int size,
 	domain->revmap_size = size;
 	domain->revmap_direct_max_irq = direct_max;
 	irq_domain_check_hierarchy(domain);
+	INIT_LIST_HEAD(&domain->ipi_hwcfg.available_ipis);
+	INIT_LIST_HEAD(&domain->ipi_hwcfg.alloced_virqs);
 
 	mutex_lock(&irq_domain_mutex);
 	list_add(&domain->link, &irq_domain_list);
@@ -749,6 +751,197 @@ static int irq_domain_alloc_descs(int virq, unsigned int cnt,
 	return virq;
 }
 
+/**
+ * irq_domain_put_ipi_hwirq() - return an IPI hwirq to the system
+ * @d: IPI domain to return the hwirq to
+ * @h: ipi_hwirq struct to be returned
+ *
+ * The domain must have a set of hwirqs to be used for IPI which are allocated
+ * by the underlying driver. This function adds this hwirq so it can be used
+ * to reserve an IPI later.
+ *
+ * returns 0 on success and negative errno on failure
+ */
+int irq_domain_put_ipi_hwirq(struct irq_domain *d, struct ipi_hwirq *h)
+{
+	struct list_head *head = &d->ipi_hwcfg.available_ipis;
+
+	cpumask_clear(&h->cpumask);
+	list_add_tail(&h->link, head);
+
+	return 0;
+}
+
+/**
+ * irq_domain_get_ipi_hwirq() - obtain an IPI hwirq from the system
+ * @d: IPI domain to obtain the hwirq from
+ *
+ * The domain contains a set of hwirqs that can be used for IPIs. This function
+ * obtains one from the available set of hwirqs.
+ *
+ * returns a pointer to ipi_hwirq struct on success and NULL on failure
+ */
+struct ipi_hwirq *irq_domain_get_ipi_hwirq(struct irq_domain *d)
+{
+	struct list_head *head = &d->ipi_hwcfg.available_ipis;
+	struct ipi_hwirq *h;
+
+	if (list_empty(head))
+		return NULL;
+
+	h = list_first_entry(head, struct ipi_hwirq, link);
+	list_del(&h->link);
+
+	return h;
+}
+
+/**
+ * irq_domain_add_ipi_virq() - add an allocated virq struct to the IPI domain
+ * @d: IPI domain to act on
+ * @v: ipi_virq struct to add
+ *
+ * The domain keeps a list of allocated (reserved) IPIs. This functions adds
+ * a newly reserved virq to this list.
+ *
+ * returns 0 on success and negative errno on failure
+ */
+static int irq_domain_add_ipi_virq(struct irq_domain *d, struct ipi_virq *v)
+{
+	struct list_head *head = &d->ipi_hwcfg.alloced_virqs;
+
+	list_add_tail(&v->link, head);
+
+	return 0;
+}
+
+/**
+ * irq_domain_add_ipi_virq() - remove an allocated virq struct from the IPI domain
+ * @d: IPI domain to act on
+ * @virq: virq to remove
+ *
+ * The domain keeps a list of allocated (reserved) IPIs. This functions removes
+ * a previously added virq from this list.
+ *
+ * returns a pointer to ipi_virq struct on success and NULL on failure
+ */
+static struct ipi_virq *irq_domain_rm_ipi_virq(struct irq_domain *d,
+					       unsigned int virq)
+{
+	struct ipi_virq *v;
+
+	v = irq_domain_find_ipi_virq(d, virq);
+	if (!v)
+		return NULL;
+
+	list_del(&v->link);
+
+	return v;
+}
+
+/**
+ * irq_domain_find_ipi_virq() - search the IPI domain for a virq
+ * @d: IPI domain to act on
+ * @virq: virq number to find
+ *
+ * The domain keeps a list of allocated (reserved) IPIs. This functions searches
+ * this list for a struct ipi_virq with a matching virq number
+ *
+ * returns a pointer to ipi_virq struct on success and NULL on failure
+ */
+struct ipi_virq *irq_domain_find_ipi_virq(struct irq_domain *d,
+					  unsigned int virq)
+{
+	struct list_head *head = &d->ipi_hwcfg.alloced_virqs;
+	struct ipi_virq *v;
+
+	list_for_each_entry(v, head, link) {
+		if (v->virq == virq)
+			return v;
+	}
+
+	return NULL;
+}
+
+/**
+ * irq_domain_alloc_ipi_virq() - alloc a ipi_virq struct
+ * @virq: virq number of the new ipi_virq struct
+ * @cpumask: cpumask associated with the virq
+ * @devid: devid whose this virq belong too
+ *
+ * Allocates a struct ipi_virq and initialise it
+ *
+ * returns a pointer to ipi_virq struct on success and NULL on failure
+ */
+static struct ipi_virq *irq_domain_alloc_ipi_virq(unsigned int virq,
+				struct cpumask *cpumask, void *devid)
+{
+	struct ipi_virq *v;
+
+	v = kzalloc(sizeof(struct ipi_virq), GFP_KERNEL);
+	if (!v)
+		return NULL;
+
+	v->virq = virq;
+	v->devid = devid;
+	cpumask_copy(&v->cpumask, cpumask);
+	INIT_LIST_HEAD(&v->mapped_hwirq);
+
+	return v;
+}
+
+/**
+ * irq_domain_alloc_ipi_virq() - free a ipi_virq struct
+ * @v: pointer to the ipi_virq struct to be freed
+ *
+ * Frees the memory assiciated with ipi_virq struct
+ */
+static void irq_domain_free_ipi_virq(struct ipi_virq *v)
+{
+	kfree(v);
+}
+
+/**
+ * irq_domain_ipi_virq_add_hwirq() - associated hwirq with a virq
+ * @v: pointer to the ipi_virq struct
+ * @h: pointer to the ipi_hwirq struct
+ *
+ * Associate a hwirq with a virq by adding it to its mapping list
+ *
+ * returns 0 on success and a negative errno on failure
+ */
+int irq_domain_ipi_virq_add_hwirq(struct ipi_virq *v,
+				  struct ipi_hwirq *h)
+{
+	struct list_head *head = &v->mapped_hwirq;
+
+	list_add_tail(&h->link, head);
+
+	return 0;
+}
+
+/**
+ * irq_domain_ipi_virq_rm_hwirq() - remove hwirq from a virq
+ * @v: pointer to the ipi_virq struct
+ *
+ * Removes a hwirq from the mapped hwirq list and returns it.
+ *
+ * returns a pointer to an associated ipi_hwirq struct on success or a NULL on
+ * failure
+ */
+struct ipi_hwirq *irq_domain_ipi_virq_rm_hwirq(struct ipi_virq *v)
+{
+	struct list_head *head = &v->mapped_hwirq;
+	struct ipi_hwirq *h;
+
+	if (list_empty(head))
+		return NULL;
+
+	h = list_first_entry(head, struct ipi_hwirq, link);
+	list_del(&h->link);
+
+	return h;
+}
+
 #ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
 /**
  * irq_domain_add_hierarchy - Add a irqdomain into the hierarchy
-- 
2.1.0
