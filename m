Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Jan 2005 01:01:41 +0000 (GMT)
Received: from nevyn.them.org ([IPv6:::ffff:66.93.172.17]:14218 "EHLO
	nevyn.them.org") by linux-mips.org with ESMTP id <S8225305AbVAUBBf>;
	Fri, 21 Jan 2005 01:01:35 +0000
Received: from drow by nevyn.them.org with local (Exim 4.43 #1 (Debian))
	id 1CrnB7-0002h8-Su
	for <linux-mips@linux-mips.org>; Thu, 20 Jan 2005 20:01:34 -0500
Date:	Thu, 20 Jan 2005 20:01:33 -0500
From:	Daniel Jacobowitz <dan@debian.org>
To:	linux-mips@linux-mips.org
Subject: Fix o32 core dumps on 64-bit kernel
Message-ID: <20050121010133.GA10319@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Return-Path: <drow@nevyn.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6974
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

Signed-off-by: Daniel Jacobowitz <dan@codesourcery.com>

Index: linux/arch/mips/kernel/binfmt_elfo32.c
===================================================================
--- linux.orig/arch/mips/kernel/binfmt_elfo32.c	2005-01-20 18:43:06.979702056 -0500
+++ linux/arch/mips/kernel/binfmt_elfo32.c	2005-01-20 19:51:07.238552283 -0500
@@ -55,43 +55,10 @@
 #include <asm/processor.h>
 #include <linux/module.h>
 #include <linux/config.h>
-#include <linux/elfcore.h>
 #include <linux/compat.h>
 
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
+#include <asm/ptrace.h>
 
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
 
 #define elf_addr_t	u32
 #define elf_caddr_t	u32
@@ -110,10 +77,12 @@
 	value->tv_usec /= NSEC_PER_USEC;
 }
 
+/* These need to be here, before the incluson of elfcore.h.  */
+
 #undef ELF_CORE_COPY_REGS
 #define ELF_CORE_COPY_REGS(_dest,_regs) elf32_core_copy_regs(_dest,_regs);
 
-void elf32_core_copy_regs(elf_gregset_t _dest, struct pt_regs *_regs)
+static void elf32_core_copy_regs(elf_gregset_t _dest, struct pt_regs *_regs)
 {
 	int i;
 
@@ -130,6 +99,65 @@
 	_dest[i++] = (elf_greg_t) _regs->cp0_cause;
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
 


-- 
Daniel Jacobowitz
