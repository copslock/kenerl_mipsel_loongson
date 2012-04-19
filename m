Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Apr 2012 22:27:37 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:50852 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903737Ab2DSU1Q (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 Apr 2012 22:27:16 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1SKxwc-0005iB-1J; Thu, 19 Apr 2012 15:27:10 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>
Subject: [PATCH v2,4/9] MIPS: Add microMIPS versions of breakpoints, BUG, etc.
Date:   Thu, 19 Apr 2012 15:27:05 -0500
Message-Id: <1334867225-12486-1-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.9.6
X-archive-position: 32977
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@mips.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: "Steven J. Hill" <sjhill@mips.com>

Add breakpoints, BUG() functions, DSP instruction masks, and
debug messages for microMIPS. Also add '.insn' directive to
a number of files that must assemble correctly when using the
microMIPS or MIPS16e instruction sets.

Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/include/asm/break.h   |    8 ++++++++
 arch/mips/include/asm/bug.h     |    8 ++++++++
 arch/mips/include/asm/dsp.h     |    4 ++++
 arch/mips/include/asm/futex.h   |    4 ++++
 arch/mips/include/asm/paccess.h |    2 ++
 arch/mips/include/asm/uaccess.h |   14 ++++++++++++--
 arch/mips/kernel/proc.c         |   27 ++++++++++++++-------------
 arch/mips/kernel/ptrace.c       |    4 ++++
 arch/mips/mm/fault.c            |    2 ++
 9 files changed, 58 insertions(+), 15 deletions(-)

diff --git a/arch/mips/include/asm/break.h b/arch/mips/include/asm/break.h
index 9161e68..56758eb 100644
--- a/arch/mips/include/asm/break.h
+++ b/arch/mips/include/asm/break.h
@@ -27,6 +27,14 @@
 #define BRK_STACKOVERFLOW 9	/* For Ada stackchecking */
 #define BRK_NORLD	10	/* No rld found - not used by Linux/MIPS */
 #define _BRK_THREADBP	11	/* For threads, user bp (used by debuggers) */
+
+/* microMIPS definitions */
+#define MM_BRK_BUG	12	/* Used by BUG() */
+#define MM_BRK_KDB	13	/* Used in KDB_ENTER() */
+#define MM_BRK_MEMU	14	/* Used by FPU emulator */
+#define MM_BRK_MULOVF	15	/* Multiply overflow */
+
+/* MIPS32/64 definitions */
 #define BRK_BUG		512	/* Used by BUG() */
 #define BRK_KDB		513	/* Used in KDB_ENTER() */
 #define BRK_MEMU	514	/* Used by FPU emulator */
diff --git a/arch/mips/include/asm/bug.h b/arch/mips/include/asm/bug.h
index 540c98a..7afa2e5 100644
--- a/arch/mips/include/asm/bug.h
+++ b/arch/mips/include/asm/bug.h
@@ -10,7 +10,11 @@
 
 static inline void __noreturn BUG(void)
 {
+#ifdef CONFIG_CPU_MICROMIPS
+	__asm__ __volatile__("break %0" : : "i" (MM_BRK_BUG));
+#else
 	__asm__ __volatile__("break %0" : : "i" (BRK_BUG));
+#endif
 	unreachable();
 }
 
@@ -27,7 +31,11 @@ static inline void  __BUG_ON(unsigned long condition)
 			return;
 	}
 	__asm__ __volatile__("tne $0, %0, %1"
+#ifdef CONFIG_CPU_MICROMIPS
+			     : : "r" (condition), "i" (MM_BRK_BUG));
+#else
 			     : : "r" (condition), "i" (BRK_BUG));
+#endif
 }
 
 #define BUG_ON(C) __BUG_ON((unsigned long)(C))
diff --git a/arch/mips/include/asm/dsp.h b/arch/mips/include/asm/dsp.h
index e9bfc08..3149b30 100644
--- a/arch/mips/include/asm/dsp.h
+++ b/arch/mips/include/asm/dsp.h
@@ -16,7 +16,11 @@
 #include <asm/mipsregs.h>
 
 #define DSP_DEFAULT	0x00000000
+#ifdef CONFIG_CPU_MICROMIPS
+#define DSP_MASK	0x7f
+#else
 #define DSP_MASK	0x3ff
