Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jul 2015 11:45:35 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:39215 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009596AbbGIJlyIRlGh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Jul 2015 11:41:54 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 73B5D3912237F;
        Thu,  9 Jul 2015 10:41:45 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 9 Jul 2015 10:41:47 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.48) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Thu, 9 Jul 2015 10:41:46 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Bresticker <abrestic@chromium.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 14/19] drivers: irqchip: irq-mips-gic: Extend GIC accessors for 64-bit CMs
Date:   Thu, 9 Jul 2015 10:40:48 +0100
Message-ID: <1436434853-30001-15-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1436434853-30001-1-git-send-email-markos.chandras@imgtec.com>
References: <1436434853-30001-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.48]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48151
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

Previously, the GIC accessors were only accessing u32 registers but
newer CMs may actually be 64-bit on MIPS64 cores. As a result of which,
extended these accessors to support 64-bit reads and writes.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Bresticker <abrestic@chromium.org>
Cc: Paul Burton <paul.burton@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 drivers/irqchip/irq-mips-gic.c   | 119 ++++++++++++++++++++++++---------------
 include/linux/irqchip/mips-gic.h |  10 +++-
 2 files changed, 83 insertions(+), 46 deletions(-)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index 4400edd1a6c7..29c494691b71 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -42,20 +42,46 @@ static struct irq_chip gic_level_irq_controller, gic_edge_irq_controller;
 
 static void __gic_irq_dispatch(void);
 
-static inline unsigned int gic_read(unsigned int reg)
+static inline u32 gic_read32(unsigned int reg)
 {
 	return __raw_readl(gic_base + reg);
 }
 
-static inline void gic_write(unsigned int reg, unsigned int val)
+static inline u64 gic_read64(unsigned int reg)
 {
-	__raw_writel(val, gic_base + reg);
+	return __raw_readq(gic_base + reg);
 }
 
-static inline void gic_update_bits(unsigned int reg, unsigned int mask,
-				   unsigned int val)
+static inline unsigned long gic_read(unsigned int reg)
 {
-	unsigned int regval;
+	if (!mips_cm_is64)
+		return gic_read32(reg);
+	else
+		return gic_read64(reg);
+}
+
+static inline void gic_write32(unsigned int reg, u32 val)
+{
+	return __raw_writel(val, gic_base + reg);
+}
+
+static inline void gic_write64(unsigned int reg, u64 val)
+{
+	return __raw_writeq(val, gic_base + reg);
+}
+
+static inline void gic_write(unsigned int reg, unsigned long val)
+{
+	if (!mips_cm_is64)
+		return gic_write32(reg, (u32)val);
+	else
+		return gic_write64(reg, (u64)val);
+}
+
+static inline void gic_update_bits(unsigned int reg, unsigned long mask,
+				   unsigned long val)
+{
+	unsigned long regval;
 
 	regval = gic_read(reg);
 	regval &= ~mask;
@@ -66,40 +92,40 @@ static inline void gic_update_bits(unsigned int reg, unsigned int mask,
 static inline void gic_reset_mask(unsigned int intr)
 {
 	gic_write(GIC_REG(SHARED, GIC_SH_RMASK) + GIC_INTR_OFS(intr),
-		  1 << GIC_INTR_BIT(intr));
+		  1ul << GIC_INTR_BIT(intr));
 }
 
 static inline void gic_set_mask(unsigned int intr)
 {
 	gic_write(GIC_REG(SHARED, GIC_SH_SMASK) + GIC_INTR_OFS(intr),
-		  1 << GIC_INTR_BIT(intr));
+		  1ul << GIC_INTR_BIT(intr));
 }
 
 static inline void gic_set_polarity(unsigned int intr, unsigned int pol)
 {
 	gic_update_bits(GIC_REG(SHARED, GIC_SH_SET_POLARITY) +
-			GIC_INTR_OFS(intr), 1 << GIC_INTR_BIT(intr),
-			pol << GIC_INTR_BIT(intr));
+			GIC_INTR_OFS(intr), 1ul << GIC_INTR_BIT(intr),
+			(unsigned long)pol << GIC_INTR_BIT(intr));
 }
 
 static inline void gic_set_trigger(unsigned int intr, unsigned int trig)
 {
 	gic_update_bits(GIC_REG(SHARED, GIC_SH_SET_TRIGGER) +
-			GIC_INTR_OFS(intr), 1 << GIC_INTR_BIT(intr),
-			trig << GIC_INTR_BIT(intr));
+			GIC_INTR_OFS(intr), 1ul << GIC_INTR_BIT(intr),
+			(unsigned long)trig << GIC_INTR_BIT(intr));
 }
 
 static inline void gic_set_dual_edge(unsigned int intr, unsigned int dual)
 {
 	gic_update_bits(GIC_REG(SHARED, GIC_SH_SET_DUAL) + GIC_INTR_OFS(intr),
-			1 << GIC_INTR_BIT(intr),
-			dual << GIC_INTR_BIT(intr));
+			1ul << GIC_INTR_BIT(intr),
+			(unsigned long)dual << GIC_INTR_BIT(intr));
 }
 
 static inline void gic_map_to_pin(unsigned int intr, unsigned int pin)
 {
-	gic_write(GIC_REG(SHARED, GIC_SH_INTR_MAP_TO_PIN_BASE) +
-		  GIC_SH_MAP_TO_PIN(intr), GIC_MAP_TO_PIN_MSK | pin);
+	gic_write32(GIC_REG(SHARED, GIC_SH_INTR_MAP_TO_PIN_BASE) +
+		    GIC_SH_MAP_TO_PIN(intr), GIC_MAP_TO_PIN_MSK | pin);
 }
 
 static inline void gic_map_to_vpe(unsigned int intr, unsigned int vpe)
