Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id UAA109140 for <linux-archive@neteng.engr.sgi.com>; Sun, 23 Nov 1997 20:47:42 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id UAA02226 for linux-list; Sun, 23 Nov 1997 20:44:40 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id UAA02200 for <linux@engr.sgi.com>; Sun, 23 Nov 1997 20:44:30 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id UAA26263
	for <linux@engr.sgi.com>; Sun, 23 Nov 1997 20:44:28 -0800
	env-from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (ralf@pmport-02.uni-koblenz.de [141.26.249.2])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id FAA29938
	for <linux@engr.sgi.com>; Mon, 24 Nov 1997 05:44:24 +0100 (MET)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.8.7/8.8.7) id FAA11321;
	Mon, 24 Nov 1997 05:41:11 +0100
Message-ID: <19971124054108.44804@lappi.waldorf-gmbh.de>
Date: Mon, 24 Nov 1997 05:41:08 +0100
From: ralf@uni-koblenz.de
To: linux@cthulhu.engr.sgi.com
Subject: Libc in CVS
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi all,

with the bug fixes I checked in during the last few days libc is now
pretty stable.  In particular the problems with wrong relocations in
the X libraries and all libpam clients are working now.

Still to do:

 - some of the fixes are not very nice or correct at all
 - build binaries for redistribution.  Can somebody take care of this?

Given that this opens the way to useable native X libraries, which makes
building a large number of other RPM packages possible, these patches
are quite a breakthough.

  Ralf
