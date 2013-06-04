Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Jun 2013 20:22:48 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:36398 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6827528Ab3FDSWjrceiG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 Jun 2013 20:22:39 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <Steven.Hill@imgtec.com>)
        id 1UjvsN-0006IP-Vg; Tue, 04 Jun 2013 13:22:32 -0500
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <Steven.Hill@imgtec.com>, ralf@linux-mips.org,
        ddaney.cavm@gmail.com, macro@codesourcery.com
Subject: [PATCH] MIPS: micromips: Add 16-bit instruction floating point breakpoints.
Date:   Tue,  4 Jun 2013 13:22:26 -0500
Message-Id: <1370370146-19716-1-git-send-email-Steven.Hill@imgtec.com>
X-Mailer: git-send-email 1.7.9.5
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36672
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Steven.Hill@imgtec.com
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

This patch adds explicit support for 16-bit instruction breakpoints
for floating point exceptions.

Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
---
 arch/mips/include/asm/break.h        |    1 +
 arch/mips/include/asm/fpu_emulator.h |    3 +-
 arch/mips/kernel/traps.c             |   47 ++++++++++++++++-----------------
 arch/mips/math-emu/dsemul.c          |    6 ++--
 4 files changed, 29 insertions(+), 28 deletions(-)

diff --git a/arch/mips/include/asm/break.h b/arch/mips/include/asm/break.h
index 0ef1142..79fbb5d 100644
--- a/arch/mips/include/asm/break.h
+++ b/arch/mips/include/asm/break.h
@@ -19,6 +19,7 @@
  */
 #define BRK_KDB		513	/* Used in KDB_ENTER() */
 #define BRK_MEMU	514	/* Used by FPU emulator */
+#define BRK_MEMU_16	14	/* Used by FPU emulator (16-bit instructions) */
 #define BRK_KPROBE_BP	515	/* Kprobe break */
 #define BRK_KPROBE_SSTEPBP 516	/* Kprobe single step software implementation */
 #define BRK_MULOVF	1023	/* Multiply overflow */
diff --git a/arch/mips/include/asm/fpu_emulator.h b/arch/mips/include/asm/fpu_emulator.h
index 2abb587..5a4cfbf 100644
--- a/arch/mips/include/asm/fpu_emulator.h
+++ b/arch/mips/include/asm/fpu_emulator.h
@@ -69,6 +69,7 @@ int mm_isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
 /*
  * Break instruction with special math emu break code set
  */
-#define BREAK_MATH (0x0000000d | (BRK_MEMU << 16))
+#define BREAK_MATH	(0x0000000d | (BRK_MEMU << 16))
+#define BREAK_MATH_16	(0x00000007 | (BRK_MEMU_16 << 16))
 
 #endif /* _ASM_FPU_EMULATOR_H */
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index a75ae40..887ebc6 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -811,6 +811,7 @@ static void do_trap_or_bp(struct pt_regs *regs, unsigned int code,
 		force_sig(SIGTRAP, current);
 		break;
 	case BRK_MEMU:
+	case BRK_MEMU_16:
 		/*
 		 * Address errors may be deliberately induced by the FPU
 		 * emulator to retake control of the CPU after executing the
@@ -835,39 +836,37 @@ static void do_trap_or_bp(struct pt_regs *regs, unsigned int code,
 asmlinkage void do_bp(struct pt_regs *regs)
 {
 	unsigned int opcode, bcode;
-	unsigned long epc;
-	u16 instr[2];
+	unsigned long epc = exception_epc(regs);
 
 	if (get_isa16_mode(regs->cp0_epc)) {
-		/* Calculate EPC. */
-		epc = exception_epc(regs);
+		u16 instr[2];
+
+		if (__get_user(instr[0], (u16 __user *)msk_isa16_mode(epc)))
+			goto out_sigsegv;
+
 		if (cpu_has_mmips) {
-			if ((__get_user(instr[0], (u16 __user *)msk_isa16_mode(epc)) ||
-			    (__get_user(instr[1], (u16 __user *)msk_isa16_mode(epc + 2)))))
+			/* microMIPS mode */
+			if (__get_user(instr[1], (u16 __user *)msk_isa16_mode(epc + 2)))
 				goto out_sigsegv;
-		    opcode = (instr[0] << 16) | instr[1];
+			bcode = (instr[1] >> 6) & 0x3f;
 		} else {
-		    /* MIPS16e mode */
-		    if (__get_user(instr[0], (u16 __user *)msk_isa16_mode(epc)))
-				goto out_sigsegv;
-		    bcode = (instr[0] >> 6) & 0x3f;
-		    do_trap_or_bp(regs, bcode, "Break");
-		    return;
+			/* MIPS16e mode */
+			bcode = (instr[0] >> 6) & 0x3f;
 		}
 	} else {
-		if (__get_user(opcode, (unsigned int __user *) exception_epc(regs)))
+		if (__get_user(opcode, (unsigned int __user *) epc))
 			goto out_sigsegv;
-	}
 
