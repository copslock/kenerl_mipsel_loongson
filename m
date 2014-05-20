Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 May 2014 16:49:13 +0200 (CEST)
Received: from mail-bl2lp0205.outbound.protection.outlook.com ([207.46.163.205]:38185
        "EHLO na01-bl2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6855025AbaETOscPklDf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 20 May 2014 16:48:32 +0200
Received: from localhost.localdomain (46.78.192.208) by
 DM2PR07MB398.namprd07.prod.outlook.com (10.141.104.21) with Microsoft SMTP
 Server (TLS) id 15.0.944.11; Tue, 20 May 2014 14:48:17 +0000
From:   Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
To:     <linux-mips@linux-mips.org>
CC:     David Daney <ddaney.cavm@gmail.com>,
        Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>, <kvm@vger.kernel.org>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH 01/15] MIPS: OCTEON: Enable use of FPU.
Date:   Tue, 20 May 2014 16:47:02 +0200
Message-ID: <1400597236-11352-2-git-send-email-andreas.herrmann@caviumnetworks.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1400597236-11352-1-git-send-email-andreas.herrmann@caviumnetworks.com>
References: <1400597236-11352-1-git-send-email-andreas.herrmann@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [46.78.192.208]
X-ClientProxiedBy: AM3PR01CA004.eurprd01.prod.exchangelabs.com
 (10.242.240.14) To DM2PR07MB398.namprd07.prod.outlook.com (10.141.104.21)
