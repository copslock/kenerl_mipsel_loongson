Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Sep 2018 11:38:11 +0200 (CEST)
Received: from mail-pg1-x542.google.com ([IPv6:2607:f8b0:4864:20::542]:34526
        "EHLO mail-pg1-x542.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994553AbeIEJiIRdxRC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Sep 2018 11:38:08 +0200
Received: by mail-pg1-x542.google.com with SMTP id d19-v6so3171325pgv.1;
        Wed, 05 Sep 2018 02:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sNtc92NLsXKm6wCxsCROmY4M2ZrIPZTaJBab46yZzdk=;
        b=ijCBOUjolz8s205tONQQt6fYcPRaO8lKcRhXctYJlwSMsCc1LgyICUTjWFNHs/YJkn
         cdUqDTJCY54PxWfBmlILtHWcJbec47csVKIcgjp4TtmOOBHS7IfegDfXVyTt202zW+8W
         kE8IOR5WpUVw6UpnGtPt8tzMedUFHjX5likb2Nculh8bg2Qjd3JI6/cdW8blL1gesKNQ
         9bM16JXB9nTv3hzJRyEqTW7qrDLoDSOxKJKpghqq+fOz7dvNAklJzN4rCpK96WkcMt87
         uNcPRRFNBk/duIHYoYinwYsh4YwXoFmVP6axfIhVEDlskq10hCUaaXcvnL4qRf1F0DCf
         HzQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=sNtc92NLsXKm6wCxsCROmY4M2ZrIPZTaJBab46yZzdk=;
        b=MyGbyrI++n3HDR5azpKWPj3CHMUUqDqHOKearujbSAqpCaGQ3J9elhPxKWXzZdVFAS
         WbQ1I164e/gCdkvmVfyha2Y7wQqaMAuIGgWeVGP3M2Hmg1SPvAyhCiR5EfHmn/SQ1Sk9
         O2TgtaQ4rTIXXHlYnp4zf2BIhlg4AklphgQPIXcSUVStOwCj7JTNXy77yn44PTPvZXTs
         GruoN91f/39zZIsCrIaKqNzspBCr43cxopQYDBOi5ylbkBb/VmKOu0KYA7Cc7figLjsl
         ZVSEgbpIcP9eqcXfXfmvzSyh+tDlAIvNZqoXxUCqTWlMSmX7z5vpJ6wXdHln3RwvM+Cx
         xSTw==
X-Gm-Message-State: APzg51DaXWsb0RlPrAxY8XTzdoHCIyvlQdfLN8pCcXUAk0/K3J5Hj82Q
        rTIiBQU55ihXtByTmVi29s7IxzdJ5Ks=
X-Google-Smtp-Source: ANB0VdbW5Y0alq7rAAMZ1FfL2jzNyVCQ7TgVlPr5Z8VCm8S2quk4LRwWVIlhkZSSZa/ngQFT+aRugQ==
X-Received: by 2002:a62:c008:: with SMTP id x8-v6mr39627522pff.149.1536140281531;
        Wed, 05 Sep 2018 02:38:01 -0700 (PDT)
Received: from software.domain.org ([172.247.34.138])
        by smtp.gmail.com with ESMTPSA id y4-v6sm2008744pfm.137.2018.09.05.02.37.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 05 Sep 2018 02:38:00 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH V4 10/10] MIPS: Loongson: Introduce and use WAR_LLSC_MB
Date:   Wed,  5 Sep 2018 17:33:10 +0800
Message-Id: <1536139990-11665-11-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1536139990-11665-1-git-send-email-chenhc@lemote.com>
References: <1536139990-11665-1-git-send-email-chenhc@lemote.com>
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65948
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

This patch is not a minimal change (it is very difficult to make a
minimal change), but it is a safest change.

