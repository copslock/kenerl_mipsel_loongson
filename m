Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Dec 2007 19:24:13 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:52933 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20027576AbXLHTYK (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 8 Dec 2007 19:24:10 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lB8JO7e8029894;
	Sat, 8 Dec 2007 19:24:07 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lB8JO6uD029893;
	Sat, 8 Dec 2007 19:24:06 GMT
Date:	Sat, 8 Dec 2007 19:24:05 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Kumba <kumba@gentoo.org>, linux-mips@linux-mips.org,
	rsandifo@nildram.co.uk
Subject: Re: [UPDATED PATCH] IP28 support
Message-ID: <20071208192405.GA29208@linux-mips.org>
References: <20071129095442.C6679C2B39@solo.franken.de> <20071129130130.GA14655@linux-mips.org> <4756422D.6070305@gentoo.org> <20071205093938.GA6848@alpha.franken.de> <87ejdx6pmh.fsf@firetop.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ejdx6pmh.fsf@firetop.home>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17734
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Dec 08, 2007 at 05:52:06PM +0000, Richard Sandiford wrote:

> tsbogend@alpha.franken.de (Thomas Bogendoerfer) writes:
> > On Wed, Dec 05, 2007 at 01:16:13AM -0500, Kumba wrote:
> >> I've been out of it lately -- did the gcc side of things ever make it in, 
> >> or do we need to go push on that some more?
> >
> > We need push on that. Looking at 
> >
> > http://gcc.gnu.org/ml/gcc-patches/2006-04/msg00291.html
> >
> > there seems to be a missing understanding, why the cache
> > barriers are needed.
> 
> Heh.  Quite probably.  Which bit of my message don't you agree with?
> 
> FWIW, I was going off the original message as posted here:
> 
>     http://gcc.gnu.org/ml/gcc-patches/2006-03/msg00090.html
> 
> The explanation of the chosen workaround seemed to be left to this bit
> of http://mail-index.netbsd.org/port-sgimips/2000/06/29/0006.html:
> 
>     All is well with coherent IO systems.  On non coherent
>     systems like Indigo2 and O2 this creates a race
>     condition with DMA reads (IO->mem) where a stale
>     cached data can be written back over the DMAed data.

It's not a race condition.

>     R10K Indigo2:
> 
>     This issue was figured out late the the R10K I2
>     design cycle.  The problem was fixed by modifying
>     the compiler and assembler to issue a cache barrier
>     instruction to address 0(sp) as the first instruction
>     in basic blocks that contain stores to registers
>     other than $0 and $sp.
> 
> and from a compiler point of view, it would be nice to know
> _why_ that was a reasonable workaround.  What I was really
> looking for was: (a) a short description of the problem,
> (b) a list of assumptions that the compiler is going to
> make when working around the problem and (c) a description
> of what said workarounds are.
> 
> My understanding of (a) is that, if a store is speculatively executed,
> the target of the store might be fetched into cache and marked dirty.
> We therefore want to avoid the speculative execution of stores if:
> 
>   (1) the addressed memory might be the target of a later DMA operation.
>       If the DMA completes before the "dirty" cache line is flushed,
>       the cached data might overwrite the DMAed data.
> 
>   (2) the addressed memory might be to IO-mapped cached memory
>       (usually through the address being garbage).  The cached
>       data will be written back to the IO region when flushed.
> 
> We also want to avoid speculative execution of loads if:
> 
>   (3) the addressed memory might be to load-sensitive IO-mapped cached
>       memory (usually through the address being garbage).  The hardware
>       would "see" loads that aren't actually executed.
> 
> Is that vaguely accurate?

Yes.

> I tried to piece together (b) by asking questions in the reviews,
> but it would be great to have a single explanation.
> 
> The idea behind (c) is simple, of course: we insert a cache barrier
> before the potentially-problematic stores (and, for certain
> configurations, loads, although the original gcc patch had the
> associated macro hard-wired to false).  The key is explaining how,
> from a compiler internals viewpoint, we decide what is "potentially-
> problematic".  This ties in with the assumptions for (b).

The principle for the compiler is a store is problematic unless proven
otherwise.  A speculative store relative to the stack pointer, frame
pointer or global pointer for example is harmless.

> I'm sure my attempt at (a) above can be improved upon even if it's
> vaguely right.  But...
> 
> > I guess the patch could be improved
> > by pointing directly to the errata section of the R10k
> > user manual.
> 
> ...I think an integrated explanation of (a), (b) and (c) above
> would be better than quoting large parts of the processor manual.
> The processor manual is aimed at a much broader audience and has
> a lot of superfluous info.  It also doesn't explain what _our_
> assumptions are and what our chosen workaround is.

There are two R10000 manuals, one from SGI and one from NEC and they're
differing quite a bit on the workaround.  The SGI one gives a large number
of suggestions on how to work around the behaviour some of which even
require hardware asistance by on the system board.  A long time ago
Bill Earl, one of the engineers at SGI responsible for the workaround
emailed me this explanation which I believe is quite reasonable:

[...]
     The R10000 "bug" is, in a sense, a feature, in that it improves
performance, and is harmless on machines with cache-coherent I/O.
Specifically, on a speculative store miss (a cache miss due to a
speculatively executed store instruction), the R10000 fetches the line
dirty-exclusive and marks it modified, in anticipation of the store.
If, however, the speculatively executed store never graduates (is
never committed), the line is left dirty, even though it has not been
modified.  If the line happens to be part of a buffer into which data
is being DMAed, a subsequent victim writeback of the dirty cache line
might overwrite good data from the DMA with the obsolete data in the
cache line.  This means that, one way or the other, a system with
non-cache-coherent I/O and an R10000 must avoid allowing the
processor to perform a speculative store miss with respect to memory
into which a DMA is taking place.

     Note that the Indigo2 and O2 have somewhat different workarounds.
The Indigo2 deals with the kernel side using a special compilation mode,
and the O2 deals with the kernel side using a special hardware feature
plus a generalization of the solution for the user mode part of the problem.
Both deal with the user mode by invalidating TLB entries for pages into
which data is being transferred via DMA, so that the processor cannot
resolve the virtual address, and hence cannot speculatively fetch
a cache line at that address, while the DMA is in progress.  The kernel
side is harder, since the TLB is not used for K0SEG and XKPHYS address
spaces, which is where things get complicated.
[...]

I should mention that the hardware assissted solution for the O2 which is
implemented using an CPLD codenamed "juice" is not currently used by
Linux that is it relies on the same software-only workaround as the
Indigo 2 R10000.

  Ralf
