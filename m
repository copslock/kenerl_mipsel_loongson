Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Aug 2003 13:25:22 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:2267 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225072AbTHMMZT>; Wed, 13 Aug 2003 13:25:19 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA26553;
	Wed, 13 Aug 2003 14:25:13 +0200 (MET DST)
X-Authentication-Warning: delta.ds2.pg.gda.pl: macro owned process doing -bs
Date: Wed, 13 Aug 2003 14:25:12 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jun Sun <jsun@mvista.com>
cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [patch] Generic time trailing clean-ups
In-Reply-To: <20030812100537.B30067@mvista.com>
Message-ID: <Pine.GSO.3.96.1030813135602.25530C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3041
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Tue, 12 Aug 2003, Jun Sun wrote:

> >  As a number of interrupts is lost (at least half a second worth of; it
> > depends on how long console_init() executes), it takes a few minutes for
> > gettimeoffset() to recover from the error -- r0 (which is the number of
> > HPT ticks in a jiffy) is too high.  As a result, offsets within jiffies as
> > calculated by gettimeoffset() are distributed unevenly.  You may not care,
> > but I use NTP on my systems and I do care.  With the above initialization,
> > r0 is almost correct from the beginning and after a few minutes of uptime
> > the error is no higher than one tick. 
> > 
> >  The fixed_rate_gettimeoffset() backend doesn't care but the calibrate_*()
> > ones do.
> 
> Perhaps we should always calibrate the counter frequency and forget about
> all those calibrate_*() routines.  This will allow us to get rid of a few
> funtions.  Plus knowing the frequency is generally a good thing (for some
> performance measurement, for example).

 Of course calibrating the counter frequency beforehand would be a Good
Thing, but that's not exactly trivial.

> I have a patch floating around just doing that, and in MontaVista tree
> we have already done for a long time.
> 
> The patch is at 
> 
> http://linux.junsun.net/patches/oss.sgi.com/experimental/011128.calibrate_mips_counter.patch
> 
> (Wow!  I can't believe it was done almost two years ago.)

 That's good enough as a temporary hack, but not as a final solution.  I
think we need to do the calibration similarly to how calibrate_tsc() or
calibrate_APIC_clock() do that for the i386.  Specifically, we need to do
that with polling for appropriate accuracy (interrupt delivery time might
not be deterministic) and preferably before interrupts are enabled
(time_init() looks like a perfect place to do that).  And of course we
need to poll against the interrupt source as it's the frequency ratio that
matters (otherwise I could e.g. just read the TURBOchannel clock frequency
as reported by the firmware for the HPT on R3k DECstations).  That means
it needs to be done in platform-specific way.

 I have an idea how to make an abstraction layer for this purpose and I'll
make a patch for the DECstation soon.  The plan might be as follows: 

1. I'll apply the patch as is (Ralf has already approved it off-list) as
the calibrate_*() backends won't disappear immediately anyway. 

2. I'll provide the abstraction layer together with an example
implementation for the DECstation.

3. For 2.6 I'll add a warning about uninitialized mips_counter_frequency
and deprecation of calibrate_*() backends, so that platform maintainers
know what's going on.

4. After 2.7 starts code related to calibrate_*() will be removed and the
kernel will panic() if a HPT is found, but mips_counter_frequency is zero.

Any comments?

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
