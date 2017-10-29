Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Oct 2017 19:42:48 +0100 (CET)
Received: from ste-pvt-msa1.bahnhof.se ([213.80.101.70]:21861 "EHLO
        ste-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992176AbdJ2SmeuKX3B (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 29 Oct 2017 19:42:34 +0100
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 3DABA3F5F6;
        Sun, 29 Oct 2017 19:42:29 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id KOiA7QcgCRFU; Sun, 29 Oct 2017 19:42:21 +0100 (CET)
Received: from localhost.localdomain (h-155-4-135-114.NA.cust.bahnhof.se [155.4.135.114])
        (Authenticated sender: mb547485)
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 8BF633F585;
        Sun, 29 Oct 2017 19:42:18 +0100 (CET)
Date:   Sun, 29 Oct 2017 19:42:16 +0100
From:   Fredrik Noring <noring@nocrew.org>
To:     "Maciej W. Rozycki" <macro@imgtec.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH v2] MIPS: Add basic R5900 support
Message-ID: <20171029184216.GB2600@localhost.localdomain>
References: <20170827132309.GA32166@localhost.localdomain>
 <alpine.DEB.2.00.1708271511430.17596@tp.orcam.me.uk>
 <20170902141013.GB2602@localhost.localdomain>
 <alpine.DEB.2.00.1709091313150.4331@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1709091313150.4331@tp.orcam.me.uk>
User-Agent: Mutt/1.8.3 (2017-05-23)
Return-Path: <noring@nocrew.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60583
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

>  Please add at least a terse description of what the change actually does.

Please find below a new extended description in the first commit!

>  Ralf may yet want to chime in, but overall I think that the way to move 
> forward with your submission is to:
> 
> 1. Make the adjustments to this patch I have outlined above; dropping FPU 
>    and 64-bit support for the time being in particular.
> 
> 2. Update cache handlers to use the correct R5900-specific cache op 
>    encodings, presumably within the same patch.
> 
> 3. As Ralf has already reqested, add basic board support for the PS2 
>    platform, including essential drivers that are required to boot, e.g. 
>    serial, network; fancy stuff can be added gradually later on.
> 
> 4. Post the whole set of changes collected so far, properly split into 
>    functionally self-contained changes, i.e. ones that build and can run
>    successfully run on actual hardware, for a reasonable definition of 
>    success, e.g. patch #1 is this one, patch #2 is base board setup
>    infrastructure, patch #3 is interrupt support, patch #4 is timer 
>    support, patch #5 is the serial driver, patch #6 is the network 
>    driver, or suchlike.
> 
> We can then integrate these to have basic hardware support already working 
> and only then continue with more complicated features, especially ones 
> such as the FPU and 64-bit support which will require considerable updates 
> to generic architecture code.

Please find below a chronological log of the first 17 commits for the
initial submission. Those should cover most of the changes required for
the R5900 except memory management. I have a couple of difficulties to
sort out though. For example, the assembly version of memcpy crashes with
the R5900 (I provisionally use the Linux 2.6 version). The use of SYNC.L
is somewhat unclear to me. As are details of the CACHE changes.

Regarding item (3) on your list: I believe framebuffer and network (and
possibly USB) support are essential for most people. Those require DMA,
the Graphics Synthesizer and firmware support (plus a few other things)
in at least 10000 lines of code (not yet ready to be merged).

Any comments on the progress so far?

Fredrik

commit 2971122d3fe2647db697242f5a2ca8677625da08
Author: Fredrik Noring <noring@nocrew.org>
Date:   Sun Aug 27 12:06:13 2017 +0000

    MIPS: R5900: Initial support for the Emotion Engine in the Playstation 2
    
    The R5900 implements the 64-bit MIPS III instruction set except LL, SC,
    LLD and SCD, with additional PREFETCH and conditional move instructions
    from MIPS IV as well as three-operand multiply and multiply-accumulate
    instructions. A set of 128-bit multimedia instructions specific to the
    R5900 is also implemented. Endianness is configurable but taken to be
    little-endian. The R5900 does not implement CP0.Status.{UX,SX,KX,PX}.
    
    The COP1 FPU implements single-precision floating-point operations but
    is not entirely IEEE 754 compatible. In particular,
    
    - NaN (not a number) and plus/minus infinities are not supported;
    - exception mechanisms are not fully supported;
    - denormalized numbers are not supported;
    - rounding towards nearest and plus/minus infinities are not supported;
    - computed results usually differs in the least significant bit;
    - saturating instructions can differ more than the least significant bit.
    
    Since only rounding towards zero is supported, the two least significant
    bits of FCR31 are hardwired to 01. To support IEEE 754 in applications
    the FPU is emulated in software by the kernel.
    
    The VPU0 is a vector processor of the Emotion Engine. In macro mode, it
    functions as COP2 (coprocessor) and instructions execute simultaneously
    in the main integer pipeline I1 and the COP2 pipeline. In micro mode,
    the VPU0 functions as a stand-alone processor. The VPU1 is an additional
    vector processor that operates independently of both the R5900 and the
    VPU0. It primarily acts as a preprocessor to the Graphics Synthesizer.
    
    The scratch pad RAM (SPRAM) of the Emotion Engine is 16 KiB of very fast
    static RAM organised in 128-bit quadwords. Both the DMA controller and
    the R5900 can access the SPRAM.
    
    The R5900 has several significant hardware bugs. Perhaps the most
    important bug affecting applications is the short loop bug, which under
    certain conditions causes loops to execute only once or twice. GCC 2.95
    that shipped with Sony PS2 Linux had a patch with the following note:
    
        On the R5900, we must ensure that the compiler never generates
        loops that satisfy all of the following conditions:
    
        - a loop consists of less than equal to six instructions
          (including the branch delay slot);
        - a loop contains only one conditional branch instruction at
          the end of the loop;
        - a loop does not contain any other branch or jump instructions;
        - a branch delay slot of the loop is not NOP (EE 2.9 or later).
    
    Signed-off-by: Fredrik Noring <noring@nocrew.org>

 arch/mips/Kconfig                | 13 ++++++++++++-
 arch/mips/Makefile               |  1 +
 arch/mips/include/asm/cpu-type.h |  4 ++++
 arch/mips/include/asm/cpu.h      |  3 ++-
 arch/mips/include/asm/module.h   |  2 ++
 arch/mips/kernel/cpu-probe.c     |  8 ++++++++
 arch/mips/mm/Makefile            |  1 +
 arch/mips/mm/c-r4k.c             | 19 +++++++++++++++++++
 8 files changed, 49 insertions(+), 2 deletions(-)

commit 6c428ebe7e1a287601044b4f8605299d0a114b93
Author: Fredrik Noring <noring@nocrew.org>
Date:   Sat Oct 28 10:32:37 2017 +0000

    MIPS: R5900: Trap the RDHWR instruction as an unaligned SQ
    
    Signed-off-by: Fredrik Noring <noring@nocrew.org>

 arch/mips/include/asm/traps.h |  2 ++
 arch/mips/kernel/unaligned.c  | 30 ++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

commit 8bb6cf3f082aedaf5c2c06a5eed4de291ec649f6
Author: Fredrik Noring <noring@nocrew.org>
Date:   Sat Oct 28 11:38:03 2017 +0000

    MIPS: R5900: Sign-extend O32 system call registers
    
    The R5900 has 64-bit instructions but does not implement CP0.Status.UX
    so a 32-bit kernel cannot assume O32 registers are sign-extended.
    
    Signed-off-by: Fredrik Noring <noring@nocrew.org>

 arch/mips/kernel/scall32-o32.S | 12 ++++++++++++
 1 file changed, 12 insertions(+)

commit 494c54857165f679c14ee8f79180366d73550d07
Author: Fredrik Noring <noring@nocrew.org>
Date:   Sat Oct 28 12:35:37 2017 +0000

    MIPS: R5900: Add the SYNC.P instruction
    
    The SYNC.P instruction is a pipeline barrier. All instructions prior to
    the barrier are completed before the instructions following the barrier
    are fetched.
    
    However, the barrier operation doesn't wait for any prior instructions
    to retire, for example multiply, divide, multicycle COP1 operations or
    a pending load issued before the barrier operation.
    
    Signed-off-by: Fredrik Noring <noring@nocrew.org>

 arch/mips/include/asm/uasm.h | 1 +
 arch/mips/mm/uasm-mips.c     | 1 +
 arch/mips/mm/uasm.c          | 2 ++
 3 files changed, 4 insertions(+)

commit 096b8e8c6557ee5d8d1277727a248b0d55e369b6
Author: Fredrik Noring <noring@nocrew.org>
Date:   Sun Oct 29 15:07:40 2017 +0000

    MIPS: R5900: Reset bits 127..64 of GPRs in RESTORE_SOME
    
    Bits 127..64 are not used by the kernel but can be modified by
    applications using the R5900 specific multimedia instructions.
    Clearing them in RESTORE_SOME prevents leaking information between
    processes. This is a provisional measure until full 128-bit registers
    are saved/restored, possibly using SQ/LQ.
    
    Signed-off-by: Fredrik Noring <noring@nocrew.org>

 arch/mips/include/asm/stackframe.h | 53 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

commit 83acb945af3013a740a3bb7f75888ea38fd51dc4
Author: Fredrik Noring <noring@nocrew.org>
Date:   Sun Oct 29 15:23:30 2017 +0000

    MIPS: R5900: Reset the funnel shift amount (SA) register in RESTORE_SOME
    
    The shift amount (SA) register is a 64-bit special register storing the
    funnel shift amount. It is used by the QFSRV (quadword funnel shift
    right variable) 256-bit multimedia instruction. This is a provisional
    measure until the SA register is saved/restored properly.
    
    Signed-off-by: Fredrik Noring <noring@nocrew.org>

 arch/mips/include/asm/stackframe.h | 1 +
 1 file changed, 1 insertion(+)

commit dd12db794c4c870b84a811513984e35ba16d384f
Author: Fredrik Noring <noring@nocrew.org>
Date:   Sat Oct 28 17:07:02 2017 +0000

    MIPS: R5900: Workaround for the short loop bug
    
    The short loop bug under certain conditions causes loops to execute
    only once or twice. GCC 2.95 that shipped with Sony PS2 Linux had a
    patch with the following note:
    
        On the R5900, we must ensure that the compiler never generates
        loops that satisfy all of the following conditions:
    
        - a loop consists of less than equal to six instructions
          (including the branch delay slot).
        - a loop contains only one conditional branch instruction at
          the end of the loop.
        - a loop does not contain any other branch or jump instructions.
        - a branch delay slot of the loop is not NOP (EE 2.9 or later).
    
        We need to do this because of a bug in the chip.
    
    Signed-off-by: Fredrik Noring <noring@nocrew.org>

 arch/mips/include/asm/r4kcache.h |  7 +++++++
 arch/mips/lib/memset.S           | 12 ++++++++++++
 arch/mips/lib/strlen_user.S      |  6 ++++++
 arch/mips/lib/strncpy_user.S     |  4 ++++
 arch/mips/lib/strnlen_user.S     |  6 ++++++
 5 files changed, 35 insertions(+)

commit 2c7dd9a5741646df771fc6864e8a5388a585ba0b
Author: Fredrik Noring <noring@nocrew.org>
Date:   Sat Oct 28 13:45:55 2017 +0000

    MIPS: R5900: Add implicit SYNC.P to the UASM_i_M[FT]C0 macros
    
    The Toshiba TX79 manual mandates that all MTC0 instructions must be
    followed by a SYNC.P instruction as a barrier to guarantee COP0 register
    updates. There is one exception to this rule:
    
    An MTC0 instruction which loads the EntryHi COP0 register can be followed
    by a TLBWI or a TLBWR instruction without having an intervening SYNC.P.
    This special case is handled by a hardware interlock.
    
    Signed-off-by: Fredrik Noring <noring@nocrew.org>

 arch/mips/include/asm/uasm.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

commit b0d8587b4338001510173ce6a660d6837589b14e
Author: Fredrik Noring <noring@nocrew.org>
Date:   Sat Oct 28 17:29:21 2017 +0000

    MIPS: R5900: Add mandatory SYNC.P to all M[FT]C0 instructions
    
    The Toshiba TX79 manual mandates that all MTC0 instructions must be
    followed by a SYNC.P instruction as a barrier to guarantee COP0 register
    updates. There is one exception to this rule:
    
    An MTC0 instruction which loads the EntryHi COP0 register can be followed
    by a TLBWI or a TLBWR instruction without having an intervening SYNC.P.
    This special case is handled by a hardware interlock.
    
    Signed-off-by: Fredrik Noring <noring@nocrew.org>

 arch/mips/include/asm/asmmacro.h   | 12 +++++++
 arch/mips/include/asm/irqflags.h   | 15 +++++++++
 arch/mips/include/asm/mipsregs.h   | 69 ++++++++++++++++++++++++++++++++++++++
 arch/mips/include/asm/stackframe.h | 54 +++++++++++++++++++++++++++++
 arch/mips/kernel/genex.S           | 60 +++++++++++++++++++++++++++++++++
 arch/mips/kernel/head.S            |  9 +++++
 arch/mips/kernel/r4k_switch.S      | 21 ++++++++++++
 arch/mips/mm/cex-gen.S             |  6 ++++
 arch/mips/mm/tlbex-fault.S         |  3 ++
 arch/mips/mm/tlbex.c               | 11 +++---
 10 files changed, 256 insertions(+), 4 deletions(-)

commit b07f10ebc26eb746c22fafa46271c6297fc7929b
Author: Fredrik Noring <noring@nocrew.org>
Date:   Sat Oct 28 18:06:28 2017 +0000

    MIPS: R5900: Workaround exception NOP execution bug (FLX05)
    
    For the R5900, there are cases in which the first two instructions
    in an exception handler are executed as NOP instructions, when
    certain exceptions occur and then a bus error occurs immediately
    before jumping to the exception handler (FLX05).
    
    The corrective measure is to place NOP in the first two instruction
    locations in all exception handlers.
    
    Signed-off-by: Fredrik Noring <noring@nocrew.org>

 arch/mips/kernel/genex.S       | 42 ++++++++++++++++++++++++++++++++++++++++++
 arch/mips/kernel/scall32-o32.S | 12 ++++++++++++
 2 files changed, 54 insertions(+)

commit e2362f3890a4e64dd64e018fc9368f286d08b3b5
Author: Fredrik Noring <noring@nocrew.org>
Date:   Sun Oct 29 08:30:48 2017 +0000

    MIPS: R5900: Add CACHE instruction operation field encodings
    
    Signed-off-by: Fredrik Noring <noring@nocrew.org>

 arch/mips/include/asm/cacheops.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

commit 0b38596bf90f7968e3ebe21da061832db8980cb7
Author: Fredrik Noring <noring@nocrew.org>
Date:   Sun Oct 29 09:25:50 2017 +0000

    MIPS: R5900: Workaround where MSB must be 0 for the instruction cache
    
    Signed-off-by: Fredrik Noring <noring@nocrew.org>

 arch/mips/include/asm/r4kcache.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

commit 4170865d4d04d96ebd10cdd226c06c5d10820533
Author: Fredrik Noring <noring@nocrew.org>
Date:   Sun Oct 29 08:43:18 2017 +0000

    MIPS: R5900: Use SYNC.L for data cache and SYNC.P for instruction cache
    
    Toshiba TX79 manual programming notes:
    
        For all CACHE sub-operations which operate on the instruction cache
        the following programming restrictions have to be followed:
    
        1. A sequence of CACHE instructions has to be directly preceded and
           followed by a SYNC.P instruction.
        2. Each individual FILL sub-operation has to be followed by a SYNC.L
           instruction.
    
        For all CACHE sub-operations which operate on the data cache the
        following programming restrictions have to be followed:
    
        1. A sequence of CACHE instructions have to be directly preceded and
           followed by a SYNC.L instruction.
        2. Each of the three WRITEBACK sub-operations have to be
           individually followed by a SYNC.L instruction.
    
        For all CACHE sub-operations which operate on the BTAC the following
        programming restrictions have to be followed:
    
        1. A sequence of CACHE instructions have to be directly preceded and
           followed by a SYNC.P instruction.
    
    Signed-off-by: Fredrik Noring <noring@nocrew.org>

 arch/mips/include/asm/r4kcache.h | 239 ++++++++++++++++++++++++++++++---------
 arch/mips/mm/c-r4k.c             |   8 +-
 2 files changed, 189 insertions(+), 58 deletions(-)

commit 62acf546c937e68071c6dc97202b7404c9766854
Author: Fredrik Noring <noring@nocrew.org>
Date:   Sun Oct 29 15:57:26 2017 +0000

    MIPS: R5900: Use mandatory SYNC.L in exception handlers (FIXME: Why?)
    
    Signed-off-by: Fredrik Noring <noring@nocrew.org>

 arch/mips/include/asm/ftrace.h  |  52 ++++++++++
 arch/mips/include/asm/uaccess.h | 216 ++++++++++++++++++++++++++++++++++++++++
 arch/mips/kernel/unaligned.c    |  32 ++++++
 arch/mips/lib/csum_partial.S    |   3 +
 arch/mips/lib/memset.S          |  19 ++++
 arch/mips/lib/strlen_user.S     |   2 +
 arch/mips/lib/strncpy_user.S    |   2 +
 arch/mips/lib/strnlen_user.S    |   2 +
 8 files changed, 328 insertions(+)

commit 6cdfcde1a1a939b0114988a31eb8210505fdb042
Author: Fredrik Noring <noring@nocrew.org>
Date:   Sun Oct 29 10:13:33 2017 +0000

    MIPS: R5900: Add COP0 config register fields
    
    Signed-off-by: Fredrik Noring <noring@nocrew.org>

 arch/mips/include/asm/mipsregs.h | 8 ++++++++
 1 file changed, 8 insertions(+)

commit 412a6f4f67e395d3f048278692a8b083d1b27f03
Author: Fredrik Noring <noring@nocrew.org>
Date:   Sun Oct 29 14:20:24 2017 +0000

    MIPS: R5900: Workaround for CACHE instruction near branch delay slot
    
    Signed-off-by: Fredrik Noring <noring@nocrew.org>

 arch/mips/kernel/genex.S | 16 ++++++++++++++++
 arch/mips/kernel/traps.c | 24 ++++++++++++++++++++++++
 arch/mips/mm/tlbex.c     | 18 ++++++++++++++++++
 3 files changed, 58 insertions(+)

commit d44ba94c588f991c4ade2ac73fa8334e2e80f311
Author: Fredrik Noring <noring@nocrew.org>
Date:   Sat Oct 28 14:07:39 2017 +0000

    MIPS: R5900: Support 64-bit inq and outq macros in 32-bit kernels
    
    Playstation 2 hardware such as the Graphics Synthesizer requires 64-bit
    register reads and writes.
    
    Signed-off-by: Fredrik Noring <noring@nocrew.org>

 arch/mips/include/asm/io.h | 49 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 43 insertions(+), 6 deletions(-)
