Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Aug 2010 15:42:33 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:32972 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491159Ab0HRNm2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 18 Aug 2010 15:42:28 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id o7IDgRK8026941;
        Wed, 18 Aug 2010 14:42:27 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id o7IDgQoe026939;
        Wed, 18 Aug 2010 14:42:26 +0100
Date:   Wed, 18 Aug 2010 14:42:26 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Sergei Shtylyov <sshtylyov@mvista.com>
Cc:     linux-mips@linux-mips.org,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: MIPS: Get rid of branches to .subsections.
Message-ID: <20100818134226.GB25740@linux-mips.org>
References: <20100818124310.GA23744@linux-mips.org>
 <4C6BDF40.9050804@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4C6BDF40.9050804@mvista.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27635
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

MIPS: Get rid of branches to .subsections.

It was a nice optimization - on paper at least.  In practice it results in
branches that may exceed the maximum legal range for a branch.  We can
fight that problem with -ffunction-sections but -ffunction-sections again
is incompatible with -pg used by the function tracer.

By rewriting the loop around all simple LL/SC blocks to C we reduce reduce
the amount of inline assembler and at the same time allow GCC to often
fill the branch delay slots with something sensible or whatever else clever
optimization it may have up in its sleeve.

With this optimization gone we also no longer need -ffunction-sections,
so drop it.

This optimization was originally introduced in 2.6.21, commit
5999eca25c1fd4b9b9aca7833b04d10fe4bc877d (linux-mips.org) rsp.
f65e4fa8e0c6022ad58dc88d1b11b12589ed7f9f (kernel.org).

Original fix for the issues which caused me to pull this optimization by
Paul Gortmaker <paul.gortmaker@windriver.com>.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
--
v3: Spelling fixes and asm labels that became unused by the changed removed.

 arch/mips/Makefile              |    3 
 arch/mips/include/asm/atomic.h  |  208 ++++++++++++++----------------
 arch/mips/include/asm/bitops.h  |  270 +++++++++++++++++-----------------------
 arch/mips/include/asm/cmpxchg.h |    7 -
 arch/mips/include/asm/system.h  |   52 +++----
 5 files changed, 243 insertions(+), 297 deletions(-)

