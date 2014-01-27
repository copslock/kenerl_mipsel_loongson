Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jan 2014 16:28:30 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:4463 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6824805AbaA0P1d3KN2w (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 27 Jan 2014 16:27:33 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 09/15] mips: don't assume 64-bit FP registers for context switch
Date:   Mon, 27 Jan 2014 15:23:08 +0000
Message-ID: <1390836194-26286-10-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1390836194-26286-1-git-send-email-paul.burton@imgtec.com>
References: <1390836194-26286-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.152.22]
X-SEF-Processed: 7_3_0_01192__2014_01_27_15_27_28
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39103
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

When saving or restoring scalar FP context we want to access the least
significant 64 bits of each FP register. When the FP registers are 64
bits wide that is trivially the start of the registers value in memory.
However when the FP registers are wider this equivalence will no longer
be true for big endian systems. Define a new set of offset macros for
the least significant 64 bits of each saved FP register within thread
context, and make use of them when saving and restoring scalar FP
context.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
 arch/mips/include/asm/asmmacro-32.h | 128 ++++++++++++++++++------------------
 arch/mips/include/asm/asmmacro.h    | 128 ++++++++++++++++++------------------
 arch/mips/kernel/asm-offsets.c      |  66 +++++++++++++++++++
 3 files changed, 194 insertions(+), 128 deletions(-)

diff --git a/arch/mips/include/asm/asmmacro-32.h b/arch/mips/include/asm/asmmacro-32.h
index 70e1f17..e38c281 100644
--- a/arch/mips/include/asm/asmmacro-32.h
+++ b/arch/mips/include/asm/asmmacro-32.h
@@ -14,75 +14,75 @@
 
 	.macro	fpu_save_single thread tmp=t0
 	cfc1	\tmp,  fcr31
-	swc1	$f0,  THREAD_FPR0(\thread)
-	swc1	$f1,  THREAD_FPR1(\thread)
-	swc1	$f2,  THREAD_FPR2(\thread)
-	swc1	$f3,  THREAD_FPR3(\thread)
-	swc1	$f4,  THREAD_FPR4(\thread)
-	swc1	$f5,  THREAD_FPR5(\thread)
-	swc1	$f6,  THREAD_FPR6(\thread)
-	swc1	$f7,  THREAD_FPR7(\thread)
-	swc1	$f8,  THREAD_FPR8(\thread)
-	swc1	$f9,  THREAD_FPR9(\thread)
-	swc1	$f10, THREAD_FPR10(\thread)
-	swc1	$f11, THREAD_FPR11(\thread)
-	swc1	$f12, THREAD_FPR12(\thread)
-	swc1	$f13, THREAD_FPR13(\thread)
-	swc1	$f14, THREAD_FPR14(\thread)
-	swc1	$f15, THREAD_FPR15(\thread)
-	swc1	$f16, THREAD_FPR16(\thread)
-	swc1	$f17, THREAD_FPR17(\thread)
-	swc1	$f18, THREAD_FPR18(\thread)
-	swc1	$f19, THREAD_FPR19(\thread)
-	swc1	$f20, THREAD_FPR20(\thread)
-	swc1	$f21, THREAD_FPR21(\thread)
-	swc1	$f22, THREAD_FPR22(\thread)
-	swc1	$f23, THREAD_FPR23(\thread)
-	swc1	$f24, THREAD_FPR24(\thread)
-	swc1	$f25, THREAD_FPR25(\thread)
-	swc1	$f26, THREAD_FPR26(\thread)
-	swc1	$f27, THREAD_FPR27(\thread)
-	swc1	$f28, THREAD_FPR28(\thread)
-	swc1	$f29, THREAD_FPR29(\thread)
-	swc1	$f30, THREAD_FPR30(\thread)
-	swc1	$f31, THREAD_FPR31(\thread)
+	swc1	$f0,  THREAD_FPR0_LS64(\thread)
+	swc1	$f1,  THREAD_FPR1_LS64(\thread)
+	swc1	$f2,  THREAD_FPR2_LS64(\thread)
+	swc1	$f3,  THREAD_FPR3_LS64(\thread)
+	swc1	$f4,  THREAD_FPR4_LS64(\thread)
+	swc1	$f5,  THREAD_FPR5_LS64(\thread)
+	swc1	$f6,  THREAD_FPR6_LS64(\thread)
+	swc1	$f7,  THREAD_FPR7_LS64(\thread)
+	swc1	$f8,  THREAD_FPR8_LS64(\thread)
+	swc1	$f9,  THREAD_FPR9_LS64(\thread)
+	swc1	$f10, THREAD_FPR10_LS64(\thread)
+	swc1	$f11, THREAD_FPR11_LS64(\thread)
+	swc1	$f12, THREAD_FPR12_LS64(\thread)
+	swc1	$f13, THREAD_FPR13_LS64(\thread)
+	swc1	$f14, THREAD_FPR14_LS64(\thread)
+	swc1	$f15, THREAD_FPR15_LS64(\thread)
+	swc1	$f16, THREAD_FPR16_LS64(\thread)
+	swc1	$f17, THREAD_FPR17_LS64(\thread)
+	swc1	$f18, THREAD_FPR18_LS64(\thread)
+	swc1	$f19, THREAD_FPR19_LS64(\thread)
+	swc1	$f20, THREAD_FPR20_LS64(\thread)
+	swc1	$f21, THREAD_FPR21_LS64(\thread)
+	swc1	$f22, THREAD_FPR22_LS64(\thread)
+	swc1	$f23, THREAD_FPR23_LS64(\thread)
+	swc1	$f24, THREAD_FPR24_LS64(\thread)
+	swc1	$f25, THREAD_FPR25_LS64(\thread)
+	swc1	$f26, THREAD_FPR26_LS64(\thread)
+	swc1	$f27, THREAD_FPR27_LS64(\thread)
+	swc1	$f28, THREAD_FPR28_LS64(\thread)
+	swc1	$f29, THREAD_FPR29_LS64(\thread)
+	swc1	$f30, THREAD_FPR30_LS64(\thread)
+	swc1	$f31, THREAD_FPR31_LS64(\thread)
 	sw	\tmp, THREAD_FCR31(\thread)
 	.endm
 
 	.macro	fpu_restore_single thread tmp=t0
 	lw	\tmp, THREAD_FCR31(\thread)
