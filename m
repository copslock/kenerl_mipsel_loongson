Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Apr 2003 13:52:20 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:24527 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225202AbTDOMwU>; Tue, 15 Apr 2003 13:52:20 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA14698;
	Tue, 15 Apr 2003 14:52:54 +0200 (MET DST)
Date: Tue, 15 Apr 2003 14:52:53 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ladislav Michl <ladis@linux-mips.org>
cc: Brian Murphy <brian@murphy.dk>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: rtc_[gs]et_time()
In-Reply-To: <20030415101238.C29593@ftp.linux-mips.org>
Message-ID: <Pine.GSO.3.96.1030415143703.13254D-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2051
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Tue, 15 Apr 2003, Ladislav Michl wrote:

> > >This makes it more complex to make drivers/char/genrtc.c work on MIPS, since 
> > >usually the date and time have to be converted twice: once from struct rtc_time
> > >to seconds in <asm/rtc.h>, and once from seconds to struct rtc_time in each RTC
> > >driver.
> > >
> > >Is it OK to make rtc_[gs]et_time() always use struct rtc_time?
> > >
> > I quite like it the way it is ;-)
> 
> While I would like to see rtc_[gs]et_time() always use struct rtc_time ;)

 Note that the system time is always a monotonic count of seconds (plus a
fractional part), but the format stored in RTC chips varies.  So I think
it should be passed unchanged and the convertion left up to specific
drivers, possibly with an aid for ones that closely match 'struct
rtc_time' by means of library or inline helper functions. 

 E.g. one of the yet unsupported DECstations uses a 32bit register
counting 10ms intervals as its RTC (or actually TOY).  So maybe it's
'struct timespec' that should really be passed... 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
