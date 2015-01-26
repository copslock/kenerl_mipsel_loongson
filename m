Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Jan 2015 14:39:15 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:1778 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011318AbbAZNjMyK5qI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 26 Jan 2015 14:39:12 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 8BCCB5C7E9B82;
        Mon, 26 Jan 2015 13:39:03 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 26 Jan 2015 13:39:05 +0000
Received: from mchandras-linux.le.imgtec.org (192.168.154.96) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Mon, 26 Jan 2015 13:39:04 +0000
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: [PATCH] MIPS: asm: Rename GCC_OFF12_ASM to GCC_OFF_SMALL_ASM
Date:   Mon, 26 Jan 2015 13:39:00 +0000
Message-ID: <1422279540-29024-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.2.2
In-Reply-To: <1421405389-15512-20-git-send-email-markos.chandras@imgtec.com>
References: <1421405389-15512-20-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.96]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45485
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

The GCC_OFF12_ASM macro is used for 12-bit immediate constrains
but we will also use it for 9-bit constrains on MIPS R6 so we
rename it to something more appropriate.

Cc: Maciej W. Rozycki <macro@linux-mips.org>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
This patch will be part of MIPS R6 and it will be placed before
the following one
[PATCH RFC v2 19/70] MIPS: Use the new "ZC" constraint for MIPS R6
http://www.linux-mips.org/archives/linux-mips/2015-01/msg00211.html
---
 arch/mips/include/asm/atomic.h                     | 30 +++++++-------
 arch/mips/include/asm/bitops.h                     | 34 +++++++--------
 arch/mips/include/asm/cmpxchg.h                    | 24 +++++------
 arch/mips/include/asm/compiler.h                   |  4 +-
 arch/mips/include/asm/edac.h                       |  4 +-
 arch/mips/include/asm/futex.h                      | 16 ++++----
 .../include/asm/mach-pmcs-msp71xx/msp_regops.h     | 24 +++++------
 arch/mips/include/asm/octeon/cvmx-cmd-queue.h      |  2 +-
 arch/mips/include/asm/spinlock.h                   | 48 +++++++++++-----------
 9 files changed, 93 insertions(+), 93 deletions(-)

diff --git a/arch/mips/include/asm/atomic.h b/arch/mips/include/asm/atomic.h
index 857da84cfc92..3a44c2f17e53 100644
--- a/arch/mips/include/asm/atomic.h
+++ b/arch/mips/include/asm/atomic.h
@@ -54,7 +54,7 @@ static __inline__ void atomic_##op(int i, atomic_t * v)			      \
 		"	sc	%0, %1					\n"   \
 		"	beqzl	%0, 1b					\n"   \
 		"	.set	mips0					\n"   \
-		: "=&r" (temp), "+" GCC_OFF12_ASM() (v->counter)	      \
+		: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (v->counter)	      \
 		: "Ir" (i));						      \
 	} else if (kernel_uses_llsc) {					      \
 		int temp;						      \
@@ -66,7 +66,7 @@ static __inline__ void atomic_##op(int i, atomic_t * v)			      \
 			"	" #asm_op " %0, %2			\n"   \
 			"	sc	%0, %1				\n"   \
 			"	.set	mips0				\n"   \
-			: "=&r" (temp), "+" GCC_OFF12_ASM() (v->counter)      \
+			: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (v->counter)      \
 			: "Ir" (i));					      \
 		} while (unlikely(!temp));				      \
 	} else {							      \
@@ -97,7 +97,7 @@ static __inline__ int atomic_##op##_return(int i, atomic_t * v)		      \
 		"	" #asm_op " %0, %1, %3				\n"   \
 		"	.set	mips0					\n"   \
 		: "=&r" (result), "=&r" (temp),				      \
-		  "+" GCC_OFF12_ASM() (v->counter)			      \
+		  "+" GCC_OFF_SMALL_ASM() (v->counter)			      \
 		: "Ir" (i));						      \
 	} else if (kernel_uses_llsc) {					      \
 		int temp;						      \
@@ -110,7 +110,7 @@ static __inline__ int atomic_##op##_return(int i, atomic_t * v)		      \
 			"	sc	%0, %2				\n"   \
 			"	.set	mips0				\n"   \
 			: "=&r" (result), "=&r" (temp),			      \
-			  "+" GCC_OFF12_ASM() (v->counter)		      \
+			  "+" GCC_OFF_SMALL_ASM() (v->counter)		      \
 			: "Ir" (i));					      \
 		} while (unlikely(!result));				      \
 									      \
@@ -171,8 +171,8 @@ static __inline__ int atomic_sub_if_positive(int i, atomic_t * v)
 		"1:							\n"
 		"	.set	mips0					\n"
 		: "=&r" (result), "=&r" (temp),
