Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5ANwXnC032756
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 10 Jun 2002 16:58:33 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5ANwXxn032755
	for linux-mips-outgoing; Mon, 10 Jun 2002 16:58:33 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from localhost.localdomain (ip68-6-25-170.hu.sd.cox.net [68.6.25.170])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5ANwRnC032752
	for <linux-mips@oss.sgi.com>; Mon, 10 Jun 2002 16:58:28 -0700
Received: (from justin@localhost)
	by localhost.localdomain (8.11.6/8.11.6) id g5B003m01181;
	Mon, 10 Jun 2002 17:00:03 -0700
X-Authentication-Warning: localhost.localdomain: justin set sender to justin@cs.cmu.edu using -f
Subject: Re: Atomicity & preemptive kernels
From: Justin Carlson <justin@cs.cmu.edu>
To: Jun Sun <jsun@mvista.com>
Cc: linux-mips@oss.sgi.com
In-Reply-To: <3D0524B5.403@mvista.com>
References: <1023738247.1133.56.camel@localhost.localdomain> 
	<3D0524B5.403@mvista.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 10 Jun 2002 17:00:03 -0700
Message-Id: <1023753603.1152.28.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 2002-06-10 at 15:14, Jun Sun wrote:
> I am not sure if I am following your logic, but I don't see a race condition here.
> 
> Once current->mm is read into a register, the register is saved into stack 
> when an interrupt happens (which later incurs a reschedule presumbably).  When 
> the current preempted process comes back later, it goes back to the "tail" of 
> do_IRQ(), followed by restoring the registers.  Since the register now holds 
> the right value, set_entryhi() should be correct.
> 

You've described exactly what happens.  The only problem is, it's
possible the underlying value for current->mm has changed.  It's a
*really* narrow window, at most a cycle or two, but I think it is
there.  In addition, even if you hit the window, to trigger wrong
behavior it requires that you also saturate the local ASID space,
invoking the tlb flush and asid reset in get_mmu_context().

The change that's introduced by the preemptive kernel is that
switch_mm() can be called after an interrupt.  So, with some
hypothetical assembly, the code flow looks like this:

	lw	$1, 120($29) ; Load current->mm->context into a register
         * Interrupt happens *
	 * reschedule happens, switch_mm() is called *
	   * get_new_mmu_context() invoked, starts a new ASID cycle.
	   * current->mm->context for the original process changes
	 * (sometime later) switch back to original process
	mtc0 	$entryhi, $1 ; stale context put back into entryhi!

Does that make more sense?  It's really a tiny race, but I think it's a
real one.  

-Justin
	   
