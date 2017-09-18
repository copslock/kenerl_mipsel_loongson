Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Sep 2017 21:24:58 +0200 (CEST)
Received: from pio-pvt-msa1.bahnhof.se ([79.136.2.40]:54827 "EHLO
        pio-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993179AbdIRTYuszUy0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 Sep 2017 21:24:50 +0200
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 2D1F33F514;
        Mon, 18 Sep 2017 21:24:44 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id PkqkN24Dy3Ia; Mon, 18 Sep 2017 21:24:41 +0200 (CEST)
Received: from localhost.localdomain (h-155-4-135-114.NA.cust.bahnhof.se [155.4.135.114])
        (Authenticated sender: mb547485)
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 6DABE3F37B;
        Mon, 18 Sep 2017 21:24:32 +0200 (CEST)
Date:   Mon, 18 Sep 2017 21:24:29 +0200
From:   Fredrik Noring <noring@nocrew.org>
To:     "Maciej W. Rozycki" <macro@imgtec.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH v2] MIPS: Add basic R5900 support
Message-ID: <20170918192428.GA391@localhost.localdomain>
References: <20170911151737.GA2265@localhost.localdomain>
 <alpine.DEB.2.00.1709141423180.16752@tp.orcam.me.uk>
 <20170916133423.GB32582@localhost.localdomain>
 <alpine.DEB.2.00.1709171001160.16752@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1709171001160.16752@tp.orcam.me.uk>
User-Agent: Mutt/1.8.3 (2017-05-23)
Return-Path: <noring@nocrew.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60065
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: noring@nocrew.org
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

Hi Maciej,

> > Unfortunately I haven't found such a switch. There is also a set of 128-bit
> > multimedia instructions to consider (GCC is perhaps unlikely to generate
> > those but assembly code is an option too).
> 
>  The usual minimal approach is to have compiler intrinsics implemented.

I sometimes make less than minimal programs, or unusual ones, or both. ;)

>  Virtually all 64-bit MIPS processors have the CP0.Status.UX bit, which 
> the Linux kernel keeps clear for o32 processes (CP0.Status.PX is currently 
> unsupported and is kept clear as well), which means that an attempt to use 
> any instruction that affects register bits beyond bit #31 will cause a 
> Reserved Instruction exception, and in turn SIGILL being sent to the 
> program.  

Would UX be bit 5 of CP0.Status? That bit is hardwired to naught according
to the TX79 manual (p. 4-16).

>  So any crash caused by the lack of handling of the upper bits is a result 
> of either a kernel bug or an issue with hardware.

R5900 does not seem to implement UX, SX, KX or PX.

>  Hmm, can you verify that no LWU instruction is present in the kernel 
> somewhere?

Sure, "mipsel-linux-objdump -d vmlinux | grep lwu" yields nil.

>  Can you add a diagnostic consistency check to the context restoration 
> code, i.e. all the macros called from RESTORE_ALL (in <asm/stackframe.h>), 
> such as a `break 12' (BRK_BUG) instruction if a register value is not 
> correctly sign-extended?  You can instead use one of the register trap 
> instructions (with the same BRK_BUG code), to avoid the need for a branch.  
> Make sure you don't clobber registers restored; you may have to use $k0 or 
> $k1 in places.  This will cause a kernel oops, which can then be examined 
> to track down a possible cause.

Given the R5900 patch I believe this can be done somewhat simpler, since
register access macros have been implemented in C (in this way the physical
registers become in some sense separated from the logical registers in the
kernel).

The transition from 128-bit registers to 64-bit registers was easy (in a
32-bit kernel) by changing the LONGD_{L,S} macros in asm.h from quadword
{L,S}Q to doubleword {L,S}D instructions, and changing pt_regs::regs[32]
from r5900_reg_t to unsigned long long. (The patch replaces LONG_* with
three variants: LONGD_*, LONGH_* and LONGI_*. It also forces LD and SD
via a ".set push/.set mips3/.set pop" combination like you outline below.)

The patch has full 64-bit registers accessible in C too, which is why I
propose to do the diagnostic consistency check in C. (Macros truncate to
32 bits everywhere in the kernel except for save/restore.)

>  GAS will prevent the use of any 64-bit instructions (which LWU is one of) 
> when the o32 ABI has been selected for assembly, however it can be 
> temporarily overridden by `.set' pseudo-ops, and also I haven't verified 
> if there isn't an issue with `-march=r5900' in GAS.

I'm using a BusyBox binary from the Debian-based Black Rhino distribution,
so I'm not entirely sure how it was compiled, and it might contain 64-bit
instructions that are not caught by the (unavailable) UX bit.

Fredrik
