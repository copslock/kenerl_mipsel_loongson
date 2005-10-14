Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Oct 2005 03:22:23 +0100 (BST)
Received: from topsns.toshiba-tops.co.jp ([202.230.225.5]:48137 "HELO
	topsns.toshiba-tops.co.jp") by ftp.linux-mips.org with SMTP
	id S3465614AbVJNCWF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 14 Oct 2005 03:22:05 +0100
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 14 Oct 2005 02:22:35 UT
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id E2E0F1FE9C;
	Fri, 14 Oct 2005 11:22:31 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id CF6591FE9A;
	Fri, 14 Oct 2005 11:22:31 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id j9E2MUA9019109;
	Fri, 14 Oct 2005 11:22:31 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Fri, 14 Oct 2005 11:22:30 +0900 (JST)
Message-Id: <20051014.112230.59032886.nemoto@toshiba-tops.co.jp>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] fix possible sleeping in atomic on setup/restore
 sigcontext
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20051013140415.GC2654@linux-mips.org>
References: <20051007.235152.75184664.anemo@mba.ocn.ne.jp>
	<20051013140415.GC2654@linux-mips.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9223
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Thu, 13 Oct 2005 15:04:15 +0100, Ralf Baechle <ralf@linux-mips.org> said:
ralf> I think much of the 87d54649f67d8ffe0a8d8176de8c210a6c4bb4a7
ralf> preemption patch is flawed and the problem you were trying to
ralf> fix are in part just caused by it.

Well... the patch fixed some problem because preempt_disable/enable is
actually needed for lazy fpu switch, but some of the fixes was wrong
(as I wrote at that time ;-)).

Anyway, I create an another patch by rewriting
restore_fp_context/save_fp_context.  While thread.fpu.hard and
thread.fpu.soft are completely same, things are quite simple.

Description:
The setup_sigcontect/restore_sigcontext might sleep on
put_user/get_user with preemption disabled (i.e. atomic context).
Sleeping in atomic context is not allowed.  This patch fixes this
problem rewriting restore_fp_context/save_fp_context.

fp context saving path is:
BEFORE:  (thread.fpu -> ) real FPU -> sigcontext
AFTER:  (real FPU -> ) thread.fpu -> sigcontext

 arch/mips/kernel/signal-common.h    |   56 +++++++++++++++++++++------
 arch/mips/kernel/signal32.c         |   54 ++++++++++++++++++++------
 arch/mips/kernel/traps.c            |   54 --------------------------
 arch/mips/math-emu/kernel_linkage.c |   73 ------------------------------------ include/asm-mips/fpu.h              |    9 ----
 5 files changed, 86 insertions(+), 160 deletions(-)

