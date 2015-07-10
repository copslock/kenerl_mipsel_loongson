Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Jul 2015 17:04:30 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:38469 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010197AbbGJPEB0K5Jp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Jul 2015 17:04:01 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id C76EA96770305;
        Fri, 10 Jul 2015 16:03:51 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 10 Jul 2015 16:03:54 +0100
Received: from localhost (10.100.200.2) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Fri, 10 Jul
 2015 16:03:53 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Matthew Fortune <matthew.fortune@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        <linux-kernel@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        James Hogan <james.hogan@imgtec.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Markos Chandras <markos.chandras@imgtec.com>,
        "Ralf Baechle" <ralf@linux-mips.org>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        "Maciej W. Rozycki" <macro@codesourcery.com>
Subject: [PATCH 11/16] MIPS: save MSA extended context around signals
Date:   Fri, 10 Jul 2015 16:00:20 +0100
Message-ID: <1436540426-10021-12-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.4.4
In-Reply-To: <1436540426-10021-1-git-send-email-paul.burton@imgtec.com>
References: <1436540426-10021-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.2]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48187
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

It is desirable for signal handlers to be allowed to make use of MSA,
particularly if auto vectorisation is used when compiling a program.
The MSA context must therefore be saved & restored before & after
invoking the signal handler. Make use of the extended context structs
defined in the preceding patch to save MSA context after the sigframe
when appropriate.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/kernel/r4k_fpu.S       | 119 ++++++++++++++++++
 arch/mips/kernel/signal-common.h |   3 +
 arch/mips/kernel/signal.c        | 252 ++++++++++++++++++++++++++++++++++-----
 3 files changed, 344 insertions(+), 30 deletions(-)

diff --git a/arch/mips/kernel/r4k_fpu.S b/arch/mips/kernel/r4k_fpu.S
index aa11f43..c7fe72d 100644
--- a/arch/mips/kernel/r4k_fpu.S
+++ b/arch/mips/kernel/r4k_fpu.S
@@ -13,6 +13,7 @@
  * Copyright (C) 1999, 2001 Silicon Graphics, Inc.
  */
 #include <asm/asm.h>
+#include <asm/asmmacro.h>
 #include <asm/errno.h>
 #include <asm/fpregdef.h>
 #include <asm/mipsregs.h>
@@ -171,6 +172,124 @@ LEAF(_restore_fp_context)
 	 li	v0, 0					# success
 	END(_restore_fp_context)
 
