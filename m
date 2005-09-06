Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Sep 2005 17:34:57 +0100 (BST)
Received: from mba.ocn.ne.jp ([IPv6:::ffff:210.190.142.172]:59372 "HELO
	smtp.mba.ocn.ne.jp") by linux-mips.org with SMTP
	id <S8225548AbVIFQee>; Tue, 6 Sep 2005 17:34:34 +0100
Received: from localhost (p4135-ipad30funabasi.chiba.ocn.ne.jp [221.184.79.135])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 18EB68463; Wed,  7 Sep 2005 01:41:26 +0900 (JST)
Date:	Wed, 07 Sep 2005 01:42:34 +0900 (JST)
Message-Id: <20050907.014234.108739386.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: unkillable process due to setup_frame() failure
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
X-archive-position: 8880
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

For a long time, this test program is unkillable (by SIGKILL) on
Linux/MIPS.

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
	setup_signal(SIGTRAP);

	__asm__ __volatile__("move $29,$0");
	__asm__ __volatile__("break");
	printf("done!\n");
	return 0;
}

If we run this program,

1.  The "break" instruction raises a exception.
2.  The exception handler queues SIGTRAP(5).
3.  dequeue_signal() dequeue a signal with LOWEST number (i.e. SIGTRAP).
4.  setup_frame() fails due to bad stack pointer and queues SIGSEGV(11).
5.  returns to user process (pc unchanged).
6.  goto 1. (forever)

So, the process can not be kill by SIGKILL.  In 2.6.12, 'sigkill
priority fix' was applied to __dequeue_signal(), but it does not help
while the SIGTRAP is queued to tsk->pending but SIGKILL (by kill
command) is queued to tsk->signal->shared_pending.

I have two proposal fix:

1. Now do_signal() returns 0 if setup_frame() failed.  Therefore if
   do_signal returned 0 (and there is still pending signal), calling
   do_signal again will handle the SIGSIGV.  Like this:

--- linux-mips/arch/mips/kernel/signal.c	2005-08-30 11:02:00.000000000 +0900
+++ linux/arch/mips/kernel/signal.c	2005-09-06 15:07:45.000000000 +0900
@@ -481,6 +481,10 @@
 {
 	/* deal with pending signal delivery */
 	if (thread_info_flags & _TIF_SIGPENDING) {
-		current->thread.abi->do_signal(oldset, regs);
+		if (unlikely(!current->thread.abi->do_signal(oldset, regs)) &&
+		    unlikely(signal_pending(current))) {
+			/* SIGSEGV mighe be sent in setup_frame */
+			current->thread.abi->do_signal(oldset, regs);
+		}
 	}
 }



2. Make 'sigkill priority fix' can handle this case.  First search
   SIGKILL in tsk->pending and tsk->signal->shared_pending, then
   search another signals.  Like this:

--- linux-mips/kernel/signal.c	2005-08-29 08:41:01.000000000 +0900
+++ linux/kernel/signal.c	2005-09-07 01:33:52.338420760 +0900
@@ -520,19 +520,14 @@
 }
 
 static int __dequeue_signal(struct sigpending *pending, sigset_t *mask,
-			siginfo_t *info)
+			siginfo_t *info, int sig)
 {
-	int sig = 0;
-
-	/* SIGKILL must have priority, otherwise it is quite easy
-	 * to create an unkillable process, sending sig < SIGKILL
-	 * to self */
-	if (unlikely(sigismember(&pending->signal, SIGKILL))) {
-		if (!sigismember(mask, SIGKILL))
-			sig = SIGKILL;
-	}
-
-	if (likely(!sig))
+	if (sig) {
+		/* check signal with priority first */
+		if (likely(!sigismember(&pending->signal, sig)) ||
+		    sigismember(mask, sig))
+			sig = 0;
+	} else
 		sig = next_signal(pending, mask);
 	if (sig) {
 		if (current->notifier) {
@@ -561,10 +556,18 @@
  */
 int dequeue_signal(struct task_struct *tsk, sigset_t *mask, siginfo_t *info)
 {
-	int signr = __dequeue_signal(&tsk->pending, mask, info);
+	/* SIGKILL must have priority, otherwise it is quite easy
+	 * to create an unkillable process, sending sig < SIGKILL
+	 * to self */
+	int signr = __dequeue_signal(&tsk->pending, mask, info, SIGKILL);
+	if (likely(!signr))
+		signr = __dequeue_signal(&tsk->signal->shared_pending,
+					 mask, info, SIGKILL);
+	if (likely(!signr))
+		signr = __dequeue_signal(&tsk->pending, mask, info, 0);
 	if (!signr)
 		signr = __dequeue_signal(&tsk->signal->shared_pending,
-					 mask, info);
+					 mask, info, 0);
  	if (signr && unlikely(sig_kernel_stop(signr))) {
  		/*
  		 * Set a marker that we have dequeued a stop signal.  Our


Which are preferred?  Or is there other solutions?

---
Atsushi Nemoto
