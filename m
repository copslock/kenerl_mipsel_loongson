Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Sep 2017 01:31:25 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:22363 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994827AbdIGX2rJ5kRk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Sep 2017 01:28:47 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 4A89FAF7A9978;
        Fri,  8 Sep 2017 00:28:35 +0100 (IST)
Received: from localhost (10.20.1.88) by hhmail02.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 8 Sep 2017 00:28:40
 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     <dianders@chromium.org>, James Hogan <james.hogan@imgtec.com>,
        Brian Norris <briannorris@chromium.org>,
        Jason Cooper <jason@lakedaemon.net>,
        <jeffy.chen@rock-chips.com>, Marc Zyngier <marc.zyngier@arm.com>,
        <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>,
        <tfiga@chromium.org>, Paul Burton <paul.burton@imgtec.com>
Subject: [RFC PATCH v1 9/9] irqchip: mips-gic: Remove gic_all_vpes_local_irq_controller
Date:   Thu, 7 Sep 2017 16:25:42 -0700
Message-ID: <20170907232542.20589-10-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20170907232542.20589-1-paul.burton@imgtec.com>
References: <1682867.tATABVWsV9@np-p-burton>
 <20170907232542.20589-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.1.88]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59963
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

The gic_all_vpes_local_irq_controller irq_chip in the MIPS GIC driver is
a hack which was necessary due to other drivers & MIPS arch code not
using the percpu interrupt APIs to configure & control interrupts which
are really percpu.

This is no longer a problem - other drivers & arch code support using
the percpu interrupt APIs so we can now remove the
gic_all_vpes_local_irq_controller hack.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: James Hogan <james.hogan@imgtec.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mips@linux-mips.org

---

 drivers/irqchip/irq-mips-gic.c | 69 +++++-------------------------------------
 1 file changed, 7 insertions(+), 62 deletions(-)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index 40159ac12ac8..99dda0618599 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -337,40 +337,6 @@ static struct irq_chip gic_local_irq_controller = {
 	.irq_unmask		=	gic_unmask_local_irq,
 };
 
-static void gic_mask_local_irq_all_vpes(struct irq_data *d)
-{
-	int intr = GIC_HWIRQ_TO_LOCAL(d->hwirq);
-	int i;
-	unsigned long flags;
-
-	spin_lock_irqsave(&gic_lock, flags);
-	for (i = 0; i < gic_vpes; i++) {
-		write_gic_vl_other(mips_cm_vp_id(i));
-		write_gic_vo_rmask(BIT(intr));
-	}
-	spin_unlock_irqrestore(&gic_lock, flags);
-}
-
-static void gic_unmask_local_irq_all_vpes(struct irq_data *d)
-{
-	int intr = GIC_HWIRQ_TO_LOCAL(d->hwirq);
-	int i;
-	unsigned long flags;
-
-	spin_lock_irqsave(&gic_lock, flags);
-	for (i = 0; i < gic_vpes; i++) {
-		write_gic_vl_other(mips_cm_vp_id(i));
-		write_gic_vo_smask(BIT(intr));
-	}
-	spin_unlock_irqrestore(&gic_lock, flags);
-}
-
-static struct irq_chip gic_all_vpes_local_irq_controller = {
-	.name			=	"MIPS GIC Local",
-	.irq_mask		=	gic_mask_local_irq_all_vpes,
-	.irq_unmask		=	gic_unmask_local_irq_all_vpes,
-};
-
 static void __gic_irq_dispatch(void)
 {
 	gic_handle_local_int(false);
@@ -471,35 +437,14 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int virq,
 		return gic_shared_irq_domain_map(d, virq, hwirq, 0);
 	}
 
-	switch (GIC_HWIRQ_TO_LOCAL(hwirq)) {
-	case GIC_LOCAL_INT_TIMER:
-	case GIC_LOCAL_INT_PERFCTR:
-	case GIC_LOCAL_INT_FDC:
-		/*
-		 * HACK: These are all really percpu interrupts, but
-		 * the rest of the MIPS kernel code does not use the
-		 * percpu IRQ API for them.
-		 */
-		err = irq_domain_set_hwirq_and_chip(d, virq, hwirq,
-						    &gic_all_vpes_local_irq_controller,
-						    NULL);
-		if (err)
-			return err;
-
-		irq_set_handler(virq, handle_percpu_irq);
-		break;
+	err = irq_domain_set_hwirq_and_chip(d, virq, hwirq,
+					    &gic_local_irq_controller,
+					    NULL);
+	if (err)
+		return err;
 
-	default:
-		err = irq_domain_set_hwirq_and_chip(d, virq, hwirq,
-						    &gic_local_irq_controller,
-						    NULL);
-		if (err)
-			return err;
-
-		irq_set_handler(virq, handle_percpu_devid_irq);
-		irq_set_percpu_devid(virq);
-		break;
-	}
+	irq_set_handler(virq, handle_percpu_devid_irq);
+	irq_set_percpu_devid(virq);
 
 	return gic_local_irq_domain_map(d, virq, hwirq);
 }
-- 
2.14.1
