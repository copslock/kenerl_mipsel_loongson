Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Jul 2007 13:23:11 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:5650 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20022902AbXGTMXI (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 20 Jul 2007 13:23:08 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id C06A8E1C83;
	Fri, 20 Jul 2007 14:23:03 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9Fwis7CBTWy9; Fri, 20 Jul 2007 14:23:03 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 6A3F8E1C65;
	Fri, 20 Jul 2007 14:23:03 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l6KCNAGV027671;
	Fri, 20 Jul 2007 14:23:10 +0200
Date:	Fri, 20 Jul 2007 13:23:06 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Andrew Morton <akpm@linux-foundation.org>
cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	sibyte-users@bitmover.com
Subject: [PATCH] sb1250-duart: __maybe_unused, etc. fixes
Message-ID: <Pine.LNX.4.64N.0707201314300.7402@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.1/3702/Fri Jul 20 11:04:11 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15830
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

 This is a set of small fixes addressing points raised with the original 
driver submission.  In particular, __maybe_unused is used rather than a 
local hack and sbd_ops is made const.  Additionally I have made two local 
string variables automatic as rodata space was wasted for pointers 
unnecessarily.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
Hi,

 This should be obvious.  It builds.  Please apply.

  Maciej

patch-mips-2.6.22-20070710-serial-sb1250-duart-fix-0
diff -up --recursive --new-file linux-mips-2.6.22-20070710.macro/drivers/serial/sb1250-duart.c linux-mips-2.6.22-20070710/drivers/serial/sb1250-duart.c
--- linux-mips-2.6.22-20070710.macro/drivers/serial/sb1250-duart.c	2007-07-11 02:21:42.000000000 +0000
+++ linux-mips-2.6.22-20070710/drivers/serial/sb1250-duart.c	2007-07-19 23:46:33.000000000 +0000
@@ -25,6 +25,7 @@
 #define SUPPORT_SYSRQ
 #endif
 
+#include <linux/compiler.h>
 #include <linux/console.h>
 #include <linux/delay.h>
 #include <linux/errno.h>
@@ -103,8 +104,6 @@ struct sbd_duart {
 
 static struct sbd_duart sbd_duarts[DUART_MAX_CHIP];
 
-#define __unused __attribute__((__unused__))
-
 
 /*
  * Reading and writing SB1250 DUART registers.
@@ -204,12 +203,12 @@ static int sbd_receive_drain(struct sbd_
 	return loops;
 }
 
-static int __unused sbd_transmit_ready(struct sbd_port *sport)
+static int __maybe_unused sbd_transmit_ready(struct sbd_port *sport)
 {
 	return read_sbdchn(sport, R_DUART_STATUS) & M_DUART_TX_RDY;
 }
 
-static int __unused sbd_transmit_drain(struct sbd_port *sport)
+static int __maybe_unused sbd_transmit_drain(struct sbd_port *sport)
 {
 	int loops = 10000;
 
@@ -664,7 +663,7 @@ static void sbd_release_port(struct uart
 
 static int sbd_map_port(struct uart_port *uport)
 {
-	static const char *err = KERN_ERR "sbd: Cannot map MMIO\n";
+	const char *err = KERN_ERR "sbd: Cannot map MMIO\n";
 	struct sbd_port *sport = to_sport(uport);
 	struct sbd_duart *duart = sport->duart;
 
@@ -691,8 +690,7 @@ static int sbd_map_port(struct uart_port
 
 static int sbd_request_port(struct uart_port *uport)
 {
-	static const char *err = KERN_ERR
-				 "sbd: Unable to reserve MMIO resource\n";
+	const char *err = KERN_ERR "sbd: Unable to reserve MMIO resource\n";
 	struct sbd_duart *duart = to_sport(uport)->duart;
 	int map_guard;
 	int ret = 0;
@@ -755,7 +753,7 @@ static int sbd_verify_port(struct uart_p
 }
 
 
-static struct uart_ops sbd_ops = {
+static const struct uart_ops sbd_ops = {
 	.tx_empty	= sbd_tx_empty,
 	.set_mctrl	= sbd_set_mctrl,
 	.get_mctrl	= sbd_get_mctrl,
