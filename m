Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Aug 2017 23:05:12 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:38693 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994932AbdHRVFFX0v0H (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Aug 2017 23:05:05 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id B3425C7B3C259;
        Fri, 18 Aug 2017 22:04:54 +0100 (IST)
Received: from localhost (10.20.1.88) by hhmail02.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 18 Aug 2017 22:04:58
 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: [PATCH v2 37/38] irqchip: mips-gic: Use cpumask_first_and() in gic_set_affinity()
Date:   Fri, 18 Aug 2017 14:04:35 -0700
Message-ID: <20170818210435.2271-1-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20170813043646.25821-38-paul.burton@imgtec.com>
References: <20170813043646.25821-38-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.1.88]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59690
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

Currently in gic_set_affinity() we calculate a temporary cpumask holding
the intersection of the provided cpumask & the CPUs that are online,
then we call cpumask_first twice on it to find the first such CPU. Since
we don't need the temporary cpumask for anything else & we only care
about the first CPU that's both online & in the provided cpumask, we can
instead use cpumask_first_and to find that CPU & drop the temporary
mask.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mips@linux-mips.org

---

Changes in v2:
- Rebase atop changes to patch 35 "irqchip: mips-gic: Use pcpu_masks to
  avoid reading GIC_SH_MASK*".
- Fixup typo in commit message (s/to/the/).

 drivers/irqchip/irq-mips-gic.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index 183c225b84de..8f64ac824d20 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -250,23 +250,23 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *cpumask,
 			    bool force)
 {
 	unsigned int irq = GIC_HWIRQ_TO_SHARED(d->hwirq);
-	cpumask_t	tmp = CPU_MASK_NONE;
-	unsigned long	flags;
+	unsigned long flags;
+	unsigned int cpu;
 
-	cpumask_and(&tmp, cpumask, cpu_online_mask);
-	if (cpumask_empty(&tmp))
+	cpu = cpumask_first_and(cpumask, cpu_online_mask);
+	if (cpu >= NR_CPUS)
 		return -EINVAL;
 
 	/* Assumption : cpumask refers to a single CPU */
 	spin_lock_irqsave(&gic_lock, flags);
 
 	/* Re-route this IRQ */
-	write_gic_map_vp(irq, BIT(mips_cm_vp_id(cpumask_first(&tmp))));
+	write_gic_map_vp(irq, BIT(mips_cm_vp_id(cpu)));
 
 	/* Update the pcpu_masks */
 	gic_clear_pcpu_masks(irq);
 	if (read_gic_mask(irq))
-		set_bit(irq, per_cpu_ptr(pcpu_masks, cpumask_first(&tmp)));
+		set_bit(irq, per_cpu_ptr(pcpu_masks, cpu));
 
 	cpumask_copy(irq_data_get_affinity_mask(d), cpumask);
 	spin_unlock_irqrestore(&gic_lock, flags);
-- 
2.14.1
