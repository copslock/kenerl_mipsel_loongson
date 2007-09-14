Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Sep 2007 13:26:41 +0100 (BST)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:20864 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20021569AbXINM0d (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 14 Sep 2007 13:26:33 +0100
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 255C2400EB;
	Fri, 14 Sep 2007 14:26:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id UdDNX7pzr3Oh; Fri, 14 Sep 2007 14:25:56 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id F35C840090;
	Fri, 14 Sep 2007 14:25:55 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l8ECPwNd000517;
	Fri, 14 Sep 2007 14:25:58 +0200
Date:	Fri, 14 Sep 2007 13:25:55 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Andrew Morton <akpm@linux-foundation.org>,
	Jeff Garzik <jgarzik@pobox.com>
cc:	netdev@vger.kernel.org, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sb1250-mac.c: Fix "stats" references
Message-ID: <Pine.LNX.4.64N.0709141316410.1926@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4272/Fri Sep 14 10:36:36 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16526
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

 Fix build errors resulting from a recent commit that added references to 
"stats" through "dev" from sbdma_rx_process() and sbdma_tx_process(), but 
no definitions of that variable.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
 This is probably the simplest fix possible, though at this point it is of 
question whether it is still "struct sbmac_softc *" that should be passed 
to these functions.  I'll leave it to another occasion though.

 Applies under patch-netdev-2.6.23-rc6-20070913-sb1250-mac-typedef-8.

 Please apply,

  Maciej

patch-netdev-2.6.23-rc6-20070913-sb1250-mac-fix-1
diff -up --recursive --new-file linux-netdev-2.6.23-rc6-20070913.macro/drivers/net/sb1250-mac.c linux-netdev-2.6.23-rc6-20070913/drivers/net/sb1250-mac.c
--- linux-netdev-2.6.23-rc6-20070913.macro/drivers/net/sb1250-mac.c	2007-09-13 17:27:52.000000000 +0000
+++ linux-netdev-2.6.23-rc6-20070913/drivers/net/sb1250-mac.c	2007-09-14 12:06:15.000000000 +0000
@@ -1187,6 +1187,7 @@ static void sbmac_netpoll(struct net_dev
 static int sbdma_rx_process(struct sbmac_softc *sc,sbmacdma_t *d,
                              int work_to_do, int poll)
 {
+	struct net_device *dev = sc->sbm_dev;
 	int curidx;
 	int hwidx;
 	sbdmadscr_t *dsc;
@@ -1348,6 +1349,7 @@ done:
 
 static void sbdma_tx_process(struct sbmac_softc *sc,sbmacdma_t *d, int poll)
 {
+	struct net_device *dev = sc->sbm_dev;
 	int curidx;
 	int hwidx;
 	sbdmadscr_t *dsc;
