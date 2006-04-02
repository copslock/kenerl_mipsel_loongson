Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 Apr 2006 15:27:45 +0100 (BST)
Received: from webmail.ict.ac.cn ([159.226.39.7]:5325 "HELO ict.ac.cn")
	by ftp.linux-mips.org with SMTP id S8133564AbWDBO1f (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 2 Apr 2006 15:27:35 +0100
Received: (qmail 10676 invoked by uid 507); 2 Apr 2006 13:50:06 -0000
Received: from unknown (HELO ?192.168.2.202?) (fxzhang@222.92.8.142)
  by ict.ac.cn with SMTP; 2 Apr 2006 13:50:06 -0000
Message-ID: <442FE1CA.4030905@ict.ac.cn>
Date:	Sun, 02 Apr 2006 22:38:02 +0800
From:	Fuxin Zhang <fxzhang@ict.ac.cn>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To:	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: stack backtrace
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=GB18030
Content-Transfer-Encoding: 7bit
Return-Path: <fxzhang@ict.ac.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11004
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fxzhang@ict.ac.cn
Precedence: bulk
X-list: linux-mips

hi Ralf,

    The dwarf unwinding code is too complex and I have no time to port
it. And I doubt it will be important enough to deserve the space costs,
the -gdwarf-2 kernel is more than 20MB.

    Instead for my need I just hack up a simple version of way 1, with
frame pointer kept on: CONFIG_FRAME_POINTER.

BTW:It seems nobody use this option for MIPS? Is it dangerous? The size
and performance overhead should be barable at most time for debugging?

here is the code patch(just for reference), it depends on
CONFIG_KALLSYMS too.


--- traps.c.orig	2006-04-02 21:39:01.000000000 +0800
+++ traps.c	2006-04-02 22:38:03.000000000 +0800
@@ -116,8 +116,129 @@
 	printk("\n");
 }

