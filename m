Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Jan 2005 01:04:10 +0000 (GMT)
Received: from nevyn.them.org ([IPv6:::ffff:66.93.172.17]:19338 "EHLO
	nevyn.them.org") by linux-mips.org with ESMTP id <S8225305AbVAUBEF>;
	Fri, 21 Jan 2005 01:04:05 +0000
Received: from drow by nevyn.them.org with local (Exim 4.43 #1 (Debian))
	id 1CrnDX-0002jS-SF
	for <linux-mips@linux-mips.org>; Thu, 20 Jan 2005 20:04:04 -0500
Date:	Thu, 20 Jan 2005 20:04:03 -0500
From:	Daniel Jacobowitz <dan@debian.org>
To:	linux-mips@linux-mips.org
Subject: Fix some (maybe) missing syncs in bitops.h
Message-ID: <20050121010403.GA10371@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Return-Path: <drow@nevyn.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6975
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

If I'm reading the broadcom documentation right, the semantics of set_bit
and test_and_set_bit require a sync at the end on this architecture.

I've been trying to track down a nasty signal delivery bug that I thought
was a TIF_SIGPENDING not being visible on the other CPU early enough.  Turns
out that wasn't the problem, but I still think the syncs are correct, so I'm
posting the patch.

Signed-off-by: Daniel Jacobowitz <dan@codesourcery.com>

Index: linux/include/asm-mips/bitops.h
===================================================================
--- linux.orig/include/asm-mips/bitops.h	2005-01-20 16:31:45.921742674 -0500
+++ linux/include/asm-mips/bitops.h	2005-01-20 19:56:37.420056584 -0500
@@ -34,6 +34,7 @@
 #include <asm/interrupt.h>
 #include <asm/sgidefs.h>
 #include <asm/war.h>
+#include <asm/system.h>
 
 /*
  * clear_bit() doesn't provide any barrier for the compiler.
@@ -76,6 +77,9 @@
 		"	or	%0, %2					\n"
 		"	"__SC	"%0, %1					\n"
 		"	beqzl	%0, 1b					\n"
+#ifdef CONFIG_SMP
+		"sync							\n"
+#endif
 		: "=&r" (temp), "=m" (*m)
 		: "ir" (1UL << (nr & SZLONG_MASK)), "m" (*m));
 	} else if (cpu_has_llsc) {
@@ -84,6 +88,9 @@
 		"	or	%0, %2					\n"
 		"	"__SC	"%0, %1					\n"
 		"	beqz	%0, 1b					\n"
+#ifdef CONFIG_SMP
+		"sync							\n"
+#endif
 		: "=&r" (temp), "=m" (*m)
 		: "ir" (1UL << (nr & SZLONG_MASK)), "m" (*m));
 	} else {
@@ -195,6 +204,9 @@
 		"	xor	%0, %2				\n"
 		"	"__SC	"%0, %1				\n"
 		"	beqzl	%0, 1b				\n"
+#ifdef CONFIG_SMP
+		"sync						\n"
+#endif
 		: "=&r" (temp), "=m" (*m)
 		: "ir" (1UL << (nr & SZLONG_MASK)), "m" (*m));
 	} else if (cpu_has_llsc) {
@@ -206,6 +218,9 @@
 		"	xor	%0, %2				\n"
 		"	"__SC	"%0, %1				\n"
 		"	beqz	%0, 1b				\n"
+#ifdef CONFIG_SMP
+		"sync						\n"
+#endif
 		: "=&r" (temp), "=m" (*m)
 		: "ir" (1UL << (nr & SZLONG_MASK)), "m" (*m));
 	} else {


-- 
Daniel Jacobowitz
