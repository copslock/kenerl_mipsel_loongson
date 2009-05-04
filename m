Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 May 2009 22:55:05 +0100 (BST)
Received: from elvis.franken.de ([193.175.24.41]:53596 "EHLO elvis.franken.de"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20023500AbZEDVyd (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 4 May 2009 22:54:33 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1M167M-0005fm-00; Mon, 04 May 2009 23:54:32 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id 461B2E31C1; Mon,  4 May 2009 23:51:55 +0200 (CEST)
From:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH] SIBYTE: fix locking in set_irq_affinity
To:	linux-mips@linux-mips.org
cc:	ralf@linux-mips.org
Message-Id: <20090504215155.461B2E31C1@solo.franken.de>
Date:	Mon,  4 May 2009 23:51:54 +0200 (CEST)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22617
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

Locking of irq_desc is now done in irq_set_affinity; Don't lock it
again in chip specific set_affinity function.

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---

 arch/mips/sibyte/bcm1480/irq.c |    7 ++-----
 arch/mips/sibyte/sb1250/irq.c  |    7 ++-----
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/arch/mips/sibyte/bcm1480/irq.c b/arch/mips/sibyte/bcm1480/irq.c
index 352352b..c147c4b 100644
--- a/arch/mips/sibyte/bcm1480/irq.c
+++ b/arch/mips/sibyte/bcm1480/irq.c
@@ -113,7 +113,6 @@ static void bcm1480_set_affinity(unsigned int irq, const struct cpumask *mask)
 {
 	int i = 0, old_cpu, cpu, int_on, k;
 	u64 cur_ints;
-	struct irq_desc *desc = irq_desc + irq;
 	unsigned long flags;
 	unsigned int irq_dirty;
 
@@ -127,8 +126,7 @@ static void bcm1480_set_affinity(unsigned int irq, const struct cpumask *mask)
 	cpu = cpu_logical_map(i);
 
 	/* Protect against other affinity changers and IMR manipulation */
-	spin_lock_irqsave(&desc->lock, flags);
-	spin_lock(&bcm1480_imr_lock);
+	spin_lock_irqsave(&bcm1480_imr_lock, flags);
 
 	/* Swizzle each CPU's IMR (but leave the IP selection alone) */
 	old_cpu = bcm1480_irq_owner[irq];
@@ -153,8 +151,7 @@ static void bcm1480_set_affinity(unsigned int irq, const struct cpumask *mask)
 			____raw_writeq(cur_ints, IOADDR(A_BCM1480_IMR_MAPPER(cpu) + R_BCM1480_IMR_INTERRUPT_MASK_H + (k*BCM1480_IMR_HL_SPACING)));
 		}
 	}
-	spin_unlock(&bcm1480_imr_lock);
-	spin_unlock_irqrestore(&desc->lock, flags);
+	spin_unlock_irqrestore(&bcm1480_imr_lock, flags);
 }
 #endif
 
diff --git a/arch/mips/sibyte/sb1250/irq.c b/arch/mips/sibyte/sb1250/irq.c
index c08ff58..38cb998 100644
--- a/arch/mips/sibyte/sb1250/irq.c
+++ b/arch/mips/sibyte/sb1250/irq.c
@@ -107,7 +107,6 @@ static void sb1250_set_affinity(unsigned int irq, const struct cpumask *mask)
 {
 	int i = 0, old_cpu, cpu, int_on;
 	u64 cur_ints;
-	struct irq_desc *desc = irq_desc + irq;
 	unsigned long flags;
 
 	i = cpumask_first(mask);
@@ -121,8 +120,7 @@ static void sb1250_set_affinity(unsigned int irq, const struct cpumask *mask)
 	cpu = cpu_logical_map(i);
 
 	/* Protect against other affinity changers and IMR manipulation */
-	spin_lock_irqsave(&desc->lock, flags);
-	spin_lock(&sb1250_imr_lock);
+	spin_lock_irqsave(&sb1250_imr_lock, flags);
 
 	/* Swizzle each CPU's IMR (but leave the IP selection alone) */
 	old_cpu = sb1250_irq_owner[irq];
@@ -144,8 +142,7 @@ static void sb1250_set_affinity(unsigned int irq, const struct cpumask *mask)
 		____raw_writeq(cur_ints, IOADDR(A_IMR_MAPPER(cpu) +
 					R_IMR_INTERRUPT_MASK));
 	}
-	spin_unlock(&sb1250_imr_lock);
-	spin_unlock_irqrestore(&desc->lock, flags);
+	spin_unlock_irqrestore(&sb1250_imr_lock, flags);
 }
 #endif
 
