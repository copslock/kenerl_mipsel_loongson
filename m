Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Apr 2017 18:41:44 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:35820 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993918AbdDJQkoHLB-J (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 10 Apr 2017 18:40:44 +0200
Received: from localhost (084035110146.static.ipv4.infopact.nl [84.35.110.146])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E55434A3;
        Mon, 10 Apr 2017 16:40:37 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Burton <paul.burton@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        "Maciej W. Rozycki" <macro@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-mips@linux-mips.org
Subject: [PATCH 4.4 29/32] MIPS: End spinlocks with .insn
Date:   Mon, 10 Apr 2017 18:39:19 +0200
Message-Id: <20170410163843.357764261@linuxfoundation.org>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20170410163839.055472822@linuxfoundation.org>
References: <20170410163839.055472822@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57640
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.4-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/include/asm/spinlock.h |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/arch/mips/include/asm/spinlock.h
+++ b/arch/mips/include/asm/spinlock.h
@@ -112,7 +112,7 @@ static inline void arch_spin_lock(arch_s
 		"	andi	%[ticket], %[ticket], 0xffff		\n"
 		"	bne	%[ticket], %[my_ticket], 4f		\n"
 		"	 subu	%[ticket], %[my_ticket], %[ticket]	\n"
-		"2:							\n"
+		"2:	.insn						\n"
 		"	.subsection 2					\n"
 		"4:	andi	%[ticket], %[ticket], 0xffff		\n"
 		"	sll	%[ticket], 5				\n"
@@ -187,7 +187,7 @@ static inline unsigned int arch_spin_try
 		"	sc	%[ticket], %[ticket_ptr]		\n"
 		"	beqz	%[ticket], 1b				\n"
 		"	 li	%[ticket], 1				\n"
-		"2:							\n"
+		"2:	.insn						\n"
 		"	.subsection 2					\n"
 		"3:	b	2b					\n"
 		"	 li	%[ticket], 0				\n"
@@ -367,7 +367,7 @@ static inline int arch_read_trylock(arch
 		"	.set	reorder					\n"
 		__WEAK_LLSC_MB
 		"	li	%2, 1					\n"
-		"2:							\n"
+		"2:	.insn						\n"
 		: "=" GCC_OFF_SMALL_ASM() (rw->lock), "=&r" (tmp), "=&r" (ret)
 		: GCC_OFF_SMALL_ASM() (rw->lock)
 		: "memory");
@@ -407,7 +407,7 @@ static inline int arch_write_trylock(arc
 			"	lui	%1, 0x8000			\n"
 			"	sc	%1, %0				\n"
 			"	li	%2, 1				\n"
-			"2:						\n"
+			"2:	.insn					\n"
 			: "=" GCC_OFF_SMALL_ASM() (rw->lock), "=&r" (tmp),
 			  "=&r" (ret)
 			: GCC_OFF_SMALL_ASM() (rw->lock)
