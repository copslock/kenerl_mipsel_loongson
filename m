Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Feb 2016 11:04:46 +0100 (CET)
Received: from torg.zytor.com ([198.137.202.12]:44404 "EHLO terminus.zytor.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27010007AbcBYKEoCcmQm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 25 Feb 2016 11:04:44 +0100
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTP id u1PA4HXT002867;
        Thu, 25 Feb 2016 02:04:22 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.14.8/Submit) id u1PA4GpB002864;
        Thu, 25 Feb 2016 02:04:16 -0800
Date:   Thu, 25 Feb 2016 02:04:16 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Qais Yousef <tipbot@zytor.com>
Message-ID: <tip-c98c1822ee13e4501bf48a9e3184fb9a84c149c0@git.kernel.org>
Cc:     marc.zyngier@arm.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, mingo@kernel.org, jason@lakedaemon.net,
        qsyousef@gmail.com, qais.yousef@imgtec.com,
        jiang.liu@linux.intel.com, hpa@zytor.com,
        linux-mips@linux-mips.org, lisa.parratt@imgtec.com,
        ralf@linux-mips.org
Reply-To: jason@lakedaemon.net, qsyousef@gmail.com, marc.zyngier@arm.com,
          linux-kernel@vger.kernel.org, mingo@kernel.org,
          tglx@linutronix.de, lisa.parratt@imgtec.com, ralf@linux-mips.org,
          qais.yousef@imgtec.com, jiang.liu@linux.intel.com, hpa@zytor.com,
          linux-mips@linux-mips.org
In-Reply-To: <1449580830-23652-14-git-send-email-qais.yousef@imgtec.com>
References: <1449580830-23652-14-git-send-email-qais.yousef@imgtec.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] irqchip/mips-gic: Add device hierarchy domain
Git-Commit-ID: c98c1822ee13e4501bf48a9e3184fb9a84c149c0
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
X-archive-position: 52248
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

Commit-ID:  c98c1822ee13e4501bf48a9e3184fb9a84c149c0
Gitweb:     http://git.kernel.org/tip/c98c1822ee13e4501bf48a9e3184fb9a84c149c0
Author:     Qais Yousef <qais.yousef@imgtec.com>
AuthorDate: Tue, 8 Dec 2015 13:20:24 +0000
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 25 Feb 2016 10:56:57 +0100

irqchip/mips-gic: Add device hierarchy domain

Now the root gic_irq_domain is split into device and IPI domains.

This form provides a better representation of how the root domain is split into
2. One for devices and one for IPIs.

Signed-off-by: Qais Yousef <qais.yousef@imgtec.com>
Acked-by: Ralf Baechle <ralf@linux-mips.org>
Cc: <jason@lakedaemon.net>
Cc: <marc.zyngier@arm.com>
Cc: <jiang.liu@linux.intel.com>
Cc: <linux-mips@linux-mips.org>
Cc: <lisa.parratt@imgtec.com>
Cc: Qais Yousef <qsyousef@gmail.com>
Link: http://lkml.kernel.org/r/1449580830-23652-14-git-send-email-qais.yousef@imgtec.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/irqchip/irq-mips-gic.c | 103 +++++++++++++++++++++++++++++++++--------
 1 file changed, 83 insertions(+), 20 deletions(-)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index 99f01ca..794fc59 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -47,6 +47,7 @@ static void __iomem *gic_base;
 static struct gic_pcpu_mask pcpu_masks[NR_CPUS];
 static DEFINE_SPINLOCK(gic_lock);
 static struct irq_domain *gic_irq_domain;
+static struct irq_domain *gic_dev_domain;
 static struct irq_domain *gic_ipi_domain;
 static int gic_shared_intrs;
 static int gic_vpes;
@@ -793,25 +794,6 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int virq,
 	return gic_shared_irq_domain_map(d, virq, hw, 0);
 }
 
