Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Aug 2016 19:07:52 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:61665 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992466AbcHSRHp11ttr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Aug 2016 19:07:45 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 27FDAFEB910C6;
        Fri, 19 Aug 2016 18:07:25 +0100 (IST)
Received: from localhost (10.100.200.126) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 19 Aug
 2016 18:07:28 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-mips@linux-mips.org>, <stable@vger.kernel.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 1/2] irqchip: mips-gic: Cleanup chip & handler setup
Date:   Fri, 19 Aug 2016 18:07:14 +0100
Message-ID: <20160819170715.27820-1-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.9.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.126]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54689
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

gic_shared_irq_domain_map() is called from gic_irq_domain_alloc() where
the wrong chip has been set, and is then overwritten. Tidy this up by
setting the correct chip the first time, and setting the
handle_level_irq handler from gic_irq_domain_alloc() too.

gic_shared_irq_domain_map() is also called from gic_irq_domain_map(),
which now calls irq_set_chip_and_handler() to retain its previous
behaviour.

This patch also prepares for a follow-on which will call
gic_shared_irq_domain_map() from a callback where the lock on the struct
irq_desc is held, which without this change would cause the call to
irq_set_chip_and_handler() to lead to a deadlock.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Fixes: c98c1822ee13 ("irqchip/mips-gic: Add device hierarchy domain")
Cc: stable@vger.kernel.org # v4.6+
---
Marked with the Fixes: tag as it's a prerequisite for the following bug fix
patch. Feel free to drop the tag if it's considered clearer without.
---
 drivers/irqchip/irq-mips-gic.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index 70ed1d0..d7ec984 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -713,9 +713,6 @@ static int gic_shared_irq_domain_map(struct irq_domain *d, unsigned int virq,
 	unsigned long flags;
 	int i;
 
-	irq_set_chip_and_handler(virq, &gic_level_irq_controller,
-				 handle_level_irq);
-
 	spin_lock_irqsave(&gic_lock, flags);
 	gic_map_to_pin(intr, gic_cpu_pin);
 	gic_map_to_vpe(intr, mips_cm_vp_id(vpe));
@@ -732,6 +729,10 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int virq,
 {
 	if (GIC_HWIRQ_TO_LOCAL(hw) < GIC_NUM_LOCAL_INTRS)
 		return gic_local_irq_domain_map(d, virq, hw);
+
+	irq_set_chip_and_handler(virq, &gic_level_irq_controller,
+				 handle_level_irq);
+
 	return gic_shared_irq_domain_map(d, virq, hw, 0);
 }
 
@@ -771,11 +772,13 @@ static int gic_irq_domain_alloc(struct irq_domain *d, unsigned int virq,
 			hwirq = GIC_SHARED_TO_HWIRQ(base_hwirq + i);
 
 			ret = irq_domain_set_hwirq_and_chip(d, virq + i, hwirq,
-							    &gic_edge_irq_controller,
+							    &gic_level_irq_controller,
 							    NULL);
 			if (ret)
 				goto error;
 
+			irq_set_handler(virq + i, handle_level_irq);
+
 			ret = gic_shared_irq_domain_map(d, virq + i, hwirq, cpu);
 			if (ret)
 				goto error;
-- 
2.9.3
