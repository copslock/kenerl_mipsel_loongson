Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Feb 2008 14:21:19 +0000 (GMT)
Received: from relay01.mx.bawue.net ([193.7.176.67]:27838 "EHLO
	relay01.mx.bawue.net") by ftp.linux-mips.org with ESMTP
	id S28583690AbYBYOVQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 25 Feb 2008 14:21:16 +0000
Received: from lagash (intrt.mips-uk.com [194.74.144.130])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by relay01.mx.bawue.net (Postfix) with ESMTP id 50EA048917;
	Mon, 25 Feb 2008 15:21:11 +0100 (CET)
Received: from ths by lagash with local (Exim 4.69)
	(envelope-from <ths@networkno.de>)
	id 1JTeCg-0000y7-Nx; Mon, 25 Feb 2008 14:21:14 +0000
Date:	Mon, 25 Feb 2008 14:21:14 +0000
From:	Thiemo Seufer <ths@networkno.de>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [MIPS, 2.6.16, PATCH] Re-enable sync instruction for non-R2 CPUs
Message-ID: <20080225142112.GA25530@networkno.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18294
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

This patch re-enables the use of sync instructions for non-R2 CPUs.
It is only relevant for the linux-2.6.16-stable branch.


Signed-off-by: Thiemo Seufer <ths@networkno.de>

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 3995d45..b3739ed 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1585,12 +1585,12 @@ config CPU_MIPSR2_IRQ_EI
 	   controller to allow fast dispatching from many possible interrupt
 	   sources. Say N unless you know that external interrupt support is
 	   required.
+endmenu
 
 config CPU_HAS_SYNC
 	bool
 	depends on !CPU_R3000
 	default y
-endmenu
 
 #
 # Use the generic interrupt handling code in kernel/irq/:
