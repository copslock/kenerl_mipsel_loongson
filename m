Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Dec 2007 15:27:08 +0000 (GMT)
Received: from mail1.pearl-online.net ([62.159.194.147]:41288 "EHLO
	mail1.pearl-online.net") by ftp.linux-mips.org with ESMTP
	id S20032396AbXLLP07 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 12 Dec 2007 15:26:59 +0000
Received: from SNaIlmail.Peter (77.47.4.157.static.cablesurf.de [77.47.4.157])
	by mail1.pearl-online.net (Postfix) with ESMTP id 978ADB14C;
	Wed, 12 Dec 2007 16:27:28 +0100 (CET)
Received: from Indigo2.Peter (Indigo2.Peter [192.168.1.28])
	by SNaIlmail.Peter (8.12.6/8.12.6/Sendmail/Linux 2.0.32) with ESMTP id lBCFQZ9U000788;
	Wed, 12 Dec 2007 16:26:36 +0100
Received: from Indigo2.Peter (localhost [127.0.0.1])
	by Indigo2.Peter (8.12.6/8.12.6/Sendmail/Linux 2.6.14-rc2-ip28) with ESMTP id lBCFQVmq000535;
	Wed, 12 Dec 2007 16:26:31 +0100
Received: from localhost (pf@localhost)
	by Indigo2.Peter (8.12.6/8.12.6/Submit) with ESMTP id lBCFQVfF000532;
	Wed, 12 Dec 2007 16:26:31 +0100
Date:	Wed, 12 Dec 2007 16:26:31 +0100 (CET)
From:	peter fuerst <pf@pfrst.de>
To:	Richard Sandiford <rsandifo@nildram.co.uk>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Kumba <kumba@gentoo.org>, linux-mips@linux-mips.org
Subject: Re: [UPDATED PATCH] IP28 support
In-Reply-To: <871w9u24rd.fsf@firetop.home>
Message-ID: <Pine.LNX.3.96.1071211004847.199A@PCD-4H>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <pf@pfrst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17790
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pf@pfrst.de
Precedence: bulk
X-list: linux-mips


On Mon, 10 Dec 2007, Richard Sandiford wrote:

> Ralf Baechle <ralf@linux-mips.org> writes:
> >> Then there's the language-lawyerly code I gave to Peter on gcc-patches@:
> >>
> >>      void foo (int x)
> >>      {
> >>        int array[1];
> >>        if (x)
> >>          bar (array[0x1fff]);
> >>      }
> >>

A strange method to pass data... Of course, cooking up such an "ABI",
where local variables are accessed with a const offset that is not known at
compile-time to be valid, would subvert the test for $sp-based accesses...

> >> This function is valid if x is never true, so we cannot assume that all
> >> accesses off the stack and frame pointers are actually in-frame.  You're
> >> assuming either (i) the kernel doesn't use code like that or (ii) that
> >> "garbage" addresses in the range [$sp - 0x8000, $sp + 0x7fff] will not
> >> trigger the problem.  I imagine both are reasonable assumptions, and I'm
> >> perfectly happy for us to make them.  But they're the kind of assumption
> >> we need to state explicitly.
> >
> > Interesting test case.  I've been thinking about it myself but in the end
> > decieded to believe Peter's analysis since he's banged the head for longer
> > to the wall about this problem that I have ;-)  I'm quite but not absolutely
> > certain that this case cannot happen for realworld code, so I'd rather
> > err on the side of caution.
> >
> > Peter & Thomas - we could make the stack thing bullet proof by vmallocing
> > stacks and ensuring a sufficient virtual address gap exists around the stack
> > such that the stack is the only addressable thing in the range of
> > $sp +0x7fff / -0x8000?

...but having an address-gap, virtual or by unused memory, should make it save
even with such code.

Typical "realworld" examples for speculative access to stack-variables are

void foo (int x)             void foo ()
{                            {
  int array[N];                int array[N], i;
  if (x < N)                   for (i = 0; i < N; i++)
    bar (array[x]);              array[i] = 0;
}                            }
i.e. accesses with non-const offsets, i.e. no longer $sp-based, which always
will trigger a CB.

