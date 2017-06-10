Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Jun 2017 02:27:38 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:15645 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993955AbdFJA1bFos2t (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 10 Jun 2017 02:27:31 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 14DBDB5C1AEC;
        Sat, 10 Jun 2017 01:27:16 +0100 (IST)
Received: from localhost (10.20.1.33) by HHMAIL01.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Sat, 10 Jun 2017 01:27:17
 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 01/11] MIPS: cmpxchg: Unify R10000_LLSC_WAR & non-R10000_LLSC_WAR cases
Date:   Fri, 9 Jun 2017 17:26:33 -0700
Message-ID: <20170610002644.8434-2-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.13.1
In-Reply-To: <20170610002644.8434-1-paul.burton@imgtec.com>
References: <20170610002644.8434-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.1.33]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58390
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

Prior to this patch the xchg & cmpxchg functions have duplicated code
which is for all intents & purposes identical apart from use of a
branch-likely instruction in the R10000_LLSC_WAR case & a regular branch
instruction in the non-R10000_LLSC_WAR case.

This patch removes the duplication, declaring a __scbeqz macro to select
the branch instruction suitable for use when checking the result of an
sc instruction & making use of it to unify the 2 cases.

In __xchg_u{32,64}() this means writing the branch in asm, where it was
previously being done in C as a do...while loop for the
non-R10000_LLSC_WAR case. As this is a single instruction, and adds
consistency with the R10000_LLSC_WAR cases & the cmpxchg() code, this
seems worthwhile.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---

 arch/mips/include/asm/cmpxchg.h | 80 ++++++++++++-----------------------------
 1 file changed, 22 insertions(+), 58 deletions(-)

diff --git a/arch/mips/include/asm/cmpxchg.h b/arch/mips/include/asm/cmpxchg.h
index b71ab4a5fd50..0582c01d229d 100644
--- a/arch/mips/include/asm/cmpxchg.h
+++ b/arch/mips/include/asm/cmpxchg.h
@@ -13,44 +13,38 @@
 #include <asm/compiler.h>
 #include <asm/war.h>
 
