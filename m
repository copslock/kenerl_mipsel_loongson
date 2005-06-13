Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jun 2005 21:40:33 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:7696 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225893AbVFMUkO>; Mon, 13 Jun 2005 21:40:14 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 15B14F598B; Mon, 13 Jun 2005 22:40:04 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 24973-01; Mon, 13 Jun 2005 22:40:03 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 64EC9F5981; Mon, 13 Jun 2005 22:40:03 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j5DKe8dF029537;
	Mon, 13 Jun 2005 22:40:08 +0200
Date:	Mon, 13 Jun 2005 21:40:20 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Fix fallback atomic operations
Message-ID: <Pine.LNX.4.61L.0506132131030.1725@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.85.1/935/Mon Jun 13 18:27:50 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8082
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

Ralf,

 You may argue it's best to define a private copy of "cpu_has_llsc"  
expanding to a constant for selecting the right set of atomic operations 
at the compilation time and I would agree, but AFAIK the whole idea behind 
our current implementation is to provide a snail-speed fallback or perhaps 
to support more generic configurations at one point (e.g. one kernel for 
all DECstations).

 For most processor settings the current setup already works, as they 
provide ll/sc anyway, but not for MIPS I ones, like the R3k.  Here's a 
patch that makes the affected code work for such processors as well.

 OK to apply?

  Maciej

