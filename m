Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6TDP6Rw001530
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 29 Jul 2002 06:25:06 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6TDP6uK001529
	for linux-mips-outgoing; Mon, 29 Jul 2002 06:25:06 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6TDOHRw001517
	for <linux-mips@oss.sgi.com>; Mon, 29 Jul 2002 06:24:18 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA25263;
	Mon, 29 Jul 2002 15:25:54 +0200 (MET DST)
Date: Mon, 29 Jul 2002 15:25:53 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Johannes Stezenbach <js@convergence.de>,
   Ralf Baechle <ralf@uni-koblenz.de>, linux-mips@fnet.fr,
   linux-mips@oss.sgi.com
Subject: [patch] Oops and magic SysRq stack dump clean-ups
In-Reply-To: <Pine.GSO.3.96.1020725114648.27463B-100000@delta.ds2.pg.gda.pl>
Message-ID: <Pine.GSO.3.96.1020729150226.22288D-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hello,

 I've reviewed the stack dumping code more thoroughly and here is the
result.  Please check if it's OK for you.  Tested visually with oopses and
<SysRq>+<t> on MIPS/Linux and MIPS64/Linux.  The idea is to fit as much
data as possible in as little space as possible and at the same time lay
the numbers out visually nicely so that manual copying of output from a
terminal for ksymoops analysis is easier for a reader.  Tools ignore
spacing when processing such output anyway.

 Based somewhat on the i386 port.  Addresses cast to signed longs, since
they are such on MIPS (additionally, the code doesn't care anyway but the
resulting source is smaller).  Any objections? 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.19-rc1-20020719-mips-show_trace-8
diff -up --recursive --new-file linux-mips-2.4.19-rc1-20020719.macro/arch/mips/kernel/traps.c linux-mips-2.4.19-rc1-20020719/arch/mips/kernel/traps.c
--- linux-mips-2.4.19-rc1-20020719.macro/arch/mips/kernel/traps.c	2002-07-08 16:46:04.000000000 +0000
+++ linux-mips-2.4.19-rc1-20020719/arch/mips/kernel/traps.c	2002-07-27 11:48:19.000000000 +0000
@@ -181,61 +181,95 @@ static inline void simulate_sc(struct pt
 }
 
 /*
+ * If the address is either in the .text section of the
+ * kernel, or in the vmalloc'ed module regions, it *may*
+ * be the address of a calling routine
+ */
+
+#ifdef CONFIG_MODULES
+
+extern struct module *module_list;
+extern struct module kernel_module;
+
+static inline int kernel_text_address(long addr)
+{
+	extern char _stext, _etext;
+	int retval = 0;
+	struct module *mod;
+
+	if (addr >= (long) &_stext && addr <= (long) &_etext)
+		return 1;
+
+	for (mod = module_list; mod != &kernel_module; mod = mod->next) {
+		/* mod_bound tests for addr being inside the vmalloc'ed
+		 * module area. Of course it'd be better to test only
+		 * for the .text subset... */
+		if (mod_bound(addr, 0, mod)) {
+			retval = 1;
+			break;
+		}
+	}
+
+	return retval;
+}
+
+#else
+
+static inline int kernel_text_address(long addr)
+{
+	extern char _stext, _etext;
+
+	return (addr >= (long) &_stext && addr <= (long) &_etext);
+}
+
+#endif
+
+/*
  * This routine abuses get_user()/put_user() to reference pointers
  * with at least a bit of error checking ...
  */
