Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 May 2004 01:41:44 +0100 (BST)
Received: from p508B5AC4.dip.t-dialin.net ([IPv6:::ffff:80.139.90.196]:21329
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8226108AbUE1Af2>; Fri, 28 May 2004 01:35:28 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i4S0ZQEt027903;
	Fri, 28 May 2004 02:35:26 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i4S0ZPgR027902;
	Fri, 28 May 2004 02:35:25 +0200
Date: Fri, 28 May 2004 02:35:25 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Emmanuel Michon <em@realmagic.fr>
Cc: linux-mips@linux-mips.org
Subject: Re: down_trylock() implementation for MIPS 4KEc CPU implies 64bit arithmetics?
Message-ID: <20040528003525.GA27796@linux-mips.org>
References: <1085589315.2306.49.camel@avalon.france.sdesigns.com> <20040526203346.GA8430@linux-mips.org> <1085668313.20233.1249.camel@avalon.france.sdesigns.com> <20040527155947.GA4154@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040527155947.GA4154@linux-mips.org>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5209
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

Oh well, so here is a rewrite of the semaphore code.  Less complex,
does no longer need 64-bit alignment for the strange union handling we
were using in struct semaphore also smaller and no longer relies on
64-bit computing on 32-bit hardware.  For my SMP test kernel it did cut
off 5972 bytes.  The patch below is against 2.6 but fitting it into 2.4
is easy.

  Ralf

Index: include/asm-mips/atomic.h
===================================================================
RCS file: /home/cvs/linux/include/asm-mips/atomic.h,v
retrieving revision 1.29
diff -u -r1.29 atomic.h
--- include/asm-mips/atomic.h	19 Feb 2004 03:06:34 -0000	1.29
+++ include/asm-mips/atomic.h	28 May 2004 00:30:05 -0000
@@ -9,7 +9,7 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Copyright (C) 1996, 97, 99, 2000, 03 by Ralf Baechle
+ * Copyright (C) 1996, 97, 99, 2000, 03, 04 by Ralf Baechle
  */
 
 /*
@@ -127,6 +127,32 @@
 	return result;
 }
 
+/*
+ * atomic_sub_if_positive - add integer to atomic variable
+ * @v: pointer of type atomic_t
+ *
+ * Atomically test @v and decrement if it is greater than 0.
+ * The function returns the old value of @v minus 1.
+ */
+static __inline__ int atomic_sub_if_positive(int i, atomic_t * v)
+{
+	unsigned long temp, result;
+
+	__asm__ __volatile__(
+	"1:	ll	%1, %2		# atomic_sub_if_positive\n"
+	"	subu	%0, %1, %3				\n"
+	"	bltz	%0, 1f					\n"
+	"	sc	%0, %2					\n"
+	"	beqz	%0, 1b					\n"
+	"	sync						\n"
+	"1:							\n"
+	: "=&r" (result), "=&r" (temp), "=m" (v->counter)
+	: "Ir" (i), "m" (v->counter)
+	: "memory");
+
+	return result;
+}
+
 #else
 
 /*
@@ -192,6 +218,28 @@
 	return temp;
 }
 
+/*
+ * atomic_sub_if_positive - add integer to atomic variable
+ * @v: pointer of type atomic_t
+ *
+ * Atomically test @v and decrement if it is greater than 0.
+ * The function returns the old value of @v minus 1.
+ */
+static __inline__ int atomic_sub_if_positive(int i, atomic_t * v)
+{
+	unsigned long flags;
+	int temp, result;
+
+	spin_lock_irqsave(&atomic_lock, flags);
+	temp = v->counter;
+	temp -= i;
+	if (temp >= 0)
+		v->counter = temp;
+	spin_unlock_irqrestore(&atomic_lock, flags);
+
+	return result;
+}
+
 #endif /* CONFIG_CPU_HAS_LLSC */
 
 #define atomic_dec_return(v) atomic_sub_return(1,(v))
@@ -229,6 +277,12 @@
 #define atomic_dec_and_test(v) (atomic_sub_return(1, (v)) == 0)
 
 /*
+ * atomic_dec_if_positive - decrement by 1 if old value positive
+ * @v: pointer of type atomic_t
+ */
+#define atomic_dec_if_positive(v)	atomic_sub_if_positive(1, v)
+
+/*
  * atomic_inc - increment atomic variable
  * @v: pointer of type atomic_t
  *
@@ -356,6 +410,32 @@
 	return result;
 }
 
+/*
+ * atomic64_sub_if_positive - add integer to atomic variable
+ * @v: pointer of type atomic64_t
+ *
+ * Atomically test @v and decrement if it is greater than 0.
+ * The function returns the old value of @v minus 1.
+ */
+static __inline__ int atomic64_sub_if_positive(int i, atomic64_t * v)
+{
+	unsigned long temp, result;
+
+	__asm__ __volatile__(
+	"1:	lld	%1, %2		# atomic64_sub_if_positive\n"
+	"	subu	%0, %1, %3				\n"
+	"	bltz	%0, 1f					\n"
+	"	scd	%0, %2					\n"
+	"	beqz	%0, 1b					\n"
+	"	sync						\n"
+	"1:							\n"
+	: "=&r" (result), "=&r" (temp), "=m" (v->counter)
+	: "Ir" (i), "m" (v->counter)
+	: "memory");
+
+	return result;
+}
+
 #else
 
 /*
@@ -421,6 +501,28 @@
 	return temp;
 }
 
+/*
+ * atomic64_sub_if_positive - add integer to atomic variable
+ * @v: pointer of type atomic64_t
+ *
+ * Atomically test @v and decrement if it is greater than 0.
+ * The function returns the old value of @v minus 1.
+ */
+static __inline__ int atomic64_sub_if_positive(int i, atomic64_t * v)
+{
+	unsigned long flags;
+	long temp, result;
+
+	spin_lock_irqsave(&atomic_lock, flags);
+	temp = v->counter;
+	temp -= i;
+	if (temp >= 0)
+		v->counter = temp;
+	spin_unlock_irqrestore(&atomic_lock, flags);
+
+	return result;
+}
+
 #endif /* CONFIG_CPU_HAS_LLDSCD */
 
 #define atomic64_dec_return(v) atomic64_sub_return(1,(v))
@@ -458,6 +560,12 @@
 #define atomic64_dec_and_test(v) (atomic64_sub_return(1, (v)) == 0)
 
 /*
+ * atomic64_dec_if_positive - decrement by 1 if old value positive
+ * @v: pointer of type atomic64_t
+ */
+#define atomic64_dec_if_positive(v)	atomic64_sub_if_positive(1, v)
+
+/*
  * atomic64_inc - increment atomic variable
  * @v: pointer of type atomic64_t
  *
Index: include/asm-mips/semaphore.h
===================================================================
RCS file: /home/cvs/linux/include/asm-mips/semaphore.h,v
retrieving revision 1.27
diff -u -r1.27 semaphore.h
--- include/asm-mips/semaphore.h	28 Nov 2003 16:56:52 -0000	1.27
+++ include/asm-mips/semaphore.h	28 May 2004 00:30:05 -0000
@@ -4,61 +4,70 @@
  * for more details.
  *
  * Copyright (C) 1996  Linus Torvalds
- * Copyright (C) 1998, 99, 2000, 01  Ralf Baechle
+ * Copyright (C) 1998, 99, 2000, 01, 04  Ralf Baechle
  * Copyright (C) 1999, 2000, 01  Silicon Graphics, Inc.
  * Copyright (C) 2000, 01 MIPS Technologies, Inc.
+ *
+ * In all honesty, little of the old MIPS code left - the PPC64 variant was
+ * just looking nice and portable so I ripped it.  Credits to whoever wrote
+ * it.
  */
-#ifndef _ASM_SEMAPHORE_H
-#define _ASM_SEMAPHORE_H
+#ifndef __ASM_SEMAPHORE_H
+#define __ASM_SEMAPHORE_H
+
+/*
+ * Remove spinlock-based RW semaphores; RW semaphore definitions are
+ * now in rwsem.h and we use the generic lib/rwsem.c implementation.
+ * Rework semaphores to use atomic_dec_if_positive.
+ * -- Paul Mackerras (paulus@samba.org)
+ */
+
+#ifdef __KERNEL__
 
-#include <linux/compiler.h>
-#include <linux/config.h>
-#include <linux/spinlock.h>
+#include <asm/atomic.h>
+#include <asm/system.h>
 #include <linux/wait.h>
 #include <linux/rwsem.h>
-#include <asm/atomic.h>
 
 struct semaphore {
-#ifdef __MIPSEB__
-	atomic_t count;
-	atomic_t waking;
-#else
-	atomic_t waking;
+	/*
+	 * Note that any negative value of count is equivalent to 0,
+	 * but additionally indicates that some process(es) might be
+	 * sleeping on `wait'.
+	 */
 	atomic_t count;
-#endif
 	wait_queue_head_t wait;
-#if WAITQUEUE_DEBUG
+#ifdef WAITQUEUE_DEBUG
 	long __magic;
 #endif
-} __attribute__((aligned(8)));
+};
 
