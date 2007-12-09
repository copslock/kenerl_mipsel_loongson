Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 09 Dec 2007 04:38:44 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:37297 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021932AbXLIEim (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 9 Dec 2007 04:38:42 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lB94cMt7017247;
	Sun, 9 Dec 2007 04:38:27 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lB94cLWp017246;
	Sun, 9 Dec 2007 04:38:21 GMT
Date:	Sun, 9 Dec 2007 04:38:21 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Kumba <kumba@gentoo.org>, linux-mips@linux-mips.org,
	rsandifo@nildram.co.uk
Subject: Re: [UPDATED PATCH] IP28 support
Message-ID: <20071209043821.GB13729@linux-mips.org>
References: <20071129095442.C6679C2B39@solo.franken.de> <20071129130130.GA14655@linux-mips.org> <4756422D.6070305@gentoo.org> <20071205093938.GA6848@alpha.franken.de> <87ejdx6pmh.fsf@firetop.home> <20071208192405.GA29208@linux-mips.org> <871w9x6j9g.fsf@firetop.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871w9x6j9g.fsf@firetop.home>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17738
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Dec 08, 2007 at 08:09:31PM +0000, Richard Sandiford wrote:

> Ralf Baechle <ralf@linux-mips.org> writes:
> > On Sat, Dec 08, 2007 at 05:52:06PM +0000, Richard Sandiford wrote:
> >> I tried to piece together (b) by asking questions in the reviews,
> >> but it would be great to have a single explanation.
> >> 
> >> The idea behind (c) is simple, of course: we insert a cache barrier
> >> before the potentially-problematic stores (and, for certain
> >> configurations, loads, although the original gcc patch had the
> >> associated macro hard-wired to false).  The key is explaining how,
> >> from a compiler internals viewpoint, we decide what is "potentially-
> >> problematic".  This ties in with the assumptions for (b).
> >
> > The principle for the compiler is a store is problematic unless proven
> > otherwise.  A speculative store relative to the stack pointer, frame
> > pointer or global pointer for example is harmless.
> 
> Right.  But just so we're on the same page (and I think we probably are),
> my point was that those rules aren't intrinsically obvious.  They're
> based on assumptions about how the code is written.  For example,
> it assumes there's no DMAing into stack variables.  Maybe obvious,
> but I think it needs to be stated explicitly.

Can't harm to be explicit.  Linux forbids DMA to the stack.  In that past
DMA to the stack has caused alot of grief for Linux ports on some
architectures.

> Then there's the language-lawyerly code I gave to Peter on gcc-patches@:
> 
>      void foo (int x)
>      {
>        int array[1];
>        if (x)
>          bar (array[0x1fff]);
>      }
> 
> This function is valid if x is never true, so we cannot assume that all
> accesses off the stack and frame pointers are actually in-frame.  You're
> assuming either (i) the kernel doesn't use code like that or (ii) that
> "garbage" addresses in the range [$sp - 0x8000, $sp + 0x7fff] will not
> trigger the problem.  I imagine both are reasonable assumptions, and I'm
> perfectly happy for us to make them.  But they're the kind of assumption
> we need to state explicitly.

Interesting test case.  I've been thinking about it myself but in the end
decieded to believe Peter's analysis since he's banged the head for longer
to the wall about this problem that I have ;-)  I'm quite but not absolutely
certain that this case cannot happen for realworld code, so I'd rather
err on the side of caution.

Peter & Thomas - we could make the stack thing bullet proof by vmallocing
stacks and ensuring a sufficient virtual address gap exists around the stack
such that the stack is the only addressable thing in the range of
$sp +0x7fff / -0x8000?

A -mr10k-cache-barrier=sp-is-safe option?

> Peter's patch also treated accesses to constant integer and symbolic
> addresses as safe.  Again, this involves making assumptions about how
> constant integer and symbolic addresses are used, and this is a much
> less obvious assumption than the stack one.

The latter assumption is also needed for -msym32 kernels, so it's well
proven to be valid.  The former hold, too.

>  Again, I understand that
> it's a reasonable assumption to make in the linux context, but it's one
> we need to pin down.  E.g. there must be no run-time guarding of
> target-specific constant integer IO-mapped addresses in cases where
> those addresses might trigger the problem on other systems that the
> same kernel image supports.

In case of a hypothetic multi-platform kernel of which at least one needs
the R10000 workarounds, all code would be uniformly compiled with the
magic -mr10k-cache-barrier option and all source level workaround would
be enabled.

> Despite appearances, I'm not trying to be awkward here ;)  I just think
> the assumptions are too loosely-defined at the moment (or at least too
> scattered around).  It would be nice to have some self-contained
> description, targetted specifically at gcc and linux, that contains
> anything a gcc hacker or user needs to know about the gcc patch.

Your help is certainly appreciated and trying to find the potencial holes
here will only help.

  Ralf
