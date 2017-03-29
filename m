Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Mar 2017 10:31:48 +0200 (CEST)
Received: from smtpbg65.qq.com ([103.7.28.233]:13456 "EHLO smtpbg65.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993867AbdC2IbhBAauX (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 29 Mar 2017 10:31:37 +0200
X-QQ-mid: bizesmtp1t1490776265tw0ib8d6u
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Wed, 29 Mar 2017 16:30:15 +0800 (CST)
X-QQ-SSF: 01100000002000F0FK82000A0000000
X-QQ-FEAT: NCurqkplqhOw1lTu2xwFk5X80G5z+LTiapILMOEyZSJSnXxA6lH57NWW3+doM
        +2CsHI7OZWvtPA4L/Rk08DvEzHUNgN6OOjy3OqJTtYS+5rWlw9FxCqAedVTxwk1frTgWSgM
        0YcmCRQjXccDjsVaBS1mPyeivsx+duqDueBmKk3dT8HQb2UouwFOQCGfmiclXWucVVolNna
        gqNe6ExXjvvsD4IMeVsASYckIgXRQ5mRChgUBp4gEfkOe5AWyMDF7Bz8P6nddEv9RP/q5G/
        cb5H4QsaiRQpb54sA1jrcSBBZwIdUoBTes4XlCrKupsA4l
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH V3 8/8] MIPS: Loongson: Introduce and use LOONGSON_LLSC_WAR
Date:   Wed, 29 Mar 2017 16:24:36 +0800
Message-Id: <1490775876-29918-9-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1490775876-29918-1-git-send-email-chenhc@lemote.com>
References: <1490775876-29918-1-git-send-email-chenhc@lemote.com>
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57467
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

On the Loongson-2G/2H/3A/3B there is a hardware flaw that ll/sc and
lld/scd is very weak ordering. We should add sync instructions before
each ll/lld and after the last sc/scd to workaround. Otherwise, this
flaw will cause deadlock occationally (e.g. when doing heavy load test
with LTP).

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/include/asm/atomic.h                 | 107 ++++++++++
 arch/mips/include/asm/bitops.h                 | 273 +++++++++++++++++++------
 arch/mips/include/asm/cmpxchg.h                |  54 +++++
 arch/mips/include/asm/edac.h                   |  33 ++-
 arch/mips/include/asm/futex.h                  |  62 ++++++
 arch/mips/include/asm/local.h                  |  34 +++
 arch/mips/include/asm/mach-cavium-octeon/war.h |   1 +
 arch/mips/include/asm/mach-generic/war.h       |   1 +
 arch/mips/include/asm/mach-ip22/war.h          |   1 +
 arch/mips/include/asm/mach-ip27/war.h          |   1 +
 arch/mips/include/asm/mach-ip28/war.h          |   1 +
 arch/mips/include/asm/mach-ip32/war.h          |   1 +
 arch/mips/include/asm/mach-loongson64/war.h    |  26 +++
 arch/mips/include/asm/mach-malta/war.h         |   1 +
 arch/mips/include/asm/mach-pmcs-msp71xx/war.h  |   1 +
 arch/mips/include/asm/mach-rc32434/war.h       |   1 +
 arch/mips/include/asm/mach-rm/war.h            |   1 +
 arch/mips/include/asm/mach-sibyte/war.h        |   1 +
 arch/mips/include/asm/mach-tx49xx/war.h        |   1 +
 arch/mips/include/asm/pgtable.h                |  19 ++
 arch/mips/include/asm/spinlock.h               | 142 +++++++++++++
 arch/mips/include/asm/war.h                    |   8 +
 arch/mips/kernel/syscall.c                     |  34 +++
 arch/mips/loongson64/Platform                  |   3 +
 arch/mips/mm/tlbex.c                           |  17 ++
 25 files changed, 757 insertions(+), 67 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-loongson64/war.h

diff --git a/arch/mips/include/asm/atomic.h b/arch/mips/include/asm/atomic.h
index 0ab176b..e0002c58 100644
--- a/arch/mips/include/asm/atomic.h
+++ b/arch/mips/include/asm/atomic.h
@@ -56,6 +56,22 @@ static __inline__ void atomic_##op(int i, atomic_t * v)			      \
 		"	.set	mips0					\n"   \
 		: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (v->counter)	      \
 		: "Ir" (i));						      \
+	} else if (kernel_uses_llsc && LOONGSON_LLSC_WAR) {		      \
+		int temp;						      \
+									      \
+		do {							      \
+			__asm__ __volatile__(				      \
+			"	.set	"MIPS_ISA_LEVEL"		\n"   \
+			__WEAK_LLSC_MB					      \
+			"	ll	%0, %1		# atomic_" #op "\n"   \
+			"	" #asm_op " %0, %2			\n"   \
+			"	sc	%0, %1				\n"   \
+			"	.set	mips0				\n"   \
+			: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (v->counter)      \
+			: "Ir" (i));					      \
+		} while (unlikely(!temp));				      \
+									      \
+		smp_llsc_mb();						      \
 	} else if (kernel_uses_llsc) {					      \
 		int temp;						      \
 									      \
@@ -97,6 +113,23 @@ static __inline__ int atomic_##op##_return_relaxed(int i, atomic_t * v)	      \
 		: "=&r" (result), "=&r" (temp),				      \
 		  "+" GCC_OFF_SMALL_ASM() (v->counter)			      \
 		: "Ir" (i));						      \
+	} else if (kernel_uses_llsc && LOONGSON_LLSC_WAR) {		      \
+		int temp;						      \
+									      \
+		do {							      \
+			__asm__ __volatile__(				      \
+			"	.set	"MIPS_ISA_LEVEL"		\n"   \
+			__WEAK_LLSC_MB					      \
+			"	ll	%1, %2	# atomic_" #op "_return	\n"   \
+			"	" #asm_op " %0, %1, %3			\n"   \
+			"	sc	%0, %2				\n"   \
+			"	.set	mips0				\n"   \
+			: "=&r" (result), "=&r" (temp),			      \
+			  "+" GCC_OFF_SMALL_ASM() (v->counter)		      \
+			: "Ir" (i));					      \
+		} while (unlikely(!result));				      \
+									      \
+		result = temp; result c_op i;				      \
 	} else if (kernel_uses_llsc) {					      \
 		int temp;						      \
 									      \
@@ -237,6 +270,26 @@ static __inline__ int atomic_sub_if_positive(int i, atomic_t * v)
 		  "+" GCC_OFF_SMALL_ASM() (v->counter)
 		: "Ir" (i), GCC_OFF_SMALL_ASM() (v->counter)
 		: "memory");
+	} else if (kernel_uses_llsc && LOONGSON_LLSC_WAR) {
+		int temp;
+
+		__asm__ __volatile__(
+		"	.set	"MIPS_ISA_LEVEL"			\n"
+		"1:				# atomic_sub_if_positive\n"
+		__WEAK_LLSC_MB
+		"	ll	%1, %2					\n"
+		"	subu	%0, %1, %3				\n"
+		"	bltz	%0, 1f					\n"
+		"	sc	%0, %2					\n"
+		"	.set	noreorder				\n"
+		"	beqz	%0, 1b					\n"
+		"	 subu	%0, %1, %3				\n"
+		"	.set	reorder					\n"
+		"1:							\n"
+		"	.set	mips0					\n"
+		: "=&r" (result), "=&r" (temp),
+		  "+" GCC_OFF_SMALL_ASM() (v->counter)
+		: "Ir" (i));
 	} else if (kernel_uses_llsc) {
 		int temp;
 
@@ -398,6 +451,22 @@ static __inline__ void atomic64_##op(long i, atomic64_t * v)		      \
 		"	.set	mips0					\n"   \
 		: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (v->counter)	      \
 		: "Ir" (i));						      \
