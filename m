Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Jul 2003 23:43:47 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:31485 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225230AbTGVWnp>;
	Tue, 22 Jul 2003 23:43:45 +0100
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h6MMhe905341;
	Tue, 22 Jul 2003 15:43:40 -0700
Date: Tue, 22 Jul 2003 15:43:40 -0700
From: Jun Sun <jsun@mvista.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	jsun@mvista.com
Subject: Re: [patch] Generic time fixes
Message-ID: <20030722154340.F3135@mvista.com>
References: <20030722101014.B3135@mvista.com> <Pine.GSO.3.96.1030722225739.607J-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1030722225739.607J-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Tue, Jul 22, 2003 at 11:21:04PM +0200
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2869
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Tue, Jul 22, 2003 at 11:21:04PM +0200, Maciej W. Rozycki wrote:
> On Tue, 22 Jul 2003, Jun Sun wrote:
> 
> > >  Before I proceed further I need to get an aswer to the following
> > > question: why do we use rtc_set_time() for NTP RTC updates instead of
> > > rtc_set_mmss() like most other architectures do?  Traditionally Linux only
> > > updated minutes and seconds in this context and I don't think we need to
> > > do anything more.  And setting minutes and seconds only is way, way
> > > faster. Which might not matter that much every 11 minutes, except doing
> > > things slowly here incurs a disruption in the latency of the timer
> > > interrupt, which NTP might not like and the slow calculation of the RTC
> > > time causes less precise time being stored in the RTC chip. 
> > 
> > rtc_set_time() is more generic interface as it is also used in other 
> > places.  Boards which easily speed up (i.e., emulate rtc_set_mmss()) by
> > doing something like the following:
> > 
> > rtc_set_time(t)
> > {
> > 	if (t-last_time_set < 660 + delta)
> > 		rtc_set_mmss(t);
> > 	else
> > 		/* do a full rtc set */
> > 	last_time_set = t;
> > }
> > 
> > A lot of boards don't do RTC update, and even when they do they
> 
>  These should be fixed. 
> 
> > usually don't have performance issues (such as in vr41xx cases).
> > It is not fair to tax every board by requiring a new board interface
> > function.
> 
>  Well, rtc_set_time() is only used by the timekeeping code, so I see no
> problem with renaming it.  And the interface remains the same -- it's a
> number of seconds.  So if a full update is faster than changing minutes
> and seconds only (e.g. the RTC is a monotonic counter -- I know a system
> that just counts 10 ms intervals), an implementation is free to do so
> (although that enforces UTC to be kept in the RTC; a good thing anyway),
> but it shouldn't be required to.  And I think the name should be changed
> to reflect that. 
>

Actually the drivers/char/mips-rtc.c uses it too.  In that context
a full rtc set is needed.

The same interface can be used for the 2.6 gen-rtc.c as well, where
a full rtc update is needed also.

I like the current way it is because :

1) rtc_set_time() is a more generic interface so that it can be used
in more places (such as mips-rtc.c and gen-rtc.c).
2) rtc_set_mmss() can be reasonally emulated if it is desired on a particular
board
3) it is better to have just one rtc_set_xxx() instead of two.

> > BTW, at least one other arch (PPC) is not using rtc_set_mmss().
> 
>  Their reasoning being?
>

Probably the same reason as above?
 
> > >  It's already questionable whether the update should be done at all (this
> > > was discussed zillion of times at the NTP group) and it disrupts
> > > timekeeping of the DECstation severely, but given the current choice, I'd
> > > prefer to make it as lightweight as possible.
> > > 
> > 
> > Whether to keep rtc in sync is an option which can be set by a board
> 
>  It can't.  But it should be configurable with a sysctl (but it isn't
> now). 
> 
> > Simply do a
> > 
> > time_status |= STA_UNSYNC 
> > 
> > in your <board>_setup routine will disable any RTC update.
> 
>  Well, time_status = STA_UNSYNC initially, but ntpd will reset that.
> Which is of course required to become a server.
>

Actually searching through the kernel I can't find the place where
the flag is cleared.  Am I mistaken?

Jun
