Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Oct 2004 01:58:35 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:267 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8224929AbUJCA63>; Sun, 3 Oct 2004 01:58:29 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 02FA7E1D46; Sun,  3 Oct 2004 02:58:20 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 12084-09; Sun,  3 Oct 2004 02:58:19 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id A7680E1CDB; Sun,  3 Oct 2004 02:58:19 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.12.11/8.12.11) with ESMTP id i930wfXT024855;
	Sun, 3 Oct 2004 02:58:41 +0200
Date: Sun, 3 Oct 2004 01:58:27 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Cc: linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: Kernel 2.6 for R4600 Indy
In-Reply-To: <20041002204014.GO21351@rembrandt.csv.ica.uni-stuttgart.de>
Message-ID: <Pine.LNX.4.58L.0410022213140.18388@blysk.ds.pg.gda.pl>
References: <4152D58B.608@longlandclan.hopto.org> <20040923154855.GA2550@paradigm.rfc822.org>
 <20041002185057.GN21351@rembrandt.csv.ica.uni-stuttgart.de>
 <20041002204014.GO21351@rembrandt.csv.ica.uni-stuttgart.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5921
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, 2 Oct 2004, Thiemo Seufer wrote:

> > The last problem happens only on r4000 and r4400, and occasionally
> > also shows up as "illegal instruction" or "unaligned access". It
> > turned out to be a broken TLB handler. I temporarily switched (for
> > 32bit kernels) from except_vec0_r4000 to except_vec0_r45k_bvahwbug.
> > This may cause an avoidable performance loss, but at least it allows
> > my R4400SC-200 (V6.0) Indy to run current 2.6 CVS.
> 
> One more nop is enough to make it work. This should probably go in
> a hazard definition.
[...]
> --- arch/mips/mm/tlbex32-r4k.S  20 Jun 2004 23:52:17 -0000      1.1
> +++ arch/mips/mm/tlbex32-r4k.S  2 Oct 2004 20:36:29 -0000
> @@ -179,6 +179,7 @@
>         P_MTC0  k1, CP0_ENTRYLO1                # load it
>         mtc0_tlbw_hazard
>         tlbwr                                   # write random tlb entry
> +       nop
>         tlbw_eret_hazard
>         eret                                    # return from trap
>         END(except_vec0_r4000)

 I'd be inclined to add this nop to the tlbw_eret_hazard definition, but
it should really be processor-dependent.

 According to the R4000/R4400 cp0 hazard dependency table, there is a
three-instruction delay between tlbwi/tlbwr and eret with respect to TLB
use and two-instruction one between tlbwi/tlbwr and the instruction
following eret for the R4600/R4700.  Therefore, there should actually be
three nops there for the R4000/R4400 and one for the R4600/R4700.  AFAIK
mtc0_tlbw_hazard acts as a way to simulate two nops for the R4000/R4400.  
Still, tlbw_eret_hazard expands to nothing for non-RM9000 processors.

 I think we should either handcode all handlers explicitly or build a
single one dynamically, like we do for copy_page()/clear_page().  For now,
I'll just add the missing nop directly to the handlers.  Thanks for 
working on it.

  Maciej
