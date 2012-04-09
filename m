Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Apr 2012 17:25:22 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:39807 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903693Ab2DIPW2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Apr 2012 17:22:28 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1SHGQ9-0005vf-IJ; Mon, 09 Apr 2012 10:22:21 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>
Subject: [PATCH 6/9] MIPS: Add support for microMIPS exception handling.
Date:   Mon,  9 Apr 2012 10:22:00 -0500
Message-Id: <1333984923-445-7-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.9.6
In-Reply-To: <1333984923-445-1-git-send-email-sjhill@mips.com>
References: <1333984923-445-1-git-send-email-sjhill@mips.com>
X-archive-position: 32898
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@mips.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: "Steven J. Hill" <sjhill@mips.com>

All exceptions must be taken in microMIPS mode, never in MIPS32R2
mode or the kernel falls apart. A few 'nop' instructions are used
to maintain the correct alignment of microMIPS versions of the
exception vectors.

Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/include/asm/stackframe.h |   12 +-
 arch/mips/kernel/genex.S           |   82 +++++---
 arch/mips/kernel/scall32-o32.S     |   22 ++-
 arch/mips/kernel/smtc-asm.S        |    3 +
 arch/mips/kernel/traps.c           |  377 +++++++++++++++++++++++++-----------
 arch/mips/mm/tlbex.c               |   21 ++
 arch/mips/mti-sead3/sead3-init.c   |   57 +++++-
 7 files changed, 424 insertions(+), 150 deletions(-)

diff --git a/arch/mips/include/asm/stackframe.h b/arch/mips/include/asm/stackframe.h
index cb41af5..335ce06 100644
--- a/arch/mips/include/asm/stackframe.h
+++ b/arch/mips/include/asm/stackframe.h
@@ -139,7 +139,7 @@
 1:		move	ra, k0
 		li	k0, 3
 		mtc0	k0, $22
-#endif /* CONFIG_CPU_LOONGSON2F */
+#endif /* CONFIG_CPU_JUMP_WORKAROUNDS */
 #if defined(CONFIG_32BIT) || defined(KBUILD_64BIT_SYM32)
 		lui	k1, %hi(kernelsp)
 #else
@@ -189,6 +189,7 @@
 		LONG_S	$0, PT_R0(sp)
 		mfc0	v1, CP0_STATUS
 		LONG_S	$2, PT_R2(sp)
+		LONG_S	v1, PT_STATUS(sp)
 #ifdef CONFIG_MIPS_MT_SMTC
 		/*
 		 * Ideally, these instructions would be shuffled in
@@ -200,21 +201,20 @@
 		LONG_S	k0, PT_TCSTATUS(sp)
 #endif /* CONFIG_MIPS_MT_SMTC */
 		LONG_S	$4, PT_R4(sp)
-		LONG_S	$5, PT_R5(sp)
-		LONG_S	v1, PT_STATUS(sp)
 		mfc0	v1, CP0_CAUSE
-		LONG_S	$6, PT_R6(sp)
-		LONG_S	$7, PT_R7(sp)
+		LONG_S	$5, PT_R5(sp)
 		LONG_S	v1, PT_CAUSE(sp)
+		LONG_S	$6, PT_R6(sp)
 		MFC0	v1, CP0_EPC
+		LONG_S	$7, PT_R7(sp)
 #ifdef CONFIG_64BIT
 		LONG_S	$8, PT_R8(sp)
 		LONG_S	$9, PT_R9(sp)
 #endif
+		LONG_S	v1, PT_EPC(sp)
 		LONG_S	$25, PT_R25(sp)
 		LONG_S	$28, PT_R28(sp)
 		LONG_S	$31, PT_R31(sp)
-		LONG_S	v1, PT_EPC(sp)
 		ori	$28, sp, _THREAD_MASK
 		xori	$28, _THREAD_MASK
 #ifdef CONFIG_CPU_CAVIUM_OCTEON
diff --git a/arch/mips/kernel/genex.S b/arch/mips/kernel/genex.S
index 8882e57..f094c82 100644
--- a/arch/mips/kernel/genex.S
+++ b/arch/mips/kernel/genex.S
@@ -3,9 +3,9 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Copyright (C) 1994 - 2000, 2001, 2003 Ralf Baechle
- * Copyright (C) 1999, 2000 Silicon Graphics, Inc.
- * Copyright (C) 2001 MIPS Technologies, Inc.
+ * Copyright (C) 1994 - 2001, 2003  Ralf Baechle
+ * Copyright (C) 1999, 2000  Silicon Graphics, Inc.
+ * Copyright (C) 2001, 2011  MIPS Technologies, Inc.
  * Copyright (C) 2002, 2007  Maciej W. Rozycki
  */
 #include <linux/init.h>
@@ -22,8 +22,10 @@
 #include <asm/page.h>
 #include <asm/thread_info.h>
 
+#ifdef CONFIG_MIPS_MT_SMTC
 #define PANIC_PIC(msg)					\
-		.set push;				\
+		.set	push;				\
+		.set	nomicromips;			\
 		.set	reorder;			\
 		PTR_LA	a0,8f;				\
 		.set	noat;				\
@@ -32,17 +34,10 @@
 9:		b	9b;				\
 		.set	pop;				\
 		TEXT(msg)
+#endif
 
 	__INIT
 
-NESTED(except_vec0_generic, 0, sp)
-	PANIC_PIC("Exception vector 0 called")
-	END(except_vec0_generic)
-
-NESTED(except_vec1_generic, 0, sp)
-	PANIC_PIC("Exception vector 1 called")
-	END(except_vec1_generic)
-
 /*
  * General exception vector for all other CPUs.
  *
@@ -65,6 +60,7 @@ NESTED(except_vec3_generic, 0, sp)
 	.set	pop
 	END(except_vec3_generic)
 
+#if (cpu_has_vce != 0)
 /*
  * General exception handler for CPUs with virtual coherency exception.
  *
@@ -124,6 +120,7 @@ handle_vcei:
 	eret
 	.set	pop
 	END(except_vec3_r4000)
+#endif /* (cpu_has_vce == 0) */
 
 	__FINIT
 
