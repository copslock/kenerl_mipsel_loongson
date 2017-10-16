Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Oct 2017 07:53:43 +0200 (CEST)
Received: from resqmta-ch2-11v.sys.comcast.net ([IPv6:2001:558:fe21:29:69:252:207:43]:54306
        "EHLO resqmta-ch2-11v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990416AbdJPFxhKz0w4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 Oct 2017 07:53:37 +0200
Received: from resomta-ch2-18v.sys.comcast.net ([69.252.207.114])
        by resqmta-ch2-11v.sys.comcast.net with ESMTP
        id 3yIpeL0J7DZ6A3yIpewo14; Mon, 16 Oct 2017 05:51:03 +0000
Received: from [192.168.1.13] ([73.173.137.35])
        by resomta-ch2-18v.sys.comcast.net with SMTP
        id 3yIoeYUoslmxN3yIoeXenh; Mon, 16 Oct 2017 05:51:03 +0000
From:   Joshua Kinard <kumba@gentoo.org>
Subject: Re: Question regarding atomic ops
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
References: <eb17f62d-c347-e470-f9cf-06b18a55481e@gentoo.org>
 <4f77107c-18ba-d549-c5f2-d52d0460377b@gentoo.org>
 <20171010142306.GA24194@linux-mips.org>
Message-ID: <f25e53f7-d25d-e9d8-f592-d94e988da28e@gentoo.org>
Date:   Mon, 16 Oct 2017 01:51:01 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171010142306.GA24194@linux-mips.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfHzixLcGrNJ1KT1QjqfVelqec27cSoh9v4jtQpSg2VVs8uJqxUaBh46/6Rka3WDyOmnkjjzi6mdf3JxuNcYfUkULvngqorKMs6NREwO0jGVqE7gbftia
 twXN47rpkbK2xOJw1CKD9xcWQNPLwr+QnvR9wbPWyIa6Hd8/UuMuZ7T5BLUHfemE+JHhT6eIKag8euO/e+iW+YG5Vxk3X/R2KaI=
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60402
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

On 10/10/2017 10:23, Ralf Baechle wrote:
> On Mon, Oct 09, 2017 at 10:34:43PM -0400, Joshua Kinard wrote:
> 
>> On 10/09/2017 22:24, Joshua Kinard wrote:
>>
>> [snip]
>>
>>> This raises the question of why was the standard "kernel_uses_llsc" case
>>> changed but not the R10000_LLSC_WAR case?  The changes seem like they would be
>>> applicable to the older R10K CPUs regardless, since this is before a lot of the
>>> code for the newer ISAs (R2+) was added.  I am getting a funny feeling that a
>>> lot of these templates need to be re-written (maybe even in plain C, given
>>> newer gcc's better intelligence) and other useful cleanups done.  I am not
>>> fluent in MIPS asm enough, though, to know what to change.
>>
>> Answered one of my own questions via this buried commit from ~2006/2007 that
>> has a commit message, but no changed files:
>>
>> https://git.linux-mips.org/cgit/ralf/linux.git/commit/arch/mips/include/asm/atomic.h?id=5999eca25c1fd4b9b9aca7833b04d10fe4bc877d
>>
>>> [MIPS] Improve branch prediction in ll/sc atomic operations.
>>> Now that finally all supported versions of binutils have functioning
>>> support for .subsection use .subsection to tweak the branch prediction
>>>
>>> I did not modify the R10000 errata variants because it seems unclear if
>>> this will invalidate the workaround which actually relies on the cheesy
>>> prediction of branch likely to cause a misspredict if the sc was
>>> successful.
>>>
>>> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
>>
>> Seems like that second paragraph is a ripe candidate for a comment block so
>> this is better documented :)
> 
> Btw, I reasonably certain applying the change to the R10000 LL/SC workaround
> versions as well would work.  But testing is difficult, even with hardware
> at hand - and the other option asing a R10000 RTL designer is tricky about
> 20 years later!

Inlined below is a first-draft to cleanup atomic.h, by following Paul Burton's
patches for the cmpxchng changes he sent in a while back.  If this and his
patches both get accepted, some of the changes can probably be deduped
(especially moving the definition of __scbeqz to a common header and giving it
a more descriptive name).

The only uncertainty I have is the bottom of atomic_sub_if_positive and
atomic64_sub_if_positive.  In R10000_LLSC_WAR case, the end of the assembler is:

	  "+" GCC_OFF_SMALL_ASM() (v->counter)
	: "Ir" (i), GCC_OFF_SMALL_ASM() (v->counter)
	: "memory");

While the standard case is:

	: "=&r" (result), "=&r" (temp),
	  "+" GCC_OFF_SMALL_ASM() (v->counter)
	: "Ir" (i));

Other than that, both asm functions are virtually the same.  I am not fluent
enough in asm nor gcc's internal asm magic to decipher this, so I am not
certain which is "better", if one even is over the other.  In the draft patch,
I kept the variant from the R10000_LLSC_CASE.  If someone can explain what
differs between these two sections, that'd be helpful to determine if I
guessed correctly.

I'll send a proper/final patch in a few days, based on any feedback.

Thanks!


Draft:

 arch/mips/include/asm/atomic.h |  187 +++++--------------------------
 1 file changed, 35 insertions(+), 152 deletions(-)

---
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
 

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
6144R/F5C6C943 2015-04-27
177C 1972 1FB8 F254 BAD0 3E72 5C63 F4E3 F5C6 C943

"The past tempts us, the present confuses us, the future frightens us.  And our
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
