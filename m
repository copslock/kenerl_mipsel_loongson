Received:  by oss.sgi.com id <S305160AbQBPA0q>;
	Tue, 15 Feb 2000 16:26:46 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:35449 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305156AbQBPA00>;
	Tue, 15 Feb 2000 16:26:26 -0800
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id QAA16026; Tue, 15 Feb 2000 16:21:55 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA74646
	for linux-list;
	Tue, 15 Feb 2000 16:16:17 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA71895
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 15 Feb 2000 16:16:15 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA09319
	for <linux@cthulhu.engr.sgi.com>; Tue, 15 Feb 2000 16:16:18 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from cacc-22.uni-koblenz.de (cacc-22.uni-koblenz.de [141.26.131.22])
	by mailhost.uni-koblenz.de (8.9.3/8.9.3) with ESMTP id BAA02764;
	Wed, 16 Feb 2000 01:15:59 +0100 (MET)
Received:  by lappi.waldorf-gmbh.de id <S407895AbQBPANh>;
	Wed, 16 Feb 2000 01:13:37 +0100
Date:   Wed, 16 Feb 2000 01:13:37 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     "Kevin D. Kissell" <kevink@mips.com>
Cc:     Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
        linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: Re: Indy crashes
Message-ID: <20000216011337.C4633@uni-koblenz.de>
References: <006501bf7803$59855ad0$0ceca8c0@satanas.mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <006501bf7803$59855ad0$0ceca8c0@satanas.mips.com>
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Tue, Feb 15, 2000 at 11:23:49PM +0100, Kevin D. Kissell wrote:

> If it isn't the cache, and it tracks the CPU type, the next thing
> I suspect is a pipe hazard.   The R5000 manual states that there
> should be "at least two integer instructions between" any
> instruction modifying the PageMask, EntryHi, or EntryLo[01]
> registers and the subsequent tlbw[ir] or tlbp.  That's different
> from the R4000.  In the current Linux arch/mips/head.S file, 
> this interval does not seem to be respected by any of the TLB 
> miss handlers.  Indeed, the default except_vec0_r4000 handler,
> which I believe is what is used if an R5000 is detected, has 
> the sequence
> 
>         mtc0    k1, CP0_ENTRYLO1                # load it
>         b       1f
>          tlbwr                                  # write random tlb entry
> 1:
>         nop
>         eret
> 
> wherin the purpose of the branch is obscure (I imagine
> it fixed a bug seen somewhere on some CPU but it
> makes me rather queasy)  but wherein in any case we 
> do not seem to be assured 2 issues between the mtc0 
> and the tlbwr.  It should be OK for an R4000, but not for 
> an R5000.

No, it's not a bug workaround.  The reason for this branch is that the
R4000 and R4400 have a penalty of three cycles for a taken branch.  So
the branch above is equivalent with 

	mtc0	k1, CP0_ENTRYLO1
	nop
	tlbwr
	nop
	nop
	nop
	eret

Funky trick, isn't it?  I don't have the the R4600 / R5000 docs at hand
but as I understood them the above code should also work just perfect
for them.

> So someone with the ability to reproduce the R5000
> problem should really try sticking a nop between the
> mtc0 and the branch (sigh) to see if that stabilizes 
> the system.

Talking about CPU bugs - the R5230 and maybe it's relatives needs a nasty
workaround.  I think I only put the workaround into the Cobalt kernel.
Of course IDT doesn't admit that this bug even exists ...

  Ralf
