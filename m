Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Aug 2003 17:46:00 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:5364 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225294AbTHMQpr>;
	Wed, 13 Aug 2003 17:45:47 +0100
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h7DGjfH09736;
	Wed, 13 Aug 2003 09:45:41 -0700
Date: Wed, 13 Aug 2003 09:45:41 -0700
From: Jun Sun <jsun@mvista.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	jsun@mvista.com
Subject: Re: [patch] Generic time trailing clean-ups
Message-ID: <20030813094541.B9655@mvista.com>
References: <20030812100537.B30067@mvista.com> <Pine.GSO.3.96.1030813135602.25530C-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1030813135602.25530C-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Wed, Aug 13, 2003 at 02:25:12PM +0200
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3043
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Wed, Aug 13, 2003 at 02:25:12PM +0200, Maciej W. Rozycki wrote:
> On Tue, 12 Aug 2003, Jun Sun wrote:
> 
> > >  As a number of interrupts is lost (at least half a second worth of; it
> > > depends on how long console_init() executes), it takes a few minutes for
> > > gettimeoffset() to recover from the error -- r0 (which is the number of
> > > HPT ticks in a jiffy) is too high.  As a result, offsets within jiffies as
> > > calculated by gettimeoffset() are distributed unevenly.  You may not care,
> > > but I use NTP on my systems and I do care.  With the above initialization,
> > > r0 is almost correct from the beginning and after a few minutes of uptime
> > > the error is no higher than one tick. 
> > > 
> > >  The fixed_rate_gettimeoffset() backend doesn't care but the calibrate_*()
> > > ones do.
> > 
> > Perhaps we should always calibrate the counter frequency and forget about
> > all those calibrate_*() routines.  This will allow us to get rid of a few
> > funtions.  Plus knowing the frequency is generally a good thing (for some
> > performance measurement, for example).
> 
>  Of course calibrating the counter frequency beforehand would be a Good
> Thing, but that's not exactly trivial.
> 
> > I have a patch floating around just doing that, and in MontaVista tree
> > we have already done for a long time.
> > 
> > The patch is at 
> > 
> > http://linux.junsun.net/patches/oss.sgi.com/experimental/011128.calibrate_mips_counter.patch
> > 
> > (Wow!  I can't believe it was done almost two years ago.)
> 
>  That's good enough as a temporary hack, but not as a final solution.  I
> think we need to do the calibration similarly to how calibrate_tsc() or
> calibrate_APIC_clock() do that for the i386.  Specifically, we need to do
> that with polling for appropriate accuracy (interrupt delivery time might
> not be deterministic) and preferably before interrupts are enabled
> (time_init() looks like a perfect place to do that).  And of course we
> need to poll against the interrupt source as it's the frequency ratio that
> matters (otherwise I could e.g. just read the TURBOchannel clock frequency
> as reported by the firmware for the HPT on R3k DECstations).  That means
> it needs to be done in platform-specific way.
>

I don't like this idea.  This is way too much over-doing for little gain.

When counter frequency is calibrated, the system is just starting.  The interrupt
delivery time is rather deterministic. 

Then you also need to put into perspective of its usage in gettimeoffset.
We are talking about micro-second resolution.  calibration obtained this way
is accurate enough.

Over-abstraction is very bad for OS.  We need to recognize that danger.

In addition, this change expands MIPS common and board interface and increases
board-layer porting work.

>  I have an idea how to make an abstraction layer for this purpose and I'll
> make a patch for the DECstation soon.  The plan might be as follows: 
> 
> 1. I'll apply the patch as is (Ralf has already approved it off-list) as
> the calibrate_*() backends won't disappear immediately anyway. 
>

If you take the above view, the obvious action is to apply the 
calibration patch and get rid of all various calibrate_* routines.

Of course, future improvement is still possible even with doing this.  For example,
one interesting item is to calibrate and sync counters on a SMP system.

> 2. I'll provide the abstraction layer together with an example
> implementation for the DECstation.
> 
> 3. For 2.6 I'll add a warning about uninitialized mips_counter_frequency
> and deprecation of calibrate_*() backends, so that platform maintainers
> know what's going on.
> 
> 4. After 2.7 starts code related to calibrate_*() will be removed and the
> kernel will panic() if a HPT is found, but mips_counter_frequency is zero.
> 
> Any comments?
> 

That is my two cents.  

BTW, I am drafting a proposal to use a native high resolution clock/timer
interface for 2.7 kernel, with jiffie timer emulated on top of it.  If adopted, 
that will change the whole picture obviously.  But that is too far to be
a real factor here.  The only implication to MIPS is probably that we should 
encourage people to use CPU counter as the system timer as much as possible.
This will increase maximum code sharing and is future-proof.

Jun
