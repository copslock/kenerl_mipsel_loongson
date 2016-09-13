Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Sep 2016 18:55:15 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:8238 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991894AbcIMQzI2E7Be (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Sep 2016 18:55:08 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 4A7FAEE2F21BB;
        Tue, 13 Sep 2016 17:54:48 +0100 (IST)
Received: from localhost (10.100.200.124) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 13 Sep
 2016 17:54:52 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] irqchip: mips-gic: Use for_each_set_bit to iterate over local IRQs
Date:   Tue, 13 Sep 2016 17:54:27 +0100
Message-ID: <20160913165427.31686-1-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.9.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.124]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55130
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

The MIPS GIC driver has previously iterated over bits set in a bitmap
representing pending local IRQs by calling find_first_bit, clearing that
bit then calling find_first_bit again until all bits are clear. If
multiple interrupts are pending then this is wasteful, as find_first_bit
will have to loop over the whole bitmap from the start. Use the
for_each_set_bit macro which performs exactly what we need here instead.
It will use find_next_bit and thus only scan over the relevant part of
the bitmap, and it makes the intent of the code clearer.

This makes the same change for local interrupts that commit cae750bae4e4
("irqchip: mips-gic: Use for_each_set_bit to iterate over IRQs") made
for shared interrupts.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mips@linux-mips.org
---
Please feel free to fold this into cae750bae4e4 ("irqchip: mips-gic: Use
for_each_set_bit to iterate over IRQs") if you prefer.
---
 drivers/irqchip/irq-mips-gic.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index 61856964..8f7d38b 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -518,18 +518,13 @@ static void gic_handle_local_int(bool chained)
 
 	bitmap_and(&pending, &pending, &masked, GIC_NUM_LOCAL_INTRS);
 
-	intr = find_first_bit(&pending, GIC_NUM_LOCAL_INTRS);
-	while (intr != GIC_NUM_LOCAL_INTRS) {
+	for_each_set_bit(intr, &pending, GIC_NUM_LOCAL_INTRS) {
 		virq = irq_linear_revmap(gic_irq_domain,
 					 GIC_LOCAL_TO_HWIRQ(intr));
 		if (chained)
 			generic_handle_irq(virq);
 		else
 			do_IRQ(virq);
-
-		/* go to next pending bit */
-		bitmap_clear(&pending, intr, 1);
-		intr = find_first_bit(&pending, GIC_NUM_LOCAL_INTRS);
 	}
 }
 
-- 
2.9.3
