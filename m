Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Aug 2017 06:43:18 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:3723 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993913AbdHMEmBhmzzd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 13 Aug 2017 06:42:01 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 63E8511B7D424;
        Sun, 13 Aug 2017 05:41:53 +0100 (IST)
Received: from localhost (10.20.79.142) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Sun, 13 Aug
 2017 05:41:55 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 15/38] irqchip: mips-gic: Remove gic_map_to_vpe()
Date:   Sat, 12 Aug 2017 21:36:23 -0700
Message-ID: <20170813043646.25821-16-paul.burton@imgtec.com>
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
X-archive-position: 59531
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

Remove the gic_map_to_vpe() function in favour of using the new
write_gic_map_vp() accessor function which isn't any more complex to
use & allows us to drop a level of abstraction.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mips@linux-mips.org
---

 drivers/irqchip/irq-mips-gic.c   | 11 ++---------
 include/linux/irqchip/mips-gic.h |  6 ------
 2 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index b97c7afef61d..bc7a4e320f89 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -81,13 +81,6 @@ static inline void gic_write(unsigned int reg, unsigned long val)
 		return gic_write64(reg, (u64)val);
 }
 
-static inline void gic_map_to_vpe(unsigned int intr, unsigned int vpe)
-{
-	gic_write(GIC_REG(SHARED, GIC_SH_INTR_MAP_TO_VPE_BASE) +
-		  GIC_SH_MAP_TO_VPE_REG_OFF(intr, vpe),
-		  GIC_SH_MAP_TO_VPE_REG_BIT(vpe));
-}
-
 static bool gic_local_irq_is_routable(int intr)
 {
 	u32 vpe_ctl;
@@ -294,7 +287,7 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *cpumask,
 	spin_lock_irqsave(&gic_lock, flags);
 
 	/* Re-route this IRQ */
-	gic_map_to_vpe(irq, mips_cm_vp_id(cpumask_first(&tmp)));
+	write_gic_map_vp(irq, BIT(mips_cm_vp_id(cpumask_first(&tmp))));
 
 	/* Update the pcpu_masks */
 	for (i = 0; i < min(gic_vpes, NR_CPUS); i++)
@@ -486,7 +479,7 @@ static int gic_shared_irq_domain_map(struct irq_domain *d, unsigned int virq,
 
 	spin_lock_irqsave(&gic_lock, flags);
 	write_gic_map_pin(intr, GIC_MAP_PIN_MAP_TO_PIN | gic_cpu_pin);
-	gic_map_to_vpe(intr, mips_cm_vp_id(vpe));
+	write_gic_map_vp(intr, BIT(mips_cm_vp_id(vpe)));
 	for (i = 0; i < min(gic_vpes, NR_CPUS); i++)
 		clear_bit(intr, pcpu_masks[i].pcpu_mask);
 	set_bit(intr, pcpu_masks[vpe].pcpu_mask);
diff --git a/include/linux/irqchip/mips-gic.h b/include/linux/irqchip/mips-gic.h
index dea79a7a54cc..ad8b216b6056 100644
--- a/include/linux/irqchip/mips-gic.h
+++ b/include/linux/irqchip/mips-gic.h
@@ -37,12 +37,6 @@
 /* Set/Clear corresponding bit in Edge Detect Register */
 #define GIC_SH_WEDGE_OFS		0x0280
 
-/* Maps Interrupt X to a VPE */
-#define GIC_SH_INTR_MAP_TO_VPE_BASE_OFS 0x2000
-#define GIC_SH_MAP_TO_VPE_REG_OFF(intr, vpe) \
-	((32 * (intr)) + (((vpe) / 32) * 4))
-#define GIC_SH_MAP_TO_VPE_REG_BIT(vpe)	(1 << ((vpe) % 32))
-
 /* Register Map for Local Section */
 #define GIC_VPE_CTL_OFS			0x0000
 #define GIC_VPE_PEND_OFS		0x0004
-- 
2.14.0
