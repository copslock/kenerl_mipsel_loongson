Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Jul 2003 00:37:06 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:30192 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225239AbTGVXhE>;
	Wed, 23 Jul 2003 00:37:04 +0100
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h6MNb1d14282;
	Tue, 22 Jul 2003 16:37:01 -0700
Date: Tue, 22 Jul 2003 16:37:01 -0700
From: Jun Sun <jsun@mvista.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	jsun@mvista.com
Subject: Re: [patch] Generic time fixes
Message-ID: <20030722163701.G3135@mvista.com>
References: <20030722154340.F3135@mvista.com> <Pine.GSO.3.96.1030723005534.607Q-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1030723005534.607Q-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Wed, Jul 23, 2003 at 01:10:54AM +0200
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2874
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Wed, Jul 23, 2003 at 01:10:54AM +0200, Maciej W. Rozycki wrote:
> On Tue, 22 Jul 2003, Jun Sun wrote:
> 
> > >  Well, rtc_set_time() is only used by the timekeeping code, so I see no
> > > problem with renaming it.  And the interface remains the same -- it's a
> > > number of seconds.  So if a full update is faster than changing minutes
> > > and seconds only (e.g. the RTC is a monotonic counter -- I know a system
> > > that just counts 10 ms intervals), an implementation is free to do so
> > > (although that enforces UTC to be kept in the RTC; a good thing anyway),
> > > but it shouldn't be required to.  And I think the name should be changed
> > > to reflect that. 
> > 
> > Actually the drivers/char/mips-rtc.c uses it too.  In that context
> > a full rtc set is needed.
> > 
> > The same interface can be used for the 2.6 gen-rtc.c as well, where
> > a full rtc update is needed also.
> 
>  But that function should be provided by the driver (it may use
> system-specific backends at will -- drivers/char/rtc.c does so as well),

Isn't it cool to take care of the board-specific with the same interface
kernel time system uses?  Every MIPS board gets a basic RTC driver for free!

> > I like the current way it is because :
> > 
> > 1) rtc_set_time() is a more generic interface so that it can be used
> > in more places (such as mips-rtc.c and gen-rtc.c).
> 
>  I see no problem with that interface being used there.

Eh?  I assume you mean "no problem with rtc_set_mmss() being used there", true?

How come no problem?  rtc_set_mmss() does not even allow you set the time
if the new time is too off.  

> 
> > 2) rtc_set_mmss() can be reasonally emulated if it is desired on a particular
> > board
> 
>  I don't think so -- it would incur a race and a severe performance hit.
> It makes no sense anyway.

What is the race condition?  And what is the performance hit?

> > 3) it is better to have just one rtc_set_xxx() instead of two.
> 
>  Please define "better".  I think it's better to have a fast variation for
> timekeeping as it's been used for years now for MC146818 and clones.
>

Oh, yeah?  Look at those ugly #ifdefs include/asm-mips/mc146818rtc.h.
It is a poor abstraction of RTC.

If you convert DEC to the new RTC interface we could get rid of that
file completely.

And make no mistake, you _can_ have fast implementation that you are
looking for.

BTW, are you proposing to rename rtc_set_time() to rtc_set_mmss() and change
its semantic accordingly?  Or are you suggesting to add rtc_set_mmss()?

If you are suggesting the later, clearly fewer interface functions 
between MIPS common and board layer is better.

> > Actually searching through the kernel I can't find the place where
> > the flag is cleared.  Am I mistaken?
> 
>  See do_adjtimex().
>

I see.  Thanks.

Jun 
