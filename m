Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id FAA11470; Mon, 1 Jul 1996 05:29:52 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id MAA06255 for linux-list; Mon, 1 Jul 1996 12:28:22 GMT
Received: from neteng.engr.sgi.com (neteng.engr.sgi.com [192.26.80.10]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id FAA06250 for <linux@cthulhu.engr.sgi.com>; Mon, 1 Jul 1996 05:28:20 -0700
Received: (from dm@localhost) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id FAA11437; Mon, 1 Jul 1996 05:28:20 -0700
Date: Mon, 1 Jul 1996 05:28:20 -0700
Message-Id: <199607011228.FAA11437@neteng.engr.sgi.com>
From: "David S. Miller" <dm@neteng.engr.sgi.com>
To: linux@cthulhu.engr.sgi.com
Subject: wheee, irix binaries...
Reply-to: dm@sgi.com
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


Well, it at least appears that I have a stock IRIX 'sed' binary
working.  The initial framework for IRIX syscall compatability is in
the tree now and I will just whack away at this until most
'reasonable' binaries work.

For those who are wondering, sproc() shouldn't even be that hard
believe it or not, in fact I am told someone out there in linux land
has already written the kernel code for preliminary support.

Later,
David S. Miller
dm@sgi.com