-static int gic_irq_domain_xlate(struct irq_domain *d, struct device_node *ctrlr,
-				const u32 *intspec, unsigned int intsize,
-				irq_hw_number_t *out_hwirq,
-				unsigned int *out_type)
-{
-	if (intsize != 3)
-		return -EINVAL;
-
-	if (intspec[0] == GIC_SHARED)
-		*out_hwirq = GIC_SHARED_TO_HWIRQ(intspec[1]);
-	else if (intspec[0] == GIC_LOCAL)
-		*out_hwirq = GIC_LOCAL_TO_HWIRQ(intspec[1]);
-	else
-		return -EINVAL;
-	*out_type = intspec[2] & IRQ_TYPE_SENSE_MASK;
-
-	return 0;
-}
-
 static int gic_irq_domain_alloc(struct irq_domain *d, unsigned int virq,
 				unsigned int nr_irqs, void *arg)
 {
@@ -881,11 +863,86 @@ void gic_irq_domain_free(struct irq_domain *d, unsigned int virq,
 	bitmap_set(ipi_resrv, base_hwirq, nr_irqs);
 }
 
+int gic_irq_domain_match(struct irq_domain *d, struct device_node *node,
+			 enum irq_domain_bus_token bus_token)
+{
+	/* this domain should'nt be accessed directly */
+	return 0;
+}
+
 static const struct irq_domain_ops gic_irq_domain_ops = {
 	.map = gic_irq_domain_map,
-	.xlate = gic_irq_domain_xlate,
 	.alloc = gic_irq_domain_alloc,
 	.free = gic_irq_domain_free,
+	.match = gic_irq_domain_match,
+};
+
+static int gic_dev_domain_xlate(struct irq_domain *d, struct device_node *ctrlr,
+				const u32 *intspec, unsigned int intsize,
+				irq_hw_number_t *out_hwirq,
+				unsigned int *out_type)
+{
+	if (intsize != 3)
+		return -EINVAL;
+
+	if (intspec[0] == GIC_SHARED)
+		*out_hwirq = GIC_SHARED_TO_HWIRQ(intspec[1]);
+	else if (intspec[0] == GIC_LOCAL)
+		*out_hwirq = GIC_LOCAL_TO_HWIRQ(intspec[1]);
+	else
+		return -EINVAL;
+	*out_type = intspec[2] & IRQ_TYPE_SENSE_MASK;
+
+	return 0;
+}
+
+static int gic_dev_domain_alloc(struct irq_domain *d, unsigned int virq,
+				unsigned int nr_irqs, void *arg)
+{
+	struct irq_fwspec *fwspec = arg;
+	struct gic_irq_spec spec = {
+		.type = GIC_DEVICE,
+		.hwirq = fwspec->param[1],
+	};
+	int i, ret;
+	bool is_shared = fwspec->param[0] == GIC_SHARED;
+
+	if (is_shared) {
+		ret = irq_domain_alloc_irqs_parent(d, virq, nr_irqs, &spec);
+		if (ret)
+			return ret;
+	}
+
+	for (i = 0; i < nr_irqs; i++) {
+		irq_hw_number_t hwirq;
+
+		if (is_shared)
+			hwirq = GIC_SHARED_TO_HWIRQ(spec.hwirq + i);
+		else
+			hwirq = GIC_LOCAL_TO_HWIRQ(spec.hwirq + i);
+
+		ret = irq_domain_set_hwirq_and_chip(d, virq + i,
+						    hwirq,
+						    &gic_level_irq_controller,
+						    NULL);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+void gic_dev_domain_free(struct irq_domain *d, unsigned int virq,
+			 unsigned int nr_irqs)
+{
+	/* no real allocation is done for dev irqs, so no need to free anything */
+	return;
+}
+
+static struct irq_domain_ops gic_dev_domain_ops = {
+	.xlate = gic_dev_domain_xlate,
+	.alloc = gic_dev_domain_alloc,
+	.free = gic_dev_domain_free,
 };
 
 static int gic_ipi_domain_xlate(struct irq_domain *d, struct device_node *ctrlr,
@@ -1026,6 +1083,12 @@ static void __init __gic_init(unsigned long gic_base_addr,
 	if (!gic_irq_domain)
 		panic("Failed to add GIC IRQ domain");
 
+	gic_dev_domain = irq_domain_add_hierarchy(gic_irq_domain, 0,
+						  GIC_NUM_LOCAL_INTRS + gic_shared_intrs,
+						  node, &gic_dev_domain_ops, NULL);
+	if (!gic_dev_domain)
+		panic("Failed to add GIC DEV domain");
+
 	gic_ipi_domain = irq_domain_add_hierarchy(gic_irq_domain,
 						  IRQ_DOMAIN_FLAG_IPI_PER_CPU,
 						  GIC_NUM_LOCAL_INTRS + gic_shared_intrs,