-#if WAITQUEUE_DEBUG
-# define __SEM_DEBUG_INIT(name) , .__magic = (long)&(name).__magic
+#ifdef WAITQUEUE_DEBUG
+# define __SEM_DEBUG_INIT(name) \
+		, (long)&(name).__magic
 #else
 # define __SEM_DEBUG_INIT(name)
 #endif
 
-#define __SEMAPHORE_INITIALIZER(name,_count) {				\
-	.count	= ATOMIC_INIT(_count),					\
-	.waking	= ATOMIC_INIT(0),					\
-	.wait	= __WAIT_QUEUE_HEAD_INITIALIZER((name).wait)		\
-	__SEM_DEBUG_INIT(name)						\
-}
+#define __SEMAPHORE_INITIALIZER(name, count) \
+	{ ATOMIC_INIT(count), \
+	  __WAIT_QUEUE_HEAD_INITIALIZER((name).wait) \
+	  __SEM_DEBUG_INIT(name) }
 
-#define __MUTEX_INITIALIZER(name) __SEMAPHORE_INITIALIZER(name, 1)
+#define __MUTEX_INITIALIZER(name) \
+	__SEMAPHORE_INITIALIZER(name, 1)
 
-#define __DECLARE_SEMAPHORE_GENERIC(name,count) \
-	struct semaphore name = __SEMAPHORE_INITIALIZER(name, count)
+#define __DECLARE_SEMAPHORE_GENERIC(name, count) \
+	struct semaphore name = __SEMAPHORE_INITIALIZER(name,count)
 
