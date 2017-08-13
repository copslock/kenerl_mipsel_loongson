Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Aug 2017 06:44:02 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:31484 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993911AbdHMEmiT6F9d (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 13 Aug 2017 06:42:38 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 9D4DB2038A0A3;
        Sun, 13 Aug 2017 05:42:29 +0100 (IST)
Received: from localhost (10.20.79.142) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Sun, 13 Aug
 2017 05:42:31 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 17/38] irqchip: mips-gic: Convert local int mask access to new accessors
Date:   Sat, 12 Aug 2017 21:36:25 -0700
Message-ID: <20170813043646.25821-18-paul.burton@imgtec.com>
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
X-archive-position: 59533
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

Use the new accessor functions provided by asm/mips-gic.h to access
masks controlling local interrupts, resulting in code which is often
shorter & easier to read.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mips@linux-mips.org
---

 drivers/irqchip/irq-mips-gic.c   | 14 +++++------
 include/linux/irqchip/mips-gic.h | 52 ----------------------------------------
 2 files changed, 7 insertions(+), 59 deletions(-)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index 90b8644e1264..ac4ba4f7c2d6 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -328,8 +328,8 @@ static void gic_handle_local_int(bool chained)
 	unsigned long pending, masked;
 	unsigned int intr, virq;
 
-	pending = gic_read32(GIC_REG(VPE_LOCAL, GIC_VPE_PEND));
-	masked = gic_read32(GIC_REG(VPE_LOCAL, GIC_VPE_MASK));
+	pending = read_gic_vl_pend();
+	masked = read_gic_vl_mask();
 
 	bitmap_and(&pending, &pending, &masked, GIC_NUM_LOCAL_INTRS);
 
@@ -347,14 +347,14 @@ static void gic_mask_local_irq(struct irq_data *d)
 {
 	int intr = GIC_HWIRQ_TO_LOCAL(d->hwirq);
 
-	gic_write32(GIC_REG(VPE_LOCAL, GIC_VPE_RMASK), 1 << intr);
+	write_gic_vl_rmask(BIT(intr));
 }
 
 static void gic_unmask_local_irq(struct irq_data *d)
 {
 	int intr = GIC_HWIRQ_TO_LOCAL(d->hwirq);
 
-	gic_write32(GIC_REG(VPE_LOCAL, GIC_VPE_SMASK), 1 << intr);
+	write_gic_vl_smask(BIT(intr));
 }
 
 static struct irq_chip gic_local_irq_controller = {
@@ -373,7 +373,7 @@ static void gic_mask_local_irq_all_vpes(struct irq_data *d)
 	for (i = 0; i < gic_vpes; i++) {
 		gic_write(GIC_REG(VPE_LOCAL, GIC_VPE_OTHER_ADDR),
 			  mips_cm_vp_id(i));
-		gic_write32(GIC_REG(VPE_OTHER, GIC_VPE_RMASK), 1 << intr);
+		write_gic_vo_rmask(BIT(intr));
 	}
 	spin_unlock_irqrestore(&gic_lock, flags);
 }
@@ -388,7 +388,7 @@ static void gic_unmask_local_irq_all_vpes(struct irq_data *d)
 	for (i = 0; i < gic_vpes; i++) {
 		gic_write(GIC_REG(VPE_LOCAL, GIC_VPE_OTHER_ADDR),
 			  mips_cm_vp_id(i));
-		gic_write32(GIC_REG(VPE_OTHER, GIC_VPE_SMASK), 1 << intr);
+		write_gic_vo_smask(BIT(intr));
 	}
 	spin_unlock_irqrestore(&gic_lock, flags);
 }
@@ -432,7 +432,7 @@ static void __init gic_basic_init(void)
 		for (j = 0; j < GIC_NUM_LOCAL_INTRS; j++) {
 			if (!gic_local_irq_is_routable(j))
 				continue;
-			gic_write32(GIC_REG(VPE_OTHER, GIC_VPE_RMASK), 1 << j);
+			write_gic_vo_rmask(BIT(j));
 		}
 	}
 }
diff --git a/include/linux/irqchip/mips-gic.h b/include/linux/irqchip/mips-gic.h
index f0a60770d775..011698962a8d 100644
--- a/include/linux/irqchip/mips-gic.h
+++ b/include/linux/irqchip/mips-gic.h
@@ -28,10 +28,6 @@
 
 /* Register Map for Local Section */
 #define GIC_VPE_CTL_OFS			0x0000
-#define GIC_VPE_PEND_OFS		0x0004
-#define GIC_VPE_MASK_OFS		0x0008
-#define GIC_VPE_RMASK_OFS		0x000c
-#define GIC_VPE_SMASK_OFS		0x0010
 #define GIC_VPE_TIMER_MAP_OFS		0x0048
 #define GIC_VPE_OTHER_ADDR_OFS		0x0080
 #define GIC_VPE_WD_CONFIG0_OFS		0x0090
