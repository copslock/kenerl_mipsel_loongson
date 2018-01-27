Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 27 Jan 2018 04:24:26 +0100 (CET)
Received: from mail-pg0-x243.google.com ([IPv6:2607:f8b0:400e:c05::243]:45252
        "EHLO mail-pg0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994585AbeA0DWwWspjB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 27 Jan 2018 04:22:52 +0100
Received: by mail-pg0-x243.google.com with SMTP id m136so1362607pga.12;
        Fri, 26 Jan 2018 19:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ku/QDkZ50EoWy5wVP9+bYIMuxWne33SLR/xWsaLzSog=;
        b=h0KIvt+fqVgE1eghaBjlEe5c8hU23TqOQfFfpwRD2o9LoajjAV+RxWfjB//dgr29Pr
         Y+fiO3S3cTaNJzhDEJT0oh+RRygZuE3hNDunEXTxbWIE2nNb0r/W/2Asf3XyaxVcjJ8c
         HGaMS3fkaOzIIJbn/x78dObtnW+LmuyTYOh1jNeRXSDDzdvChlJcH0qGCrrT1AzFfZcN
         J8529RNkVFO5a6OmTpW2vUwPZMZ+SB7wp1ykaueyGjdcEJQYPeHoL4nr0KguwxeOGDFB
         oR8uUK5nlC4AQN3ZY4rpbKq45WMLOTQowVvyAV/DnhAtO7e+Ca7kkhV6K9ppghOZnjek
         UBlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=Ku/QDkZ50EoWy5wVP9+bYIMuxWne33SLR/xWsaLzSog=;
        b=U4a90sDc/k6qRNk9gowORJDoZNHs5N1v9qch7JebCvOWsdhugiJ7RnWYEtvgmjW2Ky
         zmYhxE3VHH8N+h75doocF3tPRy1Z4oXxPpC5rIL4EdiCzIouDAh0TMLxLP72IqJwiMKJ
         C/OEEVFLFdqYxPmtyUtlqPYrukRPb2vjc8n1tzcCdY+Sv3L6E5U/OGJhX2gxTWZWhp+d
         Tug6s553zS+NVzRTox0XblBxzbpusbUQ5b5SOZL/sRMhAxRHimt+LnFVVaWjTx7rjMCi
         aRxjmQMZHpBQU5Ej47nQbXjB8b3+VAMrctAVeVxoJmGXV8iImYoGk0R2DafntKOBQ+Ez
         zUjQ==
X-Gm-Message-State: AKwxytdOZ0ke9RE1t4x4iz4975yj6Sx+7rEMFr/AtTqMnvDkKqJxwUIt
        PDfUVYQkbqiuJ4R8Y4YJ9qN4Sg==
X-Google-Smtp-Source: AH8x225nnoEdD0Ts90wW0Alee00W6+5XO9cqBBQY87ddoUyS2TH94/mn9YrlBfQn8EBLNdyccNVneQ==
X-Received: by 10.99.121.132 with SMTP id u126mr17210858pgc.275.1517023365805;
        Fri, 26 Jan 2018 19:22:45 -0800 (PST)
Received: from software.domain.org ([172.247.34.138])
        by smtp.gmail.com with ESMTPSA id r13sm8821174pgt.27.2018.01.26.19.22.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Jan 2018 19:22:45 -0800 (PST)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     James Hogan <james.hogan@mips.com>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH V2 12/12] MIPS: Loongson: Introduce and use WAR_LLSC_MB
Date:   Sat, 27 Jan 2018 11:23:01 +0800
Message-Id: <1517023381-17624-3-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1517023381-17624-1-git-send-email-chenhc@lemote.com>
References: <1517022752-3053-1-git-send-email-chenhc@lemote.com>
 <1517023381-17624-1-git-send-email-chenhc@lemote.com>
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62355
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
 arch/mips/include/asm/atomic.h  | 18 ++++++++++++++++--
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
 11 files changed, 88 insertions(+), 14 deletions(-)