-#define DECLARE_MUTEX(name) __DECLARE_SEMAPHORE_GENERIC(name, 1)
-#define DECLARE_MUTEX_LOCKED(name) __DECLARE_SEMAPHORE_GENERIC(name,0)
+#define DECLARE_MUTEX(name)		__DECLARE_SEMAPHORE_GENERIC(name, 1)
+#define DECLARE_MUTEX_LOCKED(name)	__DECLARE_SEMAPHORE_GENERIC(name, 0)
 
 static inline void sema_init (struct semaphore *sem, int val)
 {
 	atomic_set(&sem->count, val);
-	atomic_set(&sem->waking, 0);
 	init_waitqueue_head(&sem->wait);
-#if WAITQUEUE_DEBUG
+#ifdef WAITQUEUE_DEBUG
 	sem->__magic = (long)&sem->__magic;
 #endif
 }
@@ -73,211 +82,57 @@
 	sema_init(sem, 0);
 }
 
-#ifndef CONFIG_CPU_HAS_LLDSCD
-/*
- * On machines without lld/scd we need a spinlock to make the manipulation of
- * sem->count and sem->waking atomic.
- */
-extern spinlock_t semaphore_lock;
-#endif
-
-extern void __down_failed(struct semaphore * sem);
-extern int  __down_failed_interruptible(struct semaphore * sem);
-extern void __up_wakeup(struct semaphore * sem);
+extern void __down(struct semaphore * sem);
+extern int  __down_interruptible(struct semaphore * sem);
+extern void __up(struct semaphore * sem);
 
 static inline void down(struct semaphore * sem)
 {
-	int count;
-
-#if WAITQUEUE_DEBUG
+#ifdef WAITQUEUE_DEBUG
 	CHECK_MAGIC(sem->__magic);
 #endif
 	might_sleep();
-	count = atomic_dec_return(&sem->count);
-	if (unlikely(count < 0))
-		__down_failed(sem);
+
+	/*
+	 * Try to get the semaphore, take the slow path if we fail.
+	 */
+	if (unlikely(atomic_dec_return(&sem->count) < 0))
+		__down(sem);
 }
 