@@ -139,12 +136,19 @@ LEAF(r4k_wait)
 	 nop
 	nop
 	nop
+#ifdef CONFIG_CPU_MICROMIPS
+	nop
+	nop
+	nop
+	nop
+#endif
 	.set	mips3
 	wait
 	/* end of rollback region (the region size must be power of two) */
-	.set	pop
 1:
 	jr	ra
+	nop
+	.set	pop
 	END(r4k_wait)
 
 	.macro	BUILD_ROLLBACK_PROLOGUE handler
@@ -202,7 +206,11 @@ NESTED(handle_int, PT_SIZE, sp)
 	LONG_L	s0, TI_REGS($28)
 	LONG_S	sp, TI_REGS($28)
 	PTR_LA	ra, ret_from_irq
-	j	plat_irq_dispatch
+	PTR_LA  v0, plat_irq_dispatch
+	jr	v0
+#ifdef CONFIG_CPU_MICROMIPS
+	nop
+#endif
 	END(handle_int)
 
 	__INIT
@@ -223,11 +231,14 @@ NESTED(except_vec4, 0, sp)
 /*
  * EJTAG debug exception handler.
  * The EJTAG debug exception entry point is 0xbfc00480, which
- * normally is in the boot PROM, so the boot PROM must do a
+ * normally is in the boot PROM, so the boot PROM must do an
  * unconditional jump to this vector.
  */
 NESTED(except_vec_ejtag_debug, 0, sp)
 	j	ejtag_debug_handler
+#ifdef CONFIG_CPU_MICROMIPS
+	 nop
+#endif
 	END(except_vec_ejtag_debug)
 
 	__FINIT
@@ -252,9 +263,10 @@ NESTED(except_vec_vi, 0, sp)
 FEXPORT(except_vec_vi_mori)
 	ori	a0, $0, 0
 #endif /* CONFIG_MIPS_MT_SMTC */
+	PTR_LA	v1, except_vec_vi_handler
 FEXPORT(except_vec_vi_lui)
 	lui	v0, 0		/* Patched */
-	j	except_vec_vi_handler
+	jr	v1
 FEXPORT(except_vec_vi_ori)
 	 ori	v0, 0		/* Patched */
 	.set	pop
@@ -355,6 +367,9 @@ EXPORT(ejtag_debug_buffer)
  */
 NESTED(except_vec_nmi, 0, sp)
 	j	nmi_handler
+#ifdef CONFIG_CPU_MICROMIPS
+	 nop
+#endif
 	END(except_vec_nmi)
 
 	__FINIT
@@ -363,7 +378,7 @@ NESTED(nmi_handler, PT_SIZE, sp)
 	.set	push
 	.set	noat
 	SAVE_ALL
- 	move	a0, sp
+	move	a0, sp
 	jal	nmi_exception_handler
 	RESTORE_ALL
 	.set	mips3
@@ -501,13 +516,36 @@ NESTED(nmi_handler, PT_SIZE, sp)
 	.set	push
 	.set	noat
 	.set	noreorder
-	/* 0x7c03e83b: rdhwr v1,$29 */
+	/* MIPS32: 0x7c03e83b: rdhwr v1,$29 */
+	/* uMIPS:  0x007d6b3c: rdhwr v1,$29 -- in MIPS16e it is  */
+	/*         ADDIUSP $16,0x7d; LI $3,0x3c and never RI. LY22 */
 	MFC0	k1, CP0_EPC
-	lui	k0, 0x7c03
-	lw	k1, (k1)
-	ori	k0, 0xe83b
-	.set	reorder
+#if defined(CONFIG_CPU_MICROMIPS) || defined(CONFIG_CPU_MIPS32_R2) || defined(CONFIG_CPU_MIPS64_R2)
+	and     k0, k1, 1
+	beqz    k0, 1f
+	xor     k1, k0
+	lhu     k0, (k1)
+	lhu     k1, 2(k1)
+	ins     k1, k0, 16, 16
+	lui     k0, 0x007d
+	b       docheck
+	ori     k0, 0x6b3c
+1:
+	lui     k0, 0x7c03
+	lw      k1, (k1)
+	ori     k0, 0xe83b
+#else
+	andi    k0, k1, 1
+	bnez    k0, handle_ri
+	lui     k0, 0x7c03
+	lw      k1, (k1)
+	ori     k0, 0xe83b
+#endif
+	.set    reorder
+docheck:
 	bne	k0, k1, handle_ri	/* if not ours */
+
+isrdhwr:
 	/* The insn is rdhwr.  No need to check CAUSE.BD here. */
 	get_saved_sp	/* k1 := current_thread_info */
 	.set	noreorder
diff --git a/arch/mips/kernel/scall32-o32.S b/arch/mips/kernel/scall32-o32.S
index a632bc1..62e7cff 100644
--- a/arch/mips/kernel/scall32-o32.S
+++ b/arch/mips/kernel/scall32-o32.S
@@ -143,15 +143,29 @@ stackargs:
 	jr	t1
 	 addiu	t1, 6f - 5f
 
-2:	lw	t8, 28(t0)		# argument #8 from usp
-3:	lw	t7, 24(t0)		# argument #7 from usp
-4:	lw	t6, 20(t0)		# argument #6 from usp
-5:	jr	t1
+2:	.insn
+	lw	t8, 28(t0)		# argument #8 from usp
+3:	.insn
+	lw	t7, 24(t0)		# argument #7 from usp
+4:	.insn
+	lw	t6, 20(t0)		# argument #6 from usp
+5:	.insn
+	jr	t1
 	 sw	t5, 16(sp)		# argument #5 to ksp
 