-		  "+" GCC_OFF12_ASM() (v->counter)
-		: "Ir" (i), GCC_OFF12_ASM() (v->counter)
+		  "+" GCC_OFF_SMALL_ASM() (v->counter)
+		: "Ir" (i), GCC_OFF_SMALL_ASM() (v->counter)
 		: "memory");
 	} else if (kernel_uses_llsc) {
 		int temp;
@@ -190,7 +190,7 @@ static __inline__ int atomic_sub_if_positive(int i, atomic_t * v)
 		"1:							\n"
 		"	.set	mips0					\n"
 		: "=&r" (result), "=&r" (temp),
-		  "+" GCC_OFF12_ASM() (v->counter)
+		  "+" GCC_OFF_SMALL_ASM() (v->counter)
 		: "Ir" (i));
 	} else {
 		unsigned long flags;
@@ -333,7 +333,7 @@ static __inline__ void atomic64_##op(long i, atomic64_t * v)		      \
 		"	scd	%0, %1					\n"   \
 		"	beqzl	%0, 1b					\n"   \
 		"	.set	mips0					\n"   \
-		: "=&r" (temp), "+" GCC_OFF12_ASM() (v->counter)	      \
+		: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (v->counter)	      \
 		: "Ir" (i));						      \
 	} else if (kernel_uses_llsc) {					      \
 		long temp;						      \
@@ -345,7 +345,7 @@ static __inline__ void atomic64_##op(long i, atomic64_t * v)		      \
 			"	" #asm_op " %0, %2			\n"   \
 			"	scd	%0, %1				\n"   \
 			"	.set	mips0				\n"   \
-			: "=&r" (temp), "+" GCC_OFF12_ASM() (v->counter)      \
+			: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (v->counter)      \
 			: "Ir" (i));					      \
 		} while (unlikely(!temp));				      \
 	} else {							      \
@@ -376,7 +376,7 @@ static __inline__ long atomic64_##op##_return(long i, atomic64_t * v)	      \
 		"	" #asm_op " %0, %1, %3				\n"   \
 		"	.set	mips0					\n"   \
 		: "=&r" (result), "=&r" (temp),				      \
-		  "+" GCC_OFF12_ASM() (v->counter)			      \
+		  "+" GCC_OFF_SMALL_ASM() (v->counter)			      \
 		: "Ir" (i));						      \
 	} else if (kernel_uses_llsc) {					      \
 		long temp;						      \
@@ -389,8 +389,8 @@ static __inline__ long atomic64_##op##_return(long i, atomic64_t * v)	      \
 			"	scd	%0, %2				\n"   \
 			"	.set	mips0				\n"   \
 			: "=&r" (result), "=&r" (temp),			      \
-			  "=" GCC_OFF12_ASM() (v->counter)		      \
-			: "Ir" (i), GCC_OFF12_ASM() (v->counter)	      \
+			  "=" GCC_OFF_SMALL_ASM() (v->counter)		      \
+			: "Ir" (i), GCC_OFF_SMALL_ASM() (v->counter)	      \
 			: "memory");					      \
 		} while (unlikely(!result));				      \
 									      \
@@ -452,8 +452,8 @@ static __inline__ long atomic64_sub_if_positive(long i, atomic64_t * v)
 		"1:							\n"
 		"	.set	mips0					\n"
 		: "=&r" (result), "=&r" (temp),
-		  "=" GCC_OFF12_ASM() (v->counter)
-		: "Ir" (i), GCC_OFF12_ASM() (v->counter)
+		  "=" GCC_OFF_SMALL_ASM() (v->counter)
+		: "Ir" (i), GCC_OFF_SMALL_ASM() (v->counter)
 		: "memory");
 	} else if (kernel_uses_llsc) {
 		long temp;
@@ -471,7 +471,7 @@ static __inline__ long atomic64_sub_if_positive(long i, atomic64_t * v)
 		"1:							\n"
 		"	.set	mips0					\n"
 		: "=&r" (result), "=&r" (temp),
-		  "+" GCC_OFF12_ASM() (v->counter)
+		  "+" GCC_OFF_SMALL_ASM() (v->counter)
 		: "Ir" (i));
 	} else {
 		unsigned long flags;
diff --git a/arch/mips/include/asm/bitops.h b/arch/mips/include/asm/bitops.h
index 6663bcca9d0c..6cc1f539c79a 100644
--- a/arch/mips/include/asm/bitops.h
+++ b/arch/mips/include/asm/bitops.h
@@ -79,8 +79,8 @@ static inline void set_bit(unsigned long nr, volatile unsigned long *addr)
 		"	" __SC	"%0, %1					\n"
 		"	beqzl	%0, 1b					\n"
 		"	.set	mips0					\n"
-		: "=&r" (temp), "=" GCC_OFF12_ASM() (*m)
-		: "ir" (1UL << bit), GCC_OFF12_ASM() (*m));
+		: "=&r" (temp), "=" GCC_OFF_SMALL_ASM() (*m)
+		: "ir" (1UL << bit), GCC_OFF_SMALL_ASM() (*m));
 #ifdef CONFIG_CPU_MIPSR2
 	} else if (kernel_uses_llsc && __builtin_constant_p(bit)) {
 		do {
@@ -88,7 +88,7 @@ static inline void set_bit(unsigned long nr, volatile unsigned long *addr)
 			"	" __LL "%0, %1		# set_bit	\n"
 			"	" __INS "%0, %3, %2, 1			\n"
 			"	" __SC "%0, %1				\n"
-			: "=&r" (temp), "+" GCC_OFF12_ASM() (*m)
+			: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (*m)
 			: "ir" (bit), "r" (~0));
 		} while (unlikely(!temp));
 #endif /* CONFIG_CPU_MIPSR2 */
