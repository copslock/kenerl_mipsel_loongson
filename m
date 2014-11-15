Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 15 Nov 2014 23:10:07 +0100 (CET)
Received: from relay1.mentorg.com ([192.94.38.131]:54543 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013682AbaKOWKFYFA1L (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 15 Nov 2014 23:10:05 +0100
Received: from nat-ies.mentorg.com ([192.94.31.2] helo=SVR-IES-FEM-01.mgc.mentorg.com)
        by relay1.mentorg.com with esmtp 
        id 1XplXa-0004EE-Oc from Maciej_Rozycki@mentor.com ; Sat, 15 Nov 2014 14:09:59 -0800
Received: from localhost (137.202.0.76) by SVR-IES-FEM-01.mgc.mentorg.com
 (137.202.0.104) with Microsoft SMTP Server (TLS) id 14.3.181.6; Sat, 15 Nov
 2014 22:09:56 +0000
Date:   Sat, 15 Nov 2014 22:09:54 +0000
From:   "Maciej W. Rozycki" <macro@codesourcery.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>
Subject: [PATCH 7/7] MIPS: atomic.h: Reformat to fit in 79 columns
In-Reply-To: <alpine.DEB.1.10.1411140122420.2881@tp.orcam.me.uk>
Message-ID: <alpine.DEB.1.10.1411152148070.2881@tp.orcam.me.uk>
References: <alpine.DEB.1.10.1411140122420.2881@tp.orcam.me.uk>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-Path: <Maciej_Rozycki@mentor.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44190
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@codesourcery.com
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

Signed-off-by: Maciej W. Rozycki <macro@codesourcery.com>
---
Hi,

 No comment.  Please apply.

  Maciej

linux-mips-atomic-format.diff
Index: linux-3.18-rc4-malta/arch/mips/include/asm/atomic.h
===================================================================
--- linux-3.18-rc4-malta.orig/arch/mips/include/asm/atomic.h	2014-11-15 05:56:06.000000000 +0000
+++ linux-3.18-rc4-malta/arch/mips/include/asm/atomic.h	2014-11-15 06:06:58.551778827 +0000
@@ -41,97 +41,97 @@
  */
 #define atomic_set(v, i)		((v)->counter = (i))
 
-#define ATOMIC_OP(op, c_op, asm_op)						\
-static __inline__ void atomic_##op(int i, atomic_t * v)				\
-{										\
-	if (kernel_uses_llsc && R10000_LLSC_WAR) {				\
-		int temp;							\
-										\
-		__asm__ __volatile__(						\
-		"	.set	arch=r4000				\n"	\
-		"1:	ll	%0, %1		# atomic_" #op "	\n"	\
-		"	" #asm_op " %0, %2				\n"	\
-		"	sc	%0, %1					\n"	\
-		"	beqzl	%0, 1b					\n"	\
-		"	.set	mips0					\n"	\
-		: "=&r" (temp), "+" GCC_OFF12_ASM() (v->counter)		\
-		: "Ir" (i));							\
-	} else if (kernel_uses_llsc) {						\
-		int temp;							\
-										\
-		do {								\
-			__asm__ __volatile__(					\
-			"	.set	arch=r4000			\n"	\
-			"	ll	%0, %1		# atomic_" #op "\n"	\
-			"	" #asm_op " %0, %2			\n"	\
-			"	sc	%0, %1				\n"	\
-			"	.set	mips0				\n"	\
-			: "=&r" (temp), "+" GCC_OFF12_ASM() (v->counter)	\
-			: "Ir" (i));						\
-		} while (unlikely(!temp));					\
-	} else {								\
-		unsigned long flags;						\
-										\
-		raw_local_irq_save(flags);					\
-		v->counter c_op i;						\
-		raw_local_irq_restore(flags);					\
-	}									\
-}										\
+#define ATOMIC_OP(op, c_op, asm_op)					      \
+static __inline__ void atomic_##op(int i, atomic_t * v)			      \
+{									      \
+	if (kernel_uses_llsc && R10000_LLSC_WAR) {			      \
+		int temp;						      \
+									      \
+		__asm__ __volatile__(					      \
+		"	.set	arch=r4000				\n"   \
+		"1:	ll	%0, %1		# atomic_" #op "	\n"   \
+		"	" #asm_op " %0, %2				\n"   \
+		"	sc	%0, %1					\n"   \
+		"	beqzl	%0, 1b					\n"   \
+		"	.set	mips0					\n"   \
+		: "=&r" (temp), "+" GCC_OFF12_ASM() (v->counter)	      \
+		: "Ir" (i));						      \
+	} else if (kernel_uses_llsc) {					      \
+		int temp;						      \
+									      \
+		do {							      \
+			__asm__ __volatile__(				      \
+			"	.set	arch=r4000			\n"   \
+			"	ll	%0, %1		# atomic_" #op "\n"   \
+			"	" #asm_op " %0, %2			\n"   \
+			"	sc	%0, %1				\n"   \
+			"	.set	mips0				\n"   \
+			: "=&r" (temp), "+" GCC_OFF12_ASM() (v->counter)      \
+			: "Ir" (i));					      \
+		} while (unlikely(!temp));				      \
+	} else {							      \
+		unsigned long flags;					      \
+									      \
+		raw_local_irq_save(flags);				      \
+		v->counter c_op i;					      \
+		raw_local_irq_restore(flags);				      \
+	}								      \
+}
 
-#define ATOMIC_OP_RETURN(op, c_op, asm_op)					\
-static __inline__ int atomic_##op##_return(int i, atomic_t * v)			\
-{										\
-	int result;								\
-										\
-	smp_mb__before_llsc();							\
-										\
-	if (kernel_uses_llsc && R10000_LLSC_WAR) {				\
-		int temp;							\
-										\
-		__asm__ __volatile__(						\
-		"	.set	arch=r4000				\n"	\
-		"1:	ll	%1, %2		# atomic_" #op "_return	\n"	\
-		"	" #asm_op " %0, %1, %3				\n"	\
-		"	sc	%0, %2					\n"	\
-		"	beqzl	%0, 1b					\n"	\
-		"	" #asm_op " %0, %1, %3				\n"	\
-		"	.set	mips0					\n"	\
-		: "=&r" (result), "=&r" (temp),					\
-		  "+" GCC_OFF12_ASM() (v->counter)				\
-		: "Ir" (i));							\
-	} else if (kernel_uses_llsc) {						\
-		int temp;							\
-										\
-		do {								\
-			__asm__ __volatile__(					\
-			"	.set	arch=r4000			\n"	\
-			"	ll	%1, %2	# atomic_" #op "_return	\n"	\
-			"	" #asm_op " %0, %1, %3			\n"	\
-			"	sc	%0, %2				\n"	\
-			"	.set	mips0				\n"	\
-			: "=&r" (result), "=&r" (temp),				\
-			  "+" GCC_OFF12_ASM() (v->counter)			\
-			: "Ir" (i));						\
-		} while (unlikely(!result));					\
-										\
-		result = temp; result c_op i;					\
-	} else {								\
-		unsigned long flags;						\
-										\
-		raw_local_irq_save(flags);					\
-		result = v->counter;						\
-		result c_op i;							\
-		v->counter = result;						\
-		raw_local_irq_restore(flags);					\
-	}									\
-										\
-	smp_llsc_mb();								\
-										\
-	return result;								\
+#define ATOMIC_OP_RETURN(op, c_op, asm_op)				      \
+static __inline__ int atomic_##op##_return(int i, atomic_t * v)		      \
+{									      \
+	int result;							      \
+									      \
+	smp_mb__before_llsc();						      \
+									      \
+	if (kernel_uses_llsc && R10000_LLSC_WAR) {			      \
+		int temp;						      \
+									      \
+		__asm__ __volatile__(					      \
+		"	.set	arch=r4000				\n"   \
+		"1:	ll	%1, %2		# atomic_" #op "_return	\n"   \
+		"	" #asm_op " %0, %1, %3				\n"   \
+		"	sc	%0, %2					\n"   \
+		"	beqzl	%0, 1b					\n"   \
+		"	" #asm_op " %0, %1, %3				\n"   \
+		"	.set	mips0					\n"   \
+		: "=&r" (result), "=&r" (temp),				      \
+		  "+" GCC_OFF12_ASM() (v->counter)			      \
+		: "Ir" (i));						      \
+	} else if (kernel_uses_llsc) {					      \
+		int temp;						      \
+									      \
+		do {							      \
+			__asm__ __volatile__(				      \
+			"	.set	arch=r4000			\n"   \
+			"	ll	%1, %2	# atomic_" #op "_return	\n"   \
+			"	" #asm_op " %0, %1, %3			\n"   \
+			"	sc	%0, %2				\n"   \
+			"	.set	mips0				\n"   \
+			: "=&r" (result), "=&r" (temp),			      \
+			  "+" GCC_OFF12_ASM() (v->counter)		      \
+			: "Ir" (i));					      \
+		} while (unlikely(!result));				      \
+									      \
+		result = temp; result c_op i;				      \
+	} else {							      \
+		unsigned long flags;					      \
+									      \
+		raw_local_irq_save(flags);				      \
+		result = v->counter;					      \
+		result c_op i;						      \
+		v->counter = result;					      \
+		raw_local_irq_restore(flags);				      \
+	}								      \
+									      \
+	smp_llsc_mb();							      \
+									      \
+	return result;							      \
 }
 
-#define ATOMIC_OPS(op, c_op, asm_op)						\
-	ATOMIC_OP(op, c_op, asm_op)						\
+#define ATOMIC_OPS(op, c_op, asm_op)					      \
+	ATOMIC_OP(op, c_op, asm_op)					      \
 	ATOMIC_OP_RETURN(op, c_op, asm_op)
 
 ATOMIC_OPS(add, +=, addu)
@@ -320,98 +320,98 @@ static __inline__ int __atomic_add_unles
  */
 #define atomic64_set(v, i)	((v)->counter = (i))
 
-#define ATOMIC64_OP(op, c_op, asm_op)						\
-static __inline__ void atomic64_##op(long i, atomic64_t * v)			\
-{										\
-	if (kernel_uses_llsc && R10000_LLSC_WAR) {				\
-		long temp;							\
-										\
-		__asm__ __volatile__(						\
-		"	.set	arch=r4000				\n"	\
-		"1:	lld	%0, %1		# atomic64_" #op "	\n"	\
-		"	" #asm_op " %0, %2				\n"	\
-		"	scd	%0, %1					\n"	\
-		"	beqzl	%0, 1b					\n"	\
-		"	.set	mips0					\n"	\
-		: "=&r" (temp), "+" GCC_OFF12_ASM() (v->counter)		\
-		: "Ir" (i));							\
-	} else if (kernel_uses_llsc) {						\
-		long temp;							\
-										\
-		do {								\
-			__asm__ __volatile__(					\
-			"	.set	arch=r4000			\n"	\
-			"	lld	%0, %1		# atomic64_" #op "\n"	\
-			"	" #asm_op " %0, %2			\n"	\
-			"	scd	%0, %1				\n"	\
-			"	.set	mips0				\n"	\
-			: "=&r" (temp), "+" GCC_OFF12_ASM() (v->counter)	\
-			: "Ir" (i));						\
-		} while (unlikely(!temp));					\
-	} else {								\
-		unsigned long flags;						\
-										\
-		raw_local_irq_save(flags);					\
-		v->counter c_op i;						\
-		raw_local_irq_restore(flags);					\
-	}									\
-}										\
+#define ATOMIC64_OP(op, c_op, asm_op)					      \
+static __inline__ void atomic64_##op(long i, atomic64_t * v)		      \
+{									      \
+	if (kernel_uses_llsc && R10000_LLSC_WAR) {			      \
+		long temp;						      \
+									      \
+		__asm__ __volatile__(					      \
+		"	.set	arch=r4000				\n"   \
+		"1:	lld	%0, %1		# atomic64_" #op "	\n"   \
+		"	" #asm_op " %0, %2				\n"   \
+		"	scd	%0, %1					\n"   \
+		"	beqzl	%0, 1b					\n"   \
+		"	.set	mips0					\n"   \
+		: "=&r" (temp), "+" GCC_OFF12_ASM() (v->counter)	      \
+		: "Ir" (i));						      \
+	} else if (kernel_uses_llsc) {					      \
+		long temp;						      \
+									      \
+		do {							      \
+			__asm__ __volatile__(				      \
+			"	.set	arch=r4000			\n"   \
+			"	lld	%0, %1		# atomic64_" #op "\n" \
+			"	" #asm_op " %0, %2			\n"   \
+			"	scd	%0, %1				\n"   \
+			"	.set	mips0				\n"   \
+			: "=&r" (temp), "+" GCC_OFF12_ASM() (v->counter)      \
+			: "Ir" (i));					      \
+		} while (unlikely(!temp));				      \
+	} else {							      \
+		unsigned long flags;					      \
+									      \
+		raw_local_irq_save(flags);				      \
+		v->counter c_op i;					      \
+		raw_local_irq_restore(flags);				      \
+	}								      \
+}
 
-#define ATOMIC64_OP_RETURN(op, c_op, asm_op)					\
-static __inline__ long atomic64_##op##_return(long i, atomic64_t * v)		\
-{										\
-	long result;								\
-										\
-	smp_mb__before_llsc();							\
-										\
-	if (kernel_uses_llsc && R10000_LLSC_WAR) {				\
-		long temp;							\
-										\
-		__asm__ __volatile__(						\
-		"	.set	arch=r4000				\n"	\
-		"1:	lld	%1, %2		# atomic64_" #op "_return\n"	\
-		"	" #asm_op " %0, %1, %3				\n"	\
-		"	scd	%0, %2					\n"	\
-		"	beqzl	%0, 1b					\n"	\
-		"	" #asm_op " %0, %1, %3				\n"	\
-		"	.set	mips0					\n"	\
-		: "=&r" (result), "=&r" (temp),					\
-		  "+" GCC_OFF12_ASM() (v->counter)				\
-		: "Ir" (i));							\
-	} else if (kernel_uses_llsc) {						\
-		long temp;							\
-										\
-		do {								\
-			__asm__ __volatile__(					\
-			"	.set	arch=r4000			\n"	\
-			"	lld	%1, %2	# atomic64_" #op "_return\n"	\
-			"	" #asm_op " %0, %1, %3			\n"	\
-			"	scd	%0, %2				\n"	\
-			"	.set	mips0				\n"	\
-			: "=&r" (result), "=&r" (temp),				\
-			  "=" GCC_OFF12_ASM() (v->counter)			\
-			: "Ir" (i), GCC_OFF12_ASM() (v->counter)		\
-			: "memory");						\
-		} while (unlikely(!result));					\
-										\
-		result = temp; result c_op i;					\
-	} else {								\
-		unsigned long flags;						\
-										\
-		raw_local_irq_save(flags);					\
-		result = v->counter;						\
-		result c_op i;							\
-		v->counter = result;						\
-		raw_local_irq_restore(flags);					\
-	}									\
-										\
-	smp_llsc_mb();								\
-										\
-	return result;								\
+#define ATOMIC64_OP_RETURN(op, c_op, asm_op)				      \
+static __inline__ long atomic64_##op##_return(long i, atomic64_t * v)	      \
+{									      \
+	long result;							      \
+									      \
+	smp_mb__before_llsc();						      \
+									      \
+	if (kernel_uses_llsc && R10000_LLSC_WAR) {			      \
+		long temp;						      \
+									      \
+		__asm__ __volatile__(					      \
+		"	.set	arch=r4000				\n"   \
+		"1:	lld	%1, %2		# atomic64_" #op "_return\n"  \
+		"	" #asm_op " %0, %1, %3				\n"   \
+		"	scd	%0, %2					\n"   \
+		"	beqzl	%0, 1b					\n"   \
+		"	" #asm_op " %0, %1, %3				\n"   \
+		"	.set	mips0					\n"   \
+		: "=&r" (result), "=&r" (temp),				      \
+		  "+" GCC_OFF12_ASM() (v->counter)			      \
+		: "Ir" (i));						      \
+	} else if (kernel_uses_llsc) {					      \
+		long temp;						      \
+									      \
+		do {							      \
+			__asm__ __volatile__(				      \
+			"	.set	arch=r4000			\n"   \
+			"	lld	%1, %2	# atomic64_" #op "_return\n"  \
+			"	" #asm_op " %0, %1, %3			\n"   \
+			"	scd	%0, %2				\n"   \
+			"	.set	mips0				\n"   \
+			: "=&r" (result), "=&r" (temp),			      \
+			  "=" GCC_OFF12_ASM() (v->counter)		      \
+			: "Ir" (i), GCC_OFF12_ASM() (v->counter)	      \
+			: "memory");					      \
+		} while (unlikely(!result));				      \
+									      \
+		result = temp; result c_op i;				      \
+	} else {							      \
+		unsigned long flags;					      \
+									      \
+		raw_local_irq_save(flags);				      \
+		result = v->counter;					      \
+		result c_op i;						      \
+		v->counter = result;					      \
+		raw_local_irq_restore(flags);				      \
+	}								      \
+									      \
+	smp_llsc_mb();							      \
+									      \
+	return result;							      \
 }
 
-#define ATOMIC64_OPS(op, c_op, asm_op)						\
-	ATOMIC64_OP(op, c_op, asm_op)						\
+#define ATOMIC64_OPS(op, c_op, asm_op)					      \
+	ATOMIC64_OP(op, c_op, asm_op)					      \
 	ATOMIC64_OP_RETURN(op, c_op, asm_op)
 
 ATOMIC64_OPS(add, +=, daddu)
@@ -422,7 +422,8 @@ ATOMIC64_OPS(sub, -=, dsubu)
 #undef ATOMIC64_OP
 
 /*
- * atomic64_sub_if_positive - conditionally subtract integer from atomic variable
+ * atomic64_sub_if_positive - conditionally subtract integer from atomic
+ *                            variable
  * @i: integer value to subtract
  * @v: pointer of type atomic64_t
  *
