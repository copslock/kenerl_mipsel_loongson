Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Apr 2016 17:27:04 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:38906 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27027290AbcDVP1DG6Xmy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Apr 2016 17:27:03 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email with ESMTPS id 83BEBCD94285E;
        Fri, 22 Apr 2016 16:26:53 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Fri, 22 Apr 2016 16:26:56 +0100
Received: from mredfearn-linux.kl.imgtec.org (192.168.154.116) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Fri, 22 Apr 2016 16:26:56 +0100
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     <lisa.parratt@imgtec.com>, <jason@lakedaemon.net>,
        <ralf@linux-mips.org>, <linux-kernel@vger.kernel.org>,
        <jiang.liu@linux.intel.com>, <marc.zyngier@arm.com>,
        <linux-mips@linux-mips.org>, Qais Yousef <qsyousef@gmail.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>
Subject: [PATCH 1/2] genirq: Make irq_destroy_ipi take a cpumask of IPIs to destroy
Date:   Fri, 22 Apr 2016 16:26:48 +0100
Message-ID: <1461338809-10590-1-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.5.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.116]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53205
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

Previously irq_destroy_ipi() would destroy IPIs to all CPUs that were
configured by irq_reserve_ipi(). This change makes it possible to
destroy just a subset of the IPIs. This may be useful to remove IPIs to
CPUs that have been hot removed so that the IRQ numbers allocated within
the IPI domain can be re-used.

The original behaviour is restored by passing the complete mask that the
IPI was created with.

There are currently no users of this function that would break from the
API change.

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
---

 include/linux/irqdomain.h |  2 +-
 kernel/irq/ipi.c          | 18 ++++++++++++++----
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 2aed04396210..e1b81d35e7a3 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -348,7 +348,7 @@ int irq_domain_xlate_onetwocell(struct irq_domain *d, struct device_node *ctrlr,
 /* IPI functions */
 unsigned int irq_reserve_ipi(struct irq_domain *domain,
 			     const struct cpumask *dest);
-void irq_destroy_ipi(unsigned int irq);
+void irq_destroy_ipi(unsigned int irq, const struct cpumask *dest);
 
 /* V2 interfaces to support hierarchy IRQ domains. */
 extern struct irq_data *irq_domain_get_irq_data(struct irq_domain *domain,
diff --git a/kernel/irq/ipi.c b/kernel/irq/ipi.c
index 14777af8e097..bedc995ae214 100644
--- a/kernel/irq/ipi.c
+++ b/kernel/irq/ipi.c
@@ -106,11 +106,12 @@ free_descs:
 /**
  * irq_destroy_ipi() - unreserve an IPI that was previously allocated
  * @irq:	linux irq number to be destroyed
+ * @dest:	cpumask of cpus which should have the IPI removed
  *
  * Return the IPIs allocated with irq_reserve_ipi() to the system destroying
  * all virqs associated with them.
  */
-void irq_destroy_ipi(unsigned int irq)
+void irq_destroy_ipi(unsigned int irq, const struct cpumask *dest)
 {
 	struct irq_data *data = irq_get_irq_data(irq);
 	struct cpumask *ipimask = data ? irq_data_get_affinity_mask(data) : NULL;
@@ -129,10 +130,19 @@ void irq_destroy_ipi(unsigned int irq)
 		return;
 	}
 
-	if (irq_domain_is_ipi_per_cpu(domain))
-		nr_irqs = cpumask_weight(ipimask);
-	else
+	if (WARN_ON(!cpumask_subset(dest, ipimask)))
+		/*
+		 * Must be destroying a subset of CPUs to which this IPI
+		 * was set up to target
+		 */
+		return;
+
+	if (irq_domain_is_ipi_per_cpu(domain)) {
+		irq = irq + cpumask_first(dest) - data->common->ipi_offset;
+		nr_irqs = cpumask_weight(dest);
+	} else {
 		nr_irqs = 1;
+	}
 
 	irq_domain_free_irqs(irq, nr_irqs);
 }
-- 
2.5.0
