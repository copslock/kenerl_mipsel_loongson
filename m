Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Jul 2003 02:14:35 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:50416 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225239AbTGWBOd>;
	Wed, 23 Jul 2003 02:14:33 +0100
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h6N1EUd15747;
	Tue, 22 Jul 2003 18:14:30 -0700
Date: Tue, 22 Jul 2003 18:14:30 -0700
From: Jun Sun <jsun@mvista.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	jsun@mvista.com
Subject: Re: [patch] Generic time fixes
Message-ID: <20030722181430.I3135@mvista.com>
References: <20030722163701.G3135@mvista.com> <Pine.GSO.3.96.1030723014418.607S-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1030723014418.607S-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Wed, Jul 23, 2003 at 02:30:53AM +0200
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2878
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Wed, Jul 23, 2003 at 02:30:53AM +0200, Maciej W. Rozycki wrote:
> On Tue, 22 Jul 2003, Jun Sun wrote:
> 
> > Isn't it cool to take care of the board-specific with the same interface
> > kernel time system uses?  Every MIPS board gets a basic RTC driver for free!
> 
>  Well, I'm not that convinced.  What's wrong with making real support for
> the RTC chip instead?
>

Nothing wrong with full RTC driver support - it is just that when
30+ MIPS boards don't have to add #ifdef's to rtc.c and mc146818rtc.h
and hwclock still works people start appreciate more about the
existence of rtc_set_time().

> > 
> > What is the race condition?  And what is the performance hit?
> 
>  You need to read from the RTC, modify minutes and seconds as appropriate
> and write the RTC back.  Meanwhile the time as stored in the RTC may
> change.  With the 500 ms offset approximation as used by time.c it may be
> unlikely, but that assumption is for the MC146818 and it may not be true
> for incompatible RTC chips.  That is the race.  The performance hit is
> obvious -- now a read is added to the write.
>

OK, I see the performance hit now.

If you really want, how about the following change:

1) add set_rtc_mmss() function pointer in asm/time.h.
2) set it equal to set_rtc_time in time_init().  Board can override
   this decision in board_timer_setup() for better performance.
3) RTC update is changed to call set_rtc_mmss()

How does this sound?  It leaves all existing code unchanged, while
gives a way for optimization.  The default setting of set_rtc_mmss
to set_rtc_time makes logical sense too, because set_rtc_mmss is really
a "back door" version of set_rtc_time().

Jun