@@ -69,54 +65,6 @@
 #define GIC_VPE_CTL_EIC_MODE_SHF	0
 #define GIC_VPE_CTL_EIC_MODE_MSK	(MSK(1) << GIC_VPE_CTL_EIC_MODE_SHF)
 
-/* GIC_VPE_PEND Masks */
-#define GIC_VPE_PEND_WD_SHF		0
-#define GIC_VPE_PEND_WD_MSK		(MSK(1) << GIC_VPE_PEND_WD_SHF)
-#define GIC_VPE_PEND_CMP_SHF		1
-#define GIC_VPE_PEND_CMP_MSK		(MSK(1) << GIC_VPE_PEND_CMP_SHF)
-#define GIC_VPE_PEND_TIMER_SHF		2
-#define GIC_VPE_PEND_TIMER_MSK		(MSK(1) << GIC_VPE_PEND_TIMER_SHF)
-#define GIC_VPE_PEND_PERFCOUNT_SHF	3
-#define GIC_VPE_PEND_PERFCOUNT_MSK	(MSK(1) << GIC_VPE_PEND_PERFCOUNT_SHF)
-#define GIC_VPE_PEND_SWINT0_SHF		4
-#define GIC_VPE_PEND_SWINT0_MSK		(MSK(1) << GIC_VPE_PEND_SWINT0_SHF)
-#define GIC_VPE_PEND_SWINT1_SHF		5
-#define GIC_VPE_PEND_SWINT1_MSK		(MSK(1) << GIC_VPE_PEND_SWINT1_SHF)
-#define GIC_VPE_PEND_FDC_SHF		6
-#define GIC_VPE_PEND_FDC_MSK		(MSK(1) << GIC_VPE_PEND_FDC_SHF)
-
-/* GIC_VPE_RMASK Masks */
-#define GIC_VPE_RMASK_WD_SHF		0
-#define GIC_VPE_RMASK_WD_MSK		(MSK(1) << GIC_VPE_RMASK_WD_SHF)
-#define GIC_VPE_RMASK_CMP_SHF		1
-#define GIC_VPE_RMASK_CMP_MSK		(MSK(1) << GIC_VPE_RMASK_CMP_SHF)
-#define GIC_VPE_RMASK_TIMER_SHF		2
-#define GIC_VPE_RMASK_TIMER_MSK		(MSK(1) << GIC_VPE_RMASK_TIMER_SHF)
-#define GIC_VPE_RMASK_PERFCNT_SHF	3
-#define GIC_VPE_RMASK_PERFCNT_MSK	(MSK(1) << GIC_VPE_RMASK_PERFCNT_SHF)
-#define GIC_VPE_RMASK_SWINT0_SHF	4
-#define GIC_VPE_RMASK_SWINT0_MSK	(MSK(1) << GIC_VPE_RMASK_SWINT0_SHF)
-#define GIC_VPE_RMASK_SWINT1_SHF	5
-#define GIC_VPE_RMASK_SWINT1_MSK	(MSK(1) << GIC_VPE_RMASK_SWINT1_SHF)
-#define GIC_VPE_RMASK_FDC_SHF		6
-#define GIC_VPE_RMASK_FDC_MSK		(MSK(1) << GIC_VPE_RMASK_FDC_SHF)
-
-/* GIC_VPE_SMASK Masks */
-#define GIC_VPE_SMASK_WD_SHF		0
-#define GIC_VPE_SMASK_WD_MSK		(MSK(1) << GIC_VPE_SMASK_WD_SHF)
-#define GIC_VPE_SMASK_CMP_SHF		1
-#define GIC_VPE_SMASK_CMP_MSK		(MSK(1) << GIC_VPE_SMASK_CMP_SHF)
-#define GIC_VPE_SMASK_TIMER_SHF		2
-#define GIC_VPE_SMASK_TIMER_MSK		(MSK(1) << GIC_VPE_SMASK_TIMER_SHF)
-#define GIC_VPE_SMASK_PERFCNT_SHF	3
-#define GIC_VPE_SMASK_PERFCNT_MSK	(MSK(1) << GIC_VPE_SMASK_PERFCNT_SHF)
-#define GIC_VPE_SMASK_SWINT0_SHF	4
-#define GIC_VPE_SMASK_SWINT0_MSK	(MSK(1) << GIC_VPE_SMASK_SWINT0_SHF)
-#define GIC_VPE_SMASK_SWINT1_SHF	5
-#define GIC_VPE_SMASK_SWINT1_MSK	(MSK(1) << GIC_VPE_SMASK_SWINT1_SHF)
-#define GIC_VPE_SMASK_FDC_SHF		6
-#define GIC_VPE_SMASK_FDC_MSK		(MSK(1) << GIC_VPE_SMASK_FDC_SHF)
-
 /* GIC nomenclature for Core Interrupt Pins. */
 #define GIC_CPU_INT0		0 /* Core Interrupt 2 */
 #define GIC_CPU_INT1		1 /* .		      */
-- 
2.14.0
