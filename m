Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Jul 2003 18:16:59 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:17139 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8224821AbTGVRQ4>;
	Tue, 22 Jul 2003 18:16:56 +0100
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h6MHGs003275;
	Tue, 22 Jul 2003 10:16:54 -0700
Date: Tue, 22 Jul 2003 10:16:54 -0700
From: Jun Sun <jsun@mvista.com>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>,
	linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: [patch] Generic time fixes
Message-ID: <20030722101654.C3135@mvista.com>
References: <Pine.GSO.3.96.1030722093500.607A-100000@delta.ds2.pg.gda.pl> <20030722100444.GA4148@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030722100444.GA4148@linux-mips.org>; from ralf@linux-mips.org on Tue, Jul 22, 2003 at 12:04:44PM +0200
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2857
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Tue, Jul 22, 2003 at 12:04:44PM +0200, Ralf Baechle wrote:
> On Tue, Jul 22, 2003 at 09:58:46AM +0200, Maciej W. Rozycki wrote:
> 
> >  Before I proceed further I need to get an aswer to the following
> > question: why do we use rtc_set_time() for NTP RTC updates instead of
> > rtc_set_mmss() like most other architectures do?  Traditionally Linux only
> > updated minutes and seconds in this context and I don't think we need to
> > do anything more.  And setting minutes and seconds only is way, way
> > faster. Which might not matter that much every 11 minutes, except doing
> > things slowly here incurs a disruption in the latency of the timer
> > interrupt, which NTP might not like and the slow calculation of the RTC
> > time causes less precise time being stored in the RTC chip. 
> > 
> >  It's already questionable whether the update should be done at all (this
> > was discussed zillion of times at the NTP group) and it disrupts
> > timekeeping of the DECstation severely, but given the current choice, I'd
> > prefer to make it as lightweight as possible.
> 
> It's a common case to have a system boot up with the RTC date being
> completly off, then syncing via ntpdate and xntp to the accurate time.
> If in that situation we only update the time the RTC will stay way far
> from reality.  Another case would be updates of the time near midnight
> where the RTC and NTP date happen to just differ.
> 
> I share your dislike of updating the RTC for performance reasons; these
> chips are impressive performance pigs.  So how about updating the RTC
> date only when
> 
>  - write the time to the RTC for the first time after NTP synchronizes

"First time after NTP synchronization" is not readily known to arch
time code.  This will involve kernel common code change.

>  - write the time to the RTC if xtime.tv_sec <= last_rtc_update + 660
>

Do you mean "xtime.tv_sec > last_rtc_update + 660", which is already
the case?

Again, board does have choice as to whether it wants RTC update or not.

Jun
