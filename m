Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Jun 2016 20:00:10 +0200 (CEST)
Received: from 82-70-136-246.dsl.in-addr.zen.co.uk ([82.70.136.246]:45128 "EHLO
        rainbowdash.ducie.codethink.co.uk" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27030897AbcFHSAILOPmv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 8 Jun 2016 20:00:08 +0200
Received: from ben by rainbowdash.ducie.codethink.co.uk with local (Exim 4.87)
        (envelope-from <ben.dooks@codethink.co.uk>)
        id 1bAhln-0004E5-J2; Wed, 08 Jun 2016 18:59:59 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     linux-kernel@lists.codethink.co.uk
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>,
        Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org
Subject: [PATCH] irqchip/bcm7120-l2: make probe functions static
Date:   Wed,  8 Jun 2016 18:59:58 +0100
Message-Id: <1465408798-16201-1-git-send-email-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.8.1
Return-Path: <ben.dooks@codethink.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53903
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ben.dooks@codethink.co.uk
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

The probe functions in this driver are not exported or declared
for use elsewhere, so make them static to fix the warnings:

drivers/irqchip/irq-bcm7120-l2.c:218:12: warning: symbol 'bcm7120_l2_intc_probe' was not declared. Should it be static?
drivers/irqchip/irq-bcm7120-l2.c:342:12: warning: symbol 'bcm7120_l2_intc_probe_7120' was not declared. Should it be static?
drivers/irqchip/irq-bcm7120-l2.c:349:12: warning: symbol 'bcm7120_l2_intc_probe_3380' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Kevin Cernekee <cernekee@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mips@linux-mips.org
---
 drivers/irqchip/irq-bcm7120-l2.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-bcm7120-l2.c b/drivers/irqchip/irq-bcm7120-l2.c
index 61b18ab..0ec9263 100644
--- a/drivers/irqchip/irq-bcm7120-l2.c
+++ b/drivers/irqchip/irq-bcm7120-l2.c
@@ -215,7 +215,7 @@ static int __init bcm7120_l2_intc_iomap_3380(struct device_node *dn,
 	return 0;
 }
 
-int __init bcm7120_l2_intc_probe(struct device_node *dn,
+static int __init bcm7120_l2_intc_probe(struct device_node *dn,
 				 struct device_node *parent,
 				 int (*iomap_regs_fn)(struct device_node *,
 					struct bcm7120_l2_intc_data *),
@@ -339,15 +339,15 @@ out_unmap:
 	return ret;
 }
 
-int __init bcm7120_l2_intc_probe_7120(struct device_node *dn,
-				      struct device_node *parent)
+static int __init bcm7120_l2_intc_probe_7120(struct device_node *dn,
+					     struct device_node *parent)
 {
 	return bcm7120_l2_intc_probe(dn, parent, bcm7120_l2_intc_iomap_7120,
 				     "BCM7120 L2");
 }
 
-int __init bcm7120_l2_intc_probe_3380(struct device_node *dn,
-				      struct device_node *parent)
+static int __init bcm7120_l2_intc_probe_3380(struct device_node *dn,
+					     struct device_node *parent)
 {
 	return bcm7120_l2_intc_probe(dn, parent, bcm7120_l2_intc_iomap_3380,
 				     "BCM3380 L2");
-- 
2.8.1
