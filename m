Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id UAA02876 for <linux-archive@neteng.engr.sgi.com>; Sat, 13 Dec 1997 20:12:06 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id UAA04188 for linux-list; Sat, 13 Dec 1997 20:11:01 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id UAA04182 for <linux@cthulhu.engr.sgi.com>; Sat, 13 Dec 1997 20:10:58 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id UAA26156
	for <linux@cthulhu.engr.sgi.com>; Sat, 13 Dec 1997 20:10:55 -0800
	env-from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-08.uni-koblenz.de [141.26.249.8])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id FAA25081
	for <linux@cthulhu.engr.sgi.com>; Sun, 14 Dec 1997 05:10:24 +0100 (MET)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id EAA09489;
	Sun, 14 Dec 1997 04:58:18 +0100
Message-ID: <19971214045818.29337@uni-koblenz.de>
Date: Sun, 14 Dec 1997 04:58:18 +0100
To: Alex deVries <adevries@engsoc.carleton.ca>
Cc: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: Initrd, bzImage and more.
References: <Pine.LNX.3.95.971212090320.3688G-100000@lager.engsoc.carleton.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <Pine.LNX.3.95.971212090320.3688G-100000@lager.engsoc.carleton.ca>; from Alex deVries on Fri, Dec 12, 1997 at 09:20:42AM -0500
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Fri, Dec 12, 1997 at 09:20:42AM -0500, Alex deVries wrote:

> Back to the problem of getting initrd working...
> 
> Here's where I recall leaving off.  To use a compressed image, you
> normally set some kernel flags using rdev or similiar to define the offset
> of where the compressed image is.  Now, there's something like 11 bits
> available to define this offset.  The problem is that on MIPS,
> vmlinux kernels are considerably larger, so either the 11 bits needs to be
> larger, or we need to make the kernel smaller.
> 
> Making the kernel smaller is easily done by making bzImage kernels.  When
> I last looked, there was no way to compile a bzImage kernel.  I don't
> think fixing that would be that tough, but I guess what I don't understand
> is why bzImage kernels are architecture specific.

The entire way to boot a system, the fileformats used for etc. is highly
architecture specific because you have to deal with initalizing some
hardware state, stacks, firmware, processor modes and more.  In short,
unless you agree with Evil Bill that 640kb are enough for everybody,
don't worry too much about the way the Intel guys have to booting their
kernels and do the right thing.  The PROM variables are way nicer than
rdev to control the boot process.

> I confess that I haven't looked at this very closely recently, so correct
> me where I'm off.
> 
> Ralf said at one point that we should use the ARC stuff, and that may be a
> good idea.  But, it's not consistent with the other architectures. It'd be
> nice for SGI/Linux to be installed in the same way that RH does i386/Linux
> setups.

Actually I had enough ``fun'' with the ARC stuff that don't believe anymore
that it was a good idea.

  Ralf