Why disable fix-loongson3-llsc in compiler?
Because compiler fix will cause problems in kernel's .fixup section.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/include/asm/atomic.h  | 36 ++++++++++++++++++++++++++++--------
 arch/mips/include/asm/barrier.h |  6 ++++++
 arch/mips/include/asm/bitops.h  | 15 +++++++++++++++
 arch/mips/include/asm/cmpxchg.h |  9 +++++++--
 arch/mips/include/asm/edac.h    |  5 ++++-
 arch/mips/include/asm/futex.h   | 18 ++++++++++++------
 arch/mips/include/asm/local.h   | 10 ++++++++--
 arch/mips/include/asm/pgtable.h |  5 ++++-
 arch/mips/kernel/syscall.c      |  2 ++
 arch/mips/loongson64/Platform   |  3 +++
 arch/mips/mm/tlbex.c            | 11 +++++++++++
 11 files changed, 100 insertions(+), 20 deletions(-)

diff --git a/arch/mips/include/asm/atomic.h b/arch/mips/include/asm/atomic.h
index d4ea7a5..9e91641 100644
--- a/arch/mips/include/asm/atomic.h
+++ b/arch/mips/include/asm/atomic.h
@@ -60,13 +60,16 @@ static __inline__ void atomic_##op(int i, atomic_t * v)			      \
 									      \
 		__asm__ __volatile__(					      \
 		"	.set	"MIPS_ISA_LEVEL"			\n"   \
-		"1:	ll	%0, %1		# atomic_" #op "	\n"   \
+		"1:				# atomic_" #op "	\n"   \
+		__WAR_LLSC_MB						      \
+		"	ll	%0, %1					\n"   \
 		"	" #asm_op " %0, %2				\n"   \
 		"	sc	%0, %1					\n"   \
 		"\t" __scbeqz "	%0, 1b					\n"   \
 		"	.set	mips0					\n"   \
 		: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (v->counter)	      \
 		: "Ir" (i));						      \
