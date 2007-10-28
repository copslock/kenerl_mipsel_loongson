Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 Oct 2007 20:23:49 +0000 (GMT)
Received: from relay01.mx.bawue.net ([193.7.176.67]:22736 "EHLO
	relay01.mx.bawue.net") by ftp.linux-mips.org with ESMTP
	id S20023618AbXJ1UX0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 28 Oct 2007 20:23:26 +0000
Received: from lagash (88-106-176-50.dynamic.dsl.as9105.com [88.106.176.50])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by relay01.mx.bawue.net (Postfix) with ESMTP id 8244448FB4;
	Sun, 28 Oct 2007 20:35:04 +0100 (CET)
Received: from ths by lagash with local (Exim 4.68)
	(envelope-from <ths@networkno.de>)
	id 1ImEen-0000UJ-2Z; Sun, 28 Oct 2007 20:22:49 +0000
Date:	Sun, 28 Oct 2007 20:22:49 +0000
From:	Thiemo Seufer <ths@networkno.de>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: Fix (workaround?) for BCM Bigsur
Message-ID: <20071028202249.GC22287@networkno.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-11)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17272
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Hello All,

the appended patchlet allows to boot current HEAD on a BCM1480.
Without it the kernel dies in an unhandled interrupt loop.


Thiemo


Signed-off-by: Thiemo Seufer <ths@networkno.de>
---
diff --git a/arch/mips/sibyte/bcm1480/time.c b/arch/mips/sibyte/bcm1480/time.c
index 610f025..9344c7b 100644
--- a/arch/mips/sibyte/bcm1480/time.c
+++ b/arch/mips/sibyte/bcm1480/time.c
@@ -142,7 +142,6 @@ void __cpuinit sb1480_clockevent_init(void)
 			R_BCM1480_IMR_INTERRUPT_MAP_BASE_H) + (irq << 3)));
 
 	bcm1480_unmask_irq(cpu, irq);
-	bcm1480_steal_irq(irq);
 
 	action->handler	= sibyte_counter_handler;
 	action->flags	= IRQF_DISABLED | IRQF_PERCPU;
