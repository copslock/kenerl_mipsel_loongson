Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Aug 2017 06:51:39 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:37416 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994818AbdHMEskRGvWd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 13 Aug 2017 06:48:40 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 28E7F28558E17;
        Sun, 13 Aug 2017 05:48:32 +0100 (IST)
Received: from localhost (10.20.79.142) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Sun, 13 Aug
 2017 05:48:33 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 37/38] irqchip: mips-gic: Use cpumask_first_and() in gic_set_affinity()
Date:   Sat, 12 Aug 2017 21:36:45 -0700
Message-ID: <20170813043646.25821-38-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.14.0
In-Reply-To: <20170813043646.25821-1-paul.burton@imgtec.com>
References: <20170813043646.25821-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.79.142]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59553
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
we don't need to temporary cpumask for anything else & we only care
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

 drivers/irqchip/irq-mips-gic.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index e4ab65c7056d..cd9cbda1f263 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -250,21 +250,21 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *cpumask,
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
-	gic_setup_pcpu_mask(irq, read_gic_mask(irq) ? cpumask_first(&tmp) : NR_CPUS);
+	gic_setup_pcpu_mask(irq, read_gic_mask(irq) ? cpu : NR_CPUS);
 
 	cpumask_copy(irq_data_get_affinity_mask(d), cpumask);
 	spin_unlock_irqrestore(&gic_lock, flags);
-- 
2.14.0