+		__asm__ __volatile__(__WAR_LLSC_MB : : :"memory");	      \
 	} else {							      \
 		unsigned long flags;					      \
 									      \
@@ -86,7 +89,9 @@ static __inline__ int atomic_##op##_return_relaxed(int i, atomic_t * v)	      \
 									      \
 		__asm__ __volatile__(					      \
 		"	.set	"MIPS_ISA_LEVEL"			\n"   \
-		"1:	ll	%1, %2		# atomic_" #op "_return	\n"   \
+		"1:				# atomic_" #op "_return	\n"   \
+		__WAR_LLSC_MB						      \
+		"	ll	%1, %2					\n"   \
 		"	" #asm_op " %0, %1, %3				\n"   \
 		"	sc	%0, %2					\n"   \
 		"\t" __scbeqz "	%0, 1b					\n"   \
@@ -118,7 +123,9 @@ static __inline__ int atomic_fetch_##op##_relaxed(int i, atomic_t * v)	      \
 									      \
 		__asm__ __volatile__(					      \
 		"	.set	"MIPS_ISA_LEVEL"			\n"   \
-		"1:	ll	%1, %2		# atomic_fetch_" #op "	\n"   \
+		"1:				# atomic_fetch_" #op "	\n"   \
+		__WAR_LLSC_MB						      \
+		"	ll	%1, %2					\n"   \
 		"	" #asm_op " %0, %1, %3				\n"   \
 		"	sc	%0, %2					\n"   \
 		"\t" __scbeqz "	%0, 1b					\n"   \
@@ -127,6 +134,7 @@ static __inline__ int atomic_fetch_##op##_relaxed(int i, atomic_t * v)	      \
 		: "=&r" (result), "=&r" (temp),				      \
 		  "+" GCC_OFF_SMALL_ASM() (v->counter)			      \
 		: "Ir" (i));						      \
+		__asm__ __volatile__(__WAR_LLSC_MB : : :"memory");	      \
 	} else {							      \
 		unsigned long flags;					      \
 									      \
@@ -189,7 +197,9 @@ static __inline__ int atomic_sub_if_positive(int i, atomic_t * v)
 
 		__asm__ __volatile__(
 		"	.set	"MIPS_ISA_LEVEL"			\n"
-		"1:	ll	%1, %2		# atomic_sub_if_positive\n"
+		"1:				# atomic_sub_if_positive\n"
+		__WAR_LLSC_MB
+		"	ll	%1, %2					\n"
 		"	.set	mips0					\n"
 		"	subu	%0, %1, %3				\n"
 		"	move	%1, %0					\n"
@@ -253,13 +263,16 @@ static __inline__ void atomic64_##op(long i, atomic64_t * v)		      \
 									      \
 		__asm__ __volatile__(					      \
 		"	.set	"MIPS_ISA_LEVEL"			\n"   \
-		"1:	lld	%0, %1		# atomic64_" #op "	\n"   \
+		"1:				# atomic64_" #op "	\n"   \
+		__WAR_LLSC_MB						      \
+		"	lld	%0, %1					\n"   \
 		"	" #asm_op " %0, %2				\n"   \
 		"	scd	%0, %1					\n"   \
 		"\t" __scbeqz "	%0, 1b					\n"   \
 		"	.set	mips0					\n"   \
 		: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (v->counter)	      \
 		: "Ir" (i));						      \
+		__asm__ __volatile__(__WAR_LLSC_MB : : :"memory");	      \
 	} else {							      \
 		unsigned long flags;					      \
 									      \
@@ -279,7 +292,9 @@ static __inline__ long atomic64_##op##_return_relaxed(long i, atomic64_t * v) \
 									      \
 		__asm__ __volatile__(					      \
 		"	.set	"MIPS_ISA_LEVEL"			\n"   \
-		"1:	lld	%1, %2		# atomic64_" #op "_return\n"  \
+		"1:				# atomic64_" #op "_return\n"  \
+		__WAR_LLSC_MB						      \
+		"	lld	%1, %2					\n"   \
 		"	" #asm_op " %0, %1, %3				\n"   \
 		"	scd	%0, %2					\n"   \
 		"\t" __scbeqz "	%0, 1b					\n"   \
@@ -311,7 +326,9 @@ static __inline__ long atomic64_fetch_##op##_relaxed(long i, atomic64_t * v)  \
 									      \
 		__asm__ __volatile__(					      \
 		"	.set	"MIPS_ISA_LEVEL"			\n"   \
-		"1:	lld	%1, %2		# atomic64_fetch_" #op "\n"   \
+		"1:				# atomic64_fetch_" #op "\n"   \
+		__WAR_LLSC_MB						      \
+		"	lld	%1, %2					\n"   \
 		"	" #asm_op " %0, %1, %3				\n"   \
 		"	scd	%0, %2					\n"   \
 		"\t" __scbeqz "	%0, 1b					\n"   \
@@ -320,6 +337,7 @@ static __inline__ long atomic64_fetch_##op##_relaxed(long i, atomic64_t * v)  \
 		: "=&r" (result), "=&r" (temp),				      \
 		  "+" GCC_OFF_SMALL_ASM() (v->counter)			      \
 		: "Ir" (i));						      \
+		__asm__ __volatile__(__WAR_LLSC_MB : : :"memory");	      \
 	} else {							      \
 		unsigned long flags;					      \
 									      \
@@ -383,7 +401,9 @@ static __inline__ long atomic64_sub_if_positive(long i, atomic64_t * v)
 
 		__asm__ __volatile__(
 		"	.set	"MIPS_ISA_LEVEL"			\n"
-		"1:	lld	%1, %2		# atomic64_sub_if_positive\n"
+		"1:				# atomic64_sub_if_positive\n"
+		__WAR_LLSC_MB
+		"	lld	%1, %2					\n"
 		"	dsubu	%0, %1, %3				\n"
 		"	move	%1, %0					\n"
 		"	bltz	%0, 1f					\n"
diff --git a/arch/mips/include/asm/barrier.h b/arch/mips/include/asm/barrier.h
index a5eb1bb..d892094 100644
--- a/arch/mips/include/asm/barrier.h
+++ b/arch/mips/include/asm/barrier.h
@@ -203,6 +203,12 @@
 #define __WEAK_LLSC_MB		"		\n"
 #endif
 
+#if defined(CONFIG_LOONGSON3) && defined(CONFIG_SMP) /* Loongson-3's LLSC workaround */
+#define __WAR_LLSC_MB		"	sync	\n"
+#else
+#define __WAR_LLSC_MB		"		\n"
+#endif
+
 #define smp_llsc_mb()	__asm__ __volatile__(__WEAK_LLSC_MB : : :"memory")
 
 #ifdef CONFIG_CPU_CAVIUM_OCTEON
diff --git a/arch/mips/include/asm/bitops.h b/arch/mips/include/asm/bitops.h
index da1b8718..0612cff 100644
--- a/arch/mips/include/asm/bitops.h
+++ b/arch/mips/include/asm/bitops.h
@@ -70,17 +70,20 @@ static inline void set_bit(unsigned long nr, volatile unsigned long *addr)
 	} else if (kernel_uses_llsc && __builtin_constant_p(bit)) {
 		do {
 			__asm__ __volatile__(
+			__WAR_LLSC_MB
 			"	" __LL "%0, %1		# set_bit	\n"
 			"	" __INS "%0, %3, %2, 1			\n"
 			"	" __SC "%0, %1				\n"
 			: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (*m)
 			: "ir" (bit), "r" (~0));
 		} while (unlikely(!temp));
+		__asm__ __volatile__(__WAR_LLSC_MB : : :"memory");
 #endif /* CONFIG_CPU_MIPSR2 || CONFIG_CPU_MIPSR6 */
 	} else if (kernel_uses_llsc) {
 		do {
 			__asm__ __volatile__(
 			"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"
+			__WAR_LLSC_MB
 			"	" __LL "%0, %1		# set_bit	\n"
 			"	or	%0, %2				\n"
 			"	" __SC	"%0, %1				\n"
@@ -88,6 +91,7 @@ static inline void set_bit(unsigned long nr, volatile unsigned long *addr)
 			: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (*m)
 			: "ir" (1UL << bit));
 		} while (unlikely(!temp));
+		__asm__ __volatile__(__WAR_LLSC_MB : : :"memory");
 	} else
 		__mips_set_bit(nr, addr);
 }
@@ -122,17 +126,20 @@ static inline void clear_bit(unsigned long nr, volatile unsigned long *addr)
 	} else if (kernel_uses_llsc && __builtin_constant_p(bit)) {
 		do {
 			__asm__ __volatile__(
+			__WAR_LLSC_MB
 			"	" __LL "%0, %1		# clear_bit	\n"
 			"	" __INS "%0, $0, %2, 1			\n"
 			"	" __SC "%0, %1				\n"
 			: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (*m)
 			: "ir" (bit));
 		} while (unlikely(!temp));
+		__asm__ __volatile__(__WAR_LLSC_MB : : :"memory");
 #endif /* CONFIG_CPU_MIPSR2 || CONFIG_CPU_MIPSR6 */
 	} else if (kernel_uses_llsc) {
 		do {
 			__asm__ __volatile__(
 			"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"
+			__WAR_LLSC_MB
 			"	" __LL "%0, %1		# clear_bit	\n"
 			"	and	%0, %2				\n"
 			"	" __SC "%0, %1				\n"
@@ -140,6 +147,7 @@ static inline void clear_bit(unsigned long nr, volatile unsigned long *addr)
 			: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (*m)
 			: "ir" (~(1UL << bit)));
 		} while (unlikely(!temp));
+		__asm__ __volatile__(__WAR_LLSC_MB : : :"memory");
 	} else
 		__mips_clear_bit(nr, addr);
 }
@@ -191,6 +199,7 @@ static inline void change_bit(unsigned long nr, volatile unsigned long *addr)
 		do {
 			__asm__ __volatile__(
 			"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"
+			__WAR_LLSC_MB
 			"	" __LL "%0, %1		# change_bit	\n"
 			"	xor	%0, %2				\n"
 			"	" __SC	"%0, %1				\n"
@@ -198,6 +207,7 @@ static inline void change_bit(unsigned long nr, volatile unsigned long *addr)
 			: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (*m)
 			: "ir" (1UL << bit));
 		} while (unlikely(!temp));
+		__asm__ __volatile__(__WAR_LLSC_MB : : :"memory");
 	} else
 		__mips_change_bit(nr, addr);
 }
