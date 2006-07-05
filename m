Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Jul 2006 14:33:16 +0100 (BST)
Received: from bender.bawue.de ([193.7.176.20]:3806 "EHLO bender.bawue.de")
	by ftp.linux-mips.org with ESMTP id S8133380AbWGENdH (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 5 Jul 2006 14:33:07 +0100
Received: from lagash (mipsfw.mips-uk.com [194.74.144.146])
	(using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by bender.bawue.de (Postfix) with ESMTP
	id 1B17A44672; Wed,  5 Jul 2006 15:33:02 +0200 (MEST)
Received: from ths by lagash with local (Exim 4.62)
	(envelope-from <ths@networkno.de>)
	id 1Fy7Up-0008Gu-Na; Wed, 05 Jul 2006 14:32:51 +0100
Date:	Wed, 5 Jul 2006 14:32:51 +0100
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Fix fatal typo for bcm1480
Message-ID: <20060705133251.GD29112@networkno.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11915
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Hello All,

this fixes a fatal typo which crept in the rewritten interrupt handler.


Thiemo


Signed-off-by: Thiemo Seufer <ths@networkno.de>


--- a/arch/mips/sibyte/bcm1480/irq.c
+++ b/arch/mips/sibyte/bcm1480/irq.c
@@ -533,7 +533,7 @@ #endif
 		mask_l = __raw_readq(
 			IOADDR(base + R_BCM1480_IMR_INTERRUPT_STATUS_BASE_L));
 
-		if (!mask_h) {
+		if (mask_h) {
 			if (mask_h ^ 1)
 				do_IRQ(63 - dclz(mask_h), regs);
 			else
