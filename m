Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Dec 2007 17:52:19 +0000 (GMT)
Received: from smtp.nildram.co.uk ([195.112.4.54]:24338 "EHLO
	smtp.nildram.co.uk") by ftp.linux-mips.org with ESMTP
	id S20026287AbXLHRwI (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 8 Dec 2007 17:52:08 +0000
Received: from firetop.home (85-211-134-127.dyn.gotadsl.co.uk [85.211.134.127])
	by smtp.nildram.co.uk (Postfix) with ESMTP id 5B63B2B5F05;
	Sat,  8 Dec 2007 17:52:04 +0000 (GMT)
Received: from richard by firetop.home with local (Exim 4.63)
	(envelope-from <rsandifo@nildram.co.uk>)
	id 1J13qR-0006pZ-0X; Sat, 08 Dec 2007 17:52:07 +0000
From:	Richard Sandiford <rsandifo@nildram.co.uk>
To:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Mail-Followup-To: tsbogend@alpha.franken.de (Thomas Bogendoerfer),Kumba <kumba@gentoo.org>,  Ralf Baechle <ralf@linux-mips.org>,  linux-mips@linux-mips.org, rsandifo@nildram.co.uk
Cc:	Kumba <kumba@gentoo.org>, Ralf Baechle <ralf@linux-mips.org>,
	linux-mips@linux-mips.org
Subject: Re: [UPDATED PATCH] IP28 support
References: <20071129095442.C6679C2B39@solo.franken.de>
	<20071129130130.GA14655@linux-mips.org> <4756422D.6070305@gentoo.org>
	<20071205093938.GA6848@alpha.franken.de>
Date:	Sat, 08 Dec 2007 17:52:06 +0000
In-Reply-To: <20071205093938.GA6848@alpha.franken.de> (Thomas Bogendoerfer's
	message of "Wed\, 5 Dec 2007 10\:39\:38 +0100")
Message-ID: <87ejdx6pmh.fsf@firetop.home>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <rsandifo@nildram.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17731
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rsandifo@nildram.co.uk
Precedence: bulk
X-list: linux-mips

tsbogend@alpha.franken.de (Thomas Bogendoerfer) writes:
> On Wed, Dec 05, 2007 at 01:16:13AM -0500, Kumba wrote:
>> I've been out of it lately -- did the gcc side of things ever make it in, 
>> or do we need to go push on that some more?
>
> We need push on that. Looking at 
>
> http://gcc.gnu.org/ml/gcc-patches/2006-04/msg00291.html
>
> there seems to be a missing understanding, why the cache
> barriers are needed.

Heh.  Quite probably.  Which bit of my message don't you agree with?

FWIW, I was going off the original message as posted here:

    http://gcc.gnu.org/ml/gcc-patches/2006-03/msg00090.html

The explanation of the chosen workaround seemed to be left to this bit
of http://mail-index.netbsd.org/port-sgimips/2000/06/29/0006.html:

    All is well with coherent IO systems.  On non coherent
    systems like Indigo2 and O2 this creates a race
    condition with DMA reads (IO->mem) where a stale
    cached data can be written back over the DMAed data.

    R10K Indigo2:

    This issue was figured out late the the R10K I2
    design cycle.  The problem was fixed by modifying
    the compiler and assembler to issue a cache barrier
    instruction to address 0(sp) as the first instruction
    in basic blocks that contain stores to registers
    other than $0 and $sp.

and from a compiler point of view, it would be nice to know
_why_ that was a reasonable workaround.  What I was really
looking for was: (a) a short description of the problem,
(b) a list of assumptions that the compiler is going to
make when working around the problem and (c) a description
of what said workarounds are.

My understanding of (a) is that, if a store is speculatively executed,
the target of the store might be fetched into cache and marked dirty.
We therefore want to avoid the speculative execution of stores if:

  (1) the addressed memory might be the target of a later DMA operation.
      If the DMA completes before the "dirty" cache line is flushed,
      the cached data might overwrite the DMAed data.

  (2) the addressed memory might be to IO-mapped cached memory
      (usually through the address being garbage).  The cached
      data will be written back to the IO region when flushed.

We also want to avoid speculative execution of loads if:

  (3) the addressed memory might be to load-sensitive IO-mapped cached
      memory (usually through the address being garbage).  The hardware
      would "see" loads that aren't actually executed.

Is that vaguely accurate?

I tried to piece together (b) by asking questions in the reviews,
but it would be great to have a single explanation.

The idea behind (c) is simple, of course: we insert a cache barrier
before the potentially-problematic stores (and, for certain
configurations, loads, although the original gcc patch had the
associated macro hard-wired to false).  The key is explaining how,
from a compiler internals viewpoint, we decide what is "potentially-
problematic".  This ties in with the assumptions for (b).

I'm sure my attempt at (a) above can be improved upon even if it's
vaguely right.  But...

> I guess the patch could be improved
> by pointing directly to the errata section of the R10k
> user manual.

...I think an integrated explanation of (a), (b) and (c) above
would be better than quoting large parts of the processor manual.
The processor manual is aimed at a much broader audience and has
a lot of superfluous info.  It also doesn't explain what _our_
assumptions are and what our chosen workaround is.

Richard