+#ifdef CONFIG_CPU_MICROMIPS
+	## FIXME:
+	sw	t8, 28(sp)		# argument #8 to ksp
+	nop
+	sw	t7, 24(sp)		# argument #7 to ksp
+	nop
+	sw	t6, 20(sp)		# argument #6 to ksp
+	nop
+#else
 	sw	t8, 28(sp)		# argument #8 to ksp
 	sw	t7, 24(sp)		# argument #7 to ksp
 	sw	t6, 20(sp)		# argument #6 to ksp
+#endif
 6:	j	stack_done		# go back
 	 nop
 	.set	pop
diff --git a/arch/mips/kernel/smtc-asm.S b/arch/mips/kernel/smtc-asm.S
index 20938a4..8e9ae50 100644
--- a/arch/mips/kernel/smtc-asm.S
+++ b/arch/mips/kernel/smtc-asm.S
@@ -49,6 +49,9 @@ CAN WE PROVE THAT WE WON'T DO THIS IF INTS DISABLED??
 	.text
 	.align 5
 FEXPORT(__smtc_ipi_vector)
+#ifdef CONFIG_CPU_MICROMIPS
+	nop
+#endif
 	.set	noat
 	/* Disable thread scheduling to make Status update atomic */
 	DMT	27					# dmt	k1
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index f4858a0..b88e63d 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -10,6 +10,7 @@
  * Kevin D. Kissell, kevink@mips.com and Carsten Langgaard, carstenl@mips.com
  * Copyright (C) 2000, 01 MIPS Technologies, Inc.
  * Copyright (C) 2002, 2003, 2004, 2005, 2007  Maciej W. Rozycki
+ * Copyright (C) 2011 MIPS Technologies, Inc.
  */
 #include <linux/bug.h>
 #include <linux/compiler.h>
@@ -81,10 +82,6 @@ extern asmlinkage void handle_dsp(void);
 extern asmlinkage void handle_mcheck(void);
 extern asmlinkage void handle_reserved(void);
 
-extern int fpu_emulator_cop1Handler(struct pt_regs *xcp,
-				    struct mips_fpu_struct *ctx, int has_fpu,
-				    void *__user *fault_addr);
-
 void (*board_be_init)(void);
 int (*board_be_handler)(struct pt_regs *regs, int is_fixup);
 void (*board_nmi_handler_setup)(void);
@@ -92,6 +89,7 @@ void (*board_ejtag_handler_setup)(void);
 void (*board_bind_eic_interrupt)(int irq, int regset);
 void (*board_ebase_setup)(void);
 
