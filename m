Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Dec 2016 15:22:47 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:44284 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992735AbcLSOVO52CUh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Dec 2016 15:21:14 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 37D0BA29F6479;
        Mon, 19 Dec 2016 14:21:05 +0000 (GMT)
Received: from mredfearn-linux.le.imgtec.org (10.150.130.83) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Mon, 19 Dec 2016 14:21:08 +0000
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH v3 4/5] MIPS: Switch to the irq_stack in interrupts
Date:   Mon, 19 Dec 2016 14:20:59 +0000
Message-ID: <1482157260-18730-5-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1482157260-18730-1-git-send-email-matt.redfearn@imgtec.com>
References: <1482157260-18730-1-git-send-email-matt.redfearn@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56099
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@imgtec.com
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

When enterring interrupt context via handle_int or except_vec_vi, switch
to the irq_stack of the current CPU if it is not already in use.

The current stack pointer is masked with the thread size and compared to
the base or the irq stack. If it does not match then the stack pointer
is set to the top of that stack, otherwise this is a nested irq being
handled on the irq stack so the stack pointer should be left as it was.

The in-use stack pointer is placed in the callee saved register s1. It
will be saved to the stack when plat_irq_dispatch is invoked and can be
restored once control returns here.

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
---

Changes in v3: None
Changes in v2: None

 arch/mips/kernel/genex.S | 81 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 76 insertions(+), 5 deletions(-)

diff --git a/arch/mips/kernel/genex.S b/arch/mips/kernel/genex.S
index dc0b29612891..0a7ba4b2f687 100644
--- a/arch/mips/kernel/genex.S
+++ b/arch/mips/kernel/genex.S
@@ -187,9 +187,44 @@ NESTED(handle_int, PT_SIZE, sp)
 
 	LONG_L	s0, TI_REGS($28)
 	LONG_S	sp, TI_REGS($28)
-	PTR_LA	ra, ret_from_irq
-	PTR_LA	v0, plat_irq_dispatch
-	jr	v0
+
+	/*
+	 * SAVE_ALL ensures we are using a valid kernel stack for the thread.
+	 * Check if we are already using the IRQ stack.
+	 */
+	move	s1, sp # Preserve the sp
+
+	/* Get IRQ stack for this CPU */
+	ASM_CPUID_MFC0	k0, ASM_SMP_CPUID_REG
+#if defined(CONFIG_32BIT) || defined(KBUILD_64BIT_SYM32)
+	lui	k1, %hi(irq_stack)
+#else
+	lui	k1, %highest(irq_stack)
+	daddiu	k1, %higher(irq_stack)
+	dsll	k1, 16
+	daddiu	k1, %hi(irq_stack)
+	dsll	k1, 16
+#endif
+	LONG_SRL	k0, SMP_CPUID_PTRSHIFT
+	LONG_ADDU	k1, k0
+	LONG_L	t0, %lo(irq_stack)(k1)
+
+	# Check if already on IRQ stack
+	PTR_LI	t1, ~(_THREAD_SIZE-1)
+	and	t1, t1, sp
+	beq	t0, t1, 2f
+
+	/* Switch to IRQ stack */
+	li	t1, _IRQ_STACK_SIZE
+	PTR_ADD sp, t0, t1
+
+2:
+	jal	plat_irq_dispatch
+
+	/* Restore sp */
+	move	sp, s1
+
+	j	ret_from_irq
 #ifdef CONFIG_CPU_MICROMIPS
 	nop
 #endif
@@ -262,8 +297,44 @@ NESTED(except_vec_vi_handler, 0, sp)
 
 	LONG_L	s0, TI_REGS($28)
 	LONG_S	sp, TI_REGS($28)
-	PTR_LA	ra, ret_from_irq
-	jr	v0
+
+	/*
+	 * SAVE_ALL ensures we are using a valid kernel stack for the thread.
+	 * Check if we are already using the IRQ stack.
+	 */
+	move	s1, sp # Preserve the sp
+
+	/* Get IRQ stack for this CPU */
+	ASM_CPUID_MFC0	k0, ASM_SMP_CPUID_REG
+#if defined(CONFIG_32BIT) || defined(KBUILD_64BIT_SYM32)
+	lui	k1, %hi(irq_stack)
+#else
+	lui	k1, %highest(irq_stack)
+	daddiu	k1, %higher(irq_stack)
+	dsll	k1, 16
+	daddiu	k1, %hi(irq_stack)
+	dsll	k1, 16
+#endif
+	LONG_SRL	k0, SMP_CPUID_PTRSHIFT
+	LONG_ADDU	k1, k0
+	LONG_L	t0, %lo(irq_stack)(k1)
+
+	# Check if already on IRQ stack
+	PTR_LI	t1, ~(_THREAD_SIZE-1)
+	and	t1, t1, sp
+	beq	t0, t1, 2f
+
+	/* Switch to IRQ stack */
+	li	t1, _IRQ_STACK_SIZE
+	PTR_ADD sp, t0, t1
+
+2:
+	jal	plat_irq_dispatch
+
+	/* Restore sp */
+	move	sp, s1
+
+	j	ret_from_irq
 	END(except_vec_vi_handler)
 
 /*
-- 
2.7.4
