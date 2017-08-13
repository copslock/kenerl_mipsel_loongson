Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Aug 2017 06:44:27 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:2056 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993915AbdHMEm51Dyxd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 13 Aug 2017 06:42:57 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id A49D461BF91A6;
        Sun, 13 Aug 2017 05:42:47 +0100 (IST)
Received: from localhost (10.20.79.142) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Sun, 13 Aug
 2017 05:42:49 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 18/38] irqchip: mips-gic: Convert remaining local reg access to new accessors
Date:   Sat, 12 Aug 2017 21:36:26 -0700
Message-ID: <20170813043646.25821-19-paul.burton@imgtec.com>
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
X-archive-position: 59534
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

Convert the remaining accesses to registers in the GIC VP-local &
VP-other register blocks to use the new accessor functions provided by
asm/mips-gic.h, resulting in code which is often shorter & easier to
read.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mips@linux-mips.org
---

 drivers/irqchip/irq-mips-gic.c   | 68 +++++++---------------------------------
 include/linux/irqchip/mips-gic.h | 44 --------------------------
 2 files changed, 12 insertions(+), 100 deletions(-)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index ac4ba4f7c2d6..5b282a7fd7e0 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -45,42 +45,6 @@ DECLARE_BITMAP(ipi_available, GIC_MAX_INTRS);
 
 static void __gic_irq_dispatch(void);
 
-static inline u32 gic_read32(unsigned int reg)
-{
-	return __raw_readl(mips_gic_base + reg);
-}
-
-static inline u64 gic_read64(unsigned int reg)
-{
-	return __raw_readq(mips_gic_base + reg);
-}
-
-static inline unsigned long gic_read(unsigned int reg)
-{
-	if (!mips_cm_is64)
-		return gic_read32(reg);
-	else
-		return gic_read64(reg);
-}
-
-static inline void gic_write32(unsigned int reg, u32 val)
-{
-	return __raw_writel(val, mips_gic_base + reg);
-}
-
-static inline void gic_write64(unsigned int reg, u64 val)
-{
-	return __raw_writeq(val, mips_gic_base + reg);
-}
-
-static inline void gic_write(unsigned int reg, unsigned long val)
-{
-	if (!mips_cm_is64)
-		return gic_write32(reg, (u32)val);
-	else
-		return gic_write64(reg, (u64)val);
-}
-
 static bool gic_local_irq_is_routable(int intr)
 {
 	u32 vpe_ctl;
@@ -89,17 +53,17 @@ static bool gic_local_irq_is_routable(int intr)
 	if (cpu_has_veic)
 		return true;
 
-	vpe_ctl = gic_read32(GIC_REG(VPE_LOCAL, GIC_VPE_CTL));
+	vpe_ctl = read_gic_vl_ctl();
 	switch (intr) {
 	case GIC_LOCAL_INT_TIMER:
-		return vpe_ctl & GIC_VPE_CTL_TIMER_RTBL_MSK;
+		return vpe_ctl & GIC_VX_CTL_TIMER_ROUTABLE;
 	case GIC_LOCAL_INT_PERFCTR:
-		return vpe_ctl & GIC_VPE_CTL_PERFCNT_RTBL_MSK;
+		return vpe_ctl & GIC_VX_CTL_PERFCNT_ROUTABLE;
 	case GIC_LOCAL_INT_FDC:
-		return vpe_ctl & GIC_VPE_CTL_FDC_RTBL_MSK;
+		return vpe_ctl & GIC_VX_CTL_FDC_ROUTABLE;
 	case GIC_LOCAL_INT_SWINT0:
 	case GIC_LOCAL_INT_SWINT1:
-		return vpe_ctl & GIC_VPE_CTL_SWINT_RTBL_MSK;
+		return vpe_ctl & GIC_VX_CTL_SWINT_ROUTABLE;
 	default:
 		return true;
 	}
@@ -111,8 +75,7 @@ static void gic_bind_eic_interrupt(int irq, int set)
 	irq -= GIC_PIN_TO_VEC_OFFSET;
 
 	/* Set irq to use shadow set */
-	gic_write(GIC_REG(VPE_LOCAL, GIC_VPE_EIC_SHADOW_SET_BASE) +
-		  GIC_VPE_EIC_SS(irq), set);
+	write_gic_vl_eic_shadow_set(irq, set);
 }
 
 static void gic_send_ipi(struct irq_data *d, unsigned int cpu)
