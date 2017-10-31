Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Oct 2017 17:42:54 +0100 (CET)
Received: from 19pmail.ess.barracuda.com ([64.235.154.231]:36621 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992318AbdJaQmrTODPA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 31 Oct 2017 17:42:47 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1411.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Tue, 31 Oct 2017 16:42:24 +0000
Received: from pburton-laptop.mipstec.com (10.20.1.18) by mips01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server id 14.3.361.1; Tue, 31 Oct 2017
 09:41:00 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>,
        Paul Burton <paul.burton@mips.com>
Subject: [PATCH v2 1/8] irqchip: mips-gic: Inline gic_local_irq_domain_map()
Date:   Tue, 31 Oct 2017 09:41:44 -0700
Message-ID: <20171031164151.6357-2-paul.burton@mips.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20171031164151.6357-1-paul.burton@mips.com>
References: <867evc5cc9.fsf@arm.com>
 <20171031164151.6357-1-paul.burton@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-BESS-ID: 1509468105-452059-3093-416304-3
X-BESS-VER: 2017.12.1-r1710261623
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186453
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Paul.Burton@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60603
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@mips.com
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

The gic_local_irq_domain_map() function has only one callsite in
gic_irq_domain_map(), and the split between the two functions makes it
unclear that they duplicate calculations & checks.

Inline gic_local_irq_domain_map() into gic_irq_domain_map() in order to
clean this up. Doing this makes the following small issues obvious, and
the patch tidies them up:

 - Both functions used GIC_HWIRQ_TO_LOCAL() to convert a hwirq number to
   a local IRQ number. We now only do this once. Although the compiler
   ought to have optimised this away before anyway, the change leaves us
   with less duplicate code.

 - gic_local_irq_domain_map() had a check for invalid local interrupt
   numbers (intr > GIC_LOCAL_INT_FDC). This condition can never occur
   because any hwirq higher than those used for local interrupts is a
   shared interrupt, which gic_irq_domain_map() already handles
   separately. We therefore remove this check.

 - The decision of whether to map the interrupt to gic_cpu_pin or
   timer_cpu_pin can be handled within the existing switch statement in
   gic_irq_domain_map(), shortening the code a little.

The change additionally prepares us nicely for the following patch of
the series which would otherwise need to duplicate the check for whether
a local interrupt should be percpu_devid or just percpu (ie. the switch
statement from gic_irq_domain_map()) in gic_local_irq_domain_map().

Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mips@linux-mips.org
---

Changes in v2: None

 drivers/irqchip/irq-mips-gic.c | 58 ++++++++++++++++--------------------------
 1 file changed, 22 insertions(+), 36 deletions(-)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index c90976d7e53c..6fdcc1552fab 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -382,39 +382,6 @@ static void gic_irq_dispatch(struct irq_desc *desc)
 	gic_handle_shared_int(true);
 }
 
-static int gic_local_irq_domain_map(struct irq_domain *d, unsigned int virq,
-				    irq_hw_number_t hw)
-{
-	int intr = GIC_HWIRQ_TO_LOCAL(hw);
-	int i;
-	unsigned long flags;
-	u32 val;
-
-	if (!gic_local_irq_is_routable(intr))
-		return -EPERM;
-
-	if (intr > GIC_LOCAL_INT_FDC) {
-		pr_err("Invalid local IRQ %d\n", intr);
-		return -EINVAL;
-	}
-
-	if (intr == GIC_LOCAL_INT_TIMER) {
-		/* CONFIG_MIPS_CMP workaround (see __gic_init) */
-		val = GIC_MAP_PIN_MAP_TO_PIN | timer_cpu_pin;
-	} else {
-		val = GIC_MAP_PIN_MAP_TO_PIN | gic_cpu_pin;
-	}
-
-	spin_lock_irqsave(&gic_lock, flags);
-	for (i = 0; i < gic_vpes; i++) {
-		write_gic_vl_other(mips_cm_vp_id(i));
-		write_gic_vo_map(intr, val);
-	}
-	spin_unlock_irqrestore(&gic_lock, flags);
-
-	return 0;
-}
-
 static int gic_shared_irq_domain_map(struct irq_domain *d, unsigned int virq,
 				     irq_hw_number_t hw, unsigned int cpu)
 {
@@ -457,7 +424,10 @@ static int gic_irq_domain_xlate(struct irq_domain *d, struct device_node *ctrlr,
 static int gic_irq_domain_map(struct irq_domain *d, unsigned int virq,
 			      irq_hw_number_t hwirq)
 {
-	int err;
+	unsigned long flags;
+	unsigned int intr;
+	int err, i;
+	u32 map;
 
 	if (hwirq >= GIC_SHARED_HWIRQ_BASE) {
 		/* verify that shared irqs don't conflict with an IPI irq */
@@ -474,8 +444,14 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int virq,
 		return gic_shared_irq_domain_map(d, virq, hwirq, 0);
 	}
 
-	switch (GIC_HWIRQ_TO_LOCAL(hwirq)) {
+	intr = GIC_HWIRQ_TO_LOCAL(hwirq);
+	map = GIC_MAP_PIN_MAP_TO_PIN | gic_cpu_pin;
+
+	switch (intr) {
 	case GIC_LOCAL_INT_TIMER:
+		/* CONFIG_MIPS_CMP workaround (see __gic_init) */
+		map = GIC_MAP_PIN_MAP_TO_PIN | timer_cpu_pin;
+		/* fall-through */
 	case GIC_LOCAL_INT_PERFCTR:
 	case GIC_LOCAL_INT_FDC:
 		/*
@@ -504,7 +480,17 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int virq,
 		break;
 	}
 
-	return gic_local_irq_domain_map(d, virq, hwirq);
+	if (!gic_local_irq_is_routable(intr))
+		return -EPERM;
+
+	spin_lock_irqsave(&gic_lock, flags);
+	for (i = 0; i < gic_vpes; i++) {
+		write_gic_vl_other(mips_cm_vp_id(i));
+		write_gic_vo_map(intr, map);
+	}
+	spin_unlock_irqrestore(&gic_lock, flags);
+
+	return 0;
 }
 
 static int gic_irq_domain_alloc(struct irq_domain *d, unsigned int virq,
-- 
2.14.3