-void show_trace(struct task_struct *task, unsigned long *stack)
+#include <asm/inst.h>
+
+static struct mips_frame_info {
+	void *func;
+	int omit_fp;	/* compiled without fno-omit-frame-pointer */
+	int frame_offset;
+	int pc_offset;
+} tmp_frame;
+
+static int get_frame_info(void *func,struct mips_frame_info *info)
+{
+	int i;
+	union mips_instruction *ip = (union mips_instruction *)func;
+	info->pc_offset = -1;
+	info->frame_offset = -1;
+	for (i = 0; i < 128; i++, ip++) {
+		/* if jal, jalr, jr, stop. */
+		if (ip->j_format.opcode == jal_op ||
+		    (ip->r_format.opcode == spec_op &&
+		     (ip->r_format.func == jalr_op ||
+		      ip->r_format.func == jr_op)))
+			break;
+
+		if (
+#ifdef CONFIG_32BIT
+		    ip->i_format.opcode == sw_op &&
+#endif
+#ifdef CONFIG_64BIT
+		    ip->i_format.opcode == sd_op &&
+#endif
+		    ip->i_format.rs == 29)
+		{
+			/* sw / sd $ra, offset($sp) */
+			if (ip->i_format.rt == 31) {
+				if (info->pc_offset != -1)
+					continue;
+				info->pc_offset =
+					ip->i_format.simmediate / sizeof(long);
+			}
+			/* sw / sd $s8, offset($sp) */
+			if (ip->i_format.rt == 30) {
+//#if 0	/* gcc 3.4 does aggressive optimization... */
+				if (info->frame_offset != -1)
+					continue;
+//#endif
+				info->frame_offset =
+					ip->i_format.simmediate / sizeof(long);
+			}
+		}
+	}
+	if (info->pc_offset == -1 || info->frame_offset == -1) {
+		printk("Can't analyze prologue code at %p\n", func);
+		info->pc_offset = -1;
+		info->frame_offset = -1;
+		return -1;
+	}
+
+	return 0;
+}
+
+static void show_trace(struct task_struct *task, void *regs_in)
 {
+	unsigned long prev_sp,stack_top;
+	unsigned long count = 0;
+	unsigned long frame, pc;
+	char namebuf[KSYM_NAME_LEN+1];
+	const char *name;
+	char *modname;
+	unsigned long size,offset;
+	struct pt_regs *regs;
+	int in_exception = 0;
+
+	if (regs_in) /* called from show_registers */
+	  regs = (struct pt_regs*) regs_in;
+	else
+	  regs = (struct pt_regs *) ((unsigned long) task->thread_info +
+	      THREAD_SIZE - 32 - sizeof(struct pt_regs));
+
+	printk("Call Trace:\n");
+
+	prev_sp = (unsigned long) (task->thread_info + 1);
+	stack_top = (unsigned long) task->thread_info + THREAD_SIZE;
+
+	pc = (unsigned long)show_trace;
+
+	if (get_frame_info((void*)pc,&tmp_frame))
+	  return;
+
+	__asm__ volatile ("addu %0,$0,$30" : "=r" (frame));
+
+	do {
+		pc = ((unsigned long *)frame)[tmp_frame.pc_offset];
+		frame = ((unsigned long *)frame)[tmp_frame.frame_offset];
+		if (frame < prev_sp || frame > stack_top) {
+		  printk("out of range sp %08lx,give up!\n",frame);
+		  break;
+		}
+
+	    retry_pc:
+		if (!__kernel_text_address(pc)) {
+		  printk("out of text addr %08lx,give up!\n",pc);
+		  break;
+		}
+
+		name = kallsyms_lookup(pc, &size, &offset, &modname, namebuf);
+		if (!name) {
+		  printk("no function found at %08lx\n",pc);
+		  return;
+		}
+		printk("%s at %08lx,frame=%08lx",name,pc,frame);
+
+		pc = pc - offset;
+		if (get_frame_info((void*)pc,&tmp_frame) && !in_exception) {
+		  printk("get frame information failed, assume exceptions\n");
+		  in_exception = 1;
+		  pc = regs->cp0_epc;
+		  frame = regs->regs[30];
+		  printk("epc = %08lx,frame=%08lx\n",pc,frame);
+		  goto retry_pc;
+		}
+	} while (count++ < 16);
+
+#if 0
 	const int field = 2 * sizeof(unsigned long);
 	unsigned long addr;

@@ -140,6 +261,7 @@
 		}
 	}
 	printk("\n");
+#endif
 }

 /*
@@ -147,9 +269,10 @@
  */
 void dump_stack(void)
 {
-	unsigned long stack;
+	//unsigned long stack;

-	show_trace(current, &stack);
+	//show_trace(current, &stack);
+	show_trace(current, NULL);
 }

 EXPORT_SYMBOL(dump_stack);
@@ -269,7 +392,8 @@
 	printk("Process %s (pid: %d, threadinfo=%p, task=%p)\n",
 	        current->comm, current->pid, current_thread_info(), current);
 	show_stack(current, (long *) regs->regs[29]);
-	show_trace(current, (long *) regs->regs[29]);
+	//show_trace(current, (long *) regs->regs[29]);
+	show_trace(current,(void*) regs);
 	show_code((unsigned int *) regs->cp0_epc);
 	printk("\n");
 }



--- process.c.orig	2006-04-02 21:38:51.000000000 +0800
+++ process.c	2006-03-23 22:56:46.000000000 +0800
@@ -314,6 +314,9 @@
 	int i;
 	void *func = info->func;
 	union mips_instruction *ip = (union mips_instruction *)func;
+#ifdef CONFIG_FRAME_POINTER
+	info->omit_fp = 0;
+#endif
 	info->pc_offset = -1;
 	info->frame_offset = info->omit_fp ? 0 : -1;
 	for (i = 0; i < 128; i++, ip++) {
