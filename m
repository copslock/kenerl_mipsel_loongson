Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Jul 2003 15:53:22 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:6868 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225193AbTGWOxU>; Wed, 23 Jul 2003 15:53:20 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id QAA26816;
	Wed, 23 Jul 2003 16:52:32 +0200 (MET DST)
X-Authentication-Warning: delta.ds2.pg.gda.pl: macro owned process doing -bs
Date: Wed, 23 Jul 2003 16:52:31 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jun Sun <jsun@mvista.com>
cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [patch] Generic time fixes
In-Reply-To: <20030722181430.I3135@mvista.com>
Message-ID: <Pine.GSO.3.96.1030723164616.26641A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2891
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Tue, 22 Jul 2003, Jun Sun wrote:

> > > Isn't it cool to take care of the board-specific with the same interface
> > > kernel time system uses?  Every MIPS board gets a basic RTC driver for free!
> > 
> >  Well, I'm not that convinced.  What's wrong with making real support for
> > the RTC chip instead?
> >
> 
> Nothing wrong with full RTC driver support - it is just that when
> 30+ MIPS boards don't have to add #ifdef's to rtc.c and mc146818rtc.h
> and hwclock still works people start appreciate more about the
> existence of rtc_set_time().

 Hmm, but how many different RTC chips are out there?  I agree the current
rtc.c/mc146818rtc.h implementation sucks, but it should be fixed and not
worked around.

> If you really want, how about the following change:
> 
> 1) add set_rtc_mmss() function pointer in asm/time.h.
> 2) set it equal to set_rtc_time in time_init().  Board can override
>    this decision in board_timer_setup() for better performance.
> 3) RTC update is changed to call set_rtc_mmss()
> 
> How does this sound?  It leaves all existing code unchanged, while
> gives a way for optimization.  The default setting of set_rtc_mmss
> to set_rtc_time makes logical sense too, because set_rtc_mmss is really
> a "back door" version of set_rtc_time().

 That's just fine for me.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
