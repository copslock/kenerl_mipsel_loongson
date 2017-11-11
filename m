Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 11 Nov 2017 17:05:01 +0100 (CET)
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:10549 "EHLO
        ste-ftg-msa2.bahnhof.se" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23990590AbdKKQEzSMvJ2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 11 Nov 2017 17:04:55 +0100
Received: from localhost (localhost [127.0.0.1])
        by ste-ftg-msa2.bahnhof.se (Postfix) with ESMTP id 5783B3F785;
        Sat, 11 Nov 2017 17:04:46 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from ste-ftg-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id sFF49E2rCx4G; Sat, 11 Nov 2017 17:04:34 +0100 (CET)
Received: from localhost.localdomain (h-155-4-135-114.NA.cust.bahnhof.se [155.4.135.114])
        (Authenticated sender: mb547485)
        by ste-ftg-msa2.bahnhof.se (Postfix) with ESMTPA id B04A13F423;
        Sat, 11 Nov 2017 17:04:25 +0100 (CET)
Date:   Sat, 11 Nov 2017 17:04:23 +0100
From:   Fredrik Noring <noring@nocrew.org>
To:     "Maciej W. Rozycki" <macro@mips.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH v2] MIPS: Add basic R5900 support
Message-ID: <20171111160422.GA2332@localhost.localdomain>
References: <20170918192428.GA391@localhost.localdomain>
 <alpine.DEB.2.00.1709182055090.16752@tp.orcam.me.uk>
 <20170920145440.GB9255@localhost.localdomain>
 <alpine.DEB.2.00.1709201705070.16752@tp.orcam.me.uk>
 <20170927172107.GB2631@localhost.localdomain>
 <alpine.DEB.2.00.1709272208300.16752@tp.orcam.me.uk>
 <20170930065654.GA7714@localhost.localdomain>
 <alpine.DEB.2.00.1709301305400.12020@tp.orcam.me.uk>
 <20171029172016.GA2600@localhost.localdomain>
 <alpine.DEB.2.00.1711102209440.10088@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1711102209440.10088@tp.orcam.me.uk>
User-Agent: Mutt/1.8.3 (2017-05-23)
Return-Path: <noring@nocrew.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60836
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

Many thanks for your review, Maciej,

>  You'll need a `-mfix-r5900' workaround in the compiler then.  One for GAS 
> for handcoded assembly might be doable as well, fixing the `reorder' mode 
> only and possibly bailing out if the conditions are met in the `noreorder' 
> mode.

-march=r5900 currently handles this for C code, but the assembler does not
attempt to fix anything, as far as I understand. As shown in

https://www.linux-mips.org/archives/linux-mips/2017-10/msg00372.html

a separate commit updates

 arch/mips/include/asm/r4kcache.h |  7 +++++++
 arch/mips/lib/memset.S           | 12 ++++++++++++
 arch/mips/lib/strlen_user.S      |  6 ++++++
 arch/mips/lib/strncpy_user.S     |  4 ++++
 arch/mips/lib/strnlen_user.S     |  6 ++++++
 5 files changed, 35 insertions(+)

to avoid this bug. Taking care of this in the assembler sounds interesting.

> > +#ifdef CONFIG_CPU_R5900
> 
>  It might be preferable to use:
> 
> 	if (IS_ENABLED(CONFIG_CPU_R5900))
> 
> instead.

Yes, that makes sense once the patch set is rebased on the latest version
after v4.12 (which was the latest version when I started out; I'm hoping
to sort out all major issues before proceeding to the latest version).

> > +	case spec3_op:
> 
>  There is already a `spec3_op' case in this `switch' statement, so you 
> need to fold your code into it (have you actually successfully built this 
> piece before posting?).

Yes, it successfully builds and runs because the patch is based on v4.12
where

	% git sh v4.12:arch/mips/kernel/unaligned.c | sed -n 942,943p
	#ifdef CONFIG_EVA
		case spec3_op:

and CONFIG_EVA is disabled.

>  I think `r_format' is more appropriate for RDHWR (`spec3_format' really 
> matches EVA instructions only; we might invent a distinct new format for 
> the BSHFL, DBSHFL and RDHWR minor opcodes, but I think this would be an 
> overkill) and you need to qualify the other instruction fields, i.e. `rs' 
> and `re', because of the overlap with SQ.  We only want to give the 
> special exception for what looks like a real RDHWR instruction and not 
> just any faulting SQ whose least significant bits of the offset happen to 
> match the RDHWR minor opcode.

Sure, please find updated patch below.

> > +			do_ri(regs);
> 
>  Or rather `simulate_rdhwr(regs, insn.r_format.rd, insn.r_format.rt)' as 
> we've already qualified it.

compute_return_epc(regs) seems to be required to avoid a boundless loop.

> > +			return;
> > +		}
> > +		goto sigill;
> 
>  This I think should be `sigbus' as the SQ opcode is valid on the R5900.

Sure, please find updated patch below.

Fredrik

diff --git a/arch/mips/include/asm/traps.h b/arch/mips/include/asm/traps.h
index f41cf3ee82a7..256998085d5e 100644
--- a/arch/mips/include/asm/traps.h
+++ b/arch/mips/include/asm/traps.h
@@ -39,4 +39,6 @@ extern int register_nmi_notifier(struct notifier_block *nb);
 	register_nmi_notifier(&fn##_nb);				\
 })
 
+int simulate_rdhwr(struct pt_regs *regs, int rd, int rt);
+
 #endif /* _ASM_TRAPS_H */
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 38dfa27730ff..2341c3d4b1c3 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -623,7 +623,7 @@ static int simulate_llsc(struct pt_regs *regs, unsigned int opcode)
  * Simulate trapping 'rdhwr' instructions to provide user accessible
  * registers not implemented in hardware.
  */
-static int simulate_rdhwr(struct pt_regs *regs, int rd, int rt)
+int simulate_rdhwr(struct pt_regs *regs, int rd, int rt)
 {
 	struct thread_info *ti = task_thread_info(current);
 
diff --git a/arch/mips/kernel/unaligned.c b/arch/mips/kernel/unaligned.c
index f806ee56e639..4f645ae3fde9 100644
--- a/arch/mips/kernel/unaligned.c
+++ b/arch/mips/kernel/unaligned.c
@@ -89,6 +89,7 @@
 #include <asm/fpu.h>
 #include <asm/fpu_emulator.h>
 #include <asm/inst.h>
+#include <asm/traps.h>
 #include <linux/uaccess.h>
 
 #define STR(x)	__STR(x)
@@ -1309,6 +1310,40 @@ static void emulate_load_store_insn(struct pt_regs *regs,
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
+		if (insn.r_format.func == rdhwr_op &&
+		    insn.r_format.rs == 0 &&
+		    insn.r_format.re == 0) {
+			if (compute_return_epc(regs) < 0 ||
+			    simulate_rdhwr(regs, insn.r_format.rd,
+				           insn.r_format.rt) < 0)
+				goto sigill;
+			return;
+		}
+		goto sigbus;
+#endif
+
 	default:
 		/*
 		 * Pheeee...  We encountered an yet unknown instruction or
