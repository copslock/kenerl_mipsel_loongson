Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id LAA93481 for <linux-archive@neteng.engr.sgi.com>; Sat, 10 Jan 1998 11:15:03 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id LAA11684 for linux-list; Sat, 10 Jan 1998 11:11:32 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA11677 for <linux@cthulhu.engr.sgi.com>; Sat, 10 Jan 1998 11:11:22 -0800
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id LAA05460
	for <linux@cthulhu.engr.sgi.com>; Sat, 10 Jan 1998 11:11:19 -0800
	env-from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id OAA03180;
	Sat, 10 Jan 1998 14:13:33 -0500
Date: Sat, 10 Jan 1998 14:13:33 -0500 (EST)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux@cthulhu.engr.sgi.com
Subject: Re: RedHat 5.0 RPMs for SGI...
In-Reply-To: <m0xr5TY-0005FsC@lightning.swansea.linux.org.uk>
Message-ID: <Pine.LNX.3.95.980110130336.20199A-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


On Sat, 10 Jan 1998, Alan Cox wrote:
> Ok. I'll work with you on that from Monday. Ive got the fixes for several
> RH5 SRPMS to build with mips.  Glibc 2.0.6 should fix the argv[0] bug
> and the -lbsd problems too so much more should build

My build ran until about 2am last night before hanging because of a zombie
process.  No big deal.  The first pass ended at about 't'.  In about an
hour all my work will be in ftp://ftp.linux.sgi.com/pub/RedHat/RPMS-5.0 .
I've moved the existing RPMs to RPMS-4.9.x. 

- Alex