patch-mips-2.6.12-rc4-20050526-atomic-3
diff -up --recursive --new-file linux-mips-2.6.12-rc4-20050526.macro/arch/mips/kernel/semaphore.c linux-mips-2.6.12-rc4-20050526/arch/mips/kernel/semaphore.c
--- linux-mips-2.6.12-rc4-20050526.macro/arch/mips/kernel/semaphore.c	2005-01-15 05:56:03.000000000 +0000
+++ linux-mips-2.6.12-rc4-20050526/arch/mips/kernel/semaphore.c	2005-06-12 18:31:35.000000000 +0000
@@ -42,24 +42,28 @@ static inline int __sem_update_count(str
 
 	if (cpu_has_llsc && R10000_LLSC_WAR) {
 		__asm__ __volatile__(
-		"1:	ll	%0, %2					\n"
+		"	.set	mips2					\n"
+		"1:	ll	%0, %2		# __sem_update_count	\n"
 		"	sra	%1, %0, 31				\n"
 		"	not	%1					\n"
 		"	and	%1, %0, %1				\n"
-		"	add	%1, %1, %3				\n"
+		"	addu	%1, %1, %3				\n"
 		"	sc	%1, %2					\n"
 		"	beqzl	%1, 1b					\n"
+		"	.set	mips0					\n"
 		: "=&r" (old_count), "=&r" (tmp), "=m" (sem->count)
 		: "r" (incr), "m" (sem->count));
 	} else if (cpu_has_llsc) {
 		__asm__ __volatile__(
-		"1:	ll	%0, %2					\n"
+		"	.set	mips2					\n"
+		"1:	ll	%0, %2		# __sem_update_count	\n"	
 		"	sra	%1, %0, 31				\n"
 		"	not	%1					\n"
 		"	and	%1, %0, %1				\n"
-		"	add	%1, %1, %3				\n"
+		"	addu	%1, %1, %3				\n"
 		"	sc	%1, %2					\n"
 		"	beqz	%1, 1b					\n"
+		"	.set	mips0					\n"
 		: "=&r" (old_count), "=&r" (tmp), "=m" (sem->count)
 		: "r" (incr), "m" (sem->count));
 	} else {
diff -up --recursive --new-file linux-mips-2.6.12-rc4-20050526.macro/include/asm-mips/atomic.h linux-mips-2.6.12-rc4-20050526/include/asm-mips/atomic.h
--- linux-mips-2.6.12-rc4-20050526.macro/include/asm-mips/atomic.h	2004-08-20 03:58:10.000000000 +0000
+++ linux-mips-2.6.12-rc4-20050526/include/asm-mips/atomic.h	2005-06-12 18:16:22.000000000 +0000
@@ -62,20 +62,24 @@ static __inline__ void atomic_add(int i,
 		unsigned long temp;
 
 		__asm__ __volatile__(
+		"	.set	mips2					\n"
 		"1:	ll	%0, %1		# atomic_add		\n"
 		"	addu	%0, %2					\n"
 		"	sc	%0, %1					\n"
 		"	beqzl	%0, 1b					\n"
+		"	.set	mips0					\n"
 		: "=&r" (temp), "=m" (v->counter)
 		: "Ir" (i), "m" (v->counter));
 	} else if (cpu_has_llsc) {
 		unsigned long temp;
 
 		__asm__ __volatile__(
+		"	.set	mips2					\n"
 		"1:	ll	%0, %1		# atomic_add		\n"
 		"	addu	%0, %2					\n"
 		"	sc	%0, %1					\n"
 		"	beqz	%0, 1b					\n"
+		"	.set	mips0					\n"
 		: "=&r" (temp), "=m" (v->counter)
 		: "Ir" (i), "m" (v->counter));
 	} else {
@@ -100,20 +104,24 @@ static __inline__ void atomic_sub(int i,
 		unsigned long temp;
 
 		__asm__ __volatile__(
+		"	.set	mips2					\n"
 		"1:	ll	%0, %1		# atomic_sub		\n"
 		"	subu	%0, %2					\n"
 		"	sc	%0, %1					\n"
 		"	beqzl	%0, 1b					\n"
+		"	.set	mips0					\n"
 		: "=&r" (temp), "=m" (v->counter)
 		: "Ir" (i), "m" (v->counter));
 	} else if (cpu_has_llsc) {
 		unsigned long temp;
 
 		__asm__ __volatile__(
+		"	.set	mips2					\n"
 		"1:	ll	%0, %1		# atomic_sub		\n"
 		"	subu	%0, %2					\n"
 		"	sc	%0, %1					\n"
 		"	beqz	%0, 1b					\n"
+		"	.set	mips0					\n"
 		: "=&r" (temp), "=m" (v->counter)
 		: "Ir" (i), "m" (v->counter));
 	} else {
@@ -136,12 +144,14 @@ static __inline__ int atomic_add_return(
 		unsigned long temp;
 
 		__asm__ __volatile__(
+		"	.set	mips2					\n"
 		"1:	ll	%1, %2		# atomic_add_return	\n"
 		"	addu	%0, %1, %3				\n"
 		"	sc	%0, %2					\n"
 		"	beqzl	%0, 1b					\n"
 		"	addu	%0, %1, %3				\n"
 		"	sync						\n"
+		"	.set	mips0					\n"
 		: "=&r" (result), "=&r" (temp), "=m" (v->counter)
 		: "Ir" (i), "m" (v->counter)
 		: "memory");
@@ -149,12 +159,14 @@ static __inline__ int atomic_add_return(
 		unsigned long temp;
 
 		__asm__ __volatile__(
+		"	.set	mips2					\n"
 		"1:	ll	%1, %2		# atomic_add_return	\n"
 		"	addu	%0, %1, %3				\n"
 		"	sc	%0, %2					\n"
 		"	beqz	%0, 1b					\n"
 		"	addu	%0, %1, %3				\n"
 		"	sync						\n"
+		"	.set	mips0					\n"
 		: "=&r" (result), "=&r" (temp), "=m" (v->counter)
 		: "Ir" (i), "m" (v->counter)
 		: "memory");
@@ -179,12 +191,14 @@ static __inline__ int atomic_sub_return(
 		unsigned long temp;
 
 		__asm__ __volatile__(
+		"	.set	mips2					\n"
 		"1:	ll	%1, %2		# atomic_sub_return	\n"
 		"	subu	%0, %1, %3				\n"
 		"	sc	%0, %2					\n"
 		"	beqzl	%0, 1b					\n"
 		"	subu	%0, %1, %3				\n"
 		"	sync						\n"
+		"	.set	mips0					\n"
 		: "=&r" (result), "=&r" (temp), "=m" (v->counter)
 		: "Ir" (i), "m" (v->counter)
 		: "memory");
@@ -192,12 +206,14 @@ static __inline__ int atomic_sub_return(
 		unsigned long temp;
 
 		__asm__ __volatile__(
+		"	.set	mips2					\n"
 		"1:	ll	%1, %2		# atomic_sub_return	\n"
 		"	subu	%0, %1, %3				\n"
 		"	sc	%0, %2					\n"
 		"	beqz	%0, 1b					\n"
 		"	subu	%0, %1, %3				\n"
 		"	sync						\n"
+		"	.set	mips0					\n"
 		: "=&r" (result), "=&r" (temp), "=m" (v->counter)
 		: "Ir" (i), "m" (v->counter)
 		: "memory");
@@ -229,6 +245,7 @@ static __inline__ int atomic_sub_if_posi
 		unsigned long temp;
 
 		__asm__ __volatile__(
+		"	.set	mips2					\n"
 		"1:	ll	%1, %2		# atomic_sub_if_positive\n"
 		"	subu	%0, %1, %3				\n"
 		"	bltz	%0, 1f					\n"
@@ -236,6 +253,7 @@ static __inline__ int atomic_sub_if_posi
 		"	beqzl	%0, 1b					\n"
 		"	sync						\n"
 		"1:							\n"
+		"	.set	mips0					\n"
 		: "=&r" (result), "=&r" (temp), "=m" (v->counter)
 		: "Ir" (i), "m" (v->counter)
 		: "memory");
@@ -243,6 +261,7 @@ static __inline__ int atomic_sub_if_posi
 		unsigned long temp;
 
 		__asm__ __volatile__(
+		"	.set	mips2					\n"
 		"1:	ll	%1, %2		# atomic_sub_if_positive\n"
 		"	subu	%0, %1, %3				\n"
 		"	bltz	%0, 1f					\n"
@@ -250,6 +269,7 @@ static __inline__ int atomic_sub_if_posi
 		"	beqz	%0, 1b					\n"
 		"	sync						\n"
 		"1:							\n"
+		"	.set	mips0					\n"
 		: "=&r" (result), "=&r" (temp), "=m" (v->counter)
 		: "Ir" (i), "m" (v->counter)
 		: "memory");
@@ -367,20 +387,24 @@ static __inline__ void atomic64_add(long
 		unsigned long temp;
 
 		__asm__ __volatile__(
+		"	.set	mips3					\n"
 		"1:	lld	%0, %1		# atomic64_add		\n"
 		"	addu	%0, %2					\n"
 		"	scd	%0, %1					\n"
 		"	beqzl	%0, 1b					\n"
+		"	.set	mips0					\n"
 		: "=&r" (temp), "=m" (v->counter)
 		: "Ir" (i), "m" (v->counter));
 	} else if (cpu_has_llsc) {
 		unsigned long temp;
 
 		__asm__ __volatile__(
+		"	.set	mips3					\n"
 		"1:	lld	%0, %1		# atomic64_add		\n"
 		"	addu	%0, %2					\n"
 		"	scd	%0, %1					\n"
 		"	beqz	%0, 1b					\n"
+		"	.set	mips0					\n"
 		: "=&r" (temp), "=m" (v->counter)
 		: "Ir" (i), "m" (v->counter));
 	} else {
@@ -405,20 +429,24 @@ static __inline__ void atomic64_sub(long
 		unsigned long temp;
 
 		__asm__ __volatile__(
+		"	.set	mips3					\n"
 		"1:	lld	%0, %1		# atomic64_sub		\n"
 		"	subu	%0, %2					\n"
 		"	scd	%0, %1					\n"
 		"	beqzl	%0, 1b					\n"
+		"	.set	mips0					\n"
 		: "=&r" (temp), "=m" (v->counter)
 		: "Ir" (i), "m" (v->counter));
 	} else if (cpu_has_llsc) {
 		unsigned long temp;
 
 		__asm__ __volatile__(
+		"	.set	mips3					\n"
 		"1:	lld	%0, %1		# atomic64_sub		\n"
 		"	subu	%0, %2					\n"
 		"	scd	%0, %1					\n"
 		"	beqz	%0, 1b					\n"
+		"	.set	mips0					\n"
 		: "=&r" (temp), "=m" (v->counter)
 		: "Ir" (i), "m" (v->counter));
 	} else {
@@ -441,12 +469,14 @@ static __inline__ long atomic64_add_retu
 		unsigned long temp;
 
 		__asm__ __volatile__(
+		"	.set	mips3					\n"
 		"1:	lld	%1, %2		# atomic64_add_return	\n"
 		"	addu	%0, %1, %3				\n"
 		"	scd	%0, %2					\n"
 		"	beqzl	%0, 1b					\n"
 		"	addu	%0, %1, %3				\n"
 		"	sync						\n"
+		"	.set	mips0					\n"
 		: "=&r" (result), "=&r" (temp), "=m" (v->counter)
 		: "Ir" (i), "m" (v->counter)
 		: "memory");
@@ -454,12 +484,14 @@ static __inline__ long atomic64_add_retu
 		unsigned long temp;
 
 		__asm__ __volatile__(
+		"	.set	mips3					\n"
 		"1:	lld	%1, %2		# atomic64_add_return	\n"
 		"	addu	%0, %1, %3				\n"
 		"	scd	%0, %2					\n"
 		"	beqz	%0, 1b					\n"
 		"	addu	%0, %1, %3				\n"
 		"	sync						\n"
+		"	.set	mips0					\n"
 		: "=&r" (result), "=&r" (temp), "=m" (v->counter)
 		: "Ir" (i), "m" (v->counter)
 		: "memory");
@@ -484,12 +516,14 @@ static __inline__ long atomic64_sub_retu
 		unsigned long temp;
 
 		__asm__ __volatile__(
+		"	.set	mips3					\n"
 		"1:	lld	%1, %2		# atomic64_sub_return	\n"
 		"	subu	%0, %1, %3				\n"
 		"	scd	%0, %2					\n"
 		"	beqzl	%0, 1b					\n"
 		"	subu	%0, %1, %3				\n"
 		"	sync						\n"
+		"	.set	mips0					\n"
 		: "=&r" (result), "=&r" (temp), "=m" (v->counter)
 		: "Ir" (i), "m" (v->counter)
 		: "memory");
@@ -497,12 +531,14 @@ static __inline__ long atomic64_sub_retu
 		unsigned long temp;
 
 		__asm__ __volatile__(
+		"	.set	mips3					\n"
 		"1:	lld	%1, %2		# atomic64_sub_return	\n"
 		"	subu	%0, %1, %3				\n"
 		"	scd	%0, %2					\n"
 		"	beqz	%0, 1b					\n"
 		"	subu	%0, %1, %3				\n"
 		"	sync						\n"
+		"	.set	mips0					\n"
 		: "=&r" (result), "=&r" (temp), "=m" (v->counter)
 		: "Ir" (i), "m" (v->counter)
 		: "memory");
@@ -534,6 +570,7 @@ static __inline__ long atomic64_sub_if_p
 		unsigned long temp;
 
 		__asm__ __volatile__(
+		"	.set	mips3					\n"
 		"1:	lld	%1, %2		# atomic64_sub_if_positive\n"
 		"	dsubu	%0, %1, %3				\n"
 		"	bltz	%0, 1f					\n"
@@ -541,6 +578,7 @@ static __inline__ long atomic64_sub_if_p
 		"	beqzl	%0, 1b					\n"
 		"	sync						\n"
 		"1:							\n"
+		"	.set	mips0					\n"
 		: "=&r" (result), "=&r" (temp), "=m" (v->counter)
 		: "Ir" (i), "m" (v->counter)
 		: "memory");
@@ -548,6 +586,7 @@ static __inline__ long atomic64_sub_if_p
 		unsigned long temp;
 
 		__asm__ __volatile__(
+		"	.set	mips3					\n"
 		"1:	lld	%1, %2		# atomic64_sub_if_positive\n"
 		"	dsubu	%0, %1, %3				\n"
 		"	bltz	%0, 1f					\n"
@@ -555,6 +594,7 @@ static __inline__ long atomic64_sub_if_p
 		"	beqz	%0, 1b					\n"
 		"	sync						\n"
 		"1:							\n"
+		"	.set	mips0					\n"
 		: "=&r" (result), "=&r" (temp), "=m" (v->counter)
 		: "Ir" (i), "m" (v->counter)
 		: "memory");
diff -up --recursive --new-file linux-mips-2.6.12-rc4-20050526.macro/include/asm-mips/bitops.h linux-mips-2.6.12-rc4-20050526/include/asm-mips/bitops.h
--- linux-mips-2.6.12-rc4-20050526.macro/include/asm-mips/bitops.h	2005-01-09 05:55:44.000000000 +0000
+++ linux-mips-2.6.12-rc4-20050526/include/asm-mips/bitops.h	2005-06-12 18:11:49.000000000 +0000
@@ -18,14 +18,16 @@
 #if (_MIPS_SZLONG == 32)
 #define SZLONG_LOG 5
 #define SZLONG_MASK 31UL
-#define __LL	"ll	"
-#define __SC	"sc	"
+#define __LL		"ll	"
+#define __SC		"sc	"
+#define __SET_MIPS	".set	mips2	"
 #define cpu_to_lelongp(x) cpu_to_le32p((__u32 *) (x)) 
 #elif (_MIPS_SZLONG == 64)
 #define SZLONG_LOG 6
 #define SZLONG_MASK 63UL
-#define __LL	"lld	"
-#define __SC	"scd	"
+#define __LL		"lld	"
+#define __SC		"scd	"
+#define __SET_MIPS	".set	mips3	"
 #define cpu_to_lelongp(x) cpu_to_le64p((__u64 *) (x)) 
 #endif
 
@@ -72,18 +74,22 @@ static inline void set_bit(unsigned long
 
 	if (cpu_has_llsc && R10000_LLSC_WAR) {
 		__asm__ __volatile__(
+		"	" __SET_MIPS "					\n"
 		"1:	" __LL "%0, %1			# set_bit	\n"
 		"	or	%0, %2					\n"
-		"	"__SC	"%0, %1					\n"
+		"	" __SC	"%0, %1					\n"
 		"	beqzl	%0, 1b					\n"
+		"	.set	mips0					\n"
 		: "=&r" (temp), "=m" (*m)
 		: "ir" (1UL << (nr & SZLONG_MASK)), "m" (*m));
 	} else if (cpu_has_llsc) {
 		__asm__ __volatile__(
+		"	" __SET_MIPS "					\n"
 		"1:	" __LL "%0, %1			# set_bit	\n"
 		"	or	%0, %2					\n"
-		"	"__SC	"%0, %1					\n"
+		"	" __SC	"%0, %1					\n"
 		"	beqz	%0, 1b					\n"
+		"	.set	mips0					\n"
 		: "=&r" (temp), "=m" (*m)
 		: "ir" (1UL << (nr & SZLONG_MASK)), "m" (*m));
 	} else {
@@ -132,18 +138,22 @@ static inline void clear_bit(unsigned lo
 
 	if (cpu_has_llsc && R10000_LLSC_WAR) {
 		__asm__ __volatile__(
+		"	" __SET_MIPS "					\n"
 		"1:	" __LL "%0, %1			# clear_bit	\n"
 		"	and	%0, %2					\n"
 		"	" __SC "%0, %1					\n"
 		"	beqzl	%0, 1b					\n"
+		"	.set	mips0					\n"
 		: "=&r" (temp), "=m" (*m)
 		: "ir" (~(1UL << (nr & SZLONG_MASK))), "m" (*m));
 	} else if (cpu_has_llsc) {
 		__asm__ __volatile__(
+		"	" __SET_MIPS "					\n"
 		"1:	" __LL "%0, %1			# clear_bit	\n"
 		"	and	%0, %2					\n"
 		"	" __SC "%0, %1					\n"
 		"	beqz	%0, 1b					\n"
+		"	.set	mips0					\n"
 		: "=&r" (temp), "=m" (*m)
 		: "ir" (~(1UL << (nr & SZLONG_MASK))), "m" (*m));
 	} else {
@@ -191,10 +201,12 @@ static inline void change_bit(unsigned l
 		unsigned long temp;
 
 		__asm__ __volatile__(
+		"	" __SET_MIPS "				\n"
 		"1:	" __LL "%0, %1		# change_bit	\n"
 		"	xor	%0, %2				\n"
-		"	"__SC	"%0, %1				\n"
+		"	" __SC	"%0, %1				\n"
 		"	beqzl	%0, 1b				\n"
+		"	.set	mips0				\n"
 		: "=&r" (temp), "=m" (*m)
 		: "ir" (1UL << (nr & SZLONG_MASK)), "m" (*m));
 	} else if (cpu_has_llsc) {
@@ -202,10 +214,12 @@ static inline void change_bit(unsigned l
 		unsigned long temp;
 
 		__asm__ __volatile__(
+		"	" __SET_MIPS "				\n"
 		"1:	" __LL "%0, %1		# change_bit	\n"
 		"	xor	%0, %2				\n"
-		"	"__SC	"%0, %1				\n"
+		"	" __SC	"%0, %1				\n"
 		"	beqz	%0, 1b				\n"
+		"	.set	mips0				\n"
 		: "=&r" (temp), "=m" (*m)
 		: "ir" (1UL << (nr & SZLONG_MASK)), "m" (*m));
 	} else {
@@ -253,14 +267,16 @@ static inline int test_and_set_bit(unsig
 		unsigned long temp, res;
 
 		__asm__ __volatile__(
+		"	" __SET_MIPS "					\n"
 		"1:	" __LL "%0, %1		# test_and_set_bit	\n"
 		"	or	%2, %0, %3				\n"
 		"	" __SC	"%2, %1					\n"
 		"	beqzl	%2, 1b					\n"
 		"	and	%2, %0, %3				\n"
 #ifdef CONFIG_SMP
-		"sync							\n"
+		"	sync						\n"
 #endif
+		"	.set	mips0					\n"
 		: "=&r" (temp), "=m" (*m), "=&r" (res)
 		: "r" (1UL << (nr & SZLONG_MASK)), "m" (*m)
 		: "memory");
@@ -271,16 +287,18 @@ static inline int test_and_set_bit(unsig
 		unsigned long temp, res;
 
 		__asm__ __volatile__(
-		"	.set	noreorder	# test_and_set_bit	\n"
-		"1:	" __LL "%0, %1					\n"
+		"	.set	push					\n"
+		"	.set	noreorder				\n"
+		"	" __SET_MIPS "					\n"
+		"1:	" __LL "%0, %1		# test_and_set_bit	\n"
 		"	or	%2, %0, %3				\n"
 		"	" __SC	"%2, %1					\n"
 		"	beqz	%2, 1b					\n"
 		"	 and	%2, %0, %3				\n"
 #ifdef CONFIG_SMP
-		"sync							\n"
+		"	sync						\n"
 #endif
-		".set\treorder"
+		"	.set	pop					\n"
 		: "=&r" (temp), "=m" (*m), "=&r" (res)
 		: "r" (1UL << (nr & SZLONG_MASK)), "m" (*m)
 		: "memory");
@@ -343,15 +361,17 @@ static inline int test_and_clear_bit(uns
 		unsigned long temp, res;
 
 		__asm__ __volatile__(
+		"	" __SET_MIPS "					\n"
 		"1:	" __LL	"%0, %1		# test_and_clear_bit	\n"
 		"	or	%2, %0, %3				\n"
 		"	xor	%2, %3					\n"
-			__SC 	"%2, %1					\n"
+		"	" __SC 	"%2, %1					\n"
 		"	beqzl	%2, 1b					\n"
 		"	and	%2, %0, %3				\n"
 #ifdef CONFIG_SMP
 		"	sync						\n"
 #endif
+		"	.set	mips0					\n"
 		: "=&r" (temp), "=m" (*m), "=&r" (res)
 		: "r" (1UL << (nr & SZLONG_MASK)), "m" (*m)
 		: "memory");
@@ -362,17 +382,19 @@ static inline int test_and_clear_bit(uns
 		unsigned long temp, res;
 
 		__asm__ __volatile__(
-		"	.set	noreorder	# test_and_clear_bit	\n"
-		"1:	" __LL	"%0, %1					\n"
+		"	.set	push					\n"
+		"	.set	noreorder				\n"
+		"	" __SET_MIPS "					\n"
+		"1:	" __LL	"%0, %1		# test_and_clear_bit	\n"
 		"	or	%2, %0, %3				\n"
 		"	xor	%2, %3					\n"
-			__SC 	"%2, %1					\n"
+		"	" __SC 	"%2, %1					\n"
 		"	beqz	%2, 1b					\n"
 		"	 and	%2, %0, %3				\n"
 #ifdef CONFIG_SMP
 		"	sync						\n"
 #endif
-		"	.set	reorder					\n"
+		"	.set	pop					\n"
 		: "=&r" (temp), "=m" (*m), "=&r" (res)
 		: "r" (1UL << (nr & SZLONG_MASK)), "m" (*m)
 		: "memory");
@@ -435,14 +457,16 @@ static inline int test_and_change_bit(un
 		unsigned long temp, res;
 
 		__asm__ __volatile__(
-		"1:	" __LL	" %0, %1	# test_and_change_bit	\n"
+		"	" __SET_MIPS "					\n"
+		"1:	" __LL	"%0, %1		# test_and_change_bit	\n"
 		"	xor	%2, %0, %3				\n"
-		"	"__SC	"%2, %1					\n"
+		"	" __SC	"%2, %1					\n"
 		"	beqzl	%2, 1b					\n"
 		"	and	%2, %0, %3				\n"
 #ifdef CONFIG_SMP
 		"	sync						\n"
 #endif
+		"	.set	mips0					\n"
 		: "=&r" (temp), "=m" (*m), "=&r" (res)
 		: "r" (1UL << (nr & SZLONG_MASK)), "m" (*m)
 		: "memory");
@@ -453,16 +477,18 @@ static inline int test_and_change_bit(un
 		unsigned long temp, res;
 
 		__asm__ __volatile__(
-		"	.set	noreorder	# test_and_change_bit	\n"
-		"1:	" __LL	" %0, %1				\n"
+		"	.set	push					\n"
+		"	.set	noreorder				\n"
+		"	" __SET_MIPS "					\n"
+		"1:	" __LL	"%0, %1		# test_and_change_bit	\n"
 		"	xor	%2, %0, %3				\n"
-		"	"__SC	"\t%2, %1				\n"
+		"	" __SC	"\t%2, %1				\n"
 		"	beqz	%2, 1b					\n"
 		"	 and	%2, %0, %3				\n"
 #ifdef CONFIG_SMP
 		"	sync						\n"
 #endif
-		"	.set	reorder					\n"
+		"	.set	pop					\n"
 		: "=&r" (temp), "=m" (*m), "=&r" (res)
 		: "r" (1UL << (nr & SZLONG_MASK)), "m" (*m)
 		: "memory");
diff -up --recursive --new-file linux-mips-2.6.12-rc4-20050526.macro/include/asm-mips/system.h linux-mips-2.6.12-rc4-20050526/include/asm-mips/system.h
--- linux-mips-2.6.12-rc4-20050526.macro/include/asm-mips/system.h	2005-03-19 05:58:17.000000000 +0000
+++ linux-mips-2.6.12-rc4-20050526/include/asm-mips/system.h	2005-06-12 18:08:04.000000000 +0000
@@ -171,6 +171,7 @@ static inline unsigned long __xchg_u32(v
 		unsigned long dummy;
 
 		__asm__ __volatile__(
+		"	.set	mips2					\n"
 		"1:	ll	%0, %3			# xchg_u32	\n"
 		"	move	%2, %z4					\n"
 		"	sc	%2, %1					\n"
@@ -179,6 +180,7 @@ static inline unsigned long __xchg_u32(v
 #ifdef CONFIG_SMP
 		"	sync						\n"
 #endif
+		"	.set	mips0					\n"
 		: "=&r" (retval), "=m" (*m), "=&r" (dummy)
 		: "R" (*m), "Jr" (val)
 		: "memory");
@@ -186,6 +188,7 @@ static inline unsigned long __xchg_u32(v
 		unsigned long dummy;
 
 		__asm__ __volatile__(
+		"	.set	mips2					\n"
 		"1:	ll	%0, %3			# xchg_u32	\n"
 		"	move	%2, %z4					\n"
 		"	sc	%2, %1					\n"
@@ -193,6 +196,7 @@ static inline unsigned long __xchg_u32(v
 #ifdef CONFIG_SMP
 		"	sync						\n"
 #endif
+		"	.set	mips0					\n"
 		: "=&r" (retval), "=m" (*m), "=&r" (dummy)
 		: "R" (*m), "Jr" (val)
 		: "memory");
@@ -217,6 +221,7 @@ static inline __u64 __xchg_u64(volatile 
 		unsigned long dummy;
 
 		__asm__ __volatile__(
+		"	.set	mips3					\n"
 		"1:	lld	%0, %3			# xchg_u64	\n"
 		"	move	%2, %z4					\n"
 		"	scd	%2, %1					\n"
@@ -225,6 +230,7 @@ static inline __u64 __xchg_u64(volatile 
 #ifdef CONFIG_SMP
 		"	sync						\n"
 #endif
+		"	.set	mips0					\n"
 		: "=&r" (retval), "=m" (*m), "=&r" (dummy)
 		: "R" (*m), "Jr" (val)
 		: "memory");
@@ -232,6 +238,7 @@ static inline __u64 __xchg_u64(volatile 
 		unsigned long dummy;
 
 		__asm__ __volatile__(
+		"	.set	mips3					\n"
 		"1:	lld	%0, %3			# xchg_u64	\n"
 		"	move	%2, %z4					\n"
 		"	scd	%2, %1					\n"
@@ -239,6 +246,7 @@ static inline __u64 __xchg_u64(volatile 
 #ifdef CONFIG_SMP
 		"	sync						\n"
 #endif
+		"	.set	mips0					\n"
 		: "=&r" (retval), "=m" (*m), "=&r" (dummy)
 		: "R" (*m), "Jr" (val)
 		: "memory");
@@ -286,7 +294,9 @@ static inline unsigned long __cmpxchg_u3
 
 	if (cpu_has_llsc && R10000_LLSC_WAR) {
 		__asm__ __volatile__(
+		"	.set	push					\n"
 		"	.set	noat					\n"
+		"	.set	mips2					\n"
 		"1:	ll	%0, %2			# __cmpxchg_u32	\n"
 		"	bne	%0, %z3, 2f				\n"
 		"	move	$1, %z4					\n"
@@ -297,13 +307,15 @@ static inline unsigned long __cmpxchg_u3
 		"	sync						\n"
 #endif
 		"2:							\n"
-		"	.set	at					\n"
+		"	.set	pop					\n"
 		: "=&r" (retval), "=m" (*m)
 		: "R" (*m), "Jr" (old), "Jr" (new)
 		: "memory");
 	} else if (cpu_has_llsc) {
 		__asm__ __volatile__(
+		"	.set	push					\n"
 		"	.set	noat					\n"
+		"	.set	mips2					\n"
 		"1:	ll	%0, %2			# __cmpxchg_u32	\n"
 		"	bne	%0, %z3, 2f				\n"
 		"	move	$1, %z4					\n"
@@ -313,7 +325,7 @@ static inline unsigned long __cmpxchg_u3
 		"	sync						\n"
 #endif
 		"2:							\n"
-		"	.set	at					\n"
+		"	.set	pop					\n"
 		: "=&r" (retval), "=m" (*m)
 		: "R" (*m), "Jr" (old), "Jr" (new)
 		: "memory");
@@ -338,7 +350,9 @@ static inline unsigned long __cmpxchg_u6
 
 	if (cpu_has_llsc) {
 		__asm__ __volatile__(
+		"	.set	push					\n"
 		"	.set	noat					\n"
+		"	.set	mips3					\n"
 		"1:	lld	%0, %2			# __cmpxchg_u64	\n"
 		"	bne	%0, %z3, 2f				\n"
 		"	move	$1, %z4					\n"
@@ -349,13 +363,15 @@ static inline unsigned long __cmpxchg_u6
 		"	sync						\n"
 #endif
 		"2:							\n"
-		"	.set	at					\n"
+		"	.set	pop					\n"
 		: "=&r" (retval), "=m" (*m)
 		: "R" (*m), "Jr" (old), "Jr" (new)
 		: "memory");
 	} else if (cpu_has_llsc) {
 		__asm__ __volatile__(
+		"	.set	push					\n"
 		"	.set	noat					\n"
+		"	.set	mips2					\n"
 		"1:	lld	%0, %2			# __cmpxchg_u64	\n"
 		"	bne	%0, %z3, 2f				\n"
 		"	move	$1, %z4					\n"
@@ -365,7 +381,7 @@ static inline unsigned long __cmpxchg_u6
 		"	sync						\n"
 #endif
 		"2:							\n"
-		"	.set	at					\n"
+		"	.set	pop					\n"
 		: "=&r" (retval), "=m" (*m)
 		: "R" (*m), "Jr" (old), "Jr" (new)
 		: "memory");
