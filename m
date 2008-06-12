Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jun 2008 23:44:19 +0100 (BST)
Received: from kirk.serum.com.pl ([213.77.9.205]:4079 "EHLO serum.com.pl")
	by ftp.linux-mips.org with ESMTP id S28581217AbYFLWoR (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 12 Jun 2008 23:44:17 +0100
Received: from serum.com.pl (IDENT:macro@localhost [127.0.0.1])
	by serum.com.pl (8.12.11/8.12.11) with ESMTP id m5CMhlgw025094;
	Fri, 13 Jun 2008 00:43:47 +0200
Received: from localhost (macro@localhost)
	by serum.com.pl (8.12.11/8.12.11/Submit) with ESMTP id m5CMhlaj025090;
	Thu, 12 Jun 2008 23:43:47 +0100
Date:	Thu, 12 Jun 2008 23:43:47 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Andrew Morton <akpm@linux-foundation.org>
cc:	linux-serial@vger.kernel.org, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] serial: DZ11: Avoid a hang at console switch-over
Message-ID: <Pine.LNX.4.55.0806122328350.23634@cliff.in.clinika.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19528
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

 Changes to the generic console support code that happened a while ago
introduced a scenario where the initial console is used in parallel with
the final console during a brief period when switching between the two is
in progress.  During that time a message about the switch-over is printed.

 With some combinations of chips, firmware and drivers, such as the DEC
DZ11 clone used with the DECstation, a hang may happen because the
firmware used for the initial console may not expect the state of the chip
after it has been initialised by the driver.

 This is a workaround for the DZ11 which reuses the power-management
callback to keep the transmitter of the line associated with the console
enabled.  It reflects the consensus reached in a discussion a while ago.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
patch-mips-2.6.23-rc5-20070904-dz-pm-1
diff -up --recursive --new-file linux-mips-2.6.23-rc5-20070904.macro/drivers/serial/dz.c linux-mips-2.6.23-rc5-20070904/drivers/serial/dz.c
--- linux-mips-2.6.23-rc5-20070904.macro/drivers/serial/dz.c	2007-10-14 00:49:58.000000000 +0000
+++ linux-mips-2.6.23-rc5-20070904/drivers/serial/dz.c	2007-10-14 01:46:41.000000000 +0000
@@ -637,6 +637,26 @@ static void dz_set_termios(struct uart_p
 	spin_unlock_irqrestore(&dport->port.lock, flags);
 }
 
+/*
+ * Hack alert!
+ * Required solely so that the initial PROM-based console
+ * works undisturbed in parallel with this one.
+ */
+static void dz_pm(struct uart_port *uport, unsigned int state,
+		  unsigned int oldstate)
+{
+	struct dz_port *dport = to_dport(uport);
+	unsigned long flags;
+
+	spin_lock_irqsave(&dport->port.lock, flags);
+	if (state < 3)
+		dz_start_tx(&dport->port);
+	else
+		dz_stop_tx(&dport->port);
+	spin_unlock_irqrestore(&dport->port.lock, flags);
+}
+
+
 static const char *dz_type(struct uart_port *uport)
 {
 	return "DZ";
@@ -733,6 +753,7 @@ static struct uart_ops dz_ops = {
 	.startup	= dz_startup,
 	.shutdown	= dz_shutdown,
 	.set_termios	= dz_set_termios,
+	.pm		= dz_pm,
 	.type		= dz_type,
 	.release_port	= dz_release_port,
 	.request_port	= dz_request_port,
@@ -856,7 +877,10 @@ static int __init dz_console_setup(struc
 	if (ret)
 		return ret;
 
+	spin_lock_init(&dport->port.lock);	/* For dz_pm().  */
+
 	dz_reset(dport);
+	dz_pm(uport, 0, -1);
 
 	if (options)
 		uart_parse_options(options, &baud, &parity, &bits, &flow);