-	lwc1	$f0,  THREAD_FPR0(\thread)
-	lwc1	$f1,  THREAD_FPR1(\thread)
-	lwc1	$f2,  THREAD_FPR2(\thread)
-	lwc1	$f3,  THREAD_FPR3(\thread)
-	lwc1	$f4,  THREAD_FPR4(\thread)
-	lwc1	$f5,  THREAD_FPR5(\thread)
-	lwc1	$f6,  THREAD_FPR6(\thread)
-	lwc1	$f7,  THREAD_FPR7(\thread)
-	lwc1	$f8,  THREAD_FPR8(\thread)
-	lwc1	$f9,  THREAD_FPR9(\thread)
-	lwc1	$f10, THREAD_FPR10(\thread)
-	lwc1	$f11, THREAD_FPR11(\thread)
-	lwc1	$f12, THREAD_FPR12(\thread)
-	lwc1	$f13, THREAD_FPR13(\thread)
-	lwc1	$f14, THREAD_FPR14(\thread)
-	lwc1	$f15, THREAD_FPR15(\thread)
-	lwc1	$f16, THREAD_FPR16(\thread)
-	lwc1	$f17, THREAD_FPR17(\thread)
-	lwc1	$f18, THREAD_FPR18(\thread)
-	lwc1	$f19, THREAD_FPR19(\thread)
-	lwc1	$f20, THREAD_FPR20(\thread)
-	lwc1	$f21, THREAD_FPR21(\thread)
-	lwc1	$f22, THREAD_FPR22(\thread)
-	lwc1	$f23, THREAD_FPR23(\thread)
-	lwc1	$f24, THREAD_FPR24(\thread)
-	lwc1	$f25, THREAD_FPR25(\thread)
-	lwc1	$f26, THREAD_FPR26(\thread)
-	lwc1	$f27, THREAD_FPR27(\thread)
-	lwc1	$f28, THREAD_FPR28(\thread)
-	lwc1	$f29, THREAD_FPR29(\thread)
-	lwc1	$f30, THREAD_FPR30(\thread)
-	lwc1	$f31, THREAD_FPR31(\thread)
+	lwc1	$f0,  THREAD_FPR0_LS64(\thread)
+	lwc1	$f1,  THREAD_FPR1_LS64(\thread)
+	lwc1	$f2,  THREAD_FPR2_LS64(\thread)
+	lwc1	$f3,  THREAD_FPR3_LS64(\thread)
+	lwc1	$f4,  THREAD_FPR4_LS64(\thread)
+	lwc1	$f5,  THREAD_FPR5_LS64(\thread)
+	lwc1	$f6,  THREAD_FPR6_LS64(\thread)
+	lwc1	$f7,  THREAD_FPR7_LS64(\thread)
+	lwc1	$f8,  THREAD_FPR8_LS64(\thread)
+	lwc1	$f9,  THREAD_FPR9_LS64(\thread)
+	lwc1	$f10, THREAD_FPR10_LS64(\thread)
+	lwc1	$f11, THREAD_FPR11_LS64(\thread)
+	lwc1	$f12, THREAD_FPR12_LS64(\thread)
+	lwc1	$f13, THREAD_FPR13_LS64(\thread)
+	lwc1	$f14, THREAD_FPR14_LS64(\thread)
+	lwc1	$f15, THREAD_FPR15_LS64(\thread)
+	lwc1	$f16, THREAD_FPR16_LS64(\thread)
+	lwc1	$f17, THREAD_FPR17_LS64(\thread)
+	lwc1	$f18, THREAD_FPR18_LS64(\thread)
+	lwc1	$f19, THREAD_FPR19_LS64(\thread)
+	lwc1	$f20, THREAD_FPR20_LS64(\thread)
+	lwc1	$f21, THREAD_FPR21_LS64(\thread)
+	lwc1	$f22, THREAD_FPR22_LS64(\thread)
+	lwc1	$f23, THREAD_FPR23_LS64(\thread)
+	lwc1	$f24, THREAD_FPR24_LS64(\thread)
+	lwc1	$f25, THREAD_FPR25_LS64(\thread)
+	lwc1	$f26, THREAD_FPR26_LS64(\thread)
+	lwc1	$f27, THREAD_FPR27_LS64(\thread)
+	lwc1	$f28, THREAD_FPR28_LS64(\thread)
+	lwc1	$f29, THREAD_FPR29_LS64(\thread)
+	lwc1	$f30, THREAD_FPR30_LS64(\thread)
+	lwc1	$f31, THREAD_FPR31_LS64(\thread)
 	ctc1	\tmp, fcr31
 	.endm
 