@@ -100,7 +100,7 @@ static inline void set_bit(unsigned long nr, volatile unsigned long *addr)
 			"	or	%0, %2				\n"
 			"	" __SC	"%0, %1				\n"
 			"	.set	mips0				\n"
-			: "=&r" (temp), "+" GCC_OFF12_ASM() (*m)
+			: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (*m)
 			: "ir" (1UL << bit));
 		} while (unlikely(!temp));
 	} else
@@ -131,7 +131,7 @@ static inline void clear_bit(unsigned long nr, volatile unsigned long *addr)
 		"	" __SC "%0, %1					\n"
 		"	beqzl	%0, 1b					\n"
 		"	.set	mips0					\n"
-		: "=&r" (temp), "+" GCC_OFF12_ASM() (*m)
+		: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (*m)
 		: "ir" (~(1UL << bit)));
 #ifdef CONFIG_CPU_MIPSR2
 	} else if (kernel_uses_llsc && __builtin_constant_p(bit)) {
@@ -140,7 +140,7 @@ static inline void clear_bit(unsigned long nr, volatile unsigned long *addr)
 			"	" __LL "%0, %1		# clear_bit	\n"
 			"	" __INS "%0, $0, %2, 1			\n"
 			"	" __SC "%0, %1				\n"
-			: "=&r" (temp), "+" GCC_OFF12_ASM() (*m)
+			: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (*m)
 			: "ir" (bit));
 		} while (unlikely(!temp));
 #endif /* CONFIG_CPU_MIPSR2 */
@@ -152,7 +152,7 @@ static inline void clear_bit(unsigned long nr, volatile unsigned long *addr)
 			"	and	%0, %2				\n"
 			"	" __SC "%0, %1				\n"
 			"	.set	mips0				\n"
-			: "=&r" (temp), "+" GCC_OFF12_ASM() (*m)
+			: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (*m)
 			: "ir" (~(1UL << bit)));
 		} while (unlikely(!temp));
 	} else
@@ -197,7 +197,7 @@ static inline void change_bit(unsigned long nr, volatile unsigned long *addr)
 		"	" __SC	"%0, %1				\n"
 		"	beqzl	%0, 1b				\n"
 		"	.set	mips0				\n"
-		: "=&r" (temp), "+" GCC_OFF12_ASM() (*m)
+		: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (*m)
 		: "ir" (1UL << bit));
 	} else if (kernel_uses_llsc) {
 		unsigned long *m = ((unsigned long *) addr) + (nr >> SZLONG_LOG);
@@ -210,7 +210,7 @@ static inline void change_bit(unsigned long nr, volatile unsigned long *addr)
 			"	xor	%0, %2				\n"
 			"	" __SC	"%0, %1				\n"
 			"	.set	mips0				\n"
-			: "=&r" (temp), "+" GCC_OFF12_ASM() (*m)
+			: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (*m)
 			: "ir" (1UL << bit));
 		} while (unlikely(!temp));
 	} else
@@ -245,7 +245,7 @@ static inline int test_and_set_bit(unsigned long nr,
 		"	beqzl	%2, 1b					\n"
 		"	and	%2, %0, %3				\n"
 		"	.set	mips0					\n"
-		: "=&r" (temp), "+" GCC_OFF12_ASM() (*m), "=&r" (res)
+		: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (*m), "=&r" (res)
 		: "r" (1UL << bit)
 		: "memory");
 	} else if (kernel_uses_llsc) {
@@ -259,7 +259,7 @@ static inline int test_and_set_bit(unsigned long nr,
 			"	or	%2, %0, %3			\n"
 			"	" __SC	"%2, %1				\n"
 			"	.set	mips0				\n"
-			: "=&r" (temp), "+" GCC_OFF12_ASM() (*m), "=&r" (res)
+			: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (*m), "=&r" (res)
 			: "r" (1UL << bit)
 			: "memory");
 		} while (unlikely(!res));
@@ -313,7 +313,7 @@ static inline int test_and_set_bit_lock(unsigned long nr,
 			"	or	%2, %0, %3			\n"
 			"	" __SC	"%2, %1				\n"
 			"	.set	mips0				\n"
-			: "=&r" (temp), "+" GCC_OFF12_ASM() (*m), "=&r" (res)
+			: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (*m), "=&r" (res)
 			: "r" (1UL << bit)
 			: "memory");
 		} while (unlikely(!res));
@@ -355,7 +355,7 @@ static inline int test_and_clear_bit(unsigned long nr,
 		"	beqzl	%2, 1b					\n"
 		"	and	%2, %0, %3				\n"
 		"	.set	mips0					\n"
-		: "=&r" (temp), "+" GCC_OFF12_ASM() (*m), "=&r" (res)
+		: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (*m), "=&r" (res)
 		: "r" (1UL << bit)
 		: "memory");
 #ifdef CONFIG_CPU_MIPSR2
