Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jun 2007 13:28:43 +0100 (BST)
Received: from wf1.mips-uk.com ([194.74.144.154]:41158 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20027204AbXFGM2k (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 7 Jun 2007 13:28:40 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l57CNiYM020050;
	Thu, 7 Jun 2007 13:23:44 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l57CNiMG020049;
	Thu, 7 Jun 2007 13:23:44 +0100
Date:	Thu, 7 Jun 2007 13:23:44 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: smp_mb() in asm-mips/bitops.h
Message-ID: <20070607122344.GD26047@linux-mips.org>
References: <20070607.165301.63743560.nemoto@toshiba-tops.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070607.165301.63743560.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15326
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jun 07, 2007 at 04:53:01PM +0900, Atsushi Nemoto wrote:

> I found some funny usages of smp_mb() in asm-mips/bitops.h:

Funny indeed ;-)  Below patch should do the trick.

Due to very inagressive memory reordering on the few non-strongly ordered
MIPS SMP systems I am somewhat confident this didn't break anything but
if so, Sibyte and PMC-Sierra RM9000 SMP systems are affected.

  Ralf

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/include/asm-mips/bitops.h b/include/asm-mips/bitops.h
index d995413..ffe245b 100644
--- a/include/asm-mips/bitops.h
+++ b/include/asm-mips/bitops.h
@@ -238,10 +238,11 @@ static inline int test_and_set_bit(unsigned long nr,
 	volatile unsigned long *addr)
 {
 	unsigned short bit = nr & SZLONG_MASK;
+	unsigned long res;
 
 	if (cpu_has_llsc && R10000_LLSC_WAR) {
 		unsigned long *m = ((unsigned long *) addr) + (nr >> SZLONG_LOG);
-		unsigned long temp, res;
+		unsigned long temp;
 
 		__asm__ __volatile__(
 		"	.set	mips3					\n"
@@ -254,11 +255,9 @@ static inline int test_and_set_bit(unsigned long nr,
 		: "=&r" (temp), "=m" (*m), "=&r" (res)
 		: "r" (1UL << bit), "m" (*m)
 		: "memory");
-
-		return res != 0;
 	} else if (cpu_has_llsc) {
 		unsigned long *m = ((unsigned long *) addr) + (nr >> SZLONG_LOG);
-		unsigned long temp, res;
+		unsigned long temp;
 
 		__asm__ __volatile__(
 		"	.set	push					\n"
@@ -277,25 +276,22 @@ static inline int test_and_set_bit(unsigned long nr,
 		: "=&r" (temp), "=m" (*m), "=&r" (res)
 		: "r" (1UL << bit), "m" (*m)
 		: "memory");
-
-		return res != 0;
 	} else {
 		volatile unsigned long *a = addr;
 		unsigned long mask;
-		int retval;
 		unsigned long flags;
 
 		a += nr >> SZLONG_LOG;
 		mask = 1UL << bit;
 		raw_local_irq_save(flags);
-		retval = (mask & *a) != 0;
+		res = (mask & *a);
 		*a |= mask;
 		raw_local_irq_restore(flags);
-
-		return retval;
 	}
 
 	smp_mb();
+
+	return res != 0;
 }
 
 /*
@@ -310,6 +306,7 @@ static inline int test_and_clear_bit(unsigned long nr,
 	volatile unsigned long *addr)
 {
 	unsigned short bit = nr & SZLONG_MASK;
+	unsigned long res;
 
 	if (cpu_has_llsc && R10000_LLSC_WAR) {
 		unsigned long *m = ((unsigned long *) addr) + (nr >> SZLONG_LOG);
@@ -327,12 +324,10 @@ static inline int test_and_clear_bit(unsigned long nr,
 		: "=&r" (temp), "=m" (*m), "=&r" (res)
 		: "r" (1UL << bit), "m" (*m)
 		: "memory");
-
-		return res != 0;
 #ifdef CONFIG_CPU_MIPSR2
 	} else if (__builtin_constant_p(nr)) {
 		unsigned long *m = ((unsigned long *) addr) + (nr >> SZLONG_LOG);
-		unsigned long temp, res;
+		unsigned long temp;
 
 		__asm__ __volatile__(
 		"1:	" __LL	"%0, %1		# test_and_clear_bit	\n"
@@ -346,12 +341,10 @@ static inline int test_and_clear_bit(unsigned long nr,
 		: "=&r" (temp), "=m" (*m), "=&r" (res)
 		: "ri" (bit), "m" (*m)
 		: "memory");
-
-		return res;
 #endif
 	} else if (cpu_has_llsc) {
 		unsigned long *m = ((unsigned long *) addr) + (nr >> SZLONG_LOG);
-		unsigned long temp, res;
+		unsigned long temp;
 
 		__asm__ __volatile__(
 		"	.set	push					\n"
@@ -371,25 +364,22 @@ static inline int test_and_clear_bit(unsigned long nr,
 		: "=&r" (temp), "=m" (*m), "=&r" (res)
 		: "r" (1UL << bit), "m" (*m)
 		: "memory");
-
-		return res != 0;
 	} else {
 		volatile unsigned long *a = addr;
 		unsigned long mask;
-		int retval;
 		unsigned long flags;
 
 		a += nr >> SZLONG_LOG;
 		mask = 1UL << bit;
 		raw_local_irq_save(flags);
-		retval = (mask & *a) != 0;
+		res = (mask & *a);
 		*a &= ~mask;
 		raw_local_irq_restore(flags);
-
-		return retval;
 	}
 
 	smp_mb();
+
+	return res != 0;
 }
 
 /*
@@ -404,10 +394,11 @@ static inline int test_and_change_bit(unsigned long nr,
 	volatile unsigned long *addr)
 {
 	unsigned short bit = nr & SZLONG_MASK;
+	unsigned long res;
 
 	if (cpu_has_llsc && R10000_LLSC_WAR) {
 		unsigned long *m = ((unsigned long *) addr) + (nr >> SZLONG_LOG);
-		unsigned long temp, res;
+		unsigned long temp;
 
 		__asm__ __volatile__(
 		"	.set	mips3					\n"
@@ -420,11 +411,9 @@ static inline int test_and_change_bit(unsigned long nr,
 		: "=&r" (temp), "=m" (*m), "=&r" (res)
 		: "r" (1UL << bit), "m" (*m)
 		: "memory");
-
-		return res != 0;
 	} else if (cpu_has_llsc) {
 		unsigned long *m = ((unsigned long *) addr) + (nr >> SZLONG_LOG);
-		unsigned long temp, res;
+		unsigned long temp;
 
 		__asm__ __volatile__(
 		"	.set	push					\n"
@@ -443,24 +432,22 @@ static inline int test_and_change_bit(unsigned long nr,
 		: "=&r" (temp), "=m" (*m), "=&r" (res)
 		: "r" (1UL << bit), "m" (*m)
 		: "memory");
-
-		return res != 0;
 	} else {
 		volatile unsigned long *a = addr;
-		unsigned long mask, retval;
+		unsigned long mask;
 		unsigned long flags;
 
 		a += nr >> SZLONG_LOG;
 		mask = 1UL << bit;
 		raw_local_irq_save(flags);
-		retval = (mask & *a) != 0;
+		res = (mask & *a);
 		*a ^= mask;
 		raw_local_irq_restore(flags);
-
-		return retval;
 	}
 
 	smp_mb();
+
+	return res != 0;
 }
 
 #include <asm-generic/bitops/non-atomic.h>