@@ -240,6 +250,7 @@ static inline int test_and_set_bit(unsigned long nr,
 		do {
 			__asm__ __volatile__(
 			"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"
+			__WAR_LLSC_MB
 			"	" __LL "%0, %1	# test_and_set_bit	\n"
 			"	or	%2, %0, %3			\n"
 			"	" __SC	"%2, %1				\n"
@@ -294,6 +305,7 @@ static inline int test_and_set_bit_lock(unsigned long nr,
 		do {
 			__asm__ __volatile__(
 			"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"
+			__WAR_LLSC_MB
 			"	" __LL "%0, %1	# test_and_set_bit	\n"
 			"	or	%2, %0, %3			\n"
 			"	" __SC	"%2, %1				\n"
@@ -350,6 +362,7 @@ static inline int test_and_clear_bit(unsigned long nr,
 
 		do {
 			__asm__ __volatile__(
+			__WAR_LLSC_MB
 			"	" __LL	"%0, %1 # test_and_clear_bit	\n"
 			"	" __EXT "%2, %0, %3, 1			\n"
 			"	" __INS "%0, $0, %3, 1			\n"
@@ -366,6 +379,7 @@ static inline int test_and_clear_bit(unsigned long nr,
 		do {
 			__asm__ __volatile__(
 			"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"
+			__WAR_LLSC_MB
 			"	" __LL	"%0, %1 # test_and_clear_bit	\n"
 			"	or	%2, %0, %3			\n"
 			"	xor	%2, %3				\n"
@@ -423,6 +437,7 @@ static inline int test_and_change_bit(unsigned long nr,
 		do {
 			__asm__ __volatile__(
 			"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"
+			__WAR_LLSC_MB
 			"	" __LL	"%0, %1 # test_and_change_bit	\n"
 			"	xor	%2, %0, %3			\n"
 			"	" __SC	"\t%2, %1			\n"
diff --git a/arch/mips/include/asm/cmpxchg.h b/arch/mips/include/asm/cmpxchg.h
index 89e9fb7..1f9c091 100644
--- a/arch/mips/include/asm/cmpxchg.h
+++ b/arch/mips/include/asm/cmpxchg.h
@@ -48,7 +48,9 @@ extern unsigned long __xchg_called_with_bad_pointer(void)
 		"	.set	push				\n"	\
 		"	.set	noat				\n"	\
 		"	.set	" MIPS_ISA_ARCH_LEVEL "		\n"	\
-		"1:	" ld "	%0, %2		# __xchg_asm	\n"	\
+		"1:				# __xchg_asm	\n"	\
+		__WAR_LLSC_MB						\
+		"	" ld "	%0, %2				\n"	\
 		"	.set	mips0				\n"	\
 		"	move	$1, %z3				\n"	\
 		"	.set	" MIPS_ISA_ARCH_LEVEL "		\n"	\
@@ -118,7 +120,9 @@ static inline unsigned long __xchg(volatile void *ptr, unsigned long x,
 		"	.set	push				\n"	\
 		"	.set	noat				\n"	\
 		"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"	\
-		"1:	" ld "	%0, %2		# __cmpxchg_asm \n"	\
+		"1:				# __cmpxchg_asm \n"	\
+		__WAR_LLSC_MB						\
+		"	" ld "	%0, %2				\n"	\
 		"	bne	%0, %z3, 2f			\n"	\
 		"	.set	mips0				\n"	\
 		"	move	$1, %z4				\n"	\
@@ -127,6 +131,7 @@ static inline unsigned long __xchg(volatile void *ptr, unsigned long x,
 		"\t" __scbeqz "	$1, 1b				\n"	\
 		"	.set	pop				\n"	\
 		"2:						\n"	\
+		__WAR_LLSC_MB						\
 		: "=&r" (__ret), "=" GCC_OFF_SMALL_ASM() (*m)		\
 		: GCC_OFF_SMALL_ASM() (*m), "Jr" (old), "Jr" (new)		\
 		: "memory");						\
diff --git a/arch/mips/include/asm/edac.h b/arch/mips/include/asm/edac.h
index fc46776..b07a3a9 100644
--- a/arch/mips/include/asm/edac.h
+++ b/arch/mips/include/asm/edac.h
@@ -22,13 +22,16 @@ static inline void edac_atomic_scrub(void *va, u32 size)
 
 		__asm__ __volatile__ (
 		"	.set	mips2					\n"
-		"1:	ll	%0, %1		# edac_atomic_scrub	\n"
+		"1:				# edac_atomic_scrub	\n"
+		__WAR_LLSC_MB
+		"	ll	%0, %1					\n"
 		"	addu	%0, $0					\n"
 		"	sc	%0, %1					\n"
 		"	beqz	%0, 1b					\n"
 		"	.set	mips0					\n"
 		: "=&r" (temp), "=" GCC_OFF_SMALL_ASM() (*virt_addr)
 		: GCC_OFF_SMALL_ASM() (*virt_addr));
+		__asm__ __volatile__(__WAR_LLSC_MB : : :"memory");
 
 		virt_addr++;
 	}
diff --git a/arch/mips/include/asm/futex.h b/arch/mips/include/asm/futex.h
index a9e61ea..d497ee9 100644
--- a/arch/mips/include/asm/futex.h
+++ b/arch/mips/include/asm/futex.h
@@ -54,7 +54,9 @@
 		"	.set	push				\n"	\
 		"	.set	noat				\n"	\
 		"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"	\
-		"1:	"user_ll("%1", "%4")" # __futex_atomic_op\n"	\
+		"1:				 # __futex_atomic_op\n"	\
+		__WAR_LLSC_MB						\
+		"	"user_ll("%1", "%4")"			\n"	\
 		"	.set	mips0				\n"	\
 		"	" insn	"				\n"	\
 		"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"	\
@@ -70,8 +72,9 @@
 		"	j	3b				\n"	\
 		"	.previous				\n"	\
 		"	.section __ex_table,\"a\"		\n"	\
-		"	"__UA_ADDR "\t1b, 4b			\n"	\
-		"	"__UA_ADDR "\t2b, 4b			\n"	\
+		"	"__UA_ADDR "\t(1b + 0), 4b		\n"	\
+		"	"__UA_ADDR "\t(1b + 4), 4b		\n"	\
+		"	"__UA_ADDR "\t(2b + 0), 4b		\n"	\
 		"	.previous				\n"	\
 		: "=r" (ret), "=&r" (oldval),				\
 		  "=" GCC_OFF_SMALL_ASM() (*uaddr)				\
@@ -167,7 +170,9 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 		"	.set	push					\n"
 		"	.set	noat					\n"
 		"	.set	"MIPS_ISA_ARCH_LEVEL"			\n"
-		"1:	"user_ll("%1", "%3")"				\n"
+		"1:							\n"
+		__WAR_LLSC_MB
+		"	"user_ll("%1", "%3")"				\n"
 		"	bne	%1, %z4, 3f				\n"
 		"	.set	mips0					\n"
 		"	move	$1, %z5					\n"
@@ -183,8 +188,9 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 		"	j	3b					\n"
 		"	.previous					\n"
 		"	.section __ex_table,\"a\"			\n"
-		"	"__UA_ADDR "\t1b, 4b				\n"
-		"	"__UA_ADDR "\t2b, 4b				\n"
+		"	"__UA_ADDR "\t(1b + 0), 4b			\n"
+		"	"__UA_ADDR "\t(1b + 4), 4b			\n"
+		"	"__UA_ADDR "\t(2b + 0), 4b			\n"
 		"	.previous					\n"
 		: "+r" (ret), "=&r" (val), "=" GCC_OFF_SMALL_ASM() (*uaddr)
 		: GCC_OFF_SMALL_ASM() (*uaddr), "Jr" (oldval), "Jr" (newval),
diff --git a/arch/mips/include/asm/local.h b/arch/mips/include/asm/local.h
index ac8264e..4105b7a 100644
--- a/arch/mips/include/asm/local.h
+++ b/arch/mips/include/asm/local.h
@@ -50,7 +50,9 @@ static __inline__ long local_add_return(long i, local_t * l)
 
 		__asm__ __volatile__(
 		"	.set	"MIPS_ISA_ARCH_LEVEL"			\n"
-		"1:"	__LL	"%1, %2		# local_add_return	\n"
+		"1:				# local_add_return	\n"
+			__WAR_LLSC_MB
+			__LL	"%1, %2					\n"
 		"	addu	%0, %1, %3				\n"
 			__SC	"%0, %2					\n"
 		"	beqz	%0, 1b					\n"
@@ -59,6 +61,7 @@ static __inline__ long local_add_return(long i, local_t * l)
 		: "=&r" (result), "=&r" (temp), "=m" (l->a.counter)
 		: "Ir" (i), "m" (l->a.counter)
 		: "memory");
+		__asm__ __volatile__(__WAR_LLSC_MB : : :"memory");
 	} else {
 		unsigned long flags;
 
@@ -95,7 +98,9 @@ static __inline__ long local_sub_return(long i, local_t * l)
 
 		__asm__ __volatile__(
 		"	.set	"MIPS_ISA_ARCH_LEVEL"			\n"
-		"1:"	__LL	"%1, %2		# local_sub_return	\n"
+		"1:				# local_sub_return	\n"
+			__WAR_LLSC_MB
+			__LL	"%1, %2					\n"
 		"	subu	%0, %1, %3				\n"
 			__SC	"%0, %2					\n"
 		"	beqz	%0, 1b					\n"
@@ -104,6 +109,7 @@ static __inline__ long local_sub_return(long i, local_t * l)
 		: "=&r" (result), "=&r" (temp), "=m" (l->a.counter)
 		: "Ir" (i), "m" (l->a.counter)
 		: "memory");
+		__asm__ __volatile__(__WAR_LLSC_MB : : :"memory");
 	} else {
 		unsigned long flags;
 
diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
index 129e032..e189384 100644
--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -233,7 +233,9 @@ static inline void set_pte(pte_t *ptep, pte_t pteval)
 			"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"
 			"	.set	push				\n"
 			"	.set	noreorder			\n"
-			"1:"	__LL	"%[tmp], %[buddy]		\n"
+			"1:						\n"
+				__WAR_LLSC_MB
+				__LL	"%[tmp], %[buddy]		\n"
 			"	bnez	%[tmp], 2f			\n"
 			"	 or	%[tmp], %[tmp], %[global]	\n"
 				__SC	"%[tmp], %[buddy]		\n"
@@ -244,6 +246,7 @@ static inline void set_pte(pte_t *ptep, pte_t pteval)
 			"	.set	mips0				\n"
 			: [buddy] "+m" (buddy->pte), [tmp] "=&r" (tmp)
 			: [global] "r" (page_global));
+			__asm__ __volatile__(__WAR_LLSC_MB : : :"memory");
 		}
 #else /* !CONFIG_SMP */
 		if (pte_none(*buddy))
diff --git a/arch/mips/kernel/syscall.c b/arch/mips/kernel/syscall.c
index 69c17b5..743714a 100644
--- a/arch/mips/kernel/syscall.c
+++ b/arch/mips/kernel/syscall.c
@@ -135,6 +135,7 @@ static inline int mips_atomic_set(unsigned long addr, unsigned long new)
 		"	.set	"MIPS_ISA_ARCH_LEVEL"			\n"
 		"	li	%[err], 0				\n"
 		"1:							\n"
+		__WAR_LLSC_MB
 		user_ll("%[old]", "(%[addr])")
 		"	move	%[tmp], %[new]				\n"
 		"2:							\n"
@@ -158,6 +159,7 @@ static inline int mips_atomic_set(unsigned long addr, unsigned long new)
 		  [new] "r" (new),
 		  [efault] "i" (-EFAULT)
 		: "memory");
+		__asm__ __volatile__(__WAR_LLSC_MB : : :"memory");
 	} else {
 		do {
 			preempt_disable();
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
index 0677142..74941b2 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -931,6 +931,8 @@ build_get_pgd_vmalloc64(u32 **p, struct uasm_label **l, struct uasm_reloc **r,
 		 * to mimic that here by taking a load/istream page
 		 * fault.
 		 */
+		if (current_cpu_type() == CPU_LOONGSON3)
+			uasm_i_sync(p, 0);
 		UASM_i_LA(p, ptr, (unsigned long)tlb_do_page_fault_0);
 		uasm_i_jr(p, ptr);
 
@@ -1555,6 +1557,7 @@ static void build_loongson3_tlb_refill_handler(void)
 
 	if (check_for_high_segbits) {
 		uasm_l_large_segbits_fault(&l, p);
+		uasm_i_sync(&p, 0);
 		UASM_i_LA(&p, K1, (unsigned long)tlb_do_page_fault_0);
 		uasm_i_jr(&p, K1);
 		uasm_i_nop(&p);
@@ -1645,6 +1648,8 @@ static void
 iPTE_LW(u32 **p, unsigned int pte, unsigned int ptr)
 {
 #ifdef CONFIG_SMP
+	if (current_cpu_type() == CPU_LOONGSON3)
+		uasm_i_sync(p, 0);
 # ifdef CONFIG_PHYS_ADDR_T_64BIT
 	if (cpu_has_64bits)
 		uasm_i_lld(p, pte, 0, ptr);
@@ -2258,6 +2263,8 @@ static void build_r4000_tlb_load_handler(void)
 #endif
 
 	uasm_l_nopage_tlbl(&l, p);
+	if (current_cpu_type() == CPU_LOONGSON3)
+		uasm_i_sync(&p, 0);
 	build_restore_work_registers(&p);
 #ifdef CONFIG_CPU_MICROMIPS
 	if ((unsigned long)tlb_do_page_fault_0 & 1) {
@@ -2312,6 +2319,8 @@ static void build_r4000_tlb_store_handler(void)
 #endif
 
 	uasm_l_nopage_tlbs(&l, p);
+	if (current_cpu_type() == CPU_LOONGSON3)
+		uasm_i_sync(&p, 0);
 	build_restore_work_registers(&p);
 #ifdef CONFIG_CPU_MICROMIPS
 	if ((unsigned long)tlb_do_page_fault_1 & 1) {
@@ -2367,6 +2376,8 @@ static void build_r4000_tlb_modify_handler(void)
 #endif
 
 	uasm_l_nopage_tlbm(&l, p);
+	if (current_cpu_type() == CPU_LOONGSON3)
+		uasm_i_sync(&p, 0);
 	build_restore_work_registers(&p);
 #ifdef CONFIG_CPU_MICROMIPS
 	if ((unsigned long)tlb_do_page_fault_1 & 1) {
-- 
2.7.0