Then we can remove all arch/mips/kernel/*_fpu.S and some (all?) SC_
symbols from asm-offset.c file.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/arch/mips/kernel/signal-common.h b/arch/mips/kernel/signal-common.h
--- a/arch/mips/kernel/signal-common.h
+++ b/arch/mips/kernel/signal-common.h
@@ -10,6 +10,42 @@
 
 #include <linux/config.h>
 
+/*
+ * Emulator context save/restore to/from a signal context
+ * presumed to be on the user stack, and therefore accessed
+ * with appropriate macros from uaccess.h
+ */
+
+static inline int save_fp_context(struct sigcontext *sc)
+{
+	int i;
+	int err = 0;
+
+	for (i = 0; i < 32; i++) {
+		err |=
+		    __put_user(current->thread.fpu.soft.fpr[i],
+			       &sc->sc_fpregs[i]);
+	}
+	err |= __put_user(current->thread.fpu.soft.fcr31, &sc->sc_fpc_csr);
+
+	return err;
+}
+
+static inline int restore_fp_context(struct sigcontext *sc)
+{
+	int i;
+	int err = 0;
+
+	for (i = 0; i < 32; i++) {
+		err |=
+		    __get_user(current->thread.fpu.soft.fpr[i],
+			       &sc->sc_fpregs[i]);
+	}
+	err |= __get_user(current->thread.fpu.soft.fcr31, &sc->sc_fpc_csr);
+
+	return err;
+}
+
 static inline int
 setup_sigcontext(struct pt_regs *regs, struct sigcontext *sc)
 {
@@ -68,15 +104,14 @@ setup_sigcontext(struct pt_regs *regs, s
 	 * current FPU state.
 	 */
 	preempt_disable();
-
-	if (!is_fpu_owner()) {
-		own_fpu();
-		restore_fp(current);
+	if (is_fpu_owner()) {
+		/* save current context to task_struct */
+		save_fp(current);
+		/* no need to call lose_fpu here. */
 	}
-	err |= save_fp_context(sc);
-
 	preempt_enable();
 
+	err |= save_fp_context(sc);
 out:
 	return err;
 }
@@ -138,19 +173,16 @@ restore_sigcontext(struct pt_regs *regs,
 	err |= __get_user(used_math, &sc->sc_used_math);
 	conditional_used_math(used_math);
 
+	/* signal handler may have used FPU.  Give it up. */
 	preempt_disable();
+	lose_fpu();
+	preempt_enable();
 
 	if (used_math()) {
 		/* restore fpu context if we have used it before */
-		own_fpu();
 		err |= restore_fp_context(sc);
-	} else {
-		/* signal handler may have used FPU.  Give it up. */
-		lose_fpu();
 	}
 
-	preempt_enable();
-
 	return err;
 }
 
diff --git a/arch/mips/kernel/signal32.c b/arch/mips/kernel/signal32.c
--- a/arch/mips/kernel/signal32.c
+++ b/arch/mips/kernel/signal32.c
@@ -335,6 +335,40 @@ asmlinkage int sys32_sigaltstack(nabi_no
 	return ret;
 }
 
+/*
+ * This is the o32 version
+ */
+
+static inline int save_fp_context32(struct sigcontext32 *sc)
+{
+	int i;
+	int err = 0;
+
+	for (i = 0; i < 32; i+=2) {
+		err |=
+		    __put_user(current->thread.fpu.soft.fpr[i],
+			       &sc->sc_fpregs[i]);
+	}
+	err |= __put_user(current->thread.fpu.soft.fcr31, &sc->sc_fpc_csr);
+
+	return err;
+}
+
+static inline int restore_fp_context32(struct sigcontext32 *sc)
+{
+	int i;
+	int err = 0;
+
+	for (i = 0; i < 32; i+=2) {
+		err |=
+		    __get_user(current->thread.fpu.soft.fpr[i],
+			       &sc->sc_fpregs[i]);
+	}
+	err |= __get_user(current->thread.fpu.soft.fcr31, &sc->sc_fpc_csr);
+
+	return err;
+}
+
 static int restore_sigcontext32(struct pt_regs *regs, struct sigcontext32 *sc)
 {
 	u32 used_math;
@@ -376,19 +410,16 @@ static int restore_sigcontext32(struct p
 	err |= __get_user(used_math, &sc->sc_used_math);
 	conditional_used_math(used_math);
 
+	/* signal handler may have used FPU.  Give it up. */
 	preempt_disable();
+	lose_fpu();
+	preempt_enable();
 
 	if (used_math()) {
 		/* restore fpu context if we have used it before */
-		own_fpu();
 		err |= restore_fp_context32(sc);
-	} else {
-		/* signal handler may have used FPU.  Give it up. */
-		lose_fpu();
 	}
 
-	preempt_enable();
-
 	return err;
 }
 
@@ -609,15 +640,14 @@ static inline int setup_sigcontext32(str
 	 * current FPU state.
 	 */
 	preempt_disable();
-
-	if (!is_fpu_owner()) {
-		own_fpu();
-		restore_fp(current);
+	if (is_fpu_owner()) {
+		/* save current context to task_struct */
+		save_fp(current);
+		/* no need to call lose_fpu here. */
 	}
-	err |= save_fp_context32(sc);
-
 	preempt_enable();
 
+	err |= save_fp_context32(sc);
 out:
 	return err;
 }
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1098,55 +1098,6 @@ void *set_vi_handler (int n, void *addr)
 }
 #endif
 
-/*
- * This is used by native signal handling
- */
-asmlinkage int (*save_fp_context)(struct sigcontext *sc);
-asmlinkage int (*restore_fp_context)(struct sigcontext *sc);
-
-extern asmlinkage int _save_fp_context(struct sigcontext *sc);
-extern asmlinkage int _restore_fp_context(struct sigcontext *sc);
-
-extern asmlinkage int fpu_emulator_save_context(struct sigcontext *sc);
-extern asmlinkage int fpu_emulator_restore_context(struct sigcontext *sc);
-
-static inline void signal_init(void)
-{
-	if (cpu_has_fpu) {
-		save_fp_context = _save_fp_context;
-		restore_fp_context = _restore_fp_context;
-	} else {
-		save_fp_context = fpu_emulator_save_context;
-		restore_fp_context = fpu_emulator_restore_context;
-	}
-}
-
-#ifdef CONFIG_MIPS32_COMPAT
-
-/*
- * This is used by 32-bit signal stuff on the 64-bit kernel
- */
-asmlinkage int (*save_fp_context32)(struct sigcontext32 *sc);
-asmlinkage int (*restore_fp_context32)(struct sigcontext32 *sc);
-
-extern asmlinkage int _save_fp_context32(struct sigcontext32 *sc);
-extern asmlinkage int _restore_fp_context32(struct sigcontext32 *sc);
-
-extern asmlinkage int fpu_emulator_save_context32(struct sigcontext32 *sc);
-extern asmlinkage int fpu_emulator_restore_context32(struct sigcontext32 *sc);
-
-static inline void signal32_init(void)
-{
-	if (cpu_has_fpu) {
-		save_fp_context32 = _save_fp_context32;
-		restore_fp_context32 = _restore_fp_context32;
-	} else {
-		save_fp_context32 = fpu_emulator_save_context32;
-		restore_fp_context32 = fpu_emulator_restore_context32;
-	}
-}
-#endif
-
 extern void cpu_cache_init(void);
 extern void tlb_init(void);
 
@@ -1350,10 +1301,5 @@ void __init trap_init(void)
 	else
 		memcpy((void *)(CAC_BASE + 0x080), &except_vec3_generic, 0x80);
 
-	signal_init();
-#ifdef CONFIG_MIPS32_COMPAT
-	signal32_init();
-#endif
-
 	flush_icache_range(ebase, ebase + 0x400);
 }
diff --git a/arch/mips/math-emu/kernel_linkage.c b/arch/mips/math-emu/kernel_linkage.c
--- a/arch/mips/math-emu/kernel_linkage.c
+++ b/arch/mips/math-emu/kernel_linkage.c
@@ -44,76 +44,3 @@ void fpu_emulator_init_fpu(void)
 		current->thread.fpu.soft.fpr[i] = SIGNALLING_NAN;
 	}
 }
