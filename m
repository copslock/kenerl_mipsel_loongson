Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Apr 2017 11:08:22 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:3354 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991232AbdDTJHsm6sod (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 20 Apr 2017 11:07:48 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id A42E12AD5BDCA;
        Thu, 20 Apr 2017 10:07:39 +0100 (IST)
Received: from mredfearn-linux.le.imgtec.org (10.150.130.83) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 20 Apr 2017 10:07:42 +0100
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Jason Cooper <jason@lakedaemon.net>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] irqchip: mips-gic: Separate IPI reservation & usage tracking
Date:   Thu, 20 Apr 2017 10:07:34 +0100
Message-ID: <1492679256-14513-2-git-send-email-matt.redfearn@imgtec.com>
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
X-archive-position: 57737
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

From: Paul Burton <paul.burton@imgtec.com>

Since commit 2af70a962070 ("irqchip/mips-gic: Add a IPI hierarchy
domain") introduced the GIC IPI IRQ domain we have tracked both
reservation of interrupts & their use with a single bitmap - ipi_resrv.
If an interrupt is reserved for use as an IPI but not actually in use
then the appropriate bit is set in ipi_resrv. If an interrupt is either
not reserved for use as an IPI or has been allocated as one then the
appropriate bit is clear in ipi_resrv.

Unfortunately this means that checking whether a bit is set in ipi_resrv
to prevent IPI interrupts being allocated for use with a device is
broken, because if the interrupt has been allocated as an IPI first then
its bit will be clear.

Fix this by separating the tracking of IPI reservation & usage,
introducing a separate ipi_available bitmap for the latter. This means
that ipi_resrv will now always have bits set corresponding to all
interrupts reserved for use as IPIs, whether or not they have been
allocated yet, and therefore that checking it when allocating device
interrupts works as expected.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Fixes: 2af70a962070 ("irqchip/mips-gic: Add a IPI hierarchy domain")
Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
---

 drivers/irqchip/irq-mips-gic.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index cd20df12d63d..db058e10df00 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -55,6 +55,7 @@ static unsigned int gic_cpu_pin;
 static unsigned int timer_cpu_pin;
 static struct irq_chip gic_level_irq_controller, gic_edge_irq_controller;
 DECLARE_BITMAP(ipi_resrv, GIC_MAX_INTRS);
+DECLARE_BITMAP(ipi_available, GIC_MAX_INTRS);
 
 static void __gic_irq_dispatch(void);
 
@@ -746,17 +747,17 @@ static int gic_irq_domain_alloc(struct irq_domain *d, unsigned int virq,
 
 		return gic_setup_dev_chip(d, virq, spec->hwirq);
 	} else {
-		base_hwirq = find_first_bit(ipi_resrv, gic_shared_intrs);
+		base_hwirq = find_first_bit(ipi_available, gic_shared_intrs);
 		if (base_hwirq == gic_shared_intrs) {
 			return -ENOMEM;
 		}
 
 		/* check that we have enough space */
 		for (i = base_hwirq; i < nr_irqs; i++) {
-			if (!test_bit(i, ipi_resrv))
+			if (!test_bit(i, ipi_available))
 				return -EBUSY;
 		}
-		bitmap_clear(ipi_resrv, base_hwirq, nr_irqs);
+		bitmap_clear(ipi_available, base_hwirq, nr_irqs);
 
 		/* map the hwirq for each cpu consecutively */
 		i = 0;
@@ -787,7 +788,7 @@ static int gic_irq_domain_alloc(struct irq_domain *d, unsigned int virq,
 
 	return 0;
 error:
-	bitmap_set(ipi_resrv, base_hwirq, nr_irqs);
+	bitmap_set(ipi_available, base_hwirq, nr_irqs);
 	return ret;
 }
 
@@ -802,7 +803,7 @@ void gic_irq_domain_free(struct irq_domain *d, unsigned int virq,
 		return;
 
 	base_hwirq = GIC_HWIRQ_TO_SHARED(irqd_to_hwirq(data));
-	bitmap_set(ipi_resrv, base_hwirq, nr_irqs);
+	bitmap_set(ipi_available, base_hwirq, nr_irqs);
 }
 
 int gic_irq_domain_match(struct irq_domain *d, struct device_node *node,
@@ -1098,6 +1099,7 @@ static void __init __gic_init(unsigned long gic_base_addr,
 			   2 * gic_vpes);
 	}
 
+	bitmap_copy(ipi_available, ipi_resrv, GIC_MAX_INTRS);
 	gic_basic_init();
 	gic_map_interrupts(node);
 }
-- 
2.7.4
