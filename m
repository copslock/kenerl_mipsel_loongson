Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Jun 2017 02:31:41 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:10915 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993966AbdFJAaEribTt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 10 Jun 2017 02:30:04 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 6F26B6CB21700;
        Sat, 10 Jun 2017 01:29:56 +0100 (IST)
Received: from localhost (10.20.1.33) by HHMAIL01.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Sat, 10 Jun 2017 01:29:57
 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 10/11] MIPS: Use queued read/write locks (qrwlock)
Date:   Fri, 9 Jun 2017 17:26:42 -0700
Message-ID: <20170610002644.8434-11-paul.burton@imgtec.com>
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
X-archive-position: 58399
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

This patch switches MIPS to make use of generically implemented queued
read/write locks, rather than the custom implementation used previously.
This allows us to drop a whole load of inline assembly, share more
generic code, and is also a performance win.

Results from running the AIM7 short workload on a MIPS Creator Ci40 (ie.
2 core 2 thread interAptiv CPU clocked at 546MHz) with v4.12-rc4
pistachio_defconfig, with ftrace disabled due to a current bug, and both
with & without use of queued rwlocks & spinlocks:

  Forks | v4.12-rc4 | +qlocks  | Change
 -------|-----------|----------|--------
     10 | 52630.32  | 53316.31 | +1.01%
     20 | 51777.80  | 52623.15 | +1.02%
     30 | 51645.92  | 52517.26 | +1.02%
     40 | 51634.88  | 52419.89 | +1.02%
     50 | 51506.75  | 52307.81 | +1.02%
     60 | 51500.74  | 52322.72 | +1.02%
     70 | 51434.81  | 52288.60 | +1.02%
     80 | 51423.22  | 52434.85 | +1.02%
     90 | 51428.65  | 52410.10 | +1.02%

The kernels used for these tests also had my "MIPS: Hardcode cpu_has_*
where known at compile time due to ISA" patch applied, which allows the
kernel_uses_llsc checks in cmpxchg() & xchg() to be optimised away at
compile time.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---

 arch/mips/Kconfig                      |   1 +
 arch/mips/include/asm/Kbuild           |   1 +
 arch/mips/include/asm/spinlock.h       | 216 +--------------------------------
 arch/mips/include/asm/spinlock_types.h |  10 +-
 4 files changed, 4 insertions(+), 224 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 2828ecde133d..50c71273f569 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -70,6 +70,7 @@ config MIPS
 	select HAVE_EXIT_THREAD
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_COPY_THREAD_TLS
+	select ARCH_USE_QUEUED_RWLOCKS
 
 menu "Machine selection"
 
diff --git a/arch/mips/include/asm/Kbuild b/arch/mips/include/asm/Kbuild
index 2535c7b4c482..ae6cb47e9d22 100644
--- a/arch/mips/include/asm/Kbuild
+++ b/arch/mips/include/asm/Kbuild
@@ -12,6 +12,7 @@ generic-y += mm-arch-hooks.h
 generic-y += parport.h
 generic-y += percpu.h
 generic-y += preempt.h
+generic-y += qrwlock.h
 generic-y += sections.h
 generic-y += segment.h
 generic-y += serial.h
diff --git a/arch/mips/include/asm/spinlock.h b/arch/mips/include/asm/spinlock.h
index a8df44d60607..3e7afff196cd 100644
--- a/arch/mips/include/asm/spinlock.h
+++ b/arch/mips/include/asm/spinlock.h
@@ -13,6 +13,7 @@
 
 #include <asm/barrier.h>
 #include <asm/processor.h>
+#include <asm/qrwlock.h>
 #include <asm/compiler.h>
 #include <asm/war.h>
 
@@ -220,221 +221,6 @@ static inline unsigned int arch_spin_trylock(arch_spinlock_t *lock)
 	return tmp;
 }
 
