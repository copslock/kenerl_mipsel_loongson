Received:  by oss.sgi.com id <S305163AbQBQQjt>;
	Thu, 17 Feb 2000 08:39:49 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:36169 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305159AbQBQQjh>;
	Thu, 17 Feb 2000 08:39:37 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id IAA02845; Thu, 17 Feb 2000 08:35:06 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id IAA32643
	for linux-list;
	Thu, 17 Feb 2000 08:29:07 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id IAA34912
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 17 Feb 2000 08:29:05 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id IAA03300
	for <linux@cthulhu.engr.sgi.com>; Thu, 17 Feb 2000 08:29:09 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from cacc-27.uni-koblenz.de (cacc-27.uni-koblenz.de [141.26.131.27])
	by mailhost.uni-koblenz.de (8.9.3/8.9.3) with ESMTP id RAA24602;
	Thu, 17 Feb 2000 17:27:23 +0100 (MET)
Received:  by lappi.waldorf-gmbh.de id <S407920AbQBQQHo>;
	Thu, 17 Feb 2000 17:07:44 +0100
Date:   Thu, 17 Feb 2000 17:07:44 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     "Kevin D. Kissell" <kevink@mips.com>
Cc:     Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
        linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: Re: Indy crashes
Message-ID: <20000217170744.F5436@uni-koblenz.de>
References: <003101bf786a$8c44d150$0ceca8c0@satanas.mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <003101bf786a$8c44d150$0ceca8c0@satanas.mips.com>
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Wed, Feb 16, 2000 at 11:42:29AM +0100, Kevin D. Kissell wrote:

> >Funky trick, isn't it?  I don't have the the R4600 / R5000 docs at hand
> >but as I understood them the above code should also work just perfect
> >for them.
> 
> No.  Not as I read the specs.  There are three problems here.
> 
> First, the question is *not* one of no-ops between the TLBWR
> and the ERET, but of no-ops between the MTC0 and the
> TLBWR - re-read the quoted text above from my previous
> message.  So the code may well be broken as I conjectured
> even if your assumption about the branch delay was valid.

Exactly _that_ is the trick.  The pipeline will execute the two extra
branch penalty cycles _after_ the tlbwr instruction.  That is exactly
what according to my reading of the manual is necessary in order to
guarantee correct operation.

The c0 hazard between the mtc0 and tlbwr is also taken care of by the
branch instruction itself, there is only one instruction necessary and
as per r4k manual any instruction does.

Yes, it's obfuscating.  However David Miller put this in the code, I
guess he took this trick from IRIX and I took it from him.  I think
it's highly unlikely that we all made the same mistake - and that nobody
got bit by this for a the past few years.

That said, the whole TLB exception handling is sometimes very performance
sensitive.  We've got good reason to optimize it at almost any price.
So the whole thing should be rewritten anyway.

> Second, the R5000 and R4600 piprlines are not as deep
> as those of the R4000/4400.   The R5000 documentation
> calls out a branch implementation with a *single* delay cycle.
> I quote: "The one cycle branch delay is a result of the branch
> comparison logic operating during the 1A pipeline stage of
> the branch.  This allows the branch target address calculated
> in the previous stage to be used for the instruction access in
> the following 1I phase."   So even if the execution of the
> branch were inserting delay between the MTC0 and the
> TLBWR as you seemed to assume, it might not be inserting
> as much delay as you think.

On the R4600 and R5000 the branch will be taken with a delay of a single
cycle, that is the instruction in the branch delay slot and no additional
penalty.  That's exactly what we want.

> Thirdly, this whole thread underscores why "clever" solutions that 
> depend on implementation features of particular CPUs should 
> be avoided whenever possible.

That's why we have a number of implementations of TLB exception handlers.
Let me reiterate that they are extremly performance sensitive.

> If you want to be assured of
> getting a delay cycle in a MIPS instruction stream, you should
> use a "SSNOP", (sll r0,r0,1 as opposed to the "nop" sll r0,r0,0),
> which forces delays even in superscalar implementations.
> 
> >> So someone with the ability to reproduce the R5000
> >> problem should really try sticking a nop between the
> >> mtc0 and the branch (sigh) to see if that stabilizes 
> >> the system.
> 
> I still think this would be a good idea.  Further, from Bill Earl's
> comment on this same thread, it sounds like, to be conservative,
>  trap_init() in arch/mips/kernel/traps.c needs to detect the R5000
> case and patch in except_vec0_r45k_bvahwbug instead
> of except_vec0_r4000, and that furthermore a nop (or ssnop) 
> be added between the MTC0 and the branch of 
> except_vec0_r45k_bvahwbug.

Indeed, and I'll do that.  The fact that we do not handle this bug is
simply an omission on my side.  The conditions that need to be true for
this bug to actually hit a system are sufficiently rare that I don't
wonder why nobody ever got hit by this.

> >Talking about CPU bugs - the R5230 and maybe it's relatives needs a nasty
> >workaround.  I think I only put the workaround into the Cobalt kernel.
> >Of course IDT doesn't admit that this bug even exists ...
> 
> Um, why should they, when IDT didn't do the R5230?  ;-)
> Seriously, did you mean to refer to the R323xx from IDT,
> or to QED as the design house for the R5230?  I have been 
> running 2.2.12 on an R5260 for months and it has been very 
> stable.   To which bug and which workaround are you referring?

Sorry, I permanently missattribute the R5230 to IDT even though the manual
says different in big letters on the frontpage.  This is the exception
handler from the Cobalt kernel.

	/*
	 * This version has a bug workaround for the Nevada.  It seems
	 * as if under certain circumstances the move from cp0_context
	 * might produce a bogus result when the mfc0 instruction and
	 * it's consumer are in a different cacheline or a load instruction,
	 * probably any memory reference, is between them.  This is
	 * potencially slower than the R4000 version, so we use this
	 * special version.
	 */
	LEAF(except_vec0_nevada)
	.set	mips3
	mfc0	k0, CP0_BADVADDR		# Get faulting address
	mfc0	k1, CP0_TAGLO
	srl	k0, k0, 22			# get pgd only bits
	sll	k0, k0, 2
	addu	k1, k1, k0			# add in pgd offset
	lw	k1, (k1)
	mfc0	k0, CP0_CONTEXT			# get context reg
	srl	k0, k0, 1			# get pte offset
	and	k0, k0, 0xff8
	addu	k1, k1, k0			# add in offset
	lw	k0, 0(k1)			# get even pte
	lw	k1, 4(k1)			# get odd pte
	srl	k0, k0, 6			# convert to entrylo0
	mtc0	k0, CP0_ENTRYLO0		# load it
	srl	k1, k1, 6			# convert to entrylo1
	mtc0	k1, CP0_ENTRYLO1		# load it
	tlbwr					# write random tlb entry
	nop
	nop
	eret					# return from trap
	END(except_vec0_nevada)

Note that this is a handler for Cobalt's 2.0 so it's not a drop in
replacement for what we have in other kernels.

What we observed was that the first access of the kernel to virtual
memory, that was buffer_init() which was still using vmalloc'ed memory
somehow was not being processed correctly.  We've never observed that the
bug hits at some other place.  The explanation given in above comment is a
possible explanation of what I suspect after playing with exception handler
modifications for a few hours.  Since the CPU is a blackbox for me I cannot
guarantee that this explanation is correct or even close to reality.

Two people at Cobalt did run independently into this problem and found that
c0_context was corrupted.  However when later on some of there other at
Cobalt were talking to QED they denied the possible existence of a bug like
this in their silicon.  Having an empirically correct workaround for this
problem we then stopped further tracking this problem.

  Ralf