@@ -115,9 +141,9 @@ cycle_t gic_read_count(void)
 	unsigned int hi, hi2, lo;
 
 	do {
-		hi = gic_read(GIC_REG(SHARED, GIC_SH_COUNTER_63_32));
-		lo = gic_read(GIC_REG(SHARED, GIC_SH_COUNTER_31_00));
-		hi2 = gic_read(GIC_REG(SHARED, GIC_SH_COUNTER_63_32));
+		hi = gic_read32(GIC_REG(SHARED, GIC_SH_COUNTER_63_32));
+		lo = gic_read32(GIC_REG(SHARED, GIC_SH_COUNTER_31_00));
+		hi2 = gic_read32(GIC_REG(SHARED, GIC_SH_COUNTER_63_32));
 	} while (hi2 != hi);
 
 	return (((cycle_t) hi) << 32) + lo;
@@ -136,9 +162,9 @@ unsigned int gic_get_count_width(void)
 
 void gic_write_compare(cycle_t cnt)
 {
-	gic_write(GIC_REG(VPE_LOCAL, GIC_VPE_COMPARE_HI),
+	gic_write32(GIC_REG(VPE_LOCAL, GIC_VPE_COMPARE_HI),
 				(int)(cnt >> 32));
-	gic_write(GIC_REG(VPE_LOCAL, GIC_VPE_COMPARE_LO),
+	gic_write32(GIC_REG(VPE_LOCAL, GIC_VPE_COMPARE_LO),
 				(int)(cnt & 0xffffffff));
 }
 
@@ -148,10 +174,10 @@ void gic_write_cpu_compare(cycle_t cnt, int cpu)
 
 	local_irq_save(flags);
 
-	gic_write(GIC_REG(VPE_LOCAL, GIC_VPE_OTHER_ADDR), cpu);
-	gic_write(GIC_REG(VPE_OTHER, GIC_VPE_COMPARE_HI),
+	gic_write32(GIC_REG(VPE_LOCAL, GIC_VPE_OTHER_ADDR), cpu);
+	gic_write32(GIC_REG(VPE_OTHER, GIC_VPE_COMPARE_HI),
 				(int)(cnt >> 32));
-	gic_write(GIC_REG(VPE_OTHER, GIC_VPE_COMPARE_LO),
+	gic_write32(GIC_REG(VPE_OTHER, GIC_VPE_COMPARE_LO),
 				(int)(cnt & 0xffffffff));
 
 	local_irq_restore(flags);
@@ -161,8 +187,8 @@ cycle_t gic_read_compare(void)
 {
 	unsigned int hi, lo;
 
-	hi = gic_read(GIC_REG(VPE_LOCAL, GIC_VPE_COMPARE_HI));
-	lo = gic_read(GIC_REG(VPE_LOCAL, GIC_VPE_COMPARE_LO));
+	hi = gic_read32(GIC_REG(VPE_LOCAL, GIC_VPE_COMPARE_HI));
+	lo = gic_read32(GIC_REG(VPE_LOCAL, GIC_VPE_COMPARE_LO));
 
 	return (((cycle_t) hi) << 32) + lo;
 }
@@ -197,7 +223,7 @@ static bool gic_local_irq_is_routable(int intr)
 	if (cpu_has_veic)
 		return true;
 
-	vpe_ctl = gic_read(GIC_REG(VPE_LOCAL, GIC_VPE_CTL));
+	vpe_ctl = gic_read32(GIC_REG(VPE_LOCAL, GIC_VPE_CTL));
 	switch (intr) {
 	case GIC_LOCAL_INT_TIMER:
 		return vpe_ctl & GIC_VPE_CTL_TIMER_RTBL_MSK;
@@ -273,7 +299,7 @@ int gic_get_c0_fdc_int(void)
 
 static void gic_handle_shared_int(bool chained)
 {
-	unsigned int i, intr, virq;
+	unsigned int i, intr, virq, gic_reg_step = mips_cm_is64 ? 8 : 4;
 	unsigned long *pcpu_mask;
 	unsigned long pending_reg, intrmask_reg;
 	DECLARE_BITMAP(pending, GIC_MAX_INTRS);
@@ -288,8 +314,8 @@ static void gic_handle_shared_int(bool chained)
 	for (i = 0; i < BITS_TO_LONGS(gic_shared_intrs); i++) {
 		pending[i] = gic_read(pending_reg);
 		intrmask[i] = gic_read(intrmask_reg);
-		pending_reg += 0x4;
-		intrmask_reg += 0x4;
+		pending_reg += gic_reg_step;
+		intrmask_reg += gic_reg_step;
 	}
 
 	bitmap_and(pending, pending, intrmask, gic_shared_intrs);
@@ -439,8 +465,8 @@ static void gic_handle_local_int(bool chained)
 	unsigned long pending, masked;
 	unsigned int intr, virq;
 
-	pending = gic_read(GIC_REG(VPE_LOCAL, GIC_VPE_PEND));
-	masked = gic_read(GIC_REG(VPE_LOCAL, GIC_VPE_MASK));
+	pending = gic_read32(GIC_REG(VPE_LOCAL, GIC_VPE_PEND));
+	masked = gic_read32(GIC_REG(VPE_LOCAL, GIC_VPE_MASK));
 
 	bitmap_and(&pending, &pending, &masked, GIC_NUM_LOCAL_INTRS);
 
@@ -463,14 +489,14 @@ static void gic_mask_local_irq(struct irq_data *d)
 {
 	int intr = GIC_HWIRQ_TO_LOCAL(d->hwirq);
 
-	gic_write(GIC_REG(VPE_LOCAL, GIC_VPE_RMASK), 1 << intr);
+	gic_write32(GIC_REG(VPE_LOCAL, GIC_VPE_RMASK), 1 << intr);
 }
 
 static void gic_unmask_local_irq(struct irq_data *d)
 {
 	int intr = GIC_HWIRQ_TO_LOCAL(d->hwirq);
 
-	gic_write(GIC_REG(VPE_LOCAL, GIC_VPE_SMASK), 1 << intr);
+	gic_write32(GIC_REG(VPE_LOCAL, GIC_VPE_SMASK), 1 << intr);
 }
 
 static struct irq_chip gic_local_irq_controller = {
@@ -488,7 +514,7 @@ static void gic_mask_local_irq_all_vpes(struct irq_data *d)
 	spin_lock_irqsave(&gic_lock, flags);
 	for (i = 0; i < gic_vpes; i++) {
 		gic_write(GIC_REG(VPE_LOCAL, GIC_VPE_OTHER_ADDR), i);
-		gic_write(GIC_REG(VPE_OTHER, GIC_VPE_RMASK), 1 << intr);
+		gic_write32(GIC_REG(VPE_OTHER, GIC_VPE_RMASK), 1 << intr);
 	}
 	spin_unlock_irqrestore(&gic_lock, flags);
 }
@@ -502,7 +528,7 @@ static void gic_unmask_local_irq_all_vpes(struct irq_data *d)
 	spin_lock_irqsave(&gic_lock, flags);
 	for (i = 0; i < gic_vpes; i++) {
 		gic_write(GIC_REG(VPE_LOCAL, GIC_VPE_OTHER_ADDR), i);
-		gic_write(GIC_REG(VPE_OTHER, GIC_VPE_SMASK), 1 << intr);
+		gic_write32(GIC_REG(VPE_OTHER, GIC_VPE_SMASK), 1 << intr);
 	}
 	spin_unlock_irqrestore(&gic_lock, flags);
 }
@@ -667,27 +693,32 @@ static int gic_local_irq_domain_map(struct irq_domain *d, unsigned int virq,
 
 		switch (intr) {
 		case GIC_LOCAL_INT_WD:
-			gic_write(GIC_REG(VPE_OTHER, GIC_VPE_WD_MAP), val);
+			gic_write32(GIC_REG(VPE_OTHER, GIC_VPE_WD_MAP), val);
 			break;
 		case GIC_LOCAL_INT_COMPARE:
-			gic_write(GIC_REG(VPE_OTHER, GIC_VPE_COMPARE_MAP), val);
+			gic_write32(GIC_REG(VPE_OTHER, GIC_VPE_COMPARE_MAP),
+				    val);
 			break;
 		case GIC_LOCAL_INT_TIMER:
 			/* CONFIG_MIPS_CMP workaround (see __gic_init) */
 			val = GIC_MAP_TO_PIN_MSK | timer_cpu_pin;
-			gic_write(GIC_REG(VPE_OTHER, GIC_VPE_TIMER_MAP), val);
+			gic_write32(GIC_REG(VPE_OTHER, GIC_VPE_TIMER_MAP),
+				    val);
 			break;
 		case GIC_LOCAL_INT_PERFCTR:
-			gic_write(GIC_REG(VPE_OTHER, GIC_VPE_PERFCTR_MAP), val);
+			gic_write32(GIC_REG(VPE_OTHER, GIC_VPE_PERFCTR_MAP),
+				    val);
 			break;
 		case GIC_LOCAL_INT_SWINT0:
-			gic_write(GIC_REG(VPE_OTHER, GIC_VPE_SWINT0_MAP), val);
+			gic_write32(GIC_REG(VPE_OTHER, GIC_VPE_SWINT0_MAP),
+				    val);
 			break;
 		case GIC_LOCAL_INT_SWINT1:
-			gic_write(GIC_REG(VPE_OTHER, GIC_VPE_SWINT1_MAP), val);
+			gic_write32(GIC_REG(VPE_OTHER, GIC_VPE_SWINT1_MAP),
+				    val);
 			break;
 		case GIC_LOCAL_INT_FDC:
-			gic_write(GIC_REG(VPE_OTHER, GIC_VPE_FDC_MAP), val);
+			gic_write32(GIC_REG(VPE_OTHER, GIC_VPE_FDC_MAP), val);
 			break;
 		default:
 			pr_err("Invalid local IRQ %d\n", intr);
@@ -792,7 +823,7 @@ static void __init __gic_init(unsigned long gic_base_addr,
 		 */
 		if (IS_ENABLED(CONFIG_MIPS_CMP) &&
 		    gic_local_irq_is_routable(GIC_LOCAL_INT_TIMER)) {
-			timer_cpu_pin = gic_read(GIC_REG(VPE_LOCAL,
+			timer_cpu_pin = gic_read32(GIC_REG(VPE_LOCAL,
 							 GIC_VPE_TIMER_MAP)) &
 					GIC_MAP_MSK;
 			irq_set_chained_handler(MIPS_CPU_IRQ_BASE +
diff --git a/include/linux/irqchip/mips-gic.h b/include/linux/irqchip/mips-gic.h
index 9b1ad3734911..10e4a9073019 100644
--- a/include/linux/irqchip/mips-gic.h
+++ b/include/linux/irqchip/mips-gic.h
@@ -45,8 +45,14 @@
 #define GIC_SH_REVISIONID_OFS		0x0020
 
 /* Convert an interrupt number to a byte offset/bit for multi-word registers */
-#define GIC_INTR_OFS(intr)		(((intr) / 32) * 4)
-#define GIC_INTR_BIT(intr)		((intr) % 32)
+#define GIC_INTR_OFS(intr) ({				\
+	unsigned bits = mips_cm_is64 ? 64 : 32;		\
+	unsigned reg_idx = (intr) / bits;		\
+	unsigned reg_width = bits / 8;			\
+							\
+	reg_idx * reg_width;				\
+})
+#define GIC_INTR_BIT(intr)		((intr) % (mips_cm_is64 ? 64 : 32))
 
 /* Polarity : Reset Value is always 0 */
 #define GIC_SH_SET_POLARITY_OFS		0x0100
-- 
2.4.5
