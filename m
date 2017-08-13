Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Aug 2017 06:50:06 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:48930 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993898AbdHMEr2l5pyd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 13 Aug 2017 06:47:28 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 6DB2FA601A41D;
        Sun, 13 Aug 2017 05:47:20 +0100 (IST)
Received: from localhost (10.20.79.142) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Sun, 13 Aug
 2017 05:47:22 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 33/38] irqchip: mips-gic: Inline gic_basic_init()
Date:   Sat, 12 Aug 2017 21:36:41 -0700
Message-ID: <20170813043646.25821-34-paul.burton@imgtec.com>
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
X-archive-position: 59549
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

gic_basic_init() is now a fairly short function that is only called in
one place. Inline it into gic_of_init() to help readability.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mips@linux-mips.org
---

 drivers/irqchip/irq-mips-gic.c | 47 ++++++++++++++++++------------------------
 1 file changed, 20 insertions(+), 27 deletions(-)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index a4a22bcb1a38..feff4bf97577 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -372,31 +372,6 @@ static void gic_irq_dispatch(struct irq_desc *desc)
 	gic_handle_shared_int(true);
 }
 
-static void __init gic_basic_init(void)
-{
-	unsigned int i;
-
-	board_bind_eic_interrupt = &gic_bind_eic_interrupt;
-
-	/* Setup defaults */
-	for (i = 0; i < gic_shared_intrs; i++) {
-		change_gic_pol(i, GIC_POL_ACTIVE_HIGH);
-		change_gic_trig(i, GIC_TRIG_LEVEL);
-		write_gic_rmask(BIT(i));
-	}
-
-	for (i = 0; i < gic_vpes; i++) {
-		unsigned int j;
-
-		write_gic_vl_other(mips_cm_vp_id(i));
-		for (j = 0; j < GIC_NUM_LOCAL_INTRS; j++) {
-			if (!gic_local_irq_is_routable(j))
-				continue;
-			write_gic_vo_rmask(BIT(j));
-		}
-	}
-}
-
 static int gic_local_irq_domain_map(struct irq_domain *d, unsigned int virq,
 				    irq_hw_number_t hw)
 {
@@ -652,7 +627,7 @@ static const struct irq_domain_ops gic_ipi_domain_ops = {
 static int __init gic_of_init(struct device_node *node,
 			      struct device_node *parent)
 {
-	unsigned int cpu_vec, i, reserved, gicconfig, cpu, v[2];
+	unsigned int cpu_vec, i, j, reserved, gicconfig, cpu, v[2];
 	phys_addr_t gic_base;
 	struct resource res;
 	size_t gic_len;
@@ -775,7 +750,25 @@ static int __init gic_of_init(struct device_node *node,
 	}
 
 	bitmap_copy(ipi_available, ipi_resrv, GIC_MAX_INTRS);
-	gic_basic_init();
+
+	board_bind_eic_interrupt = &gic_bind_eic_interrupt;
+
+	/* Setup defaults */
+	for (i = 0; i < gic_shared_intrs; i++) {
+		change_gic_pol(i, GIC_POL_ACTIVE_HIGH);
+		change_gic_trig(i, GIC_TRIG_LEVEL);
+		write_gic_rmask(BIT(i));
+	}
+
+	for (i = 0; i < gic_vpes; i++) {
+		write_gic_vl_other(mips_cm_vp_id(i));
+		for (j = 0; j < GIC_NUM_LOCAL_INTRS; j++) {
+			if (!gic_local_irq_is_routable(j))
+				continue;
+			write_gic_vo_rmask(BIT(j));
+		}
+	}
+
 	return 0;
 }
 IRQCHIP_DECLARE(mips_gic, "mti,gic", gic_of_init);
-- 
2.14.0
