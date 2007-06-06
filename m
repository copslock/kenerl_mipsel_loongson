Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Jun 2007 10:07:41 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:29967 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20021466AbXFFJHj (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 6 Jun 2007 10:07:39 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 3A56CE1CC0;
	Wed,  6 Jun 2007 11:07:31 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U+bzqJx5Mgsw; Wed,  6 Jun 2007 11:07:31 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id E3A71E1C7F;
	Wed,  6 Jun 2007 11:07:30 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l5697bXW018717;
	Wed, 6 Jun 2007 11:07:38 +0200
Date:	Wed, 6 Jun 2007 10:07:34 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Andrew Morton <akpm@linux-foundation.org>
cc:	linux-mips@linux-mips.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] zs.c: Drain the transmission line
Message-ID: <Pine.LNX.4.64N.0706051145260.15653@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.90.3/3367/Wed Jun  6 07:14:43 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15301
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

 This is an update to the zs.c driver to make it wait for the transmission 
line to become idle before disabling the transmitter or resetting the 
chip.  This way the character that is on the way at the time one of these 
actions is about to be performed does not get corrupted.

 Plus a change to reset the index/data pointer first before issuing a chip 
reset just in case the state is wrong when control of the chip is taken 
the first time.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
 These are almost obvious, but I have run-time tested them just in case.  
They make the switch from the initial (early printk) PROM-based console 
less disruptive.  The change to load_zsregs() also affects set_termios().

 Please apply,

  Maciej

patch-mips-2.6.21-20070502-zs-serial-drain-3
diff -up --recursive --new-file linux-mips-2.6.21-20070502.macro/drivers/serial/zs.c linux-mips-2.6.21-20070502/drivers/serial/zs.c
--- linux-mips-2.6.21-20070502.macro/drivers/serial/zs.c	2007-06-05 11:08:24.000000000 +0000
+++ linux-mips-2.6.21-20070502/drivers/serial/zs.c	2007-06-05 11:08:57.000000000 +0000
@@ -240,10 +240,24 @@ static int zs_transmit_drain(struct zs_p
 	return loops;
 }
 
+static int zs_line_drain(struct zs_port *zport, int irq)
+{
+	struct zs_scc *scc = zport->scc;
+	int loops = 10000;
+
+	while (!(read_zsreg(zport, R1) & ALL_SNT) && loops--) {
+		zs_spin_unlock_cond_irq(&scc->zlock, irq);
+		udelay(2);
+		zs_spin_lock_cond_irq(&scc->zlock, irq);
+	}
+	return loops;
+}
+
 
 static void load_zsregs(struct zs_port *zport, u8 *regs, int irq)
 {
-	zs_transmit_drain(zport, irq);
+	/* Let the current transmission finish.  */
+	zs_line_drain(zport, irq);
 	/* Load 'em up.  */
 	write_zsreg(zport, R3, regs[3] & ~RxENABLE);
 	write_zsreg(zport, R5, regs[5] & ~TxENAB);
@@ -814,6 +828,10 @@ static void zs_reset(struct zs_port *zpo
 	spin_lock_irqsave(&scc->zlock, flags);
 	irq = !irqs_disabled_flags(flags);
 	if (!scc->initialised) {
+		/* Reset the pointer first, just in case...  */
+		read_zsreg(zport, R0);
+		/* And let the current transmission finish.  */
+		zs_line_drain(zport, irq);
 		write_zsreg(zport, R9, FHWRES);
 		udelay(10);
 		write_zsreg(zport, R9, 0);