@@ -369,7 +369,7 @@ static inline int test_and_clear_bit(unsigned long nr,
 			"	" __EXT "%2, %0, %3, 1			\n"
 			"	" __INS "%0, $0, %3, 1			\n"
 			"	" __SC	"%0, %1				\n"
-			: "=&r" (temp), "+" GCC_OFF12_ASM() (*m), "=&r" (res)
+			: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (*m), "=&r" (res)
 			: "ir" (bit)
 			: "memory");
 		} while (unlikely(!temp));
@@ -386,7 +386,7 @@ static inline int test_and_clear_bit(unsigned long nr,
 			"	xor	%2, %3				\n"
 			"	" __SC	"%2, %1				\n"
 			"	.set	mips0				\n"
-			: "=&r" (temp), "+" GCC_OFF12_ASM() (*m), "=&r" (res)
+			: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (*m), "=&r" (res)
 			: "r" (1UL << bit)
 			: "memory");
 		} while (unlikely(!res));
@@ -428,7 +428,7 @@ static inline int test_and_change_bit(unsigned long nr,
 		"	beqzl	%2, 1b					\n"
 		"	and	%2, %0, %3				\n"
 		"	.set	mips0					\n"
-		: "=&r" (temp), "+" GCC_OFF12_ASM() (*m), "=&r" (res)
+		: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (*m), "=&r" (res)
 		: "r" (1UL << bit)
 		: "memory");
 	} else if (kernel_uses_llsc) {
@@ -442,7 +442,7 @@ static inline int test_and_change_bit(unsigned long nr,
 			"	xor	%2, %0, %3			\n"
 			"	" __SC	"\t%2, %1			\n"
 			"	.set	mips0				\n"
-			: "=&r" (temp), "+" GCC_OFF12_ASM() (*m), "=&r" (res)
+			: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (*m), "=&r" (res)
 			: "r" (1UL << bit)
 			: "memory");
 		} while (unlikely(!res));
diff --git a/arch/mips/include/asm/cmpxchg.h b/arch/mips/include/asm/cmpxchg.h
index 28b1edf19501..68baa0cf521a 100644
--- a/arch/mips/include/asm/cmpxchg.h
+++ b/arch/mips/include/asm/cmpxchg.h
@@ -31,8 +31,8 @@ static inline unsigned long __xchg_u32(volatile int * m, unsigned int val)
 		"	sc	%2, %1					\n"
 		"	beqzl	%2, 1b					\n"
 		"	.set	mips0					\n"
