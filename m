Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5AMFsnC028654
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 10 Jun 2002 15:15:54 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5AMFsqx028653
	for linux-mips-outgoing; Mon, 10 Jun 2002 15:15:54 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5AMFmnC028649
	for <linux-mips@oss.sgi.com>; Mon, 10 Jun 2002 15:15:48 -0700
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id PAA15096;
	Mon, 10 Jun 2002 15:16:02 -0700
Message-ID: <3D0524B5.403@mvista.com>
Date: Mon, 10 Jun 2002 15:14:13 -0700
From: Jun Sun <jsun@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2.1) Gecko/20010901
X-Accept-Language: en-us
MIME-Version: 1.0
To: Justin Carlson <justin@cs.cmu.edu>
CC: linux-mips@oss.sgi.com
Subject: Re: Atomicity & preemptive kernels
References: <1023738247.1133.56.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Justin Carlson wrote:

> I know we're not there yet, but I'm trying to understand some issues
> with rml's preemptive kernel and ASID's.
> 
> While doing a virtually-tagged hit invalidate of a cache, I was going to
> write code something like this;
> 
> set_entryhi(CPU_CONTEXT(cpu, mm->vm_mm));
> hit_invalidate_range(start, end);
> set_entryhi(CPU_CONTEXT(cpu, current->mm));
> 
> Insofar as I understand current kernel scheduling guarantees, this is
> safe because we won't reschedule while running in kernel mode.  But, if
> I'm looking ahead to the preemptive kernel, then I think there is a
> slight window for a race in between the reading of current->mm and 
> the setting of entryhi.  Something like this:
> 
> current->mm->context is read
>   * kernel reschedules.  
>   * switch_mm() called
>   * current->mm->context changes on return to this process
> entryhi is set to the wrong context.
> 
> Is this a real race? 


I am not sure if I am following your logic, but I don't see a race condition here.

Once current->mm is read into a register, the register is saved into stack 
when an interrupt happens (which later incurs a reschedule presumbably).  When 
the current preempted process comes back later, it goes back to the "tail" of 
do_IRQ(), followed by restoring the registers.  Since the register now holds 
the right value, set_entryhi() should be correct.

BTW, I have preemptiable kernel working fine under both UP and SMP.  If there 
is much interestes, I will publish it on the list.

Jun
