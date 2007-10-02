Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Oct 2007 14:54:30 +0100 (BST)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:18923 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20024233AbXJBNyW (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 2 Oct 2007 14:54:22 +0100
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 527174010F;
	Tue,  2 Oct 2007 15:54:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id CCQEDd23Xd9C; Tue,  2 Oct 2007 15:54:16 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 5837B40040;
	Tue,  2 Oct 2007 15:54:16 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l92DsKoK014880;
	Tue, 2 Oct 2007 15:54:20 +0200
Date:	Tue, 2 Oct 2007 14:54:15 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>,
	Thiemo Seufer <ths@networkno.de>
cc:	linux-mips@linux-mips.org
Subject: [PATCH] mm/pg-r4k.c: Dump the generated code
Message-ID: <Pine.LNX.4.64N.0710021447470.32726@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4452/Tue Oct  2 07:03:17 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16787
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

 Dump the generated code for clear/copy page calls like it is done for TLB 
fault handlers.  Useful for debugging.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
Thiemo,

 It was your change to add ".set noreorder", etc. to the TLB fault 
handlers -- what is it needed for?  I have thought gas does not try to 
outsmart the user at the moment and does not reorder ".word" directives.

 Ralf, please apply.

  Maciej

patch-mips-2.6.23-rc5-20070904-pg-r4k-dump-0
diff -up --recursive --new-file linux-mips-2.6.23-rc5-20070904.macro/arch/mips/mm/pg-r4k.c linux-mips-2.6.23-rc5-20070904/arch/mips/mm/pg-r4k.c
--- linux-mips-2.6.23-rc5-20070904.macro/arch/mips/mm/pg-r4k.c	2007-02-05 16:38:47.000000000 +0000
+++ linux-mips-2.6.23-rc5-20070904/arch/mips/mm/pg-r4k.c	2007-10-01 22:50:13.000000000 +0000
@@ -347,6 +347,7 @@ void __init build_clear_page(void)
 {
 	unsigned int loop_start;
 	unsigned long off;
+	int i;
 
 	epc = (unsigned int *) &clear_page_array;
 	instruction_pending = 0;
@@ -434,12 +435,22 @@ dest = label();
 	build_jr_ra();
 
 	BUG_ON(epc > clear_page_array + ARRAY_SIZE(clear_page_array));
+
+	pr_info("Synthesized clear page handler (%u instructions).\n",
+		(unsigned int)(epc - clear_page_array));
+
+	pr_debug("\t.set push\n");
+	pr_debug("\t.set noreorder\n");
+	for (i = 0; i < (epc - clear_page_array); i++)
+		pr_debug("\t.word 0x%08x\n", clear_page_array[i]);
+	pr_debug("\t.set pop\n");
 }
 
 void __init build_copy_page(void)
 {
 	unsigned int loop_start;
 	unsigned long off;
+	int i;
 
 	epc = (unsigned int *) &copy_page_array;
 	store_offset = load_offset = 0;
@@ -515,4 +526,13 @@ dest = label();
 	build_jr_ra();
 
 	BUG_ON(epc > copy_page_array + ARRAY_SIZE(copy_page_array));
+
+	pr_info("Synthesized copy page handler (%u instructions).\n",
+		(unsigned int)(epc - copy_page_array));
+
+	pr_debug("\t.set push\n");
+	pr_debug("\t.set noreorder\n");
+	for (i = 0; i < (epc - copy_page_array); i++)
+		pr_debug("\t.word 0x%08x\n", copy_page_array[i]);
+	pr_debug("\t.set pop\n");
 }
