Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Dec 2007 18:09:46 +0000 (GMT)
Received: from smtp.nildram.co.uk ([195.149.33.74]:38275 "EHLO
	smtp.nildram.co.uk") by ftp.linux-mips.org with ESMTP
	id S20034738AbXLLSJh (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 12 Dec 2007 18:09:37 +0000
Received: from firetop.home (85-211-134-127.dyn.gotadsl.co.uk [85.211.134.127])
	by smtp.nildram.co.uk (Postfix) with ESMTP id 593762DFFD5;
	Wed, 12 Dec 2007 18:09:29 +0000 (GMT)
Received: from richard by firetop.home with local (Exim 4.63)
	(envelope-from <rsandifo@nildram.co.uk>)
	id 1J2W1T-0001wj-Ls; Wed, 12 Dec 2007 18:09:31 +0000
From:	Richard Sandiford <rsandifo@nildram.co.uk>
To:	peter fuerst <pf@pfrst.de>
Mail-Followup-To: peter fuerst <pf@pfrst.de>,Ralf Baechle <ralf@linux-mips.org>,  Thomas Bogendoerfer <tsbogend@alpha.franken.de>,  Kumba <kumba@gentoo.org>,  linux-mips@linux-mips.org, rsandifo@nildram.co.uk
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Kumba <kumba@gentoo.org>, linux-mips@linux-mips.org
Subject: Re: [UPDATED PATCH] IP28 support
References: <Pine.LNX.3.96.1071211004847.199A@PCD-4H>
Date:	Wed, 12 Dec 2007 18:09:31 +0000
In-Reply-To: <Pine.LNX.3.96.1071211004847.199A@PCD-4H> (peter fuerst's message
	of "Wed\, 12 Dec 2007 16\:26\:31 +0100 \(CET\)")
Message-ID: <87hcinlr8k.fsf@firetop.home>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <rsandifo@nildram.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17795
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rsandifo@nildram.co.uk
Precedence: bulk
X-list: linux-mips

peter fuerst <pf@pfrst.de> writes:
>> Ralf Baechle <ralf@linux-mips.org> writes:
>> >> Then there's the language-lawyerly code I gave to Peter on gcc-patches@:
>> >>
>> >>      void foo (int x)
>> >>      {
>> >>        int array[1];
>> >>        if (x)
>> >>          bar (array[0x1fff]);
>> >>      }
>> >>
>
> A strange method to pass data... Of course, cooking up such an "ABI",
> where local variables are accessed with a const offset that is not known at
> compile-time to be valid, would subvert the test for $sp-based accesses...

Well, as I said when I gave that example originally, it's unlikely that
the example would be written in that form.  But hide the constants and
checks in configurable macros, and the general idea becomes a little
more feasible.

>> FWIW, my first cut at the option restrictions were based on what
>> the patch exempts (and doesn't exempt).  We could instead get gcc
>> to only exempt accesses that it can prove are either to the current
>> function's stack frame or to its stack arguments.  I.e. rather than
>> consider every $sp-based access to be safe, we'd instead do some
>
> "every $sp-based access" (set(mem(plus(sp)(const_int)))) is restricted
> to local variables too, with the constant offset being either
> - compiler-generated or
> - deliberately put in the source (however including the above example)

That's not literally true.  SP+INT addresses can be used to access
stack arguments too, and 4.x can optimise some varargs accesses to
compile-time base+offset addresses.  And as I said, the compiler is
free to make up accesses that aren't in fact valid for cases where
the access isn't made.  E.g. if you had a loop with a stride of 128,
the compiler could unroll the loop as many times as it likes.  Some
of the unrolled iterations might access areas outside the stack frame.
(You would hope that the compiler would be intelligent enough to crop
the iteration count in such cases, because the extra iterations should
never be used in valid code.  But that isn't the point.  The compiler
doesn't _need_ to crop the iteration count for correctness, and we're
talking about something we _do_ need for correctness.)

>> bounds checking on the value.
> Fine, if that is possible.

FWIW, the frame info is available in cfun->machine->frame at the time
your code runs.

>>                                (We could also use MEM_ATTRS to
>> pick up cases where a stack variable is acceesed via something
>> other than the stack or frame pointers, as happens for large frames.)
>
> Aren't these always accesses with non-constant offset, where a CB can't be
> avoided, even if they are recognized as being actually relative to $sp ?

The MEM_ATTRS I meant were MEM_EXPR + MEM_OFFSET, which only apply where
there is a known constant offset.

>> > In case of a hypothetic multi-platform kernel of which at least one needs
>> > the R10000 workarounds, all code would be uniformly compiled with the
>> > magic -mr10k-cache-barrier option and all source level workaround would
>> > be enabled.
>>
>> Hmm.  This probably shows I am misunderstanding the problem, but I was
>> thinking about the IO-mapped case.  I thought one of the problems was
>> that if you had a cached speculative load or store to an access-sensitive
>> IO-mapped address, the IO-mapped device might "see" that access even if it
>> doesn't take place.  Could you not have a situation where a KSEG0 or
>> XKSEG0 access is access-sensitive on one machine and not another?
>> The patch won't insert countermeasures before symbolic and constant
>> addresses, because it believes all such addresses to be safe.
>>
>
> The threat to IO-addresses comes from the addressing register in the speculated
> mem-instruction (set(mem(plus(reg)...), containing one of the addresses as
> "garbage".
>
> Symbolic addresses are well defined from link-time on, no matter what history
> before the access.  They either point (set(mem(plus(symbol_ref)...) to
> - some variable in the cached area, what is harmless (unless DMA-related),
>   or to
> - IO-devices, accessed uncached, i.e. non-speculative,
> unless there is a programming-error ;)
> The same holds for const_int used as address.

I think you're missing my point.  If you access an I/O-mapped device
through KSEG2 or an uncached XKPHYS address, is it not also physically
possible (though clearly unwise) to access it through KSEG0 or a cached
XKPHYS address too?  So can you guarantee that every const_int cached
address in a multi-platform kernel is not I/O-mapped on any of the r10k
platforms?  Or can you guarantee that the compiler will not manufacture
such an address from an otherwise harmless address?  Again, the key thing
is to think about what the compiler can validly do on non-r10k platforms,
however silly it might seem, and then make sure the workarounds cope
with it.

>> I'm also a little worried that the compiler is free to make up accesses
>> that didn't exist in the original program, provided that those accesses
> The cache-barrier itself ?

No, in general.  Optimisers (particularly loop optimisers) can invent
accesses that didn't exist in the original source code.  Normally they
would only be executed in correct circumstances, but with this
speculative execution, that might not be true.

>> are never actually performed in cases where they'd be wrong.  So how about:
>>
>> -mr10k-cache-barrier=load-store
>>   Insert a cache barrier at the beginning of any sequentially-executed
>>   series of instructions that contains a load or store.  For the purposes
>>   of this option, GCC can ignore loads and stores that it can prove
>>   are an in-range access to:
>>
>>   (a) the current function's stack frame;
>>   (b) an incoming stack argument;
>>   (b) an object with a link-time-constant address; or
>>   (c) a block of uncached memory
> Can we recognize uncached memory in the instruction ?

Well, I was just thinking about teaching the compiler about KSEG2,
the always-uncached XKPHYS addresses, etc.  (Sorry for messing up
the bullet letters there!)  The idea is that we have a correlation
between symbolic constants and C objects, so we can check whether
an offset in a symbolic constant is within the object.  We already
have code to do this in other situations.  But there is no correlation
between const_int addresses and C objects, and we cannot be sure that
a given const_int address existed in the original source code, so
I think the only safe thing is to check its uncached properties instead.

I know all this must be frustrating.  I'm sure your patches work great
as they are with current and past kernels, and current and past compilers.
The problem is that, if it becomes a mainline gcc feature, it needs to be
defined from first principles.  And we need to do that without assuming
that the accesses we're looking at existed in the original source code.

FWIW, I'm happy to help update the patch once we've agreed on an
option spec.

Richard
