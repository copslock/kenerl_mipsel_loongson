Return-Path: <SRS0=T/5f=XY=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02533C47404
	for <linux-mips@archiver.kernel.org>; Sun, 29 Sep 2019 17:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8D132086A
	for <linux-mips@archiver.kernel.org>; Sun, 29 Sep 2019 17:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569779014;
	bh=I9IKwRqNjBya+//XLi4G7RG1Q/fT+hMum9Ow+lED6E8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cUG5X1OMwDiFisCDS5OCn1dSXeKiE3Sz6usMWrZBf31e+GfWK7LkIl/oUxCXBP59h
	 BPFodRDbVz03R9BIDUCikTLyTeF2Pe5JHvwqiDie1O4nb2lAxgCTjFiMs5c4FUajKW
	 O/odGLnMV2CysSGVvco6kA21fE9dU9PCvoSMJHCk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729260AbfI2Rb3 (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sun, 29 Sep 2019 13:31:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:41868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729238AbfI2Rb3 (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Sun, 29 Sep 2019 13:31:29 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A565621925;
        Sun, 29 Sep 2019 17:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569778287;
        bh=I9IKwRqNjBya+//XLi4G7RG1Q/fT+hMum9Ow+lED6E8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SJ4fcRiLNGGkobFeDE5720bh7FG0c+iUQTR3aHqlFPOKV9Jwo7aMdM8A8TcpTNym8
         rRsHGf7GHfEeR+hRWohC4OsYAGTvBUMTUYwAB9RzPjR9sX/E7vvNeKpoDFmmuIM9JK
         UybwiE7+SzeWYcz9hdnRbWQ0rONOAo8HnkvekQ58=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Paul Burton <paul.burton@mips.com>,
        Sasha Levin <sashal@kernel.org>, linux-mips@vger.kernel.org
Subject: [PATCH AUTOSEL 5.3 14/49] mips/atomic: Fix smp_mb__{before,after}_atomic()
Date:   Sun, 29 Sep 2019 13:30:14 -0400
Message-Id: <20190929173053.8400-14-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190929173053.8400-1-sashal@kernel.org>
References: <20190929173053.8400-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit 42344113ba7a1ed7b5654cd5270af0d5698d8521 ]

Recent probing at the Linux Kernel Memory Model uncovered a
'surprise'. Strongly ordered architectures where the atomic RmW
primitive implies full memory ordering and
smp_mb__{before,after}_atomic() are a simple barrier() (such as MIPS
without WEAK_REORDERING_BEYOND_LLSC) fail for:

	*x = 1;
	atomic_inc(u);
	smp_mb__after_atomic();
	r0 = *y;

Because, while the atomic_inc() implies memory order, it
(surprisingly) does not provide a compiler barrier. This then allows
the compiler to re-order like so:

	atomic_inc(u);
	*x = 1;
	smp_mb__after_atomic();
	r0 = *y;

Which the CPU is then allowed to re-order (under TSO rules) like:

	atomic_inc(u);
	r0 = *y;
	*x = 1;

And this very much was not intended. Therefore strengthen the atomic
RmW ops to include a compiler barrier.

Reported-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/include/asm/atomic.h  | 14 +++++------
 arch/mips/include/asm/barrier.h | 12 ++++++++--
 arch/mips/include/asm/bitops.h  | 42 ++++++++++++++++++++-------------
 arch/mips/include/asm/cmpxchg.h |  6 ++---
 4 files changed, 45 insertions(+), 29 deletions(-)

diff --git a/arch/mips/include/asm/atomic.h b/arch/mips/include/asm/atomic.h
index 190f1b6151221..bb8658cc7f126 100644
--- a/arch/mips/include/asm/atomic.h
+++ b/arch/mips/include/asm/atomic.h
@@ -68,7 +68,7 @@ static __inline__ void atomic_##op(int i, atomic_t * v)			      \
 		"\t" __scbeqz "	%0, 1b					\n"   \
 		"	.set	pop					\n"   \
 		: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (v->counter)	      \
-		: "Ir" (i));						      \
+		: "Ir" (i) : __LLSC_CLOBBER);				      \
 	} else {							      \
 		unsigned long flags;					      \
 									      \
@@ -98,7 +98,7 @@ static __inline__ int atomic_##op##_return_relaxed(int i, atomic_t * v)	      \
 		"	.set	pop					\n"   \
 		: "=&r" (result), "=&r" (temp),				      \
 		  "+" GCC_OFF_SMALL_ASM() (v->counter)			      \
-		: "Ir" (i));						      \
+		: "Ir" (i) : __LLSC_CLOBBER);				      \
 	} else {							      \
 		unsigned long flags;					      \
 									      \
@@ -132,7 +132,7 @@ static __inline__ int atomic_fetch_##op##_relaxed(int i, atomic_t * v)	      \
 		"	move	%0, %1					\n"   \
 		: "=&r" (result), "=&r" (temp),				      \
 		  "+" GCC_OFF_SMALL_ASM() (v->counter)			      \
-		: "Ir" (i));						      \
+		: "Ir" (i) : __LLSC_CLOBBER);				      \
 	} else {							      \
 		unsigned long flags;					      \
 									      \
@@ -210,7 +210,7 @@ static __inline__ int atomic_sub_if_positive(int i, atomic_t * v)
 		"	.set	pop					\n"
 		: "=&r" (result), "=&r" (temp),
 		  "+" GCC_OFF_SMALL_ASM() (v->counter)
-		: "Ir" (i));
+		: "Ir" (i) : __LLSC_CLOBBER);
 	} else {
 		unsigned long flags;
 
@@ -270,7 +270,7 @@ static __inline__ void atomic64_##op(s64 i, atomic64_t * v)		      \
 		"\t" __scbeqz "	%0, 1b					\n"   \
 		"	.set	pop					\n"   \
 		: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (v->counter)	      \
-		: "Ir" (i));						      \
+		: "Ir" (i) : __LLSC_CLOBBER);				      \
 	} else {							      \
 		unsigned long flags;					      \
 									      \
@@ -300,7 +300,7 @@ static __inline__ s64 atomic64_##op##_return_relaxed(s64 i, atomic64_t * v)   \
 		"	.set	pop					\n"   \
 		: "=&r" (result), "=&r" (temp),				      \
 		  "+" GCC_OFF_SMALL_ASM() (v->counter)			      \
-		: "Ir" (i));						      \
+		: "Ir" (i) : __LLSC_CLOBBER);				      \
 	} else {							      \
 		unsigned long flags;					      \
 									      \
@@ -334,7 +334,7 @@ static __inline__ s64 atomic64_fetch_##op##_relaxed(s64 i, atomic64_t * v)    \
 		"	.set	pop					\n"   \
 		: "=&r" (result), "=&r" (temp),				      \
 		  "+" GCC_OFF_SMALL_ASM() (v->counter)			      \
-		: "Ir" (i));						      \
+		: "Ir" (i) : __LLSC_CLOBBER);				      \
 	} else {							      \
 		unsigned long flags;					      \
 									      \
diff --git a/arch/mips/include/asm/barrier.h b/arch/mips/include/asm/barrier.h
index f9a6da96aae12..9228f73862205 100644
--- a/arch/mips/include/asm/barrier.h
+++ b/arch/mips/include/asm/barrier.h
@@ -211,14 +211,22 @@
 #define __smp_wmb()	barrier()
 #endif
 
+/*
+ * When LL/SC does imply order, it must also be a compiler barrier to avoid the
+ * compiler from reordering where the CPU will not. When it does not imply
+ * order, the compiler is also free to reorder across the LL/SC loop and
+ * ordering will be done by smp_llsc_mb() and friends.
+ */
 #if defined(CONFIG_WEAK_REORDERING_BEYOND_LLSC) && defined(CONFIG_SMP)
 #define __WEAK_LLSC_MB		"	sync	\n"
+#define smp_llsc_mb()		__asm__ __volatile__(__WEAK_LLSC_MB : : :"memory")
+#define __LLSC_CLOBBER
 #else
 #define __WEAK_LLSC_MB		"		\n"
+#define smp_llsc_mb()		do { } while (0)
+#define __LLSC_CLOBBER		"memory"
 #endif
 
-#define smp_llsc_mb()	__asm__ __volatile__(__WEAK_LLSC_MB : : :"memory")
-
 #ifdef CONFIG_CPU_CAVIUM_OCTEON
 #define smp_mb__before_llsc() smp_wmb()
 #define __smp_mb__before_llsc() __smp_wmb()
diff --git a/arch/mips/include/asm/bitops.h b/arch/mips/include/asm/bitops.h
index 7bd35e5e2a9e4..985d6a02f9ea1 100644
--- a/arch/mips/include/asm/bitops.h
+++ b/arch/mips/include/asm/bitops.h
@@ -66,7 +66,8 @@ static inline void set_bit(unsigned long nr, volatile unsigned long *addr)
 		"	beqzl	%0, 1b					\n"
 		"	.set	pop					\n"
 		: "=&r" (temp), "=" GCC_OFF_SMALL_ASM() (*m)
-		: "ir" (1UL << bit), GCC_OFF_SMALL_ASM() (*m));
+		: "ir" (1UL << bit), GCC_OFF_SMALL_ASM() (*m)
+		: __LLSC_CLOBBER);
 #if defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_MIPSR6)
 	} else if (kernel_uses_llsc && __builtin_constant_p(bit)) {
 		loongson_llsc_mb();
@@ -76,7 +77,8 @@ static inline void set_bit(unsigned long nr, volatile unsigned long *addr)
 			"	" __INS "%0, %3, %2, 1			\n"
 			"	" __SC "%0, %1				\n"
 			: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (*m)
-			: "ir" (bit), "r" (~0));
+			: "ir" (bit), "r" (~0)
+			: __LLSC_CLOBBER);
 		} while (unlikely(!temp));
 #endif /* CONFIG_CPU_MIPSR2 || CONFIG_CPU_MIPSR6 */
 	} else if (kernel_uses_llsc) {
@@ -90,7 +92,8 @@ static inline void set_bit(unsigned long nr, volatile unsigned long *addr)
 			"	" __SC	"%0, %1				\n"
 			"	.set	pop				\n"
 			: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (*m)
-			: "ir" (1UL << bit));
+			: "ir" (1UL << bit)
+			: __LLSC_CLOBBER);
 		} while (unlikely(!temp));
 	} else
 		__mips_set_bit(nr, addr);
