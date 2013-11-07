Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Nov 2013 13:50:24 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:52390 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823043Ab3KGMsz2OOwc (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 7 Nov 2013 13:48:55 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 4/6] mips: support for 64-bit FP with O32 binaries
Date:   Thu, 7 Nov 2013 12:48:31 +0000
Message-ID: <1383828513-28462-5-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1383828513-28462-1-git-send-email-paul.burton@imgtec.com>
References: <1383828513-28462-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.152.22]
X-SEF-Processed: 7_3_0_01192__2013_11_07_12_48_54
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38474
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

CPUs implementing mips32r2 may include a 64-bit FPU, just as mips64 CPUs
do. In order to preserve backwards compatibility a 64-bit FPU will act
like a 32-bit FPU (by accessing doubles from the least significant 32
bits of an even-odd pair of FP registers) when the Status.FR bit is
zero, again just like a mips64 CPU. The standard O32 ABI is defined
expecting a 32-bit FPU, however recent toolchains support use of a
64-bit FPU from an O32 mips32 executable. When an ELF executable is
built to use a 64-bit FPU a new flag (EF_MIPS_FP64) is set in the ELF
header.

With this patch the kernel will check the EF_MIPS_FP64 flag when
executing an O32 binary, and set Status.FR accordingly. The addition
of O32 64-bit FP support lessens the opportunity for optimisation in
the FPU emulator, so a CONFIG_MIPS_O32_FP64_SUPPORT Kconfig option is
introduced to allow this support to be disabled for those that don't
require it.

Inspired by an earlier patch by Leonid Yegoshin, but implemented more
cleanly & correctly.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
 arch/mips/Kconfig                   |  17 ++++++
 arch/mips/include/asm/asmmacro-32.h |  42 --------------
 arch/mips/include/asm/asmmacro-64.h |  96 --------------------------------
 arch/mips/include/asm/asmmacro.h    | 107 ++++++++++++++++++++++++++++++++++++
 arch/mips/include/asm/elf.h         |  17 +++++-
 arch/mips/include/asm/fpu.h         |  91 +++++++++++++++++++++++++-----
 arch/mips/include/asm/thread_info.h |   4 +-
 arch/mips/kernel/cpu-probe.c        |   2 +-
 arch/mips/kernel/process.c          |   3 -
 arch/mips/kernel/ptrace.c           |   8 +--
 arch/mips/kernel/ptrace32.c         |   4 +-
 arch/mips/kernel/r4k_fpu.S          |  74 +++++++++++++++++++++++--
 arch/mips/kernel/r4k_switch.S       |  45 ++++++++++++++-
 arch/mips/kernel/signal.c           |  10 ++--
 arch/mips/kernel/signal32.c         |  10 ++--
 arch/mips/kernel/traps.c            |  20 +++++--
 arch/mips/math-emu/cp1emu.c         |  10 ++--
 arch/mips/math-emu/kernel_linkage.c |   6 +-
 18 files changed, 373 insertions(+), 193 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 17cc7ff..aa2e03a 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2335,6 +2335,23 @@ config CC_STACKPROTECTOR
 
 	  This feature requires gcc version 4.2 or above.
 
+config MIPS_O32_FP64_SUPPORT
+	bool "Support for O32 binaries using 64-bit FP"
+	depends on (32BIT && CPU_MIPSR2) || MIPS32_O32
+	default y
+	help
+	  When this is enabled, the kernel will support use of 64-bit floating
+	  point registers with binaries using the O32 ABI along with the
+	  EF_MIPS_FP64 ELF header flag (typically built with -mfp64). On
+	  mips32 systems this support is at the cost of increasing the size
+	  and complexity of the compiled FPU emulator. Thus if you are running
+	  a mips32 system and know that none of your userland binaries will
+	  require 64-bit floating point, you may wish to reduce the size of
+	  your kernel & potentially improve FP emulation performance by saying
+	  N here.
+
+	  If unsure, say Y.
+
 config USE_OF
 	bool
 	select OF
diff --git a/arch/mips/include/asm/asmmacro-32.h b/arch/mips/include/asm/asmmacro-32.h
index 2413afe..70e1f17 100644
--- a/arch/mips/include/asm/asmmacro-32.h
+++ b/arch/mips/include/asm/asmmacro-32.h
@@ -12,27 +12,6 @@
 #include <asm/fpregdef.h>
 #include <asm/mipsregs.h>
 
-	.macro	fpu_save_double thread status tmp1=t0
-	cfc1	\tmp1,  fcr31
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
-	sw	\tmp1, THREAD_FCR31(\thread)
-	.endm
-
 	.macro	fpu_save_single thread tmp=t0
 	cfc1	\tmp,  fcr31
 	swc1	$f0,  THREAD_FPR0(\thread)
@@ -70,27 +49,6 @@
 	sw	\tmp, THREAD_FCR31(\thread)
 	.endm
 