+	} else if (kernel_uses_llsc && LOONGSON_LLSC_WAR) {		      \
+		long temp;						      \
+									      \
+		do {							      \
+			__asm__ __volatile__(				      \
+			"	.set	"MIPS_ISA_LEVEL"		\n"   \
+			__WEAK_LLSC_MB					      \
+			"	lld	%0, %1		# atomic64_" #op "\n" \
+			"	" #asm_op " %0, %2			\n"   \
+			"	scd	%0, %1				\n"   \
+			"	.set	mips0				\n"   \
+			: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (v->counter)      \
+			: "Ir" (i));					      \
+		} while (unlikely(!temp));				      \
+									      \
+		smp_llsc_mb();						      \
 	} else if (kernel_uses_llsc) {					      \
 		long temp;						      \
 									      \
@@ -439,6 +508,24 @@ static __inline__ long atomic64_##op##_return_relaxed(long i, atomic64_t * v) \
 		: "=&r" (result), "=&r" (temp),				      \
 		  "+" GCC_OFF_SMALL_ASM() (v->counter)			      \
 		: "Ir" (i));						      \
+	} else if (kernel_uses_llsc && LOONGSON_LLSC_WAR) {		      \
+		long temp;						      \
+									      \
+		do {							      \
+			__asm__ __volatile__(				      \
+			"	.set	"MIPS_ISA_LEVEL"		\n"   \
+			__WEAK_LLSC_MB					      \
+			"	lld	%1, %2	# atomic64_" #op "_return\n"  \
+			"	" #asm_op " %0, %1, %3			\n"   \
+			"	scd	%0, %2				\n"   \
+			"	.set	mips0				\n"   \
+			: "=&r" (result), "=&r" (temp),			      \
+			  "=" GCC_OFF_SMALL_ASM() (v->counter)		      \
+			: "Ir" (i), GCC_OFF_SMALL_ASM() (v->counter)	      \
+			: "memory");					      \
+		} while (unlikely(!result));				      \
+									      \
+		result = temp; result c_op i;				      \
 	} else if (kernel_uses_llsc) {					      \
 		long temp;						      \
 									      \
@@ -582,6 +669,26 @@ static __inline__ long atomic64_sub_if_positive(long i, atomic64_t * v)
 		  "=" GCC_OFF_SMALL_ASM() (v->counter)
 		: "Ir" (i), GCC_OFF_SMALL_ASM() (v->counter)
 		: "memory");
+	} else if (kernel_uses_llsc && LOONGSON_LLSC_WAR) {
+		long temp;
+
+		__asm__ __volatile__(
+		"	.set	"MIPS_ISA_LEVEL"			\n"
+		"1:				# atomic64_sub_if_positive\n"
+		__WEAK_LLSC_MB
+		"	lld	%1, %2					\n"
+		"	dsubu	%0, %1, %3				\n"
+		"	bltz	%0, 1f					\n"
+		"	scd	%0, %2					\n"
+		"	.set	noreorder				\n"
+		"	beqz	%0, 1b					\n"
+		"	 dsubu	%0, %1, %3				\n"
+		"	.set	reorder					\n"
+		"1:							\n"
+		"	.set	mips0					\n"
+		: "=&r" (result), "=&r" (temp),
+		  "+" GCC_OFF_SMALL_ASM() (v->counter)
+		: "Ir" (i));
 	} else if (kernel_uses_llsc) {
 		long temp;
 
diff --git a/arch/mips/include/asm/bitops.h b/arch/mips/include/asm/bitops.h
index fa57cef..6bef54a 100644
--- a/arch/mips/include/asm/bitops.h
+++ b/arch/mips/include/asm/bitops.h
@@ -68,26 +68,54 @@ static inline void set_bit(unsigned long nr, volatile unsigned long *addr)
 		: "ir" (1UL << bit), GCC_OFF_SMALL_ASM() (*m));
 #if defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_MIPSR6)
 	} else if (kernel_uses_llsc && __builtin_constant_p(bit)) {
-		do {
-			__asm__ __volatile__(
-			"	" __LL "%0, %1		# set_bit	\n"
-			"	" __INS "%0, %3, %2, 1			\n"
-			"	" __SC "%0, %1				\n"
-			: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (*m)
-			: "ir" (bit), "r" (~0));
-		} while (unlikely(!temp));
+		if (LOONGSON_LLSC_WAR) {
+			do {
+				__asm__ __volatile__(
+				__WEAK_LLSC_MB
+				"	" __LL "%0, %1		# set_bit	\n"
+				"	" __INS "%0, %3, %2, 1			\n"
+				"	" __SC "%0, %1				\n"
+				: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (*m)
+				: "ir" (bit), "r" (~0));
+			} while (unlikely(!temp));
+			smp_llsc_mb();
+		} else {
+			do {
+				__asm__ __volatile__(
+				"	" __LL "%0, %1		# set_bit	\n"
+				"	" __INS "%0, %3, %2, 1			\n"
+				"	" __SC "%0, %1				\n"
+				: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (*m)
+				: "ir" (bit), "r" (~0));
+			} while (unlikely(!temp));
+		}
 #endif /* CONFIG_CPU_MIPSR2 || CONFIG_CPU_MIPSR6 */
 	} else if (kernel_uses_llsc) {
-		do {
-			__asm__ __volatile__(
-			"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"
-			"	" __LL "%0, %1		# set_bit	\n"
-			"	or	%0, %2				\n"
-			"	" __SC	"%0, %1				\n"
-			"	.set	mips0				\n"
-			: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (*m)
-			: "ir" (1UL << bit));
-		} while (unlikely(!temp));
+		if (LOONGSON_LLSC_WAR) {
+			do {
+				__asm__ __volatile__(
+				"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"
+				__WEAK_LLSC_MB
+				"	" __LL "%0, %1		# set_bit	\n"
+				"	or	%0, %2				\n"
+				"	" __SC	"%0, %1				\n"
+				"	.set	mips0				\n"
+				: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (*m)
+				: "ir" (1UL << bit));
+			} while (unlikely(!temp));
+			smp_llsc_mb();
+		} else {
+			do {
+				__asm__ __volatile__(
+				"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"
+				"	" __LL "%0, %1		# set_bit	\n"
+				"	or	%0, %2				\n"
+				"	" __SC	"%0, %1				\n"
+				"	.set	mips0				\n"
+				: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (*m)
+				: "ir" (1UL << bit));
+			} while (unlikely(!temp));
+		}
 	} else
 		__mips_set_bit(nr, addr);
 }
@@ -120,26 +148,54 @@ static inline void clear_bit(unsigned long nr, volatile unsigned long *addr)
 		: "ir" (~(1UL << bit)));
 #if defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_MIPSR6)
 	} else if (kernel_uses_llsc && __builtin_constant_p(bit)) {
-		do {
-			__asm__ __volatile__(
-			"	" __LL "%0, %1		# clear_bit	\n"
-			"	" __INS "%0, $0, %2, 1			\n"
-			"	" __SC "%0, %1				\n"
-			: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (*m)
-			: "ir" (bit));
-		} while (unlikely(!temp));
+		if (LOONGSON_LLSC_WAR) {
+			do {
+				__asm__ __volatile__(
+				__WEAK_LLSC_MB
+				"	" __LL "%0, %1		# clear_bit	\n"
+				"	" __INS "%0, $0, %2, 1			\n"
+				"	" __SC "%0, %1				\n"
+				: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (*m)
+				: "ir" (bit));
+			} while (unlikely(!temp));
+			smp_llsc_mb();
+		} else {
+			do {
+				__asm__ __volatile__(
+				"	" __LL "%0, %1		# clear_bit	\n"
+				"	" __INS "%0, $0, %2, 1			\n"
+				"	" __SC "%0, %1				\n"
+				: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (*m)
+				: "ir" (bit));
+			} while (unlikely(!temp));
+		}
 #endif /* CONFIG_CPU_MIPSR2 || CONFIG_CPU_MIPSR6 */
 	} else if (kernel_uses_llsc) {
-		do {
-			__asm__ __volatile__(
-			"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"
-			"	" __LL "%0, %1		# clear_bit	\n"
-			"	and	%0, %2				\n"
-			"	" __SC "%0, %1				\n"
-			"	.set	mips0				\n"
-			: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (*m)
-			: "ir" (~(1UL << bit)));
-		} while (unlikely(!temp));
+		if (LOONGSON_LLSC_WAR) {
+			do {
+				__asm__ __volatile__(
+				"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"
+				__WEAK_LLSC_MB
+				"	" __LL "%0, %1		# clear_bit	\n"
+				"	and	%0, %2				\n"
+				"	" __SC "%0, %1				\n"
+				"	.set	mips0				\n"
+				: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (*m)
+				: "ir" (~(1UL << bit)));
+			} while (unlikely(!temp));
+			smp_llsc_mb();
+		} else {
+			do {
+				__asm__ __volatile__(
+				"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"
+				"	" __LL "%0, %1		# clear_bit	\n"
+				"	and	%0, %2				\n"
+				"	" __SC "%0, %1				\n"
+				"	.set	mips0				\n"
+				: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (*m)
+				: "ir" (~(1UL << bit)));
+			} while (unlikely(!temp));
+		}
 	} else
 		__mips_clear_bit(nr, addr);
 }
