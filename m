Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id GAA1176941 for <linux-archive@neteng.engr.sgi.com>; Fri, 12 Dec 1997 06:24:28 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id GAA28566 for linux-list; Fri, 12 Dec 1997 06:23:34 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id GAA28556 for <linux@cthulhu.engr.sgi.com>; Fri, 12 Dec 1997 06:23:32 -0800
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id GAA16791
	for <linux@cthulhu.engr.sgi.com>; Fri, 12 Dec 1997 06:23:29 -0800
	env-from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id JAA25541
	for <linux@cthulhu.engr.sgi.com>; Fri, 12 Dec 1997 09:20:42 -0500
Date: Fri, 12 Dec 1997 09:20:42 -0500 (EST)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Initrd, bzImage and more.
Message-ID: <Pine.LNX.3.95.971212090320.3688G-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


Back to the problem of getting initrd working...

Here's where I recall leaving off.  To use a compressed image, you
normally set some kernel flags using rdev or similiar to define the offset
of where the compressed image is.  Now, there's something like 11 bits
available to define this offset.  The problem is that on MIPS,
vmlinux kernels are considerably larger, so either the 11 bits needs to be
larger, or we need to make the kernel smaller.

Making the kernel smaller is easily done by making bzImage kernels.  When
I last looked, there was no way to compile a bzImage kernel.  I don't
think fixing that would be that tough, but I guess what I don't understand
is why bzImage kernels are architecture specific.

I confess that I haven't looked at this very closely recently, so correct
me where I'm off.

Ralf said at one point that we should use the ARC stuff, and that may be a
good idea.  But, it's not consistent with the other architectures. It'd be
nice for SGI/Linux to be installed in the same way that RH does i386/Linux
setups.

Anyway, I'm not going to have a hell of a lot of time to work on things
for the rest of the month as I'm on vacation for two weeks, and I'll be in
a different country than my Indy.

- A

      Alex deVries          Rent this space for a $5 donation 
  System Administrator      to EngSoc per day.
   The EngSoc Project       Send spam to spam@engsoc.carleton.ca.
