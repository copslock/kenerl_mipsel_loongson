Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jan 2003 10:07:13 +0000 (GMT)
Received: from eau.irisa.fr ([IPv6:::ffff:131.254.60.97]:4534 "EHLO
	eau.irisa.fr") by linux-mips.org with ESMTP id <S8226275AbTAMKHM>;
	Mon, 13 Jan 2003 10:07:12 +0000
Received: from irisa.fr (traezhenn.irisa.fr [131.254.41.15])
	by eau.irisa.fr (8.11.4/8.11.4) with ESMTP id h0DA6Zi26740;
	Mon, 13 Jan 2003 11:06:35 +0100 (MET)
Message-ID: <3E228FAB.5010004@irisa.fr>
Date: Mon, 13 Jan 2003 11:06:35 +0100
From: Vivien Chappelier <vchappel@irisa.fr>
Reply-To: Vivien Chappelier <vivienc@nerim.net>
User-Agent: Mozilla/5.0 (X11; U; SunOS sun4u; en-US; rv:1.0.1) Gecko/20020920 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ralf Baechle <ralf@oss.sgi.com>
CC: linux-mips <linux-mips@linux-mips.org>
Subject: [2.5 PATCH] signal handling
Content-Type: multipart/mixed;
 boundary="------------090906020704070304070501"
X-MailScanner: Found to be clean
Return-Path: <vchappel@irisa.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1142
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vchappel@irisa.fr
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------090906020704070304070501
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

         This patch fixes various bugs in the 2.5 signal code (native and
mips64 32bit compatibility code):
         - revert changes to ucontext.h to match the arguments of
setup_sigcontext and restore_sigcontext (which need a sigcontext struct,
not mcontext struct)
         - fix swapped arguments in the call to do_signal in
do_notify_resume
         - cleanup and fix 32 bit compatibility code for mips64, 
including making sigset_t32 and sigset_t size match.

Vivien.

--------------090906020704070304070501
Content-Type: text/plain;
 name="linux-mips-signal.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-mips-signal.diff"

--- include/asm-mips/ucontext.h	2002-10-09 23:12:56.000000000 +0200
+++ include/asm-mips/ucontext.h	2003-01-10 23:36:16.000000000 +0100
@@ -10,33 +10,12 @@
 #ifndef _ASM_UCONTEXT_H
 #define _ASM_UCONTEXT_H
 
-typedef unsigned int greg_t;
-
-#define NGREG 36
-
-typedef greg_t gregset_t[NGREG];
-
-typedef struct fpregset {
-	union {
-		double		fp_dregs[16];
-		float		fp_fregs [32];
-		unsigned int	fp_regs[32];
-	} fp_r;
-	unsigned int fp_csr;
-	unsigned int fp_pad;
-} fpregset_t;
-
-typedef struct {
-	gregset_t gregs;
-	fpregset_t fpregs;
-} mcontext_t;
-
 struct ucontext {
-	unsigned long	uc_flags;
-	struct ucontext	*uc_link;
-	stack_t		uc_stack;
-	mcontext_t	uc_mcontext;
-	sigset_t	uc_sigmask;	/* mask last for extensibility */
+	unsigned long	  uc_flags;
+	struct ucontext  *uc_link;
+	stack_t		  uc_stack;
+	struct sigcontext uc_mcontext;
+	sigset_t	  uc_sigmask;	/* mask last for extensibility */
 };
 
 #endif /* _ASM_UCONTEXT_H */
--- include/asm-mips64/ucontext.h	2002-10-09 23:12:58.000000000 +0200
+++ include/asm-mips64/ucontext.h	2003-01-10 23:35:06.000000000 +0100
@@ -10,33 +10,12 @@
 #ifndef _ASM_UCONTEXT_H
 #define _ASM_UCONTEXT_H
 
-typedef unsigned int greg_t;
-
-#define NGREG 36
-
-typedef greg_t gregset_t[NGREG];
-
-typedef struct fpregset {
-	union {
-		double		fp_dregs[32];
-		float		fp_fregs [32];
-		unsigned long	fp_regs[32];
-	} fp_r;
-	unsigned int fp_csr;
-	unsigned int fp_pad;
-} fpregset_t;
-
-typedef struct {
-	gregset_t gregs;
-	fpregset_t fpregs;
-} mcontext_t;
-
 struct ucontext {
-	unsigned long	uc_flags;
-	struct ucontext	*uc_link;
-	stack_t		uc_stack;
-	mcontext_t	uc_mcontext;
-	sigset_t	uc_sigmask;	/* mask last for extensibility */
+	unsigned long	  uc_flags;
+	struct ucontext  *uc_link;
+	stack_t		  uc_stack;
+	struct sigcontext uc_mcontext;
+	sigset_t	  uc_sigmask;	/* mask last for extensibility */
 };
 
 #endif /* _ASM_UCONTEXT_H */
--- include/asm-mips64/signal.h	2002-11-09 16:16:54.000000000 +0100
+++ include/asm-mips64/signal.h	2003-01-11 00:57:26.000000000 +0100
@@ -11,25 +11,47 @@
 
 #include <linux/types.h>
 
-#define _NSIG		64
+#define _NSIG		128
 #define _NSIG_BPW	64
 #define _NSIG_WORDS	(_NSIG / _NSIG_BPW)
 
 typedef struct {
-	long sig[_NSIG_WORDS];
+	unsigned long sig[_NSIG_WORDS];
 } sigset_t;
 
+typedef unsigned long old_sigset_t;		/* at least 32 bits */
+
+#ifdef __KERNEL__
+
 #define _NSIG32		128
 #define _NSIG_BPW32	32
 #define _NSIG_WORDS32	(_NSIG32 / _NSIG_BPW32)
 
 typedef struct {
-	long sig[_NSIG_WORDS32];
+	unsigned int sig[_NSIG_WORDS32];
 } sigset_t32;
 
-typedef unsigned long old_sigset_t;		/* at least 32 bits */
 typedef unsigned int old_sigset_t32;
 
+typedef unsigned int __sighandler_t32;
+
+struct sigaction32 {
+	unsigned int		sa_flags;
+	__sighandler_t32	sa_handler;
+	sigset_t32		sa_mask;
+	unsigned int		sa_restorer;
+	unsigned int		sa_resv[1];     /* reserved */
+};
+
+/* IRIX compatible stack_t  */
+typedef struct sigaltstack32 {
+	unsigned int ss_sp;
+	__kernel_size_t32 ss_size;
+	int ss_flags;
+} stack32_t;
+
+#endif /* __KERNEL__ */
+
 #define SIGHUP		 1	/* Hangup (POSIX).  */
 #define SIGINT		 2	/* Interrupt (ANSI).  */
 #define SIGQUIT		 3	/* Quit (POSIX).  */
--- arch/mips/kernel/signal.c	2002-11-09 16:10:08.000000000 +0100
+++ arch/mips/kernel/signal.c	2003-01-10 21:26:35.000000000 +0100
@@ -580,6 +580,6 @@
 			return;
 		}
 #endif
