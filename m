Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 26 Jan 2003 01:57:34 +0000 (GMT)
Received: from smtp-102.nerim.net ([IPv6:::ffff:62.4.16.102]:26381 "EHLO
	kraid.nerim.net") by linux-mips.org with ESMTP id <S8225200AbTAZB5d>;
	Sun, 26 Jan 2003 01:57:33 +0000
Received: from melkor (vivienc.net1.nerim.net [213.41.134.233])
	by kraid.nerim.net (Postfix) with ESMTP
	id 5BA8E40E2B; Sun, 26 Jan 2003 02:57:30 +0100 (CET)
Received: from glaurung (helo=localhost)
	by melkor with local-esmtp (Exim 3.36 #1 (Debian))
	id 18cc3l-00049Z-00; Sun, 26 Jan 2003 02:58:09 +0100
Date: Sun, 26 Jan 2003 02:58:09 +0100 (CET)
From: Vivien Chappelier <vivienc@nerim.net>
X-Sender: glaurung@melkor
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: linux-mips@linux-mips.org
Subject: [PATCH 2.5] FPU
Message-ID: <Pine.LNX.4.21.0301260251300.15950-100000@melkor>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <vivienc@nerim.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1219
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vivienc@nerim.net
Precedence: bulk
X-list: linux-mips

Hi,

	At various places in the 2.5 kernel, the fpu is accessed in
kernel mode with CU1 not set, causing an unexpected exception. This patch
makes sure FPU can be accessed by the kernel, though it may only
be a workaround. Any comment from someone with a better understanding of
the FPU access/context switching code?

Vivien.

--- include/asm-mips64/fpu.h	2002-12-11 20:44:20.000000000 +0100
+++ include/asm-mips64/fpu.h	2002-12-11 21:51:44.000000000 +0100
@@ -109,6 +109,7 @@
 
 static inline void save_fp(struct task_struct *tsk)
 {
+	enable_fpu();
 	if (mips_cpu.options & MIPS_CPU_FPU) 
 		_save_fp(tsk);
 }
--- include/asm-mips/fpu.h	2002-12-11 20:44:20.000000000 +0100
+++ include/asm-mips/fpu.h	2002-12-11 21:51:44.000000000 +0100
@@ -109,6 +109,7 @@
 
 static inline void save_fp(struct task_struct *tsk)
 {
+	enable_fpu();
 	if (mips_cpu.options & MIPS_CPU_FPU) 
 		_save_fp(tsk);
 }
--- arch/mips64/kernel/signal.c	2002-11-09 16:10:14.000000000 +0100
+++ arch/mips64/kernel/signal.c	2003-01-14 01:35:42.000000000 +0100
@@ -162,20 +162,19 @@
 
 	err |= __put_user(current->used_math, &sc->sc_used_math);
 
-	if (!current->used_math)
-		goto out;
+	if (current->used_math) {
+
+		/*
+		 * Save FPU state to signal context.
+		 * Signal handler will "inherit" current FPU state.
+		 */
 
-	/*
-	 * Save FPU state to signal context.  Signal handler will "inherit"
-	 * current FPU state.
-	 */
-	if (!is_fpu_owner()) {
 		own_fpu();
 		restore_fp(current);
+
+		err |= save_fp_context(sc);
 	}
-	err |= save_fp_context(sc);
 
-out:
 	return err;
 }
 
--- arch/mips/kernel/signal.c	2002-11-09 16:10:08.000000000 +0100
+++ arch/mips/kernel/signal.c	2003-01-14 01:36:41.000000000 +0100
@@ -313,20 +313,19 @@
 
 	err |= __put_user(current->used_math, &sc->sc_used_math);
 
-	if (!current->used_math)
-		goto out;
+	if (current->used_math) {
+
+		/* 
+		 * Save FPU state to signal context.
+		 * Signal handler will "inherit" current FPU state.
+		 */
 
-	/* 
-	 * Save FPU state to signal context.  Signal handler will "inherit"
-	 * current FPU state.
-	 */
-	if (!is_fpu_owner()) {
 		own_fpu();
 		restore_fp(current);
+
+		err |= save_fp_context(sc);
 	}
-	err |= save_fp_context(sc);
 
-out:
 	return err;
 }
 
--- arch/mips64/kernel/signal32.c	2002-11-09 16:10:14.000000000 +0100
+++ arch/mips64/kernel/signal32.c	2003-01-14 01:34:52.000000000 +0100
@@ -457,20 +430,19 @@
 
 	err |= __put_user(current->used_math, &sc->sc_used_math);
 
-	if (!current->used_math)
-		goto out;
+	if (current->used_math) {
+
+		/* 
+		 * Save FPU state to signal context.
+		 * Signal handler will "inherit" current FPU state.
+		 */
 
-	/* 
-	 * Save FPU state to signal context.  Signal handler will "inherit"
-	 * current FPU state.
-	 */
-	if (!is_fpu_owner()) {
 		own_fpu();
 		restore_fp(current);
+
+		err |= save_fp_context(sc);
 	}
-	err |= save_fp_context(sc);
 
-out:
 	return err;
 }
 
