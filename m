Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id PAA479192 for <linux-archive@neteng.engr.sgi.com>; Tue, 6 Jan 1998 15:20:43 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id PAA13172 for linux-list; Tue, 6 Jan 1998 15:19:27 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id PAA13153 for <linux@engr.sgi.com>; Tue, 6 Jan 1998 15:19:22 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id PAA01268
	for <linux@engr.sgi.com>; Tue, 6 Jan 1998 15:19:20 -0800
	env-from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-09.uni-koblenz.de [141.26.249.9])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id AAA26901
	for <linux@engr.sgi.com>; Wed, 7 Jan 1998 00:19:18 +0100 (MET)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id AAA05242;
	Wed, 7 Jan 1998 00:05:46 +0100
Message-ID: <19980107000546.28542@uni-koblenz.de>
Date: Wed, 7 Jan 1998 00:05:46 +0100
To: linux-mips@fnet.fr, linux@cthulhu.engr.sgi.com
Subject: Binutils ...
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

After Thomas posted his analysis of his binutils bug I doublechecked
the binutils binary package.  It doesn't contain the arch directory
because I used the RedHat spec file which (imho a superfluous attempt
to be overly conforming to the FHS) explicitly build the binutils
without the arch directory.  I'll upload a fixed package shortly.

Alan, what were your sympthoms again, did the built executables crash
or the linker itself?  I understood the later ...

Oh, and a happy new year to you all out there!

  Ralf
