Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1K4Si502671
	for linux-mips-outgoing; Tue, 19 Feb 2002 20:28:44 -0800
Received: from nixon.xkey.com (nixon.xkey.com [209.245.148.124])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1K4Se902668
	for <linux-mips@oss.sgi.com>; Tue, 19 Feb 2002 20:28:40 -0800
Received: (qmail 3656 invoked from network); 20 Feb 2002 03:28:40 -0000
Received: from localhost (HELO localhost.conservativecomputer.com) (127.0.0.1)
  by localhost with SMTP; 20 Feb 2002 03:28:40 -0000
Received: (from lindahl@localhost)
	by localhost.conservativecomputer.com (8.11.6/8.11.0) id g1K3SZN04338
	for linux-mips@oss.sgi.com; Tue, 19 Feb 2002 22:28:35 -0500
X-Authentication-Warning: localhost.hpti.com: lindahl set sender to lindahl@conservativecomputer.com using -f
Date: Tue, 19 Feb 2002 22:28:35 -0500
From: Greg Lindahl <lindahl@conservativecomputer.com>
To: linux-mips@oss.sgi.com
Subject: Re: FPU emulator unsafe for SMP?
Message-ID: <20020219222835.A4195@wumpus.skymv.com>
Mail-Followup-To: linux-mips@oss.sgi.com
References: <3C6C6ACF.CAD2FFC@mvista.com> <20020215031118.B21011@dea.linux-mips.net> <20020214232030.A3601@mvista.com> <20020215003037.A3670@mvista.com> <002b01c1b607$6afbd5c0$10eca8c0@grendel> <20020219140514.C25739@mvista.com> <00af01c1b9a2$c0d6d5f0$10eca8c0@grendel> <20020219171238.E25739@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020219171238.E25739@mvista.com>; from jsun@mvista.com on Tue, Feb 19, 2002 at 05:12:38PM -0800
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Feb 19, 2002 at 05:12:38PM -0800, Jun Sun wrote:

> As I looked into FPU/SMP issue, I realized this problem.  I agree 
> that locking fpu owner to the current cpu is the best solution.
> I bet this won't really hurt performance because any alternative would
> incur transferring FPU registers across cpus, which is not a small 
> overhead.

There are other CPUs out there with large cpu contexts, like the Alpha
and Itanium. So we can look at what Linux does with them.

Alpha seems to always save the fpu state (the comments say that gcc
always generates code that uses it in every user process.)

The Itanium seems to be lazy only for nonSMP. If a process touches the
fpu registers and doesn't own their contents, it will save the fpu
contents to the appropriate process' state and load the correct fpu
state. For SMP it seems to always save the fpu state, if the process
modified it.

I suspect that the optimization of not saving the fpu state for a
process that doesn't use the fpu is the most critical optimization.
And that you do already.

What you propose, locking the fpu owner to the current cpu, will not
result in a fair solution. Imagine a 2 cpu machine with 2 processes
using integer math and 1 using floating point... how much cpu time
will each process get? Imagine all the funky effects. Now add in a
MIPS design in which interrupts are not delivered uniformly to all the
cpus... I don't know if there are any or will ever be any, but...

greg
