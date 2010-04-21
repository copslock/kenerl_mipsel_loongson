Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Apr 2010 19:19:43 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:41507 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S32854Ab0DURTh (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 21 Apr 2010 19:19:37 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o3LHJJMC029499;
        Wed, 21 Apr 2010 18:19:19 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o3LHJGMm029491;
        Wed, 21 Apr 2010 18:19:16 +0100
Date:   Wed, 21 Apr 2010 18:19:15 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     Deng-Cheng Zhu <dengcheng.zhu@gmail.com>,
        linux-mips@linux-mips.org, a.p.zijlstra@chello.nl,
        paulus@samba.org, mingo@elte.hu, acme@redhat.com,
        jamie.iles@picochip.com
Subject: Re: [PATCH 1/3] MIPS: use the generic atomic64 operations for perf
 counter support
Message-ID: <20100421171915.GA29010@linux-mips.org>
References: <1271349525.7467.420.camel@fun-lab>
 <4BCDD58F.7020201@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4BCDD58F.7020201@caviumnetworks.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26444
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Apr 20, 2010 at 09:25:51AM -0700, David Daney wrote:

> >Signed-off-by: Deng-Cheng Zhu<dengcheng.zhu@gmail.com>
> 
> NAK.

> >+#ifdef CONFIG_GENERIC_ATOMIC64
> >+#include<asm-generic/atomic64.h>
> >+#endif
> >+
> >  #define ATOMIC_INIT(i)    { (i) }
> >
> >  /*
> 
> This is incorrect.  For 64-bit kernels, we already have all the
> 64-bit atomics implemented.  This will break 64-bit kernels.

Here's an alternative patch.  Much larger but should take make the atomic64
functions fully usable on 32-bit kernels.  Some additional optimizations
for 64-bit hardware running 32-bit kernels would be possible but why bother.

  Ralf

MIPS: Make atomic64 functions usable on 32-bit kernels.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/arch/mips/include/asm/atomic.h b/arch/mips/include/asm/atomic.h
index 519197e..5f00bbc 100644
--- a/arch/mips/include/asm/atomic.h
+++ b/arch/mips/include/asm/atomic.h
@@ -15,11 +15,13 @@
 #define _ASM_ATOMIC_H
 
 #include <linux/irqflags.h>
+#include <linux/spinlock.h>
 #include <linux/types.h>
 #include <asm/barrier.h>
+#include <asm/cmpxchg.h>
 #include <asm/cpu-features.h>
+#include <asm/hashed-locks.h>
 #include <asm/war.h>
-#include <asm/system.h>
 
 #define ATOMIC_INIT(i)    { (i) }
 
@@ -401,7 +403,9 @@ static __inline__ int atomic_add_unless(atomic_t *v, int a, int u)
  */
 #define atomic_add_negative(i, v) (atomic_add_return(i, (v)) < 0)
 
-#ifdef CONFIG_64BIT
+typedef struct {
+	long long counter;
+} atomic64_t;
 
 #define ATOMIC64_INIT(i)    { (i) }
 
@@ -410,14 +414,44 @@ static __inline__ int atomic_add_unless(atomic_t *v, int a, int u)
  * @v: pointer of type atomic64_t
  *
  */
-#define atomic64_read(v)	((v)->counter)
+static long long __inline__ atomic64_read(const atomic64_t *v)
+{
+	unsigned long flags;
+	raw_spinlock_t *lock;
+	long long val;
+
+	if (cpu_has_64bit_gp_regs)	/* 64-bit regs imply 64-bit ld / sd  */
+		return v->counter;
+
+	lock = atomic_lock_addr(v);
+	raw_spin_lock_irqsave(lock, flags);
+	val = v->counter;
+	raw_spin_unlock_irqrestore(lock, flags);
+
+	return val;
+}
 
 /*
  * atomic64_set - set atomic variable
  * @v: pointer of type atomic64_t
  * @i: required value
  */
-#define atomic64_set(v, i)	((v)->counter = (i))
+static void __inline__ atomic64_set(atomic64_t *v, long long i)
+{
+	unsigned long flags;
+	raw_spinlock_t *lock;
+
+	if (cpu_has_64bit_gp_regs) {	/* 64-bit regs imply 64-bit ld / sd  */
+		v->counter = i;
+
+		return;
+	}
+
+	lock = atomic_lock_addr(v);
+	raw_spin_lock_irqsave(lock, flags);
+	v->counter = i;
+	raw_spin_unlock_irqrestore(lock, flags);
+}
 
 /*
  * atomic64_add - add integer to atomic variable
@@ -428,7 +462,7 @@ static __inline__ int atomic_add_unless(atomic_t *v, int a, int u)
  */
 static __inline__ void atomic64_add(long i, atomic64_t * v)
 {
-	if (kernel_uses_llsc && R10000_LLSC_WAR) {
+	if (kernel_uses_llsc && cpu_has_64bit_gp_regs && R10000_LLSC_WAR) {
 		long temp;
 
 		__asm__ __volatile__(
@@ -440,7 +474,7 @@ static __inline__ void atomic64_add(long i, atomic64_t * v)
 		"	.set	mips0					\n"
 		: "=&r" (temp), "=m" (v->counter)
 		: "Ir" (i), "m" (v->counter));
-	} else if (kernel_uses_llsc) {
+	} else if (kernel_uses_llsc && cpu_has_64bit_gp_regs) {
 		long temp;
 
 		__asm__ __volatile__(
@@ -456,11 +490,12 @@ static __inline__ void atomic64_add(long i, atomic64_t * v)
 		: "=&r" (temp), "=m" (v->counter)
 		: "Ir" (i), "m" (v->counter));
 	} else {
+		raw_spinlock_t *lock = atomic_lock_addr(v);
 		unsigned long flags;
 
-		raw_local_irq_save(flags);
+		raw_spin_lock_irqsave(lock, flags);
 		v->counter += i;
-		raw_local_irq_restore(flags);
+		raw_spin_unlock_irqrestore(lock, flags);
 	}
 }
 
@@ -473,7 +508,7 @@ static __inline__ void atomic64_add(long i, atomic64_t * v)
  */
 static __inline__ void atomic64_sub(long i, atomic64_t * v)
 {
-	if (kernel_uses_llsc && R10000_LLSC_WAR) {
+	if (kernel_uses_llsc && cpu_has_64bit_gp_regs && R10000_LLSC_WAR) {
 		long temp;
 
 		__asm__ __volatile__(
@@ -485,7 +520,7 @@ static __inline__ void atomic64_sub(long i, atomic64_t * v)
 		"	.set	mips0					\n"
 		: "=&r" (temp), "=m" (v->counter)
 		: "Ir" (i), "m" (v->counter));
-	} else if (kernel_uses_llsc) {
+	} else if (kernel_uses_llsc && cpu_has_64bit_gp_regs) {
 		long temp;
 
 		__asm__ __volatile__(
@@ -501,11 +536,12 @@ static __inline__ void atomic64_sub(long i, atomic64_t * v)
 		: "=&r" (temp), "=m" (v->counter)
 		: "Ir" (i), "m" (v->counter));
 	} else {
+		raw_spinlock_t *lock = atomic_lock_addr(v);
 		unsigned long flags;
 
-		raw_local_irq_save(flags);
+		raw_spin_lock_irqsave(lock, flags);
 		v->counter -= i;
-		raw_local_irq_restore(flags);
+		raw_spin_unlock_irqrestore(lock, flags);
 	}
 }
 
@@ -518,7 +554,7 @@ static __inline__ long atomic64_add_return(long i, atomic64_t * v)
 
 	smp_mb__before_llsc();
 
-	if (kernel_uses_llsc && R10000_LLSC_WAR) {
+	if (kernel_uses_llsc &&  cpu_has_64bit_gp_regs && R10000_LLSC_WAR) {
 		long temp;
 
 		__asm__ __volatile__(
@@ -532,7 +568,7 @@ static __inline__ long atomic64_add_return(long i, atomic64_t * v)
 		: "=&r" (result), "=&r" (temp), "=m" (v->counter)
 		: "Ir" (i), "m" (v->counter)
 		: "memory");
-	} else if (kernel_uses_llsc) {
+	} else if (kernel_uses_llsc && cpu_has_64bit_gp_regs) {
 		long temp;
 
 		__asm__ __volatile__(
@@ -550,13 +586,14 @@ static __inline__ long atomic64_add_return(long i, atomic64_t * v)
 		: "Ir" (i), "m" (v->counter)
 		: "memory");
 	} else {
+		raw_spinlock_t *lock = atomic_lock_addr(v);
 		unsigned long flags;
 
-		raw_local_irq_save(flags);
+		raw_spin_lock_irqsave(lock, flags);
 		result = v->counter;
 		result += i;
 		v->counter = result;
-		raw_local_irq_restore(flags);
+		raw_spin_unlock_irqrestore(lock, flags);
 	}
 
 	smp_llsc_mb();
@@ -570,7 +607,7 @@ static __inline__ long atomic64_sub_return(long i, atomic64_t * v)
 
 	smp_mb__before_llsc();
 
-	if (kernel_uses_llsc && R10000_LLSC_WAR) {
+	if (kernel_uses_llsc && cpu_has_64bit_gp_regs && R10000_LLSC_WAR) {
 		long temp;
 
 		__asm__ __volatile__(
@@ -584,7 +621,7 @@ static __inline__ long atomic64_sub_return(long i, atomic64_t * v)
 		: "=&r" (result), "=&r" (temp), "=m" (v->counter)
 		: "Ir" (i), "m" (v->counter)
 		: "memory");
-	} else if (kernel_uses_llsc) {
+	} else if (kernel_uses_llsc && cpu_has_64bit_gp_regs) {
 		long temp;
 
 		__asm__ __volatile__(
@@ -602,13 +639,14 @@ static __inline__ long atomic64_sub_return(long i, atomic64_t * v)
 		: "Ir" (i), "m" (v->counter)
 		: "memory");
 	} else {
+		raw_spinlock_t *lock = atomic_lock_addr(v);
 		unsigned long flags;
 
-		raw_local_irq_save(flags);
+		raw_spin_lock_irqsave(lock, flags);
 		result = v->counter;
 		result -= i;
 		v->counter = result;
-		raw_local_irq_restore(flags);
+		raw_spin_unlock_irqrestore(lock, flags);
 	}
 
 	smp_llsc_mb();
@@ -630,7 +668,7 @@ static __inline__ long atomic64_sub_if_positive(long i, atomic64_t * v)
 
 	smp_mb__before_llsc();
 
-	if (kernel_uses_llsc && R10000_LLSC_WAR) {
+	if (kernel_uses_llsc && cpu_has_64bit_gp_regs && R10000_LLSC_WAR) {
 		long temp;
 
 		__asm__ __volatile__(
@@ -648,7 +686,7 @@ static __inline__ long atomic64_sub_if_positive(long i, atomic64_t * v)
 		: "=&r" (result), "=&r" (temp), "=m" (v->counter)
 		: "Ir" (i), "m" (v->counter)
 		: "memory");
-	} else if (kernel_uses_llsc) {
+	} else if (kernel_uses_llsc && cpu_has_64bit_gp_regs) {
 		long temp;
 
 		__asm__ __volatile__(
@@ -670,14 +708,15 @@ static __inline__ long atomic64_sub_if_positive(long i, atomic64_t * v)
 		: "Ir" (i), "m" (v->counter)
 		: "memory");
 	} else {
+		raw_spinlock_t *lock = atomic_lock_addr(v);
 		unsigned long flags;
 
-		raw_local_irq_save(flags);
+		raw_spin_lock_irqsave(lock, flags);
 		result = v->counter;
 		result -= i;
 		if (result >= 0)
 			v->counter = result;
-		raw_local_irq_restore(flags);
+		raw_spin_unlock_irqrestore(lock, flags);
 	}
 
 	smp_llsc_mb();
@@ -782,8 +821,6 @@ static __inline__ int atomic64_add_unless(atomic64_t *v, long a, long u)
  */
 #define atomic64_add_negative(i, v) (atomic64_add_return(i, (v)) < 0)
 
-#endif /* CONFIG_64BIT */
-
 /*
  * atomic*_return operations are serializing but not the non-*_return
  * versions.
diff --git a/arch/mips/include/asm/cmpxchg.h b/arch/mips/include/asm/cmpxchg.h
index 2d28017..7ed77bd 100644
--- a/arch/mips/include/asm/cmpxchg.h
+++ b/arch/mips/include/asm/cmpxchg.h
@@ -9,6 +9,8 @@
 #define __ASM_CMPXCHG_H
 
 #include <linux/irqflags.h>
+#include <linux/spinlock_types.h>
+#include <asm/hashed-locks.h>
 
 #define __HAVE_ARCH_CMPXCHG 1
 
@@ -53,16 +55,8 @@
 		: "=&r" (__ret), "=R" (*m)				\
 		: "R" (*m), "Jr" (old), "Jr" (new)			\
 		: "memory");						\
-	} else {							\
-		unsigned long __flags;					\
-									\
-		raw_local_irq_save(__flags);				\
-		__ret = *m;						\
-		if (__ret == old)					\
-			*m = new;					\
-		raw_local_irq_restore(__flags);				\
-	}								\
-									\
+	} else								\
+		BUG();							\
 	__ret;								\
 })
 
@@ -78,19 +72,42 @@ extern void __cmpxchg_called_with_bad_pointer(void);
 	__typeof__(*(ptr)) __old = (old);				\
 	__typeof__(*(ptr)) __new = (new);				\
 	__typeof__(*(ptr)) __res = 0;					\
+	unsigned long __flags;						\
+	raw_spinlock_t *lock;						\
 									\
 	pre_barrier;							\
 									\
 	switch (sizeof(*(__ptr))) {					\
 	case 4:								\
-		__res = __cmpxchg_asm("ll", "sc", __ptr, __old, __new);	\
+		if (kernel_uses_llsc) {					\
+			__res = __cmpxchg_asm("ll", "sc", __ptr, __old, \
+					       __new);			\
+			break;						\
+		}							\
+									\
+		lock = atomic_lock_addr(__ptr);				\
+		raw_spin_lock_irqsave(lock, __flags);			\
+		__res = *__ptr;						\
+		if (__res == __old)					\
+			*__ptr = __new;					\
+		raw_spin_unlock_irqrestore(lock, __flags);		\
 		break;							\
+									\
 	case 8:								\
-		if (sizeof(long) == 8) {				\
+		if (kernel_uses_llsc && cpu_has_64bit_gp_regs) {	\
 			__res = __cmpxchg_asm("lld", "scd", __ptr,	\
-					   __old, __new);		\
+					      __old, __new);		\
 			break;						\
 		}							\
+									\
+		lock = atomic_lock_addr(__ptr);				\
+		raw_spin_lock_irqsave(lock, __flags);			\
+		__res = *__ptr;						\
+		if (__res == __old)					\
+			*__ptr = __new;					\
+		raw_spin_unlock_irqrestore(lock, __flags);		\
+		break;							\
+									\
 	default:							\
 		__cmpxchg_called_with_bad_pointer();			\
 		break;							\
@@ -110,15 +127,10 @@ extern void __cmpxchg_called_with_bad_pointer(void);
 	cmpxchg((ptr), (o), (n));					\
   })
 
-#ifdef CONFIG_64BIT
 #define cmpxchg64_local(ptr, o, n)					\
   ({									\
 	BUILD_BUG_ON(sizeof(*(ptr)) != 8);				\
 	cmpxchg_local((ptr), (o), (n));					\
   })
-#else
-#include <asm-generic/cmpxchg-local.h>
-#define cmpxchg64_local(ptr, o, n) __cmpxchg64_local_generic((ptr), (o), (n))
-#endif
 
 #endif /* __ASM_CMPXCHG_H */
diff --git a/arch/mips/include/asm/hashed-locks.h b/arch/mips/include/asm/hashed-locks.h
new file mode 100644
index 0000000..6d6321c
--- /dev/null
+++ b/arch/mips/include/asm/hashed-locks.h
@@ -0,0 +1,38 @@
+/*
+ * Hashed locks for when we cannot or do not want to use LL/SC for the
+ * implementation of atomic operations in atomic.h, cmpxchg.h etc.
+ */
+#ifndef __ASM_HASHED_LOCKS_H
+#define __ASM_HASHED_LOCKS_H
+
+#include <linux/cache.h>
+#include <linux/spinlock_types.h>
+
+/*
+ * We use a hashed array of spinlocks to provide exclusive access
+ * to each atomic64_t variable.  Since this is expected to used on
+ * systems with small numbers of CPUs (<= 4 or so), we use a
+ * relatively small array of 16 spinlocks to avoid wasting too much
+ * memory on the spinlock array.
+ */
+#define NR_LOCKS	16
+
+/*
+ * Ensure each lock is in a separate cacheline.
+ */
+extern union atomic64_lock_union {
+	raw_spinlock_t lock;
+	char pad[L1_CACHE_BYTES];
+} __atomic_lock_array[NR_LOCKS];
+
+static inline raw_spinlock_t *atomic_lock_addr(volatile const void *v)
+{
+	unsigned long addr = (unsigned long) v;
+
+	addr >>= L1_CACHE_SHIFT;
+	addr ^= (addr >> 8) ^ (addr >> 16);
+
+	return &__atomic_lock_array[addr & (NR_LOCKS - 1)].lock;
+}
+
+#endif /* __ASM_HASHED_LOCKS_H */
diff --git a/arch/mips/lib/Makefile b/arch/mips/lib/Makefile
index 2adead5..c138aad 100644
--- a/arch/mips/lib/Makefile
+++ b/arch/mips/lib/Makefile
@@ -2,8 +2,8 @@
 # Makefile for MIPS-specific library files..
 #
 
-lib-y	+= csum_partial.o delay.o memcpy.o memcpy-inatomic.o memset.o \
-	   strlen_user.o strncpy_user.o strnlen_user.o uncached.o
+lib-y	+= csum_partial.o delay.o hashed-locks.o memcpy.o memcpy-inatomic.o \
+	   memset.o strlen_user.o strncpy_user.o strnlen_user.o uncached.o
 
 obj-y			+= iomap.o
 obj-$(CONFIG_PCI)	+= iomap-pci.o
diff --git a/arch/mips/lib/hashed-locks.c b/arch/mips/lib/hashed-locks.c
new file mode 100644
index 0000000..2fbb68a
--- /dev/null
+++ b/arch/mips/lib/hashed-locks.c
@@ -0,0 +1,9 @@
+#include <linux/cache.h>
+#include <linux/module.h>
+#include <asm/atomic.h>
+
+union atomic64_lock_union __atomic_lock_array[NR_LOCKS] = {
+	[0 ... NR_LOCKS - 1] .lock	= __ARCH_SPIN_LOCK_UNLOCKED,
+} __cacheline_aligned_in_smp;
+
+EXPORT_SYMBOL(__atomic_lock_array);
