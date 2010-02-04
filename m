Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Feb 2010 20:33:05 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:17507 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493045Ab0BDTc6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Feb 2010 20:32:58 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4b6b20ee0001>; Thu, 04 Feb 2010 11:33:02 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Thu, 4 Feb 2010 11:31:54 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Thu, 4 Feb 2010 11:31:54 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id o14JVooQ001705;
        Thu, 4 Feb 2010 11:31:50 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id o14JVnLV001704;
        Thu, 4 Feb 2010 11:31:49 -0800
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] MIPS: Optimize spinlocks.
Date:   Thu,  4 Feb 2010 11:31:49 -0800
Message-Id: <1265311909-1679-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.0.6
X-OriginalArrivalTime: 04 Feb 2010 19:31:54.0872 (UTC) FILETIME=[B5677F80:01CAA5D0]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25874
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

The current locking mechanism uses a ll/sc sequence to release a
spinlock.  This is slower than a wmb() followed by a store to unlock.

The branching forward to .subsection 2 on sc failure slows down the
contended case.  So we get rid of that part too.

Since we are now working on naturally aligned u16 values, we can get
rid of a masking operation as the LHU already does the right thing.
The ANDI are reversed for better scheduling on multi-issue CPUs

On a 12 CPU 750MHz Octeon cn5750 this patch improves ipv4 UDP packet
forwarding rates from 3.58*10^6 PPS to 3.99*10^6 PPS, or about 11%.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/barrier.h        |    6 ++
 arch/mips/include/asm/spinlock.h       |  118 ++++++++++++--------------------
 arch/mips/include/asm/spinlock_types.h |   24 +++++--
 3 files changed, 67 insertions(+), 81 deletions(-)

diff --git a/arch/mips/include/asm/barrier.h b/arch/mips/include/asm/barrier.h
index a2670a2..c0884f0 100644
--- a/arch/mips/include/asm/barrier.h
+++ b/arch/mips/include/asm/barrier.h
@@ -168,8 +168,14 @@
 
 #ifdef CONFIG_CPU_CAVIUM_OCTEON
 #define smp_mb__before_llsc() smp_wmb()
+/* Cause previous writes to become visible on all CPUs as soon as possible */
+#define nudge_writes() __asm__ __volatile__(".set push\n\t"		\
+					    ".set arch=octeon\n\t"	\
+					    "syncw\n\t"			\
+					    ".set pop" : : : "memory")
 #else
 #define smp_mb__before_llsc() smp_llsc_mb()
+#define nudge_writes() mb()
 #endif
 
 #endif /* __ASM_BARRIER_H */
diff --git a/arch/mips/include/asm/spinlock.h b/arch/mips/include/asm/spinlock.h
index 5f16696..396e402 100644
--- a/arch/mips/include/asm/spinlock.h
+++ b/arch/mips/include/asm/spinlock.h
@@ -36,9 +36,9 @@
 
 static inline int arch_spin_is_locked(arch_spinlock_t *lock)
 {
-	unsigned int counters = ACCESS_ONCE(lock->lock);
+	u32 counters = ACCESS_ONCE(lock->lock);
 
-	return ((counters >> 14) ^ counters) & 0x1fff;
+	return ((counters >> 16) ^ counters) & 0xffff;
 }
 
 #define arch_spin_lock_flags(lock, flags) arch_spin_lock(lock)
@@ -47,9 +47,9 @@ static inline int arch_spin_is_locked(arch_spinlock_t *lock)
 
 static inline int arch_spin_is_contended(arch_spinlock_t *lock)
 {
-	unsigned int counters = ACCESS_ONCE(lock->lock);
+	u32 counters = ACCESS_ONCE(lock->lock);
 
-	return (((counters >> 14) - counters) & 0x1fff) > 1;
+	return (((counters >> 16) - counters) & 0xffff) > 1;
 }
 #define arch_spin_is_contended	arch_spin_is_contended
 
