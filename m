Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Mar 2003 12:50:00 +0000 (GMT)
Received: from p508B4DD5.dip.t-dialin.net ([IPv6:::ffff:80.139.77.213]:37569
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225200AbTCHMt7>; Sat, 8 Mar 2003 12:49:59 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h28CntR23246
	for linux-mips@linux-mips.org; Sat, 8 Mar 2003 13:49:55 +0100
Date: Sat, 8 Mar 2003 13:49:55 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: linux-mips@linux-mips.org
Subject: Struct sigaction cleanup
Message-ID: <20030308134955.A22922@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Return-Path: <ralf@linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1669
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

I'm working on overhauling the signal code.  Part 1 is just some cleanup.
As historic garbage we've got two unused fields in struct sigaction:

struct sigaction {
        unsigned int    sa_flags;
        __sighandler_t  sa_handler;
        sigset_t        sa_mask;
        void            (*sa_restorer)(void);
        int             sa_resv[1];     /* reserved */
};

Actually the size of sa_mask is supposed to be variable and therefore
sa_mask has to be the last member of struct sigaction.  Further no known
libc implementation making use of sa_restorer.  So here's a patch to
remove the two fields.  This little change btw. delivers 3% speedup of
signal delivery.

Note there is no binary compatibility issue.  Glibc's contains it's own
definitions of struct sigaction and the kernel's struct sigaction.  That
means existing glibc binaries will simply pass a too large kernel struct
sigaction to the kernel which will just ignore the extra fields.

Comments?

  Ralf

Index: arch/mips/kernel/irixsig.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/kernel/irixsig.c,v
retrieving revision 1.20.2.1
diff -u -r1.20.2.1 irixsig.c
--- arch/mips/kernel/irixsig.c	5 Aug 2002 23:53:33 -0000	1.20.2.1
+++ arch/mips/kernel/irixsig.c	8 Mar 2003 12:17:51 -0000
@@ -116,7 +116,8 @@
 	regs->regs[5] = 0; /* XXX sigcode XXX */
 	regs->regs[6] = regs->regs[29] = sp;
 	regs->regs[7] = (unsigned long) ka->sa.sa_handler;
-	regs->regs[25] = regs->cp0_epc = (unsigned long) ka->sa.sa_restorer;
+	regs->regs[25] = regs->cp0_epc = (unsigned long) ka->sa_restorer;
+
 	return;
 
 segv_and_exit:
@@ -407,7 +408,7 @@
 		 * value for all invocations of sigaction.  Will have to
 		 * investigate.  POSIX POSIX, die die die...
 		 */
-		new_ka.sa.sa_restorer = trampoline;
+		new_ka.sa_restorer = trampoline;
 	}
 
 /* XXX Implement SIG_SETMASK32 for IRIX compatibility */
Index: arch/mips/kernel/signal.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/kernel/signal.c,v
retrieving revision 1.39.2.10
diff -u -r1.39.2.10 signal.c
--- arch/mips/kernel/signal.c	4 Nov 2002 19:39:56 -0000	1.39.2.10
+++ arch/mips/kernel/signal.c	8 Mar 2003 12:17:52 -0000
@@ -148,7 +148,6 @@
 		err |= __get_user(new_ka.sa.sa_handler, &act->sa_handler);
 		err |= __get_user(new_ka.sa.sa_flags, &act->sa_flags);
 		err |= __get_user(mask, &act->sa_mask.sig[0]);
-		err |= __get_user(new_ka.sa.sa_restorer, &act->sa_restorer);
 		if (err)
 			return -EFAULT;
 
@@ -166,7 +165,6 @@
                 err |= __put_user(0, &oact->sa_mask.sig[1]);
                 err |= __put_user(0, &oact->sa_mask.sig[2]);
                 err |= __put_user(0, &oact->sa_mask.sig[3]);
-		err |= __put_user(old_ka.sa.sa_restorer, &oact->sa_restorer);
                 if (err)
 			return -EFAULT;
 	}
@@ -400,23 +398,15 @@
 	if (!access_ok(VERIFY_WRITE, frame, sizeof (*frame)))
 		goto give_sigsegv;
 
-	/* Set up to return from userspace.  If provided, use a stub already
-	   in userspace.  */
-	if (ka->sa.sa_flags & SA_RESTORER)
-		regs->regs[31] = (unsigned long) ka->sa.sa_restorer;
-	else {
-		/*
-		 * Set up the return code ...
-		 *
-		 *         li      v0, __NR_sigreturn
-		 *         syscall
-		 */
-		err |= __put_user(0x24020000 + __NR_sigreturn,
-		                  frame->sf_code + 0);
-		err |= __put_user(0x0000000c                 ,
-		                  frame->sf_code + 1);
-		flush_cache_sigtramp((unsigned long) frame->sf_code);
-	}
+	/*
+	 * Set up the return code ...
+	 *
+	 *         li      v0, __NR_sigreturn
+	 *         syscall
+	 */
+	err |= __put_user(0x24020000 + __NR_sigreturn, frame->sf_code + 0);
+	err |= __put_user(0x0000000c                 , frame->sf_code + 1);
+	flush_cache_sigtramp((unsigned long) frame->sf_code);
 
 	err |= setup_sigcontext(regs, &frame->sf_sc);
 	err |= __copy_to_user(&frame->sf_mask, set, sizeof(*set));