-		: "=&r" (retval), "=" GCC_OFF12_ASM() (*m), "=&r" (dummy)
-		: GCC_OFF12_ASM() (*m), "Jr" (val)
+		: "=&r" (retval), "=" GCC_OFF_SMALL_ASM() (*m), "=&r" (dummy)
+		: GCC_OFF_SMALL_ASM() (*m), "Jr" (val)
 		: "memory");
 	} else if (kernel_uses_llsc) {
 		unsigned long dummy;
@@ -46,9 +46,9 @@ static inline unsigned long __xchg_u32(volatile int * m, unsigned int val)
 			"	.set	arch=r4000			\n"
 			"	sc	%2, %1				\n"
 			"	.set	mips0				\n"
-			: "=&r" (retval), "=" GCC_OFF12_ASM() (*m),
+			: "=&r" (retval), "=" GCC_OFF_SMALL_ASM() (*m),
 			  "=&r" (dummy)
-			: GCC_OFF12_ASM() (*m), "Jr" (val)
+			: GCC_OFF_SMALL_ASM() (*m), "Jr" (val)
 			: "memory");
 		} while (unlikely(!dummy));
 	} else {
@@ -82,8 +82,8 @@ static inline __u64 __xchg_u64(volatile __u64 * m, __u64 val)
 		"	scd	%2, %1					\n"
 		"	beqzl	%2, 1b					\n"
 		"	.set	mips0					\n"
-		: "=&r" (retval), "=" GCC_OFF12_ASM() (*m), "=&r" (dummy)
-		: GCC_OFF12_ASM() (*m), "Jr" (val)
+		: "=&r" (retval), "=" GCC_OFF_SMALL_ASM() (*m), "=&r" (dummy)
+		: GCC_OFF_SMALL_ASM() (*m), "Jr" (val)
 		: "memory");
 	} else if (kernel_uses_llsc) {
 		unsigned long dummy;
@@ -95,9 +95,9 @@ static inline __u64 __xchg_u64(volatile __u64 * m, __u64 val)
 			"	move	%2, %z4				\n"
 			"	scd	%2, %1				\n"
 			"	.set	mips0				\n"
-			: "=&r" (retval), "=" GCC_OFF12_ASM() (*m),
+			: "=&r" (retval), "=" GCC_OFF_SMALL_ASM() (*m),
 			  "=&r" (dummy)
-			: GCC_OFF12_ASM() (*m), "Jr" (val)
+			: GCC_OFF_SMALL_ASM() (*m), "Jr" (val)
 			: "memory");
 		} while (unlikely(!dummy));
 	} else {
@@ -158,8 +158,8 @@ static inline unsigned long __xchg(unsigned long x, volatile void * ptr, int siz
 		"	beqzl	$1, 1b				\n"	\
 		"2:						\n"	\
 		"	.set	pop				\n"	\
-		: "=&r" (__ret), "=" GCC_OFF12_ASM() (*m)		\
-		: GCC_OFF12_ASM() (*m), "Jr" (old), "Jr" (new)		\
+		: "=&r" (__ret), "=" GCC_OFF_SMALL_ASM() (*m)		\
+		: GCC_OFF_SMALL_ASM() (*m), "Jr" (old), "Jr" (new)		\
 		: "memory");						\
 	} else if (kernel_uses_llsc) {					\
 		__asm__ __volatile__(					\
@@ -175,8 +175,8 @@ static inline unsigned long __xchg(unsigned long x, volatile void * ptr, int siz
 		"	beqz	$1, 1b				\n"	\
 		"	.set	pop				\n"	\
 		"2:						\n"	\
-		: "=&r" (__ret), "=" GCC_OFF12_ASM() (*m)		\
-		: GCC_OFF12_ASM() (*m), "Jr" (old), "Jr" (new)		\
+		: "=&r" (__ret), "=" GCC_OFF_SMALL_ASM() (*m)		\
+		: GCC_OFF_SMALL_ASM() (*m), "Jr" (old), "Jr" (new)		\
 		: "memory");						\
 	} else {							\
 		unsigned long __flags;					\
diff --git a/arch/mips/include/asm/compiler.h b/arch/mips/include/asm/compiler.h
index c73815e0123a..90a317a08bd7 100644
--- a/arch/mips/include/asm/compiler.h
+++ b/arch/mips/include/asm/compiler.h
@@ -17,9 +17,9 @@
 #endif
 
 #ifndef CONFIG_CPU_MICROMIPS
-#define GCC_OFF12_ASM() "R"
+#define GCC_OFF_SMALL_ASM() "R"
 #elif __GNUC__ > 4 || (__GNUC__ == 4 && __GNUC_MINOR__ >= 9)
-#define GCC_OFF12_ASM() "ZC"
+#define GCC_OFF_SMALL_ASM() "ZC"
 #else
 #error "microMIPS compilation unsupported with GCC older than 4.9"
 #endif
diff --git a/arch/mips/include/asm/edac.h b/arch/mips/include/asm/edac.h
index ae6fedcb0060..94105d3f58f4 100644
--- a/arch/mips/include/asm/edac.h
+++ b/arch/mips/include/asm/edac.h
@@ -26,8 +26,8 @@ static inline void atomic_scrub(void *va, u32 size)
 		"	sc	%0, %1					\n"
 		"	beqz	%0, 1b					\n"
 		"	.set	mips0					\n"
-		: "=&r" (temp), "=" GCC_OFF12_ASM() (*virt_addr)
-		: GCC_OFF12_ASM() (*virt_addr));
+		: "=&r" (temp), "=" GCC_OFF_SMALL_ASM() (*virt_addr)
+		: GCC_OFF_SMALL_ASM() (*virt_addr));
 
 		virt_addr++;
 	}
diff --git a/arch/mips/include/asm/futex.h b/arch/mips/include/asm/futex.h
index ef9987a61d88..f666c0608c11 100644
--- a/arch/mips/include/asm/futex.h
+++ b/arch/mips/include/asm/futex.h
@@ -45,8 +45,8 @@
 		"	"__UA_ADDR "\t2b, 4b			\n"	\
 		"	.previous				\n"	\
 		: "=r" (ret), "=&r" (oldval),				\
-		  "=" GCC_OFF12_ASM() (*uaddr)				\
-		: "0" (0), GCC_OFF12_ASM() (*uaddr), "Jr" (oparg),	\
+		  "=" GCC_OFF_SMALL_ASM() (*uaddr)				\
+		: "0" (0), GCC_OFF_SMALL_ASM() (*uaddr), "Jr" (oparg),	\
 		  "i" (-EFAULT)						\
 		: "memory");						\
 	} else if (cpu_has_llsc) {					\
@@ -74,8 +74,8 @@
 		"	"__UA_ADDR "\t2b, 4b			\n"	\
 		"	.previous				\n"	\
 		: "=r" (ret), "=&r" (oldval),				\
-		  "=" GCC_OFF12_ASM() (*uaddr)				\
-		: "0" (0), GCC_OFF12_ASM() (*uaddr), "Jr" (oparg),	\
+		  "=" GCC_OFF_SMALL_ASM() (*uaddr)				\
+		: "0" (0), GCC_OFF_SMALL_ASM() (*uaddr), "Jr" (oparg),	\
 		  "i" (-EFAULT)						\
 		: "memory");						\
 	} else								\
@@ -174,8 +174,8 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 		"	"__UA_ADDR "\t1b, 4b				\n"
 		"	"__UA_ADDR "\t2b, 4b				\n"
 		"	.previous					\n"
