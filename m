Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jun 2007 12:35:30 +0100 (BST)
Received: from wf1.mips-uk.com ([194.74.144.154]:23967 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20027194AbXFGLf2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 7 Jun 2007 12:35:28 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l57BUWER026602;
	Thu, 7 Jun 2007 12:30:32 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l57BUWL2026601;
	Thu, 7 Jun 2007 12:30:32 +0100
Date:	Thu, 7 Jun 2007 12:30:32 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Tickless/dyntick kernel, highres timer and general time
	crapectomy
Message-ID: <20070607113032.GA26047@linux-mips.org>
References: <20070606185450.GA10511@linux-mips.org> <cda58cb80706070059k3765cbf6w7e8907a2f0d83e1d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cda58cb80706070059k3765cbf6w7e8907a2f0d83e1d@mail.gmail.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15325
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jun 07, 2007 at 09:59:53AM +0200, Franck Bui-Huu wrote:

> >I'm working on getting dyntick and highres timer support working for MIPS.
> >This unavoidably implies dumping most of the MIPS-private time
> >infrastructure we've piled up over the past decade.  Which really is a
> >major crapectomy.  A first cut of the patches which are tested to
> >run
> 
> That's definitely true. I wrote my own version of clockevent support
> yesterday based on your patchset "dyntick-quilt" and I end up rewrite
> the whole time.c. The biggest part of the job would be to split this
> into several patches to ease the review but I doubt it worth it since
> we rewrite it almost from scratch.

I'm actually getting closer and closer to the point where keep things in
a nicely split patchset stops being workable.

> Another issue I have is to implement clockevent set_mode() method. You
> left it empty but I think we need at least to shut down the timer
> interrupt when setting the clock event device. Strangely I haven't
> found a "generic" way to stop them through cp0. Have I missed
> something ?

You can mask the count/compare interrupt in the status register like any
other interrupt.  Keep in mind that on many CPUs this interrupt is
shared with the performance counter interrupt so cannot always be disabled.
There is no other disable bit for this interrupt than the IE bit in the
status register.  So it may just have to be ignored.

Other issues to solve:

  o The R4000/R4400 (others?) allow the use of hwint5 for either the
    count/compare interrupt or as a normal hardware interrupt.  The switch
    happens based on a bootstream setting.  There is no config register
    bit for this, so we either have to hardcode the knowledge about the
    affected machines or construct a probe.  Where the count/compare is
    not usable we cannot use this as a clockevent device.
  o Old revisions of the R4000 have a bug where if the count register is
    read in exactly the moment where it matches the compare register the
    timer interrupt is lost.  This means the system will be interrupt-less
    for the next typicall like 86s (at the typical 100MHz clock for the
    affected processors).  The workaround needs to be implemented.

Both are currently the least of my concerns, there is much bigger fish to
catch ...

> BTW any idea when "time-ntp-make-cmos-update-generic.patch" is going
> to be merged into mainline ? Note: I think there's a bug in
> notify_cmos_timer(). The following test should be negated, shouldn't
> it ?
> 
> +	if (no_sync_cmos_clock)
> +		mod_timer(&sync_cmos_timer, jiffies + 1);

In theory the patch should be in -mm to be merged early just after .22.

> The other patch named "time-move-to_tm-to-lib.patch" create a new file
> in arch/mips/lib directory. This new file is called
> "to_tm.c". Shouldn't we call it something less specific like "time.c" ?

I actually may drop that one for now.  Two problems with it:

 o to_tm() is being used in modules but having the function in a lib means
   it may not be linked into the kernel so the modules might fail.
 o arch/mips/lib is not the right place anyway.  There are several nearly
   identical copies of the function around under arch/ so they should be
   unified.

  Ralf
