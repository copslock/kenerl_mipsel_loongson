Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id PAA01769; Wed, 29 May 1996 15:00:29 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id WAA05014 for linux-list; Wed, 29 May 1996 22:00:22 GMT
Received: from neteng.engr.sgi.com (neteng.engr.sgi.com [192.26.80.10]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id PAA05005 for <linux@cthulhu.engr.sgi.com>; Wed, 29 May 1996 15:00:21 -0700
Received: from lanta.engr.sgi.com (lanta.engr.sgi.com [192.26.75.15]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id PAA01749 for <lmlinux@neteng.engr.sgi.com>; Wed, 29 May 1996 15:00:21 -0700
Received: by lanta.engr.sgi.com (940816.SGI.8.6.9/911001.SGI)
	 id OAA09070; Wed, 29 May 1996 14:59:58 -0700
Date: Wed, 29 May 1996 14:59:58 -0700
From: nn@lanta.engr.sgi.com (Neal Nuckolls)
Message-Id: <199605292159.OAA09070@lanta.engr.sgi.com>
To: torvalds@cs.helsinki.fi, alan@cymru.net
Subject: linux needs bsd networking stack
Cc: sparclinux-cvs@caipfs.rutgers.edu, lmlinux@neteng.engr.sgi.com
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


Silicon Valley is bubbling with networking startups.
Many of these new small companies are designing products
based on PC motherboards and doing some sw and/or hw
customization to turn them into networking switches,
routers, firewalls, etc.  Rather than embedding a RTOS,
they are choosing a free unix and usually this is FreeBSD
since Linux networking is not the de facto BSD stack.
The "unique" tcp/ip implementation is a liability to linux.
Is anyone working to replace the standard linux stack
with port derived from the 4.4BSD code?

thanks.

neal nuckolls
nn@engr.sgi.com
