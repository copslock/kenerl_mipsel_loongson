Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Jan 2015 08:09:13 +0100 (CET)
Received: from jaguar.aricent.com ([180.151.2.24]:41169 "EHLO
        jaguar.aricent.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27014482AbbALHIJPwRlf convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 Jan 2015 08:08:09 +0100
Received: from jaguar.aricent.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1B463218BA8;
        Mon, 12 Jan 2015 12:38:02 +0530 (IST)
Received: from GUREXHT01.ASIAN.AD.ARICENT.COM (unknown [10.203.171.136])
        by jaguar.aricent.com (Postfix) with ESMTPS id 04064218B95;
        Mon, 12 Jan 2015 12:38:02 +0530 (IST)
Received: from imsseuq.aricent.com (10.203.171.248) by
 GUREXHT01.ASIAN.AD.ARICENT.COM (10.203.171.136) with Microsoft SMTP Server id
 8.3.342.0; Mon, 12 Jan 2015 12:38:00 +0530
Received: from h2512.localdomain ([172.16.116.228])     by imsseuq.aricent.com
 (8.13.1/8.13.1) with ESMTP id t0C6VBrC019509;  Mon, 12 Jan 2015 12:01:32 +0530
From:   Abhishek Paliwal <abhishek.paliwal@aricent.com>
To:     <kexin.hao@windriver.com>, <bo.liu@windriver.com>
CC:     Chandrakala.Chavva@caviumnetworks.com, rakesh.garg@aricent.com,
        Abhishek Paliwal <abhishek.paliwal@aricent.com>,
        David Daney <david.daney@cavium.com>,
        Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        linux-mips@linux-mips.org, James Hogan <james.hogan@imgtec.com>,
        kvm@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 2/9] MIPS OCTEON Enable use of FPU
Date:   Mon, 12 Jan 2015 12:36:18 +0530
Message-ID: <1421046385-2535-3-git-send-email-abhishek.paliwal@aricent.com>
X-Mailer: git-send-email 1.8.1.4
In-Reply-To: <1421046385-2535-1-git-send-email-abhishek.paliwal@aricent.com>
References: <1421046385-2535-1-git-send-email-abhishek.paliwal@aricent.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8BIT
X-TM-AS-MML: disable
Return-Path: <abhishek.paliwal@aricent.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45079
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abhishek.paliwal@aricent.com
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

commit  a36d8225bceba4b7be47ade34d175945f85cffbc upstream

Some versions of the assembler will not assemble CFC1 for OCTEON, so override the ISA for these.

Add r4k_fpu.o to handle low level FPU initialization.

Modify octeon_switch.S to save the FPU registers. And include r4k_switch.S to pick up more FPU support.

Get rid of "#define cpu_has_fpu 0"

Signed-off-by: David Daney <david.daney@cavium.com>
Signed-off-by: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
Cc: linux-mips@linux-mips.org
Cc: James Hogan <james.hogan@imgtec.com>
Cc: kvm@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/7006/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Abhishek Paliwal <abhishek.paliwal@aricent.com>
---
 .../asm/mach-cavium-octeon/cpu-feature-overrides.h |  1 -
 arch/mips/kernel/Makefile                          |  2 +-
 arch/mips/kernel/branch.c                          |  6 +-
 arch/mips/kernel/octeon_switch.S                   | 85 ++++++++++++++++------
 arch/mips/kernel/r4k_switch.S                      |  3 +
 arch/mips/math-emu/cp1emu.c                        | 12 ++-
 6 files changed, 80 insertions(+), 29 deletions(-)

diff --git a/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h b/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h
index 94ed063..cf80228 100644
--- a/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h
@@ -22,7 +22,6 @@
 #define cpu_has_3k_cache       0
 #define cpu_has_4k_cache       0
 #define cpu_has_tx39_cache     0
