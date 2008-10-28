Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Oct 2008 16:06:53 +0000 (GMT)
Received: from h4.dl5rb.org.uk ([81.2.74.4]:46499 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S22593882AbYJ1QGs (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 28 Oct 2008 16:06:48 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m9SG6dUj000444;
	Tue, 28 Oct 2008 16:06:39 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m9SG6c6X000442;
	Tue, 28 Oct 2008 16:06:38 GMT
Date:	Tue, 28 Oct 2008 16:06:38 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-mips@linux-mips.org,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>,
	Paul Gortmaker <Paul.Gortmaker@windriver.com>
Subject: Re: [PATCH 29/36] Cavium OCTEON FPU EMU exception as TLB exception
Message-ID: <20081028160638.GA11152@linux-mips.org>
References: <1225152181-3221-20-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-21-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-22-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-23-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-24-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-25-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-26-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-27-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-28-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-29-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1225152181-3221-29-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21059
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Oct 27, 2008 at 05:03:01PM -0700, David Daney wrote:

> The FPU exceptions come in as TLB exceptions -- see if this is
> one of them, and act accordingly.

> +#ifdef CONFIG_CAVIUM_OCTEON_HW_FIX_UNALIGNED
> +	/*
> +	 * Normally the FPU emulator uses a load word from address one
> +	 * to retake control of the CPU after executing the
> +	 * instruction in the delay slot of an emulated branch. The
> +	 * Octeon hardware unaligned access fix changes this from an
> +	 * address exception into a TLB exception. This code checks to
> +	 * see if this page fault was caused by an FPU emulation.
> +	 *
> +	 * Terminate if exception was recognized as a delay slot return.
> +	 */
> +	if (do_dsemulret(regs))
> +		return;
> +#endif

There is absolutely no need to use any particular type of exception for
this; the choice of the address error exception back in history was totally
arbitrary - and arguably ugly.  There was even the hook to use the CU
exception instead but I think this is more what the break instruction was
intended for, so I propose to use a break instruction and allocate a new
break code for this.  See below patch.  Untested.  It may compile.  It
may even work ;-)

  Ralf

PS: You may have noticed a pattern - I hunt down most #ifdefs to generic
code you submit.  Evil stuff :-)

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

 arch/mips/include/asm/break.h        |    1 +
 arch/mips/include/asm/fpu_emulator.h |   16 ++++++++++++++++
 arch/mips/kernel/traps.c             |   16 ++++++++++++++++
 arch/mips/kernel/unaligned.c         |   12 ------------
 arch/mips/math-emu/cp1emu.c          |    4 ----
 arch/mips/math-emu/dsemul.c          |    7 +++----
 arch/mips/math-emu/dsemul.h          |   17 -----------------
 7 files changed, 36 insertions(+), 37 deletions(-)

diff --git a/arch/mips/include/asm/break.h b/arch/mips/include/asm/break.h
index 25b980c..44437ed 100644
--- a/arch/mips/include/asm/break.h
+++ b/arch/mips/include/asm/break.h
@@ -29,6 +29,7 @@
 #define _BRK_THREADBP	11	/* For threads, user bp (used by debuggers) */
 #define BRK_BUG		512	/* Used by BUG() */
 #define BRK_KDB		513	/* Used in KDB_ENTER() */
+#define BRK_MEMU	514	/* Used by FPU emulator */
 #define BRK_MULOVF	1023	/* Multiply overflow */
 
 #endif /* __ASM_BREAK_H */
diff --git a/arch/mips/include/asm/fpu_emulator.h b/arch/mips/include/asm/fpu_emulator.h
index 2731c38..a66f25e 100644
--- a/arch/mips/include/asm/fpu_emulator.h
+++ b/arch/mips/include/asm/fpu_emulator.h
@@ -23,6 +23,8 @@
 #ifndef _ASM_FPU_EMULATOR_H
 #define _ASM_FPU_EMULATOR_H
 
