Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Jun 2017 02:32:08 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:12521 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993976AbdFJAaXQuSit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 10 Jun 2017 02:30:23 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id C6CD624B5C004;
        Sat, 10 Jun 2017 01:30:14 +0100 (IST)
Received: from localhost (10.20.1.33) by HHMAIL01.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Sat, 10 Jun 2017 01:30:16
 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 11/11] MIPS: Use queued spinlocks (qspinlock)
Date:   Fri, 9 Jun 2017 17:26:43 -0700
Message-ID: <20170610002644.8434-12-paul.burton@imgtec.com>
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
X-archive-position: 58400
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
spinlocks, rather than the ticket spinlocks used previously. This allows
us to drop a whole load of inline assembly, share more generic code, and
is also a performance win.

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
 arch/mips/include/asm/spinlock.h       | 210 +--------------------------------
 arch/mips/include/asm/spinlock_types.h |  24 +---
 4 files changed, 4 insertions(+), 232 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 50c71273f569..398f0a55d4fa 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -71,6 +71,7 @@ config MIPS
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_COPY_THREAD_TLS
 	select ARCH_USE_QUEUED_RWLOCKS
+	select ARCH_USE_QUEUED_SPINLOCKS
 
 menu "Machine selection"
 
diff --git a/arch/mips/include/asm/Kbuild b/arch/mips/include/asm/Kbuild
index ae6cb47e9d22..7c8aab23bce8 100644
--- a/arch/mips/include/asm/Kbuild
+++ b/arch/mips/include/asm/Kbuild
@@ -13,6 +13,7 @@ generic-y += parport.h
 generic-y += percpu.h
 generic-y += preempt.h
 generic-y += qrwlock.h
+generic-y += qspinlock.h
 generic-y += sections.h
 generic-y += segment.h
 generic-y += serial.h
diff --git a/arch/mips/include/asm/spinlock.h b/arch/mips/include/asm/spinlock.h
index 3e7afff196cd..a7d21da16b6a 100644
--- a/arch/mips/include/asm/spinlock.h
+++ b/arch/mips/include/asm/spinlock.h
@@ -9,217 +9,9 @@
 #ifndef _ASM_SPINLOCK_H
 #define _ASM_SPINLOCK_H
 
-#include <linux/compiler.h>
-
-#include <asm/barrier.h>
 #include <asm/processor.h>
 #include <asm/qrwlock.h>