X-Forefront-PRVS: 02176E2458
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(6069001)(6009001)(428001)(199002)(189002)(79102001)(36756003)(48376002)(66066001)(77982001)(92726001)(50466002)(74502001)(46102001)(64706001)(47776003)(80022001)(20776003)(50226001)(33646001)(101416001)(50986999)(76482001)(77156001)(89996001)(42186004)(81542001)(92566001)(62966002)(81342001)(87976001)(93916002)(87286001)(4396001)(19580395003)(83072002)(88136002)(85852003)(21056001)(76176999)(83322001)(31966008)(74662001)(86362001)(99396002)(102836001)(19580405001);DIR:OUT;SFP:;SCL:1;SRVR:DM2PR07MB398;H:localhost.localdomain;FPR:;MLV:sfv;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (: caviumnetworks.com does not designate permitted sender
 hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andreas.Herrmann@caviumnetworks.com; 
X-OriginatorOrg: caviumnetworks.com
Return-Path: <Andreas.Herrmann@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40175
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andreas.herrmann@caviumnetworks.com
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

From: David Daney <david.daney@cavium.com>

Some versions of the assembler will not assemble CFC1 for OCTEON, so
override the ISA for these.

Add r4k_fpu.o to handle low level FPU initialization.

Modify octeon_switch.S to save the FPU registers.  And include
r4k_switch.S to pick up more FPU support.

Get rid of "#define cpu_has_fpu		0"

Signed-off-by: David Daney <david.daney@cavium.com>
Signed-off-by: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
---
 .../asm/mach-cavium-octeon/cpu-feature-overrides.h |    1 -
 arch/mips/kernel/Makefile                          |    2 +-
 arch/mips/kernel/branch.c                          |    6 +-
 arch/mips/kernel/octeon_switch.S                   |   84 ++++++++++++++------
 arch/mips/kernel/r4k_switch.S                      |    3 +
 arch/mips/math-emu/cp1emu.c                        |   12 ++-
 6 files changed, 80 insertions(+), 28 deletions(-)

diff --git a/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h b/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h
index 94ed063..cf80228 100644
--- a/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h
@@ -22,7 +22,6 @@
 #define cpu_has_3k_cache	0
 #define cpu_has_4k_cache	0
 #define cpu_has_tx39_cache	0
-#define cpu_has_fpu		0
 #define cpu_has_counter		1
 #define cpu_has_watch		1
 #define cpu_has_divec		1
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index 277dab3..1d07f3c 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -42,7 +42,7 @@ obj-$(CONFIG_CPU_R4K_FPU)	+= r4k_fpu.o r4k_switch.o
 obj-$(CONFIG_CPU_R3000)		+= r2300_fpu.o r2300_switch.o
 obj-$(CONFIG_CPU_R6000)		+= r6000_fpu.o r4k_switch.o
 obj-$(CONFIG_CPU_TX39XX)	+= r2300_fpu.o r2300_switch.o
-obj-$(CONFIG_CPU_CAVIUM_OCTEON) += octeon_switch.o
+obj-$(CONFIG_CPU_CAVIUM_OCTEON)	+= r4k_fpu.o octeon_switch.o
 
 obj-$(CONFIG_SMP)		+= smp.o
 obj-$(CONFIG_SMP_UP)		+= smp-up.o
diff --git a/arch/mips/kernel/branch.c b/arch/mips/kernel/branch.c
index 4d78bf4..418865f 100644
--- a/arch/mips/kernel/branch.c
+++ b/arch/mips/kernel/branch.c
@@ -366,7 +366,11 @@ int __compute_return_epc_for_insn(struct pt_regs *regs,
 	case cop1_op:
 		preempt_disable();
 		if (is_fpu_owner())
-			asm volatile("cfc1\t%0,$31" : "=r" (fcr31));
+			asm volatile(
+				".set push\n"
+				"\t.set mips1\n"
+				"\tcfc1\t%0,$31\n"
+				"\t.set pop" : "=r" (fcr31));
 		else
 			fcr31 = current->thread.fpu.fcr31;
 		preempt_enable();
diff --git a/arch/mips/kernel/octeon_switch.S b/arch/mips/kernel/octeon_switch.S
index 029e002..f654768 100644
--- a/arch/mips/kernel/octeon_switch.S
+++ b/arch/mips/kernel/octeon_switch.S
@@ -10,24 +10,12 @@
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
 
+#define USE_ALTERNATE_RESUME_IMPL 1
+	.set push
+	.set arch=mips64r2
+#include "r4k_switch.S"
+	.set pop
 /*
  * task_struct *resume(task_struct *prev, task_struct *next,
  *		       struct thread_info *next_ti, int usedfpu)
@@ -40,6 +28,61 @@
 	cpu_save_nonscratch a0
 	LONG_S	ra, THREAD_REG31(a0)
 
+	/*
+	 * check if we need to save FPU registers
+	 */
+	PTR_L	t3, TASK_THREAD_INFO(a0)
+	LONG_L	t0, TI_FLAGS(t3)
+	li	t1, _TIF_USEDFPU
+	and	t2, t0, t1
+	beqz	t2, 1f
+	nor	t1, zero, t1
+
+	and	t0, t0, t1
+	LONG_S	t0, TI_FLAGS(t3)
+
+	/*
+	 * clear saved user stack CU1 bit
+	 */
+	LONG_L	t0, ST_OFF(t3)
+	li	t1, ~ST0_CU1
+	and	t0, t0, t1
+	LONG_S	t0, ST_OFF(t3)
+
+	.set push
+	.set arch=mips64r2
+	fpu_save_double a0 t0 t1		# c0_status passed in t0
+						# clobbers t1
+	.set pop
+1:
+
+	/* check if we need to save COP2 registers */
+	PTR_L	t2, TASK_THREAD_INFO(a0)
+	LONG_L	t0, ST_OFF(t2)
+	bbit0	t0, 30, 1f
+
+	/* Disable COP2 in the stored process state */
+	li	t1, ST0_CU2
+	xor	t0, t1
+	LONG_S	t0, ST_OFF(t2)
+
+	/* Enable COP2 so we can save it */
+	mfc0	t0, CP0_STATUS
+	or	t0, t1
+	mtc0	t0, CP0_STATUS
+
+	/* Save COP2 */
+	daddu	a0, THREAD_CP2
+	jal octeon_cop2_save
+	dsubu	a0, THREAD_CP2
+
+	/* Disable COP2 now that we are done */
+	mfc0	t0, CP0_STATUS
+	li	t1, ST0_CU2
+	xor	t0, t1
+	mtc0	t0, CP0_STATUS
+
+1:
 #if CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE > 0
 	/* Check if we need to store CVMSEG state */
 	mfc0	t0, $11,7	/* CvmMemCtl */
@@ -85,12 +128,7 @@
 	move	$28, a2
 	cpu_restore_nonscratch a1
 
-#if (_THREAD_SIZE - 32) < 0x8000
-	PTR_ADDIU	t0, $28, _THREAD_SIZE - 32
-#else
-	PTR_LI		t0, _THREAD_SIZE - 32
-	PTR_ADDU	t0, $28
-#endif
+	PTR_ADDU	t0, $28, _THREAD_SIZE - 32
 	set_saved_sp	t0, t1, t2
 
 	mfc0	t1, CP0_STATUS		/* Do we really need this? */
diff --git a/arch/mips/kernel/r4k_switch.S b/arch/mips/kernel/r4k_switch.S
index abacac7..37477fc 100644
--- a/arch/mips/kernel/r4k_switch.S
+++ b/arch/mips/kernel/r4k_switch.S
@@ -28,6 +28,7 @@
  */
 #define ST_OFF (_THREAD_SIZE - 32 - PT_SIZE + PT_STATUS)
 
+#ifndef USE_ALTERNATE_RESUME_IMPL
 /*
  * task_struct *resume(task_struct *prev, task_struct *next,
  *		       struct thread_info *next_ti, s32 fp_save)
@@ -123,6 +124,8 @@
 	jr	ra
 	END(resume)
 
+#endif /* USE_ALTERNATE_RESUME_IMPL */
+
 /*
  * Save a thread's fp context.
  */
diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
index 7b3c9ac..946413f 100644
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -559,7 +559,11 @@ int mm_isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
 		case mm_bc1t_op:
 			preempt_disable();
 			if (is_fpu_owner())
-				asm volatile("cfc1\t%0,$31" : "=r" (fcr31));
+				asm volatile(
+					".set push\n"
+					"\t.set mips1\n"
+					"\tcfc1\t%0,$31\n"
+					"\t.set pop" : "=r" (fcr31));
 			else
 				fcr31 = current->thread.fpu.fcr31;
 			preempt_enable();
@@ -817,7 +821,11 @@ static int isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
 		if (insn.i_format.rs == bc_op) {
 			preempt_disable();
 			if (is_fpu_owner())
-				asm volatile("cfc1\t%0,$31" : "=r" (fcr31));
+				asm volatile(
+					".set push\n"
+					"\t.set mips1\n"
+					"\tcfc1\t%0,$31\n"
+					"\t.set pop" : "=r" (fcr31));
 			else
 				fcr31 = current->thread.fpu.fcr31;
 			preempt_enable();
-- 
1.7.9.5
