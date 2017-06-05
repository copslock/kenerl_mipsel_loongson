Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Jun 2017 20:22:30 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:48643 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992213AbdFESWPaW5QR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Jun 2017 20:22:15 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 304ECD22FB711;
        Mon,  5 Jun 2017 19:22:04 +0100 (IST)
Received: from localhost (10.20.1.33) by hhmail02.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 5 Jun 2017 19:22:08
 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 1/5] MIPS: Remove unused R6000 support
Date:   Mon, 5 Jun 2017 11:21:27 -0700
Message-ID: <20170605182131.16853-2-paul.burton@imgtec.com>
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
X-archive-position: 58223
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

The kernel contains a small amount of incomplete code aimed at
supporting old R6000 CPUs. This is:

  - Unused, as no machine selects CONFIG_SYS_HAS_CPU_R6000.

  - Broken, since there are glaring errors such as r6000_fpu.S moving
    the FCSR register to t1, then ignoring it & instead saving t0 into
    struct sigcontext...

  - A maintenance headache, since it's code that nobody can test which
    nevertheless imposes constraints on code which it shares with other
    machines.

Remove this incomplete & broken R6000 CPU support in order to clean up
and in preparation for changes which will no longer need to consider
dragging the pretense of R6000 support along with them.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---

 arch/mips/Kconfig                | 17 ++-----
 arch/mips/Makefile               |  1 -
 arch/mips/include/asm/cpu-type.h |  5 --
 arch/mips/include/asm/cpu.h      |  5 --
 arch/mips/include/asm/module.h   |  2 -
 arch/mips/kernel/Makefile        |  1 -
 arch/mips/kernel/cpu-probe.c     | 18 --------
 arch/mips/kernel/r6000_fpu.S     | 99 ----------------------------------------
 arch/mips/kernel/traps.c         | 15 ------
 arch/mips/mm/tlbex.c             |  5 --
 10 files changed, 3 insertions(+), 165 deletions(-)
 delete mode 100644 arch/mips/kernel/r6000_fpu.S

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 2828ecde133d..40ea50aabd06 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1615,14 +1615,6 @@ config CPU_R5500
 	  NEC VR5500 and VR5500A series processors implement 64-bit MIPS IV
 	  instruction set.
 
-config CPU_R6000
-	bool "R6000"
-	depends on SYS_HAS_CPU_R6000
-	select CPU_SUPPORTS_32BIT_KERNEL
-	help
-	  MIPS Technologies R6000 and R6000A series processors.  Note these
-	  processors are extremely rare and the support for them is incomplete.
-
 config CPU_NEVADA
 	bool "RM52xx"
 	depends on SYS_HAS_CPU_NEVADA
@@ -1938,9 +1930,6 @@ config SYS_HAS_CPU_R5432
 config SYS_HAS_CPU_R5500
 	bool
 
-config SYS_HAS_CPU_R6000
-	bool
-
 config SYS_HAS_CPU_NEVADA
 	bool
 
@@ -2168,7 +2157,7 @@ config PAGE_SIZE_32KB
 
 config PAGE_SIZE_64KB
 	bool "64kB"
-	depends on !CPU_R3000 && !CPU_TX39XX && !CPU_R6000
+	depends on !CPU_R3000 && !CPU_TX39XX
 	help
 	  Using 64kB page size will result in higher performance kernel at
 	  the price of higher memory consumption.  This option is available on
@@ -2236,11 +2225,11 @@ config CPU_HAS_PREFETCH
 
 config CPU_GENERIC_DUMP_TLB
 	bool
-	default y if !(CPU_R3000 || CPU_R6000 || CPU_R8000 || CPU_TX39XX)
+	default y if !(CPU_R3000 || CPU_R8000 || CPU_TX39XX)
 
 config CPU_R4K_FPU
 	bool
-	default y if !(CPU_R3000 || CPU_R6000 || CPU_TX39XX || CPU_CAVIUM_OCTEON)
+	default y if !(CPU_R3000 || CPU_TX39XX || CPU_CAVIUM_OCTEON)
 
 config CPU_R4K_CACHE_TLB
 	bool
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 02a1787c888c..3d2f247310e4 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -151,7 +151,6 @@ cflags-y += -fno-stack-check
 #
 cflags-$(CONFIG_CPU_R3000)	+= -march=r3000
 cflags-$(CONFIG_CPU_TX39XX)	+= -march=r3900
-cflags-$(CONFIG_CPU_R6000)	+= -march=r6000 -Wa,--trap
 cflags-$(CONFIG_CPU_R4300)	+= -march=r4300 -Wa,--trap
 cflags-$(CONFIG_CPU_VR41XX)	+= -march=r4100 -Wa,--trap
 cflags-$(CONFIG_CPU_R4X00)	+= -march=r4600 -Wa,--trap
