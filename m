Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Apr 2016 12:32:24 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:4467 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27026215AbcDUKcWXfYyV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 21 Apr 2016 12:32:22 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email with ESMTPS id 0A2E0B9F3DD6B;
        Thu, 21 Apr 2016 11:32:10 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Thu, 21 Apr 2016 11:32:16 +0100
Received: from localhost (10.100.200.79) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Thu, 21 Apr
 2016 11:32:15 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        "Marc Zyngier" <marc.zyngier@arm.com>
CC:     Paul Burton <paul.burton@imgtec.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] irqchip/mips-gic: Don't overrun pcpu_masks array
Date:   Thu, 21 Apr 2016 11:31:54 +0100
Message-ID: <1461234714-9975-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.8.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.79]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53143
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

Commit 2a0787051182 ("irqchip/mips-gic: Use gic_vpes instead of
NR_CPUS") & commit 78930f09b940 ("irqchip/mips-gic: Clear percpu_masks
correctly when mapping") both introduce code which accesses gic_vpes
entries in the pcpu_masks array. However, this array has length NR_CPUS.
If NR_CPUS is less than gic_vpes (ie. the kernel supports use of less
CPUs than are present in the system) then we overrun the array, clobber
some other data & generally die pretty promptly.

Most notably this affects uniprocessor kernels running on any multicore
or multithreaded Malta with a GIC (ie. the vast majority of real Malta
boards).

Fix this by only accessing up to min(gic_vpes, NR_CPUS) entries in the
pcpu_masks array, preventing the array overrun.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Fixes: 2a0787051182 ("irqchip/mips-gic: Use gic_vpes instead of NR_CPUS")
Fixes: 78930f09b940 ("irqchip/mips-gic: Clear percpu_masks correctly when mapping")

---

 drivers/irqchip/irq-mips-gic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index 94a30da..4dffccf 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -467,7 +467,7 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *cpumask,
 	gic_map_to_vpe(irq, mips_cm_vp_id(cpumask_first(&tmp)));
 
 	/* Update the pcpu_masks */
-	for (i = 0; i < gic_vpes; i++)
+	for (i = 0; i < min(gic_vpes, NR_CPUS); i++)
 		clear_bit(irq, pcpu_masks[i].pcpu_mask);
 	set_bit(irq, pcpu_masks[cpumask_first(&tmp)].pcpu_mask);
 
@@ -707,7 +707,7 @@ static int gic_shared_irq_domain_map(struct irq_domain *d, unsigned int virq,
 	spin_lock_irqsave(&gic_lock, flags);
 	gic_map_to_pin(intr, gic_cpu_pin);
 	gic_map_to_vpe(intr, vpe);
-	for (i = 0; i < gic_vpes; i++)
+	for (i = 0; i < min(gic_vpes, NR_CPUS); i++)
 		clear_bit(intr, pcpu_masks[i].pcpu_mask);
 	set_bit(intr, pcpu_masks[vpe].pcpu_mask);
 	spin_unlock_irqrestore(&gic_lock, flags);
-- 
2.8.0
