Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1K2DHe01072
	for linux-mips-outgoing; Tue, 19 Feb 2002 18:13:17 -0800
Received: from orion.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1K2DB901069
	for <linux-mips@oss.sgi.com>; Tue, 19 Feb 2002 18:13:11 -0800
Received: (from jsun@localhost)
	by orion.mvista.com (8.9.3/8.9.3) id RAA25904;
	Tue, 19 Feb 2002 17:12:38 -0800
Date: Tue, 19 Feb 2002 17:12:38 -0800
From: Jun Sun <jsun@mvista.com>
To: "Kevin D. Kissell" <kevink@mips.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: FPU emulator unsafe for SMP?
Message-ID: <20020219171238.E25739@mvista.com>
References: <3C6C6ACF.CAD2FFC@mvista.com> <20020215031118.B21011@dea.linux-mips.net> <20020214232030.A3601@mvista.com> <20020215003037.A3670@mvista.com> <002b01c1b607$6afbd5c0$10eca8c0@grendel> <20020219140514.C25739@mvista.com> <00af01c1b9a2$c0d6d5f0$10eca8c0@grendel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <00af01c1b9a2$c0d6d5f0$10eca8c0@grendel>; from kevink@mips.com on Wed, Feb 20, 2002 at 01:08:30AM +0100
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Feb 20, 2002 at 01:08:30AM +0100, Kevin D. Kissell wrote:
> > > > Hmm, I see. The lazy fpu context switch code is not SMP safe.
> > > > I see fishy things like "last_task_used_math" etc...
> > > 
> > > What, you mean "last_task_used_math" isn't allocated in a
> > > processor-specific page of kseg3???    ;-)
> > 
> > You must be talking about another OS, right? :-)  I don't think 
> > Linux has processor-specific page, although this sounds like
> > a good idea to explore.
> 
> It's gotta be done.  I mean, the last I heard (which was a long
> time ago) mips64 Linux was keeping the CPU node number in
> a watchpoint register (or something equally unwholesome)

It seems that people are getting smarter by putting cpu id to
context register.  In fact isn't this part of new MIPS
standard?
> 
> But getting back to the original topic, there's another fun bug
> waiting for us in MIPS/Linux SMP floating point that can't
> be fixed as easly with VM slight-of-hand.  Consider processes
> "A" and "B", where A uses FP and B does not:  A gets scheduled
> on CPU 1, runs for a while, gets preempted, and B gets CPU 1.
> CPU 2 gets freed, so A gets scheduled on CPU 2.  Unfortunately,
> A's FP state is still in the FP register set of CPU 1.  The lazy FPU
> context switch either needs to be turned off (bleah!) or be fixed
> for SMP to handle the case where the "owner" of the FPR's
> on one CPU gets scheduled on another.  
> 
> The brute force would be somehow to send an interrupt to the CPU 
> with the FP state that will cause it to cough it up into the thread context 
> area.  One alternative would be to give strict CPU affinity to the thread 
> that has it's FP state on a particular CPU.  That could complicate load 
> balancing, but might not really be too bad.  At most one thread per CPU 
> will be non-migratable at a given point in time.  In the above scenario, 
> "A" could never migrate off of CPU 1, but "B" could, and would 
> presumably be picked up by an idle CPU 2 as soon as it's time slice 
> is up on CPU 1.  That will be less efficient than doing an "FPU shootdown"
> in some cases, but it should also be more portable and easier 
> to get right.
> 

As I looked into FPU/SMP issue, I realized this problem.  I agree 
that locking fpu owner to the current cpu is the best solution.
I bet this won't really hurt performance because any alternative would
incur transferring FPU registers across cpus, which is not a small 
overhead.

> Does this come up in x86-land?  The FPU state is much smaller
> there, so lazy context switching is presumably less important.
> 

It appears x86 is not doing lazy fpu switching, at least not
as agressively as MIPS.  I am actually curious how IRIX handles
this case, assuming IRIX is reasonable enough to have
lazy FPU switching...

Jun
