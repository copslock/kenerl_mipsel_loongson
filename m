Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Nov 2004 23:19:47 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:36370 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225196AbUKWXTl>; Tue, 23 Nov 2004 23:19:41 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 9180FF5BFB; Tue, 23 Nov 2004 23:53:41 +0100 (CET)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 08780-04; Tue, 23 Nov 2004 23:53:41 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 01B4BF6B90; Tue, 23 Nov 2004 21:24:11 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.1/8.13.1) with ESMTP id iANKOJiC016322;
	Tue, 23 Nov 2004 21:24:22 +0100
Date: Tue, 23 Nov 2004 20:24:08 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Manish Lachwani <mlachwani@mvista.com>
Cc: Ralf Baechle <ralf@linux-mips.org>,
	Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: [PATCH] Synthesize TLB refill handler at runtime
In-Reply-To: <41A29DCF.8030308@mvista.com>
Message-ID: <Pine.LNX.4.58L.0411232018390.19941@blysk.ds.pg.gda.pl>
References: <20041121170242.GR20986@rembrandt.csv.ica.uni-stuttgart.de>
 <Pine.GSO.4.61.0411212048520.26374@waterleaf.sonytel.be>
 <20041121203757.GS20986@rembrandt.csv.ica.uni-stuttgart.de>
 <20041122070117.GB25433@linux-mips.org> <41A283BD.3080300@mvista.com>
 <Pine.LNX.4.58L.0411230036310.31113@blysk.ds.pg.gda.pl> <41A29DCF.8030308@mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.80/590/Wed Nov 17 22:03:52 2004
	clamav-milter version 0.80j
	on piorun.ds.pg.gda.pl
X-Virus-Status: Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6425
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 22 Nov 2004, Manish Lachwani wrote:

> However, the crash still occurs. I dont think your patch was intended to 
> fix the problem that I see below (resulting in crash).

 Certainly, it wasn't, but it couldn't have hurt, either.

> Data bus error, epc == 801f83b8, ra == 80323f04

 The reason are cp0 hazards, likely leading to an incorrect mapping.  Try
the following patch; already applied to the mainline as obviously correct.

  Maciej

patch-mips-2.6.10-rc1-20041112-mips-tlb-ehb-0
diff -up --recursive --new-file linux-mips-2.6.10-rc1-20041112.macro/arch/mips/mm/tlbex.c linux-mips-2.6.10-rc1-20041112/arch/mips/mm/tlbex.c
--- linux-mips-2.6.10-rc1-20041112.macro/arch/mips/mm/tlbex.c	2004-11-23 19:52:53.000000000 +0000
+++ linux-mips-2.6.10-rc1-20041112/arch/mips/mm/tlbex.c	2004-11-23 19:58:31.000000000 +0000
@@ -448,7 +448,8 @@ L_LA(_split)
 #define i_bnez(buf, rs, off) i_bne(buf, rs, 0, off)
 #define i_move(buf, a, b) i_ADDU(buf, a, 0, b)
 #define i_nop(buf) i_sll(buf, 0, 0, 0)
-#define i_ssnop(buf) i_sll(buf, 0, 2, 1)
+#define i_ssnop(buf) i_sll(buf, 0, 0, 1)
+#define i_ehb(buf) i_sll(buf, 0, 0, 3)
 
 #if CONFIG_MIPS64
 static __init int in_compat_space_p(long addr)
@@ -799,12 +800,12 @@ static __init void build_tlb_write_rando
 	default:
 		/*
 		 * Others are assumed to have one cycle mtc0 hazard,
-		 * and one cycle tlbwr hazard.
+		 * and one cycle tlbwr hazard or to understand ehb.
 		 * XXX: This might be overly general.
 		 */
-		i_nop(p);
+		i_ehb(p);
 		i_tlbwr(p);
-		i_nop(p);
+		i_ehb(p);
 		break;
 	}
 }