@@ -371,8 +334,7 @@ static void gic_mask_local_irq_all_vpes(struct irq_data *d)
 
 	spin_lock_irqsave(&gic_lock, flags);
 	for (i = 0; i < gic_vpes; i++) {
-		gic_write(GIC_REG(VPE_LOCAL, GIC_VPE_OTHER_ADDR),
-			  mips_cm_vp_id(i));
+		write_gic_vl_other(mips_cm_vp_id(i));
 		write_gic_vo_rmask(BIT(intr));
 	}
 	spin_unlock_irqrestore(&gic_lock, flags);
@@ -386,8 +348,7 @@ static void gic_unmask_local_irq_all_vpes(struct irq_data *d)
 
 	spin_lock_irqsave(&gic_lock, flags);
 	for (i = 0; i < gic_vpes; i++) {
-		gic_write(GIC_REG(VPE_LOCAL, GIC_VPE_OTHER_ADDR),
-			  mips_cm_vp_id(i));
+		write_gic_vl_other(mips_cm_vp_id(i));
 		write_gic_vo_smask(BIT(intr));
 	}
 	spin_unlock_irqrestore(&gic_lock, flags);
@@ -427,8 +388,7 @@ static void __init gic_basic_init(void)
 	for (i = 0; i < gic_vpes; i++) {
 		unsigned int j;
 
-		gic_write(GIC_REG(VPE_LOCAL, GIC_VPE_OTHER_ADDR),
-			  mips_cm_vp_id(i));
+		write_gic_vl_other(mips_cm_vp_id(i));
 		for (j = 0; j < GIC_NUM_LOCAL_INTRS; j++) {
 			if (!gic_local_irq_is_routable(j))
 				continue;
@@ -712,10 +672,8 @@ static void __init __gic_init(unsigned long gic_base_addr,
 	if (cpu_has_veic) {
 		/* Set EIC mode for all VPEs */
 		for_each_present_cpu(cpu) {
-			gic_write(GIC_REG(VPE_LOCAL, GIC_VPE_OTHER_ADDR),
-				  mips_cm_vp_id(cpu));
-			gic_write(GIC_REG(VPE_OTHER, GIC_VPE_CTL),
-				  GIC_VPE_CTL_EIC_MODE_MSK);
+			write_gic_vl_other(mips_cm_vp_id(cpu));
+			write_gic_vo_ctl(GIC_VX_CTL_EIC);
 		}
 
 		/* Always use vector 1 in EIC mode */
@@ -740,9 +698,7 @@ static void __init __gic_init(unsigned long gic_base_addr,
 		 */
 		if (IS_ENABLED(CONFIG_MIPS_CMP) &&
 		    gic_local_irq_is_routable(GIC_LOCAL_INT_TIMER)) {
-			timer_cpu_pin = gic_read32(GIC_REG(VPE_LOCAL,
-							 GIC_VPE_TIMER_MAP)) &
-					GIC_MAP_MSK;
+			timer_cpu_pin = read_gic_vl_timer_map() & GIC_MAP_PIN_MAP;
 			irq_set_chained_handler(MIPS_CPU_IRQ_BASE +
 						GIC_CPU_PIN_OFFSET +
 						timer_cpu_pin,
diff --git a/include/linux/irqchip/mips-gic.h b/include/linux/irqchip/mips-gic.h
index 011698962a8d..b7a3ce1da9a7 100644
--- a/include/linux/irqchip/mips-gic.h
+++ b/include/linux/irqchip/mips-gic.h
@@ -13,58 +13,14 @@
 
 #define GIC_MAX_INTRS			256
 
-#define MSK(n) ((1 << (n)) - 1)
-
-/* Accessors */
-#define GIC_REG(segment, offset) (segment##_##SECTION_OFS + offset##_##OFS)
-
 /* GIC Address Space */
-#define VPE_LOCAL_SECTION_OFS		0x8000
-#define VPE_LOCAL_SECTION_SIZE		0x4000
-#define VPE_OTHER_SECTION_OFS		0xc000
-#define VPE_OTHER_SECTION_SIZE		0x4000
 #define USM_VISIBLE_SECTION_OFS		0x10000
 #define USM_VISIBLE_SECTION_SIZE	0x10000
 
-/* Register Map for Local Section */
-#define GIC_VPE_CTL_OFS			0x0000
-#define GIC_VPE_TIMER_MAP_OFS		0x0048
-#define GIC_VPE_OTHER_ADDR_OFS		0x0080
-#define GIC_VPE_WD_CONFIG0_OFS		0x0090
-#define GIC_VPE_WD_COUNT0_OFS		0x0094
-#define GIC_VPE_WD_INITIAL0_OFS		0x0098
-
-#define GIC_VPE_EIC_SHADOW_SET_BASE_OFS	0x0100
-#define GIC_VPE_EIC_SS(intr)		(4 * (intr))
-
-#define GIC_VPE_EIC_VEC_BASE_OFS	0x0800
-#define GIC_VPE_EIC_VEC(intr)		(4 * (intr))
-
-#define GIC_VPE_TENABLE_NMI_OFS		0x1000
-#define GIC_VPE_TENABLE_YQ_OFS		0x1004
-#define GIC_VPE_TENABLE_INT_31_0_OFS	0x1080
-#define GIC_VPE_TENABLE_INT_63_32_OFS	0x1084
-
 /* User Mode Visible Section Register Map */
 #define GIC_UMV_SH_COUNTER_31_00_OFS	0x0000
 #define GIC_UMV_SH_COUNTER_63_32_OFS	0x0004
 
-/* Masks */
-#define GIC_MAP_SHF			0
-#define GIC_MAP_MSK			(MSK(6) << GIC_MAP_SHF)
-
-/* GIC_VPE_CTL Masks */
-#define GIC_VPE_CTL_FDC_RTBL_SHF	4
-#define GIC_VPE_CTL_FDC_RTBL_MSK	(MSK(1) << GIC_VPE_CTL_FDC_RTBL_SHF)
-#define GIC_VPE_CTL_SWINT_RTBL_SHF	3
-#define GIC_VPE_CTL_SWINT_RTBL_MSK	(MSK(1) << GIC_VPE_CTL_SWINT_RTBL_SHF)
-#define GIC_VPE_CTL_PERFCNT_RTBL_SHF	2
-#define GIC_VPE_CTL_PERFCNT_RTBL_MSK	(MSK(1) << GIC_VPE_CTL_PERFCNT_RTBL_SHF)
-#define GIC_VPE_CTL_TIMER_RTBL_SHF	1
-#define GIC_VPE_CTL_TIMER_RTBL_MSK	(MSK(1) << GIC_VPE_CTL_TIMER_RTBL_SHF)
-#define GIC_VPE_CTL_EIC_MODE_SHF	0
-#define GIC_VPE_CTL_EIC_MODE_MSK	(MSK(1) << GIC_VPE_CTL_EIC_MODE_SHF)
-
 /* GIC nomenclature for Core Interrupt Pins. */
 #define GIC_CPU_INT0		0 /* Core Interrupt 2 */
 #define GIC_CPU_INT1		1 /* .		      */
-- 
2.14.0
