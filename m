Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Oct 2007 21:44:24 +0100 (BST)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:7575 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20045663AbXJSUoO (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 19 Oct 2007 21:44:14 +0100
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id BD3F2400D5;
	Fri, 19 Oct 2007 22:44:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id dHPynmX6bhDg; Fri, 19 Oct 2007 22:44:10 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 0A2F6400A4;
	Fri, 19 Oct 2007 22:44:10 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l9JKiFQw026530;
	Fri, 19 Oct 2007 22:44:15 +0200
Date:	Fri, 19 Oct 2007 21:44:08 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Andrew Morton <akpm@linux-foundation.org>
cc:	linux-mips@linux-mips.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dz.c: Fix locking issues
Message-ID: <Pine.LNX.4.64N.0710192139550.13279@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4545/Wed Oct 17 23:05:57 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17143
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

 The ->start_tx(), ->stop_tx() and ->stop_rx() backends are called with 
the port's lock already taken.  Remove locking from within them and wrap 
around calls as necessary.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
 Tested with checkpatch.pl and at the run-time -- MIPS/Linux on a 
DECstation 5000/200.

 Please apply,

  Maciej

patch-mips-2.6.23-rc5-20070904-dz-lock-1
diff -up --recursive --new-file linux-mips-2.6.23-rc5-20070904.macro/drivers/serial/dz.c linux-mips-2.6.23-rc5-20070904/drivers/serial/dz.c
--- linux-mips-2.6.23-rc5-20070904.macro/drivers/serial/dz.c	2007-05-02 04:56:10.000000000 +0000
+++ linux-mips-2.6.23-rc5-20070904/drivers/serial/dz.c	2007-10-13 20:10:37.000000000 +0000
@@ -105,37 +105,28 @@ static void dz_stop_tx(struct uart_port 
 {
 	struct dz_port *dport = (struct dz_port *)uport;
 	unsigned short tmp, mask = 1 << dport->port.line;
-	unsigned long flags;
 
-	spin_lock_irqsave(&dport->port.lock, flags);
 	tmp = dz_in(dport, DZ_TCR);	/* read the TX flag */
 	tmp &= ~mask;			/* clear the TX flag */
 	dz_out(dport, DZ_TCR, tmp);
-	spin_unlock_irqrestore(&dport->port.lock, flags);
 }
 
 static void dz_start_tx(struct uart_port *uport)
 {
 	struct dz_port *dport = (struct dz_port *)uport;
 	unsigned short tmp, mask = 1 << dport->port.line;
-	unsigned long flags;
 
-	spin_lock_irqsave(&dport->port.lock, flags);
 	tmp = dz_in(dport, DZ_TCR);	/* read the TX flag */
 	tmp |= mask;			/* set the TX flag */
 	dz_out(dport, DZ_TCR, tmp);
-	spin_unlock_irqrestore(&dport->port.lock, flags);
 }
 
 static void dz_stop_rx(struct uart_port *uport)
 {
 	struct dz_port *dport = (struct dz_port *)uport;
-	unsigned long flags;
 
-	spin_lock_irqsave(&dport->port.lock, flags);
 	dport->cflag &= ~DZ_CREAD;
 	dz_out(dport, DZ_LPR, dport->cflag | dport->port.line);
-	spin_unlock_irqrestore(&dport->port.lock, flags);
 }
 
 static void dz_enable_ms(struct uart_port *port)
@@ -265,7 +256,9 @@ static inline void dz_transmit_chars(str
 	}
 	/* If nothing to do or stopped or hardware stopped. */
 	if (uart_circ_empty(xmit) || uart_tx_stopped(&dport->port)) {
+		spin_lock(&dport->port.lock);
 		dz_stop_tx(&dport->port);
+		spin_unlock(&dport->port.lock);
 		return;
 	}
 
@@ -282,8 +275,11 @@ static inline void dz_transmit_chars(str
 		uart_write_wakeup(&dport->port);
 
 	/* Are we are done. */
-	if (uart_circ_empty(xmit))
+	if (uart_circ_empty(xmit)) {
+		spin_lock(&dport->port.lock);
 		dz_stop_tx(&dport->port);
+		spin_unlock(&dport->port.lock);
+	}
 }
 
 /*
@@ -414,7 +410,12 @@ static int dz_startup(struct uart_port *
  */
 static void dz_shutdown(struct uart_port *uport)
 {
-	dz_stop_tx(uport);
+	struct dz_port *dport = (struct dz_port *)uport;
+	unsigned long flags;
+
+	spin_lock_irqsave(&dport->port.lock, flags);
+	dz_stop_tx(&dport->port);
+	spin_unlock_irqrestore(&dport->port.lock, flags);
 }
 
 /*