@@ -184,6 +240,23 @@ static inline void change_bit(unsigned long nr, volatile unsigned long *addr)
 		"	.set	mips0				\n"
 		: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (*m)
 		: "ir" (1UL << bit));
+	} else if (kernel_uses_llsc && LOONGSON_LLSC_WAR) {
+		unsigned long *m = ((unsigned long *) addr) + (nr >> SZLONG_LOG);
+		unsigned long temp;
+
+		do {
+			__asm__ __volatile__(
+			"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"
+			__WEAK_LLSC_MB
+			"	" __LL "%0, %1		# change_bit	\n"
+			"	xor	%0, %2				\n"
+			"	" __SC	"%0, %1				\n"
+			"	.set	mips0				\n"
+			: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (*m)
+			: "ir" (1UL << bit));
+		} while (unlikely(!temp));
+
+		smp_llsc_mb();
 	} else if (kernel_uses_llsc) {
 		unsigned long *m = ((unsigned long *) addr) + (nr >> SZLONG_LOG);
 		unsigned long temp;
@@ -233,6 +306,24 @@ static inline int test_and_set_bit(unsigned long nr,
 		: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (*m), "=&r" (res)
 		: "r" (1UL << bit)
 		: "memory");
+	} else if (kernel_uses_llsc && LOONGSON_LLSC_WAR) {
+		unsigned long *m = ((unsigned long *) addr) + (nr >> SZLONG_LOG);
+		unsigned long temp;
+
+		do {
+			__asm__ __volatile__(
+			"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"
+			__WEAK_LLSC_MB
+			"	" __LL "%0, %1	# test_and_set_bit	\n"
+			"	or	%2, %0, %3			\n"
+			"	" __SC	"%2, %1				\n"
+			"	.set	mips0				\n"
+			: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (*m), "=&r" (res)
+			: "r" (1UL << bit)
+			: "memory");
+		} while (unlikely(!res));
+
+		res = temp & (1UL << bit);
 	} else if (kernel_uses_llsc) {
 		unsigned long *m = ((unsigned long *) addr) + (nr >> SZLONG_LOG);
 		unsigned long temp;
@@ -287,6 +378,24 @@ static inline int test_and_set_bit_lock(unsigned long nr,
 		: "=&r" (temp), "+m" (*m), "=&r" (res)
 		: "r" (1UL << bit)
 		: "memory");
+	} else if (kernel_uses_llsc && LOONGSON_LLSC_WAR) {
+		unsigned long *m = ((unsigned long *) addr) + (nr >> SZLONG_LOG);
+		unsigned long temp;
+
+		do {
+			__asm__ __volatile__(
+			"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"
+			__WEAK_LLSC_MB
+			"	" __LL "%0, %1	# test_and_set_bit	\n"
+			"	or	%2, %0, %3			\n"
+			"	" __SC	"%2, %1				\n"
+			"	.set	mips0				\n"
+			: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (*m), "=&r" (res)
+			: "r" (1UL << bit)
+			: "memory");
+		} while (unlikely(!res));
+
+		res = temp & (1UL << bit);
 	} else if (kernel_uses_llsc) {
 		unsigned long *m = ((unsigned long *) addr) + (nr >> SZLONG_LOG);
 		unsigned long temp;
@@ -348,33 +457,63 @@ static inline int test_and_clear_bit(unsigned long nr,
 		unsigned long *m = ((unsigned long *) addr) + (nr >> SZLONG_LOG);
 		unsigned long temp;
 
-		do {
-			__asm__ __volatile__(
-			"	" __LL	"%0, %1 # test_and_clear_bit	\n"
-			"	" __EXT "%2, %0, %3, 1			\n"
-			"	" __INS "%0, $0, %3, 1			\n"
-			"	" __SC	"%0, %1				\n"
-			: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (*m), "=&r" (res)
-			: "ir" (bit)
-			: "memory");
-		} while (unlikely(!temp));
+		if (LOONGSON_LLSC_WAR) {
+			do {
+				__asm__ __volatile__(
+				__WEAK_LLSC_MB
+				"	" __LL	"%0, %1 # test_and_clear_bit	\n"
+				"	" __EXT "%2, %0, %3, 1			\n"
+				"	" __INS "%0, $0, %3, 1			\n"
+				"	" __SC	"%0, %1				\n"
+				: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (*m), "=&r" (res)
+				: "ir" (bit)
+				: "memory");
+			} while (unlikely(!temp));
+		} else {
+			do {
+				__asm__ __volatile__(
+				"	" __LL	"%0, %1 # test_and_clear_bit	\n"
+				"	" __EXT "%2, %0, %3, 1			\n"
+				"	" __INS "%0, $0, %3, 1			\n"
+				"	" __SC	"%0, %1				\n"
+				: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (*m), "=&r" (res)
+				: "ir" (bit)
+				: "memory");
+			} while (unlikely(!temp));
+		}
 #endif
 	} else if (kernel_uses_llsc) {
 		unsigned long *m = ((unsigned long *) addr) + (nr >> SZLONG_LOG);
 		unsigned long temp;
 
-		do {
-			__asm__ __volatile__(
-			"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"
-			"	" __LL	"%0, %1 # test_and_clear_bit	\n"
-			"	or	%2, %0, %3			\n"
-			"	xor	%2, %3				\n"
-			"	" __SC	"%2, %1				\n"
-			"	.set	mips0				\n"
-			: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (*m), "=&r" (res)
-			: "r" (1UL << bit)
-			: "memory");
-		} while (unlikely(!res));
+		if (LOONGSON_LLSC_WAR) {
+			do {
+				__asm__ __volatile__(
+				"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"
+				__WEAK_LLSC_MB
+				"	" __LL	"%0, %1 # test_and_clear_bit	\n"
+				"	or	%2, %0, %3			\n"
+				"	xor	%2, %3				\n"
+				"	" __SC	"%2, %1				\n"
+				"	.set	mips0				\n"
+				: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (*m), "=&r" (res)
+				: "r" (1UL << bit)
+				: "memory");
+			} while (unlikely(!res));
+		} else {
+			do {
+				__asm__ __volatile__(
+				"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"
+				"	" __LL	"%0, %1 # test_and_clear_bit	\n"
+				"	or	%2, %0, %3			\n"
+				"	xor	%2, %3				\n"
+				"	" __SC	"%2, %1				\n"
+				"	.set	mips0				\n"
+				: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (*m), "=&r" (res)
+				: "r" (1UL << bit)
+				: "memory");
+			} while (unlikely(!res));
+		}
 
 		res = temp & (1UL << bit);
 	} else
@@ -416,6 +555,24 @@ static inline int test_and_change_bit(unsigned long nr,
 		: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (*m), "=&r" (res)
 		: "r" (1UL << bit)
 		: "memory");
+	} else if (kernel_uses_llsc && LOONGSON_LLSC_WAR) {
+		unsigned long *m = ((unsigned long *) addr) + (nr >> SZLONG_LOG);
+		unsigned long temp;
+
+		do {
+			__asm__ __volatile__(
+			"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"
+			__WEAK_LLSC_MB
+			"	" __LL	"%0, %1 # test_and_change_bit	\n"
+			"	xor	%2, %0, %3			\n"
+			"	" __SC	"\t%2, %1			\n"
+			"	.set	mips0				\n"
+			: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (*m), "=&r" (res)
+			: "r" (1UL << bit)
+			: "memory");
+		} while (unlikely(!res));
+
+		res = temp & (1UL << bit);
 	} else if (kernel_uses_llsc) {
 		unsigned long *m = ((unsigned long *) addr) + (nr >> SZLONG_LOG);
 		unsigned long temp;
diff --git a/arch/mips/include/asm/cmpxchg.h b/arch/mips/include/asm/cmpxchg.h
index b71ab4a..5bfd70d 100644
--- a/arch/mips/include/asm/cmpxchg.h
+++ b/arch/mips/include/asm/cmpxchg.h
@@ -34,6 +34,24 @@ static inline unsigned long __xchg_u32(volatile int * m, unsigned int val)
 		: "=&r" (retval), "=" GCC_OFF_SMALL_ASM() (*m), "=&r" (dummy)
 		: GCC_OFF_SMALL_ASM() (*m), "Jr" (val)
 		: "memory");
