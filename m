Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Aug 2017 06:42:32 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:33296 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992036AbdHMElZd6fAd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 13 Aug 2017 06:41:25 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 0CB3FD5203722;
        Sun, 13 Aug 2017 05:41:17 +0100 (IST)
Received: from localhost (10.20.79.142) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Sun, 13 Aug
 2017 05:41:18 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 13/38] irqchip: mips-gic: Remove gic_set_dual_edge()
Date:   Sat, 12 Aug 2017 21:36:21 -0700
Message-ID: <20170813043646.25821-14-paul.burton@imgtec.com>
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
X-archive-position: 59529
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

Remove the gic_set_dual_edge() function in favour of using the new
change_gic_dual() accessor function which provides equivalent
functionality. This also allows us to remove the gic_update_bits()
function which gic_set_dual_edge() was the last user of, along with the
GIC_INTR_OFS() & GIC_INTR_BIT() macros.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mips@linux-mips.org
---

 drivers/irqchip/irq-mips-gic.c   | 28 +++++-----------------------
 include/linux/irqchip/mips-gic.h | 17 -----------------
 2 files changed, 5 insertions(+), 40 deletions(-)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index 960d393ca8d1..cd5d46b1c372 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -81,24 +81,6 @@ static inline void gic_write(unsigned int reg, unsigned long val)
 		return gic_write64(reg, (u64)val);
 }
 
-static inline void gic_update_bits(unsigned int reg, unsigned long mask,
-				   unsigned long val)
-{
-	unsigned long regval;
-
-	regval = gic_read(reg);
-	regval &= ~mask;
-	regval |= val;
-	gic_write(reg, regval);
-}
-
-static inline void gic_set_dual_edge(unsigned int intr, unsigned int dual)
-{
-	gic_update_bits(GIC_REG(SHARED, GIC_SH_SET_DUAL) + GIC_INTR_OFS(intr),
-			1ul << GIC_INTR_BIT(intr),
-			(unsigned long)dual << GIC_INTR_BIT(intr));
-}
-
 static inline void gic_map_to_pin(unsigned int intr, unsigned int pin)
 {
 	gic_write32(GIC_REG(SHARED, GIC_SH_INTR_MAP_TO_PIN_BASE) +
@@ -260,32 +242,32 @@ static int gic_set_type(struct irq_data *d, unsigned int type)
 	case IRQ_TYPE_EDGE_FALLING:
 		change_gic_pol(irq, GIC_POL_FALLING_EDGE);
 		change_gic_trig(irq, GIC_TRIG_EDGE);
-		gic_set_dual_edge(irq, GIC_TRIG_DUAL_DISABLE);
+		change_gic_dual(irq, GIC_DUAL_SINGLE);
 		is_edge = true;
 		break;
 	case IRQ_TYPE_EDGE_RISING:
 		change_gic_pol(irq, GIC_POL_RISING_EDGE);
 		change_gic_trig(irq, GIC_TRIG_EDGE);
-		gic_set_dual_edge(irq, GIC_TRIG_DUAL_DISABLE);
+		change_gic_dual(irq, GIC_DUAL_SINGLE);
 		is_edge = true;
 		break;
 	case IRQ_TYPE_EDGE_BOTH:
 		/* polarity is irrelevant in this case */
 		change_gic_trig(irq, GIC_TRIG_EDGE);
-		gic_set_dual_edge(irq, GIC_TRIG_DUAL_ENABLE);
+		change_gic_dual(irq, GIC_DUAL_DUAL);
 		is_edge = true;
 		break;
 	case IRQ_TYPE_LEVEL_LOW:
 		change_gic_pol(irq, GIC_POL_ACTIVE_LOW);
 		change_gic_trig(irq, GIC_TRIG_LEVEL);
-		gic_set_dual_edge(irq, GIC_TRIG_DUAL_DISABLE);
+		change_gic_dual(irq, GIC_DUAL_SINGLE);
 		is_edge = false;
 		break;
 	case IRQ_TYPE_LEVEL_HIGH:
 	default:
 		change_gic_pol(irq, GIC_POL_ACTIVE_HIGH);
 		change_gic_trig(irq, GIC_TRIG_LEVEL);
-		gic_set_dual_edge(irq, GIC_TRIG_DUAL_DISABLE);
+		change_gic_dual(irq, GIC_DUAL_SINGLE);
 		is_edge = false;
 		break;
 	}
diff --git a/include/linux/irqchip/mips-gic.h b/include/linux/irqchip/mips-gic.h
index 2e9f0c43d425..bd348fc9db18 100644
--- a/include/linux/irqchip/mips-gic.h
+++ b/include/linux/irqchip/mips-gic.h
@@ -13,10 +13,6 @@
 
 #define GIC_MAX_INTRS			256
 
-/* Constants */
-#define GIC_TRIG_DUAL_ENABLE		1
-#define GIC_TRIG_DUAL_DISABLE		0
-
 #define MSK(n) ((1 << (n)) - 1)
 
 /* Accessors */
@@ -38,19 +34,6 @@
 
 #define GIC_SH_REVISIONID_OFS		0x0020
 
-/* Convert an interrupt number to a byte offset/bit for multi-word registers */
-#define GIC_INTR_OFS(intr) ({				\
-	unsigned bits = mips_cm_is64 ? 64 : 32;		\
-	unsigned reg_idx = (intr) / bits;		\
-	unsigned reg_width = bits / 8;			\
-							\
-	reg_idx * reg_width;				\
-})
-#define GIC_INTR_BIT(intr)		((intr) % (mips_cm_is64 ? 64 : 32))
-
-/* Dual edge triggering : Reset Value is always 0 */
-#define GIC_SH_SET_DUAL_OFS		0x0200
-
 /* Set/Clear corresponding bit in Edge Detect Register */
 #define GIC_SH_WEDGE_OFS		0x0280
 
-- 
2.14.0
