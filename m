Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id JAA414159 for <linux-archive@neteng.engr.sgi.com>; Fri, 5 Dec 1997 09:13:56 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id JAA24454 for linux-list; Fri, 5 Dec 1997 09:11:09 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id JAA24424 for <linux@engr.sgi.com>; Fri, 5 Dec 1997 09:11:04 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id JAA05855
	for <linux@engr.sgi.com>; Fri, 5 Dec 1997 09:11:00 -0800
	env-from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (ralf@pmport-09.uni-koblenz.de [141.26.249.9])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id SAA24125
	for <linux@engr.sgi.com>; Fri, 5 Dec 1997 18:10:57 +0100 (MET)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id SAA02427;
	Fri, 5 Dec 1997 18:07:17 +0100
Message-ID: <19971205180717.22087@uni-koblenz.de>
Date: Fri, 5 Dec 1997 18:07:17 +0100
To: linux@cthulhu.engr.sgi.com
Subject: Update ...
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

135mb rpm packages and maybe 20mb tarballs waiting to be uploaded.  Plus
a small pile of tarballs ...  Problems still to solve:

  - a change in the kernel makes ld.so die under certain circumstances.
  - RedHat's sh-utils package is broken, it's pam support  doesn't compile.
  - When building the binutils 2.8.1-1 rpm cc1 dies with signal 6.
    Strange, because the same package works great on the little endian
    boxes and GCC actually shouldn't contain byteorder problems.
  - the Emacs srpm refuses to he compiled on big endian machines
  - I think I found the bug causing the large number of timouts the Seeq
    driver is signalling.  Haven't tested it, my kernel sources are in the
    other end of the universe, under IRIX and I don't feel like rebooting ...
  - timekeeping seems to be pretty broken, I saw my clock doing 10h in
    three hours of uptime.
  - the console code is somehow broken.  Occasionally it writes garbage
    characters under the lowest line that normally is used.  When the
    screenblanker is active one can see it writing garbage characters
    on other places of the screen.  Aside it's crawling, scrolling in less
    reminds of a Sparc console of a slow Sparc.  Furthermore I suspect
    the console is also the cause of the memory corruption I occasionally
    see.

Fixing #1 is the most important.  It breaks recompiling libc as well as
the library dependency generation in RPM for all packages.  RPM, btw. is
dumb and continues without noticing ...

  Ralf
