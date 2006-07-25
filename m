Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Jul 2006 15:50:28 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:34800 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133455AbWGYOuO (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 25 Jul 2006 15:50:14 +0100
Received: from localhost (p6003-ipad211funabasi.chiba.ocn.ne.jp [58.91.162.3])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 05359881E; Tue, 25 Jul 2006 23:50:07 +0900 (JST)
Date:	Tue, 25 Jul 2006 23:51:36 +0900 (JST)
Message-Id: <20060725.235136.92587083.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] rearrange show_stack, show_trace 
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12068
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Print call-trace in show_stack() (as like as other archs).
Also make show_trace() static and simplify its argument list.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 368fdb7..c6f7046 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -79,6 +79,25 @@ void (*board_bind_eic_interrupt)(int irq
  */
 #define MODULE_RANGE (8*1024*1024)
 
+static void show_trace(unsigned long *stack)
+{
+	const int field = 2 * sizeof(unsigned long);
+	unsigned long addr;
+
+	printk("Call Trace:");
+#ifdef CONFIG_KALLSYMS
+	printk("\n");
+#endif
+	while (!kstack_end(stack)) {
+		addr = *stack++;
+		if (__kernel_text_address(addr)) {
+			printk(" [<%0*lx>] ", field, addr);
+			print_symbol("%s\n", addr);
+		}
+	}
+	printk("\n");
+}
+
 /*
  * This routine abuses get_user()/put_user() to reference pointers
  * with at least a bit of error checking ...
@@ -88,6 +107,7 @@ void show_stack(struct task_struct *task
 	const int field = 2 * sizeof(unsigned long);
 	long stackdata;
 	int i;
+	unsigned long *stack;
 
 	if (!sp) {
 		if (task && task != current)
@@ -95,6 +115,7 @@ void show_stack(struct task_struct *task
 		else
 			sp = (unsigned long *) &sp;
 	}
+	stack = sp;
 
 	printk("Stack :");
 	i = 0;
@@ -115,32 +136,7 @@ void show_stack(struct task_struct *task
 		i++;
 	}
 	printk("\n");
-}
-
-void show_trace(struct task_struct *task, unsigned long *stack)
-{
-	const int field = 2 * sizeof(unsigned long);
-	unsigned long addr;
-
-	if (!stack) {
-		if (task && task != current)
-			stack = (unsigned long *) task->thread.reg29;
-		else
-			stack = (unsigned long *) &stack;
-	}
-
-	printk("Call Trace:");
-#ifdef CONFIG_KALLSYMS
-	printk("\n");
-#endif
-	while (!kstack_end(stack)) {
-		addr = *stack++;
-		if (__kernel_text_address(addr)) {
-			printk(" [<%0*lx>] ", field, addr);
-			print_symbol("%s\n", addr);
-		}
-	}
-	printk("\n");
+	show_trace(stack);
 }
 
 /*
@@ -150,7 +146,7 @@ void dump_stack(void)
 {
 	unsigned long stack;
 
-	show_trace(current, &stack);
+	show_trace(&stack);
 }
 
 EXPORT_SYMBOL(dump_stack);
@@ -270,7 +266,6 @@ void show_registers(struct pt_regs *regs
 	printk("Process %s (pid: %d, threadinfo=%p, task=%p)\n",
 	        current->comm, current->pid, current_thread_info(), current);
 	show_stack(current, (long *) regs->regs[29]);
-	show_trace(current, (long *) regs->regs[29]);
 	show_code((unsigned int *) regs->cp0_epc);
 	printk("\n");
 }
