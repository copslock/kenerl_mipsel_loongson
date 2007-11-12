Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Nov 2007 17:33:39 +0000 (GMT)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:30384 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S28577237AbXKLRda (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 12 Nov 2007 17:33:30 +0000
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 4748A4008C;
	Mon, 12 Nov 2007 18:33:01 +0100 (CET)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id JMXhbs0gAqei; Mon, 12 Nov 2007 18:32:56 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id F2871400CE;
	Mon, 12 Nov 2007 18:32:55 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id lACHX15n010356;
	Mon, 12 Nov 2007 18:33:01 +0100
Date:	Mon, 12 Nov 2007 17:32:48 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	linux-mips@linux-mips.org
Subject: [PATCH] sni/pcimt.c: s/achknowledge/acknowledge
Message-ID: <Pine.LNX.4.64N.0711121731090.30102@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4755/Mon Nov 12 15:41:11 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17472
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

s/achknowledge/acknowledge

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
 While at fixing typos...

 Please apply.

  Maciej

patch-mips-2.6.23-20071023-sni-pcimt-typo-0
diff -up --recursive --new-file linux-mips-2.6.23-20071023.macro/arch/mips/sni/pcimt.c linux-mips-2.6.23-20071023/arch/mips/sni/pcimt.c
--- linux-mips-2.6.23-20071023.macro/arch/mips/sni/pcimt.c	2007-10-23 04:57:23.000000000 +0000
+++ linux-mips-2.6.23-20071023/arch/mips/sni/pcimt.c	2007-11-11 23:20:26.000000000 +0000
@@ -244,7 +244,7 @@ static void pcimt_hwint1(void)
 	if (pend & IT_EISA) {
 		int irq;
 		/*
-		 * Note: ASIC PCI's builtin interrupt achknowledge feature is
+		 * Note: ASIC PCI's builtin interrupt acknowledge feature is
 		 * broken.  Using it may result in loss of some or all i8259
 		 * interrupts, so don't use PCIMT_INT_ACKNOWLEDGE ...
 		 */