@@ -57,6 +57,7 @@ static inline void arch_spin_lock(arch_spinlock_t *lock)
 {
 	int my_ticket;
 	int tmp;
+	int inc = 0x10000;
 
 	if (R10000_LLSC_WAR) {
 		__asm__ __volatile__ (
@@ -64,25 +65,24 @@ static inline void arch_spin_lock(arch_spinlock_t *lock)
 		"	.set noreorder					\n"
 		"							\n"
 		"1:	ll	%[ticket], %[ticket_ptr]		\n"
-		"	addiu	%[my_ticket], %[ticket], 0x4000		\n"
+		"	addu	%[my_ticket], %[ticket], %[inc]		\n"
 		"	sc	%[my_ticket], %[ticket_ptr]		\n"
 		"	beqzl	%[my_ticket], 1b			\n"
 		"	 nop						\n"
-		"	srl	%[my_ticket], %[ticket], 14		\n"
-		"	andi	%[my_ticket], %[my_ticket], 0x1fff	\n"
-		"	andi	%[ticket], %[ticket], 0x1fff		\n"
+		"	srl	%[my_ticket], %[ticket], 16		\n"
+		"	andi	%[ticket], %[ticket], 0xffff		\n"
+		"	andi	%[my_ticket], %[my_ticket], 0xffff	\n"
 		"	bne	%[ticket], %[my_ticket], 4f		\n"
 		"	 subu	%[ticket], %[my_ticket], %[ticket]	\n"
 		"2:							\n"
 		"	.subsection 2					\n"
-		"4:	andi	%[ticket], %[ticket], 0x1fff		\n"
+		"4:	andi	%[ticket], %[ticket], 0xffff		\n"
 		"	sll	%[ticket], 5				\n"
 		"							\n"
 		"6:	bnez	%[ticket], 6b				\n"
 		"	 subu	%[ticket], 1				\n"
 		"							\n"
-		"	lw	%[ticket], %[ticket_ptr]		\n"
-		"	andi	%[ticket], %[ticket], 0x1fff		\n"
+		"	lhu	%[ticket], %[serving_now_ptr]		\n"
 		"	beq	%[ticket], %[my_ticket], 2b		\n"
 		"	 subu	%[ticket], %[my_ticket], %[ticket]	\n"
 		"	b	4b					\n"
@@ -90,36 +90,33 @@ static inline void arch_spin_lock(arch_spinlock_t *lock)
 		"	.previous					\n"
 		"	.set pop					\n"
 		: [ticket_ptr] "+m" (lock->lock),
+		  [serving_now_ptr] "+m" (lock->h.serving_now),
 		  [ticket] "=&r" (tmp),
-		  [my_ticket] "=&r" (my_ticket));
+		  [my_ticket] "=&r" (my_ticket)
+		: [inc] "r" (inc));
 	} else {
 		__asm__ __volatile__ (
 		"	.set push		# arch_spin_lock	\n"
 		"	.set noreorder					\n"
 		"							\n"
-		"	ll	%[ticket], %[ticket_ptr]		\n"
-		"1:	addiu	%[my_ticket], %[ticket], 0x4000		\n"
+		"1:	ll	%[ticket], %[ticket_ptr]		\n"
+		"	addu	%[my_ticket], %[ticket], %[inc]		\n"
 		"	sc	%[my_ticket], %[ticket_ptr]		\n"
-		"	beqz	%[my_ticket], 3f			\n"
-		"	 nop						\n"
-		"	srl	%[my_ticket], %[ticket], 14		\n"
-		"	andi	%[my_ticket], %[my_ticket], 0x1fff	\n"
-		"	andi	%[ticket], %[ticket], 0x1fff		\n"
+		"	beqz	%[my_ticket], 1b			\n"
+		"	 srl	%[my_ticket], %[ticket], 16		\n"
+		"	andi	%[ticket], %[ticket], 0xffff		\n"
+		"	andi	%[my_ticket], %[my_ticket], 0xffff	\n"
 		"	bne	%[ticket], %[my_ticket], 4f		\n"
 		"	 subu	%[ticket], %[my_ticket], %[ticket]	\n"
 		"2:							\n"
 		"	.subsection 2					\n"
-		"3:	b	1b					\n"
-		"	 ll	%[ticket], %[ticket_ptr]		\n"
-		"							\n"
 		"4:	andi	%[ticket], %[ticket], 0x1fff		\n"
 		"	sll	%[ticket], 5				\n"
 		"							\n"
 		"6:	bnez	%[ticket], 6b				\n"
 		"	 subu	%[ticket], 1				\n"
 		"							\n"
-		"	lw	%[ticket], %[ticket_ptr]		\n"
-		"	andi	%[ticket], %[ticket], 0x1fff		\n"
+		"	lhu	%[ticket], %[serving_now_ptr]		\n"
 		"	beq	%[ticket], %[my_ticket], 2b		\n"
 		"	 subu	%[ticket], %[my_ticket], %[ticket]	\n"
 		"	b	4b					\n"
@@ -127,8 +124,10 @@ static inline void arch_spin_lock(arch_spinlock_t *lock)
 		"	.previous					\n"
 		"	.set pop					\n"
 		: [ticket_ptr] "+m" (lock->lock),
+		  [serving_now_ptr] "+m" (lock->h.serving_now),
 		  [ticket] "=&r" (tmp),
-		  [my_ticket] "=&r" (my_ticket));
+		  [my_ticket] "=&r" (my_ticket)
+		: [inc] "r" (inc));
 	}
 
 	smp_llsc_mb();