+#ifdef CONFIG_CPU_HAS_MSA
+
+	.macro	save_msa_upper	wr, off, base
+	.set	push
+	.set	noat
+#ifdef CONFIG_64BIT
+	copy_u_d \wr, 1
+	EX sd	$1, \off(\base)
+#elif defined(CONFIG_CPU_LITTLE_ENDIAN)
+	copy_u_w \wr, 2
+	EX sw	$1, \off(\base)
+	copy_u_w \wr, 3
+	EX sw	$1, (\off+4)(\base)
+#else /* CONFIG_CPU_BIG_ENDIAN */
+	copy_u_w \wr, 2
+	EX sw	$1, (\off+4)(\base)
+	copy_u_w \wr, 3
+	EX sw	$1, \off(\base)
+#endif
+	.set	pop
+	.endm
+
+LEAF(_save_msa_all_upper)
+	save_msa_upper	0, 0x00, a0
+	save_msa_upper	1, 0x08, a0
+	save_msa_upper	2, 0x10, a0
+	save_msa_upper	3, 0x18, a0
+	save_msa_upper	4, 0x20, a0
+	save_msa_upper	5, 0x28, a0
+	save_msa_upper	6, 0x30, a0
+	save_msa_upper	7, 0x38, a0
+	save_msa_upper	8, 0x40, a0
+	save_msa_upper	9, 0x48, a0
+	save_msa_upper	10, 0x50, a0
+	save_msa_upper	11, 0x58, a0
+	save_msa_upper	12, 0x60, a0
+	save_msa_upper	13, 0x68, a0
+	save_msa_upper	14, 0x70, a0
+	save_msa_upper	15, 0x78, a0
+	save_msa_upper	16, 0x80, a0
+	save_msa_upper	17, 0x88, a0
+	save_msa_upper	18, 0x90, a0
+	save_msa_upper	19, 0x98, a0
+	save_msa_upper	20, 0xa0, a0
+	save_msa_upper	21, 0xa8, a0
+	save_msa_upper	22, 0xb0, a0
+	save_msa_upper	23, 0xb8, a0
+	save_msa_upper	24, 0xc0, a0
+	save_msa_upper	25, 0xc8, a0
+	save_msa_upper	26, 0xd0, a0
+	save_msa_upper	27, 0xd8, a0
+	save_msa_upper	28, 0xe0, a0
+	save_msa_upper	29, 0xe8, a0
+	save_msa_upper	30, 0xf0, a0
+	save_msa_upper	31, 0xf8, a0
+	jr	ra
+	 li	v0, 0
+	END(_save_msa_all_upper)
+
+	.macro	restore_msa_upper	wr, off, base
+	.set	push
+	.set	noat
+#ifdef CONFIG_64BIT
+	EX ld	$1, \off(\base)
+	insert_d \wr, 1
+#elif defined(CONFIG_CPU_LITTLE_ENDIAN)
+	EX lw	$1, \off(\base)
+	insert_w \wr, 2
+	EX lw	$1, (\off+4)(\base)
+	insert_w \wr, 3
+#else /* CONFIG_CPU_BIG_ENDIAN */
+	EX lw	$1, (\off+4)(\base)
+	insert_w \wr, 2
+	EX lw	$1, \off(\base)
+	insert_w \wr, 3
+#endif
+	.set	pop
+	.endm
+
+LEAF(_restore_msa_all_upper)
+	restore_msa_upper	0, 0x00, a0
+	restore_msa_upper	1, 0x08, a0
+	restore_msa_upper	2, 0x10, a0
+	restore_msa_upper	3, 0x18, a0
+	restore_msa_upper	4, 0x20, a0
+	restore_msa_upper	5, 0x28, a0
+	restore_msa_upper	6, 0x30, a0
+	restore_msa_upper	7, 0x38, a0
+	restore_msa_upper	8, 0x40, a0
+	restore_msa_upper	9, 0x48, a0
+	restore_msa_upper	10, 0x50, a0
+	restore_msa_upper	11, 0x58, a0
+	restore_msa_upper	12, 0x60, a0
+	restore_msa_upper	13, 0x68, a0
+	restore_msa_upper	14, 0x70, a0
+	restore_msa_upper	15, 0x78, a0
+	restore_msa_upper	16, 0x80, a0
+	restore_msa_upper	17, 0x88, a0
+	restore_msa_upper	18, 0x90, a0
+	restore_msa_upper	19, 0x98, a0
+	restore_msa_upper	20, 0xa0, a0
+	restore_msa_upper	21, 0xa8, a0
+	restore_msa_upper	22, 0xb0, a0
+	restore_msa_upper	23, 0xb8, a0
+	restore_msa_upper	24, 0xc0, a0
+	restore_msa_upper	25, 0xc8, a0
+	restore_msa_upper	26, 0xd0, a0
+	restore_msa_upper	27, 0xd8, a0
+	restore_msa_upper	28, 0xe0, a0
+	restore_msa_upper	29, 0xe8, a0
+	restore_msa_upper	30, 0xf0, a0
+	restore_msa_upper	31, 0xf8, a0
+	jr	ra
+	 li	v0, 0
+	END(_restore_msa_all_upper)
+
+#endif /* CONFIG_CPU_HAS_MSA */
+
 	.set	reorder
 
 	.type	fault@function
diff --git a/arch/mips/kernel/signal-common.h b/arch/mips/kernel/signal-common.h
index d594695..a99987f 100644
--- a/arch/mips/kernel/signal-common.h
+++ b/arch/mips/kernel/signal-common.h
@@ -42,4 +42,7 @@ _save_fp_context(void __user *fpregs, void __user *csr);
 extern asmlinkage int
 _restore_fp_context(void __user *fpregs, void __user *csr);
 
+extern asmlinkage int _save_msa_all_upper(void __user *buf);
+extern asmlinkage int _restore_msa_all_upper(void __user *buf);
+
 #endif	/* __SIGNAL_COMMON_H */
diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
index 4e626ca..98bbca6 100644
--- a/arch/mips/kernel/signal.c
+++ b/arch/mips/kernel/signal.c
@@ -38,6 +38,7 @@
 #include <asm/vdso.h>
 #include <asm/dsp.h>
 #include <asm/inst.h>
+#include <asm/msa.h>
 
 #include "signal-common.h"
 
