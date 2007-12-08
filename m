Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Dec 2007 21:39:56 +0000 (GMT)
Received: from mail1.pearl-online.net ([62.159.194.147]:49702 "EHLO
	mail1.pearl-online.net") by ftp.linux-mips.org with ESMTP
	id S20021622AbXLHVjr (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 8 Dec 2007 21:39:47 +0000
Received: from SNaIlmail.Peter (unknown [77.47.48.214])
	by mail1.pearl-online.net (Postfix) with ESMTP id E43FBBC74;
	Sat,  8 Dec 2007 22:40:15 +0100 (CET)
Received: from Indigo2.Peter (Indigo2.Peter [192.168.1.28])
	by SNaIlmail.Peter (8.12.6/8.12.6/Sendmail/Linux 2.0.32) with ESMTP id lB8LT2Hd001249;
	Sat, 8 Dec 2007 22:29:02 +0100
Received: from Indigo2.Peter (localhost [127.0.0.1])
	by Indigo2.Peter (8.12.6/8.12.6/Sendmail/Linux 2.6.20-ip28) with ESMTP id lB8LP1Q1014982;
	Sat, 8 Dec 2007 22:25:01 +0100
Received: from localhost (pf@localhost)
	by Indigo2.Peter (8.12.6/8.12.6/Submit) with ESMTP id lB8LP1wo014979;
	Sat, 8 Dec 2007 22:25:01 +0100
X-Authentication-Warning: Indigo2.Peter: pf owned process doing -bs
Date:	Sat, 8 Dec 2007 22:25:01 +0100 (CET)
From:	peter fuerst <post@pfrst.de>
X-X-Sender: pf@Indigo2.Peter
Reply-To: post@pfrst.de
To:	Richard Sandiford <rsandifo@nildram.co.uk>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Kumba <kumba@gentoo.org>, linux-mips@linux-mips.org
Subject: Re: [UPDATED PATCH] IP28 support
In-Reply-To: <871w9x6j9g.fsf@firetop.home>
Message-ID: <Pine.LNX.4.58.0712082217370.14975@Indigo2.Peter>
References: <20071129095442.C6679C2B39@solo.franken.de>
 <20071129130130.GA14655@linux-mips.org> <4756422D.6070305@gentoo.org>
 <20071205093938.GA6848@alpha.franken.de> <87ejdx6pmh.fsf@firetop.home>
 <20071208192405.GA29208@linux-mips.org> <871w9x6j9g.fsf@firetop.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <post@pfrst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17736
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: post@pfrst.de
Precedence: bulk
X-list: linux-mips


Hi!

could text like this help to pin the assumptions down (from
"http://gcc.gnu.org/ml/gcc-patches/2006-05/msg01446.html") ?

  "...
  What cases of $N can be exempted from this measure?
  - Stack-addresses and constant (static) addresses ("sd $M,symbol+n") will not
    be used for DMA, since DMA-buffers are allocated at runtime.
  - Uncached accesses will not be done speculatively, but they fall under the
    "constant"-case already or will not be recognized at compile-time.

  Besides the DMA-problem, depending on the mis-speculation path (up to four
  branches deep), one of the frequently reused multi-purpose registers $N
  will contain some "random" value, which may be a legal but invalid kernel-
  address (say a800000061234567), reaching the memory-controller...
  However, there are cases where a register $N's content is well defined, no
  matter what (mis-)speculation path took us to this instruction:
  - The stack-pointer points to the stack from kernel-initializtion on.
  - Constant addresses ("symbol+n") are well defined "per se".
  (Luckily, legal-but-invalid doesn't occur in user mode, where no cache-
  barriers can be used. There we get either an address-error or a TLB-miss,
  leaving memory/bus untouched.)
  ..."

kind regards

peter


On Sat, 8 Dec 2007, Richard Sandiford wrote:

> Date: Sat, 08 Dec 2007 20:09:31 +0000
> From: Richard Sandiford <rsandifo@nildram.co.uk>
> To: Ralf Baechle <ralf@linux-mips.org>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Kumba <kumba@gentoo.org>,
>      linux-mips@linux-mips.org
> Subject: Re: [UPDATED PATCH] IP28 support
>
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
> but I think it needs to be stated explicitly.  Then there's the
> language-lawyerly code I gave to Peter on gcc-patches@:
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
>
> Peter's patch also treated accesses to constant integer and symbolic
> addresses as safe.  Again, this involves making assumptions about how
> constant integer and symbolic addresses are used, and this is a much
> less obvious assumption than the stack one.  Again, I understand that
> it's a reasonable assumption to make in the linux context, but it's one
> we need to pin down.  E.g. there must be no run-time guarding of
> target-specific constant integer IO-mapped addresses in cases where
> those addresses might trigger the problem on other systems that the
> same kernel image supports.
>
> Despite appearances, I'm not trying to be awkward here ;)  I just think
> the assumptions are too loosely-defined at the moment (or at least too
> scattered around).  It would be nice to have some self-contained
> description, targetted specifically at gcc and linux, that contains
> anything a gcc hacker or user needs to know about the gcc patch.
>
> Richard
>
>
>
