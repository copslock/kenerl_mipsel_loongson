Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Sep 2017 20:29:35 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:27255 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991067AbdIES3WScFVI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 5 Sep 2017 20:29:22 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 9F4F14E304460;
        Tue,  5 Sep 2017 19:29:11 +0100 (IST)
Received: from localhost (10.20.1.88) by hhmail02.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 5 Sep 2017 19:29:15
 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH] irqchip: mips-gic: Fix shared interrupt mask writes
Date:   Tue, 5 Sep 2017 11:28:46 -0700
Message-ID: <20170905182846.27994-1-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.1.88]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59938
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

The write_gic_smask() & write_gic_rmask() functions take a shared
interrupt number as a parameter, but we're incorrectly providing them a
bitmask with the shared interrupt's bit set. This effectively means that
we mask or unmask the shared interrupt 1<<n rather than shared interrupt
n, and as a result likely drop interrupts.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Fixes: 68898c8765f4 ("irqchip: mips-gic: Drop gic_(re)set_mask() functions")
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mips@linux-mips.org
---
With Boston PCIe support & the GIC cleanup series now coming together in
-next, this bug was uncovered by running next-20170905 on a Boston
board, which failed to find any rootfs media due to a lack of PCIe
interrupts. With this fix we're now able to use the Boston's SATA or MMC
controllers :)

Ideally this would be applied as a fixup to 68898c8765f4 ("irqchip:
mips-gic: Drop gic_(re)set_mask() functions"), but even if not it'd be
great to get into the v4.14 MIPS pull where the breakage is introduced,
or otherwise just ASAP - my apologies!
---
 drivers/irqchip/irq-mips-gic.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index 6e52a88bbd9e..40159ac12ac8 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -169,7 +169,7 @@ static void gic_mask_irq(struct irq_data *d)
 {
 	unsigned int intr = GIC_HWIRQ_TO_SHARED(d->hwirq);
 
-	write_gic_rmask(BIT(intr));
+	write_gic_rmask(intr);
 	gic_clear_pcpu_masks(intr);
 }
 
@@ -179,7 +179,7 @@ static void gic_unmask_irq(struct irq_data *d)
 	unsigned int intr = GIC_HWIRQ_TO_SHARED(d->hwirq);
 	unsigned int cpu;
 
-	write_gic_smask(BIT(intr));
+	write_gic_smask(intr);
 
 	gic_clear_pcpu_masks(intr);
 	cpu = cpumask_first_and(affinity, cpu_online_mask);
@@ -767,7 +767,7 @@ static int __init gic_of_init(struct device_node *node,
 	for (i = 0; i < gic_shared_intrs; i++) {
 		change_gic_pol(i, GIC_POL_ACTIVE_HIGH);
 		change_gic_trig(i, GIC_TRIG_LEVEL);
-		write_gic_rmask(BIT(i));
+		write_gic_rmask(i);
 	}
 
 	for (i = 0; i < gic_vpes; i++) {
-- 
2.14.1
