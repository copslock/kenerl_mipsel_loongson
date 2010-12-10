Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Dec 2010 18:22:45 +0100 (CET)
Received: from 124x34x33x190.ap124.ftth.ucom.ne.jp ([124.34.33.190]:59561 "EHLO
        master.linux-sh.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491878Ab0LJRWm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Dec 2010 18:22:42 +0100
Received: from localhost (unknown [127.0.0.1])
        by master.linux-sh.org (Postfix) with ESMTP id E3A2B6376C;
        Fri, 10 Dec 2010 17:21:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at linux-sh.org
Received: from master.linux-sh.org ([127.0.0.1])
        by localhost (master.linux-sh.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id RZ0miE+oGbP7; Sat, 11 Dec 2010 02:21:25 +0900 (JST)
Received: by master.linux-sh.org (Postfix, from userid 500)
        id 82E9063778; Sat, 11 Dec 2010 02:21:25 +0900 (JST)
Date:   Sat, 11 Dec 2010 02:21:25 +0900
From:   Paul Mundt <lethal@linux-sh.org>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney@caviumnetworks.com>,
        Anoop P A <anoop.pa@gmail.com>, linux-mips@linux-mips.org,
        LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] Introduce mips_late_time_init
Message-ID: <20101210172125.GA3750@linux-sh.org>
References: <1291623812.31822.6.camel@paanoop1-desktop> <4CFD2095.9040404@caviumnetworks.com> <20101208203704.GB30923@linux-mips.org> <alpine.LFD.2.00.1012082217230.2653@localhost6.localdomain6> <1291848346.16694.205.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1291848346.16694.205.camel@pasglop>
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <lethal@linux-sh.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28632
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lethal@linux-sh.org
Precedence: bulk
X-list: linux-mips

On Thu, Dec 09, 2010 at 09:45:46AM +1100, Benjamin Herrenschmidt wrote:
> On Wed, 2010-12-08 at 22:21 +0100, Thomas Gleixner wrote:
> > On Wed, 8 Dec 2010, Ralf Baechle wrote:
> > > Running everything from late_time_init() instead allows the use of kmalloc.
> > > X86 has the same issue with requiring kmalloc in time_init which is why
> > > they had moved everything to late_time_init.
> > 
> > It's more ioremap, but yeah.
> >  
> > > So the real question is, why can't we just move the call of time_init()
> > > in setup_kernel() to where late_time_init() is getting called from for
> > > all architectures, does anything rely on it getting called early?
> > 
> > That's a good question and I asked it myself already. I can't see a
> > real reason why something would need it early. Definitely worth to
> > try.
> 
> Well, I can see some reasons at least...
> 
> On ppc at least, we calibrate the timebase/decrementer in time_init, so
> things like udelay etc... are going to be unreliable until we've done
> that, which could be a problem if done too late due to sensitive HW
> accessors that might rely on these.
> 
The SH case is similar. We bring up the clock framework during
time_init() which we need for per-CPU loops_per_jiffy calculation in
addition to initializing the clocksource/clockevent timers that come up
during late_time_init.

Presently we have a slab_is_available() check in the SH clkdev
implementation mostly for board PLLs and so on, and our ioremap()
implementation also transparently bolts on to fixed ioremaps through
fixmap if we're really early anyways. It's possible that kmalloc is
usable outright now after the reordering happened, I haven't gone back
and checked it again since then.

> So we'd probably need to move that to a different (early) arch callback
> if time_init is moved.
> 
late_time_init has always struck me as a bit of a misnomer, since it's
still quite early as far as the rest of the system state is concerned,
particularly the driver core (all SH and ARM SH-Mobile platforms use
platform devices for clocksources/clockevents). In any event, SH would
also need this.

On ARM SH-Mobile we use the same approach although each platform
explicitly calls in to clock framework initialization prior to assigning
a late_time_init, which in turn gets all wrapped up in the ARM sys_timer
abstraction.