-		: "+r" (ret), "=&r" (val), "=" GCC_OFF12_ASM() (*uaddr)
-		: GCC_OFF12_ASM() (*uaddr), "Jr" (oldval), "Jr" (newval),
+		: "+r" (ret), "=&r" (val), "=" GCC_OFF_SMALL_ASM() (*uaddr)
+		: GCC_OFF_SMALL_ASM() (*uaddr), "Jr" (oldval), "Jr" (newval),
 		  "i" (-EFAULT)
 		: "memory");
 	} else if (cpu_has_llsc) {
@@ -203,8 +203,8 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 		"	"__UA_ADDR "\t1b, 4b				\n"
 		"	"__UA_ADDR "\t2b, 4b				\n"
 		"	.previous					\n"
-		: "+r" (ret), "=&r" (val), "=" GCC_OFF12_ASM() (*uaddr)
-		: GCC_OFF12_ASM() (*uaddr), "Jr" (oldval), "Jr" (newval),
+		: "+r" (ret), "=&r" (val), "=" GCC_OFF_SMALL_ASM() (*uaddr)
+		: GCC_OFF_SMALL_ASM() (*uaddr), "Jr" (oldval), "Jr" (newval),
 		  "i" (-EFAULT)
 		: "memory");
 	} else
diff --git a/arch/mips/include/asm/mach-pmcs-msp71xx/msp_regops.h b/arch/mips/include/asm/mach-pmcs-msp71xx/msp_regops.h
index 2e54b4bff5cf..90dbe43c8d27 100644
--- a/arch/mips/include/asm/mach-pmcs-msp71xx/msp_regops.h
+++ b/arch/mips/include/asm/mach-pmcs-msp71xx/msp_regops.h
@@ -85,8 +85,8 @@ static inline void set_value_reg32(volatile u32 *const addr,
 	"	"__beqz"%0, 1b				\n"
 	"	nop					\n"
 	"	.set	pop				\n"
-	: "=&r" (temp), "=" GCC_OFF12_ASM() (*addr)
-	: "ir" (~mask), "ir" (value), GCC_OFF12_ASM() (*addr));
+	: "=&r" (temp), "=" GCC_OFF_SMALL_ASM() (*addr)
+	: "ir" (~mask), "ir" (value), GCC_OFF_SMALL_ASM() (*addr));
 }
 
 /*
@@ -106,8 +106,8 @@ static inline void set_reg32(volatile u32 *const addr,
 	"	"__beqz"%0, 1b				\n"
 	"	nop					\n"
 	"	.set	pop				\n"
-	: "=&r" (temp), "=" GCC_OFF12_ASM() (*addr)
-	: "ir" (mask), GCC_OFF12_ASM() (*addr));
+	: "=&r" (temp), "=" GCC_OFF_SMALL_ASM() (*addr)
+	: "ir" (mask), GCC_OFF_SMALL_ASM() (*addr));
 }
 
 /*
@@ -127,8 +127,8 @@ static inline void clear_reg32(volatile u32 *const addr,
 	"	"__beqz"%0, 1b				\n"
 	"	nop					\n"
 	"	.set	pop				\n"
-	: "=&r" (temp), "=" GCC_OFF12_ASM() (*addr)
-	: "ir" (~mask), GCC_OFF12_ASM() (*addr));
+	: "=&r" (temp), "=" GCC_OFF_SMALL_ASM() (*addr)
+	: "ir" (~mask), GCC_OFF_SMALL_ASM() (*addr));
 }
 
 /*
@@ -148,8 +148,8 @@ static inline void toggle_reg32(volatile u32 *const addr,
 	"	"__beqz"%0, 1b				\n"
 	"	nop					\n"
 	"	.set	pop				\n"
-	: "=&r" (temp), "=" GCC_OFF12_ASM() (*addr)
-	: "ir" (mask), GCC_OFF12_ASM() (*addr));
+	: "=&r" (temp), "=" GCC_OFF_SMALL_ASM() (*addr)
+	: "ir" (mask), GCC_OFF_SMALL_ASM() (*addr));
 }
 
 /*
@@ -220,8 +220,8 @@ static inline u32 blocking_read_reg32(volatile u32 *const addr)
 	"	.set	arch=r4000			\n"	\
 	"1:	ll	%0, %1	#custom_read_reg32	\n"	\
 	"	.set	pop				\n"	\
-	: "=r" (tmp), "=" GCC_OFF12_ASM() (*address)		\
-	: GCC_OFF12_ASM() (*address))
+	: "=r" (tmp), "=" GCC_OFF_SMALL_ASM() (*address)		\
+	: GCC_OFF_SMALL_ASM() (*address))
 
 #define custom_write_reg32(address, tmp)			\
 	__asm__ __volatile__(					\
@@ -231,7 +231,7 @@ static inline u32 blocking_read_reg32(volatile u32 *const addr)
 	"	"__beqz"%0, 1b				\n"	\
 	"	nop					\n"	\
 	"	.set	pop				\n"	\
-	: "=&r" (tmp), "=" GCC_OFF12_ASM() (*address)		\
-	: "0" (tmp), GCC_OFF12_ASM() (*address))
+	: "=&r" (tmp), "=" GCC_OFF_SMALL_ASM() (*address)		\
+	: "0" (tmp), GCC_OFF_SMALL_ASM() (*address))
 
 #endif	/* __ASM_REGOPS_H__ */
