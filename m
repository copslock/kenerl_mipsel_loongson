Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Jun 2004 14:12:44 +0100 (BST)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:46024 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225285AbUF1NMi>; Mon, 28 Jun 2004 14:12:38 +0100
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id 8CCC449D0A; Mon, 28 Jun 2004 15:12:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id 7B23C47C5C; Mon, 28 Jun 2004 15:12:27 +0200 (CEST)
Date: Mon, 28 Jun 2004 15:12:27 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Subject: Re: [patch] Prevent dead code/data removal with gcc 3.4
In-Reply-To: <20040213145316.GA23810@linux-mips.org>
Message-ID: <Pine.LNX.4.55.0406281509170.23162@jurand.ds.pg.gda.pl>
References: <Pine.LNX.4.55.0402131453360.15042@jurand.ds.pg.gda.pl>
 <20040213145316.GA23810@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5367
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, 13 Feb 2004, Ralf Baechle wrote:

> It is possible that gcc changes one of the registers before save_static
> and I can't imagine there's a reliable way to fix this in the inline
> version.

 Here's an updated version.  It's been checked with gcc 3.5.0, but it
should work just fine back to 2.95 at least.  OK to apply?

  Maciej

patch-mips-2.4.26-20040531-mips-save-static-gcc3-1
diff -up --recursive --new-file linux-mips-2.4.26-20040531.macro/arch/mips/kernel/signal.c linux-mips-2.4.26-20040531/arch/mips/kernel/signal.c
--- linux-mips-2.4.26-20040531.macro/arch/mips/kernel/signal.c	2004-03-03 03:57:09.000000000 +0000
+++ linux-mips-2.4.26-20040531/arch/mips/kernel/signal.c	2004-06-26 17:12:28.000000000 +0000
@@ -6,8 +6,10 @@
  * Copyright (C) 1991, 1992  Linus Torvalds
  * Copyright (C) 1994 - 1999  Ralf Baechle
  * Copyright (C) 1999 Silicon Graphics, Inc.
+ * Copyright (C) 2004  Maciej W. Rozycki
  */
 #include <linux/config.h>
+#include <linux/compiler.h>
 #include <linux/sched.h>
 #include <linux/mm.h>
 #include <linux/smp.h>
