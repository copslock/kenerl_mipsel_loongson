Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Feb 2005 02:26:19 +0000 (GMT)
Received: from nevyn.them.org ([IPv6:::ffff:66.93.172.17]:55760 "EHLO
	nevyn.them.org") by linux-mips.org with ESMTP id <S8225229AbVBNC0C>;
	Mon, 14 Feb 2005 02:26:02 +0000
Received: from drow by nevyn.them.org with local (Exim 4.44 #1 (Debian))
	id 1D0Vw1-0006nJ-IN
	for <linux-mips@linux-mips.org>; Sun, 13 Feb 2005 21:26:01 -0500
Date:	Sun, 13 Feb 2005 21:26:01 -0500
From:	Daniel Jacobowitz <dan@debian.org>
To:	linux-mips@linux-mips.org
Subject: Re: Fix o32 core dumps on 64-bit kernel
Message-ID: <20050214022601.GB25335@nevyn.them.org>
References: <20050121010133.GA10319@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050121010133.GA10319@nevyn.them.org>
User-Agent: Mutt/1.5.6+20040907i
Return-Path: <drow@nevyn.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7245
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

The core dump code in binfmt_elfo32.c has bitrotted.  It no longer worked
after elfcore.h started using inline functions - not sure when that was.
With this, I have both single-threaded and multi-threaded core dumps
working.  I'm not sure about the FP bits, if a task is currently using
hardware FP, but I just copied the existing brokenness from dump_fpu.
Better than nothing.

This patch also adds "$0" (saved syscall number), $k0, and $k1 back to the
coredump.  Don't worry, GDB knows that this isn't the real $0 value.

Updated for current 2.6 CVS.

Signed-off-by: Daniel Jacobowitz <dan@codesourcery.com>

Index: linux/arch/mips/kernel/binfmt_elfo32.c
===================================================================
--- linux.orig/arch/mips/kernel/binfmt_elfo32.c	2005-02-02 09:16:20.000000000 -0500
+++ linux/arch/mips/kernel/binfmt_elfo32.c	2005-02-13 21:03:23.068817064 -0500
@@ -54,43 +54,9 @@ typedef elf_fpreg_t elf_fpregset_t[ELF_N
 
 #include <asm/processor.h>
 #include <linux/module.h>
-#include <linux/elfcore.h>
 #include <linux/compat.h>
-
-#define elf_prstatus elf_prstatus32
-struct elf_prstatus32
-{
-	struct elf_siginfo pr_info;	/* Info associated with signal */
-	short	pr_cursig;		/* Current signal */
-	unsigned int pr_sigpend;	/* Set of pending signals */
-	unsigned int pr_sighold;	/* Set of held signals */
-	pid_t	pr_pid;
-	pid_t	pr_ppid;
-	pid_t	pr_pgrp;
-	pid_t	pr_sid;
-	struct compat_timeval pr_utime;	/* User time */
-	struct compat_timeval pr_stime;	/* System time */
-	struct compat_timeval pr_cutime;/* Cumulative user time */
-	struct compat_timeval pr_cstime;/* Cumulative system time */
-	elf_gregset_t pr_reg;	/* GP registers */
-	int pr_fpvalid;		/* True if math co-processor being used.  */
-};
-
-#define elf_prpsinfo elf_prpsinfo32
-struct elf_prpsinfo32
-{
-	char	pr_state;	/* numeric process state */
-	char	pr_sname;	/* char for pr_state */
-	char	pr_zomb;	/* zombie */
-	char	pr_nice;	/* nice val */
-	unsigned int pr_flag;	/* flags */
-	__kernel_uid_t	pr_uid;
-	__kernel_gid_t	pr_gid;
-	pid_t	pr_pid, pr_ppid, pr_pgrp, pr_sid;
-	/* Lots missing */
-	char	pr_fname[16];	/* filename of executable */
-	char	pr_psargs[ELF_PRARGSZ];	/* initial part of arg list */
-};
+#include <asm/ptrace.h>
+#include <asm/reg.h>
 
 #define elf_addr_t	u32
 #define elf_caddr_t	u32
@@ -109,20 +75,19 @@ jiffies_to_compat_timeval(unsigned long 
 	value->tv_usec /= NSEC_PER_USEC;
 }
 
+/* These need to be here, before the incluson of elfcore.h.  */
+
 #undef ELF_CORE_COPY_REGS
 #define ELF_CORE_COPY_REGS(_dest,_regs) elf32_core_copy_regs(_dest,_regs);
 
-void elf32_core_copy_regs(elf_gregset_t grp, struct pt_regs *regs)
+static void elf32_core_copy_regs(elf_gregset_t grp, struct pt_regs *regs)
 {
 	int i;
 
 	for (i = 0; i < EF_R0; i++)
 		grp[i] = 0;
-	grp[EF_R0] = 0;
-	for (i = 1; i <= 31; i++)
+	for (i = 0; i <= 31; i++)
 		grp[EF_R0 + i] = (elf_greg_t) regs->regs[i];
-	grp[EF_R26] = 0;
-	grp[EF_R27] = 0;
 	grp[EF_LO] = (elf_greg_t) regs->lo;
 	grp[EF_HI] = (elf_greg_t) regs->hi;
 	grp[EF_CP0_EPC] = (elf_greg_t) regs->cp0_epc;
@@ -134,6 +99,65 @@ void elf32_core_copy_regs(elf_gregset_t 
 #endif
 }
 
+#undef ELF_CORE_COPY_TASK_REGS
+#define ELF_CORE_COPY_TASK_REGS(_task,_dest) elf32_core_copy_task_regs(_task, *(_dest))
+
+static int elf32_core_copy_task_regs(struct task_struct *_task, elf_gregset_t _dest)
+{
+	struct pt_regs *_regs;
+	_regs = (struct pt_regs *) ((unsigned long) _task->thread_info
+				    + THREAD_SIZE - 32 - sizeof (struct pt_regs));
+	elf32_core_copy_regs (_dest, _regs);
+	return 1;
+}
+
+#undef ELF_CORE_COPY_FPREGS
+#define ELF_CORE_COPY_FPREGS(tsk, elf_fpregs) elf32_dump_task_fpu(tsk, elf_fpregs)
+
+static int elf32_dump_task_fpu(struct task_struct *tsk, elf_fpregset_t *fpu)
+{
+	/* FIXME: Is this right?  */
+	memcpy(fpu, &tsk->thread.fpu, sizeof(tsk->thread.fpu));
+	return 1;
+}
+
+#include <linux/elfcore.h>
+
+#define elf_prstatus elf_prstatus32
+struct elf_prstatus32
+{
+	struct elf_siginfo pr_info;	/* Info associated with signal */
+	short	pr_cursig;		/* Current signal */
+	unsigned int pr_sigpend;	/* Set of pending signals */
+	unsigned int pr_sighold;	/* Set of held signals */
+	pid_t	pr_pid;
+	pid_t	pr_ppid;
+	pid_t	pr_pgrp;
+	pid_t	pr_sid;
+	struct compat_timeval pr_utime;	/* User time */
+	struct compat_timeval pr_stime;	/* System time */
+	struct compat_timeval pr_cutime;/* Cumulative user time */
+	struct compat_timeval pr_cstime;/* Cumulative system time */
+	elf_gregset_t pr_reg;	/* GP registers */
+	int pr_fpvalid;		/* True if math co-processor being used.  */
+};
+
+#define elf_prpsinfo elf_prpsinfo32
+struct elf_prpsinfo32
+{
+	char	pr_state;	/* numeric process state */
+	char	pr_sname;	/* char for pr_state */
+	char	pr_zomb;	/* zombie */
+	char	pr_nice;	/* nice val */
+	unsigned int pr_flag;	/* flags */
+	__kernel_uid_t	pr_uid;
+	__kernel_gid_t	pr_gid;
+	pid_t	pr_pid, pr_ppid, pr_pgrp, pr_sid;
+	/* Lots missing */
+	char	pr_fname[16];	/* filename of executable */
+	char	pr_psargs[ELF_PRARGSZ];	/* initial part of arg list */
+};
+
 MODULE_DESCRIPTION("Binary format loader for compatibility with o32 Linux/MIPS binaries");
 MODULE_AUTHOR("Ralf Baechle (ralf@linux-mips.org)");
 
Index: linux/arch/mips/kernel/process.c
===================================================================
--- linux.orig/arch/mips/kernel/process.c	2005-02-13 20:55:57.665590299 -0500
+++ linux/arch/mips/kernel/process.c	2005-02-13 21:18:26.230390943 -0500
@@ -163,11 +163,8 @@ void dump_regs(elf_greg_t *gp, struct pt
 
 	for (i = 0; i < EF_R0; i++)
 		gp[i] = 0;
-	gp[EF_R0] = 0;
-	for (i = 1; i <= 31; i++)
+	for (i = 0; i <= 31; i++)
 		gp[EF_R0 + i] = regs->regs[i];
-	gp[EF_R26] = 0;
-	gp[EF_R27] = 0;
 	gp[EF_LO] = regs->lo;
 	gp[EF_HI] = regs->hi;
 	gp[EF_CP0_EPC] = regs->cp0_epc;


-- 
Daniel Jacobowitz
CodeSourcery, LLC