diff --git a/arch/mips/include/asm/octeon/cvmx-cmd-queue.h b/arch/mips/include/asm/octeon/cvmx-cmd-queue.h
index 75739c83f07e..8d05d9069823 100644
--- a/arch/mips/include/asm/octeon/cvmx-cmd-queue.h
+++ b/arch/mips/include/asm/octeon/cvmx-cmd-queue.h
@@ -275,7 +275,7 @@ static inline void __cvmx_cmd_queue_lock(cvmx_cmd_queue_id_t queue_id,
 		" lbu	%[ticket], %[now_serving]\n"
 		"4:\n"
 		".set pop\n" :
-		[ticket_ptr] "=" GCC_OFF12_ASM()(__cvmx_cmd_queue_state_ptr->ticket[__cvmx_cmd_queue_get_index(queue_id)]),
+		[ticket_ptr] "=" GCC_OFF_SMALL_ASM()(__cvmx_cmd_queue_state_ptr->ticket[__cvmx_cmd_queue_get_index(queue_id)]),
 		[now_serving] "=m"(qptr->now_serving), [ticket] "=r"(tmp),
 		[my_ticket] "=r"(my_ticket)
 	    );
diff --git a/arch/mips/include/asm/spinlock.h b/arch/mips/include/asm/spinlock.h
index c6d06d383ef9..b5238404c059 100644
--- a/arch/mips/include/asm/spinlock.h
+++ b/arch/mips/include/asm/spinlock.h
@@ -89,7 +89,7 @@ static inline void arch_spin_lock(arch_spinlock_t *lock)
 		"	 subu	%[ticket], %[ticket], 1			\n"
 		"	.previous					\n"
 		"	.set pop					\n"
-		: [ticket_ptr] "+" GCC_OFF12_ASM() (lock->lock),
+		: [ticket_ptr] "+" GCC_OFF_SMALL_ASM() (lock->lock),
 		  [serving_now_ptr] "+m" (lock->h.serving_now),
 		  [ticket] "=&r" (tmp),
 		  [my_ticket] "=&r" (my_ticket)
@@ -122,7 +122,7 @@ static inline void arch_spin_lock(arch_spinlock_t *lock)
 		"	 subu	%[ticket], %[ticket], 1			\n"
 		"	.previous					\n"
 		"	.set pop					\n"
-		: [ticket_ptr] "+" GCC_OFF12_ASM() (lock->lock),
+		: [ticket_ptr] "+" GCC_OFF_SMALL_ASM() (lock->lock),
 		  [serving_now_ptr] "+m" (lock->h.serving_now),
 		  [ticket] "=&r" (tmp),
 		  [my_ticket] "=&r" (my_ticket)
@@ -164,7 +164,7 @@ static inline unsigned int arch_spin_trylock(arch_spinlock_t *lock)
 		"	 li	%[ticket], 0				\n"
 		"	.previous					\n"
 		"	.set pop					\n"
-		: [ticket_ptr] "+" GCC_OFF12_ASM() (lock->lock),
+		: [ticket_ptr] "+" GCC_OFF_SMALL_ASM() (lock->lock),
 		  [ticket] "=&r" (tmp),
 		  [my_ticket] "=&r" (tmp2),
 		  [now_serving] "=&r" (tmp3)
@@ -188,7 +188,7 @@ static inline unsigned int arch_spin_trylock(arch_spinlock_t *lock)
 		"	 li	%[ticket], 0				\n"
 		"	.previous					\n"
 		"	.set pop					\n"
-		: [ticket_ptr] "+" GCC_OFF12_ASM() (lock->lock),
+		: [ticket_ptr] "+" GCC_OFF_SMALL_ASM() (lock->lock),
 		  [ticket] "=&r" (tmp),
 		  [my_ticket] "=&r" (tmp2),
 		  [now_serving] "=&r" (tmp3)
@@ -235,8 +235,8 @@ static inline void arch_read_lock(arch_rwlock_t *rw)
 		"	beqzl	%1, 1b					\n"
 		"	 nop						\n"
 		"	.set	reorder					\n"
-		: "=" GCC_OFF12_ASM() (rw->lock), "=&r" (tmp)
-		: GCC_OFF12_ASM() (rw->lock)
+		: "=" GCC_OFF_SMALL_ASM() (rw->lock), "=&r" (tmp)
+		: GCC_OFF_SMALL_ASM() (rw->lock)
 		: "memory");
 	} else {
 		do {
@@ -245,8 +245,8 @@ static inline void arch_read_lock(arch_rwlock_t *rw)
 			"	bltz	%1, 1b				\n"
 			"	 addu	%1, 1				\n"
 			"2:	sc	%1, %0				\n"
-			: "=" GCC_OFF12_ASM() (rw->lock), "=&r" (tmp)
-			: GCC_OFF12_ASM() (rw->lock)
+			: "=" GCC_OFF_SMALL_ASM() (rw->lock), "=&r" (tmp)
+			: GCC_OFF_SMALL_ASM() (rw->lock)
 			: "memory");
 		} while (unlikely(!tmp));
 	}
