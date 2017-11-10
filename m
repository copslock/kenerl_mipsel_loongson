Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 11 Nov 2017 00:34:50 +0100 (CET)
Received: from 19pmail.ess.barracuda.com ([64.235.150.245]:50272 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992309AbdKJXenV03oS convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 11 Nov 2017 00:34:43 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx3.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Fri, 10 Nov 2017 23:34:38 +0000
Received: from [10.20.78.226] (10.20.78.226) by mips01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server id 14.3.361.1; Fri, 10 Nov 2017
 15:34:37 -0800
Date:   Fri, 10 Nov 2017 23:34:26 +0000
From:   "Maciej W. Rozycki" <macro@mips.com>
To:     Fredrik Noring <noring@nocrew.org>
CC:     <linux-mips@linux-mips.org>
Subject: Re: [PATCH v2] MIPS: Add basic R5900 support
In-Reply-To: <20171029172016.GA2600@localhost.localdomain>
Message-ID: <alpine.DEB.2.00.1711102209440.10088@tp.orcam.me.uk>
References: <20170916133423.GB32582@localhost.localdomain> <alpine.DEB.2.00.1709171001160.16752@tp.orcam.me.uk> <20170918192428.GA391@localhost.localdomain> <alpine.DEB.2.00.1709182055090.16752@tp.orcam.me.uk> <20170920145440.GB9255@localhost.localdomain>
 <alpine.DEB.2.00.1709201705070.16752@tp.orcam.me.uk> <20170927172107.GB2631@localhost.localdomain> <alpine.DEB.2.00.1709272208300.16752@tp.orcam.me.uk> <20170930065654.GA7714@localhost.localdomain> <alpine.DEB.2.00.1709301305400.12020@tp.orcam.me.uk>
 <20171029172016.GA2600@localhost.localdomain>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-BESS-ID: 1510356878-298554-22254-74628-1
X-BESS-VER: 2017.14-r1710272128
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186804
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Maciej.Rozycki@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60834
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@mips.com
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

> However, it turns out that the R5900 has a grave hardware error that
> appears to rule out most if not all generic MIPS distributions:
> 
> The short loop bug under certain conditions causes loops to execute only
> once or twice. GCC 2.95 that shipped with Sony PS2 Linux had a patch with
> the following note:
> 
>     On the R5900, we must ensure that the compiler never generates
>     loops that satisfy all of the following conditions:
> 
>     - a loop consists of less than equal to six instructions
>       (including the branch delay slot).
>     - a loop contains only one conditional branch instruction at
>       the end of the loop.
>     - a loop does not contain any other branch or jump instructions.
>     - a branch delay slot of the loop is not NOP (EE 2.9 or later).
> 
>     We need to do this because of a bug in the chip.

 You'll need a `-mfix-r5900' workaround in the compiler then.  One for GAS 
for handcoded assembly might be doable as well, fixing the `reorder' mode 
only and possibly bailing out if the conditions are met in the `noreorder' 
mode.

> > originating from the IDT R4650 and the NEC Vr5500 processors.  It has 
> > nothing to do with the DSP ASE (though it may have been claimed originally 
> > to be a DSP enhancement).
> 
> The R5900 has three-operand multiply and multiply-accumulate instructions
> as part of its multimedia set. Sadly, the MULT instruction format
> 
>       SPECIAL                          MULT
>     +--------+----+----+----+-------+--------+
>     | 000000 | rs | rt | rd | 00000 | 011000 |
>     +--------+----+----+----+-------+--------+
>          6      5    5    5     5        6
> 
> is incompatible with the corresponding MIPS32 MUL format
> 
>      SPECIAL2                           MUL
>     +--------+----+----+----+-------+--------+
>     | 011100 | rs | rt | rd | 00000 | 000010 |
>     +--------+----+----+----+-------+--------+.
>          6      5    5    5     5        6

 Still R5900-specific code may use it.

> > > > Also make sure you have RDHWR instruction emulation in place for CP0
> > > > UserLocal register access.
> > > 
> > > Right. Debian's BusyBox has 857 of those. Jürgen Urban observed in the
> > > conversation with you in
> > > 
> > > https://gcc.gnu.org/ml/gcc-patches/2013-01/msg00658.html
> > > 
> > > that RDHWR has the same encoding as "sq v1,-6085(zero)" for the R5900,
> > > which luckily always gives an alignment exception so that the kernel is
> > > able to emulate RDHWR properly. I haven't verified this though.
> > 
> >  That instruction encoding (actually implemented by some MIPS32r2/MIPS64r2 
> > and newer hardware) is used under Linux for Thread Local Storage (TLS) 
> > access.  For hardware that does not have it the instruction is emulated in 
> > the Reserved Instruction (RI) exception handler, but obviously not the 
> > Address Error Store (AdES) exception.  So code to handle it as a special 
> > case with the R5900 has to be provided among the patches (and included 
> > with the initial series).
> > 
> >  Note that `rdhwr $3,$29' is the usual encoding, handled by a fastpath in 
> > arch/mips/kernel/genex.S (see `handle_ri_rdhwr'), however all `rt' 
> > encodings (covered in `simulate_rdhwr' in arch/mips/kernel/traps.c) have 
> > to be handled for completeness.  Fortunately RDHWR and SQ both use the 
> > same bits for `rt', and the `-6085(zero)' encoding of the memory reference 
> > makes no sense, so we can safely rely on the AdES exception.
> 
> This patch traps the RDHWR instruction as an unaligned SQ:
> 
> diff --git a/arch/mips/include/asm/traps.h b/arch/mips/include/asm/traps.h
> index f41cf3ee82a7..d4987e2d9695 100644
> --- a/arch/mips/include/asm/traps.h
> +++ b/arch/mips/include/asm/traps.h
> @@ -39,4 +39,6 @@ extern int register_nmi_notifier(struct notifier_block *nb);
>  	register_nmi_notifier(&fn##_nb);				\
>  })
>  
> +asmlinkage void do_ri(struct pt_regs *regs);
> +
>  #endif /* _ASM_TRAPS_H */
> diff --git a/arch/mips/kernel/unaligned.c b/arch/mips/kernel/unaligned.c
> index f806ee56e639..7303d5d5cac8 100644
> --- a/arch/mips/kernel/unaligned.c
> +++ b/arch/mips/kernel/unaligned.c
> @@ -89,6 +89,7 @@
>  #include <asm/fpu.h>
>  #include <asm/fpu_emulator.h>
>  #include <asm/inst.h>
> +#include <asm/traps.h>
>  #include <linux/uaccess.h>
>  
>  #define STR(x)	__STR(x)
> @@ -1309,6 +1310,35 @@ static void emulate_load_store_insn(struct pt_regs *regs,
>  		cu2_notifier_call_chain(CU2_SDC2_OP, regs);
>  		break;
>  #endif
> +
> +#ifdef CONFIG_CPU_R5900

 It might be preferable to use:

	if (IS_ENABLED(CONFIG_CPU_R5900))

instead.

> +	case spec3_op:

 There is already a `spec3_op' case in this `switch' statement, so you 
need to fold your code into it (have you actually successfully built this 
piece before posting?).

> +		/*
> +		 * On the R5900 the RDHWR instruction
> +		 *
> +		 *     +--------+-------+----+----+-------+--------+
> +		 *     | 011111 | 00000 | rt | rd | 00000 | 111011 |
> +		 *     +--------+-------+----+----+-------+--------+
> +		 *          6       5      5    5     5        6
> +		 *
> +		 * is interpreted as the R5900 specific SQ instruction
> +		 *
> +		 *     +--------+-------+----+---------------------+
> +		 *     | 011111 |  base | rt |        offset       |
> +		 *     +--------+-------+----+---------------------+
> +		 *          6       5      5            16
> +		 *
> +		 * with an odd offset based on $0 that always yields an
> +		 * address error exception. Hence RDHWR can be trapped
> +		 * and emulated here.
> +		 */
> +		if (insn.spec3_format.func == rdhwr_op) {

 I think `r_format' is more appropriate for RDHWR (`spec3_format' really 
matches EVA instructions only; we might invent a distinct new format for 
the BSHFL, DBSHFL and RDHWR minor opcodes, but I think this would be an 
overkill) and you need to qualify the other instruction fields, i.e. `rs' 
and `re', because of the overlap with SQ.  We only want to give the 
special exception for what looks like a real RDHWR instruction and not 
just any faulting SQ whose least significant bits of the offset happen to 
match the RDHWR minor opcode.

> +			do_ri(regs);

 Or rather `simulate_rdhwr(regs, insn.r_format.rd, insn.r_format.rt)' as 
we've already qualified it.

> +			return;
> +		}
> +		goto sigill;

 This I think should be `sigbus' as the SQ opcode is valid on the R5900.

  Maciej
