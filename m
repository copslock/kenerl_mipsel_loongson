Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5BIkNnC017069
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 11 Jun 2002 11:46:23 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5BIkNHb017068
	for linux-mips-outgoing; Tue, 11 Jun 2002 11:46:23 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5BIkGnC017065
	for <linux-mips@oss.sgi.com>; Tue, 11 Jun 2002 11:46:16 -0700
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id LAA14072;
	Tue, 11 Jun 2002 11:46:30 -0700
Message-ID: <3D0644F4.8070902@mvista.com>
Date: Tue, 11 Jun 2002 11:44:04 -0700
From: Jun Sun <jsun@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2.1) Gecko/20010901
X-Accept-Language: en-us
MIME-Version: 1.0
To: Justin Carlson <justin@cs.cmu.edu>
CC: linux-mips@oss.sgi.com
Subject: Re: Atomicity & preemptive kernels
References: <1023738247.1133.56.camel@localhost.localdomain> 	<3D0524B5.403@mvista.com> <1023753603.1152.28.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Justin Carlson wrote:

> On Mon, 2002-06-10 at 15:14, Jun Sun wrote:
> 
>>I am not sure if I am following your logic, but I don't see a race condition here.
>>
>>Once current->mm is read into a register, the register is saved into stack 
>>when an interrupt happens (which later incurs a reschedule presumbably).  When 
>>the current preempted process comes back later, it goes back to the "tail" of 
>>do_IRQ(), followed by restoring the registers.  Since the register now holds 
>>the right value, set_entryhi() should be correct.
>>
>>
> 
> You've described exactly what happens.  The only problem is, it's
> possible the underlying value for current->mm has changed.  It's a
> *really* narrow window, at most a cycle or two, but I think it is
> there.  In addition, even if you hit the window, to trigger wrong
> behavior it requires that you also saturate the local ASID space,
> invoking the tlb flush and asid reset in get_mmu_context().
> 
> The change that's introduced by the preemptive kernel is that
> switch_mm() can be called after an interrupt.  So, with some
> hypothetical assembly, the code flow looks like this:
> 
> 	lw	$1, 120($29) ; Load current->mm->context into a register
>          * Interrupt happens *
> 	 * reschedule happens, switch_mm() is called *
> 	   * get_new_mmu_context() invoked, starts a new ASID cycle.
> 	   * current->mm->context for the original process changes
> 	 * (sometime later) switch back to original process
> 	mtc0 	$entryhi, $1 ; stale context put back into entryhi!
> 
> Does that make more sense?  It's really a tiny race, but I think it's a
> real one.  
> 


I see your point now.

However, the race is not there.  switch_mm() is only called from inside 
schedule() function, which as a whole is preemption-safe.  In other words, the 
above event sequence won't cause a context switch until we exit from 
schedule() function.

Jun
