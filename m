Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Jul 2003 21:38:46 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:3715 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225207AbTGVUio>; Tue, 22 Jul 2003 21:38:44 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id WAA09983;
	Tue, 22 Jul 2003 22:38:41 +0200 (MET DST)
X-Authentication-Warning: delta.ds2.pg.gda.pl: macro owned process doing -bs
Date: Tue, 22 Jul 2003 22:38:41 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
cc: linux-mips@linux-mips.org
Subject: Re: [patch] Generic time fixes
In-Reply-To: <20030722100444.GA4148@linux-mips.org>
Message-ID: <Pine.GSO.3.96.1030722222128.607H-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2860
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Tue, 22 Jul 2003, Ralf Baechle wrote:

> >  It's already questionable whether the update should be done at all (this
> > was discussed zillion of times at the NTP group) and it disrupts
> > timekeeping of the DECstation severely, but given the current choice, I'd
> > prefer to make it as lightweight as possible.
> 
> It's a common case to have a system boot up with the RTC date being
> completly off, then syncing via ntpdate and xntp to the accurate time.
> If in that situation we only update the time the RTC will stay way far

 Hmm, any problems with `ntpdate <your_server>; hwclock -uw'?  Plus a lone
`hwclock -uw' before a graceful halt/reboot?  That's a typical userland
task and a trivial one, actually. 

> from reality.  Another case would be updates of the time near midnight
> where the RTC and NTP date happen to just differ.

 That's why rtc_set_mmss() never does an update that would require a
change to hours -- it defers it with a "set_rtc_mmss: can't update from x
to y" message.

> I share your dislike of updating the RTC for performance reasons; these
> chips are impressive performance pigs.  So how about updating the RTC
> date only when
> 
>  - write the time to the RTC for the first time after NTP synchronizes
>  - write the time to the RTC if xtime.tv_sec <= last_rtc_update + 660
> 
> ?

 I really see no point in doing it at all -- it's all easier and more
flexible to be done in the userland.

> > 5. Leap years are handled properly.
> 
> Good thing.  People at times do run their systems with clocks set wrongly,
> even intensionally.  So I blame (year % 4) == 0 for being a too trivial
> view of the world.

 Well, that's actually just the Julian view.

 There were a number of surprising discoveries in code here and there wrt
the y2k leap year exception -- apparently a number of people involved in
coding were not aware of the full Gregorian Calendar leap year rule, even
though doing that stuff should make them obliged to.  Somehow the rule was
already known to me many years ago, certainly before y2k and probably even
before I got involved with computers...

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