-/*
- * Interruptible try to acquire a semaphore.  If we obtained
- * it, return zero.  If we were interrupted, returns -EINTR
- */
 static inline int down_interruptible(struct semaphore * sem)
 {
-	int count;
+	int ret = 0;
 
-#if WAITQUEUE_DEBUG
+#ifdef WAITQUEUE_DEBUG
 	CHECK_MAGIC(sem->__magic);
 #endif
 	might_sleep();
-	count = atomic_dec_return(&sem->count);
-	if (unlikely(count < 0))
-		return __down_failed_interruptible(sem);
-
-	return 0;
-}
-
-#ifdef CONFIG_CPU_HAS_LLDSCD
-
-/*
- * down_trylock returns 0 on success, 1 if we failed to get the lock.
- *
- * We must manipulate count and waking simultaneously and atomically.
- * Here, we do this by using lld/scd on the pair of 32-bit words.
- *
- * Pseudocode:
- *
- *   Decrement(sem->count)
- *   If(sem->count >=0) {
- *	Return(SUCCESS)			// resource is free
- *   } else {
- *	If(sem->waking <= 0) {		// if no wakeup pending
- *	   Increment(sem->count)	// undo decrement
- *	   Return(FAILURE)
- *      } else {
- *	   Decrement(sem->waking)	// otherwise "steal" wakeup
- *	   Return(SUCCESS)
- *	}
- *   }
- */
-static inline int down_trylock(struct semaphore * sem)
-{
-	long ret, tmp, tmp2, sub;
-
-#if WAITQUEUE_DEBUG
-	CHECK_MAGIC(sem->__magic);
-#endif
-
-	__asm__ __volatile__(
-	"	.set	mips3			# down_trylock		\n"
-	"0:	lld	%1, %4						\n"
-	"	dli	%3, 0x0000000100000000	# count -= 1		\n"
-	"	dsubu	%1, %3						\n"
-	"	li	%0, 0			# ret = 0		\n"
-	"	bgez	%1, 2f			# if count >= 0		\n"
-	"	sll	%2, %1, 0		# extract waking	\n"
-	"	blez	%2, 1f			# if waking < 0 -> 1f	\n"
-	"	daddiu	%1, %1, -1		# waking -= 1		\n"
-	"	b	2f						\n"
-	"1:	daddu	%1, %1, %3		# count += 1		\n"
-	"	li	%0, 1			# ret = 1		\n"
-	"2:	scd	%1, %4						\n"
-	"	beqz	%1, 0b						\n"
-	"	sync							\n"
-	"	.set	mips0						\n"
-	: "=&r"(ret), "=&r"(tmp), "=&r"(tmp2), "=&r"(sub)
-	: "m"(*sem)
-	: "memory");
 
+	if (unlikely(atomic_dec_return(&sem->count) < 0))
+		ret = __down_interruptible(sem);
 	return ret;
 }
 
-/*
- * Note! This is subtle. We jump to wake people up only if
- * the semaphore was negative (== somebody was waiting on it).
- */
-static inline void up(struct semaphore * sem)
-{
-	unsigned long tmp, tmp2;
-	int count;
-
-#if WAITQUEUE_DEBUG
-	CHECK_MAGIC(sem->__magic);
-#endif
-	/*
-	 * We must manipulate count and waking simultaneously and atomically.
-	 * Otherwise we have races between up and __down_failed_interruptible
-	 * waking up on a signal.
-	 */
-
-	__asm__ __volatile__(
-	"	.set	mips3					\n"
-	"	sync			# up			\n"
-	"1:	lld	%1, %3					\n"
-	"	dsra32	%0, %1, 0	# extract count to %0	\n"
-	"	daddiu	%0, 1		# count += 1		\n"
-	"	slti	%2, %0, 1	# %3 = (%0 <= 0)	\n"
-	"	daddu	%1, %2		# waking += %3		\n"
-	"	dsll32 %1, %1, 0	# zero-extend %1	\n"
-	"	dsrl32 %1, %1, 0				\n"
-	"	dsll32	%2, %0, 0	# Reassemble union	\n"
-	"	or	%1, %2		# from count and waking	\n"
-	"	scd	%1, %3					\n"
-	"	beqz	%1, 1b					\n"
-	"	.set	mips0					\n"
-	: "=&r"(count), "=&r"(tmp), "=&r"(tmp2), "+m"(*sem)
-	:
-	: "memory");
-
-	if (unlikely(count <= 0))
-		__up_wakeup(sem);
-}
-
-#else
-
-/*
- * Non-blockingly attempt to down() a semaphore.
- * Returns zero if we acquired it
- */
 static inline int down_trylock(struct semaphore * sem)
 {
-	unsigned long flags;
-	int count, waking;
-	int ret = 0;
-
-#if WAITQUEUE_DEBUG
+#ifdef WAITQUEUE_DEBUG
 	CHECK_MAGIC(sem->__magic);
 #endif
 
-	spin_lock_irqsave(&semaphore_lock, flags);
-	count = atomic_read(&sem->count) - 1;
-	atomic_set(&sem->count, count);
-	if (unlikely(count < 0)) {
-		waking = atomic_read(&sem->waking);
-		if (waking <= 0) {
-			atomic_set(&sem->count, count + 1);
-			ret = 1;
-		} else {
-			atomic_set(&sem->waking, waking - 1);
-			ret = 0;
-		}
-	}
-	spin_unlock_irqrestore(&semaphore_lock, flags);
-
-	return ret;
+	return atomic_dec_if_positive(&sem->count) < 0;
 }
 
