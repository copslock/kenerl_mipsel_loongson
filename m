Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id DAA73073 for <linux-archive@neteng.engr.sgi.com>; Wed, 3 Dec 1997 03:47:54 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id DAA19348 for linux-list; Wed, 3 Dec 1997 03:42:44 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id DAA19338 for <linux@engr.sgi.com>; Wed, 3 Dec 1997 03:42:38 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id DAA29587
	for <linux@engr.sgi.com>; Wed, 3 Dec 1997 03:42:37 -0800
	env-from (ralf@mailhost.uni-koblenz.de)
Received: from zaphod (ralf@zaphod.uni-koblenz.de [141.26.4.13])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with SMTP id MAA15922
	for <linux@engr.sgi.com>; Wed, 3 Dec 1997 12:42:35 +0100 (MET)
Received: by zaphod (SMI-8.6/KO-2.0)
	id MAA17997; Wed, 3 Dec 1997 12:42:33 +0100
Message-ID: <19971203124232.10294@zaphod.uni-koblenz.de>
Date: Wed, 3 Dec 1997 12:42:32 +0100
From: Ralf Baechle <ralf@uni-koblenz.de>
To: linux@cthulhu.engr.sgi.com
Subject: libc
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.84e
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi all,

it turned out that the libc bugs I was still observing were produced
due to the libc install process failing in a subtile way.  So the
sources are ok.  Now that this problem is gone the RPM factory has
been restarted.

Be careful: I still observe occasional disk corruption.  Fsck is your
friend :-(  I suspect the console driver is the cause as it also has
some other misterious "properties".  For some reason the system's
performance is extremly bad.  Crosscompiling libc on IRIX takes about
90 minutes using a R4600/133Mhz.  Using a R5000 under Linux takes more
than four times as much.  Again I suspect the console driver as the
cause.

Since the load address for the program interpreter is no longer fixed
in the kernel also directly calling ld.so like during the libc build or
in ldd fails.  Easy to fix.

  Ralf
