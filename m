Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id VAA537434 for <linux-archive@neteng.engr.sgi.com>; Tue, 20 Jan 1998 21:31:32 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id VAA10068 for linux-list; Tue, 20 Jan 1998 21:27:45 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id VAA10041 for <linux@cthulhu.engr.sgi.com>; Tue, 20 Jan 1998 21:27:36 -0800
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id VAA10668
	for <linux@cthulhu.engr.sgi.com>; Tue, 20 Jan 1998 21:27:32 -0800
	env-from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id AAA02279
	for <linux@cthulhu.engr.sgi.com>; Wed, 21 Jan 1998 00:29:46 -0500
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Wed, 21 Jan 1998 00:29:46 -0500 (EST)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Statuses...
Message-ID: <Pine.LNX.3.95.980121001522.30047E-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


Or would that be statii?

With a bit of luck I'll be releasing root-be-0.03 which _will_ work, and
which will contain such things as a modern version of rpm and fdisk. Give
me 24 hours.

I've hacked most of util-linux so that it'll work with mips. hwclock will
_not_ work by accessing hardware directly, it'll have to go through
/dev/rtc, which is the way it should be anyway.  The one thing I'm missing
for that is the setup for partitioning; if someone could give me a spec
for Irix partitioned disks, I'd have a hope in hell of getting it to work.
If someone wants to sort this out, it'd be awfully nice. This includes
mkswap, swapon, which will be on root-be-0.03.

Other things:
- thanks to my Alma M., I now have a CDROM on my Indy.  Works fine.
- I started looking at modules and the MIPS kernel, and I've come to the
conclusion that modutils is just the tip of the iceberg.  Exactly what
needs to be done to the kernel for this to work?
- Thanks to FedEx and mostly Ariel, I have Indy docs.  While on the Boston
public transit system, I gained new respect for everybody who got the
basic device drivers going. It's more complex than I'd thought.
- Exactly what is required to get psaux mice working?  It compiled fine
for me, but doing a "cat /dev/psaux" hung the machine heavily.
- What are the problems in getting X working?


- Alex

-- 
      Alex deVries          Run Linux on everything,
  System Administrator      run everything on Linux.
   The EngSoc Project       Send spam to spam@engsoc.carleton.ca.
