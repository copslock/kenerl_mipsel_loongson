Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Jun 2017 20:22:56 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:58145 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992078AbdFESWdgUXUR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Jun 2017 20:22:33 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 2FCDF123EC9CD;
        Mon,  5 Jun 2017 19:22:22 +0100 (IST)
Received: from localhost (10.20.1.33) by hhmail02.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 5 Jun 2017 19:22:26
 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 2/5] MIPS: Move r4k FP code from r4k_switch.S to r4k_fpu.S
Date:   Mon, 5 Jun 2017 11:21:28 -0700
Message-ID: <20170605182131.16853-3-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170605182131.16853-1-paul.burton@imgtec.com>
References: <20170605182131.16853-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.1.33]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58224
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

Move _save_fp(), _restore_fp(), _save_msa(), _restore_msa(),
_init_msa_upper() & _init_fpu() out of r4k_switch.S & into r4k_fpu.S.
This allows us to clean up the way in which Octeon includes the default
r4k implementations of these FP functions despite replacing resume(),
and makes CONFIG_R4K_FPU more straightforwardly represent all
configurations that have an R4K-style FPU, including Octeon.

Besides cleaning up this will be useful for later patches which disable
FP support.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---

 arch/mips/Kconfig                |   2 +-
 arch/mips/kernel/Makefile        |  13 ++-
 arch/mips/kernel/octeon_switch.S |   5 -
 arch/mips/kernel/r4k_fpu.S       | 196 +++++++++++++++++++++++++++++++++++++
 arch/mips/kernel/r4k_switch.S    | 203 ---------------------------------------
 5 files changed, 206 insertions(+), 213 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 40ea50aabd06..20958af88522 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2229,7 +2229,7 @@ config CPU_GENERIC_DUMP_TLB
 
 config CPU_R4K_FPU
 	bool
-	default y if !(CPU_R3000 || CPU_TX39XX || CPU_CAVIUM_OCTEON)
+	default y if !(CPU_R3000 || CPU_TX39XX)
 
 config CPU_R4K_CACHE_TLB
 	bool
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index f3af9e07e888..10d75888f6ae 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -36,10 +36,15 @@ obj-$(CONFIG_MODULES_USE_ELF_RELA) += module-rela.o
 obj-$(CONFIG_FTRACE_SYSCALLS)	+= ftrace.o
 obj-$(CONFIG_FUNCTION_TRACER)	+= mcount.o ftrace.o
 
-obj-$(CONFIG_CPU_R4K_FPU)	+= r4k_fpu.o r4k_switch.o
-obj-$(CONFIG_CPU_R3000)		+= r2300_fpu.o r2300_switch.o
-obj-$(CONFIG_CPU_TX39XX)	+= r2300_fpu.o r2300_switch.o
-obj-$(CONFIG_CPU_CAVIUM_OCTEON)	+= r4k_fpu.o octeon_switch.o
+sw-y				:= r4k_switch.o
+sw-$(CONFIG_CPU_R3000)		:= r2300_switch.o
+sw-$(CONFIG_CPU_TX39XX)		:= r2300_switch.o
+sw-$(CONFIG_CPU_CAVIUM_OCTEON)	:= octeon_switch.o
+obj-y				+= $(sw-y)
+
+obj-$(CONFIG_CPU_R4K_FPU)	+= r4k_fpu.o
+obj-$(CONFIG_CPU_R3000)		+= r2300_fpu.o
+obj-$(CONFIG_CPU_TX39XX)	+= r2300_fpu.o
 
 obj-$(CONFIG_SMP)		+= smp.o
 obj-$(CONFIG_SMP_UP)		+= smp-up.o
diff --git a/arch/mips/kernel/octeon_switch.S b/arch/mips/kernel/octeon_switch.S
index 3375745b9198..dbfe4ff83ea3 100644
--- a/arch/mips/kernel/octeon_switch.S
+++ b/arch/mips/kernel/octeon_switch.S
@@ -11,11 +11,6 @@
  *    written by Carsten Langgaard, carstenl@mips.com
  */
 