-/*
- * Note! This is subtle. We jump to wake people up only if
- * the semaphore was negative (== somebody was waiting on it).
- */
 static inline void up(struct semaphore * sem)
 {
-	unsigned long flags;
-	int count, waking;
-
-#if WAITQUEUE_DEBUG
+#ifdef WAITQUEUE_DEBUG
 	CHECK_MAGIC(sem->__magic);
 #endif
-	/*
-	 * We must manipulate count and waking simultaneously and atomically.
-	 * Otherwise we have races between up and __down_failed_interruptible
-	 * waking up on a signal.
-	 */
-
-	spin_lock_irqsave(&semaphore_lock, flags);
-	count = atomic_read(&sem->count) + 1;
-	waking = atomic_read(&sem->waking);
-	if (count <= 0)
-		waking++;
-	atomic_set(&sem->count, count);
-	atomic_set(&sem->waking, waking);
-	spin_unlock_irqrestore(&semaphore_lock, flags);
 
-	if (unlikely(count <= 0))
-		__up_wakeup(sem);
+	if (unlikely(atomic_inc_return(&sem->count) <= 0))
+		__up(sem);
 }
 
-#endif /* CONFIG_CPU_HAS_LLDSCD */
+#endif /* __KERNEL__ */
 
-#endif /* _ASM_SEMAPHORE_H */
+#endif /* __ASM_SEMAPHORE_H */
Index: arch/mips/kernel/semaphore.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/kernel/semaphore.c,v
retrieving revision 1.8
diff -u -r1.8 semaphore.c
--- arch/mips/kernel/semaphore.c	23 Apr 2004 15:54:09 -0000	1.8
+++ arch/mips/kernel/semaphore.c	28 May 2004 00:30:05 -0000
@@ -1,273 +1,165 @@
 /*
- * Copyright (C) 1999, 2001, 02, 03 Ralf Baechle
+ * MIPS-specific semaphore code.
  *
- * Heavily inspired by the Alpha implementation
+ * Copyright (C) 1999 Cort Dougan <cort@cs.nmt.edu>
+ * Copyright (C) 2004 Ralf Baechle <ralf@linux-mips.org>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ *
+ * April 2001 - Reworked by Paul Mackerras <paulus@samba.org>
+ * to eliminate the SMP races in the old version between the updates
+ * of `count' and `waking'.  Now we use negative `count' values to
+ * indicate that some process(es) are waiting for the semaphore.
  */
+
 #include <linux/config.h>
-#include <linux/errno.h>
 #include <linux/module.h>
-#include <linux/init.h>
 #include <linux/sched.h>
+#include <linux/init.h>
+#include <asm/atomic.h>
+#include <asm/semaphore.h>
+#include <asm/errno.h>
 
