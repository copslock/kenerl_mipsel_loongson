Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Oct 2017 21:01:17 +0200 (CEST)
Received: from resqmta-ch2-05v.sys.comcast.net ([IPv6:2001:558:fe21:29:69:252:207:37]:33032
        "EHLO resqmta-ch2-05v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992318AbdJQTBKwhoTX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 Oct 2017 21:01:10 +0200
Received: from resomta-ch2-03v.sys.comcast.net ([69.252.207.99])
        by resqmta-ch2-05v.sys.comcast.net with ESMTP
        id 4X2Xe6o7P0MXt4X4XezFjq; Tue, 17 Oct 2017 18:58:37 +0000
Received: from [192.168.1.13] ([73.173.137.35])
        by resomta-ch2-03v.sys.comcast.net with SMTP
        id 4X4Ve849p0v3O4X4Vexz1h; Tue, 17 Oct 2017 18:58:37 +0000
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux/MIPS <linux-mips@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
From:   Joshua Kinard <kumba@gentoo.org>
Subject: [PATCH] MIPS: Cleanup R10000_LLSC_WAR logic in atomic.h
Message-ID: <5baf0f58-862b-2488-8685-bf7383b19c20@gentoo.org>
Date:   Tue, 17 Oct 2017 14:58:27 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfDRCzLVvNTnTgLKjB7E7JadYkAzZjyGXf8IHDQQMHpqpC2Oaqzr1RUnvr6NeazJy3L1SJJFopobSGc0dHdT1LKS7D8x+PXl1nd9FJGXNDc8FrpnDEKJn
 B3YARPVkKjI2OMpQGwCubjb7fCawDl/AexPvay8nFdTO1cuAjRVsu7aPlj+rpke2vo5TH3Oq3EfFCX3kjNrqXGI9vq6Fax7WrWxuZUGCT8i2sfscfIH//9ry
 cJ7DUiGHVLyi/1OjzfM7gQ==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60434
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
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

From: Joshua Kinard <kumba@gentoo.org>

This patch reduces down the conditionals in MIPS atomic code that
deal with a silicon bug in early R10000 cpus that required a workaround
of a branch-likely instruction following a store-conditional in order
to guarantee the whole ll/sc sequence is atomic.  As the only real
difference is a branch-likely instruction (beqzl) over a standard
branch (beqz), the conditional is reduced down to down to a single
preprocessor check at the top to pick the required instruction.

This requires writing the uses in assembler, thus we discard the
non-R10000 case that uses a mixture of a C do...while loop with
embedded assembler that was added back in commit 7837314d141c, while
also addressing a note found in the git log for empty commit
5999eca25c1f.

The macro definition for the branch instruction and the code comment
derives from a patch sent in earlier by Paul Burton for various cmpxchg
cleanups.

Cc: linux-mips@linux-mips.org
Cc: Paul Burton <paul.burton@imgtec.com>
Signed-off-by: Joshua Kinard <kumba@gentoo.org>
---
 arch/mips/include/asm/atomic.h |  187 +++++--------------------------
 1 file changed, 35 insertions(+), 152 deletions(-)

diff --git a/arch/mips/include/asm/atomic.h b/arch/mips/include/asm/atomic.h
index 0ab176bdb8e8..404e64e57a72 100644
--- a/arch/mips/include/asm/atomic.h
+++ b/arch/mips/include/asm/atomic.h
@@ -22,6 +22,17 @@
 #include <asm/cmpxchg.h>
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
 #define ATOMIC_INIT(i)	  { (i) }
 
 /*
@@ -44,31 +55,18 @@
 #define ATOMIC_OP(op, c_op, asm_op)					      \
 static __inline__ void atomic_##op(int i, atomic_t * v)			      \
 {									      \
-	if (kernel_uses_llsc && R10000_LLSC_WAR) {			      \
+	if (kernel_uses_llsc) {						      \
 		int temp;						      \
 									      \
 		__asm__ __volatile__(					      \
-		"	.set	arch=r4000				\n"   \
+		"	.set	"MIPS_ISA_LEVEL"			\n"   \
 		"1:	ll	%0, %1		# atomic_" #op "	\n"   \
 		"	" #asm_op " %0, %2				\n"   \
 		"	sc	%0, %1					\n"   \
-		"	beqzl	%0, 1b					\n"   \
+		"\t" __scbeqz "	%0, 1b					\n"   \
 		"	.set	mips0					\n"   \
 		: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (v->counter)	      \
 		: "Ir" (i));						      \
-	} else if (kernel_uses_llsc) {					      \
-		int temp;						      \
-									      \
-		do {							      \
-			__asm__ __volatile__(				      \
-			"	.set	"MIPS_ISA_LEVEL"		\n"   \
-			"	ll	%0, %1		# atomic_" #op "\n"   \
-			"	" #asm_op " %0, %2			\n"   \
-			"	sc	%0, %1				\n"   \
-			"	.set	mips0				\n"   \
-			: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (v->counter)  \
-			: "Ir" (i));					      \
-		} while (unlikely(!temp));				      \
 	} else {							      \
 		unsigned long flags;					      \
 									      \
@@ -83,36 +81,20 @@ static __inline__ int atomic_##op##_return_relaxed(int i, atomic_t * v)	      \
 {									      \
 	int result;							      \
 									      \
-	if (kernel_uses_llsc && R10000_LLSC_WAR) {			      \
+	if (kernel_uses_llsc) {						      \
 		int temp;						      \
 									      \
 		__asm__ __volatile__(					      \
-		"	.set	arch=r4000				\n"   \
+		"	.set	"MIPS_ISA_LEVEL"			\n"   \
 		"1:	ll	%1, %2		# atomic_" #op "_return	\n"   \
 		"	" #asm_op " %0, %1, %3				\n"   \
 		"	sc	%0, %2					\n"   \
-		"	beqzl	%0, 1b					\n"   \
+		"\t" __scbeqz "	%0, 1b					\n"   \
 		"	" #asm_op " %0, %1, %3				\n"   \
 		"	.set	mips0					\n"   \
 		: "=&r" (result), "=&r" (temp),				      \
 		  "+" GCC_OFF_SMALL_ASM() (v->counter)			      \
 		: "Ir" (i));						      \
-	} else if (kernel_uses_llsc) {					      \
-		int temp;						      \
-									      \
-		do {							      \
-			__asm__ __volatile__(				      \
-			"	.set	"MIPS_ISA_LEVEL"		\n"   \
-			"	ll	%1, %2	# atomic_" #op "_return	\n"   \
-			"	" #asm_op " %0, %1, %3			\n"   \
-			"	sc	%0, %2				\n"   \
-			"	.set	mips0				\n"   \
-			: "=&r" (result), "=&r" (temp),			      \
-			  "+" GCC_OFF_SMALL_ASM() (v->counter)		      \
-			: "Ir" (i));					      \
-		} while (unlikely(!result));				      \
-									      \
-		result = temp; result c_op i;				      \
 	} else {							      \
 		unsigned long flags;					      \
 									      \
@@ -131,36 +113,20 @@ static __inline__ int atomic_fetch_##op##_relaxed(int i, atomic_t * v)	      \
 {									      \
 	int result;							      \
 									      \
-	if (kernel_uses_llsc && R10000_LLSC_WAR) {			      \
+	if (kernel_uses_llsc) {						      \
 		int temp;						      \
 									      \
 		__asm__ __volatile__(					      \
-		"	.set	arch=r4000				\n"   \
+		"	.set	"MIPS_ISA_LEVEL"			\n"   \
 		"1:	ll	%1, %2		# atomic_fetch_" #op "	\n"   \
 		"	" #asm_op " %0, %1, %3				\n"   \
 		"	sc	%0, %2					\n"   \
-		"	beqzl	%0, 1b					\n"   \
+		"\t" __scbeqz "	%0, 1b					\n"   \
 		"	move	%0, %1					\n"   \
 		"	.set	mips0					\n"   \
 		: "=&r" (result), "=&r" (temp),				      \
 		  "+" GCC_OFF_SMALL_ASM() (v->counter)			      \
 		: "Ir" (i));						      \
-	} else if (kernel_uses_llsc) {					      \
-		int temp;						      \
-									      \
-		do {							      \
-			__asm__ __volatile__(				      \
-			"	.set	"MIPS_ISA_LEVEL"		\n"   \
-			"	ll	%1, %2	# atomic_fetch_" #op "	\n"   \
-			"	" #asm_op " %0, %1, %3			\n"   \
-			"	sc	%0, %2				\n"   \
-			"	.set	mips0				\n"   \
-			: "=&r" (result), "=&r" (temp),			      \
-			  "+" GCC_OFF_SMALL_ASM() (v->counter)		      \
-			: "Ir" (i));					      \
-		} while (unlikely(!result));				      \
-									      \
-		result = temp;						      \
 	} else {							      \
 		unsigned long flags;					      \
 									      \
@@ -218,17 +184,17 @@ static __inline__ int atomic_sub_if_positive(int i, atomic_t * v)
 
 	smp_mb__before_llsc();
 
-	if (kernel_uses_llsc && R10000_LLSC_WAR) {
+	if (kernel_uses_llsc) {
 		int temp;
 
 		__asm__ __volatile__(
-		"	.set	arch=r4000				\n"
+		"	.set	"MIPS_ISA_LEVEL"			\n"
 		"1:	ll	%1, %2		# atomic_sub_if_positive\n"
 		"	subu	%0, %1, %3				\n"
 		"	bltz	%0, 1f					\n"
 		"	sc	%0, %2					\n"
 		"	.set	noreorder				\n"
-		"	beqzl	%0, 1b					\n"
+		"\t" __scbeqz "	%0, 1b					\n"
 		"	 subu	%0, %1, %3				\n"
 		"	.set	reorder					\n"
 		"1:							\n"
@@ -237,24 +203,6 @@ static __inline__ int atomic_sub_if_positive(int i, atomic_t * v)
 		  "+" GCC_OFF_SMALL_ASM() (v->counter)
 		: "Ir" (i), GCC_OFF_SMALL_ASM() (v->counter)
 		: "memory");
-	} else if (kernel_uses_llsc) {
-		int temp;
-
-		__asm__ __volatile__(
-		"	.set	"MIPS_ISA_LEVEL"			\n"
-		"1:	ll	%1, %2		# atomic_sub_if_positive\n"
-		"	subu	%0, %1, %3				\n"
-		"	bltz	%0, 1f					\n"
-		"	sc	%0, %2					\n"
-		"	.set	noreorder				\n"
-		"	beqz	%0, 1b					\n"
-		"	 subu	%0, %1, %3				\n"
-		"	.set	reorder					\n"
-		"1:							\n"
-		"	.set	mips0					\n"
-		: "=&r" (result), "=&r" (temp),
-		  "+" GCC_OFF_SMALL_ASM() (v->counter)
-		: "Ir" (i));
 	} else {
 		unsigned long flags;
 
@@ -386,31 +334,18 @@ static __inline__ int __atomic_add_unless(atomic_t *v, int a, int u)
 #define ATOMIC64_OP(op, c_op, asm_op)					      \
 static __inline__ void atomic64_##op(long i, atomic64_t * v)		      \
 {									      \
-	if (kernel_uses_llsc && R10000_LLSC_WAR) {			      \
+	if (kernel_uses_llsc) {						      \
 		long temp;						      \
 									      \
 		__asm__ __volatile__(					      \
-		"	.set	arch=r4000				\n"   \
+		"	.set	"MIPS_ISA_LEVEL"			\n"   \
 		"1:	lld	%0, %1		# atomic64_" #op "	\n"   \
 		"	" #asm_op " %0, %2				\n"   \
 		"	scd	%0, %1					\n"   \
-		"	beqzl	%0, 1b					\n"   \
+		"\t" __scbeqz "	%0, 1b					\n"   \
 		"	.set	mips0					\n"   \
 		: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (v->counter)	      \
 		: "Ir" (i));						      \
-	} else if (kernel_uses_llsc) {					      \
-		long temp;						      \
-									      \
-		do {							      \
-			__asm__ __volatile__(				      \
-			"	.set	"MIPS_ISA_LEVEL"		\n"   \
-			"	lld	%0, %1		# atomic64_" #op "\n" \
-			"	" #asm_op " %0, %2			\n"   \
-			"	scd	%0, %1				\n"   \
-			"	.set	mips0				\n"   \
-			: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (v->counter)      \
-			: "Ir" (i));					      \
-		} while (unlikely(!temp));				      \
 	} else {							      \
 		unsigned long flags;					      \
 									      \
@@ -425,37 +360,20 @@ static __inline__ long atomic64_##op##_return_relaxed(long i, atomic64_t * v) \
 {									      \
 	long result;							      \
 									      \
-	if (kernel_uses_llsc && R10000_LLSC_WAR) {			      \
+	if (kernel_uses_llsc) {						      \
 		long temp;						      \
 									      \
 		__asm__ __volatile__(					      \
-		"	.set	arch=r4000				\n"   \
+		"	.set	"MIPS_ISA_LEVEL"			\n"   \
 		"1:	lld	%1, %2		# atomic64_" #op "_return\n"  \
 		"	" #asm_op " %0, %1, %3				\n"   \
 		"	scd	%0, %2					\n"   \
-		"	beqzl	%0, 1b					\n"   \
+		"\t" __scbeqz "	%0, 1b					\n"   \
 		"	" #asm_op " %0, %1, %3				\n"   \
 		"	.set	mips0					\n"   \
 		: "=&r" (result), "=&r" (temp),				      \
 		  "+" GCC_OFF_SMALL_ASM() (v->counter)			      \
 		: "Ir" (i));						      \
-	} else if (kernel_uses_llsc) {					      \
-		long temp;						      \
-									      \
-		do {							      \
-			__asm__ __volatile__(				      \
-			"	.set	"MIPS_ISA_LEVEL"		\n"   \
-			"	lld	%1, %2	# atomic64_" #op "_return\n"  \
-			"	" #asm_op " %0, %1, %3			\n"   \
-			"	scd	%0, %2				\n"   \
-			"	.set	mips0				\n"   \
-			: "=&r" (result), "=&r" (temp),			      \
-			  "=" GCC_OFF_SMALL_ASM() (v->counter)		      \
-			: "Ir" (i), GCC_OFF_SMALL_ASM() (v->counter)	      \
-			: "memory");					      \
-		} while (unlikely(!result));				      \
-									      \
-		result = temp; result c_op i;				      \
 	} else {							      \
 		unsigned long flags;					      \
 									      \
@@ -474,37 +392,20 @@ static __inline__ long atomic64_fetch_##op##_relaxed(long i, atomic64_t * v)  \
 {									      \
 	long result;							      \
 									      \
-	if (kernel_uses_llsc && R10000_LLSC_WAR) {			      \
+	if (kernel_uses_llsc) {						      \
 		long temp;						      \
 									      \
 		__asm__ __volatile__(					      \
-		"	.set	arch=r4000				\n"   \
+		"	.set	"MIPS_ISA_LEVEL"			\n"   \
 		"1:	lld	%1, %2		# atomic64_fetch_" #op "\n"   \
 		"	" #asm_op " %0, %1, %3				\n"   \
 		"	scd	%0, %2					\n"   \
-		"	beqzl	%0, 1b					\n"   \
+		"\t" __scbeqz "	%0, 1b					\n"   \
 		"	move	%0, %1					\n"   \
 		"	.set	mips0					\n"   \
 		: "=&r" (result), "=&r" (temp),				      \
 		  "+" GCC_OFF_SMALL_ASM() (v->counter)			      \
 		: "Ir" (i));						      \
-	} else if (kernel_uses_llsc) {					      \
-		long temp;						      \
-									      \
-		do {							      \
-			__asm__ __volatile__(				      \
-			"	.set	"MIPS_ISA_LEVEL"		\n"   \
-			"	lld	%1, %2	# atomic64_fetch_" #op "\n"   \
-			"	" #asm_op " %0, %1, %3			\n"   \
-			"	scd	%0, %2				\n"   \
-			"	.set	mips0				\n"   \
-			: "=&r" (result), "=&r" (temp),			      \
-			  "=" GCC_OFF_SMALL_ASM() (v->counter)		      \
-			: "Ir" (i), GCC_OFF_SMALL_ASM() (v->counter)	      \
-			: "memory");					      \
-		} while (unlikely(!result));				      \
-									      \
-		result = temp;						      \
 	} else {							      \
 		unsigned long flags;					      \
 									      \
@@ -563,17 +464,17 @@ static __inline__ long atomic64_sub_if_positive(long i, atomic64_t * v)
 
 	smp_mb__before_llsc();
 
-	if (kernel_uses_llsc && R10000_LLSC_WAR) {
+	if (kernel_uses_llsc) {
 		long temp;
 
 		__asm__ __volatile__(
-		"	.set	arch=r4000				\n"
+		"	.set	"MIPS_ISA_LEVEL"			\n"
 		"1:	lld	%1, %2		# atomic64_sub_if_positive\n"
 		"	dsubu	%0, %1, %3				\n"
 		"	bltz	%0, 1f					\n"
 		"	scd	%0, %2					\n"
 		"	.set	noreorder				\n"
-		"	beqzl	%0, 1b					\n"
+		"\t" __scbeqz "	%0, 1b					\n"
 		"	 dsubu	%0, %1, %3				\n"
 		"	.set	reorder					\n"
 		"1:							\n"
@@ -582,24 +483,6 @@ static __inline__ long atomic64_sub_if_positive(long i, atomic64_t * v)
 		  "=" GCC_OFF_SMALL_ASM() (v->counter)
 		: "Ir" (i), GCC_OFF_SMALL_ASM() (v->counter)
 		: "memory");
-	} else if (kernel_uses_llsc) {
-		long temp;
-
-		__asm__ __volatile__(
-		"	.set	"MIPS_ISA_LEVEL"			\n"
-		"1:	lld	%1, %2		# atomic64_sub_if_positive\n"
-		"	dsubu	%0, %1, %3				\n"
-		"	bltz	%0, 1f					\n"
-		"	scd	%0, %2					\n"
-		"	.set	noreorder				\n"
-		"	beqz	%0, 1b					\n"
-		"	 dsubu	%0, %1, %3				\n"
-		"	.set	reorder					\n"
-		"1:							\n"
-		"	.set	mips0					\n"
-		: "=&r" (result), "=&r" (temp),
-		  "+" GCC_OFF_SMALL_ASM() (v->counter)
-		: "Ir" (i));
 	} else {
 		unsigned long flags;
 