@@ -463,23 +453,15 @@
 	if (!access_ok(VERIFY_WRITE, frame, sizeof (*frame)))
 		goto give_sigsegv;
 
-	/* Set up to return from userspace.  If provided, use a stub already
-	   in userspace.  */
-	if (ka->sa.sa_flags & SA_RESTORER)
-		regs->regs[31] = (unsigned long) ka->sa.sa_restorer;
-	else {
-		/*
-		 * Set up the return code ...
-		 *
-		 *         li      v0, __NR_rt_sigreturn
-		 *         syscall
-		 */
-		err |= __put_user(0x24020000 + __NR_rt_sigreturn,
-		                  frame->rs_code + 0);
-		err |= __put_user(0x0000000c                 ,
-		                  frame->rs_code + 1);
-		flush_cache_sigtramp((unsigned long) frame->rs_code);
-	}
+	/*
+	 * Set up the return code ...
+	 *
+	 *         li      v0, __NR_rt_sigreturn
+	 *         syscall
+	 */
+	err |= __put_user(0x24020000 + __NR_rt_sigreturn, frame->rs_code + 0);
+	err |= __put_user(0x0000000c                    , frame->rs_code + 1);
+	flush_cache_sigtramp((unsigned long) frame->rs_code);
 
 	/* Create siginfo.  */
 	err |= copy_siginfo_to_user(&frame->rs_info, info);
Index: arch/mips64/kernel/signal32.c
===================================================================
RCS file: /home/cvs/linux/arch/mips64/kernel/signal32.c,v
retrieving revision 1.20.2.11
diff -u -r1.20.2.11 signal32.c
--- arch/mips64/kernel/signal32.c	4 Nov 2002 19:39:56 -0000	1.20.2.11
+++ arch/mips64/kernel/signal32.c	8 Mar 2003 12:17:57 -0000
@@ -51,8 +51,6 @@
 	unsigned int		sa_flags;
 	__sighandler32_t	sa_handler;
 	sigset32_t		sa_mask;
-	unsigned int		sa_restorer;
-	int			sa_resv[1];     /* reserved */
 };
 
 /* IRIX compatible stack_t  */
@@ -189,8 +187,6 @@
 		                  &act->sa_handler);
 		err |= __get_user(new_ka.sa.sa_flags, &act->sa_flags);
 		err |= __get_user(mask, &act->sa_mask.sig[0]);
-		err |= __get_user((u32)(u64)new_ka.sa.sa_restorer,
-		                   &act->sa_restorer);
 		if (err)
 			return -EFAULT;
 
@@ -209,8 +205,6 @@
                 err |= __put_user(0, &oact->sa_mask.sig[1]);
                 err |= __put_user(0, &oact->sa_mask.sig[2]);
                 err |= __put_user(0, &oact->sa_mask.sig[3]);
-		err |= __put_user((u32)(u64)old_ka.sa.sa_restorer,
-		                  &oact->sa_restorer);
                 if (err)
 			return -EFAULT;
 	}
@@ -509,23 +503,15 @@
 	if (!access_ok(VERIFY_WRITE, frame, sizeof (*frame)))
 		goto give_sigsegv;
 
-	/* Set up to return from userspace.  If provided, use a stub already
-	   in userspace.  */
-	if (ka->sa.sa_flags & SA_RESTORER)
-		regs->regs[31] = (unsigned long) ka->sa.sa_restorer;
-	else {
-		/*
-		 * Set up the return code ...
-		 *
-		 *         li      v0, __NR_O32_sigreturn
-		 *         syscall
-		 */
-		err |= __put_user(0x24020000 + __NR_O32_sigreturn,
-		                  frame->sf_code + 0);
-		err |= __put_user(0x0000000c                 ,
-		                  frame->sf_code + 1);
-		flush_cache_sigtramp((unsigned long) frame->sf_code);
-	}
+	/*
+	 * Set up the return code ...
+	 *
+	 *         li      v0, __NR_O32_sigreturn
+	 *         syscall
+	 */
+	err |= __put_user(0x24020000 + __NR_O32_sigreturn, frame->sf_code + 0);
+	err |= __put_user(0x0000000c                     , frame->sf_code + 1);
+	flush_cache_sigtramp((unsigned long) frame->sf_code);
 
 	err |= setup_sigcontext(regs, &frame->sf_sc);
 	err |= __copy_to_user(&frame->sf_mask, set, sizeof(*set));
