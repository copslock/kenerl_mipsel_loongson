Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id GAA292625 for <linux-archive@neteng.engr.sgi.com>; Mon, 23 Feb 1998 06:18:52 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id GAA03783 for linux-list; Mon, 23 Feb 1998 06:15:51 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id GAA03778 for <linux@cthulhu.engr.sgi.com>; Mon, 23 Feb 1998 06:15:50 -0800
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id GAA24570
	for <linux@cthulhu.engr.sgi.com>; Mon, 23 Feb 1998 06:15:48 -0800
	env-from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id JAA11442;
	Mon, 23 Feb 1998 09:15:47 -0500
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Mon, 23 Feb 1998 09:15:47 -0500 (EST)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: Mike Shaver <shaver@netscape.com>
cc: linux@cthulhu.engr.sgi.com
Subject: Re: netscape-communicator-5.0-1.mips.rpm
In-Reply-To: <34F11DB9.C00393AF@netscape.com>
Message-ID: <Pine.LNX.3.95.980223091239.9744A-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Sun, 22 Feb 1998, Mike Shaver wrote:
> The client build team has asked me to set up a Linux/Indy system for
> them to do some preliminary porting work on, so I'd like to make sure
> that we don't spend time working around previously-fixed bugs.  Do
> people have patches (especiall libc patches!) lying around that they can
> offer up?  Better still would be actual binaries, etc., but this beggar
> won't be a chooser!

I believe the binaries you should use are:
- glibc 2.0.6 RPMs from
   ftp://ftp.linux.sgi.com/pub/redhat/redhat-4.9.1/RPMS/mips-linux/*
- all the other RPMs from 
   ftp://ftp.linux.sgi.com/pub/redhat/redhat-5.0/RPMS/mips-linux/*

And you're welcome to use alex3 if you're having problems booting up. :)

- Alex
