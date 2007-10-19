Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Oct 2007 21:24:31 +0100 (BST)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:41903 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20045556AbXJSUYW (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 19 Oct 2007 21:24:22 +0100
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id AB26D400D4;
	Fri, 19 Oct 2007 22:24:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id luJIoS52bWak; Fri, 19 Oct 2007 22:24:18 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id F2FD3400A4;
	Fri, 19 Oct 2007 22:24:17 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l9JKONRX022957;
	Fri, 19 Oct 2007 22:24:23 +0200
Date:	Fri, 19 Oct 2007 21:24:16 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Andrew Morton <akpm@linux-foundation.org>
cc:	linux-mips@linux-mips.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dz.c: Don't panic() when request_irq() fails
Message-ID: <Pine.LNX.4.64N.0710192119360.13279@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4545/Wed Oct 17 23:05:57 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17139
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

 Well, panic() is a little bit undue if request_irq() fails; there is 
probably no need to justify it any further.  Handle the case gracefully, 
by unregistering the driver.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
 Tested with checkpatch.pl and at the run-time -- MIPS/Linux on a
DECstation 5000/200.

 Please apply,

  Maciej

patch-mips-2.6.18-20060920-dz-init-0
diff -up --recursive --new-file linux-mips-2.6.18-20060920.macro/drivers/serial/dz.c linux-mips-2.6.18-20060920/drivers/serial/dz.c
--- linux-mips-2.6.18-20060920.macro/drivers/serial/dz.c	2006-11-23 05:17:01.000000000 +0000
+++ linux-mips-2.6.18-20060920/drivers/serial/dz.c	2007-01-14 00:39:20.000000000 +0000
@@ -795,18 +795,28 @@ static int __init dz_init(void)
 	dz_reset(&dz_ports[0]);
 #endif
 
-	if (request_irq(dz_ports[0].port.irq, dz_interrupt,
-			IRQF_DISABLED, "DZ", &dz_ports[0]))
-		panic("Unable to register DZ interrupt");
-
 	ret = uart_register_driver(&dz_reg);
 	if (ret != 0)
-		return ret;
+		goto out;
+
+	ret = request_irq(dz_ports[0].port.irq, dz_interrupt, IRQF_DISABLED,
+			  "DZ", &dz_ports[0]);
+	if (ret != 0) {
+		printk(KERN_ERR "dz: Cannot get IRQ %d!\n",
+		       dz_ports[0].port.irq);
+		goto out_unregister;
+	}
 
 	for (i = 0; i < DZ_NB_PORT; i++)
 		uart_add_one_port(&dz_reg, &dz_ports[i].port);
 
 	return ret;
+
+out_unregister:
+	uart_unregister_driver(&dz_reg);
+
+out:
+	return ret;
 }
 
 module_init(dz_init);
