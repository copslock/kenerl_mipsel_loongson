Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5AJgZnC026769
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 10 Jun 2002 12:42:36 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5AJgZUq026768
	for linux-mips-outgoing; Mon, 10 Jun 2002 12:42:35 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from localhost.localdomain (ip68-6-25-170.hu.sd.cox.net [68.6.25.170])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5AJgVnC026765
	for <linux-mips@oss.sgi.com>; Mon, 10 Jun 2002 12:42:31 -0700
Received: (from justin@localhost)
	by localhost.localdomain (8.11.6/8.11.6) id g5AJi8k01696;
	Mon, 10 Jun 2002 12:44:08 -0700
X-Authentication-Warning: localhost.localdomain: justin set sender to justin@cs.cmu.edu using -f
Subject: Atomicity & preemptive kernels
From: Justin Carlson <justin@cs.cmu.edu>
To: linux-mips@oss.sgi.com
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 10 Jun 2002 12:44:07 -0700
Message-Id: <1023738247.1133.56.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I know we're not there yet, but I'm trying to understand some issues
with rml's preemptive kernel and ASID's.

While doing a virtually-tagged hit invalidate of a cache, I was going to
write code something like this;

set_entryhi(CPU_CONTEXT(cpu, mm->vm_mm));
hit_invalidate_range(start, end);
set_entryhi(CPU_CONTEXT(cpu, current->mm));

Insofar as I understand current kernel scheduling guarantees, this is
safe because we won't reschedule while running in kernel mode.  But, if
I'm looking ahead to the preemptive kernel, then I think there is a
slight window for a race in between the reading of current->mm and 
the setting of entryhi.  Something like this:

current->mm->context is read
  * kernel reschedules.  
  * switch_mm() called
  * current->mm->context changes on return to this process
entryhi is set to the wrong context.

Is this a real race?  If so, is there any way around it other than
locally disabling interrupts around the restoration of the context?

-Justin
 
