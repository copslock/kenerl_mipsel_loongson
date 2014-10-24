Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Oct 2014 08:28:14 +0200 (CEST)
Received: from mail-wi0-f178.google.com ([209.85.212.178]:51938 "EHLO
        mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010111AbaJXG2M2s1L8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 24 Oct 2014 08:28:12 +0200
Received: by mail-wi0-f178.google.com with SMTP id q5so401186wiv.17
        for <multiple recipients>; Thu, 23 Oct 2014 23:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=fG67m8QjdoFK16zAx+wcWRyJ3Bv0BCJ/aZEZOdZ6044=;
        b=obkO6yDHydA95+npOWtLWlPCVsQwxKZPMDFkv4HY18tmDdeYun3+M0oZ/1qavwoals
         htYhJ0DXqcGU3Zod00tTAvLg5bx2seBWt990G6U/EYWuU7ufN3IM3rit5B4IQ4jOReiq
         AehVK/U/C+VVkGF1v32i9MgJWED0GE2UhFAjOQqcr1V/369qVll3cP30No4mrDxRa1Y8
         WIYiPfBNLKBKIeH37JEE4Ek+S64bHWxzUgxXmkZs2s2wnOJtEK32237yZL501ELtH+8z
         j+liY7QlAPejKntTwPG/mM46ptiitYIX7GgH/8QVly6uiJLjgQK0sDS7q4e7MmtMkLsT
         dtdw==
X-Received: by 10.180.104.8 with SMTP id ga8mr1845801wib.78.1414132087138;
        Thu, 23 Oct 2014 23:28:07 -0700 (PDT)
Received: from localhost.localdomain ([46.114.4.255])
        by mx.google.com with ESMTPSA id ee3sm880578wic.4.2014.10.23.23.28.04
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 Oct 2014 23:28:06 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@gmail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Markos Chandras <Markos.Chandras@imgtec.com>,
        Matthew Fortune <Matthew.Fortune@imgtec.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Manuel Lauss <manuel.lauss@gmail.com>
Subject: [RFC PATCH v4] MIPS: fix build with binutils 2.24.51+
Date:   Fri, 24 Oct 2014 08:27:59 +0200
Message-Id: <1414132079-155342-1-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 2.1.2
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43549
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
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

Starting with version 2.24.51.20140728 MIPS binutils complain loudly
about mixing soft-float and hard-float object files, leading to this
build failure since GCC is invoked with "-msoft-float" on MIPS:

{standard input}: Warning: .gnu_attribute 4,3 requires `softfloat'
  LD      arch/mips/alchemy/common/built-in.o
mipsel-softfloat-linux-gnu-ld: Warning: arch/mips/alchemy/common/built-in.o
 uses -msoft-float (set by arch/mips/alchemy/common/prom.o),
 arch/mips/alchemy/common/sleeper.o uses -mhard-float

To fix this, we detect if GAS is new enough to support "-msoft-float" command
option, and if it does, we can let GCC pass it to GAS;  but then we also need
to sprinkle the files which make use of floating point registers with the
necessary ".set hardfloat" directives.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
Compiles with binutils 2.23 and current git head, 32bit mips32r1 tested only.

Tests on 64bit and with MSA and other extensions also appreciated!
Markos: I can't reproduce the malta defconfig error you're seeing, at least
not with sourceware sources.

v4: fixed issues outlined by Markos and Matthew.

v3: incorporate Maciej's suggestions:
	- detect if gas can handle -msoft-float and ".set hardfloat"
	- apply .set hardfloat only where really necessary

v2: cover more files

This was introduced in binutils commit  351cdf24d223290b15fa991e5052ec9e9bd1e284
("[MIPS] Implement O32 FPXX, FP64 and FP64A ABI extensions").

 arch/mips/Makefile                  |  9 +++++++++
 arch/mips/include/asm/asmmacro-32.h |  6 ++++++
 arch/mips/include/asm/asmmacro.h    | 18 ++++++++++++++++++
 arch/mips/include/asm/fpregdef.h    | 14 ++++++++++++++
 arch/mips/include/asm/fpu.h         |  4 ++--
 arch/mips/include/asm/mipsregs.h    | 11 ++++++++++-
 arch/mips/kernel/branch.c           |  8 ++------
 arch/mips/kernel/genex.S            |  1 +
 arch/mips/kernel/r2300_fpu.S        |  6 ++++++
 arch/mips/kernel/r2300_switch.S     |  5 +++++
 arch/mips/kernel/r4k_fpu.S          | 18 ++++++++++++++++++
 arch/mips/kernel/r4k_switch.S       |  9 +++++++++
 arch/mips/kernel/r6000_fpu.S        |  5 +++++
 13 files changed, 105 insertions(+), 9 deletions(-)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 23cb948..5807647 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -93,6 +93,15 @@ LDFLAGS_vmlinux			+= -G 0 -static -n -nostdlib
 KBUILD_AFLAGS_MODULE		+= -mlong-calls
 KBUILD_CFLAGS_MODULE		+= -mlong-calls
 
+#
+# pass -msoft-float to GAS if it supports it.  However on newer binutils
+# (specifically newer than 2.24.51.20140728) we then also need to explicitly
+# set ".set hardfloat" in all files which manipulate floating point registers.
+#
+ifneq ($(call as-option,-Wa$(comma)-msoft-float,),)
+	cflags-y		+= -DGAS_HAS_SET_HARDFLOAT -Wa,-msoft-float
+endif
+
 cflags-y += -ffreestanding
 
 #
diff --git a/arch/mips/include/asm/asmmacro-32.h b/arch/mips/include/asm/asmmacro-32.h
index e38c281..cdac7b3 100644
--- a/arch/mips/include/asm/asmmacro-32.h
+++ b/arch/mips/include/asm/asmmacro-32.h
@@ -13,6 +13,8 @@
 #include <asm/mipsregs.h>
 
 	.macro	fpu_save_single thread tmp=t0
+	.set push
+	SET_HARDFLOAT
 	cfc1	\tmp,  fcr31
 	swc1	$f0,  THREAD_FPR0_LS64(\thread)
 	swc1	$f1,  THREAD_FPR1_LS64(\thread)
@@ -47,9 +49,12 @@
 	swc1	$f30, THREAD_FPR30_LS64(\thread)
 	swc1	$f31, THREAD_FPR31_LS64(\thread)
 	sw	\tmp, THREAD_FCR31(\thread)
+	.set pop
 	.endm
 
 	.macro	fpu_restore_single thread tmp=t0
+	.set push
+	SET_HARDFLOAT
 	lw	\tmp, THREAD_FCR31(\thread)
 	lwc1	$f0,  THREAD_FPR0_LS64(\thread)
 	lwc1	$f1,  THREAD_FPR1_LS64(\thread)
@@ -84,6 +89,7 @@
 	lwc1	$f30, THREAD_FPR30_LS64(\thread)
 	lwc1	$f31, THREAD_FPR31_LS64(\thread)
 	ctc1	\tmp, fcr31
+	.set pop
 	.endm
 
 	.macro	cpu_save_nonscratch thread
diff --git a/arch/mips/include/asm/asmmacro.h b/arch/mips/include/asm/asmmacro.h
index cd9a98b..6caf876 100644
--- a/arch/mips/include/asm/asmmacro.h
+++ b/arch/mips/include/asm/asmmacro.h
@@ -57,6 +57,8 @@
 #endif /* CONFIG_CPU_MIPSR2 */
 
 	.macro	fpu_save_16even thread tmp=t0
+	.set	push
+	SET_HARDFLOAT
 	cfc1	\tmp, fcr31
 	sdc1	$f0,  THREAD_FPR0_LS64(\thread)
 	sdc1	$f2,  THREAD_FPR2_LS64(\thread)
@@ -75,11 +77,13 @@
 	sdc1	$f28, THREAD_FPR28_LS64(\thread)
 	sdc1	$f30, THREAD_FPR30_LS64(\thread)
 	sw	\tmp, THREAD_FCR31(\thread)
+	.set	pop
 	.endm
 
 	.macro	fpu_save_16odd thread
 	.set	push
 	.set	mips64r2
+	SET_HARDFLOAT
 	sdc1	$f1,  THREAD_FPR1_LS64(\thread)
 	sdc1	$f3,  THREAD_FPR3_LS64(\thread)
 	sdc1	$f5,  THREAD_FPR5_LS64(\thread)
@@ -110,6 +114,8 @@
 	.endm
 
 	.macro	fpu_restore_16even thread tmp=t0
+	.set	push
+	SET_HARDFLOAT
 	lw	\tmp, THREAD_FCR31(\thread)
 	ldc1	$f0,  THREAD_FPR0_LS64(\thread)
 	ldc1	$f2,  THREAD_FPR2_LS64(\thread)
@@ -133,6 +139,7 @@
 	.macro	fpu_restore_16odd thread
 	.set	push
 	.set	mips64r2
+	SET_HARDFLOAT
 	ldc1	$f1,  THREAD_FPR1_LS64(\thread)
 	ldc1	$f3,  THREAD_FPR3_LS64(\thread)
 	ldc1	$f5,  THREAD_FPR5_LS64(\thread)
@@ -277,6 +284,7 @@
 	.macro	cfcmsa	rd, cs
 	.set	push
 	.set	noat
+	SET_HARDFLOAT
 	.insn
 	.word	CFC_MSA_INSN | (\cs << 11)
 	move	\rd, $1
@@ -286,6 +294,7 @@
 	.macro	ctcmsa	cd, rs
 	.set	push
 	.set	noat
+	SET_HARDFLOAT
 	move	$1, \rs
 	.word	CTC_MSA_INSN | (\cd << 6)
 	.set	pop
@@ -294,6 +303,7 @@
 	.macro	ld_d	wd, off, base
 	.set	push
 	.set	noat
+	SET_HARDFLOAT
 	add	$1, \base, \off
 	.word	LDD_MSA_INSN | (\wd << 6)
 	.set	pop
@@ -302,6 +312,7 @@
 	.macro	st_d	wd, off, base
 	.set	push
 	.set	noat
+	SET_HARDFLOAT
 	add	$1, \base, \off
 	.word	STD_MSA_INSN | (\wd << 6)
 	.set	pop
@@ -310,6 +321,7 @@
 	.macro	copy_u_w	rd, ws, n
 	.set	push
 	.set	noat
+	SET_HARDFLOAT
 	.insn
 	.word	COPY_UW_MSA_INSN | (\n << 16) | (\ws << 11)
 	/* move triggers an assembler bug... */
@@ -320,6 +332,7 @@
 	.macro	copy_u_d	rd, ws, n
 	.set	push
 	.set	noat
+	SET_HARDFLOAT
 	.insn
 	.word	COPY_UD_MSA_INSN | (\n << 16) | (\ws << 11)
 	/* move triggers an assembler bug... */
@@ -330,6 +343,7 @@
 	.macro	insert_w	wd, n, rs
 	.set	push
 	.set	noat
+	SET_HARDFLOAT
 	/* move triggers an assembler bug... */
 	or	$1, \rs, zero
 	.word	INSERT_W_MSA_INSN | (\n << 16) | (\wd << 6)
@@ -339,6 +353,7 @@
 	.macro	insert_d	wd, n, rs
 	.set	push
 	.set	noat
+	SET_HARDFLOAT
 	/* move triggers an assembler bug... */
 	or	$1, \rs, zero
 	.word	INSERT_D_MSA_INSN | (\n << 16) | (\wd << 6)
@@ -381,6 +396,7 @@
 	st_d	31, THREAD_FPR31, \thread
 	.set	push
 	.set	noat
+	SET_HARDFLOAT
 	cfcmsa	$1, MSA_CSR
 	sw	$1, THREAD_MSA_CSR(\thread)
 	.set	pop
@@ -389,6 +405,7 @@
 	.macro	msa_restore_all	thread
 	.set	push
 	.set	noat
+	SET_HARDFLOAT
 	lw	$1, THREAD_MSA_CSR(\thread)
 	ctcmsa	MSA_CSR, $1
 	.set	pop
@@ -441,6 +458,7 @@
 	.macro	msa_init_all_upper
 	.set	push
 	.set	noat
+	SET_HARDFLOAT
 	not	$1, zero
 	msa_init_upper	0
 	.set	pop
diff --git a/arch/mips/include/asm/fpregdef.h b/arch/mips/include/asm/fpregdef.h
index 429481f..f184ba0 100644
--- a/arch/mips/include/asm/fpregdef.h
+++ b/arch/mips/include/asm/fpregdef.h
@@ -14,6 +14,20 @@
 
 #include <asm/sgidefs.h>
 
+/*
+ * starting with binutils 2.24.51.20140729, MIPS binutils warn about mixing
+ * hardfloat and softfloat object files.  The kernel build uses soft-float by
+ * default, so we also need to pass -msoft-float along to GAS if it supports it.
+ * But this in turn causes assembler errors in files which access hardfloat
+ * registers.  We detect if GAS supports "-msoft-float" in the Makefile and
+ * explicitly put ".set hardfloat" where floating point registers are touched.
+ */
+#ifdef GAS_HAS_SET_HARDFLOAT
+#define SET_HARDFLOAT .set hardfloat
+#else
+#define SET_HARDFLOAT
+#endif
+
 #if _MIPS_SIM == _MIPS_SIM_ABI32
 
 /*
diff --git a/arch/mips/include/asm/fpu.h b/arch/mips/include/asm/fpu.h
index 4d0aeda..dd56241 100644
--- a/arch/mips/include/asm/fpu.h
+++ b/arch/mips/include/asm/fpu.h
@@ -145,8 +145,8 @@ static inline void lose_fpu(int save)
 	if (is_msa_enabled()) {
 		if (save) {
 			save_msa(current);
-			asm volatile("cfc1 %0, $31"
-				: "=r"(current->thread.fpu.fcr31));
+			current->thread.fpu.fcr31 =
+					read_32bit_cp1_register(CP1_STATUS);
 		}
 		disable_msa();
 		clear_thread_flag(TIF_USEDMSA);
diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index cf3b580..b46cd22 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -1324,7 +1324,7 @@ do {									\
 /*
  * Macros to access the floating point coprocessor control registers
  */
-#define read_32bit_cp1_register(source)					\
+#define _read_32bit_cp1_register(source, gas_hardfloat)			\
 ({									\
 	int __res;							\
 									\
@@ -1334,12 +1334,21 @@ do {									\
 	"	# gas fails to assemble cfc1 for some archs,	\n"	\
 	"	# like Octeon.					\n"	\
 	"	.set	mips1					\n"	\
+	"	"STR(gas_hardfloat)"				\n"	\
 	"	cfc1	%0,"STR(source)"			\n"	\
 	"	.set	pop					\n"	\
 	: "=r" (__res));						\
 	__res;								\
 })
 
+#ifdef GAS_HAS_SET_HARDFLOAT
+#define read_32bit_cp1_register(source)					\
+	_read_32bit_cp1_register(source, .set hardfloat)
+#else
+#define read_32bit_cp1_register(source)					\
+	_read_32bit_cp1_register(source, )
+#endif
+
 #ifdef HAVE_AS_DSP
 #define rddsp(mask)							\
 ({									\
diff --git a/arch/mips/kernel/branch.c b/arch/mips/kernel/branch.c
index 7b2df22..4d7d99d 100644
--- a/arch/mips/kernel/branch.c
+++ b/arch/mips/kernel/branch.c
@@ -144,7 +144,7 @@ int __mm_isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
 		case mm_bc1t_op:
 			preempt_disable();
 			if (is_fpu_owner())
-				asm volatile("cfc1\t%0,$31" : "=r" (fcr31));
+			        fcr31 = read_32bit_cp1_register(CP1_STATUS);
 			else
 				fcr31 = current->thread.fpu.fcr31;
 			preempt_enable();
@@ -562,11 +562,7 @@ int __compute_return_epc_for_insn(struct pt_regs *regs,
 	case cop1_op:
 		preempt_disable();
 		if (is_fpu_owner())
-			asm volatile(
-				".set push\n"
-				"\t.set mips1\n"
-				"\tcfc1\t%0,$31\n"
-				"\t.set pop" : "=r" (fcr31));
+		        fcr31 = read_32bit_cp1_register(CP1_STATUS);
 		else
 			fcr31 = current->thread.fpu.fcr31;
 		preempt_enable();
diff --git a/arch/mips/kernel/genex.S b/arch/mips/kernel/genex.S
index ac35e12..a5e26dd 100644
--- a/arch/mips/kernel/genex.S
+++ b/arch/mips/kernel/genex.S
@@ -358,6 +358,7 @@ NESTED(nmi_handler, PT_SIZE, sp)
 	.set	push
 	/* gas fails to assemble cfc1 for some archs (octeon).*/ \
 	.set	mips1
+	SET_HARDFLOAT
 	cfc1	a1, fcr31
 	li	a2, ~(0x3f << 12)
 	and	a2, a1
diff --git a/arch/mips/kernel/r2300_fpu.S b/arch/mips/kernel/r2300_fpu.S
index f31063d..5ce3b74 100644
--- a/arch/mips/kernel/r2300_fpu.S
+++ b/arch/mips/kernel/r2300_fpu.S
@@ -28,6 +28,8 @@
 	.set	mips1
 	/* Save floating point context */
 LEAF(_save_fp_context)
+	.set	push
+	SET_HARDFLOAT
 	li	v0, 0					# assume success
 	cfc1	t1,fcr31
 	EX(swc1 $f0,(SC_FPREGS+0)(a0))
@@ -65,6 +67,7 @@ LEAF(_save_fp_context)
 	EX(sw	t1,(SC_FPC_CSR)(a0))
 	cfc1	t0,$0				# implementation/version
 	jr	ra
+	.set	pop
 	.set	nomacro
 	 EX(sw	t0,(SC_FPC_EIR)(a0))
 	.set	macro
@@ -80,6 +83,8 @@ LEAF(_save_fp_context)
  * stack frame which might have been changed by the user.
  */
 LEAF(_restore_fp_context)
+	.set	push
+	SET_HARDFLOAT
 	li	v0, 0					# assume success
 	EX(lw t0,(SC_FPC_CSR)(a0))
 	EX(lwc1 $f0,(SC_FPREGS+0)(a0))
@@ -116,6 +121,7 @@ LEAF(_restore_fp_context)
 	EX(lwc1 $f31,(SC_FPREGS+248)(a0))
 	jr	ra
 	 ctc1	t0,fcr31
+	.set	pop
 	END(_restore_fp_context)
 	.set	reorder
 
diff --git a/arch/mips/kernel/r2300_switch.S b/arch/mips/kernel/r2300_switch.S
index 20b7b04..435ea65 100644
--- a/arch/mips/kernel/r2300_switch.S
+++ b/arch/mips/kernel/r2300_switch.S
@@ -120,6 +120,9 @@ LEAF(_restore_fp)
 
 #define FPU_DEFAULT  0x00000000
 
+	.set push
+	SET_HARDFLOAT
+
 LEAF(_init_fpu)
 	mfc0	t0, CP0_STATUS
 	li	t1, ST0_CU1
@@ -165,3 +168,5 @@ LEAF(_init_fpu)
 	mtc1	t0, $f31
 	jr	ra
 	END(_init_fpu)
+
+	.set pop
diff --git a/arch/mips/kernel/r4k_fpu.S b/arch/mips/kernel/r4k_fpu.S
index 8352523..f21c046 100644
--- a/arch/mips/kernel/r4k_fpu.S
+++ b/arch/mips/kernel/r4k_fpu.S
@@ -21,6 +21,7 @@
 
 	.macro	EX insn, reg, src
 	.set	push
+	SET_HARDFLOAT
 	.set	nomacro
 .ex\@:	\insn	\reg, \src
 	.set	pop
@@ -33,10 +34,14 @@
 	.set	arch=r4000
 
 LEAF(_save_fp_context)
+	.set	push
+	SET_HARDFLOAT
 	cfc1	t1, fcr31
+	.set	pop
 
 #if defined(CONFIG_64BIT) || defined(CONFIG_CPU_MIPS32_R2)
 	.set	push
+	SET_HARDFLOAT
 #ifdef CONFIG_CPU_MIPS32_R2
 	.set	mips64r2
 	mfc0	t0, CP0_STATUS
@@ -64,6 +69,8 @@ LEAF(_save_fp_context)
 1:	.set	pop
 #endif
 
+	.set push
+	SET_HARDFLOAT
 	/* Store the 16 even double precision registers */
 	EX	sdc1 $f0, SC_FPREGS+0(a0)
 	EX	sdc1 $f2, SC_FPREGS+16(a0)
@@ -84,11 +91,14 @@ LEAF(_save_fp_context)
 	EX	sw t1, SC_FPC_CSR(a0)
 	jr	ra
 	 li	v0, 0					# success
+	.set pop
 	END(_save_fp_context)
 
 #ifdef CONFIG_MIPS32_COMPAT
 	/* Save 32-bit process floating point context */
 LEAF(_save_fp_context32)
+	.set push
+	SET_HARDFLOAT
 	cfc1	t1, fcr31
 
 	mfc0	t0, CP0_STATUS
@@ -134,6 +144,7 @@ LEAF(_save_fp_context32)
 	EX	sw t1, SC32_FPC_CSR(a0)
 	cfc1	t0, $0				# implementation/version
 	EX	sw t0, SC32_FPC_EIR(a0)
+	.set pop
 
 	jr	ra
 	 li	v0, 0					# success
@@ -150,6 +161,7 @@ LEAF(_restore_fp_context)
 
 #if defined(CONFIG_64BIT) || defined(CONFIG_CPU_MIPS32_R2)
 	.set	push
+	SET_HARDFLOAT
 #ifdef CONFIG_CPU_MIPS32_R2
 	.set	mips64r2
 	mfc0	t0, CP0_STATUS
@@ -175,6 +187,8 @@ LEAF(_restore_fp_context)
 	EX	ldc1 $f31, SC_FPREGS+248(a0)
 1:	.set pop
 #endif
+	.set push
+	SET_HARDFLOAT
 	EX	ldc1 $f0, SC_FPREGS+0(a0)
 	EX	ldc1 $f2, SC_FPREGS+16(a0)
 	EX	ldc1 $f4, SC_FPREGS+32(a0)
@@ -192,6 +206,7 @@ LEAF(_restore_fp_context)
 	EX	ldc1 $f28, SC_FPREGS+224(a0)
 	EX	ldc1 $f30, SC_FPREGS+240(a0)
 	ctc1	t1, fcr31
+	.set pop
 	jr	ra
 	 li	v0, 0					# success
 	END(_restore_fp_context)
@@ -199,6 +214,8 @@ LEAF(_restore_fp_context)
 #ifdef CONFIG_MIPS32_COMPAT
 LEAF(_restore_fp_context32)
 	/* Restore an o32 sigcontext.  */
+	.set push
+	SET_HARDFLOAT
 	EX	lw t1, SC32_FPC_CSR(a0)
 
 	mfc0	t0, CP0_STATUS
@@ -242,6 +259,7 @@ LEAF(_restore_fp_context32)
 	ctc1	t1, fcr31
 	jr	ra
 	 li	v0, 0					# success
+	.set pop
 	END(_restore_fp_context32)
 #endif
 
diff --git a/arch/mips/kernel/r4k_switch.S b/arch/mips/kernel/r4k_switch.S
index 4c4ec18..6467a8b 100644
--- a/arch/mips/kernel/r4k_switch.S
+++ b/arch/mips/kernel/r4k_switch.S
@@ -65,8 +65,12 @@
 	bgtz	a3, 1f
 
 	/* Save 128b MSA vector context + scalar FP control & status. */
+	.set push
+	SET_HARDFLOAT
 	cfc1	t1, fcr31
 	msa_save_all	a0
+	.set pop	/* SET_HARDFLOAT */
+
 	sw	t1, THREAD_FCR31(a0)
 	b	2f
 
@@ -161,6 +165,9 @@ LEAF(_init_msa_upper)
 
 #define FPU_DEFAULT  0x00000000
 
+	.set push
+	SET_HARDFLOAT
+
 LEAF(_init_fpu)
 	mfc0	t0, CP0_STATUS
 	li	t1, ST0_CU1
@@ -291,3 +298,5 @@ LEAF(_init_fpu)
 #endif
 	jr	ra
 	END(_init_fpu)
+
+	.set pop	/* SET_HARDFLOAT */
diff --git a/arch/mips/kernel/r6000_fpu.S b/arch/mips/kernel/r6000_fpu.S
index da0fbe4..4707738 100644
--- a/arch/mips/kernel/r6000_fpu.S
+++ b/arch/mips/kernel/r6000_fpu.S
@@ -18,6 +18,9 @@
 
 	.set	noreorder
 	.set	mips2
+	.set	push
+	SET_HARDFLOAT
+
 	/* Save floating point context */
 	LEAF(_save_fp_context)
 	mfc0	t0,CP0_STATUS
@@ -85,3 +88,5 @@
 1:	jr	ra
 	 nop
 	END(_restore_fp_context)
+
+	.set pop	/* SET_HARDFLOAT */
-- 
2.1.2