-void show_stack(unsigned int *sp)
+void show_stack(long *sp)
 {
 	int i;
-	unsigned int *stack;
-
-	stack = sp ? sp : (unsigned int *)&sp;
-	i = 0;
+	long stackdata;
 
-	printk("Stack:");
-	while ((unsigned long) stack & (PAGE_SIZE - 1)) {
-		unsigned long stackdata;
+	sp = sp ? sp : (long *)&sp;
 
-		if (__get_user(stackdata, stack++)) {
-			printk(" (Bad stack address)");
+	printk("Stack:   ");
+	i = 1;
+	while ((long) sp & (PAGE_SIZE - 1)) {
+		if (i && ((i % 8) == 0))
+			printk("\n");
+		if (i > 40) {
+			printk(" ...");
 			break;
 		}
 
-		printk(" %08lx", stackdata);
-
-		if (++i > 40) {
-			printk(" ...");
+		if (__get_user(stackdata, sp++)) {
+			printk(" (Bad stack address)");
 			break;
 		}
 
-		if (i % 8 == 0)
-			printk("\n      ");
+		printk(" %08lx", stackdata);
+		i++;
 	}
+	printk("\n");
 }
 
-void show_trace(unsigned int *sp)
+void show_trace(long *sp)
 {
 	int i;
-	int column = 0;
-	unsigned int *stack;
-	unsigned long kernel_start, kernel_end;
-	unsigned long module_start, module_end;
-	extern char _stext, _etext;
-
-	stack = sp ? sp : (unsigned int *) &sp;
-	i = 0;
-
-	kernel_start = (unsigned long) &_stext;
-	kernel_end = (unsigned long) &_etext;
-	module_start = VMALLOC_START;
-	module_end = module_start + MODULE_RANGE;
+	long addr;
 
-	printk("\nCall Trace:");
+	sp = sp ? sp : (long *) &sp;
 
-	while ((unsigned long) stack & (PAGE_SIZE -1)) {
-		unsigned long addr;
+	printk("Call Trace:  ");
+	i = 1;
+	while ((long) sp & (PAGE_SIZE - 1)) {
 
-		if (__get_user(addr, stack++)) {
+		if (__get_user(addr, sp++)) {
+			if (i && ((i % 6) == 0))
+				printk("\n");
 			printk(" (Bad stack address)\n");
 			break;
 		}
@@ -249,27 +283,24 @@ void show_trace(unsigned int *sp)
 		 * out the call path that was taken.
 		 */
 
-		if ((addr >= kernel_start && addr < kernel_end) ||
-		    (addr >= module_start && addr < module_end)) { 
-
-			printk(" [<%08lx>]", addr);
-			if (column++ == 5) {
+		if (kernel_text_address(addr)) {
+			if (i && ((i % 6) == 0))
 				printk("\n");
-				column = 0;
-			}
-			if (++i > 40) {
+			if (i > 40) {
 				printk(" ...");
 				break;
 			}
+
+			printk(" [<%08lx>]", addr);
+			i++;
 		}
 	}
-	if (column != 0)
-		printk("\n");
+	printk("\n");
 }
 
 void show_trace_task(struct task_struct *tsk)
 {
-	show_trace((unsigned int *)tsk->thread.reg29);
+	show_trace((long *)tsk->thread.reg29);
 }
 
 void show_code(unsigned int *pc)
@@ -321,8 +352,8 @@ void show_registers(struct pt_regs *regs
 	show_regs(regs);
 	printk("Process %s (pid: %d, stackpage=%08lx)\n",
 		current->comm, current->pid, (unsigned long) current);
-	show_stack((unsigned int *) regs->regs[29]);
-	show_trace((unsigned int *) regs->regs[29]);
+	show_stack((long *) regs->regs[29]);
+	show_trace((long *) regs->regs[29]);
 	show_code((unsigned int *) regs->cp0_epc);
 	printk("\n");
 }
diff -up --recursive --new-file linux-mips-2.4.19-rc1-20020719.macro/arch/mips64/kernel/traps.c linux-mips-2.4.19-rc1-20020719/arch/mips64/kernel/traps.c
--- linux-mips-2.4.19-rc1-20020719.macro/arch/mips64/kernel/traps.c	2002-07-08 16:46:08.000000000 +0000
+++ linux-mips-2.4.19-rc1-20020719/arch/mips64/kernel/traps.c	2002-07-27 11:43:15.000000000 +0000
@@ -70,60 +70,91 @@ int kstack_depth_to_print = 24;
 #define OPCODE 0xfc000000
 
 /*
+ * If the address is either in the .text section of the
+ * kernel, or in the vmalloc'ed module regions, it *may*
+ * be the address of a calling routine
+ */
+
+#ifdef CONFIG_MODULES
+
+extern struct module *module_list;
+extern struct module kernel_module;
+
+static inline int kernel_text_address(long addr)
+{
+	extern char _stext, _etext;
+	int retval = 0;
+	struct module *mod;
+
+	if (addr >= (long) &_stext && addr <= (long) &_etext)
+		return 1;
+
+	for (mod = module_list; mod != &kernel_module; mod = mod->next) {
+		/* mod_bound tests for addr being inside the vmalloc'ed
+		 * module area. Of course it'd be better to test only
+		 * for the .text subset... */
+		if (mod_bound(addr, 0, mod)) {
+			retval = 1;
+			break;
+		}
+	}
+
+	return retval;
+}
+
+#else
+
+static inline int kernel_text_address(long addr)
+{
+	extern char _stext, _etext;
+
+	return (addr >= (long) &_stext && addr <= (long) &_etext);
+}
+
+#endif
+
+/*
  * This routine abuses get_user()/put_user() to reference pointers
  * with at least a bit of error checking ...
  */
-void show_stack(unsigned long *sp)
+void show_stack(long *sp)
 {
 	int i;
-	unsigned long *stack;
-
-	stack = sp;
-	i = 0;
+	long stackdata;
 
 	printk("Stack:");
-	while ((unsigned long) stack & (PAGE_SIZE - 1)) {
-		unsigned long stackdata;
-
-		if (__get_user(stackdata, stack++)) {
-			printk(" (Bad stack address)");
+	i = 0;
+	while ((long) sp & (PAGE_SIZE - 1)) {
+		if (i && ((i % 4) == 0))
+			printk("\n      ");
+		if (i > 40) {
+			printk(" ...");
 			break;
 		}
 
-		printk(" %016lx", stackdata);
-
-		if (++i > 40) {
-			printk(" ...");
+		if (__get_user(stackdata, sp++)) {
+			printk(" (Bad stack address)");
 			break;
 		}
 
-		if (i % 4 == 0)
-			printk("\n      ");
+		printk(" %016lx", stackdata);
+		i++;
 	}
+	printk("\n");
 }
 
-void show_trace(unsigned long *sp)
+void show_trace(long *sp)
 {
 	int i;
-	unsigned long *stack;
-	unsigned long kernel_start, kernel_end;
-	unsigned long module_start, module_end;
-	extern char _stext, _etext;
+	long addr;
 
-	stack = sp;
+	printk("Call Trace:");
 	i = 0;
+	while ((long) sp & (PAGE_SIZE - 1)) {
 
-	kernel_start = (unsigned long) &_stext;
-	kernel_end = (unsigned long) &_etext;
-	module_start = VMALLOC_START;
-	module_end = module_start + MODULE_RANGE;
-
-	printk("\nCall Trace:");
-
-	while ((unsigned long) stack & (PAGE_SIZE - 1)) {
-		unsigned long addr;
-
-		if (__get_user(addr, stack++)) {
+		if (__get_user(addr, sp++)) {
+			if (i && ((i % 3) == 0))
+				printk("\n           ");
 			printk(" (Bad stack address)\n");
 			break;
 		}
@@ -137,25 +168,24 @@ void show_trace(unsigned long *sp)
 		 * out the call path that was taken.
 		 */
 
-		if ((addr >= kernel_start && addr < kernel_end) ||
-		    (addr >= module_start && addr < module_end)) { 
-
-			/* Since our kernel is still at KSEG0,
-			 * truncate the address so that ksymoops
-			 * understands it.
-			 */
-			printk(" [<%08x>]", (unsigned int) addr);
-			if (++i > 40) {
+		if (kernel_text_address(addr)) {
+			if (i && ((i % 3) == 0))
+				printk("\n           ");
+			if (i > 40) {
 				printk(" ...");
 				break;
 			}
+
+			printk(" [<%016lx>]", addr);
+			i++;
 		}
 	}
+	printk("\n");
 }
 
 void show_trace_task(struct task_struct *tsk)
 {
-	show_trace((unsigned long *)tsk->thread.reg29);
+	show_trace((long *)tsk->thread.reg29);
 }
 
 
@@ -224,8 +254,8 @@ void show_registers(struct pt_regs *regs
 	show_regs(regs);
 	printk("Process %s (pid: %d, stackpage=%016lx)\n",
 		current->comm, current->pid, (unsigned long) current);
-	show_stack((unsigned long *) regs->regs[29]);
-	show_trace((unsigned long *) regs->regs[29]);
+	show_stack((long *) regs->regs[29]);
+	show_trace((long *) regs->regs[29]);
 	show_code((unsigned int *) regs->cp0_epc);
 	printk("\n");
 }