diff --git a/arch/mips/include/asm/asmmacro.h b/arch/mips/include/asm/asmmacro.h
index 3220c93..2aa713f 100644
--- a/arch/mips/include/asm/asmmacro.h
+++ b/arch/mips/include/asm/asmmacro.h
@@ -64,44 +64,44 @@
 
 	.macro	fpu_save_16even thread tmp=t0
 	cfc1	\tmp, fcr31
-	sdc1	$f0,  THREAD_FPR0(\thread)
-	sdc1	$f2,  THREAD_FPR2(\thread)
-	sdc1	$f4,  THREAD_FPR4(\thread)
-	sdc1	$f6,  THREAD_FPR6(\thread)
-	sdc1	$f8,  THREAD_FPR8(\thread)
-	sdc1	$f10, THREAD_FPR10(\thread)
-	sdc1	$f12, THREAD_FPR12(\thread)
-	sdc1	$f14, THREAD_FPR14(\thread)
-	sdc1	$f16, THREAD_FPR16(\thread)
-	sdc1	$f18, THREAD_FPR18(\thread)
-	sdc1	$f20, THREAD_FPR20(\thread)
-	sdc1	$f22, THREAD_FPR22(\thread)
-	sdc1	$f24, THREAD_FPR24(\thread)
-	sdc1	$f26, THREAD_FPR26(\thread)
-	sdc1	$f28, THREAD_FPR28(\thread)
-	sdc1	$f30, THREAD_FPR30(\thread)
+	sdc1	$f0,  THREAD_FPR0_LS64(\thread)
+	sdc1	$f2,  THREAD_FPR2_LS64(\thread)
+	sdc1	$f4,  THREAD_FPR4_LS64(\thread)
+	sdc1	$f6,  THREAD_FPR6_LS64(\thread)
+	sdc1	$f8,  THREAD_FPR8_LS64(\thread)
+	sdc1	$f10, THREAD_FPR10_LS64(\thread)
+	sdc1	$f12, THREAD_FPR12_LS64(\thread)
+	sdc1	$f14, THREAD_FPR14_LS64(\thread)
+	sdc1	$f16, THREAD_FPR16_LS64(\thread)
+	sdc1	$f18, THREAD_FPR18_LS64(\thread)
+	sdc1	$f20, THREAD_FPR20_LS64(\thread)
+	sdc1	$f22, THREAD_FPR22_LS64(\thread)
+	sdc1	$f24, THREAD_FPR24_LS64(\thread)
+	sdc1	$f26, THREAD_FPR26_LS64(\thread)
+	sdc1	$f28, THREAD_FPR28_LS64(\thread)
+	sdc1	$f30, THREAD_FPR30_LS64(\thread)
 	sw	\tmp, THREAD_FCR31(\thread)
 	.endm
 
 	.macro	fpu_save_16odd thread
 	.set	push
 	.set	mips64r2
