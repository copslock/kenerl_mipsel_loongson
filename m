Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Sep 2005 19:26:32 +0100 (BST)
Received: from nevyn.them.org ([66.93.172.17]:26603 "EHLO nevyn.them.org")
	by ftp.linux-mips.org with ESMTP id S8133361AbVIVS0G (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 22 Sep 2005 19:26:06 +0100
Received: from drow by nevyn.them.org with local (Exim 4.52)
	id 1EIVlh-0002rC-9X; Thu, 22 Sep 2005 14:26:01 -0400
Date:	Thu, 22 Sep 2005 14:26:01 -0400
From:	Daniel Jacobowitz <dan@debian.org>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: RFC: Revise n32 ptrace interface
Message-ID: <20050922182601.GA10829@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Return-Path: <drow@nevyn.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9024
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

Currently n32 uses the n64 ptrace interface.  This means that it expects
both of its arguments to be "long long" rather than "long", PTRACE_PEEKTEXT
transfers eight bytes, et cetera.  All of which has combined to cause no end
of trouble for GDB.

Here's an alternative interface that I've just started testing.  n32 uses
the o32 ptrace interface instead, which transfers 32-bit quantities, as we'd
expect from a system with 32-bit longs.  There are only a couple of catches:

1.  We need to get at the 64-bit registers.  I considered a number of
different approaches for this and decided to just implement a 64-bit
PTRACE_GETREGS instead of messing with PTRACE_PEEKUSR.  It's much simpler
this way.  I didn't add one for the DSP registers; that can be handled
separately when someone's working on debug support for them...

2.  While I'm fixing this interface, an n32 program ought to be able to
debug an n64 program.  This copies the clever trick that ppc64 uses,
i.e. passing the 64-bit address via reference.  Less efficient but hugely
simpler.

3.  PTRACE_{GET,SET}SIGINFO.  I didn't even go there.  N32 kernel and glibc
don't even agree about the layout of struct siginfo at the moment.  This
should be investigated, but it's a problem for another day.

Any thoughts on the ABI change?  Just for N32 of course; for o32/n64 this
strictly adds new mechanisms.

NOTE: this patch is just for comments, I don't want it to go in as is. There
ought to be a 32-bit GETREGS while I'm here, and I haven't written GDB
support for the _3264 operations yet, so I haven't tested it much.  I'll be
back to work on this some more in a couple of days.

Index: linux/arch/mips/kernel/ptrace32.c
===================================================================
--- linux.orig/arch/mips/kernel/ptrace32.c	2005-09-21 14:48:02.000000000 -0400
+++ linux/arch/mips/kernel/ptrace32.c	2005-09-22 14:14:06.000000000 -0400
@@ -35,6 +35,12 @@
 #include <asm/uaccess.h>
 #include <asm/bootinfo.h>
 
+int ptrace_getregs64 (struct task_struct *child, __u64 __user *data);
+int ptrace_setregs64 (struct task_struct *child, __u64 __user *data);
+
+int ptrace_getfpregs (struct task_struct *child, __u32 __user *data);
+int ptrace_setfpregs (struct task_struct *child, __u32 __user *data);
+
 /*
  * Tracing a 32-bit process with a 64-bit strace and vice versa will not
  * work.  I don't know how to fix this.
@@ -99,6 +105,35 @@ asmlinkage int sys32_ptrace(int request,
 		break;
 	}
 
+	/*
+	 * Read 4 bytes of the other process' storage
+	 *  data is a pointer specifying where the user wants the
+	 *	4 bytes copied into
+	 *  addr is a pointer in the user's storage that contains an 8 byte
+	 *	address in the other process of the 4 bytes that is to be read
+	 * (this is run in a 32-bit process looking at a 64-bit process)
+	 * when I and D space are separate, these will need to be fixed.
+	 */
+	case PTRACE_PEEKTEXT_3264:
+	case PTRACE_PEEKDATA_3264: {
+		u32 tmp;
+		int copied;
+		u32 __user * addrOthers;
+
+		ret = -EIO;
+
+		/* Get the addr in the other process that we want to read */
+		if (get_user(addrOthers, (u32 __user * __user *) (unsigned long) addr) != 0)
+			break;
+
+		copied = access_process_vm(child, (u64)addrOthers, &tmp,
+				sizeof(tmp), 0);
+		if (copied != sizeof(tmp))
+			break;
+		ret = put_user(tmp, (u32 __user *) (unsigned long) data);
+		break;
+	}
+
 	/* Read the word at location addr in the USER area. */
 	case PTRACE_PEEKUSR: {
 		struct pt_regs *regs;
@@ -202,6 +237,31 @@ asmlinkage int sys32_ptrace(int request,
 		ret = -EIO;
 		break;
 
+	/*
+	 * Write 4 bytes into the other process' storage
+	 *  data is the 4 bytes that the user wants written
+	 *  addr is a pointer in the user's storage that contains an
+	 *	8 byte address in the other process where the 4 bytes
+	 *	that is to be written
+	 * (this is run in a 32-bit process looking at a 64-bit process)
+	 * when I and D space are separate, these will need to be fixed.
+	 */
+	case PTRACE_POKETEXT_3264:
+	case PTRACE_POKEDATA_3264: {
+		u32 __user * addrOthers;
+
+		/* Get the addr in the other process that we want to write into */
+		ret = -EIO;
+		if (get_user(addrOthers, (u32 __user * __user *) (unsigned long) addr) != 0)
+			break;
+		ret = 0;
+		if (access_process_vm(child, (u64)addrOthers, &data,
+					sizeof(data), 1) == sizeof(data))
+			break;
+		ret = -EIO;
+		break;
+	}
+
 	case PTRACE_POKEUSR: {
 		struct pt_regs *regs;
 		ret = 0;
@@ -276,6 +336,22 @@ asmlinkage int sys32_ptrace(int request,
 		break;
 		}
 
+	case PTRACE_GETFPREGS:
+		ret = ptrace_getfpregs (child, (__u32 __user *) (__u64) data);
+		break;
+
+	case PTRACE_SETFPREGS:
+		ret = ptrace_setfpregs (child, (__u32 __user *) (__u64) data);
+		break;
+
+	case PTRACE_GETREGS64:
+		ret = ptrace_getregs64 (child, (__u64 __user *) (__u64) data);
+		break;
+
+	case PTRACE_SETREGS64:
+		ret = ptrace_setregs64 (child, (__u64 __user *) (__u64) data);
+		break;
+
 	case PTRACE_SYSCALL: /* continue and stop at next (return from) syscall */
 	case PTRACE_CONT: { /* restart after signal. */
 		ret = -EIO;
@@ -320,6 +396,11 @@ asmlinkage int sys32_ptrace(int request,
 			       (unsigned int __user *) (unsigned long) data);
 		break;
 
+	case PTRACE_GET_THREAD_AREA_3264:
+		ret = put_user(child->thread_info->tp_value,
+				(unsigned long __user *) (unsigned long) data);
+		break;
+
 	default:
 		ret = ptrace_request(child, request, addr, data);
 		break;
Index: linux/include/asm-mips/ptrace.h
===================================================================
--- linux.orig/include/asm-mips/ptrace.h	2005-09-21 14:48:02.000000000 -0400
+++ linux/include/asm-mips/ptrace.h	2005-09-22 13:03:20.000000000 -0400
@@ -50,8 +50,8 @@ struct pt_regs {
 /* Arbitrarily choose the same ptrace numbers as used by the Sparc code. */
 /* #define PTRACE_GETREGS		12 */
 /* #define PTRACE_SETREGS		13 */
-/* #define PTRACE_GETFPREGS		14 */
-/* #define PTRACE_SETFPREGS		15 */
+#define PTRACE_GETFPREGS		14
+#define PTRACE_SETFPREGS		15
 /* #define PTRACE_GETFPXREGS		18 */
 /* #define PTRACE_SETFPXREGS		19 */
 
@@ -60,6 +60,17 @@ struct pt_regs {
 #define PTRACE_GET_THREAD_AREA	25
 #define PTRACE_SET_THREAD_AREA	26
 
+/* Calls to trace a 64bit program from a 32bit program.  */
+#define PTRACE_PEEKTEXT_3264	0xc0
+#define PTRACE_PEEKDATA_3264	0xc1
+#define PTRACE_POKETEXT_3264	0xc2
+#define PTRACE_POKEDATA_3264	0xc3
+#define PTRACE_GET_THREAD_AREA_3264	0xc4
+
+/* Calls to fetch 64bit registers from an o32 or n32 program.  */
+#define PTRACE_GETREGS64	0xd0
+#define PTRACE_SETREGS64	0xd1
+
 #ifdef __KERNEL__
 
 #include <linux/linkage.h>
Index: linux/arch/mips/kernel/scall64-n32.S
===================================================================
--- linux.orig/arch/mips/kernel/scall64-n32.S	2005-09-21 09:34:45.000000000 -0400
+++ linux/arch/mips/kernel/scall64-n32.S	2005-09-22 14:04:19.000000000 -0400
@@ -216,7 +216,7 @@ EXPORT(sysn32_call_table)
 	PTR	compat_sys_getrusage
 	PTR	sys32_sysinfo
 	PTR	compat_sys_times
-	PTR	sys_ptrace
+	PTR	sys32_ptrace
 	PTR	sys_getuid			/* 6100 */
 	PTR	sys_syslog
 	PTR	sys_getgid
Index: linux/arch/mips/kernel/ptrace.c
===================================================================
--- linux.orig/arch/mips/kernel/ptrace.c	2005-09-22 14:11:07.000000000 -0400
+++ linux/arch/mips/kernel/ptrace.c	2005-09-22 14:11:12.000000000 -0400
@@ -38,6 +38,7 @@
 #include <asm/system.h>
 #include <asm/uaccess.h>
 #include <asm/bootinfo.h>
+#include <asm/reg.h>
 
 /*
  * Called by kernel/ptrace.c when detaching..
@@ -49,6 +50,110 @@ void ptrace_disable(struct task_struct *
 	/* Nothing to do.. */
 }
 
+#ifdef CONFIG_64BIT
+int ptrace_getregs64 (struct task_struct *child, __u64 __user *data)
+{
+	struct pt_regs *regs;
+	int i;
+
+	if (!access_ok(VERIFY_WRITE, data, EF_SIZE))
+		return -EIO;
+
+	regs = (struct pt_regs *) ((unsigned long) child->thread_info +
+	       THREAD_SIZE - 32 - sizeof(struct pt_regs));
+
+	for (i = 0; i < 32; i++)
+		__put_user (regs->regs[i], data + EF_R0 + i);
+	__put_user (regs->lo, data + EF_LO);
+	__put_user (regs->hi, data + EF_HI);
+	__put_user (regs->cp0_epc, data + EF_CP0_EPC);
+	__put_user (regs->cp0_badvaddr, data + EF_CP0_BADVADDR);
+	__put_user (regs->cp0_status, data + EF_CP0_STATUS);
+	__put_user (regs->cp0_cause, data + EF_CP0_CAUSE);
+
+	return 0;
+}
+
+int ptrace_setregs64 (struct task_struct *child, __u64 __user *data)
+{
+	struct pt_regs *regs;
+	int i;
+
+	if (!access_ok(VERIFY_READ, data, EF_SIZE))
+		return -EIO;
+
+	regs = (struct pt_regs *) ((unsigned long) child->thread_info +
+	       THREAD_SIZE - 32 - sizeof(struct pt_regs));
+
+	for (i = 0; i < 32; i++)
+		__get_user (regs->regs[i], data + EF_R0 + i);
+	__get_user (regs->lo, data + EF_LO);
+	__get_user (regs->hi, data + EF_HI);
+	__get_user (regs->cp0_epc, data + EF_CP0_EPC);
+
+	/* badvaddr, status, and cause may not be written.  */
+
+	return 0;
+}
+#endif
+
+int ptrace_getfpregs (struct task_struct *child, __u32 __user *data)
+{
+	int i;
+
+	if (!access_ok(VERIFY_WRITE, data, 33 * 8))
+		return -EIO;
+
+	if (tsk_used_math(child)) {
+		fpureg_t *fregs = get_fpu_regs(child);
+		for (i = 0; i < 32; i++)
+			__put_user (fregs[i], i + (__u64 __user *) data);
+	} else {
+		for (i = 0; i < 32; i++)
+			__put_user ((__u64) -1, i + (__u64 __user *) data);
+	}
+
+	if (cpu_has_fpu) {
+		unsigned int flags, tmp;
+
+		__put_user (child->thread.fpu.hard.fcr31, data + 64);
+
+		flags = read_c0_status();
+		__enable_fpu();
+		__asm__ __volatile__("cfc1\t%0,$0" : "=r" (tmp));
+		write_c0_status(flags);
+		__put_user (tmp, data + 65);
+	} else {
+		__put_user (child->thread.fpu.soft.fcr31, data + 64);
+		__put_user ((__u32) 0, data + 65);
+	}
+
+	return 0;
+}
+
+int ptrace_setfpregs (struct task_struct *child, __u32 __user *data)
+{
+	fpureg_t *fregs;
+	int i;
+
+	if (!access_ok(VERIFY_READ, data, 33 * 8))
+		return -EIO;
+
+	fregs = get_fpu_regs(child);
+
+	for (i = 0; i < 32; i++)
+		__get_user (fregs[i], i + (__u64 __user *) data);
+
+	if (cpu_has_fpu)
+		__get_user (child->thread.fpu.hard.fcr31, data + 64);
+	else
+		__get_user (child->thread.fpu.soft.fcr31, data + 64);
+
+	/* FIR may not be written.  */
+
+	return 0;
+}
+
 asmlinkage int sys_ptrace(long request, long pid, long addr, long data)
 {
 	struct task_struct *child;
@@ -300,6 +405,24 @@ asmlinkage int sys_ptrace(long request, 
 		break;
 		}
 
+	case PTRACE_GETFPREGS:
+		ret = ptrace_getfpregs (child, (__u32 __user *) data);
+		break;
+
+	case PTRACE_SETFPREGS:
+		ret = ptrace_setfpregs (child, (__u32 __user *) data);
+		break;
+
+#ifdef CONFIG_64BIT
+	case PTRACE_GETREGS64:
+		ret = ptrace_getregs64 (child, (__u64 __user *) data);
+		break;
+
+	case PTRACE_SETREGS64:
+		ret = ptrace_setregs64 (child, (__u64 __user *) data);
+		break;
+#endif
+
 	case PTRACE_SYSCALL: /* continue and stop at next (return from) syscall */
 	case PTRACE_CONT: { /* restart after signal. */
 		ret = -EIO;

-- 
Daniel Jacobowitz
CodeSourcery, LLC