@@ -122,7 +125,8 @@ static inline void clear_bit(unsigned long nr, volatile unsigned long *addr)
 		"	beqzl	%0, 1b					\n"
 		"	.set	pop					\n"
 		: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (*m)
-		: "ir" (~(1UL << bit)));
+		: "ir" (~(1UL << bit))
+		: __LLSC_CLOBBER);
 #if defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_MIPSR6)
 	} else if (kernel_uses_llsc && __builtin_constant_p(bit)) {
 		loongson_llsc_mb();
@@ -132,7 +136,8 @@ static inline void clear_bit(unsigned long nr, volatile unsigned long *addr)
 			"	" __INS "%0, $0, %2, 1			\n"
 			"	" __SC "%0, %1				\n"
 			: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (*m)
-			: "ir" (bit));
+			: "ir" (bit)
+			: __LLSC_CLOBBER);
 		} while (unlikely(!temp));
 #endif /* CONFIG_CPU_MIPSR2 || CONFIG_CPU_MIPSR6 */
 	} else if (kernel_uses_llsc) {
@@ -146,7 +151,8 @@ static inline void clear_bit(unsigned long nr, volatile unsigned long *addr)
 			"	" __SC "%0, %1				\n"
 			"	.set	pop				\n"
 			: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (*m)
-			: "ir" (~(1UL << bit)));
+			: "ir" (~(1UL << bit))
+			: __LLSC_CLOBBER);
 		} while (unlikely(!temp));
 	} else
 		__mips_clear_bit(nr, addr);