@@ -269,8 +269,8 @@ static inline void arch_read_unlock(arch_rwlock_t *rw)
 		"	sub	%1, 1					\n"
 		"	sc	%1, %0					\n"
 		"	beqzl	%1, 1b					\n"
-		: "=" GCC_OFF12_ASM() (rw->lock), "=&r" (tmp)
-		: GCC_OFF12_ASM() (rw->lock)
+		: "=" GCC_OFF_SMALL_ASM() (rw->lock), "=&r" (tmp)
+		: GCC_OFF_SMALL_ASM() (rw->lock)
 		: "memory");
 	} else {
 		do {
@@ -278,8 +278,8 @@ static inline void arch_read_unlock(arch_rwlock_t *rw)
 			"1:	ll	%1, %2	# arch_read_unlock	\n"
 			"	sub	%1, 1				\n"
 			"	sc	%1, %0				\n"
-			: "=" GCC_OFF12_ASM() (rw->lock), "=&r" (tmp)
-			: GCC_OFF12_ASM() (rw->lock)
+			: "=" GCC_OFF_SMALL_ASM() (rw->lock), "=&r" (tmp)
+			: GCC_OFF_SMALL_ASM() (rw->lock)
 			: "memory");
 		} while (unlikely(!tmp));
 	}
@@ -299,8 +299,8 @@ static inline void arch_write_lock(arch_rwlock_t *rw)
 		"	beqzl	%1, 1b					\n"
 		"	 nop						\n"
 		"	.set	reorder					\n"
-		: "=" GCC_OFF12_ASM() (rw->lock), "=&r" (tmp)
-		: GCC_OFF12_ASM() (rw->lock)
+		: "=" GCC_OFF_SMALL_ASM() (rw->lock), "=&r" (tmp)
+		: GCC_OFF_SMALL_ASM() (rw->lock)
 		: "memory");
 	} else {
 		do {
@@ -309,8 +309,8 @@ static inline void arch_write_lock(arch_rwlock_t *rw)
 			"	bnez	%1, 1b				\n"
 			"	 lui	%1, 0x8000			\n"
 			"2:	sc	%1, %0				\n"
-			: "=" GCC_OFF12_ASM() (rw->lock), "=&r" (tmp)
-			: GCC_OFF12_ASM() (rw->lock)
+			: "=" GCC_OFF_SMALL_ASM() (rw->lock), "=&r" (tmp)
+			: GCC_OFF_SMALL_ASM() (rw->lock)
 			: "memory");
 		} while (unlikely(!tmp));
 	}
@@ -349,8 +349,8 @@ static inline int arch_read_trylock(arch_rwlock_t *rw)
 		__WEAK_LLSC_MB
 		"	li	%2, 1					\n"
 		"2:							\n"
-		: "=" GCC_OFF12_ASM() (rw->lock), "=&r" (tmp), "=&r" (ret)
-		: GCC_OFF12_ASM() (rw->lock)
+		: "=" GCC_OFF_SMALL_ASM() (rw->lock), "=&r" (tmp), "=&r" (ret)
+		: GCC_OFF_SMALL_ASM() (rw->lock)
 		: "memory");
 	} else {
 		__asm__ __volatile__(
@@ -366,8 +366,8 @@ static inline int arch_read_trylock(arch_rwlock_t *rw)
 		__WEAK_LLSC_MB
 		"	li	%2, 1					\n"
 		"2:							\n"
-		: "=" GCC_OFF12_ASM() (rw->lock), "=&r" (tmp), "=&r" (ret)
-		: GCC_OFF12_ASM() (rw->lock)
+		: "=" GCC_OFF_SMALL_ASM() (rw->lock), "=&r" (tmp), "=&r" (ret)
+		: GCC_OFF_SMALL_ASM() (rw->lock)
 		: "memory");
 	}
 
@@ -393,8 +393,8 @@ static inline int arch_write_trylock(arch_rwlock_t *rw)
 		"	li	%2, 1					\n"
 		"	.set	reorder					\n"
 		"2:							\n"
-		: "=" GCC_OFF12_ASM() (rw->lock), "=&r" (tmp), "=&r" (ret)
-		: GCC_OFF12_ASM() (rw->lock)
+		: "=" GCC_OFF_SMALL_ASM() (rw->lock), "=&r" (tmp), "=&r" (ret)
+		: GCC_OFF_SMALL_ASM() (rw->lock)
 		: "memory");
 	} else {
 		do {
@@ -406,9 +406,9 @@ static inline int arch_write_trylock(arch_rwlock_t *rw)
 			"	sc	%1, %0				\n"
 			"	li	%2, 1				\n"
 			"2:						\n"
-			: "=" GCC_OFF12_ASM() (rw->lock), "=&r" (tmp),
+			: "=" GCC_OFF_SMALL_ASM() (rw->lock), "=&r" (tmp),
 			  "=&r" (ret)
-			: GCC_OFF12_ASM() (rw->lock)
+			: GCC_OFF_SMALL_ASM() (rw->lock)
 			: "memory");
 		} while (unlikely(!tmp));
 
-- 
2.2.2
