Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id LAA811322 for <linux-archive@neteng.engr.sgi.com>; Fri, 9 Jan 1998 11:57:20 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id LAA18799 for linux-list; Fri, 9 Jan 1998 11:52:07 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA18762 for <linux@cthulhu.engr.sgi.com>; Fri, 9 Jan 1998 11:52:02 -0800
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id LAA01542
	for <linux@cthulhu.engr.sgi.com>; Fri, 9 Jan 1998 11:51:40 -0800
	env-from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id OAA04959
	for <linux@cthulhu.engr.sgi.com>; Fri, 9 Jan 1998 14:54:03 -0500
Date: Fri, 9 Jan 1998 14:54:03 -0500 (EST)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: RedHat 5.0 RPMs for SGI...
Message-ID: <Pine.LNX.3.95.980109143918.55A-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


Now that I'm nicely settled back at work with my Indy, I've had a chance
to get my system up to scratch with Ralf's latest glibc.  Much better!
gethostbbynam and such now work properly, so I can now build RPMs.

I'm in the middle of churning out the RH 5.0 RPMs, and I'll upload them
into a seperate directory on linus than the others. The only difference
with these and many of the RPM's already on linus is that they're built
against the latest glibc, and they're from the RH 5.0 install, not 4.9.1.

Most of the work is getting a build environment going; the rpm of rpm
itself on linus won't build because it's compiled against an older libc;
then there's all the other broken libraries to create or fix...

Could someone in Europe kindly create a PGP RPM?  I have one here, but I
cannot distribute it because of ridiculous laws.

Some odd problems I'm encountering:
- the bare system which runs nothing consumes 20MB of RAM.  I'm using
Ralf's 2.1.67 kernel.  Perhaps I'm reading it wrong, but 'free' gives me
20MB used, 16MB which is unaccounted for.  Does this mean the kernel is
using 16MB? Wow. It explains the 'memory exhausted' problems I get.
- gcc occasionally segfaults.

But, I have a functional system I can telnet into with virtual consoles
and most things II need to get boot strapped.  It looks good.

- A

-- 
      Alex deVries          Run Linux on everything,
  System Administrator      run everything on Linux.
   The EngSoc Project       Send spam to spam@engsoc.carleton.ca.