+/*
+ * Using a branch-likely instruction to check the result of an sc instruction
+ * works around a bug present in R10000 CPUs prior to revision 3.0 that could
+ * cause ll-sc sequences to execute non-atomically.
+ */
+#if R10000_LLSC_WAR
+# define __scbeqz "beqzl"
+#else
+# define __scbeqz "beqz"
+#endif
+
 static inline unsigned long __xchg_u32(volatile int * m, unsigned int val)
 {
 	__u32 retval;
 
 	smp_mb__before_llsc();
 
-	if (kernel_uses_llsc && R10000_LLSC_WAR) {
+	if (kernel_uses_llsc) {
 		unsigned long dummy;
 
 		__asm__ __volatile__(
-		"	.set	arch=r4000				\n"
+		"	.set	" MIPS_ISA_ARCH_LEVEL "			\n"
 		"1:	ll	%0, %3			# xchg_u32	\n"
 		"	.set	mips0					\n"
 		"	move	%2, %z4					\n"
-		"	.set	arch=r4000				\n"
+		"	.set	" MIPS_ISA_ARCH_LEVEL "			\n"
 		"	sc	%2, %1					\n"
-		"	beqzl	%2, 1b					\n"
+		"\t" __scbeqz "	%2, 1b					\n"
 		"	.set	mips0					\n"
 		: "=&r" (retval), "=" GCC_OFF_SMALL_ASM() (*m), "=&r" (dummy)
 		: GCC_OFF_SMALL_ASM() (*m), "Jr" (val)
 		: "memory");
-	} else if (kernel_uses_llsc) {
-		unsigned long dummy;
-
-		do {
-			__asm__ __volatile__(
-			"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"
-			"	ll	%0, %3		# xchg_u32	\n"
-			"	.set	mips0				\n"
-			"	move	%2, %z4				\n"
-			"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"
-			"	sc	%2, %1				\n"
-			"	.set	mips0				\n"
-			: "=&r" (retval), "=" GCC_OFF_SMALL_ASM() (*m),
-			  "=&r" (dummy)
-			: GCC_OFF_SMALL_ASM() (*m), "Jr" (val)
-			: "memory");
-		} while (unlikely(!dummy));
 	} else {
 		unsigned long flags;
 
@@ -72,34 +66,19 @@ static inline __u64 __xchg_u64(volatile __u64 * m, __u64 val)
 
 	smp_mb__before_llsc();
 
-	if (kernel_uses_llsc && R10000_LLSC_WAR) {
+	if (kernel_uses_llsc) {
 		unsigned long dummy;
 
 		__asm__ __volatile__(
-		"	.set	arch=r4000				\n"
+		"	.set	" MIPS_ISA_ARCH_LEVEL "			\n"
 		"1:	lld	%0, %3			# xchg_u64	\n"
 		"	move	%2, %z4					\n"
 		"	scd	%2, %1					\n"
-		"	beqzl	%2, 1b					\n"
+		"\t" __scbeqz "	%2, 1b					\n"
 		"	.set	mips0					\n"
 		: "=&r" (retval), "=" GCC_OFF_SMALL_ASM() (*m), "=&r" (dummy)
 		: GCC_OFF_SMALL_ASM() (*m), "Jr" (val)
 		: "memory");
-	} else if (kernel_uses_llsc) {
-		unsigned long dummy;
-
-		do {
-			__asm__ __volatile__(
-			"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"
-			"	lld	%0, %3		# xchg_u64	\n"
-			"	move	%2, %z4				\n"
-			"	scd	%2, %1				\n"
-			"	.set	mips0				\n"
-			: "=&r" (retval), "=" GCC_OFF_SMALL_ASM() (*m),
-			  "=&r" (dummy)
-			: GCC_OFF_SMALL_ASM() (*m), "Jr" (val)
-			: "memory");
-		} while (unlikely(!dummy));
 	} else {
 		unsigned long flags;
 
@@ -142,24 +121,7 @@ static inline unsigned long __xchg(unsigned long x, volatile void * ptr, int siz
 ({									\
 	__typeof(*(m)) __ret;						\
 									\
-	if (kernel_uses_llsc && R10000_LLSC_WAR) {			\
-		__asm__ __volatile__(					\
-		"	.set	push				\n"	\
-		"	.set	noat				\n"	\
-		"	.set	arch=r4000			\n"	\
-		"1:	" ld "	%0, %2		# __cmpxchg_asm \n"	\
-		"	bne	%0, %z3, 2f			\n"	\
-		"	.set	mips0				\n"	\
-		"	move	$1, %z4				\n"	\
-		"	.set	arch=r4000			\n"	\
-		"	" st "	$1, %1				\n"	\
-		"	beqzl	$1, 1b				\n"	\
-		"2:						\n"	\
-		"	.set	pop				\n"	\
-		: "=&r" (__ret), "=" GCC_OFF_SMALL_ASM() (*m)		\
-		: GCC_OFF_SMALL_ASM() (*m), "Jr" (old), "Jr" (new)		\
-		: "memory");						\
-	} else if (kernel_uses_llsc) {					\
+	if (kernel_uses_llsc) {						\
 		__asm__ __volatile__(					\
 		"	.set	push				\n"	\
 		"	.set	noat				\n"	\
@@ -170,7 +132,7 @@ static inline unsigned long __xchg(unsigned long x, volatile void * ptr, int siz
 		"	move	$1, %z4				\n"	\
 		"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"	\
 		"	" st "	$1, %1				\n"	\
-		"	beqz	$1, 1b				\n"	\
+		"\t" __scbeqz "	$1, 1b				\n"	\
 		"	.set	pop				\n"	\
 		"2:						\n"	\
 		: "=&r" (__ret), "=" GCC_OFF_SMALL_ASM() (*m)		\
@@ -245,4 +207,6 @@ extern void __cmpxchg_called_with_bad_pointer(void);
 #define cmpxchg64(ptr, o, n) cmpxchg64_local((ptr), (o), (n))
 #endif
 
+#undef __scbeqz
+
 #endif /* __ASM_CMPXCHG_H */
-- 
2.13.1