-#ifdef CONFIG_CPU_HAS_LLDSCD
-/*
- * On machines without lld/scd we need a spinlock to make the manipulation of
- * sem->count and sem->waking atomic.  Scalability isn't an issue because
- * this lock is used on UP only so it's just an empty variable.
- */
-spinlock_t semaphore_lock = SPIN_LOCK_UNLOCKED;
-
-EXPORT_SYMBOL(semaphore_lock);
-#endif
+#ifdef CONFIG_CPU_HAS_LLSC
 
 /*
- * Semaphores are implemented using a two-way counter: The "count" variable is
- * decremented for each process that tries to sleep, while the "waking" variable
- * is incremented when the "up()" code goes to wake up waiting processes.
- *
- * Notably, the inline "up()" and "down()" functions can efficiently test if
- * they need to do any extra work (up needs to do something only if count was
- * negative before the increment operation.
- *
- * waking_non_zero() must execute atomically.
- *
- * When __up() is called, the count was negative before incrementing it, and we
- * need to wake up somebody.
+ * Atomically update sem->count.
+ * This does the equivalent of the following:
  *
- * This routine adds one to the count of processes that need to wake up and
- * exit.  ALL waiting processes actually wake up but only the one that gets to
- * the "waking" field first will gate through and acquire the semaphore.  The
- * others will go back to sleep.
- *
- * Note that these functions are only called when there is contention on the
- * lock, and as such all this is the "non-critical" part of the whole semaphore
- * business. The critical part is the inline stuff in <asm/semaphore.h> where
- * we want to avoid any extra jumps and calls.
+ *	old_count = sem->count;
+ *	tmp = MAX(old_count, 0) + incr;
+ *	sem->count = tmp;
+ *	return old_count;
  */
-void __up_wakeup(struct semaphore *sem)
-{
-	wake_up(&sem->wait);
-}
-
-EXPORT_SYMBOL(__up_wakeup);
-
-#ifdef CONFIG_CPU_HAS_LLSC
-
-static inline int waking_non_zero(struct semaphore *sem)
+static inline int __sem_update_count(struct semaphore *sem, int incr)
 {
-	int ret, tmp;
+	int old_count, tmp;
 
 	__asm__ __volatile__(
-	"1:	ll	%1, %2			# waking_non_zero	\n"
-	"	blez	%1, 2f						\n"
-	"	subu	%0, %1, 1					\n"
-	"	sc	%0, %2						\n"
-	"	beqz	%0, 1b						\n"
-	"2:								\n"
-	: "=r" (ret), "=r" (tmp), "+m" (sem->waking)
-	: "0" (0));
+	"1:	ll	%0, %2					\n"
+	"	sra	%1, %0, 31				\n"
+	"	not	%1					\n"
+	"	and	%1, %0, %1				\n"
+	"	add	%1, %1, %3				\n"
+	"	sc	%1, %2					\n"
+	"	beqz	%1, 1b					\n"
+	: "=&r" (old_count), "=&r" (tmp), "=m" (sem->count)
+	: "r" (incr), "m" (sem->count));
 
-	return ret;
+	return old_count;
 }
 
-#else /* !CONFIG_CPU_HAS_LLSC */
+#else
+
+/*
+ * On machines without lld/scd we need a spinlock to make the manipulation of
+ * sem->count and sem->waking atomic.  Scalability isn't an issue because
+ * this lock is used on UP only so it's just an empty variable.
+ */
+static spinlock_t semaphore_lock = SPIN_LOCK_UNLOCKED;
 
-static inline int waking_non_zero(struct semaphore *sem)
+static inline int __sem_update_count(struct semaphore *sem, int incr)
 {
 	unsigned long flags;
-	int waking, ret = 0;
+	int old_count, tmp;
 
 	spin_lock_irqsave(&semaphore_lock, flags);
-	waking = atomic_read(&sem->waking);
-	if (waking > 0) {
-		atomic_set(&sem->waking, waking - 1);
-		ret = 1;
-	}
+	old_count = atomic_read(&sem->count);
+	tmp = max_t(int, old_count, 0) + incr;
+	atomic_set(&sem->count, tmp);
 	spin_unlock_irqrestore(&semaphore_lock, flags);
 
-	return ret;
+	return old_count;
 }
 
-#endif /* !CONFIG_CPU_HAS_LLSC */
-
-/*
- * Perform the "down" function.  Return zero for semaphore acquired, return
- * negative for signalled out of the function.
- *
- * If called from down, the return is ignored and the wait loop is not
- * interruptible.  This means that a task waiting on a semaphore using "down()"
- * cannot be killed until someone does an "up()" on the semaphore.
- *
- * If called from down_interruptible, the return value gets checked upon return.
- * If the return value is negative then the task continues with the negative
- * value in the return register (it can be tested by the caller).
- *
- * Either form may be used in conjunction with "up()".
- */
+#endif
 
