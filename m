Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Oct 2017 01:40:45 +0200 (CEST)
Received: from 5pmail.ess.barracuda.com ([64.235.154.203]:49354 "EHLO
        5pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992128AbdJYXiqeIQQS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 Oct 2017 01:38:46 +0200
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1403.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Wed, 25 Oct 2017 23:38:36 +0000
Received: from pburton-laptop.mipstec.com (10.20.1.18) by mips01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server id 14.3.361.1; Wed, 25 Oct 2017
 16:36:21 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>,
        Paul Burton <paul.burton@mips.com>
Subject: [PATCH 7/8] irqchip: mips-gic: Share register writes in gic_set_type()
Date:   Wed, 25 Oct 2017 16:37:29 -0700
Message-ID: <20171025233730.22225-8-paul.burton@mips.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20171025233730.22225-1-paul.burton@mips.com>
References: <20171025233730.22225-1-paul.burton@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-BESS-ID: 1508974696-321459-28744-58481-9
X-BESS-VER: 2017.12-r1709122024
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186295
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
X-archive-position: 60569
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

The gic_set_type() function included writes to the MIPS GIC polarity,
trigger & dual-trigger registers in each case of a switch statement
determining the IRQs type. This is all well & good when we only have a
single cluster & thus a single GIC whose register we want to update. It
will lead to significant duplication once we have multi-cluster support
& multiple GICs to update.

Refactor this such that we determine values for the polarity, trigger &
dual-trigger registers and then have a single set of register writes
following the switch statement. This will allow us to write the same
values to each GIC in a multi-cluster system in a later patch, rather
than needing to duplicate more register writes in each case.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mips@linux-mips.org
---

 drivers/irqchip/irq-mips-gic.c | 46 +++++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index 88797e1c58e2..8c719a9912fc 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -199,46 +199,46 @@ static void gic_ack_irq(struct irq_data *d)
 
 static int gic_set_type(struct irq_data *d, unsigned int type)
 {
-	unsigned int irq = GIC_HWIRQ_TO_SHARED(d->hwirq);
+	unsigned int irq, pol, trig, dual;
 	unsigned long flags;
-	bool is_edge;
+
+	irq = GIC_HWIRQ_TO_SHARED(d->hwirq);
 
 	spin_lock_irqsave(&gic_lock, flags);
 	switch (type & IRQ_TYPE_SENSE_MASK) {
 	case IRQ_TYPE_EDGE_FALLING:
-		change_gic_pol(irq, GIC_POL_FALLING_EDGE);
-		change_gic_trig(irq, GIC_TRIG_EDGE);
-		change_gic_dual(irq, GIC_DUAL_SINGLE);
-		is_edge = true;
+		pol = GIC_POL_FALLING_EDGE;
+		trig = GIC_TRIG_EDGE;
+		dual = GIC_DUAL_SINGLE;
 		break;
 	case IRQ_TYPE_EDGE_RISING:
-		change_gic_pol(irq, GIC_POL_RISING_EDGE);
-		change_gic_trig(irq, GIC_TRIG_EDGE);
-		change_gic_dual(irq, GIC_DUAL_SINGLE);
-		is_edge = true;
+		pol = GIC_POL_RISING_EDGE;
+		trig = GIC_TRIG_EDGE;
+		dual = GIC_DUAL_SINGLE;
 		break;
 	case IRQ_TYPE_EDGE_BOTH:
-		/* polarity is irrelevant in this case */
-		change_gic_trig(irq, GIC_TRIG_EDGE);
-		change_gic_dual(irq, GIC_DUAL_DUAL);
-		is_edge = true;
+		pol = 0; /* Doesn't matter */
+		trig = GIC_TRIG_EDGE;
+		dual = GIC_DUAL_DUAL;
 		break;
 	case IRQ_TYPE_LEVEL_LOW:
-		change_gic_pol(irq, GIC_POL_ACTIVE_LOW);
-		change_gic_trig(irq, GIC_TRIG_LEVEL);
-		change_gic_dual(irq, GIC_DUAL_SINGLE);
-		is_edge = false;
+		pol = GIC_POL_ACTIVE_LOW;
+		trig = GIC_TRIG_LEVEL;
+		dual = GIC_DUAL_SINGLE;
 		break;
 	case IRQ_TYPE_LEVEL_HIGH:
 	default:
-		change_gic_pol(irq, GIC_POL_ACTIVE_HIGH);
-		change_gic_trig(irq, GIC_TRIG_LEVEL);
-		change_gic_dual(irq, GIC_DUAL_SINGLE);
-		is_edge = false;
+		pol = GIC_POL_ACTIVE_HIGH;
+		trig = GIC_TRIG_LEVEL;
+		dual = GIC_DUAL_SINGLE;
 		break;
 	}
 
-	if (is_edge)
+	change_gic_pol(irq, pol);
+	change_gic_trig(irq, trig);
+	change_gic_dual(irq, dual);
+
+	if (trig == GIC_TRIG_EDGE)
 		irq_set_chip_handler_name_locked(d, &gic_edge_irq_controller,
 						 handle_edge_irq, NULL);
 	else
-- 
2.14.3
