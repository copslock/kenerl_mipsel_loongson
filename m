Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Jul 2003 01:31:01 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:54419 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225239AbTGWAa7>; Wed, 23 Jul 2003 01:30:59 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id CAA12182;
	Wed, 23 Jul 2003 02:30:53 +0200 (MET DST)
X-Authentication-Warning: delta.ds2.pg.gda.pl: macro owned process doing -bs
Date: Wed, 23 Jul 2003 02:30:53 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jun Sun <jsun@mvista.com>
cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [patch] Generic time fixes
In-Reply-To: <20030722163701.G3135@mvista.com>
Message-ID: <Pine.GSO.3.96.1030723014418.607S-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2877
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Tue, 22 Jul 2003, Jun Sun wrote:

> > > >  Well, rtc_set_time() is only used by the timekeeping code, so I see no
> > > > problem with renaming it.  And the interface remains the same -- it's a
> > > > number of seconds.  So if a full update is faster than changing minutes
> > > > and seconds only (e.g. the RTC is a monotonic counter -- I know a system
> > > > that just counts 10 ms intervals), an implementation is free to do so
> > > > (although that enforces UTC to be kept in the RTC; a good thing anyway),
> > > > but it shouldn't be required to.  And I think the name should be changed
> > > > to reflect that. 
> > > 
> > > Actually the drivers/char/mips-rtc.c uses it too.  In that context
> > > a full rtc set is needed.
> > > 
> > > The same interface can be used for the 2.6 gen-rtc.c as well, where
> > > a full rtc update is needed also.
> > 
> >  But that function should be provided by the driver (it may use
> > system-specific backends at will -- drivers/char/rtc.c does so as well),
> 
> Isn't it cool to take care of the board-specific with the same interface
> kernel time system uses?  Every MIPS board gets a basic RTC driver for free!

 Well, I'm not that convinced.  What's wrong with making real support for
the RTC chip instead?

> > > I like the current way it is because :
> > > 
> > > 1) rtc_set_time() is a more generic interface so that it can be used
> > > in more places (such as mips-rtc.c and gen-rtc.c).
> > 
> >  I see no problem with that interface being used there.
> 
> Eh?  I assume you mean "no problem with rtc_set_mmss() being used
> there", true? 

 Nope, I mean rtc_set_time() is just fine here -- do I sound crazy? 

> > > 2) rtc_set_mmss() can be reasonally emulated if it is desired on a particular
> > > board
> > 
> >  I don't think so -- it would incur a race and a severe performance hit.
> > It makes no sense anyway.
> 
> What is the race condition?  And what is the performance hit?

 You need to read from the RTC, modify minutes and seconds as appropriate
and write the RTC back.  Meanwhile the time as stored in the RTC may
change.  With the 500 ms offset approximation as used by time.c it may be
unlikely, but that assumption is for the MC146818 and it may not be true
for incompatible RTC chips.  That is the race.  The performance hit is
obvious -- now a read is added to the write.

> > > 3) it is better to have just one rtc_set_xxx() instead of two.
> > 
> >  Please define "better".  I think it's better to have a fast variation for
> > timekeeping as it's been used for years now for MC146818 and clones.
> 
> Oh, yeah?  Look at those ugly #ifdefs include/asm-mips/mc146818rtc.h.
> It is a poor abstraction of RTC.

 These should probably be removed and a few variables used instead.  I'll 
get it fixed one day.

> If you convert DEC to the new RTC interface we could get rid of that
> file completely.

 We won't be able -- at least drivers/char/rtc.c needs it.  And also the
driver is used for more systems than the lone DECstation.

> And make no mistake, you _can_ have fast implementation that you are
> looking for.

 I fail to see how a single division plus two iomem writes can be slower
than complicated arithmetics, involving a couple of loops and divisions,
then seven iomem writes, sorry.

> BTW, are you proposing to rename rtc_set_time() to rtc_set_mmss() and change
> its semantic accordingly?  Or are you suggesting to add rtc_set_mmss()?
> 
> If you are suggesting the later, clearly fewer interface functions 
> between MIPS common and board layer is better.

 It's mostly alike to me, except that I won't need rtc_set_time() as I
don't use mips_rtc.c or genrtc.c, so I won't implement it.

 And having no rtc_set_mmss() interface I *will* implement rtc_set_time()
as a lone minutes and seconds update with an appropriate comment why it is
done so.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
