Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Jul 2006 17:58:55 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:11013 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S8133510AbWGGQ6p (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 7 Jul 2006 17:58:45 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id C912CF5CF3;
	Fri,  7 Jul 2006 18:58:39 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 03788-09; Fri,  7 Jul 2006 18:58:39 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 6BF26F5CE8;
	Fri,  7 Jul 2006 18:58:39 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.7/8.13.1) with ESMTP id k67GwouK018230;
	Fri, 7 Jul 2006 18:58:50 +0200
Date:	Fri, 7 Jul 2006 17:58:44 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] fast path for rdhwr emulation for TLS
In-Reply-To: <20060708.011245.82794581.anemo@mba.ocn.ne.jp>
Message-ID: <Pine.LNX.4.64N.0607071715360.25285@blysk.ds.pg.gda.pl>
References: <20060708.000032.88471510.anemo@mba.ocn.ne.jp>
 <Pine.LNX.4.64N.0607071607520.25285@blysk.ds.pg.gda.pl>
 <20060708.011245.82794581.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.88.2/1588/Fri Jul  7 15:54:23 2006 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11940
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, 8 Jul 2006, Atsushi Nemoto wrote:

> >  For a VIVT I-cache this can result in a TLB exception.  TLB handlers are 
> > not currently prepared for being called at the exception level.
> 
> Thanks, now I understand the problem.  Are there any good solutions?
> Only I can think now is using handle_ri_slow for such CPUs.

 I have implemented an appropriate update to the TLB handlers (or actually 
it's enough to care for this case for the TLBL exception), but it predates 
the current synthesized ones.  There is a small impact resulting from 
this change and the synthesized handlers have the advantage of making it 
only necessary for these chips that do need such handling.

 There are two possible ways of handling TLB exceptions from the exception 
level, both requiring checking cp0.index.p (which we do not do at the 
moment under the assumption a TLB refill exception has already been taken 
and handled) and if a failure is indicated either:

1. jumping to the TLB refill handler,

or:

2. executing "tlbwr" rather than "tlbwi".

Both are good, but I have not benchmarked them -- note that a failure is 
expected to be an extremely rare event, so it's the performance for the 
probe success that matters.

> >  Also I am fairly sure gas won't fill the branch delay slot above -- a 
> > trivial rearrangement of code would save a cycle here (and this is a fast 
> > path, so we do not want wasting time).
> 
> Well, here is a code compiled by binutils 2.17.  This version of gas
> can put MFC0 on the delay slot.  But it might be better to use
> noreorder by myself.
> 
> 80012a80 <handle_ri>:
> 80012a80:	401a6800 	mfc0	k0,c0_cause
> 80012a84:	0740fd2e 	bltz	k0,80011f40 <handle_ri_slow>
> 80012a88:	401b7000 	mfc0	k1,c0_epc
> 80012a8c:	8f7a0000 	lw	k0,0(k1)

 Still bad -- you have a stall on $k1 here.  And on $k0 two instructions 
earlier.

> 80012a90:	3c1b7c03 	lui	k1,0x7c03
> 80012a94:	377be83b 	ori	k1,k1,0xe83b
> 80012a98:	175bfd29 	bne	k0,k1,80011f40 <handle_ri_slow>
> 80012a9c:	00000000 	nop

 And this "nop" is a waste of time.

> 80012aa0:	3c1b801b 	lui	k1,0x801b
> 80012aa4:	8f7b4008 	lw	k1,16392(k1)
> 80012aa8:	401a7000 	mfc0	k0,c0_epc
> 80012aac:	275a0004 	addiu	k0,k0,4
> 80012ab0:	409a7000 	mtc0	k0,c0_epc
> 80012ab4:	377b1fff 	ori	k1,k1,0x1fff
> 80012ab8:	3b7b1fff 	xori	k1,k1,0x1fff
> 80012abc:	8f63000c 	lw	v1,12(k1)
> 80012ac0:	42000018 	eret

 I'd restructure the code more or less like this, taking care for (almost) 
all stalls resulting from interlocks on coprocessor moves and memory loads 
and likewise avoiding the need for "nop" fillers there for MIPS I 
processors:

	.set	push
	.set	noat
	.set	noreorder
	mfc0	k0, CP0_CAUSE
	MFC0	k1, CP0_EPC
	bltz	k0, handle_ri_slow	/* if delay slot */
	 lui	k0, 0x7c03
	lw	k1, (k1)
	ori	k0, 0xe83b		/* k0 := rdhwr v1,$29 */
	bne	k0, k1, handle_ri_slow	/* if not ours */
	 get_saved_sp			/* k1 := current_thread_info */
	MFC0	k0, CP0_EPC
#if defined(CONFIG_CPU_R3000) || defined(CONFIG_CPU_TX39XX)
	ori	k1, _THREAD_MASK
	xori	k1, _THREAD_MASK
	LONG_L	v1, TI_FLAGS(k1)
	PTR_ADDIU k0, 4
	jr	k0
	 rfe
#else
	PTR_ADDIU k0, 4			/* stall on $k0 */
	MTC0	k0, CP0_EPC
	ori	k1, _THREAD_MASK
	xori	k1, _THREAD_MASK
	LONG_L	v1, TI_FLAGS(k1)
	eret
#endif
	.set	pop

I hope I got this right. ;-)

  Maciej
