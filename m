Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 16 Apr 2017 10:07:32 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:58316 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993932AbdDPIFQRO7HO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 16 Apr 2017 10:05:16 +0200
Received: from localhost (LFbn-1-12060-104.w90-92.abo.wanadoo.fr [90.92.122.104])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A01E871F;
        Sun, 16 Apr 2017 08:05:09 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matt Redfearn <matt.redfearn@imgtec.com>,
        "Jason A. Donenfeld" <jason@zx2c4.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Amit Pundir <amit.pundir@linaro.org>
Subject: [PATCH 4.9 19/31] MIPS: Switch to the irq_stack in interrupts
Date:   Sun, 16 Apr 2017 10:04:10 +0200
Message-Id: <20170416080222.813276112@linuxfoundation.org>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20170416080221.808058771@linuxfoundation.org>
References: <20170416080221.808058771@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57696
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matt Redfearn <matt.redfearn@imgtec.com>

commit dda45f701c9d7ad4ac0bb446e3a96f6df9a468d9 upstream.

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
Acked-by: Jason A. Donenfeld <jason@zx2c4.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: James Hogan <james.hogan@imgtec.com>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/14743/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/genex.S |   81 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 76 insertions(+), 5 deletions(-)

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