@@ -192,7 +198,8 @@ static inline void change_bit(unsigned long nr, volatile unsigned long *addr)
 		"	beqzl	%0, 1b				\n"
 		"	.set	pop				\n"
 		: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (*m)
-		: "ir" (1UL << bit));
+		: "ir" (1UL << bit)
+		: __LLSC_CLOBBER);
 	} else if (kernel_uses_llsc) {
 		unsigned long *m = ((unsigned long *) addr) + (nr >> SZLONG_LOG);
 		unsigned long temp;
@@ -207,7 +214,8 @@ static inline void change_bit(unsigned long nr, volatile unsigned long *addr)
 			"	" __SC	"%0, %1				\n"
 			"	.set	pop				\n"
 			: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (*m)
-			: "ir" (1UL << bit));
+			: "ir" (1UL << bit)
+			: __LLSC_CLOBBER);
 		} while (unlikely(!temp));
 	} else
 		__mips_change_bit(nr, addr);
@@ -244,7 +252,7 @@ static inline int test_and_set_bit(unsigned long nr,
 		"	.set	pop					\n"
 		: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (*m), "=&r" (res)
 		: "r" (1UL << bit)
-		: "memory");
+		: __LLSC_CLOBBER);
 	} else if (kernel_uses_llsc) {
 		unsigned long *m = ((unsigned long *) addr) + (nr >> SZLONG_LOG);
 		unsigned long temp;
@@ -260,7 +268,7 @@ static inline int test_and_set_bit(unsigned long nr,
 			"	.set	pop				\n"
 			: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (*m), "=&r" (res)
 			: "r" (1UL << bit)
-			: "memory");
+			: __LLSC_CLOBBER);
 		} while (unlikely(!res));
 
 		res = temp & (1UL << bit);