+	} else if (kernel_uses_llsc && LOONGSON_LLSC_WAR) {
+		unsigned long dummy;
+
+		do {
+			__asm__ __volatile__(
+			"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"
+			__WEAK_LLSC_MB
+			"	ll	%0, %3		# xchg_u32	\n"
+			"	.set	mips0				\n"
+			"	move	%2, %z4				\n"
+			"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"
+			"	sc	%2, %1				\n"
+			"	.set	mips0				\n"
+			: "=&r" (retval), "=" GCC_OFF_SMALL_ASM() (*m),
+			  "=&r" (dummy)
+			: GCC_OFF_SMALL_ASM() (*m), "Jr" (val)
+			: "memory");
+		} while (unlikely(!dummy));
 	} else if (kernel_uses_llsc) {
 		unsigned long dummy;
 
@@ -85,6 +103,22 @@ static inline __u64 __xchg_u64(volatile __u64 * m, __u64 val)
 		: "=&r" (retval), "=" GCC_OFF_SMALL_ASM() (*m), "=&r" (dummy)
 		: GCC_OFF_SMALL_ASM() (*m), "Jr" (val)
 		: "memory");
+	} else if (kernel_uses_llsc && LOONGSON_LLSC_WAR) {
+		unsigned long dummy;
+
+		do {
+			__asm__ __volatile__(
+			"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"
+			__WEAK_LLSC_MB
+			"	lld	%0, %3		# xchg_u64	\n"
+			"	move	%2, %z4				\n"
+			"	scd	%2, %1				\n"
+			"	.set	mips0				\n"
+			: "=&r" (retval), "=" GCC_OFF_SMALL_ASM() (*m),
+			  "=&r" (dummy)
+			: GCC_OFF_SMALL_ASM() (*m), "Jr" (val)
+			: "memory");
+		} while (unlikely(!dummy));
 	} else if (kernel_uses_llsc) {
 		unsigned long dummy;
 
@@ -159,6 +193,26 @@ static inline unsigned long __xchg(unsigned long x, volatile void * ptr, int siz
 		: "=&r" (__ret), "=" GCC_OFF_SMALL_ASM() (*m)		\
 		: GCC_OFF_SMALL_ASM() (*m), "Jr" (old), "Jr" (new)		\
 		: "memory");						\
+	} else if (kernel_uses_llsc && LOONGSON_LLSC_WAR) {		\
+		__asm__ __volatile__(					\
+		"	.set	push				\n"	\
+		"	.set	noat				\n"	\
+		"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"	\
+		"1:				# __cmpxchg_asm \n"	\
+		__WEAK_LLSC_MB						\
+		"	" ld "	%0, %2				\n"	\
+		"	bne	%0, %z3, 2f			\n"	\
+		"	.set	mips0				\n"	\
+		"	move	$1, %z4				\n"	\
+		"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"	\
+		"	" st "	$1, %1				\n"	\
+		"	beqz	$1, 1b				\n"	\
+		"	.set	pop				\n"	\
+		"2:						\n"	\
+		__WEAK_LLSC_MB						\
+		: "=&r" (__ret), "=" GCC_OFF_SMALL_ASM() (*m)		\
+		: GCC_OFF_SMALL_ASM() (*m), "Jr" (old), "Jr" (new)		\
+		: "memory");						\
 	} else if (kernel_uses_llsc) {					\
 		__asm__ __volatile__(					\
 		"	.set	push				\n"	\
diff --git a/arch/mips/include/asm/edac.h b/arch/mips/include/asm/edac.h
index 980b165..a864aa9 100644
--- a/arch/mips/include/asm/edac.h
+++ b/arch/mips/include/asm/edac.h
@@ -19,15 +19,30 @@ static inline void edac_atomic_scrub(void *va, u32 size)
 		 * Intel: asm("lock; addl $0, %0"::"m"(*virt_addr));
 		 */
 
-		__asm__ __volatile__ (
-		"	.set	mips2					\n"
-		"1:	ll	%0, %1		# edac_atomic_scrub	\n"
-		"	addu	%0, $0					\n"
-		"	sc	%0, %1					\n"
-		"	beqz	%0, 1b					\n"
-		"	.set	mips0					\n"
-		: "=&r" (temp), "=" GCC_OFF_SMALL_ASM() (*virt_addr)
-		: GCC_OFF_SMALL_ASM() (*virt_addr));
+		if (LOONGSON_LLSC_WAR) {
+			__asm__ __volatile__ (
+			"	.set	mips2					\n"
+			"1:				# edac_atomic_scrub	\n"
+			__WEAK_LLSC_MB
+			"	ll	%0, %1					\n"
+			"	addu	%0, $0					\n"
+			"	sc	%0, %1					\n"
+			"	beqz	%0, 1b					\n"
+			"	.set	mips0					\n"
+			: "=&r" (temp), "=" GCC_OFF_SMALL_ASM() (*virt_addr)
+			: GCC_OFF_SMALL_ASM() (*virt_addr));
+			smp_llsc_mb();
+		} else {
+			__asm__ __volatile__ (
+			"	.set	mips2					\n"
+			"1:	ll	%0, %1		# edac_atomic_scrub	\n"
+			"	addu	%0, $0					\n"
+			"	sc	%0, %1					\n"
+			"	beqz	%0, 1b					\n"
+			"	.set	mips0					\n"
+			: "=&r" (temp), "=" GCC_OFF_SMALL_ASM() (*virt_addr)
+			: GCC_OFF_SMALL_ASM() (*virt_addr));
+		}
 
 		virt_addr++;
 	}
diff --git a/arch/mips/include/asm/futex.h b/arch/mips/include/asm/futex.h
index 1de190b..3e2741f 100644
--- a/arch/mips/include/asm/futex.h
+++ b/arch/mips/include/asm/futex.h
@@ -49,6 +49,37 @@
 		: "0" (0), GCC_OFF_SMALL_ASM() (*uaddr), "Jr" (oparg),	\
 		  "i" (-EFAULT)						\
 		: "memory");						\