-#define USE_ALTERNATE_RESUME_IMPL 1
-	.set push
-	.set arch=mips64r2
-#include "r4k_switch.S"
-	.set pop
 /*
  * task_struct *resume(task_struct *prev, task_struct *next,
  *		       struct thread_info *next_ti)
diff --git a/arch/mips/kernel/r4k_fpu.S b/arch/mips/kernel/r4k_fpu.S
index 56d86b09c917..0a83b1708b3c 100644
--- a/arch/mips/kernel/r4k_fpu.S
+++ b/arch/mips/kernel/r4k_fpu.S
@@ -15,6 +15,7 @@
 #include <asm/asm.h>
 #include <asm/asmmacro.h>
 #include <asm/errno.h>
+#include <asm/export.h>
 #include <asm/fpregdef.h>
 #include <asm/mipsregs.h>
 #include <asm/asm-offsets.h>
@@ -34,6 +35,201 @@
 	.previous
 	.endm
 
+/*
+ * Save a thread's fp context.
+ */
+LEAF(_save_fp)
+EXPORT_SYMBOL(_save_fp)
+#if defined(CONFIG_64BIT) || defined(CONFIG_CPU_MIPS32_R2) || \
+		defined(CONFIG_CPU_MIPS32_R6)
+	mfc0	t0, CP0_STATUS
+#endif
+	fpu_save_double a0 t0 t1		# clobbers t1
+	jr	ra
+	END(_save_fp)
+
+/*
+ * Restore a thread's fp context.
+ */
+LEAF(_restore_fp)
+#if defined(CONFIG_64BIT) || defined(CONFIG_CPU_MIPS32_R2) || \
+		defined(CONFIG_CPU_MIPS32_R6)
+	mfc0	t0, CP0_STATUS
+#endif
+	fpu_restore_double a0 t0 t1		# clobbers t1
+	jr	ra
+	END(_restore_fp)
+
+#ifdef CONFIG_CPU_HAS_MSA
+
+/*
+ * Save a thread's MSA vector context.
+ */
+LEAF(_save_msa)
+EXPORT_SYMBOL(_save_msa)
+	msa_save_all	a0
+	jr	ra
+	END(_save_msa)
+
+/*
+ * Restore a thread's MSA vector context.
+ */
+LEAF(_restore_msa)
+	msa_restore_all	a0
+	jr	ra
+	END(_restore_msa)
+
+LEAF(_init_msa_upper)
+	msa_init_all_upper
+	jr	ra
+	END(_init_msa_upper)
+
+#endif
+
+/*
+ * Load the FPU with signalling NANS.  This bit pattern we're using has
+ * the property that no matter whether considered as single or as double
+ * precision represents signaling NANS.
+ *
+ * The value to initialize fcr31 to comes in $a0.
+ */
+
+	.set push
+	SET_HARDFLOAT
+
+LEAF(_init_fpu)
+	mfc0	t0, CP0_STATUS
+	li	t1, ST0_CU1
+	or	t0, t1
+	mtc0	t0, CP0_STATUS
+	enable_fpu_hazard
+
+	ctc1	a0, fcr31
+
+	li	t1, -1				# SNaN
+
+#ifdef CONFIG_64BIT
+	sll	t0, t0, 5
+	bgez	t0, 1f				# 16 / 32 register mode?
+
+	dmtc1	t1, $f1
+	dmtc1	t1, $f3
+	dmtc1	t1, $f5
+	dmtc1	t1, $f7
+	dmtc1	t1, $f9
+	dmtc1	t1, $f11
+	dmtc1	t1, $f13
+	dmtc1	t1, $f15
+	dmtc1	t1, $f17
+	dmtc1	t1, $f19
+	dmtc1	t1, $f21
+	dmtc1	t1, $f23
+	dmtc1	t1, $f25
+	dmtc1	t1, $f27
+	dmtc1	t1, $f29
+	dmtc1	t1, $f31
+1:
+#endif
+
+#ifdef CONFIG_CPU_MIPS32
+	mtc1	t1, $f0
+	mtc1	t1, $f1
+	mtc1	t1, $f2
+	mtc1	t1, $f3
+	mtc1	t1, $f4
+	mtc1	t1, $f5
+	mtc1	t1, $f6
+	mtc1	t1, $f7
+	mtc1	t1, $f8
+	mtc1	t1, $f9
+	mtc1	t1, $f10
+	mtc1	t1, $f11
+	mtc1	t1, $f12
+	mtc1	t1, $f13
+	mtc1	t1, $f14
+	mtc1	t1, $f15
+	mtc1	t1, $f16
+	mtc1	t1, $f17
+	mtc1	t1, $f18
+	mtc1	t1, $f19
+	mtc1	t1, $f20
+	mtc1	t1, $f21
+	mtc1	t1, $f22
+	mtc1	t1, $f23
+	mtc1	t1, $f24
+	mtc1	t1, $f25
+	mtc1	t1, $f26
+	mtc1	t1, $f27
+	mtc1	t1, $f28
+	mtc1	t1, $f29
+	mtc1	t1, $f30
+	mtc1	t1, $f31
+
+#if defined(CONFIG_CPU_MIPS32_R2) || defined(CONFIG_CPU_MIPS32_R6)
+	.set    push
+	.set    MIPS_ISA_LEVEL_RAW
+	.set	fp=64
+	sll     t0, t0, 5			# is Status.FR set?
+	bgez    t0, 1f				# no: skip setting upper 32b
+
+	mthc1   t1, $f0
+	mthc1   t1, $f1
+	mthc1   t1, $f2
+	mthc1   t1, $f3
+	mthc1   t1, $f4
+	mthc1   t1, $f5
+	mthc1   t1, $f6
+	mthc1   t1, $f7
+	mthc1   t1, $f8
+	mthc1   t1, $f9
+	mthc1   t1, $f10
+	mthc1   t1, $f11
+	mthc1   t1, $f12
+	mthc1   t1, $f13
+	mthc1   t1, $f14
+	mthc1   t1, $f15
+	mthc1   t1, $f16
+	mthc1   t1, $f17
+	mthc1   t1, $f18
+	mthc1   t1, $f19
+	mthc1   t1, $f20
+	mthc1   t1, $f21
+	mthc1   t1, $f22
+	mthc1   t1, $f23
+	mthc1   t1, $f24
+	mthc1   t1, $f25
+	mthc1   t1, $f26
+	mthc1   t1, $f27
+	mthc1   t1, $f28
+	mthc1   t1, $f29
+	mthc1   t1, $f30
+	mthc1   t1, $f31
+1:	.set    pop
+#endif /* CONFIG_CPU_MIPS32_R2 || CONFIG_CPU_MIPS32_R6 */
+#else
+	.set	MIPS_ISA_ARCH_LEVEL_RAW
+	dmtc1	t1, $f0
+	dmtc1	t1, $f2
+	dmtc1	t1, $f4
+	dmtc1	t1, $f6
+	dmtc1	t1, $f8
+	dmtc1	t1, $f10
+	dmtc1	t1, $f12
+	dmtc1	t1, $f14
+	dmtc1	t1, $f16
+	dmtc1	t1, $f18
+	dmtc1	t1, $f20
+	dmtc1	t1, $f22
+	dmtc1	t1, $f24
+	dmtc1	t1, $f26
+	dmtc1	t1, $f28
+	dmtc1	t1, $f30
+#endif
+	jr	ra
+	END(_init_fpu)
+
+	.set pop	/* SET_HARDFLOAT */
+
 	.set	noreorder
 
 /**
diff --git a/arch/mips/kernel/r4k_switch.S b/arch/mips/kernel/r4k_switch.S
index 7b386d54fd65..17cf9341c1cf 100644
--- a/arch/mips/kernel/r4k_switch.S
+++ b/arch/mips/kernel/r4k_switch.S
@@ -12,8 +12,6 @@
  */
 #include <asm/asm.h>
 #include <asm/cachectl.h>