@@ -125,6 +126,168 @@ static int restore_hw_fp_context(void __user *sc)
 }
 
 /*
+ * Extended context handling.
+ */
+
+static inline void __user *sc_to_extcontext(void __user *sc)
+{
+	struct ucontext __user *uc;
+
+	/*
+	 * We can just pretend the sigcontext is always embedded in a struct
+	 * ucontext here, because the offset from sigcontext to extended
+	 * context is the same in the struct sigframe case.
+	 */
+	uc = container_of(sc, struct ucontext, uc_mcontext);
+	return &uc->uc_extcontext;
+}
+
+static int save_msa_extcontext(void __user *buf)
+{
+	struct msa_extcontext __user *msa = buf;
+	uint64_t val;
+	int i, err;
+
+	if (!thread_msa_context_live())
+		return 0;
+
+	/*
+	 * Ensure that we can't lose the live MSA context between checking
+	 * for it & writing it to memory.
+	 */
+	preempt_disable();
+
+	if (is_msa_enabled()) {
+		/*
+		 * There are no EVA versions of the vector register load/store
+		 * instructions, so MSA context has to be saved to kernel memory
+		 * and then copied to user memory. The save to kernel memory
+		 * should already have been done when handling scalar FP
+		 * context.
+		 */
+		BUG_ON(config_enabled(CONFIG_EVA));
+
+		err = __put_user(read_msa_csr(), &msa->csr);
+		err |= _save_msa_all_upper(&msa->wr);
+
+		preempt_enable();
+	} else {
+		preempt_enable();
+
+		err = __put_user(current->thread.fpu.msacsr, &msa->csr);
+
+		for (i = 0; i < NUM_FPU_REGS; i++) {
+			val = get_fpr64(&current->thread.fpu.fpr[i], 1);
+			err |= __put_user(val, &msa->wr[i]);
+		}
+	}
+
+	err |= __put_user(MSA_EXTCONTEXT_MAGIC, &msa->ext.magic);
+	err |= __put_user(sizeof(*msa), &msa->ext.size);
+
+	return err ? -EFAULT : sizeof(*msa);
+}
+
+static int restore_msa_extcontext(void __user *buf, unsigned int size)
+{
+	struct msa_extcontext __user *msa = buf;
+	unsigned long long val;
+	unsigned int csr;
+	int i, err;
+
+	if (size != sizeof(*msa))
+		return -EINVAL;
+
+	err = get_user(csr, &msa->csr);
+	if (err)
+		return err;
+
+	preempt_disable();
+
+	if (is_msa_enabled()) {
+		/*
+		 * There are no EVA versions of the vector register load/store
+		 * instructions, so MSA context has to be copied to kernel
+		 * memory and later loaded to registers. The same is true of
+		 * scalar FP context, so FPU & MSA should have already been
+		 * disabled whilst handling scalar FP context.
+		 */
+		BUG_ON(config_enabled(CONFIG_EVA));
+
+		write_msa_csr(csr);
+		err |= _restore_msa_all_upper(&msa->wr);
+		preempt_enable();
+	} else {
+		preempt_enable();
+
+		current->thread.fpu.msacsr = csr;
+
+		for (i = 0; i < NUM_FPU_REGS; i++) {
+			err |= __get_user(val, &msa->wr[i]);
+			set_fpr64(&current->thread.fpu.fpr[i], 1, val);
+		}
+	}
+
+	return err;
+}
+
+static int save_extcontext(void __user *buf)
+{
+	int sz;
+
+	sz = save_msa_extcontext(buf);
+	if (sz < 0)
+		return sz;
+	buf += sz;
+
+	/* If no context was saved then trivially return */
+	if (!sz)
+		return 0;
+
+	/* Write the end marker */
+	if (__put_user(END_EXTCONTEXT_MAGIC, (u32 *)buf))
+		return -EFAULT;
+
+	sz += sizeof(((struct extcontext *)NULL)->magic);
+	return sz;
+}
+
+static int restore_extcontext(void __user *buf)
+{
+	struct extcontext ext;
+	int err;
+
+	while (1) {
+		err = __get_user(ext.magic, (unsigned int *)buf);
+		if (err)
+			return err;
+
+		if (ext.magic == END_EXTCONTEXT_MAGIC)
+			return 0;
+
+		err = __get_user(ext.size, (unsigned int *)(buf
+			+ offsetof(struct extcontext, size)));
+		if (err)
+			return err;
+
+		switch (ext.magic) {
+		case MSA_EXTCONTEXT_MAGIC:
+			err = restore_msa_extcontext(buf, ext.size);
+			break;
+
+		default:
+			err = -EINVAL;
+			break;
+		}
+
+		if (err)
+			return err;
+
+		buf += ext.size;
+	}
+}
+
+/*
  * Helper routines
  */
 int protected_save_fp_context(void __user *sc)
