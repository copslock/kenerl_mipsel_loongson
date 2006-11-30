Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Nov 2006 13:15:21 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:41481 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20037670AbWK3NPN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 30 Nov 2006 13:15:13 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id A82F7F5946;
	Thu, 30 Nov 2006 14:14:59 +0100 (CET)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G82bNkTXLVEX; Thu, 30 Nov 2006 14:14:59 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 660E6E1C61;
	Thu, 30 Nov 2006 14:14:59 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id kAUDF84R012388;
	Thu, 30 Nov 2006 14:15:08 +0100
Date:	Thu, 30 Nov 2006 13:15:05 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>
cc:	netdev@vger.kernel.org, linux-mips@linux-mips.org
Subject: [PATCH 2.6.18] declance: Support the I/O ASIC LANCE w/o TURBOchannel
Message-ID: <Pine.LNX.4.64N.0611301306460.1757@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.88.6/2263/Thu Nov 30 07:51:08 2006 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13279
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

 The onboard LANCE of I/O ASIC systems is not a TURBOchannel device, at 
least from the software point of view.  Therefore it does not rely on any 
kernel TURBOchannel bus services and can be supported even if support for 
TURBOchannel has not been enabled in the configuration.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
 Tested with the onboard LANCE of a DECstation 5000/133.

 Please apply.

  Maciej

patch-mips-2.6.18-20060920-declance-tc-0
diff -up --recursive --new-file linux-mips-2.6.18-20060920.macro/drivers/net/declance.c linux-mips-2.6.18-20060920/drivers/net/declance.c
--- linux-mips-2.6.18-20060920.macro/drivers/net/declance.c	2006-11-23 02:55:34.000000000 +0000
+++ linux-mips-2.6.18-20060920/drivers/net/declance.c	2006-11-30 02:31:19.000000000 +0000
@@ -1068,7 +1068,6 @@ static int __init dec_lance_init(const i
 	lp->type = type;
 	lp->slot = slot;
 	switch (type) {
-#ifdef CONFIG_TC
 	case ASIC_LANCE:
 		dev->base_addr = CKSEG1ADDR(dec_kn_slot_base + IOASIC_LANCE);
 
@@ -1112,7 +1111,7 @@ static int __init dec_lance_init(const i
 			     CPHYSADDR(dev->mem_start) << 3);
 
 		break;
-
+#ifdef CONFIG_TC
 	case PMAD_LANCE:
 		claim_tc_card(slot);
 
@@ -1143,7 +1142,6 @@ static int __init dec_lance_init(const i
 
 		break;
 #endif
-
 	case PMAX_LANCE:
 		dev->irq = dec_interrupt[DEC_IRQ_LANCE];
 		dev->base_addr = CKSEG1ADDR(KN01_SLOT_BASE + KN01_LANCE);
@@ -1298,10 +1296,8 @@ static int __init dec_lance_probe(void)
 	/* Then handle onboard devices. */
 	if (dec_interrupt[DEC_IRQ_LANCE] >= 0) {
 		if (dec_interrupt[DEC_IRQ_LANCE_MERR] >= 0) {
-#ifdef CONFIG_TC
 			if (dec_lance_init(ASIC_LANCE, -1) >= 0)
 				count++;
-#endif
 		} else if (!TURBOCHANNEL) {
 			if (dec_lance_init(PMAX_LANCE, -1) >= 0)
 				count++;
