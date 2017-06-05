Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Jun 2017 20:24:28 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:25826 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993892AbdFESX1cAmm3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Jun 2017 20:23:27 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 4EFD93601EB50;
        Mon,  5 Jun 2017 19:23:16 +0100 (IST)
Received: from localhost (10.20.1.33) by hhmail02.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 5 Jun 2017 19:23:20
 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 5/5] MIPS: Allow floating point support to be disabled
Date:   Mon, 5 Jun 2017 11:21:31 -0700
Message-ID: <20170605182131.16853-6-paul.burton@imgtec.com>
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
X-archive-position: 58227
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

Floating point support has up until now always been included in all MIPS
kernels. On systems that will run exclusively soft-float code this means
the kernel includes a considerable amount of code which will never be
executed.

This patch introduces a Kconfig option to disable floating point support
in the kernel. Doing so will result in a kernel that never enables an
FPU for userland, and that always responds to use of floating point
instructions with SIGILL. With a maltasmvp_defconfig kernel this shaves
~65KiB from the size of the kernel binary.

Further optimisations would be possible, for example removing the FP &
MSA vector context from struct thread_struct when FP support is
disabled, and compiling out the code that provides access to that
through ptrace. Such changes are more invasive than those in this patch
however, so they're left as potential later work.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org

---

 arch/mips/Kconfig                    | 26 +++++++++++++++++++++++---
 arch/mips/Makefile                   |  2 +-
 arch/mips/include/asm/cpu-features.h | 11 ++++++++---
 arch/mips/include/asm/dsemul.h       | 34 ++++++++++++++++++++++++++++++++++
 arch/mips/include/asm/fpu.h          |  3 +++
 arch/mips/include/asm/fpu_emulator.h | 16 ++++++++++++++++
 arch/mips/kernel/Makefile            |  3 +--
 arch/mips/kernel/process.c           |  8 ++++++++
 8 files changed, 94 insertions(+), 9 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 20958af88522..c6255acd6d99 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2227,9 +2227,29 @@ config CPU_GENERIC_DUMP_TLB
 	bool
 	default y if !(CPU_R3000 || CPU_R8000 || CPU_TX39XX)
 
+config FP_SUPPORT
+	bool "Floating Point Support"
+	default y
+	help
+	  Select this to enable support for programs which make use of floating
+	  point instructions. This allows the kernel to support initialising, context
+	  switching & emulating the Floating Point Unit (FPU) in order to allow such
+	  programs to execute correctly.
+
+	  If you disable this then any program which attempts to execute a floating
+	  point instruction will receive a SIGILL signal & is likely to fail.
+
+	  If in doubt, say Y.
+
+config CPU_R2300_FPU
+	bool
+	depends on FP_SUPPORT
+	default y if CPU_R3000 || CPU_TX39XX
+
 config CPU_R4K_FPU
 	bool
-	default y if !(CPU_R3000 || CPU_TX39XX)
+	depends on FP_SUPPORT
+	default y if !CPU_R2300_FPU
 
 config CPU_R4K_CACHE_TLB
 	bool
@@ -2279,7 +2299,7 @@ config MIPS_MT_FPAFF
 
 config MIPSR2_TO_R6_EMULATOR
 	bool "MIPS R2-to-R6 emulator"
-	depends on CPU_MIPSR6
+	depends on CPU_MIPSR6 && FP_SUPPORT
 	default y
 	help
 	  Choose this option if you want to run non-R6 MIPS userland code.
@@ -2423,7 +2443,7 @@ endchoice
 
 config CPU_HAS_MSA
 	bool "Support for the MIPS SIMD Architecture"
-	depends on CPU_SUPPORTS_MSA
+	depends on CPU_SUPPORTS_MSA && FP_SUPPORT
 	depends on 64BIT || MIPS_O32_FP64_SUPPORT
 	help
 	  MIPS SIMD Architecture (MSA) introduces 128 bit wide vector registers
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 3d2f247310e4..4900bec32bed 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -301,7 +301,7 @@ OBJCOPYFLAGS		+= --remove-section=.reginfo
 head-y := arch/mips/kernel/head.o
 
 libs-y			+= arch/mips/lib/
