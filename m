Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Oct 2007 18:18:26 +0100 (BST)
Received: from elvis.franken.de ([193.175.24.41]:34483 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20036916AbXJQRSR (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 17 Oct 2007 18:18:17 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1IiCU7-000810-00; Wed, 17 Oct 2007 19:15:07 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id D68FEC3589; Wed, 17 Oct 2007 19:15:17 +0200 (CEST)
Date:	Wed, 17 Oct 2007 19:15:17 +0200
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] IP22 fix hang due to messing with timer interrupt handler
Message-ID: <20071017171517.GA16678@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17101
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

As IP22 is now using do_IRQ for timer interrupt, don't mess with
interrupt handler any longer

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---

diff --git a/arch/mips/sgi-ip22/ip22-time.c b/arch/mips/sgi-ip22/ip22-time.c
index 9b9bffd..10e5054 100644
--- a/arch/mips/sgi-ip22/ip22-time.c
+++ b/arch/mips/sgi-ip22/ip22-time.c
@@ -192,12 +192,3 @@ void indy_8254timer_irq(void)
 	ArcEnterInteractiveMode();
 	irq_exit();
 }
-
-void __init plat_timer_setup(struct irqaction *irq)
-{
-	/* over-write the handler, we use our own way */
-	irq->handler = no_action;
-
-	/* setup irqaction */
-	setup_irq(SGI_TIMER_IRQ, irq);
-}


-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
