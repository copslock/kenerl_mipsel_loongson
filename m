Return-Path: <SRS0=ULQD=RZ=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1168C10F0E
	for <linux-mips@archiver.kernel.org>; Fri, 22 Mar 2019 14:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52B27218E2
	for <linux-mips@archiver.kernel.org>; Fri, 22 Mar 2019 14:30:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728960AbfCVOa1 (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 22 Mar 2019 10:30:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54508 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727964AbfCVOa0 (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Fri, 22 Mar 2019 10:30:26 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CF4D458597;
        Fri, 22 Mar 2019 14:30:24 +0000 (UTC)
Received: from llong.com (dhcp-17-47.bos.redhat.com [10.18.17.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 61CFA60BF2;
        Fri, 22 Mar 2019 14:30:21 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        uclinux-h8-devel@lists.sourceforge.jp,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        linux-arch@vger.kernel.org, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v5 1/3] locking/rwsem: Remove arch specific rwsem files
Date:   Fri, 22 Mar 2019 10:30:06 -0400
Message-Id: <20190322143008.21313-2-longman@redhat.com>
In-Reply-To: <20190322143008.21313-1-longman@redhat.com>
References: <20190322143008.21313-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Fri, 22 Mar 2019 14:30:25 +0000 (UTC)
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

As the generic rwsem-xadd code is using the appropriate acquire and
release versions of the atomic operations, the arch specific rwsem.h
files will not be that much faster than the generic code as long as the
atomic functions are properly implemented. So we can remove those arch
specific rwsem.h and stop building asm/rwsem.h to reduce maintenance
effort.

Currently, only x86, alpha and ia64 have implemented architecture
specific fast paths. I don't have access to alpha and ia64 systems for
testing, but they are legacy systems that are not likely to be updated
to the latest kernel anyway.

By using a rwsem microbenchmark, the total locking rates on a 4-socket
56-core 112-thread x86-64 system before and after the patch were as
follows (mixed means equal # of read and write locks):

                      Before Patch              After Patch
   # of Threads  wlock   rlock   mixed     wlock   rlock   mixed
   ------------  -----   -----   -----     -----   -----   -----
        1        29,201  30,143  29,458    28,615  30,172  29,201
        2         6,807  13,299   1,171     7,725  15,025   1,804
        4         6,504  12,755   1,520     7,127  14,286   1,345
        8         6,762  13,412     764     6,826  13,652     726
       16         6,693  15,408     662     6,599  15,938     626
       32         6,145  15,286     496     5,549  15,487     511
       64         5,812  15,495      60     5,858  15,572      60

There were some run-to-run variations for the multi-thread tests. For
x86-64, using the generic C code fast path seems to be a little bit
faster than the assembly version with low lock contention.  Looking at
the assembly version of the fast paths, there are assembly to/from C
code wrappers that save and restore all the callee-clobbered registers
(7 registers on x86-64). The assembly generated from the generic C
code doesn't need to do that. That may explain the slight performance
gain here.

The generic asm rwsem.h can also be merged into kernel/locking/rwsem.h
with no code change as no other code other than those under
kernel/locking needs to access the internal rwsem macros and functions.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 MAINTAINERS                     |   1 -
 arch/alpha/include/asm/rwsem.h  | 211 ----------------------------
 arch/arm/include/asm/Kbuild     |   1 -
 arch/arm64/include/asm/Kbuild   |   1 -
 arch/hexagon/include/asm/Kbuild |   1 -
 arch/ia64/include/asm/rwsem.h   | 172 -----------------------
 arch/powerpc/include/asm/Kbuild |   1 -
 arch/s390/include/asm/Kbuild    |   1 -
 arch/sh/include/asm/Kbuild      |   1 -
 arch/sparc/include/asm/Kbuild   |   1 -
 arch/x86/include/asm/rwsem.h    | 237 --------------------------------
 arch/x86/lib/Makefile           |   1 -
 arch/x86/lib/rwsem.S            | 156 ---------------------
 arch/x86/um/Makefile            |   1 -
 arch/xtensa/include/asm/Kbuild  |   1 -
 include/asm-generic/rwsem.h     | 140 -------------------
 include/linux/rwsem.h           |   4 +-
 kernel/locking/percpu-rwsem.c   |   2 +
 kernel/locking/rwsem.h          | 130 ++++++++++++++++++
 19 files changed, 133 insertions(+), 930 deletions(-)
 delete mode 100644 arch/alpha/include/asm/rwsem.h
 delete mode 100644 arch/ia64/include/asm/rwsem.h
 delete mode 100644 arch/x86/include/asm/rwsem.h
 delete mode 100644 arch/x86/lib/rwsem.S
 delete mode 100644 include/asm-generic/rwsem.h

diff --git a/MAINTAINERS b/MAINTAINERS
index e17ebf70b548..6bfd5a94c08e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9089,7 +9089,6 @@ F:	arch/*/include/asm/spinlock*.h
 F:	include/linux/rwlock*.h
 F:	include/linux/mutex*.h
 F:	include/linux/rwsem*.h
-F:	arch/*/include/asm/rwsem.h
 F:	include/linux/seqlock.h
 F:	lib/locking*.[ch]
 F:	kernel/locking/
diff --git a/arch/alpha/include/asm/rwsem.h b/arch/alpha/include/asm/rwsem.h
deleted file mode 100644
index cf8fc8f9a2ed..000000000000
--- a/arch/alpha/include/asm/rwsem.h
+++ /dev/null
@@ -1,211 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ALPHA_RWSEM_H
-#define _ALPHA_RWSEM_H
-
-/*
- * Written by Ivan Kokshaysky <ink@jurassic.park.msu.ru>, 2001.
- * Based on asm-alpha/semaphore.h and asm-i386/rwsem.h
- */
-
-#ifndef _LINUX_RWSEM_H
-#error "please don't include asm/rwsem.h directly, use linux/rwsem.h instead"
-#endif
-
-#ifdef __KERNEL__
-
-#include <linux/compiler.h>
-
-#define RWSEM_UNLOCKED_VALUE		0x0000000000000000L
-#define RWSEM_ACTIVE_BIAS		0x0000000000000001L
-#define RWSEM_ACTIVE_MASK		0x00000000ffffffffL
-#define RWSEM_WAITING_BIAS		(-0x0000000100000000L)
-#define RWSEM_ACTIVE_READ_BIAS		RWSEM_ACTIVE_BIAS
-#define RWSEM_ACTIVE_WRITE_BIAS		(RWSEM_WAITING_BIAS + RWSEM_ACTIVE_BIAS)
-
-static inline int ___down_read(struct rw_semaphore *sem)
-{
-	long oldcount;
-#ifndef	CONFIG_SMP
-	oldcount = sem->count.counter;
-	sem->count.counter += RWSEM_ACTIVE_READ_BIAS;
-#else
-	long temp;
-	__asm__ __volatile__(
-	"1:	ldq_l	%0,%1\n"
-	"	addq	%0,%3,%2\n"
-	"	stq_c	%2,%1\n"
-	"	beq	%2,2f\n"
-	"	mb\n"
-	".subsection 2\n"
-	"2:	br	1b\n"
-	".previous"
-	:"=&r" (oldcount), "=m" (sem->count), "=&r" (temp)
-	:"Ir" (RWSEM_ACTIVE_READ_BIAS), "m" (sem->count) : "memory");
-#endif
-	return (oldcount < 0);
-}
-
-static inline void __down_read(struct rw_semaphore *sem)
-{
-	if (unlikely(___down_read(sem)))
-		rwsem_down_read_failed(sem);
-}
-
-static inline int __down_read_killable(struct rw_semaphore *sem)
-{
-	if (unlikely(___down_read(sem)))
-		if (IS_ERR(rwsem_down_read_failed_killable(sem)))
-			return -EINTR;
-
-	return 0;
-}
-
-/*
- * trylock for reading -- returns 1 if successful, 0 if contention
- */
-static inline int __down_read_trylock(struct rw_semaphore *sem)
-{
-	long old, new, res;
-
-	res = atomic_long_read(&sem->count);
-	do {
-		new = res + RWSEM_ACTIVE_READ_BIAS;
-		if (new <= 0)
-			break;
-		old = res;
-		res = atomic_long_cmpxchg(&sem->count, old, new);
-	} while (res != old);
-	return res >= 0 ? 1 : 0;
-}
-
-static inline long ___down_write(struct rw_semaphore *sem)
-{
-	long oldcount;
-#ifndef	CONFIG_SMP
-	oldcount = sem->count.counter;
-	sem->count.counter += RWSEM_ACTIVE_WRITE_BIAS;
-#else
-	long temp;
-	__asm__ __volatile__(
-	"1:	ldq_l	%0,%1\n"
-	"	addq	%0,%3,%2\n"
-	"	stq_c	%2,%1\n"
-	"	beq	%2,2f\n"
-	"	mb\n"
-	".subsection 2\n"
-	"2:	br	1b\n"
-	".previous"
-	:"=&r" (oldcount), "=m" (sem->count), "=&r" (temp)
-	:"Ir" (RWSEM_ACTIVE_WRITE_BIAS), "m" (sem->count) : "memory");
-#endif
-	return oldcount;
-}
-
-static inline void __down_write(struct rw_semaphore *sem)
-{
-	if (unlikely(___down_write(sem)))
-		rwsem_down_write_failed(sem);
-}
-
-static inline int __down_write_killable(struct rw_semaphore *sem)
-{
-	if (unlikely(___down_write(sem))) {
-		if (IS_ERR(rwsem_down_write_failed_killable(sem)))
-			return -EINTR;
-	}
-
-	return 0;
-}
-
-/*
- * trylock for writing -- returns 1 if successful, 0 if contention
- */
-static inline int __down_write_trylock(struct rw_semaphore *sem)
-{
-	long ret = atomic_long_cmpxchg(&sem->count, RWSEM_UNLOCKED_VALUE,
-			   RWSEM_ACTIVE_WRITE_BIAS);
-	if (ret == RWSEM_UNLOCKED_VALUE)
-		return 1;
-	return 0;
-}
-
-static inline void __up_read(struct rw_semaphore *sem)
-{
-	long oldcount;
-#ifndef	CONFIG_SMP
-	oldcount = sem->count.counter;
-	sem->count.counter -= RWSEM_ACTIVE_READ_BIAS;
-#else
-	long temp;
-	__asm__ __volatile__(
-	"	mb\n"
-	"1:	ldq_l	%0,%1\n"
-	"	subq	%0,%3,%2\n"
-	"	stq_c	%2,%1\n"
-	"	beq	%2,2f\n"
-	".subsection 2\n"
-	"2:	br	1b\n"
-	".previous"
-	:"=&r" (oldcount), "=m" (sem->count), "=&r" (temp)
-	:"Ir" (RWSEM_ACTIVE_READ_BIAS), "m" (sem->count) : "memory");
-#endif
-	if (unlikely(oldcount < 0))
-		if ((int)oldcount - RWSEM_ACTIVE_READ_BIAS == 0)
-			rwsem_wake(sem);
-}
-
-static inline void __up_write(struct rw_semaphore *sem)
-{
-	long count;
-#ifndef	CONFIG_SMP
-	sem->count.counter -= RWSEM_ACTIVE_WRITE_BIAS;
-	count = sem->count.counter;
-#else
-	long temp;
-	__asm__ __volatile__(
-	"	mb\n"
-	"1:	ldq_l	%0,%1\n"
-	"	subq	%0,%3,%2\n"
-	"	stq_c	%2,%1\n"
-	"	beq	%2,2f\n"
-	"	subq	%0,%3,%0\n"
-	".subsection 2\n"
-	"2:	br	1b\n"
-	".previous"
-	:"=&r" (count), "=m" (sem->count), "=&r" (temp)
-	:"Ir" (RWSEM_ACTIVE_WRITE_BIAS), "m" (sem->count) : "memory");
-#endif
-	if (unlikely(count))
-		if ((int)count == 0)
-			rwsem_wake(sem);
-}
-
-/*
- * downgrade write lock to read lock
- */
-static inline void __downgrade_write(struct rw_semaphore *sem)
-{
-	long oldcount;
-#ifndef	CONFIG_SMP
-	oldcount = sem->count.counter;
-	sem->count.counter -= RWSEM_WAITING_BIAS;
-#else
-	long temp;
-	__asm__ __volatile__(
-	"1:	ldq_l	%0,%1\n"
-	"	addq	%0,%3,%2\n"
-	"	stq_c	%2,%1\n"
-	"	beq	%2,2f\n"
-	"	mb\n"
-	".subsection 2\n"
-	"2:	br	1b\n"
-	".previous"
-	:"=&r" (oldcount), "=m" (sem->count), "=&r" (temp)
-	:"Ir" (-RWSEM_WAITING_BIAS), "m" (sem->count) : "memory");
-#endif
-	if (unlikely(oldcount < 0))
-		rwsem_downgrade_wake(sem);
-}
-
-#endif /* __KERNEL__ */
-#endif /* _ALPHA_RWSEM_H */
diff --git a/arch/arm/include/asm/Kbuild b/arch/arm/include/asm/Kbuild
index a8a4eb7f6dae..8fb51b7bf1d5 100644
--- a/arch/arm/include/asm/Kbuild
+++ b/arch/arm/include/asm/Kbuild
@@ -12,7 +12,6 @@ generic-y += mm-arch-hooks.h
 generic-y += msi.h
 generic-y += parport.h
 generic-y += preempt.h
-generic-y += rwsem.h
 generic-y += seccomp.h
 generic-y += segment.h
 generic-y += serial.h
diff --git a/arch/arm64/include/asm/Kbuild b/arch/arm64/include/asm/Kbuild
index 1e17ea5c372b..60a933b07001 100644
--- a/arch/arm64/include/asm/Kbuild
+++ b/arch/arm64/include/asm/Kbuild
@@ -16,7 +16,6 @@ generic-y += mm-arch-hooks.h
 generic-y += msi.h
 generic-y += qrwlock.h
 generic-y += qspinlock.h
-generic-y += rwsem.h
 generic-y += segment.h
 generic-y += serial.h
 generic-y += set_memory.h
diff --git a/arch/hexagon/include/asm/Kbuild b/arch/hexagon/include/asm/Kbuild
index b25fd42aa0f4..0a12feb41777 100644
--- a/arch/hexagon/include/asm/Kbuild
+++ b/arch/hexagon/include/asm/Kbuild
@@ -26,7 +26,6 @@ generic-y += mm-arch-hooks.h
 generic-y += pci.h
 generic-y += percpu.h
 generic-y += preempt.h
-generic-y += rwsem.h
 generic-y += sections.h
 generic-y += segment.h
 generic-y += serial.h
diff --git a/arch/ia64/include/asm/rwsem.h b/arch/ia64/include/asm/rwsem.h
deleted file mode 100644
index 917910607e0e..000000000000
--- a/arch/ia64/include/asm/rwsem.h
+++ /dev/null
@@ -1,172 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * R/W semaphores for ia64
- *
- * Copyright (C) 2003 Ken Chen <kenneth.w.chen@intel.com>
- * Copyright (C) 2003 Asit Mallick <asit.k.mallick@intel.com>
- * Copyright (C) 2005 Christoph Lameter <cl@linux.com>
- *
- * Based on asm-i386/rwsem.h and other architecture implementation.
- *
- * The MSW of the count is the negated number of active writers and
- * waiting lockers, and the LSW is the total number of active locks.
- *
- * The lock count is initialized to 0 (no active and no waiting lockers).
- *
- * When a writer subtracts WRITE_BIAS, it'll get 0xffffffff00000001 for
- * the case of an uncontended lock. Readers increment by 1 and see a positive
- * value when uncontended, negative if there are writers (and maybe) readers
- * waiting (in which case it goes to sleep).
- */
-
-#ifndef _ASM_IA64_RWSEM_H
-#define _ASM_IA64_RWSEM_H
-
-#ifndef _LINUX_RWSEM_H
-#error "Please don't include <asm/rwsem.h> directly, use <linux/rwsem.h> instead."
-#endif
-
-#include <asm/intrinsics.h>
-
-#define RWSEM_UNLOCKED_VALUE		__IA64_UL_CONST(0x0000000000000000)
-#define RWSEM_ACTIVE_BIAS		(1L)
-#define RWSEM_ACTIVE_MASK		(0xffffffffL)
-#define RWSEM_WAITING_BIAS		(-0x100000000L)
-#define RWSEM_ACTIVE_READ_BIAS		RWSEM_ACTIVE_BIAS
-#define RWSEM_ACTIVE_WRITE_BIAS		(RWSEM_WAITING_BIAS + RWSEM_ACTIVE_BIAS)
-
-/*
- * lock for reading
- */
-static inline int
-___down_read (struct rw_semaphore *sem)
-{
-	long result = ia64_fetchadd8_acq((unsigned long *)&sem->count.counter, 1);
-
-	return (result < 0);
-}
-
-static inline void
-__down_read (struct rw_semaphore *sem)
-{
-	if (___down_read(sem))
-		rwsem_down_read_failed(sem);
-}
-
-static inline int
-__down_read_killable (struct rw_semaphore *sem)
-{
-	if (___down_read(sem))
-		if (IS_ERR(rwsem_down_read_failed_killable(sem)))
-			return -EINTR;
-
-	return 0;
-}
-
-/*
- * lock for writing
- */
-static inline long
-___down_write (struct rw_semaphore *sem)
-{
-	long old, new;
-
-	do {
-		old = atomic_long_read(&sem->count);
-		new = old + RWSEM_ACTIVE_WRITE_BIAS;
-	} while (atomic_long_cmpxchg_acquire(&sem->count, old, new) != old);
-
-	return old;
-}
-
-static inline void
-__down_write (struct rw_semaphore *sem)
-{
-	if (___down_write(sem))
-		rwsem_down_write_failed(sem);
-}
-
-static inline int
-__down_write_killable (struct rw_semaphore *sem)
-{
-	if (___down_write(sem)) {
-		if (IS_ERR(rwsem_down_write_failed_killable(sem)))
-			return -EINTR;
-	}
-
-	return 0;
-}
-
-/*
- * unlock after reading
- */
-static inline void
-__up_read (struct rw_semaphore *sem)
-{
-	long result = ia64_fetchadd8_rel((unsigned long *)&sem->count.counter, -1);
-
-	if (result < 0 && (--result & RWSEM_ACTIVE_MASK) == 0)
-		rwsem_wake(sem);
-}
-
-/*
- * unlock after writing
- */
-static inline void
-__up_write (struct rw_semaphore *sem)
-{
-	long old, new;
-
-	do {
-		old = atomic_long_read(&sem->count);
-		new = old - RWSEM_ACTIVE_WRITE_BIAS;
-	} while (atomic_long_cmpxchg_release(&sem->count, old, new) != old);
-
-	if (new < 0 && (new & RWSEM_ACTIVE_MASK) == 0)
-		rwsem_wake(sem);
-}
-
-/*
- * trylock for reading -- returns 1 if successful, 0 if contention
- */
-static inline int
-__down_read_trylock (struct rw_semaphore *sem)
-{
-	long tmp;
-	while ((tmp = atomic_long_read(&sem->count)) >= 0) {
-		if (tmp == atomic_long_cmpxchg_acquire(&sem->count, tmp, tmp+1)) {
-			return 1;
-		}
-	}
-	return 0;
-}
-
-/*
- * trylock for writing -- returns 1 if successful, 0 if contention
- */
-static inline int
-__down_write_trylock (struct rw_semaphore *sem)
-{
-	long tmp = atomic_long_cmpxchg_acquire(&sem->count,
-			RWSEM_UNLOCKED_VALUE, RWSEM_ACTIVE_WRITE_BIAS);
-	return tmp == RWSEM_UNLOCKED_VALUE;
-}
-
-/*
- * downgrade write lock to read lock
- */
-static inline void
-__downgrade_write (struct rw_semaphore *sem)
-{
-	long old, new;
-
-	do {
-		old = atomic_long_read(&sem->count);
-		new = old - RWSEM_WAITING_BIAS;
-	} while (atomic_long_cmpxchg_release(&sem->count, old, new) != old);
-
-	if (old < 0)
-		rwsem_downgrade_wake(sem);
-}
-
-#endif /* _ASM_IA64_RWSEM_H */
diff --git a/arch/powerpc/include/asm/Kbuild b/arch/powerpc/include/asm/Kbuild
index a0c132bedfae..36bda391e549 100644
--- a/arch/powerpc/include/asm/Kbuild
+++ b/arch/powerpc/include/asm/Kbuild
@@ -8,6 +8,5 @@ generic-y += irq_regs.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
 generic-y += preempt.h
-generic-y += rwsem.h
 generic-y += vtime.h
 generic-y += msi.h
diff --git a/arch/s390/include/asm/Kbuild b/arch/s390/include/asm/Kbuild
index 12d77cb11fe5..d5fadefea33c 100644
--- a/arch/s390/include/asm/Kbuild
+++ b/arch/s390/include/asm/Kbuild
@@ -20,7 +20,6 @@ generic-y += local.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
 generic-y += mm-arch-hooks.h
-generic-y += rwsem.h
 generic-y += trace_clock.h
 generic-y += unaligned.h
 generic-y += word-at-a-time.h
diff --git a/arch/sh/include/asm/Kbuild b/arch/sh/include/asm/Kbuild
index a6ef3fee5f85..b89fce40878b 100644
--- a/arch/sh/include/asm/Kbuild
+++ b/arch/sh/include/asm/Kbuild
@@ -16,7 +16,6 @@ generic-y += mm-arch-hooks.h
 generic-y += parport.h
 generic-y += percpu.h
 generic-y += preempt.h
-generic-y += rwsem.h
 generic-y += serial.h
 generic-y += sizes.h
 generic-y += trace_clock.h
diff --git a/arch/sparc/include/asm/Kbuild b/arch/sparc/include/asm/Kbuild
index b82f64e28f55..e843fc04d10b 100644
--- a/arch/sparc/include/asm/Kbuild
+++ b/arch/sparc/include/asm/Kbuild
@@ -17,7 +17,6 @@ generic-y += mm-arch-hooks.h
 generic-y += module.h
 generic-y += msi.h
 generic-y += preempt.h
-generic-y += rwsem.h
 generic-y += serial.h
 generic-y += trace_clock.h
 generic-y += word-at-a-time.h
diff --git a/arch/x86/include/asm/rwsem.h b/arch/x86/include/asm/rwsem.h
deleted file mode 100644
index 4c25cf6caefa..000000000000
--- a/arch/x86/include/asm/rwsem.h
+++ /dev/null
@@ -1,237 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* rwsem.h: R/W semaphores implemented using XADD/CMPXCHG for i486+
- *
- * Written by David Howells (dhowells@redhat.com).
- *
- * Derived from asm-x86/semaphore.h
- *
- *
- * The MSW of the count is the negated number of active writers and waiting
- * lockers, and the LSW is the total number of active locks
- *
- * The lock count is initialized to 0 (no active and no waiting lockers).
- *
- * When a writer subtracts WRITE_BIAS, it'll get 0xffff0001 for the case of an
- * uncontended lock. This can be determined because XADD returns the old value.
- * Readers increment by 1 and see a positive value when uncontended, negative
- * if there are writers (and maybe) readers waiting (in which case it goes to
- * sleep).
- *
- * The value of WAITING_BIAS supports up to 32766 waiting processes. This can
- * be extended to 65534 by manually checking the whole MSW rather than relying
- * on the S flag.
- *
- * The value of ACTIVE_BIAS supports up to 65535 active processes.
- *
- * This should be totally fair - if anything is waiting, a process that wants a
- * lock will go to the back of the queue. When the currently active lock is
- * released, if there's a writer at the front of the queue, then that and only
- * that will be woken up; if there's a bunch of consecutive readers at the
- * front, then they'll all be woken up, but no other readers will be.
- */
-
-#ifndef _ASM_X86_RWSEM_H
-#define _ASM_X86_RWSEM_H
-
-#ifndef _LINUX_RWSEM_H
-#error "please don't include asm/rwsem.h directly, use linux/rwsem.h instead"
-#endif
-
-#ifdef __KERNEL__
-#include <asm/asm.h>
-
-/*
- * The bias values and the counter type limits the number of
- * potential readers/writers to 32767 for 32 bits and 2147483647
- * for 64 bits.
- */
-
-#ifdef CONFIG_X86_64
-# define RWSEM_ACTIVE_MASK		0xffffffffL
-#else
-# define RWSEM_ACTIVE_MASK		0x0000ffffL
-#endif
-
-#define RWSEM_UNLOCKED_VALUE		0x00000000L
-#define RWSEM_ACTIVE_BIAS		0x00000001L
-#define RWSEM_WAITING_BIAS		(-RWSEM_ACTIVE_MASK-1)
-#define RWSEM_ACTIVE_READ_BIAS		RWSEM_ACTIVE_BIAS
-#define RWSEM_ACTIVE_WRITE_BIAS		(RWSEM_WAITING_BIAS + RWSEM_ACTIVE_BIAS)
-
-/*
- * lock for reading
- */
-#define ____down_read(sem, slow_path)					\
-({									\
-	struct rw_semaphore* ret;					\
-	asm volatile("# beginning down_read\n\t"			\
-		     LOCK_PREFIX _ASM_INC "(%[sem])\n\t"		\
-		     /* adds 0x00000001 */				\
-		     "  jns        1f\n"				\
-		     "  call " slow_path "\n"				\
-		     "1:\n\t"						\
-		     "# ending down_read\n\t"				\
-		     : "+m" (sem->count), "=a" (ret),			\
-			ASM_CALL_CONSTRAINT				\
-		     : [sem] "a" (sem)					\
-		     : "memory", "cc");					\
-	ret;								\
-})
-
-static inline void __down_read(struct rw_semaphore *sem)
-{
-	____down_read(sem, "call_rwsem_down_read_failed");
-}
-
-static inline int __down_read_killable(struct rw_semaphore *sem)
-{
-	if (IS_ERR(____down_read(sem, "call_rwsem_down_read_failed_killable")))
-		return -EINTR;
-	return 0;
-}
-
-/*
- * trylock for reading -- returns 1 if successful, 0 if contention
- */
-static inline bool __down_read_trylock(struct rw_semaphore *sem)
-{
-	long result, tmp;
-	asm volatile("# beginning __down_read_trylock\n\t"
-		     "  mov          %[count],%[result]\n\t"
-		     "1:\n\t"
-		     "  mov          %[result],%[tmp]\n\t"
-		     "  add          %[inc],%[tmp]\n\t"
-		     "  jle	     2f\n\t"
-		     LOCK_PREFIX "  cmpxchg  %[tmp],%[count]\n\t"
-		     "  jnz	     1b\n\t"
-		     "2:\n\t"
-		     "# ending __down_read_trylock\n\t"
-		     : [count] "+m" (sem->count), [result] "=&a" (result),
-		       [tmp] "=&r" (tmp)
-		     : [inc] "i" (RWSEM_ACTIVE_READ_BIAS)
-		     : "memory", "cc");
-	return result >= 0;
-}
-
-/*
- * lock for writing
- */
-#define ____down_write(sem, slow_path)			\
-({							\
-	long tmp;					\
-	struct rw_semaphore* ret;			\
-							\
-	asm volatile("# beginning down_write\n\t"	\
-		     LOCK_PREFIX "  xadd      %[tmp],(%[sem])\n\t"	\
-		     /* adds 0xffff0001, returns the old value */ \
-		     "  test " __ASM_SEL(%w1,%k1) "," __ASM_SEL(%w1,%k1) "\n\t" \
-		     /* was the active mask 0 before? */\
-		     "  jz        1f\n"			\
-		     "  call " slow_path "\n"		\
-		     "1:\n"				\
-		     "# ending down_write"		\
-		     : "+m" (sem->count), [tmp] "=d" (tmp),	\
-		       "=a" (ret), ASM_CALL_CONSTRAINT	\
-		     : [sem] "a" (sem), "[tmp]" (RWSEM_ACTIVE_WRITE_BIAS) \
-		     : "memory", "cc");			\
-	ret;						\
-})
-
-static inline void __down_write(struct rw_semaphore *sem)
-{
-	____down_write(sem, "call_rwsem_down_write_failed");
-}
-
-static inline int __down_write_killable(struct rw_semaphore *sem)
-{
-	if (IS_ERR(____down_write(sem, "call_rwsem_down_write_failed_killable")))
-		return -EINTR;
-
-	return 0;
-}
-
-/*
- * trylock for writing -- returns 1 if successful, 0 if contention
- */
-static inline bool __down_write_trylock(struct rw_semaphore *sem)
-{
-	bool result;
-	long tmp0, tmp1;
-	asm volatile("# beginning __down_write_trylock\n\t"
-		     "  mov          %[count],%[tmp0]\n\t"
-		     "1:\n\t"
-		     "  test " __ASM_SEL(%w1,%k1) "," __ASM_SEL(%w1,%k1) "\n\t"
-		     /* was the active mask 0 before? */
-		     "  jnz          2f\n\t"
-		     "  mov          %[tmp0],%[tmp1]\n\t"
-		     "  add          %[inc],%[tmp1]\n\t"
-		     LOCK_PREFIX "  cmpxchg  %[tmp1],%[count]\n\t"
-		     "  jnz	     1b\n\t"
-		     "2:\n\t"
-		     CC_SET(e)
-		     "# ending __down_write_trylock\n\t"
-		     : [count] "+m" (sem->count), [tmp0] "=&a" (tmp0),
-		       [tmp1] "=&r" (tmp1), CC_OUT(e) (result)
-		     : [inc] "er" (RWSEM_ACTIVE_WRITE_BIAS)
-		     : "memory");
-	return result;
-}
-
-/*
- * unlock after reading
- */
-static inline void __up_read(struct rw_semaphore *sem)
-{
-	long tmp;
-	asm volatile("# beginning __up_read\n\t"
-		     LOCK_PREFIX "  xadd      %[tmp],(%[sem])\n\t"
-		     /* subtracts 1, returns the old value */
-		     "  jns        1f\n\t"
-		     "  call call_rwsem_wake\n" /* expects old value in %edx */
-		     "1:\n"
-		     "# ending __up_read\n"
-		     : "+m" (sem->count), [tmp] "=d" (tmp)
-		     : [sem] "a" (sem), "[tmp]" (-RWSEM_ACTIVE_READ_BIAS)
-		     : "memory", "cc");
-}
-
-/*
- * unlock after writing
- */
-static inline void __up_write(struct rw_semaphore *sem)
-{
-	long tmp;
-	asm volatile("# beginning __up_write\n\t"
-		     LOCK_PREFIX "  xadd      %[tmp],(%[sem])\n\t"
-		     /* subtracts 0xffff0001, returns the old value */
-		     "  jns        1f\n\t"
-		     "  call call_rwsem_wake\n" /* expects old value in %edx */
-		     "1:\n\t"
-		     "# ending __up_write\n"
-		     : "+m" (sem->count), [tmp] "=d" (tmp)
-		     : [sem] "a" (sem), "[tmp]" (-RWSEM_ACTIVE_WRITE_BIAS)
-		     : "memory", "cc");
-}
-
-/*
- * downgrade write lock to read lock
- */
-static inline void __downgrade_write(struct rw_semaphore *sem)
-{
-	asm volatile("# beginning __downgrade_write\n\t"
-		     LOCK_PREFIX _ASM_ADD "%[inc],(%[sem])\n\t"
-		     /*
-		      * transitions 0xZZZZ0001 -> 0xYYYY0001 (i386)
-		      *     0xZZZZZZZZ00000001 -> 0xYYYYYYYY00000001 (x86_64)
-		      */
-		     "  jns       1f\n\t"
-		     "  call call_rwsem_downgrade_wake\n"
-		     "1:\n\t"
-		     "# ending __downgrade_write\n"
-		     : "+m" (sem->count)
-		     : [sem] "a" (sem), [inc] "er" (-RWSEM_WAITING_BIAS)
-		     : "memory", "cc");
-}
-
-#endif /* __KERNEL__ */
-#endif /* _ASM_X86_RWSEM_H */
diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
index 140e61843a07..986652064b15 100644
--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -23,7 +23,6 @@ obj-$(CONFIG_SMP) += msr-smp.o cache-smp.o
 lib-y := delay.o misc.o cmdline.o cpu.o
 lib-y += usercopy_$(BITS).o usercopy.o getuser.o putuser.o
 lib-y += memcpy_$(BITS).o
-lib-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) += rwsem.o
 lib-$(CONFIG_INSTRUCTION_DECODER) += insn.o inat.o insn-eval.o
 lib-$(CONFIG_RANDOMIZE_BASE) += kaslr.o
 lib-$(CONFIG_FUNCTION_ERROR_INJECTION)	+= error-inject.o
diff --git a/arch/x86/lib/rwsem.S b/arch/x86/lib/rwsem.S
deleted file mode 100644
index dc2ab6ea6768..000000000000
--- a/arch/x86/lib/rwsem.S
+++ /dev/null
@@ -1,156 +0,0 @@
-/*
- * x86 semaphore implementation.
- *
- * (C) Copyright 1999 Linus Torvalds
- *
- * Portions Copyright 1999 Red Hat, Inc.
- *
- *	This program is free software; you can redistribute it and/or
- *	modify it under the terms of the GNU General Public License
- *	as published by the Free Software Foundation; either version
- *	2 of the License, or (at your option) any later version.
- *
- * rw semaphores implemented November 1999 by Benjamin LaHaise <bcrl@kvack.org>
- */
-
-#include <linux/linkage.h>
-#include <asm/alternative-asm.h>
-#include <asm/frame.h>
-
-#define __ASM_HALF_REG(reg)	__ASM_SEL(reg, e##reg)
-#define __ASM_HALF_SIZE(inst)	__ASM_SEL(inst##w, inst##l)
-
-#ifdef CONFIG_X86_32
-
-/*
- * The semaphore operations have a special calling sequence that
- * allow us to do a simpler in-line version of them. These routines
- * need to convert that sequence back into the C sequence when
- * there is contention on the semaphore.
- *
- * %eax contains the semaphore pointer on entry. Save the C-clobbered
- * registers (%eax, %edx and %ecx) except %eax which is either a return
- * value or just gets clobbered. Same is true for %edx so make sure GCC
- * reloads it after the slow path, by making it hold a temporary, for
- * example see ____down_write().
- */
-
-#define save_common_regs \
-	pushl %ecx
-
-#define restore_common_regs \
-	popl %ecx
-
-	/* Avoid uglifying the argument copying x86-64 needs to do. */
-	.macro movq src, dst
-	.endm
-
-#else
-
-/*
- * x86-64 rwsem wrappers
- *
- * This interfaces the inline asm code to the slow-path
- * C routines. We need to save the call-clobbered regs
- * that the asm does not mark as clobbered, and move the
- * argument from %rax to %rdi.
- *
- * NOTE! We don't need to save %rax, because the functions
- * will always return the semaphore pointer in %rax (which
- * is also the input argument to these helpers)
- *
- * The following can clobber %rdx because the asm clobbers it:
- *   call_rwsem_down_write_failed
- *   call_rwsem_wake
- * but %rdi, %rsi, %rcx, %r8-r11 always need saving.
- */
-
-#define save_common_regs \
-	pushq %rdi; \
-	pushq %rsi; \
-	pushq %rcx; \
-	pushq %r8;  \
-	pushq %r9;  \
-	pushq %r10; \
-	pushq %r11
-
-#define restore_common_regs \
-	popq %r11; \
-	popq %r10; \
-	popq %r9; \
-	popq %r8; \
-	popq %rcx; \
-	popq %rsi; \
-	popq %rdi
-
-#endif
-
-/* Fix up special calling conventions */
-ENTRY(call_rwsem_down_read_failed)
-	FRAME_BEGIN
-	save_common_regs
-	__ASM_SIZE(push,) %__ASM_REG(dx)
-	movq %rax,%rdi
-	call rwsem_down_read_failed
-	__ASM_SIZE(pop,) %__ASM_REG(dx)
-	restore_common_regs
-	FRAME_END
-	ret
-ENDPROC(call_rwsem_down_read_failed)
-
-ENTRY(call_rwsem_down_read_failed_killable)
-	FRAME_BEGIN
-	save_common_regs
-	__ASM_SIZE(push,) %__ASM_REG(dx)
-	movq %rax,%rdi
-	call rwsem_down_read_failed_killable
-	__ASM_SIZE(pop,) %__ASM_REG(dx)
-	restore_common_regs
-	FRAME_END
-	ret
-ENDPROC(call_rwsem_down_read_failed_killable)
-
-ENTRY(call_rwsem_down_write_failed)
-	FRAME_BEGIN
-	save_common_regs
-	movq %rax,%rdi
-	call rwsem_down_write_failed
-	restore_common_regs
-	FRAME_END
-	ret
-ENDPROC(call_rwsem_down_write_failed)
-
-ENTRY(call_rwsem_down_write_failed_killable)
-	FRAME_BEGIN
-	save_common_regs
-	movq %rax,%rdi
-	call rwsem_down_write_failed_killable
-	restore_common_regs
-	FRAME_END
-	ret
-ENDPROC(call_rwsem_down_write_failed_killable)
-
-ENTRY(call_rwsem_wake)
-	FRAME_BEGIN
-	/* do nothing if still outstanding active readers */
-	__ASM_HALF_SIZE(dec) %__ASM_HALF_REG(dx)
-	jnz 1f
-	save_common_regs
-	movq %rax,%rdi
-	call rwsem_wake
-	restore_common_regs
-1:	FRAME_END
-	ret
-ENDPROC(call_rwsem_wake)
-
-ENTRY(call_rwsem_downgrade_wake)
-	FRAME_BEGIN
-	save_common_regs
-	__ASM_SIZE(push,) %__ASM_REG(dx)
-	movq %rax,%rdi
-	call rwsem_downgrade_wake
-	__ASM_SIZE(pop,) %__ASM_REG(dx)
-	restore_common_regs
-	FRAME_END
-	ret
-ENDPROC(call_rwsem_downgrade_wake)
diff --git a/arch/x86/um/Makefile b/arch/x86/um/Makefile
index 2d686ae54681..22554c585ced 100644
--- a/arch/x86/um/Makefile
+++ b/arch/x86/um/Makefile
@@ -21,7 +21,6 @@ obj-y += checksum_32.o syscalls_32.o
 obj-$(CONFIG_ELF_CORE) += elfcore.o
 
 subarch-y = ../lib/string_32.o ../lib/atomic64_32.o ../lib/atomic64_cx8_32.o
-subarch-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) += ../lib/rwsem.o
 
 else
 
diff --git a/arch/xtensa/include/asm/Kbuild b/arch/xtensa/include/asm/Kbuild
index 42b6cb3d16f7..ea97bdebfba7 100644
--- a/arch/xtensa/include/asm/Kbuild
+++ b/arch/xtensa/include/asm/Kbuild
@@ -24,7 +24,6 @@ generic-y += percpu.h
 generic-y += preempt.h
 generic-y += qrwlock.h
 generic-y += qspinlock.h
-generic-y += rwsem.h
 generic-y += sections.h
 generic-y += socket.h
 generic-y += topology.h
diff --git a/include/asm-generic/rwsem.h b/include/asm-generic/rwsem.h
deleted file mode 100644
index 93e67a055a4d..000000000000
--- a/include/asm-generic/rwsem.h
+++ /dev/null
@@ -1,140 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_GENERIC_RWSEM_H
-#define _ASM_GENERIC_RWSEM_H
-
-#ifndef _LINUX_RWSEM_H
-#error "Please don't include <asm/rwsem.h> directly, use <linux/rwsem.h> instead."
-#endif
-
-#ifdef __KERNEL__
-
-/*
- * R/W semaphores originally for PPC using the stuff in lib/rwsem.c.
- * Adapted largely from include/asm-i386/rwsem.h
- * by Paul Mackerras <paulus@samba.org>.
- */
-
-/*
- * the semaphore definition
- */
-#ifdef CONFIG_64BIT
-# define RWSEM_ACTIVE_MASK		0xffffffffL
-#else
-# define RWSEM_ACTIVE_MASK		0x0000ffffL
-#endif
-
-#define RWSEM_UNLOCKED_VALUE		0x00000000L
-#define RWSEM_ACTIVE_BIAS		0x00000001L
-#define RWSEM_WAITING_BIAS		(-RWSEM_ACTIVE_MASK-1)
-#define RWSEM_ACTIVE_READ_BIAS		RWSEM_ACTIVE_BIAS
-#define RWSEM_ACTIVE_WRITE_BIAS		(RWSEM_WAITING_BIAS + RWSEM_ACTIVE_BIAS)
-
-/*
- * lock for reading
- */
-static inline void __down_read(struct rw_semaphore *sem)
-{
-	if (unlikely(atomic_long_inc_return_acquire(&sem->count) <= 0))
-		rwsem_down_read_failed(sem);
-}
-
-static inline int __down_read_killable(struct rw_semaphore *sem)
-{
-	if (unlikely(atomic_long_inc_return_acquire(&sem->count) <= 0)) {
-		if (IS_ERR(rwsem_down_read_failed_killable(sem)))
-			return -EINTR;
-	}
-
-	return 0;
-}
-
-static inline int __down_read_trylock(struct rw_semaphore *sem)
-{
-	long tmp;
-
-	while ((tmp = atomic_long_read(&sem->count)) >= 0) {
-		if (tmp == atomic_long_cmpxchg_acquire(&sem->count, tmp,
-				   tmp + RWSEM_ACTIVE_READ_BIAS)) {
-			return 1;
-		}
-	}
-	return 0;
-}
-
-/*
- * lock for writing
- */
-static inline void __down_write(struct rw_semaphore *sem)
-{
-	long tmp;
-
-	tmp = atomic_long_add_return_acquire(RWSEM_ACTIVE_WRITE_BIAS,
-					     &sem->count);
-	if (unlikely(tmp != RWSEM_ACTIVE_WRITE_BIAS))
-		rwsem_down_write_failed(sem);
-}
-
-static inline int __down_write_killable(struct rw_semaphore *sem)
-{
-	long tmp;
-
-	tmp = atomic_long_add_return_acquire(RWSEM_ACTIVE_WRITE_BIAS,
-					     &sem->count);
-	if (unlikely(tmp != RWSEM_ACTIVE_WRITE_BIAS))
-		if (IS_ERR(rwsem_down_write_failed_killable(sem)))
-			return -EINTR;
-	return 0;
-}
-
-static inline int __down_write_trylock(struct rw_semaphore *sem)
-{
-	long tmp;
-
-	tmp = atomic_long_cmpxchg_acquire(&sem->count, RWSEM_UNLOCKED_VALUE,
-		      RWSEM_ACTIVE_WRITE_BIAS);
-	return tmp == RWSEM_UNLOCKED_VALUE;
-}
-
-/*
- * unlock after reading
- */
-static inline void __up_read(struct rw_semaphore *sem)
-{
-	long tmp;
-
-	tmp = atomic_long_dec_return_release(&sem->count);
-	if (unlikely(tmp < -1 && (tmp & RWSEM_ACTIVE_MASK) == 0))
-		rwsem_wake(sem);
-}
-
-/*
- * unlock after writing
- */
-static inline void __up_write(struct rw_semaphore *sem)
-{
-	if (unlikely(atomic_long_sub_return_release(RWSEM_ACTIVE_WRITE_BIAS,
-						    &sem->count) < 0))
-		rwsem_wake(sem);
-}
-
-/*
- * downgrade write lock to read lock
- */
-static inline void __downgrade_write(struct rw_semaphore *sem)
-{
-	long tmp;
-
-	/*
-	 * When downgrading from exclusive to shared ownership,
-	 * anything inside the write-locked region cannot leak
-	 * into the read side. In contrast, anything in the
-	 * read-locked region is ok to be re-ordered into the
-	 * write side. As such, rely on RELEASE semantics.
-	 */
-	tmp = atomic_long_add_return_release(-RWSEM_WAITING_BIAS, &sem->count);
-	if (tmp < 0)
-		rwsem_downgrade_wake(sem);
-}
-
-#endif	/* __KERNEL__ */
-#endif	/* _ASM_GENERIC_RWSEM_H */
diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
index 67dbb57508b1..6e56006b2cb6 100644
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -57,15 +57,13 @@ extern struct rw_semaphore *rwsem_down_write_failed_killable(struct rw_semaphore
 extern struct rw_semaphore *rwsem_wake(struct rw_semaphore *);
 extern struct rw_semaphore *rwsem_downgrade_wake(struct rw_semaphore *sem);
 
-/* Include the arch specific part */
-#include <asm/rwsem.h>
-
 /* In all implementations count != 0 means locked */
 static inline int rwsem_is_locked(struct rw_semaphore *sem)
 {
 	return atomic_long_read(&sem->count) != 0;
 }
 
+#define RWSEM_UNLOCKED_VALUE		0L
 #define __RWSEM_INIT_COUNT(name)	.count = ATOMIC_LONG_INIT(RWSEM_UNLOCKED_VALUE)
 #endif
 
diff --git a/kernel/locking/percpu-rwsem.c b/kernel/locking/percpu-rwsem.c
index 883cf1b92d90..f17dad99eec8 100644
--- a/kernel/locking/percpu-rwsem.c
+++ b/kernel/locking/percpu-rwsem.c
@@ -7,6 +7,8 @@
 #include <linux/sched.h>
 #include <linux/errno.h>
 
+#include "rwsem.h"
+
 int __percpu_init_rwsem(struct percpu_rw_semaphore *sem,
 			const char *name, struct lock_class_key *rwsem_key)
 {
diff --git a/kernel/locking/rwsem.h b/kernel/locking/rwsem.h
index bad2bca0268b..067e265fa5c1 100644
--- a/kernel/locking/rwsem.h
+++ b/kernel/locking/rwsem.h
@@ -32,6 +32,26 @@
 # define DEBUG_RWSEMS_WARN_ON(c)
 #endif
 
+/*
+ * R/W semaphores originally for PPC using the stuff in lib/rwsem.c.
+ * Adapted largely from include/asm-i386/rwsem.h
+ * by Paul Mackerras <paulus@samba.org>.
+ */
+
+/*
+ * the semaphore definition
+ */
+#ifdef CONFIG_64BIT
+# define RWSEM_ACTIVE_MASK		0xffffffffL
+#else
+# define RWSEM_ACTIVE_MASK		0x0000ffffL
+#endif
+
+#define RWSEM_ACTIVE_BIAS		0x00000001L
+#define RWSEM_WAITING_BIAS		(-RWSEM_ACTIVE_MASK-1)
+#define RWSEM_ACTIVE_READ_BIAS		RWSEM_ACTIVE_BIAS
+#define RWSEM_ACTIVE_WRITE_BIAS		(RWSEM_WAITING_BIAS + RWSEM_ACTIVE_BIAS)
+
 #ifdef CONFIG_RWSEM_SPIN_ON_OWNER
 /*
  * All writes to owner are protected by WRITE_ONCE() to make sure that
@@ -132,3 +152,113 @@ static inline void rwsem_clear_reader_owned(struct rw_semaphore *sem)
 {
 }
 #endif
+
+#ifdef CONFIG_RWSEM_XCHGADD_ALGORITHM
+/*
+ * lock for reading
+ */
+static inline void __down_read(struct rw_semaphore *sem)
+{
+	if (unlikely(atomic_long_inc_return_acquire(&sem->count) <= 0))
+		rwsem_down_read_failed(sem);
+}
+
+static inline int __down_read_killable(struct rw_semaphore *sem)
+{
+	if (unlikely(atomic_long_inc_return_acquire(&sem->count) <= 0)) {
+		if (IS_ERR(rwsem_down_read_failed_killable(sem)))
+			return -EINTR;
+	}
+
+	return 0;
+}
+
+static inline int __down_read_trylock(struct rw_semaphore *sem)
+{
+	long tmp;
+
+	while ((tmp = atomic_long_read(&sem->count)) >= 0) {
+		if (tmp == atomic_long_cmpxchg_acquire(&sem->count, tmp,
+				   tmp + RWSEM_ACTIVE_READ_BIAS)) {
+			return 1;
+		}
+	}
+	return 0;
+}
+
+/*
+ * lock for writing
+ */
+static inline void __down_write(struct rw_semaphore *sem)
+{
+	long tmp;
+
+	tmp = atomic_long_add_return_acquire(RWSEM_ACTIVE_WRITE_BIAS,
+					     &sem->count);
+	if (unlikely(tmp != RWSEM_ACTIVE_WRITE_BIAS))
+		rwsem_down_write_failed(sem);
+}
+
+static inline int __down_write_killable(struct rw_semaphore *sem)
+{
+	long tmp;
+
+	tmp = atomic_long_add_return_acquire(RWSEM_ACTIVE_WRITE_BIAS,
+					     &sem->count);
+	if (unlikely(tmp != RWSEM_ACTIVE_WRITE_BIAS))
+		if (IS_ERR(rwsem_down_write_failed_killable(sem)))
+			return -EINTR;
+	return 0;
+}
+
+static inline int __down_write_trylock(struct rw_semaphore *sem)
+{
+	long tmp;
+
+	tmp = atomic_long_cmpxchg_acquire(&sem->count, RWSEM_UNLOCKED_VALUE,
+		      RWSEM_ACTIVE_WRITE_BIAS);
+	return tmp == RWSEM_UNLOCKED_VALUE;
+}
+
+/*
+ * unlock after reading
+ */
+static inline void __up_read(struct rw_semaphore *sem)
+{
+	long tmp;
+
+	tmp = atomic_long_dec_return_release(&sem->count);
+	if (unlikely(tmp < -1 && (tmp & RWSEM_ACTIVE_MASK) == 0))
+		rwsem_wake(sem);
+}
+
+/*
+ * unlock after writing
+ */
+static inline void __up_write(struct rw_semaphore *sem)
+{
+	if (unlikely(atomic_long_sub_return_release(RWSEM_ACTIVE_WRITE_BIAS,
+						    &sem->count) < 0))
+		rwsem_wake(sem);
+}
+
+/*
+ * downgrade write lock to read lock
+ */
+static inline void __downgrade_write(struct rw_semaphore *sem)
+{
+	long tmp;
+
+	/*
+	 * When downgrading from exclusive to shared ownership,
+	 * anything inside the write-locked region cannot leak
+	 * into the read side. In contrast, anything in the
+	 * read-locked region is ok to be re-ordered into the
+	 * write side. As such, rely on RELEASE semantics.
+	 */
+	tmp = atomic_long_add_return_release(-RWSEM_WAITING_BIAS, &sem->count);
+	if (tmp < 0)
+		rwsem_downgrade_wake(sem);
+}
+
+#endif /* CONFIG_RWSEM_XCHGADD_ALGORITHM */
-- 
2.18.1