-void __sched __down_failed(struct semaphore * sem)
+void __up(struct semaphore *sem)
 {
-	struct task_struct *tsk = current;
-	wait_queue_t wait;
-
-	init_waitqueue_entry(&wait, tsk);
-	__set_current_state(TASK_UNINTERRUPTIBLE);
-	add_wait_queue_exclusive(&sem->wait, &wait);
-
 	/*
-	 * Ok, we're set up.  sem->count is known to be less than zero
-	 * so we must wait.
-	 *
-	 * We can let go the lock for purposes of waiting.
-	 * We re-acquire it after awaking so as to protect
-	 * all semaphore operations.
-	 *
-	 * If "up()" is called before we call waking_non_zero() then
-	 * we will catch it right away.  If it is called later then
-	 * we will have to go through a wakeup cycle to catch it.
-	 *
-	 * Multiple waiters contend for the semaphore lock to see
-	 * who gets to gate through and who has to wait some more.
+	 * Note that we incremented count in up() before we came here,
+	 * but that was ineffective since the result was <= 0, and
+	 * any negative value of count is equivalent to 0.
+	 * This ends up setting count to 1, unless count is now > 0
+	 * (i.e. because some other cpu has called up() in the meantime),
+	 * in which case we just increment count.
 	 */
-	for (;;) {
-		if (waking_non_zero(sem))
-			break;
-		schedule();
-		__set_current_state(TASK_UNINTERRUPTIBLE);
-	}
-	__set_current_state(TASK_RUNNING);
-	remove_wait_queue(&sem->wait, &wait);
+	__sem_update_count(sem, 1);
+	wake_up(&sem->wait);
 }
 
-EXPORT_SYMBOL(__down_failed);
-
-#ifdef CONFIG_CPU_HAS_LLDSCD
+EXPORT_SYMBOL(__up);
 
 /*
- * waking_non_zero_interruptible:
- *	1	got the lock
- *	0	go to sleep
- *	-EINTR	interrupted
- *
- * We must undo the sem->count down_interruptible decrement
- * simultaneously and atomically with the sem->waking adjustment,
- * otherwise we can race with wake_one_more.
- *
- * This is accomplished by doing a 64-bit lld/scd on the 2 32-bit words.
- *
- * This is crazy.  Normally it's strictly forbidden to use 64-bit operations
- * in the 32-bit MIPS kernel.  In this case it's however ok because if an
- * interrupt has destroyed the upper half of registers sc will fail.
- * Note also that this will not work for MIPS32 CPUs!
- *
- * Pseudocode:
- *
- * If(sem->waking > 0) {
- *	Decrement(sem->waking)
- *	Return(SUCCESS)
- * } else If(signal_pending(tsk)) {
- *	Increment(sem->count)
- *	Return(-EINTR)
- * } else {
- *	Return(SLEEP)
- * }
+ * Note that when we come in to __down or __down_interruptible,
+ * we have already decremented count, but that decrement was
+ * ineffective since the result was < 0, and any negative value
+ * of count is equivalent to 0.
+ * Thus it is only when we decrement count from some value > 0
+ * that we have actually got the semaphore.
  */
