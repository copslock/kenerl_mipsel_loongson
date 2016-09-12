Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Sep 2016 17:32:12 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:58101 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992209AbcILPcE4gmNG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 Sep 2016 17:32:04 +0200
Received: from localhost (pes75-3-78-192-101-3.fbxo.proxad.net [78.192.101.3])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C35DC93E;
        Mon, 12 Sep 2016 15:31:57 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Burton <paul.burton@imgtec.com>,
        linux-mips@linux-mips.org, Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.7 40/59] irqchip/mips-gic: Cleanup chip and handler setup
Date:   Mon, 12 Sep 2016 17:30:00 +0200
Message-Id: <20160912152130.453719889@linuxfoundation.org>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160912152128.765864031@linuxfoundation.org>
References: <20160912152128.765864031@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55106
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Burton <paul.burton@imgtec.com>

commit 6a33fa2b87513fee44cb8f0cd17b1acd6316bc6b upstream.

gic_shared_irq_domain_map() is called from gic_irq_domain_alloc() where
the wrong chip has been set, and is then overwritten. Tidy this up by
setting the correct chip the first time, and setting the
handle_level_irq handler from gic_irq_domain_alloc() too.

gic_shared_irq_domain_map() is also called from gic_irq_domain_map(),
which now calls irq_set_chip_and_handler() to retain its previous
behaviour.

This patch prepares for a follow-on which will call
gic_shared_irq_domain_map() from a callback where the lock on the struct
irq_desc is held, which without this change would cause the call to
irq_set_chip_and_handler() to lead to a deadlock.

Fixes: c98c1822ee13 ("irqchip/mips-gic: Add device hierarchy domain")
Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: linux-mips@linux-mips.org
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Link: http://lkml.kernel.org/r/20160819170715.27820-1-paul.burton@imgtec.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/irqchip/irq-mips-gic.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -713,9 +713,6 @@ static int gic_shared_irq_domain_map(str
 	unsigned long flags;
 	int i;
 
-	irq_set_chip_and_handler(virq, &gic_level_irq_controller,
-				 handle_level_irq);
-
 	spin_lock_irqsave(&gic_lock, flags);
 	gic_map_to_pin(intr, gic_cpu_pin);
 	gic_map_to_vpe(intr, mips_cm_vp_id(vpe));
@@ -732,6 +729,10 @@ static int gic_irq_domain_map(struct irq
 {
 	if (GIC_HWIRQ_TO_LOCAL(hw) < GIC_NUM_LOCAL_INTRS)
 		return gic_local_irq_domain_map(d, virq, hw);
+
+	irq_set_chip_and_handler(virq, &gic_level_irq_controller,
+				 handle_level_irq);
+
 	return gic_shared_irq_domain_map(d, virq, hw, 0);
 }
 
@@ -771,11 +772,13 @@ static int gic_irq_domain_alloc(struct i
 			hwirq = GIC_SHARED_TO_HWIRQ(base_hwirq + i);
 
 			ret = irq_domain_set_hwirq_and_chip(d, virq + i, hwirq,
-							    &gic_edge_irq_controller,
+							    &gic_level_irq_controller,
 							    NULL);
 			if (ret)
 				goto error;
 
+			irq_set_handler(virq + i, handle_level_irq);
+
 			ret = gic_shared_irq_domain_map(d, virq + i, hwirq, cpu);
 			if (ret)
 				goto error;
