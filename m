Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Nov 2017 16:24:06 +0100 (CET)
Received: from resqmta-po-05v.sys.comcast.net ([IPv6:2001:558:fe16:19:96:114:154:164]:33574
        "EHLO resqmta-po-05v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990590AbdKQPX5k4yuK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 Nov 2017 16:23:57 +0100
Received: from resomta-po-03v.sys.comcast.net ([96.114.154.227])
        by resqmta-po-05v.sys.comcast.net with ESMTP
        id FiRDe0fzPsdQ7FiSIeM9UC; Fri, 17 Nov 2017 15:21:22 +0000
Received: from [192.168.1.13] ([73.173.137.35])
        by resomta-po-03v.sys.comcast.net with SMTP
        id FiSGeWcWRuXCzFiSHevIyE; Fri, 17 Nov 2017 15:21:22 +0000
To:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@mips.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     Paul Burton <paul.burton@mips.com>,
        Linux/MIPS <linux-mips@linux-mips.org>
From:   Joshua Kinard <kumba@gentoo.org>
Subject: [PATCH v3] MIPS: Cleanup R10000_LLSC_WAR logic in atomic.h
Message-ID: <23fb0d7b-347a-195d-38f3-383ac59cc69d@gentoo.org>
Date:   Fri, 17 Nov 2017 10:21:00 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfHEFxPmFpiLoP99CYbdRxEar2OST0XxQVz4tLJ1eSuYhTETcuD87w668J3o8/wCDuMT77C7OXVpKJR7A123QX6cnVhdkPXPl/dXj8Clx87CfuDsvD5om
 f3YRVsan3gkLnruQCaml5uqUVBYuLFsArwdc2qfsWQhLDW6zZ/jKajB4oo/nFp87ZnQX5aKZleEc+/LzMG8bk6nIAoHhzeeI/wMPTcrO1Xd9KzUlg+zTiZJk
 j3qcqFGCO5qEWBdLVQV6C6dqFQJwPNMVXyob+es+M9woIhp1h6uGMzJoIFbzUUGh
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60995
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

This patch reduces down the conditionals in MIPS atomic code that deal
with a silicon bug in early R10000 cpus that required a workaround of
a branch-likely instruction following a store-conditional in order to
to guarantee the whole ll/sc sequence is atomic.  As the only real
difference is a branch-likely instruction (beqzl) over a standard
branch (beqz), the conditional is reduced down to down to a single
preprocessor check at the top to pick the required instruction.

This requires writing the uses in assembler, thus we discard the
non-R10000 case that uses a mixture of a C do...while loop with
embedded assembler that was added back in commit 7837314d141c.  A note
found in the git log for empty commit 5999eca25c1f is also addressed
and all uses of the 'noreorder' directive are eliminated, allowing GAS
to handle scheduling of the assembler.

The macro definition for the branch instruction and the code comment
derives from a patch sent in earlier by Paul Burton for various cmpxchg
cleanups.

Cc: linux-mips@linux-mips.org
Cc: Paul Burton <paul.burton@mips.com>
Signed-off-by: Joshua Kinard <kumba@gentoo.org>
Tested-by: Joshua Kinard <kumba@gentoo.org>

---
Changes in v3:
- Make the result of subu/dsubu available to sc/scd in
  atomic_sub_if_positive and atomic64_sub_if_positive while still
  avoiding the use of 'noreorder'.

Changes in v2:
- Incorporate suggestions from upstream to atomic_sub_if_positive
  and atomic64_sub_if_positive to avoid memory barriers, as those
  are already implied and to eliminate the '.noreorder' directive
  and corner case of subu/dsubu's output not getting used in the
  branch-likely case due to being in the branch delay slot.

---
 arch/mips/include/asm/atomic.h |  199 +++++--------------------------
 1 file changed, 38 insertions(+), 161 deletions(-)

diff --git a/arch/mips/include/asm/atomic.h b/arch/mips/include/asm/atomic.h
index 0ab176bdb8e8..629c4fca26a9 100644
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
@@ -218,38 +184,17 @@ static __inline__ int atomic_sub_if_positive(int i, atomic_t * v)
 
 	smp_mb__before_llsc();
 
-	if (kernel_uses_llsc && R10000_LLSC_WAR) {
-		int temp;
-
-		__asm__ __volatile__(
-		"	.set	arch=r4000				\n"
-		"1:	ll	%1, %2		# atomic_sub_if_positive\n"
-		"	subu	%0, %1, %3				\n"
-		"	bltz	%0, 1f					\n"
-		"	sc	%0, %2					\n"
-		"	.set	noreorder				\n"
-		"	beqzl	%0, 1b					\n"
-		"	 subu	%0, %1, %3				\n"
-		"	.set	reorder					\n"
-		"1:							\n"
-		"	.set	mips0					\n"
-		: "=&r" (result), "=&r" (temp),
-		  "+" GCC_OFF_SMALL_ASM() (v->counter)
-		: "Ir" (i), GCC_OFF_SMALL_ASM() (v->counter)
-		: "memory");
-	} else if (kernel_uses_llsc) {
+	if (kernel_uses_llsc) {
 		int temp;
 
 		__asm__ __volatile__(
 		"	.set	"MIPS_ISA_LEVEL"			\n"
 		"1:	ll	%1, %2		# atomic_sub_if_positive\n"
 		"	subu	%0, %1, %3				\n"
+		"	move	%1, %0					\n"
 		"	bltz	%0, 1f					\n"
-		"	sc	%0, %2					\n"
-		"	.set	noreorder				\n"
-		"	beqz	%0, 1b					\n"
-		"	 subu	%0, %1, %3				\n"
-		"	.set	reorder					\n"
+		"	sc	%1, %2					\n"
+		"\t" __scbeqz "	%1, 1b					\n"
 		"1:							\n"
 		"	.set	mips0					\n"
 		: "=&r" (result), "=&r" (temp),
@@ -386,31 +331,18 @@ static __inline__ int __atomic_add_unless(atomic_t *v, int a, int u)
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
@@ -425,37 +357,20 @@ static __inline__ long atomic64_##op##_return_relaxed(long i, atomic64_t * v) \
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
@@ -474,37 +389,20 @@ static __inline__ long atomic64_fetch_##op##_relaxed(long i, atomic64_t * v)  \
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
@@ -563,42 +461,21 @@ static __inline__ long atomic64_sub_if_positive(long i, atomic64_t * v)
 
 	smp_mb__before_llsc();
 
-	if (kernel_uses_llsc && R10000_LLSC_WAR) {
-		long temp;
-
-		__asm__ __volatile__(
-		"	.set	arch=r4000				\n"
-		"1:	lld	%1, %2		# atomic64_sub_if_positive\n"
-		"	dsubu	%0, %1, %3				\n"
-		"	bltz	%0, 1f					\n"
-		"	scd	%0, %2					\n"
-		"	.set	noreorder				\n"
-		"	beqzl	%0, 1b					\n"
-		"	 dsubu	%0, %1, %3				\n"
-		"	.set	reorder					\n"
-		"1:							\n"
-		"	.set	mips0					\n"
-		: "=&r" (result), "=&r" (temp),
-		  "=" GCC_OFF_SMALL_ASM() (v->counter)
-		: "Ir" (i), GCC_OFF_SMALL_ASM() (v->counter)
-		: "memory");
-	} else if (kernel_uses_llsc) {
+	if (kernel_uses_llsc) {
 		long temp;
 
 		__asm__ __volatile__(
 		"	.set	"MIPS_ISA_LEVEL"			\n"
 		"1:	lld	%1, %2		# atomic64_sub_if_positive\n"
 		"	dsubu	%0, %1, %3				\n"
+		"	move	%1, %0					\n"
 		"	bltz	%0, 1f					\n"
-		"	scd	%0, %2					\n"
-		"	.set	noreorder				\n"
-		"	beqz	%0, 1b					\n"
-		"	 dsubu	%0, %1, %3				\n"
-		"	.set	reorder					\n"
+		"	scd	%1, %2					\n"
+		"\t" __scbeqz "	%1, 1b					\n"
 		"1:							\n"
 		"	.set	mips0					\n"
 		: "=&r" (result), "=&r" (temp),
-		  "+" GCC_OFF_SMALL_ASM() (v->counter)
+		  "=" GCC_OFF_SMALL_ASM() (v->counter)
 		: "Ir" (i));
 	} else {
 		unsigned long flags;
