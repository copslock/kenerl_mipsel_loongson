Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id WAA740889 for <linux-archive@neteng.engr.sgi.com>; Mon, 8 Dec 1997 22:07:30 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id WAA28959 for linux-list; Mon, 8 Dec 1997 22:06:14 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id WAA28945 for <linux@cthulhu.engr.sgi.com>; Mon, 8 Dec 1997 22:06:09 -0800
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id WAA17003
	for <linux@cthulhu.engr.sgi.com>; Mon, 8 Dec 1997 22:06:07 -0800
	env-from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id BAA08489;
	Tue, 9 Dec 1997 01:03:18 -0500
Date: Tue, 9 Dec 1997 01:03:18 -0500 (EST)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: Ralf Baechle <ralf@uni-koblenz.de>
cc: linux@cthulhu.engr.sgi.com
Subject: Re: Uploads ...
In-Reply-To: <19971208150602.52582@brian.uni-koblenz.de>
Message-ID: <Pine.LNX.3.95.971209005539.22886D-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Mon, 8 Dec 1997, Ralf Baechle wrote:
> Just as announced I've started uploading all the toys I've been working
> on to Linus.  Right now all the RPMs (about 134mb) and all the source RPMs

Yay!

> are online.  I had to modify a couple of the source RPMs.  The most
> common bug was trying to link with libbsd.a from Linux-libc which of
> course is missing on our glibc-only system.

What is the replacement for libbsd.a, for future reference?

> I've also uploaded a linux 2.1.67 kernel binary to Linus.

I will try it tomorrow. 

I installed a load of RPM's, and had to install with a --nodeps since I
don't have the glibc RPM. As well, loads of stuff crashed.  I know this is
because of me missing a modern version of libc, so I'm really looking for
the libc release.

- Alex
