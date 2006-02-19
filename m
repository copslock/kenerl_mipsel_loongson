Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 Feb 2006 14:40:20 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:63189 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133477AbWBSOkK (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 19 Feb 2006 14:40:10 +0000
Received: from localhost (p2098-ipad212funabasi.chiba.ocn.ne.jp [58.91.166.98])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 9F4D5AF84; Sun, 19 Feb 2006 23:46:54 +0900 (JST)
Date:	Sun, 19 Feb 2006 23:46:44 +0900 (JST)
Message-Id: <20060219.234644.108739570.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] signal cleanup
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10514
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Move function prototypes to asm/signal.h to detect trivial errors and
add some __user tags to get rid of sparse warnings.  Output code
should not be changed.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 092679c..a8f435d 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -60,17 +60,9 @@ ATTRIB_NORET void cpu_idle(void)
 	}
 }
 
-extern void do_signal(struct pt_regs *regs);
-extern void do_signal32(struct pt_regs *regs);
-
 /*
  * Native o32 and N64 ABI without DSP ASE
  */
-extern int setup_frame(struct k_sigaction * ka, struct pt_regs *regs,
-        int signr, sigset_t *set);
-extern int setup_rt_frame(struct k_sigaction * ka, struct pt_regs *regs,
-        int signr, sigset_t *set, siginfo_t *info);
-
 struct mips_abi mips_abi = {
 	.do_signal	= do_signal,
 #ifdef CONFIG_TRAD_SIGNALS
@@ -83,11 +75,6 @@ struct mips_abi mips_abi = {
 /*
  * o32 compatibility on 64-bit kernels, without DSP ASE
  */
-extern int setup_frame_32(struct k_sigaction * ka, struct pt_regs *regs,
-        int signr, sigset_t *set);
-extern int setup_rt_frame_32(struct k_sigaction * ka, struct pt_regs *regs,
-        int signr, sigset_t *set, siginfo_t *info);
-
 struct mips_abi mips_abi_32 = {
 	.do_signal	= do_signal32,
 	.setup_frame	= setup_frame_32,
@@ -99,9 +86,6 @@ struct mips_abi mips_abi_32 = {
 /*
  * N32 on 64-bit kernels, without DSP ASE
  */
-extern int setup_rt_frame_n32(struct k_sigaction * ka, struct pt_regs *regs,
-        int signr, sigset_t *set, siginfo_t *info);
-
 struct mips_abi mips_abi_n32 = {
 	.do_signal	= do_signal,
 	.setup_rt_frame	= setup_rt_frame_n32
diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
index c974cc9..402efd2 100644
--- a/arch/mips/kernel/signal.c
+++ b/arch/mips/kernel/signal.c
@@ -100,8 +100,8 @@ _sys_rt_sigsuspend(nabi_no_regargs struc
 }
 
 #ifdef CONFIG_TRAD_SIGNALS
-asmlinkage int sys_sigaction(int sig, const struct sigaction *act,
-	struct sigaction *oact)
+asmlinkage int sys_sigaction(int sig, const struct sigaction __user *act,
+	struct sigaction __user *oact)
 {
 	struct k_sigaction new_ka, old_ka;
 	int ret;
@@ -331,7 +331,7 @@ int setup_rt_frame(struct k_sigaction * 
 	/* Create the ucontext.  */
 	err |= __put_user(0, &frame->rs_uc.uc_flags);
 	err |= __put_user(NULL, &frame->rs_uc.uc_link);
-	err |= __put_user((void *)current->sas_ss_sp,
+	err |= __put_user((void __user *)current->sas_ss_sp,
 	                  &frame->rs_uc.uc_stack.ss_sp);
 	err |= __put_user(sas_ss_flags(regs->regs[29]),
 	                  &frame->rs_uc.uc_stack.ss_flags);
diff --git a/arch/mips/kernel/signal32.c b/arch/mips/kernel/signal32.c
index 237cd8a..225b05e 100644
--- a/arch/mips/kernel/signal32.c
+++ b/arch/mips/kernel/signal32.c
@@ -163,7 +163,7 @@ static inline int put_sigset(const sigse
 	return err;
 }
 
-static inline int get_sigset(sigset_t *kbuf, const compat_sigset_t *ubuf)
+static inline int get_sigset(sigset_t *kbuf, const compat_sigset_t __user *ubuf)
 {
 	int err = 0;
 	unsigned long sig[4];
@@ -195,10 +195,10 @@ save_static_function(sys32_sigsuspend);
 __attribute_used__ noinline static int
 _sys32_sigsuspend(nabi_no_regargs struct pt_regs regs)
 {
-	compat_sigset_t *uset;
+	compat_sigset_t __user *uset;
 	sigset_t newset;
 
-	uset = (compat_sigset_t *) regs.regs[4];
+	uset = (compat_sigset_t __user *) regs.regs[4];
 	if (get_sigset(&newset, uset))
 		return -EFAULT;
 	sigdelsetmask(&newset, ~_BLOCKABLE);
@@ -219,7 +219,7 @@ save_static_function(sys32_rt_sigsuspend
 __attribute_used__ noinline static int
 _sys32_rt_sigsuspend(nabi_no_regargs struct pt_regs regs)
 {
-	compat_sigset_t *uset;
+	compat_sigset_t __user *uset;
 	sigset_t newset;
 	size_t sigsetsize;
 
@@ -228,7 +228,7 @@ _sys32_rt_sigsuspend(nabi_no_regargs str
 	if (sigsetsize != sizeof(compat_sigset_t))
 		return -EINVAL;
 
-	uset = (compat_sigset_t *) regs.regs[4];
+	uset = (compat_sigset_t __user *) regs.regs[4];
 	if (get_sigset(&newset, uset))
 		return -EFAULT;
 	sigdelsetmask(&newset, ~_BLOCKABLE);
@@ -245,8 +245,8 @@ _sys32_rt_sigsuspend(nabi_no_regargs str
 	return -ERESTARTNOHAND;
 }
 
-asmlinkage int sys32_sigaction(int sig, const struct sigaction32 *act,
-                               struct sigaction32 *oact)
+asmlinkage int sys32_sigaction(int sig, const struct sigaction32 __user *act,
+                               struct sigaction32 __user *oact)
 {
 	struct k_sigaction new_ka, old_ka;
 	int ret;
@@ -301,7 +301,7 @@ asmlinkage int sys32_sigaltstack(nabi_no
 		if (!access_ok(VERIFY_READ, uss, sizeof(*uss)))
 			return -EFAULT;
 		err |= __get_user(sp, &uss->ss_sp);
-		kss.ss_sp = (void *) (long) sp;
+		kss.ss_sp = (void __user *) (long) sp;
 		err |= __get_user(kss.ss_size, &uss->ss_size);
 		err |= __get_user(kss.ss_flags, &uss->ss_flags);
 		if (err)
@@ -316,7 +316,7 @@ asmlinkage int sys32_sigaltstack(nabi_no
 	if (!ret && uoss) {
 		if (!access_ok(VERIFY_WRITE, uoss, sizeof(*uoss)))
 			return -EFAULT;
-		sp = (int) (long) koss.ss_sp;
+		sp = (int) (unsigned long) koss.ss_sp;
 		err |= __put_user(sp, &uoss->ss_sp);
 		err |= __put_user(koss.ss_size, &uoss->ss_size);
 		err |= __put_user(koss.ss_flags, &uoss->ss_flags);
@@ -527,7 +527,7 @@ _sys32_rt_sigreturn(nabi_no_regargs stru
 	/* The ucontext contains a stack32_t, so we must convert!  */
 	if (__get_user(sp, &frame->rs_uc.uc_stack.ss_sp))
 		goto badframe;
-	st.ss_sp = (void *)(long) sp;
+	st.ss_sp = (void __user *)(long) sp;
 	if (__get_user(st.ss_size, &frame->rs_uc.uc_stack.ss_size))
 		goto badframe;
 	if (__get_user(st.ss_flags, &frame->rs_uc.uc_stack.ss_flags))
@@ -868,7 +868,7 @@ no_signal:
 	}
 }
 
-asmlinkage int sys32_rt_sigaction(int sig, const struct sigaction32 *act,
+asmlinkage int sys32_rt_sigaction(int sig, const struct sigaction32 __user *act,
 				  struct sigaction32 __user *oact,
 				  unsigned int sigsetsize)
 {
@@ -912,7 +912,7 @@ out:
 	return ret;
 }
 
-asmlinkage int sys32_rt_sigprocmask(int how, compat_sigset_t *set,
+asmlinkage int sys32_rt_sigprocmask(int how, compat_sigset_t __user *set,
 	compat_sigset_t __user *oset, unsigned int sigsetsize)
 {
 	sigset_t old_set, new_set;
diff --git a/arch/mips/kernel/signal_n32.c b/arch/mips/kernel/signal_n32.c
index 3e168c0..220e6de 100644
--- a/arch/mips/kernel/signal_n32.c
+++ b/arch/mips/kernel/signal_n32.c
@@ -141,7 +141,7 @@ _sysn32_rt_sigreturn(nabi_no_regargs str
 	/* The ucontext contains a stack32_t, so we must convert!  */
 	if (__get_user(sp, &frame->rs_uc.uc_stack.ss_sp))
 		goto badframe;
-	st.ss_sp = (void *)(long) sp;
+	st.ss_sp = (void __user *)(long) sp;
 	if (__get_user(st.ss_size, &frame->rs_uc.uc_stack.ss_size))
 		goto badframe;
 	if (__get_user(st.ss_flags, &frame->rs_uc.uc_stack.ss_flags))
diff --git a/include/asm-mips/signal.h b/include/asm-mips/signal.h
index 6fe903e..d8349e4 100644
--- a/include/asm-mips/signal.h
+++ b/include/asm-mips/signal.h
@@ -147,16 +147,34 @@ struct k_sigaction {
 
 /* IRIX compatible stack_t  */
 typedef struct sigaltstack {
-	void *ss_sp;
+	void __user *ss_sp;
 	size_t ss_size;
 	int ss_flags;
 } stack_t;
 
 #ifdef __KERNEL__
 #include <asm/sigcontext.h>
+#include <asm/siginfo.h>
 
 #define ptrace_signal_deliver(regs, cookie) do { } while (0)
 
+struct pt_regs;
+extern void do_signal(struct pt_regs *regs);
+extern void do_signal32(struct pt_regs *regs);
+
+extern int setup_frame(struct k_sigaction * ka, struct pt_regs *regs,
+        int signr, sigset_t *set);
+extern int setup_rt_frame(struct k_sigaction * ka, struct pt_regs *regs,
+        int signr, sigset_t *set, siginfo_t *info);
+
+extern int setup_frame_32(struct k_sigaction * ka, struct pt_regs *regs,
+        int signr, sigset_t *set);
+extern int setup_rt_frame_32(struct k_sigaction * ka, struct pt_regs *regs,
+        int signr, sigset_t *set, siginfo_t *info);
+
+extern int setup_rt_frame_n32(struct k_sigaction * ka, struct pt_regs *regs,
+        int signr, sigset_t *set, siginfo_t *info);
+
 #endif /* __KERNEL__ */
 
 #endif /* _ASM_SIGNAL_H */