-		do_signal(regs,oldset);
+		do_signal(oldset, regs);
 	}
 }
--- arch/mips64/kernel/signal.c	2002-11-09 16:10:14.000000000 +0100
+++ arch/mips64/kernel/signal.c	2003-01-10 22:40:25.000000000 +0100
@@ -411,6 +411,6 @@
 			return;
 		}
 #endif
-		do_signal(regs,oldset);
+		do_signal(oldset, regs);
 	}
 }
--- arch/mips64/kernel/signal32.c	2002-11-09 16:10:14.000000000 +0100
+++ arch/mips64/kernel/signal32.c	2003-01-11 01:39:50.000000000 +0100
@@ -35,37 +35,10 @@
 
 extern asmlinkage void do_syscall_trace(void);
 
-/* 32-bit compatibility types */
-
-#define _NSIG32_BPW	32
-#define _NSIG32_WORDS	(_NSIG / _NSIG32_BPW)
-
-typedef struct {
-	unsigned int sig[_NSIG32_WORDS];
-} sigset32_t;
-
-typedef unsigned int __sighandler32_t;
-typedef void (*vfptr_t)(void);
-
-struct sigaction32 {
-	unsigned int		sa_flags;
-	__sighandler32_t	sa_handler;
-	sigset32_t		sa_mask;
-	unsigned int		sa_restorer;
-	int			sa_resv[1];     /* reserved */
-};
-
-/* IRIX compatible stack_t  */
-typedef struct sigaltstack32 {
-	s32 ss_sp;
-	__kernel_size_t32 ss_size;
-	int ss_flags;
-} stack32_t;
-
 extern void __put_sigset_unknown_nsig(void);
 extern void __get_sigset_unknown_nsig(void);
 