Index: linux-queue/arch/mips/include/asm/atomic.h
===================================================================
--- linux-queue.orig/arch/mips/include/asm/atomic.h
+++ linux-queue/arch/mips/include/asm/atomic.h
@@ -64,18 +64,16 @@ static __inline__ void atomic_add(int i,
 	} else if (kernel_uses_llsc) {
 		int temp;
 
-		__asm__ __volatile__(
-		"	.set	mips3					\n"
-		"1:	ll	%0, %1		# atomic_add		\n"
-		"	addu	%0, %2					\n"
-		"	sc	%0, %1					\n"
-		"	beqz	%0, 2f					\n"
-		"	.subsection 2					\n"
-		"2:	b	1b					\n"
-		"	.previous					\n"
-		"	.set	mips0					\n"
-		: "=&r" (temp), "=m" (v->counter)
-		: "Ir" (i), "m" (v->counter));
+		do {
+			__asm__ __volatile__(
+			"	.set	mips3				\n"
+			"	ll	%0, %1		# atomic_add	\n"
+			"	addu	%0, %2				\n"
+			"	sc	%0, %1				\n"
+			"	.set	mips0				\n"
+			: "=&r" (temp), "=m" (v->counter)
+			: "Ir" (i), "m" (v->counter));
+		} while (unlikely(!temp));
 	} else {
 		unsigned long flags;
 
@@ -109,18 +107,16 @@ static __inline__ void atomic_sub(int i,
 	} else if (kernel_uses_llsc) {
 		int temp;
 
-		__asm__ __volatile__(
-		"	.set	mips3					\n"
-		"1:	ll	%0, %1		# atomic_sub		\n"
-		"	subu	%0, %2					\n"
-		"	sc	%0, %1					\n"
-		"	beqz	%0, 2f					\n"
-		"	.subsection 2					\n"
-		"2:	b	1b					\n"
-		"	.previous					\n"
-		"	.set	mips0					\n"
-		: "=&r" (temp), "=m" (v->counter)
-		: "Ir" (i), "m" (v->counter));
+		do {
+			__asm__ __volatile__(
+			"	.set	mips3				\n"
+			"	ll	%0, %1		# atomic_sub	\n"
+			"	subu	%0, %2				\n"
+			"	sc	%0, %1				\n"
+			"	.set	mips0				\n"
+			: "=&r" (temp), "=m" (v->counter)
+			: "Ir" (i), "m" (v->counter));
+		} while (unlikely(!temp));
 	} else {
 		unsigned long flags;
 
@@ -156,20 +152,19 @@ static __inline__ int atomic_add_return(
 	} else if (kernel_uses_llsc) {
 		int temp;
 
-		__asm__ __volatile__(
-		"	.set	mips3					\n"
-		"1:	ll	%1, %2		# atomic_add_return	\n"
-		"	addu	%0, %1, %3				\n"
-		"	sc	%0, %2					\n"
-		"	beqz	%0, 2f					\n"
-		"	addu	%0, %1, %3				\n"
-		"	.subsection 2					\n"
-		"2:	b	1b					\n"
-		"	.previous					\n"
-		"	.set	mips0					\n"
-		: "=&r" (result), "=&r" (temp), "=m" (v->counter)
-		: "Ir" (i), "m" (v->counter)
-		: "memory");
+		do {
+			__asm__ __volatile__(
+			"	.set	mips3				\n"
+			"	ll	%1, %2	# atomic_add_return	\n"
+			"	addu	%0, %1, %3			\n"
+			"	sc	%0, %2				\n"
+			"	.set	mips0				\n"
+			: "=&r" (result), "=&r" (temp), "=m" (v->counter)
+			: "Ir" (i), "m" (v->counter)
+			: "memory");
+		} while (unlikely(!result));
+
+		result = temp + i;
 	} else {
 		unsigned long flags;
 
@@ -205,23 +200,24 @@ static __inline__ int atomic_sub_return(
 		: "=&r" (result), "=&r" (temp), "=m" (v->counter)
 		: "Ir" (i), "m" (v->counter)
 		: "memory");
+
+		result = temp - i;
 	} else if (kernel_uses_llsc) {
 		int temp;
 
-		__asm__ __volatile__(
-		"	.set	mips3					\n"
-		"1:	ll	%1, %2		# atomic_sub_return	\n"
-		"	subu	%0, %1, %3				\n"
-		"	sc	%0, %2					\n"
-		"	beqz	%0, 2f					\n"
-		"	subu	%0, %1, %3				\n"
-		"	.subsection 2					\n"
-		"2:	b	1b					\n"
-		"	.previous					\n"
-		"	.set	mips0					\n"
-		: "=&r" (result), "=&r" (temp), "=m" (v->counter)
-		: "Ir" (i), "m" (v->counter)
-		: "memory");
+		do {
+			__asm__ __volatile__(
+			"	.set	mips3				\n"
+			"	ll	%1, %2	# atomic_sub_return	\n"
+			"	subu	%0, %1, %3			\n"
+			"	sc	%0, %2				\n"
+			"	.set	mips0				\n"
+			: "=&r" (result), "=&r" (temp), "=m" (v->counter)
+			: "Ir" (i), "m" (v->counter)
+			: "memory");
+		} while (unlikely(!result));
+
+		result = temp - i;
 	} else {
 		unsigned long flags;
 
@@ -279,12 +275,9 @@ static __inline__ int atomic_sub_if_posi
 		"	bltz	%0, 1f					\n"
 		"	sc	%0, %2					\n"
 		"	.set	noreorder				\n"
-		"	beqz	%0, 2f					\n"
+		"	beqz	%0, 1b					\n"
 		"	 subu	%0, %1, %3				\n"
 		"	.set	reorder					\n"
-		"	.subsection 2					\n"
-		"2:	b	1b					\n"
-		"	.previous					\n"
 		"1:							\n"
 		"	.set	mips0					\n"
 		: "=&r" (result), "=&r" (temp), "=m" (v->counter)
@@ -443,18 +436,16 @@ static __inline__ void atomic64_add(long
 	} else if (kernel_uses_llsc) {
 		long temp;
 
-		__asm__ __volatile__(
-		"	.set	mips3					\n"
-		"1:	lld	%0, %1		# atomic64_add		\n"
-		"	daddu	%0, %2					\n"
-		"	scd	%0, %1					\n"
-		"	beqz	%0, 2f					\n"
-		"	.subsection 2					\n"
-		"2:	b	1b					\n"
-		"	.previous					\n"
-		"	.set	mips0					\n"
-		: "=&r" (temp), "=m" (v->counter)
-		: "Ir" (i), "m" (v->counter));
+		do {
+			__asm__ __volatile__(
+			"	.set	mips3				\n"
+			"	lld	%0, %1		# atomic64_add	\n"
+			"	daddu	%0, %2				\n"
+			"	scd	%0, %1				\n"
+			"	.set	mips0				\n"
+			: "=&r" (temp), "=m" (v->counter)
+			: "Ir" (i), "m" (v->counter));
+		} while (unlikely(!temp));
 	} else {
 		unsigned long flags;
 
@@ -488,18 +479,16 @@ static __inline__ void atomic64_sub(long
 	} else if (kernel_uses_llsc) {
 		long temp;
 
-		__asm__ __volatile__(
-		"	.set	mips3					\n"
-		"1:	lld	%0, %1		# atomic64_sub		\n"
-		"	dsubu	%0, %2					\n"
-		"	scd	%0, %1					\n"
-		"	beqz	%0, 2f					\n"
-		"	.subsection 2					\n"
-		"2:	b	1b					\n"
-		"	.previous					\n"
-		"	.set	mips0					\n"
-		: "=&r" (temp), "=m" (v->counter)
-		: "Ir" (i), "m" (v->counter));
+		do {
+			__asm__ __volatile__(
+			"	.set	mips3				\n"
+			"	lld	%0, %1		# atomic64_sub	\n"
+			"	dsubu	%0, %2				\n"
+			"	scd	%0, %1				\n"
+			"	.set	mips0				\n"
+			: "=&r" (temp), "=m" (v->counter)
+			: "Ir" (i), "m" (v->counter));
+		} while (unlikely(!temp));
 	} else {
 		unsigned long flags;
 
@@ -535,20 +524,19 @@ static __inline__ long atomic64_add_retu
 	} else if (kernel_uses_llsc) {
 		long temp;
 
-		__asm__ __volatile__(
-		"	.set	mips3					\n"
-		"1:	lld	%1, %2		# atomic64_add_return	\n"
-		"	daddu	%0, %1, %3				\n"
-		"	scd	%0, %2					\n"
-		"	beqz	%0, 2f					\n"
-		"	daddu	%0, %1, %3				\n"
-		"	.subsection 2					\n"
-		"2:	b	1b					\n"
-		"	.previous					\n"
-		"	.set	mips0					\n"
-		: "=&r" (result), "=&r" (temp), "=m" (v->counter)
-		: "Ir" (i), "m" (v->counter)
-		: "memory");
+		do {
+			__asm__ __volatile__(
+			"	.set	mips3				\n"
+			"	lld	%1, %2	# atomic64_add_return	\n"
+			"	daddu	%0, %1, %3			\n"
+			"	scd	%0, %2				\n"
+			"	.set	mips0				\n"
+			: "=&r" (result), "=&r" (temp), "=m" (v->counter)
+			: "Ir" (i), "m" (v->counter)
+			: "memory");
+		} while (unlikely(!result));
+
+		result = temp + i;
 	} else {
 		unsigned long flags;
 
@@ -587,20 +575,19 @@ static __inline__ long atomic64_sub_retu
 	} else if (kernel_uses_llsc) {
 		long temp;
 
-		__asm__ __volatile__(
-		"	.set	mips3					\n"
-		"1:	lld	%1, %2		# atomic64_sub_return	\n"
-		"	dsubu	%0, %1, %3				\n"
-		"	scd	%0, %2					\n"
-		"	beqz	%0, 2f					\n"
-		"	dsubu	%0, %1, %3				\n"
-		"	.subsection 2					\n"
-		"2:	b	1b					\n"
-		"	.previous					\n"
-		"	.set	mips0					\n"
-		: "=&r" (result), "=&r" (temp), "=m" (v->counter)
-		: "Ir" (i), "m" (v->counter)
-		: "memory");
+		do {
+			__asm__ __volatile__(
+			"	.set	mips3				\n"
+			"	lld	%1, %2	# atomic64_sub_return	\n"
+			"	dsubu	%0, %1, %3			\n"
+			"	scd	%0, %2				\n"
+			"	.set	mips0				\n"
+			: "=&r" (result), "=&r" (temp), "=m" (v->counter)
+			: "Ir" (i), "m" (v->counter)
+			: "memory");
+		} while (unlikely(!result));
+
+		result = temp - i;
 	} else {
 		unsigned long flags;
 
@@ -658,12 +645,9 @@ static __inline__ long atomic64_sub_if_p
 		"	bltz	%0, 1f					\n"
 		"	scd	%0, %2					\n"
 		"	.set	noreorder				\n"
-		"	beqz	%0, 2f					\n"
+		"	beqz	%0, 1b					\n"
 		"	 dsubu	%0, %1, %3				\n"
 		"	.set	reorder					\n"
-		"	.subsection 2					\n"
-		"2:	b	1b					\n"
-		"	.previous					\n"
 		"1:							\n"
 		"	.set	mips0					\n"
 		: "=&r" (result), "=&r" (temp), "=m" (v->counter)
Index: linux-queue/arch/mips/include/asm/bitops.h
===================================================================
--- linux-queue.orig/arch/mips/include/asm/bitops.h
+++ linux-queue/arch/mips/include/asm/bitops.h
@@ -73,30 +73,26 @@ static inline void set_bit(unsigned long
 		: "ir" (1UL << bit), "m" (*m));
 #ifdef CONFIG_CPU_MIPSR2
 	} else if (kernel_uses_llsc && __builtin_constant_p(bit)) {
-		__asm__ __volatile__(
-		"1:	" __LL "%0, %1			# set_bit	\n"
-		"	" __INS "%0, %4, %2, 1				\n"
-		"	" __SC "%0, %1					\n"
-		"	beqz	%0, 2f					\n"
-		"	.subsection 2					\n"
-		"2:	b	1b					\n"
-		"	.previous					\n"
-		: "=&r" (temp), "=m" (*m)
-		: "ir" (bit), "m" (*m), "r" (~0));
+		do {
+			__asm__ __volatile__(
+			"	" __LL "%0, %1		# set_bit	\n"
+			"	" __INS "%0, %3, %2, 1			\n"
+			"	" __SC "%0, %1				\n"
+			: "=&r" (temp), "+m" (*m)
+			: "ir" (bit), "r" (~0));
+		} while (unlikely(!temp));
 #endif /* CONFIG_CPU_MIPSR2 */
 	} else if (kernel_uses_llsc) {
-		__asm__ __volatile__(
-		"	.set	mips3					\n"
-		"1:	" __LL "%0, %1			# set_bit	\n"
-		"	or	%0, %2					\n"
-		"	" __SC	"%0, %1					\n"
-		"	beqz	%0, 2f					\n"
-		"	.subsection 2					\n"
-		"2:	b	1b					\n"
-		"	.previous					\n"
-		"	.set	mips0					\n"
-		: "=&r" (temp), "=m" (*m)
-		: "ir" (1UL << bit), "m" (*m));
+		do {
+			__asm__ __volatile__(
+			"	.set	mips3				\n"
+			"	" __LL "%0, %1		# set_bit	\n"
+			"	or	%0, %2				\n"
+			"	" __SC	"%0, %1				\n"
+			"	.set	mips0				\n"
+			: "=&r" (temp), "+m" (*m)
+			: "ir" (1UL << bit));
+		} while (unlikely(!temp));
 	} else {
 		volatile unsigned long *a = addr;
 		unsigned long mask;
@@ -134,34 +130,30 @@ static inline void clear_bit(unsigned lo
 		"	" __SC "%0, %1					\n"
 		"	beqzl	%0, 1b					\n"
 		"	.set	mips0					\n"
-		: "=&r" (temp), "=m" (*m)
-		: "ir" (~(1UL << bit)), "m" (*m));
+		: "=&r" (temp), "+m" (*m)
+		: "ir" (~(1UL << bit)));
 #ifdef CONFIG_CPU_MIPSR2
 	} else if (kernel_uses_llsc && __builtin_constant_p(bit)) {
-		__asm__ __volatile__(
-		"1:	" __LL "%0, %1			# clear_bit	\n"
-		"	" __INS "%0, $0, %2, 1				\n"
-		"	" __SC "%0, %1					\n"
-		"	beqz	%0, 2f					\n"
-		"	.subsection 2					\n"
-		"2:	b	1b					\n"
-		"	.previous					\n"
-		: "=&r" (temp), "=m" (*m)
-		: "ir" (bit), "m" (*m));
+		do {
+			__asm__ __volatile__(
+			"	" __LL "%0, %1		# clear_bit	\n"
+			"	" __INS "%0, $0, %2, 1			\n"
+			"	" __SC "%0, %1				\n"
+			: "=&r" (temp), "+m" (*m)
+			: "ir" (bit));
+		} while (unlikely(!temp));
 #endif /* CONFIG_CPU_MIPSR2 */
 	} else if (kernel_uses_llsc) {
-		__asm__ __volatile__(
-		"	.set	mips3					\n"
-		"1:	" __LL "%0, %1			# clear_bit	\n"
-		"	and	%0, %2					\n"
-		"	" __SC "%0, %1					\n"
-		"	beqz	%0, 2f					\n"
-		"	.subsection 2					\n"
-		"2:	b	1b					\n"
-		"	.previous					\n"
-		"	.set	mips0					\n"
-		: "=&r" (temp), "=m" (*m)
-		: "ir" (~(1UL << bit)), "m" (*m));
+		do {
+			__asm__ __volatile__(
+			"	.set	mips3				\n"
+			"	" __LL "%0, %1		# clear_bit	\n"
+			"	and	%0, %2				\n"
+			"	" __SC "%0, %1				\n"
+			"	.set	mips0				\n"
+			: "=&r" (temp), "+m" (*m)
+			: "ir" (~(1UL << bit)));
+		} while (unlikely(!temp));
 	} else {
 		volatile unsigned long *a = addr;
 		unsigned long mask;
@@ -213,24 +205,22 @@ static inline void change_bit(unsigned l
 		"	" __SC	"%0, %1				\n"
 		"	beqzl	%0, 1b				\n"
 		"	.set	mips0				\n"
-		: "=&r" (temp), "=m" (*m)
-		: "ir" (1UL << bit), "m" (*m));
+		: "=&r" (temp), "+m" (*m)
+		: "ir" (1UL << bit));
 	} else if (kernel_uses_llsc) {
 		unsigned long *m = ((unsigned long *) addr) + (nr >> SZLONG_LOG);
 		unsigned long temp;
 
-		__asm__ __volatile__(
-		"	.set	mips3				\n"
-		"1:	" __LL "%0, %1		# change_bit	\n"
-		"	xor	%0, %2				\n"
-		"	" __SC	"%0, %1				\n"
-		"	beqz	%0, 2f				\n"
-		"	.subsection 2				\n"
-		"2:	b	1b				\n"
-		"	.previous				\n"
-		"	.set	mips0				\n"
-		: "=&r" (temp), "=m" (*m)
-		: "ir" (1UL << bit), "m" (*m));
+		do {
+			__asm__ __volatile__(
+			"	.set	mips3				\n"
+			"	" __LL "%0, %1		# change_bit	\n"
+			"	xor	%0, %2				\n"
+			"	" __SC	"%0, %1				\n"
+			"	.set	mips0				\n"
+			: "=&r" (temp), "+m" (*m)
+			: "ir" (1UL << bit));
+		} while (unlikely(!temp));
 	} else {
 		volatile unsigned long *a = addr;
 		unsigned long mask;
@@ -272,30 +262,26 @@ static inline int test_and_set_bit(unsig
 		"	beqzl	%2, 1b					\n"
 		"	and	%2, %0, %3				\n"
 		"	.set	mips0					\n"
-		: "=&r" (temp), "=m" (*m), "=&r" (res)
-		: "r" (1UL << bit), "m" (*m)
+		: "=&r" (temp), "+m" (*m), "=&r" (res)
+		: "r" (1UL << bit)
 		: "memory");
 	} else if (kernel_uses_llsc) {
 		unsigned long *m = ((unsigned long *) addr) + (nr >> SZLONG_LOG);
 		unsigned long temp;
 
-		__asm__ __volatile__(
-		"	.set	push					\n"
-		"	.set	noreorder				\n"
-		"	.set	mips3					\n"
-		"1:	" __LL "%0, %1		# test_and_set_bit	\n"
-		"	or	%2, %0, %3				\n"
-		"	" __SC	"%2, %1					\n"
-		"	beqz	%2, 2f					\n"
-		"	 and	%2, %0, %3				\n"
-		"	.subsection 2					\n"
-		"2:	b	1b					\n"
-		"	 nop						\n"
-		"	.previous					\n"
-		"	.set	pop					\n"
-		: "=&r" (temp), "=m" (*m), "=&r" (res)
-		: "r" (1UL << bit), "m" (*m)
-		: "memory");
+		do {
+			__asm__ __volatile__(
+			"	.set	mips3				\n"
+			"	" __LL "%0, %1	# test_and_set_bit	\n"
+			"	or	%2, %0, %3			\n"
+			"	" __SC	"%2, %1				\n"
+			"	.set	mips0				\n"
+			: "=&r" (temp), "+m" (*m), "=&r" (res)
+			: "r" (1UL << bit)
+			: "memory");
+		} while (unlikely(!res));
+
+		res = temp & (1UL << bit);
 	} else {
 		volatile unsigned long *a = addr;
 		unsigned long mask;
@@ -340,30 +326,26 @@ static inline int test_and_set_bit_lock(
 		"	beqzl	%2, 1b					\n"
 		"	and	%2, %0, %3				\n"
 		"	.set	mips0					\n"
-		: "=&r" (temp), "=m" (*m), "=&r" (res)
-		: "r" (1UL << bit), "m" (*m)
+		: "=&r" (temp), "+m" (*m), "=&r" (res)
+		: "r" (1UL << bit)
 		: "memory");
 	} else if (kernel_uses_llsc) {
 		unsigned long *m = ((unsigned long *) addr) + (nr >> SZLONG_LOG);
 		unsigned long temp;
 
-		__asm__ __volatile__(
-		"	.set	push					\n"
-		"	.set	noreorder				\n"
-		"	.set	mips3					\n"
-		"1:	" __LL "%0, %1		# test_and_set_bit	\n"
-		"	or	%2, %0, %3				\n"
-		"	" __SC	"%2, %1					\n"
-		"	beqz	%2, 2f					\n"
-		"	 and	%2, %0, %3				\n"
-		"	.subsection 2					\n"
-		"2:	b	1b					\n"
-		"	 nop						\n"
-		"	.previous					\n"
-		"	.set	pop					\n"
-		: "=&r" (temp), "=m" (*m), "=&r" (res)
-		: "r" (1UL << bit), "m" (*m)
-		: "memory");
+		do {
+			__asm__ __volatile__(
+			"	.set	mips3				\n"
+			"	" __LL "%0, %1	# test_and_set_bit	\n"
+			"	or	%2, %0, %3			\n"
+			"	" __SC	"%2, %1				\n"
+			"	.set	mips0				\n"
+			: "=&r" (temp), "+m" (*m), "=&r" (res)
+			: "r" (1UL << bit)
+			: "memory");
+		} while (unlikely(!res));
+
+		res = temp & (1UL << bit);
 	} else {
 		volatile unsigned long *a = addr;
 		unsigned long mask;
@@ -410,49 +392,43 @@ static inline int test_and_clear_bit(uns
 		"	beqzl	%2, 1b					\n"
 		"	and	%2, %0, %3				\n"
 		"	.set	mips0					\n"
-		: "=&r" (temp), "=m" (*m), "=&r" (res)
-		: "r" (1UL << bit), "m" (*m)
+		: "=&r" (temp), "+m" (*m), "=&r" (res)
+		: "r" (1UL << bit)
 		: "memory");
 #ifdef CONFIG_CPU_MIPSR2
 	} else if (kernel_uses_llsc && __builtin_constant_p(nr)) {
 		unsigned long *m = ((unsigned long *) addr) + (nr >> SZLONG_LOG);
 		unsigned long temp;
 
-		__asm__ __volatile__(
-		"1:	" __LL	"%0, %1		# test_and_clear_bit	\n"
-		"	" __EXT "%2, %0, %3, 1				\n"
-		"	" __INS	"%0, $0, %3, 1				\n"
-		"	" __SC 	"%0, %1					\n"
-		"	beqz	%0, 2f					\n"
-		"	.subsection 2					\n"
-		"2:	b	1b					\n"
-		"	.previous					\n"
-		: "=&r" (temp), "=m" (*m), "=&r" (res)
-		: "ir" (bit), "m" (*m)
-		: "memory");
+		do {
+			__asm__ __volatile__(
+			"	" __LL	"%0, %1	# test_and_clear_bit	\n"
+			"	" __EXT "%2, %0, %3, 1			\n"
+			"	" __INS	"%0, $0, %3, 1			\n"
+			"	" __SC 	"%0, %1				\n"
+			: "=&r" (temp), "+m" (*m), "=&r" (res)
+			: "ir" (bit)
+			: "memory");
+		} while (unlikely(!temp));
 #endif
 	} else if (kernel_uses_llsc) {
 		unsigned long *m = ((unsigned long *) addr) + (nr >> SZLONG_LOG);
 		unsigned long temp;
 
-		__asm__ __volatile__(
-		"	.set	push					\n"
-		"	.set	noreorder				\n"
-		"	.set	mips3					\n"
-		"1:	" __LL	"%0, %1		# test_and_clear_bit	\n"
-		"	or	%2, %0, %3				\n"
-		"	xor	%2, %3					\n"
-		"	" __SC 	"%2, %1					\n"
-		"	beqz	%2, 2f					\n"
-		"	 and	%2, %0, %3				\n"
-		"	.subsection 2					\n"
-		"2:	b	1b					\n"
-		"	 nop						\n"
-		"	.previous					\n"
-		"	.set	pop					\n"
-		: "=&r" (temp), "=m" (*m), "=&r" (res)
-		: "r" (1UL << bit), "m" (*m)
-		: "memory");
+		do {
+			__asm__ __volatile__(
+			"	.set	mips3				\n"
+			"	" __LL	"%0, %1	# test_and_clear_bit	\n"
+			"	or	%2, %0, %3			\n"
+			"	xor	%2, %3				\n"
+			"	" __SC 	"%2, %1				\n"
+			"	.set	mips0				\n"
+			: "=&r" (temp), "+m" (*m), "=&r" (res)
+			: "r" (1UL << bit)
+			: "memory");
+		} while (unlikely(!res));
+
+		res = temp & (1UL << bit);
 	} else {
 		volatile unsigned long *a = addr;
 		unsigned long mask;
@@ -499,30 +475,26 @@ static inline int test_and_change_bit(un
 		"	beqzl	%2, 1b					\n"
 		"	and	%2, %0, %3				\n"
 		"	.set	mips0					\n"
-		: "=&r" (temp), "=m" (*m), "=&r" (res)
-		: "r" (1UL << bit), "m" (*m)
+		: "=&r" (temp), "+m" (*m), "=&r" (res)
+		: "r" (1UL << bit)
 		: "memory");
 	} else if (kernel_uses_llsc) {
 		unsigned long *m = ((unsigned long *) addr) + (nr >> SZLONG_LOG);
 		unsigned long temp;
 
-		__asm__ __volatile__(
-		"	.set	push					\n"
-		"	.set	noreorder				\n"
-		"	.set	mips3					\n"
-		"1:	" __LL	"%0, %1		# test_and_change_bit	\n"
-		"	xor	%2, %0, %3				\n"
-		"	" __SC	"\t%2, %1				\n"
-		"	beqz	%2, 2f					\n"
-		"	 and	%2, %0, %3				\n"
-		"	.subsection 2					\n"
-		"2:	b	1b					\n"
-		"	 nop						\n"
-		"	.previous					\n"
-		"	.set	pop					\n"
-		: "=&r" (temp), "=m" (*m), "=&r" (res)
-		: "r" (1UL << bit), "m" (*m)
-		: "memory");
+		do {
+			__asm__ __volatile__(
+			"	.set	mips3				\n"
+			"	" __LL	"%0, %1	# test_and_change_bit	\n"
+			"	xor	%2, %0, %3			\n"
+			"	" __SC	"\t%2, %1			\n"
+			"	.set	mips0				\n"
+			: "=&r" (temp), "+m" (*m), "=&r" (res)
+			: "r" (1UL << bit)
+			: "memory");
+		} while (unlikely(!res));
+
+		res = temp & (1UL << bit);
 	} else {
 		volatile unsigned long *a = addr;
 		unsigned long mask;
Index: linux-queue/arch/mips/include/asm/cmpxchg.h
===================================================================
--- linux-queue.orig/arch/mips/include/asm/cmpxchg.h
+++ linux-queue/arch/mips/include/asm/cmpxchg.h
@@ -44,12 +44,9 @@
 		"	move	$1, %z4				\n"	\
 		"	.set	mips3				\n"	\
 		"	" st "	$1, %1				\n"	\
-		"	beqz	$1, 3f				\n"	\
-		"2:						\n"	\
-		"	.subsection 2				\n"	\
-		"3:	b	1b				\n"	\
-		"	.previous				\n"	\
+		"	beqz	$1, 1b				\n"	\
 		"	.set	pop				\n"	\
+		"2:						\n"	\
 		: "=&r" (__ret), "=R" (*m)				\
 		: "R" (*m), "Jr" (old), "Jr" (new)			\
 		: "memory");						\
Index: linux-queue/arch/mips/include/asm/system.h
===================================================================
--- linux-queue.orig/arch/mips/include/asm/system.h
+++ linux-queue/arch/mips/include/asm/system.h
@@ -115,21 +115,19 @@ static inline unsigned long __xchg_u32(v
 	} else if (kernel_uses_llsc) {
 		unsigned long dummy;
 
-		__asm__ __volatile__(
-		"	.set	mips3					\n"
-		"1:	ll	%0, %3			# xchg_u32	\n"
-		"	.set	mips0					\n"
-		"	move	%2, %z4					\n"
-		"	.set	mips3					\n"
-		"	sc	%2, %1					\n"
-		"	beqz	%2, 2f					\n"
-		"	.subsection 2					\n"
-		"2:	b	1b					\n"
-		"	.previous					\n"
-		"	.set	mips0					\n"
-		: "=&r" (retval), "=m" (*m), "=&r" (dummy)
-		: "R" (*m), "Jr" (val)
-		: "memory");
+		do {
+			__asm__ __volatile__(
+			"	.set	mips3				\n"
+			"	ll	%0, %3		# xchg_u32	\n"
+			"	.set	mips0				\n"
+			"	move	%2, %z4				\n"
+			"	.set	mips3				\n"
+			"	sc	%2, %1				\n"
+			"	.set	mips0				\n"
+			: "=&r" (retval), "=m" (*m), "=&r" (dummy)
+			: "R" (*m), "Jr" (val)
+			: "memory");
+		} while (unlikely(!dummy));
 	} else {
 		unsigned long flags;
 
@@ -167,19 +165,17 @@ static inline __u64 __xchg_u64(volatile 
 	} else if (kernel_uses_llsc) {
 		unsigned long dummy;
 
-		__asm__ __volatile__(
-		"	.set	mips3					\n"
-		"1:	lld	%0, %3			# xchg_u64	\n"
-		"	move	%2, %z4					\n"
-		"	scd	%2, %1					\n"
-		"	beqz	%2, 2f					\n"
-		"	.subsection 2					\n"
-		"2:	b	1b					\n"
-		"	.previous					\n"
-		"	.set	mips0					\n"
-		: "=&r" (retval), "=m" (*m), "=&r" (dummy)
-		: "R" (*m), "Jr" (val)
-		: "memory");
+		do {
+			__asm__ __volatile__(
+			"	.set	mips3				\n"
+			"	lld	%0, %3		# xchg_u64	\n"
+			"	move	%2, %z4				\n"
+			"	scd	%2, %1				\n"
+			"	.set	mips0				\n"
+			: "=&r" (retval), "=m" (*m), "=&r" (dummy)
+			: "R" (*m), "Jr" (val)
+			: "memory");
+		} while (unlikely(!dummy));
 	} else {
 		unsigned long flags;
 
Index: linux-queue/arch/mips/Makefile
===================================================================
--- linux-queue.orig/arch/mips/Makefile
+++ linux-queue/arch/mips/Makefile
@@ -48,9 +48,6 @@ ifneq ($(SUBARCH),$(ARCH))
   endif
 endif
 
-ifndef CONFIG_FUNCTION_TRACER
-cflags-y := -ffunction-sections
-endif
 ifdef CONFIG_FUNCTION_GRAPH_TRACER
   ifndef KBUILD_MCOUNT_RA_ADDRESS
     ifeq ($(call cc-option-yn,-mmcount-ra-address), y)
