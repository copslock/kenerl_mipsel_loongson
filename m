Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8803EB23086
	for linux-mips-outgoing; Fri, 7 Sep 2001 17:03:14 -0700
Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f88036d23080
	for <linux-mips@oss.sgi.com>; Fri, 7 Sep 2001 17:03:06 -0700
Received: from dea.linux-mips.net (u-10-20.karlsruhe.ipdial.viaginterkom.de [62.180.20.10]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id RAA04544
	for <linux-mips@oss.sgi.com>; Fri, 7 Sep 2001 17:00:35 -0700 (PDT)
	mail_from (ralf@linux-mips.net)
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id f87NacK21302;
	Sat, 8 Sep 2001 01:36:38 +0200
Date: Sat, 8 Sep 2001 01:36:38 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
Cc: linux-mips@oss.sgi.com
Subject: Re: setup_frame() failure
Message-ID: <20010908013638.A19154@dea.linux-mips.net>
References: <20010907.202652.71083122.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010907.202652.71083122.nemoto@toshiba-tops.co.jp>; from nemoto@toshiba-tops.co.jp on Fri, Sep 07, 2001 at 08:26:52PM +0900
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Sep 07, 2001 at 08:26:52PM +0900, Atsushi Nemoto wrote:

> I found that if setup_frame() fails in certain conditions the process
> which caused the signal grabs CPU and never be killed.
> 
> Here is a sample test program.
> 
> #include <stdio.h>
> #include <stdlib.h>
> #include <signal.h>
> 
> void sighandler(int sig)
> {
> 	printf("SIGNAL %d!\n", sig);
> 	exit(2);
> }
> void setup_signal(int sig)
> {
> 	struct sigaction act;
> 	memset(&act, 0, sizeof(act));
> 	act.sa_handler = sighandler;
> 	act.sa_flags = SA_NOMASK | SA_RESTART;
> 	sigaction(sig, &act, 0);
> }
> 
> int main(int argc, char **argv)
> {
> 	setup_signal(SIGILL);
> 	setup_signal(SIGQUIT);
> 	setup_signal(SIGINT);
> 
> 	__asm__ __volatile__("move $29,$0");
> 	__asm__ __volatile__("mfc0 $0,$0");
> 	printf("done!\n");
> 	return 0;
> }
> 
> 
> This program setups signal handlers and causes Coprocessor Unusable
> Exception with $sp == 0.
> 
> If we run this program,
> 
> 1.  "mfc1" instruction raises a exception.
> 2.  The exception handler queues SIGILL(4).
> 3.  do_signal() dequeue a signal with LOWEST number.
> 4.  setup_frame() fails and queues SIGSEGV(11).
> 5.  returns to user process.
> 6.  again from 1. (forever)
> 
> So, even SIGKILL can not kill the process.  (SIGHUP can do it).
> 
> I make a change for do_signal() to check failure of setup_frame() and
> continue processing pending signals.  It seems work for me.  Here is
> the patch.  Any comments are welcome.

Nice test case.  Thanks. I decied for a differnet fix attached below.

  Ralf

Index: arch/mips64/kernel/traps.c
===================================================================
RCS file: /home/pub/cvs/linux/arch/mips64/kernel/traps.c,v
retrieving revision 1.20
diff -u -r1.20 traps.c
--- arch/mips64/kernel/traps.c 2001/07/11 23:32:54 1.20  
+++ arch/mips64/kernel/traps.c 2001/09/07 23:29:16   
@@ -347,11 +347,9 @@
 
 void do_ri(struct pt_regs *regs)
 {
-	printk("Cpu%d[%s:%d] Illegal instruction at %08lx ra=%08lx\n",
-	        smp_processor_id(), current->comm, current->pid, regs->cp0_epc, 
-		regs->regs[31]);
 	if (compute_return_epc(regs))
 		return;
+
 	force_sig(SIGILL, current);
 }
 
@@ -388,6 +386,7 @@
 	return;
 
 bad_cid:
+	compute_return_epc(regs);
 	force_sig(SIGILL, current);
 }
 
Index: arch/mips/kernel/traps.c
===================================================================
RCS file: /home/pub/cvs/linux/arch/mips/kernel/traps.c,v
retrieving revision 1.78
diff -u -r1.78 traps.c
--- arch/mips/kernel/traps.c 2001/09/06 13:22:24 1.78  
+++ arch/mips/kernel/traps.c 2001/09/07 23:29:16   
@@ -606,9 +606,6 @@
 
 asmlinkage void do_ri(struct pt_regs *regs)
 {
-	unsigned int opcode;
-
-	get_insn_opcode(regs, &opcode);
 	if (compute_return_epc(regs))
 		return;
 
@@ -659,6 +656,7 @@
 	return;
 
 bad_cid:
+	compute_return_epc(regs);
 	force_sig(SIGILL, current);
 }
 
