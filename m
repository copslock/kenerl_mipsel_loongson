Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Nov 2017 18:53:30 +0100 (CET)
Received: from 19pmail.ess.barracuda.com ([64.235.154.231]:39332 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992780AbdKNRxYQAVmX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Nov 2017 18:53:24 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1403.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Tue, 14 Nov 2017 17:53:11 +0000
Received: from [10.20.78.27] (10.20.78.27) by mips01.mipstec.com (10.20.43.31)
 with Microsoft SMTP Server id 14.3.361.1; Tue, 14 Nov 2017 09:53:06 -0800
Date:   Tue, 14 Nov 2017 17:52:53 +0000
From:   "Maciej W. Rozycki" <macro@mips.com>
To:     Joshua Kinard <kumba@gentoo.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Linux/MIPS <linux-mips@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: Re: [PATCH] MIPS: Cleanup R10000_LLSC_WAR logic in atomic.h
In-Reply-To: <9eea04e2-169d-e8d7-8f93-26e33e3d1145@gentoo.org>
Message-ID: <alpine.DEB.2.00.1711141734540.3893@tp.orcam.me.uk>
References: <5baf0f58-862b-2488-8685-bf7383b19c20@gentoo.org> <alpine.LFD.2.21.1711041423530.23561@eddie.linux-mips.org> <9eea04e2-169d-e8d7-8f93-26e33e3d1145@gentoo.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-BESS-ID: 1510681988-321459-2398-6720-12
X-BESS-VER: 2017.14-r1710272128
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186920
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Maciej.Rozycki@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60931
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@mips.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Mon, 6 Nov 2017, Joshua Kinard wrote:

> >> @@ -563,17 +464,17 @@ static __inline__ long atomic64_sub_if_positive(long i, atomic64_t * v)
> >>
> >>      smp_mb__before_llsc();
> >>
> >> -    if (kernel_uses_llsc && R10000_LLSC_WAR) {
> >> +    if (kernel_uses_llsc) {
> >>              long temp;
> >>
> >>              __asm__ __volatile__(
> >> -            "       .set    arch=r4000                              \n"
> >> +            "       .set    "MIPS_ISA_LEVEL"                        \n"
> >>              "1:     lld     %1, %2          # atomic64_sub_if_positive\n"
> >>              "       dsubu   %0, %1, %3                              \n"
> >>              "       bltz    %0, 1f                                  \n"
> >>              "       scd     %0, %2                                  \n"
> >>              "       .set    noreorder                               \n"
> >> -            "       beqzl   %0, 1b                                  \n"
> >> +            "\t" __scbeqz " %0, 1b                                  \n"
> >>              "        dsubu  %0, %1, %3                              \n"
> >>              "       .set    reorder                                 \n"
> >>              "1:                                                     \n"
> >
> >  This is obviously a preexisting bug, which has only been made more
> > obvious with your merge of this code, but this can't be right, because the
> > final DSUBU instruction which calculates `result', later returned, in %0
> > will not be executed with BEQZL in the fall-through case, however it will
> > be in the BEQZ case.
> 
> Oh, I see.  Because the subu/dsubu hides in the branch-delay slot, and thus, in
> a branch-likely case, gets skipped?

 AFAICT the only reason for the addition in the delay slot is to replay 
the operation made on the value fetched with LLD, recalculating the result 
of the subtraction lost due to SCD reusing the same register for its 
result.  And it only matters for the fall-through case, because otherwise 
the subtraction result is immediately overwritten by the value fetched by 
LLD on the next iteration.

 Actually I overlooked how SCD handles its source again and made a bug in 
the replacement code proposed, sorry.  See below for an update.

> >  It may make sense to split the temporary set by SCD from the result and
> > then the final DSUBU won't be needed at all as the result will have
> > already been calculated by the first DSUBU.  In fact ISTM %1 can simply be
> > used, i.e.:
> >
> >               __asm__ __volatile__(
> >               "       .set    "MIPS_ISA_LEVEL"                        \n"
> >               "1:     lld     %1, %2          # atomic64_sub_if_positive\n"
> >               "       dsubu   %0, %1, %3                              \n"
> >               "       bltz    %0, 1f                                  \n"
> >               "       scd     %1, %2                                  \n"
> >               "\t" __scbeqz " %1, 1b                                  \n"
> >               "1:                                                     \n"
> >               "       .set    mips0                                   \n"
> >               : "=&r" (result), "=&r" (temp),
> >                 "+" GCC_OFF_SMALL_ASM() (v->counter)
> >               : "Ir" (i));
> >
> > making this short and sweet, also avoiding the nasty `noreorder' piece and
> > therefore making it one place less to concern about with porting Linux to
> > the microMIPSr6 ISA.
> >
> >  I haven't gone through the remaining updates; it's just this piece that
> > has caught my eye as I glanced over your change.
> 
> I rolled these changes (and James' earlier suggestion to use the non-memory
> barrier bottom bits) into a v2 patch that I just sent in (also for the
> non-64bit case using subu).  I haven't tested the changes on my Octane yet, but
> am assuming it'll work.  Saving an instruction or two on a heavily-executed bit
> of code will likely yield some small benefits.

 So we do have to make the result of DSUBU available to SCD and I propose 
to make an obvious update to the piece of code previously posted, which 
still does not require `noreorder' hacks:

		__asm__ __volatile__(
		"	.set	"MIPS_ISA_LEVEL"			\n"
		"1:	lld	%1, %2		# atomic64_sub_if_positive\n"
		"	dsubu	%0, %1, %3				\n"
		"	move	%1, %0					\n"
		"	bltz	%0, 1f					\n"
		"	scd	%1, %2					\n"
		"\t" __scbeqz "	%1, 1b					\n"
		"1:							\n"
		"	.set	mips0					\n"
		: "=&r" (result), "=&r" (temp),
		  "+" GCC_OFF_SMALL_ASM() (v->counter)
		: "Ir" (i));

and uses the same instruction count, in terms of both the code size and 
the number of instructions actually executed, because previously BLTZ 
would have its delay slot filled with a NOP and now the MOVE instruction 
will go there.

  Maciej