-
-static inline int
-waking_non_zero_interruptible(struct semaphore *sem, struct task_struct *tsk)
+void __sched __down(struct semaphore *sem)
 {
-	long ret, tmp;
-
-	__asm__ __volatile__(
-	"	.set	push		# waking_non_zero_interruptible	\n"
-	"	.set	mips3						\n"
-	"	.set	noat						\n"
-	"0:	lld	%1, %2						\n"
-	"	li	%0, 0						\n"
-	"	sll	$1, %1, 0					\n"
-	"	blez	$1, 1f						\n"
-	"	daddiu	%1, %1, -1					\n"
-	"	li	%0, 1						\n"
-	"	b	2f						\n"
-	"1:	beqz	%3, 2f						\n"
-	"	li	%0, %4						\n"
-	"	dli	$1, 0x0000000100000000				\n"
-	"	daddu	%1, %1, $1					\n"
-	"2:	scd	%1, %2						\n"
-	"	beqz	%1, 0b						\n"
-	"	.set	pop						\n"
-	: "=&r" (ret), "=&r" (tmp), "=m" (*sem)
-	: "r" (signal_pending(tsk)), "i" (-EINTR));
-
-	return ret;
-}
-
-#else /* !CONFIG_CPU_HAS_LLDSCD */
-
-static inline int waking_non_zero_interruptible(struct semaphore *sem,
-						struct task_struct *tsk)
-{
-	int waking, pending, ret = 0;
-	unsigned long flags;
+	struct task_struct *tsk = current;
+	DECLARE_WAITQUEUE(wait, tsk);
 
-	pending = signal_pending(tsk);
+	__set_task_state(tsk, TASK_UNINTERRUPTIBLE);
+	add_wait_queue_exclusive(&sem->wait, &wait);
 
-	spin_lock_irqsave(&semaphore_lock, flags);
-	waking = atomic_read(&sem->waking);
-	if (waking > 0) {
-		atomic_set(&sem->waking, waking - 1);
-		ret = 1;
-	} else if (pending) {
-		atomic_set(&sem->count, atomic_read(&sem->count) + 1);
-		ret = -EINTR;
+	/*
+	 * Try to get the semaphore.  If the count is > 0, then we've
+	 * got the semaphore; we decrement count and exit the loop.
+	 * If the count is 0 or negative, we set it to -1, indicating
+	 * that we are asleep, and then sleep.
+	 */
+	while (__sem_update_count(sem, -1) <= 0) {
+		schedule();
+		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
 	}
-	spin_unlock_irqrestore(&semaphore_lock, flags);
+	remove_wait_queue(&sem->wait, &wait);
+	__set_task_state(tsk, TASK_RUNNING);
 
-	return ret;
+	/*
+	 * If there are any more sleepers, wake one of them up so
+	 * that it can either get the semaphore, or set count to -1
+	 * indicating that there are still processes sleeping.
+	 */
+	wake_up(&sem->wait);
 }
 
-#endif /* !CONFIG_CPU_HAS_LLDSCD */
+EXPORT_SYMBOL(__down);
 
-int __sched __down_failed_interruptible(struct semaphore * sem)
+int __sched __down_interruptible(struct semaphore * sem)
 {
+	int retval = 0;
 	struct task_struct *tsk = current;
-	wait_queue_t wait;
-	int ret = 0;
+	DECLARE_WAITQUEUE(wait, tsk);
 
-	init_waitqueue_entry(&wait, tsk);
-	__set_current_state(TASK_INTERRUPTIBLE);
+	__set_task_state(tsk, TASK_INTERRUPTIBLE);
 	add_wait_queue_exclusive(&sem->wait, &wait);
 
-	/*
-	 * Ok, we're set up.  sem->count is known to be less than zero
-	 * so we must wait.
-	 *
-	 * We can let go the lock for purposes of waiting.
-	 * We re-acquire it after awaking so as to protect
-	 * all semaphore operations.
-	 *
-	 * If "up()" is called before we call waking_non_zero() then
-	 * we will catch it right away.  If it is called later then
-	 * we will have to go through a wakeup cycle to catch it.
-	 *
-	 * Multiple waiters contend for the semaphore lock to see
-	 * who gets to gate through and who has to wait some more.
-	 */
-	for (;;) {
-		ret = waking_non_zero_interruptible(sem, tsk);
-		if (ret) {
-			if (ret == 1)
-				/* ret != 0 only if we get interrupted -arca */
-				ret = 0;
+	while (__sem_update_count(sem, -1) <= 0) {
+		if (signal_pending(current)) {
+			/*
+			 * A signal is pending - give up trying.
+			 * Set sem->count to 0 if it is negative,
+			 * since we are no longer sleeping.
+			 */
+			__sem_update_count(sem, 0);
+			retval = -EINTR;
 			break;
 		}
 		schedule();
-		__set_current_state(TASK_INTERRUPTIBLE);
+		set_task_state(tsk, TASK_INTERRUPTIBLE);
 	}
-	__set_current_state(TASK_RUNNING);
 	remove_wait_queue(&sem->wait, &wait);
+	__set_task_state(tsk, TASK_RUNNING);
 
-	return ret;
+	wake_up(&sem->wait);
+	return retval;
 }
 
-EXPORT_SYMBOL(__down_failed_interruptible);
+EXPORT_SYMBOL(__down_interruptible);
