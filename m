Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Nov 2004 21:46:28 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:5903 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225005AbUKXVqX>; Wed, 24 Nov 2004 21:46:23 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id D63FBE1C84; Wed, 24 Nov 2004 22:46:10 +0100 (CET)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 03021-09; Wed, 24 Nov 2004 22:46:10 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id CD6A4E1C8A; Wed, 24 Nov 2004 22:46:09 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.1/8.13.1) with ESMTP id iAOLkJ0v021260;
	Wed, 24 Nov 2004 22:46:25 +0100
Date: Wed, 24 Nov 2004 21:46:05 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>,
	Manish Lachwani <mlachwani@mvista.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: [PATCH] Synthesize TLB refill handler at runtime
In-Reply-To: <Pine.LNX.4.58L.0411241451290.843@blysk.ds.pg.gda.pl>
Message-ID: <Pine.LNX.4.58L.0411242138560.843@blysk.ds.pg.gda.pl>
References: <20041121170242.GR20986@rembrandt.csv.ica.uni-stuttgart.de>
 <Pine.GSO.4.61.0411212048520.26374@waterleaf.sonytel.be>
 <20041121203757.GS20986@rembrandt.csv.ica.uni-stuttgart.de>
 <20041122070117.GB25433@linux-mips.org> <41A283BD.3080300@mvista.com>
 <Pine.LNX.4.58L.0411230036310.31113@blysk.ds.pg.gda.pl> <41A29DCF.8030308@mvista.com>
 <Pine.LNX.4.58L.0411232018390.19941@blysk.ds.pg.gda.pl>
 <20041124014057.GE902@rembrandt.csv.ica.uni-stuttgart.de>
 <20041124094423.GB21039@linux-mips.org> <Pine.LNX.4.58L.0411241451290.843@blysk.ds.pg.gda.pl>
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
X-archive-position: 6442
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 24 Nov 2004, Maciej W. Rozycki wrote:

>  Agreed.  We should probably verify these few "traditional" CPUs to be
> handled explicitly ourselves, though, as there is no one else to look 
> after them.

 Here's my proposal.  It doesn't handle MIPS*R2 processors implicitly yet
as that asks for a clean implementation of MIPS architecture
determination.  I'll do that in a separate step and adjust this code 
afterwards.  For now it should be OK.  Agreed?

 Note, these panic()s really beg for early printk() support -- but doesn't
everyone have it already? ;-)

  Maciej

patch-mips-2.6.10-rc1-20041112-mips-tlbwr-0
diff -up --recursive --new-file linux-mips-2.6.10-rc1-20041112.macro/arch/mips/mm/tlbex.c linux-mips-2.6.10-rc1-20041112/arch/mips/mm/tlbex.c
--- linux-mips-2.6.10-rc1-20041112.macro/arch/mips/mm/tlbex.c	Tue Nov 23 20:55:14 2004
+++ linux-mips-2.6.10-rc1-20041112/arch/mips/mm/tlbex.c	Wed Nov 24 20:15:35 2004
@@ -761,10 +761,22 @@ static __init void build_tlb_write_rando
 
 	case CPU_R4600:
 	case CPU_R4700:
+	case CPU_R5000:
+	case CPU_5KC:
 		i_nop(p);
 		i_tlbwr(p);
 		break;
 
+	case CPU_R10000:
+	case CPU_R12000:
+	case CPU_4KC:
+	case CPU_SB1:
+	case CPU_4KSC:
+	case CPU_20KC:
+	case CPU_25KF:
+		i_tlbwr(p);
+		break;
+
 	case CPU_NEVADA:
 		i_nop(p); /* QED specifies 2 nops hazard */
 		/*
@@ -776,6 +788,12 @@ static __init void build_tlb_write_rando
 		l_tlbwr_hazard(l, *p);
 		break;
 
+	case CPU_4KEC:
+	case CPU_24K:
+		i_ehb(p);
+		i_tlbwr(p);
+		break;
+
 	case CPU_RM9000:
 		/*
 		 * When the JTLB is updated by tlbwi or tlbwr, a subsequent
@@ -794,21 +812,9 @@ static __init void build_tlb_write_rando
 		i_ssnop(p);
 		break;
 
-	case CPU_R10000:
-	case CPU_R12000:
-	case CPU_SB1:
-		i_tlbwr(p);
-		break;
-
 	default:
-		/*
-		 * Others are assumed to have one cycle mtc0 hazard,
-		 * and one cycle tlbwr hazard or to understand ehb.
-		 * XXX: This might be overly general.
-		 */
-		i_ehb(p);
-		i_tlbwr(p);
-		i_ehb(p);
+		panic("No TLB refill handler yet (CPU type: %d)",
+		      current_cpu_data.cputype);
 		break;
 	}
 }
