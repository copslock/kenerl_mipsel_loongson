Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Oct 2017 18:20:52 +0100 (CET)
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:51103 "EHLO
        pio-pvt-msa3.bahnhof.se" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990754AbdJ2RUlgKjNY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 29 Oct 2017 18:20:41 +0100
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id B92EB3F70F;
        Sun, 29 Oct 2017 18:20:35 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id x1BnwvO1cqTg; Sun, 29 Oct 2017 18:20:28 +0100 (CET)
Received: from localhost.localdomain (h-155-4-135-114.NA.cust.bahnhof.se [155.4.135.114])
        (Authenticated sender: mb547485)
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id 10DD93F5DB;
        Sun, 29 Oct 2017 18:20:20 +0100 (CET)
Date:   Sun, 29 Oct 2017 18:20:17 +0100
From:   Fredrik Noring <noring@nocrew.org>
To:     "Maciej W. Rozycki" <macro@imgtec.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH v2] MIPS: Add basic R5900 support
Message-ID: <20171029172016.GA2600@localhost.localdomain>
References: <20170916133423.GB32582@localhost.localdomain>
 <alpine.DEB.2.00.1709171001160.16752@tp.orcam.me.uk>
 <20170918192428.GA391@localhost.localdomain>
 <alpine.DEB.2.00.1709182055090.16752@tp.orcam.me.uk>
 <20170920145440.GB9255@localhost.localdomain>
 <alpine.DEB.2.00.1709201705070.16752@tp.orcam.me.uk>
 <20170927172107.GB2631@localhost.localdomain>
 <alpine.DEB.2.00.1709272208300.16752@tp.orcam.me.uk>
 <20170930065654.GA7714@localhost.localdomain>
 <alpine.DEB.2.00.1709301305400.12020@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.DEB.2.00.1709301305400.12020@tp.orcam.me.uk>
User-Agent: Mutt/1.8.3 (2017-05-23)
Return-Path: <noring@nocrew.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60580
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

> > >  Getting a core dump and using it to figure out which specific instruction 
> > > caused the exception would be interesting.
> > 
> > It's 72308802 as in "mul s1,s1,s0" which I believe is the DSP enhancement
> > multiplication with register write in the MIPS32 architecture. The R5900
> > doesn't have those DSP instructions, as far as I can tell.
> 
>  Umm, has Debian switched to MIPS32 as the base architecture?  That would 
> be unfortunate, they used to support MIPS I or at worst MIPS II (ISTR 
> voices to switch to the latter).  There's still plenty of MIPS III 
> hardware around so for 32-bit support I would consider MIPS II the common 
> denominator (the sole difference between MIPS II and MIPS III is 64-bit 
> support).
> 
>  In any case you'll have to find a MIPS I or MIPS II distribution, like an 
> older version of Debian.

Jürgen Urban tried Debian 3.0, 3.1, 4.0, 5.0, 6.0 and 7.0. As far as he
remembers 3.0 and perhaps 5.0 were good. 6.0 and 7.0 required substantial
workarounds.

However, it turns out that the R5900 has a grave hardware error that
appears to rule out most if not all generic MIPS distributions:

The short loop bug under certain conditions causes loops to execute only
once or twice. GCC 2.95 that shipped with Sony PS2 Linux had a patch with
the following note:

    On the R5900, we must ensure that the compiler never generates
    loops that satisfy all of the following conditions:

    - a loop consists of less than equal to six instructions
      (including the branch delay slot).
    - a loop contains only one conditional branch instruction at
      the end of the loop.
    - a loop does not contain any other branch or jump instructions.
    - a branch delay slot of the loop is not NOP (EE 2.9 or later).

    We need to do this because of a bug in the chip.

>  The three-argument MUL is a part of the base MIPS32 architecture BTW, 
> originating from the IDT R4650 and the NEC Vr5500 processors.  It has 
> nothing to do with the DSP ASE (though it may have been claimed originally 
> to be a DSP enhancement).

The R5900 has three-operand multiply and multiply-accumulate instructions
as part of its multimedia set. Sadly, the MULT instruction format

      SPECIAL                          MULT
    +--------+----+----+----+-------+--------+
    | 000000 | rs | rt | rd | 00000 | 011000 |
    +--------+----+----+----+-------+--------+
         6      5    5    5     5        6

