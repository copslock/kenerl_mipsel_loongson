Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Oct 2007 14:47:37 +0100 (BST)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:59550 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20024135AbXJBNr2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 2 Oct 2007 14:47:28 +0100
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id D46EE400FD;
	Tue,  2 Oct 2007 15:47:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id gXEBWqqOTnWo; Tue,  2 Oct 2007 15:47:23 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 2480240040;
	Tue,  2 Oct 2007 15:47:23 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l92DlQur013790;
	Tue, 2 Oct 2007 15:47:27 +0200
Date:	Tue, 2 Oct 2007 14:47:22 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>,
	Thiemo Seufer <ths@networkno.de>
cc:	linux-mips@linux-mips.org
Subject: [PATCH] mm/pg-r4k.c: Fix a typo in an R4600 v2 erratum workaround
Message-ID: <Pine.LNX.4.64N.0710021435200.32726@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4452/Tue Oct  2 07:03:17 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16786
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

 Restore a load from KSEG1 done as a workaround for an R4600 v2 
erratum, dropped with 211be16de99a7424e66c0b6c0d00e2c970508ac2.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
Thiemo,

 It reverts your change of Sep 1st, 2005; given the way the code is 
written, I am assuming the change was accidental, correct?  At the moment 
the load never happens.

 Ralf, please apply.

  Maciej

patch-mips-2.6.23-rc5-20070904-pg-r4k-r4600-0
diff -up --recursive --new-file linux-mips-2.6.23-rc5-20070904.macro/arch/mips/mm/pg-r4k.c linux-mips-2.6.23-rc5-20070904/arch/mips/mm/pg-r4k.c
--- linux-mips-2.6.23-rc5-20070904.macro/arch/mips/mm/pg-r4k.c	2007-02-05 16:38:47.000000000 +0000
+++ linux-mips-2.6.23-rc5-20070904/arch/mips/mm/pg-r4k.c	2007-10-02 00:15:33.000000000 +0000
@@ -209,7 +209,7 @@ static inline void build_cdex_p(void)
 	}
 
 	if (R4600_V2_HIT_CACHEOP_WAR && cpu_is_r4600_v2_x())
-		build_insn_word(0x3c01a000);	/* lui     $at, 0xa000  */
+		build_insn_word(0x8c200000);	/* lw      $zero, ($at) */
 
 	mi.c_format.opcode     = cache_op;
 	mi.c_format.rs         = 4;		/* $a0 */