-	sdc1	$f1,  THREAD_FPR1(\thread)
-	sdc1	$f3,  THREAD_FPR3(\thread)
-	sdc1	$f5,  THREAD_FPR5(\thread)
-	sdc1	$f7,  THREAD_FPR7(\thread)
-	sdc1	$f9,  THREAD_FPR9(\thread)
-	sdc1	$f11, THREAD_FPR11(\thread)
-	sdc1	$f13, THREAD_FPR13(\thread)
-	sdc1	$f15, THREAD_FPR15(\thread)
-	sdc1	$f17, THREAD_FPR17(\thread)
-	sdc1	$f19, THREAD_FPR19(\thread)
-	sdc1	$f21, THREAD_FPR21(\thread)
-	sdc1	$f23, THREAD_FPR23(\thread)
-	sdc1	$f25, THREAD_FPR25(\thread)
-	sdc1	$f27, THREAD_FPR27(\thread)
-	sdc1	$f29, THREAD_FPR29(\thread)
-	sdc1	$f31, THREAD_FPR31(\thread)
+	sdc1	$f1,  THREAD_FPR1_LS64(\thread)
+	sdc1	$f3,  THREAD_FPR3_LS64(\thread)
+	sdc1	$f5,  THREAD_FPR5_LS64(\thread)
+	sdc1	$f7,  THREAD_FPR7_LS64(\thread)
+	sdc1	$f9,  THREAD_FPR9_LS64(\thread)
+	sdc1	$f11, THREAD_FPR11_LS64(\thread)
+	sdc1	$f13, THREAD_FPR13_LS64(\thread)
+	sdc1	$f15, THREAD_FPR15_LS64(\thread)
+	sdc1	$f17, THREAD_FPR17_LS64(\thread)
+	sdc1	$f19, THREAD_FPR19_LS64(\thread)
+	sdc1	$f21, THREAD_FPR21_LS64(\thread)
+	sdc1	$f23, THREAD_FPR23_LS64(\thread)
+	sdc1	$f25, THREAD_FPR25_LS64(\thread)
+	sdc1	$f27, THREAD_FPR27_LS64(\thread)
+	sdc1	$f29, THREAD_FPR29_LS64(\thread)
+	sdc1	$f31, THREAD_FPR31_LS64(\thread)
 	.set	pop
 	.endm
 
@@ -117,44 +117,44 @@
 
 	.macro	fpu_restore_16even thread tmp=t0
 	lw	\tmp, THREAD_FCR31(\thread)
-	ldc1	$f0,  THREAD_FPR0(\thread)
-	ldc1	$f2,  THREAD_FPR2(\thread)
-	ldc1	$f4,  THREAD_FPR4(\thread)
-	ldc1	$f6,  THREAD_FPR6(\thread)
-	ldc1	$f8,  THREAD_FPR8(\thread)
-	ldc1	$f10, THREAD_FPR10(\thread)
-	ldc1	$f12, THREAD_FPR12(\thread)
-	ldc1	$f14, THREAD_FPR14(\thread)
-	ldc1	$f16, THREAD_FPR16(\thread)
-	ldc1	$f18, THREAD_FPR18(\thread)
-	ldc1	$f20, THREAD_FPR20(\thread)
-	ldc1	$f22, THREAD_FPR22(\thread)
-	ldc1	$f24, THREAD_FPR24(\thread)
-	ldc1	$f26, THREAD_FPR26(\thread)
-	ldc1	$f28, THREAD_FPR28(\thread)
-	ldc1	$f30, THREAD_FPR30(\thread)
+	ldc1	$f0,  THREAD_FPR0_LS64(\thread)
+	ldc1	$f2,  THREAD_FPR2_LS64(\thread)
+	ldc1	$f4,  THREAD_FPR4_LS64(\thread)
+	ldc1	$f6,  THREAD_FPR6_LS64(\thread)
+	ldc1	$f8,  THREAD_FPR8_LS64(\thread)
+	ldc1	$f10, THREAD_FPR10_LS64(\thread)
+	ldc1	$f12, THREAD_FPR12_LS64(\thread)
+	ldc1	$f14, THREAD_FPR14_LS64(\thread)
+	ldc1	$f16, THREAD_FPR16_LS64(\thread)
+	ldc1	$f18, THREAD_FPR18_LS64(\thread)
+	ldc1	$f20, THREAD_FPR20_LS64(\thread)
+	ldc1	$f22, THREAD_FPR22_LS64(\thread)
+	ldc1	$f24, THREAD_FPR24_LS64(\thread)
+	ldc1	$f26, THREAD_FPR26_LS64(\thread)
+	ldc1	$f28, THREAD_FPR28_LS64(\thread)
+	ldc1	$f30, THREAD_FPR30_LS64(\thread)
 	ctc1	\tmp, fcr31
 	.endm
 
 	.macro	fpu_restore_16odd thread
 	.set	push
 	.set	mips64r2