is incompatible with the corresponding MIPS32 MUL format

     SPECIAL2                           MUL
    +--------+----+----+----+-------+--------+
    | 011100 | rs | rt | rd | 00000 | 000010 |
    +--------+----+----+----+-------+--------+.
         6      5    5    5     5        6

> > > Also make sure you have RDHWR instruction emulation in place for CP0
> > > UserLocal register access.
> > 
> > Right. Debian's BusyBox has 857 of those. Jürgen Urban observed in the
> > conversation with you in
> > 
> > https://gcc.gnu.org/ml/gcc-patches/2013-01/msg00658.html
> > 
> > that RDHWR has the same encoding as "sq v1,-6085(zero)" for the R5900,
> > which luckily always gives an alignment exception so that the kernel is
> > able to emulate RDHWR properly. I haven't verified this though.
> 
>  That instruction encoding (actually implemented by some MIPS32r2/MIPS64r2 
> and newer hardware) is used under Linux for Thread Local Storage (TLS) 
> access.  For hardware that does not have it the instruction is emulated in 
> the Reserved Instruction (RI) exception handler, but obviously not the 
> Address Error Store (AdES) exception.  So code to handle it as a special 
> case with the R5900 has to be provided among the patches (and included 
> with the initial series).
> 
>  Note that `rdhwr $3,$29' is the usual encoding, handled by a fastpath in 
> arch/mips/kernel/genex.S (see `handle_ri_rdhwr'), however all `rt' 
> encodings (covered in `simulate_rdhwr' in arch/mips/kernel/traps.c) have 
> to be handled for completeness.  Fortunately RDHWR and SQ both use the 
> same bits for `rt', and the `-6085(zero)' encoding of the memory reference 
> makes no sense, so we can safely rely on the AdES exception.

This patch traps the RDHWR instruction as an unaligned SQ:

diff --git a/arch/mips/include/asm/traps.h b/arch/mips/include/asm/traps.h
index f41cf3ee82a7..d4987e2d9695 100644
--- a/arch/mips/include/asm/traps.h
+++ b/arch/mips/include/asm/traps.h
@@ -39,4 +39,6 @@ extern int register_nmi_notifier(struct notifier_block *nb);
 	register_nmi_notifier(&fn##_nb);				\
 })
 
+asmlinkage void do_ri(struct pt_regs *regs);
+
 #endif /* _ASM_TRAPS_H */
diff --git a/arch/mips/kernel/unaligned.c b/arch/mips/kernel/unaligned.c
index f806ee56e639..7303d5d5cac8 100644
--- a/arch/mips/kernel/unaligned.c
+++ b/arch/mips/kernel/unaligned.c
@@ -89,6 +89,7 @@
 #include <asm/fpu.h>
 #include <asm/fpu_emulator.h>
 #include <asm/inst.h>
+#include <asm/traps.h>
 #include <linux/uaccess.h>
 
 #define STR(x)	__STR(x)
@@ -1309,6 +1310,35 @@ static void emulate_load_store_insn(struct pt_regs *regs,
 		cu2_notifier_call_chain(CU2_SDC2_OP, regs);
 		break;
 #endif
+
+#ifdef CONFIG_CPU_R5900
+	case spec3_op:
+		/*
+		 * On the R5900 the RDHWR instruction
+		 *
+		 *     +--------+-------+----+----+-------+--------+
+		 *     | 011111 | 00000 | rt | rd | 00000 | 111011 |
+		 *     +--------+-------+----+----+-------+--------+
+		 *          6       5      5    5     5        6
+		 *
+		 * is interpreted as the R5900 specific SQ instruction
+		 *
+		 *     +--------+-------+----+---------------------+
+		 *     | 011111 |  base | rt |        offset       |
+		 *     +--------+-------+----+---------------------+
+		 *          6       5      5            16
+		 *
+		 * with an odd offset based on $0 that always yields an
+		 * address error exception. Hence RDHWR can be trapped
+		 * and emulated here.
+		 */
+		if (insn.spec3_format.func == rdhwr_op) {
+			do_ri(regs);
+			return;
+		}
+		goto sigill;
+#endif
+
 	default:
 		/*
 		 * Pheeee...  We encountered an yet unknown instruction or

Fredrik