-
-
-/*
- * Emulator context save/restore to/from a signal context
- * presumed to be on the user stack, and therefore accessed
- * with appropriate macros from uaccess.h
- */
-
-int fpu_emulator_save_context(struct sigcontext *sc)
-{
-	int i;
-	int err = 0;
-
-	for (i = 0; i < 32; i++) {
-		err |=
-		    __put_user(current->thread.fpu.soft.fpr[i],
-			       &sc->sc_fpregs[i]);
-	}
-	err |= __put_user(current->thread.fpu.soft.fcr31, &sc->sc_fpc_csr);
-
-	return err;
-}
-
-int fpu_emulator_restore_context(struct sigcontext *sc)
-{
-	int i;
-	int err = 0;
-
-	for (i = 0; i < 32; i++) {
-		err |=
-		    __get_user(current->thread.fpu.soft.fpr[i],
-			       &sc->sc_fpregs[i]);
-	}
-	err |= __get_user(current->thread.fpu.soft.fcr31, &sc->sc_fpc_csr);
-
-	return err;
-}
-
-#ifdef CONFIG_64BIT
-/*
- * This is the o32 version
- */
-
-int fpu_emulator_save_context32(struct sigcontext32 *sc)
-{
-	int i;
-	int err = 0;
-
-	for (i = 0; i < 32; i+=2) {
-		err |=
-		    __put_user(current->thread.fpu.soft.fpr[i],
-			       &sc->sc_fpregs[i]);
-	}
-	err |= __put_user(current->thread.fpu.soft.fcr31, &sc->sc_fpc_csr);
-
-	return err;
-}
-
-int fpu_emulator_restore_context32(struct sigcontext32 *sc)
-{
-	int i;
-	int err = 0;
-
-	for (i = 0; i < 32; i+=2) {
-		err |=
-		    __get_user(current->thread.fpu.soft.fpr[i],
-			       &sc->sc_fpregs[i]);
-	}
-	err |= __get_user(current->thread.fpu.soft.fcr31, &sc->sc_fpc_csr);
-
-	return err;
-}
-#endif
diff --git a/include/asm-mips/fpu.h b/include/asm-mips/fpu.h
--- a/include/asm-mips/fpu.h
+++ b/include/asm-mips/fpu.h
@@ -21,15 +21,6 @@
 #include <asm/processor.h>
 #include <asm/current.h>
 
-struct sigcontext;
-struct sigcontext32;
-
-extern asmlinkage int (*save_fp_context)(struct sigcontext *sc);
-extern asmlinkage int (*restore_fp_context)(struct sigcontext *sc);
-
-extern asmlinkage int (*save_fp_context32)(struct sigcontext32 *sc);
-extern asmlinkage int (*restore_fp_context32)(struct sigcontext32 *sc);
-
 extern void fpu_emulator_init_fpu(void);
 extern void _init_fpu(void);
 extern void _save_fp(struct task_struct *);