-#include <asm/export.h>
-#include <asm/fpregdef.h>
 #include <asm/mipsregs.h>
 #include <asm/asm-offsets.h>
 #include <asm/regdef.h>
@@ -22,10 +20,6 @@
 
 #include <asm/asmmacro.h>
 
-/* preprocessor replaces the fp in ".set fp=64" with $30 otherwise */
-#undef fp
-
-#ifndef USE_ALTERNATE_RESUME_IMPL
 /*
  * task_struct *resume(task_struct *prev, task_struct *next,
  *		       struct thread_info *next_ti)
@@ -63,200 +57,3 @@
 	move	v0, a0
 	jr	ra
 	END(resume)
-
-#endif /* USE_ALTERNATE_RESUME_IMPL */
-
-/*
- * Save a thread's fp context.
- */
-LEAF(_save_fp)
-EXPORT_SYMBOL(_save_fp)
-#if defined(CONFIG_64BIT) || defined(CONFIG_CPU_MIPS32_R2) || \
-		defined(CONFIG_CPU_MIPS32_R6)
-	mfc0	t0, CP0_STATUS
-#endif
-	fpu_save_double a0 t0 t1		# clobbers t1
-	jr	ra
-	END(_save_fp)
-
-/*
- * Restore a thread's fp context.
- */
-LEAF(_restore_fp)
-#if defined(CONFIG_64BIT) || defined(CONFIG_CPU_MIPS32_R2) || \
-		defined(CONFIG_CPU_MIPS32_R6)
-	mfc0	t0, CP0_STATUS
-#endif
-	fpu_restore_double a0 t0 t1		# clobbers t1
-	jr	ra
-	END(_restore_fp)
-
-#ifdef CONFIG_CPU_HAS_MSA
-
-/*
- * Save a thread's MSA vector context.
- */
-LEAF(_save_msa)
-EXPORT_SYMBOL(_save_msa)
-	msa_save_all	a0
-	jr	ra
-	END(_save_msa)
-
-/*
- * Restore a thread's MSA vector context.
- */
-LEAF(_restore_msa)
-	msa_restore_all	a0
-	jr	ra
-	END(_restore_msa)
-
-LEAF(_init_msa_upper)
-	msa_init_all_upper
-	jr	ra
-	END(_init_msa_upper)
-
-#endif
-
-/*
- * Load the FPU with signalling NANS.  This bit pattern we're using has
- * the property that no matter whether considered as single or as double
- * precision represents signaling NANS.
- *
- * The value to initialize fcr31 to comes in $a0.
- */
-
-	.set push
-	SET_HARDFLOAT
-
-LEAF(_init_fpu)
-	mfc0	t0, CP0_STATUS
-	li	t1, ST0_CU1
-	or	t0, t1
-	mtc0	t0, CP0_STATUS
-	enable_fpu_hazard
-
-	ctc1	a0, fcr31
-
-	li	t1, -1				# SNaN
-
-#ifdef CONFIG_64BIT
-	sll	t0, t0, 5
-	bgez	t0, 1f				# 16 / 32 register mode?
-
-	dmtc1	t1, $f1
-	dmtc1	t1, $f3
-	dmtc1	t1, $f5
-	dmtc1	t1, $f7
-	dmtc1	t1, $f9
-	dmtc1	t1, $f11
-	dmtc1	t1, $f13
-	dmtc1	t1, $f15
-	dmtc1	t1, $f17
-	dmtc1	t1, $f19
-	dmtc1	t1, $f21
-	dmtc1	t1, $f23
-	dmtc1	t1, $f25
-	dmtc1	t1, $f27
-	dmtc1	t1, $f29
-	dmtc1	t1, $f31
-1:
-#endif
-
-#ifdef CONFIG_CPU_MIPS32
-	mtc1	t1, $f0
-	mtc1	t1, $f1
-	mtc1	t1, $f2
-	mtc1	t1, $f3
-	mtc1	t1, $f4
-	mtc1	t1, $f5
-	mtc1	t1, $f6
-	mtc1	t1, $f7
-	mtc1	t1, $f8
-	mtc1	t1, $f9
-	mtc1	t1, $f10
-	mtc1	t1, $f11
-	mtc1	t1, $f12
-	mtc1	t1, $f13
-	mtc1	t1, $f14
-	mtc1	t1, $f15
-	mtc1	t1, $f16
-	mtc1	t1, $f17
-	mtc1	t1, $f18
-	mtc1	t1, $f19
-	mtc1	t1, $f20
-	mtc1	t1, $f21
-	mtc1	t1, $f22
-	mtc1	t1, $f23
-	mtc1	t1, $f24
-	mtc1	t1, $f25
-	mtc1	t1, $f26
-	mtc1	t1, $f27
-	mtc1	t1, $f28
-	mtc1	t1, $f29
-	mtc1	t1, $f30
-	mtc1	t1, $f31
-
-#if defined(CONFIG_CPU_MIPS32_R2) || defined(CONFIG_CPU_MIPS32_R6)
-	.set    push
-	.set    MIPS_ISA_LEVEL_RAW
-	.set	fp=64
-	sll     t0, t0, 5			# is Status.FR set?
-	bgez    t0, 1f				# no: skip setting upper 32b
-
-	mthc1   t1, $f0
-	mthc1   t1, $f1
-	mthc1   t1, $f2
-	mthc1   t1, $f3
-	mthc1   t1, $f4
-	mthc1   t1, $f5
-	mthc1   t1, $f6
-	mthc1   t1, $f7
-	mthc1   t1, $f8
-	mthc1   t1, $f9
-	mthc1   t1, $f10
-	mthc1   t1, $f11
-	mthc1   t1, $f12
-	mthc1   t1, $f13
-	mthc1   t1, $f14
-	mthc1   t1, $f15
-	mthc1   t1, $f16
-	mthc1   t1, $f17
-	mthc1   t1, $f18
-	mthc1   t1, $f19
-	mthc1   t1, $f20
-	mthc1   t1, $f21
-	mthc1   t1, $f22
-	mthc1   t1, $f23
-	mthc1   t1, $f24
-	mthc1   t1, $f25
-	mthc1   t1, $f26
-	mthc1   t1, $f27
-	mthc1   t1, $f28
-	mthc1   t1, $f29
-	mthc1   t1, $f30
-	mthc1   t1, $f31
-1:	.set    pop
-#endif /* CONFIG_CPU_MIPS32_R2 || CONFIG_CPU_MIPS32_R6 */
-#else
-	.set	MIPS_ISA_ARCH_LEVEL_RAW
-	dmtc1	t1, $f0
-	dmtc1	t1, $f2
-	dmtc1	t1, $f4
-	dmtc1	t1, $f6
-	dmtc1	t1, $f8
-	dmtc1	t1, $f10
-	dmtc1	t1, $f12
-	dmtc1	t1, $f14
-	dmtc1	t1, $f16
-	dmtc1	t1, $f18
-	dmtc1	t1, $f20
-	dmtc1	t1, $f22
-	dmtc1	t1, $f24
-	dmtc1	t1, $f26
-	dmtc1	t1, $f28
-	dmtc1	t1, $f30
-#endif
-	jr	ra
-	END(_init_fpu)
-
-	.set pop	/* SET_HARDFLOAT */
-- 
2.13.0