@@ -575,21 +561,15 @@
 
 	/* Set up to return from userspace.  If provided, use a stub already
 	   in userspace.  */
-	if (ka->sa.sa_flags & SA_RESTORER)
-		regs->regs[31] = (unsigned long) ka->sa.sa_restorer;
-	else {
-		/*
-		 * Set up the return code ...
-		 *
-		 *         li      v0, __NR_O32_rt_sigreturn
-		 *         syscall
-		 */
-		err |= __put_user(0x24020000 + __NR_O32_rt_sigreturn,
-		                  frame->rs_code + 0);
-		err |= __put_user(0x0000000c                 ,
-		                  frame->rs_code + 1);
-		flush_cache_sigtramp((unsigned long) frame->rs_code);
-	}
+	/*
+	 * Set up the return code ...
+	 *
+	 *         li      v0, __NR_O32_rt_sigreturn
+	 *         syscall
+	 */
+	err |= __put_user(0x24020000 + __NR_O32_rt_sigreturn, frame->rs_code + 0);
+	err |= __put_user(0x0000000c                      , frame->rs_code + 1);
+	flush_cache_sigtramp((unsigned long) frame->rs_code);
 
 	/* Convert (siginfo_t -> siginfo_t32) and copy to user. */
 	err |= copy_siginfo_to_user32(&frame->rs_info, info);
@@ -812,11 +792,14 @@
 
 	if (set && get_user (s, set))
 		return -EFAULT;
+
 	set_fs (KERNEL_DS);
 	ret = sys_sigprocmask(how, set ? &s : NULL, oset ? &s : NULL);
 	set_fs (old_fs);
+
 	if (!ret && oset && put_user (s, oset))
 		return -EFAULT;
+
 	return ret;
 }
 
@@ -857,8 +840,6 @@
 		err |= __get_user((u32)(u64)new_sa.sa.sa_handler,
 		                  &act->sa_handler);
 		err |= __get_user(new_sa.sa.sa_flags, &act->sa_flags);
-		err |= __get_user((u32)(u64)new_sa.sa.sa_restorer,
-		                  &act->sa_restorer);
 		err |= get_sigset(&new_sa.sa.sa_mask, &act->sa_mask);
 		if (err)
 			return -EFAULT;
@@ -875,8 +856,6 @@
 		err |= __put_user((u32)(u64)old_sa.sa.sa_handler,
 		                   &oact->sa_handler);
 		err |= __put_user(old_sa.sa.sa_flags, &oact->sa_flags);
-		err |= __put_user((u32)(u64)old_sa.sa.sa_restorer,
-		                  &oact->sa_restorer);
 		err |= put_sigset(&old_sa.sa.sa_mask, &oact->sa_mask);
 		if (err)
 			return -EFAULT;
Index: include/asm-mips/signal.h
===================================================================
RCS file: /home/cvs/linux/include/asm-mips/signal.h,v
retrieving revision 1.9.2.1
diff -u -r1.9.2.1 signal.h
--- include/asm-mips/signal.h	5 Aug 2002 23:53:37 -0000	1.9.2.1
+++ include/asm-mips/signal.h	8 Mar 2003 12:18:40 -0000
@@ -9,6 +9,7 @@
 #ifndef _ASM_SIGNAL_H
 #define _ASM_SIGNAL_H
 
+#include <linux/config.h>
 #include <linux/types.h>
 
 #define _NSIG		128
@@ -130,12 +131,13 @@
 	unsigned int	sa_flags;
 	__sighandler_t	sa_handler;
 	sigset_t	sa_mask;
-	void		(*sa_restorer)(void);
-	int		sa_resv[1];	/* reserved */
 };
 
 struct k_sigaction {
 	struct sigaction sa;
+#ifdef CONFIG_BINFMT_IRIX
+	void		(*sa_restorer)(void);
+#endif
 };
 
 /* IRIX compatible stack_t  */
Index: include/asm-mips64/signal.h
===================================================================
RCS file: /home/cvs/linux/include/asm-mips64/signal.h,v
retrieving revision 1.4.2.4
diff -u -r1.4.2.4 signal.h
--- include/asm-mips64/signal.h	27 Jan 2003 19:19:13 -0000	1.4.2.4
+++ include/asm-mips64/signal.h	8 Mar 2003 12:18:45 -0000
@@ -139,8 +139,6 @@
 	unsigned int	sa_flags;
 	__sighandler_t	sa_handler;
 	sigset_t	sa_mask;
-	void		(*sa_restorer)(void);
-	int		sa_resv[1];	/* reserved */
 };
 
 struct k_sigaction {
