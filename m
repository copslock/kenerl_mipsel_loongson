Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Mar 2005 14:12:26 +0000 (GMT)
Received: from nevyn.them.org ([IPv6:::ffff:66.93.172.17]:51370 "EHLO
	nevyn.them.org") by linux-mips.org with ESMTP id <S8225275AbVCPOMF>;
	Wed, 16 Mar 2005 14:12:05 +0000
Received: from drow by nevyn.them.org with local (Exim 4.44 #1 (Debian))
	id 1DBZFY-00067n-AV; Wed, 16 Mar 2005 09:11:52 -0500
Date:	Wed, 16 Mar 2005 09:11:52 -0500
From:	Daniel Jacobowitz <dan@debian.org>
To:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: NPTL support for the kernel
Message-ID: <20050316141151.GA23225@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Return-Path: <drow@nevyn.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7445
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

Here's a kernel patch to enable NPTL support.  This doesn't include Maciej's
uber-fast rdhwr emulation; I believe we ought to include both the fast and
slow paths, since the slow path will handle use of other destination
registers.  Changes:

  - Clone takes five arguments, not four.  Um, this bit is gross.
  - New syscall sys_set_thread_area.  Only glibc uses this.
  - Emulation of the rdhwr instruction.  This version is only loosely
    based on the emulation on the malta branch; the major difference
    is that I fixed ll/sc/rdhwr emulation in branch delay slots.
    GCC 4.1 will generate rdhwr in branch delay slots in some
    conditions.
  - PTRACE_GET_THREAD_AREA support for GDB.

How's it look?  I've just finished hopefully final tests for the
glibc bits, and will post them once this patch is resolved.

[Credit goes to Manish Lachwani at MontaVista for writing the
first draft of this patch, though he won't recognize most of this
copy :-)]


Index: linux/arch/mips/kernel/syscall.c
===================================================================
--- linux.orig/arch/mips/kernel/syscall.c	2005-03-15 10:09:23.000000000 -0500
+++ linux/arch/mips/kernel/syscall.c	2005-03-15 10:30:09.000000000 -0500
@@ -176,14 +176,28 @@ _sys_clone(nabi_no_regargs struct pt_reg
 {
 	unsigned long clone_flags;
 	unsigned long newsp;
-	int *parent_tidptr, *child_tidptr;
+	int __user *parent_tidptr, *child_tidptr;
 
 	clone_flags = regs.regs[4];
 	newsp = regs.regs[5];
 	if (!newsp)
 		newsp = regs.regs[29];
-	parent_tidptr = (int *) regs.regs[6];
-	child_tidptr = (int *) regs.regs[7];
+	parent_tidptr = (int __user *) regs.regs[6];
+#ifdef CONFIG_MIPS32
+	/* We need to fetch the fifth argument off the stack.  */
+	child_tidptr = NULL;
+	if (clone_flags & (CLONE_CHILD_SETTID | CLONE_CHILD_CLEARTID)) {
+		int __user *__user *usp = (int __user *__user *) regs.regs[29];
+		if (regs.regs[2] == __NR_syscall) {
+			if (get_user (child_tidptr, &usp[5]))
+				return -EFAULT;
+		}
+		else if (get_user (child_tidptr, &usp[4]))
+			return -EFAULT;
+	}
+#else
+	child_tidptr = (int __user *) regs.regs[8];
+#endif
 	return do_fork(clone_flags, newsp, &regs, 0,
 	               parent_tidptr, child_tidptr);
 }
@@ -245,6 +259,16 @@ asmlinkage int sys_olduname(struct oldol
 	return error;
 }
 
+void sys_set_thread_area(unsigned long addr)
+{
+	struct thread_info *ti = current->thread_info;
+
+	ti->tp_value = addr;
+
+	/* If some future MIPS implementation has this register in hardware,
+	 * we will need to update it here (and in context switches).  */
+}
+
 asmlinkage int _sys_sysmips(int cmd, long arg1, int arg2, int arg3)
 {
 	int	tmp, len;
Index: linux/arch/mips/kernel/traps.c
===================================================================
--- linux.orig/arch/mips/kernel/traps.c	2005-03-15 10:09:23.000000000 -0500
+++ linux/arch/mips/kernel/traps.c	2005-03-15 10:33:48.000000000 -0500
@@ -360,6 +360,10 @@ static inline int get_insn_opcode(struct
 #define OFFSET 0x0000ffff
 #define LL     0xc0000000
 #define SC     0xe0000000
+#define SPEC3  0x7c000000
+#define RD     0x0000f800
+#define FUNC   0x0000003f
+#define RDHWR  0x0000003b
 
 /*
  * The ll_bit is cleared by r*_switch.S
@@ -408,9 +412,10 @@ static inline void simulate_ll(struct pt
 
 	preempt_enable();
 
+	compute_return_epc(regs);
+
 	regs->regs[(opcode & RT) >> 16] = value;
 
-	compute_return_epc(regs);
 	return;
 
 sig:
@@ -446,9 +451,9 @@ static inline void simulate_sc(struct pt
 	preempt_disable();
 
 	if (ll_bit == 0 || ll_task != current) {
-		regs->regs[reg] = 0;
 		preempt_enable();
 		compute_return_epc(regs);
+		regs->regs[reg] = 0;
 		return;
 	}
 
@@ -459,9 +464,8 @@ static inline void simulate_sc(struct pt
 		goto sig;
 	}
 
-	regs->regs[reg] = 1;
-
 	compute_return_epc(regs);
+	regs->regs[reg] = 1;
 	return;
 
 sig:
@@ -494,6 +498,37 @@ static inline int simulate_llsc(struct p
 	return -EFAULT;			/* Strange things going on ... */
 }
 
+/*
+ * Simulate trapping 'rdhwr' instructions to provide user accessible
+ * registers not implemented in hardware.  The only current use of this
+ * is the thread area pointer.
+ */
+static inline int simulate_rdhwr(struct pt_regs *regs)
+{
+	struct thread_info *ti = current->thread_info;
+	unsigned int opcode;
+
+	if (unlikely(get_insn_opcode(regs, &opcode)))
+		return -EFAULT;
+
+	if (unlikely(compute_return_epc(regs)))
+		return -EFAULT;
+
+	if ((opcode & OPCODE) == SPEC3 && (opcode & FUNC) == RDHWR) {
+		int rd = (opcode & RD) >> 11;
+		int rt = (opcode & RT) >> 16;
+		switch (rd) {
+			case 29:
+				regs->regs[rt] = ti->tp_value;
+				break;
+			default:
+				return -EFAULT;
+		}
+	}
+
+	return 0;
+}
+
 asmlinkage void do_ov(struct pt_regs *regs)
 {
 	siginfo_t info;
@@ -640,6 +675,9 @@ asmlinkage void do_ri(struct pt_regs *re
 		if (!simulate_llsc(regs))
 			return;
 
+	if (!simulate_rdhwr(regs))
+		return;
+
 	force_sig(SIGILL, current);
 }
 
@@ -653,11 +691,13 @@ asmlinkage void do_cpu(struct pt_regs *r
 
 	switch (cpid) {
 	case 0:
-		if (cpu_has_llsc)
-			break;
+		if (!cpu_has_llsc)
+			if (!simulate_llsc(regs))
+				return;
 
-		if (!simulate_llsc(regs))
+		if (!simulate_rdhwr(regs))
 			return;
+
 		break;
 
 	case 1:
Index: linux/arch/mips/kernel/process.c
===================================================================
--- linux.orig/arch/mips/kernel/process.c	2005-03-15 10:09:23.000000000 -0500
+++ linux/arch/mips/kernel/process.c	2005-03-16 09:04:04.049856461 -0500
@@ -89,6 +89,7 @@ int copy_thread(int nr, unsigned long cl
 	struct thread_info *ti = p->thread_info;
 	struct pt_regs *childregs;
 	long childksp;
+	p->set_child_tid = p->clear_child_tid = NULL;
 
 	childksp = (unsigned long)ti + THREAD_SIZE - 32;
 
@@ -134,6 +135,9 @@ int copy_thread(int nr, unsigned long cl
 	childregs->cp0_status &= ~(ST0_CU2|ST0_CU1);
 	clear_tsk_thread_flag(p, TIF_USEDFPU);
 
+	if (clone_flags & CLONE_SETTLS)
+		ti->tp_value = regs->regs[7];
+	
 	return 0;
 }
 
Index: linux/include/asm-mips/inst.h
===================================================================
--- linux.orig/include/asm-mips/inst.h	2005-03-15 10:09:23.000000000 -0500
+++ linux/include/asm-mips/inst.h	2005-03-15 10:09:29.000000000 -0500
@@ -28,7 +28,7 @@ enum major_op {
 	sdl_op, sdr_op, swr_op, cache_op,
 	ll_op, lwc1_op, lwc2_op, pref_op,
 	lld_op, ldc1_op, ldc2_op, ld_op,
-	sc_op, swc1_op, swc2_op, major_3b_op, /* Opcode 0x3b is unused */
+	sc_op, swc1_op, swc2_op, rdhwr_op,
 	scd_op, sdc1_op, sdc2_op, sd_op
 };
 
Index: linux/arch/mips/kernel/ptrace.c
===================================================================
--- linux.orig/arch/mips/kernel/ptrace.c	2005-03-15 10:09:23.000000000 -0500
+++ linux/arch/mips/kernel/ptrace.c	2005-03-15 10:09:29.000000000 -0500
@@ -287,6 +287,11 @@ asmlinkage int sys_ptrace(long request, 
 		ret = ptrace_detach(child, data);
 		break;
 
+	case PTRACE_GET_THREAD_AREA:
+		ret = put_user(child->thread_info->tp_value,
+				(unsigned long __user *) data);
+		break;
+
 	default:
 		ret = ptrace_request(child, request, addr, data);
 		break;
Index: linux/include/asm-mips/thread_info.h
===================================================================
--- linux.orig/include/asm-mips/thread_info.h	2005-03-15 10:09:23.000000000 -0500
+++ linux/include/asm-mips/thread_info.h	2005-03-15 10:34:51.000000000 -0500
@@ -26,6 +26,7 @@ struct thread_info {
 	struct task_struct	*task;		/* main task structure */
 	struct exec_domain	*exec_domain;	/* execution domain */
 	unsigned long		flags;		/* low level flags */
+	unsigned long		tp_value;	/* thread pointer */
 	__u32			cpu;		/* current CPU */
 	__s32			preempt_count; /* 0 => preemptable, <0 => BUG */
 
Index: linux/arch/mips/kernel/offset.c
===================================================================
--- linux.orig/arch/mips/kernel/offset.c	2005-03-15 10:09:23.000000000 -0500
+++ linux/arch/mips/kernel/offset.c	2005-03-15 10:09:29.000000000 -0500
@@ -95,6 +95,7 @@ void output_thread_info_defines(void)
 	offset("#define TI_PRE_COUNT       ", struct thread_info, preempt_count);
 	offset("#define TI_ADDR_LIMIT      ", struct thread_info, addr_limit);
 	offset("#define TI_RESTART_BLOCK   ", struct thread_info, restart_block);
+	offset("#define TI_TP_VALUE	   ", struct thread_info, tp_value);
 	constant("#define _THREAD_SIZE_ORDER ", THREAD_SIZE_ORDER);
 	constant("#define _THREAD_SIZE       ", THREAD_SIZE);
 	constant("#define _THREAD_MASK       ", THREAD_MASK);
Index: linux/arch/mips/kernel/scall64-o32.S
===================================================================
--- linux.orig/arch/mips/kernel/scall64-o32.S	2005-03-15 10:09:23.000000000 -0500
+++ linux/arch/mips/kernel/scall64-o32.S	2005-03-15 10:29:46.000000000 -0500
@@ -322,7 +322,7 @@ sys_call_table:
 	PTR	sys32_ipc
 	PTR	sys_fsync
 	PTR	sys32_sigreturn
-	PTR	sys_clone			/* 4120 */
+	PTR	sys32_clone			/* 4120 */
 	PTR	sys_setdomainname
 	PTR	sys32_newuname
 	PTR	sys_ni_syscall			/* sys_modify_ldt */
@@ -485,4 +485,5 @@ sys_call_table:
 	PTR	sys_add_key			/* 4280 */
 	PTR	sys_request_key
 	PTR	sys_keyctl
+	PTR	sys_set_thread_area
 	.size	sys_call_table,.-sys_call_table
Index: linux/arch/mips/kernel/linux32.c
===================================================================
--- linux.orig/arch/mips/kernel/linux32.c	2005-03-15 10:09:23.000000000 -0500
+++ linux/arch/mips/kernel/linux32.c	2005-03-15 10:29:02.000000000 -0500
@@ -1471,3 +1471,38 @@ sysn32_rt_sigtimedwait(const sigset_t __
 	}
 	return sys_rt_sigtimedwait(uthese, uinfo, uts, sigsetsize);
 }
+
+save_static_function(sys32_clone);
+__attribute_used__ noinline static int
+_sys32_clone(unsigned long __dummy0,
+	     unsigned long __dummy1,
+	     unsigned long __dummy2,
+	     unsigned long __dummy3,
+	     unsigned long __dummy4,
+	     unsigned long __dummy5,
+	     unsigned long __dummy6,
+	     unsigned long __dummy7,
+	     struct pt_regs regs)
+{
+	unsigned long clone_flags;
+	unsigned long newsp;
+	int __user *parent_tidptr, *child_tidptr;
+
+	clone_flags = regs.regs[4];
+	newsp = regs.regs[5];
+	if (!newsp)
+		newsp = regs.regs[29];
+	parent_tidptr = (int *) regs.regs[6];
+
+	/* Use __dummy4 instead of getting it off the stack, so that
+	   syscall() works.  */
+	child_tidptr = (int __user *) __dummy4;
+	return do_fork(clone_flags, newsp, &regs, 0,
+	               parent_tidptr, child_tidptr);
+}
+
+extern asmlinkage void sys_set_thread_area(u32 addr);
+asmlinkage void sys32_set_thread_area(u32 addr)
+{
+	sys_set_thread_area(AA(addr));
+}
Index: linux/arch/mips/kernel/ptrace32.c
===================================================================
--- linux.orig/arch/mips/kernel/ptrace32.c	2005-03-15 10:09:23.000000000 -0500
+++ linux/arch/mips/kernel/ptrace32.c	2005-03-15 10:09:29.000000000 -0500
@@ -268,6 +268,11 @@ asmlinkage int sys32_ptrace(int request,
 		wake_up_process(child);
 		break;
 
+	case PTRACE_GET_THREAD_AREA:
+		ret = put_user(child->thread_info->tp_value,
+				(unsigned int __user *) (unsigned long) data);
+		break;
+
 	case PTRACE_DETACH: /* detach a process that was attached. */
 		ret = ptrace_detach(child, data);
 		break;
Index: linux/arch/mips/kernel/scall32-o32.S
===================================================================
--- linux.orig/arch/mips/kernel/scall32-o32.S	2005-03-15 10:04:30.000000000 -0500
+++ linux/arch/mips/kernel/scall32-o32.S	2005-03-15 10:29:24.000000000 -0500
@@ -623,6 +623,7 @@ einval:	li	v0, -EINVAL
 	sys	sys_add_key		5
 	sys	sys_request_key		4
 	sys	sys_keyctl		5
+	sys	sys_set_thread_area	1
 
 	.endm
 
Index: linux/include/asm-mips/unistd.h
===================================================================
--- linux.orig/include/asm-mips/unistd.h	2005-02-02 09:17:33.000000000 -0500
+++ linux/include/asm-mips/unistd.h	2005-03-15 10:26:02.000000000 -0500
@@ -303,16 +303,17 @@
 #define __NR_add_key			(__NR_Linux + 280)
 #define __NR_request_key		(__NR_Linux + 281)
 #define __NR_keyctl			(__NR_Linux + 282)
+#define __NR_set_thread_area		(__NR_Linux + 283)
 
 /*
  * Offset of the last Linux o32 flavoured syscall
  */
-#define __NR_Linux_syscalls		282
+#define __NR_Linux_syscalls		283
 
 #endif /* _MIPS_SIM == _MIPS_SIM_ABI32 */
 
 #define __NR_O32_Linux			4000
-#define __NR_O32_Linux_syscalls		282
+#define __NR_O32_Linux_syscalls		283
 
 #if _MIPS_SIM == _MIPS_SIM_ABI64
 
@@ -562,16 +563,17 @@
 #define __NR_add_key			(__NR_Linux + 239)
 #define __NR_request_key		(__NR_Linux + 240)
 #define __NR_keyctl			(__NR_Linux + 241)
+#define __NR_set_thread_area		(__NR_Linux + 242)
 
 /*
  * Offset of the last Linux 64-bit flavoured syscall
  */
-#define __NR_Linux_syscalls		241
+#define __NR_Linux_syscalls		242
 
 #endif /* _MIPS_SIM == _MIPS_SIM_ABI64 */
 
 #define __NR_64_Linux			5000
-#define __NR_64_Linux_syscalls		241
+#define __NR_64_Linux_syscalls		242
 
 #if _MIPS_SIM == _MIPS_SIM_NABI32
 
@@ -825,16 +827,17 @@
 #define __NR_add_key			(__NR_Linux + 243)
 #define __NR_request_key		(__NR_Linux + 244)
 #define __NR_keyctl			(__NR_Linux + 245)
+#define __NR_set_thread_area		(__NR_Linux + 246)
 
 /*
  * Offset of the last N32 flavoured syscall
  */
-#define __NR_Linux_syscalls		245
+#define __NR_Linux_syscalls		246
 
 #endif /* _MIPS_SIM == _MIPS_SIM_NABI32 */
 
 #define __NR_N32_Linux			6000
-#define __NR_N32_Linux_syscalls		245
+#define __NR_N32_Linux_syscalls		246
 
 #ifndef __ASSEMBLY__
 
Index: linux/arch/mips/kernel/scall64-64.S
===================================================================
--- linux.orig/arch/mips/kernel/scall64-64.S	2005-01-20 16:26:58.000000000 -0500
+++ linux/arch/mips/kernel/scall64-64.S	2005-03-15 10:29:48.000000000 -0500
@@ -449,3 +449,4 @@ sys_call_table:
 	PTR	sys_add_key
 	PTR	sys_request_key			/* 5240 */
 	PTR	sys_keyctl
+	PTR	sys_set_thread_area
Index: linux/arch/mips/kernel/scall64-n32.S
===================================================================
--- linux.orig/arch/mips/kernel/scall64-n32.S	2005-03-15 10:09:21.000000000 -0500
+++ linux/arch/mips/kernel/scall64-n32.S	2005-03-16 09:04:03.388011517 -0500
@@ -363,3 +363,4 @@ EXPORT(sysn32_call_table)
 	PTR	sys_add_key
 	PTR	sys_request_key
 	PTR	sys_keyctl			/* 6245 */
+	PTR	sys_set_thread_area

-- 
Daniel Jacobowitz
CodeSourcery, LLC
