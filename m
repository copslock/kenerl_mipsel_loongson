Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Apr 2017 15:53:56 +0200 (CEST)
Received: from mail-pg0-x233.google.com ([IPv6:2607:f8b0:400e:c05::233]:33472
        "EHLO mail-pg0-x233.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993907AbdDFNwlVZI4x (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Apr 2017 15:52:41 +0200
Received: by mail-pg0-x233.google.com with SMTP id x125so37119743pgb.0
        for <linux-mips@linux-mips.org>; Thu, 06 Apr 2017 06:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bqJHojYH4zH27VAYD/IIz6NoUGefaNIbta7z6UHc7+U=;
        b=Z2dLnJ6+CfMzzWIqTVfV04BF/8ZaXDmzXlfANvLdUSAAmAO2MhfWO4bjjqtRR5p51j
         fAiwt/w4rmDQVwYNcRkhrFEGiP4emRuIywitSgy49eKu/ob79nQPFRe+4OCKK2Yf14YY
         eQzSb0ZZ1QFc/FYf+VJp7lncBjrv1ql4M5uZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bqJHojYH4zH27VAYD/IIz6NoUGefaNIbta7z6UHc7+U=;
        b=nMFL9e83winj7bBOwkV1tVLfk0Mm0MB9Uq64MkhaAwyMq292RIq1/5xJNHti2xhzm9
         E126C9BTX4Wzg8orA3LCQn4pku8yi4bNWSiMLILN5wAAWbfOqcTIfKA89rS7VFCBSNwR
         k6frY0EafaKirJpvh8vwhAZqbAu8sFzC2BTK6DploqbfNouhQX2R9puOn5I5kk9++M+S
         bn4GfgNGx1U2Pb8iXtnUxCfldPQdKdBn4o9CWcXv1pnieSy9WoCxy4Cj3/nkwV9S/H8B
         09fjMSEcjLQmOqxsDJlJqeX0D+0MrdspTVwGXmk0v7Dq2uZ99nodG2GrE+tmBLZSsnr9
         pHpQ==
X-Gm-Message-State: AFeK/H2VbLD9AOiLMKeKMtrZ0ZvmOuBoWpTH38BqEen0MguzA7VsxdJxvnTor6Fkm80r2voK
X-Received: by 10.98.49.129 with SMTP id x123mr14249822pfx.45.1491486755449;
        Thu, 06 Apr 2017 06:52:35 -0700 (PDT)
Received: from localhost.localdomain ([106.51.240.246])
        by smtp.gmail.com with ESMTPSA id v11sm4187210pfi.50.2017.04.06.06.52.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 06 Apr 2017 06:52:34 -0700 (PDT)
From:   Amit Pundir <amit.pundir@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     stable@vger.kernel.org, james.hogan@imgtec.com,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Burton <paul.burton@imgtec.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH for-4.10 4/6] MIPS: Switch to the irq_stack in interrupts
Date:   Thu,  6 Apr 2017 19:22:12 +0530
Message-Id: <1491486734-15668-5-git-send-email-amit.pundir@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1491486734-15668-1-git-send-email-amit.pundir@linaro.org>
References: <1491486734-15668-1-git-send-email-amit.pundir@linaro.org>
Return-Path: <amit.pundir@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57604
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: amit.pundir@linaro.org
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

From: Matt Redfearn <matt.redfearn@imgtec.com>

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
(cherry picked from commit dda45f701c9d7ad4ac0bb446e3a96f6df9a468d9)
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
---
 arch/mips/kernel/genex.S | 81 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 76 insertions(+), 5 deletions(-)

diff --git a/arch/mips/kernel/genex.S b/arch/mips/kernel/genex.S
index dc0b296..0a7ba4b 100644
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
