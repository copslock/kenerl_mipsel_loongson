Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id AAA607287 for <linux-archive@neteng.engr.sgi.com>; Thu, 26 Feb 1998 00:07:59 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id AAA01895 for linux-list; Thu, 26 Feb 1998 00:07:20 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id AAA01884 for <linux@engr.sgi.com>; Thu, 26 Feb 1998 00:07:18 -0800
Received: from seaside2.varberg.se (mail.varberg.se [193.13.151.101]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id AAA15054
	for <linux@engr.sgi.com>; Thu, 26 Feb 1998 00:07:17 -0800
	env-from (grimsy@seaside.se)
Received: from calypso.saturn (grimsy@dialup118-3-28.swipnet.se [130.244.118.156]) by seaside2.varberg.se (8.8.5/8.6.9) with SMTP id IAA15731 for <linux@engr.sgi.com>; Thu, 26 Feb 1998 08:13:07 GMT
Date: Thu, 26 Feb 1998 09:09:06 +0100 (CET)
From: Ulf Carlsson <grimsy@varberg.se>
X-Sender: grimsy@calypso.saturn
To: linux@cthulhu.engr.sgi.com
Subject: Re: installation problem.
Message-ID: <Pine.LNX.3.96.980226085920.2193D-100000@calypso.saturn>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> But, there are .72 binaries in:
> ftp://ftp.linux.sgi.com/pub/test/

Sorry it's my fault (my big fool). Assumed all the .tar.gz files were
sources, forgot checking the sizes.

Well, the .72 binary didn't boot at all. I got "black screen". But .67
gets atleast so far that it mounts my root filesystem (over nfs). But
directly after that I recieve these errors (same as under .55, but this
kernel prints the message more than one time):

Unable to handle kernel paging request at virtual address 000013f0, epc ==
8803ff14, ra == 88040680
Aiee, killing interrupt handler

That message is printed out about ten times with different
values for epc and ra and virtual address.
Do you have any idea what's causing this mess?

It's also very strange that the kernel doesn't detect my scsi harddrives
correctly (I have reported these error messages earlier). I tested fx, and
fx detected them correctly. I get the same error with my orginal sgi
harddrive which obviously works, since irix doesn't have any problems with
it.

I'll take a look in the kernel source and try to figure out what's causing
that kernel paging error.

/Ulf Carlsson
