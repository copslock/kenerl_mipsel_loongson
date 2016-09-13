Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Sep 2016 18:54:24 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:1126 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992186AbcIMQyQf383e (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Sep 2016 18:54:16 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 82192569CB499;
        Tue, 13 Sep 2016 17:53:55 +0100 (IST)
Received: from localhost (10.100.200.124) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 13 Sep
 2016 17:53:59 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        "stable # v4 . 6+" <stable@vger.kernel.org>,
        Qais Yousef <qsyousef@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] irqchip: mips-gic: Fix local interrupts
Date:   Tue, 13 Sep 2016 17:53:35 +0100
Message-ID: <20160913165335.31389-1-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.9.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.124]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55129
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

Since the device hierarchy domain was added by commit c98c1822ee13
("irqchip/mips-gic: Add device hierarchy domain"), GIC local interrupts
have been broken.

Users attempting to setup a per-cpu local IRQ, for example the GIC timer
clock events code in drivers/clocksource/mips-gic-timer.c, the
setup_percpu_irq function would refuse with -EINVAL because the GIC
irqchip driver never called irq_set_percpu_devid so the
IRQ_PER_CPU_DEVID flag was never set for the IRQ. This happens because
irq_set_percpu_devid was being called from the gic_irq_domain_map
function which is no longer called.

Doing only that runs into further problems because gic_dev_domain_alloc
set the struct irq_chip for all interrupts, local or shared, to
gic_level_irq_controller despite that only being suitable for shared
interrupts. The typical outcome of this is that gic_level_irq_controller
callback functions are called for local interrupts, and then hwirq
number calculations overflow & the driver ends up attempting to access
some invalid register with an address calculated from an invalid hwirq
number. Best case scenario is that this then leads to a bus error. This
is fixed by abstracting the setup of the hwirq & chip to a new function
gic_setup_dev_chip which is used by both the root GIC IRQ domain & the
device domain.

Finally, decoding local interrupts failed because gic_dev_domain_alloc
only called irq_domain_alloc_irqs_parent for shared interrupts. Local
ones were therefore never associated with hwirqs in the root GIC IRQ
domain and the virq in gic_handle_local_int would always be 0. This is
fixed by calling irq_domain_alloc_irqs_parent unconditionally & having
gic_irq_domain_alloc handle both local & shared interrupts, which is
easy due to the aforementioned abstraction of chip setup into
gic_setup_dev_chip.