+static void mt_ase_fp_affinity(void);
 
 static void show_raw_backtrace(unsigned long reg29)
 {
@@ -487,6 +485,12 @@ asmlinkage void do_be(struct pt_regs *regs)
 #define SYNC   0x0000000f
 #define RDHWR  0x0000003b
 
+/*  microMIPS definitions   */
+#define MM_POOL32A_FUNC 0xfc00ffff
+#define MM_RDHWR        0x00006b3c
+#define MM_RS           0x001f0000
+#define MM_RT           0x03e00000
+
 /*
  * The ll_bit is cleared by r*_switch.S
  */
@@ -510,7 +514,7 @@ static inline int simulate_ll(struct pt_regs *regs, unsigned int opcode)
 	offset >>= 16;
 
 	vaddr = (unsigned long __user *)
-	        ((unsigned long)(regs->regs[(opcode & BASE) >> 21]) + offset);
+		((unsigned long)(regs->regs[(opcode & BASE) >> 21]) + offset);
 
 	if ((unsigned long)vaddr & 3)
 		return SIGBUS;
@@ -550,7 +554,7 @@ static inline int simulate_sc(struct pt_regs *regs, unsigned int opcode)
 	offset >>= 16;
 
 	vaddr = (unsigned long __user *)
-	        ((unsigned long)(regs->regs[(opcode & BASE) >> 21]) + offset);
+		((unsigned long)(regs->regs[(opcode & BASE) >> 21]) + offset);
 	reg = (opcode & RT) >> 16;
 
 	if ((unsigned long)vaddr & 3)
@@ -601,48 +605,72 @@ static int simulate_llsc(struct pt_regs *regs, unsigned int opcode)
  * Simulate trapping 'rdhwr' instructions to provide user accessible
  * registers not implemented in hardware.
  */
-static int simulate_rdhwr(struct pt_regs *regs, unsigned int opcode)
+static int simulate_rdhwr(struct pt_regs *regs, int rd, int rt)
 {
 	struct thread_info *ti = task_thread_info(current);
 
+	perf_sw_event(PERF_COUNT_SW_EMULATION_FAULTS,
+			1, regs, 0);
+	switch (rd) {
+	case 0:		/* CPU number */
+		regs->regs[rt] = smp_processor_id();
+		return 0;
+	case 1:		/* SYNCI length */
+		regs->regs[rt] = min(current_cpu_data.dcache.linesz,
+				     current_cpu_data.icache.linesz);
+		return 0;
+	case 2:		/* Read count register */
+		regs->regs[rt] = read_c0_count();
+		return 0;
+	case 3:		/* Count register resolution */
+		switch (current_cpu_data.cputype) {
+		case CPU_20KC:
+		case CPU_25KF:
+			regs->regs[rt] = 1;
+			break;
+		default:
+			regs->regs[rt] = 2;
+		}
+		return 0;
+	case 29:
+		regs->regs[rt] = ti->tp_value;
+		return 0;
+	default:
+		return -1;
+	}
+}
+
+static int simulate_rdhwr_normal(struct pt_regs *regs, unsigned int opcode)
+{
 	if ((opcode & OPCODE) == SPEC3 && (opcode & FUNC) == RDHWR) {
 		int rd = (opcode & RD) >> 11;
 		int rt = (opcode & RT) >> 16;
-		perf_sw_event(PERF_COUNT_SW_EMULATION_FAULTS,
-				1, regs, 0);
-		switch (rd) {
-		case 0:		/* CPU number */
-			regs->regs[rt] = smp_processor_id();
-			return 0;
-		case 1:		/* SYNCI length */
-			regs->regs[rt] = min(current_cpu_data.dcache.linesz,
-					     current_cpu_data.icache.linesz);
-			return 0;
-		case 2:		/* Read count register */
-			regs->regs[rt] = read_c0_count();
-			return 0;
-		case 3:		/* Count register resolution */
-			switch (current_cpu_data.cputype) {
-			case CPU_20KC:
-			case CPU_25KF:
-				regs->regs[rt] = 1;
-				break;
-			default:
-				regs->regs[rt] = 2;
-			}
-			return 0;
-		case 29:
-			regs->regs[rt] = ti->tp_value;
-			return 0;
-		default:
-			return -1;
-		}
+
+		simulate_rdhwr(regs, rd, rt);
+		return 0;
+	}
+
+	/* Not ours.  */
+	return -1;
+}
+
+static int simulate_rdhwr_mm(struct pt_regs *regs, unsigned short opcode)
+{
+	if ((opcode & MM_POOL32A_FUNC) == MM_RDHWR) {
+		int rd = (opcode & MM_RS) >> 16;
+		int rt = (opcode & MM_RT) >> 21;
+		simulate_rdhwr(regs, rd, rt);
+		return 0;
 	}
 
 	/* Not ours.  */
 	return -1;
 }
 
+
+
+
+
 static int simulate_sync(struct pt_regs *regs, unsigned int opcode)
 {
 	if ((opcode & OPCODE) == SPEC0 && (opcode & FUNC) == SYNC) {
@@ -667,7 +695,7 @@ asmlinkage void do_ov(struct pt_regs *regs)
 	force_sig_info(SIGFPE, &info, current);
 }
 
-static int process_fpemu_return(int sig, void __user *fault_addr)
+int process_fpemu_return(int sig, void __user *fault_addr)
 {
 	if (sig == SIGSEGV || sig == SIGBUS) {
 		struct siginfo si = {0};
@@ -789,10 +817,12 @@ static void do_trap_or_bp(struct pt_regs *regs, unsigned int code,
 		info.si_addr = (void __user *) regs->cp0_epc;
 		force_sig_info(SIGFPE, &info, current);
 		break;
+	case MM_BRK_BUG:
 	case BRK_BUG:
 		die_if_kernel("Kernel bug detected", regs);
 		force_sig(SIGTRAP, current);
 		break;
+	case MM_BRK_MEMU:
 	case BRK_MEMU:
 		/*
 		 * Address errors may be deliberately induced by the FPU
@@ -818,9 +848,29 @@ static void do_trap_or_bp(struct pt_regs *regs, unsigned int code,
 asmlinkage void do_bp(struct pt_regs *regs)
 {
 	unsigned int opcode, bcode;
-
-	if (__get_user(opcode, (unsigned int __user *) exception_epc(regs)))
-		goto out_sigsegv;
+	unsigned long epc;
+	u16 instr[2];
+
+	if (regs->cp0_epc & MIPS_ISA_MODE) {
+		/* calc exception pc */
+		epc = exception_epc(regs);
+		if (cpu_has_mmips) {
+			if ((__get_user(instr[0], (u16 __user *)(epc & ~MIPS_ISA_MODE))) ||
+			    (__get_user(instr[1], (u16 __user *)((epc+2) & ~MIPS_ISA_MODE))))
+				goto out_sigsegv;
+		    opcode = (instr[0] << 16) | instr[1];
+		} else {
+		    /* MIPS16e mode */
+		    if (__get_user(instr[0], (u16 __user *)(epc & ~MIPS_ISA_MODE)))
+				goto out_sigsegv;
+		    bcode = (instr[0] >> 6) & 0x3f;
+		    do_trap_or_bp(regs, bcode, "Break");
+		    return;
+		}
+	} else {
+		if (__get_user(opcode, (unsigned int __user *) exception_epc(regs)))
+			goto out_sigsegv;
+	}
 
 	/*
 	 * There is the ancient bug in the MIPS assemblers that the break
@@ -861,13 +911,22 @@ out_sigsegv:
 asmlinkage void do_tr(struct pt_regs *regs)
 {
 	unsigned int opcode, tcode = 0;
+	u16 instr[2];
+	unsigned long epc = exception_epc(regs);
 
-	if (__get_user(opcode, (unsigned int __user *) exception_epc(regs)))
-		goto out_sigsegv;
+	if ((__get_user(instr[0], (u16 __user *)(epc & ~MIPS_ISA_MODE))) ||
+		(__get_user(instr[1], (u16 __user *)((epc+2) & ~MIPS_ISA_MODE))))
+			goto out_sigsegv;
+	opcode = (instr[0] << 16) | instr[1];
 
 	/* Immediate versions don't provide a code.  */
-	if (!(opcode & OPCODE))
-		tcode = ((opcode >> 6) & ((1 << 10) - 1));
+	if (!(opcode & OPCODE)) {
+		if (is16mode(regs))
+			/* microMIPS */
+			tcode = (opcode >> 12) & 0x1f;
+		else
+			tcode = ((opcode >> 6) & ((1 << 10) - 1));
+	}
 
 	do_trap_or_bp(regs, tcode, "Trap");
 	return;
@@ -880,8 +939,10 @@ asmlinkage void do_ri(struct pt_regs *regs)
 {
 	unsigned int __user *epc = (unsigned int __user *)exception_epc(regs);
 	unsigned long old_epc = regs->cp0_epc;
+	unsigned long old31 = regs->regs[31];
 	unsigned int opcode = 0;
 	int status = -1;
+	unsigned short mmop[2];
 
 	if (notify_die(DIE_RI, "RI Fault", regs, 0, regs_to_trapnr(regs), SIGILL)
 	    == NOTIFY_STOP)
@@ -892,23 +953,35 @@ asmlinkage void do_ri(struct pt_regs *regs)
 	if (unlikely(compute_return_epc(regs) < 0))
 		return;
 
-	if (unlikely(get_user(opcode, epc) < 0))
-		status = SIGSEGV;
+	if (is16mode(regs)) {
+		if (unlikely(get_user(mmop[0], epc) < 0))
+			status = SIGSEGV;
+		if (unlikely(get_user(mmop[1], epc) < 0))
+			status = SIGSEGV;
+		opcode = (mmop[0] << 16) | mmop[1];
 
-	if (!cpu_has_llsc && status < 0)
-		status = simulate_llsc(regs, opcode);
+		if (status < 0)
+			status = simulate_rdhwr_mm(regs, opcode);
+	} else {
+		if (unlikely(get_user(opcode, epc) < 0))
+			status = SIGSEGV;
 
-	if (status < 0)
-		status = simulate_rdhwr(regs, opcode);
+		if (!cpu_has_llsc && status < 0)
+			status = simulate_llsc(regs, opcode);
 
-	if (status < 0)
-		status = simulate_sync(regs, opcode);
+		if (status < 0)
+			status = simulate_rdhwr_normal(regs, opcode);
+
+		if (status < 0)
+			status = simulate_sync(regs, opcode);
+	}
 
 	if (status < 0)
 		status = SIGILL;
 
 	if (unlikely(status > 0)) {
-		regs->cp0_epc = old_epc;		/* Undo skip-over.  */
+		regs->cp0_epc = old_epc;                /* Undo skip-over.  */
+		regs->regs[31] = old31;
 		force_sig(status, current);
 	}
 }
@@ -978,11 +1051,12 @@ static int default_cu2_call(struct notifier_block *nfb, unsigned long action,
 asmlinkage void do_cpu(struct pt_regs *regs)
 {
 	unsigned int __user *epc;
-	unsigned long old_epc;
+	unsigned long old_epc, old31;
 	unsigned int opcode;
 	unsigned int cpid;
 	int status;
 	unsigned long __maybe_unused flags;
+	unsigned short mmop[2];
 
 	die_if_kernel("do_cpu invoked from kernel context!", regs);
 
@@ -992,26 +1066,39 @@ asmlinkage void do_cpu(struct pt_regs *regs)
 	case 0:
 		epc = (unsigned int __user *)exception_epc(regs);
 		old_epc = regs->cp0_epc;
+		old31 = regs->regs[31];
 		opcode = 0;
 		status = -1;
 
 		if (unlikely(compute_return_epc(regs) < 0))
 			return;
 
-		if (unlikely(get_user(opcode, epc) < 0))
-			status = SIGSEGV;
+		if (is16mode(regs)) {
+			if (unlikely(get_user(mmop[0], epc) < 0))
+				status = SIGSEGV;
+			if (unlikely(get_user(mmop[1], epc) < 0))
+				status = SIGSEGV;
+			opcode = (mmop[0] << 16) | mmop[1];
 
-		if (!cpu_has_llsc && status < 0)
-			status = simulate_llsc(regs, opcode);
+			if (status < 0)
+				status = simulate_rdhwr_mm(regs, opcode);
+		} else {
+			if (unlikely(get_user(opcode, epc) < 0))
+				status = SIGSEGV;
 
-		if (status < 0)
-			status = simulate_rdhwr(regs, opcode);
+			if (!cpu_has_llsc && status < 0)
+				status = simulate_llsc(regs, opcode);
+
+			if (status < 0)
+				status = simulate_rdhwr_normal(regs, opcode);
+		}
 
 		if (status < 0)
 			status = SIGILL;
 
 		if (unlikely(status > 0)) {
-			regs->cp0_epc = old_epc;	/* Undo skip-over.  */
+			regs->cp0_epc = old_epc;        /* Undo skip-over.  */
+			regs->regs[31] = old31;
 			force_sig(status, current);
 		}
 
@@ -1208,6 +1295,7 @@ static inline void parity_protection_init(void)
 	case CPU_34K:
 	case CPU_74K:
 	case CPU_1004K:
+	case CPU_1074K:
 		{
 #define ERRCTL_PE	0x80000000
 #define ERRCTL_L2P	0x00800000
@@ -1323,7 +1411,7 @@ asmlinkage void cache_parity_error(void)
 void ejtag_exception_handler(struct pt_regs *regs)
 {
 	const int field = 2 * sizeof(unsigned long);
-	unsigned long depc, old_epc;
+	unsigned long depc, old_epc, old_ra;
 	unsigned int debug;
 
 	printk(KERN_DEBUG "SDBBP EJTAG debug exception - not handled yet, just ignored!\n");
@@ -1338,10 +1426,12 @@ void ejtag_exception_handler(struct pt_regs *regs)
 		 * calculation.
 		 */
 		old_epc = regs->cp0_epc;
+		old_ra = regs->regs[31];
 		regs->cp0_epc = depc;
-		__compute_return_epc(regs);
+		compute_return_epc(regs);
 		depc = regs->cp0_epc;
 		regs->cp0_epc = old_epc;
+		regs->regs[31] = old_ra;
 	} else
 		depc += 4;
 	write_c0_depc(depc);
@@ -1377,14 +1467,59 @@ unsigned long ebase;
 unsigned long exception_handlers[32];
 unsigned long vi_handlers[64];
 
+/* Install CPU exception handler */
+void __cpuinit set_handler(unsigned long offset, void *addr, unsigned long size)
+{
+#ifdef CONFIG_CPU_MICROMIPS
+	memcpy((void *)(ebase + offset), ((unsigned char *)addr - 1), size);
+#else
+	memcpy((void *)(ebase + offset), addr, size);
+#endif
+	local_flush_icache_range(ebase + offset, ebase + offset + size);
+}
+
+static char panic_null_cerr[] __cpuinitdata =
+	"Trying to set NULL cache error exception handler";
+
+/*
+ * Install uncached CPU exception handler.
+ * This is suitable only for the cache error exception which is the only
+ * exception handler that is being run uncached.
+ */
+void __cpuinit set_uncached_handler(unsigned long offset, void *addr,
+	unsigned long size)
+{
+	unsigned long uncached_ebase = CKSEG1ADDR(ebase);
+
+	if (!addr)
+		panic(panic_null_cerr);
+
+	memcpy((void *)(uncached_ebase + offset), addr, size);
+}
+
 void __init *set_except_vector(int n, void *addr)
 {
 	unsigned long handler = (unsigned long) addr;
 	unsigned long old_handler = exception_handlers[n];
 
+#ifdef CONFIG_CPU_MICROMIPS
+	/*
+	 * Only the TLB handlers are cache aligned with an even
+	 * address. All other handlers are on an odd address and
+	 * require no modification. Otherwise, MIPS32 mode will
+	 * be entered when handling any TLB exceptions. That
+	 * would be bad...since we must stay in microMIPS mode.
+	 */
+	if (!(handler & 0x1))
+		handler |= 1;
+#endif
 	exception_handlers[n] = handler;
 	if (n == 0 && cpu_has_divec) {
+#ifdef CONFIG_CPU_MICROMIPS
+		unsigned long jump_mask = ~((1 << 27) - 1);
+#else
 		unsigned long jump_mask = ~((1 << 28) - 1);
+#endif
 		u32 *buf = (u32 *)(ebase + 0x200);
 		unsigned int k0 = 26;
 		if ((handler & jump_mask) == ((ebase + 0x200) & jump_mask)) {
@@ -1411,17 +1546,18 @@ static void *set_vi_srs_handler(int n, vi_handler_t addr, int srs)
 	unsigned long handler;
 	unsigned long old_handler = vi_handlers[n];
 	int srssets = current_cpu_data.srsets;
-	u32 *w;
+	u16 *h;
 	unsigned char *b;
 
 	BUG_ON(!cpu_has_veic && !cpu_has_vint);
+	BUG_ON((n < 0) && (n > 9));
 
 	if (addr == NULL) {
 		handler = (unsigned long) do_default_vi;
 		srs = 0;
 	} else
 		handler = (unsigned long) addr;
-	vi_handlers[n] = (unsigned long) addr;
+	vi_handlers[n] = handler;
 
 	b = (unsigned char *)(ebase + 0x200 + n*VECTORSPACING);
 
@@ -1434,15 +1570,21 @@ static void *set_vi_srs_handler(int n, vi_handler_t addr, int srs)
 	} else if (cpu_has_vint) {
 		/* SRSMap is only defined if shadow sets are implemented */
 		if (srssets > 1)
-			change_c0_srsmap(0xf << n*4, srs << n*4);
+		{
+			if (n < 8)
+				change_c0_srsmap(0xf << (n * 4),
+					srs << (n * 4));
+			else
+				change_c0_srsmap2(0xf << ((n - 8) * 4),
+					srs << ((n - 8) * 4));
+		}
 	}
 
 	if (srs == 0) {
 		/*
 		 * If no shadow set is selected then use the default handler
-		 * that does normal register saving and a standard interrupt exit
+		 * that does normal register saving and standard interrupt exit
 		 */
-
 		extern char except_vec_vi, except_vec_vi_lui;
 		extern char except_vec_vi_ori, except_vec_vi_end;
 		extern char rollback_except_vec_vi;
@@ -1455,11 +1597,20 @@ static void *set_vi_srs_handler(int n, vi_handler_t addr, int srs)
 		 * Status.IM bit to be masked before going there.
 		 */
 		extern char except_vec_vi_mori;
+#if defined(CONFIG_CPU_MICROMIPS) || defined(CONFIG_CPU_BIG_ENDIAN)
+		const int mori_offset = &except_vec_vi_mori - vec_start + 2;
+#else
 		const int mori_offset = &except_vec_vi_mori - vec_start;
+#endif
 #endif /* CONFIG_MIPS_MT_SMTC */
-		const int handler_len = &except_vec_vi_end - vec_start;
+#if defined(CONFIG_CPU_MICROMIPS) || defined(CONFIG_CPU_BIG_ENDIAN)
+		const int lui_offset = &except_vec_vi_lui - vec_start + 2;
+		const int ori_offset = &except_vec_vi_ori - vec_start + 2;
+#else
 		const int lui_offset = &except_vec_vi_lui - vec_start;
 		const int ori_offset = &except_vec_vi_ori - vec_start;
+#endif
+		const int handler_len = &except_vec_vi_end - vec_start;
 
 		if (handler_len > VECTORSPACING) {
 			/*
@@ -1469,30 +1620,44 @@ static void *set_vi_srs_handler(int n, vi_handler_t addr, int srs)
 			panic("VECTORSPACING too small");
 		}
 
-		memcpy(b, vec_start, handler_len);
+		set_handler(((unsigned long)b - ebase), vec_start,
+#ifdef CONFIG_CPU_MICROMIPS
+				(handler_len - 1));
+#else
+				handler_len);
+#endif
 #ifdef CONFIG_MIPS_MT_SMTC
 		BUG_ON(n > 7);	/* Vector index %d exceeds SMTC maximum. */
 
-		w = (u32 *)(b + mori_offset);
-		*w = (*w & 0xffff0000) | (0x100 << n);
+		h = (u16 *)(b + mori_offset);
+		*h = (0x100 << n);
 #endif /* CONFIG_MIPS_MT_SMTC */
-		w = (u32 *)(b + lui_offset);
-		*w = (*w & 0xffff0000) | (((u32)handler >> 16) & 0xffff);
-		w = (u32 *)(b + ori_offset);
-		*w = (*w & 0xffff0000) | ((u32)handler & 0xffff);
+		h = (u16 *)(b + lui_offset);
+		*h = (handler >> 16) & 0xffff;
+		h = (u16 *)(b + ori_offset);
+		*h = (handler & 0xffff);
 		local_flush_icache_range((unsigned long)b,
 					 (unsigned long)(b+handler_len));
 	}
 	else {
 		/*
-		 * In other cases jump directly to the interrupt handler
-		 *
-		 * It is the handlers responsibility to save registers if required
-		 * (eg hi/lo) and return from the exception using "eret"
+		 * In other cases jump directly to the interrupt handler. It
+		 * is the handler's responsibility to save registers if required
+		 * (eg hi/lo) and return from the exception using "eret".
 		 */
-		w = (u32 *)b;
-		*w++ = 0x08000000 | (((u32)handler >> 2) & 0x03fffff); /* j handler */
-		*w = 0;
+		u32 insn;
+
+		h = (u16 *)b;
+		/* j handler */
+#ifdef CONFIG_CPU_MICROMIPS
+		insn = 0xd4000000 | (((u32)handler & 0x07ffffff) >> 1);
+#else
+		insn = 0x08000000 | (((u32)handler & 0x0fffffff) >> 2);
+#endif
+		h[0] = (insn >> 16) & 0xffff;
+		h[1] = insn & 0xffff;
+		h[2] = 0;
+		h[3] = 0;
 		local_flush_icache_range((unsigned long)b,
 					 (unsigned long)(b+8));
 	}
@@ -1607,7 +1772,11 @@ void __cpuinit per_cpu_trap_init(void)
 	if (cpu_has_mips_r2) {
 		cp0_compare_irq_shift = CAUSEB_TI - CAUSEB_IP;
 		cp0_compare_irq = (read_c0_intctl() >> INTCTLB_IPTI) & 7;
+		if (!cp0_compare_irq)
+			cp0_compare_irq = CP0_LEGACY_COMPARE_IRQ;
 		cp0_perfcount_irq = (read_c0_intctl() >> INTCTLB_IPPCI) & 7;
+		if (!cp0_perfcount_irq)
+			cp0_perfcount_irq = CP0_LEGACY_PERFCNT_IRQ;
 		if (cp0_perfcount_irq == cp0_compare_irq)
 			cp0_perfcount_irq = -1;
 	} else {
@@ -1646,32 +1815,6 @@ void __cpuinit per_cpu_trap_init(void)
 	TLBMISS_HANDLER_SETUP();
 }
 
-/* Install CPU exception handler */
-void __init set_handler(unsigned long offset, void *addr, unsigned long size)
-{
-	memcpy((void *)(ebase + offset), addr, size);
-	local_flush_icache_range(ebase + offset, ebase + offset + size);
-}
-
-static char panic_null_cerr[] __cpuinitdata =
-	"Trying to set NULL cache error exception handler";
-
-/*
- * Install uncached CPU exception handler.
- * This is suitable only for the cache error exception which is the only
- * exception handler that is being run uncached.
- */
-void __cpuinit set_uncached_handler(unsigned long offset, void *addr,
-	unsigned long size)
-{
-	unsigned long uncached_ebase = CKSEG1ADDR(ebase);
-
-	if (!addr)
-		panic(panic_null_cerr);
-
-	memcpy((void *)(uncached_ebase + offset), addr, size);
-}
-
 static int __initdata rdhwr_noopt;
 static int __init set_rdhwr_noopt(char *str)
 {
@@ -1683,8 +1826,11 @@ __setup("rdhwr_noopt", set_rdhwr_noopt);
 
 void __init trap_init(void)
 {
-	extern char except_vec3_generic, except_vec3_r4000;
+	extern char except_vec3_generic;
 	extern char except_vec4;
+#if (cpu_has_vce != 0)
+	extern char except_vec3_r4000;
+#endif
 	unsigned long i;
 	int rollback;
 
@@ -1812,13 +1958,16 @@ void __init trap_init(void)
 
 	set_except_vector(26, handle_dsp);
 
+#if (cpu_has_vce != 0)
 	if (cpu_has_vce)
 		/* Special exception: R4[04]00 uses also the divec space. */
-		memcpy((void *)(ebase + 0x180), &except_vec3_r4000, 0x100);
-	else if (cpu_has_4kex)
-		memcpy((void *)(ebase + 0x180), &except_vec3_generic, 0x80);
+		set_handler(0x180, &except_vec3_r4000, 0x100);
+	else
+#endif
+	if (cpu_has_4kex)
+		set_handler(0x180, &except_vec3_generic, 0x80);
 	else
-		memcpy((void *)(ebase + 0x080), &except_vec3_generic, 0x80);
+		set_handler(0x080, &except_vec3_generic, 0x80);
 
 	local_flush_icache_range(ebase, ebase + 0x400);
 	flush_tlb_handlers();
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 64d631e..4bebe04 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -2021,6 +2021,13 @@ static void __cpuinit build_r4000_tlb_load_handler(void)
 
 	uasm_l_nopage_tlbl(&l, p);
 	build_restore_work_registers(&p);
+#ifdef CONFIG_CPU_MICROMIPS
+	if ((unsigned long)tlb_do_page_fault_0 & 1) {
+		uasm_i_lui(&p, K0, uasm_rel_hi((long)tlb_do_page_fault_0));
+		uasm_i_addiu(&p, K0, K0, uasm_rel_lo((long)tlb_do_page_fault_0));
+		uasm_i_jr(&p, K0);
+	} else
+#endif
 	uasm_i_j(&p, (unsigned long)tlb_do_page_fault_0 & 0x0fffffff);
 	uasm_i_nop(&p);
 
@@ -2068,6 +2075,13 @@ static void __cpuinit build_r4000_tlb_store_handler(void)
 
 	uasm_l_nopage_tlbs(&l, p);
 	build_restore_work_registers(&p);
+#ifdef CONFIG_CPU_MICROMIPS
+	if ((unsigned long)tlb_do_page_fault_1 & 1) {
+		uasm_i_lui(&p, K0, uasm_rel_hi((long)tlb_do_page_fault_1));
+		uasm_i_addiu(&p, K0, K0, uasm_rel_lo((long)tlb_do_page_fault_1));
+		uasm_i_jr(&p, K0);
+	} else
+#endif
 	uasm_i_j(&p, (unsigned long)tlb_do_page_fault_1 & 0x0fffffff);
 	uasm_i_nop(&p);
 
@@ -2116,6 +2130,13 @@ static void __cpuinit build_r4000_tlb_modify_handler(void)
 
 	uasm_l_nopage_tlbm(&l, p);
 	build_restore_work_registers(&p);
+#ifdef CONFIG_CPU_MICROMIPS
+	if ((unsigned long)tlb_do_page_fault_1 & 1) {
+		uasm_i_lui(&p, K0, uasm_rel_hi((long)tlb_do_page_fault_1));
+		uasm_i_addiu(&p, K0, K0, uasm_rel_lo((long)tlb_do_page_fault_1));
+		uasm_i_jr(&p, K0);
+	} else
+#endif
 	uasm_i_j(&p, (unsigned long)tlb_do_page_fault_1 & 0x0fffffff);
 	uasm_i_nop(&p);
 
diff --git a/arch/mips/mti-sead3/sead3-init.c b/arch/mips/mti-sead3/sead3-init.c
index 14e0c49..f4ca42b 100644
--- a/arch/mips/mti-sead3/sead3-init.c
+++ b/arch/mips/mti-sead3/sead3-init.c
@@ -22,9 +22,9 @@
 #include <linux/init.h>
 #include <linux/string.h>
 #include <linux/kernel.h>
+#include <linux/io.h>
 
 #include <asm/bootinfo.h>
-#include <asm/io.h>
 #include <asm/system.h>
 #include <asm/cacheflush.h>
 #include <asm/traps.h>
@@ -97,14 +97,14 @@ int get_ethernet_addr(char *ethernet_addr)
 
 	ethaddr_str = prom_getenv("ethaddr");
 	if (!ethaddr_str) {
-		printk("ethaddr not set in boot prom\n");
+		printk(KERN_WARN "ethaddr not set in boot prom\n");
 		return -1;
 	}
 	str2eaddr(ethernet_addr, ethaddr_str);
 
 	if (init_debug > 1) {
 		int i;
-		printk("get_ethernet_addr: ");
+		printk(KERN_DEBUG "get_ethernet_addr: ");
 		for (i = 0; i < 5; i++)
 			printk("%02x:", (unsigned char)*(ethernet_addr+i));
 		printk("%02x\n", *(ethernet_addr+i));
@@ -147,7 +147,8 @@ static void __init console_config(void)
 			bits = '8';
 		if (flow == '\0')
 			flow = 'r';
-		sprintf(console_string, " console=ttyS0,%d%c%c%c", baud, parity, bits, flow);
+		sprintf(console_string, " console=ttyS0,%d%c%c%c", baud,
+			parity, bits, flow);
 		strcat(prom_getcmdline(), console_string);
 		pr_info("Config serial console:%s\n", console_string);
 	}
@@ -162,7 +163,41 @@ static void __init mips_nmi_setup(void)
 	base = cpu_has_veic ?
 		(void *)(CAC_BASE + 0xa80) :
 		(void *)(CAC_BASE + 0x380);
+#ifdef CONFIG_CPU_MICROMIPS
+	/*
+	 * Decrement the exception vector address by one for microMIPS.
+	 */
+	memcpy(base, (&except_vec_nmi - 1), 0x80);
+
+	/*
+	 * This is a hack. We do not know if the boot loader was built with
+	 * microMIPS instructions or not. If it was not, the NMI exception
+	 * code at 0x80000a80 will be taken in MIPS32 mode. The hand coded
+	 * assembly below forces us into microMIPS mode if we are a pure
+	 * microMIPS kernel. The assembly instructions are:
+	 *
+	 *  3C1A8000   lui       k0,0x8000
+	 *  375A0381   ori       k0,k0,0x381
+	 *  03400008   jr        k0
+	 *  00000000   nop
+	 *
+	 * The mode switch occurs by jumping to the unaligned exception
+	 * vector address at 0x80000381 which would have been 0x80000380
+	 * in MIPS32 mode. The jump to the unaligned address transitions
+	 * us into microMIPS mode.
+	 */
+	if (!cpu_has_veic) {
+		void *base2 = (void *)(CAC_BASE + 0xa80);
+		*((unsigned int *)base2) = 0x3c1a8000;
+		*((unsigned int *)base2 + 1) = 0x375a0381;
+		*((unsigned int *)base2 + 2) = 0x03400008;
+		*((unsigned int *)base2 + 3) = 0x00000000;
+		flush_icache_range((unsigned long)base2,
+			(unsigned long)base2 + 0x10);
+	}
+#else
 	memcpy(base, &except_vec_nmi, 0x80);
+#endif
 	flush_icache_range((unsigned long)base, (unsigned long)base + 0x80);
 }
 
@@ -174,7 +209,21 @@ static void __init mips_ejtag_setup(void)
 	base = cpu_has_veic ?
 		(void *)(CAC_BASE + 0xa00) :
 		(void *)(CAC_BASE + 0x300);
+#ifdef CONFIG_CPU_MICROMIPS
+	/* Deja vu... */
+	memcpy(base, (&except_vec_ejtag_debug - 1), 0x80);
+	if (!cpu_has_veic) {
+		void *base2 = (void *)(CAC_BASE + 0xa00);
+		*((unsigned int *)base2) = 0x3c1a8000;
+		*((unsigned int *)base2 + 1) = 0x375a0301;
+		*((unsigned int *)base2 + 2) = 0x03400008;
+		*((unsigned int *)base2 + 3) = 0x00000000;
+		flush_icache_range((unsigned long)base2,
+			(unsigned long)base2 + 0x10);
+	}
+#else
 	memcpy(base, &except_vec_ejtag_debug, 0x80);
+#endif
 	flush_icache_range((unsigned long)base, (unsigned long)base + 0x80);
 }
 
-- 
1.7.9.6