-#define cpu_has_fpu            0
 #define cpu_has_counter                1
 #define cpu_has_watch          1
 #define cpu_has_divec          1
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index 26c6175..f76cf1e 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -42,7 +42,7 @@ obj-$(CONFIG_CPU_R4K_FPU)     += r4k_fpu.o r4k_switch.o
 obj-$(CONFIG_CPU_R3000)                += r2300_fpu.o r2300_switch.o
 obj-$(CONFIG_CPU_R6000)                += r6000_fpu.o r4k_switch.o
 obj-$(CONFIG_CPU_TX39XX)       += r2300_fpu.o r2300_switch.o
-obj-$(CONFIG_CPU_CAVIUM_OCTEON) += octeon_switch.o
+obj-$(CONFIG_CPU_CAVIUM_OCTEON) += r4k_fpu.o octeon_switch.o

 obj-$(CONFIG_SMP)              += smp.o
 obj-$(CONFIG_SMP_UP)           += smp-up.o
diff --git a/arch/mips/kernel/branch.c b/arch/mips/kernel/branch.c
index 4d78bf4..418865f 100644
--- a/arch/mips/kernel/branch.c
+++ b/arch/mips/kernel/branch.c
@@ -366,7 +366,11 @@ int __compute_return_epc_for_insn(struct pt_regs *regs,
        case cop1_op:
                preempt_disable();
                if (is_fpu_owner())
-                       asm volatile("cfc1\t%0,$31" : "=r" (fcr31));
+                       asm volatile(
+                               ".set push\n"
+                               "\t.set mips1\n"
+                               "\tcfc1\t%0,$31\n"
+                               "\t.set pop" : "=r" (fcr31));
                else
                        fcr31 = current->thread.fpu.fcr31;
                preempt_enable();
diff --git a/arch/mips/kernel/octeon_switch.S b/arch/mips/kernel/octeon_switch.S
index 029e002..0f1163a 100644
--- a/arch/mips/kernel/octeon_switch.S
+++ b/arch/mips/kernel/octeon_switch.S
@@ -10,24 +10,11 @@
  * Copyright (C) 2000 MIPS Technologies, Inc.
  *    written by Carsten Langgaard, carstenl@mips.com
  */
-#include <asm/asm.h>
-#include <asm/cachectl.h>
-#include <asm/fpregdef.h>
-#include <asm/mipsregs.h>
-#include <asm/asm-offsets.h>
-#include <asm/pgtable-bits.h>
-#include <asm/regdef.h>
-#include <asm/stackframe.h>
-#include <asm/thread_info.h>
-
-#include <asm/asmmacro.h>
-
-/*
- * Offset to the current process status flags, the first 32 bytes of the
- * stack are not used.
- */
-#define ST_OFF (_THREAD_SIZE - 32 - PT_SIZE + PT_STATUS)
-
+#define USE_ALTERNATE_RESUME_IMPL 1
+       .set push
+       .set arch=mips64r2
+#include "r4k_switch.S"
+       .set pop
 /*
  * task_struct *resume(task_struct *prev, task_struct *next,
  *                    struct thread_info *next_ti, int usedfpu)
@@ -39,7 +26,62 @@
        LONG_S  t1, THREAD_STATUS(a0)
        cpu_save_nonscratch a0
        LONG_S  ra, THREAD_REG31(a0)
+       /*
+       * check if we need to save FPU registers
+       */
+       PTR_L t3, TASK_THREAD_INFO(a0)
+       LONG_L t0, TI_FLAGS(t3)
+       li t1, _TIF_USEDFPU
+       and t2, t0, t1
+       beqz t2, 1f
+       nor t1, zero, t1
+
+       and t0, t0, t1
+       LONG_S t0, TI_FLAGS(t3)

+       /*
+       * clear saved user stack CU1 bit
+       */
+       LONG_L t0, ST_OFF(t3)
+       li t1, ~ST0_CU1
+       and t0, t0, t1
+       LONG_S t0, ST_OFF(t3)
+
+       .set push
+       .set arch=mips64r2
+       fpu_save_double a0 t0 t1        # c0_status passed in t0
+                                       # clobbers t1
+
+       .set pop
+1:
+
+       /* check if we need to save COP2 registers */
+       PTR_L t2, TASK_THREAD_INFO(a0)
+       LONG_L t0, ST_OFF(t2)
+       bbit0 t0, 30, 1f
+
+       /* Disable COP2 in the stored process state */
+       li t1, ST0_CU2
+       xor t0, t1
+       LONG_S t0, ST_OFF(t2)
+
+       /* Enable COP2 so we can save it */
+       mfc0 t0, CP0_STATUS
+       or t0, t1
+       mtc0 t0, CP0_STATUS
+
+       /* Save COP2 */
+       daddu a0, THREAD_CP2
+       jal octeon_cop2_save
+       dsubu a0, THREAD_CP2
+
+       /* Disable COP2 now that we are done */
+       mfc0 t0, CP0_STATUS
+       li t1, ST0_CU2
+       xor t0, t1
+       mtc0 t0, CP0_STATUS
+
+1:
 #if CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE > 0
        /* Check if we need to store CVMSEG state */
        mfc0    t0, $11,7       /* CvmMemCtl */
@@ -85,12 +127,7 @@
        move    $28, a2
        cpu_restore_nonscratch a1

-#if (_THREAD_SIZE - 32) < 0x8000
-       PTR_ADDIU       t0, $28, _THREAD_SIZE - 32
-#else
-       PTR_LI          t0, _THREAD_SIZE - 32
-       PTR_ADDU        t0, $28
-#endif
+       PTR_ADDU t0, $28, _THREAD_SIZE - 32
        set_saved_sp    t0, t1, t2

        mfc0    t1, CP0_STATUS          /* Do we really need this? */
diff --git a/arch/mips/kernel/r4k_switch.S b/arch/mips/kernel/r4k_switch.S
index cc78dd9..8a4f9a5 100644
--- a/arch/mips/kernel/r4k_switch.S
+++ b/arch/mips/kernel/r4k_switch.S
@@ -28,6 +28,7 @@
  */
 #define ST_OFF (_THREAD_SIZE - 32 - PT_SIZE + PT_STATUS)

+#ifndef USE_ALTERNATE_RESUME_IMPL
 /*
  * FPU context is saved iff the process has used it's FPU in the current
  * time slice as indicated by _TIF_USEDFPU.  In any case, the CU1 bit for user
@@ -119,6 +120,8 @@
        jr      ra
        END(resume)

+#endif  /* USE_ALTERNATE_RESUME_IMPL */
+
 /*
  * Save a thread's fp context.
  */
diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
index 0b4e2e3..edb110c 100644
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -559,7 +559,11 @@ int mm_isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
                case mm_bc1t_op:
                        preempt_disable();
                        if (is_fpu_owner())
-                               asm volatile("cfc1\t%0,$31" : "=r" (fcr31));
+                               asm volatile(
+                                            ".set push\n"
+                                            "  .set mips1\n"
+                                            "  cfc1    %0,$31\n"
+                                            "  .set pop" : "=r" (fcr31));
                        else
                                fcr31 = current->thread.fpu.fcr31;
                        preempt_enable();
@@ -817,7 +821,11 @@ static int isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
                if (insn.i_format.rs == bc_op) {
                        preempt_disable();
                        if (is_fpu_owner())
-                               asm volatile("cfc1\t%0,$31" : "=r" (fcr31));
+                               asm volatile(
+                                       ".set push\n"
+                                       "\t.set mips1\n"
+                                       "\tcfc1\t%0,$31\n"
+                                       "\t.set pop" : "=r" (fcr31));
                        else
                                fcr31 = current->thread.fpu.fcr31;
                        preempt_enable();
--
1.8.1.4



"DISCLAIMER: This message is proprietary to Aricent and is intended solely for the use of the individual to whom it is addressed. It may contain privileged or confidential information and should not be circulated or used for any purpose other than for what it is intended. If you have received this message in error, please notify the originator immediately. If you are not the intended recipient, you are notified that you are strictly prohibited from using, copying, altering, or disclosing the contents of this message. Aricent accepts no responsibility for loss or damage arising from the use of the information transmitted by this email including damage from virus."
