Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Aug 2017 06:41:01 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:27782 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992036AbdHMEkLRZ4Dd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 13 Aug 2017 06:40:11 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id C391C3DC9EDBC;
        Sun, 13 Aug 2017 05:40:02 +0100 (IST)
Received: from localhost (10.20.79.142) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Sun, 13 Aug
 2017 05:40:04 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 09/38] irqchip: mips-gic: Simplify gic_local_irq_domain_map()
Date:   Sat, 12 Aug 2017 21:36:17 -0700
Message-ID: <20170813043646.25821-10-paul.burton@imgtec.com>
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
X-archive-position: 59525
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

Simplify gic_local_irq_domain_map() by:

- Moving the check for invalid IRQs outside of the loop.

- Moving the decision about whether to use gic_cpu_pin or timer_cpu_pin
  outside of the loop.

- Using the new write_gic_vo_map() accessor function to avoid the need
  to handle each map register separately.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mips@linux-mips.org
---

 drivers/irqchip/irq-mips-gic.c   | 57 +++++++++++-----------------------------
 include/linux/irqchip/mips-gic.h |  6 -----
 2 files changed, 16 insertions(+), 47 deletions(-)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index 01ab6fbdb700..8ed4a997554d 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -498,58 +498,33 @@ static int gic_local_irq_domain_map(struct irq_domain *d, unsigned int virq,
 				    irq_hw_number_t hw)
 {
 	int intr = GIC_HWIRQ_TO_LOCAL(hw);
-	int ret = 0;
 	int i;
 	unsigned long flags;
+	u32 val;
 
 	if (!gic_local_irq_is_routable(intr))
 		return -EPERM;
 
-	spin_lock_irqsave(&gic_lock, flags);
-	for (i = 0; i < gic_vpes; i++) {
-		u32 val = GIC_MAP_TO_PIN_MSK | gic_cpu_pin;
+	if (intr > GIC_LOCAL_INT_FDC) {
+		pr_err("Invalid local IRQ %d\n", intr);
+		return -EINVAL;
+	}
 
-		gic_write(GIC_REG(VPE_LOCAL, GIC_VPE_OTHER_ADDR),
-			  mips_cm_vp_id(i));
+	if (intr == GIC_LOCAL_INT_TIMER) {
+		/* CONFIG_MIPS_CMP workaround (see __gic_init) */
+		val = GIC_MAP_PIN_MAP_TO_PIN | timer_cpu_pin;
+	} else {
+		val = GIC_MAP_PIN_MAP_TO_PIN | gic_cpu_pin;
+	}
 
-		switch (intr) {
-		case GIC_LOCAL_INT_WD:
-			gic_write32(GIC_REG(VPE_OTHER, GIC_VPE_WD_MAP), val);
-			break;
-		case GIC_LOCAL_INT_COMPARE:
-			gic_write32(GIC_REG(VPE_OTHER, GIC_VPE_COMPARE_MAP),
-				    val);
-			break;
-		case GIC_LOCAL_INT_TIMER:
-			/* CONFIG_MIPS_CMP workaround (see __gic_init) */
-			val = GIC_MAP_TO_PIN_MSK | timer_cpu_pin;
-			gic_write32(GIC_REG(VPE_OTHER, GIC_VPE_TIMER_MAP),
-				    val);
-			break;
-		case GIC_LOCAL_INT_PERFCTR:
-			gic_write32(GIC_REG(VPE_OTHER, GIC_VPE_PERFCTR_MAP),
-				    val);
-			break;
-		case GIC_LOCAL_INT_SWINT0:
-			gic_write32(GIC_REG(VPE_OTHER, GIC_VPE_SWINT0_MAP),
-				    val);
-			break;
-		case GIC_LOCAL_INT_SWINT1:
-			gic_write32(GIC_REG(VPE_OTHER, GIC_VPE_SWINT1_MAP),
-				    val);
-			break;
-		case GIC_LOCAL_INT_FDC:
-			gic_write32(GIC_REG(VPE_OTHER, GIC_VPE_FDC_MAP), val);
-			break;
-		default:
-			pr_err("Invalid local IRQ %d\n", intr);
-			ret = -EINVAL;
-			break;
-		}
+	spin_lock_irqsave(&gic_lock, flags);
+	for (i = 0; i < gic_vpes; i++) {
+		write_gic_vl_other(mips_cm_vp_id(i));
+		write_gic_vo_map(intr, val);
 	}
 	spin_unlock_irqrestore(&gic_lock, flags);
 
-	return ret;
+	return 0;
 }
 
 static int gic_shared_irq_domain_map(struct irq_domain *d, unsigned int virq,
diff --git a/include/linux/irqchip/mips-gic.h b/include/linux/irqchip/mips-gic.h
index 835e25506660..1342b17b6812 100644
--- a/include/linux/irqchip/mips-gic.h
+++ b/include/linux/irqchip/mips-gic.h
@@ -84,13 +84,7 @@
 #define GIC_VPE_MASK_OFS		0x0008
 #define GIC_VPE_RMASK_OFS		0x000c
 #define GIC_VPE_SMASK_OFS		0x0010
-#define GIC_VPE_WD_MAP_OFS		0x0040
-#define GIC_VPE_COMPARE_MAP_OFS		0x0044
 #define GIC_VPE_TIMER_MAP_OFS		0x0048
-#define GIC_VPE_FDC_MAP_OFS		0x004c
-#define GIC_VPE_PERFCTR_MAP_OFS		0x0050
-#define GIC_VPE_SWINT0_MAP_OFS		0x0054
-#define GIC_VPE_SWINT1_MAP_OFS		0x0058
 #define GIC_VPE_OTHER_ADDR_OFS		0x0080
 #define GIC_VPE_WD_CONFIG0_OFS		0x0090
 #define GIC_VPE_WD_COUNT0_OFS		0x0094
-- 
2.14.0
