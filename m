Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1KF10F13620
	for linux-mips-outgoing; Wed, 20 Feb 2002 07:01:00 -0800
Received: from dea.linux-mips.net (a1as06-p249.stg.tli.de [195.252.187.249])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1KF0l913560
	for <linux-mips@oss.sgi.com>; Wed, 20 Feb 2002 07:00:48 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g1KD3fo16150;
	Wed, 20 Feb 2002 14:03:41 +0100
Date: Wed, 20 Feb 2002 14:03:41 +0100
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Kevin D. Kissell" <kevink@mips.com>
Cc: Jun Sun <jsun@mvista.com>, linux-mips@oss.sgi.com
Subject: Re: FPU emulator unsafe for SMP?
Message-ID: <20020220140341.B15588@dea.linux-mips.net>
References: <3C6C6ACF.CAD2FFC@mvista.com> <20020215031118.B21011@dea.linux-mips.net> <20020214232030.A3601@mvista.com> <20020215003037.A3670@mvista.com> <002b01c1b607$6afbd5c0$10eca8c0@grendel> <20020219140514.C25739@mvista.com> <00af01c1b9a2$c0d6d5f0$10eca8c0@grendel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <00af01c1b9a2$c0d6d5f0$10eca8c0@grendel>; from kevink@mips.com on Wed, Feb 20, 2002 at 01:08:30AM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Feb 20, 2002 at 01:08:30AM +0100, Kevin D. Kissell wrote:

> It's gotta be done.  I mean, the last I heard (which was a long
> time ago) mips64 Linux was keeping the CPU node number in
> a watchpoint register (or something equally unwholesome) and
> using that value as an index into tables.

NUMA nitpicking: cpu number != node number.  We store the CPU number
in the PTEBase field from bit 23 on in the c0_context register.  This
number is then used to index the pgd_current[] array to find the root
of the page table tree.

Having some extra on-die memory for such tiny bits of frequently accessed
information on the CPU die would be really cool.  I bet it would make
a visible difference.

>  Sticking all the per-CPU
> state in a kseg3 VM page which is allocated and locked at boot
> time would be much cleaner and on the average probably quite
> a bit faster (definitely faster in the kernel but to be fair one has
> to factor in the increase in TLB pressure from the locked entry).

The plan is actually to map 32-bit page tables into a flat array of 4mb
in size and use one wired mapping for that.  The other half of the
TLB entry mapping the root would still be available.

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
> Does this come up in x86-land?  The FPU state is much smaller
> there, so lazy context switching is presumably less important.

Yes, it's an issue also on x86-land.  Since the i386 code stopped using
task segments for context switching their whole context switching code
has actually become reasonably sane and can be used as a template.  In
particular I like the fact that they got away without tons of CONFIG_SMP
that used to live in their kernel fp code.  Time to re-read the i386 code.

Using an IPI for migration of an FP context between CPUs a really bad
idea which may result in rather sucky worst case context switching times.
One of the facts that many performace tradeoffs in the Linux world
assume to be granted is blindingly fast context switch times.

The number of SMP platforms is growing.  I thought it's mindboggling
but people are actually building SMP on a chip systems from cores that
were designed for uniprocessing.  I'd expect such systems to perform
like the early SMPs from the 80's, that's not very much at all ...

  Ralf
