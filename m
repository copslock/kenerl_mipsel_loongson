Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Apr 2005 14:42:43 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:15622 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8226027AbVDDNm2>; Mon, 4 Apr 2005 14:42:28 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 74719E1C95; Mon,  4 Apr 2005 15:42:19 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 26912-07; Mon,  4 Apr 2005 15:42:19 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 386E9E1C6D; Mon,  4 Apr 2005 15:42:19 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.1/8.13.1) with ESMTP id j34DgHtx022483;
	Mon, 4 Apr 2005 15:42:22 +0200
Date:	Mon, 4 Apr 2005 14:42:25 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Greg Weeks <greg.weeks@timesys.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: malta 4kc machine check
In-Reply-To: <42514113.9060902@timesys.com>
Message-ID: <Pine.LNX.4.61L.0504041437441.20089@blysk.ds.pg.gda.pl>
References: <42514113.9060902@timesys.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.83/804/Mon Apr  4 16:38:58 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7583
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 4 Apr 2005, Greg Weeks wrote:

> I'm getting a machine check on a malta 4kc when userland starts up. This was
> built from a copy of the malta tree from Friday. Has anyone else ran into
> this?

 This is being resolved -- please try this patch for now.

  Maciej

diff -up --recursive --new-file linux-mips-2.6.11-rc2-20050202.macro/arch/mips/mm/tlbex.c linux-mips-2.6.11-rc2-20050202/arch/mips/mm/tlbex.c
--- linux-mips-2.6.11-rc2-20050202.macro/arch/mips/mm/tlbex.c	2005-01-13 19:15:04.000000000 +0000
+++ linux-mips-2.6.11-rc2-20050202/arch/mips/mm/tlbex.c	2005-02-05 01:35:00.000000000 +0000
@@ -1621,7 +1620,6 @@ build_r4000_tlbchange_handler_head(u32 *
 	l_smp_pgtable_change(l, *p);
 # endif
 	iPTE_LW(p, l, pte, 0, ptr); /* get even pte */
-	build_tlb_probe_entry(p);
 }
 
 static void __init
@@ -1662,6 +1660,7 @@ static void __init build_r4000_tlb_load_
 
 	build_r4000_tlbchange_handler_head(&p, &l, &r, K0, K1);
 	build_pte_present(&p, &l, &r, K0, K1, label_nopage_tlbl);
+	build_tlb_probe_entry(&p);
 	build_make_valid(&p, &r, K0, K1);
 	build_r4000_tlbchange_handler_tail(&p, &l, &r, K0, K1);
 
@@ -1701,6 +1700,7 @@ static void __init build_r4000_tlb_store
 
 	build_r4000_tlbchange_handler_head(&p, &l, &r, K0, K1);
 	build_pte_writable(&p, &l, &r, K0, K1, label_nopage_tlbs);
+	build_tlb_probe_entry(&p);
 	build_make_write(&p, &r, K0, K1);
 	build_r4000_tlbchange_handler_tail(&p, &l, &r, K0, K1);
 
@@ -1740,6 +1740,7 @@ static void __init build_r4000_tlb_modif
 
 	build_r4000_tlbchange_handler_head(&p, &l, &r, K0, K1);
 	build_pte_modifiable(&p, &l, &r, K0, K1, label_nopage_tlbm);
+	build_tlb_probe_entry(&p);
 	/* Present and writable bits set, set accessed and dirty bits. */
 	build_make_write(&p, &r, K0, K1);
 	build_r4000_tlbchange_handler_tail(&p, &l, &r, K0, K1);
