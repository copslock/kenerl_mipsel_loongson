Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Jul 2010 13:44:04 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:44106 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492082Ab0GELoB (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 5 Jul 2010 13:44:01 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id o65Bht5Q013958;
        Mon, 5 Jul 2010 12:43:56 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id o65BhrB9013957;
        Mon, 5 Jul 2010 12:43:53 +0100
Date:   Mon, 5 Jul 2010 12:43:52 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
Cc:     "Maciej W. Rozycki" <macro@linux-mips.org>,
        Shinya Kuribayashi <skuribay@pobox.com>,
        David VomLehn <dvomlehn@cisco.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: PowerTV: Use fls() carefully where static
 optimization is required
Message-ID: <20100705114352.GB12699@linux-mips.org>
References: <4C2755A3.3080600@pobox.com>
 <20100630220124.GA576@dvomlehn-lnx2.corp.sa.net>
 <4C2DF427.7080508@pobox.com>
 <20100702213219.GA390@dvomlehn-lnx2.corp.sa.net>
 <4C2F49D0.60200@pobox.com>
 <alpine.LFD.2.00.1007031748350.11778@eddie.linux-mips.org>
 <4C312860.3020005@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4C312860.3020005@renesas.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27315
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jul 05, 2010 at 09:33:36AM +0900, Shinya Kuribayashi wrote:

> On 7/4/2010 2:03 AM, Maciej W. Rozycki wrote:
> >  Malta also supports a couple of MIPS IV processors too, so please be 
> > careful about such assumptions.
> 
> Ah, that's the answer I'm looking for, thanks!  So current irq_ffs()
> form (clz() is enabled only when CONFIG_CPU_MIPS32/64 is selected) is
> well-suited for Malta platform, and it seems better to leave them as
> they are.  I'll drop the patch from my list.
> 
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

For pedantic accuracy - the IDT RC32364 introduced CLO and CLZ; in an act
of uglyness the RC64574 then inherited these two instructions but did not
add. though it was 64-bit not DCLO and DCLZ; the NEC VR5500 has the full
complement of CLO, CLZ, DCLO and DCLZ.

> I see, cpu_has_clo_clz doesn't work well for platforms such as Malta.
> Malta can support several ISAs at a time, which is very valuable, but
> hard to be optimized :-)

While MIPS IV CPU cards for the Malta are available hardly anybody is using
on of those cards.  Thus cpu_has_clo_clz defaults to cpu_has_mips_r and
ideally and platform should see cpu_has_mips_r to a constant to allow best
possible optimization.  Malta doesn't ...

> >  It might be simpler just to use __builtin_ffs() for this variant though.  
> > Inline assembly is better avoided unless absolutely required.  Not even 
> > mentioning readability.
> 
> Hm.  It might be simpler, but it's not the purpose of irq_ffs(), IMHO.

Indeed.

  Ralf
