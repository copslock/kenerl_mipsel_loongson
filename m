Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Dec 2007 20:09:55 +0000 (GMT)
Received: from smtp.nildram.co.uk ([195.112.4.54]:36104 "EHLO
	smtp.nildram.co.uk") by ftp.linux-mips.org with ESMTP
	id S20029019AbXLHUJr (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 8 Dec 2007 20:09:47 +0000
Received: from firetop.home (85-211-134-127.dyn.gotadsl.co.uk [85.211.134.127])
	by smtp.nildram.co.uk (Postfix) with ESMTP id 77C1E2B7355;
	Sat,  8 Dec 2007 20:09:28 +0000 (GMT)
Received: from richard by firetop.home with local (Exim 4.63)
	(envelope-from <rsandifo@nildram.co.uk>)
	id 1J15zP-0008DO-Gp; Sat, 08 Dec 2007 20:09:31 +0000
From:	Richard Sandiford <rsandifo@nildram.co.uk>
To:	Ralf Baechle <ralf@linux-mips.org>
Mail-Followup-To: Ralf Baechle <ralf@linux-mips.org>,Thomas Bogendoerfer <tsbogend@alpha.franken.de>,  Kumba <kumba@gentoo.org>,  linux-mips@linux-mips.org, rsandifo@nildram.co.uk
Cc:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Kumba <kumba@gentoo.org>, linux-mips@linux-mips.org
Subject: Re: [UPDATED PATCH] IP28 support
References: <20071129095442.C6679C2B39@solo.franken.de>
	<20071129130130.GA14655@linux-mips.org> <4756422D.6070305@gentoo.org>
	<20071205093938.GA6848@alpha.franken.de> <87ejdx6pmh.fsf@firetop.home>
	<20071208192405.GA29208@linux-mips.org>
Date:	Sat, 08 Dec 2007 20:09:31 +0000
In-Reply-To: <20071208192405.GA29208@linux-mips.org> (Ralf Baechle's message
	of "Sat\, 8 Dec 2007 19\:24\:05 +0000")
Message-ID: <871w9x6j9g.fsf@firetop.home>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <rsandifo@nildram.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17735
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rsandifo@nildram.co.uk
Precedence: bulk
X-list: linux-mips

Ralf Baechle <ralf@linux-mips.org> writes:
> On Sat, Dec 08, 2007 at 05:52:06PM +0000, Richard Sandiford wrote:
>> I tried to piece together (b) by asking questions in the reviews,
>> but it would be great to have a single explanation.
>> 
>> The idea behind (c) is simple, of course: we insert a cache barrier
>> before the potentially-problematic stores (and, for certain
>> configurations, loads, although the original gcc patch had the
>> associated macro hard-wired to false).  The key is explaining how,
>> from a compiler internals viewpoint, we decide what is "potentially-
>> problematic".  This ties in with the assumptions for (b).
>
> The principle for the compiler is a store is problematic unless proven
> otherwise.  A speculative store relative to the stack pointer, frame
> pointer or global pointer for example is harmless.

Right.  But just so we're on the same page (and I think we probably are),
my point was that those rules aren't intrinsically obvious.  They're
based on assumptions about how the code is written.  For example,
it assumes there's no DMAing into stack variables.  Maybe obvious,
but I think it needs to be stated explicitly.  Then there's the
language-lawyerly code I gave to Peter on gcc-patches@:

     void foo (int x)
     {
       int array[1];
       if (x)
         bar (array[0x1fff]);
     }

This function is valid if x is never true, so we cannot assume that all
accesses off the stack and frame pointers are actually in-frame.  You're
assuming either (i) the kernel doesn't use code like that or (ii) that
"garbage" addresses in the range [$sp - 0x8000, $sp + 0x7fff] will not
trigger the problem.  I imagine both are reasonable assumptions, and I'm
perfectly happy for us to make them.  But they're the kind of assumption
we need to state explicitly.

Peter's patch also treated accesses to constant integer and symbolic
addresses as safe.  Again, this involves making assumptions about how
constant integer and symbolic addresses are used, and this is a much
less obvious assumption than the stack one.  Again, I understand that
it's a reasonable assumption to make in the linux context, but it's one
we need to pin down.  E.g. there must be no run-time guarding of
target-specific constant integer IO-mapped addresses in cases where
those addresses might trigger the problem on other systems that the
same kernel image supports.

Despite appearances, I'm not trying to be awkward here ;)  I just think
the assumptions are too loosely-defined at the moment (or at least too
scattered around).  It would be nice to have some self-contained
description, targetted specifically at gcc and linux, that contains
anything a gcc hacker or user needs to know about the gcc patch.

Richard
