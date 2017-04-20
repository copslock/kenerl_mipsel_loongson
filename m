Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Apr 2017 11:09:16 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:24730 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992178AbdDTJHycAm9d (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 20 Apr 2017 11:07:54 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 66E8C98EB0E89;
        Thu, 20 Apr 2017 10:07:45 +0100 (IST)
Received: from mredfearn-linux.le.imgtec.org (10.150.130.83) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 20 Apr 2017 10:07:47 +0100
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Jason Cooper <jason@lakedaemon.net>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] irqchip: mips-gic: Replace static map with dynamic
Date:   Thu, 20 Apr 2017 10:07:36 +0100
Message-ID: <1492679256-14513-4-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1492679256-14513-1-git-send-email-matt.redfearn@imgtec.com>
References: <1492679256-14513-1-git-send-email-matt.redfearn@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57739
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

Commit 4cfffcfa5106 ("irqchip/mips-gic: Fix local interrupts") fixed
local interrupts by creating virq mappings for them all at startup.
Unfortunately this change broke legacy IRQ controllers in the same
system, such as the i8259 on the Malta platform, as it allocates virq
numbers that were expected to be available for the legacy controller.

Instead of creating the mappings statically when the GIC is probed,
re-introduce the irq domain .map function, removed by commit e875bd66dfb
("irqchip/mips-gic: Fix local interrupts") and use it to set up the irq
handler and chip. Since a good deal of the required functionality is
already implemented by gic_irq_domain_alloc, repurpose that function for
gic_irq_domain_map and add a new gic_irq_domain_alloc which wraps
gic_irq_domain_map with the necessary conversion.

This change fixes the legacy interrupt controller of the Malta platform
without breaking the perf interrupt fixed by commit e875bd66dfb
("irqchip/mips-gic: Fix local interrupts").

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>

---

 drivers/irqchip/irq-mips-gic.c | 60 +++++++++++++-----------------------------
 1 file changed, 18 insertions(+), 42 deletions(-)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index eb448a1d57b4..eb7fbe159963 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -700,16 +700,12 @@ static int gic_irq_domain_xlate(struct irq_domain *d, struct device_node *ctrlr,
 	return 0;
 }
 
-static int gic_irq_domain_alloc(struct irq_domain *d, unsigned int virq,
-				unsigned int nr_irqs, void *arg)
+static int gic_irq_domain_map(struct irq_domain *d, unsigned int virq,
+			      irq_hw_number_t hwirq)
 {
-	struct irq_fwspec *fwspec = arg;
-	irq_hw_number_t hwirq;
 	int err;
 
-	if (fwspec->param[0] == GIC_SHARED) {
-		hwirq = GIC_SHARED_TO_HWIRQ(fwspec->param[1]);
-
+	if (hwirq >= GIC_SHARED_HWIRQ_BASE) {
 		/* verify that shared irqs don't conflict with an IPI irq */
 		if (test_bit(GIC_HWIRQ_TO_SHARED(hwirq), ipi_resrv))
 			return -EBUSY;
@@ -723,8 +719,6 @@ static int gic_irq_domain_alloc(struct irq_domain *d, unsigned int virq,
 		return gic_shared_irq_domain_map(d, virq, hwirq, 0);
 	}
 
-	hwirq = GIC_LOCAL_TO_HWIRQ(fwspec->param[1]);
-
 	switch (GIC_HWIRQ_TO_LOCAL(hwirq)) {
 	case GIC_LOCAL_INT_TIMER:
 	case GIC_LOCAL_INT_PERFCTR:
@@ -758,6 +752,20 @@ static int gic_irq_domain_alloc(struct irq_domain *d, unsigned int virq,
 	return gic_local_irq_domain_map(d, virq, hwirq);
 }
 
+static int gic_irq_domain_alloc(struct irq_domain *d, unsigned int virq,
+				unsigned int nr_irqs, void *arg)
+{
+	struct irq_fwspec *fwspec = arg;
+	irq_hw_number_t hwirq;
+
+	if (fwspec->param[0] == GIC_SHARED)
+		hwirq = GIC_SHARED_TO_HWIRQ(fwspec->param[1]);
+	else
+		hwirq = GIC_LOCAL_TO_HWIRQ(fwspec->param[1]);
+
+	return gic_irq_domain_map(d, virq, hwirq);
+}
+
 void gic_irq_domain_free(struct irq_domain *d, unsigned int virq,
 			 unsigned int nr_irqs)
 {
@@ -767,6 +775,7 @@ static const struct irq_domain_ops gic_irq_domain_ops = {
 	.xlate = gic_irq_domain_xlate,
 	.alloc = gic_irq_domain_alloc,
 	.free = gic_irq_domain_free,
+	.map = gic_irq_domain_map,
 };
 
 static int gic_ipi_domain_xlate(struct irq_domain *d, struct device_node *ctrlr,
@@ -872,38 +881,6 @@ static struct irq_domain_ops gic_ipi_domain_ops = {
 	.match = gic_ipi_domain_match,
 };
 
-static void __init gic_map_single_int(struct device_node *node,
-				      unsigned int irq)
-{
-	unsigned int linux_irq;
-	struct irq_fwspec local_int_fwspec = {
-		.fwnode         = &node->fwnode,
-		.param_count    = 3,
-		.param          = {
-			[0]     = GIC_LOCAL,
-			[1]     = irq,
-			[2]     = IRQ_TYPE_NONE,
-		},
-	};
-
-	if (!gic_local_irq_is_routable(irq))
-		return;
-
-	linux_irq = irq_create_fwspec_mapping(&local_int_fwspec);
-	WARN_ON(!linux_irq);
-}
-
-static void __init gic_map_interrupts(struct device_node *node)
-{
-	gic_map_single_int(node, GIC_LOCAL_INT_WD);
-	gic_map_single_int(node, GIC_LOCAL_INT_COMPARE);
-	gic_map_single_int(node, GIC_LOCAL_INT_TIMER);
-	gic_map_single_int(node, GIC_LOCAL_INT_PERFCTR);
-	gic_map_single_int(node, GIC_LOCAL_INT_SWINT0);
-	gic_map_single_int(node, GIC_LOCAL_INT_SWINT1);
-	gic_map_single_int(node, GIC_LOCAL_INT_FDC);
-}
-
 static void __init __gic_init(unsigned long gic_base_addr,
 			      unsigned long gic_addrspace_size,
 			      unsigned int cpu_vec, unsigned int irqbase,
@@ -997,7 +974,6 @@ static void __init __gic_init(unsigned long gic_base_addr,
 
 	bitmap_copy(ipi_available, ipi_resrv, GIC_MAX_INTRS);
 	gic_basic_init();
-	gic_map_interrupts(node);
 }
 
 void __init gic_init(unsigned long gic_base_addr,
-- 
2.7.4
