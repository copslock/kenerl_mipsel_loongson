Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id MAA05147; Thu, 16 May 1996 12:05:08 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id TAA22974 for linux-list; Thu, 16 May 1996 19:03:42 GMT
Received: from neteng.engr.sgi.com (neteng.engr.sgi.com [192.26.80.10]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id MAA22942 for <linux@cthulhu.engr.sgi.com>; Thu, 16 May 1996 12:03:39 -0700
Received: from lanta.engr.sgi.com (lanta.engr.sgi.com [192.26.75.15]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id MAA05094 for <lmlinux@neteng.engr.sgi.com>; Thu, 16 May 1996 12:03:38 -0700
Received: by lanta.engr.sgi.com (940816.SGI.8.6.9/911001.SGI)
	 id MAA13605; Thu, 16 May 1996 12:03:35 -0700
Date: Thu, 16 May 1996 12:03:35 -0700
From: nn@lanta.engr.sgi.com (Neal Nuckolls)
Message-Id: <199605161903.MAA13605@lanta.engr.sgi.com>
To: Alan Cox <alan@cymru.net>
Subject: Re: lmbench with new checksum code...
Cc: sparclinux-cvs@caipfs.rutgers.edu, torvalds@cs.helsinki.fi,
        lmlinux@neteng.engr.sgi.com
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Alan is right, the Solaris tcp/ip implementation has a special case
for loopback which skims just the top of the IP module, no checksum,
no copy at that level, large mtu.

neal
