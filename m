Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id KAA51109 for <linux-archive@neteng.engr.sgi.com>; Thu, 15 Jan 1998 10:40:12 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id KAA14558 for linux-list; Thu, 15 Jan 1998 10:39:35 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id KAA14552 for <linux@cthulhu.engr.sgi.com>; Thu, 15 Jan 1998 10:39:33 -0800
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id KAA26276
	for <linux@cthulhu.engr.sgi.com>; Thu, 15 Jan 1998 10:39:32 -0800
	env-from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id NAA11078;
	Thu, 15 Jan 1998 13:42:39 -0500
Date: Thu, 15 Jan 1998 13:42:39 -0500 (EST)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: Michael Hill <mdhill@interlog.com>
cc: linux@cthulhu.engr.sgi.com
Subject: Re: Follow-up:  Hard Drive Problems
In-Reply-To: <199801151340.IAA03707@mdhill.interlog.com>
Message-ID: <Pine.LNX.3.95.980115133336.4203C-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


On Thu, 15 Jan 1998, Michael Hill wrote:

> Modifications to /var/sysgen/master.d/wd93 (courtesy of dealer tech
> support) have permitted my hard drive to be recognized by IRIX.  I
> successfully ran mke2fs on it and I'm trying to figure out what to do
> next.  Is there any further news on Mike Shaver's installer script?

I don't know about Mike's installer, but I'm working now on getting initrd
and a ramdisk together that'll let you do the install from Linux. Give me
a week.

> Barring that, what would be the next step in installing Alex'
> root-be-0.02 from IRIX?

The current method that _will_ work is putting the kernel on your EFS
drive, and mounting up your root filesystem with tftp and nfs.  That
assumes that you don't have problems getting another machine on the
network.

I have no idea if root-be-0.002 actually works, either.  I should probably
try that. root=be-0.00 will, though.

Oh, and as soon as we have a functional ssh server, I can consider giving
accounts on my machine for development purposes.

- Alex