-/*
- * Read-write spinlocks, allowing multiple readers but only one writer.
- *
- * NOTE! it is quite common to have readers in interrupts but no interrupt
- * writers. For those circumstances we can "mix" irq-safe locks - any writer
- * needs to get a irq-safe write-lock, but readers can get non-irqsafe
- * read-locks.
- */
-
-/*
- * read_can_lock - would read_trylock() succeed?
- * @lock: the rwlock in question.
- */
-#define arch_read_can_lock(rw)	((rw)->lock >= 0)
-
-/*
- * write_can_lock - would write_trylock() succeed?
- * @lock: the rwlock in question.
- */
-#define arch_write_can_lock(rw) (!(rw)->lock)
-
-static inline void arch_read_lock(arch_rwlock_t *rw)
-{
-	unsigned int tmp;
-
-	if (R10000_LLSC_WAR) {
-		__asm__ __volatile__(
-		"	.set	noreorder	# arch_read_lock	\n"
-		"1:	ll	%1, %2					\n"
-		"	bltz	%1, 1b					\n"
-		"	 addu	%1, 1					\n"
-		"	sc	%1, %0					\n"
-		"	beqzl	%1, 1b					\n"
-		"	 nop						\n"
-		"	.set	reorder					\n"
-		: "=" GCC_OFF_SMALL_ASM() (rw->lock), "=&r" (tmp)
-		: GCC_OFF_SMALL_ASM() (rw->lock)
-		: "memory");
-	} else {
-		do {
-			__asm__ __volatile__(
-			"1:	ll	%1, %2	# arch_read_lock	\n"
-			"	bltz	%1, 1b				\n"
-			"	 addu	%1, 1				\n"
-			"2:	sc	%1, %0				\n"
-			: "=" GCC_OFF_SMALL_ASM() (rw->lock), "=&r" (tmp)
-			: GCC_OFF_SMALL_ASM() (rw->lock)
-			: "memory");
-		} while (unlikely(!tmp));
-	}
-
-	smp_llsc_mb();
-}
-
-static inline void arch_read_unlock(arch_rwlock_t *rw)
-{
-	unsigned int tmp;
-
-	smp_mb__before_llsc();
-
-	if (R10000_LLSC_WAR) {
-		__asm__ __volatile__(
-		"1:	ll	%1, %2		# arch_read_unlock	\n"
-		"	addiu	%1, -1					\n"
-		"	sc	%1, %0					\n"
-		"	beqzl	%1, 1b					\n"
-		: "=" GCC_OFF_SMALL_ASM() (rw->lock), "=&r" (tmp)
-		: GCC_OFF_SMALL_ASM() (rw->lock)
-		: "memory");
-	} else {
-		do {
-			__asm__ __volatile__(
-			"1:	ll	%1, %2	# arch_read_unlock	\n"
-			"	addiu	%1, -1				\n"
-			"	sc	%1, %0				\n"
-			: "=" GCC_OFF_SMALL_ASM() (rw->lock), "=&r" (tmp)
-			: GCC_OFF_SMALL_ASM() (rw->lock)
-			: "memory");
-		} while (unlikely(!tmp));
-	}
-}
-
-static inline void arch_write_lock(arch_rwlock_t *rw)
-{
-	unsigned int tmp;
-
-	if (R10000_LLSC_WAR) {
-		__asm__ __volatile__(
-		"	.set	noreorder	# arch_write_lock	\n"
-		"1:	ll	%1, %2					\n"
-		"	bnez	%1, 1b					\n"
-		"	 lui	%1, 0x8000				\n"
-		"	sc	%1, %0					\n"
-		"	beqzl	%1, 1b					\n"
-		"	 nop						\n"
-		"	.set	reorder					\n"
-		: "=" GCC_OFF_SMALL_ASM() (rw->lock), "=&r" (tmp)
-		: GCC_OFF_SMALL_ASM() (rw->lock)
-		: "memory");
-	} else {
-		do {
-			__asm__ __volatile__(
-			"1:	ll	%1, %2	# arch_write_lock	\n"
-			"	bnez	%1, 1b				\n"
-			"	 lui	%1, 0x8000			\n"
-			"2:	sc	%1, %0				\n"
-			: "=" GCC_OFF_SMALL_ASM() (rw->lock), "=&r" (tmp)
-			: GCC_OFF_SMALL_ASM() (rw->lock)
-			: "memory");
-		} while (unlikely(!tmp));
-	}
-
-	smp_llsc_mb();
-}
-
-static inline void arch_write_unlock(arch_rwlock_t *rw)
-{
-	smp_mb__before_llsc();
-
-	__asm__ __volatile__(
-	"				# arch_write_unlock	\n"
-	"	sw	$0, %0					\n"
-	: "=m" (rw->lock)
-	: "m" (rw->lock)
-	: "memory");
-}
-
-static inline int arch_read_trylock(arch_rwlock_t *rw)
-{
-	unsigned int tmp;
-	int ret;
-
-	if (R10000_LLSC_WAR) {
-		__asm__ __volatile__(
-		"	.set	noreorder	# arch_read_trylock	\n"
-		"	li	%2, 0					\n"
-		"1:	ll	%1, %3					\n"
-		"	bltz	%1, 2f					\n"
-		"	 addu	%1, 1					\n"
-		"	sc	%1, %0					\n"
-		"	.set	reorder					\n"
-		"	beqzl	%1, 1b					\n"
-		"	 nop						\n"
-		__WEAK_LLSC_MB
-		"	li	%2, 1					\n"
-		"2:							\n"
-		: "=" GCC_OFF_SMALL_ASM() (rw->lock), "=&r" (tmp), "=&r" (ret)
-		: GCC_OFF_SMALL_ASM() (rw->lock)
-		: "memory");
-	} else {
-		__asm__ __volatile__(
-		"	.set	noreorder	# arch_read_trylock	\n"
-		"	li	%2, 0					\n"
-		"1:	ll	%1, %3					\n"
-		"	bltz	%1, 2f					\n"
-		"	 addu	%1, 1					\n"
-		"	sc	%1, %0					\n"
-		"	beqz	%1, 1b					\n"
-		"	 nop						\n"
-		"	.set	reorder					\n"
-		__WEAK_LLSC_MB
-		"	li	%2, 1					\n"
-		"2:	.insn						\n"
-		: "=" GCC_OFF_SMALL_ASM() (rw->lock), "=&r" (tmp), "=&r" (ret)
-		: GCC_OFF_SMALL_ASM() (rw->lock)
-		: "memory");
-	}
-
-	return ret;
-}
-
-static inline int arch_write_trylock(arch_rwlock_t *rw)
-{
-	unsigned int tmp;
-	int ret;
-
-	if (R10000_LLSC_WAR) {
-		__asm__ __volatile__(
-		"	.set	noreorder	# arch_write_trylock	\n"
-		"	li	%2, 0					\n"
-		"1:	ll	%1, %3					\n"
-		"	bnez	%1, 2f					\n"
-		"	 lui	%1, 0x8000				\n"
-		"	sc	%1, %0					\n"
-		"	beqzl	%1, 1b					\n"
-		"	 nop						\n"
-		__WEAK_LLSC_MB
-		"	li	%2, 1					\n"
-		"	.set	reorder					\n"
-		"2:							\n"
-		: "=" GCC_OFF_SMALL_ASM() (rw->lock), "=&r" (tmp), "=&r" (ret)
-		: GCC_OFF_SMALL_ASM() (rw->lock)
-		: "memory");
-	} else {
-		do {
-			__asm__ __volatile__(
-			"	ll	%1, %3	# arch_write_trylock	\n"
-			"	li	%2, 0				\n"
-			"	bnez	%1, 2f				\n"
-			"	lui	%1, 0x8000			\n"
-			"	sc	%1, %0				\n"
-			"	li	%2, 1				\n"
-			"2:	.insn					\n"
-			: "=" GCC_OFF_SMALL_ASM() (rw->lock), "=&r" (tmp),
-			  "=&r" (ret)
-			: GCC_OFF_SMALL_ASM() (rw->lock)
-			: "memory");
-		} while (unlikely(!tmp));
-
-		smp_llsc_mb();
-	}
-
-	return ret;
-}
-
 #define arch_read_lock_flags(lock, flags) arch_read_lock(lock)
 #define arch_write_lock_flags(lock, flags) arch_write_lock(lock)
 
diff --git a/arch/mips/include/asm/spinlock_types.h b/arch/mips/include/asm/spinlock_types.h
index 9b2528e612c0..3d38bfad9b49 100644
--- a/arch/mips/include/asm/spinlock_types.h
+++ b/arch/mips/include/asm/spinlock_types.h
@@ -1,10 +1,6 @@
 #ifndef _ASM_SPINLOCK_TYPES_H
 #define _ASM_SPINLOCK_TYPES_H
 
-#ifndef __LINUX_SPINLOCK_TYPES_H
-# error "please don't include this file directly"
-#endif
-
 #include <linux/types.h>
 
 #include <asm/byteorder.h>
@@ -28,10 +24,6 @@ typedef union {
 
 #define __ARCH_SPIN_LOCK_UNLOCKED	{ .lock = 0 }
 
-typedef struct {
-	volatile unsigned int lock;
-} arch_rwlock_t;
-
-#define __ARCH_RW_LOCK_UNLOCKED		{ 0 }
+#include <asm-generic/qrwlock_types.h>
 
 #endif
-- 
2.13.1
