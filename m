Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id LAA109077 for <linux-archive@neteng.engr.sgi.com>; Tue, 13 Jan 1998 11:06:09 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id LAA04628 for linux-list; Tue, 13 Jan 1998 11:02:28 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA04617 for <linux@cthulhu.engr.sgi.com>; Tue, 13 Jan 1998 11:02:27 -0800
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id LAA26890
	for <linux@cthulhu.engr.sgi.com>; Tue, 13 Jan 1998 11:02:19 -0800
	env-from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id OAA29244
	for <linux@cthulhu.engr.sgi.com>; Tue, 13 Jan 1998 14:05:19 -0500
Date: Tue, 13 Jan 1998 14:05:18 -0500 (EST)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: vmlinux and ldd
Message-ID: <Pine.LNX.3.95.980113135148.15630E-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


1. I can now compile kernel properly, but when I try to boot them,  I get
errors  that show a register dump within the boot monitor, or or I just
get a blank screen.  When I do a 'file' on the images from within Irix,
the working ones are of type "ELF 32-bit MSB executable (not stripped)
MIPS - version 1", mine is "ELF 32-bit MSB mips-2 executable (not stripped
MIPS - version 1". What am I doing wrong?

2. ldd always segfaults on me.  Does anyone have a functioning version of
it?

- A

-- 
      Alex deVries          Run Linux on everything,
  System Administrator      run everything on Linux.
   The EngSoc Project       Send spam to spam@engsoc.carleton.ca.