diff --git a/arch/mips/include/asm/atomic.h b/arch/mips/include/asm/atomic.h
index 0ab176b..99a6d01 100644
--- a/arch/mips/include/asm/atomic.h
+++ b/arch/mips/include/asm/atomic.h
@@ -62,6 +62,7 @@ static __inline__ void atomic_##op(int i, atomic_t * v)			      \
 		do {							      \
 			__asm__ __volatile__(				      \
 			"	.set	"MIPS_ISA_LEVEL"		\n"   \
+			__WAR_LLSC_MB					      \
 			"	ll	%0, %1		# atomic_" #op "\n"   \
 			"	" #asm_op " %0, %2			\n"   \
 			"	sc	%0, %1				\n"   \
@@ -69,6 +70,7 @@ static __inline__ void atomic_##op(int i, atomic_t * v)			      \
 			: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (v->counter)  \
 			: "Ir" (i));					      \
 		} while (unlikely(!temp));				      \
+		__asm__ __volatile__(__WAR_LLSC_MB : : :"memory");	      \
 	} else {							      \
 		unsigned long flags;					      \
 									      \
@@ -103,6 +105,7 @@ static __inline__ int atomic_##op##_return_relaxed(int i, atomic_t * v)	      \
 		do {							      \
 			__asm__ __volatile__(				      \
 			"	.set	"MIPS_ISA_LEVEL"		\n"   \
+			__WAR_LLSC_MB					      \
 			"	ll	%1, %2	# atomic_" #op "_return	\n"   \
 			"	" #asm_op " %0, %1, %3			\n"   \
 			"	sc	%0, %2				\n"   \
@@ -151,6 +154,7 @@ static __inline__ int atomic_fetch_##op##_relaxed(int i, atomic_t * v)	      \
 		do {							      \
 			__asm__ __volatile__(				      \
 			"	.set	"MIPS_ISA_LEVEL"		\n"   \
+			__WAR_LLSC_MB					      \
 			"	ll	%1, %2	# atomic_fetch_" #op "	\n"   \
 			"	" #asm_op " %0, %1, %3			\n"   \
 			"	sc	%0, %2				\n"   \
@@ -159,6 +163,7 @@ static __inline__ int atomic_fetch_##op##_relaxed(int i, atomic_t * v)	      \
 			  "+" GCC_OFF_SMALL_ASM() (v->counter)		      \
 			: "Ir" (i));					      \
 		} while (unlikely(!result));				      \
+		__asm__ __volatile__(__WAR_LLSC_MB : : :"memory");	      \
 									      \
 		result = temp;						      \
 	} else {							      \
@@ -242,7 +247,9 @@ static __inline__ int atomic_sub_if_positive(int i, atomic_t * v)
 
 		__asm__ __volatile__(
 		"	.set	"MIPS_ISA_LEVEL"			\n"
-		"1:	ll	%1, %2		# atomic_sub_if_positive\n"
+		"1:			# atomic_sub_if_positive	\n"
+		__WAR_LLSC_MB
+		"	ll	%1, %2					\n"
 		"	subu	%0, %1, %3				\n"
 		"	bltz	%0, 1f					\n"
 		"	sc	%0, %2					\n"
@@ -404,6 +411,7 @@ static __inline__ void atomic64_##op(long i, atomic64_t * v)		      \
 		do {							      \
 			__asm__ __volatile__(				      \
 			"	.set	"MIPS_ISA_LEVEL"		\n"   \
+			__WAR_LLSC_MB					      \
 			"	lld	%0, %1		# atomic64_" #op "\n" \
 			"	" #asm_op " %0, %2			\n"   \
 			"	scd	%0, %1				\n"   \
@@ -411,6 +419,7 @@ static __inline__ void atomic64_##op(long i, atomic64_t * v)		      \
 			: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (v->counter)      \
 			: "Ir" (i));					      \
 		} while (unlikely(!temp));				      \
+		__asm__ __volatile__(__WAR_LLSC_MB : : :"memory");	      \
 	} else {							      \
 		unsigned long flags;					      \
 									      \
@@ -445,6 +454,7 @@ static __inline__ long atomic64_##op##_return_relaxed(long i, atomic64_t * v) \
 		do {							      \
 			__asm__ __volatile__(				      \
 			"	.set	"MIPS_ISA_LEVEL"		\n"   \
+			__WAR_LLSC_MB					      \
 			"	lld	%1, %2	# atomic64_" #op "_return\n"  \
 			"	" #asm_op " %0, %1, %3			\n"   \
 			"	scd	%0, %2				\n"   \
@@ -494,6 +504,7 @@ static __inline__ long atomic64_fetch_##op##_relaxed(long i, atomic64_t * v)  \
 		do {							      \
 			__asm__ __volatile__(				      \
 			"	.set	"MIPS_ISA_LEVEL"		\n"   \
+			__WAR_LLSC_MB					      \
 			"	lld	%1, %2	# atomic64_fetch_" #op "\n"   \
 			"	" #asm_op " %0, %1, %3			\n"   \
 			"	scd	%0, %2				\n"   \
@@ -503,6 +514,7 @@ static __inline__ long atomic64_fetch_##op##_relaxed(long i, atomic64_t * v)  \
 			: "Ir" (i), GCC_OFF_SMALL_ASM() (v->counter)	      \
 			: "memory");					      \
 		} while (unlikely(!result));				      \
+		__asm__ __volatile__(__WAR_LLSC_MB : : :"memory");	      \
 									      \
 		result = temp;						      \
 	} else {							      \
@@ -587,7 +599,9 @@ static __inline__ long atomic64_sub_if_positive(long i, atomic64_t * v)
 
 		__asm__ __volatile__(
 		"	.set	"MIPS_ISA_LEVEL"			\n"
-		"1:	lld	%1, %2		# atomic64_sub_if_positive\n"
+		"1:			# atomic64_sub_if_positive	\n"
+		__WAR_LLSC_MB
+		"	lld	%1, %2					\n"
 		"	dsubu	%0, %1, %3				\n"
 		"	bltz	%0, 1f					\n"
 		"	scd	%0, %2					\n"
diff --git a/arch/mips/include/asm/barrier.h b/arch/mips/include/asm/barrier.h
index 0e8e6af..268d921 100644
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
index da1b871..0612cff 100644
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
index 1a508a7..729e001 100644
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
index 58c6f63..342fbff 100644
--- a/arch/mips/kernel/syscall.c
+++ b/arch/mips/kernel/syscall.c
@@ -133,6 +133,7 @@ static inline int mips_atomic_set(unsigned long addr, unsigned long new)
 		"	.set	"MIPS_ISA_ARCH_LEVEL"			\n"
 		"	li	%[err], 0				\n"
 		"1:							\n"
+		__WAR_LLSC_MB
 		user_ll("%[old]", "(%[addr])")
 		"	move	%[tmp], %[new]				\n"
 		"2:							\n"
@@ -156,6 +157,7 @@ static inline int mips_atomic_set(unsigned long addr, unsigned long new)
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
index 3d3dfba..a507ba7 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -919,6 +919,8 @@ build_get_pgd_vmalloc64(u32 **p, struct uasm_label **l, struct uasm_reloc **r,
 		 * to mimic that here by taking a load/istream page
 		 * fault.
 		 */
+		if (current_cpu_type() == CPU_LOONGSON3)
+			uasm_i_sync(p, 0);
 		UASM_i_LA(p, ptr, (unsigned long)tlb_do_page_fault_0);
 		uasm_i_jr(p, ptr);
 
@@ -1545,6 +1547,7 @@ static void build_loongson3_tlb_refill_handler(void)
 
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
@@ -2262,6 +2267,8 @@ static void build_r4000_tlb_load_handler(void)
 #endif
 
 	uasm_l_nopage_tlbl(&l, p);
+	if (current_cpu_type() == CPU_LOONGSON3)
+		uasm_i_sync(&p, 0);
 	build_restore_work_registers(&p);
 #ifdef CONFIG_CPU_MICROMIPS
 	if ((unsigned long)tlb_do_page_fault_0 & 1) {
@@ -2317,6 +2324,8 @@ static void build_r4000_tlb_store_handler(void)
 #endif
 
 	uasm_l_nopage_tlbs(&l, p);
+	if (current_cpu_type() == CPU_LOONGSON3)
+		uasm_i_sync(&p, 0);
 	build_restore_work_registers(&p);
 #ifdef CONFIG_CPU_MICROMIPS
 	if ((unsigned long)tlb_do_page_fault_1 & 1) {
@@ -2373,6 +2382,8 @@ static void build_r4000_tlb_modify_handler(void)
 #endif
 
 	uasm_l_nopage_tlbm(&l, p);
+	if (current_cpu_type() == CPU_LOONGSON3)
+		uasm_i_sync(&p, 0);
 	build_restore_work_registers(&p);
 #ifdef CONFIG_CPU_MICROMIPS
 	if ((unsigned long)tlb_do_page_fault_1 & 1) {
-- 
2.7.0
