Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1K5PC303181
	for linux-mips-outgoing; Tue, 19 Feb 2002 21:25:12 -0800
Received: from orion.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1K5P8903178
	for <linux-mips@oss.sgi.com>; Tue, 19 Feb 2002 21:25:08 -0800
Received: (from jsun@localhost)
	by orion.mvista.com (8.9.3/8.9.3) id UAA03511;
	Tue, 19 Feb 2002 20:24:34 -0800
Date: Tue, 19 Feb 2002 20:24:34 -0800
From: Jun Sun <jsun@mvista.com>
To: Greg Lindahl <lindahl@conservativecomputer.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: FPU emulator unsafe for SMP?
Message-ID: <20020219202434.F25739@mvista.com>
References: <3C6C6ACF.CAD2FFC@mvista.com> <20020215031118.B21011@dea.linux-mips.net> <20020214232030.A3601@mvista.com> <20020215003037.A3670@mvista.com> <002b01c1b607$6afbd5c0$10eca8c0@grendel> <20020219140514.C25739@mvista.com> <00af01c1b9a2$c0d6d5f0$10eca8c0@grendel> <20020219171238.E25739@mvista.com> <20020219222835.A4195@wumpus.skymv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020219222835.A4195@wumpus.skymv.com>; from lindahl@conservativecomputer.com on Tue, Feb 19, 2002 at 10:28:35PM -0500
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Feb 19, 2002 at 10:28:35PM -0500, Greg Lindahl wrote:
> 
> Alpha seems to always save the fpu state (the comments say that gcc
> always generates code that uses it in every user process.)
>

I think the comment might be an execuse. :-)  Never heard of gcc
generating unnecessary floating point code.

> I suspect that the optimization of not saving the fpu state for a
> process that doesn't use the fpu is the most critical optimization.
> And that you do already.

If you do use floating point, I think it is pretty common to have
only process that uses fpu and runs for very long.  In that case,
leaving FPU owned by the process also saves quite a bit.
 
> What you propose, locking the fpu owner to the current cpu, will not
> result in a fair solution. Imagine a 2 cpu machine with 2 processes
> using integer math and 1 using floating point... how much cpu time
> will each process get? 

In this case, proc that uses fpu gets about 50% of one cpu, i.e., 25% of total
load, while the other two integer math proces split the rest 75%, which
gives 37.5% each.  Not too bad in my opinion.

> Imagine all the funky effects. Now add in a
> MIPS design in which interrupts are not delivered uniformly to all the
> cpus...

This is chip-specific, I think.  Not related to general MIPS arch.

Jun