diff --git a/arch/mips/include/asm/cpu-type.h b/arch/mips/include/asm/cpu-type.h
index bdd6dc18e65c..de5788091b16 100644
--- a/arch/mips/include/asm/cpu-type.h
+++ b/arch/mips/include/asm/cpu-type.h
@@ -150,11 +150,6 @@ static inline int __pure __get_cpu_type(const int cpu_type)
 	case CPU_R5500:
 #endif
 
-#ifdef CONFIG_SYS_HAS_CPU_R6000
-	case CPU_R6000:
-	case CPU_R6000A:
-#endif
-
 #ifdef CONFIG_SYS_HAS_CPU_NEVADA
 	case CPU_NEVADA:
 #endif
diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index 98f59307e6a3..55d1d49fbba8 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -284,11 +284,6 @@ enum cpu_type_enum {
 	CPU_R3081, CPU_R3081E,
 
 	/*
-	 * R6000 class processors
-	 */
-	CPU_R6000, CPU_R6000A,
-
-	/*
 	 * R4000 class processors
 	 */
 	CPU_R4000PC, CPU_R4000SC, CPU_R4000MC, CPU_R4200, CPU_R4300, CPU_R4310,
diff --git a/arch/mips/include/asm/module.h b/arch/mips/include/asm/module.h
index 702c273e67a9..32c7c524b8eb 100644
--- a/arch/mips/include/asm/module.h
+++ b/arch/mips/include/asm/module.h
@@ -114,8 +114,6 @@ search_module_dbetables(unsigned long addr)
 #define MODULE_PROC_FAMILY "R5432 "
 #elif defined CONFIG_CPU_R5500
 #define MODULE_PROC_FAMILY "R5500 "
-#elif defined CONFIG_CPU_R6000
-#define MODULE_PROC_FAMILY "R6000 "
 #elif defined CONFIG_CPU_NEVADA
 #define MODULE_PROC_FAMILY "NEVADA "
 #elif defined CONFIG_CPU_R8000
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index 9a0e37b92ce0..f3af9e07e888 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -38,7 +38,6 @@ obj-$(CONFIG_FUNCTION_TRACER)	+= mcount.o ftrace.o
 
 obj-$(CONFIG_CPU_R4K_FPU)	+= r4k_fpu.o r4k_switch.o
 obj-$(CONFIG_CPU_R3000)		+= r2300_fpu.o r2300_switch.o
-obj-$(CONFIG_CPU_R6000)		+= r6000_fpu.o r4k_switch.o
 obj-$(CONFIG_CPU_TX39XX)	+= r2300_fpu.o r2300_switch.o
 obj-$(CONFIG_CPU_CAVIUM_OCTEON)	+= r4k_fpu.o octeon_switch.o
 
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 1aba27786bd5..ddc86f98eb86 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -1391,24 +1391,6 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 			     MIPS_CPU_DIVEC | MIPS_CPU_LLSC;
 		c->tlbsize = 48;
 		break;
-	case PRID_IMP_R6000:
-		c->cputype = CPU_R6000;
-		__cpu_name[cpu] = "R6000";
-		set_isa(c, MIPS_CPU_ISA_II);
-		c->fpu_msk31 |= FPU_CSR_CONDX | FPU_CSR_FS;
-		c->options = MIPS_CPU_TLB | MIPS_CPU_FPU |
-			     MIPS_CPU_LLSC;
-		c->tlbsize = 32;
-		break;
-	case PRID_IMP_R6000A:
-		c->cputype = CPU_R6000A;
-		__cpu_name[cpu] = "R6000A";
-		set_isa(c, MIPS_CPU_ISA_II);
-		c->fpu_msk31 |= FPU_CSR_CONDX | FPU_CSR_FS;
-		c->options = MIPS_CPU_TLB | MIPS_CPU_FPU |
-			     MIPS_CPU_LLSC;
-		c->tlbsize = 32;
-		break;
 	case PRID_IMP_RM7000:
 		c->cputype = CPU_RM7000;
 		__cpu_name[cpu] = "RM7000";
diff --git a/arch/mips/kernel/r6000_fpu.S b/arch/mips/kernel/r6000_fpu.S
deleted file mode 100644
index 9cc7bfab3419..000000000000
--- a/arch/mips/kernel/r6000_fpu.S
+++ /dev/null
@@ -1,99 +0,0 @@
-/*
- * r6000_fpu.S: Save/restore floating point context for signal handlers.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 1996 by Ralf Baechle
- *
- * Multi-arch abstraction and asm macros for easier reading:
- * Copyright (C) 1996 David S. Miller (davem@davemloft.net)
- */
-#include <asm/asm.h>
-#include <asm/fpregdef.h>
-#include <asm/mipsregs.h>
-#include <asm/asm-offsets.h>
-#include <asm/regdef.h>
-
-	.set	noreorder
-	.set	mips2
-	.set	push
-	SET_HARDFLOAT
-
-/**
- * _save_fp_context() - save FP context from the FPU
- * @a0 - pointer to fpregs field of sigcontext
- * @a1 - pointer to fpc_csr field of sigcontext
- *
- * Save FP context, including the 32 FP data registers and the FP
- * control & status register, from the FPU to signal context.
- */
-	LEAF(_save_fp_context)
-	mfc0	t0,CP0_STATUS
-	sll	t0,t0,2
-	bgez	t0,1f
-	 nop
-
-	cfc1	t1,fcr31
-	/* Store the 16 double precision registers */
-	sdc1	$f0,0(a0)
-	sdc1	$f2,16(a0)
-	sdc1	$f4,32(a0)
-	sdc1	$f6,48(a0)
-	sdc1	$f8,64(a0)
-	sdc1	$f10,80(a0)
-	sdc1	$f12,96(a0)
-	sdc1	$f14,112(a0)
-	sdc1	$f16,128(a0)
-	sdc1	$f18,144(a0)
-	sdc1	$f20,160(a0)
-	sdc1	$f22,176(a0)
-	sdc1	$f24,192(a0)
-	sdc1	$f26,208(a0)
-	sdc1	$f28,224(a0)
-	sdc1	$f30,240(a0)
-	jr	ra
-	 sw	t0,(a1)
-1:	jr	ra
-	 nop
-	END(_save_fp_context)
-
-/**
- * _restore_fp_context() - restore FP context to the FPU
- * @a0 - pointer to fpregs field of sigcontext
- * @a1 - pointer to fpc_csr field of sigcontext
- *
- * Restore FP context, including the 32 FP data registers and the FP
- * control & status register, from signal context to the FPU.
- */
-	LEAF(_restore_fp_context)
-	mfc0	t0,CP0_STATUS
-	sll	t0,t0,2
-
-	bgez	t0,1f
-	 lw	t0,(a1)
-	/* Restore the 16 double precision registers */
-	ldc1	$f0,0(a0)
-	ldc1	$f2,16(a0)
-	ldc1	$f4,32(a0)
-	ldc1	$f6,48(a0)
-	ldc1	$f8,64(a0)
-	ldc1	$f10,80(a0)
-	ldc1	$f12,96(a0)
-	ldc1	$f14,112(a0)
-	ldc1	$f16,128(a0)
-	ldc1	$f18,144(a0)
-	ldc1	$f20,160(a0)
-	ldc1	$f22,176(a0)
-	ldc1	$f24,192(a0)
-	ldc1	$f26,208(a0)
-	ldc1	$f28,224(a0)
-	ldc1	$f30,240(a0)
-	jr	ra
-	 ctc1	t0,fcr31
-1:	jr	ra
-	 nop
-	END(_restore_fp_context)
-
-	.set pop	/* SET_HARDFLOAT */
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 9681b5877140..4ad3e4f39339 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -2425,21 +2425,6 @@ void __init trap_init(void)
 	set_except_vector(EXCCODE_TR, handle_tr);
 	set_except_vector(EXCCODE_MSAFPE, handle_msa_fpe);
 
-	if (current_cpu_type() == CPU_R6000 ||
-	    current_cpu_type() == CPU_R6000A) {
-		/*
-		 * The R6000 is the only R-series CPU that features a machine
-		 * check exception (similar to the R4000 cache error) and
-		 * unaligned ldc1/sdc1 exception.  The handlers have not been
-		 * written yet.	 Well, anyway there is no R6000 machine on the
-		 * current list of targets for Linux/MIPS.
-		 * (Duh, crap, there is someone with a triple R6k machine)
-		 */
-		//set_except_vector(14, handle_mc);
-		//set_except_vector(15, handle_ndc);
-	}
-
-
 	if (board_nmi_handler_setup)
 		board_nmi_handler_setup();
 
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index ed1c5297547a..7dfc8f8b9960 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -2599,11 +2599,6 @@ void build_tlb_refill_handler(void)
 #endif
 		break;
 
-	case CPU_R6000:
-	case CPU_R6000A:
-		panic("No R6000 TLB refill handler yet");
-		break;
-
 	case CPU_R8000:
 		panic("No R8000 TLB refill handler yet");
 		break;
-- 
2.13.0
