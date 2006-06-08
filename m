Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Jun 2006 02:36:49 +0100 (BST)
Received: from intranet.codesourcery.com ([65.74.133.6]:44193 "EHLO
	mail.codesourcery.com") by ftp.linux-mips.org with ESMTP
	id S8134038AbWFHBgk (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 8 Jun 2006 02:36:40 +0100
Received: (qmail 27433 invoked from network); 8 Jun 2006 01:36:30 -0000
Received: from unknown (HELO digraph.polyomino.org.uk) (joseph@127.0.0.2)
  by mail.codesourcery.com with ESMTPA; 8 Jun 2006 01:36:30 -0000
Received: from jsm28 (helo=localhost)
	by digraph.polyomino.org.uk with local-esmtp (Exim 4.52)
	id 1Fo9Rl-0000os-R3
	for linux-mips@linux-mips.org; Thu, 08 Jun 2006 01:36:29 +0000
Date:	Thu, 8 Jun 2006 01:36:29 +0000 (UTC)
From:	"Joseph S. Myers" <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To:	linux-mips@linux-mips.org
Subject: N32 sigset and __COMPAT_ENDIAN_SWAP__
Message-ID: <Pine.LNX.4.64.0606080134480.26638@digraph.polyomino.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <joseph@codesourcery.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11694
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joseph@codesourcery.com
Precedence: bulk
X-list: linux-mips

I'm testing glibc on MIPS64, little-endian, N32, O32 and N64
multilibs.

Among the NPTL test failures seen are some arising from sigsuspend
problems for N32: it blocks the wrong signals, so SIGCANCEL (SIGRTMIN)
is blocked despite glibc's carefully excluding it from sets of signals
to block.  Specifically, testing suggests it blocks signal N^32
instead of signal N, so (in the example tested) blocking SIGUSR1 (17)
blocks signal 49 instead.

glibc's sigset_t uses an array of unsigned long, as does the kernel.
In both cases, signal N+1 is represented as
(1UL << (N % (8 * sizeof (unsigned long)))) in word number
(N / (8 * sizeof (unsigned long))).

Thus the N32 glibc uses an array of 32-bit words and the N64 kernel
uses an array of 64-bit words.  For little-endian, the layout is the
same, with signals 1-32 in the first 4 bytes, signals 33-64 in the
second, etc.; for big-endian, userspace has that layout while in the
kernel each 8 bytes have the two halves swapped from the userspace
layout.

The N32 sigsuspend syscall uses sigset_from_compat to convert the
userspace sigset to kernel format.  If __COMPAT_ENDIAN_SWAP__ is *not*
set, this uses logic of the form

  set->sig[0] = compat->sig[0] | (((long)compat->sig[1]) << 32 )

to convert the userspace sigset to a kernel one.  This looks correct
to me for both big and little endian, given that in userspace
compat->sig[1] will represent signals 33-64, and so will the high 32
bits of set->sig[0] in the kernel.  If however __COMPAT_ENDIAN_SWAP__
*is* set, as it is for __MIPSEL__, it uses

  set->sig[0] = compat->sig[1] | (((long)compat->sig[0]) << 32 );

which seems incorrect for both big and little endian, and would
explain the observed symptoms.

This code is the only use of __COMPAT_ENDIAN_SWAP__, so if incorrect
then that macro serves no purpose, in which case something like the
following patch would seem appropriate to remove it.


Signed-off-by: Joseph Myers <joseph@codesourcery.com>

---

diff -rupN linux-2.6.17-rc6.orig/include/asm-mips/compat.h linux-2.6.17-rc6/include/asm-mips/compat.h
--- linux-2.6.17-rc6.orig/include/asm-mips/compat.h	2006-06-08 01:05:13.000000000 +0000
+++ linux-2.6.17-rc6/include/asm-mips/compat.h	2006-06-08 01:04:10.000000000 +0000
@@ -145,8 +145,5 @@ static inline void __user *compat_alloc_
 
 	return (void __user *) (regs->regs[29] - len);
 }
-#if defined (__MIPSEL__)
-#define __COMPAT_ENDIAN_SWAP__ 	1
-#endif
 
 #endif /* _ASM_COMPAT_H */
diff -rupN linux-2.6.17-rc6.orig/kernel/compat.c linux-2.6.17-rc6/kernel/compat.c
--- linux-2.6.17-rc6.orig/kernel/compat.c	2006-06-08 01:05:13.000000000 +0000
+++ linux-2.6.17-rc6/kernel/compat.c	2006-06-08 01:03:47.000000000 +0000
@@ -729,17 +729,10 @@ void
 sigset_from_compat (sigset_t *set, compat_sigset_t *compat)
 {
 	switch (_NSIG_WORDS) {
-#if defined (__COMPAT_ENDIAN_SWAP__)
-	case 4: set->sig[3] = compat->sig[7] | (((long)compat->sig[6]) << 32 );
-	case 3: set->sig[2] = compat->sig[5] | (((long)compat->sig[4]) << 32 );
-	case 2: set->sig[1] = compat->sig[3] | (((long)compat->sig[2]) << 32 );
-	case 1: set->sig[0] = compat->sig[1] | (((long)compat->sig[0]) << 32 );
-#else
 	case 4: set->sig[3] = compat->sig[6] | (((long)compat->sig[7]) << 32 );
 	case 3: set->sig[2] = compat->sig[4] | (((long)compat->sig[5]) << 32 );
 	case 2: set->sig[1] = compat->sig[2] | (((long)compat->sig[3]) << 32 );
 	case 1: set->sig[0] = compat->sig[0] | (((long)compat->sig[1]) << 32 );
-#endif
 	}
 }
 


-- 
Joseph S. Myers
joseph@codesourcery.com
