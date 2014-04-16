Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Apr 2014 14:55:34 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.89.28.114]:59668 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6837072AbaDPMzYQ8LY7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Apr 2014 14:55:24 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 2884C86F2CA78
        for <linux-mips@linux-mips.org>; Wed, 16 Apr 2014 13:55:14 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Wed, 16 Apr 2014 13:55:15 +0100
Received: from pburton-linux.le.imgtec.org (192.168.154.79) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Wed, 16 Apr 2014 13:55:15 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 05/39] MIPS: PM: Implement PM helper macros
Date:   Wed, 16 Apr 2014 13:52:56 +0100
Message-ID: <1397652810-4336-6-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1397652810-4336-1-git-send-email-paul.burton@imgtec.com>
References: <1397652810-4336-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.79]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39812
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

From: James Hogan <james.hogan@imgtec.com>

Implement assembler helper macros in asm/pm.h for platform code to use
for saving context across low power states - for example suspend to RAM
or powered down cpuidle states. Macros are provided for saving and
restoring the main CPU context used by C code and doing important
configuration which must be done very early during resume. Notably EVA
needs segmentation control registers to be restored before the stack or
dynamically allocated memory is accessed, so that state is saved in
global data.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
 arch/mips/include/asm/pm.h     | 167 +++++++++++++++++++++++++++++++++++++++++
 arch/mips/kernel/asm-offsets.c |  15 ++++
 arch/mips/kernel/pm.c          |   4 +
 3 files changed, 186 insertions(+)
 create mode 100644 arch/mips/include/asm/pm.h

diff --git a/arch/mips/include/asm/pm.h b/arch/mips/include/asm/pm.h
new file mode 100644
index 0000000..268546f
--- /dev/null
+++ b/arch/mips/include/asm/pm.h
@@ -0,0 +1,167 @@
+/*
+ * Copyright (C) 2014 Imagination Technologies Ltd
+ *
+ * This program is free software; you can redistribute	it and/or modify it
+ * under  the terms of	the GNU General	 Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ * PM helper macros for CPU power off (e.g. Suspend-to-RAM).
+ */
+
+#ifndef __ASM_PM_H
+#define __ASM_PM_H
+
+#ifdef __ASSEMBLY__
+
+#include <asm/asm-offsets.h>
+#include <asm/asm.h>
+#include <asm/mipsregs.h>
+#include <asm/regdef.h>
+
+/* Save CPU state to stack for suspend to RAM */
+.macro SUSPEND_SAVE_REGS
+	subu	sp, PT_SIZE
+	/* Call preserved GPRs */
+	LONG_S	$16, PT_R16(sp)
+	LONG_S	$17, PT_R17(sp)
+	LONG_S	$18, PT_R18(sp)
+	LONG_S	$19, PT_R19(sp)
+	LONG_S	$20, PT_R20(sp)
+	LONG_S	$21, PT_R21(sp)
+	LONG_S	$22, PT_R22(sp)
+	LONG_S	$23, PT_R23(sp)
+	LONG_S	$28, PT_R28(sp)
+	LONG_S	$30, PT_R30(sp)
+	LONG_S	$31, PT_R31(sp)
+	/* A couple of CP0 registers with space in pt_regs */
+	mfc0	k0, CP0_STATUS
+	LONG_S	k0, PT_STATUS(sp)
+#ifdef CONFIG_MIPS_MT_SMTC
+	mfc0	k0, CP0_TCSTATUS
+	LONG_S	k0, PT_TCSTATUS(sp)
+#endif
+.endm
+
+/* Restore CPU state from stack after resume from RAM */
+.macro RESUME_RESTORE_REGS_RETURN
+	.set	push
+	.set	noreorder
+	/* A couple of CP0 registers with space in pt_regs */
+	LONG_L	k0, PT_STATUS(sp)
+	mtc0	k0, CP0_STATUS
+#ifdef CONFIG_MIPS_MT_SMTC
+	LONG_L	k0, PT_TCSTATUS(sp)
+	mtc0	k0, CP0_TCSTATUS
+#endif
+	/* Call preserved GPRs */
+	LONG_L	$16, PT_R16(sp)
+	LONG_L	$17, PT_R17(sp)
+	LONG_L	$18, PT_R18(sp)
+	LONG_L	$19, PT_R19(sp)
+	LONG_L	$20, PT_R20(sp)
+	LONG_L	$21, PT_R21(sp)
+	LONG_L	$22, PT_R22(sp)
+	LONG_L	$23, PT_R23(sp)
+	LONG_L	$28, PT_R28(sp)
+	LONG_L	$30, PT_R30(sp)
+	LONG_L	$31, PT_R31(sp)
+	/* Pop and return */
+	jr	ra
+	 addiu	sp, PT_SIZE
+	.set	pop
+.endm
+
+/* Get address of static suspend state into t1 */
+.macro LA_STATIC_SUSPEND
+	la	t1, mips_static_suspend_state
+.endm
+
+/* Save important CPU state for early restoration to global data */
+.macro SUSPEND_SAVE_STATIC
+#ifdef CONFIG_EVA
+	/*
+	 * Segment configuration is saved in global data where it can be easily
+	 * reloaded without depending on the segment configuration.
+	 */
+	mfc0	k0, CP0_PAGEMASK, 2	/* SegCtl0 */
+	LONG_S	k0, SSS_SEGCTL0(t1)
+	mfc0	k0, CP0_PAGEMASK, 3	/* SegCtl1 */
+	LONG_S	k0, SSS_SEGCTL1(t1)
+	mfc0	k0, CP0_PAGEMASK, 4	/* SegCtl2 */
+	LONG_S	k0, SSS_SEGCTL2(t1)
+#endif
+	/* save stack pointer (pointing to GPRs) */
+	LONG_S	sp, SSS_SP(t1)
+.endm
+
+/* Restore important CPU state early from global data */
+.macro RESUME_RESTORE_STATIC
+#ifdef CONFIG_EVA
+	/*
+	 * Segment configuration must be restored prior to any access to
+	 * allocated memory, as it may reside outside of the legacy kernel
+	 * segments.
+	 */
+	LONG_L	k0, SSS_SEGCTL0(t1)
+	mtc0	k0, CP0_PAGEMASK, 2	/* SegCtl0 */
+	LONG_L	k0, SSS_SEGCTL1(t1)
+	mtc0	k0, CP0_PAGEMASK, 3	/* SegCtl1 */
+	LONG_L	k0, SSS_SEGCTL2(t1)
+	mtc0	k0, CP0_PAGEMASK, 4	/* SegCtl2 */
+	tlbw_use_hazard
+#endif
+	/* restore stack pointer (pointing to GPRs) */
+	LONG_L	sp, SSS_SP(t1)
+.endm
+
+/* flush caches to make sure context has reached memory */
+.macro SUSPEND_CACHE_FLUSH
+	.extern	__wback_cache_all
+	.set	push
+	.set	noreorder
+	la	t1, __wback_cache_all
+	LONG_L	t0, 0(t1)
+	jalr	t0
+	 nop
+	.set	pop
+ .endm
+
+/* Save suspend state and flush data caches to RAM */
+.macro SUSPEND_SAVE
+	SUSPEND_SAVE_REGS
+	LA_STATIC_SUSPEND
+	SUSPEND_SAVE_STATIC
+	SUSPEND_CACHE_FLUSH
+.endm
+
+/* Restore saved state after resume from RAM and return */
+.macro RESUME_RESTORE_RETURN
+	LA_STATIC_SUSPEND
+	RESUME_RESTORE_STATIC
+	RESUME_RESTORE_REGS_RETURN
+.endm
+
+#else /* __ASSEMBLY__ */
+
+/**
+ * struct mips_static_suspend_state - Core saved CPU state across S2R.
+ * @segctl:	CP0 Segment control registers.
+ * @sp:		Stack frame where GP register context is saved.
+ *
+ * This structure contains minimal CPU state that must be saved in static kernel
+ * data in order to be able to restore the rest of the state. This includes
+ * segmentation configuration in the case of EVA being enabled, as they must be
+ * restored prior to any kmalloc'd memory being referenced (even the stack
+ * pointer).
+ */
+struct mips_static_suspend_state {
+#ifdef CONFIG_EVA
+	unsigned long segctl[3];
+#endif
+	unsigned long sp;
+};
+
+#endif /* !__ASSEMBLY__ */
+
+#endif /* __ASM_PM_HELPERS_H */
diff --git a/arch/mips/kernel/asm-offsets.c b/arch/mips/kernel/asm-offsets.c
index 0ea75c2..e085cde 100644
--- a/arch/mips/kernel/asm-offsets.c
+++ b/arch/mips/kernel/asm-offsets.c
@@ -14,6 +14,7 @@
 #include <linux/mm.h>
 #include <linux/kbuild.h>
 #include <linux/suspend.h>