@@ -136,47 +135,16 @@ static inline void arch_spin_lock(arch_spinlock_t *lock)
 
 static inline void arch_spin_unlock(arch_spinlock_t *lock)
 {
-	int tmp;
-
-	smp_mb__before_llsc();
-
-	if (R10000_LLSC_WAR) {
-		__asm__ __volatile__ (
-		"				# arch_spin_unlock	\n"
-		"1:	ll	%[ticket], %[ticket_ptr]		\n"
-		"	addiu	%[ticket], %[ticket], 1			\n"
-		"	ori	%[ticket], %[ticket], 0x2000		\n"
-		"	xori	%[ticket], %[ticket], 0x2000		\n"
-		"	sc	%[ticket], %[ticket_ptr]		\n"
-		"	beqzl	%[ticket], 1b				\n"
-		: [ticket_ptr] "+m" (lock->lock),
-		  [ticket] "=&r" (tmp));
-	} else {
-		__asm__ __volatile__ (
-		"	.set push		# arch_spin_unlock	\n"
-		"	.set noreorder					\n"
-		"							\n"
-		"	ll	%[ticket], %[ticket_ptr]		\n"
-		"1:	addiu	%[ticket], %[ticket], 1			\n"
-		"	ori	%[ticket], %[ticket], 0x2000		\n"
-		"	xori	%[ticket], %[ticket], 0x2000		\n"
-		"	sc	%[ticket], %[ticket_ptr]		\n"
-		"	beqz	%[ticket], 2f				\n"
-		"	 nop						\n"
-		"							\n"
-		"	.subsection 2					\n"
-		"2:	b	1b					\n"
-		"	 ll	%[ticket], %[ticket_ptr]		\n"
-		"	.previous					\n"
-		"	.set pop					\n"
-		: [ticket_ptr] "+m" (lock->lock),
-		  [ticket] "=&r" (tmp));
-	}
+	unsigned int serving_now = lock->h.serving_now + 1;
+	wmb();
+	lock->h.serving_now = (u16)serving_now;
+	nudge_writes();
 }
 
 static inline unsigned int arch_spin_trylock(arch_spinlock_t *lock)
 {
 	int tmp, tmp2, tmp3;
+	int inc = 0x10000;
 
 	if (R10000_LLSC_WAR) {
 		__asm__ __volatile__ (
@@ -184,11 +152,11 @@ static inline unsigned int arch_spin_trylock(arch_spinlock_t *lock)
 		"	.set noreorder					\n"
 		"							\n"
 		"1:	ll	%[ticket], %[ticket_ptr]		\n"
-		"	srl	%[my_ticket], %[ticket], 14		\n"
-		"	andi	%[my_ticket], %[my_ticket], 0x1fff	\n"
-		"	andi	%[now_serving], %[ticket], 0x1fff	\n"
+		"	srl	%[my_ticket], %[ticket], 16		\n"
+		"	andi	%[my_ticket], %[my_ticket], 0xffff	\n"
+		"	andi	%[now_serving], %[ticket], 0xffff	\n"
 		"	bne	%[my_ticket], %[now_serving], 3f	\n"
-		"	 addiu	%[ticket], %[ticket], 0x4000		\n"
+		"	 addu	%[ticket], %[ticket], %[inc]		\n"
 		"	sc	%[ticket], %[ticket_ptr]		\n"
 		"	beqzl	%[ticket], 1b				\n"
 		"	 li	%[ticket], 1				\n"
@@ -201,33 +169,33 @@ static inline unsigned int arch_spin_trylock(arch_spinlock_t *lock)
 		: [ticket_ptr] "+m" (lock->lock),
 		  [ticket] "=&r" (tmp),
 		  [my_ticket] "=&r" (tmp2),
-		  [now_serving] "=&r" (tmp3));
+		  [now_serving] "=&r" (tmp3)
+		: [inc] "r" (inc));
 	} else {
 		__asm__ __volatile__ (
 		"	.set push		# arch_spin_trylock	\n"
 		"	.set noreorder					\n"
 		"							\n"
-		"	ll	%[ticket], %[ticket_ptr]		\n"
-		"1:	srl	%[my_ticket], %[ticket], 14		\n"
-		"	andi	%[my_ticket], %[my_ticket], 0x1fff	\n"
-		"	andi	%[now_serving], %[ticket], 0x1fff	\n"
+		"1:	ll	%[ticket], %[ticket_ptr]		\n"
+		"	srl	%[my_ticket], %[ticket], 16		\n"
+		"	andi	%[my_ticket], %[my_ticket], 0xffff	\n"
+		"	andi	%[now_serving], %[ticket], 0xffff	\n"
 		"	bne	%[my_ticket], %[now_serving], 3f	\n"
-		"	 addiu	%[ticket], %[ticket], 0x4000		\n"
+		"	 addu	%[ticket], %[ticket], %[inc]		\n"
 		"	sc	%[ticket], %[ticket_ptr]		\n"
-		"	beqz	%[ticket], 4f				\n"
+		"	beqz	%[ticket], 1b				\n"
 		"	 li	%[ticket], 1				\n"
 		"2:							\n"
 		"	.subsection 2					\n"
 		"3:	b	2b					\n"
 		"	 li	%[ticket], 0				\n"
-		"4:	b	1b					\n"
-		"	 ll	%[ticket], %[ticket_ptr]		\n"
 		"	.previous					\n"
 		"	.set pop					\n"
 		: [ticket_ptr] "+m" (lock->lock),
 		  [ticket] "=&r" (tmp),
 		  [my_ticket] "=&r" (tmp2),
-		  [now_serving] "=&r" (tmp3));
+		  [now_serving] "=&r" (tmp3)
+		: [inc] "r" (inc));
 	}
 
 	smp_llsc_mb();
diff --git a/arch/mips/include/asm/spinlock_types.h b/arch/mips/include/asm/spinlock_types.h
index ee197c2..c52f360 100644
--- a/arch/mips/include/asm/spinlock_types.h
+++ b/arch/mips/include/asm/spinlock_types.h
@@ -5,16 +5,28 @@
 # error "please don't include this file directly"
 #endif
 
-typedef struct {
+#include <linux/types.h>
+
+#include <asm/byteorder.h>
+
+typedef union {
 	/*
-	 * bits  0..13: serving_now
-	 * bits 14    : junk data
-	 * bits 15..28: ticket
+	 * bits  0..15 : serving_now
+	 * bits 16..31 : ticket
 	 */
-	unsigned int lock;
+	u32 lock;
+	struct {
+#ifdef __BIG_ENDIAN
+		u16 ticket;
+		u16 serving_now;
+#else
+		u16 serving_now;
+		u16 ticket;
+#endif
+	} h;
 } arch_spinlock_t;
 
-#define __ARCH_SPIN_LOCK_UNLOCKED	{ 0 }
+#define __ARCH_SPIN_LOCK_UNLOCKED	{ .lock = 0 }
 
 typedef struct {
 	volatile unsigned int lock;
-- 
1.6.0.6