+#endif
 
 #define __enable_dsp_hazard()						\
 do {									\
diff --git a/arch/mips/include/asm/futex.h b/arch/mips/include/asm/futex.h
index 6ebf173..007adca 100644
--- a/arch/mips/include/asm/futex.h
+++ b/arch/mips/include/asm/futex.h
@@ -31,6 +31,7 @@
 		"	beqzl	$1, 1b				\n"	\
 		__WEAK_LLSC_MB						\
 		"3:						\n"	\
+		"	.insn					\n"	\
 		"	.set	pop				\n"	\
 		"	.set	mips0				\n"	\
 		"	.section .fixup,\"ax\"			\n"	\
@@ -57,6 +58,7 @@
 		"	beqz	$1, 1b				\n"	\
 		__WEAK_LLSC_MB						\
 		"3:						\n"	\
+		"	.insn					\n"	\
 		"	.set	pop				\n"	\
 		"	.set	mips0				\n"	\
 		"	.section .fixup,\"ax\"			\n"	\
@@ -156,6 +158,7 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 		"	beqzl	$1, 1b					\n"
 		__WEAK_LLSC_MB
 		"3:							\n"
+		"	.insn						\n"
 		"	.set	pop					\n"
 		"	.section .fixup,\"ax\"				\n"
 		"4:	li	%0, %6					\n"
@@ -183,6 +186,7 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 		"	beqz	$1, 1b					\n"
 		__WEAK_LLSC_MB
 		"3:							\n"
+		"	.insn						\n"
 		"	.set	pop					\n"
 		"	.section .fixup,\"ax\"				\n"
 		"4:	li	%0, %6					\n"
diff --git a/arch/mips/include/asm/paccess.h b/arch/mips/include/asm/paccess.h
index 9ce5a1e..f479742 100644
--- a/arch/mips/include/asm/paccess.h
+++ b/arch/mips/include/asm/paccess.h
@@ -56,6 +56,7 @@ struct __large_pstruct { unsigned long buf[100]; };
 	"1:\t" insn "\t%1,%2\n\t"					\
 	"move\t%0,$0\n"							\
 	"2:\n\t"							\
+	".insn\n\t"							\
 	".section\t.fixup,\"ax\"\n"					\
 	"3:\tli\t%0,%3\n\t"						\
 	"move\t%1,$0\n\t"						\
@@ -94,6 +95,7 @@ extern void __get_dbe_unknown(void);
 	"1:\t" insn "\t%1,%2\n\t"					\
 	"move\t%0,$0\n"							\
 	"2:\n\t"							\
+	".insn\n\t"							\
 	".section\t.fixup,\"ax\"\n"					\
 	"3:\tli\t%0,%3\n\t"						\
 	"j\t2b\n\t"							\
diff --git a/arch/mips/include/asm/uaccess.h b/arch/mips/include/asm/uaccess.h
index 653a412..9510015 100644
--- a/arch/mips/include/asm/uaccess.h
+++ b/arch/mips/include/asm/uaccess.h
@@ -261,6 +261,7 @@ do {									\
 	__asm__ __volatile__(						\
 	"1:	" insn "	%1, %3				\n"	\
 	"2:							\n"	\
+	"	.insn						\n"	\
 	"	.section .fixup,\"ax\"				\n"	\
 	"3:	li	%0, %4					\n"	\
 	"	j	2b					\n"	\
@@ -287,7 +288,9 @@ do {									\
 	__asm__ __volatile__(						\
 	"1:	lw	%1, (%3)				\n"	\
 	"2:	lw	%D1, 4(%3)				\n"	\
-	"3:	.section	.fixup,\"ax\"			\n"	\
+	"3:							\n"	\
+	"	.insn						\n"	\
+	"	.section	.fixup,\"ax\"			\n"	\
 	"4:	li	%0, %4					\n"	\
 	"	move	%1, $0					\n"	\
 	"	move	%D1, $0					\n"	\
@@ -355,6 +358,7 @@ do {									\
 	__asm__ __volatile__(						\
 	"1:	" insn "	%z2, %3		# __put_user_asm\n"	\
 	"2:							\n"	\
+	"	.insn						\n"	\
 	"	.section	.fixup,\"ax\"			\n"	\
 	"3:	li	%0, %4					\n"	\
 	"	j	2b					\n"	\
@@ -373,6 +377,7 @@ do {									\
 	"1:	sw	%2, (%3)	# __put_user_asm_ll32	\n"	\
 	"2:	sw	%D2, 4(%3)				\n"	\
 	"3:							\n"	\
+	"	.insn						\n"	\
 	"	.section	.fixup,\"ax\"			\n"	\
 	"4:	li	%0, %4					\n"	\
 	"	j	3b					\n"	\
@@ -524,6 +529,7 @@ do {									\
 	__asm__ __volatile__(						\
 	"1:	" insn "	%1, %3				\n"	\
 	"2:							\n"	\
+	"	.insn						\n"	\
 	"	.section .fixup,\"ax\"				\n"	\
 	"3:	li	%0, %4					\n"	\
 	"	j	2b					\n"	\
@@ -549,7 +555,9 @@ do {									\
 	"1:	ulw	%1, (%3)				\n"	\
 	"2:	ulw	%D1, 4(%3)				\n"	\
 	"	move	%0, $0					\n"	\
-	"3:	.section	.fixup,\"ax\"			\n"	\
+	"3:							\n"	\
+	"	.insn						\n"	\
+	"	.section	.fixup,\"ax\"			\n"	\
 	"4:	li	%0, %4					\n"	\
 	"	move	%1, $0					\n"	\
 	"	move	%D1, $0					\n"	\
@@ -616,6 +624,7 @@ do {									\
 	__asm__ __volatile__(						\
 	"1:	" insn "	%z2, %3		# __put_user_unaligned_asm\n" \
 	"2:							\n"	\
+	"	.insn						\n"	\
 	"	.section	.fixup,\"ax\"			\n"	\
 	"3:	li	%0, %4					\n"	\
 	"	j	2b					\n"	\
@@ -634,6 +643,7 @@ do {									\
 	"1:	sw	%2, (%3)	# __put_user_unaligned_asm_ll32	\n" \
 	"2:	sw	%D2, 4(%3)				\n"	\
 	"3:							\n"	\
+	"	.insn						\n"	\
 	"	.section	.fixup,\"ax\"			\n"	\
 	"4:	li	%0, %4					\n"	\
 	"	j	3b					\n"	\
diff --git a/arch/mips/kernel/proc.c b/arch/mips/kernel/proc.c
index e309665..2c0f781 100644
--- a/arch/mips/kernel/proc.c
+++ b/arch/mips/kernel/proc.c
@@ -41,29 +41,30 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 
 	seq_printf(m, "processor\t\t: %ld\n", n);
 	sprintf(fmt, "cpu model\t\t: %%s V%%d.%%d%s\n",
-	        cpu_data[n].options & MIPS_CPU_FPU ? "  FPU V%d.%d" : "");
+		      cpu_data[n].options & MIPS_CPU_FPU ? "  FPU V%d.%d" : "");
 	seq_printf(m, fmt, __cpu_name[n],
-	                           (version >> 4) & 0x0f, version & 0x0f,
-	                           (fp_vers >> 4) & 0x0f, fp_vers & 0x0f);
+		      (version >> 4) & 0x0f, version & 0x0f,
+		      (fp_vers >> 4) & 0x0f, fp_vers & 0x0f);
 	seq_printf(m, "BogoMIPS\t\t: %u.%02u\n",
-	              cpu_data[n].udelay_val / (500000/HZ),
-	              (cpu_data[n].udelay_val / (5000/HZ)) % 100);
+		      cpu_data[n].udelay_val / (500000/HZ),
+		      (cpu_data[n].udelay_val / (5000/HZ)) % 100);
 	seq_printf(m, "wait instruction\t: %s\n", cpu_wait ? "yes" : "no");
 	seq_printf(m, "microsecond timers\t: %s\n",
-	              cpu_has_counter ? "yes" : "no");
+		      cpu_has_counter ? "yes" : "no");
 	seq_printf(m, "tlb_entries\t\t: %d\n", cpu_data[n].tlbsize);
 	seq_printf(m, "extra interrupt vector\t: %s\n",
-	              cpu_has_divec ? "yes" : "no");
+		      cpu_has_divec ? "yes" : "no");
 	seq_printf(m, "hardware watchpoint\t: %s",
-		   cpu_has_watch ? "yes, " : "no\n");
+		      cpu_has_watch ? "yes, " : "no\n");
 	if (cpu_has_watch) {
 		seq_printf(m, "count: %d, address/irw mask: [",
-			   cpu_data[n].watch_reg_count);
+		      cpu_data[n].watch_reg_count);
 		for (i = 0; i < cpu_data[n].watch_reg_count; i++)
 			seq_printf(m, "%s0x%04x", i ? ", " : "" ,
-				   cpu_data[n].watch_reg_masks[i]);
+				cpu_data[n].watch_reg_masks[i]);
 		seq_printf(m, "]\n");
 	}
+	seq_printf(m, "microMIPS\t\t: %s\n", cpu_has_mmips ? "yes" : "no");
 	seq_printf(m, "ASEs implemented\t:%s%s%s%s%s%s\n",
 		      cpu_has_mips16 ? " mips16" : "",
 		      cpu_has_mdmx ? " mdmx" : "",
@@ -73,13 +74,13 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 		      cpu_has_mipsmt ? " mt" : ""
 		);
 	seq_printf(m, "shadow register sets\t: %d\n",
-		       cpu_data[n].srsets);
+		      cpu_data[n].srsets);
 	seq_printf(m, "kscratch registers\t: %d\n",
-		   hweight8(cpu_data[n].kscratch_mask));
+		      hweight8(cpu_data[n].kscratch_mask));
 	seq_printf(m, "core\t\t\t: %d\n", cpu_data[n].core);
 
 	sprintf(fmt, "VCE%%c exceptions\t\t: %s\n",
-	        cpu_has_vce ? "%u" : "not available");
+		      cpu_has_vce ? "%u" : "not available");
 	seq_printf(m, fmt, 'D', vced_count);
 	seq_printf(m, fmt, 'I', vcei_count);
 	seq_printf(m, "\n");
diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
index 7c24c29..4b4bbc0 100644
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -364,6 +364,7 @@ long arch_ptrace(struct task_struct *child, long request,
 			preempt_enable();
 			break;
 		}
+#ifndef CONFIG_CPU_MICROMIPS
 		case DSP_BASE ... DSP_BASE + 5: {
 			dspreg_t *dregs;
 
@@ -384,6 +385,7 @@ long arch_ptrace(struct task_struct *child, long request,
 			}
 			tmp = child->thread.dsp.dspcontrol;
 			break;
+#endif
 		default:
 			tmp = 0;
 			ret = -EIO;
@@ -453,6 +455,7 @@ long arch_ptrace(struct task_struct *child, long request,
 		case FPC_CSR:
 			child->thread.fpu.fcr31 = data;
 			break;
+#ifndef CONFIG_CPU_MICROMIPS
 		case DSP_BASE ... DSP_BASE + 5: {
 			dspreg_t *dregs;
 
@@ -472,6 +475,7 @@ long arch_ptrace(struct task_struct *child, long request,
 			}
 			child->thread.dsp.dspcontrol = data;
 			break;
+#endif
 		default:
 			/* The rest are not allowed. */
 			ret = -EIO;
diff --git a/arch/mips/mm/fault.c b/arch/mips/mm/fault.c
index c14f6df..bae32a7 100644
--- a/arch/mips/mm/fault.c
+++ b/arch/mips/mm/fault.c
@@ -25,6 +25,7 @@
 #include <asm/uaccess.h>
 #include <asm/ptrace.h>
 #include <asm/highmem.h>		/* For VMALLOC_END */
+#include <asm/tlbdebug.h>
 #include <linux/kdebug.h>
 
 /*
@@ -231,6 +232,7 @@ no_context:
 	       "virtual address %0*lx, epc == %0*lx, ra == %0*lx\n",
 	       raw_smp_processor_id(), field, address, field, regs->cp0_epc,
 	       field,  regs->regs[31]);
+	dump_tlb_all();
 	die("Oops", regs);
 
 out_of_memory:
-- 
1.7.9.6
