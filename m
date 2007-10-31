Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Oct 2007 16:27:12 +0000 (GMT)
Received: from relay01.mx.bawue.net ([193.7.176.67]:11452 "EHLO
	relay01.mx.bawue.net") by ftp.linux-mips.org with ESMTP
	id S28576008AbXJaQ1D (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 31 Oct 2007 16:27:03 +0000
Received: from lagash (intrt.mips-uk.com [194.74.144.130])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by relay01.mx.bawue.net (Postfix) with ESMTP id 15D0D490D8;
	Wed, 31 Oct 2007 17:25:35 +0100 (CET)
Received: from ths by lagash with local (Exim 4.68)
	(envelope-from <ths@networkno.de>)
	id 1InGPA-0000Ub-PR; Wed, 31 Oct 2007 16:26:56 +0000
Date:	Wed, 31 Oct 2007 16:26:56 +0000
From:	Thiemo Seufer <ths@networkno.de>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Fix SWARM build failure
Message-ID: <20071031162656.GJ7712@networkno.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-11)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17334
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

This fixes a typo, the warning lets the build fail.


Thiemo


Signed-off-by: Thiemo Seufer <ths@networkno.de>
---
diff --git a/arch/mips/sibyte/sb1250/time.c b/arch/mips/sibyte/sb1250/time.c
index e224fe7..f455ac1 100644
--- a/arch/mips/sibyte/sb1250/time.c
+++ b/arch/mips/sibyte/sb1250/time.c
@@ -155,7 +155,7 @@ void __cpuinit sb1250_clockevent_init(void)
 	action->flags	= IRQF_DISABLED | IRQF_PERCPU;
 	action->name	= name;
 	action->dev_id	= cd;
-	setup_irq(irq, &action);
+	setup_irq(irq, action);
 }
 
 /*
