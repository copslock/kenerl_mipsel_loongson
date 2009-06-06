Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 06 Jun 2009 08:54:11 +0100 (WEST)
Received: from elvis.franken.de ([193.175.24.41]:52927 "EHLO elvis.franken.de"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20022664AbZFFHyE (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 6 Jun 2009 08:54:04 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1MCqj5-0004ET-00; Sat, 06 Jun 2009 09:54:03 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id C0A64C35B8; Sat,  6 Jun 2009 09:53:55 +0200 (CEST)
From:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH] SIBYTE: remove irritating printk from set_affinity
To:	linux-mips@linux-mips.org
cc:	ralf@linux-mips.org
Message-Id: <20090606075355.C0A64C35B8@solo.franken.de>
Date:	Sat,  6 Jun 2009 09:53:55 +0200 (CEST)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23305
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

set_affinity() will be called with cpui masks, which have more than one
cpu set. Instead of generating noise we now select the first set
cpu and use that for setting affinity.

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---

 arch/mips/sibyte/bcm1480/irq.c |    4 ----
 arch/mips/sibyte/sb1250/irq.c  |    5 -----
 2 files changed, 0 insertions(+), 9 deletions(-)

diff --git a/arch/mips/sibyte/bcm1480/irq.c b/arch/mips/sibyte/bcm1480/irq.c
index c147c4b..524dd36 100644
--- a/arch/mips/sibyte/bcm1480/irq.c
+++ b/arch/mips/sibyte/bcm1480/irq.c
@@ -116,10 +116,6 @@ static void bcm1480_set_affinity(unsigned int irq, const struct cpumask *mask)
 	unsigned long flags;
 	unsigned int irq_dirty;
 
-	if (cpumask_weight(mask) != 1) {
-		printk("attempted to set irq affinity for irq %d to multiple CPUs\n", irq);
-		return;
-	}
 	i = cpumask_first(mask);
 
 	/* Convert logical CPU to physical CPU */
diff --git a/arch/mips/sibyte/sb1250/irq.c b/arch/mips/sibyte/sb1250/irq.c
index 38cb998..a73ea36 100644
--- a/arch/mips/sibyte/sb1250/irq.c
+++ b/arch/mips/sibyte/sb1250/irq.c
@@ -111,11 +111,6 @@ static void sb1250_set_affinity(unsigned int irq, const struct cpumask *mask)
 
 	i = cpumask_first(mask);
 
-	if (cpumask_weight(mask) > 1) {
-		printk("attempted to set irq affinity for irq %d to multiple CPUs\n", irq);
-		return;
-	}
-
 	/* Convert logical CPU to physical CPU */
 	cpu = cpu_logical_map(i);
 
