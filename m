Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 23 Dec 2007 01:46:27 +0000 (GMT)
Received: from mail1.pearl-online.net ([62.159.194.147]:63826 "EHLO
	mail1.pearl-online.net") by ftp.linux-mips.org with ESMTP
	id S28575343AbXLWBqS (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 23 Dec 2007 01:46:18 +0000
Received: from SNaIlmail.Peter (unknown [77.47.54.105])
	by mail1.pearl-online.net (Postfix) with ESMTP id E6462B27F;
	Sun, 23 Dec 2007 02:45:30 +0100 (CET)
Received: from Indigo2.Peter (Indigo2.Peter [192.168.1.28])
	by SNaIlmail.Peter (8.12.6/8.12.6/Sendmail/Linux 2.0.32) with ESMTP id lBN1jA74000860;
	Sun, 23 Dec 2007 02:45:11 +0100
Received: from Indigo2.Peter (localhost [127.0.0.1])
	by Indigo2.Peter (8.12.6/8.12.6/Sendmail/Linux 2.6.14-rc2-ip28) with ESMTP id lBN1i2F5000219;
	Sun, 23 Dec 2007 02:44:02 +0100
Received: from localhost (pf@localhost)
	by Indigo2.Peter (8.12.6/8.12.6/Submit) with ESMTP id lBN1i1od000216;
	Sun, 23 Dec 2007 02:44:01 +0100
X-Authentication-Warning: Indigo2.Peter: pf owned process doing -bs
Date:	Sun, 23 Dec 2007 02:44:01 +0100 (CET)
From:	peter fuerst <post@pfrst.de>
X-X-Sender: pf@Indigo2.Peter
To:	Richard Sandiford <rsandifo@nildram.co.uk>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Kumba <kumba@gentoo.org>, linux-mips@linux-mips.org
Subject: Re: [UPDATED PATCH] IP28 support
Message-ID: <Pine.LNX.4.58.0712230242590.215@Indigo2.Peter>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <post@pfrst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17869
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: post@pfrst.de
Precedence: bulk
X-list: linux-mips



On Wed, 12 Dec 2007, Richard Sandiford wrote:

> Date: Wed, 12 Dec 2007 18:09:31 +0000
> From: Richard Sandiford <rsandifo@nildram.co.uk>
> To: peter fuerst <pf@pfrst.de>
> Cc: Ralf Baechle <ralf@linux-mips.org>,
>      Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
>      Kumba <kumba@gentoo.org>, linux-mips@linux-mips.org
> Subject: Re: [UPDATED PATCH] IP28 support
>
> peter fuerst <pf@pfrst.de> writes:
> >> Ralf Baechle <ralf@linux-mips.org> writes:
> >> >> Then there's the language-lawyerly code I gave to Peter on gcc-patches@:
> >> >>
> >> >>      void foo (int x)
> >> >>      {
> >> >>        int array[1];
> >> >>        if (x)
> >> >>          bar (array[0x1fff]);
> >> >>      }
> >> >>
> >
> > A strange method to pass data... Of course, cooking up such an "ABI",
> > where local variables are accessed with a const offset that is not known at
> > compile-time to be valid, would subvert the test for $sp-based accesses...
>
> Well, as I said when I gave that example originally, it's unlikely that
> the example would be written in that form.  But hide the constants and
> checks in configurable macros, and the general idea becomes a little
> more feasible.
>
> >> FWIW, my first cut at the option restrictions were based on what
> >> the patch exempts (and doesn't exempt).  We could instead get gcc
> >> to only exempt accesses that it can prove are either to the current
> >> function's stack frame or to its stack arguments.  I.e. rather than
> >> consider every $sp-based access to be safe, we'd instead do some
> >
> > "every $sp-based access" (set(mem(plus(sp)(const_int)))) is restricted
> > to local variables too, with the constant offset being either
> > - compiler-generated or
> > - deliberately put in the source (however including the above example)
>
> That's not literally true.  SP+INT addresses can be used to access
> stack arguments too, and 4.x can optimise some varargs accesses to

"local variables" was meant to include (var-)argument-slots too, which are
allright, so far.

> compile-time base+offset addresses.  And as I said, the compiler is
> free to make up accesses that aren't in fact valid for cases where
> the access isn't made.  E.g. if you had a loop with a stride of 128,
> the compiler could unroll the loop as many times as it likes.  Some
> of the unrolled iterations might access areas outside the stack frame.

You mean, the compiler would generate $sp+const_int accesses here, whose
validity is not known at compile-time - similar to foo() above ?

> (You would hope that the compiler would be intelligent enough to crop
> the iteration count in such cases, because the extra iterations should
> never be used in valid code.  But that isn't the point.  The compiler
> doesn't _need_ to crop the iteration count for correctness, and we're
> talking about something we _do_ need for correctness.)
>
> >> bounds checking on the value.
> > Fine, if that is possible.
>
> FWIW, the frame info is available in cfun->machine->frame at the time
> your code runs.
>
> >>                                (We could also use MEM_ATTRS to
> >> pick up cases where a stack variable is acceesed via something
> >> other than the stack or frame pointers, as happens for large frames.)
> >
> > Aren't these always accesses with non-constant offset, where a CB can't be
> > avoided, even if they are recognized as being actually relative to $sp ?
>
> The MEM_ATTRS I meant were MEM_EXPR + MEM_OFFSET, which only apply where
> there is a known constant offset.
>
> >> > In case of a hypothetic multi-platform kernel of which at least one needs
> >> > the R10000 workarounds, all code would be uniformly compiled with the
> >> > magic -mr10k-cache-barrier option and all source level workaround would
> >> > be enabled.
> >>
> >> Hmm.  This probably shows I am misunderstanding the problem, but I was
> >> thinking about the IO-mapped case.  I thought one of the problems was
> >> that if you had a cached speculative load or store to an access-sensitive
> >> IO-mapped address, the IO-mapped device might "see" that access even if it
> >> doesn't take place.  Could you not have a situation where a KSEG0 or
> >> XKSEG0 access is access-sensitive on one machine and not another?
> >> The patch won't insert countermeasures before symbolic and constant
> >> addresses, because it believes all such addresses to be safe.
> >>
> >
> > The threat to IO-addresses comes from the addressing register in the speculated
> > mem-instruction (set(mem(plus(reg)...), containing one of the addresses as
> > "garbage".
> >
> > Symbolic addresses are well defined from link-time on, no matter what history
> > before the access.  They either point (set(mem(plus(symbol_ref)...) to
> > - some variable in the cached area, what is harmless (unless DMA-related),
> >   or to
> > - IO-devices, accessed uncached, i.e. non-speculative,
> > unless there is a programming-error ;)
> > The same holds for const_int used as address.
>
> I think you're missing my point.  If you access an I/O-mapped device
> through KSEG2 or an uncached XKPHYS address, is it not also physically
> possible (though clearly unwise) to access it through KSEG0 or a cached
> XKPHYS address too?  So can you guarantee that every const_int cached
> address in a multi-platform kernel is not I/O-mapped on any of the r10k
> platforms?  Or can you guarantee that the compiler will not manufacture
> such an address from an otherwise harmless address?
Hmm, it's not quite clear, how it could be manufactured.
>                                                     Again, the key thing
> is to think about what the compiler can validly do on non-r10k platforms,
> however silly it might seem, and then make sure the workarounds cope
> with it.

Do you think of accesses that essentially look like this ?

  if (machine_x)
     *uncached(const_addr) = val;
  else
     *cached(const_addr) = val;

Fortunately (at least? even?) on IP28 cached access (hence a block read
request) to an I/O-device address is a non-issue. In this respect the
hardware design seems to follow the recommendations from the R10000 manual
(NACK from external agent?):
- if such an access graduates (i.e. a "real" access), a bus-error will occur.
- if not (i.e. mis-speculated), nothing happens.

However, i don't yet know, how O2 behaves, or, if there exists any other
R10k-machine, which would need the software-workaround.

>
> >> I'm also a little worried that the compiler is free to make up accesses
> >> that didn't exist in the original program, provided that those accesses
> > The cache-barrier itself ?
>
> No, in general.  Optimisers (particularly loop optimisers) can invent
> accesses that didn't exist in the original source code.  Normally they
> would only be executed in correct circumstances, but with this
> speculative execution, that might not be true.
>
> >> are never actually performed in cases where they'd be wrong.  So how about:
> >>
> >> -mr10k-cache-barrier=load-store
> >>   Insert a cache barrier at the beginning of any sequentially-executed
> >>   series of instructions that contains a load or store.  For the purposes
> >>   of this option, GCC can ignore loads and stores that it can prove
> >>   are an in-range access to:
> >>
> >>   (a) the current function's stack frame;
> >>   (b) an incoming stack argument;
> >>   (b) an object with a link-time-constant address; or
> >>   (c) a block of uncached memory
> > Can we recognize uncached memory in the instruction ?
>
> Well, I was just thinking about teaching the compiler about KSEG2,
> the always-uncached XKPHYS addresses, etc.  (Sorry for messing up
> the bullet letters there!)  The idea is that we have a correlation
> between symbolic constants and C objects, so we can check whether
> an offset in a symbolic constant is within the object.  We already

No doubt, this would be very helpfull.

> have code to do this in other situations.  But there is no correlation
> between const_int addresses and C objects, and we cannot be sure that
> a given const_int address existed in the original source code, so
> I think the only safe thing is to check its uncached properties instead.
>
> I know all this must be frustrating.  I'm sure your patches work great
> as they are with current and past kernels, and current and past compilers.
> The problem is that, if it becomes a mainline gcc feature, it needs to be
> defined from first principles.

Agreed, the design of any feature advantageously should be based on a clear
(more or less formal) specification of what the compiler can do.

>                                 And we need to do that without assuming
> that the accesses we're looking at existed in the original source code.
>
> FWIW, I'm happy to help update the patch once we've agreed on an

This would be appreciated (of course :) Many thanks in advance!

> option spec.

Well, the option spec could be as listed above. With "store" as default
for an empty option-string ("none" as default if the option isn't given
at all).

>
> Richard
>
>

kind regards

peter


PS: apologies for delaying the answer, i just couldn't concentrate on
this topic recently.