-#include <asm/compiler.h>
-#include <asm/war.h>
-
-/*
- * Your basic SMP spinlocks, allowing only a single CPU anywhere
- *
- * Simple spin lock operations.	 There are two variants, one clears IRQ's
- * on the local processor, one does not.
- *
- * These are fair FIFO ticket locks
- *
- * (the type definitions are in asm/spinlock_types.h)
- */
-
-
-/*
- * Ticket locks are conceptually two parts, one indicating the current head of
- * the queue, and the other indicating the current tail. The lock is acquired
- * by atomically noting the tail and incrementing it by one (thus adding
- * ourself to the queue and noting our position), then waiting until the head
- * becomes equal to the the initial value of the tail.
- */
-
-static inline int arch_spin_is_locked(arch_spinlock_t *lock)
-{
-	u32 counters = ACCESS_ONCE(lock->lock);
-
-	return ((counters >> 16) ^ counters) & 0xffff;
-}
-
-static inline int arch_spin_value_unlocked(arch_spinlock_t lock)
-{
-	return lock.h.serving_now == lock.h.ticket;
-}
-
-#define arch_spin_lock_flags(lock, flags) arch_spin_lock(lock)
-
-static inline void arch_spin_unlock_wait(arch_spinlock_t *lock)
-{
-	u16 owner = READ_ONCE(lock->h.serving_now);
-	smp_rmb();
-	for (;;) {
-		arch_spinlock_t tmp = READ_ONCE(*lock);
-
-		if (tmp.h.serving_now == tmp.h.ticket ||
-		    tmp.h.serving_now != owner)
-			break;
-
-		cpu_relax();
-	}
-	smp_acquire__after_ctrl_dep();
-}
-
-static inline int arch_spin_is_contended(arch_spinlock_t *lock)
-{
-	u32 counters = ACCESS_ONCE(lock->lock);
-
-	return (((counters >> 16) - counters) & 0xffff) > 1;
-}
-#define arch_spin_is_contended	arch_spin_is_contended
-
-static inline void arch_spin_lock(arch_spinlock_t *lock)
-{
-	int my_ticket;
-	int tmp;
-	int inc = 0x10000;
-
-	if (R10000_LLSC_WAR) {
-		__asm__ __volatile__ (
-		"	.set push		# arch_spin_lock	\n"
-		"	.set noreorder					\n"
-		"							\n"
-		"1:	ll	%[ticket], %[ticket_ptr]		\n"
-		"	addu	%[my_ticket], %[ticket], %[inc]		\n"
-		"	sc	%[my_ticket], %[ticket_ptr]		\n"
-		"	beqzl	%[my_ticket], 1b			\n"
-		"	 nop						\n"
-		"	srl	%[my_ticket], %[ticket], 16		\n"
-		"	andi	%[ticket], %[ticket], 0xffff		\n"
-		"	bne	%[ticket], %[my_ticket], 4f		\n"
-		"	 subu	%[ticket], %[my_ticket], %[ticket]	\n"
-		"2:							\n"
-		"	.subsection 2					\n"
-		"4:	andi	%[ticket], %[ticket], 0xffff		\n"
-		"	sll	%[ticket], 5				\n"
-		"							\n"
-		"6:	bnez	%[ticket], 6b				\n"
-		"	 subu	%[ticket], 1				\n"
-		"							\n"
-		"	lhu	%[ticket], %[serving_now_ptr]		\n"
-		"	beq	%[ticket], %[my_ticket], 2b		\n"
-		"	 subu	%[ticket], %[my_ticket], %[ticket]	\n"
-		"	b	4b					\n"
-		"	 subu	%[ticket], %[ticket], 1			\n"
-		"	.previous					\n"
-		"	.set pop					\n"
-		: [ticket_ptr] "+" GCC_OFF_SMALL_ASM() (lock->lock),
-		  [serving_now_ptr] "+m" (lock->h.serving_now),
-		  [ticket] "=&r" (tmp),
-		  [my_ticket] "=&r" (my_ticket)
-		: [inc] "r" (inc));
-	} else {
-		__asm__ __volatile__ (
-		"	.set push		# arch_spin_lock	\n"
-		"	.set noreorder					\n"
-		"							\n"
-		"1:	ll	%[ticket], %[ticket_ptr]		\n"
-		"	addu	%[my_ticket], %[ticket], %[inc]		\n"
-		"	sc	%[my_ticket], %[ticket_ptr]		\n"
-		"	beqz	%[my_ticket], 1b			\n"
-		"	 srl	%[my_ticket], %[ticket], 16		\n"
-		"	andi	%[ticket], %[ticket], 0xffff		\n"
-		"	bne	%[ticket], %[my_ticket], 4f		\n"
-		"	 subu	%[ticket], %[my_ticket], %[ticket]	\n"
-		"2:	.insn						\n"
-		"	.subsection 2					\n"
-		"4:	andi	%[ticket], %[ticket], 0xffff		\n"
-		"	sll	%[ticket], 5				\n"
-		"							\n"
-		"6:	bnez	%[ticket], 6b				\n"
-		"	 subu	%[ticket], 1				\n"
-		"							\n"
-		"	lhu	%[ticket], %[serving_now_ptr]		\n"
-		"	beq	%[ticket], %[my_ticket], 2b		\n"
-		"	 subu	%[ticket], %[my_ticket], %[ticket]	\n"
-		"	b	4b					\n"
-		"	 subu	%[ticket], %[ticket], 1			\n"
-		"	.previous					\n"
-		"	.set pop					\n"
-		: [ticket_ptr] "+" GCC_OFF_SMALL_ASM() (lock->lock),
-		  [serving_now_ptr] "+m" (lock->h.serving_now),
-		  [ticket] "=&r" (tmp),
-		  [my_ticket] "=&r" (my_ticket)
-		: [inc] "r" (inc));
-	}
-
-	smp_llsc_mb();
-}
-
-static inline void arch_spin_unlock(arch_spinlock_t *lock)
-{
-	unsigned int serving_now = lock->h.serving_now + 1;
-	wmb();
-	lock->h.serving_now = (u16)serving_now;
-	nudge_writes();
-}
-
-static inline unsigned int arch_spin_trylock(arch_spinlock_t *lock)
-{
-	int tmp, tmp2, tmp3;
-	int inc = 0x10000;
-
-	if (R10000_LLSC_WAR) {
-		__asm__ __volatile__ (
-		"	.set push		# arch_spin_trylock	\n"
-		"	.set noreorder					\n"
-		"							\n"
-		"1:	ll	%[ticket], %[ticket_ptr]		\n"
-		"	srl	%[my_ticket], %[ticket], 16		\n"
-		"	andi	%[now_serving], %[ticket], 0xffff	\n"
-		"	bne	%[my_ticket], %[now_serving], 3f	\n"
-		"	 addu	%[ticket], %[ticket], %[inc]		\n"
-		"	sc	%[ticket], %[ticket_ptr]		\n"
-		"	beqzl	%[ticket], 1b				\n"
-		"	 li	%[ticket], 1				\n"
-		"2:							\n"
-		"	.subsection 2					\n"
-		"3:	b	2b					\n"
-		"	 li	%[ticket], 0				\n"
-		"	.previous					\n"
-		"	.set pop					\n"
-		: [ticket_ptr] "+" GCC_OFF_SMALL_ASM() (lock->lock),
-		  [ticket] "=&r" (tmp),
-		  [my_ticket] "=&r" (tmp2),
-		  [now_serving] "=&r" (tmp3)
-		: [inc] "r" (inc));
-	} else {
-		__asm__ __volatile__ (
-		"	.set push		# arch_spin_trylock	\n"
-		"	.set noreorder					\n"
-		"							\n"
-		"1:	ll	%[ticket], %[ticket_ptr]		\n"
-		"	srl	%[my_ticket], %[ticket], 16		\n"
-		"	andi	%[now_serving], %[ticket], 0xffff	\n"
-		"	bne	%[my_ticket], %[now_serving], 3f	\n"
-		"	 addu	%[ticket], %[ticket], %[inc]		\n"
-		"	sc	%[ticket], %[ticket_ptr]		\n"
-		"	beqz	%[ticket], 1b				\n"
-		"	 li	%[ticket], 1				\n"
-		"2:	.insn						\n"
-		"	.subsection 2					\n"
-		"3:	b	2b					\n"
-		"	 li	%[ticket], 0				\n"
-		"	.previous					\n"
-		"	.set pop					\n"
-		: [ticket_ptr] "+" GCC_OFF_SMALL_ASM() (lock->lock),
-		  [ticket] "=&r" (tmp),
-		  [my_ticket] "=&r" (tmp2),
-		  [now_serving] "=&r" (tmp3)
-		: [inc] "r" (inc));
-	}
-
-	smp_llsc_mb();
-
-	return tmp;
-}
+#include <asm/qspinlock.h>
 
 #define arch_read_lock_flags(lock, flags) arch_read_lock(lock)
 #define arch_write_lock_flags(lock, flags) arch_write_lock(lock)
diff --git a/arch/mips/include/asm/spinlock_types.h b/arch/mips/include/asm/spinlock_types.h
index 3d38bfad9b49..177e722eb96c 100644
--- a/arch/mips/include/asm/spinlock_types.h
+++ b/arch/mips/include/asm/spinlock_types.h
@@ -1,29 +1,7 @@
 #ifndef _ASM_SPINLOCK_TYPES_H
 #define _ASM_SPINLOCK_TYPES_H
 
-#include <linux/types.h>
-
-#include <asm/byteorder.h>
-
-typedef union {
-	/*
-	 * bits	 0..15 : serving_now
-	 * bits 16..31 : ticket
-	 */
-	u32 lock;
-	struct {
-#ifdef __BIG_ENDIAN
-		u16 ticket;
-		u16 serving_now;
-#else
-		u16 serving_now;
-		u16 ticket;
-#endif
-	} h;
-} arch_spinlock_t;
-
-#define __ARCH_SPIN_LOCK_UNLOCKED	{ .lock = 0 }
-
+#include <asm-generic/qspinlock_types.h>
 #include <asm-generic/qrwlock_types.h>
 
 #endif
-- 
2.13.1
