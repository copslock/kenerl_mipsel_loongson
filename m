Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id JAA67010 for <linux-archive@neteng.engr.sgi.com>; Sat, 10 Jan 1998 09:59:02 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id JAA03554 for linux-list; Sat, 10 Jan 1998 09:54:42 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id JAA03548 for <linux@cthulhu.engr.sgi.com>; Sat, 10 Jan 1998 09:54:40 -0800
Received: from snowcrash.cymru.net (snowcrash.cymru.net [163.164.160.3]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id JAA23172
	for <linux@cthulhu.engr.sgi.com>; Sat, 10 Jan 1998 09:54:39 -0800
	env-from (alan@lxorguk.ukuu.org.uk)
Received: from lightning.swansea.linux.org.uk (the-village.bc.nu [163.164.160.21]) by snowcrash.cymru.net (8.8.7/8.7.1) with SMTP id RAA04013; Sat, 10 Jan 1998 17:54:19 GMT
Received: by lightning.swansea.linux.org.uk (Smail3.1.29.1 #2)
	id m0xr5TY-0005FsC; Sat, 10 Jan 98 18:17 GMT
Message-Id: <m0xr5TY-0005FsC@lightning.swansea.linux.org.uk>
From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Subject: Re: RedHat 5.0 RPMs for SGI...
To: adevries@engsoc.carleton.ca (Alex deVries)
Date: Sat, 10 Jan 1998 18:17:40 +0000 (GMT)
Cc: linux@cthulhu.engr.sgi.com
In-Reply-To: <Pine.LNX.3.95.980109143918.55A-100000@lager.engsoc.carleton.ca> from "Alex deVries" at Jan 9, 98 02:54:03 pm
Content-Type: text
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> I'm in the middle of churning out the RH 5.0 RPMs, and I'll upload them
> into a seperate directory on linus than the others. The only difference
> with these and many of the RPM's already on linus is that they're built
> against the latest glibc, and they're from the RH 5.0 install, not 4.9.1.

Ok. I'll work with you on that from Monday. Ive got the fixes for several
RH5 SRPMS to build with mips.  Glibc 2.0.6 should fix the argv[0] bug
and the -lbsd problems too so much more should build

> Could someone in Europe kindly create a PGP RPM?  I have one here, but I
> cannot distribute it because of ridiculous laws.

No problem. I can build pgp etc again. I'll build ssh and anything else
looking fun off replay and upload the stuff back

Alan
