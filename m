Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Dec 2014 16:17:22 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:4897 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009167AbaLRPMBQO5Rh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Dec 2014 16:12:01 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 657E169A4DCA8
        for <linux-mips@linux-mips.org>; Thu, 18 Dec 2014 15:11:52 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 18 Dec 2014 15:11:55 +0000
Received: from mchandras-linux.le.imgtec.org (192.168.154.125) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Thu, 18 Dec 2014 15:11:54 +0000
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>,
        Matthew Fortune <Matthew.Fortune@imgtec.com>
Subject: [PATCH RFC 23/67] MIPS: asm: spinlock: Update asm constrains for MIPS R6 support
Date:   Thu, 18 Dec 2014 15:09:32 +0000
Message-ID: <1418915416-3196-24-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.2.0
In-Reply-To: <1418915416-3196-1-git-send-email-markos.chandras@imgtec.com>
References: <1418915416-3196-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.125]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44758
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

MIPS R6 changed the opcodes for LL/SC instructions and reduced the
offset field to 9-bits. This has some undesired effects with the "m"
constrain since it implies a 16-bit immediate. As a result of which,
add a register ("r") constrain as well to make sure the entire address
is loaded to a register before the LL/SC operations.

Cc: Matthew Fortune <Matthew.Fortune@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/include/asm/spinlock.h | 58 +++++++++++++++++++++-------------------
 1 file changed, 30 insertions(+), 28 deletions(-)

diff --git a/arch/mips/include/asm/spinlock.h b/arch/mips/include/asm/spinlock.h
index 78d201fb6c87..f63b3543c1a4 100644
--- a/arch/mips/include/asm/spinlock.h
+++ b/arch/mips/include/asm/spinlock.h
@@ -98,9 +98,9 @@ static inline void arch_spin_lock(arch_spinlock_t *lock)
 		"	.set push		# arch_spin_lock	\n"
 		"	.set noreorder					\n"
 		"							\n"
-		"1:	ll	%[ticket], %[ticket_ptr]		\n"
+		"1:	ll	%[ticket], 0(%[ticket_ptr])		\n"
 		"	addu	%[my_ticket], %[ticket], %[inc]		\n"
-		"	sc	%[my_ticket], %[ticket_ptr]		\n"
+		"	sc	%[my_ticket], 0(%[ticket_ptr])		\n"
 		"	beqz	%[my_ticket], 1b			\n"
 		"	 srl	%[my_ticket], %[ticket], 16		\n"
 		"	andi	%[ticket], %[ticket], 0xffff		\n"
@@ -121,11 +121,12 @@ static inline void arch_spin_lock(arch_spinlock_t *lock)
 		"	 subu	%[ticket], %[ticket], 1			\n"
 		"	.previous					\n"
 		"	.set pop					\n"
-		: [ticket_ptr] "+m" (lock->lock),
+		: "+m" (lock->lock),
 		  [serving_now_ptr] "+m" (lock->h.serving_now),
 		  [ticket] "=&r" (tmp),
 		  [my_ticket] "=&r" (my_ticket)
-		: [inc] "r" (inc));
+		: [inc] "r" (inc),
+		  [ticket_ptr] "r" (&lock->lock));
 	}
 
 	smp_llsc_mb();
@@ -173,12 +174,12 @@ static inline unsigned int arch_spin_trylock(arch_spinlock_t *lock)
 		"	.set push		# arch_spin_trylock	\n"
 		"	.set noreorder					\n"
 		"							\n"
-		"1:	ll	%[ticket], %[ticket_ptr]		\n"
+		"1:	ll	%[ticket], 0(%[ticket_ptr])		\n"
 		"	srl	%[my_ticket], %[ticket], 16		\n"
 		"	andi	%[now_serving], %[ticket], 0xffff	\n"
 		"	bne	%[my_ticket], %[now_serving], 3f	\n"
 		"	 addu	%[ticket], %[ticket], %[inc]		\n"
-		"	sc	%[ticket], %[ticket_ptr]		\n"
+		"	sc	%[ticket], 0(%[ticket_ptr])		\n"
 		"	beqz	%[ticket], 1b				\n"
 		"	 li	%[ticket], 1				\n"
 		"2:							\n"
@@ -187,11 +188,12 @@ static inline unsigned int arch_spin_trylock(arch_spinlock_t *lock)
 		"	 li	%[ticket], 0				\n"
 		"	.previous					\n"
 		"	.set pop					\n"
-		: [ticket_ptr] "+m" (lock->lock),
+		: "+m" (lock->lock),
 		  [ticket] "=&r" (tmp),
 		  [my_ticket] "=&r" (tmp2),
 		  [now_serving] "=&r" (tmp3)
