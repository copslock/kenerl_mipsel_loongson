Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Sep 2017 01:55:41 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:18165 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992618AbdI2Xze6Ik0L (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 30 Sep 2017 01:55:34 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 672AD3FBAB9A8;
        Sat, 30 Sep 2017 00:55:23 +0100 (IST)
Received: from [10.20.78.110] (10.20.78.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.361.1; Sat, 30 Sep 2017
 00:55:27 +0100
Date:   Sat, 30 Sep 2017 00:55:15 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Fredrik Noring <noring@nocrew.org>
CC:     <linux-mips@linux-mips.org>
Subject: Re: [PATCH v2] MIPS: Add basic R5900 support
In-Reply-To: <20170922163753.GA2415@localhost.localdomain>
Message-ID: <alpine.DEB.2.00.1709300024350.12020@tp.orcam.me.uk>
References: <20170911151737.GA2265@localhost.localdomain> <alpine.DEB.2.00.1709141423180.16752@tp.orcam.me.uk> <20170916133423.GB32582@localhost.localdomain> <alpine.DEB.2.00.1709171001160.16752@tp.orcam.me.uk> <20170920140715.GA9255@localhost.localdomain>
 <alpine.DEB.2.00.1709201604400.16752@tp.orcam.me.uk> <20170922163753.GA2415@localhost.localdomain>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.110]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60208
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

> >  This would verify whether the original contents of $17 were a properly 
> > sign-extended 32-bit value.  Although for predictable operation I would 
> > advise to use:
> > 
> > 	sll	k1, $17, 0
> > 	sw	k1, PT_R17(sp)
> > 	lw	k1, PT_R17(sp)
> > 	tne	k1, $17, 12
> > 
> > or simply:
> > 
> > 	sll	k1, $17, 0
> > 	tne	k1, $17, 12
> > 	sw	$17, PT_R17(sp)
> 
> There is a slight complication: the trap appears to be taken before the
> console is ready, hence nothing is displayed. Is there a practical way
> to postpone or recover from a trap? The issue becomes somewhat involved
> since the trap needs to save/restore registers for itself to recover,
> and so might evoke boundless recursion.

 You can use a static variable to hold a flag preventing the diagnostic 
check from failing more than once, avoiding recursion.  Just check it here 
before doing actual verification and set it at the beginning of the Trap 
exception handler in arch/mips/kernel/genex.S.

> From a practical point of view it would be great if backtraces could be
> rate limited, recoverable and possible to copy over network (I don't have
> e.g. a serial port soldered). I will look into other alternatives to try
> to capture this.

 You can halt mid-way through `show_registers' to limit output if all you 
have is the virtual terminal and you have to copy information by hand.  
Later on in bootstrap you have the netconsole available; see 
Documentation/networking/netconsole.txt for details (I have never used 
that myself though).

> > Previously you wrote that the problem is with resetting the upper 96 bits 
> > (how did you notice that BTW?) rather than bits 63:32 only, so you need a 
> > different check.
> 
> I suspect 63:32 are the critical bits of the upper 96 bits since SD/LD
> is sufficient. Summery of observations thus far: save/restore works with
> SQ/LQ and SD/LD, but not SW/LW, in a 32-bit kernel ceteris paribus.

 This does look intriguing.

> >  Well, you do need to verify your patches for such a possibility, right.  
> > I would advise double-checking exception handling indeed, including 
> > run-time generated exception handler code in particular.
> 
> The extremely early trap indicates a kernel issue, or perhaps register
> garbage during kernel initialisation, that wouldn't be an error? Is the
> run-time code related to genex.S? The R5900 patch sprinkles NOP and
> SYNC.P instructions on it, for various workarounds, but not much else
> apart from reverting db8466c581c "MIPS: IRQ Stack: Unwind IRQ stack onto
> task stack" that otherwise crashes for an unknown reason.

 You cannot assume the firmware leaves properly sign-extended 32-bit 
values in registers upon the kernel entry.  I advise truncating the 
contents of registers (with SLL by 0) at the beginning of `kernel_entry' 
in arch/mips/kernel/head.S for the purpose of avoiding spurious check 
triggers in the course of this debugging effort.

 HTH,

  Maciej
