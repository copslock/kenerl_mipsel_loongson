Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Dec 2007 11:01:19 +0000 (GMT)
Received: from smtp.nildram.co.uk ([195.112.4.54]:42763 "EHLO
	smtp.nildram.co.uk") by ftp.linux-mips.org with ESMTP
	id S20024131AbXLJLBK (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 10 Dec 2007 11:01:10 +0000
Received: from firetop.home (85-211-134-127.dyn.gotadsl.co.uk [85.211.134.127])
	by smtp.nildram.co.uk (Postfix) with ESMTP id 3931C2B7945;
	Mon, 10 Dec 2007 11:00:53 +0000 (GMT)
Received: from richard by firetop.home with local (Exim 4.63)
	(envelope-from <rsandifo@nildram.co.uk>)
	id 1J1gNa-0004Lz-IN; Mon, 10 Dec 2007 11:00:54 +0000
From:	Richard Sandiford <rsandifo@nildram.co.uk>
To:	Ralf Baechle <ralf@linux-mips.org>
Mail-Followup-To: Ralf Baechle <ralf@linux-mips.org>,Thomas Bogendoerfer <tsbogend@alpha.franken.de>,  Kumba <kumba@gentoo.org>,  linux-mips@linux-mips.org, rsandifo@nildram.co.uk
Cc:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Kumba <kumba@gentoo.org>, linux-mips@linux-mips.org
Subject: Re: [UPDATED PATCH] IP28 support
References: <20071129095442.C6679C2B39@solo.franken.de>
	<20071129130130.GA14655@linux-mips.org> <4756422D.6070305@gentoo.org>
	<20071205093938.GA6848@alpha.franken.de> <87ejdx6pmh.fsf@firetop.home>
	<20071208192405.GA29208@linux-mips.org> <871w9x6j9g.fsf@firetop.home>
	<20071209043821.GB13729@linux-mips.org>
Date:	Mon, 10 Dec 2007 11:00:54 +0000
In-Reply-To: <20071209043821.GB13729@linux-mips.org> (Ralf Baechle's message
	of "Sun\, 9 Dec 2007 04\:38\:21 +0000")
Message-ID: <871w9u24rd.fsf@firetop.home>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <rsandifo@nildram.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17750
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rsandifo@nildram.co.uk
Precedence: bulk
X-list: linux-mips

Ralf Baechle <ralf@linux-mips.org> writes:
>> Then there's the language-lawyerly code I gave to Peter on gcc-patches@:
>> 
>>      void foo (int x)
>>      {
>>        int array[1];
>>        if (x)
>>          bar (array[0x1fff]);
>>      }
>> 
>> This function is valid if x is never true, so we cannot assume that all
>> accesses off the stack and frame pointers are actually in-frame.  You're
>> assuming either (i) the kernel doesn't use code like that or (ii) that
>> "garbage" addresses in the range [$sp - 0x8000, $sp + 0x7fff] will not
>> trigger the problem.  I imagine both are reasonable assumptions, and I'm
>> perfectly happy for us to make them.  But they're the kind of assumption
>> we need to state explicitly.
>
> Interesting test case.  I've been thinking about it myself but in the end
> decieded to believe Peter's analysis since he's banged the head for longer
> to the wall about this problem that I have ;-)  I'm quite but not absolutely
> certain that this case cannot happen for realworld code, so I'd rather
> err on the side of caution.
>
> Peter & Thomas - we could make the stack thing bullet proof by vmallocing
> stacks and ensuring a sufficient virtual address gap exists around the stack
> such that the stack is the only addressable thing in the range of
> $sp +0x7fff / -0x8000?

FWIW, my first cut at the option restrictions were based on what
the patch exempts (and doesn't exempt).  We could instead get gcc
to only exempt accesses that it can prove are either to the current
function's stack frame or to its stack arguments.  I.e. rather than
consider every $sp-based access to be safe, we'd instead do some
bounds checking on the value.  (We could also use MEM_ATTRS to
pick up cases where a stack variable is acceesed via something
other than the stack or frame pointers, as happens for large frames.)

>> Peter's patch also treated accesses to constant integer and symbolic
>> addresses as safe.  Again, this involves making assumptions about how
>> constant integer and symbolic addresses are used, and this is a much
>> less obvious assumption than the stack one.
>
> The latter assumption is also needed for -msym32 kernels, so it's well
> proven to be valid.  The former hold, too.
>
>>  Again, I understand that
>> it's a reasonable assumption to make in the linux context, but it's one
>> we need to pin down.  E.g. there must be no run-time guarding of
>> target-specific constant integer IO-mapped addresses in cases where
>> those addresses might trigger the problem on other systems that the
>> same kernel image supports.
>
> In case of a hypothetic multi-platform kernel of which at least one needs
> the R10000 workarounds, all code would be uniformly compiled with the
> magic -mr10k-cache-barrier option and all source level workaround would
> be enabled.

Hmm.  This probably shows I am misunderstanding the problem, but I was
thinking about the IO-mapped case.  I thought one of the problems was
that if you had a cached speculative load or store to an access-sensitive
IO-mapped address, the IO-mapped device might "see" that access even if it
doesn't take place.  Could you not have a situation where a KSEG0 or
XKSEG0 access is access-sensitive on one machine and not another?
The patch won't insert countermeasures before symbolic and constant
addresses, because it believes all such addresses to be safe.

I'm also a little worried that the compiler is free to make up accesses
that didn't exist in the original program, provided that those accesses
are never actually performed in cases where they'd be wrong.  So how about:

-mr10k-cache-barrier=load-store
  Insert a cache barrier at the beginning of any sequentially-executed
  series of instructions that contains a load or store.  For the purposes
  of this option, GCC can ignore loads and stores that it can prove
  are an in-range access to:

  (a) the current function's stack frame;
  (b) an incoming stack argument;
  (b) an object with a link-time-constant address; or
  (c) a block of uncached memory

  It can also ignore sequences that are always immediately preceded by
  an untaken branch-likely instruction.

  Here, a ``sequentially-executed series'' is one in which calls,
  jumps and branches occur only as the last instruction.

-mr10k-cache-barrier=store
  Like -mr10k-cache-barrier=load-store, but ignore all loads.

-mr10k-cache-barrier=none
  ...

Richard
