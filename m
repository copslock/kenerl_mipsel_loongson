Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f87BMR610176
	for linux-mips-outgoing; Fri, 7 Sep 2001 04:22:27 -0700
Received: from topsns.toshiba-tops.co.jp (topsns.toshiba-tops.co.jp [202.230.225.5])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f87BMGd10173
	for <linux-mips@oss.sgi.com>; Fri, 7 Sep 2001 04:22:17 -0700
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for oss.sgi.com [216.32.174.27]) with SMTP; 7 Sep 2001 11:22:16 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP
	id 8C7FFB458; Fri,  7 Sep 2001 20:22:14 +0900 (JST)
Received: by srd2sd.toshiba-tops.co.jp (8.9.3/3.5Wbeta-srd2sd) with ESMTP
	id UAA66116; Fri, 7 Sep 2001 20:22:11 +0900 (JST)
Date: Fri, 07 Sep 2001 20:26:52 +0900 (JST)
Message-Id: <20010907.202652.71083122.nemoto@toshiba-tops.co.jp>
To: linux-mips@oss.sgi.com
Cc: Ralf Baechle <ralf@uni-koblenz.de>
Subject: setup_frame() failure
From: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
X-Mailer: Mew version 2.0 on Emacs 20.7 / Mule 4.1 (AOI)
X-Fingerprint: EC 9D B9 17 2E 89 D2 25  CE F5 5D 3D 12 29 2A AD
X-Pgp-Public-Key: http://pgp.nic.ad.jp/cgi-bin/pgpsearchkey.pl?op=get&search=0xB6D728B1
Organization: TOSHIBA Personal Computer System Corporation
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
 boundary="--Next_Part(Fri_Sep__7_20:26:52_2001_026)--"
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

----Next_Part(Fri_Sep__7_20:26:52_2001_026)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On 07 Dec 2000, Carsten Langgaard posted a question about failure of
setup_frame() function. (and there was no response on ML)

I found that if setup_frame() fails in certain conditions the process
which caused the signal grabs CPU and never be killed.

Here is a sample test program.

#include <stdio.h>
#include <stdlib.h>
#include <signal.h>

void sighandler(int sig)
{
	printf("SIGNAL %d!\n", sig);
	exit(2);
}
void setup_signal(int sig)
{
	struct sigaction act;
	memset(&act, 0, sizeof(act));
	act.sa_handler = sighandler;
	act.sa_flags = SA_NOMASK | SA_RESTART;
	sigaction(sig, &act, 0);
}

int main(int argc, char **argv)
{
	setup_signal(SIGILL);
	setup_signal(SIGQUIT);
	setup_signal(SIGINT);

	__asm__ __volatile__("move $29,$0");
	__asm__ __volatile__("mfc0 $0,$0");
	printf("done!\n");
	return 0;
}


This program setups signal handlers and causes Coprocessor Unusable
Exception with $sp == 0.

If we run this program,

1.  "mfc1" instruction raises a exception.
2.  The exception handler queues SIGILL(4).
3.  do_signal() dequeue a signal with LOWEST number.
4.  setup_frame() fails and queues SIGSEGV(11).
5.  returns to user process.
6.  again from 1. (forever)

So, even SIGKILL can not kill the process.  (SIGHUP can do it).

I make a change for do_signal() to check failure of setup_frame() and
continue processing pending signals.  It seems work for me.  Here is
the patch.  Any comments are welcome.

---
Atsushi Nemoto

----Next_Part(Fri_Sep__7_20:26:52_2001_026)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="signal.c.patch"

diff -ur linux.sgi/arch/mips/kernel/signal.c linux/arch/mips/kernel/signal.c
--- linux.sgi/arch/mips/kernel/signal.c	Mon Jun 25 22:56:56 2001
+++ linux/arch/mips/kernel/signal.c	Fri Sep  7 18:52:23 2001
@@ -382,7 +382,7 @@
 	return (void *)((sp - frame_size) & ALMASK);
 }
 
-static void inline
+static int inline
 setup_frame(struct k_sigaction * ka, struct pt_regs *regs,
             int signr, sigset_t *set)
 {
@@ -437,15 +437,16 @@
 	printk("SIG deliver (%s:%d): sp=0x%p pc=0x%p ra=0x%p\n",
 	       current->comm, current->pid, frame, regs->cp0_epc, frame->code);
 #endif
-        return;
+	return 0;
 
 give_sigsegv:
 	if (signr == SIGSEGV)
 		ka->sa.sa_handler = SIG_DFL;
 	force_sig(SIGSEGV, current);
+	return SIGSEGV;
 }
 
-static void inline
+static int inline
 setup_rt_frame(struct k_sigaction * ka, struct pt_regs *regs,
                int signr, sigset_t *set, siginfo_t *info)
 {
@@ -513,22 +514,26 @@
 	printk("SIG deliver (%s:%d): sp=0x%p pc=0x%p ra=0x%p\n",
 	       current->comm, current->pid, frame, regs->cp0_epc, frame->code);
 #endif
-	return;
+	return 0;
 
 give_sigsegv:
 	if (signr == SIGSEGV)
 		ka->sa.sa_handler = SIG_DFL;
 	force_sig(SIGSEGV, current);
+	return SIGSEGV;
 }
 
-static inline void
+static inline int
 handle_signal(unsigned long sig, struct k_sigaction *ka,
 	siginfo_t *info, sigset_t *oldset, struct pt_regs * regs)
 {
+	int newsig;
 	if (ka->sa.sa_flags & SA_SIGINFO)
-		setup_rt_frame(ka, regs, sig, oldset, info);
+		newsig = setup_rt_frame(ka, regs, sig, oldset, info);
 	else
-		setup_frame(ka, regs, sig, oldset);
+		newsig = setup_frame(ka, regs, sig, oldset);
+	if (newsig)
+		return newsig;
 
 	if (ka->sa.sa_flags & SA_ONESHOT)
 		ka->sa.sa_handler = SIG_DFL;
@@ -539,6 +544,7 @@
 		recalc_sigpending(current);
 		spin_unlock_irq(&current->sigmask_lock);
 	}
+	return 0;
 }
 
 static inline void
@@ -672,8 +678,9 @@
 		if (regs->regs[0])
 			syscall_restart(regs, ka);
 		/* Whee!  Actually deliver the signal.  */
-		handle_signal(signr, ka, &info, oldset, regs);
-		return 1;
+		if (handle_signal(signr, ka, &info, oldset, regs) == 0)
+			return 1;
+		/* another signal queued.  continue. */
 	}
 
 	/*

----Next_Part(Fri_Sep__7_20:26:52_2001_026)----