-	.macro	fpu_restore_double thread status tmp=t0
-	lw	\tmp, THREAD_FCR31(\thread)
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
-	ctc1	\tmp, fcr31
-	.endm
-
 	.macro	fpu_restore_single thread tmp=t0
 	lw	\tmp, THREAD_FCR31(\thread)
 	lwc1	$f0,  THREAD_FPR0(\thread)
diff --git a/arch/mips/include/asm/asmmacro-64.h b/arch/mips/include/asm/asmmacro-64.h
index 08a527d..38ea609 100644
--- a/arch/mips/include/asm/asmmacro-64.h
+++ b/arch/mips/include/asm/asmmacro-64.h
@@ -13,102 +13,6 @@
 #include <asm/fpregdef.h>
 #include <asm/mipsregs.h>
 
-	.macro	fpu_save_16even thread tmp=t0
-	cfc1	\tmp, fcr31
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
-	sw	\tmp, THREAD_FCR31(\thread)
-	.endm
-
-	.macro	fpu_save_16odd thread
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
-	.endm
-
-	.macro	fpu_save_double thread status tmp
-	sll	\tmp, \status, 5
-	bgez	\tmp, 2f
-	fpu_save_16odd \thread
-2:
-	fpu_save_16even \thread \tmp
-	.endm
-
-	.macro	fpu_restore_16even thread tmp=t0
-	lw	\tmp, THREAD_FCR31(\thread)
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
-	ctc1	\tmp, fcr31
-	.endm
-
-	.macro	fpu_restore_16odd thread
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
-	.endm
-
-	.macro	fpu_restore_double thread status tmp
-	sll	\tmp, \status, 5
-	bgez	\tmp, 1f				# 16 register mode?
-
-	fpu_restore_16odd \thread
-1:	fpu_restore_16even \thread \tmp
-	.endm
-
 	.macro	cpu_save_nonscratch thread
 	LONG_S	s0, THREAD_REG16(\thread)
 	LONG_S	s1, THREAD_REG17(\thread)
diff --git a/arch/mips/include/asm/asmmacro.h b/arch/mips/include/asm/asmmacro.h
index 6c8342a..3220c93 100644
--- a/arch/mips/include/asm/asmmacro.h
+++ b/arch/mips/include/asm/asmmacro.h
@@ -62,6 +62,113 @@
 	.endm
 #endif /* CONFIG_MIPS_MT_SMTC */
 