-	/*
-	 * There is the ancient bug in the MIPS assemblers that the break
-	 * code starts left to bit 16 instead to bit 6 in the opcode.
-	 * Gas is bug-compatible, but not always, grrr...
-	 * We handle both cases with a simple heuristics.  --macro
-	 */
-	bcode = ((opcode >> 6) & ((1 << 20) - 1));
-	if (bcode >= (1 << 10))
-		bcode >>= 10;
+		/*
+		 * There is the ancient bug in the MIPS assemblers that the
+		 * break code starts left to bit 16 instead to bit 6 in the
+		 * opcode. Gas is bug-compatible, but not always, grrr...
+		 * We handle both cases with a simple heuristics.  --macro
+		 */
+		bcode = ((opcode >> 6) & ((1 << 20) - 1));
+		if (bcode >= (1 << 10))
+			bcode >>= 10;
+	}
 
 	/*
 	 * notify the kprobe handlers, if instruction is likely to
diff --git a/arch/mips/math-emu/dsemul.c b/arch/mips/math-emu/dsemul.c
index 7ea622a..2521274 100644
--- a/arch/mips/math-emu/dsemul.c
+++ b/arch/mips/math-emu/dsemul.c
@@ -96,8 +96,8 @@ int mips_dsemul(struct pt_regs *regs, mips_instruction ir, unsigned long cpc)
 	if (get_isa16_mode(regs->cp0_epc)) {
 		err = __put_user(ir >> 16, (u16 __user *)(&fr->emul));
 		err |= __put_user(ir & 0xffff, (u16 __user *)((long)(&fr->emul) + 2));
-		err |= __put_user(BREAK_MATH >> 16, (u16 __user *)(&fr->badinst));
-		err |= __put_user(BREAK_MATH & 0xffff, (u16 __user *)((long)(&fr->badinst) + 2));
+		err |= __put_user(BREAK_MATH_16 >> 16, (u16 __user *)(&fr->badinst));
+		err |= __put_user(BREAK_MATH_16 & 0xffff, (u16 __user *)((long)(&fr->badinst) + 2));
 	} else {
 		err = __put_user(ir, &fr->emul);
 		err |= __put_user((mips_instruction)BREAK_MATH, &fr->badinst);
@@ -152,7 +152,7 @@ int do_dsemulret(struct pt_regs *xcp)
 	}
 	err |= __get_user(cookie, &fr->cookie);
 
-	if (unlikely(err || (insn != BREAK_MATH) || (cookie != BD_COOKIE))) {
+	if (unlikely(err || (insn != BREAK_MATH) || (insn != BREAK_MATH_16) || (cookie != BD_COOKIE))) {
 		MIPS_FPU_EMU_INC_STATS(errors);
 		return 0;
 	}
-- 
1.7.2.5
