Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Feb 2017 15:50:49 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:10566 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993543AbdBWOujNVk07 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Feb 2017 15:50:39 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 9F621C937C6F9;
        Thu, 23 Feb 2017 14:50:29 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 23 Feb 2017 14:50:32 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        "Maciej W . Rozycki" <macro@imgtec.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] MIPS: End spinlocks with .insn
Date:   Thu, 23 Feb 2017 14:50:24 +0000
Message-ID: <dea55f438343246636ca4b033cd8cdfef5f45b0d.1487861280.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.11.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56889
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

From: Paul Burton <paul.burton@imgtec.com>

When building for microMIPS we need to ensure that the assembler always
knows that there is code at the target of a branch or jump. Recent
toolchains will fail to link a microMIPS kernel when this isn't the case
due to what it thinks is a branch to non-microMIPS code.

mips-mti-linux-gnu-ld kernel/built-in.o: .spinlock.text+0x2fc: Unsupported branch between ISA modes.
mips-mti-linux-gnu-ld final link failed: Bad value

This is due to inline assembly labels in spinlock.h not being followed
by an instruction mnemonic, either due to a .subsection pseudo-op or the
end of the inline asm block.

Fix this with a .insn direction after such labels.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Maciej W. Rozycki <macro@imgtec.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
---
 arch/mips/include/asm/spinlock.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/spinlock.h b/arch/mips/include/asm/spinlock.h
index f485afe51514..a8df44d60607 100644
--- a/arch/mips/include/asm/spinlock.h
+++ b/arch/mips/include/asm/spinlock.h
@@ -127,7 +127,7 @@ static inline void arch_spin_lock(arch_spinlock_t *lock)
 		"	andi	%[ticket], %[ticket], 0xffff		\n"
 		"	bne	%[ticket], %[my_ticket], 4f		\n"
 		"	 subu	%[ticket], %[my_ticket], %[ticket]	\n"
-		"2:							\n"
+		"2:	.insn						\n"
 		"	.subsection 2					\n"
 		"4:	andi	%[ticket], %[ticket], 0xffff		\n"
 		"	sll	%[ticket], 5				\n"
@@ -202,7 +202,7 @@ static inline unsigned int arch_spin_trylock(arch_spinlock_t *lock)
 		"	sc	%[ticket], %[ticket_ptr]		\n"
 		"	beqz	%[ticket], 1b				\n"
 		"	 li	%[ticket], 1				\n"
-		"2:							\n"
+		"2:	.insn						\n"
 		"	.subsection 2					\n"
 		"3:	b	2b					\n"
 		"	 li	%[ticket], 0				\n"
@@ -382,7 +382,7 @@ static inline int arch_read_trylock(arch_rwlock_t *rw)
 		"	.set	reorder					\n"
 		__WEAK_LLSC_MB
 		"	li	%2, 1					\n"
-		"2:							\n"
+		"2:	.insn						\n"
 		: "=" GCC_OFF_SMALL_ASM() (rw->lock), "=&r" (tmp), "=&r" (ret)
 		: GCC_OFF_SMALL_ASM() (rw->lock)
 		: "memory");
@@ -422,7 +422,7 @@ static inline int arch_write_trylock(arch_rwlock_t *rw)
 			"	lui	%1, 0x8000			\n"
 			"	sc	%1, %0				\n"
 			"	li	%2, 1				\n"
-			"2:						\n"
+			"2:	.insn					\n"
 			: "=" GCC_OFF_SMALL_ASM() (rw->lock), "=&r" (tmp),
 			  "=&r" (ret)
 			: GCC_OFF_SMALL_ASM() (rw->lock)
-- 
git-series 0.8.10
