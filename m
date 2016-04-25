Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Apr 2016 09:14:53 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:38925 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27027382AbcDYHOg4bnfP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 25 Apr 2016 09:14:36 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email with ESMTPS id DB7AFF3150813;
        Mon, 25 Apr 2016 08:14:27 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Mon, 25 Apr 2016 08:14:29 +0100
Received: from mredfearn-linux.kl.imgtec.org (192.168.154.116) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Mon, 25 Apr 2016 08:14:29 +0100
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     <lisa.parratt@imgtec.com>, <jason@lakedaemon.net>,
        <ralf@linux-mips.org>, <linux-kernel@vger.kernel.org>,
        <jiang.liu@linux.intel.com>, <marc.zyngier@arm.com>,
        <linux-mips@linux-mips.org>, Qais Yousef <qsyousef@gmail.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>
Subject: [PATCH v2 2/2] genirq: Add error code reporting to irq_{reserve,destroy}_ipi
Date:   Mon, 25 Apr 2016 08:14:24 +0100
Message-ID: <1461568464-31701-2-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1461568464-31701-1-git-send-email-matt.redfearn@imgtec.com>
References: <1461568464-31701-1-git-send-email-matt.redfearn@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.116]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53227
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@imgtec.com
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

Make these functions return appropriate error codes when something goes
wrong.

Previously irq_destroy_ipi returned void making it impossible to notify
the caller if the request could not be fulfilled. Patch 1 in the series
added another condition in which this could fail in addition to the
existing ones. irq_reserve_ipi returned an unsigned int meaning it could
only return 0 on failure and give the caller no indication as to why the
request failed.

As time goes on there are likely to be further conditions added in which
these functions can fail. These APIs and the IPI IRQ domain are new in
4.6 and the number of existing call sites are low, changing the API now
has little impact on the code, while making it easier for these
functions to grow over time.

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
---

Changes in v2:
- More descriptive commit message

 include/linux/irqdomain.h |  5 ++---
 kernel/irq/ipi.c          | 31 +++++++++++++++++--------------
 2 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index e1b81d35e7a3..736abd74c135 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -346,9 +346,8 @@ int irq_domain_xlate_onetwocell(struct irq_domain *d, struct device_node *ctrlr,
 			irq_hw_number_t *out_hwirq, unsigned int *out_type);
 
 /* IPI functions */
-unsigned int irq_reserve_ipi(struct irq_domain *domain,
-			     const struct cpumask *dest);
-void irq_destroy_ipi(unsigned int irq, const struct cpumask *dest);
+int irq_reserve_ipi(struct irq_domain *domain, const struct cpumask *dest);
+int irq_destroy_ipi(unsigned int irq, const struct cpumask *dest);
 
 /* V2 interfaces to support hierarchy IRQ domains. */
 extern struct irq_data *irq_domain_get_irq_data(struct irq_domain *domain,
diff --git a/kernel/irq/ipi.c b/kernel/irq/ipi.c
index bedc995ae214..c42742208e5e 100644
--- a/kernel/irq/ipi.c
+++ b/kernel/irq/ipi.c
@@ -19,9 +19,9 @@
  *
  * Allocate a virq that can be used to send IPI to any CPU in dest mask.
  *
- * On success it'll return linux irq number and 0 on failure
+ * On success it'll return linux irq number and error code on failure
  */
-unsigned int irq_reserve_ipi(struct irq_domain *domain,
+int irq_reserve_ipi(struct irq_domain *domain,
 			     const struct cpumask *dest)
 {
 	unsigned int nr_irqs, offset;
@@ -30,18 +30,18 @@ unsigned int irq_reserve_ipi(struct irq_domain *domain,
 
 	if (!domain ||!irq_domain_is_ipi(domain)) {
 		pr_warn("Reservation on a non IPI domain\n");
-		return 0;
+		return -EINVAL;
 	}
 
 	if (!cpumask_subset(dest, cpu_possible_mask)) {
 		pr_warn("Reservation is not in possible_cpu_mask\n");
-		return 0;
+		return -EINVAL;
 	}
 
 	nr_irqs = cpumask_weight(dest);
 	if (!nr_irqs) {
 		pr_warn("Reservation for empty destination mask\n");
-		return 0;
+		return -EINVAL;
 	}
 
 	if (irq_domain_is_ipi_single(domain)) {
@@ -72,14 +72,14 @@ unsigned int irq_reserve_ipi(struct irq_domain *domain,
 			next = cpumask_next(next, dest);
 		if (next < nr_cpu_ids) {
 			pr_warn("Destination mask has holes\n");
-			return 0;
+			return -EINVAL;
 		}
 	}
 
 	virq = irq_domain_alloc_descs(-1, nr_irqs, 0, NUMA_NO_NODE);
 	if (virq <= 0) {
 		pr_warn("Can't reserve IPI, failed to alloc descs\n");
-		return 0;
+		return -ENOMEM;
 	}
 
 	virq = __irq_domain_alloc_irqs(domain, virq, nr_irqs, NUMA_NO_NODE,
@@ -100,7 +100,7 @@ unsigned int irq_reserve_ipi(struct irq_domain *domain,
 
 free_descs:
 	irq_free_descs(virq, nr_irqs);
-	return 0;
+	return -EBUSY;
 }
 
 /**
@@ -108,10 +108,12 @@ free_descs:
  * @irq:	linux irq number to be destroyed
  * @dest:	cpumask of cpus which should have the IPI removed
  *
- * Return the IPIs allocated with irq_reserve_ipi() to the system destroying
- * all virqs associated with them.
+ * The IPIs allocated with irq_reserve_ipi() are retuerned to the system
+ * destroying all virqs associated with them.
+ *
+ * Return 0 on success or error code on failure.
  */
-void irq_destroy_ipi(unsigned int irq, const struct cpumask *dest)
+int irq_destroy_ipi(unsigned int irq, const struct cpumask *dest)
 {
 	struct irq_data *data = irq_get_irq_data(irq);
 	struct cpumask *ipimask = data ? irq_data_get_affinity_mask(data) : NULL;
@@ -119,7 +121,7 @@ void irq_destroy_ipi(unsigned int irq, const struct cpumask *dest)
 	unsigned int nr_irqs;
 
 	if (!irq || !data || !ipimask)
-		return;
+		return -EINVAL;
 
 	domain = data->domain;
 	if (WARN_ON(domain == NULL))
@@ -127,7 +129,7 @@ void irq_destroy_ipi(unsigned int irq, const struct cpumask *dest)
 
 	if (!irq_domain_is_ipi(domain)) {
 		pr_warn("Trying to destroy a non IPI domain!\n");
-		return;
+		return -EINVAL;
 	}
 
 	if (WARN_ON(!cpumask_subset(dest, ipimask)))
@@ -135,7 +137,7 @@ void irq_destroy_ipi(unsigned int irq, const struct cpumask *dest)
 		 * Must be destroying a subset of CPUs to which this IPI
 		 * was set up to target
 		 */
-		return;
+		return -EINVAL;
 
 	if (irq_domain_is_ipi_per_cpu(domain)) {
 		irq = irq + cpumask_first(dest) - data->common->ipi_offset;
@@ -145,6 +147,7 @@ void irq_destroy_ipi(unsigned int irq, const struct cpumask *dest)
 	}
 
 	irq_domain_free_irqs(irq, nr_irqs);
+	return 0;
 }
 
 /**
-- 
2.5.0
