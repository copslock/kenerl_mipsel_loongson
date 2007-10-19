Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Oct 2007 21:39:16 +0100 (BST)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:61067 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20045660AbXJSUjI (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 19 Oct 2007 21:39:08 +0100
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 366DB400DD;
	Fri, 19 Oct 2007 22:38:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id pXBlOyABQ1GF; Fri, 19 Oct 2007 22:38:34 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 87E25400A4;
	Fri, 19 Oct 2007 22:38:34 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l9JKcdV9025552;
	Fri, 19 Oct 2007 22:38:39 +0200
Date:	Fri, 19 Oct 2007 21:38:33 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Andrew Morton <akpm@linux-foundation.org>
cc:	linux-mips@linux-mips.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dz.c: Rename the serial console structure
Message-ID: <Pine.LNX.4.64N.0710192135440.13279@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4545/Wed Oct 17 23:05:57 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17142
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

 Rename the serial console structure so that `modpost' does not complain 
about a reference to an "init" section -- "_console" is magic.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
 Tested with checkpatch.pl and at the run-time -- MIPS/Linux on a 
DECstation 5000/200.

 Please apply,

  Maciej

patch-mips-2.6.23-rc5-20070904-serial-dz-console-0
diff -up --recursive --new-file linux-mips-2.6.23-rc5-20070904.macro/drivers/serial/dz.c linux-mips-2.6.23-rc5-20070904/drivers/serial/dz.c
--- linux-mips-2.6.23-rc5-20070904.macro/drivers/serial/dz.c	2007-05-02 04:56:10.000000000 +0000
+++ linux-mips-2.6.23-rc5-20070904/drivers/serial/dz.c	2007-09-18 23:07:54.000000000 +0000
@@ -741,7 +741,7 @@ static int __init dz_console_setup(struc
 }
 
 static struct uart_driver dz_reg;
-static struct console dz_sercons = {
+static struct console dz_console = {
 	.name	= "ttyS",
 	.write	= dz_console_print,
 	.device	= uart_console_device,
@@ -755,7 +755,7 @@ static int __init dz_serial_console_init
 {
 	if (!IOASIC) {
 		dz_init_ports();
-		register_console(&dz_sercons);
+		register_console(&dz_console);
 		return 0;
 	} else
 		return -ENXIO;
@@ -763,7 +763,7 @@ static int __init dz_serial_console_init
 
 console_initcall(dz_serial_console_init);
 
-#define SERIAL_DZ_CONSOLE	&dz_sercons
+#define SERIAL_DZ_CONSOLE	&dz_console
 #else
 #define SERIAL_DZ_CONSOLE	NULL
 #endif /* CONFIG_SERIAL_DZ_CONSOLE */
