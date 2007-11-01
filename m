Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Nov 2007 10:40:03 +0000 (GMT)
Received: from elvis.franken.de ([193.175.24.41]:58551 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20026568AbXKAKjy (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 1 Nov 2007 10:39:54 +0000
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1InXPo-0003Sa-00; Thu, 01 Nov 2007 11:36:44 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
	id 66B02FA733; Thu,  1 Nov 2007 11:36:42 +0100 (CET)
Date:	Thu, 1 Nov 2007 11:36:42 +0100
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] SNI: register a02r clockevent; don't use PIT timer
Message-ID: <20071101103642.GA28146@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17346
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

Register A20R clockevent
Remove PIT timer setup because it doesn't work 

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---

diff --git a/arch/mips/sni/time.c b/arch/mips/sni/time.c
index 60bc62e..6f339af 100644
--- a/arch/mips/sni/time.c
+++ b/arch/mips/sni/time.c
@@ -1,6 +1,7 @@
 #include <linux/types.h>
 #include <linux/interrupt.h>
 #include <linux/time.h>
+#include <linux/clockchips.h>
 
 #include <asm/i8253.h>
 #include <asm/sni.h>
@@ -80,7 +81,7 @@ static void __init sni_a20r_timer_setup(void)
 	unsigned int cpu = smp_processor_id();
 
 	cd->cpumask             = cpumask_of_cpu(cpu);
-
+	clockevents_register_device(cd);
 	action->dev_id = cd;
 	setup_irq(SNI_A20R_IRQ_TIMER, &a20r_irqaction);
 }
@@ -169,8 +170,6 @@ void __init plat_time_init(void)
 
 	mips_hpt_frequency = r4k_tick * HZ;
 
-	setup_pit_timer();
-
 	switch (sni_brd_type) {
 	case SNI_BRD_10:
 	case SNI_BRD_10NEW:


-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