+	.macro	fpu_save_16even thread tmp=t0
+	cfc1	\tmp, fcr31
+	sdc1	$f0,  THREAD_FPR0(\thread)
+	sdc1	$f2,  THREAD_FPR2(\thread)
+	sdc1	$f4,  THREAD_FPR4(\thread)
+	sdc1	$f6,  THREAD_FPR6(\thread)
+	sdc1	$f8,  THREAD_FPR8(\thread)
+	sdc1	$f10, THREAD_FPR10(\thread)
+	sdc1	$f12, THREAD_FPR12(\thread)
+	sdc1	$f14, THREAD_FPR14(\thread)
+	sdc1	$f16, THREAD_FPR16(\thread)
+	sdc1	$f18, THREAD_FPR18(\thread)
+	sdc1	$f20, THREAD_FPR20(\thread)
+	sdc1	$f22, THREAD_FPR22(\thread)
+	sdc1	$f24, THREAD_FPR24(\thread)
+	sdc1	$f26, THREAD_FPR26(\thread)
+	sdc1	$f28, THREAD_FPR28(\thread)
+	sdc1	$f30, THREAD_FPR30(\thread)
+	sw	\tmp, THREAD_FCR31(\thread)
+	.endm
+
+	.macro	fpu_save_16odd thread
+	.set	push
+	.set	mips64r2
+	sdc1	$f1,  THREAD_FPR1(\thread)
+	sdc1	$f3,  THREAD_FPR3(\thread)
+	sdc1	$f5,  THREAD_FPR5(\thread)
+	sdc1	$f7,  THREAD_FPR7(\thread)
+	sdc1	$f9,  THREAD_FPR9(\thread)
+	sdc1	$f11, THREAD_FPR11(\thread)
+	sdc1	$f13, THREAD_FPR13(\thread)
+	sdc1	$f15, THREAD_FPR15(\thread)
+	sdc1	$f17, THREAD_FPR17(\thread)
+	sdc1	$f19, THREAD_FPR19(\thread)
+	sdc1	$f21, THREAD_FPR21(\thread)
+	sdc1	$f23, THREAD_FPR23(\thread)
+	sdc1	$f25, THREAD_FPR25(\thread)
+	sdc1	$f27, THREAD_FPR27(\thread)
+	sdc1	$f29, THREAD_FPR29(\thread)
+	sdc1	$f31, THREAD_FPR31(\thread)
+	.set	pop
+	.endm
+
+	.macro	fpu_save_double thread status tmp
+#if defined(CONFIG_MIPS64) || defined(CONFIG_CPU_MIPS32_R2)
+	sll	\tmp, \status, 5
+	bgez	\tmp, 10f
+	fpu_save_16odd \thread
+10:
+#endif
+	fpu_save_16even \thread \tmp
+	.endm
+
+	.macro	fpu_restore_16even thread tmp=t0
+	lw	\tmp, THREAD_FCR31(\thread)
+	ldc1	$f0,  THREAD_FPR0(\thread)
+	ldc1	$f2,  THREAD_FPR2(\thread)
+	ldc1	$f4,  THREAD_FPR4(\thread)
+	ldc1	$f6,  THREAD_FPR6(\thread)
+	ldc1	$f8,  THREAD_FPR8(\thread)
+	ldc1	$f10, THREAD_FPR10(\thread)
+	ldc1	$f12, THREAD_FPR12(\thread)
+	ldc1	$f14, THREAD_FPR14(\thread)
+	ldc1	$f16, THREAD_FPR16(\thread)
+	ldc1	$f18, THREAD_FPR18(\thread)
+	ldc1	$f20, THREAD_FPR20(\thread)
+	ldc1	$f22, THREAD_FPR22(\thread)
+	ldc1	$f24, THREAD_FPR24(\thread)
+	ldc1	$f26, THREAD_FPR26(\thread)
+	ldc1	$f28, THREAD_FPR28(\thread)
+	ldc1	$f30, THREAD_FPR30(\thread)
+	ctc1	\tmp, fcr31
+	.endm
+
+	.macro	fpu_restore_16odd thread
+	.set	push
+	.set	mips64r2
+	ldc1	$f1,  THREAD_FPR1(\thread)
+	ldc1	$f3,  THREAD_FPR3(\thread)
+	ldc1	$f5,  THREAD_FPR5(\thread)
+	ldc1	$f7,  THREAD_FPR7(\thread)
+	ldc1	$f9,  THREAD_FPR9(\thread)
+	ldc1	$f11, THREAD_FPR11(\thread)
+	ldc1	$f13, THREAD_FPR13(\thread)
+	ldc1	$f15, THREAD_FPR15(\thread)
+	ldc1	$f17, THREAD_FPR17(\thread)
+	ldc1	$f19, THREAD_FPR19(\thread)
+	ldc1	$f21, THREAD_FPR21(\thread)
+	ldc1	$f23, THREAD_FPR23(\thread)
+	ldc1	$f25, THREAD_FPR25(\thread)
+	ldc1	$f27, THREAD_FPR27(\thread)
+	ldc1	$f29, THREAD_FPR29(\thread)
+	ldc1	$f31, THREAD_FPR31(\thread)
+	.set	pop
+	.endm
+
+	.macro	fpu_restore_double thread status tmp
+#if defined(CONFIG_MIPS64) || defined(CONFIG_CPU_MIPS32_R2)
+	sll	\tmp, \status, 5
+	bgez	\tmp, 10f				# 16 register mode?
+
+	fpu_restore_16odd \thread
+10:
+#endif
+	fpu_restore_16even \thread \tmp
+	.endm
+
 /*
  * Temporary until all gas have MT ASE support
  */
diff --git a/arch/mips/include/asm/elf.h b/arch/mips/include/asm/elf.h
index a66359e..17163cf 100644
--- a/arch/mips/include/asm/elf.h
+++ b/arch/mips/include/asm/elf.h
@@ -36,6 +36,7 @@
 #define EF_MIPS_ABI2		0x00000020
 #define EF_MIPS_OPTIONS_FIRST	0x00000080
 #define EF_MIPS_32BITMODE	0x00000100
+#define EF_MIPS_FP64		0x00000200
 #define EF_MIPS_ABI		0x0000f000
 #define EF_MIPS_ARCH		0xf0000000
 
