Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Nov 2006 13:06:30 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:13318 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20037693AbWK3NGY (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 30 Nov 2006 13:06:24 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 544DCE1C9C;
	Thu, 30 Nov 2006 14:06:11 +0100 (CET)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tRPpp4yz8kqj; Thu, 30 Nov 2006 14:06:10 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 99FADE1C61;
	Thu, 30 Nov 2006 14:06:10 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id kAUD6ItH009407;
	Thu, 30 Nov 2006 14:06:18 +0100
Date:	Thu, 30 Nov 2006 13:06:15 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>
cc:	netdev@vger.kernel.org, linux-mips@linux-mips.org
Subject: [PATCH 2.6.18] declance: Fix RX ownership handover
Message-ID: <Pine.LNX.4.64N.0611301257300.1757@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.88.6/2263/Thu Nov 30 07:51:08 2006 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13278
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

 The change for PMAD support introduced a bug, where the ownership of RX 
descriptors was given back to the LANCE in the wrong way.  Occasional 
lockups would happen as a result.  This is a fix for this problem.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
 Tested with the onboard LANCE of a DECstation 5000/133.

 Please apply.

  Maciej

patch-mips-2.6.18-20060920-pmax-lance-rx-fix-0
diff -up --recursive --new-file linux-mips-2.6.18-20060920.macro/drivers/net/declance.c linux-mips-2.6.18-20060920/drivers/net/declance.c
--- linux-mips-2.6.18-20060920.macro/drivers/net/declance.c	2006-11-23 02:55:34.000000000 +0000
+++ linux-mips-2.6.18-20060920/drivers/net/declance.c	2006-11-30 02:26:34.000000000 +0000
@@ -628,7 +628,6 @@ static int lance_rx(struct net_device *d
 		/* Return the packet to the pool */
 		*rds_ptr(rd, mblength, lp->type) = 0;
 		*rds_ptr(rd, length, lp->type) = -RX_BUFF_SIZE | 0xf000;
-		*rds_ptr(rd, rmd1, lp->type) = LE_R1_OWN;
 		*rds_ptr(rd, rmd1, lp->type) =
 			((lp->rx_buf_ptr_lnc[entry] >> 16) & 0xff) | LE_R1_OWN;
 		lp->rx_new = (entry + 1) & RX_RING_MOD_MASK;
