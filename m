Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id EAA13022 for <linux-archive@neteng.engr.sgi.com>; Fri, 30 Oct 1998 04:32:32 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id EAA80270
	for linux-list;
	Fri, 30 Oct 1998 04:31:51 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id EAA17728
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 30 Oct 1998 04:31:46 -0800 (PST)
	mail_from (ulfc@bun.falkenberg.se)
Received: from calypso.saturn (dialup49-4-27.swipnet.se [130.244.49.219]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id EAA00733
	for <linux@cthulhu.engr.sgi.com>; Fri, 30 Oct 1998 04:31:43 -0800 (PST)
	mail_from (ulfc@bun.falkenberg.se)
Received: by bun.falkenberg.se
	via sendmail from stdin
	id <m0zZDjz-000w5NC@calypso.saturn> (Debian Smail3.2.0.101)
	for linux@cthulhu.engr.sgi.com; Fri, 30 Oct 1998 13:33:19 +0100 (CET) 
Message-ID: <19981030133319.A3845@bun.falkenberg.se>
Date: Fri, 30 Oct 1998 13:33:19 +0100
From: Ulf Carlsson <ulfc@bun.falkenberg.se>
To: ralf@uni-koblenz.de
Cc: linux-mips@fnet.fr, linux-mips@vger.rutgers.edu,
        linux@cthulhu.engr.sgi.com
Subject: ksymoops support for MIPS
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=oyUTqETQ0mS9luUI
X-Mailer: Mutt 0.93.2
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii

Hi Ralf,

I've modified arch/mips/kernel/traps.c to support ksymoops, and Keith Owens has
modified ksymoops to support MIPS. A new version of ksymoops will show up within
a few days at ftp://ftp.ocs.com.au/pub/ksymoops.tar.gz. I have a later version
of ksymoops which works, but I prefer not to spam you :)

Can't you please include this patch in the CVS tree?

- Ulf

--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="traps.c.diff"

--- linux/arch/mips/kernel/traps.c-orig	Thu Oct 29 17:23:19 1998
+++ linux/arch/mips/kernel/traps.c	Fri Oct 30 13:25:21 1998
@@ -6,6 +6,7 @@
  *
  * Copyright 1994, 1995, 1996, 1997, 1998 by Ralf Baechle
  * Modified for R3000 by Paul M. Antoine, 1995, 1996
+ * Complete output from die() by Ulf Carlsson, 1998
  */
 #include <linux/config.h>
 #include <linux/init.h>
@@ -80,50 +81,61 @@
  * This routine abuses get_user()/put_user() to reference pointers
  * with at least a bit of error checking ...
  */
-void show_registers(char * str, struct pt_regs * regs, long err)
+void show_stack(unsigned int *sp)
 {
-	int	i;
-	int	*stack;
-	u32	*sp, *pc, addr, module_start, module_end;
-	extern	char start_kernel, _etext;
+	int i;
+	unsigned int *stack;
 
-	sp = (u32 *)regs->regs[29];
-	pc = (u32 *)regs->cp0_epc;
+	stack = sp;
+	i = 0;
 
-	show_regs(regs);
+	printk("Stack:");
+	while ((unsigned long) stack & (PAGE_SIZE - 1)) {
+		unsigned long stackdata;
 
-	/*
-	 * Dump the stack
-	 */
-	printk("Process %s (pid: %ld, stackpage=%08lx)\nStack: ",
-		current->comm, current->pid, (unsigned long)current);
-	for(i=0;i<5;i++)
-		printk("%08x ", *sp++);
-	stack = (int *) sp;
+		if (__get_user(stackdata, stack++)) {
+			printk(" (Bad stack address)");
+			break;
+		}
 
-	for(i=0; i < kstack_depth_to_print; i++) {
-		unsigned int stackdata;
+		printk(" %08lx", stackdata);
 
-		if (((u32) stack & (PAGE_SIZE -1)) == 0)
-			break;
-		if (i && ((i % 8) == 0))
-			printk("\n       ");
-		if (get_user(stackdata, stack++) < 0) {
-			printk("(Bad stack address)");
+		if (++i > 40) {
+			printk(" ...");
 			break;
 		}
-		printk("%08x ", stackdata);
+
+		if (i % 8 == 0)
+			printk("\n      ");
 	}
-	printk("\nCall Trace: ");
-	stack = (int *)sp;
-	i = 1;
+}
+
+void show_trace(unsigned int *sp)
+{
+	int i;
+	unsigned int *stack;
+	unsigned long kernel_start, kernel_end;
+	unsigned long module_start, module_end;
+	extern char _stext, _etext;
+
+	stack = sp;
+	i = 0;
+
+	kernel_start = (unsigned long) &_stext;
+	kernel_end = (unsigned long) &_etext;
 	module_start = VMALLOC_START;
 	module_end = module_start + MODULE_RANGE;
-	while (((unsigned long)stack & (PAGE_SIZE -1)) != 0) {
-		if (get_user(addr, stack++) < 0) {
-			printk("(Bad address)\n");
+
+	printk("\nCall Trace:");
+
+	while ((unsigned long) stack & (PAGE_SIZE -1)) {
+		unsigned long addr;
+
+		if (__get_user(addr, stack++)) {
+			printk(" (Bad stack address)\n");
 			break;
 		}
+
 		/*
 		 * If the address is either in the text segment of the
 		 * kernel, or in the region which contains vmalloc'ed
@@ -132,26 +144,33 @@
 		 * down the cause of the crash will be able to figure
 		 * out the call path that was taken.
 		 */
-		if (((addr >= (u32) &start_kernel) &&
-		     (addr <= (u32) &_etext)) ||
-		    ((addr >= module_start) && (addr <= module_end))) {
-			if (i && ((i % 8) == 0))
-				printk("\n       ");
-			printk("%08x ", addr);
-			i++;
+
+		if ((addr >= kernel_start && addr < kernel_end) ||
+		    (addr >= module_start && addr < module_end)) { 
+
+			printk(" [<%08lx>]", addr);
+			if (++i > 40) {
+				printk(" ...");
+				break;
+			}
 		}
 	}
+}
 
-	printk("\nCode : ");
-	if ((KSEGX(pc) == KSEG0 || KSEGX(pc) == KSEG1) &&
-	    (((unsigned long) pc & 3) == 0))
-	{
-		for(i=0;i<5;i++)
-			printk("%08x ", *pc++);
-		printk("\n");
+void show_code(unsigned int *pc)
+{
+	long i;
+
+	printk("\nCode:");
+
+	for(i = -3 ; i < 6 ; i++) {
+		unsigned long insn;
+		if (__get_user(insn, pc + i)) {
+			printk(" (Bad address in epc)\n");
+			break;
+		}
+		printk("%c%08lx%c",(i?' ':'<'),insn,(i?' ':'>'));
 	}
-	else
-		printk("(Bad address in epc)\n");
 }
 
 void die(const char * str, struct pt_regs * regs, unsigned long err)
@@ -162,6 +181,12 @@
 	console_verbose();
 	printk("%s: %04lx\n", str, err & 0xffff);
 	show_regs(regs);
+	printk("Process %s (pid: %ld, stackpage=%08lx)\n",
+		current->comm, current->pid, (unsigned long) current);
+	show_stack((unsigned int *) regs->regs[29]);
+	show_trace((unsigned int *) regs->regs[29]);
+	show_code((unsigned int *) regs->cp0_epc);
+	printk("\n");
 	do_exit(SIGSEGV);
 }
 

--oyUTqETQ0mS9luUI--
