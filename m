Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id VAA645125 for <linux-archive@neteng.engr.sgi.com>; Sun, 7 Dec 1997 21:40:31 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id VAA20925 for linux-list; Sun, 7 Dec 1997 21:35:56 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id VAA20916 for <linux@engr.sgi.com>; Sun, 7 Dec 1997 21:35:52 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id VAA24965
	for <linux@engr.sgi.com>; Sun, 7 Dec 1997 21:35:51 -0800
	env-from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-22.uni-koblenz.de [141.26.249.22])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id GAA03779
	for <linux@engr.sgi.com>; Mon, 8 Dec 1997 06:34:39 +0100 (MET)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id GAA01824;
	Mon, 8 Dec 1997 06:26:54 +0100
Message-ID: <19971208062654.17859@uni-koblenz.de>
Date: Mon, 8 Dec 1997 06:26:54 +0100
To: linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: New signal stuff for 2.1.68
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi all,

the new new signal stuff for Linux 2.1.68 is looking fairly nice.  In
retrospecive I did the right thing when I redid the signal stuff in
a mostly IRIX compatible way somewhen back in history.  I think we'll
be able to get rid of most of the special signal handling stuff for
the IRIX binary compatibility stuff.

  Ralf
