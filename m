Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 03 May 2003 13:57:06 +0100 (BST)
Received: from mba.ocn.ne.jp ([IPv6:::ffff:210.190.142.172]:28881 "HELO
	smtp.mba.ocn.ne.jp") by linux-mips.org with SMTP
	id <S8225202AbTECM5D>; Sat, 3 May 2003 13:57:03 +0100
Received: from localhost (p3166-ip01funabasi.chiba.ocn.ne.jp [61.112.99.166])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id D34AA40D5; Sat,  3 May 2003 21:56:56 +0900 (JST)
Date: Sat, 03 May 2003 22:04:31 +0900 (JST)
Message-Id: <20030503.220431.41626489.anemo@mba.ocn.ne.jp>
To: linux-mips@linux-mips.org, ralf@linux-mips.org
Cc: nemoto@toshiba-tops.co.jp
Subject: Re: magic constants in thread_saved_pc and get_wchan
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20030502.230446.25481355.anemo@mba.ocn.ne.jp>
References: <20030502.230446.25481355.anemo@mba.ocn.ne.jp>
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
X-archive-position: 2264
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Fri, 02 May 2003 23:04:46 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> said:
anemo> There are some magic constants about stack layout in
anemo> thread_saved_pc() and get_wchan().  Also I think get_wchan()
anemo> for 32bit kernel is something wrong. (it is not easy to explain
anemo> HOW wrong...)

anemo> This patch (for 2.4 cvs) get rid of these magic constants by
anemo> analyzing kernel codes in runtime.

And this is (untested) 2.5 version of the patch.

diff -ur linux-mips-2.5-cvs/arch/mips/kernel/process.c linux-2.5.new/arch/mips/kernel/process.c
--- linux-mips-2.5-cvs/arch/mips/kernel/process.c	Fri Jan 10 04:16:50 2003
+++ linux-2.5.new/arch/mips/kernel/process.c	Sat May  3 21:51:51 2003
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
 
 /*
  * We use this if we don't have any better idle routine..
@@ -172,6 +175,65 @@
 	return retval;
 }
 
+struct mips_frame_info {
+	int frame_offset;
+	int pc_offset;
+};
+static struct mips_frame_info schedule_frame;
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
 unsigned long thread_saved_pc(struct thread_struct *t)
 {
 	extern void ret_from_fork(void);
@@ -180,7 +242,9 @@
 	if (t->reg31 == (unsigned long) ret_from_fork)
 	return t->reg31;
 
-	return ((unsigned long *)t->reg29)[13];
+	if (schedule_frame.pc_offset < 0)
+		return 0;
+	return ((unsigned long *)t->reg29)[schedule_frame.pc_offset];
 }
 
 /*
@@ -199,6 +263,8 @@
 	if (!p || p == current || p->state == TASK_RUNNING)
 		return 0;
 
+	if (!mips_frame_info_initialized)
+		return 0;
 	pc = thread_saved_pc(&p->thread);
 	if (pc < first_sched || pc >= last_sched) {
 		return pc;
@@ -212,29 +278,33 @@
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
diff -ur linux-mips-2.5-cvs/arch/mips/kernel/setup.c linux-2.5.new/arch/mips/kernel/setup.c
--- linux-mips-2.5-cvs/arch/mips/kernel/setup.c	Sat Apr 12 02:28:23 2003
+++ linux-2.5.new/arch/mips/kernel/setup.c	Sat May  3 21:25:54 2003
@@ -493,7 +493,9 @@
 	void au1000_setup(void);
 	void au1100_setup(void);
 	void au1500_setup(void);
+	void frame_info_init(void);
 
+	frame_info_init();
 #ifdef CONFIG_BLK_DEV_FD
 	fd_ops = &no_fd_ops;
 #endif
diff -ur linux-mips-2.5-cvs/arch/mips64/kernel/process.c linux-2.5.new/arch/mips64/kernel/process.c
--- linux-mips-2.5-cvs/arch/mips64/kernel/process.c	Fri Feb 21 04:47:25 2003
+++ linux-2.5.new/arch/mips64/kernel/process.c	Sat May  3 21:51:45 2003
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
 
 /*
  * We use this if we don't have any better idle routine..
@@ -163,6 +166,65 @@
 	return retval;
 }
 
+struct mips_frame_info {
+	int frame_offset;
+	int pc_offset;
+};
+static struct mips_frame_info schedule_frame;
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
 /*
  * Return saved PC of a blocked thread.
  */
@@ -174,7 +236,9 @@
 	if (t->reg31 == (unsigned long) ret_from_fork)
 		return t->reg31;
 
-	return ((unsigned long*)t->reg29)[11];
+	if (schedule_frame.pc_offset < 0)
+		return 0;
+	return ((unsigned long *)t->reg29)[schedule_frame.pc_offset];
 }
 
 /*
@@ -193,6 +257,8 @@
 	if (!p || p == current || p->state == TASK_RUNNING)
 		return 0;
 
+	if (!mips_frame_info_initialized)
+		return 0;
 	pc = thread_saved_pc(&p->thread);
 	if (pc < first_sched || pc >= last_sched)
 		goto out;
@@ -205,26 +271,29 @@
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
diff -ur linux-mips-2.5-cvs/arch/mips64/kernel/setup.c linux-2.5.new/arch/mips64/kernel/setup.c
--- linux-mips-2.5-cvs/arch/mips64/kernel/setup.c	Wed Apr  9 09:46:47 2003
+++ linux-2.5.new/arch/mips64/kernel/setup.c	Sat May  3 21:25:59 2003
@@ -421,7 +421,9 @@
 	extern void ip32_setup(void);
 	extern void swarm_setup(void);
 	extern void malta_setup(void);
+	void frame_info_init(void);
 
+	frame_info_init();
 #ifdef CONFIG_DECSTATION
 	decstation_setup();
 #endif
---
Atsushi Nemoto
