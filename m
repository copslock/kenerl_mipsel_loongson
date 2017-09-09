Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 09 Sep 2017 12:13:37 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:30064 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990451AbdIIKNaWmM57 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 9 Sep 2017 12:13:30 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 65635EBBE2B41;
        Sat,  9 Sep 2017 11:13:21 +0100 (IST)
Received: from [10.20.78.233] (10.20.78.233) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Sat, 9 Sep 2017
 11:13:22 +0100
Date:   Sat, 9 Sep 2017 11:13:15 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Fredrik Noring <noring@nocrew.org>
CC:     <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: Add basic R5900 support
In-Reply-To: <20170902102830.GA2602@localhost.localdomain>
Message-ID: <alpine.DEB.2.00.1709091022180.4331@tp.orcam.me.uk>
References: <20170827132309.GA32166@localhost.localdomain> <alpine.DEB.2.00.1708271511430.17596@tp.orcam.me.uk> <20170902102830.GA2602@localhost.localdomain>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.233]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59970
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@imgtec.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Hi Fredrik,

> >  If you don't have documentation, but you have the hardware at hand, then 
> > you'll best check it yourself by writing a small user program that writes 
> > to CP1.FCSR and checks which bits stick (of course you need to leave the 
> > exception cause/mask bits alone for this check or you'll get SIGFPE sent 
> > instead).
> 
> Did you have something like this in mind? It prints 01000001 so the bits
> above FS does not seem to stick.
> 
> 	uint32_t fcr31;
> 	asm volatile (" cfc1 $t0,$31\n"
> 		      " lui  $t1,0xfe00\n"
> 		      " or   $t0,$t1,$t0\n"
> 	              " ctc1 $t0,$31\n"
> 	              " nop\n"
> 	              " cfc1 $t0,$31\n"
> 	              " nop\n"
> 	              " move %0,$t0\n" : "=r" (fcr31));

 NB you're missing clobbers for $t0 and $t1 here, which may cause odd 
results (since you've named these registers explicitly rather than letting 
GCC choose them via constraints).

> 	printf("fcr31 %08" PRIx32 "\n", fcr31);

 Yes, this is roughly what I had in mind, although you could have used an 
upper mask of 0xfffc to double-check the other bits.  Thanks for doing 
this check.

 I find it odd to see the FS bit set though, it shouldn't be as neither 
the kernel nor glibc startup sets it -- is it hardwired by any chance?  
If so, then it has to be reflected both in `->fpu_msk31' and in 
`->fpu_csr31', in particular for the `nofpu' mode to closely follow 
hardware (but also for some obscure corner cases where CTC1 is emulated 
even in the regular FPU operation mode).

 Can you please try flipping the bits instead then, e.g.:

	uint32_t fcsr0, fcsr1;
	asm volatile (" cfc1 %0,$31\n"
		      " lui  %1,0xfffc\n"
		      " xor  %1,%0\n"
	              " ctc1 %1,$31\n"
	              " nop\n"
	              " cfc1 %1,$31\n"
	              " ctc1 %0,$31\n"
		      : "=r" (fcsr0), "=r" (fcsr1));
	printf("FCSR old: %08" PRIx32 ", new: %08" PRIx32 "\n", fcsr0, fcsr1);

[NB there are no pipeline hazards in accessing the FCRs according to 
Section 10.2.4 "Accessing the FP Control and Implementation/Revision 
Registers" of the TX79 manual, however I've left the NOP in place as it 
won't hurt and may be needed by other hardware.]

You then effectively need to set:

	->fpu_csr31 = (old & new) & 0xfffc0000;
	->fpu_msk31 = (old ^ ~new) & 0xfffc0000;

however see examples throughout arch/mips/kernel/cpu-probe.c for how to 
use macros rather than magic numbers to express bits on the RHS.  We avoid 
run-time probing for FCSR bits to avoid unpredictable behaviour some 
hardware can show.

> The "TX System RISC TX79 Core Architecture" manual says that both data and
> instruction caches are 32 kB, but other sources seem to contradict this with
> 8 kB for data and 16 kB for instructions. So R5900 and C790 seem to be very
> similar but not identical which could bring various surprises. Here is
> another source:
> 
> https://www.linux-mips.org/wiki/PS2

 Cache sizes may well have been an RTL option and the base architecture 
the same.  Of course it would help if we had accurate documentation, but 
as often we need to live with whatever we have available.

  Maciej