+#include <asm/inst.h>
+
 struct mips_fpu_emulator_stats {
 	unsigned int emulated;
 	unsigned int loads;
@@ -34,4 +36,18 @@ struct mips_fpu_emulator_stats {
 
 extern struct mips_fpu_emulator_stats fpuemustats;
 
+extern int mips_dsemul(struct pt_regs *regs, mips_instruction ir,
+	unsigned long cpc);
+extern int do_dsemulret(struct pt_regs *xcp);
+
+/*
+ * Instruction inserted following the badinst to further tag the sequence
+ */
+#define BD_COOKIE 0x0000bd36	/* tne $0, $0 with baggage */
+
+/*
+ * Break instruction with special math emu break code set
+ */
+#define BREAK_MATH (0x0000000d | (BRK_MEMU << 16))
+
 #endif /* _ASM_FPU_EMULATOR_H */
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 3f6de76..3530561 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -32,6 +32,7 @@
 #include <asm/cpu.h>
 #include <asm/dsp.h>
 #include <asm/fpu.h>
+#include <asm/fpu_emulator.h>
 #include <asm/mipsregs.h>
 #include <asm/mipsmtregs.h>
 #include <asm/module.h>
@@ -722,6 +723,21 @@ static void do_trap_or_bp(struct pt_regs *regs, unsigned int code,
 		die_if_kernel("Kernel bug detected", regs);
 		force_sig(SIGTRAP, current);
 		break;
+	case BRK_MEMU:
+		/*
+		 * Address errors may be deliberately induced by the FPU
+		 * emulator to retake control of the CPU after executing the
+		 * instruction in the delay slot of an emulated branch.
+		 *
+		 * Terminate if exception was recognized as a delay slot return
+		 * otherwise handle as normal.
+		 */
+		if (do_dsemulret(regs))
+			return;
+
+		die_if_kernel("Math emu break/trap", regs);
+		force_sig(SIGTRAP, current);
+		break;
 	default:
 		scnprintf(b, sizeof(b), "%s instruction in kernel code", str);
 		die_if_kernel(b, regs);
diff --git a/arch/mips/kernel/unaligned.c b/arch/mips/kernel/unaligned.c
index 2070966..bf4c4a9 100644
--- a/arch/mips/kernel/unaligned.c
+++ b/arch/mips/kernel/unaligned.c
@@ -499,22 +499,10 @@ sigill:
 
 asmlinkage void do_ade(struct pt_regs *regs)
 {
-	extern int do_dsemulret(struct pt_regs *);
 	unsigned int __user *pc;
 	mm_segment_t seg;
 
 	/*
-	 * Address errors may be deliberately induced by the FPU emulator to
-	 * retake control of the CPU after executing the instruction in the
-	 * delay slot of an emulated branch.
-	 */
-	/* Terminate if exception was recognized as a delay slot return */
-	if (do_dsemulret(regs))
-		return;
-
-	/* Otherwise handle as normal */
-
-	/*
 	 * Did we catch a fault trying to load an instruction?
 	 * Or are we running in MIPS16 mode?
 	 */
diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
index 7ec0b21..890f779 100644
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -48,7 +48,6 @@
 #include <asm/branch.h>
 
 #include "ieee754.h"
-#include "dsemul.h"
 
 /* Strap kernel emulator for full MIPS IV emulation */
 
@@ -346,9 +345,6 @@ static int cop1Emulate(struct pt_regs *xcp, struct mips_fpu_struct *ctx)
 			/* cop control register rd -> gpr[rt] */
 			u32 value;
 
-			if (ir == CP1UNDEF) {
-				return do_dsemulret(xcp);
-			}
 			if (MIPSInst_RD(ir) == FPCREG_CSR) {
 				value = ctx->fcr31;
 				value = (value & ~0x3) | mips_rm[value & 0x3];
diff --git a/arch/mips/math-emu/dsemul.c b/arch/mips/math-emu/dsemul.c
index 653e325..df7b9d9 100644
--- a/arch/mips/math-emu/dsemul.c
+++ b/arch/mips/math-emu/dsemul.c
@@ -18,7 +18,6 @@
 #include <asm/fpu_emulator.h>
 
 #include "ieee754.h"
-#include "dsemul.h"
 
 /* Strap kernel emulator for full MIPS IV emulation */
 
@@ -94,7 +93,7 @@ int mips_dsemul(struct pt_regs *regs, mips_instruction ir, unsigned long cpc)
 		return SIGBUS;
 
 	err = __put_user(ir, &fr->emul);
-	err |= __put_user((mips_instruction)BADINST, &fr->badinst);
+	err |= __put_user((mips_instruction)BREAK_MATH, &fr->badinst);
 	err |= __put_user((mips_instruction)BD_COOKIE, &fr->cookie);
 	err |= __put_user(cpc, &fr->epc);
 
@@ -130,13 +129,13 @@ int do_dsemulret(struct pt_regs *xcp)
 	/*
 	 * Do some sanity checking on the stackframe:
 	 *
-	 *  - Is the instruction pointed to by the EPC an BADINST?
+	 *  - Is the instruction pointed to by the EPC an BREAK_MATH?
 	 *  - Is the following memory word the BD_COOKIE?
 	 */
 	err = __get_user(insn, &fr->badinst);
 	err |= __get_user(cookie, &fr->cookie);
 
-	if (unlikely(err || (insn != BADINST) || (cookie != BD_COOKIE))) {
+	if (unlikely(err || (insn != BREAK_MATH) || (cookie != BD_COOKIE))) {
 		fpuemustats.errors++;
 		return 0;
 	}
diff --git a/arch/mips/math-emu/dsemul.h b/arch/mips/math-emu/dsemul.h
deleted file mode 100644
index 091f0e7..0000000
--- a/arch/mips/math-emu/dsemul.h
+++ /dev/null
@@ -1,17 +0,0 @@
-extern int mips_dsemul(struct pt_regs *regs, mips_instruction ir, unsigned long cpc);
-extern int do_dsemulret(struct pt_regs *xcp);
-
-/* Instruction which will always cause an address error */
-#define AdELOAD 0x8c000001	/* lw $0,1($0) */
-/* Instruction which will plainly cause a CP1 exception when FPU is disabled */
-#define CP1UNDEF 0x44400001    /* cfc1 $0,$0 undef  */
-
-/* Instruction inserted following the badinst to further tag the sequence */
-#define BD_COOKIE 0x0000bd36 /* tne $0,$0 with baggage */
-
-/* Setup which instruction to use for trampoline */
-#ifdef STANDALONE_EMULATOR
-#define BADINST CP1UNDEF
-#else
-#define BADINST AdELOAD
-#endif
