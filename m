Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Jan 2005 05:41:43 +0000 (GMT)
Received: from nevyn.them.org ([IPv6:::ffff:66.93.172.17]:49294 "EHLO
	nevyn.them.org") by linux-mips.org with ESMTP id <S8224893AbVAUFle>;
	Fri, 21 Jan 2005 05:41:34 +0000
Received: from drow by nevyn.them.org with local (Exim 4.43 #1 (Debian))
	id 1CrrXj-0004Ro-Tp
	for <linux-mips@linux-mips.org>; Fri, 21 Jan 2005 00:41:12 -0500
Date:	Fri, 21 Jan 2005 00:41:11 -0500
From:	Daniel Jacobowitz <dan@debian.org>
To:	linux-mips@linux-mips.org
Subject: Fix sys32_rt_sigtimedwait
Message-ID: <20050121054111.GA17070@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Return-Path: <drow@nevyn.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6976
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

The copy of this logic in arch/mips/ has gotten out of sync with the copy in
kernel/ - fatally so.  Because it doesn't set real_blocked, sigwaiting for a
blocked but otherwise fatal signal may cause the thread group to exit.

Signed-off-by: Daniel Jacobowitz <dan@codesourcery.com>

Index: linux/arch/mips/kernel/signal32.c
===================================================================
--- linux.orig/arch/mips/kernel/signal32.c	2005-01-20 18:43:07.056683648 -0500
+++ linux/arch/mips/kernel/signal32.c	2005-01-21 00:34:37.213772391 -0500
@@ -948,25 +948,29 @@
 	spin_lock_irq(&current->sighand->siglock);
 	sig = dequeue_signal(current, &these, &info);
 	if (!sig) {
-		/* None ready -- temporarily unblock those we're interested
-		   in so that we'll be awakened when they arrive.  */
-		sigset_t oldblocked = current->blocked;
-		sigandsets(&current->blocked, &current->blocked, &these);
-		recalc_sigpending();
-		spin_unlock_irq(&current->sighand->siglock);
-
 		timeout = MAX_SCHEDULE_TIMEOUT;
 		if (uts)
 			timeout = (timespec_to_jiffies(&ts)
 				   + (ts.tv_sec || ts.tv_nsec));
 
-		current->state = TASK_INTERRUPTIBLE;
-		timeout = schedule_timeout(timeout);
-
-		spin_lock_irq(&current->sighand->siglock);
-		sig = dequeue_signal(current, &these, &info);
-		current->blocked = oldblocked;
-		recalc_sigpending();
+		if (timeout) {
+			/* None ready -- temporarily unblock those we're
+			 * interested while we are sleeping in so that we'll
+			 * be awakened when they arrive.  */
+			current->real_blocked = current->blocked;
+			sigandsets(&current->blocked, &current->blocked, &these);
+			recalc_sigpending();
+			spin_unlock_irq(&current->sighand->siglock);
+
+			current->state = TASK_INTERRUPTIBLE;
+			timeout = schedule_timeout(timeout);
+
+			spin_lock_irq(&current->sighand->siglock);
+			sig = dequeue_signal(current, &these, &info);
+			current->blocked = current->real_blocked;
+			siginitset(&current->real_blocked, 0);
+			recalc_sigpending();
+		}
 	}
 	spin_unlock_irq(&current->sighand->siglock);
 

-- 
Daniel Jacobowitz
