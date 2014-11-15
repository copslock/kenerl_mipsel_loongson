Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 15 Nov 2014 23:09:06 +0100 (CET)
Received: from relay1.mentorg.com ([192.94.38.131]:54511 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013682AbaKOWJD1Apm7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 15 Nov 2014 23:09:03 +0100
Received: from nat-ies.mentorg.com ([192.94.31.2] helo=SVR-IES-FEM-01.mgc.mentorg.com)
        by relay1.mentorg.com with esmtp 
        id 1XplWY-00040C-17 from Maciej_Rozycki@mentor.com ; Sat, 15 Nov 2014 14:08:54 -0800
Received: from localhost (137.202.0.76) by SVR-IES-FEM-01.mgc.mentorg.com
 (137.202.0.104) with Microsoft SMTP Server (TLS) id 14.3.181.6; Sat, 15 Nov
 2014 22:08:51 +0000
Date:   Sat, 15 Nov 2014 22:08:48 +0000
From:   "Maciej W. Rozycki" <macro@codesourcery.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>
Subject: [PATCH 5/7] MIPS: Fix microMIPS LL/SC immediate offsets
In-Reply-To: <alpine.DEB.1.10.1411140122420.2881@tp.orcam.me.uk>
Message-ID: <alpine.DEB.1.10.1411152113210.2881@tp.orcam.me.uk>
References: <alpine.DEB.1.10.1411140122420.2881@tp.orcam.me.uk>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-Path: <Maciej_Rozycki@mentor.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44188
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

In the microMIPS encoding some memory access instructions have their 
immediate offset reduced to 12 bits only.  That does not match the GCC 
`R' constraint we use in some places to satisfy the requirement, 
resulting in build failures like this:

{standard input}: Assembler messages:
{standard input}:720: Error: macro used $at after ".set noat"
{standard input}:720: Warning: macro instruction expanded into multiple instructions

Fix the problem by defining a macro, `GCC_OFF12_ASM', that expands to 
the right constraint depending on whether microMIPS or standard MIPS 
code is produced.  Also apply the fix to where `m' is used as in the 
worst case this change does nothing, e.g. where the pointer was already 
in a register such as a function argument and no further offset was 
requested, and in the best case it avoids an extraneous sequence of up 
to two instructions to load the high 20 bits of the address in the LL/SC 
loop.  This reduces the risk of lock contention that is the higher the 
more instructions there are in the critical section between LL and SC.

Strictly speaking we could just bulk-replace `R' with `ZC' as the latter 
constraint adjusts automatically depending on the ISA selected.  
However it was only introduced with GCC 4.9 and we keep supporing older 
compilers for the standard MIPS configuration, hence the slightly more 
complicated approach I chose.

The choice of a zero-argument function-like rather than an object-like 
macro was made so that it does not look like a function call taking the 
C expression used for the constraint as an argument.  This is so as not 
to confuse the reader or formatting checkers like `checkpatch.pl' and 
follows previous practice.

Signed-off-by: Maciej W. Rozycki <macro@codesourcery.com>
---
Hi,

 This has been discussed before and I already recommended implementing 
it, but nobody bothered -- I guess that means nobody actually maintains 
the microMIPS port.  Anyway I needed to build a working kernel (well it 
still does not boot as at 3.17, I'll have to debug it, it stops with a 
fault at giving away the initial console, at which point no exception 
handler has been installed yet, probably a BUG() somewhere) so I went 
ahead and implemented the missing bits.

 In the process of updating these constraints I noticed there were many 
inconsistencies and bugs, but I decided enough is enough.  Therefore 
this change merely replaces the existing constraints in place without 
any semantic rearrangements.

 Also sometime recently someone has reformatted the file breaking our 
coding convention rule not to extend lines beyond 79 columns and making 
it completely unreadable in the sections affected.  I don't know why 
such a change was accepted, it shouldn't have been.

 Anyway, I decided the bug fix has a priority so this change retains the 
broken formatting and I'll be bringing sanity back here with a follow-up 
change.

 Please apply,

  Maciej

linux-umips-off12-constraint.diff
Index: linux-3.18-rc4-malta/arch/mips/include/asm/atomic.h
===================================================================
--- linux-3.18-rc4-malta.orig/arch/mips/include/asm/atomic.h	2014-11-14 03:29:49.000000000 +0000
+++ linux-3.18-rc4-malta/arch/mips/include/asm/atomic.h	2014-11-15 05:55:38.441902949 +0000
@@ -17,6 +17,7 @@
 #include <linux/irqflags.h>
 #include <linux/types.h>
 #include <asm/barrier.h>
+#include <asm/compiler.h>
 #include <asm/cpu-features.h>
 #include <asm/cmpxchg.h>
 #include <asm/war.h>
@@ -53,7 +54,7 @@ static __inline__ void atomic_##op(int i
 		"	sc	%0, %1					\n"	\
 		"	beqzl	%0, 1b					\n"	\
 		"	.set	mips0					\n"	\
-		: "=&r" (temp), "+m" (v->counter)				\
+		: "=&r" (temp), "+" GCC_OFF12_ASM() (v->counter)		\
 		: "Ir" (i));							\
 	} else if (kernel_uses_llsc) {						\
 		int temp;							\
@@ -65,7 +66,7 @@ static __inline__ void atomic_##op(int i
 			"	" #asm_op " %0, %2			\n"	\
 			"	sc	%0, %1				\n"	\
 			"	.set	mips0				\n"	\
-			: "=&r" (temp), "+m" (v->counter)			\
+			: "=&r" (temp), "+" GCC_OFF12_ASM() (v->counter)	\
 			: "Ir" (i));						\
 		} while (unlikely(!temp));					\
 	} else {								\
@@ -95,7 +96,8 @@ static __inline__ int atomic_##op##_retu
 		"	beqzl	%0, 1b					\n"	\
 		"	" #asm_op " %0, %1, %3				\n"	\
 		"	.set	mips0					\n"	\
-		: "=&r" (result), "=&r" (temp), "+m" (v->counter)		\
+		: "=&r" (result), "=&r" (temp),					\
+		  "+" GCC_OFF12_ASM() (v->counter)				\
 		: "Ir" (i));							\
 	} else if (kernel_uses_llsc) {						\
 		int temp;							\
@@ -107,7 +109,8 @@ static __inline__ int atomic_##op##_retu
 			"	" #asm_op " %0, %1, %3			\n"	\
 			"	sc	%0, %2				\n"	\
 			"	.set	mips0				\n"	\
-			: "=&r" (result), "=&r" (temp), "+m" (v->counter)	\
+			: "=&r" (result), "=&r" (temp),				\
+			  "+" GCC_OFF12_ASM() (v->counter)			\
 			: "Ir" (i));						\
 		} while (unlikely(!result));					\
 										\
@@ -167,8 +170,9 @@ static __inline__ int atomic_sub_if_posi
 		"	.set	reorder					\n"
 		"1:							\n"
 		"	.set	mips0					\n"
-		: "=&r" (result), "=&r" (temp), "+m" (v->counter)
-		: "Ir" (i), "m" (v->counter)
+		: "=&r" (result), "=&r" (temp),
+		  "+" GCC_OFF12_ASM() (v->counter)
+		: "Ir" (i), GCC_OFF12_ASM() (v->counter)
 		: "memory");
 	} else if (kernel_uses_llsc) {
 		int temp;
@@ -185,7 +189,8 @@ static __inline__ int atomic_sub_if_posi
 		"	.set	reorder					\n"
 		"1:							\n"
 		"	.set	mips0					\n"
-		: "=&r" (result), "=&r" (temp), "+m" (v->counter)
+		: "=&r" (result), "=&r" (temp),
+		  "+" GCC_OFF12_ASM() (v->counter)
 		: "Ir" (i));
 	} else {
 		unsigned long flags;
@@ -328,7 +333,7 @@ static __inline__ void atomic64_##op(lon
 		"	scd	%0, %1					\n"	\
 		"	beqzl	%0, 1b					\n"	\
 		"	.set	mips0					\n"	\
-		: "=&r" (temp), "+m" (v->counter)				\
+		: "=&r" (temp), "+" GCC_OFF12_ASM() (v->counter)		\
 		: "Ir" (i));							\
 	} else if (kernel_uses_llsc) {						\
 		long temp;							\
@@ -340,7 +345,7 @@ static __inline__ void atomic64_##op(lon
 			"	" #asm_op " %0, %2			\n"	\
 			"	scd	%0, %1				\n"	\
 			"	.set	mips0				\n"	\
-			: "=&r" (temp), "+m" (v->counter)			\
+			: "=&r" (temp), "+" GCC_OFF12_ASM() (v->counter)	\
 			: "Ir" (i));						\
 		} while (unlikely(!temp));					\
 	} else {								\
@@ -370,7 +375,8 @@ static __inline__ long atomic64_##op##_r
 		"	beqzl	%0, 1b					\n"	\
 		"	" #asm_op " %0, %1, %3				\n"	\
 		"	.set	mips0					\n"	\
-		: "=&r" (result), "=&r" (temp), "+m" (v->counter)		\
+		: "=&r" (result), "=&r" (temp),					\
+		  "+" GCC_OFF12_ASM() (v->counter)				\
 		: "Ir" (i));							\
 	} else if (kernel_uses_llsc) {						\
 		long temp;							\
@@ -382,8 +388,9 @@ static __inline__ long atomic64_##op##_r
 			"	" #asm_op " %0, %1, %3			\n"	\
 			"	scd	%0, %2				\n"	\
 			"	.set	mips0				\n"	\
-			: "=&r" (result), "=&r" (temp), "=m" (v->counter)	\
-			: "Ir" (i), "m" (v->counter)				\
+			: "=&r" (result), "=&r" (temp),				\
+			  "=" GCC_OFF12_ASM() (v->counter)			\
+			: "Ir" (i), GCC_OFF12_ASM() (v->counter)		\
 			: "memory");						\
 		} while (unlikely(!result));					\
 										\
@@ -443,8 +450,9 @@ static __inline__ long atomic64_sub_if_p
 		"	.set	reorder					\n"
 		"1:							\n"
 		"	.set	mips0					\n"
-		: "=&r" (result), "=&r" (temp), "=m" (v->counter)
-		: "Ir" (i), "m" (v->counter)
+		: "=&r" (result), "=&r" (temp),
+		  "=" GCC_OFF12_ASM() (v->counter)
+		: "Ir" (i), GCC_OFF12_ASM() (v->counter)
 		: "memory");
 	} else if (kernel_uses_llsc) {
 		long temp;
@@ -461,7 +469,8 @@ static __inline__ long atomic64_sub_if_p
 		"	.set	reorder					\n"
 		"1:							\n"
 		"	.set	mips0					\n"
-		: "=&r" (result), "=&r" (temp), "+m" (v->counter)
+		: "=&r" (result), "=&r" (temp),
+		  "+" GCC_OFF12_ASM() (v->counter)
 		: "Ir" (i));
 	} else {
 		unsigned long flags;
Index: linux-3.18-rc4-malta/arch/mips/include/asm/bitops.h
===================================================================
--- linux-3.18-rc4-malta.orig/arch/mips/include/asm/bitops.h	2014-11-14 03:29:49.000000000 +0000
+++ linux-3.18-rc4-malta/arch/mips/include/asm/bitops.h	2014-11-15 05:48:25.871909457 +0000
@@ -17,6 +17,7 @@
 #include <linux/types.h>
 #include <asm/barrier.h>
 #include <asm/byteorder.h>		/* sigh ... */
+#include <asm/compiler.h>
 #include <asm/cpu-features.h>
 #include <asm/sgidefs.h>
 #include <asm/war.h>
@@ -78,8 +79,8 @@ static inline void set_bit(unsigned long
 		"	" __SC	"%0, %1					\n"
 		"	beqzl	%0, 1b					\n"
 		"	.set	mips0					\n"
-		: "=&r" (temp), "=m" (*m)
-		: "ir" (1UL << bit), "m" (*m));
+		: "=&r" (temp), "=" GCC_OFF12_ASM() (*m)
+		: "ir" (1UL << bit), GCC_OFF12_ASM() (*m));
 #ifdef CONFIG_CPU_MIPSR2
 	} else if (kernel_uses_llsc && __builtin_constant_p(bit)) {
 		do {
@@ -87,7 +88,7 @@ static inline void set_bit(unsigned long
 			"	" __LL "%0, %1		# set_bit	\n"
 			"	" __INS "%0, %3, %2, 1			\n"
 			"	" __SC "%0, %1				\n"
-			: "=&r" (temp), "+m" (*m)
+			: "=&r" (temp), "+" GCC_OFF12_ASM() (*m)
 			: "ir" (bit), "r" (~0));
 		} while (unlikely(!temp));
 #endif /* CONFIG_CPU_MIPSR2 */
@@ -99,7 +100,7 @@ static inline void set_bit(unsigned long
 			"	or	%0, %2				\n"
 			"	" __SC	"%0, %1				\n"
 			"	.set	mips0				\n"
-			: "=&r" (temp), "+m" (*m)
+			: "=&r" (temp), "+" GCC_OFF12_ASM() (*m)
 			: "ir" (1UL << bit));
 		} while (unlikely(!temp));
 	} else
@@ -130,7 +131,7 @@ static inline void clear_bit(unsigned lo
 		"	" __SC "%0, %1					\n"
 		"	beqzl	%0, 1b					\n"
 		"	.set	mips0					\n"
-		: "=&r" (temp), "+m" (*m)
+		: "=&r" (temp), "+" GCC_OFF12_ASM() (*m)
 		: "ir" (~(1UL << bit)));
 #ifdef CONFIG_CPU_MIPSR2
 	} else if (kernel_uses_llsc && __builtin_constant_p(bit)) {
@@ -139,7 +140,7 @@ static inline void clear_bit(unsigned lo
 			"	" __LL "%0, %1		# clear_bit	\n"
 			"	" __INS "%0, $0, %2, 1			\n"
 			"	" __SC "%0, %1				\n"
-			: "=&r" (temp), "+m" (*m)
+			: "=&r" (temp), "+" GCC_OFF12_ASM() (*m)
 			: "ir" (bit));
 		} while (unlikely(!temp));
 #endif /* CONFIG_CPU_MIPSR2 */
@@ -151,7 +152,7 @@ static inline void clear_bit(unsigned lo
 			"	and	%0, %2				\n"
 			"	" __SC "%0, %1				\n"
 			"	.set	mips0				\n"
-			: "=&r" (temp), "+m" (*m)
+			: "=&r" (temp), "+" GCC_OFF12_ASM() (*m)
 			: "ir" (~(1UL << bit)));
 		} while (unlikely(!temp));
 	} else
@@ -196,7 +197,7 @@ static inline void change_bit(unsigned l
 		"	" __SC	"%0, %1				\n"
 		"	beqzl	%0, 1b				\n"
 		"	.set	mips0				\n"
-		: "=&r" (temp), "+m" (*m)
+		: "=&r" (temp), "+" GCC_OFF12_ASM() (*m)
 		: "ir" (1UL << bit));
 	} else if (kernel_uses_llsc) {
 		unsigned long *m = ((unsigned long *) addr) + (nr >> SZLONG_LOG);
@@ -209,7 +210,7 @@ static inline void change_bit(unsigned l
 			"	xor	%0, %2				\n"
 			"	" __SC	"%0, %1				\n"
 			"	.set	mips0				\n"
-			: "=&r" (temp), "+m" (*m)
+			: "=&r" (temp), "+" GCC_OFF12_ASM() (*m)
 			: "ir" (1UL << bit));
 		} while (unlikely(!temp));
 	} else
@@ -244,7 +245,7 @@ static inline int test_and_set_bit(unsig
 		"	beqzl	%2, 1b					\n"
 		"	and	%2, %0, %3				\n"
 		"	.set	mips0					\n"
-		: "=&r" (temp), "+m" (*m), "=&r" (res)
+		: "=&r" (temp), "+" GCC_OFF12_ASM() (*m), "=&r" (res)
 		: "r" (1UL << bit)
 		: "memory");
 	} else if (kernel_uses_llsc) {
@@ -258,7 +259,7 @@ static inline int test_and_set_bit(unsig
 			"	or	%2, %0, %3			\n"
 			"	" __SC	"%2, %1				\n"
 			"	.set	mips0				\n"
-			: "=&r" (temp), "+m" (*m), "=&r" (res)
+			: "=&r" (temp), "+" GCC_OFF12_ASM() (*m), "=&r" (res)
 			: "r" (1UL << bit)
 			: "memory");
 		} while (unlikely(!res));
@@ -312,7 +313,7 @@ static inline int test_and_set_bit_lock(
 			"	or	%2, %0, %3			\n"
 			"	" __SC	"%2, %1				\n"
 			"	.set	mips0				\n"
-			: "=&r" (temp), "+m" (*m), "=&r" (res)
+			: "=&r" (temp), "+" GCC_OFF12_ASM() (*m), "=&r" (res)
 			: "r" (1UL << bit)
 			: "memory");
 		} while (unlikely(!res));
@@ -354,7 +355,7 @@ static inline int test_and_clear_bit(uns
 		"	beqzl	%2, 1b					\n"
 		"	and	%2, %0, %3				\n"
 		"	.set	mips0					\n"
-		: "=&r" (temp), "+m" (*m), "=&r" (res)
+		: "=&r" (temp), "+" GCC_OFF12_ASM() (*m), "=&r" (res)
 		: "r" (1UL << bit)
 		: "memory");
 #ifdef CONFIG_CPU_MIPSR2
@@ -368,7 +369,7 @@ static inline int test_and_clear_bit(uns
 			"	" __EXT "%2, %0, %3, 1			\n"
 			"	" __INS "%0, $0, %3, 1			\n"
 			"	" __SC	"%0, %1				\n"
-			: "=&r" (temp), "+m" (*m), "=&r" (res)
+			: "=&r" (temp), "+" GCC_OFF12_ASM() (*m), "=&r" (res)
 			: "ir" (bit)
 			: "memory");
 		} while (unlikely(!temp));
@@ -385,7 +386,7 @@ static inline int test_and_clear_bit(uns
 			"	xor	%2, %3				\n"
 			"	" __SC	"%2, %1				\n"
 			"	.set	mips0				\n"
-			: "=&r" (temp), "+m" (*m), "=&r" (res)
+			: "=&r" (temp), "+" GCC_OFF12_ASM() (*m), "=&r" (res)
 			: "r" (1UL << bit)
 			: "memory");
 		} while (unlikely(!res));
@@ -427,7 +428,7 @@ static inline int test_and_change_bit(un
 		"	beqzl	%2, 1b					\n"
 		"	and	%2, %0, %3				\n"
 		"	.set	mips0					\n"
-		: "=&r" (temp), "+m" (*m), "=&r" (res)
+		: "=&r" (temp), "+" GCC_OFF12_ASM() (*m), "=&r" (res)
 		: "r" (1UL << bit)
 		: "memory");
 	} else if (kernel_uses_llsc) {
@@ -441,7 +442,7 @@ static inline int test_and_change_bit(un
 			"	xor	%2, %0, %3			\n"
 			"	" __SC	"\t%2, %1			\n"
 			"	.set	mips0				\n"
-			: "=&r" (temp), "+m" (*m), "=&r" (res)
+			: "=&r" (temp), "+" GCC_OFF12_ASM() (*m), "=&r" (res)
 			: "r" (1UL << bit)
 			: "memory");
 		} while (unlikely(!res));
Index: linux-3.18-rc4-malta/arch/mips/include/asm/cmpxchg.h
===================================================================
--- linux-3.18-rc4-malta.orig/arch/mips/include/asm/cmpxchg.h	2014-11-14 03:29:49.000000000 +0000
+++ linux-3.18-rc4-malta/arch/mips/include/asm/cmpxchg.h	2014-11-15 05:48:25.871909457 +0000
@@ -10,6 +10,7 @@
 
 #include <linux/bug.h>
 #include <linux/irqflags.h>
+#include <asm/compiler.h>
 #include <asm/war.h>
 
 static inline unsigned long __xchg_u32(volatile int * m, unsigned int val)
@@ -30,8 +31,8 @@ static inline unsigned long __xchg_u32(v
 		"	sc	%2, %1					\n"
 		"	beqzl	%2, 1b					\n"
 		"	.set	mips0					\n"
-		: "=&r" (retval), "=m" (*m), "=&r" (dummy)
-		: "R" (*m), "Jr" (val)
+		: "=&r" (retval), "=" GCC_OFF12_ASM() (*m), "=&r" (dummy)
+		: GCC_OFF12_ASM() (*m), "Jr" (val)
 		: "memory");
 	} else if (kernel_uses_llsc) {
 		unsigned long dummy;
@@ -45,8 +46,9 @@ static inline unsigned long __xchg_u32(v
 			"	.set	arch=r4000			\n"
 			"	sc	%2, %1				\n"
 			"	.set	mips0				\n"
-			: "=&r" (retval), "=m" (*m), "=&r" (dummy)
-			: "R" (*m), "Jr" (val)
+			: "=&r" (retval), "=" GCC_OFF12_ASM() (*m),
+			  "=&r" (dummy)
+			: GCC_OFF12_ASM() (*m), "Jr" (val)
 			: "memory");
 		} while (unlikely(!dummy));
 	} else {
@@ -80,8 +82,8 @@ static inline __u64 __xchg_u64(volatile 
 		"	scd	%2, %1					\n"
 		"	beqzl	%2, 1b					\n"
 		"	.set	mips0					\n"
-		: "=&r" (retval), "=m" (*m), "=&r" (dummy)
-		: "R" (*m), "Jr" (val)
+		: "=&r" (retval), "=" GCC_OFF12_ASM() (*m), "=&r" (dummy)
+		: GCC_OFF12_ASM() (*m), "Jr" (val)
 		: "memory");
 	} else if (kernel_uses_llsc) {
 		unsigned long dummy;
@@ -93,8 +95,9 @@ static inline __u64 __xchg_u64(volatile 
 			"	move	%2, %z4				\n"
 			"	scd	%2, %1				\n"
 			"	.set	mips0				\n"
-			: "=&r" (retval), "=m" (*m), "=&r" (dummy)
-			: "R" (*m), "Jr" (val)
+			: "=&r" (retval), "=" GCC_OFF12_ASM() (*m),
+			  "=&r" (dummy)
+			: GCC_OFF12_ASM() (*m), "Jr" (val)
 			: "memory");
 		} while (unlikely(!dummy));
 	} else {
@@ -155,8 +158,8 @@ static inline unsigned long __xchg(unsig
 		"	beqzl	$1, 1b				\n"	\
 		"2:						\n"	\
 		"	.set	pop				\n"	\
-		: "=&r" (__ret), "=R" (*m)				\
-		: "R" (*m), "Jr" (old), "Jr" (new)			\
+		: "=&r" (__ret), "=" GCC_OFF12_ASM() (*m)		\
+		: GCC_OFF12_ASM() (*m), "Jr" (old), "Jr" (new)		\
 		: "memory");						\
 	} else if (kernel_uses_llsc) {					\
 		__asm__ __volatile__(					\
@@ -172,8 +175,8 @@ static inline unsigned long __xchg(unsig
 		"	beqz	$1, 1b				\n"	\
 		"	.set	pop				\n"	\
 		"2:						\n"	\
-		: "=&r" (__ret), "=R" (*m)				\
-		: "R" (*m), "Jr" (old), "Jr" (new)			\
+		: "=&r" (__ret), "=" GCC_OFF12_ASM() (*m)		\
+		: GCC_OFF12_ASM() (*m), "Jr" (old), "Jr" (new)		\
 		: "memory");						\
 	} else {							\
 		unsigned long __flags;					\
Index: linux-3.18-rc4-malta/arch/mips/include/asm/compiler.h
===================================================================
--- linux-3.18-rc4-malta.orig/arch/mips/include/asm/compiler.h	2012-09-12 21:33:05.000000000 +0100
+++ linux-3.18-rc4-malta/arch/mips/include/asm/compiler.h	2014-11-15 05:48:25.871909457 +0000
@@ -16,4 +16,12 @@
 #define GCC_REG_ACCUM "accum"
 #endif
 
+#ifndef CONFIG_CPU_MICROMIPS
+#define GCC_OFF12_ASM() "R"
+#elif __GNUC__ > 4 || (__GNUC__ == 4 && __GNUC_MINOR__ >= 9)
+#define GCC_OFF12_ASM() "ZC"
+#else
+#error "microMIPS compilation unsupported with GCC older than 4.9"
+#endif
+
 #endif /* _ASM_COMPILER_H */
Index: linux-3.18-rc4-malta/arch/mips/include/asm/edac.h
===================================================================
--- linux-3.18-rc4-malta.orig/arch/mips/include/asm/edac.h	2012-09-12 21:33:05.000000000 +0100
+++ linux-3.18-rc4-malta/arch/mips/include/asm/edac.h	2014-11-15 05:48:25.871909457 +0000
@@ -1,6 +1,8 @@
 #ifndef ASM_EDAC_H
 #define ASM_EDAC_H
 
+#include <asm/compiler.h>
+
 /* ECC atomic, DMA, SMP and interrupt safe scrub function */
 
 static inline void atomic_scrub(void *va, u32 size)
@@ -24,8 +26,8 @@ static inline void atomic_scrub(void *va
 		"	sc	%0, %1					\n"
 		"	beqz	%0, 1b					\n"
 		"	.set	mips0					\n"
-		: "=&r" (temp), "=m" (*virt_addr)
-		: "m" (*virt_addr));
+		: "=&r" (temp), "=" GCC_OFF12_ASM() (*virt_addr)
+		: GCC_OFF12_ASM() (*virt_addr));
 
 		virt_addr++;
 	}
Index: linux-3.18-rc4-malta/arch/mips/include/asm/futex.h
===================================================================
--- linux-3.18-rc4-malta.orig/arch/mips/include/asm/futex.h	2014-11-14 03:29:49.000000000 +0000
+++ linux-3.18-rc4-malta/arch/mips/include/asm/futex.h	2014-11-15 05:48:25.871909457 +0000
@@ -14,6 +14,7 @@
 #include <linux/uaccess.h>
 #include <asm/asm-eva.h>
 #include <asm/barrier.h>
+#include <asm/compiler.h>
 #include <asm/errno.h>
 #include <asm/war.h>
 
@@ -42,8 +43,10 @@
 		"	"__UA_ADDR "\t1b, 4b			\n"	\
 		"	"__UA_ADDR "\t2b, 4b			\n"	\
 		"	.previous				\n"	\
-		: "=r" (ret), "=&r" (oldval), "=R" (*uaddr)		\
-		: "0" (0), "R" (*uaddr), "Jr" (oparg), "i" (-EFAULT)	\
+		: "=r" (ret), "=&r" (oldval),				\
+		  "=" GCC_OFF12_ASM() (*uaddr)				\
+		: "0" (0), GCC_OFF12_ASM() (*uaddr), "Jr" (oparg),	\
+		  "i" (-EFAULT)						\
 		: "memory");						\
 	} else if (cpu_has_llsc) {					\
 		__asm__ __volatile__(					\
@@ -68,8 +71,10 @@
 		"	"__UA_ADDR "\t1b, 4b			\n"	\
 		"	"__UA_ADDR "\t2b, 4b			\n"	\
 		"	.previous				\n"	\
-		: "=r" (ret), "=&r" (oldval), "=R" (*uaddr)		\
-		: "0" (0), "R" (*uaddr), "Jr" (oparg), "i" (-EFAULT)	\
+		: "=r" (ret), "=&r" (oldval),				\
+		  "=" GCC_OFF12_ASM() (*uaddr)				\
+		: "0" (0), GCC_OFF12_ASM() (*uaddr), "Jr" (oparg),	\
+		  "i" (-EFAULT)						\
 		: "memory");						\
 	} else								\
 		ret = -ENOSYS;						\
@@ -166,8 +171,9 @@ futex_atomic_cmpxchg_inatomic(u32 *uval,
 		"	"__UA_ADDR "\t1b, 4b				\n"
 		"	"__UA_ADDR "\t2b, 4b				\n"
 		"	.previous					\n"
-		: "+r" (ret), "=&r" (val), "=R" (*uaddr)
-		: "R" (*uaddr), "Jr" (oldval), "Jr" (newval), "i" (-EFAULT)
+		: "+r" (ret), "=&r" (val), "=" GCC_OFF12_ASM() (*uaddr)
+		: GCC_OFF12_ASM() (*uaddr), "Jr" (oldval), "Jr" (newval),
+		  "i" (-EFAULT)
 		: "memory");
 	} else if (cpu_has_llsc) {
 		__asm__ __volatile__(
@@ -193,8 +199,9 @@ futex_atomic_cmpxchg_inatomic(u32 *uval,
 		"	"__UA_ADDR "\t1b, 4b				\n"
 		"	"__UA_ADDR "\t2b, 4b				\n"
 		"	.previous					\n"
-		: "+r" (ret), "=&r" (val), "=R" (*uaddr)
-		: "R" (*uaddr), "Jr" (oldval), "Jr" (newval), "i" (-EFAULT)
+		: "+r" (ret), "=&r" (val), "=" GCC_OFF12_ASM() (*uaddr)
+		: GCC_OFF12_ASM() (*uaddr), "Jr" (oldval), "Jr" (newval),
+		  "i" (-EFAULT)
 		: "memory");
 	} else
 		return -ENOSYS;
Index: linux-3.18-rc4-malta/arch/mips/include/asm/mach-pmcs-msp71xx/msp_regops.h
===================================================================
--- linux-3.18-rc4-malta.orig/arch/mips/include/asm/mach-pmcs-msp71xx/msp_regops.h	2014-11-14 03:29:49.000000000 +0000
+++ linux-3.18-rc4-malta/arch/mips/include/asm/mach-pmcs-msp71xx/msp_regops.h	2014-11-15 05:48:25.871909457 +0000
@@ -49,6 +49,7 @@
 
 #include <linux/types.h>
 
+#include <asm/compiler.h>
 #include <asm/war.h>
 
 #ifndef R10000_LLSC_WAR
@@ -84,8 +85,8 @@ static inline void set_value_reg32(volat
 	"	"__beqz"%0, 1b				\n"
 	"	nop					\n"
 	"	.set	pop				\n"
-	: "=&r" (temp), "=m" (*addr)
-	: "ir" (~mask), "ir" (value), "m" (*addr));
+	: "=&r" (temp), "=" GCC_OFF12_ASM() (*addr)
+	: "ir" (~mask), "ir" (value), GCC_OFF12_ASM() (*addr));
 }
 
 /*
@@ -105,8 +106,8 @@ static inline void set_reg32(volatile u3
 	"	"__beqz"%0, 1b				\n"
 	"	nop					\n"
 	"	.set	pop				\n"
-	: "=&r" (temp), "=m" (*addr)
-	: "ir" (mask), "m" (*addr));
+	: "=&r" (temp), "=" GCC_OFF12_ASM() (*addr)
+	: "ir" (mask), GCC_OFF12_ASM() (*addr));
 }
 
 /*
@@ -126,8 +127,8 @@ static inline void clear_reg32(volatile 
 	"	"__beqz"%0, 1b				\n"
 	"	nop					\n"
 	"	.set	pop				\n"
-	: "=&r" (temp), "=m" (*addr)
-	: "ir" (~mask), "m" (*addr));
+	: "=&r" (temp), "=" GCC_OFF12_ASM() (*addr)
+	: "ir" (~mask), GCC_OFF12_ASM() (*addr));
 }
 
 /*
@@ -147,8 +148,8 @@ static inline void toggle_reg32(volatile
 	"	"__beqz"%0, 1b				\n"
 	"	nop					\n"
 	"	.set	pop				\n"
-	: "=&r" (temp), "=m" (*addr)
-	: "ir" (mask), "m" (*addr));
+	: "=&r" (temp), "=" GCC_OFF12_ASM() (*addr)
+	: "ir" (mask), GCC_OFF12_ASM() (*addr));
 }
 
 /*
@@ -219,8 +220,8 @@ static inline u32 blocking_read_reg32(vo
 	"	.set	arch=r4000			\n"	\
 	"1:	ll	%0, %1	#custom_read_reg32	\n"	\
 	"	.set	pop				\n"	\
-	: "=r" (tmp), "=m" (*address)				\
-	: "m" (*address))
+	: "=r" (tmp), "=" GCC_OFF12_ASM() (*address)		\
+	: GCC_OFF12_ASM() (*address))
 
 #define custom_write_reg32(address, tmp)			\
 	__asm__ __volatile__(					\
@@ -230,7 +231,7 @@ static inline u32 blocking_read_reg32(vo
 	"	"__beqz"%0, 1b				\n"	\
 	"	nop					\n"	\
 	"	.set	pop				\n"	\
-	: "=&r" (tmp), "=m" (*address)				\
-	: "0" (tmp), "m" (*address))
+	: "=&r" (tmp), "=" GCC_OFF12_ASM() (*address)		\
+	: "0" (tmp), GCC_OFF12_ASM() (*address))
 
 #endif	/* __ASM_REGOPS_H__ */
Index: linux-3.18-rc4-malta/arch/mips/include/asm/octeon/cvmx-cmd-queue.h
===================================================================
--- linux-3.18-rc4-malta.orig/arch/mips/include/asm/octeon/cvmx-cmd-queue.h	2013-05-23 16:08:04.000000000 +0100
+++ linux-3.18-rc4-malta/arch/mips/include/asm/octeon/cvmx-cmd-queue.h	2014-11-15 05:48:25.871909457 +0000
@@ -76,6 +76,8 @@
 
 #include <linux/prefetch.h>
 
+#include <asm/compiler.h>
+
 #include <asm/octeon/cvmx-fpa.h>
 /**
  * By default we disable the max depth support. Most programs
@@ -273,7 +275,7 @@ static inline void __cvmx_cmd_queue_lock
 		" lbu	%[ticket], %[now_serving]\n"
 		"4:\n"
 		".set pop\n" :
-		[ticket_ptr] "=m"(__cvmx_cmd_queue_state_ptr->ticket[__cvmx_cmd_queue_get_index(queue_id)]),
+		[ticket_ptr] "=" GCC_OFF12_ASM()(__cvmx_cmd_queue_state_ptr->ticket[__cvmx_cmd_queue_get_index(queue_id)]),
 		[now_serving] "=m"(qptr->now_serving), [ticket] "=r"(tmp),
 		[my_ticket] "=r"(my_ticket)
 	    );
Index: linux-3.18-rc4-malta/arch/mips/include/asm/spinlock.h
===================================================================
--- linux-3.18-rc4-malta.orig/arch/mips/include/asm/spinlock.h	2013-05-23 16:08:04.000000000 +0100
+++ linux-3.18-rc4-malta/arch/mips/include/asm/spinlock.h	2014-11-15 05:48:25.871909457 +0000
@@ -12,6 +12,7 @@
 #include <linux/compiler.h>
 
 #include <asm/barrier.h>
+#include <asm/compiler.h>
 #include <asm/war.h>
 
 /*
@@ -88,7 +89,7 @@ static inline void arch_spin_lock(arch_s
 		"	 subu	%[ticket], %[ticket], 1			\n"
 		"	.previous					\n"
 		"	.set pop					\n"
-		: [ticket_ptr] "+m" (lock->lock),
+		: [ticket_ptr] "+" GCC_OFF12_ASM() (lock->lock),
 		  [serving_now_ptr] "+m" (lock->h.serving_now),
 		  [ticket] "=&r" (tmp),
 		  [my_ticket] "=&r" (my_ticket)
@@ -121,7 +122,7 @@ static inline void arch_spin_lock(arch_s
 		"	 subu	%[ticket], %[ticket], 1			\n"
 		"	.previous					\n"
 		"	.set pop					\n"
-		: [ticket_ptr] "+m" (lock->lock),
+		: [ticket_ptr] "+" GCC_OFF12_ASM() (lock->lock),
 		  [serving_now_ptr] "+m" (lock->h.serving_now),
 		  [ticket] "=&r" (tmp),
 		  [my_ticket] "=&r" (my_ticket)
@@ -163,7 +164,7 @@ static inline unsigned int arch_spin_try
 		"	 li	%[ticket], 0				\n"
 		"	.previous					\n"
 		"	.set pop					\n"
-		: [ticket_ptr] "+m" (lock->lock),
+		: [ticket_ptr] "+" GCC_OFF12_ASM() (lock->lock),
 		  [ticket] "=&r" (tmp),
 		  [my_ticket] "=&r" (tmp2),
 		  [now_serving] "=&r" (tmp3)
@@ -187,7 +188,7 @@ static inline unsigned int arch_spin_try
 		"	 li	%[ticket], 0				\n"
 		"	.previous					\n"
 		"	.set pop					\n"
-		: [ticket_ptr] "+m" (lock->lock),
+		: [ticket_ptr] "+" GCC_OFF12_ASM() (lock->lock),
 		  [ticket] "=&r" (tmp),
 		  [my_ticket] "=&r" (tmp2),
 		  [now_serving] "=&r" (tmp3)
@@ -234,8 +235,8 @@ static inline void arch_read_lock(arch_r
 		"	beqzl	%1, 1b					\n"
 		"	 nop						\n"
 		"	.set	reorder					\n"
-		: "=m" (rw->lock), "=&r" (tmp)
-		: "m" (rw->lock)
+		: "=" GCC_OFF12_ASM() (rw->lock), "=&r" (tmp)
+		: GCC_OFF12_ASM() (rw->lock)
 		: "memory");
 	} else {
 		do {
@@ -244,8 +245,8 @@ static inline void arch_read_lock(arch_r
 			"	bltz	%1, 1b				\n"
 			"	 addu	%1, 1				\n"
 			"2:	sc	%1, %0				\n"
-			: "=m" (rw->lock), "=&r" (tmp)
-			: "m" (rw->lock)
+			: "=" GCC_OFF12_ASM() (rw->lock), "=&r" (tmp)
+			: GCC_OFF12_ASM() (rw->lock)
 			: "memory");
 		} while (unlikely(!tmp));
 	}
@@ -268,8 +269,8 @@ static inline void arch_read_unlock(arch
 		"	sub	%1, 1					\n"
 		"	sc	%1, %0					\n"
 		"	beqzl	%1, 1b					\n"
-		: "=m" (rw->lock), "=&r" (tmp)
-		: "m" (rw->lock)
+		: "=" GCC_OFF12_ASM() (rw->lock), "=&r" (tmp)
+		: GCC_OFF12_ASM() (rw->lock)
 		: "memory");
 	} else {
 		do {
@@ -277,8 +278,8 @@ static inline void arch_read_unlock(arch
 			"1:	ll	%1, %2	# arch_read_unlock	\n"
 			"	sub	%1, 1				\n"
 			"	sc	%1, %0				\n"
-			: "=m" (rw->lock), "=&r" (tmp)
-			: "m" (rw->lock)
+			: "=" GCC_OFF12_ASM() (rw->lock), "=&r" (tmp)
+			: GCC_OFF12_ASM() (rw->lock)
 			: "memory");
 		} while (unlikely(!tmp));
 	}
@@ -298,8 +299,8 @@ static inline void arch_write_lock(arch_
 		"	beqzl	%1, 1b					\n"
 		"	 nop						\n"
 		"	.set	reorder					\n"
-		: "=m" (rw->lock), "=&r" (tmp)
-		: "m" (rw->lock)
+		: "=" GCC_OFF12_ASM() (rw->lock), "=&r" (tmp)
+		: GCC_OFF12_ASM() (rw->lock)
 		: "memory");
 	} else {
 		do {
@@ -308,8 +309,8 @@ static inline void arch_write_lock(arch_
 			"	bnez	%1, 1b				\n"
 			"	 lui	%1, 0x8000			\n"
 			"2:	sc	%1, %0				\n"
-			: "=m" (rw->lock), "=&r" (tmp)
-			: "m" (rw->lock)
+			: "=" GCC_OFF12_ASM() (rw->lock), "=&r" (tmp)
+			: GCC_OFF12_ASM() (rw->lock)
 			: "memory");
 		} while (unlikely(!tmp));
 	}
@@ -348,8 +349,8 @@ static inline int arch_read_trylock(arch
 		__WEAK_LLSC_MB
 		"	li	%2, 1					\n"
 		"2:							\n"
-		: "=m" (rw->lock), "=&r" (tmp), "=&r" (ret)
-		: "m" (rw->lock)
+		: "=" GCC_OFF12_ASM() (rw->lock), "=&r" (tmp), "=&r" (ret)
+		: GCC_OFF12_ASM() (rw->lock)
 		: "memory");
 	} else {
 		__asm__ __volatile__(
@@ -365,8 +366,8 @@ static inline int arch_read_trylock(arch
 		__WEAK_LLSC_MB
 		"	li	%2, 1					\n"
 		"2:							\n"
-		: "=m" (rw->lock), "=&r" (tmp), "=&r" (ret)
-		: "m" (rw->lock)
+		: "=" GCC_OFF12_ASM() (rw->lock), "=&r" (tmp), "=&r" (ret)
+		: GCC_OFF12_ASM() (rw->lock)
 		: "memory");
 	}
 
@@ -392,8 +393,8 @@ static inline int arch_write_trylock(arc
 		"	li	%2, 1					\n"
 		"	.set	reorder					\n"
 		"2:							\n"
-		: "=m" (rw->lock), "=&r" (tmp), "=&r" (ret)
-		: "m" (rw->lock)
+		: "=" GCC_OFF12_ASM() (rw->lock), "=&r" (tmp), "=&r" (ret)
+		: GCC_OFF12_ASM() (rw->lock)
 		: "memory");
 	} else {
 		do {
@@ -405,8 +406,9 @@ static inline int arch_write_trylock(arc
 			"	sc	%1, %0				\n"
 			"	li	%2, 1				\n"
 			"2:						\n"
-			: "=m" (rw->lock), "=&r" (tmp), "=&r" (ret)
-			: "m" (rw->lock)
+			: "=" GCC_OFF12_ASM() (rw->lock), "=&r" (tmp),
+			  "=&r" (ret)
+			: GCC_OFF12_ASM() (rw->lock)
 			: "memory");
 		} while (unlikely(!tmp));
 
