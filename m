Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jul 2005 17:39:10 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:1289 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8226889AbVGSQiy>; Tue, 19 Jul 2005 17:38:54 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id ED406E1CBD; Tue, 19 Jul 2005 18:40:34 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 15248-04; Tue, 19 Jul 2005 18:40:34 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id B7954E1CB9; Tue, 19 Jul 2005 18:40:34 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j6JGedLa030778;
	Tue, 19 Jul 2005 18:40:39 +0200
Date:	Tue, 19 Jul 2005 17:40:48 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Jan-Benedict Glaw <jbglaw@lug-owl.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: Updating RTC with date command
In-Reply-To: <20050719152008.GG20065@lug-owl.de>
Message-ID: <Pine.LNX.4.61L.0507191645510.10363@blysk.ds.pg.gda.pl>
References: <CBD77117272E1249BFDC21E33D555FDC06018D@dbde01.ent.ti.com>
 <20050719143110.GD3108@linux-mips.org> <20050719144230.GE20065@lug-owl.de>
 <Pine.LNX.4.61L.0507191555360.10363@blysk.ds.pg.gda.pl> <20050719152008.GG20065@lug-owl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.85.1/984/Tue Jul 19 11:16:09 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8558
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, 19 Jul 2005, Jan-Benedict Glaw wrote:

> >  Well, `hwclock' should normally be used to update the RTC every time 
> > after a manual system clock update.
> 
> Which of course should only be done once. Ever :)

 Well, depending on whether the system is networked or not.  If it is, 
it's not needed at all as you fetch the initial setting over NTP, too.  If 
it's not, then unfortunately it's needed every time you notice the clock 
has skewed too much.

> >  Note that ntpd only updates minutes and seconds and then only if the 
> > difference is small -- to account for the existence of time zones and a 
> > system-specific relation between the time recoreded by the system and one 
> > handled by the RTC.  Also the feature is broken by design -- ntpd 
> > shouldn't do that at all in principle and in practice it leads to the 
> > system time being corrupted on some machines using an RTC interrupt for 
> > the system timer tick.
> 
> Aren't we expected to keep UTC time inside the HW clock? So there's no

 It's a good idea, but whether it's feasible or not is unfortunately 
system-specific.

> problem with timezones.  Also, if your timer interrupt source it that
> broken that ntpd cannot track it, then you're having more servere
> problems...

 Huh?  The time source is correct if let to run freely, but modifying the 
time stored in RTC may disturb it.  This is e.g. the case with the 
Motorola MC146818 and its clones which are rather common chips -- any 
system using their periodic interrupt for the system clock tick suffers 
from this problem.

> > > distributions seem to also update the HW clock at system shutdown time.
> > 
> >  Which is where it should really happen.
> 
> I disagree. IFF there's a known good time, it's acceptable to write it
> into a backing HW clock. In case there isn't (any longer), it's probably
> better to not write to the HW clock at all. Probably it's contents is
> better than a wrongly manually adjusted local date setting...

 Something has to preserve the clock across reboots and power-offs.  
Which of the sources is to be trusted more is a matter of a local policy 
and neither the kernel nor tools should force any particular one.

> I do trust ntpd, but do I trust someone who looks at it's watch?

 Well, I do trust myself ultimately...

> > > So the correct solution to your problem is to either shutdown once
> > > (workaround) or keep ntpd running (the solution[tm]).
> > 
> >  I think you've got the figures reversed (well, it's useful to have ntpd 
> > running, but it should not fiddle with the RTC).
> 
> Well, I stated my oppinion. Maybe ntpd shouldn't set the clock (or make
> the kernel set it internally), but for sure I don't want the HW clock
> being set by hand (except very first power-up of the system) and by no
> means if local time came up from a manual process.

 If ntpd has been running with a good reference it must have disciplined 
the system clock, so it should have a smaller drift than the RTC.  So it 
should be safe to store the former into the latter at a shutdown (but 
that's a policy).  Otherwise nothing can be told about both clocks and the 
system's administrator should decide.  In the end I think the decision 
should be left up to the administrator in all cases.

  Maciej
