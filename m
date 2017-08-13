Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Aug 2017 06:42:53 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:55946 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993898AbdHMElrA5NGd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 13 Aug 2017 06:41:47 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 448C94D950BAD;
        Sun, 13 Aug 2017 05:41:35 +0100 (IST)
Received: from localhost (10.20.79.142) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Sun, 13 Aug
 2017 05:41:36 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 14/38] irqchip: mips-gic: Remove gic_map_to_pin()
Date:   Sat, 12 Aug 2017 21:36:22 -0700
Message-ID: <20170813043646.25821-15-paul.burton@imgtec.com>
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
X-archive-position: 59530
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

Remove the gic_map_to_pin() function in favour of using the new
write_gic_map_pin() accessor function which isn't any more complex to
use & allows us to drop a level of abstraction.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mips@linux-mips.org
---

 drivers/irqchip/irq-mips-gic.c   |  8 +-------
 include/linux/irqchip/mips-gic.h | 10 ----------
 2 files changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index cd5d46b1c372..b97c7afef61d 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -81,12 +81,6 @@ static inline void gic_write(unsigned int reg, unsigned long val)
 		return gic_write64(reg, (u64)val);
 }
 
-static inline void gic_map_to_pin(unsigned int intr, unsigned int pin)
-{
-	gic_write32(GIC_REG(SHARED, GIC_SH_INTR_MAP_TO_PIN_BASE) +
-		    GIC_SH_MAP_TO_PIN(intr), GIC_MAP_TO_PIN_MSK | pin);
-}
-
 static inline void gic_map_to_vpe(unsigned int intr, unsigned int vpe)
 {
 	gic_write(GIC_REG(SHARED, GIC_SH_INTR_MAP_TO_VPE_BASE) +
@@ -491,7 +485,7 @@ static int gic_shared_irq_domain_map(struct irq_domain *d, unsigned int virq,
 	int i;
 
 	spin_lock_irqsave(&gic_lock, flags);
-	gic_map_to_pin(intr, gic_cpu_pin);
+	write_gic_map_pin(intr, GIC_MAP_PIN_MAP_TO_PIN | gic_cpu_pin);
 	gic_map_to_vpe(intr, mips_cm_vp_id(vpe));
 	for (i = 0; i < min(gic_vpes, NR_CPUS); i++)
 		clear_bit(intr, pcpu_masks[i].pcpu_mask);
diff --git a/include/linux/irqchip/mips-gic.h b/include/linux/irqchip/mips-gic.h
index bd348fc9db18..dea79a7a54cc 100644
--- a/include/linux/irqchip/mips-gic.h
+++ b/include/linux/irqchip/mips-gic.h
@@ -37,10 +37,6 @@
 /* Set/Clear corresponding bit in Edge Detect Register */
 #define GIC_SH_WEDGE_OFS		0x0280
 
-/* Maps Interrupt X to a Pin */
-#define GIC_SH_INTR_MAP_TO_PIN_BASE_OFS 0x0500
-#define GIC_SH_MAP_TO_PIN(intr)		(4 * (intr))
-
 /* Maps Interrupt X to a VPE */
 #define GIC_SH_INTR_MAP_TO_VPE_BASE_OFS 0x2000
 #define GIC_SH_MAP_TO_VPE_REG_OFF(intr, vpe) \
@@ -84,12 +80,6 @@
 #define GIC_SH_WEDGE_SET(intr)		((intr) | (0x1 << 31))
 #define GIC_SH_WEDGE_CLR(intr)		((intr) & ~(0x1 << 31))
 
-#define GIC_MAP_TO_PIN_SHF		31
-#define GIC_MAP_TO_PIN_MSK		(MSK(1) << GIC_MAP_TO_PIN_SHF)
-#define GIC_MAP_TO_NMI_SHF		30
-#define GIC_MAP_TO_NMI_MSK		(MSK(1) << GIC_MAP_TO_NMI_SHF)
-#define GIC_MAP_TO_YQ_SHF		29
-#define GIC_MAP_TO_YQ_MSK		(MSK(1) << GIC_MAP_TO_YQ_SHF)
 #define GIC_MAP_SHF			0
 #define GIC_MAP_MSK			(MSK(6) << GIC_MAP_SHF)
 
-- 
2.14.0