-libs-y			+= arch/mips/math-emu/
+libs-$(CONFIG_FP_SUPPORT)	+= arch/mips/math-emu/
 
 # See arch/mips/Kbuild for content of core part of the kernel
 core-y += arch/mips/
diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index 494d38274142..fc0a974545c8 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -76,10 +76,15 @@
 #endif
 /* Don't override `cpu_has_fpu' to 1 or the "nofpu" option won't work.  */
 #ifndef cpu_has_fpu
-#define cpu_has_fpu		(current_cpu_data.options & MIPS_CPU_FPU)
-#define raw_cpu_has_fpu		(raw_current_cpu_data.options & MIPS_CPU_FPU)
+# ifdef CONFIG_FP_SUPPORT
+#  define cpu_has_fpu		(current_cpu_data.options & MIPS_CPU_FPU)
+#  define raw_cpu_has_fpu	(raw_current_cpu_data.options & MIPS_CPU_FPU)
+# else
+#  define cpu_has_fpu		0
+#  define raw_cpu_has_fpu	0
+# endif
 #else
-#define raw_cpu_has_fpu		cpu_has_fpu
+# define raw_cpu_has_fpu	cpu_has_fpu
 #endif
 #ifndef cpu_has_32fpr
 #define cpu_has_32fpr		(cpu_data[0].options & MIPS_CPU_32FPR)
diff --git a/arch/mips/include/asm/dsemul.h b/arch/mips/include/asm/dsemul.h
index a6e067801f23..c5e1e719318b 100644
--- a/arch/mips/include/asm/dsemul.h
+++ b/arch/mips/include/asm/dsemul.h
@@ -13,6 +13,7 @@
 
 #include <asm/break.h>
 #include <asm/inst.h>
+#include <asm/signal.h>
 
 /* Break instruction with special math emu break code set */
 #define BREAK_MATH(micromips)	(((micromips) ? 0x7 : 0xd) | (BRK_MEMU << 16))
@@ -38,8 +39,16 @@ struct task_struct;
  *
  * Return: Zero on success, negative if ir is a NOP, signal number on failure.
  */
+#ifdef CONFIG_FP_SUPPORT
 extern int mips_dsemul(struct pt_regs *regs, mips_instruction ir,
 		       unsigned long branch_pc, unsigned long cont_pc);
+#else
+static inline int mips_dsemul(struct pt_regs *regs, mips_instruction ir,
+			      unsigned long branch_pc, unsigned long cont_pc)
+{
+	return SIGILL;
+}
+#endif
 
 /**
  * do_dsemulret() - Return from a delay slot 'emulation' frame
@@ -52,7 +61,14 @@ extern int mips_dsemul(struct pt_regs *regs, mips_instruction ir,
  *
  * Return: True if an emulation frame was returned from, else false.
  */
+#ifdef CONFIG_FP_SUPPORT
 extern bool do_dsemulret(struct pt_regs *xcp);
+#else
+static inline bool do_dsemulret(struct pt_regs *xcp)
+{
+	return false;
+}
+#endif
 
 /**
  * dsemul_thread_cleanup() - Cleanup thread 'emulation' frame
@@ -63,7 +79,14 @@ extern bool do_dsemulret(struct pt_regs *xcp);
  *
  * Return: True if a frame was freed, else false.
  */
+#ifdef CONFIG_FP_SUPPORT
 extern bool dsemul_thread_cleanup(struct task_struct *tsk);
+#else
+static inline bool dsemul_thread_cleanup(struct task_struct *tsk)
+{
+	return false;
+}
+#endif
 
 /**
  * dsemul_thread_rollback() - Rollback from an 'emulation' frame
@@ -77,7 +100,14 @@ extern bool dsemul_thread_cleanup(struct task_struct *tsk);
  *
  * Return: True if a frame was exited, else false.
  */
+#ifdef CONFIG_FP_SUPPORT
 extern bool dsemul_thread_rollback(struct pt_regs *regs);
+#else
+static inline bool dsemul_thread_rollback(struct pt_regs *regs)
+{
+	return false;
+}
+#endif
 
 /**
  * dsemul_mm_cleanup() - Cleanup per-mm delay slot 'emulation' state
@@ -87,6 +117,10 @@ extern bool dsemul_thread_rollback(struct pt_regs *regs);
  * for delay slot 'emulation' book-keeping is freed. This is to be called
  * before @mm is freed in order to avoid memory leaks.
  */
