Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Oct 2007 15:10:53 +0100 (BST)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:26067 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20022627AbXJYOKO (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 25 Oct 2007 15:10:14 +0100
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id CECC3400B9;
	Thu, 25 Oct 2007 16:09:43 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id RA8sijIXosOx; Thu, 25 Oct 2007 16:09:36 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 3C4B54007F;
	Thu, 25 Oct 2007 16:09:36 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l9PE9dpw017973;
	Thu, 25 Oct 2007 16:09:40 +0200
Date:	Thu, 25 Oct 2007 15:09:35 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Andrew Morton <akpm@linux-foundation.org>
cc:	linux-mips@linux-mips.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dz.c: Use a helper to cast from "struct uart_port *"
Message-ID: <Pine.LNX.4.64N.0710251458190.24086@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4594/Thu Oct 25 14:45:14 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17212
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

 Replace all casts from "struct uart_port *" to "struct dz_port *" with a 
construct based on container_of().  This makes the conversion work 
irrespective of where the former struct is located within the latter.

 By popular request I have implemented it as an inline function rather 
than a macro this time.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
 Tested with checkpatch.pl and at the run-time -- MIPS/Linux on a
DECstation 5000/200.

 Please apply,

  Maciej

patch-mips-2.6.23-rc5-20070904-dz-to_dport-2
diff -up --recursive --new-file linux-mips-2.6.23-rc5-20070904.macro/drivers/serial/dz.c linux-mips-2.6.23-rc5-20070904/drivers/serial/dz.c
--- linux-mips-2.6.23-rc5-20070904.macro/drivers/serial/dz.c	2007-10-13 12:57:52.000000000 +0000
+++ linux-mips-2.6.23-rc5-20070904/drivers/serial/dz.c	2007-10-13 19:48:07.000000000 +0000
@@ -65,6 +65,11 @@ struct dz_port {
 
 static struct dz_port dz_ports[DZ_NB_PORT];
 
+static inline struct dz_port *to_dport(struct uart_port *uport)
+{
+	return container_of(uport, struct dz_port, port);
+}
+
 /*
  * ------------------------------------------------------------
  * dz_in () and dz_out ()
@@ -103,7 +108,7 @@ static inline void dz_out(struct dz_port
 
 static void dz_stop_tx(struct uart_port *uport)
 {
-	struct dz_port *dport = (struct dz_port *)uport;
+	struct dz_port *dport = to_dport(uport);
 	unsigned short tmp, mask = 1 << dport->port.line;
 
 	tmp = dz_in(dport, DZ_TCR);	/* read the TX flag */
@@ -113,7 +118,7 @@ static void dz_stop_tx(struct uart_port 
 
 static void dz_start_tx(struct uart_port *uport)
 {
-	struct dz_port *dport = (struct dz_port *)uport;
+	struct dz_port *dport = to_dport(uport);
 	unsigned short tmp, mask = 1 << dport->port.line;
 
 	tmp = dz_in(dport, DZ_TCR);	/* read the TX flag */
@@ -123,7 +128,7 @@ static void dz_start_tx(struct uart_port
 
 static void dz_stop_rx(struct uart_port *uport)
 {
-	struct dz_port *dport = (struct dz_port *)uport;
+	struct dz_port *dport = to_dport(uport);
 
 	dport->cflag &= ~DZ_CREAD;
 	dz_out(dport, DZ_LPR, dport->cflag | dport->port.line);
@@ -347,7 +352,7 @@ static unsigned int dz_get_mctrl(struct 
 	/*
 	 * FIXME: Handle the 3100/5000 as appropriate. --macro
 	 */
-	struct dz_port *dport = (struct dz_port *)uport;
+	struct dz_port *dport = to_dport(uport);
 	unsigned int mctrl = TIOCM_CAR | TIOCM_DSR | TIOCM_CTS;
 
 	if (dport->port.line == DZ_MODEM) {
@@ -363,7 +368,7 @@ static void dz_set_mctrl(struct uart_por
 	/*
 	 * FIXME: Handle the 3100/5000 as appropriate. --macro
 	 */
-	struct dz_port *dport = (struct dz_port *)uport;
+	struct dz_port *dport = to_dport(uport);
 	unsigned short tmp;
 
 	if (dport->port.line == DZ_MODEM) {
@@ -385,7 +390,7 @@ static void dz_set_mctrl(struct uart_por
  */
 static int dz_startup(struct uart_port *uport)
 {
-	struct dz_port *dport = (struct dz_port *)uport;
+	struct dz_port *dport = to_dport(uport);
 	unsigned long flags;
 	unsigned short tmp;
 
@@ -411,7 +416,7 @@ static int dz_startup(struct uart_port *
  */
 static void dz_shutdown(struct uart_port *uport)
 {
-	struct dz_port *dport = (struct dz_port *)uport;
+	struct dz_port *dport = to_dport(uport);
 	unsigned long flags;
 
 	spin_lock_irqsave(&dport->port.lock, flags);
@@ -433,7 +438,7 @@ static void dz_shutdown(struct uart_port
  */
 static unsigned int dz_tx_empty(struct uart_port *uport)
 {
-	struct dz_port *dport = (struct dz_port *)uport;
+	struct dz_port *dport = to_dport(uport);
 	unsigned short tmp, mask = 1 << dport->port.line;
 
 	tmp = dz_in(dport, DZ_TCR);
@@ -448,7 +453,7 @@ static void dz_break_ctl(struct uart_por
 	 * FIXME: Can't access BREAK bits in TDR easily;
 	 * reuse the code for polled TX. --macro
 	 */
-	struct dz_port *dport = (struct dz_port *)uport;
+	struct dz_port *dport = to_dport(uport);
 	unsigned long flags;
 	unsigned short tmp, mask = 1 << dport->port.line;
 
@@ -465,7 +470,7 @@ static void dz_break_ctl(struct uart_por
 static void dz_set_termios(struct uart_port *uport, struct ktermios *termios,
 			   struct ktermios *old_termios)
 {
-	struct dz_port *dport = (struct dz_port *)uport;
+	struct dz_port *dport = to_dport(uport);
 	unsigned long flags;
 	unsigned int cflag, baud;
 
@@ -672,7 +677,7 @@ static void dz_reset(struct dz_port *dpo
  */
 static void dz_console_putchar(struct uart_port *uport, int ch)
 {
-	struct dz_port *dport = (struct dz_port *)uport;
+	struct dz_port *dport = to_dport(uport);
 	unsigned long flags;
 	unsigned short csr, tcr, trdy, mask;
 	int loops = 10000;