@@ -76,7 +78,9 @@ int copy_siginfo_to_user(siginfo_t *to, 
  * Atomically swap in the new signal mask, and wait for a signal.
  */
 save_static_function(sys_sigsuspend);
-static_unused int _sys_sigsuspend(struct pt_regs regs)
+static int _sys_sigsuspend(struct pt_regs regs)
+	__asm__("_sys_sigsuspend") __attribute_used__;
+static int _sys_sigsuspend(struct pt_regs regs)
 {
 	sigset_t *uset, saveset, newset;
 
@@ -102,7 +106,9 @@ static_unused int _sys_sigsuspend(struct
 }
 
 save_static_function(sys_rt_sigsuspend);
-static_unused int _sys_rt_sigsuspend(struct pt_regs regs)
+static int _sys_rt_sigsuspend(struct pt_regs regs)
+	__asm__("_sys_rt_sigsuspend") __attribute_used__;
+static int _sys_rt_sigsuspend(struct pt_regs regs)
 {
 	sigset_t *unewset, saveset, newset;
         size_t sigsetsize;
diff -up --recursive --new-file linux-mips-2.4.26-20040531.macro/arch/mips/kernel/syscall.c linux-mips-2.4.26-20040531/arch/mips/kernel/syscall.c
--- linux-mips-2.4.26-20040531.macro/arch/mips/kernel/syscall.c	2003-04-01 02:56:50.000000000 +0000
+++ linux-mips-2.4.26-20040531/arch/mips/kernel/syscall.c	2004-06-26 17:14:46.000000000 +0000
@@ -5,6 +5,7 @@
  *
  * Copyright (C) 1995 - 2000 by Ralf Baechle
  * Copyright (C) 2000 Silicon Graphics, Inc.
+ * Copyright (C) 2004  Maciej W. Rozycki
  *
  * TODO:  Implement the compatibility syscalls.
  *        Don't waste that much memory for empty entries in the syscall
@@ -158,7 +159,9 @@ sys_mmap2(unsigned long addr, unsigned l
 }
 
 save_static_function(sys_fork);
-static_unused int _sys_fork(struct pt_regs regs)
+static int _sys_fork(struct pt_regs regs)
+	__asm__("_sys_fork") __attribute_used__;
+static int _sys_fork(struct pt_regs regs)
 {
 	int res;
 
@@ -168,7 +171,9 @@ static_unused int _sys_fork(struct pt_re
 
 
 save_static_function(sys_clone);
-static_unused int _sys_clone(struct pt_regs regs)
+static int _sys_clone(struct pt_regs regs)
+	__asm__("_sys_clone") __attribute_used__;
+static int _sys_clone(struct pt_regs regs)
 {
 	unsigned long clone_flags;
 	unsigned long newsp;
diff -up --recursive --new-file linux-mips-2.4.26-20040531.macro/arch/mips64/kernel/signal.c linux-mips-2.4.26-20040531/arch/mips64/kernel/signal.c
--- linux-mips-2.4.26-20040531.macro/arch/mips64/kernel/signal.c	2004-03-03 03:57:12.000000000 +0000
+++ linux-mips-2.4.26-20040531/arch/mips64/kernel/signal.c	2004-06-26 17:19:15.000000000 +0000
@@ -6,8 +6,10 @@
  * Copyright (C) 1991, 1992  Linus Torvalds
  * Copyright (C) 1994 - 2000  Ralf Baechle
  * Copyright (C) 1999, 2000 Silicon Graphics, Inc.
+ * Copyright (C) 2004  Maciej W. Rozycki
  */
 #include <linux/config.h>
+#include <linux/compiler.h>
 #include <linux/sched.h>
 #include <linux/mm.h>
 #include <linux/smp.h>
@@ -75,7 +77,9 @@ int copy_siginfo_to_user(siginfo_t *to, 
  * Atomically swap in the new signal mask, and wait for a signal.
  */
 save_static_function(sys_rt_sigsuspend);
-static_unused int _sys_rt_sigsuspend(abi64_no_regargs, struct pt_regs regs)
+static int _sys_rt_sigsuspend(abi64_no_regargs, struct pt_regs regs)
+	__asm__("_sys_rt_sigsuspend") __attribute_used__;
+static int _sys_rt_sigsuspend(abi64_no_regargs, struct pt_regs regs)
 {
 	sigset_t *unewset, saveset, newset;
         size_t sigsetsize;
diff -up --recursive --new-file linux-mips-2.4.26-20040531.macro/arch/mips64/kernel/signal32.c linux-mips-2.4.26-20040531/arch/mips64/kernel/signal32.c
--- linux-mips-2.4.26-20040531.macro/arch/mips64/kernel/signal32.c	2004-03-04 03:57:04.000000000 +0000
+++ linux-mips-2.4.26-20040531/arch/mips64/kernel/signal32.c	2004-06-26 17:19:06.000000000 +0000
@@ -6,7 +6,9 @@
  * Copyright (C) 1991, 1992  Linus Torvalds
  * Copyright (C) 1994 - 2000  Ralf Baechle
  * Copyright (C) 1999, 2000 Silicon Graphics, Inc.
+ * Copyright (C) 2004  Maciej W. Rozycki
  */
+#include <linux/compiler.h>
 #include <linux/sched.h>
 #include <linux/mm.h>
 #include <linux/smp.h>
@@ -127,7 +129,9 @@ static inline int get_sigset(sigset_t *k
  * Atomically swap in the new signal mask, and wait for a signal.
  */
 save_static_function(sys32_sigsuspend);
-static_unused int _sys32_sigsuspend(abi64_no_regargs, struct pt_regs regs)
+static int _sys32_sigsuspend(abi64_no_regargs, struct pt_regs regs)
+	__asm__("_sys32_sigsuspend") __attribute_used__;
+static int _sys32_sigsuspend(abi64_no_regargs, struct pt_regs regs)
 {
 	sigset32_t *uset;
 	sigset_t newset, saveset;
@@ -154,7 +158,9 @@ static_unused int _sys32_sigsuspend(abi6
 }
 
 save_static_function(sys32_rt_sigsuspend);
-static_unused int _sys32_rt_sigsuspend(abi64_no_regargs, struct pt_regs regs)
+static int _sys32_rt_sigsuspend(abi64_no_regargs, struct pt_regs regs)
+	__asm__("_sys32_rt_sigsuspend") __attribute_used__;
+static int _sys32_rt_sigsuspend(abi64_no_regargs, struct pt_regs regs)
 {
 	sigset32_t *uset;
 	sigset_t newset, saveset;
diff -up --recursive --new-file linux-mips-2.4.26-20040531.macro/arch/mips64/kernel/syscall.c linux-mips-2.4.26-20040531/arch/mips64/kernel/syscall.c
--- linux-mips-2.4.26-20040531.macro/arch/mips64/kernel/syscall.c	2004-03-10 03:57:00.000000000 +0000
+++ linux-mips-2.4.26-20040531/arch/mips64/kernel/syscall.c	2004-06-26 17:21:08.000000000 +0000
@@ -6,7 +6,9 @@
  * Copyright (C) 1995 - 2000, 2001 by Ralf Baechle
  * Copyright (C) 1999, 2000 Silicon Graphics, Inc.
  * Copyright (C) 2001 MIPS Technologies, Inc.
+ * Copyright (C) 2004  Maciej W. Rozycki
  */
+#include <linux/compiler.h>
 #include <linux/errno.h>
 #include <linux/linkage.h>
 #include <linux/mm.h>
@@ -151,7 +153,9 @@ out:
 }
 
 save_static_function(sys_fork);
-static_unused int _sys_fork(abi64_no_regargs, struct pt_regs regs)
+static int _sys_fork(abi64_no_regargs, struct pt_regs regs)
+	__asm__("_sys_fork") __attribute_used__;
+static int _sys_fork(abi64_no_regargs, struct pt_regs regs)
 {
 	int res;
 
@@ -160,7 +164,9 @@ static_unused int _sys_fork(abi64_no_reg
 }
 
 save_static_function(sys_clone);
-static_unused int _sys_clone(abi64_no_regargs, struct pt_regs regs)
+static int _sys_clone(abi64_no_regargs, struct pt_regs regs)
+	__asm__("_sys_clone") __attribute_used__;
+static int _sys_clone(abi64_no_regargs, struct pt_regs regs)
 {
 	unsigned long clone_flags;
 	unsigned long newsp;
diff -up --recursive --new-file linux-mips-2.4.26-20040531.macro/include/asm-mips/ptrace.h linux-mips-2.4.26-20040531/include/asm-mips/ptrace.h
--- linux-mips-2.4.26-20040531.macro/include/asm-mips/ptrace.h	2004-02-09 04:30:14.000000000 +0000
+++ linux-mips-2.4.26-20040531/include/asm-mips/ptrace.h	2004-06-26 17:30:45.000000000 +0000
@@ -4,6 +4,7 @@
  * for more details.
  *
  * Copyright (C) 1994, 1995, 1996, 1997, 1998, 1999, 2000 by Ralf Baechle
+ * Copyright (C) 2004  Maciej W. Rozycki
  *
  * Machine dependent structs and defines to help the user use
  * the ptrace system call.
@@ -64,12 +65,10 @@ __asm__ (                               
         "sw\t$22,"__str(PT_R22)"($29)\n\t"                              \
         "sw\t$23,"__str(PT_R23)"($29)\n\t"                              \
         "sw\t$30,"__str(PT_R30)"($29)\n\t"                              \
+	"j\t_" #symbol "\n\t"						\
         ".end\t" #symbol "\n\t"                                         \
         ".size\t" #symbol",. - " #symbol)
 
-/* Used in declaration of save_static functions.  */
-#define static_unused static __attribute__((unused))
-
 #endif /* !__ASSEMBLY__ */
 
 /* Arbitrarily choose the same ptrace numbers as used by the Sparc code. */
diff -up --recursive --new-file linux-mips-2.4.26-20040531.macro/include/asm-mips64/ptrace.h linux-mips-2.4.26-20040531/include/asm-mips64/ptrace.h
--- linux-mips-2.4.26-20040531.macro/include/asm-mips64/ptrace.h	2004-01-26 03:35:56.000000000 +0000
+++ linux-mips-2.4.26-20040531/include/asm-mips64/ptrace.h	2004-06-26 17:30:15.000000000 +0000
@@ -5,6 +5,7 @@
  *
  * Copyright (C) 1994, 95, 96, 97, 98, 99, 2000 by Ralf Baechle
  * Copyright (C) 1999, 2000 Silicon Graphics, Inc.
+ * Copyright (C) 2004  Maciej W. Rozycki
  */
 #ifndef _ASM_PTRACE_H
 #define _ASM_PTRACE_H
@@ -61,12 +62,10 @@ __asm__ (                               
         "sd\t$22,"__str(PT_R22)"($29)\n\t"                              \
         "sd\t$23,"__str(PT_R23)"($29)\n\t"                              \
         "sd\t$30,"__str(PT_R30)"($29)\n\t"                              \
+	"j\t_" #symbol "\n\t"						\
         ".end\t" #symbol "\n\t"                                         \
         ".size\t" #symbol",. - " #symbol)
 
-/* Used in declaration of save_static functions.  */
-#define static_unused static __attribute__((unused))
-
 #define abi64_no_regargs						\
 	unsigned long __dummy0,						\
 	unsigned long __dummy1,						\
