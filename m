Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via SMTP id MAA26776 for <linux-archive@neteng.engr.sgi.com>; Fri, 27 Feb 1998 12:25:39 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id MAA23845 for linux-list; Fri, 27 Feb 1998 12:24:37 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id MAA22567; Fri, 27 Feb 1998 12:21:27 -0800
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id MAA29821; Fri, 27 Feb 1998 12:21:23 -0800
	env-from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id PAA29758;
	Fri, 27 Feb 1998 15:20:55 -0500
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Fri, 27 Feb 1998 15:20:55 -0500 (EST)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: Ulf Carlsson <grimsy@varberg.se>
cc: Alistair Lambie <alambie@wellington.sgi.com>,
        "William J. Earl" <wje@fir.engr.sgi.com>, linux@cthulhu.engr.sgi.com
Subject: Re: installation problem.
In-Reply-To: <Pine.LNX.3.96.980227144932.6574F-100000@calypso.saturn>
Message-ID: <Pine.LNX.3.95.980227151518.20111B-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


On Fri, 27 Feb 1998, Ulf Carlsson wrote:
> On Fri, 27 Feb 1998, Alistair Lambie wrote:
> > William J. Earl wrote:
> > >  > Are not all indys almost identical? It's very strange IMO that .72 hangs
> > >  > before it prints anything on the screen. I think I've tested almost
> > >  > everything by now.

Ah, I think I know the problem.  There are some problems with the .72 make
depend which screws up the console.  The version that's uploaded may not
have the console compiled in properly.  That should be clear from the
config file that' sin the tar.gz file.

I could quite easily get you a binary that does have it compiled in. If I
don't have it on linus by tomorrow, pester me.

Been there, done that.

I might think about doing the update to .89, but I don't want to try to do
what anybody else is doing, since 10 Alex hours = 1 Ralf hour.  But, my
other projects with GTK and RPM are kind of at a standstill because of
waiting for others to release components and sorting out endless loops of
design logic.  So, maybe I'll take a stab at it.

- Alex
