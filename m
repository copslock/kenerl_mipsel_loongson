Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Jul 2003 11:04:53 +0100 (BST)
Received: from p508B5B34.dip.t-dialin.net ([IPv6:::ffff:80.139.91.52]:50885
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224821AbTGVKEv>; Tue, 22 Jul 2003 11:04:51 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h6MA4jDB011658;
	Tue, 22 Jul 2003 12:04:45 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h6MA4iBA011657;
	Tue, 22 Jul 2003 12:04:44 +0200
Date: Tue, 22 Jul 2003 12:04:44 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>,
	linux-mips@linux-mips.org
Subject: Re: [patch] Generic time fixes
Message-ID: <20030722100444.GA4148@linux-mips.org>
References: <Pine.GSO.3.96.1030722093500.607A-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1030722093500.607A-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2848
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jul 22, 2003 at 09:58:46AM +0200, Maciej W. Rozycki wrote:

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
>  It's already questionable whether the update should be done at all (this
> was discussed zillion of times at the NTP group) and it disrupts
> timekeeping of the DECstation severely, but given the current choice, I'd
> prefer to make it as lightweight as possible.

It's a common case to have a system boot up with the RTC date being
completly off, then syncing via ntpdate and xntp to the accurate time.
If in that situation we only update the time the RTC will stay way far
from reality.  Another case would be updates of the time near midnight
where the RTC and NTP date happen to just differ.

I share your dislike of updating the RTC for performance reasons; these
chips are impressive performance pigs.  So how about updating the RTC
date only when

 - write the time to the RTC for the first time after NTP synchronizes
 - write the time to the RTC if xtime.tv_sec <= last_rtc_update + 660

?

> 3. local_timer_interrupt() is called with arguments passed from the above
> instead of fake ones (although "irq" and "dev_id" could be completely
> removed here; in the next iteration, I suppose). 

Agreed.  I can't imagine any use for dev_id in the timer interrupt and
the interrupt number seems only marginally more useful.

> 5. Leap years are handled properly.

Good thing.  People at times do run their systems with clocks set wrongly,
even intensionally.  So I blame (year % 4) == 0 for being a too trivial
view of the world.

> 6. Missing "extern" qualifiers for function declarations are added.
> 
>  OK to apply?

Yes.

  Ralf
