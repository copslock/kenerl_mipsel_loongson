Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g441d3wJ001360
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 3 May 2002 18:39:03 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g441d39u001359
	for linux-mips-outgoing; Fri, 3 May 2002 18:39:03 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g441cswJ001356
	for <linux-mips@oss.sgi.com>; Fri, 3 May 2002 18:38:54 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g441e0p01320;
	Fri, 3 May 2002 18:40:00 -0700
Date: Fri, 3 May 2002 18:40:00 -0700
From: Ralf Baechle <ralf@oss.sgi.com>
To: Jun Sun <jsun@mvista.com>
Cc: linux-mips <linux-mips@oss.sgi.com>
Subject: Re: what is the right behavior of copy_to_user(0x0, ..., ...)?
Message-ID: <20020503184000.A1238@dea.linux-mips.net>
References: <3CD3052B.1050400@mvista.com> <20020503162337.A27366@dea.linux-mips.net> <3CD32044.9040109@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3CD32044.9040109@mvista.com>; from jsun@mvista.com on Fri, May 03, 2002 at 04:41:56PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, May 03, 2002 at 04:41:56PM -0700, Jun Sun wrote:

> It appears earlier version of kernel does not have this problem.  I have not 
> fully figured out why.

We didn't handle exceptions in branch delay slots.  Try this patch and
tell me if it helps.

  Ralf

Index: arch/mips/mm/fault.c
===================================================================
RCS file: /home/pub/cvs/linux/arch/mips/mm/fault.c,v
retrieving revision 1.25.2.2
diff -u -r1.25.2.2 fault.c
--- arch/mips/mm/fault.c	16 Jan 2002 03:49:24 -0000	1.25.2.2
+++ arch/mips/mm/fault.c	4 May 2002 01:28:34 -0000
@@ -19,6 +19,7 @@
 #include <linux/smp_lock.h>
 #include <linux/version.h>
 
+#include <asm/branch.h>
 #include <asm/hardirq.h>
 #include <asm/pgalloc.h>
 #include <asm/mmu_context.h>
@@ -77,7 +78,7 @@
 	struct vm_area_struct * vma;
 	struct task_struct *tsk = current;
 	struct mm_struct *mm = tsk->mm;
-	unsigned long fixup;
+	unsigned long epc, fixup;
 	siginfo_t info;
 
 	/*
@@ -181,7 +182,8 @@
 
 no_context:
 	/* Are we prepared to handle this kernel fault?  */
-	fixup = search_exception_table(regs->cp0_epc);
+	epc = regs->cp0_epc + delay_slot(regs) ? 4 : 0;
+	fixup = search_exception_table(epc);
 	if (fixup) {
 		long new_epc;
 
Index: arch/mips64/mm/fault.c
===================================================================
RCS file: /home/pub/cvs/linux/arch/mips64/mm/fault.c,v
retrieving revision 1.26.2.6
diff -u -r1.26.2.6 fault.c
--- arch/mips64/mm/fault.c	23 Feb 2002 02:16:42 -0000	1.26.2.6
+++ arch/mips64/mm/fault.c	4 May 2002 01:28:34 -0000
@@ -21,6 +21,7 @@
 #include <linux/smp_lock.h>
 #include <linux/version.h>
 
+#include <asm/branch.h>
 #include <asm/hardirq.h>
 #include <asm/pgalloc.h>
 #include <asm/mmu_context.h>
@@ -103,7 +104,7 @@
 	struct vm_area_struct * vma;
 	struct task_struct *tsk = current;
 	struct mm_struct *mm = tsk->mm;
-	unsigned long fixup;
+	unsigned long epc, fixup;
 	siginfo_t info;
 
 #if 0
@@ -208,7 +209,8 @@
 
 no_context:
 	/* Are we prepared to handle this kernel fault?  */
-	fixup = search_exception_table(regs->cp0_epc);
+	epc = regs->cp0_epc + delay_slot(regs) ? 4 : 0;
+	fixup = search_exception_table(epc);
 	if (fixup) {
 		long new_epc;
 
