Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Jan 2006 16:36:54 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:11221 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133522AbWAaQge (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 31 Jan 2006 16:36:34 +0000
Received: from localhost (p2155-ipad27funabasi.chiba.ocn.ne.jp [220.107.193.155])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 7C6109E95; Wed,  1 Feb 2006 01:41:30 +0900 (JST)
Date:	Wed, 01 Feb 2006 01:41:09 +0900 (JST)
Message-Id: <20060201.014109.126141844.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] add some __user tags to signal functions
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
X-archive-position: 10255
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/arch/mips/kernel/signal-common.h b/arch/mips/kernel/signal-common.h
index 0f66ae5..0fbc492 100644
--- a/arch/mips/kernel/signal-common.h
+++ b/arch/mips/kernel/signal-common.h
@@ -11,7 +11,7 @@
 #include <linux/config.h>
 
 static inline int
-setup_sigcontext(struct pt_regs *regs, struct sigcontext *sc)
+setup_sigcontext(struct pt_regs *regs, struct sigcontext __user *sc)
 {
 	int err = 0;
 
@@ -82,7 +82,7 @@ out:
 }
 
 static inline int
-restore_sigcontext(struct pt_regs *regs, struct sigcontext *sc)
+restore_sigcontext(struct pt_regs *regs, struct sigcontext __user *sc)
 {
 	unsigned int used_math;
 	unsigned long treg;
@@ -157,7 +157,7 @@ restore_sigcontext(struct pt_regs *regs,
 /*
  * Determine which stack to use..
  */
-static inline void *
+static inline void __user *
 get_sigframe(struct k_sigaction *ka, struct pt_regs *regs, size_t frame_size)
 {
 	unsigned long sp;
@@ -176,7 +176,7 @@ get_sigframe(struct k_sigaction *ka, str
 	if ((ka->sa.sa_flags & SA_ONSTACK) && (sas_ss_flags (sp) == 0))
 		sp = current->sas_ss_sp + current->sas_ss_size;
 
-	return (void *)((sp - frame_size) & (ICACHE_REFILLS_WORKAROUND_WAR ? 32 : ALMASK));
+	return (void __user *)((sp - frame_size) & (ICACHE_REFILLS_WORKAROUND_WAR ? 32 : ALMASK));
 }
 
 static inline int install_sigtramp(unsigned int __user *tramp,
diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
index 7d1800f..e8e43bd 100644
--- a/arch/mips/kernel/signal.c
+++ b/arch/mips/kernel/signal.c
@@ -199,10 +199,10 @@ save_static_function(sys_sigreturn);
 __attribute_used__ noinline static void
 _sys_sigreturn(nabi_no_regargs struct pt_regs regs)
 {
-	struct sigframe *frame;
+	struct sigframe __user *frame;
 	sigset_t blocked;
 
-	frame = (struct sigframe *) regs.regs[29];
+	frame = (struct sigframe __user *) regs.regs[29];
 	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
 		goto badframe;
 	if (__copy_from_user(&blocked, &frame->sf_mask, sizeof(blocked)))
@@ -236,11 +236,11 @@ save_static_function(sys_rt_sigreturn);
 __attribute_used__ noinline static void
 _sys_rt_sigreturn(nabi_no_regargs struct pt_regs regs)
 {
-	struct rt_sigframe *frame;
+	struct rt_sigframe __user *frame;
 	sigset_t set;
 	stack_t st;
 
-	frame = (struct rt_sigframe *) regs.regs[29];
+	frame = (struct rt_sigframe __user *) regs.regs[29];
 	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
 		goto badframe;
 	if (__copy_from_user(&set, &frame->rs_uc.uc_sigmask, sizeof(set)))
@@ -259,7 +259,7 @@ _sys_rt_sigreturn(nabi_no_regargs struct
 		goto badframe;
 	/* It is more difficult to avoid calling this function than to
 	   call it and ignore errors.  */
-	do_sigaltstack(&st, NULL, regs.regs[29]);
+	do_sigaltstack((stack_t __user *)&st, NULL, regs.regs[29]);
 
 	/*
 	 * Don't let your children do this ...
@@ -279,7 +279,7 @@ badframe:
 int setup_frame(struct k_sigaction * ka, struct pt_regs *regs,
 	int signr, sigset_t *set)
 {
-	struct sigframe *frame;
+	struct sigframe __user *frame;
 	int err = 0;
 
 	frame = get_sigframe(ka, regs, sizeof(*frame));
@@ -326,7 +326,7 @@ give_sigsegv:
 int setup_rt_frame(struct k_sigaction * ka, struct pt_regs *regs,
 	int signr, sigset_t *set, siginfo_t *info)
 {
-	struct rt_sigframe *frame;
+	struct rt_sigframe __user *frame;
 	int err = 0;
 
 	frame = get_sigframe(ka, regs, sizeof(*frame));
diff --git a/arch/mips/kernel/signal32.c b/arch/mips/kernel/signal32.c
index 98b185b..7c2241e 100644
--- a/arch/mips/kernel/signal32.c
+++ b/arch/mips/kernel/signal32.c
@@ -144,7 +144,7 @@ struct ucontext32 {
 extern void __put_sigset_unknown_nsig(void);
 extern void __get_sigset_unknown_nsig(void);
 
-static inline int put_sigset(const sigset_t *kbuf, compat_sigset_t *ubuf)
+static inline int put_sigset(const sigset_t *kbuf, compat_sigset_t __user *ubuf)
 {
 	int err = 0;
 
@@ -269,7 +269,7 @@ asmlinkage int sys32_sigaction(int sig, 
 		if (!access_ok(VERIFY_READ, act, sizeof(*act)))
 			return -EFAULT;
 		err |= __get_user(handler, &act->sa_handler);
-		new_ka.sa.sa_handler = (void*)(s64)handler;
+		new_ka.sa.sa_handler = (void __user *)(s64)handler;
 		err |= __get_user(new_ka.sa.sa_flags, &act->sa_flags);
 		err |= __get_user(mask, &act->sa_mask.sig[0]);
 		if (err)
@@ -299,8 +299,8 @@ asmlinkage int sys32_sigaction(int sig, 
 
 asmlinkage int sys32_sigaltstack(nabi_no_regargs struct pt_regs regs)
 {
-	const stack32_t *uss = (const stack32_t *) regs.regs[4];
-	stack32_t *uoss = (stack32_t *) regs.regs[5];
+	const stack32_t __user *uss = (const stack32_t __user *) regs.regs[4];
+	stack32_t __user *uoss = (stack32_t __user *) regs.regs[5];
 	unsigned long usp = regs.regs[29];
 	stack_t kss, koss;
 	int ret, err = 0;
@@ -319,7 +319,8 @@ asmlinkage int sys32_sigaltstack(nabi_no
 	}
 
 	set_fs (KERNEL_DS);
-	ret = do_sigaltstack(uss ? &kss : NULL , uoss ? &koss : NULL, usp);
+	ret = do_sigaltstack(uss ? (stack_t __user *)&kss : NULL,
+			     uoss ? (stack_t __user *)&koss : NULL, usp);
 	set_fs (old_fs);
 
 	if (!ret && uoss) {
@@ -335,7 +336,7 @@ asmlinkage int sys32_sigaltstack(nabi_no
 	return ret;
 }
 
-static int restore_sigcontext32(struct pt_regs *regs, struct sigcontext32 *sc)
+static int restore_sigcontext32(struct pt_regs *regs, struct sigcontext32 __user *sc)
 {
 	u32 used_math;
 	int err = 0;
@@ -420,7 +421,7 @@ struct rt_sigframe32 {
 #endif
 };
 
-int copy_siginfo_to_user32(compat_siginfo_t *to, siginfo_t *from)
+int copy_siginfo_to_user32(compat_siginfo_t __user *to, siginfo_t *from)
 {
 	int err;
 
@@ -476,10 +477,10 @@ save_static_function(sys32_sigreturn);
 __attribute_used__ noinline static void
 _sys32_sigreturn(nabi_no_regargs struct pt_regs regs)
 {
-	struct sigframe *frame;
+	struct sigframe __user *frame;
 	sigset_t blocked;
 
-	frame = (struct sigframe *) regs.regs[29];
+	frame = (struct sigframe __user *) regs.regs[29];
 	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
 		goto badframe;
 	if (__copy_from_user(&blocked, &frame->sf_mask, sizeof(blocked)))
@@ -512,13 +513,13 @@ save_static_function(sys32_rt_sigreturn)
 __attribute_used__ noinline static void
 _sys32_rt_sigreturn(nabi_no_regargs struct pt_regs regs)
 {
-	struct rt_sigframe32 *frame;
+	struct rt_sigframe32 __user *frame;
 	mm_segment_t old_fs;
 	sigset_t set;
 	stack_t st;
 	s32 sp;
 
-	frame = (struct rt_sigframe32 *) regs.regs[29];
+	frame = (struct rt_sigframe32 __user *) regs.regs[29];
 	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
 		goto badframe;
 	if (__copy_from_user(&set, &frame->rs_uc.uc_sigmask, sizeof(set)))
@@ -546,7 +547,7 @@ _sys32_rt_sigreturn(nabi_no_regargs stru
 	   call it and ignore errors.  */
 	old_fs = get_fs();
 	set_fs (KERNEL_DS);
-	do_sigaltstack(&st, NULL, regs.regs[29]);
+	do_sigaltstack((stack_t __user *)&st, NULL, regs.regs[29]);
 	set_fs (old_fs);
 
 	/*
@@ -564,7 +565,7 @@ badframe:
 }
 
 static inline int setup_sigcontext32(struct pt_regs *regs,
-				     struct sigcontext32 *sc)
+				     struct sigcontext32 __user *sc)
 {
 	int err = 0;
 
@@ -623,8 +624,9 @@ out:
 /*
  * Determine which stack to use..
  */
-static inline void *get_sigframe(struct k_sigaction *ka, struct pt_regs *regs,
-				 size_t frame_size)
+static inline void __user *get_sigframe(struct k_sigaction *ka,
+					struct pt_regs *regs,
+					size_t frame_size)
 {
 	unsigned long sp;
 
@@ -642,13 +644,13 @@ static inline void *get_sigframe(struct 
 	if ((ka->sa.sa_flags & SA_ONSTACK) && (sas_ss_flags (sp) == 0))
 		sp = current->sas_ss_sp + current->sas_ss_size;
 
-	return (void *)((sp - frame_size) & ALMASK);
+	return (void __user *)((sp - frame_size) & ALMASK);
 }
 
 int setup_frame_32(struct k_sigaction * ka, struct pt_regs *regs,
 	int signr, sigset_t *set)
 {
-	struct sigframe *frame;
+	struct sigframe __user *frame;
 	int err = 0;
 
 	frame = get_sigframe(ka, regs, sizeof(*frame));
@@ -702,7 +704,7 @@ give_sigsegv:
 int setup_rt_frame_32(struct k_sigaction * ka, struct pt_regs *regs,
 	int signr, sigset_t *set, siginfo_t *info)
 {
-	struct rt_sigframe32 *frame;
+	struct rt_sigframe32 __user *frame;
 	int err = 0;
 	s32 sp;
 
@@ -855,7 +857,7 @@ no_signal:
 }
 
 asmlinkage int sys32_rt_sigaction(int sig, const struct sigaction32 *act,
-				  struct sigaction32 *oact,
+				  struct sigaction32 __user *oact,
 				  unsigned int sigsetsize)
 {
 	struct k_sigaction new_sa, old_sa;
@@ -872,7 +874,7 @@ asmlinkage int sys32_rt_sigaction(int si
 		if (!access_ok(VERIFY_READ, act, sizeof(*act)))
 			return -EFAULT;
 		err |= __get_user(handler, &act->sa_handler);
-		new_sa.sa.sa_handler = (void*)(s64)handler;
+		new_sa.sa.sa_handler = (void __user *)(s64)handler;
 		err |= __get_user(new_sa.sa.sa_flags, &act->sa_flags);
 		err |= get_sigset(&new_sa.sa.sa_mask, &act->sa_mask);
 		if (err)
@@ -899,7 +901,7 @@ out:
 }
 
 asmlinkage int sys32_rt_sigprocmask(int how, compat_sigset_t *set,
-	compat_sigset_t *oset, unsigned int sigsetsize)
+	compat_sigset_t __user *oset, unsigned int sigsetsize)
 {
 	sigset_t old_set, new_set;
 	int ret;
@@ -909,8 +911,9 @@ asmlinkage int sys32_rt_sigprocmask(int 
 		return -EFAULT;
 
 	set_fs (KERNEL_DS);
-	ret = sys_rt_sigprocmask(how, set ? &new_set : NULL,
-				 oset ? &old_set : NULL, sigsetsize);
+	ret = sys_rt_sigprocmask(how, set ? (sigset_t __user *)&new_set : NULL,
+				 oset ? (sigset_t __user *)&old_set : NULL,
+				 sigsetsize);
 	set_fs (old_fs);
 
 	if (!ret && oset && put_sigset(&old_set, oset))
@@ -919,7 +922,7 @@ asmlinkage int sys32_rt_sigprocmask(int 
 	return ret;
 }
 
-asmlinkage int sys32_rt_sigpending(compat_sigset_t *uset,
+asmlinkage int sys32_rt_sigpending(compat_sigset_t __user *uset,
 	unsigned int sigsetsize)
 {
 	int ret;
@@ -927,7 +930,7 @@ asmlinkage int sys32_rt_sigpending(compa
 	mm_segment_t old_fs = get_fs();
 
 	set_fs (KERNEL_DS);
-	ret = sys_rt_sigpending(&set, sigsetsize);
+	ret = sys_rt_sigpending((sigset_t __user *)&set, sigsetsize);
 	set_fs (old_fs);
 
 	if (!ret && put_sigset(&set, uset))
@@ -936,7 +939,7 @@ asmlinkage int sys32_rt_sigpending(compa
 	return ret;
 }
 
-asmlinkage int sys32_rt_sigqueueinfo(int pid, int sig, compat_siginfo_t *uinfo)
+asmlinkage int sys32_rt_sigqueueinfo(int pid, int sig, compat_siginfo_t __user *uinfo)
 {
 	siginfo_t info;
 	int ret;
@@ -946,7 +949,7 @@ asmlinkage int sys32_rt_sigqueueinfo(int
 	    copy_from_user (info._sifields._pad, uinfo->_sifields._pad, SI_PAD_SIZE))
 		return -EFAULT;
 	set_fs (KERNEL_DS);
-	ret = sys_rt_sigqueueinfo(pid, sig, &info);
+	ret = sys_rt_sigqueueinfo(pid, sig, (siginfo_t __user *)&info);
 	set_fs (old_fs);
 	return ret;
 }
diff --git a/arch/mips/kernel/signal_n32.c b/arch/mips/kernel/signal_n32.c
index ec61b26..3d2f8e3 100644
--- a/arch/mips/kernel/signal_n32.c
+++ b/arch/mips/kernel/signal_n32.c
@@ -83,12 +83,12 @@ save_static_function(sysn32_rt_sigreturn
 __attribute_used__ noinline static void
 _sysn32_rt_sigreturn(nabi_no_regargs struct pt_regs regs)
 {
-	struct rt_sigframe_n32 *frame;
+	struct rt_sigframe_n32 __user *frame;
 	sigset_t set;
 	stack_t st;
 	s32 sp;
 
-	frame = (struct rt_sigframe_n32 *) regs.regs[29];
+	frame = (struct rt_sigframe_n32 __user *) regs.regs[29];
 	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
 		goto badframe;
 	if (__copy_from_user(&set, &frame->rs_uc.uc_sigmask, sizeof(set)))
@@ -114,7 +114,7 @@ _sysn32_rt_sigreturn(nabi_no_regargs str
 
 	/* It is more difficult to avoid calling this function than to
 	   call it and ignore errors.  */
-	do_sigaltstack(&st, NULL, regs.regs[29]);
+	do_sigaltstack((stack_t __user *)&st, NULL, regs.regs[29]);
 
 	/*
 	 * Don't let your children do this ...
@@ -133,7 +133,7 @@ badframe:
 int setup_rt_frame_n32(struct k_sigaction * ka,
 	struct pt_regs *regs, int signr, sigset_t *set, siginfo_t *info)
 {
-	struct rt_sigframe_n32 *frame;
+	struct rt_sigframe_n32 __user *frame;
 	int err = 0;
 	s32 sp;
 
