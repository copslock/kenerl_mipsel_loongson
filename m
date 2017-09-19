Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Sep 2017 14:44:50 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:30672 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993921AbdISMofyKRtD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 Sep 2017 14:44:35 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 913C8BCBFEDC4;
        Tue, 19 Sep 2017 13:44:26 +0100 (IST)
Received: from [10.20.78.58] (10.20.78.58) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.361.1; Tue, 19 Sep 2017
 13:44:28 +0100
Date:   Tue, 19 Sep 2017 13:44:17 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Fredrik Noring <noring@nocrew.org>
CC:     <linux-mips@linux-mips.org>
Subject: Re: [PATCH v2] MIPS: Add basic R5900 support
In-Reply-To: <20170918192428.GA391@localhost.localdomain>
Message-ID: <alpine.DEB.2.00.1709182055090.16752@tp.orcam.me.uk>
References: <20170911151737.GA2265@localhost.localdomain> <alpine.DEB.2.00.1709141423180.16752@tp.orcam.me.uk> <20170916133423.GB32582@localhost.localdomain> <alpine.DEB.2.00.1709171001160.16752@tp.orcam.me.uk> <20170918192428.GA391@localhost.localdomain>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.58]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60073
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

> >  Virtually all 64-bit MIPS processors have the CP0.Status.UX bit, which 
> > the Linux kernel keeps clear for o32 processes (CP0.Status.PX is currently 
> > unsupported and is kept clear as well), which means that an attempt to use 
> > any instruction that affects register bits beyond bit #31 will cause a 
> > Reserved Instruction exception, and in turn SIGILL being sent to the 
> > program.  
> 
> Would UX be bit 5 of CP0.Status? That bit is hardwired to naught according
> to the TX79 manual (p. 4-16).

 Yes, bit #5.

> >  Can you add a diagnostic consistency check to the context restoration 
> > code, i.e. all the macros called from RESTORE_ALL (in <asm/stackframe.h>), 
> > such as a `break 12' (BRK_BUG) instruction if a register value is not 
> > correctly sign-extended?  You can instead use one of the register trap 
> > instructions (with the same BRK_BUG code), to avoid the need for a branch.  
> > Make sure you don't clobber registers restored; you may have to use $k0 or 
> > $k1 in places.  This will cause a kernel oops, which can then be examined 
> > to track down a possible cause.
> 
> Given the R5900 patch I believe this can be done somewhat simpler, since
> register access macros have been implemented in C (in this way the physical
> registers become in some sense separated from the logical registers in the
> kernel).
> 
> The transition from 128-bit registers to 64-bit registers was easy (in a
> 32-bit kernel) by changing the LONGD_{L,S} macros in asm.h from quadword
> {L,S}Q to doubleword {L,S}D instructions, and changing pt_regs::regs[32]
> from r5900_reg_t to unsigned long long.

 But why did you have to change anything there in the first place?  All 
that's there is generic stuff.

> (The patch replaces LONG_* with
> three variants: LONGD_*, LONGH_* and LONGI_*. It also forces LD and SD
> via a ".set push/.set mips3/.set pop" combination like you outline below.)

 I don't remember suggesting anything like that.

> The patch has full 64-bit registers accessible in C too, which is why I
> propose to do the diagnostic consistency check in C. (Macros truncate to
> 32 bits everywhere in the kernel except for save/restore.)

 You need to figure out the semantics of 128-bit registers and describe it 
in details (to be provided in the relevant commit's description), in 
particular any interaction 32-bit and 64-bit instructions have with the 
upper 64-bit half, before we can accept any change to support these 
extended registers.
  
 Barring evidence otherwise I think updating macros in <asm/asm.h> is not 
enough, because our syscalls rely on the standard MIPS psABI's calling 
convention and call-saved registers will only be saved and restored on an 
as-needed basis, in the prologue/epilogue of any kernel's C functions that 
actually use them.  And GCC will only use save and restore call-saved 
registers using regular 32-bit or 64-bit operations, according to the ABI 
the kernel has been compiled for.  So if there's a need to preserve the 
upper 64-bit halves, then it has to be done explicitly, possibly in an 
extra <asm/stackframe.h> macro.

 But all that is something for a later stage; right now I suggest that you 
figure out what's causing registers to become clobbered and fix it there.

> >  GAS will prevent the use of any 64-bit instructions (which LWU is one of) 
> > when the o32 ABI has been selected for assembly, however it can be 
> > temporarily overridden by `.set' pseudo-ops, and also I haven't verified 
> > if there isn't an issue with `-march=r5900' in GAS.
> 
> I'm using a BusyBox binary from the Debian-based Black Rhino distribution,
> so I'm not entirely sure how it was compiled, and it might contain 64-bit
> instructions that are not caught by the (unavailable) UX bit.

 Use `file' or `readelf -h' on the BusyBox binary to double-check the ABI 
it has been built for.  Although I doubt there will be issues with the 
executable, as it would crash on any of the other MIPS processors which 
implement the 32-bit mode correctly.

  Maciej