This fixes use of the MIPS GIC timer for clock events, which has been
broken since c98c1822ee13 ("irqchip/mips-gic: Add device hierarchy
domain") but hadn't been noticed due to a silent fallback to the MIPS
coprocessor 0 count/compare clock events device.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Fixes: c98c1822ee13 ("irqchip/mips-gic: Add device hierarchy domain")
Cc: stable <stable@vger.kernel.org> # v4.6+
Cc: Qais Yousef <qsyousef@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mips@linux-mips.org
---
 drivers/irqchip/irq-mips-gic.c | 105 ++++++++++++++++++++---------------------
 1 file changed, 50 insertions(+), 55 deletions(-)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index 83f4983..61856964 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -638,27 +638,6 @@ static int gic_local_irq_domain_map(struct irq_domain *d, unsigned int virq,
 	if (!gic_local_irq_is_routable(intr))
 		return -EPERM;
 
-	/*
-	 * HACK: These are all really percpu interrupts, but the rest
-	 * of the MIPS kernel code does not use the percpu IRQ API for
-	 * the CP0 timer and performance counter interrupts.
-	 */
-	switch (intr) {
-	case GIC_LOCAL_INT_TIMER:
-	case GIC_LOCAL_INT_PERFCTR:
-	case GIC_LOCAL_INT_FDC:
-		irq_set_chip_and_handler(virq,
-					 &gic_all_vpes_local_irq_controller,
-					 handle_percpu_irq);
-		break;
-	default:
-		irq_set_chip_and_handler(virq,
-					 &gic_local_irq_controller,
-					 handle_percpu_devid_irq);
-		irq_set_percpu_devid(virq);
-		break;
-	}
-
 	spin_lock_irqsave(&gic_lock, flags);
 	for (i = 0; i < gic_vpes; i++) {
 		u32 val = GIC_MAP_TO_PIN_MSK | gic_cpu_pin;
@@ -724,16 +703,42 @@ static int gic_shared_irq_domain_map(struct irq_domain *d, unsigned int virq,
 	return 0;
 }
 
-static int gic_irq_domain_map(struct irq_domain *d, unsigned int virq,
-			      irq_hw_number_t hw)
+static int gic_setup_dev_chip(struct irq_domain *d, unsigned int virq,
+			      unsigned int hwirq)
 {
-	if (GIC_HWIRQ_TO_LOCAL(hw) < GIC_NUM_LOCAL_INTRS)
-		return gic_local_irq_domain_map(d, virq, hw);
+	struct irq_chip *chip;
+	int err;
 
-	irq_set_chip_and_handler(virq, &gic_level_irq_controller,
-				 handle_level_irq);
+	if (hwirq >= GIC_SHARED_HWIRQ_BASE) {
+		err = irq_domain_set_hwirq_and_chip(d, virq, hwirq,
+						    &gic_level_irq_controller,
+						    NULL);
+	} else {
+		switch (GIC_HWIRQ_TO_LOCAL(hwirq)) {
+		case GIC_LOCAL_INT_TIMER:
+		case GIC_LOCAL_INT_PERFCTR:
+		case GIC_LOCAL_INT_FDC:
+			/*
+			 * HACK: These are all really percpu interrupts, but
+			 * the rest of the MIPS kernel code does not use the
+			 * percpu IRQ API for them.
+			 */
+			chip = &gic_all_vpes_local_irq_controller;
+			irq_set_handler(virq, handle_percpu_irq);
+			break;
 
-	return gic_shared_irq_domain_map(d, virq, hw, 0);
+		default:
+			chip = &gic_local_irq_controller;
+			irq_set_handler(virq, handle_percpu_devid_irq);
+			irq_set_percpu_devid(virq);
+			break;
+		}
+
+		err = irq_domain_set_hwirq_and_chip(d, virq, hwirq,
+						    chip, NULL);
+	}
+
+	return err;
 }
 
 static int gic_irq_domain_alloc(struct irq_domain *d, unsigned int virq,
@@ -744,15 +749,12 @@ static int gic_irq_domain_alloc(struct irq_domain *d, unsigned int virq,
 	int cpu, ret, i;
 
 	if (spec->type == GIC_DEVICE) {
-		/* verify that it doesn't conflict with an IPI irq */
-		if (test_bit(spec->hwirq, ipi_resrv))
+		/* verify that shared irqs don't conflict with an IPI irq */
+		if ((spec->hwirq >= GIC_SHARED_HWIRQ_BASE) &&
+		    test_bit(GIC_HWIRQ_TO_SHARED(spec->hwirq), ipi_resrv))
 			return -EBUSY;
 
-		hwirq = GIC_SHARED_TO_HWIRQ(spec->hwirq);
-
-		return irq_domain_set_hwirq_and_chip(d, virq, hwirq,
-						     &gic_level_irq_controller,
-						     NULL);
+		return gic_setup_dev_chip(d, virq, spec->hwirq);
 	} else {
 		base_hwirq = find_first_bit(ipi_resrv, gic_shared_intrs);
 		if (base_hwirq == gic_shared_intrs) {
@@ -821,7 +823,6 @@ int gic_irq_domain_match(struct irq_domain *d, struct device_node *node,
 }
 
 static const struct irq_domain_ops gic_irq_domain_ops = {
-	.map = gic_irq_domain_map,
 	.alloc = gic_irq_domain_alloc,
 	.free = gic_irq_domain_free,
 	.match = gic_irq_domain_match,
@@ -852,29 +853,20 @@ static int gic_dev_domain_alloc(struct irq_domain *d, unsigned int virq,
 	struct irq_fwspec *fwspec = arg;
 	struct gic_irq_spec spec = {
 		.type = GIC_DEVICE,
-		.hwirq = fwspec->param[1],
 	};
 	int i, ret;
-	bool is_shared = fwspec->param[0] == GIC_SHARED;
 
-	if (is_shared) {
-		ret = irq_domain_alloc_irqs_parent(d, virq, nr_irqs, &spec);
-		if (ret)
-			return ret;
-	}
+	if (fwspec->param[0] == GIC_SHARED)
+		spec.hwirq = GIC_SHARED_TO_HWIRQ(fwspec->param[1]);
+	else
+		spec.hwirq = GIC_LOCAL_TO_HWIRQ(fwspec->param[1]);
+
+	ret = irq_domain_alloc_irqs_parent(d, virq, nr_irqs, &spec);
+	if (ret)
+		return ret;
 
 	for (i = 0; i < nr_irqs; i++) {
-		irq_hw_number_t hwirq;
-
-		if (is_shared)
-			hwirq = GIC_SHARED_TO_HWIRQ(spec.hwirq + i);
-		else
-			hwirq = GIC_LOCAL_TO_HWIRQ(spec.hwirq + i);
-
-		ret = irq_domain_set_hwirq_and_chip(d, virq + i,
-						    hwirq,
-						    &gic_level_irq_controller,
-						    NULL);
+		ret = gic_setup_dev_chip(d, virq + i, spec.hwirq + i);
 		if (ret)
 			goto error;
 	}
@@ -896,7 +888,10 @@ void gic_dev_domain_free(struct irq_domain *d, unsigned int virq,
 static void gic_dev_domain_activate(struct irq_domain *domain,
 				    struct irq_data *d)
 {
-	gic_shared_irq_domain_map(domain, d->irq, d->hwirq, 0);
+	if (GIC_HWIRQ_TO_LOCAL(d->hwirq) < GIC_NUM_LOCAL_INTRS)
+		gic_local_irq_domain_map(domain, d->irq, d->hwirq);
+	else
+		gic_shared_irq_domain_map(domain, d->irq, d->hwirq, 0);
 }
 
 static struct irq_domain_ops gic_dev_domain_ops = {
-- 
2.9.3
