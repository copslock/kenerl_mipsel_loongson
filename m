Received:  by oss.sgi.com id <S553808AbQJ0B45>;
	Thu, 26 Oct 2000 18:56:57 -0700
Received: from gateway-490.mvista.com ([63.192.220.206]:15355 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S553796AbQJ0B42>;
	Thu, 26 Oct 2000 18:56:28 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id e9R1sq325979;
	Thu, 26 Oct 2000 18:54:52 -0700
Message-ID: <39F8E121.8260535A@mvista.com>
Date:   Thu, 26 Oct 2000 18:57:53 -0700
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To:     Ralf Baechle <ralf@oss.sgi.com>
CC:     linux-mips@oss.sgi.com
Subject: Re: a REALLY, REALLY nasty bug
References: <39F79EF8.9029AE6@mvista.com> <20001027013845.C1056@bacchus.dhis.org>
Content-Type: multipart/mixed;
 boundary="------------C5536D991A3F6184B968C232"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

This is a multi-part message in MIME format.
--------------C5536D991A3F6184B968C232
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Ralf Baechle wrote:
> 
> On Wed, Oct 25, 2000 at 08:03:20PM -0700, Jun Sun wrote:
> 
> > I am sure Ralf will have something to say about it.  :-)  In any case, I
> > attached a patch for 1) fix.
> 
> A fix that is less easily affected by compiler overoptmizations is contained
> in 2.2; I'll merge it forward into 2.4.  Dunno how that didn't make it
> into 2.4.
> 

I took a look of what v2.2 does.  It does look better than my hack. 
Just verified that it worked on my machine.  I attached the patch - if
you want to save some time.
 
> Time for a brown paper bag.
>

You mean time for beer and pork feet?
 
Jun
--------------C5536D991A3F6184B968C232
Content-Type: text/plain; charset=us-ascii;
 name="junk"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="junk"

diff -Nru linux/include/asm-mips/stackframe.h.orig linux/include/asm-mips/stackframe.h
--- linux/include/asm-mips/stackframe.h.orig	Wed Oct 25 19:45:50 2000
+++ linux/include/asm-mips/stackframe.h	Thu Oct 26 18:34:50 2000
@@ -47,19 +47,28 @@
 #define __str2(x) #x
 #define __str(x) __str2(x)
 
-#define save_static(frame)                               \
-	__asm__ __volatile__(                            \
-		"sw\t$16,"__str(PT_R16)"(%0)\n\t"        \
-		"sw\t$17,"__str(PT_R17)"(%0)\n\t"        \
-		"sw\t$18,"__str(PT_R18)"(%0)\n\t"        \
-		"sw\t$19,"__str(PT_R19)"(%0)\n\t"        \
-		"sw\t$20,"__str(PT_R20)"(%0)\n\t"        \
-		"sw\t$21,"__str(PT_R21)"(%0)\n\t"        \
-		"sw\t$22,"__str(PT_R22)"(%0)\n\t"        \
-		"sw\t$23,"__str(PT_R23)"(%0)\n\t"        \
-		"sw\t$30,"__str(PT_R30)"(%0)\n\t"        \
-		: /* No outputs */                       \
-		: "r" (frame))
+#define save_static_function(symbol)                                    \
+__asm__ (                                                               \
+        ".globl\t" #symbol "\n\t"                                       \
+        ".align\t2\n\t"                                                 \
+        ".type\t" #symbol ", @function\n\t"                             \
+        ".ent\t" #symbol ", 0\n"                                        \
+        #symbol":\n\t"                                                  \
+        ".frame\t$29, 0, $31\n\t"                                       \
+        "sw\t$16,"__str(PT_R16)"($29)\t\t\t# save_static_function\n\t"  \
+        "sw\t$17,"__str(PT_R17)"($29)\n\t"                              \
+        "sw\t$18,"__str(PT_R18)"($29)\n\t"                              \
+        "sw\t$19,"__str(PT_R19)"($29)\n\t"                              \
+        "sw\t$20,"__str(PT_R20)"($29)\n\t"                              \
+        "sw\t$21,"__str(PT_R21)"($29)\n\t"                              \
+        "sw\t$22,"__str(PT_R22)"($29)\n\t"                              \
+        "sw\t$23,"__str(PT_R23)"($29)\n\t"                              \
+        "sw\t$30,"__str(PT_R30)"($29)\n\t"                              \
+        ".end\t" #symbol "\n\t"                                         \
+        ".size\t" #symbol",. - " #symbol)
+
+/* Used in declaration of save_static functions.  */
+#define unused __attribute__((unused))
 
 #define SAVE_SOME                                        \
 		.set	push;                            \
@@ -90,6 +99,7 @@
 		mfc0	v1, CP0_EPC;                     \
 		sw	$7, PT_R7(sp);                   \
 		sw	v1, PT_EPC(sp);                  \
+		sw	$16, PT_R16(sp);                 \
 		sw	$25, PT_R25(sp);                 \
 		sw	$28, PT_R28(sp);                 \
 		sw	$31, PT_R31(sp);                 \
diff -Nru linux/arch/mips/kernel/signal.c.orig linux/arch/mips/kernel/signal.c
--- linux/arch/mips/kernel/signal.c.orig	Thu Oct 26 18:36:54 2000
+++ linux/arch/mips/kernel/signal.c	Thu Oct 26 18:42:01 2000
@@ -76,12 +76,12 @@
 /*
  * Atomically swap in the new signal mask, and wait for a signal.
  */
-asmlinkage inline int
-sys_sigsuspend(struct pt_regs regs)
+save_static_function(sys_sigsuspend);
+static unused int
+_sys_sigsuspend(struct pt_regs regs)
 {
 	sigset_t *uset, saveset, newset;
 
-	save_static(&regs);
 	uset = (sigset_t *) regs.regs[4];
 	if (copy_from_user(&newset, uset, sizeof(sigset_t)))
 		return -EFAULT;
@@ -103,13 +103,13 @@
 	}
 }
 
-asmlinkage int
-sys_rt_sigsuspend(struct pt_regs regs)
+
+save_static_function(sys_rt_sigsuspend);
+static unused int
+_sys_rt_sigsuspend(struct pt_regs regs)
 {
 	sigset_t *unewset, saveset, newset;
         size_t sigsetsize;
-
-	save_static(&regs);
 
 	/* XXX Don't preclude handling different sized sigset_t's.  */
 	sigsetsize = regs.regs[5];
diff -Nru linux/arch/mips/kernel/syscall.c.orig linux/arch/mips/kernel/syscall.c
--- linux/arch/mips/kernel/syscall.c.orig	Thu Oct 26 18:43:10 2000
+++ linux/arch/mips/kernel/syscall.c	Thu Oct 26 18:47:00 2000
@@ -92,22 +92,22 @@
 	return do_mmap2(addr, len, prot, flags, fd, pgoff);
 }
 
-asmlinkage int sys_fork(struct pt_regs regs)
+save_static_function(sys_fork);
+static unused int _sys_fork(struct pt_regs regs)
 {
 	int res;
 
-	save_static(&regs);
 	res = do_fork(SIGCHLD, regs.regs[29], &regs);
 	return res;
 }
 
-asmlinkage int sys_clone(struct pt_regs regs)
+save_static_function(sys_clone);
+static unused int _sys_clone(struct pt_regs regs)
 {
 	unsigned long clone_flags;
 	unsigned long newsp;
 	int res;
 
-	save_static(&regs);
 	clone_flags = regs.regs[4];
 	newsp = regs.regs[5];
 	if (!newsp)

--------------C5536D991A3F6184B968C232--
