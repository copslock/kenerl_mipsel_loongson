Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id XAA59548 for <linux-archive@neteng.engr.sgi.com>; Thu, 18 Dec 1997 23:24:46 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id XAA08364 for linux-list; Thu, 18 Dec 1997 23:23:48 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id XAA08357 for <linux@engr.sgi.com>; Thu, 18 Dec 1997 23:23:46 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id XAA16390
	for <linux@engr.sgi.com>; Thu, 18 Dec 1997 23:23:44 -0800
	env-from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-03.uni-koblenz.de [141.26.249.3])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id IAA08945
	for <linux@engr.sgi.com>; Fri, 19 Dec 1997 08:23:20 +0100 (MET)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id IAA22378;
	Fri, 19 Dec 1997 08:18:57 +0100
Message-ID: <19971219081856.16849@uni-koblenz.de>
Date: Fri, 19 Dec 1997 08:18:56 +0100
To: linux-mips@fnet.fr, linux@cthulhu.engr.sgi.com,
        linux-mips@vger.rutgers.edu
Subject: Merge back
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Linus finally accepted my kernel patches and included them into 2.1.73
that way at least the bulky parts are now synchronsized with him.  I'll
work on gradually fully integrating the rest of the MIPS stuff.
I think we should go for Jazz, RM200 and Indy support in 2.2.

  Ralf