+	} else if (cpu_has_llsc && LOONGSON_LLSC_WAR) {					\
+		__asm__ __volatile__(					\
+		"	.set	push				\n"	\
+		"	.set	noat				\n"	\
+		"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"	\
+		"1:				 # __futex_atomic_op\n"	\
+		__WEAK_LLSC_MB						\
+		"	"user_ll("%1", "%4")"			\n"	\
+		"	.set	mips0				\n"	\
+		"	" insn	"				\n"	\
+		"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"	\
+		"2:	"user_sc("$1", "%2")"			\n"	\
+		"	beqz	$1, 1b				\n"	\
+		__WEAK_LLSC_MB						\
+		"3:						\n"	\
+		"	.insn					\n"	\
+		"	.set	pop				\n"	\
+		"	.set	mips0				\n"	\
+		"	.section .fixup,\"ax\"			\n"	\
+		"4:	li	%0, %6				\n"	\
+		"	j	3b				\n"	\
+		"	.previous				\n"	\
+		"	.section __ex_table,\"a\"		\n"	\
+		"	"__UA_ADDR "\t(1b + 4), 4b		\n"	\
+		"	"__UA_ADDR "\t(2b + 0), 4b		\n"	\
+		"	.previous				\n"	\
+		: "=r" (ret), "=&r" (oldval),				\
+		  "=" GCC_OFF_SMALL_ASM() (*uaddr)				\
+		: "0" (0), GCC_OFF_SMALL_ASM() (*uaddr), "Jr" (oparg),	\
+		  "i" (-EFAULT)						\
+		: "memory");						\
 	} else if (cpu_has_llsc) {					\
 		__asm__ __volatile__(					\
 		"	.set	push				\n"	\
@@ -178,6 +209,37 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 		: GCC_OFF_SMALL_ASM() (*uaddr), "Jr" (oldval), "Jr" (newval),
 		  "i" (-EFAULT)
 		: "memory");
+	} else if (cpu_has_llsc && LOONGSON_LLSC_WAR) {
+		__asm__ __volatile__(
+		"# futex_atomic_cmpxchg_inatomic			\n"
+		"	.set	push					\n"
+		"	.set	noat					\n"
+		"	.set	"MIPS_ISA_ARCH_LEVEL"			\n"
+		"1:							\n"
+		__WEAK_LLSC_MB
+		"	"user_ll("%1", "%3")"				\n"
+		"	bne	%1, %z4, 3f				\n"
+		"	.set	mips0					\n"
+		"	move	$1, %z5					\n"
+		"	.set	"MIPS_ISA_ARCH_LEVEL"			\n"
+		"2:	"user_sc("$1", "%2")"				\n"
+		"	beqz	$1, 1b					\n"
+		__WEAK_LLSC_MB
+		"3:							\n"
+		"	.insn						\n"
+		"	.set	pop					\n"
+		"	.section .fixup,\"ax\"				\n"
+		"4:	li	%0, %6					\n"
+		"	j	3b					\n"
+		"	.previous					\n"
+		"	.section __ex_table,\"a\"			\n"
+		"	"__UA_ADDR "\t(1b + 4), 4b			\n"
+		"	"__UA_ADDR "\t(2b + 0), 4b			\n"
+		"	.previous					\n"
+		: "+r" (ret), "=&r" (val), "=" GCC_OFF_SMALL_ASM() (*uaddr)
+		: GCC_OFF_SMALL_ASM() (*uaddr), "Jr" (oldval), "Jr" (newval),
+		  "i" (-EFAULT)
+		: "memory");
 	} else if (cpu_has_llsc) {
 		__asm__ __volatile__(
 		"# futex_atomic_cmpxchg_inatomic			\n"
diff --git a/arch/mips/include/asm/local.h b/arch/mips/include/asm/local.h
index 8feaed6..a6e9d06 100644
--- a/arch/mips/include/asm/local.h
+++ b/arch/mips/include/asm/local.h
@@ -44,6 +44,23 @@ static __inline__ long local_add_return(long i, local_t * l)
 		: "=&r" (result), "=&r" (temp), "=m" (l->a.counter)
 		: "Ir" (i), "m" (l->a.counter)
 		: "memory");
+	} else if (kernel_uses_llsc && LOONGSON_LLSC_WAR) {
+		unsigned long temp;
+
+		__asm__ __volatile__(
+		"	.set	"MIPS_ISA_ARCH_LEVEL"			\n"
+		"1:							\n"
+			__WEAK_LLSC_MB
+			__LL	"%1, %2		# local_add_return	\n"
+		"	addu	%0, %1, %3				\n"
+			__SC	"%0, %2					\n"
+		"	beqz	%0, 1b					\n"
+		"	addu	%0, %1, %3				\n"
+		"	.set	mips0					\n"
+		: "=&r" (result), "=&r" (temp), "=m" (l->a.counter)
+		: "Ir" (i), "m" (l->a.counter)
+		: "memory");
+		smp_llsc_mb();
 	} else if (kernel_uses_llsc) {
 		unsigned long temp;
 
@@ -89,6 +106,23 @@ static __inline__ long local_sub_return(long i, local_t * l)
 		: "=&r" (result), "=&r" (temp), "=m" (l->a.counter)
 		: "Ir" (i), "m" (l->a.counter)
 		: "memory");
