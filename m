Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id RAA09688; Mon, 5 Aug 1996 17:00:30 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id XAA07267 for linux-list; Mon, 5 Aug 1996 23:51:20 GMT
Received: from neteng.engr.sgi.com (neteng.engr.sgi.com [192.26.80.10]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id QAA07262 for <linux@cthulhu.engr.sgi.com>; Mon, 5 Aug 1996 16:51:19 -0700
Received: (from lm@localhost) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id QAA07180 for linux; Mon, 5 Aug 1996 16:51:19 -0700
Date: Mon, 5 Aug 1996 16:51:19 -0700
From: lm@neteng.engr.sgi.com (Larry McVoy)
Message-Id: <199608052351.QAA07180@neteng.engr.sgi.com>
To: linux@neteng.engr.sgi.com
Subject: coolness
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

For an unrelated-to-Linux project that I'm working on with some other
folks over here, we needed a user level NFS server.  So I stole David's
GCC for IRIX compilation environment and built the Linux user level NFS
server code on IRIX.  I uninstalled NFS (which unfortunately also removes
YP, that's a bummer, I had to copy over hosts) and started up Linux's
version.

You can play with it right now.  Try

	% cd /hosts/fubar.engr
	% ls

Pretty cool, huh?

--lm
---
Larry McVoy     lm@sgi.com     http://reality.sgi.com/lm     (415) 933-1804
