Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Dec 2004 07:00:25 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:53578
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8224916AbULAHAS>; Wed, 1 Dec 2004 07:00:18 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1CZOTJ-0005bu-00; Wed, 01 Dec 2004 08:00:17 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1CZOTH-0002wp-00; Wed, 01 Dec 2004 08:00:15 +0100
Date: Wed, 1 Dec 2004 08:00:14 +0100
To: linux-mips@linux-mips.org
Cc: ralf@linux-mips.org
Subject: [PATCH] Improve atomic.h implementation robustness
Message-ID: <20041201070014.GG3225@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6516
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Hello All,

the atomic functions use so far memory references for the inline
assembler to access the semaphore. This can lead to additional
instructions in the ll/sc loop, because newer compilers don't
expand the memory reference any more but leave it to the assembler.

The appended patch uses registers instead, and makes the ll/sc
arguments more explicit. In some cases it will lead also to better
register scheduling because the register isn't bound to an output
any more.


Thiemo


Index: include/asm-mips/atomic.h
===================================================================
RCS file: /home/cvs/linux/include/asm-mips/atomic.h,v
retrieving revision 1.36
diff -u -p -r1.36 atomic.h
--- include/asm-mips/atomic.h	19 Aug 2004 09:54:23 -0000	1.36
+++ include/asm-mips/atomic.h	1 Dec 2004 06:45:27 -0000
@@ -62,22 +62,24 @@ static __inline__ void atomic_add(int i,
 		unsigned long temp;
 
 		__asm__ __volatile__(
-		"1:	ll	%0, %1		# atomic_add		\n"
+		"1:	ll	%0, (%1)	# atomic_add		\n"
 		"	addu	%0, %2					\n"
-		"	sc	%0, %1					\n"
+		"	sc	%0, (%1)				\n"
 		"	beqzl	%0, 1b					\n"
-		: "=&r" (temp), "=m" (v->counter)
-		: "Ir" (i), "m" (v->counter));
+		: "=&r" (temp)
+		: "r" (&v->counter), "Ir" (i)
+		: "memory");
 	} else if (cpu_has_llsc) {
 		unsigned long temp;
 
 		__asm__ __volatile__(
-		"1:	ll	%0, %1		# atomic_add		\n"
+		"1:	ll	%0, (%1)	# atomic_add		\n"
 		"	addu	%0, %2					\n"
-		"	sc	%0, %1					\n"
+		"	sc	%0, (%1)				\n"
 		"	beqz	%0, 1b					\n"
-		: "=&r" (temp), "=m" (v->counter)
-		: "Ir" (i), "m" (v->counter));
+		: "=&r" (temp)
+		: "r" (&v->counter), "Ir" (i)
+		: "memory");
 	} else {
 		unsigned long flags;
 
@@ -100,22 +102,24 @@ static __inline__ void atomic_sub(int i,
 		unsigned long temp;
 
 		__asm__ __volatile__(
-		"1:	ll	%0, %1		# atomic_sub		\n"
+		"1:	ll	%0, (%1)	# atomic_sub		\n"
 		"	subu	%0, %2					\n"
-		"	sc	%0, %1					\n"
+		"	sc	%0, (%1)				\n"
 		"	beqzl	%0, 1b					\n"
-		: "=&r" (temp), "=m" (v->counter)
-		: "Ir" (i), "m" (v->counter));
+		: "=&r" (temp)
+		: "r" (&v->counter), "Ir" (i)
+		: "memory");
 	} else if (cpu_has_llsc) {
 		unsigned long temp;
 
 		__asm__ __volatile__(
-		"1:	ll	%0, %1		# atomic_sub		\n"
+		"1:	ll	%0, (%1)	# atomic_sub		\n"
 		"	subu	%0, %2					\n"
-		"	sc	%0, %1					\n"
+		"	sc	%0, (%1)				\n"
 		"	beqz	%0, 1b					\n"
-		: "=&r" (temp), "=m" (v->counter)
-		: "Ir" (i), "m" (v->counter));
+		: "=&r" (temp)
+		: "r" (&v->counter), "Ir" (i)
+		: "memory");
 	} else {
 		unsigned long flags;
 
@@ -136,27 +140,27 @@ static __inline__ int atomic_add_return(
 		unsigned long temp;
 
 		__asm__ __volatile__(
-		"1:	ll	%1, %2		# atomic_add_return	\n"
+		"1:	ll	%1, (%2)	# atomic_add_return	\n"
 		"	addu	%0, %1, %3				\n"
-		"	sc	%0, %2					\n"
+		"	sc	%0, (%2)				\n"
 		"	beqzl	%0, 1b					\n"
 		"	addu	%0, %1, %3				\n"
 		"	sync						\n"
-		: "=&r" (result), "=&r" (temp), "=m" (v->counter)
-		: "Ir" (i), "m" (v->counter)
+		: "=&r" (result), "=&r" (temp)
+		: "r" (&v->counter), "Ir" (i)
 		: "memory");
 	} else if (cpu_has_llsc) {
 		unsigned long temp;
 
 		__asm__ __volatile__(
-		"1:	ll	%1, %2		# atomic_add_return	\n"
+		"1:	ll	%1, (%2)	# atomic_add_return	\n"
 		"	addu	%0, %1, %3				\n"
-		"	sc	%0, %2					\n"
+		"	sc	%0, (%2)				\n"
 		"	beqz	%0, 1b					\n"
 		"	addu	%0, %1, %3				\n"
 		"	sync						\n"
-		: "=&r" (result), "=&r" (temp), "=m" (v->counter)
-		: "Ir" (i), "m" (v->counter)
+		: "=&r" (result), "=&r" (temp)
+		: "r" (&v->counter), "Ir" (i)
 		: "memory");
 	} else {
 		unsigned long flags;
@@ -179,27 +183,27 @@ static __inline__ int atomic_sub_return(
 		unsigned long temp;
 
 		__asm__ __volatile__(
-		"1:	ll	%1, %2		# atomic_sub_return	\n"
+		"1:	ll	%1, (%2)	# atomic_sub_return	\n"
 		"	subu	%0, %1, %3				\n"
-		"	sc	%0, %2					\n"
+		"	sc	%0, (%2)				\n"
 		"	beqzl	%0, 1b					\n"
 		"	subu	%0, %1, %3				\n"
 		"	sync						\n"
-		: "=&r" (result), "=&r" (temp), "=m" (v->counter)
-		: "Ir" (i), "m" (v->counter)
+		: "=&r" (result), "=&r" (temp)
+		: "r" (&v->counter), "Ir" (i)
 		: "memory");
 	} else if (cpu_has_llsc) {
 		unsigned long temp;
 
 		__asm__ __volatile__(
-		"1:	ll	%1, %2		# atomic_sub_return	\n"
+		"1:	ll	%1, (%2)	# atomic_sub_return	\n"
 		"	subu	%0, %1, %3				\n"
-		"	sc	%0, %2					\n"
+		"	sc	%0, (%2)				\n"
 		"	beqz	%0, 1b					\n"
 		"	subu	%0, %1, %3				\n"
 		"	sync						\n"
-		: "=&r" (result), "=&r" (temp), "=m" (v->counter)
-		: "Ir" (i), "m" (v->counter)
+		: "=&r" (result), "=&r" (temp)
+		: "r" (&v->counter), "Ir" (i)
 		: "memory");
 	} else {
 		unsigned long flags;
@@ -229,29 +233,29 @@ static __inline__ int atomic_sub_if_posi
 		unsigned long temp;
 
 		__asm__ __volatile__(
-		"1:	ll	%1, %2		# atomic_sub_if_positive\n"
+		"1:	ll	%1, (%2)	# atomic_sub_if_positive\n"
 		"	subu	%0, %1, %3				\n"
 		"	bltz	%0, 1f					\n"
-		"	sc	%0, %2					\n"
+		"	sc	%0, (%2)				\n"
 		"	beqzl	%0, 1b					\n"
 		"	sync						\n"
 		"1:							\n"
-		: "=&r" (result), "=&r" (temp), "=m" (v->counter)
-		: "Ir" (i), "m" (v->counter)
+		: "=&r" (result), "=&r" (temp)
+		: "r" (&v->counter), "Ir" (i)
 		: "memory");
 	} else if (cpu_has_llsc) {
 		unsigned long temp;
 
 		__asm__ __volatile__(
-		"1:	ll	%1, %2		# atomic_sub_if_positive\n"
+		"1:	ll	%1, (%2)	# atomic_sub_if_positive\n"
 		"	subu	%0, %1, %3				\n"
 		"	bltz	%0, 1f					\n"
-		"	sc	%0, %2					\n"
+		"	sc	%0, (%2)				\n"
 		"	beqz	%0, 1b					\n"
 		"	sync						\n"
 		"1:							\n"
-		: "=&r" (result), "=&r" (temp), "=m" (v->counter)
-		: "Ir" (i), "m" (v->counter)
+		: "=&r" (result), "=&r" (temp)
+		: "r" (&v->counter), "Ir" (i)
 		: "memory");
 	} else {
 		unsigned long flags;
@@ -367,22 +371,24 @@ static __inline__ void atomic64_add(long
 		unsigned long temp;
 
 		__asm__ __volatile__(
-		"1:	lld	%0, %1		# atomic64_add		\n"
+		"1:	lld	%0, (%1)	# atomic64_add		\n"
 		"	addu	%0, %2					\n"
-		"	scd	%0, %1					\n"
+		"	scd	%0, (%1)				\n"
 		"	beqzl	%0, 1b					\n"
-		: "=&r" (temp), "=m" (v->counter)
-		: "Ir" (i), "m" (v->counter));
+		: "=&r" (temp)
+		: "r" (&v->counter), "Ir" (i)
+		: "memory");
 	} else if (cpu_has_llsc) {
 		unsigned long temp;
 
 		__asm__ __volatile__(
-		"1:	lld	%0, %1		# atomic64_add		\n"
+		"1:	lld	%0, (%1)	# atomic64_add		\n"
 		"	addu	%0, %2					\n"
-		"	scd	%0, %1					\n"
+		"	scd	%0, (%1)				\n"
 		"	beqz	%0, 1b					\n"
-		: "=&r" (temp), "=m" (v->counter)
-		: "Ir" (i), "m" (v->counter));
+		: "=&r" (temp)
+		: "r" (&v->counter), "Ir" (i)
+		: "memory");
 	} else {
 		unsigned long flags;
 
@@ -405,22 +411,24 @@ static __inline__ void atomic64_sub(long
 		unsigned long temp;
 
 		__asm__ __volatile__(
-		"1:	lld	%0, %1		# atomic64_sub		\n"
+		"1:	lld	%0, (%1)	# atomic64_sub		\n"
 		"	subu	%0, %2					\n"
-		"	scd	%0, %1					\n"
+		"	scd	%0, (%1)				\n"
 		"	beqzl	%0, 1b					\n"
-		: "=&r" (temp), "=m" (v->counter)
-		: "Ir" (i), "m" (v->counter));
+		: "=&r" (temp)
+		: "r" (&v->counter), "Ir" (i)
+		: "memory");
 	} else if (cpu_has_llsc) {
 		unsigned long temp;
 
 		__asm__ __volatile__(
-		"1:	lld	%0, %1		# atomic64_sub		\n"
+		"1:	lld	%0, (%1)	# atomic64_sub		\n"
 		"	subu	%0, %2					\n"
-		"	scd	%0, %1					\n"
+		"	scd	%0, (%1)				\n"
 		"	beqz	%0, 1b					\n"
-		: "=&r" (temp), "=m" (v->counter)
-		: "Ir" (i), "m" (v->counter));
+		: "=&r" (temp)
+		: "r" (&v->counter), "Ir" (i)
+		: "memory");
 	} else {
 		unsigned long flags;
 
@@ -441,27 +449,27 @@ static __inline__ long atomic64_add_retu
 		unsigned long temp;
 
 		__asm__ __volatile__(
-		"1:	lld	%1, %2		# atomic64_add_return	\n"
+		"1:	lld	%1, (%2)	# atomic64_add_return	\n"
 		"	addu	%0, %1, %3				\n"
-		"	scd	%0, %2					\n"
+		"	scd	%0, (%2)				\n"
 		"	beqzl	%0, 1b					\n"
 		"	addu	%0, %1, %3				\n"
 		"	sync						\n"
-		: "=&r" (result), "=&r" (temp), "=m" (v->counter)
-		: "Ir" (i), "m" (v->counter)
+		: "=&r" (result), "=&r" (temp)
+		: "r" (&v->counter), "Ir" (i)
 		: "memory");
 	} else if (cpu_has_llsc) {
 		unsigned long temp;
 
 		__asm__ __volatile__(
-		"1:	lld	%1, %2		# atomic64_add_return	\n"
+		"1:	lld	%1, (%2)	# atomic64_add_return	\n"
 		"	addu	%0, %1, %3				\n"
-		"	scd	%0, %2					\n"
+		"	scd	%0, (%2)				\n"
 		"	beqz	%0, 1b					\n"
 		"	addu	%0, %1, %3				\n"
 		"	sync						\n"
-		: "=&r" (result), "=&r" (temp), "=m" (v->counter)
-		: "Ir" (i), "m" (v->counter)
+		: "=&r" (result), "=&r" (temp)
+		: "r" (&v->counter), "Ir" (i)
 		: "memory");
 	} else {
 		unsigned long flags;
@@ -484,27 +492,27 @@ static __inline__ long atomic64_sub_retu
 		unsigned long temp;
 
 		__asm__ __volatile__(
-		"1:	lld	%1, %2		# atomic64_sub_return	\n"
+		"1:	lld	%1, (%2)	# atomic64_sub_return	\n"
 		"	subu	%0, %1, %3				\n"
-		"	scd	%0, %2					\n"
+		"	scd	%0, (%2)				\n"
 		"	beqzl	%0, 1b					\n"
 		"	subu	%0, %1, %3				\n"
 		"	sync						\n"
-		: "=&r" (result), "=&r" (temp), "=m" (v->counter)
-		: "Ir" (i), "m" (v->counter)
+		: "=&r" (result), "=&r" (temp)
+		: "r" (&v->counter), "Ir" (i)
 		: "memory");
 	} else if (cpu_has_llsc) {
 		unsigned long temp;
 
 		__asm__ __volatile__(
-		"1:	lld	%1, %2		# atomic64_sub_return	\n"
+		"1:	lld	%1, (%2)	# atomic64_sub_return	\n"
 		"	subu	%0, %1, %3				\n"
-		"	scd	%0, %2					\n"
+		"	scd	%0, (%2)				\n"
 		"	beqz	%0, 1b					\n"
 		"	subu	%0, %1, %3				\n"
 		"	sync						\n"
-		: "=&r" (result), "=&r" (temp), "=m" (v->counter)
-		: "Ir" (i), "m" (v->counter)
+		: "=&r" (result), "=&r" (temp)
+		: "r" (&v->counter), "Ir" (i)
 		: "memory");
 	} else {
 		unsigned long flags;
@@ -534,29 +542,29 @@ static __inline__ long atomic64_sub_if_p
 		unsigned long temp;
 
 		__asm__ __volatile__(
-		"1:	lld	%1, %2		# atomic64_sub_if_positive\n"
+		"1:	lld	%1, (%2)	# atomic64_sub_if_positive\n"
 		"	dsubu	%0, %1, %3				\n"
 		"	bltz	%0, 1f					\n"
-		"	scd	%0, %2					\n"
+		"	scd	%0, (%2)				\n"
 		"	beqzl	%0, 1b					\n"
 		"	sync						\n"
 		"1:							\n"
-		: "=&r" (result), "=&r" (temp), "=m" (v->counter)
-		: "Ir" (i), "m" (v->counter)
+		: "=&r" (result), "=&r" (temp)
+		: "r" (&v->counter), "Ir" (i)
 		: "memory");
 	} else if (cpu_has_llsc) {
 		unsigned long temp;
 
 		__asm__ __volatile__(
-		"1:	lld	%1, %2		# atomic64_sub_if_positive\n"
+		"1:	lld	%1, (%2)	# atomic64_sub_if_positive\n"
 		"	dsubu	%0, %1, %3				\n"
 		"	bltz	%0, 1f					\n"
-		"	scd	%0, %2					\n"
+		"	scd	%0, (%2)				\n"
 		"	beqz	%0, 1b					\n"
 		"	sync						\n"
 		"1:							\n"
-		: "=&r" (result), "=&r" (temp), "=m" (v->counter)
-		: "Ir" (i), "m" (v->counter)
+		: "=&r" (result), "=&r" (temp)
+		: "r" (&v->counter), "Ir" (i)
 		: "memory");
 	} else {
 		unsigned long flags;