-	ldc1	$f1,  THREAD_FPR1(\thread)
-	ldc1	$f3,  THREAD_FPR3(\thread)
-	ldc1	$f5,  THREAD_FPR5(\thread)
-	ldc1	$f7,  THREAD_FPR7(\thread)
-	ldc1	$f9,  THREAD_FPR9(\thread)
-	ldc1	$f11, THREAD_FPR11(\thread)
-	ldc1	$f13, THREAD_FPR13(\thread)
-	ldc1	$f15, THREAD_FPR15(\thread)
-	ldc1	$f17, THREAD_FPR17(\thread)
-	ldc1	$f19, THREAD_FPR19(\thread)
-	ldc1	$f21, THREAD_FPR21(\thread)
-	ldc1	$f23, THREAD_FPR23(\thread)
-	ldc1	$f25, THREAD_FPR25(\thread)
-	ldc1	$f27, THREAD_FPR27(\thread)
-	ldc1	$f29, THREAD_FPR29(\thread)
-	ldc1	$f31, THREAD_FPR31(\thread)
+	ldc1	$f1,  THREAD_FPR1_LS64(\thread)
+	ldc1	$f3,  THREAD_FPR3_LS64(\thread)
+	ldc1	$f5,  THREAD_FPR5_LS64(\thread)
+	ldc1	$f7,  THREAD_FPR7_LS64(\thread)
+	ldc1	$f9,  THREAD_FPR9_LS64(\thread)
+	ldc1	$f11, THREAD_FPR11_LS64(\thread)
+	ldc1	$f13, THREAD_FPR13_LS64(\thread)
+	ldc1	$f15, THREAD_FPR15_LS64(\thread)
+	ldc1	$f17, THREAD_FPR17_LS64(\thread)
+	ldc1	$f19, THREAD_FPR19_LS64(\thread)
+	ldc1	$f21, THREAD_FPR21_LS64(\thread)
+	ldc1	$f23, THREAD_FPR23_LS64(\thread)
+	ldc1	$f25, THREAD_FPR25_LS64(\thread)
+	ldc1	$f27, THREAD_FPR27_LS64(\thread)
+	ldc1	$f29, THREAD_FPR29_LS64(\thread)
+	ldc1	$f31, THREAD_FPR31_LS64(\thread)
 	.set	pop
 	.endm
 
diff --git a/arch/mips/kernel/asm-offsets.c b/arch/mips/kernel/asm-offsets.c
index 0c2e853..f454d7b 100644
--- a/arch/mips/kernel/asm-offsets.c
+++ b/arch/mips/kernel/asm-offsets.c
@@ -168,6 +168,72 @@ void output_thread_fpu_defines(void)
 	OFFSET(THREAD_FPR30, task_struct, thread.fpu.fpr[30]);
 	OFFSET(THREAD_FPR31, task_struct, thread.fpu.fpr[31]);
 
