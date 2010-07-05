Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Jul 2010 15:35:42 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:58738 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491191Ab0GENfh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Jul 2010 15:35:37 +0200
Date:   Mon, 5 Jul 2010 14:35:37 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
cc:     Shinya Kuribayashi <skuribay@pobox.com>,
        David VomLehn <dvomlehn@cisco.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: PowerTV: Use fls() carefully where static optimization
 is required
In-Reply-To: <4C312860.3020005@renesas.com>
Message-ID: <alpine.LFD.2.00.1007050214210.11778@eddie.linux-mips.org>
References: <4C2755A3.3080600@pobox.com> <20100630220124.GA576@dvomlehn-lnx2.corp.sa.net> <4C2DF427.7080508@pobox.com> <20100702213219.GA390@dvomlehn-lnx2.corp.sa.net> <4C2F49D0.60200@pobox.com> <alpine.LFD.2.00.1007031748350.11778@eddie.linux-mips.org>
 <4C312860.3020005@renesas.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27320
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 5 Jul 2010, Shinya Kuribayashi wrote:

> Ah, that's the answer I'm looking for, thanks!  So current irq_ffs()
> form (clz() is enabled only when CONFIG_CPU_MIPS32/64 is selected) is
> well-suited for Malta platform, and it seems better to leave them as
> they are.  I'll drop the patch from my list.

 You still can and probably want to optimise.  You can have configuration 
dependencies in override files.

> >> +	if (__builtin_constant_p(cpu_has_clo_clz) && cpu_has_clo_clz) {
> >> +		int x;
> >> +		__asm__(
> >> +		"	.set	push					\n"
> >> +		"	.set	mips32					\n"
> >> +		"	clz	%0, %1					\n"
> >> +		"	.set	pop					\n"
> >> +		: "=r" (x)
> >> +		: "r" (pending));
> >> +
> >> +		return -x + 31 - CAUSEB_IP;
> >> +	}
> > 
> >  Hmm, ".set mips32" looks dodgy here.  For pre-MIPS32/64 platforms this 
> > code should never make it to the assembler and if it did, then a 
> > build-time error is better than a run-time problem.
> 
> I see, cpu_has_clo_clz doesn't work well for platforms such as Malta.
> Malta can support several ISAs at a time, which is very valuable, but
> hard to be optimized :-)

 Well, <asm/mach-malta/cpu-feature-overrides.h> seems to be getting this 
right.  MIPS IV options are not included as quite rare compared to 
MIPS32/64 ones and run-time determined defaults apply.  For MIPS32/64 
configurations compile-time optimisations work as usually.

> >  It might be simpler just to use __builtin_ffs() for this variant though.  
> > Inline assembly is better avoided unless absolutely required.  Not even 
> > mentioning readability.
> 
> Hm.  It might be simpler, but it's not the purpose of irq_ffs(), IMHO.

 My point is whenever cpu_has_clo_clz is hardcoded to 1 GCC will expand 
__builtin_ffs() to CLZ as expected and may potentially be able to optimise 
it further.  For the fallback path I agree you do not want to use 
__builtin_ffs() as you want to save processing time of the unneeded bits 
-- there's no 8-bit FFS intrinsic let alone a 4-bit one (I'm assuming 
there is a reason this piece of code does not check lower 4 interrupt 
inputs).

  Maciej
