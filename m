Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Nov 2017 01:32:32 +0100 (CET)
Received: from 19pmail.ess.barracuda.com ([64.235.154.231]:38011 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992188AbdKQAcZU-Hfj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 Nov 2017 01:32:25 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1411.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Fri, 17 Nov 2017 00:32:08 +0000
Received: from [10.20.78.73] (10.20.78.73) by mips01.mipstec.com (10.20.43.31)
 with Microsoft SMTP Server id 14.3.361.1; Thu, 16 Nov 2017 16:32:07 -0800
Date:   Fri, 17 Nov 2017 00:31:56 +0000
From:   "Maciej W. Rozycki" <macro@mips.com>
To:     Joshua Kinard <kumba@gentoo.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Linux/MIPS <linux-mips@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>
Subject: Re: [PATCH] MIPS: Cleanup R10000_LLSC_WAR logic in atomic.h
In-Reply-To: <39133ddb-6b10-4a7b-6739-6f52fe8aa6a6@gentoo.org>
Message-ID: <alpine.DEB.2.00.1711162329430.3888@tp.orcam.me.uk>
References: <5baf0f58-862b-2488-8685-bf7383b19c20@gentoo.org> <alpine.LFD.2.21.1711041423530.23561@eddie.linux-mips.org> <9eea04e2-169d-e8d7-8f93-26e33e3d1145@gentoo.org> <alpine.DEB.2.00.1711141734540.3893@tp.orcam.me.uk>
 <39133ddb-6b10-4a7b-6739-6f52fe8aa6a6@gentoo.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-BESS-ID: 1510878727-452059-26975-108287-1
X-BESS-VER: 2017.14.1-r1710272128
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.187020
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
X-archive-position: 60978
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

On Tue, 14 Nov 2017, Joshua Kinard wrote:

> >  So we do have to make the result of DSUBU available to SCD and I propose 
> > to make an obvious update to the piece of code previously posted, which 
> > still does not require `noreorder' hacks:
> > 
> > 		__asm__ __volatile__(
> > 		"	.set	"MIPS_ISA_LEVEL"			\n"
> > 		"1:	lld	%1, %2		# atomic64_sub_if_positive\n"
> > 		"	dsubu	%0, %1, %3				\n"
> > 		"	move	%1, %0					\n"
> > 		"	bltz	%0, 1f					\n"
> > 		"	scd	%1, %2					\n"
> > 		"\t" __scbeqz "	%1, 1b					\n"
> > 		"1:							\n"
> > 		"	.set	mips0					\n"
> > 		: "=&r" (result), "=&r" (temp),
> > 		  "+" GCC_OFF_SMALL_ASM() (v->counter)
> > 		: "Ir" (i));
> > 
> > and uses the same instruction count, in terms of both the code size and 
> > the number of instructions actually executed, because previously BLTZ 
> > would have its delay slot filled with a NOP and now the MOVE instruction 
> > will go there.
> 
> I thought the delay slot for branch instructions came after the instruction?
> Shouldn't the "move" go after "bltz", or is this a case where "bltz" has its
> delay slot before?

 In terms of the program flow you want the move operation ahead of the 
branch.

 Of course we have the architectural peculiarity of branch delay slots, 
but in the MIPS assembly language they have been intended to be generally 
hidden from the programmer.  This is why the original MIPSCO assembler 
scheduled delay slots, which included branch delay slots, but also load 
delay slots, coprocessor transfer delay slots, etc., where the given 
architecture level had them, so that the programmer could write code as if 
there were no delay slots and let the tool optimise it.  

 And GAS normally does that as well, where possible by swapping a branch 
with the preceding instruction, or otherwise, i.e. where there is a data 
dependency or the instruction is not allowed in a delay slot for some 
reason, by inserting a NOP.

 GAS also has a way to disable delay slot scheduling, with the `.set 
noreorder' pseudo-op (with `.set reorder' undoing the effect).  In this 
mode of operation, sometimes called the `noreorder' mode, GAS assembles 
source code as it is and it is the programmer's responsibility to satisfy 
various pipeline requirements, including branch delay slots in particular, 
i.e. an instruction has to be put there explicitly, even if it is a NOP.

 This mode will typically be used by a compiler for its assembly output. 
This mode is not recommended to use in handcoded assembly unless 
specifically required for a good reason.  One such reason is optimising 
code where there is a data dependency between a branch and its delay-slot 
instruction, e.g.:

	.set	noreorder
	bnez	$2, 0b
	 addiu	$2, -1
	.set	reorder

which avoids clobbering a temporary register and is smaller/quicker then a 
functional equivalent that does not schedule the delay slot manually like:

	move	$3, $2
	addiu	$2, -1
	bnez	$3, 0b

(in this case GAS will move the ADDIU instruction into the delay slot of 
the BNEZ instruction, because there is no data dependency between the 
two instructions).  And of course if you just write:

	addiu	$2, -1
	bnez	$2, 0b

then the semantics of this sequence will be different from the first one 
above, because the addition precedes rather than following the branch and 
$2 is a data dependency between the two instructions.  This data 
dependency will also make GAS put a NOP into the delay slot of the BNEZ 
instruction instead of moving ADDIU there.

 So in the piece I proposed at the top GAS will move the MOVE instruction 
into the delay slot of BLTZ -- that is unless it is in a dumb mode where 
it always uses NOPs, as recently discovered in the discussion here: 
<https://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-mips&i=alpine.DEB.2.00.1711151425100.3893%40tp.orcam.me.uk>.  
But that's just been a bug in our build system, which will hopefully be 
fixed soon; we ought to assume smart scheduling normally (delay-slot 
scheduling makes debugging trickier sometimes, in which case using the 
dumb mode can help).

> And I am safe in assuming the same change also applies for the non-64-bit case
> earlier that uses sc and subu?  The changes to the rest of the code also look
> good?  Don't want to miss any other quirky bugs :)

 Yeah, `atomic_sub_if_positive' suffers from the same problem, and the 
rest looks good to me; also none of the other pieces of code uses the 
`noreorder' mode.

  Maciej
