Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id OAA14302 for <linux-archive@neteng.engr.sgi.com>; Wed, 14 Jan 1998 14:27:24 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id OAA07049 for linux-list; Wed, 14 Jan 1998 14:23:39 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id OAA06986 for <linux@cthulhu.engr.sgi.com>; Wed, 14 Jan 1998 14:23:34 -0800
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id OAA24834
	for <linux@cthulhu.engr.sgi.com>; Wed, 14 Jan 1998 14:23:30 -0800
	env-from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id RAA31525;
	Wed, 14 Jan 1998 17:25:31 -0500
Date: Wed, 14 Jan 1998 17:25:31 -0500 (EST)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux@cthulhu.engr.sgi.com
Subject: Re: The world's worst RPM
In-Reply-To: <m0xsb7r-0005FsC@lightning.swansea.linux.org.uk>
Message-ID: <Pine.LNX.3.95.980114171159.2369M-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


On Wed, 14 Jan 1998, Alan Cox wrote:
> > hmm, to do this with only one src.rpm, we need a little support from
> > rpm. At the moment mips is defined for mipsel and mipseb. I would suggest,
> > that for .spec execution mips is defined for bot mipsel and mipseb, because 
> > there are changes, which work for both and we only need to seperate changes 
> > like that needed by ncompress.  Comments ? Does anybody how to do this ?
> Just ask Erik Troan nicely 

He has already agreed to it, I just need to submit my patches to RPM that
do the detection of the byte order for setting the soft-coded default
architecture. It'll be done by the end of the week.

- Alex
