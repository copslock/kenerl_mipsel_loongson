Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Oct 2007 21:18:17 +0100 (BST)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:60343 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20045593AbXJSUSI (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 19 Oct 2007 21:18:08 +0100
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 83BDF400A4;
	Fri, 19 Oct 2007 22:18:10 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id tNRJtS8vTVXH; Fri, 19 Oct 2007 22:18:05 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 26FFC40091;
	Fri, 19 Oct 2007 22:18:05 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l9JKI9xt021640;
	Fri, 19 Oct 2007 22:18:10 +0200
Date:	Fri, 19 Oct 2007 21:18:03 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Andrew Morton <akpm@linux-foundation.org>
cc:	linux-mips@linux-mips.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dz.c: Always check if it is safe to console_putchar()
Message-ID: <Pine.LNX.4.64N.0710192059530.13279@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4545/Wed Oct 17 23:05:57 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17138
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

 Polled transmission is tricky enough with the DZ11 design.  While "loop" 
is set to a high value, conceptually you are not allowed to transmit 
without checking whether the device offers the right transmission line 
(yes, it is the device that selects the line -- the driver has no control 
over it other than disabling the transmitter offered if it is the wrong 
one), so the loop has to be run at least once.

 Well, the '1977 or PDP11 view of how serial lines should be handled...  
Except that the serial interface used to be quite an impressive board back 
then rather than chip.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
 Tested with checkpatch.pl and at the run-time -- MIPS/Linux on a 
DECstation 5000/200.

 Please apply,

  Maciej

patch-mips-2.6.18-20060920-dz-putchar-0
diff -up --recursive --new-file linux-mips-2.6.18-20060920.macro/drivers/serial/dz.c linux-mips-2.6.18-20060920/drivers/serial/dz.c
--- linux-mips-2.6.18-20060920.macro/drivers/serial/dz.c	2006-11-23 05:17:01.000000000 +0000
+++ linux-mips-2.6.18-20060920/drivers/serial/dz.c	2007-01-14 00:07:02.000000000 +0000
@@ -686,7 +686,7 @@ static void dz_console_putchar(struct ua
 	iob();
 	spin_unlock_irqrestore(&dport->port.lock, flags);
 
-	while (loops--) {
+	do {
 		trdy = dz_in(dport, DZ_CSR);
 		if (!(trdy & DZ_TRDY))
 			continue;
@@ -697,7 +697,7 @@ static void dz_console_putchar(struct ua
 		dz_out(dport, DZ_TCR, mask);
 		iob();
 		udelay(2);
-	}
+	} while (loops--);
 
 	if (loops)				/* Cannot send otherwise. */
 		dz_out(dport, DZ_TDR, ch);