-static inline int put_sigset(const sigset_t *kbuf, sigset32_t *ubuf)
+static inline int put_sigset(const sigset_t *kbuf, sigset_t32 *ubuf)
 {
 	int err = 0;
 
@@ -86,7 +59,7 @@
 	return err;
 }
 
-static inline int get_sigset(sigset_t *kbuf, const sigset32_t *ubuf)
+static inline int get_sigset(sigset_t *kbuf, const sigset_t32 *ubuf)
 {
 	int err = 0;
 	unsigned long sig[4];
@@ -115,11 +88,11 @@
  */
 asmlinkage inline int sys32_sigsuspend(abi64_no_regargs, struct pt_regs regs)
 {
-	sigset32_t *uset;
+	sigset_t32 *uset;
 	sigset_t newset, saveset;
 
 	save_static(&regs);
-	uset = (sigset32_t *) regs.regs[4];
+	uset = (sigset_t32 *) regs.regs[4];
 	if (get_sigset(&newset, uset))
 		return -EFAULT;
 	sigdelsetmask(&newset, ~_BLOCKABLE);
@@ -142,17 +115,17 @@
 
 asmlinkage int sys32_rt_sigsuspend(abi64_no_regargs, struct pt_regs regs)
 {
-	sigset32_t *uset;
+	sigset_t32 *uset;
 	sigset_t newset, saveset;
         size_t sigsetsize;
 
 	save_static(&regs);
 	/* XXX Don't preclude handling different sized sigset_t's.  */
 	sigsetsize = regs.regs[5];
-	if (sigsetsize != sizeof(sigset32_t))
+	if (sigsetsize != sizeof(sigset_t32))
 		return -EINVAL;
 
-	uset = (sigset32_t *) regs.regs[4];
+	uset = (sigset_t32 *) regs.regs[4];
 	if (get_sigset(&newset, uset))
 		return -EFAULT;
 	sigdelsetmask(&newset, ~_BLOCKABLE);
@@ -795,7 +768,7 @@
 asmlinkage long sys_rt_sigprocmask(int how, sigset_t *set, sigset_t *oset,
 				   size_t sigsetsize);
 
-asmlinkage int sys32_rt_sigprocmask(int how, sigset32_t *set, sigset32_t *oset,
+asmlinkage int sys32_rt_sigprocmask(int how, sigset_t32 *set, sigset_t32 *oset,
 				    unsigned int sigsetsize)
 {
 	sigset_t old_set, new_set;
@@ -818,7 +791,7 @@
 
 asmlinkage long sys_rt_sigpending(sigset_t *set, size_t sigsetsize);
 
-asmlinkage int sys32_rt_sigpending(sigset32_t *uset, unsigned int sigsetsize)
+asmlinkage int sys32_rt_sigpending(sigset_t32 *uset, unsigned int sigsetsize)
 {
 	int ret;
 	sigset_t set;

--------------090906020704070304070501--
