Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id JAA753649 for <linux-archive@neteng.engr.sgi.com>; Mon, 1 Dec 1997 09:21:26 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id JAA29414 for linux-list; Mon, 1 Dec 1997 09:17:23 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id JAA29380 for <linux@engr.sgi.com>; Mon, 1 Dec 1997 09:17:16 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id JAA27957
	for <linux@engr.sgi.com>; Mon, 1 Dec 1997 09:17:13 -0800
	env-from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (ralf@pmport-11.uni-koblenz.de [141.26.249.11])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id SAA12389
	for <linux@engr.sgi.com>; Mon, 1 Dec 1997 18:16:59 +0100 (MET)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id RAA07625;
	Mon, 1 Dec 1997 17:29:25 +0100
Message-ID: <19971201172924.64009@uni-koblenz.de>
Date: Mon, 1 Dec 1997 17:29:24 +0100
To: linux@cthulhu.engr.sgi.com
Subject: SGI specific header files
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Miguel,

you've added a couple of SGI specific header files for the GFX hardware.
If we're going to use the same interfaces as the native Linux interfaces
also, then we should probably add them to libc.  What do you think?

  Ralf
