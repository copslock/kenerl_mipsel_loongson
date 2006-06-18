Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Jun 2006 05:18:11 +0100 (BST)
Received: from bender.bawue.de ([193.7.176.20]:41608 "HELO bender.bawue.de")
	by ftp.linux-mips.org with SMTP id S3466132AbWFRESC (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 18 Jun 2006 05:18:02 +0100
Received: from lagash (88-106-172-197.dynamic.dsl.as9105.com [88.106.172.197])
	(using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by bender.bawue.de (Postfix) with ESMTP
	id 462A844156; Sun, 18 Jun 2006 06:18:01 +0200 (MEST)
Received: from ths by lagash with local (Exim 4.62)
	(envelope-from <ths@networkno.de>)
	id 1FrojS-00027m-1a; Sun, 18 Jun 2006 05:17:54 +0100
Date:	Sun, 18 Jun 2006 05:17:54 +0100
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Fix bcm1480 compile
Message-ID: <20060618041753.GB4480@networkno.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11755
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Hello All,

the appended patch fixes compilation for bcm1480, a hpt is only
available on sb1250/bcm112x.


Thiemo


Signed-off-by: Thiemo Seufer <ths@networkno.de>

diff --git a/arch/mips/sibyte/swarm/setup.c b/arch/mips/sibyte/swarm/setup.c
index 4b5f74f..be229a8 100644
--- a/arch/mips/sibyte/swarm/setup.c
+++ b/arch/mips/sibyte/swarm/setup.c
@@ -72,8 +72,10 @@ const char *get_system_type(void)
 
 void __init swarm_time_init(void)
 {
+#if defined(CONFIG_SIBYTE_SB1250) || defined(CONFIG_SIBYTE_BCM112X)
 	/* Setup HPT */
 	sb1250_hpt_setup();
+#endif
 }
 
 void __init swarm_timer_setup(struct irqaction *irq)