+	} else if (kernel_uses_llsc && LOONGSON_LLSC_WAR) {
+		unsigned long temp;
+
+		__asm__ __volatile__(
+		"	.set	"MIPS_ISA_ARCH_LEVEL"			\n"
+		"1:							\n"
+			__WEAK_LLSC_MB
+			__LL	"%1, %2		# local_sub_return	\n"
+		"	subu	%0, %1, %3				\n"
+			__SC	"%0, %2					\n"
+		"	beqz	%0, 1b					\n"
+		"	subu	%0, %1, %3				\n"
+		"	.set	mips0					\n"
+		: "=&r" (result), "=&r" (temp), "=m" (l->a.counter)
+		: "Ir" (i), "m" (l->a.counter)
+		: "memory");
+		smp_llsc_mb();
 	} else if (kernel_uses_llsc) {
 		unsigned long temp;
 
diff --git a/arch/mips/include/asm/mach-cavium-octeon/war.h b/arch/mips/include/asm/mach-cavium-octeon/war.h
index 35c80be..1c43fb2 100644
--- a/arch/mips/include/asm/mach-cavium-octeon/war.h
+++ b/arch/mips/include/asm/mach-cavium-octeon/war.h
@@ -20,6 +20,7 @@
 #define TX49XX_ICACHE_INDEX_INV_WAR	0
 #define ICACHE_REFILLS_WORKAROUND_WAR	0
 #define R10000_LLSC_WAR			0
+#define LOONGSON_LLSC_WAR		0
 #define MIPS34K_MISSED_ITLB_WAR		0
 
 #define CAVIUM_OCTEON_DCACHE_PREFETCH_WAR	\
diff --git a/arch/mips/include/asm/mach-generic/war.h b/arch/mips/include/asm/mach-generic/war.h
index a1bc2e7..2dd9bf5 100644
--- a/arch/mips/include/asm/mach-generic/war.h
+++ b/arch/mips/include/asm/mach-generic/war.h
@@ -19,6 +19,7 @@
 #define TX49XX_ICACHE_INDEX_INV_WAR	0
 #define ICACHE_REFILLS_WORKAROUND_WAR	0
 #define R10000_LLSC_WAR			0
+#define LOONGSON_LLSC_WAR		0
 #define MIPS34K_MISSED_ITLB_WAR		0
 
 #endif /* __ASM_MACH_GENERIC_WAR_H */
diff --git a/arch/mips/include/asm/mach-ip22/war.h b/arch/mips/include/asm/mach-ip22/war.h
index fba6405..66ddafa 100644
--- a/arch/mips/include/asm/mach-ip22/war.h
+++ b/arch/mips/include/asm/mach-ip22/war.h
@@ -23,6 +23,7 @@
 #define TX49XX_ICACHE_INDEX_INV_WAR	0
 #define ICACHE_REFILLS_WORKAROUND_WAR	0
 #define R10000_LLSC_WAR			0
+#define LOONGSON_LLSC_WAR		0
 #define MIPS34K_MISSED_ITLB_WAR		0
 
 #endif /* __ASM_MIPS_MACH_IP22_WAR_H */
diff --git a/arch/mips/include/asm/mach-ip27/war.h b/arch/mips/include/asm/mach-ip27/war.h
index 4ee0e4b..63ee1e5 100644
--- a/arch/mips/include/asm/mach-ip27/war.h
+++ b/arch/mips/include/asm/mach-ip27/war.h
@@ -19,6 +19,7 @@
 #define TX49XX_ICACHE_INDEX_INV_WAR	0
 #define ICACHE_REFILLS_WORKAROUND_WAR	0
 #define R10000_LLSC_WAR			1
+#define LOONGSON_LLSC_WAR		0
 #define MIPS34K_MISSED_ITLB_WAR		0
 
 #endif /* __ASM_MIPS_MACH_IP27_WAR_H */
diff --git a/arch/mips/include/asm/mach-ip28/war.h b/arch/mips/include/asm/mach-ip28/war.h
index 4821c7b..e455320 100644
--- a/arch/mips/include/asm/mach-ip28/war.h
+++ b/arch/mips/include/asm/mach-ip28/war.h
@@ -19,6 +19,7 @@
 #define TX49XX_ICACHE_INDEX_INV_WAR	0
 #define ICACHE_REFILLS_WORKAROUND_WAR	0
 #define R10000_LLSC_WAR			1
+#define LOONGSON_LLSC_WAR		0
 #define MIPS34K_MISSED_ITLB_WAR		0
 
 #endif /* __ASM_MIPS_MACH_IP28_WAR_H */
diff --git a/arch/mips/include/asm/mach-ip32/war.h b/arch/mips/include/asm/mach-ip32/war.h
index 9807ecd..2bd4caf 100644
--- a/arch/mips/include/asm/mach-ip32/war.h
+++ b/arch/mips/include/asm/mach-ip32/war.h
@@ -19,6 +19,7 @@
 #define TX49XX_ICACHE_INDEX_INV_WAR	0
 #define ICACHE_REFILLS_WORKAROUND_WAR	1
 #define R10000_LLSC_WAR			0
+#define LOONGSON_LLSC_WAR		0
 #define MIPS34K_MISSED_ITLB_WAR		0
 
 #endif /* __ASM_MIPS_MACH_IP32_WAR_H */
diff --git a/arch/mips/include/asm/mach-loongson64/war.h b/arch/mips/include/asm/mach-loongson64/war.h
new file mode 100644
index 0000000..c5f9aaa
--- /dev/null
+++ b/arch/mips/include/asm/mach-loongson64/war.h
@@ -0,0 +1,26 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2002, 2004, 2007 by Ralf Baechle <ralf@linux-mips.org>
+ * Copyright (C) 2015, 2016 by Huacai Chen <chenhc@lemote.com>
+ */
+#ifndef __ASM_MIPS_MACH_LOONGSON64_WAR_H
+#define __ASM_MIPS_MACH_LOONGSON64_WAR_H
+
+#define R4600_V1_INDEX_ICACHEOP_WAR	0
+#define R4600_V1_HIT_CACHEOP_WAR	0
+#define R4600_V2_HIT_CACHEOP_WAR	0
+#define R5432_CP0_INTERRUPT_WAR		0
+#define BCM1250_M3_WAR			0
+#define SIBYTE_1956_WAR			0
+#define MIPS4K_ICACHE_REFILL_WAR	0
+#define MIPS_CACHE_SYNC_WAR		0
+#define TX49XX_ICACHE_INDEX_INV_WAR	0
+#define ICACHE_REFILLS_WORKAROUND_WAR	0
+#define R10000_LLSC_WAR			0
+#define LOONGSON_LLSC_WAR		IS_ENABLED(CONFIG_CPU_LOONGSON3)
+#define MIPS34K_MISSED_ITLB_WAR		0
+
+#endif /* __ASM_MIPS_MACH_LOONGSON64_WAR_H */
diff --git a/arch/mips/include/asm/mach-malta/war.h b/arch/mips/include/asm/mach-malta/war.h
index d068fc4..c380825 100644
--- a/arch/mips/include/asm/mach-malta/war.h
+++ b/arch/mips/include/asm/mach-malta/war.h
@@ -19,6 +19,7 @@
 #define TX49XX_ICACHE_INDEX_INV_WAR	0
 #define ICACHE_REFILLS_WORKAROUND_WAR	1
 #define R10000_LLSC_WAR			0
+#define LOONGSON_LLSC_WAR		0
 #define MIPS34K_MISSED_ITLB_WAR		0
 
 #endif /* __ASM_MIPS_MACH_MIPS_WAR_H */
diff --git a/arch/mips/include/asm/mach-pmcs-msp71xx/war.h b/arch/mips/include/asm/mach-pmcs-msp71xx/war.h
index a60bf9d..8c5f396 100644
--- a/arch/mips/include/asm/mach-pmcs-msp71xx/war.h
+++ b/arch/mips/include/asm/mach-pmcs-msp71xx/war.h
@@ -19,6 +19,7 @@
 #define TX49XX_ICACHE_INDEX_INV_WAR	0
 #define ICACHE_REFILLS_WORKAROUND_WAR	0
 #define R10000_LLSC_WAR			0
+#define LOONGSON_LLSC_WAR		0
 #if defined(CONFIG_PMC_MSP7120_EVAL) || defined(CONFIG_PMC_MSP7120_GW) || \
 	defined(CONFIG_PMC_MSP7120_FPGA)
 #define MIPS34K_MISSED_ITLB_WAR		1
diff --git a/arch/mips/include/asm/mach-rc32434/war.h b/arch/mips/include/asm/mach-rc32434/war.h
index 1bfd489a..72d2926 100644
--- a/arch/mips/include/asm/mach-rc32434/war.h
+++ b/arch/mips/include/asm/mach-rc32434/war.h
@@ -19,6 +19,7 @@
 #define TX49XX_ICACHE_INDEX_INV_WAR	0
 #define ICACHE_REFILLS_WORKAROUND_WAR	0
 #define R10000_LLSC_WAR			0
+#define LOONGSON_LLSC_WAR		0
 #define MIPS34K_MISSED_ITLB_WAR		0
 
 #endif /* __ASM_MIPS_MACH_MIPS_WAR_H */
diff --git a/arch/mips/include/asm/mach-rm/war.h b/arch/mips/include/asm/mach-rm/war.h
index a3dde98..5683389 100644
--- a/arch/mips/include/asm/mach-rm/war.h
+++ b/arch/mips/include/asm/mach-rm/war.h
@@ -23,6 +23,7 @@
 #define TX49XX_ICACHE_INDEX_INV_WAR	0
 #define ICACHE_REFILLS_WORKAROUND_WAR	0
 #define R10000_LLSC_WAR			0
+#define LOONGSON_LLSC_WAR		0
 #define MIPS34K_MISSED_ITLB_WAR		0
 
 #endif /* __ASM_MIPS_MACH_RM_WAR_H */
diff --git a/arch/mips/include/asm/mach-sibyte/war.h b/arch/mips/include/asm/mach-sibyte/war.h
index 520f8fc..b9d7bcb 100644
--- a/arch/mips/include/asm/mach-sibyte/war.h
+++ b/arch/mips/include/asm/mach-sibyte/war.h
@@ -34,6 +34,7 @@ extern int sb1250_m3_workaround_needed(void);
 #define TX49XX_ICACHE_INDEX_INV_WAR	0
 #define ICACHE_REFILLS_WORKAROUND_WAR	0
 #define R10000_LLSC_WAR			0
+#define LOONGSON_LLSC_WAR		0
 #define MIPS34K_MISSED_ITLB_WAR		0
 
 #endif /* __ASM_MIPS_MACH_SIBYTE_WAR_H */
diff --git a/arch/mips/include/asm/mach-tx49xx/war.h b/arch/mips/include/asm/mach-tx49xx/war.h
index a8e2c58..fd44710 100644
--- a/arch/mips/include/asm/mach-tx49xx/war.h
+++ b/arch/mips/include/asm/mach-tx49xx/war.h
@@ -19,6 +19,7 @@
 #define TX49XX_ICACHE_INDEX_INV_WAR	1
 #define ICACHE_REFILLS_WORKAROUND_WAR	0
 #define R10000_LLSC_WAR			0
+#define LOONGSON_LLSC_WAR		0
 #define MIPS34K_MISSED_ITLB_WAR		0
 
 #endif /* __ASM_MIPS_MACH_TX49XX_WAR_H */
diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
index 9e9e944..d534185 100644
--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -228,6 +228,25 @@ static inline void set_pte(pte_t *ptep, pte_t pteval)
 			"	.set	mips0				\n"
 			: [buddy] "+m" (buddy->pte), [tmp] "=&r" (tmp)
 			: [global] "r" (page_global));