+#include <asm/pm.h>
 #include <asm/ptrace.h>
 #include <asm/processor.h>
 #include <asm/smp-cps.h>
@@ -404,6 +405,20 @@ void output_pbe_defines(void)
 }
 #endif
 
+#ifdef CONFIG_CPU_PM
+void output_pm_defines(void)
+{
+	COMMENT(" PM offsets. ");
+#ifdef CONFIG_EVA
+	OFFSET(SSS_SEGCTL0,	mips_static_suspend_state, segctl[0]);
+	OFFSET(SSS_SEGCTL1,	mips_static_suspend_state, segctl[1]);
+	OFFSET(SSS_SEGCTL2,	mips_static_suspend_state, segctl[2]);
+#endif
+	OFFSET(SSS_SP,		mips_static_suspend_state, sp);
+	BLANK();
+}
+#endif
+
 void output_kvm_defines(void)
 {
 	COMMENT(" KVM/MIPS Specfic offsets. ");
diff --git a/arch/mips/kernel/pm.c b/arch/mips/kernel/pm.c
index 112903f..fefdf39 100644
--- a/arch/mips/kernel/pm.c
+++ b/arch/mips/kernel/pm.c
@@ -15,8 +15,12 @@
 #include <asm/dsp.h>
 #include <asm/fpu.h>
 #include <asm/mmu_context.h>
+#include <asm/pm.h>
 #include <asm/watch.h>
 
+/* Used by PM helper macros in asm/pm.h */
+struct mips_static_suspend_state mips_static_suspend_state;
+
 /**
  * mips_cpu_save() - Save general CPU state.
  * Ensures that general CPU context is saved, notably FPU and DSP.
-- 
1.8.5.3
