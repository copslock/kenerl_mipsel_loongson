Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Jul 2003 00:11:04 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:23182 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225239AbTGVXLC>; Wed, 23 Jul 2003 00:11:02 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id BAA11504;
	Wed, 23 Jul 2003 01:10:55 +0200 (MET DST)
X-Authentication-Warning: delta.ds2.pg.gda.pl: macro owned process doing -bs
Date: Wed, 23 Jul 2003 01:10:54 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jun Sun <jsun@mvista.com>
cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [patch] Generic time fixes
In-Reply-To: <20030722154340.F3135@mvista.com>
Message-ID: <Pine.GSO.3.96.1030723005534.607Q-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2873
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Tue, 22 Jul 2003, Jun Sun wrote:

> >  Well, rtc_set_time() is only used by the timekeeping code, so I see no
> > problem with renaming it.  And the interface remains the same -- it's a
> > number of seconds.  So if a full update is faster than changing minutes
> > and seconds only (e.g. the RTC is a monotonic counter -- I know a system
> > that just counts 10 ms intervals), an implementation is free to do so
> > (although that enforces UTC to be kept in the RTC; a good thing anyway),
> > but it shouldn't be required to.  And I think the name should be changed
> > to reflect that. 
> 
> Actually the drivers/char/mips-rtc.c uses it too.  In that context
> a full rtc set is needed.
> 
> The same interface can be used for the 2.6 gen-rtc.c as well, where
> a full rtc update is needed also.

 But that function should be provided by the driver (it may use
system-specific backends at will -- drivers/char/rtc.c does so as well),
with all that fancy stuff about epoch and century handling. 

> I like the current way it is because :
> 
> 1) rtc_set_time() is a more generic interface so that it can be used
> in more places (such as mips-rtc.c and gen-rtc.c).

 I see no problem with that interface being used there.

> 2) rtc_set_mmss() can be reasonally emulated if it is desired on a particular
> board

 I don't think so -- it would incur a race and a severe performance hit.
It makes no sense anyway.

> 3) it is better to have just one rtc_set_xxx() instead of two.

 Please define "better".  I think it's better to have a fast variation for
timekeeping as it's been used for years now for MC146818 and clones.

> >  Well, time_status = STA_UNSYNC initially, but ntpd will reset that.
> > Which is of course required to become a server.
> 
> Actually searching through the kernel I can't find the place where
> the flag is cleared.  Am I mistaken?

 See do_adjtimex().

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
