Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Mar 2018 11:05:44 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:54540 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991025AbeCWKFgjcUlo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Mar 2018 11:05:36 +0100
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 67DFF140A;
        Fri, 23 Mar 2018 10:05:28 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Burton <paul.burton@imgtec.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        linux-mips@linux-mips.org, Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 037/177] irqchip/mips-gic: Separate IPI reservation & usage tracking
Date:   Fri, 23 Mar 2018 10:52:45 +0100
Message-Id: <20180323094206.787496927@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
References: <20180323094205.090519271@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63165
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Burton <paul.burton@imgtec.com>


[ Upstream commit f8dcd9e81797ae24acc44c84f0eb3b9e6cee9791 ]

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

Fixes: 2af70a962070 ("irqchip/mips-gic: Add a IPI hierarchy domain")
Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
Cc: linux-mips@linux-mips.org
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Link: http://lkml.kernel.org/r/1492679256-14513-2-git-send-email-matt.redfearn@imgtec.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/irqchip/irq-mips-gic.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -55,6 +55,7 @@ static unsigned int gic_cpu_pin;
 static unsigned int timer_cpu_pin;
 static struct irq_chip gic_level_irq_controller, gic_edge_irq_controller;
 DECLARE_BITMAP(ipi_resrv, GIC_MAX_INTRS);
+DECLARE_BITMAP(ipi_available, GIC_MAX_INTRS);
 
 static void __gic_irq_dispatch(void);
 
@@ -746,17 +747,17 @@ static int gic_irq_domain_alloc(struct i
 
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
@@ -787,7 +788,7 @@ static int gic_irq_domain_alloc(struct i
 
 	return 0;
 error:
-	bitmap_set(ipi_resrv, base_hwirq, nr_irqs);
+	bitmap_set(ipi_available, base_hwirq, nr_irqs);
 	return ret;
 }
 
@@ -802,7 +803,7 @@ void gic_irq_domain_free(struct irq_doma
 		return;
 
 	base_hwirq = GIC_HWIRQ_TO_SHARED(irqd_to_hwirq(data));
-	bitmap_set(ipi_resrv, base_hwirq, nr_irqs);
+	bitmap_set(ipi_available, base_hwirq, nr_irqs);
 }
 
 int gic_irq_domain_match(struct irq_domain *d, struct device_node *node,
@@ -1066,6 +1067,7 @@ static void __init __gic_init(unsigned l
 			   2 * gic_vpes);
 	}
 
+	bitmap_copy(ipi_available, ipi_resrv, GIC_MAX_INTRS);
 	gic_basic_init();
 }
 
