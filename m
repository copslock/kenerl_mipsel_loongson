Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6J9B5Rw019202
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 19 Jul 2002 02:11:05 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6J9B5lJ019201
	for linux-mips-outgoing; Fri, 19 Jul 2002 02:11:05 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from laposte.enst-bretagne.fr (laposte.enst-bretagne.fr [192.108.115.3])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6J9AdRw019182;
	Fri, 19 Jul 2002 02:10:40 -0700
Received: from resel.enst-bretagne.fr (UNKNOWN@maisel-gw.enst-bretagne.fr [192.44.76.8])
	by laposte.enst-bretagne.fr (8.11.6/8.11.6) with ESMTP id g6J9BBY07249;
	Fri, 19 Jul 2002 11:11:11 +0200
Received: from melkor (mail@melkor.maisel.enst-bretagne.fr [172.16.20.65])
	by resel.enst-bretagne.fr (8.12.3/8.12.3/Debian -4) with ESMTP id g6J9BBTF032698;
	Fri, 19 Jul 2002 11:11:11 +0200
Received: from glaurung (helo=localhost)
	by melkor with local-esmtp (Exim 3.35 #1 (Debian))
	id 17VTn5-0000D1-00; Fri, 19 Jul 2002 11:11:11 +0200
Date: Fri, 19 Jul 2002 11:11:11 +0200 (CEST)
From: Vivien Chappelier <vivien.chappelier@enst-bretagne.fr>
X-Sender: glaurung@melkor
To: Ralf Baechle <ralf@oss.sgi.com>
cc: linux-mips@oss.sgi.com
Subject: [2.5 PATCH] thread_info & stack fixes
Message-ID: <Pine.LNX.4.21.0207191100100.684-100000@melkor>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: by amavisd-milter (http://amavis.org/) at enst-bretagne.fr
X-Spam-Status: No, hits=-5.0 required=5.0 tests=UNIFIED_PATCH version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi,

        Here are fixes for the 2.5.4 kernel to update code that assumes
"current = (task_struct *) $28". In the 2.5.4 kernel, register $28 now
holds a thread_info struct rather than a task_struct, shared with the
stack, i.e. the layout is

$28: thread_info current_thread_info
 [...]
$28+KERNEL_STACK_SIZE-n: top of the stack
$28+KERNEL_STACK_SIZE: bottom of the stack

See also the thread_union in include/linux/sched.h:

union thread_union {
        struct thread_info thread_info;
        unsigned long stack[INIT_THREAD_SIZE/sizeof(long)];
};

	This patch is for mips64 but I guess the same applies to mips.

Vivien.

===============================================================================

--- linux/include/asm-mips64/processor.h	Tue Jul  9 22:03:12 2002
+++ linux.patch/include/asm-mips64/processor.h	Sat Jul 13 18:02:51 2002
@@ -270,7 +270,7 @@
 unsigned long get_wchan(struct task_struct *p);
 
 #define __PT_REG(reg) ((long)&((struct pt_regs *)0)->reg - sizeof(struct pt_regs))
-#define __KSTK_TOS(tsk) ((unsigned long)(tsk) + KERNEL_STACK_SIZE - 32)
+#define __KSTK_TOS(tsk) ((unsigned long)(tsk->thread_info) + KERNEL_STACK_SIZE - 32)
 #define KSTK_EIP(tsk) (*(unsigned long *)(__KSTK_TOS(tsk) + __PT_REG(cp0_epc)))
 #define KSTK_ESP(tsk) (*(unsigned long *)(__KSTK_TOS(tsk) + __PT_REG(regs[29])))
 
--- linux/arch/mips64/kernel/r4k_switch.S	Sat Jul 13 20:22:41 2002
+++ linux.patch/arch/mips64/kernel/r4k_switch.S	Sat Jul 13 20:28:17 2002
@@ -40,8 +40,8 @@
 	 */
 	move	$28, a2
 	cpu_restore_nonscratch a1
-
-	daddiu	t1, a1, KERNEL_STACK_SIZE-32
+	
+	daddiu	t1, $28, KERNEL_STACK_SIZE-32
 	set_saved_sp	t1 t0
 
 	mfc0	t1, CP0_STATUS		/* Do we really need this? */
diff -Naur linux/arch/mips64/kernel/process.c linux.patch/arch/mips64/kernel/process.c
--- linux/arch/mips64/kernel/process.c	Tue Jul  9 22:02:18 2002
+++ linux.patch/arch/mips64/kernel/process.c	Sat Jul 13 17:51:18 2002
@@ -74,7 +74,7 @@
 	struct pt_regs *childregs;
 	long childksp;
 
-	childksp = (unsigned long)p + KERNEL_STACK_SIZE - 32;
+	childksp = (unsigned long)ti + KERNEL_STACK_SIZE - 32;
 
 	if (IS_FPU_OWNER()) {
 		save_fp(p);
@@ -87,7 +87,7 @@
 	regs->regs[2] = p->pid;
 
 	if (childregs->cp0_status & ST0_CU0) {
-		childregs->regs[28] = (unsigned long) p;
+		childregs->regs[28] = (unsigned long) ti;
 		childregs->regs[29] = childksp;
 		ti->addr_limit = KERNEL_DS;
 	} else {
diff -Naur linux/arch/mips64/kernel/ptrace.c linux.patch/arch/mips64/kernel/ptrace.c
--- linux/arch/mips64/kernel/ptrace.c	Tue Jul  9 22:02:18 2002
+++ linux.patch/arch/mips64/kernel/ptrace.c	Sat Jul 13 17:47:07 2002
@@ -102,7 +102,7 @@
 		struct pt_regs *regs;
 		unsigned int tmp;
 
-		regs = (struct pt_regs *) ((unsigned long) child +
+		regs = (struct pt_regs *) ((unsigned long) child->thread_info +
 			KERNEL_STACK_SIZE - 32 - sizeof(struct pt_regs));
 		ret = 0;
 
@@ -191,7 +191,7 @@
 	case PTRACE_POKEUSR: {
 		struct pt_regs *regs;
 		ret = 0;
-		regs = (struct pt_regs *) ((unsigned long) child +
+		regs = (struct pt_regs *) ((unsigned long) child->thread_info +
 			KERNEL_STACK_SIZE - 32 - sizeof(struct pt_regs));
 
 		switch (addr) {
@@ -376,7 +376,7 @@
 		struct pt_regs *regs;
 		unsigned long tmp;
 
-		regs = (struct pt_regs *) ((unsigned long) child +
+		regs = (struct pt_regs *) ((unsigned long) child->thread_info +
 			KERNEL_STACK_SIZE - 32 - sizeof(struct pt_regs));
 		ret = 0;
 
@@ -465,7 +465,7 @@
 	case PTRACE_POKEUSR: {
 		struct pt_regs *regs;
 		ret = 0;
-		regs = (struct pt_regs *) ((unsigned long) child +
+		regs = (struct pt_regs *) ((unsigned long) child->thread_info +
 			KERNEL_STACK_SIZE - 32 - sizeof(struct pt_regs));
 
 		switch (addr) {
diff -Naur linux/arch/mips64/lib/memcpy.S linux.patch/arch/mips64/lib/memcpy.S
--- linux/arch/mips64/lib/memcpy.S	Sun Dec  9 15:47:12 2001
+++ linux.patch/arch/mips64/lib/memcpy.S	Sat Jul 13 12:57:20 2002
@@ -757,7 +757,8 @@
 	END(__rmemcpy)
 
 l_fixup:					# clear the rest of the buffer
-	ld	ta0, THREAD_BUADDR($28)
+	ld	a2, TI_TASK($28)
+	ld	ta0, THREAD_BUADDR(a2)
 	 nop
 	dsubu	a2, AT, ta0			# a2 bytes to go
 	daddu	a0, ta0				# compute start address in a1
diff -Naur linux/arch/mips64/lib/memset.S linux.patch/arch/mips64/lib/memset.S
--- linux/arch/mips64/lib/memset.S	Sun Dec  9 15:47:12 2001
+++ linux.patch/arch/mips64/lib/memset.S	Sat Jul 13 13:03:22 2002
@@ -121,14 +121,16 @@
 	 nop
 
 fwd_fixup:
-	ld	t0, THREAD_BUADDR($28)
+	ld	t2, TI_TASK($28)
+	ld	t0, THREAD_BUADDR(t2)
 	andi	a2, 0x3f
 	daddu	a2, t1
 	jr	ra
 	 dsubu	a2, t0
 
 partial_fixup:
-	ld	t0, THREAD_BUADDR($28)
+	ld	t2, TI_TASK($28)
+	ld	t0, THREAD_BUADDR(t2)
 	andi	a2, 7
 	daddu	a2, t1
 	jr	ra
diff -Naur linux/arch/mips64/sgi-ip27/ip27-init.c linux.patch/arch/mips64/sgi-ip27/ip27-init.c
--- linux/arch/mips64/sgi-ip27/ip27-init.c	Mon Jul  8 22:26:10 2002
+++ linux.patch/arch/mips64/sgi-ip27/ip27-init.c	Sat Jul 13 17:48:10 2002
@@ -29,6 +29,7 @@
 #include <asm/smp.h>
 #include <asm/processor.h>
 #include <asm/mmu_context.h>
+#include <asm/thread_info.h>
 #include <asm/sn/launch.h>
 #include <asm/sn/sn_private.h>
 #include <asm/sn/sn0/ip27.h>
@@ -492,7 +493,7 @@
 		 	 */
 			LAUNCH_SLAVE(cputonasid(num_cpus),cputoslice(num_cpus), 
 				(launch_proc_t)MAPPED_KERN_RW_TO_K0(bootstrap),
-				0, (void *)((unsigned long)p + 
+				0, (void *)((unsigned long)p->thread_info + 
 				KERNEL_STACK_SIZE - 32), (void *)p);
 
 			/*