@@ -133,7 +296,7 @@ int protected_save_fp_context(void __user *sc)
 	uint64_t __user *fpregs = sc + abi->off_sc_fpregs;
 	uint32_t __user *csr = sc + abi->off_sc_fpc_csr;
 	uint32_t __user *used_math = sc + abi->off_sc_used_math;
-	unsigned int used;
+	unsigned int used, ext_sz;
 	int err;
 
 	used = used_math() ? USED_FP : 0;
@@ -142,39 +305,40 @@ int protected_save_fp_context(void __user *sc)
 			used |= USED_FR1;
 		if (test_thread_flag(TIF_HYBRID_FPREGS))
 			used |= USED_HYBRID_FPRS;
-	}
 
-	err = __put_user(used, used_math);
-	if (err || !(used & USED_FP))
-		return err;
-
-	/*
-	 * EVA does not have userland equivalents of ldc1 or sdc1, so
-	 * save to the kernel FP context & copy that to userland below.
-	 */
-	if (config_enabled(CONFIG_EVA))
-		lose_fpu(1);
-
-	while (1) {
-		lock_fpu_owner();
-		if (is_fpu_owner()) {
-			err = save_fp_context(sc);
-			unlock_fpu_owner();
-		} else {
-			unlock_fpu_owner();
-			err = copy_fp_to_sigcontext(sc);
+		/*
+		 * EVA does not have userland equivalents of ldc1 or sdc1, so
+		 * save to the kernel FP context & copy that to userland below.
+		 */
+		if (config_enabled(CONFIG_EVA))
+			lose_fpu(1);
+
+		while (1) {
+			lock_fpu_owner();
+			if (is_fpu_owner()) {
+				err = save_fp_context(sc);
+				unlock_fpu_owner();
+			} else {
+				unlock_fpu_owner();
+				err = copy_fp_to_sigcontext(sc);
+			}
+			if (likely(!err))
+				break;
+			/* touch the sigcontext and try again */
+			err = __put_user(0, &fpregs[0]) |
+				__put_user(0, &fpregs[31]) |
+				__put_user(0, csr);
+			if (err)
+				return err;	/* really bad sigcontext */
 		}
-		if (likely(!err))
-			break;
-		/* touch the sigcontext and try again */
-		err = __put_user(0, &fpregs[0]) |
-			__put_user(0, &fpregs[31]) |
-			__put_user(0, csr);
-		if (err)
-			break;	/* really bad sigcontext */
 	}
 
-	return err;
+	ext_sz = err = save_extcontext(sc_to_extcontext(sc));
+	if (err < 0)
+		return err;
+	used |= ext_sz ? USED_EXTCONTEXT : 0;
+
+	return __put_user(used, used_math);
 }
 
 int protected_restore_fp_context(void __user *sc)
@@ -229,6 +393,9 @@ int protected_restore_fp_context(void __user *sc)
 			break;	/* really bad sigcontext */
 	}
 
+	if (used & USED_EXTCONTEXT)
+		err |= restore_extcontext(sc_to_extcontext(sc));
+
 	return err ?: sig;
 }
 
@@ -268,6 +435,28 @@ int setup_sigcontext(struct pt_regs *regs, struct sigcontext __user *sc)
 	return err;
 }
 
+static size_t extcontext_max_size(void)
+{
+	size_t sz = 0;
+
+	/*
+	 * The assumption here is that between this point & the point at which
+	 * the extended context is saved the size of the context should only
+	 * ever be able to shrink (if the task is preempted), but never grow.
+	 * That is, what this function returns is an upper bound on the size of
+	 * the extended context for the current task at the current time.
+	 */
+
+	if (thread_msa_context_live())
+		sz += sizeof(struct msa_extcontext);
+
+	/* If any context is saved then we'll append the end marker */
+	if (sz)
+		sz += sizeof(((struct extcontext *)NULL)->magic);
+
+	return sz;
+}
+
 int fpcsr_pending(unsigned int __user *fpcsr)
 {
 	int err, sig = 0;
@@ -324,6 +513,9 @@ void __user *get_sigframe(struct ksignal *ksig, struct pt_regs *regs,
 {
 	unsigned long sp;
 
+	/* Leave space for potential extended context */
+	frame_size += extcontext_max_size();
+
 	/* Default to using normal stack */
 	sp = regs->regs[29];
 
-- 
2.4.4