+		} else if (kernel_uses_llsc && LOONGSON_LLSC_WAR) {
+			__asm__ __volatile__ (
+			"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"
+			"	.set	push				\n"
+			"	.set	noreorder			\n"
+			"1:						\n"
+				__WEAK_LLSC_MB
+				__LL	"%[tmp], %[buddy]		\n"
+			"	bnez	%[tmp], 2f			\n"
+			"	 or	%[tmp], %[tmp], %[global]	\n"
+				__SC	"%[tmp], %[buddy]		\n"
+			"	beqz	%[tmp], 1b			\n"
+			"	nop					\n"
+			"2:						\n"
+			"	.set	pop				\n"
+			"	.set	mips0				\n"
+			: [buddy] "+m" (buddy->pte), [tmp] "=&r" (tmp)
+			: [global] "r" (page_global));
+			smp_llsc_mb();
 		} else if (kernel_uses_llsc) {
 			__asm__ __volatile__ (
 			"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"
diff --git a/arch/mips/include/asm/spinlock.h b/arch/mips/include/asm/spinlock.h
index a8df44d..1e44b76 100644
--- a/arch/mips/include/asm/spinlock.h
+++ b/arch/mips/include/asm/spinlock.h
@@ -114,6 +114,41 @@ static inline void arch_spin_lock(arch_spinlock_t *lock)
 		  [ticket] "=&r" (tmp),
 		  [my_ticket] "=&r" (my_ticket)
 		: [inc] "r" (inc));
+	} else if (LOONGSON_LLSC_WAR) {
+		__asm__ __volatile__ (
+		"	.set push		# arch_spin_lock	\n"
+		"	.set noreorder					\n"
+		"							\n"
+		"1:							\n"
+		__WEAK_LLSC_MB
+		"	ll	%[ticket], %[ticket_ptr]		\n"
+		"	addu	%[my_ticket], %[ticket], %[inc]		\n"
+		"	sc	%[my_ticket], %[ticket_ptr]		\n"
+		"	beqz	%[my_ticket], 1b			\n"
+		"	 srl	%[my_ticket], %[ticket], 16		\n"
+		"	andi	%[ticket], %[ticket], 0xffff		\n"
+		"	bne	%[ticket], %[my_ticket], 4f		\n"
+		"	 subu	%[ticket], %[my_ticket], %[ticket]	\n"
+		"2:							\n"
+		"	.subsection 2					\n"
+		"4:	andi	%[ticket], %[ticket], 0xffff		\n"
+		"	sll	%[ticket], 5				\n"
+		"							\n"
+		"6:	bnez	%[ticket], 6b				\n"
+		"	 subu	%[ticket], 1				\n"
+		"							\n"
+		"	lhu	%[ticket], %[serving_now_ptr]		\n"
+		"	beq	%[ticket], %[my_ticket], 2b		\n"
+		"	 subu	%[ticket], %[my_ticket], %[ticket]	\n"
+		"	b	4b					\n"
+		"	 subu	%[ticket], %[ticket], 1			\n"
+		"	.previous					\n"
+		"	.set pop					\n"
+		: [ticket_ptr] "+" GCC_OFF_SMALL_ASM() (lock->lock),
+		  [serving_now_ptr] "+m" (lock->h.serving_now),
+		  [ticket] "=&r" (tmp),
+		  [my_ticket] "=&r" (my_ticket)
+		: [inc] "r" (inc));
 	} else {
 		__asm__ __volatile__ (
 		"	.set push		# arch_spin_lock	\n"
@@ -189,6 +224,32 @@ static inline unsigned int arch_spin_trylock(arch_spinlock_t *lock)
 		  [my_ticket] "=&r" (tmp2),
 		  [now_serving] "=&r" (tmp3)
 		: [inc] "r" (inc));
+	} if (LOONGSON_LLSC_WAR) {
+		__asm__ __volatile__ (
+		"	.set push		# arch_spin_trylock	\n"
+		"	.set noreorder					\n"
+		"							\n"
+		"1:							\n"
+		__WEAK_LLSC_MB
+		"	ll	%[ticket], %[ticket_ptr]		\n"
+		"	srl	%[my_ticket], %[ticket], 16		\n"
+		"	andi	%[now_serving], %[ticket], 0xffff	\n"
+		"	bne	%[my_ticket], %[now_serving], 3f	\n"
+		"	 addu	%[ticket], %[ticket], %[inc]		\n"
+		"	sc	%[ticket], %[ticket_ptr]		\n"
+		"	beqz	%[ticket], 1b				\n"
+		"	 li	%[ticket], 1				\n"
+		"2:							\n"
+		"	.subsection 2					\n"
+		"3:	b	2b					\n"
+		"	 li	%[ticket], 0				\n"
+		"	.previous					\n"
+		"	.set pop					\n"
+		: [ticket_ptr] "+" GCC_OFF_SMALL_ASM() (lock->lock),
+		  [ticket] "=&r" (tmp),
+		  [my_ticket] "=&r" (tmp2),
+		  [now_serving] "=&r" (tmp3)
+		: [inc] "r" (inc));
 	} else {
 		__asm__ __volatile__ (
 		"	.set push		# arch_spin_trylock	\n"
@@ -258,6 +319,19 @@ static inline void arch_read_lock(arch_rwlock_t *rw)
 		: "=" GCC_OFF_SMALL_ASM() (rw->lock), "=&r" (tmp)
 		: GCC_OFF_SMALL_ASM() (rw->lock)
 		: "memory");
+	} else if (LOONGSON_LLSC_WAR) {
+		do {
+			__asm__ __volatile__(
+			"1:			# arch_read_lock	\n"
+			__WEAK_LLSC_MB
+			"	ll	%1, %2				\n"
+			"	bltz	%1, 1b				\n"
+			"	 addu	%1, 1				\n"
+			"2:	sc	%1, %0				\n"
+			: "=" GCC_OFF_SMALL_ASM() (rw->lock), "=&r" (tmp)
+			: GCC_OFF_SMALL_ASM() (rw->lock)
+			: "memory");
+		} while (unlikely(!tmp));
 	} else {
 		do {
 			__asm__ __volatile__(
@@ -289,6 +363,20 @@ static inline void arch_read_unlock(arch_rwlock_t *rw)
 		: "=" GCC_OFF_SMALL_ASM() (rw->lock), "=&r" (tmp)
 		: GCC_OFF_SMALL_ASM() (rw->lock)
 		: "memory");
+	} else if (LOONGSON_LLSC_WAR) {
+		do {
+			__asm__ __volatile__(
+			"1:			# arch_read_unlock	\n"
+			__WEAK_LLSC_MB
+			"	ll	%1, %2				\n"
+			"	addiu	%1, -1				\n"
+			"	sc	%1, %0				\n"
+			: "=" GCC_OFF_SMALL_ASM() (rw->lock), "=&r" (tmp)
+			: GCC_OFF_SMALL_ASM() (rw->lock)
+			: "memory");
+		} while (unlikely(!tmp));
+
+		smp_llsc_mb();
 	} else {
 		do {
 			__asm__ __volatile__(
@@ -319,6 +407,19 @@ static inline void arch_write_lock(arch_rwlock_t *rw)
 		: "=" GCC_OFF_SMALL_ASM() (rw->lock), "=&r" (tmp)
 		: GCC_OFF_SMALL_ASM() (rw->lock)
 		: "memory");
+	} else if (LOONGSON_LLSC_WAR) {
+		do {
+			__asm__ __volatile__(
+			"1:			# arch_write_lock	\n"
+			__WEAK_LLSC_MB
+			"	ll	%1, %2				\n"
+			"	bnez	%1, 1b				\n"
+			"	 lui	%1, 0x8000			\n"
+			"2:	sc	%1, %0				\n"
+			: "=" GCC_OFF_SMALL_ASM() (rw->lock), "=&r" (tmp)
+			: GCC_OFF_SMALL_ASM() (rw->lock)
+			: "memory");
+		} while (unlikely(!tmp));
 	} else {
 		do {
 			__asm__ __volatile__(
@@ -345,6 +446,8 @@ static inline void arch_write_unlock(arch_rwlock_t *rw)
 	: "=m" (rw->lock)
 	: "m" (rw->lock)
 	: "memory");
+
+	nudge_writes();
 }
 
 static inline int arch_read_trylock(arch_rwlock_t *rw)
@@ -369,6 +472,27 @@ static inline int arch_read_trylock(arch_rwlock_t *rw)
 		: "=" GCC_OFF_SMALL_ASM() (rw->lock), "=&r" (tmp), "=&r" (ret)
 		: GCC_OFF_SMALL_ASM() (rw->lock)
 		: "memory");
+	} else if (LOONGSON_LLSC_WAR) {
+		__asm__ __volatile__(
+		"	.set	noreorder	# arch_read_trylock	\n"
+		"	li	%2, 0					\n"
+		"1:							\n"
+		__WEAK_LLSC_MB
+		"	ll	%1, %3					\n"
+		"	bltz	%1, 2f					\n"
+		"	 addu	%1, 1					\n"
+		"	sc	%1, %0					\n"
+		"	beqz	%1, 1b					\n"
+		"	 nop						\n"
+		"	.set	reorder					\n"
+		__WEAK_LLSC_MB
+		"	li	%2, 1					\n"
+		"2:							\n"
+		: "=" GCC_OFF_SMALL_ASM() (rw->lock), "=&r" (tmp), "=&r" (ret)
+		: GCC_OFF_SMALL_ASM() (rw->lock)
+		: "memory");
+
+		smp_llsc_mb();
 	} else {
 		__asm__ __volatile__(
 		"	.set	noreorder	# arch_read_trylock	\n"
@@ -413,6 +537,24 @@ static inline int arch_write_trylock(arch_rwlock_t *rw)
 		: "=" GCC_OFF_SMALL_ASM() (rw->lock), "=&r" (tmp), "=&r" (ret)
 		: GCC_OFF_SMALL_ASM() (rw->lock)
 		: "memory");
+	} else if (LOONGSON_LLSC_WAR) {
+		do {
+			__asm__ __volatile__(
+			__WEAK_LLSC_MB
+			"	ll	%1, %3	# arch_write_trylock	\n"
+			"	li	%2, 0				\n"
+			"	bnez	%1, 2f				\n"
+			"	lui	%1, 0x8000			\n"
+			"	sc	%1, %0				\n"
+			"	li	%2, 1				\n"
+			"2:						\n"
+			: "=" GCC_OFF_SMALL_ASM() (rw->lock), "=&r" (tmp),
+			  "=&r" (ret)
+			: GCC_OFF_SMALL_ASM() (rw->lock)
+			: "memory");
+		} while (unlikely(!tmp));
+
+		smp_llsc_mb();
 	} else {
 		do {
 			__asm__ __volatile__(
diff --git a/arch/mips/include/asm/war.h b/arch/mips/include/asm/war.h
index 9344e24..2fe696a 100644
--- a/arch/mips/include/asm/war.h
+++ b/arch/mips/include/asm/war.h
@@ -227,6 +227,14 @@
 #endif
 
 /*
+ * On the Loongson-2G/2H/3A/3B there is a bug that ll / sc and lld / scd is
+ * very weak ordering.
+ */
+#ifndef LOONGSON_LLSC_WAR
+#error Check setting of LOONGSON_LLSC_WAR for your platform
+#endif
+
+/*
  * 34K core erratum: "Problems Executing the TLBR Instruction"
  */
 #ifndef MIPS34K_MISSED_ITLB_WAR
diff --git a/arch/mips/kernel/syscall.c b/arch/mips/kernel/syscall.c
index f1d17ec..8480ac4 100644
--- a/arch/mips/kernel/syscall.c
+++ b/arch/mips/kernel/syscall.c
@@ -127,6 +127,40 @@ static inline int mips_atomic_set(unsigned long addr, unsigned long new)
 		  [new] "r" (new),
 		  [efault] "i" (-EFAULT)
 		: "memory");
+	} else if (cpu_has_llsc && LOONGSON_LLSC_WAR) {
+		__asm__ __volatile__ (
+		"	.set	"MIPS_ISA_ARCH_LEVEL"			\n"
+		"	li	%[err], 0				\n"
+		"1:							\n"
+		__WEAK_LLSC_MB
+		"	ll	%[old], (%[addr])			\n"
+		"	move	%[tmp], %[new]				\n"
+		"2:	sc	%[tmp], (%[addr])			\n"
+		"	bnez	%[tmp], 4f				\n"
+		"3:							\n"
+		"	.insn						\n"
+		"	.subsection 2					\n"
+		"4:	b	1b					\n"
+		"	.previous					\n"
+		"							\n"
+		"	.section .fixup,\"ax\"				\n"
+		"5:	li	%[err], %[efault]			\n"
+		"	j	3b					\n"
+		"	.previous					\n"
+		"	.section __ex_table,\"a\"			\n"
+		"	"STR(PTR)"	(1b + 4), 5b			\n"
+		"	"STR(PTR)"	(2b + 0), 5b			\n"
+		"	.previous					\n"
+		"	.set	mips0					\n"
+		: [old] "=&r" (old),
+		  [err] "=&r" (err),
+		  [tmp] "=&r" (tmp)
+		: [addr] "r" (addr),
+		  [new] "r" (new),
+		  [efault] "i" (-EFAULT)
+		: "memory");
+
+		smp_llsc_mb();
 	} else if (cpu_has_llsc) {
 		__asm__ __volatile__ (
 		"	.set	"MIPS_ISA_ARCH_LEVEL"			\n"
diff --git a/arch/mips/loongson64/Platform b/arch/mips/loongson64/Platform
index 0fce460..3700dcf 100644
--- a/arch/mips/loongson64/Platform
+++ b/arch/mips/loongson64/Platform
@@ -23,6 +23,9 @@ ifdef CONFIG_CPU_LOONGSON2F_WORKAROUNDS
 endif
 
 cflags-$(CONFIG_CPU_LOONGSON3)	+= -Wa,--trap
+ifneq ($(call as-option,-Wa$(comma)-mfix-loongson3-llsc,),)
+  cflags-$(CONFIG_CPU_LOONGSON3) += -Wa$(comma)-mno-fix-loongson3-llsc
+endif
 #
 # binutils from v2.25 on and gcc starting from v4.9.0 treat -march=loongson3a
 # as MIPS64 R2; older versions as just R1.  This leaves the possibility open
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index ed1c529..2ed9a88 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -92,6 +92,11 @@ static inline int __maybe_unused r10000_llsc_war(void)
 	return R10000_LLSC_WAR;
 }
 
+static inline int __maybe_unused loongson_llsc_war(void)
+{
+       return LOONGSON_LLSC_WAR;
+}
+
 static int use_bbit_insns(void)
 {
 	switch (current_cpu_type()) {
@@ -936,6 +941,8 @@ build_get_pgd_vmalloc64(u32 **p, struct uasm_label **l, struct uasm_reloc **r,
 		 * to mimic that here by taking a load/istream page
 		 * fault.
 		 */
+		if (loongson_llsc_war())
+			uasm_i_sync(p, 0);
 		UASM_i_LA(p, ptr, (unsigned long)tlb_do_page_fault_0);
 		uasm_i_jr(p, ptr);
 
@@ -1561,6 +1568,8 @@ static void build_loongson3_tlb_refill_handler(void)
 
 	if (check_for_high_segbits) {
 		uasm_l_large_segbits_fault(&l, p);
+		if (loongson_llsc_war())
+			uasm_i_sync(&p, 0);
 		UASM_i_LA(&p, K1, (unsigned long)tlb_do_page_fault_0);
 		uasm_i_jr(&p, K1);
 		uasm_i_nop(&p);
@@ -1661,6 +1670,8 @@ static void
 iPTE_LW(u32 **p, unsigned int pte, unsigned int ptr)
 {
 #ifdef CONFIG_SMP
+	if (loongson_llsc_war())
+		uasm_i_sync(p, 0);
 # ifdef CONFIG_PHYS_ADDR_T_64BIT
 	if (cpu_has_64bits)
 		uasm_i_lld(p, pte, 0, ptr);
@@ -2242,6 +2253,8 @@ static void build_r4000_tlb_load_handler(void)
 #endif
 
 	uasm_l_nopage_tlbl(&l, p);
+	if (loongson_llsc_war())
+		uasm_i_sync(&p, 0);
 	build_restore_work_registers(&p);
 #ifdef CONFIG_CPU_MICROMIPS
 	if ((unsigned long)tlb_do_page_fault_0 & 1) {
@@ -2297,6 +2310,8 @@ static void build_r4000_tlb_store_handler(void)
 #endif
 
 	uasm_l_nopage_tlbs(&l, p);
+	if (loongson_llsc_war())
+		uasm_i_sync(&p, 0);
 	build_restore_work_registers(&p);
 #ifdef CONFIG_CPU_MICROMIPS
 	if ((unsigned long)tlb_do_page_fault_1 & 1) {
@@ -2353,6 +2368,8 @@ static void build_r4000_tlb_modify_handler(void)
 #endif
 
 	uasm_l_nopage_tlbm(&l, p);
+	if (loongson_llsc_war())
+		uasm_i_sync(&p, 0);
 	build_restore_work_registers(&p);
 #ifdef CONFIG_CPU_MICROMIPS
 	if ((unsigned long)tlb_do_page_fault_1 & 1) {
-- 
2.7.0