>
> FWIW, my first cut at the option restrictions were based on what
> the patch exempts (and doesn't exempt).  We could instead get gcc
> to only exempt accesses that it can prove are either to the current
> function's stack frame or to its stack arguments.  I.e. rather than
> consider every $sp-based access to be safe, we'd instead do some

"every $sp-based access" (set(mem(plus(sp)(const_int)))) is restricted
to local variables too, with the constant offset being either
- compiler-generated or
- deliberately put in the source (however including the above example)

> bounds checking on the value.
Fine, if that is possible.

>                                (We could also use MEM_ATTRS to
> pick up cases where a stack variable is acceesed via something
> other than the stack or frame pointers, as happens for large frames.)

Aren't these always accesses with non-constant offset, where a CB can't be
avoided, even if they are recognized as being actually relative to $sp ?

>
> >> Peter's patch also treated accesses to constant integer and symbolic
> >> addresses as safe.  Again, this involves making assumptions about how
> >> constant integer and symbolic addresses are used, and this is a much
> >> less obvious assumption than the stack one.
> >
> > The latter assumption is also needed for -msym32 kernels, so it's well
> > proven to be valid.  The former hold, too.
> >
> >>  Again, I understand that
> >> it's a reasonable assumption to make in the linux context, but it's one
> >> we need to pin down.  E.g. there must be no run-time guarding of
> >> target-specific constant integer IO-mapped addresses in cases where
> >> those addresses might trigger the problem on other systems that the
> >> same kernel image supports.
> >
> > In case of a hypothetic multi-platform kernel of which at least one needs
> > the R10000 workarounds, all code would be uniformly compiled with the
> > magic -mr10k-cache-barrier option and all source level workaround would
> > be enabled.
>
> Hmm.  This probably shows I am misunderstanding the problem, but I was
> thinking about the IO-mapped case.  I thought one of the problems was
> that if you had a cached speculative load or store to an access-sensitive
> IO-mapped address, the IO-mapped device might "see" that access even if it
> doesn't take place.  Could you not have a situation where a KSEG0 or
> XKSEG0 access is access-sensitive on one machine and not another?
> The patch won't insert countermeasures before symbolic and constant
> addresses, because it believes all such addresses to be safe.
>

The threat to IO-addresses comes from the addressing register in the speculated
mem-instruction (set(mem(plus(reg)...), containing one of the addresses as
"garbage".

Symbolic addresses are well defined from link-time on, no matter what history
before the access.  They either point (set(mem(plus(symbol_ref)...) to
- some variable in the cached area, what is harmless (unless DMA-related),
  or to
- IO-devices, accessed uncached, i.e. non-speculative,
unless there is a programming-error ;)
The same holds for const_int used as address.

If used for DMA and also directly accessed, symbolic addresses could be
problematic though:
extern char big_fat_dma_buffer[N];
if (!dma_running)
	*big_fat_dma_buffer = 0;
else
	...
(However, as soon as accessed with non-constant offset - e.g. in a loop,... -
the symbol_ref disappears from the mem-instruction which will trigger a CB)

Btw. with 4.x symbolic addresses are practically (without backtrace analysis)
not exempted from CBs, since they no longer show up in the mem-instruction
and (set(mem(lo_sum(reg)... is seen instead.

> I'm also a little worried that the compiler is free to make up accesses
> that didn't exist in the original program, provided that those accesses
The cache-barrier itself ?

> are never actually performed in cases where they'd be wrong.  So how about:
>
> -mr10k-cache-barrier=load-store
>   Insert a cache barrier at the beginning of any sequentially-executed
>   series of instructions that contains a load or store.  For the purposes
>   of this option, GCC can ignore loads and stores that it can prove
>   are an in-range access to:
>
>   (a) the current function's stack frame;
>   (b) an incoming stack argument;
>   (b) an object with a link-time-constant address; or
>   (c) a block of uncached memory
Can we recognize uncached memory in the instruction ?

>
>   It can also ignore sequences that are always immediately preceded by
>   an untaken branch-likely instruction.
Fine!

>
>   Here, a ``sequentially-executed series'' is one in which calls,
>   jumps and branches occur only as the last instruction.
>
> -mr10k-cache-barrier=store
>   Like -mr10k-cache-barrier=load-store, but ignore all loads.
>
> -mr10k-cache-barrier=none
>   ...
>
> Richard
>
>
>

kind regards

peter