@@ -301,7 +309,7 @@ static inline int test_and_set_bit_lock(unsigned long nr,
 		"	.set	pop					\n"
 		: "=&r" (temp), "+m" (*m), "=&r" (res)
 		: "r" (1UL << bit)
-		: "memory");
+		: __LLSC_CLOBBER);
 	} else if (kernel_uses_llsc) {
 		unsigned long *m = ((unsigned long *) addr) + (nr >> SZLONG_LOG);
 		unsigned long temp;
@@ -317,7 +325,7 @@ static inline int test_and_set_bit_lock(unsigned long nr,
 			"	.set	pop				\n"
 			: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (*m), "=&r" (res)
 			: "r" (1UL << bit)
-			: "memory");
+			: __LLSC_CLOBBER);
 		} while (unlikely(!res));
 
 		res = temp & (1UL << bit);
@@ -360,7 +368,7 @@ static inline int test_and_clear_bit(unsigned long nr,
 		"	.set	pop					\n"
 		: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (*m), "=&r" (res)
 		: "r" (1UL << bit)
-		: "memory");
+		: __LLSC_CLOBBER);
 #if defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_MIPSR6)
 	} else if (kernel_uses_llsc && __builtin_constant_p(nr)) {
 		unsigned long *m = ((unsigned long *) addr) + (nr >> SZLONG_LOG);
@@ -375,7 +383,7 @@ static inline int test_and_clear_bit(unsigned long nr,
 			"	" __SC	"%0, %1				\n"
 			: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (*m), "=&r" (res)
 			: "ir" (bit)
-			: "memory");
+			: __LLSC_CLOBBER);
 		} while (unlikely(!temp));
 #endif
 	} else if (kernel_uses_llsc) {
@@ -394,7 +402,7 @@ static inline int test_and_clear_bit(unsigned long nr,
 			"	.set	pop				\n"
 			: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (*m), "=&r" (res)
 			: "r" (1UL << bit)
-			: "memory");
+			: __LLSC_CLOBBER);
 		} while (unlikely(!res));
 
 		res = temp & (1UL << bit);
@@ -437,7 +445,7 @@ static inline int test_and_change_bit(unsigned long nr,
 		"	.set	pop					\n"
 		: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (*m), "=&r" (res)
 		: "r" (1UL << bit)
-		: "memory");
+		: __LLSC_CLOBBER);
 	} else if (kernel_uses_llsc) {
 		unsigned long *m = ((unsigned long *) addr) + (nr >> SZLONG_LOG);
 		unsigned long temp;
@@ -453,7 +461,7 @@ static inline int test_and_change_bit(unsigned long nr,
 			"	.set	pop				\n"
 			: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (*m), "=&r" (res)
 			: "r" (1UL << bit)
-			: "memory");
+			: __LLSC_CLOBBER);
 		} while (unlikely(!res));
 
 		res = temp & (1UL << bit);
diff --git a/arch/mips/include/asm/cmpxchg.h b/arch/mips/include/asm/cmpxchg.h
index f5994a332673b..c8a47d18f6288 100644
--- a/arch/mips/include/asm/cmpxchg.h
+++ b/arch/mips/include/asm/cmpxchg.h
@@ -61,7 +61,7 @@ extern unsigned long __xchg_called_with_bad_pointer(void)
 		"	.set	pop				\n"	\
 		: "=&r" (__ret), "=" GCC_OFF_SMALL_ASM() (*m)		\
 		: GCC_OFF_SMALL_ASM() (*m), "Jr" (val)			\
-		: "memory");						\
+		: __LLSC_CLOBBER);					\
 	} else {							\
 		unsigned long __flags;					\
 									\
@@ -134,8 +134,8 @@ static inline unsigned long __xchg(volatile void *ptr, unsigned long x,
 		"	.set	pop				\n"	\
 		"2:						\n"	\
 		: "=&r" (__ret), "=" GCC_OFF_SMALL_ASM() (*m)		\
-		: GCC_OFF_SMALL_ASM() (*m), "Jr" (old), "Jr" (new)		\
-		: "memory");						\
+		: GCC_OFF_SMALL_ASM() (*m), "Jr" (old), "Jr" (new)	\
+		: __LLSC_CLOBBER);					\
 		loongson_llsc_mb();					\
 	} else {							\
 		unsigned long __flags;					\
-- 
2.20.1

