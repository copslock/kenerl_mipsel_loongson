Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Jul 2003 22:21:14 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:64389 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225207AbTGVVVM>; Tue, 22 Jul 2003 22:21:12 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id XAA10354;
	Tue, 22 Jul 2003 23:21:05 +0200 (MET DST)
X-Authentication-Warning: delta.ds2.pg.gda.pl: macro owned process doing -bs
Date: Tue, 22 Jul 2003 23:21:04 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jun Sun <jsun@mvista.com>
cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [patch] Generic time fixes
In-Reply-To: <20030722101014.B3135@mvista.com>
Message-ID: <Pine.GSO.3.96.1030722225739.607J-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2862
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Tue, 22 Jul 2003, Jun Sun wrote:

> >  Before I proceed further I need to get an aswer to the following
> > question: why do we use rtc_set_time() for NTP RTC updates instead of
> > rtc_set_mmss() like most other architectures do?  Traditionally Linux only
> > updated minutes and seconds in this context and I don't think we need to
> > do anything more.  And setting minutes and seconds only is way, way
> > faster. Which might not matter that much every 11 minutes, except doing
> > things slowly here incurs a disruption in the latency of the timer
> > interrupt, which NTP might not like and the slow calculation of the RTC
> > time causes less precise time being stored in the RTC chip. 
> 
> rtc_set_time() is more generic interface as it is also used in other 
> places.  Boards which easily speed up (i.e., emulate rtc_set_mmss()) by
> doing something like the following:
> 
> rtc_set_time(t)
> {
> 	if (t-last_time_set < 660 + delta)
> 		rtc_set_mmss(t);
> 	else
> 		/* do a full rtc set */
> 	last_time_set = t;
> }
> 
> A lot of boards don't do RTC update, and even when they do they

 These should be fixed. 

> usually don't have performance issues (such as in vr41xx cases).
> It is not fair to tax every board by requiring a new board interface
> function.

 Well, rtc_set_time() is only used by the timekeeping code, so I see no
problem with renaming it.  And the interface remains the same -- it's a
number of seconds.  So if a full update is faster than changing minutes
and seconds only (e.g. the RTC is a monotonic counter -- I know a system
that just counts 10 ms intervals), an implementation is free to do so
(although that enforces UTC to be kept in the RTC; a good thing anyway),
but it shouldn't be required to.  And I think the name should be changed
to reflect that. 

 I you find such a cross-system update tedious -- don't worry.  I can do
that.  As a favor to platform maintainers I did such stuff in the past and
I can do it again.

> BTW, at least one other arch (PPC) is not using rtc_set_mmss().

 Their reasoning being?

> >  It's already questionable whether the update should be done at all (this
> > was discussed zillion of times at the NTP group) and it disrupts
> > timekeeping of the DECstation severely, but given the current choice, I'd
> > prefer to make it as lightweight as possible.
> > 
> 
> Whether to keep rtc in sync is an option which can be set by a board

 It can't.  But it should be configurable with a sysctl (but it isn't
now). 

> Simply do a
> 
> time_status |= STA_UNSYNC 
> 
> in your <board>_setup routine will disable any RTC update.

 Well, time_status = STA_UNSYNC initially, but ntpd will reset that.
Which is of course required to become a server.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
