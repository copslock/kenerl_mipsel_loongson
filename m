Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Jul 2003 18:10:29 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:20720 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8224821AbTGVRK0>;
	Tue, 22 Jul 2003 18:10:26 +0100
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h6MHAEg03254;
	Tue, 22 Jul 2003 10:10:14 -0700
Date: Tue, 22 Jul 2003 10:10:14 -0700
From: Jun Sun <jsun@mvista.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Ralf Baechle <ralf@linux-mips.org>,
	Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>,
	linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: [patch] Generic time fixes
Message-ID: <20030722101014.B3135@mvista.com>
References: <Pine.GSO.3.96.1030722093500.607A-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1030722093500.607A-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Tue, Jul 22, 2003 at 09:58:46AM +0200
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2856
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Tue, Jul 22, 2003 at 09:58:46AM +0200, Maciej W. Rozycki wrote:
> Hello,
> 
>  In preparation to merging DECstation's time support with the generic
> version I did the following clean-ups to generic time support.  Most of
> these are coding style fixes (which might have already been fixed by
> someone else during past two days -- I haven't been able to study the
> changes), but there are a few code changes (detailed below) as well.
> 
>  Before I proceed further I need to get an aswer to the following
> question: why do we use rtc_set_time() for NTP RTC updates instead of
> rtc_set_mmss() like most other architectures do?  Traditionally Linux only
> updated minutes and seconds in this context and I don't think we need to
> do anything more.  And setting minutes and seconds only is way, way
> faster. Which might not matter that much every 11 minutes, except doing
> things slowly here incurs a disruption in the latency of the timer
> interrupt, which NTP might not like and the slow calculation of the RTC
> time causes less precise time being stored in the RTC chip. 
>

rtc_set_time() is more generic interface as it is also used in other 
places.  Boards which easily speed up (i.e., emulate rtc_set_mmss()) by
doing something like the following:

rtc_set_time(t)
{
	if (t-last_time_set < 660 + delta)
		rtc_set_mmss(t);
	else
		/* do a full rtc set */
	last_time_set = t;
}

A lot of boards don't do RTC update, and even when they do they
usually don't have performance issues (such as in vr41xx cases).
It is not fair to tax every board by requiring a new board interface
function.

BTW, at least one other arch (PPC) is not using rtc_set_mmss().

>  It's already questionable whether the update should be done at all (this
> was discussed zillion of times at the NTP group) and it disrupts
> timekeeping of the DECstation severely, but given the current choice, I'd
> prefer to make it as lightweight as possible.
> 

Whether to keep rtc in sync is an option which can be set by a board
Simply do a

time_status |= STA_UNSYNC 

in your <board>_setup routine will disable any RTC update.

>  Here are the changes done:
>

The changes look good to me.

Jun
