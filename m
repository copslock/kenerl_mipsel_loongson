Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Oct 2006 17:34:42 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:24331 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20039276AbWJEQeg (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 5 Oct 2006 17:34:36 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id A79A8F5FDD;
	Thu,  5 Oct 2006 18:34:22 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s-qvGSfezdBL; Thu,  5 Oct 2006 18:34:22 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 433ABF5B22;
	Thu,  5 Oct 2006 18:34:22 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.1) with ESMTP id k95GYWsF007564;
	Thu, 5 Oct 2006 18:34:32 +0200
Date:	Thu, 5 Oct 2006 17:34:27 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
	Ralf Baechle <ralf@linux-mips.org>
cc:	netdev@vger.kernel.org, linux-mips@linux-mips.org
Subject: [PATCH 2.6.18 8/6]: sb1250-mac: Fix an incorrect use of kfree()
Message-ID: <Pine.LNX.4.64N.0610051729140.22085@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.88.4/1997/Wed Oct  4 17:20:43 2006 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12810
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

 The pointer obtained by kmalloc() is treated with ALIGN() before passing 
it to kfree().  This may or may not cause problems depending on the 
minimum alignment enforced by kmalloc() and is ugly anyway.  This change 
records the original pointer returned by kmalloc() so that kfree() may 
safely use it.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---

 This applies on top of the "typedef" change (7/6).  Please consider.

  Maciej

patch-mips-2.6.18-20060920-sb1250-mac-kfree-0
diff -up --recursive --new-file linux-mips-2.6.18-20060920.macro/drivers/net/sb1250-mac.c linux-mips-2.6.18-20060920/drivers/net/sb1250-mac.c
--- linux-mips-2.6.18-20060920.macro/drivers/net/sb1250-mac.c	2006-10-05 16:18:41.000000000 +0000
+++ linux-mips-2.6.18-20060920/drivers/net/sb1250-mac.c	2006-10-04 23:07:27.000000000 +0000
@@ -220,6 +220,7 @@ struct sbmacdma {
 	/*
 	 * This stuff is for maintenance of the ring
 	 */
+	void			*sbdma_dscrtable_un;
 	struct sbdmadscr	*sbdma_dscrtable;
 						/* base of descriptor table */
 	struct sbdmadscr	*sbdma_dscrtable_end;
@@ -640,15 +641,16 @@ static void sbdma_initctx(struct sbmacdm
 
 	d->sbdma_maxdescr = maxdescr;
 
-	d->sbdma_dscrtable = kmalloc((d->sbdma_maxdescr + 1) *
-				     sizeof(*d->sbdma_dscrtable), GFP_KERNEL);
+	d->sbdma_dscrtable_un = kmalloc((d->sbdma_maxdescr + 1) *
+					sizeof(*d->sbdma_dscrtable),
+					GFP_KERNEL);
 
 	/*
 	 * The descriptor table must be aligned to at least 16 bytes or the
 	 * MAC will corrupt it.
 	 */
 	d->sbdma_dscrtable = (struct sbdmadscr *)
-			     ALIGN((unsigned long)d->sbdma_dscrtable,
+			     ALIGN((unsigned long)d->sbdma_dscrtable_un,
 				   sizeof(*d->sbdma_dscrtable));
 
 	memset(d->sbdma_dscrtable, 0,
@@ -1309,9 +1311,9 @@ static int sbmac_initctx(struct sbmac_so
 
 static void sbdma_uninitctx(struct sbmacdma *d)
 {
-	if (d->sbdma_dscrtable) {
-		kfree(d->sbdma_dscrtable);
-		d->sbdma_dscrtable = NULL;
+	if (d->sbdma_dscrtable_un) {
+		kfree(d->sbdma_dscrtable_un);
+		d->sbdma_dscrtable = d->sbdma_dscrtable_un = NULL;
 	}
 
 	if (d->sbdma_ctxtable) {
