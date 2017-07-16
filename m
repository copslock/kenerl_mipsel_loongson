Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 16 Jul 2017 15:58:13 +0200 (CEST)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40337 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993950AbdGPN5sJHKO8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 16 Jul 2017 15:57:48 +0200
Received: from [2a02:8011:400e:2:6f00:88c8:c921:d332] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1dWk3C-00057P-Vv; Sun, 16 Jul 2017 14:57:35 +0100
Received: from ben by deadeye with local (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1dWk3C-0002A8-F6; Sun, 16 Jul 2017 14:57:34 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Ralf Baechle" <ralf@linux-mips.org>,
        "Paul Burton" <paul.burton@imgtec.com>,
        "Ingo Molnar" <mingo@redhat.com>,
        "Maciej W. Rozycki" <macro@imgtec.com>,
        "James Hogan" <james.hogan@imgtec.com>, linux-mips@linux-mips.org,
        "Peter Zijlstra" <peterz@infradead.org>
Date:   Sun, 16 Jul 2017 14:56:46 +0100
Message-ID: <lsq.1500213406.649111933@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 020/178] MIPS: End spinlocks with .insn
In-Reply-To: <lsq.1500213404.466735591@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59115
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ben@decadent.org.uk
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

3.16.46-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Burton <paul.burton@imgtec.com>

commit 4b5347a24a0f2d3272032c120664b484478455de upstream.

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
Reviewed-by: Maciej W. Rozycki <macro@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/15325/
Signed-off-by: James Hogan <james.hogan@imgtec.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/include/asm/spinlock.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/arch/mips/include/asm/spinlock.h
+++ b/arch/mips/include/asm/spinlock.h
@@ -73,7 +73,7 @@ static inline void arch_spin_lock(arch_s
 		"	andi	%[ticket], %[ticket], 0xffff		\n"
 		"	bne	%[ticket], %[my_ticket], 4f		\n"
 		"	 subu	%[ticket], %[my_ticket], %[ticket]	\n"
-		"2:							\n"
+		"2:	.insn						\n"
 		"	.subsection 2					\n"
 		"4:	andi	%[ticket], %[ticket], 0xffff		\n"
 		"	sll	%[ticket], 5				\n"
@@ -181,7 +181,7 @@ static inline unsigned int arch_spin_try
 		"	sc	%[ticket], %[ticket_ptr]		\n"
 		"	beqz	%[ticket], 1b				\n"
 		"	 li	%[ticket], 1				\n"
-		"2:							\n"
+		"2:	.insn						\n"
 		"	.subsection 2					\n"
 		"3:	b	2b					\n"
 		"	 li	%[ticket], 0				\n"
@@ -364,7 +364,7 @@ static inline int arch_read_trylock(arch
 		"	.set	reorder					\n"
 		__WEAK_LLSC_MB
 		"	li	%2, 1					\n"
-		"2:							\n"
+		"2:	.insn						\n"
 		: "=m" (rw->lock), "=&r" (tmp), "=&r" (ret)
 		: "m" (rw->lock)
 		: "memory");
@@ -404,7 +404,7 @@ static inline int arch_write_trylock(arc
 			"	lui	%1, 0x8000			\n"
 			"	sc	%1, %0				\n"
 			"	li	%2, 1				\n"
-			"2:						\n"
+			"2:	.insn					\n"
 			: "=m" (rw->lock), "=&r" (tmp), "=&r" (ret)
 			: "m" (rw->lock)
 			: "memory");
