Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Mar 2004 16:48:27 +0000 (GMT)
Received: from p508B7B8E.dip.t-dialin.net ([IPv6:::ffff:80.139.123.142]:45626
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224771AbUCIQs0>; Tue, 9 Mar 2004 16:48:26 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i29GmOex002514;
	Tue, 9 Mar 2004 17:48:24 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i29GmMld002513;
	Tue, 9 Mar 2004 17:48:22 +0100
Date: Tue, 9 Mar 2004 17:48:22 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Tiago Assump??o <module@whatever.org.ar>
Cc: linux-mips@linux-mips.org
Subject: Re: 2.4 kernels + >=binutils-2.14.90.0.8
Message-ID: <20040309164822.GD14262@linux-mips.org>
References: <404D0132.3020202@gentoo.org> <20040308234450.GF16163@rembrandt.csv.ica.uni-stuttgart.de> <404D0A18.6050802@gentoo.org> <20040309003447.GH16163@rembrandt.csv.ica.uni-stuttgart.de> <404D1909.1020005@gentoo.org> <20040309040919.GA11345@linux-mips.org> <6.0.0.22.0.20040309121104.01c25d30@whatever.org.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6.0.0.22.0.20040309121104.01c25d30@whatever.org.ar>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4517
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Mar 09, 2004 at 12:12:53PM -0300, Tiago Assump??o wrote:

> Yes, MIPS has no execution control flag in page-level.
> And agreed, yet I nor PaX team see a way to make MIPS fully supported by PaX
> -- if I'm not wrong, at the moment MIPS boards are only supported by ASLR.
> 
> I see that MIPS has split TLB's, which can not be distinguished by software
> level in another hand. Thus when a page-fault occours I don't see how a 
> piece of (non-microcoded) exception handler can get aware whether the
> I-Fetch is being done in original ``code area'' or as an attempt to execute
> injected payload in a memory area supposed to carry only readable/writeable
> data.

In a TLB reload handler you can distinguish betwen instruction and TLB
fault by comparing the fault address in badvaddr with the EPC value.  That
gives you non-exec protection for anything that doesn't already reside in
the TLB.  There is still one spare bit in the pagetables which you can use
as the exec permission bit.  So if I-fetch && !exec_bit -> SIGILL or
something like that.

The usual warning applies - any modification to the TLB code is going to
have extreme performance impact (a nop in the TLB reload handler will cost
about 0.5% of some benchmarks) and any attempts to execute code that is
already mapped will be missed.

Another better-than-nothing idea would be poisoning the I-cache by
pre-loading it.  Exploits probably don't flush the cache first so the
resulting I-cache non-coherence may crash the process instead.  Like
the previous idea this is performance intrusive and also a very dirty
solution.

> Plus situations like kseg0 and kseg1 unmaped translations, which would 
> occour
> outside of any TLB (having virtual address subtracted by 0x80000000 and
> 0xA0000000 respectively to get physiscal locations) making, as you 
> mentioned,
> only split uTLB's (not counting kseg2 special case). But PaX wants to take 
> care of
> kernel level security too.
> Even MIPS split cache unities (which can be probed separately by software) 
> wouldn't
> make the approach possible since if you have a piece of data previously 
> cached in
> D-Cache (load/store) the cache line would need to suffer an invalidation 
> and the
> context to be saved in the I-Cache before the I-Fetch pipe stage succeeds.

Okay, this paragraph was somewhat hard to understand so my comment may be
a bit off ...  All that's required is writing back data to memory or in
cache of Alchemy processors or uncached area not even that.  So chances
that exploit code actually works without having performed a cacheflush
are actually fairly good.

> Indeed, execution protection (in a general way) does not require split TLB.
> Other solutions designed and implemented by PaX are SEGMEXEC (using specific
> segmentation features of x86 basead core's) and MPROTECT. The last one uses
> vm_flags to control every memory mapping's state, ensuring that these never 
> hold
> VM_WRITE | VM_MAYWRITE together with VM_EXEC | VM_MAYEXEC. But as the
> solution becomes more complex it also tends to gain more issues. First of 
> all, this

> wouldn't be as simple and ``automatic'' as per page control. Another point 
> is that this

In the end anything less than per-page control is pretty inflexible.

> solution wouldn't prevent kernel level attacks so, among others, any 
> compromise in this level could lead to direct manipulation of a task's
> mappings flags. At the end a known problem is an attacker who is able to
> write to the filesystem and > to request this file to be mapped in
> memory as PROT_EXEC. In other words: yes it is  possible to achieve
> execution protection in other ways, but not as precise as page-level.

Okay, but that's outside the scope of what no-exec should attempt to do.

> If anybody has an idea of how to design and implement such solution on MIPS 
> computers

You could try to run the mapped kernel in supervisor mode.  Again lots
of performance implications.

  Ralf