-		: [inc] "r" (inc));
+		: [inc] "r" (inc),
+		  [ticket_ptr] "r" (&lock->lock));
 	}
 
 	smp_llsc_mb();
@@ -240,12 +242,12 @@ static inline void arch_read_lock(arch_rwlock_t *rw)
 	} else {
 		do {
 			__asm__ __volatile__(
-			"1:	ll	%1, %2	# arch_read_lock	\n"
+			"1:	ll	%1, 0(%2)# arch_read_lock	\n"
 			"	bltz	%1, 1b				\n"
 			"	 addu	%1, 1				\n"
-			"2:	sc	%1, %0				\n"
-			: "=m" (rw->lock), "=&r" (tmp)
-			: "m" (rw->lock)
+			"2:	sc	%1, 0(%2)			\n"
+			: "+m" (rw->lock), "=&r" (tmp)
+			: "r" (&rw->lock)
 			: "memory");
 		} while (unlikely(!tmp));
 	}
@@ -274,11 +276,11 @@ static inline void arch_read_unlock(arch_rwlock_t *rw)
 	} else {
 		do {
 			__asm__ __volatile__(
-			"1:	ll	%1, %2	# arch_read_unlock	\n"
+			"1:	ll	%1, 0(%2)# arch_read_unlock	\n"
 			"	sub	%1, 1				\n"
-			"	sc	%1, %0				\n"
-			: "=m" (rw->lock), "=&r" (tmp)
-			: "m" (rw->lock)
+			"	sc	%1, 0(%2)			\n"
+			: "+m" (rw->lock), "=&r" (tmp)
+			: "r" (&rw->lock)
 			: "memory");
 		} while (unlikely(!tmp));
 	}
@@ -304,12 +306,12 @@ static inline void arch_write_lock(arch_rwlock_t *rw)
 	} else {
 		do {
 			__asm__ __volatile__(
-			"1:	ll	%1, %2	# arch_write_lock	\n"
+			"1:	ll	%1, 0(%2)# arch_write_lock	\n"
 			"	bnez	%1, 1b				\n"
 			"	 lui	%1, 0x8000			\n"
-			"2:	sc	%1, %0				\n"
-			: "=m" (rw->lock), "=&r" (tmp)
-			: "m" (rw->lock)
+			"2:	sc	%1, 0(%2)			\n"
+			: "+m" (rw->lock), "=&r" (tmp)
+			: "r" (&rw->lock)
 			: "memory");
 		} while (unlikely(!tmp));
 	}
@@ -355,18 +357,18 @@ static inline int arch_read_trylock(arch_rwlock_t *rw)
 		__asm__ __volatile__(
 		"	.set	noreorder	# arch_read_trylock	\n"
 		"	li	%2, 0					\n"
-		"1:	ll	%1, %3					\n"
+		"1:	ll	%1, 0(%3)				\n"
 		"	bltz	%1, 2f					\n"
 		"	 addu	%1, 1					\n"
-		"	sc	%1, %0					\n"
+		"	sc	%1, 0(%3)				\n"
 		"	beqz	%1, 1b					\n"
 		"	 nop						\n"
 		"	.set	reorder					\n"
 		__WEAK_LLSC_MB
 		"	li	%2, 1					\n"
 		"2:							\n"
-		: "=m" (rw->lock), "=&r" (tmp), "=&r" (ret)
-		: "m" (rw->lock)
+		: "+m" (rw->lock), "=&r" (tmp), "=&r" (ret)
+		: "r" (&rw->lock)
 		: "memory");
 	}
 
@@ -398,15 +400,15 @@ static inline int arch_write_trylock(arch_rwlock_t *rw)
 	} else {
 		do {
 			__asm__ __volatile__(
-			"	ll	%1, %3	# arch_write_trylock	\n"
+			"	ll	%1, 0(%3)# arch_write_trylock	\n"
 			"	li	%2, 0				\n"
 			"	bnez	%1, 2f				\n"
 			"	lui	%1, 0x8000			\n"
-			"	sc	%1, %0				\n"
+			"	sc	%1, 0(%3)			\n"
 			"	li	%2, 1				\n"
 			"2:						\n"
-			: "=m" (rw->lock), "=&r" (tmp), "=&r" (ret)
-			: "m" (rw->lock)
+			: "+m" (rw->lock), "=&r" (tmp), "=&r" (ret)
+			: "r" (&rw->lock)
 			: "memory");
 		} while (unlikely(!tmp));
 
-- 
2.2.0
