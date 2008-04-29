Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Apr 2008 20:34:43 +0100 (BST)
Received: from rtsoft3.corbina.net ([85.21.88.6]:437 "EHLO
	buildserver.ru.mvista.com") by ftp.linux-mips.org with ESMTP
	id S28792848AbYD2Ted (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 29 Apr 2008 20:34:33 +0100
Received: from wasted.dev.rtsoft.ru (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP
	id 443488815; Wed, 30 Apr 2008 00:34:26 +0500 (SAMST)
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
To:	ralf@linux-mips.org
Subject: [PATCH] Pb1000: bury the remnants of the PCI code (part 2)
Date:	Tue, 29 Apr 2008 23:33:47 +0400
User-Agent: KMail/1.5
Cc:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200804292333.47099.sshtylyov@ru.mvista.com>
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19053
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
Here's the fragment I missed in the initial patch. Combine them if possible...

 arch/mips/au1000/pb1000/board_setup.c |    7 -------
 1 files changed, 7 deletions(-)

Index: linux-2.6/arch/mips/au1000/pb1000/board_setup.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/pb1000/board_setup.c
+++ linux-2.6/arch/mips/au1000/pb1000/board_setup.c
@@ -153,13 +153,6 @@ void __init board_setup(void)
 	au_writel(0x280E3D07, MEM_STTIME3); /* 250ns cycle time */
 	au_writel(0x10000000, MEM_STADDR3); /* any PCMCIA select */
 
-#ifdef CONFIG_PCI
-	au_writel(0, PCI_BRIDGE_CONFIG); // set extend byte to 0
-	au_writel(0, SDRAM_MBAR);        // set mbar to 0
-	au_writel(0x2, SDRAM_CMD);       // enable memory accesses
-	au_sync_delay(1);
-#endif
-
 	/* Enable Au1000 BCLK switching - note: sed1356 must not use
 	 * its BCLK (Au1000 LCLK) for any timings */
 	switch (prid & 0x000000FF)
