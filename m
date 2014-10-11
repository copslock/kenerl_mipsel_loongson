Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 11 Oct 2014 12:09:36 +0200 (CEST)
Received: from mail-lb0-f172.google.com ([209.85.217.172]:48185 "EHLO
        mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011144AbaJKKJeG8-lo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 11 Oct 2014 12:09:34 +0200
Received: by mail-lb0-f172.google.com with SMTP id b6so4352589lbj.17
        for <multiple recipients>; Sat, 11 Oct 2014 03:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=qVhjWgEFULh/ZAeQckSDuxWHJLoqD4AjCOpKv8OS/n4=;
        b=yOFpr/R1BgjUZiO/gpjmWChIfQnl2ksEgypZYzNawB2L/K5+DTdCCDbsFyRan3/d3O
         69AnW/JCQGIj2U6l1MiRnjv1eil77CBULJJ5yixp8zyy4NKGO6AxeWUBFioBkGY/vW19
         4fRJQQ1DKIXLfxPE5ToDDumu+Mc6yGaiyJL8Htlwh4OvA9Z1VXkkhJGFghyiUlCHVMKS
         fWopR+Ly5NZhY1MkfGPdMoTdg6S1xEg6CDyu8ab2GVmq05T9dq0R4P4UJ0kzxaOkn3Mo
         DKGm/DSpD7N13+JvU+HU2MM0j+54WNfwOrY6sRSx60DEHFVxVvLBqCn8GHmuPY/r1UX9
         2ewQ==
X-Received: by 10.152.9.2 with SMTP id v2mr10754336laa.36.1413022168488;
        Sat, 11 Oct 2014 03:09:28 -0700 (PDT)
Received: from localhost.localdomain (p4FD8D0F1.dip0.t-ipconnect.de. [79.216.208.241])
        by mx.google.com with ESMTPSA id ai1sm2549513lbd.12.2014.10.11.03.09.26
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 11 Oct 2014 03:09:27 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@gmail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Manuel Lauss <manuel.lauss@gmail.com>
Subject: [RFC PATCH v3] MIPS: fix build with binutils 2.24.51+
Date:   Sat, 11 Oct 2014 12:09:24 +0200
Message-Id: <1413022164-317664-1-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 2.1.2
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43240
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
I've only tested a mips32r1 build, but at least binutils-2.23 and a
snapshot from today (with the MIPS fp changes) compile a bootable
kernel.

Tests on 64bit and with MSA and other extensions also appreciated!

v3: incorporate Maciej's suggestions:
	- detect if gas can handle -msoft-float and ".set hardfloat"
	- apply .set hardfloat only where really necessary

v2: cover more files

This was introduced in binutils commit  351cdf24d223290b15fa991e5052ec9e9bd1e284
("[MIPS] Implement O32 FPXX, FP64 and FP64A ABI extensions").

 arch/mips/Makefile                  |  9 +++++++++
 arch/mips/include/asm/asmmacro-32.h |  5 +++++
 arch/mips/include/asm/asmmacro.h    | 18 ++++++++++++++++++
 arch/mips/include/asm/fpregdef.h    | 14 ++++++++++++++
 arch/mips/include/asm/mipsregs.h    | 19 +++++++++++++++++++
 arch/mips/kernel/genex.S            |  1 +
 arch/mips/kernel/r2300_switch.S     |  5 +++++
 arch/mips/kernel/r4k_fpu.S          |  7 +++++++
 arch/mips/kernel/r4k_switch.S       |  9 +++++++++
 arch/mips/kernel/r6000_fpu.S        |  5 +++++
 10 files changed, 92 insertions(+)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index bbac51e1..35005e1 100644
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
index e38c281..a97ce53 100644
--- a/arch/mips/include/asm/asmmacro-32.h
+++ b/arch/mips/include/asm/asmmacro-32.h
@@ -12,6 +12,9 @@
 #include <asm/fpregdef.h>
 #include <asm/mipsregs.h>

+	.set push
+	SET_HARDFLOAT
+
 	.macro	fpu_save_single thread tmp=t0
 	cfc1	\tmp,  fcr31
 	swc1	$f0,  THREAD_FPR0_LS64(\thread)
@@ -86,6 +89,8 @@
 	ctc1	\tmp, fcr31
 	.endm

+	.set pop
+
 	.macro	cpu_save_nonscratch thread
 	LONG_S	s0, THREAD_REG16(\thread)
 	LONG_S	s1, THREAD_REG17(\thread)
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
diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index cf3b580..889c012 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -1324,6 +1324,7 @@ do {									\
 /*
  * Macros to access the floating point coprocessor control registers
  */
+#ifdef GAS_HAS_SET_HARDFLOAT
 #define read_32bit_cp1_register(source)					\
 ({									\
 	int __res;							\
@@ -1334,11 +1335,29 @@ do {									\
 	"	# gas fails to assemble cfc1 for some archs,	\n"	\
 	"	# like Octeon.					\n"	\
 	"	.set	mips1					\n"	\
+	"	.set	hardfloat				\n"	\
 	"	cfc1	%0,"STR(source)"			\n"	\
 	"	.set	pop					\n"	\
 	: "=r" (__res));						\
 	__res;								\
 })
+#else
+#define read_32bit_cp1_register(source)					\
+({									\
+	int __res;							\
+									\
+	__asm__ __volatile__(						\
+	"	.set	push					\n"	\
+	"	.set	reorder					\n"	\
+	"	# gas fails to assemble cfc1 for some archs,	\n"	\
+	"	# like Octeon.					\n"	\
+	"	.set	mips1					\n"	\
+	"	cfc1	%0,"STR(source)"			\n"	\
+	"	.set	pop					\n"	\
+	: "=r" (__res));						\
+	__res;								\
+})
+#endif

 #ifdef HAVE_AS_DSP
 #define rddsp(mask)							\
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
index 8352523..4a827a3 100644
--- a/arch/mips/kernel/r4k_fpu.S
+++ b/arch/mips/kernel/r4k_fpu.S
@@ -21,6 +21,7 @@

 	.macro	EX insn, reg, src
 	.set	push
+	SET_HARDFLOAT
 	.set	nomacro
 .ex\@:	\insn	\reg, \src
 	.set	pop
@@ -33,7 +34,10 @@
 	.set	arch=r4000

 LEAF(_save_fp_context)
+	.set	push
+	SET_HARDFLOAT
 	cfc1	t1, fcr31
+	.set	pop

 #if defined(CONFIG_64BIT) || defined(CONFIG_CPU_MIPS32_R2)
 	.set	push
@@ -191,7 +195,10 @@ LEAF(_restore_fp_context)
 	EX	ldc1 $f26, SC_FPREGS+208(a0)
 	EX	ldc1 $f28, SC_FPREGS+224(a0)
 	EX	ldc1 $f30, SC_FPREGS+240(a0)
+	.set push
+	SET_HARDFLOAT
 	ctc1	t1, fcr31
+	.set pop
 	jr	ra
 	 li	v0, 0					# success
 	END(_restore_fp_context)
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
