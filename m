Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 May 2003 14:57:22 +0100 (BST)
Received: from mba.ocn.ne.jp ([IPv6:::ffff:210.190.142.172]:2001 "HELO
	smtp.mba.ocn.ne.jp") by linux-mips.org with SMTP
	id <S8225197AbTEBN5U>; Fri, 2 May 2003 14:57:20 +0100
Received: from localhost (p5238-ip01funabasi.chiba.ocn.ne.jp [219.96.147.238])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id B84673F11; Fri,  2 May 2003 22:57:14 +0900 (JST)
Date: Fri, 02 May 2003 23:04:46 +0900 (JST)
Message-Id: <20030502.230446.25481355.anemo@mba.ocn.ne.jp>
To: linux-mips@linux-mips.org, ralf@linux-mips.org
Cc: nemoto@toshiba-tops.co.jp
Subject: magic constants in thread_saved_pc and get_wchan
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-Spam-Checker-Version: SpamAssassin 2.50 (1.173-2003-02-20-exp)
X-archive-position: 2255
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

There are some magic constants about stack layout in thread_saved_pc()
and get_wchan().  Also I think get_wchan() for 32bit kernel is
something wrong. (it is not easy to explain HOW wrong...)

This patch (for 2.4 cvs) get rid of these magic constants by analyzing
kernel codes in runtime.

I posted same patch some time ago.  This is basically same as the
previous one but regenerated against current cvs tree and now
contains changes for mips64.


diff -ur linux-mips-cvs/arch/mips/kernel/process.c linux.new/arch/mips/kernel/process.c
--- linux-mips-cvs/arch/mips/kernel/process.c	Sat Jan 11 00:49:59 2003
+++ linux.new/arch/mips/kernel/process.c	Fri May  2 22:07:13 2003
@@ -18,6 +18,8 @@
 #include <linux/sys.h>
 #include <linux/user.h>
 #include <linux/a.out.h>
+#include <linux/init.h>
+#include <linux/completion.h>
 
 #include <asm/bootinfo.h>
 #include <asm/cpu.h>
@@ -31,6 +33,7 @@
 #include <asm/io.h>
 #include <asm/elf.h>
 #include <asm/isadep.h>
+#include <asm/inst.h>
 
 ATTRIB_NORET void cpu_idle(void)
 {
@@ -169,6 +172,61 @@
 #define first_sched	((unsigned long) scheduling_functions_start_here)
 #define last_sched	((unsigned long) scheduling_functions_end_here)
 
+struct mips_frame_info schedule_frame;
+static struct mips_frame_info schedule_timeout_frame;
+static struct mips_frame_info sleep_on_frame;
+static struct mips_frame_info sleep_on_timeout_frame;
+static struct mips_frame_info wait_for_completion_frame;
+static int mips_frame_info_initialized;
+static int __init get_frame_info(struct mips_frame_info *info, void *func)
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
+		if (ip->i_format.opcode == sw_op &&
+		    ip->i_format.rs == 29) {
+			/* sw $ra, offset($sp) */
+			if (ip->i_format.rt == 31) {
+				if (info->pc_offset != -1)
+					break;
+				info->pc_offset =
+					ip->i_format.simmediate / sizeof(long);
+			}
+			/* sw $s8, offset($sp) */
+			if (ip->i_format.rt == 30) {
+				if (info->frame_offset != -1)
+					break;
+				info->frame_offset =
+					ip->i_format.simmediate / sizeof(long);
+			}
+		}
+	}
+	if (info->pc_offset == -1 || info->frame_offset == -1) {
+		printk("Can't analize prologue code at %p\n", func);
+		info->pc_offset = -1;
+		info->frame_offset = -1;
+		return -1;
+	}
+	return 0;
+}
+void __init frame_info_init(void)
+{
+	mips_frame_info_initialized =
+		!get_frame_info(&schedule_frame, schedule) &&
+		!get_frame_info(&schedule_timeout_frame, schedule_timeout) &&
+		!get_frame_info(&sleep_on_frame, sleep_on) &&
+		!get_frame_info(&sleep_on_timeout_frame, sleep_on_timeout) &&
+		!get_frame_info(&wait_for_completion_frame, wait_for_completion);
+}
+
 /* get_wchan - a maintenance nightmare^W^Wpain in the ass ...  */
 unsigned long get_wchan(struct task_struct *p)
 {
@@ -177,6 +235,8 @@
 	if (!p || p == current || p->state == TASK_RUNNING)
 		return 0;
 
+	if (!mips_frame_info_initialized)
+		return 0;
 	pc = thread_saved_pc(&p->thread);
 	if (pc < first_sched || pc >= last_sched) {
 		return pc;
@@ -190,29 +250,33 @@
 		goto schedule_timeout_caller;
 	if (pc >= (unsigned long)interruptible_sleep_on)
 		goto schedule_caller;
-	/* Fall through */
+	if (pc >= (unsigned long)wait_for_completion)
+		goto schedule_caller;
+	goto schedule_timeout_caller;
 
 schedule_caller:
-	pc = ((unsigned long *)p->thread.reg30)[13];
-
+	frame = ((unsigned long *)p->thread.reg30)[schedule_frame.frame_offset];
+	if (pc >= (unsigned long) sleep_on)
+		pc = ((unsigned long *)frame)[sleep_on_frame.pc_offset];
+	else
+		pc = ((unsigned long *)frame)[wait_for_completion_frame.pc_offset];
 	return pc;
 
 schedule_timeout_caller:
 	/*
 	 * The schedule_timeout frame
 	 */
-	frame = ((unsigned long *)p->thread.reg30)[13];
+	frame = ((unsigned long *)p->thread.reg30)[schedule_frame.frame_offset];
 
 	/*
 	 * frame now points to sleep_on_timeout's frame
 	 */
-	frame = ((unsigned long *)frame)[9];
-	pc    = ((unsigned long *)frame)[10];
+	pc    = ((unsigned long *)frame)[schedule_timeout_frame.pc_offset];
 
 	if (pc >= first_sched && pc < last_sched) {
-		/* schedule_timeout called by interruptible_sleep_on_timeout */
-		frame = ((unsigned long *)frame)[9];
-		pc    = ((unsigned long *)frame)[10];
+		/* schedule_timeout called by [interruptible_]sleep_on_timeout */
+		frame = ((unsigned long *)frame)[schedule_timeout_frame.frame_offset];
+		pc    = ((unsigned long *)frame)[sleep_on_timeout_frame.pc_offset];
 	}
 
 	return pc;
diff -ur linux-mips-cvs/arch/mips/kernel/setup.c linux.new/arch/mips/kernel/setup.c
--- linux-mips-cvs/arch/mips/kernel/setup.c	Thu Apr 17 23:54:17 2003
+++ linux.new/arch/mips/kernel/setup.c	Fri May  2 21:47:29 2003
@@ -494,7 +494,9 @@
 	void swarm_setup(void);
 	void hp_setup(void);
 	void au1x00_setup(void);
+	void frame_info_init(void);
 
+	frame_info_init();
 #ifdef CONFIG_BLK_DEV_FD
 	fd_ops = &no_fd_ops;
 #endif
diff -ur linux-mips-cvs/arch/mips64/kernel/process.c linux.new/arch/mips64/kernel/process.c
--- linux-mips-cvs/arch/mips64/kernel/process.c	Sun Feb 23 18:55:39 2003
+++ linux.new/arch/mips64/kernel/process.c	Fri May  2 22:07:20 2003
@@ -19,6 +19,8 @@
 #include <linux/sys.h>
 #include <linux/user.h>
 #include <linux/a.out.h>
+#include <linux/init.h>
+#include <linux/completion.h>
 
 #include <asm/bootinfo.h>
 #include <asm/pgtable.h>
@@ -31,6 +33,7 @@
 #include <asm/elf.h>
 #include <asm/cpu.h>
 #include <asm/fpu.h>
+#include <asm/inst.h>
 
 ATTRIB_NORET void cpu_idle(void)
 {
@@ -162,6 +165,61 @@
 #define first_sched	((unsigned long) scheduling_functions_start_here)
 #define last_sched	((unsigned long) scheduling_functions_end_here)
 
+struct mips_frame_info schedule_frame;
+static struct mips_frame_info schedule_timeout_frame;
+static struct mips_frame_info sleep_on_frame;
+static struct mips_frame_info sleep_on_timeout_frame;
+static struct mips_frame_info wait_for_completion_frame;
+static int mips_frame_info_initialized;
+static int __init get_frame_info(struct mips_frame_info *info, void *func)
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
+		if (ip->i_format.opcode == sd_op &&
+		    ip->i_format.rs == 29) {
+			/* sd $ra, offset($sp) */
+			if (ip->i_format.rt == 31) {
+				if (info->pc_offset != -1)
+					break;
+				info->pc_offset =
+					ip->i_format.simmediate / sizeof(long);
+			}
+			/* sd $s8, offset($sp) */
+			if (ip->i_format.rt == 30) {
+				if (info->frame_offset != -1)
+					break;
+				info->frame_offset =
+					ip->i_format.simmediate / sizeof(long);
+			}
+		}
+	}
+	if (info->pc_offset == -1 || info->frame_offset == -1) {
+		printk("Can't analize prologue code at %p\n", func);
+		info->pc_offset = -1;
+		info->frame_offset = -1;
+		return -1;
+	}
+	return 0;
+}
+void __init frame_info_init(void)
+{
+	mips_frame_info_initialized =
+		!get_frame_info(&schedule_frame, schedule) &&
+		!get_frame_info(&schedule_timeout_frame, schedule_timeout) &&
+		!get_frame_info(&sleep_on_frame, sleep_on) &&
+		!get_frame_info(&sleep_on_timeout_frame, sleep_on_timeout) &&
+		!get_frame_info(&wait_for_completion_frame, wait_for_completion);
+}
+
 /* get_wchan - a maintenance nightmare ...  */
 unsigned long get_wchan(struct task_struct *p)
 {
@@ -170,6 +228,8 @@
 	if (!p || p == current || p->state == TASK_RUNNING)
 		return 0;
 
+	if (!mips_frame_info_initialized)
+		return 0;
 	pc = thread_saved_pc(&p->thread);
 	if (pc < first_sched || pc >= last_sched)
 		goto out;
@@ -182,26 +242,29 @@
 		goto schedule_timeout_caller;
 	if (pc >= (unsigned long)interruptible_sleep_on)
 		goto schedule_caller;
+	if (pc >= (unsigned long)wait_for_completion)
+		goto schedule_caller;
 	goto schedule_timeout_caller;
 
 schedule_caller:
-	frame = ((unsigned long *)p->thread.reg30)[10];
-	pc    = ((unsigned long *)frame)[7];
+	frame = ((unsigned long *)p->thread.reg30)[schedule_frame.frame_offset];
+	if (pc >= (unsigned long) sleep_on)
+		pc = ((unsigned long *)frame)[sleep_on_frame.pc_offset];
+	else
+		pc = ((unsigned long *)frame)[wait_for_completion_frame.pc_offset];
 	goto out;
 
 schedule_timeout_caller:
 	/* Must be schedule_timeout ...  */
-	pc    = ((unsigned long *)p->thread.reg30)[11];
-	frame = ((unsigned long *)p->thread.reg30)[10];
+	frame = ((unsigned long *)p->thread.reg30)[schedule_frame.frame_offset];
 
 	/* The schedule_timeout frame ...  */
-	pc    = ((unsigned long *)frame)[9];
-	frame = ((unsigned long *)frame)[8];
+	pc    = ((unsigned long *)frame)[schedule_timeout_frame.pc_offset];
 
 	if (pc >= first_sched && pc < last_sched) {
-		/* schedule_timeout called by interruptible_sleep_on_timeout */
-		pc    = ((unsigned long *)frame)[7];
-		frame = ((unsigned long *)frame)[6];
+		/* schedule_timeout called by [interruptible_]sleep_on_timeout */
+		frame = ((unsigned long *)frame)[schedule_timeout_frame.frame_offset];
+		pc    = ((unsigned long *)frame)[sleep_on_timeout_frame.pc_offset];
 	}
 
 out:
diff -ur linux-mips-cvs/arch/mips64/kernel/setup.c linux.new/arch/mips64/kernel/setup.c
--- linux-mips-cvs/arch/mips64/kernel/setup.c	Wed Apr  9 22:06:57 2003
+++ linux.new/arch/mips64/kernel/setup.c	Fri May  2 22:06:40 2003
@@ -419,7 +419,9 @@
 	extern void ip32_setup(void);
 	extern void swarm_setup(void);
 	extern void malta_setup(void);
+	extern void frame_info_init(void);
 
+	frame_info_init();
 #ifdef CONFIG_DECSTATION
 	decstation_setup();
 #endif
diff -ur linux-mips-cvs/include/asm-mips/processor.h linux.new/include/asm-mips/processor.h
--- linux-mips-cvs/include/asm-mips/processor.h	Fri Apr 25 23:43:48 2003
+++ linux.new/include/asm-mips/processor.h	Fri May  2 21:47:02 2003
@@ -240,6 +240,11 @@
 #define copy_segments(p, mm) do { } while(0)
 #define release_segments(mm) do { } while(0)
 
+struct mips_frame_info {
+	int frame_offset;
+	int pc_offset;
+};
+extern struct mips_frame_info schedule_frame;
 /*
  * Return saved PC of a blocked thread.
  */
@@ -251,7 +256,9 @@
 	if (t->reg31 == (unsigned long) ret_from_fork)
 		return t->reg31;
 
-	return ((unsigned long *)t->reg29)[13];
+	if (schedule_frame.pc_offset < 0)
+		return 0;
+	return ((unsigned long *)t->reg29)[schedule_frame.pc_offset];
 }
 
 /*
diff -ur linux-mips-cvs/include/asm-mips64/processor.h linux.new/include/asm-mips64/processor.h
--- linux-mips-cvs/include/asm-mips64/processor.h	Fri Apr 25 23:43:49 2003
+++ linux.new/include/asm-mips64/processor.h	Fri May  2 21:47:09 2003
@@ -280,6 +280,11 @@
 #define copy_segments(p, mm) do { } while(0)
 #define release_segments(mm) do { } while(0)
 
+struct mips_frame_info {
+	int frame_offset;
+	int pc_offset;
+};
+extern struct mips_frame_info schedule_frame;
 /*
  * Return saved PC of a blocked thread.
  */
@@ -291,7 +296,9 @@
 	if (t->reg31 == (unsigned long) ret_from_sys_call)
 		return t->reg31;
 
-	return ((unsigned long*)t->reg29)[11];
+	if (schedule_frame.pc_offset < 0)
+		return 0;
+	return ((unsigned long *)t->reg29)[schedule_frame.pc_offset];
 }
 
 #define user_mode(regs)	(((regs)->cp0_status & ST0_KSU) == KSU_USER)
---
Atsushi Nemoto
