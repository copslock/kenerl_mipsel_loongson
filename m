Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id AAA36575 for <linux-archive@neteng.engr.sgi.com>; Mon, 15 Dec 1997 00:24:06 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id AAA08666 for linux-list; Mon, 15 Dec 1997 00:21:31 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id AAA08652 for <linux@engr.sgi.com>; Mon, 15 Dec 1997 00:21:28 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id AAA08207
	for <linux@engr.sgi.com>; Mon, 15 Dec 1997 00:21:26 -0800
	env-from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-24.uni-koblenz.de [141.26.249.24])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id JAA02205
	for <linux@engr.sgi.com>; Mon, 15 Dec 1997 09:20:55 +0100 (MET)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id JAA12989;
	Mon, 15 Dec 1997 09:16:03 +0100
Message-ID: <19971215091602.29527@uni-koblenz.de>
Date: Mon, 15 Dec 1997 09:16:02 +0100
To: linux-mips@fnet.fr, linux@cthulhu.engr.sgi.com,
        linux-mips@vger.rutgers.edu
Subject: Cleanup ...
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi all,

I removed support for all machines which aren't supposed to be useable
or at least close to which are the ACN board, Deskstation Tyne,
Deskstation rPC44 and DECstation.  I haven't received patches for those
machines over a long time and nobody seemed to be working on support
for those machines.

By now way this means that I don't want to see support for these
machines and after all, whoever wants the old source fragments can
still get them from the Attic/ directories in the CVS archive.  The
background is that I want to clean some things and without someone
actually working for these machines I'd have broken the existing fragments
anyway.

On the positive side, the Indy stopped eating filesystems and seems to
be quite useable, so when configuring you don't have to choose
CONFIG_EXPERIMENTAL any longer.  I've moved most of the SGI specific
configuration script stuff away from arch/mips/config.in to
drivers/char/Config.in and drivers/sgi/char/Config.in.

One of the next things to clean is the timer stuff.  Currently it is not
possible to use something that doesn't have 100% pc-style timers and rtc.

I'll also remove support for linking a kernel as ECOFF.  We're currently
already have alot of ELF specific tricks and will use more in the
future, so linking ELF -> ECOFF wouldn't work anymore.  Whoever works
for a machine that requires ECOFF kernels should get the ELF to ECOFF
converter program from the Milo sources which will work and not trigger
all sorts of binutils problems that are almost impossible to fix.

  Ralf
