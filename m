Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Jan 2003 13:27:16 +0000 (GMT)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:30942 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8226025AbTAHN1P>; Wed, 8 Jan 2003 13:27:15 +0000
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA03438;
	Wed, 8 Jan 2003 14:27:07 +0100 (MET)
Date: Wed, 8 Jan 2003 14:27:05 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
cc: linux-mips@linux-mips.org
Subject: [patch] Use XKPHYS for 64-bit TLB flushes
Message-ID: <Pine.GSO.3.96.1030108141332.1580F-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1095
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

Hello,

 32-bit R4k TLB flush functions use KSEG0 as an impossible (unmapped) VPN2
value for invalidated TLB entries.  64-bit ones use KSEG0 as well, but
here KSEG0 is a valid XKSEG (mapped) value as it gets interpreted as
0xc00000ff80000000 when written into cp0.EntryHi.  The correct impossible
(unmapped) VPN2 value for the 64-bit mode is XKPHYS. 

 Here is a patch implementing it.  The code runs fine on my R4400SC.  OK
to apply?

 BTW, show_tlb() (in the same file) is buggy and redundant --
dump_tlb_all() is a correct equivalent.  I'd like to remove show_tlb() --
OK?

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.20-pre6-20021212-mips64-tlb-r4k-0
diff -up --recursive --new-file linux-mips-2.4.20-pre6-20021212.macro/arch/mips64/mm/tlb-r4k.c linux-mips-2.4.20-pre6-20021212/arch/mips64/mm/tlb-r4k.c
--- linux-mips-2.4.20-pre6-20021212.macro/arch/mips64/mm/tlb-r4k.c	2002-12-04 03:56:40.000000000 +0000
+++ linux-mips-2.4.20-pre6-20021212/arch/mips64/mm/tlb-r4k.c	2003-01-08 03:54:28.000000000 +0000
@@ -53,7 +53,7 @@ void local_flush_tlb_all(void)
 	__save_and_cli(flags);
 	/* Save old context and create impossible VPN2 value */
 	old_ctx = (read_c0_entryhi() & 0xff);
-	write_c0_entryhi(KSEG0);
+	write_c0_entryhi(XKPHYS);
 	write_c0_entrylo0(0);
 	write_c0_entrylo1(0);
 	BARRIER;
@@ -63,7 +63,7 @@ void local_flush_tlb_all(void)
 	/* Blast 'em all away. */
 	while(entry < mips_cpu.tlbsize) {
 	        /* Make sure all entries differ. */
-	        write_c0_entryhi(KSEG0+entry*0x2000);
+	        write_c0_entryhi(XKPHYS+entry*0x2000);
 		write_c0_index(entry);
 		BARRIER;
 		tlb_write_indexed();
@@ -128,7 +128,7 @@ void local_flush_tlb_range(struct mm_str
 				if(idx < 0)
 					continue;
 				/* Make sure all entries differ. */
-				write_c0_entryhi(KSEG0+idx*0x2000);
+				write_c0_entryhi(XKPHYS+idx*0x2000);
 				BARRIER;
 				tlb_write_indexed();
 				BARRIER;
@@ -167,7 +167,7 @@ void local_flush_tlb_page(struct vm_area
 		if(idx < 0)
 			goto finish;
 		/* Make sure all entries differ. */
-		write_c0_entryhi(KSEG0+idx*0x2000);
+		write_c0_entryhi(XKPHYS+idx*0x2000);
 		BARRIER;
 		tlb_write_indexed();
 	finish:
