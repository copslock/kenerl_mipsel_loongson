Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Sep 2005 23:11:37 +0100 (BST)
Received: from nevyn.them.org ([66.93.172.17]:34983 "EHLO nevyn.them.org")
	by ftp.linux-mips.org with ESMTP id S8133602AbVI1WLR (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 28 Sep 2005 23:11:17 +0100
Received: from drow by nevyn.them.org with local (Exim 4.52)
	id 1EKk8x-000624-FY; Wed, 28 Sep 2005 18:11:15 -0400
Date:	Wed, 28 Sep 2005 18:11:15 -0400
From:	Daniel Jacobowitz <dan@debian.org>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Revise MIPS64 ptrace interface
Message-ID: <20050928221115.GA22817@nevyn.them.org>
References: <20050922182601.GA10829@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050922182601.GA10829@nevyn.them.org>
User-Agent: Mutt/1.5.8i
Return-Path: <drow@nevyn.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9069
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

Change the N32 debugging ABI to something more sane, and add support
for o32 and n32 debuggers to trace n64 programs.

Signed-off-by: Daniel Jacobowitz <dan@codesourcery.com>
---

I've now tested everything except the actual _3264 operations, which
were copied from PPC anyway and I have reasonable faith in.  So here's
a final patch.  If this seems reasonable to everyone, I'd like for it
to be merged, and then I can submit the glibc and gdb bits.

The patch itself is below.  If you want to test it, at
http://return.false.org/~drow/mips/ you can find:

  gdb-2005-09-28-HEAD-MIPS64-DEBUG.tar.gz
  glibc-2005-09-28-HEAD-MIPS64-NPTL.tar.gz
  linux-2005-09-28-sentosa-n32-ptrace.tar.gz

These are patches against linux-mips.org HEAD, glibc HEAD, and gdb HEAD
(all last week) that allow n32 and n64 debugging.  For n64 debugging
you'll need to remove .debug_frame/.eh_frame first since I haven't
looked at those bits of GDB / GCC yet.

Index: linux/arch/mips/kernel/ptrace32.c
===================================================================
--- linux.orig/arch/mips/kernel/ptrace32.c	2005-09-21 14:48:02.000000000 -0400
+++ linux/arch/mips/kernel/ptrace32.c	2005-09-28 15:18:29.000000000 -0400
@@ -35,6 +35,12 @@
 #include <asm/uaccess.h>
 #include <asm/bootinfo.h>
 
+int ptrace_getregs (struct task_struct *child, __s64 __user *data);
+int ptrace_setregs (struct task_struct *child, __s64 __user *data);
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
 
+	case PTRACE_GETREGS:
+		ret = ptrace_getregs (child, (__u64 __user *) (__u64) data);
+		break;
+
+	case PTRACE_SETREGS:
+		ret = ptrace_setregs (child, (__u64 __user *) (__u64) data);
+		break;
+
+	case PTRACE_GETFPREGS:
+		ret = ptrace_getfpregs (child, (__u32 __user *) (__u64) data);
+		break;
+
+	case PTRACE_SETFPREGS:
+		ret = ptrace_setfpregs (child, (__u32 __user *) (__u64) data);
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
+++ linux/include/asm-mips/ptrace.h	2005-09-28 15:15:14.000000000 -0400
@@ -48,10 +48,10 @@ struct pt_regs {
 };
 
 /* Arbitrarily choose the same ptrace numbers as used by the Sparc code. */
-/* #define PTRACE_GETREGS		12 */
-/* #define PTRACE_SETREGS		13 */
-/* #define PTRACE_GETFPREGS		14 */
-/* #define PTRACE_SETFPREGS		15 */
+#define PTRACE_GETREGS		12
+#define PTRACE_SETREGS		13
+#define PTRACE_GETFPREGS		14
+#define PTRACE_SETFPREGS		15
 /* #define PTRACE_GETFPXREGS		18 */
 /* #define PTRACE_SETFPXREGS		19 */
 
@@ -60,6 +60,13 @@ struct pt_regs {
 #define PTRACE_GET_THREAD_AREA	25
 #define PTRACE_SET_THREAD_AREA	26
 
+/* Calls to trace a 64bit program from a 32bit program.  */
+#define PTRACE_PEEKTEXT_3264	0xc0
+#define PTRACE_PEEKDATA_3264	0xc1
+#define PTRACE_POKETEXT_3264	0xc2
+#define PTRACE_POKEDATA_3264	0xc3
+#define PTRACE_GET_THREAD_AREA_3264	0xc4
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
+++ linux/arch/mips/kernel/ptrace.c	2005-09-28 15:17:23.000000000 -0400
@@ -38,6 +38,7 @@
 #include <asm/system.h>
 #include <asm/uaccess.h>
 #include <asm/bootinfo.h>
+#include <asm/reg.h>
 
 /*
  * Called by kernel/ptrace.c when detaching..
@@ -49,6 +50,118 @@ void ptrace_disable(struct task_struct *
 	/* Nothing to do.. */
 }
 
+/*
+ * Read a general register set.  We always use the 64-bit format, even
+ * for 32-bit kernels and for 32-bit processes on a 64-bit kernel.
+ * Registers are sign extended to fill the available space.
+ */
+int ptrace_getregs (struct task_struct *child, __s64 __user *data)
+{
+	struct pt_regs *regs;
+	int i;
+
+	if (!access_ok(VERIFY_WRITE, data, 38 * 8))
+		return -EIO;
+
+	regs = (struct pt_regs *) ((unsigned long) child->thread_info +
+	       THREAD_SIZE - 32 - sizeof(struct pt_regs));
+
+	for (i = 0; i < 32; i++)
+		__put_user (regs->regs[i], data + i);
+	__put_user (regs->lo, data + EF_LO - EF_R0);
+	__put_user (regs->hi, data + EF_HI - EF_R0);
+	__put_user (regs->cp0_epc, data + EF_CP0_EPC - EF_R0);
+	__put_user (regs->cp0_badvaddr, data + EF_CP0_BADVADDR - EF_R0);
+	__put_user (regs->cp0_status, data + EF_CP0_STATUS - EF_R0);
+	__put_user (regs->cp0_cause, data + EF_CP0_CAUSE - EF_R0);
+
+	return 0;
+}
+
+/*
+ * Write a general register set.  As for PTRACE_GETREGS, we always use
+ * the 64-bit format.  On a 32-bit kernel only the lower order half
+ * (according to endianness) will be used.
+ */
+int ptrace_setregs (struct task_struct *child, __s64 __user *data)
+{
+	struct pt_regs *regs;
+	int i;
+
+	if (!access_ok(VERIFY_READ, data, 38 * 8))
+		return -EIO;
+
+	regs = (struct pt_regs *) ((unsigned long) child->thread_info +
+	       THREAD_SIZE - 32 - sizeof(struct pt_regs));
+
+	for (i = 0; i < 32; i++)
+		__get_user (regs->regs[i], data + i);
+	__get_user (regs->lo, data + EF_LO - EF_R0);
+	__get_user (regs->hi, data + EF_HI - EF_R0);
+	__get_user (regs->cp0_epc, data + EF_CP0_EPC - EF_R0);
+
+	/* badvaddr, status, and cause may not be written.  */
+
+	return 0;
+}
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
@@ -300,6 +413,22 @@ asmlinkage int sys_ptrace(long request, 
 		break;
 		}
 
+	case PTRACE_GETREGS:
+		ret = ptrace_getregs (child, (__u64 __user *) data);
+		break;
+
+	case PTRACE_SETREGS:
+		ret = ptrace_setregs (child, (__u64 __user *) data);
+		break;
+
+	case PTRACE_GETFPREGS:
+		ret = ptrace_getfpregs (child, (__u32 __user *) data);
+		break;
+
+	case PTRACE_SETFPREGS:
+		ret = ptrace_setfpregs (child, (__u32 __user *) data);
+		break;
+
 	case PTRACE_SYSCALL: /* continue and stop at next (return from) syscall */
 	case PTRACE_CONT: { /* restart after signal. */
 		ret = -EIO;

-- 
Daniel Jacobowitz
CodeSourcery, LLC