+	/* the least significant 64 bits of each FP register */
+	OFFSET(THREAD_FPR0_LS64, task_struct,
+	       thread.fpu.fpr[0].val64[FPR_IDX(64, 0)]);
+	OFFSET(THREAD_FPR1_LS64, task_struct,
+	       thread.fpu.fpr[1].val64[FPR_IDX(64, 0)]);
+	OFFSET(THREAD_FPR2_LS64, task_struct,
+	       thread.fpu.fpr[2].val64[FPR_IDX(64, 0)]);
+	OFFSET(THREAD_FPR3_LS64, task_struct,
+	       thread.fpu.fpr[3].val64[FPR_IDX(64, 0)]);
+	OFFSET(THREAD_FPR4_LS64, task_struct,
+	       thread.fpu.fpr[4].val64[FPR_IDX(64, 0)]);
+	OFFSET(THREAD_FPR5_LS64, task_struct,
+	       thread.fpu.fpr[5].val64[FPR_IDX(64, 0)]);
+	OFFSET(THREAD_FPR6_LS64, task_struct,
+	       thread.fpu.fpr[6].val64[FPR_IDX(64, 0)]);
+	OFFSET(THREAD_FPR7_LS64, task_struct,
+	       thread.fpu.fpr[7].val64[FPR_IDX(64, 0)]);
+	OFFSET(THREAD_FPR8_LS64, task_struct,
+	       thread.fpu.fpr[8].val64[FPR_IDX(64, 0)]);
+	OFFSET(THREAD_FPR9_LS64, task_struct,
+	       thread.fpu.fpr[9].val64[FPR_IDX(64, 0)]);
+	OFFSET(THREAD_FPR10_LS64, task_struct,
+	       thread.fpu.fpr[10].val64[FPR_IDX(64, 0)]);
+	OFFSET(THREAD_FPR11_LS64, task_struct,
+	       thread.fpu.fpr[11].val64[FPR_IDX(64, 0)]);
+	OFFSET(THREAD_FPR12_LS64, task_struct,
+	       thread.fpu.fpr[12].val64[FPR_IDX(64, 0)]);
+	OFFSET(THREAD_FPR13_LS64, task_struct,
+	       thread.fpu.fpr[13].val64[FPR_IDX(64, 0)]);
+	OFFSET(THREAD_FPR14_LS64, task_struct,
+	       thread.fpu.fpr[14].val64[FPR_IDX(64, 0)]);
+	OFFSET(THREAD_FPR15_LS64, task_struct,
+	       thread.fpu.fpr[15].val64[FPR_IDX(64, 0)]);
+	OFFSET(THREAD_FPR16_LS64, task_struct,
+	       thread.fpu.fpr[16].val64[FPR_IDX(64, 0)]);
+	OFFSET(THREAD_FPR17_LS64, task_struct,
+	       thread.fpu.fpr[17].val64[FPR_IDX(64, 0)]);
+	OFFSET(THREAD_FPR18_LS64, task_struct,
+	       thread.fpu.fpr[18].val64[FPR_IDX(64, 0)]);
+	OFFSET(THREAD_FPR19_LS64, task_struct,
+	       thread.fpu.fpr[19].val64[FPR_IDX(64, 0)]);
+	OFFSET(THREAD_FPR20_LS64, task_struct,
+	       thread.fpu.fpr[20].val64[FPR_IDX(64, 0)]);
+	OFFSET(THREAD_FPR21_LS64, task_struct,
+	       thread.fpu.fpr[21].val64[FPR_IDX(64, 0)]);
+	OFFSET(THREAD_FPR22_LS64, task_struct,
+	       thread.fpu.fpr[22].val64[FPR_IDX(64, 0)]);
+	OFFSET(THREAD_FPR23_LS64, task_struct,
+	       thread.fpu.fpr[23].val64[FPR_IDX(64, 0)]);
+	OFFSET(THREAD_FPR24_LS64, task_struct,
+	       thread.fpu.fpr[24].val64[FPR_IDX(64, 0)]);
+	OFFSET(THREAD_FPR25_LS64, task_struct,
+	       thread.fpu.fpr[25].val64[FPR_IDX(64, 0)]);
+	OFFSET(THREAD_FPR26_LS64, task_struct,
+	       thread.fpu.fpr[26].val64[FPR_IDX(64, 0)]);
+	OFFSET(THREAD_FPR27_LS64, task_struct,
+	       thread.fpu.fpr[27].val64[FPR_IDX(64, 0)]);
+	OFFSET(THREAD_FPR28_LS64, task_struct,
+	       thread.fpu.fpr[28].val64[FPR_IDX(64, 0)]);
+	OFFSET(THREAD_FPR29_LS64, task_struct,
+	       thread.fpu.fpr[29].val64[FPR_IDX(64, 0)]);
+	OFFSET(THREAD_FPR30_LS64, task_struct,
+	       thread.fpu.fpr[30].val64[FPR_IDX(64, 0)]);
+	OFFSET(THREAD_FPR31_LS64, task_struct,
+	       thread.fpu.fpr[31].val64[FPR_IDX(64, 0)]);
+
 	OFFSET(THREAD_FCR31, task_struct, thread.fpu.fcr31);
 	BLANK();
 }
-- 
1.8.5.3
