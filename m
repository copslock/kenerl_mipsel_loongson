Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4L0DhnC030783
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 20 May 2002 17:13:43 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4L0DhFt030782
	for linux-mips-outgoing; Mon, 20 May 2002 17:13:43 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from ayrnetworks.com (64-166-72-142.ayrnetworks.com [64.166.72.142])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4L0DcnC030777
	for <linux-mips@oss.sgi.com>; Mon, 20 May 2002 17:13:38 -0700
Received: (from wjhun@localhost)
	by  ayrnetworks.com (8.11.2/8.11.2) id g4L0DKg26560
	for linux-mips@oss.sgi.com; Mon, 20 May 2002 17:13:20 -0700
Date: Mon, 20 May 2002 17:13:20 -0700
From: William Jhun <wjhun@ayrnetworks.com>
To: linux-mips@oss.sgi.com
Subject: [PATCH] arch/mips/kernel/irq.c: do_IRQ() return value
Message-ID: <20020520171320.J20837@ayrnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Though a comment in arch/i386/kernel/irq.c: do_IRQ() clearly states:

         * 0 return value means that this irq is already being
         * handled by some other CPU. (or is disabled)

it seems that the function can only ever return (1). We wrote some low-level
interrupt handling code that depends on the correct value of this function.
Is the following patch what was initially desired? Clearly this code came
from (or vice-versa) arch/i386/kernel/irq.c. I've sent a patch out for that
version to linux-kernel.

Thanks,
William Jhun

Index: arch/mips/kernel/irq.c
===================================================================
RCS file: /cvs/linux/arch/mips/kernel/irq.c,v
retrieving revision 1.38.2.6
diff -c -r1.38.2.6 irq.c
*** arch/mips/kernel/irq.c	2002/05/15 20:41:13	1.38.2.6
--- arch/mips/kernel/irq.c	2002/05/21 00:10:11
***************
*** 488,494 ****
  
  	if (softirq_pending(cpu))
  		do_softirq();
! 	return 1;
  }
  
  /**
--- 488,494 ----
  
  	if (softirq_pending(cpu))
  		do_softirq();
! 	return (action != NULL);
  }
  
  /**