@@ -249,6 +250,11 @@ extern struct mips_abi mips_abi_n32;
 
 #define SET_PERSONALITY(ex)						\
 do {									\
+	if ((ex).e_flags & EF_MIPS_FP64)				\
+		clear_thread_flag(TIF_32BIT_FPREGS);			\
+	else								\
+		set_thread_flag(TIF_32BIT_FPREGS);			\
+									\
 	if (personality(current->personality) != PER_LINUX)		\
 		set_personality(PER_LINUX);				\
 									\
@@ -271,14 +277,18 @@ do {									\
 #endif
 
 #ifdef CONFIG_MIPS32_O32
-#define __SET_PERSONALITY32_O32()					\
+#define __SET_PERSONALITY32_O32(ex)					\
 	do {								\
 		set_thread_flag(TIF_32BIT_REGS);			\
 		set_thread_flag(TIF_32BIT_ADDR);			\
+									\
+		if (!((ex).e_flags & EF_MIPS_FP64))			\
+			set_thread_flag(TIF_32BIT_FPREGS);		\
+									\
 		current->thread.abi = &mips_abi_32;			\
 	} while (0)
 #else
-#define __SET_PERSONALITY32_O32()					\
+#define __SET_PERSONALITY32_O32(ex)					\
 	do { } while (0)
 #endif
 
@@ -289,7 +299,7 @@ do {									\
 	     ((ex).e_flags & EF_MIPS_ABI) == 0)				\
 		__SET_PERSONALITY32_N32();				\
 	else								\
-		__SET_PERSONALITY32_O32();				\
+		__SET_PERSONALITY32_O32(ex);                            \
 } while (0)
 #else
 #define __SET_PERSONALITY32(ex) do { } while (0)
@@ -300,6 +310,7 @@ do {									\
 	unsigned int p;							\
 									\
 	clear_thread_flag(TIF_32BIT_REGS);				\
+	clear_thread_flag(TIF_32BIT_FPREGS);				\
 	clear_thread_flag(TIF_32BIT_ADDR);				\
 									\
 	if ((ex).e_ident[EI_CLASS] == ELFCLASS32)			\
diff --git a/arch/mips/include/asm/fpu.h b/arch/mips/include/asm/fpu.h
index 3bf023f..cfe092f 100644
--- a/arch/mips/include/asm/fpu.h
+++ b/arch/mips/include/asm/fpu.h
@@ -33,11 +33,48 @@ extern void _init_fpu(void);
 extern void _save_fp(struct task_struct *);
 extern void _restore_fp(struct task_struct *);
 
-#define __enable_fpu()							\
-do {									\
-	set_c0_status(ST0_CU1);						\
-	enable_fpu_hazard();						\
-} while (0)
+/*
+ * This enum specifies a mode in which we want the FPU to operate, for cores
+ * which implement the Status.FR bit. Note that FPU_32BIT & FPU_64BIT
+ * purposefully have the values 0 & 1 respectively, so that an integer value
+ * of Status.FR can be trivially casted to the corresponding enum fpu_mode.
+ */
+enum fpu_mode {
+	FPU_32BIT = 0,		/* FR = 0 */
+	FPU_64BIT,		/* FR = 1 */
+	FPU_AS_IS,
+};
+
+static inline int __enable_fpu(enum fpu_mode mode)
+{
+	int fr;
+
+	switch (mode) {
+	case FPU_AS_IS:
+		/* just enable the FPU in its current mode */
+		set_c0_status(ST0_CU1);
+		enable_fpu_hazard();
+		return 0;
+
+	case FPU_64BIT:
+#if !(defined(CONFIG_CPU_MIPS32_R2) || defined(CONFIG_MIPS64))
+		/* we only have a 32-bit FPU */
+		return SIGFPE;
+#endif
+		/* fall through */
+	case FPU_32BIT:
+		/* set CU1 & change FR appropriately */
+		fr = (int)mode;
+		change_c0_status(ST0_CU1 | ST0_FR, ST0_CU1 | (fr ? ST0_FR : 0));
+		enable_fpu_hazard();
+
+		/* check FR has the desired value */
+		return (!!(read_c0_status() & ST0_FR) == !!fr) ? 0 : SIGFPE;
+
+	default:
+		BUG();
+	}
+}
 
 #define __disable_fpu()							\
 do {									\
@@ -57,27 +94,46 @@ static inline int is_fpu_owner(void)
 	return cpu_has_fpu && __is_fpu_owner();
 }
 
-static inline void __own_fpu(void)
+static inline int __own_fpu(void)
 {
-	__enable_fpu();
+	enum fpu_mode mode;
+	int ret;
+
+	mode = !test_thread_flag(TIF_32BIT_FPREGS);
+	ret = __enable_fpu(mode);
+	if (ret)
+		return ret;
+
 	KSTK_STATUS(current) |= ST0_CU1;
+	if (mode == FPU_64BIT)
+		KSTK_STATUS(current) |= ST0_FR;
+	else /* mode == FPU_32BIT */
+		KSTK_STATUS(current) &= ~ST0_FR;
+
 	set_thread_flag(TIF_USEDFPU);
+	return 0;
 }
 
-static inline void own_fpu_inatomic(int restore)
+static inline int own_fpu_inatomic(int restore)
 {
+	int ret = 0;
+
 	if (cpu_has_fpu && !__is_fpu_owner()) {
-		__own_fpu();
-		if (restore)
+		ret = __own_fpu();
+		if (restore && !ret)
 			_restore_fp(current);
 	}
+	return ret;
 }
 
-static inline void own_fpu(int restore)
+static inline int own_fpu(int restore)
 {
+	int ret;
+
 	preempt_disable();
-	own_fpu_inatomic(restore);
+	ret = own_fpu_inatomic(restore);
 	preempt_enable();
+	return ret;
 }
 
 static inline void lose_fpu(int save)
@@ -93,16 +149,21 @@ static inline void lose_fpu(int save)
 	preempt_enable();
 }
 
-static inline void init_fpu(void)
+static inline int init_fpu(void)
 {
+	int ret = 0;
+
 	preempt_disable();
 	if (cpu_has_fpu) {
-		__own_fpu();
-		_init_fpu();
+		ret = __own_fpu();
+		if (!ret)
+			_init_fpu();
 	} else {
 		fpu_emulator_init_fpu();
 	}
+
 	preempt_enable();
+	return ret;
 }
 
 static inline void save_fp(struct task_struct *tsk)
diff --git a/arch/mips/include/asm/thread_info.h b/arch/mips/include/asm/thread_info.h
index f9b24bf..b6da8b7 100644
--- a/arch/mips/include/asm/thread_info.h
+++ b/arch/mips/include/asm/thread_info.h
@@ -112,11 +112,12 @@ static inline struct thread_info *current_thread_info(void)
 #define TIF_NOHZ		19	/* in adaptive nohz mode */
 #define TIF_FIXADE		20	/* Fix address errors in software */
 #define TIF_LOGADE		21	/* Log address errors to syslog */
-#define TIF_32BIT_REGS		22	/* also implies 16/32 fprs */
+#define TIF_32BIT_REGS		22	/* 32-bit general purpose registers */
 #define TIF_32BIT_ADDR		23	/* 32-bit address space (o32/n32) */
 #define TIF_FPUBOUND		24	/* thread bound to FPU-full CPU set */
 #define TIF_LOAD_WATCH		25	/* If set, load watch registers */
 #define TIF_SYSCALL_TRACEPOINT	26	/* syscall tracepoint instrumentation */
+#define TIF_32BIT_FPREGS	27	/* 32-bit floating point registers */
 #define TIF_SYSCALL_TRACE	31	/* syscall trace active */
 
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
@@ -133,6 +134,7 @@ static inline struct thread_info *current_thread_info(void)
 #define _TIF_32BIT_ADDR		(1<<TIF_32BIT_ADDR)
 #define _TIF_FPUBOUND		(1<<TIF_FPUBOUND)
 #define _TIF_LOAD_WATCH		(1<<TIF_LOAD_WATCH)
+#define _TIF_32BIT_FPREGS	(1<<TIF_32BIT_FPREGS)
 #define _TIF_SYSCALL_TRACEPOINT	(1<<TIF_SYSCALL_TRACEPOINT)
 
 #define _TIF_WORK_SYSCALL_ENTRY	(_TIF_NOHZ | _TIF_SYSCALL_TRACE |	\
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 8168e29..116102c 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -112,7 +112,7 @@ static inline unsigned long cpu_get_fpu_id(void)
 	unsigned long tmp, fpu_id;
 
 	tmp = read_c0_status();
-	__enable_fpu();
+	__enable_fpu(FPU_AS_IS);
 	fpu_id = read_32bit_cp1_register(CP1_REVISION);
 	write_c0_status(tmp);
 	return fpu_id;
diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index ddc7610..747a6cf 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -60,9 +60,6 @@ void start_thread(struct pt_regs * regs, unsigned long pc, unsigned long sp)
 
 	/* New thread loses kernel privileges. */
 	status = regs->cp0_status & ~(ST0_CU0|ST0_CU1|ST0_FR|KU_MASK);
-#ifdef CONFIG_64BIT
-	status |= test_thread_flag(TIF_32BIT_REGS) ? 0 : ST0_FR;
-#endif
 	status |= KU_USER;
 	regs->cp0_status = status;
 	clear_used_math();
diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
index b52e1d2..30b1a43 100644
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -137,13 +137,13 @@ int ptrace_getfpregs(struct task_struct *child, __u32 __user *data)
 		if (cpu_has_mipsmt) {
 			unsigned int vpflags = dvpe();
 			flags = read_c0_status();
-			__enable_fpu();
+			__enable_fpu(FPU_AS_IS);
 			__asm__ __volatile__("cfc1\t%0,$0" : "=r" (tmp));
 			write_c0_status(flags);
 			evpe(vpflags);
 		} else {
 			flags = read_c0_status();
-			__enable_fpu();
+			__enable_fpu(FPU_AS_IS);
 			__asm__ __volatile__("cfc1\t%0,$0" : "=r" (tmp));
 			write_c0_status(flags);
 		}
@@ -483,13 +483,13 @@ long arch_ptrace(struct task_struct *child, long request,
 			if (cpu_has_mipsmt) {
 				unsigned int vpflags = dvpe();
 				flags = read_c0_status();
-				__enable_fpu();
+				__enable_fpu(FPU_AS_IS);
 				__asm__ __volatile__("cfc1\t%0,$0": "=r" (tmp));
 				write_c0_status(flags);
 				evpe(vpflags);
 			} else {
 				flags = read_c0_status();
-				__enable_fpu();
+				__enable_fpu(FPU_AS_IS);
 				__asm__ __volatile__("cfc1\t%0,$0": "=r" (tmp));
 				write_c0_status(flags);
 			}
diff --git a/arch/mips/kernel/ptrace32.c b/arch/mips/kernel/ptrace32.c
index 9486055..020342a 100644
--- a/arch/mips/kernel/ptrace32.c
+++ b/arch/mips/kernel/ptrace32.c
@@ -147,13 +147,13 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 			if (cpu_has_mipsmt) {
 				unsigned int vpflags = dvpe();
 				flags = read_c0_status();
-				__enable_fpu();
+				__enable_fpu(FPU_AS_IS);
 				__asm__ __volatile__("cfc1\t%0,$0": "=r" (tmp));
 				write_c0_status(flags);
 				evpe(vpflags);
 			} else {
 				flags = read_c0_status();
-				__enable_fpu();
+				__enable_fpu(FPU_AS_IS);
 				__asm__ __volatile__("cfc1\t%0,$0": "=r" (tmp));
 				write_c0_status(flags);
 			}
diff --git a/arch/mips/kernel/r4k_fpu.S b/arch/mips/kernel/r4k_fpu.S
index 55ffe14..253b2fb 100644
--- a/arch/mips/kernel/r4k_fpu.S
+++ b/arch/mips/kernel/r4k_fpu.S
@@ -35,7 +35,15 @@
 LEAF(_save_fp_context)
 	cfc1	t1, fcr31
 
-#ifdef CONFIG_64BIT
+#if defined(CONFIG_64BIT) || defined(CONFIG_MIPS32_R2)
+	.set	push
+#ifdef CONFIG_MIPS32_R2
+	.set	mips64r2
+	mfc0	t0, CP0_STATUS
+	sll	t0, t0, 5
+	bgez	t0, 1f			# skip storing odd if FR=0
+	 nop
+#endif
 	/* Store the 16 odd double precision registers */
 	EX	sdc1 $f1, SC_FPREGS+8(a0)
 	EX	sdc1 $f3, SC_FPREGS+24(a0)
@@ -53,6 +61,7 @@ LEAF(_save_fp_context)
 	EX	sdc1 $f27, SC_FPREGS+216(a0)
 	EX	sdc1 $f29, SC_FPREGS+232(a0)
 	EX	sdc1 $f31, SC_FPREGS+248(a0)
+1:	.set	pop
 #endif
 
 	/* Store the 16 even double precision registers */
@@ -82,7 +91,31 @@ LEAF(_save_fp_context)
 LEAF(_save_fp_context32)
 	cfc1	t1, fcr31
 
-	EX	sdc1 $f0, SC32_FPREGS+0(a0)
+	mfc0	t0, CP0_STATUS
+	sll	t0, t0, 5
+	bgez	t0, 1f			# skip storing odd if FR=0
+	 nop
+
+	/* Store the 16 odd double precision registers */
+	EX      sdc1 $f1, SC32_FPREGS+8(a0)
+	EX      sdc1 $f3, SC32_FPREGS+24(a0)
+	EX      sdc1 $f5, SC32_FPREGS+40(a0)
+	EX      sdc1 $f7, SC32_FPREGS+56(a0)
+	EX      sdc1 $f9, SC32_FPREGS+72(a0)
+	EX      sdc1 $f11, SC32_FPREGS+88(a0)
+	EX      sdc1 $f13, SC32_FPREGS+104(a0)
+	EX      sdc1 $f15, SC32_FPREGS+120(a0)
+	EX      sdc1 $f17, SC32_FPREGS+136(a0)
+	EX      sdc1 $f19, SC32_FPREGS+152(a0)
+	EX      sdc1 $f21, SC32_FPREGS+168(a0)
+	EX      sdc1 $f23, SC32_FPREGS+184(a0)
+	EX      sdc1 $f25, SC32_FPREGS+200(a0)
+	EX      sdc1 $f27, SC32_FPREGS+216(a0)
+	EX      sdc1 $f29, SC32_FPREGS+232(a0)
+	EX      sdc1 $f31, SC32_FPREGS+248(a0)
+
+	/* Store the 16 even double precision registers */
+1:	EX	sdc1 $f0, SC32_FPREGS+0(a0)
 	EX	sdc1 $f2, SC32_FPREGS+16(a0)
 	EX	sdc1 $f4, SC32_FPREGS+32(a0)
 	EX	sdc1 $f6, SC32_FPREGS+48(a0)
@@ -114,7 +147,16 @@ LEAF(_save_fp_context32)
  */
 LEAF(_restore_fp_context)
 	EX	lw t0, SC_FPC_CSR(a0)
-#ifdef CONFIG_64BIT
+
+#if defined(CONFIG_64BIT) || defined(CONFIG_MIPS32_R2)
+	.set	push
+#ifdef CONFIG_MIPS32_R2
+	.set	mips64r2
+	mfc0	t0, CP0_STATUS
+	sll	t0, t0, 5
+	bgez	t0, 1f			# skip loading odd if FR=0
+	 nop
+#endif
 	EX	ldc1 $f1, SC_FPREGS+8(a0)
 	EX	ldc1 $f3, SC_FPREGS+24(a0)
 	EX	ldc1 $f5, SC_FPREGS+40(a0)
@@ -131,6 +173,7 @@ LEAF(_restore_fp_context)
 	EX	ldc1 $f27, SC_FPREGS+216(a0)
 	EX	ldc1 $f29, SC_FPREGS+232(a0)
 	EX	ldc1 $f31, SC_FPREGS+248(a0)
+1:	.set pop
 #endif
 	EX	ldc1 $f0, SC_FPREGS+0(a0)
 	EX	ldc1 $f2, SC_FPREGS+16(a0)
@@ -157,7 +200,30 @@ LEAF(_restore_fp_context)
 LEAF(_restore_fp_context32)
 	/* Restore an o32 sigcontext.  */
 	EX	lw t0, SC32_FPC_CSR(a0)
-	EX	ldc1 $f0, SC32_FPREGS+0(a0)
+
+	mfc0	t0, CP0_STATUS
+	sll	t0, t0, 5
+	bgez	t0, 1f			# skip loading odd if FR=0
+	 nop
+
+	EX      ldc1 $f1, SC32_FPREGS+8(a0)
+	EX      ldc1 $f3, SC32_FPREGS+24(a0)
+	EX      ldc1 $f5, SC32_FPREGS+40(a0)
+	EX      ldc1 $f7, SC32_FPREGS+56(a0)
+	EX      ldc1 $f9, SC32_FPREGS+72(a0)
+	EX      ldc1 $f11, SC32_FPREGS+88(a0)
+	EX      ldc1 $f13, SC32_FPREGS+104(a0)
+	EX      ldc1 $f15, SC32_FPREGS+120(a0)
+	EX      ldc1 $f17, SC32_FPREGS+136(a0)
+	EX      ldc1 $f19, SC32_FPREGS+152(a0)
+	EX      ldc1 $f21, SC32_FPREGS+168(a0)
+	EX      ldc1 $f23, SC32_FPREGS+184(a0)
+	EX      ldc1 $f25, SC32_FPREGS+200(a0)
+	EX      ldc1 $f27, SC32_FPREGS+216(a0)
+	EX      ldc1 $f29, SC32_FPREGS+232(a0)
+	EX      ldc1 $f31, SC32_FPREGS+248(a0)
+
+1:	EX	ldc1 $f0, SC32_FPREGS+0(a0)
 	EX	ldc1 $f2, SC32_FPREGS+16(a0)
 	EX	ldc1 $f4, SC32_FPREGS+32(a0)
 	EX	ldc1 $f6, SC32_FPREGS+48(a0)
diff --git a/arch/mips/kernel/r4k_switch.S b/arch/mips/kernel/r4k_switch.S
index 078de5e..cc78dd9 100644
--- a/arch/mips/kernel/r4k_switch.S
+++ b/arch/mips/kernel/r4k_switch.S
@@ -123,7 +123,7 @@
  * Save a thread's fp context.
  */
 LEAF(_save_fp)
-#ifdef CONFIG_64BIT
+#if defined(CONFIG_64BIT) || defined(CONFIG_CPU_MIPS32_R2)
 	mfc0	t0, CP0_STATUS
 #endif
 	fpu_save_double a0 t0 t1		# clobbers t1
@@ -134,7 +134,7 @@ LEAF(_save_fp)
  * Restore a thread's fp context.
  */
 LEAF(_restore_fp)
-#ifdef CONFIG_64BIT
+#if defined(CONFIG_64BIT) || defined(CONFIG_CPU_MIPS32_R2)
 	mfc0	t0, CP0_STATUS
 #endif
 	fpu_restore_double a0 t0 t1		# clobbers t1
@@ -228,6 +228,47 @@ LEAF(_init_fpu)
 	mtc1	t1, $f29
 	mtc1	t1, $f30
 	mtc1	t1, $f31
+
+#ifdef CONFIG_CPU_MIPS32_R2
+	.set    push
+	.set    mips64r2
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
+#endif /* CONFIG_CPU_MIPS32_R2 */
 #else
 	.set	mips3
 	dmtc1	t1, $f0
diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
index 2f285ab..5199563 100644
--- a/arch/mips/kernel/signal.c
+++ b/arch/mips/kernel/signal.c
@@ -71,8 +71,9 @@ static int protected_save_fp_context(struct sigcontext __user *sc)
 	int err;
 	while (1) {
 		lock_fpu_owner();
-		own_fpu_inatomic(1);
-		err = save_fp_context(sc); /* this might fail */
+		err = own_fpu_inatomic(1);
+		if (!err)
+			err = save_fp_context(sc); /* this might fail */
 		unlock_fpu_owner();
 		if (likely(!err))
 			break;
@@ -91,8 +92,9 @@ static int protected_restore_fp_context(struct sigcontext __user *sc)
 	int err, tmp __maybe_unused;
 	while (1) {
 		lock_fpu_owner();
-		own_fpu_inatomic(0);
-		err = restore_fp_context(sc); /* this might fail */
+		err = own_fpu_inatomic(0);
+		if (!err)
+			err = restore_fp_context(sc); /* this might fail */
 		unlock_fpu_owner();
 		if (likely(!err))
 			break;
diff --git a/arch/mips/kernel/signal32.c b/arch/mips/kernel/signal32.c
index 57de8b7..7c1024b 100644
--- a/arch/mips/kernel/signal32.c
+++ b/arch/mips/kernel/signal32.c
@@ -85,8 +85,9 @@ static int protected_save_fp_context32(struct sigcontext32 __user *sc)
 	int err;
 	while (1) {
 		lock_fpu_owner();
-		own_fpu_inatomic(1);
-		err = save_fp_context32(sc); /* this might fail */
+		err = own_fpu_inatomic(1);
+		if (!err)
+			err = save_fp_context32(sc); /* this might fail */
 		unlock_fpu_owner();
 		if (likely(!err))
 			break;
@@ -105,8 +106,9 @@ static int protected_restore_fp_context32(struct sigcontext32 __user *sc)
 	int err, tmp __maybe_unused;
 	while (1) {
 		lock_fpu_owner();
-		own_fpu_inatomic(0);
-		err = restore_fp_context32(sc); /* this might fail */
+		err = own_fpu_inatomic(0);
+		if (!err)
+			err = restore_fp_context32(sc); /* this might fail */
 		unlock_fpu_owner();
 		if (likely(!err))
 			break;
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index cc20415..eb28423 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1080,7 +1080,7 @@ asmlinkage void do_cpu(struct pt_regs *regs)
 	unsigned long old_epc, old31;
 	unsigned int opcode;
 	unsigned int cpid;
-	int status;
+	int status, err;
 	unsigned long __maybe_unused flags;
 
 	prev_state = exception_enter();
@@ -1153,19 +1153,29 @@ asmlinkage void do_cpu(struct pt_regs *regs)
 
 	case 1:
 		if (used_math())	/* Using the FPU again.	 */
-			own_fpu(1);
+			err = own_fpu(1);
 		else {			/* First time FPU user.	 */
-			init_fpu();
+			err = init_fpu();
 			set_used_math();
 		}
 
-		if (!raw_cpu_has_fpu) {
+#ifndef CONFIG_MIPS_O32_FP64_SUPPORT
+		/*
+		 * This assumes that either all FPUs in the system support
+		 * Status.FR (ie. both 32-bit & 64-bit) or none of them do.
+		 */
+		if (err) {
+			force_sig(SIGFPE, current);
+			goto out;
+		}
+#endif
+		if (!raw_cpu_has_fpu || err) {
 			int sig;
 			void __user *fault_addr = NULL;
 			sig = fpu_emulator_cop1Handler(regs,
 						       &current->thread.fpu,
 						       0, &fault_addr);
-			if (!process_fpemu_return(sig, fault_addr))
+			if (!process_fpemu_return(sig, fault_addr) && !err)
 				mt_ase_fp_affinity();
 		}
 
diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
index 4b37961..22f7b11 100644
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -859,20 +859,20 @@ static int isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
  * In the Linux kernel, we support selection of FPR format on the
  * basis of the Status.FR bit.	If an FPU is not present, the FR bit
  * is hardwired to zero, which would imply a 32-bit FPU even for
- * 64-bit CPUs so we rather look at TIF_32BIT_REGS.
+ * 64-bit CPUs so we rather look at TIF_32BIT_FPREGS.
  * FPU emu is slow and bulky and optimizing this function offers fairly
  * sizeable benefits so we try to be clever and make this function return
  * a constant whenever possible, that is on 64-bit kernels without O32
- * compatibility enabled and on 32-bit kernels.
+ * compatibility enabled and on 32-bit without 64-bit FPU support.
  */
 static inline int cop1_64bit(struct pt_regs *xcp)
 {
 #if defined(CONFIG_64BIT) && !defined(CONFIG_MIPS32_O32)
 	return 1;
-#elif defined(CONFIG_64BIT) && defined(CONFIG_MIPS32_O32)
-	return !test_thread_flag(TIF_32BIT_REGS);
-#else
+#elif defined(CONFIG_32BIT) && !defined(CONFIG_MIPS_O32_FP64_SUPPORT)
 	return 0;
+#else
+	return !test_thread_flag(TIF_32BIT_FPREGS);
 #endif
 }
 
diff --git a/arch/mips/math-emu/kernel_linkage.c b/arch/mips/math-emu/kernel_linkage.c
index 1c58657..3aeae07 100644
--- a/arch/mips/math-emu/kernel_linkage.c
+++ b/arch/mips/math-emu/kernel_linkage.c
@@ -89,8 +89,9 @@ int fpu_emulator_save_context32(struct sigcontext32 __user *sc)
 {
 	int i;
 	int err = 0;
+	int inc = test_thread_flag(TIF_32BIT_FPREGS) ? 2 : 1;
 
-	for (i = 0; i < 32; i+=2) {
+	for (i = 0; i < 32; i += inc) {
 		err |=
 		    __put_user(current->thread.fpu.fpr[i], &sc->sc_fpregs[i]);
 	}
@@ -103,8 +104,9 @@ int fpu_emulator_restore_context32(struct sigcontext32 __user *sc)
 {
 	int i;
 	int err = 0;
+	int inc = test_thread_flag(TIF_32BIT_FPREGS) ? 2 : 1;
 
-	for (i = 0; i < 32; i+=2) {
+	for (i = 0; i < 32; i += inc) {
 		err |=
 		    __get_user(current->thread.fpu.fpr[i], &sc->sc_fpregs[i]);
 	}
-- 
1.8.4.1
