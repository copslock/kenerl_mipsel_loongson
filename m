Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7M5fPr21150
	for linux-mips-outgoing; Tue, 21 Aug 2001 22:41:25 -0700
Received: from topsns.toshiba-tops.co.jp (topsns.toshiba-tops.co.jp [202.230.225.5])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7M5fE921147
	for <linux-mips@oss.sgi.com>; Tue, 21 Aug 2001 22:41:15 -0700
Received: from inside-ms2.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for oss.sgi.com [216.32.174.27]) with SMTP; 22 Aug 2001 05:41:14 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms2.toshiba-tops.co.jp (Postfix) with ESMTP
	id 30BA754C0E; Wed, 22 Aug 2001 14:41:13 +0900 (JST)
Received: by srd2sd.toshiba-tops.co.jp (8.9.3/3.5Wbeta-srd2sd) with ESMTP
	id OAA86356; Wed, 22 Aug 2001 14:41:12 +0900 (JST)
Date: Wed, 22 Aug 2001 14:45:47 +0900 (JST)
Message-Id: <20010822.144547.30190293.nemoto@toshiba-tops.co.jp>
To: linux-mips@fnet.fr, linux-mips@oss.sgi.com
Cc: Ralf Baechle <ralf@uni-koblenz.de>
Subject: Magic numbers about stack layout
From: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
X-Mailer: Mew version 2.0 on Emacs 20.7 / Mule 4.1 (AOI)
X-Fingerprint: EC 9D B9 17 2E 89 D2 25  CE F5 5D 3D 12 29 2A AD
X-Pgp-Public-Key: http://pgp.nic.ad.jp/cgi-bin/pgpsearchkey.pl?op=get&search=0xB6D728B1
Organization: TOSHIBA Personal Computer System Corporation
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
 boundary="--Next_Part(Wed_Aug_22_14:45:47_2001_172)--"
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

----Next_Part(Wed_Aug_22_14:45:47_2001_172)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

There are some magic constant numbers about stack layout in
thread_saved_pc() and get_wchan() function.

I made a patch to eliminate these magic numbers.  This patch analyzes
some functions prologue codes in heuristic way at run-time.  "ps -l"
(and "MAGIC SYSRQ" feature) works fine with this patch.

---
Atsushi Nemoto

----Next_Part(Wed_Aug_22_14:45:47_2001_172)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="get_wchan.patch"

diff -ur linux.sgi/arch/mips/kernel/process.c linux/arch/mips/kernel/process.c
--- linux.sgi/arch/mips/kernel/process.c	Sun Aug  5 23:39:09 2001
+++ linux/arch/mips/kernel/process.c	Wed Aug 22 14:14:29 2001
@@ -19,6 +19,7 @@
 #include <linux/sys.h>
 #include <linux/user.h>
 #include <linux/a.out.h>
+#include <linux/init.h>
 
 #include <asm/bootinfo.h>
 #include <asm/cpu.h>
@@ -31,6 +32,7 @@
 #include <asm/io.h>
 #include <asm/elf.h>
 #include <asm/isadep.h>
+#include <asm/inst.h>
 
 void cpu_idle(void)
 {
@@ -196,6 +198,59 @@
 #define first_sched	((unsigned long) scheduling_functions_start_here)
 #define last_sched	((unsigned long) scheduling_functions_end_here)
 
+struct mips_frame_info schedule_frame;
+static struct mips_frame_info schedule_timeout_frame;
+static struct mips_frame_info sleep_on_frame;
+static struct mips_frame_info sleep_on_timeout_frame;
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
+		!get_frame_info(&sleep_on_timeout_frame, sleep_on_timeout);
+}
+
 /* get_wchan - a maintenance nightmare ...  */
 unsigned long get_wchan(struct task_struct *p)
 {
@@ -204,6 +259,8 @@
 	if (!p || p == current || p->state == TASK_RUNNING)
 		return 0;
 
+	if (!mips_frame_info_initialized)
+		return 0;
 	pc = thread_saved_pc(&p->thread);
 	if (pc < first_sched || pc >= last_sched) {
 		return pc;
@@ -220,23 +277,24 @@
 	goto schedule_timeout_caller;
 
 schedule_caller:
-	frame = ((unsigned long *)p->thread.reg30)[9];
-	pc    = ((unsigned long *)frame)[11];
+	/* schedule_timeout called by interruptible_sleep_on or sleep_on */
+	frame = ((unsigned long *)p->thread.reg30)[schedule_frame.frame_offset];
+	pc    = ((unsigned long *)frame)[sleep_on_frame.pc_offset];
 	return pc;
 
 schedule_timeout_caller:
 	/* Must be schedule_timeout ...  */
-	pc    = ((unsigned long *)p->thread.reg30)[10];
-	frame = ((unsigned long *)p->thread.reg30)[9];
+	pc    = ((unsigned long *)p->thread.reg30)[schedule_frame.pc_offset];
+	frame = ((unsigned long *)p->thread.reg30)[schedule_frame.frame_offset];
 
 	/* The schedule_timeout frame ...  */
-	pc    = ((unsigned long *)frame)[14];
-	frame = ((unsigned long *)frame)[13];
+	pc    = ((unsigned long *)frame)[schedule_timeout_frame.pc_offset];
+	frame = ((unsigned long *)frame)[schedule_timeout_frame.frame_offset];
 
 	if (pc >= first_sched && pc < last_sched) {
 		/* schedule_timeout called by interruptible_sleep_on_timeout */
-		pc    = ((unsigned long *)frame)[11];
-		frame = ((unsigned long *)frame)[10];
+		pc    = ((unsigned long *)frame)[sleep_on_timeout_frame.pc_offset];
+		frame = ((unsigned long *)frame)[sleep_on_timeout_frame.frame_offset];
 	}
 
 	return pc;
diff -ur linux.sgi/arch/mips/kernel/setup.c linux/arch/mips/kernel/setup.c
--- linux.sgi/arch/mips/kernel/setup.c	Sun Aug  5 23:39:15 2001
+++ linux/arch/mips/kernel/setup.c	Wed Aug 22 14:26:19 2001
@@ -518,12 +518,14 @@
 	void malta_setup(void);
 	void momenco_ocelot_setup(void);
 	void nino_setup(void);
+	void frame_info_init(void);
 
 	unsigned long bootmap_size;
 	unsigned long start_pfn, max_pfn, first_usable_pfn;
 
 	int i;
 
+	frame_info_init();
 #ifdef CONFIG_BLK_DEV_FD
 	fd_ops = &no_fd_ops;
 #endif
diff -ur linux.sgi/include/asm-mips/processor.h linux/include/asm-mips/processor.h
--- linux.sgi/include/asm-mips/processor.h	Sun Aug  5 23:41:29 2001
+++ linux/include/asm-mips/processor.h	Wed Aug 22 14:14:59 2001
@@ -217,6 +217,11 @@
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
@@ -228,7 +233,9 @@
 	if (t->reg31 == (unsigned long) ret_from_fork)
 		return t->reg31;
 
-	return ((unsigned long *)t->reg29)[10];
+	if (schedule_frame.pc_offset < 0)
+		return 0;
+	return ((unsigned long *)t->reg29)[schedule_frame.pc_offset];
 }
 
 /*

----Next_Part(Wed_Aug_22_14:45:47_2001_172)----
