Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Dec 2007 23:33:15 +0000 (GMT)
Received: from smtp.nildram.co.uk ([195.112.4.54]:55559 "EHLO
	smtp.nildram.co.uk") by ftp.linux-mips.org with ESMTP
	id S20022522AbXLHXdG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 8 Dec 2007 23:33:06 +0000
Received: from firetop.home (85-211-134-127.dyn.gotadsl.co.uk [85.211.134.127])
	by smtp.nildram.co.uk (Postfix) with ESMTP id 35A502C9E98;
	Sat,  8 Dec 2007 23:24:00 +0000 (GMT)
Received: from richard by firetop.home with local (Exim 4.63)
	(envelope-from <rsandifo@nildram.co.uk>)
	id 1J191f-00010V-NA; Sat, 08 Dec 2007 23:24:03 +0000
From:	Richard Sandiford <rsandifo@nildram.co.uk>
To:	post@pfrst.de
Mail-Followup-To: post@pfrst.de,Ralf Baechle <ralf@linux-mips.org>,  Thomas Bogendoerfer <tsbogend@alpha.franken.de>,  Kumba <kumba@gentoo.org>,  linux-mips@linux-mips.org, rsandifo@nildram.co.uk
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Kumba <kumba@gentoo.org>, linux-mips@linux-mips.org
Subject: Re: [UPDATED PATCH] IP28 support
References: <20071129095442.C6679C2B39@solo.franken.de>
	<20071129130130.GA14655@linux-mips.org> <4756422D.6070305@gentoo.org>
	<20071205093938.GA6848@alpha.franken.de> <87ejdx6pmh.fsf@firetop.home>
	<20071208192405.GA29208@linux-mips.org> <871w9x6j9g.fsf@firetop.home>
	<Pine.LNX.4.58.0712082217370.14975@Indigo2.Peter>
Date:	Sat, 08 Dec 2007 23:24:03 +0000
In-Reply-To: <Pine.LNX.4.58.0712082217370.14975@Indigo2.Peter> (peter fuerst's
	message of "Sat\, 8 Dec 2007 22\:25\:01 +0100 \(CET\)")
Message-ID: <87wsro6a98.fsf@firetop.home>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <rsandifo@nildram.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17737
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rsandifo@nildram.co.uk
Precedence: bulk
X-list: linux-mips

peter fuerst <post@pfrst.de> writes:
> could text like this help to pin the assumptions down (from
> "http://gcc.gnu.org/ml/gcc-patches/2006-05/msg01446.html") ?
>
>   "...
>   What cases of $N can be exempted from this measure?
>   - Stack-addresses and constant (static) addresses ("sd $M,symbol+n") will not
>     be used for DMA, since DMA-buffers are allocated at runtime.
>   - Uncached accesses will not be done speculatively, but they fall under the
>     "constant"-case already or will not be recognized at compile-time.
>
>   Besides the DMA-problem, depending on the mis-speculation path (up to four
>   branches deep), one of the frequently reused multi-purpose registers $N
>   will contain some "random" value, which may be a legal but invalid kernel-
>   address (say a800000061234567), reaching the memory-controller...
>   However, there are cases where a register $N's content is well defined, no
>   matter what (mis-)speculation path took us to this instruction:
>   - The stack-pointer points to the stack from kernel-initializtion on.
>   - Constant addresses ("symbol+n") are well defined "per se".
>   (Luckily, legal-but-invalid doesn't occur in user mode, where no cache-
>   barriers can be used. There we get either an address-error or a TLB-miss,
>   leaving memory/bus untouched.)
>   ..."

Well, the explanation of the exceptions doesn't really address the
corner cases I was trying to draw attention to in the message you
replied to.  What about top of the stack + X?  Do we guarantee that
the code will never cause the compiler to generate a store to such
an address, even with an always-false guard?  Or do we guarantee
that stores and loads to [top-of-stack, top-of-stack + 0x7fff] can
be speculated safely?  Do we guarantee that every store and load to
a cached constant address in the kernel image will not result in
a harmful IO access on any target that the image supports?

Perhaps we should just turn this around slightly and instead say:
what must the compiler do, and when must it do it?  The reasons why
aren't that important from the compiler's perspective.  So if we can
just phrase it as:

-mr10k-cache-barrier=load-store
  Insert a cache barrier at the beginning of any sequentially-executed
  series of instructions that contains a load or store.  For the purposes
  of this option, GCC can ignore loads and stores that it can prove:

  (a) access a region in the range [-0x8000 + bottom of stack frame,
      0x7fff + top of stack frame]; or
  (b) access a link-time-constant address.

  Here, a ``sequentially-executed series'' is one in which calls,
  jumps and branches occur only as the last instruction.

-mr10k-cache-barrier=store
  Like -mr10k-cache-barrier=load-store, but ignore all loads.

-mr10k-cache-barrier=none
  ...

And if you guys are willing to make sure that's safe, and change
the kernel whenever you find instances that it isn't safe, then
that should be enough.  (Bear in mind that there's ongoing work
to do link-time optimisation in gcc, so translation-unit separation
is no real guarantee.)

Richard
