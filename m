Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Jun 2010 20:45:56 +0200 (CEST)
Received: from mail-px0-f177.google.com ([209.85.212.177]:62699 "EHLO
        mail-px0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492033Ab0FLSp1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 12 Jun 2010 20:45:27 +0200
Received: by pxi18 with SMTP id 18so1783639pxi.36
        for <multiple recipients>; Sat, 12 Jun 2010 11:45:18 -0700 (PDT)
Received: by 10.142.207.10 with SMTP id e10mr2512861wfg.284.1276368318427;
        Sat, 12 Jun 2010 11:45:18 -0700 (PDT)
Received: from localhost.localdomain ([122.167.28.178])
        by mx.google.com with ESMTPS id b12sm2671724rvn.10.2010.06.12.11.45.16
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 12 Jun 2010 11:45:17 -0700 (PDT)
From:   Himanshu Chauhan <hschauhan@nulltrace.org>
To:     linux-kernel@vger.kernel.org
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: [PATCH] MIPS: Kprobe support v0.2 This incorporates some of the comments from Daney.
Date:   Sat, 12 Jun 2010 21:50:56 +0530
Message-Id: <1276359656-2375-2-git-send-email-hschauhan@nulltrace.org>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <1276359441-1846-1-git-send-email-hschauhan@nulltrace.org>
References: <1276359441-1846-1-git-send-email-hschauhan@nulltrace.org>
X-archive-position: 27125
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hschauhan@nulltrace.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 8711

Signed-off-by: Himanshu Chauhan <hschauhan@nulltrace.org>

---
 arch/mips/Kconfig               |   13 ++
 arch/mips/include/asm/break.h   |    2 +
 arch/mips/include/asm/kdebug.h  |    5 +
 arch/mips/include/asm/kprobes.h |   86 +++++++++
 arch/mips/kernel/Makefile       |    2 +
 arch/mips/kernel/kprobes.c      |  379 +++++++++++++++++++++++++++++++++++++++
 arch/mips/kernel/traps.c        |   46 +++++-
 arch/mips/mm/fault.c            |   11 +-
 8 files changed, 541 insertions(+), 3 deletions(-)
 create mode 100644 arch/mips/include/asm/kprobes.h
 create mode 100644 arch/mips/kernel/kprobes.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index cdaae94..ba7cc87 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2243,6 +2243,19 @@ source "kernel/power/Kconfig"
 
 endmenu
 
+menu "Instrumentation Support"
+
+config KPROBES
+       bool "MIPS Kprobes Support (Experimental)"
+       depends on EXPERIMENTAL && MODULES
+       help
+	  Kprobes allow you to trap at almost any kernel address
+	  and execute a callback function. Kprobes is useful for
+	  kernel debugging, non-intrusive instrumetation and testing.
+	  If in doubt, say N.
+
+endmenu
+
 source "arch/mips/kernel/cpufreq/Kconfig"
 
 source "net/Kconfig"
diff --git a/arch/mips/include/asm/break.h b/arch/mips/include/asm/break.h
index 44437ed..9ee3014 100644
--- a/arch/mips/include/asm/break.h
+++ b/arch/mips/include/asm/break.h
@@ -30,6 +30,8 @@
 #define BRK_BUG		512	/* Used by BUG() */
 #define BRK_KDB		513	/* Used in KDB_ENTER() */
 #define BRK_MEMU	514	/* Used by FPU emulator */
+#define BRK_KPRB_BP	515	/* Used by Kprobes for pre-handling */
+#define BRK_KPRB_SSTP	516	/* Used by Kprobes for post-handling */
 #define BRK_MULOVF	1023	/* Multiply overflow */
 
 #endif /* __ASM_BREAK_H */
diff --git a/arch/mips/include/asm/kdebug.h b/arch/mips/include/asm/kdebug.h
index 5bf62aa..52818ac 100644
--- a/arch/mips/include/asm/kdebug.h
+++ b/arch/mips/include/asm/kdebug.h
@@ -8,6 +8,11 @@ enum die_val {
 	DIE_FP,
 	DIE_TRAP,
 	DIE_RI,
+#ifdef CONFIG_KPROBES
+	DIE_PAGE_FAULT,
+	DIE_BREAK,
+	DIE_SSTEPBP,
+#endif
 };
 
 #endif /* _ASM_MIPS_KDEBUG_H */
diff --git a/arch/mips/include/asm/kprobes.h b/arch/mips/include/asm/kprobes.h
new file mode 100644
index 0000000..75fcda5
--- /dev/null
+++ b/arch/mips/include/asm/kprobes.h
@@ -0,0 +1,86 @@
+/*
+ *  Kernel Probes (KProbes)
+ *  include/asm-mips/kprobes.h
+ *
+ *  Copyright 2006 Sony Corp.
+ *
+ *  Himanshu Chauhan <hschauhan@nulltrace.org>
+ *  for >2.6.35 kernels.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; version 2 of the License.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#ifndef _ASM_KPROBES_H
+#define _ASM_KPROBES_H
+
+#include <linux/types.h>
+#include <linux/ptrace.h>
+#include <asm/inst.h>
+#include <asm/break.h> /* BRK_KPROBES_PRE/POSH */
+
+#define  __ARCH_WANT_KPROBES_INSN_SLOT
+
+struct kprobe;
+struct pt_regs;
+
+typedef union mips_instruction kprobe_opcode_t;
+
+/*
+ * We do not have hardware single-stepping on MIPS.
+ * So we implement software single-stepping with breakpoint
+ * trap.
+ */
+#define MIPS_KPROBE_BP			(0x0000000d | (BRK_KPRB_BP << 6))
+#define MIPS_KPROBE_SSTP		(0x0000000d | (BRK_KPRB_SSTP << 6))
+#define MAX_INSN_SIZE 			2
+
+#define flush_insn_slot(p)                      \
+        do {                                    \
+                /* invalidate I-cache */        \
+                asm volatile("cache 0, 0($0)"); \
+                /* invalidate D-cache */        \
+                asm volatile("cache 9, 0($0)"); \
+        } while(0);
+
+#define kretprobe_blacklist_size	0
+
+void arch_remove_kprobe(struct kprobe *p);
+
+/* Architecture specific copy of original instruction*/
+struct arch_specific_insn {
+	/* copy of the original instruction */
+	kprobe_opcode_t *insn;
+};
+
+struct prev_kprobe {
+	struct kprobe *kp;
+	unsigned long status;
+	unsigned long old_SR;
+	unsigned long saved_SR;
+	unsigned long saved_epc;
+};
+
+/* per-cpu kprobe control block */
+struct kprobe_ctlblk {
+	unsigned long kprobe_status;
+	unsigned long kprobe_old_SR;
+	unsigned long kprobe_saved_SR;
+	unsigned long kprobe_saved_epc;
+	struct prev_kprobe prev_kprobe;
+};
+
+extern int kprobe_exceptions_notify(struct notifier_block *self,
+				    unsigned long val, void *data);
+
+#endif				/* _ASM_KPROBES_H */
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index 7a6ac50..714f3c1 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -83,6 +83,7 @@ obj-$(CONFIG_MIPS32_N32)	+= binfmt_elfn32.o scall64-n32.o signal_n32.o
 obj-$(CONFIG_MIPS32_O32)	+= binfmt_elfo32.o scall64-o32.o
 
 obj-$(CONFIG_KGDB)		+= kgdb.o
+obj-$(CONFIG_KPROBES)		+= kprobes.o
 obj-$(CONFIG_PROC_FS)		+= proc.o
 
 obj-$(CONFIG_64BIT)		+= cpu-bugs64.o
@@ -95,6 +96,7 @@ obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
 obj-$(CONFIG_SPINLOCK_TEST)	+= spinlock_test.o
 
+
 CFLAGS_cpu-bugs64.o	= $(shell if $(CC) $(KBUILD_CFLAGS) -Wa,-mdaddi -c -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-DHAVE_AS_SET_DADDI"; fi)
 
 obj-$(CONFIG_HAVE_STD_PC_SERIAL_PORT)	+= 8250-platform.o
diff --git a/arch/mips/kernel/kprobes.c b/arch/mips/kernel/kprobes.c
new file mode 100644
index 0000000..f4e7444
--- /dev/null
+++ b/arch/mips/kernel/kprobes.c
@@ -0,0 +1,379 @@
+/*
+ *  Kernel Probes (KProbes)
+ *  arch/mips/kernel/kprobes.c
+ *
+ *  Copyright 2006 Sony Corp.
+ *
+ *  Himanshu Chauhan <hschauhan@nulltrace.org> for >2.6.35 kernels.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; version 2 of the License.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <linux/semaphore.h>
+#include <linux/kdebug.h>
+#include <linux/kprobes.h>
+#include <linux/preempt.h>
+#include <asm/cacheflush.h>
+#include <asm/inst.h>
+#include <asm/ptrace.h>
+
+DECLARE_MUTEX(kprobe_mutex);
+DEFINE_PER_CPU(struct kprobe *, current_kprobe) = NULL;
+DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
+
+int __kprobes arch_prepare_kprobe(struct kprobe *p)
+{
+	union mips_instruction insn;
+	int ret = 0;
+
+	insn = *p->addr;
+
+	switch (insn.i_format.opcode) {
+		/*
+		 * This group contains:
+		 * jr and jalr are in r_format format.
+		 */
+	case spec_op:
+
+		/*
+		 * This group contains:
+		 * bltz_op, bgez_op, bltzl_op, bgezl_op,
+		 * bltzal_op, bgezal_op, bltzall_op, bgezall_op.
+		 */
+	case bcond_op:
+
+		/*
+		 * These are unconditional and in j_format.
+		 */
+	case jal_op:
+	case j_op:
+
+		/*
+		 * These are conditional and in i_format.
+		 */
+	case beq_op:
+	case beql_op:
+	case bne_op:
+	case bnel_op:
+	case blez_op:
+	case blezl_op:
+	case bgtz_op:
+	case bgtzl_op:
+		/*
+		 * These are the FPA/cp1 branch instructions.
+		 */
+	case cop1_op:
+		printk("Kprobes for branch and jump instructions "
+		       "is not supported\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* insn: must be on special executable page on MIPS. */
+	p->ainsn.insn = get_insn_slot();
+	if (!p->ainsn.insn) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	/*
+	 * In the kprobe->ainsn.insn[] array we store the original
+	 * instruction at index zero and a break instruction at
+	 * index one.
+	 */
+	memcpy(&p->ainsn.insn[0], p->addr, sizeof(kprobe_opcode_t));
+	p->ainsn.insn[1].word = MIPS_KPROBE_SSTP;
+	p->opcode = *p->addr;
+
+out:
+	return ret;
+}
+
+void __kprobes arch_arm_kprobe(struct kprobe *p)
+{
+	p->addr->word = MIPS_KPROBE_BP;
+	flush_icache_range((unsigned long)p->addr,
+			   (unsigned long)p->addr +
+			   (MAX_INSN_SIZE * sizeof(kprobe_opcode_t)));
+}
+
+void __kprobes arch_disarm_kprobe(struct kprobe *p)
+{
+	*p->addr = p->opcode;
+	flush_icache_range((unsigned long)p->addr,
+			   (unsigned long)p->addr +
+			   (MAX_INSN_SIZE * sizeof(kprobe_opcode_t)));
+}
+
+void __kprobes arch_remove_kprobe(struct kprobe *p)
+{
+	down(&kprobe_mutex);
+	free_insn_slot(p->ainsn.insn, 0);
+	up(&kprobe_mutex);
+}
+
+static inline void save_previous_kprobe(struct kprobe_ctlblk *kcb)
+{
+	kcb->prev_kprobe.kp = kprobe_running();
+	kcb->prev_kprobe.status = kcb->kprobe_status;
+	kcb->prev_kprobe.old_SR = kcb->kprobe_old_SR;
+	kcb->prev_kprobe.saved_SR = kcb->kprobe_saved_SR;
+	kcb->prev_kprobe.saved_epc = kcb->kprobe_saved_epc;
+}
+
+static inline void restore_previous_kprobe(struct kprobe_ctlblk *kcb)
+{
+	__get_cpu_var(current_kprobe) = kcb->prev_kprobe.kp;
+	kcb->kprobe_status = kcb->prev_kprobe.status;
+	kcb->kprobe_old_SR = kcb->prev_kprobe.old_SR;
+	kcb->kprobe_saved_SR = kcb->prev_kprobe.saved_SR;
+	kcb->kprobe_saved_epc = kcb->prev_kprobe.saved_epc;
+}
+
+static inline void set_current_kprobe(struct kprobe *p, struct pt_regs *regs,
+				      struct kprobe_ctlblk *kcb)
+{
+	__get_cpu_var(current_kprobe) = p;
+	kcb->kprobe_saved_SR = kcb->kprobe_old_SR = (regs->cp0_status & ST0_IE);
+	kcb->kprobe_saved_epc = regs->cp0_epc;
+}
+
+static inline void prepare_singlestep(struct kprobe *p, struct pt_regs *regs)
+{
+	regs->cp0_status &= ~ST0_IE;
+
+	/* single step inline if the instruction is an break 0 */
+	if ((MIPSInst_OPCODE(p->opcode.word) == MIPS_KPROBE_BP)
+	    || (MIPSInst_OPCODE(p->opcode.word) == MIPS_KPROBE_SSTP))
+		regs->cp0_epc = (unsigned long)p->addr;
+	else
+		regs->cp0_epc = (unsigned long)&p->ainsn.insn[0];
+}
+
+static int __kprobes kprobe_handler(struct pt_regs *regs)
+{
+	struct kprobe *p;
+	int ret = 0;
+	kprobe_opcode_t *addr = NULL;
+	struct kprobe_ctlblk *kcb;
+
+	addr = (kprobe_opcode_t *) regs->cp0_epc;
+
+	/*
+	 * We don't want to be preempted for the entire
+	 * duration of kprobe processing
+	 */
+	preempt_disable();
+	kcb = get_kprobe_ctlblk();
+
+	/* Check we're not actually recursing */
+	if (kprobe_running()) {
+		p = get_kprobe(addr);
+		if (p) {
+			if (kcb->kprobe_status == KPROBE_HIT_SS &&
+			    p->ainsn.insn->word == MIPS_KPROBE_BP) {
+				regs->cp0_status &= ~ST0_IE;
+				regs->cp0_status |= kcb->kprobe_saved_SR;
+				goto no_kprobe;
+			}
+			/* We have reentered the kprobe_handler(), since
+			 * another probe was hit while within the handler.
+			 * We here save the original kprobes variables and
+			 * just single step on the instruction of the new probe
+			 * without calling any user handlers.
+			 */
+			save_previous_kprobe(kcb);
+			set_current_kprobe(p, regs, kcb);
+			kprobes_inc_nmissed_count(p);
+			prepare_singlestep(p, regs);
+			kcb->kprobe_status = KPROBE_REENTER;
+			return 1;
+		} else {
+			if (addr->word != MIPS_KPROBE_BP) {
+				/* The breakpoint instruction was removed by
+				 * another cpu right after we hit, no further
+				 * handling of this interrupt is appropriate
+				 */
+				ret = 1;
+				goto no_kprobe;
+			}
+			p = __get_cpu_var(current_kprobe);
+			if (p->break_handler && p->break_handler(p, regs)) {
+				goto ss_probe;
+			}
+		}
+		goto no_kprobe;
+	}
+
+	p = get_kprobe(addr);
+	if (!p) {
+		if (addr->word != MIPS_KPROBE_BP) {
+			/*
+			 * The breakpoint instruction was removed right
+			 * after we hit it.  Another cpu has removed
+			 * either a probepoint or a debugger breakpoint
+			 * at this address.  In either case, no further
+			 * handling of this interrupt is appropriate.
+			 */
+			ret = 1;
+		}
+		/* Not one of ours: let kernel handle it */
+		goto no_kprobe;
+	}
+
+	set_current_kprobe(p, regs, kcb);
+	kcb->kprobe_status = KPROBE_HIT_ACTIVE;
+
+	if (p->pre_handler && p->pre_handler(p, regs))
+		/* handler has already set things up, so skip ss setup */
+		return 1;
+
+ss_probe:
+	prepare_singlestep(p, regs);
+	kcb->kprobe_status = KPROBE_HIT_SS;
+	return 1;
+
+no_kprobe:
+	preempt_enable_no_resched();
+	return ret;
+}
+
+/*
+ * Called after single-stepping.  p->addr is the address of the
+ * instruction whose first byte has been replaced by the "break 0"
+ * instruction.  To avoid the SMP problems that can occur when we
+ * temporarily put back the original opcode to single-step, we
+ * single-stepped a copy of the instruction.  The address of this
+ * copy is p->ainsn.insn.
+ *
+ * This function prepares to return from the post-single-step
+ * breakpoint trap.
+ */
+static void __kprobes resume_execution(struct kprobe *p,
+				       struct pt_regs *regs,
+				       struct kprobe_ctlblk *kcb)
+{
+	unsigned long orig_epc = kcb->kprobe_saved_epc;
+	regs->cp0_epc = orig_epc + 4;
+}
+
+static inline int post_kprobe_handler(struct pt_regs *regs)
+{
+	struct kprobe *cur = kprobe_running();
+	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
+
+	if (!cur)
+		return 0;
+
+	if ((kcb->kprobe_status != KPROBE_REENTER) && cur->post_handler) {
+		kcb->kprobe_status = KPROBE_HIT_SSDONE;
+		cur->post_handler(cur, regs, 0);
+	}
+
+	resume_execution(cur, regs, kcb);
+
+	regs->cp0_status |= kcb->kprobe_saved_SR;
+
+	/* Restore back the original saved kprobes variables and continue. */
+	if (kcb->kprobe_status == KPROBE_REENTER) {
+		restore_previous_kprobe(kcb);
+		goto out;
+	}
+	reset_current_kprobe();
+out:
+	preempt_enable_no_resched();
+
+	return 1;
+}
+
+static inline int kprobe_fault_handler(struct pt_regs *regs, int trapnr)
+{
+	struct kprobe *cur = kprobe_running();
+	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
+
+	if (cur->fault_handler && cur->fault_handler(cur, regs, trapnr))
+		return 1;
+
+	if (kcb->kprobe_status & KPROBE_HIT_SS) {
+		resume_execution(cur, regs, kcb);
+		regs->cp0_status |= kcb->kprobe_old_SR;
+
+		reset_current_kprobe();
+		preempt_enable_no_resched();
+	}
+	return 0;
+}
+
+/*
+ * Wrapper routine for handling exceptions.
+ */
+int __kprobes kprobe_exceptions_notify(struct notifier_block *self,
+				       unsigned long val, void *data)
+{
+	struct die_args *args = (struct die_args *)data;
+        struct pt_regs *regs = (struct pt_regs *)args->regs;
+	int ret = NOTIFY_DONE;
+	int trapnr = 0;
+
+	switch (val) {
+	case DIE_BREAK:
+                ret = kprobe_handler(regs);
+		if (ret)
+			ret = NOTIFY_STOP;
+		break;
+	case DIE_SSTEPBP:
+		if (post_kprobe_handler(args->regs))
+			ret = NOTIFY_STOP;
+		break;
+
+	case DIE_PAGE_FAULT:
+		/* kprobe_running() needs smp_processor_id() */
+		preempt_disable();
+
+		/*
+		 * trapnr is the architecture-specific trap
+		 * number associated with the fault while handling
+		 * the Kprobe (e.g. on mips, 9 for a break or 13 for
+		 * a trap).
+		 * current die_args structure does not have trapnr.
+		 */
+		if (kprobe_running()
+		    && kprobe_fault_handler(args->regs, trapnr))
+			ret = NOTIFY_STOP;
+		preempt_enable();
+		break;
+	default:
+		break;
+	}
+	return ret;
+}
+
+int __kprobes setjmp_pre_handler(struct kprobe *p, struct pt_regs *regs)
+{
+	return 0;
+}
+
+void __kprobes jprobe_return(void)
+{
+}
+
+int __kprobes longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
+{
+	return 0;
+}
+
+int __init arch_init_kprobes(void)
+{
+	return 0;
+}
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 8bdd6a6..0065606 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -10,6 +10,7 @@
  * Kevin D. Kissell, kevink@mips.com and Carsten Langgaard, carstenl@mips.com
  * Copyright (C) 2000, 01 MIPS Technologies, Inc.
  * Copyright (C) 2002, 2003, 2004, 2005, 2007  Maciej W. Rozycki
+ * Himanshu Chauhan <hschauhan@nulltrace.org> KProbes support for MIPS.
  */
 #include <linux/bug.h>
 #include <linux/compiler.h>
@@ -27,6 +28,7 @@
 #include <linux/kdebug.h>
 #include <linux/notifier.h>
 #include <linux/kdb.h>
+#include <linux/kprobes.h>
 
 #include <asm/bootinfo.h>
 #include <asm/branch.h>
@@ -334,7 +336,7 @@ void show_regs(struct pt_regs *regs)
 	__show_regs((struct pt_regs *)regs);
 }
 
-void show_registers(const struct pt_regs *regs)
+void show_registers(struct pt_regs *regs)
 {
 	const int field = 2 * sizeof(unsigned long);
 
@@ -706,6 +708,37 @@ asmlinkage void do_fpe(struct pt_regs *regs, unsigned long fcr31)
 	force_sig_info(SIGFPE, &info, current);
 }
 
+#ifdef CONFIG_KPROBES
+asmlinkage int __kprobes do_kprobes_break (struct pt_regs *regs,
+                                           unsigned int bcode)
+{
+	/* return 1 if unhandled */
+        int ret = 1;
+
+	/*
+	 * Notify the kprobe handlers, if instruction is kprobe
+         * breaks (515, 516).
+	 */
+	switch (bcode) {
+	case BRK_KPRB_BP:
+		if (notify_die(DIE_BREAK, "kprb_debug", regs, bcode,
+                               0, 0) == NOTIFY_STOP) {
+                        ret = 0;
+		}
+		break;
+
+	case BRK_KPRB_SSTP:
+		if (notify_die(DIE_SSTEPBP, "kprb_single_step",
+                               regs, bcode, 0, 0) == NOTIFY_STOP) {
+                        ret = 0;
+                }
+		break;
+	}
+
+        return ret;
+}
+#endif
+
 static void do_trap_or_bp(struct pt_regs *regs, unsigned int code,
 	const char *str)
 {
@@ -783,6 +816,17 @@ asmlinkage void do_bp(struct pt_regs *regs)
 	if (bcode >= (1 << 10))
 		bcode >>= 10;
 
+#ifdef CONFIG_KPROBES
+	/*
+	 * Let kprobes handle the break first. If it returns zero
+	 * it could handle the break. Otherwise, proceed by normal
+	 * course of action.
+	 */
+        if (!do_kprobes_break(regs, bcode)) {
+                return;
+        }
+#endif
+
 	do_trap_or_bp(regs, bcode, "Break");
 	return;
 
diff --git a/arch/mips/mm/fault.c b/arch/mips/mm/fault.c
index b78f7d9..86e2d27 100644
--- a/arch/mips/mm/fault.c
+++ b/arch/mips/mm/fault.c
@@ -18,6 +18,8 @@
 #include <linux/smp.h>
 #include <linux/vt_kern.h>		/* For unblank_screen() */
 #include <linux/module.h>
+#include <linux/kprobes.h>
+#include <linux/kdebug.h>		/* notify_die and asm/kdebug.h */
 
 #include <asm/branch.h>
 #include <asm/mmu_context.h>
@@ -31,8 +33,8 @@
  * and the problem, and then passes it off to one of the appropriate
  * routines.
  */
-asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long write,
-			      unsigned long address)
+asmlinkage void __kprobes do_page_fault(struct pt_regs *regs, unsigned long write,
+                                        unsigned long address)
 {
 	struct vm_area_struct * vma = NULL;
 	struct task_struct *tsk = current;
@@ -47,6 +49,11 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long write,
 	       field, regs->cp0_epc);
 #endif
 
+	/* Notify kprobes fault handler. */
+        if (notify_die(DIE_PAGE_FAULT, "page fault",
+                       regs, -1, SEGV_MAPERR, SEGV_MAPERR) == NOTIFY_STOP)
+                return;
+
 	info.si_code = SEGV_MAPERR;
 
 	/*
-- 
1.7.0.4