+#ifdef CONFIG_FP_SUPPORT
 extern void dsemul_mm_cleanup(struct mm_struct *mm);
+#else
+static inline void dsemul_mm_cleanup(struct mm_struct *mm) { }
+#endif
 
 #endif /* __MIPS_ASM_DSEMUL_H__ */
diff --git a/arch/mips/include/asm/fpu.h b/arch/mips/include/asm/fpu.h
index a2813fe381cf..a7b2a6b76c14 100644
--- a/arch/mips/include/asm/fpu.h
+++ b/arch/mips/include/asm/fpu.h
@@ -61,6 +61,9 @@ static inline int __enable_fpu(enum fpu_mode mode)
 {
 	int fr;
 
+	if (!IS_ENABLED(CONFIG_FP_SUPPORT))
+		return SIGFPE;
+
 	switch (mode) {
 	case FPU_AS_IS:
 		/* just enable the FPU in its current mode */
diff --git a/arch/mips/include/asm/fpu_emulator.h b/arch/mips/include/asm/fpu_emulator.h
index c05369e0b8d6..6a513ecf9e18 100644
--- a/arch/mips/include/asm/fpu_emulator.h
+++ b/arch/mips/include/asm/fpu_emulator.h
@@ -60,9 +60,25 @@ do {									\
 #define MIPS_FPU_EMU_INC_STATS(M) do { } while (0)
 #endif /* CONFIG_DEBUG_FS */
 
+#ifdef CONFIG_FP_SUPPORT
+
 extern int fpu_emulator_cop1Handler(struct pt_regs *xcp,
 				    struct mips_fpu_struct *ctx, int has_fpu,
 				    void *__user *fault_addr);
+
+#else /* !CONFIG_FP_SUPPORT */
+
+static inline int fpu_emulator_cop1Handler(struct pt_regs *xcp,
+					   struct mips_fpu_struct *ctx,
+					   int has_fpu,
+					   void *__user *fault_addr)
+{
+	*fault_addr = NULL;
+	return SIGILL;
+}
+
+#endif /* !CONFIG_FP_SUPPORT */
+
 void force_fcr31_sig(unsigned long fcr31, void __user *fault_addr,
 		     struct task_struct *tsk);
 int process_fpemu_return(int sig, void __user *fault_addr,
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index 10d75888f6ae..b1a40708e932 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -42,9 +42,8 @@ sw-$(CONFIG_CPU_TX39XX)		:= r2300_switch.o
 sw-$(CONFIG_CPU_CAVIUM_OCTEON)	:= octeon_switch.o
 obj-y				+= $(sw-y)
 
+obj-$(CONFIG_CPU_R2300_FPU)	+= r2300_fpu.o
 obj-$(CONFIG_CPU_R4K_FPU)	+= r4k_fpu.o
-obj-$(CONFIG_CPU_R3000)		+= r2300_fpu.o
-obj-$(CONFIG_CPU_TX39XX)	+= r2300_fpu.o
 
 obj-$(CONFIG_SMP)		+= smp.o
 obj-$(CONFIG_SMP_UP)		+= smp-up.o
diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 5351e1f3950d..e9799e597a5d 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -663,6 +663,10 @@ int mips_get_process_fp_mode(struct task_struct *task)
 {
 	int value = 0;
 
+	/* We can do nothing sensible if we have no FP support */
+	if (!IS_ENABLED(CONFIG_FP_SUPPORT))
+		return -EOPNOTSUPP;
+
 	if (!test_tsk_thread_flag(task, TIF_32BIT_FPREGS))
 		value |= PR_FP_MODE_FR;
 	if (test_tsk_thread_flag(task, TIF_HYBRID_FPREGS))
@@ -685,6 +689,10 @@ int mips_set_process_fp_mode(struct task_struct *task, unsigned int value)
 	struct task_struct *t;
 	int max_users;
 
+	/* We can do nothing sensible if we have no FP support */
+	if (!IS_ENABLED(CONFIG_FP_SUPPORT))
+		return -EOPNOTSUPP;
+
 	/* Check the value is valid */
 	if (value & ~known_bits)
 		return -EOPNOTSUPP;
-- 
2.13.0
