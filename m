Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id MAA09469; Tue, 27 May 1997 12:30:05 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id MAA05915 for linux-list; Tue, 27 May 1997 12:29:47 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id MAA05904 for <linux@engr.sgi.com>; Tue, 27 May 1997 12:29:44 -0700
Received: from neon.ingenia.ca (neon.ingenia.ca [205.207.220.57]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id MAA26886
	for <linux@engr.sgi.com>; Tue, 27 May 1997 12:29:38 -0700
	env-from (shaver@neon.ingenia.ca)
Received: (from shaver@localhost) by neon.ingenia.ca (8.8.5/8.7.3) id PAA21206 for linux@engr.sgi.com; Tue, 27 May 1997 15:19:29 -0400
From: Mike Shaver <shaver@neon.ingenia.ca>
Message-Id: <199705271919.PAA21206@neon.ingenia.ca>
Subject: strace/truss equiv?
To: linux@cthulhu.engr.sgi.com
Date: Tue, 27 May 1997 15:19:29 -0400 (EDT)
X-Mailer: ELM [version 2.4ME+ PL28 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

OK, I'll bite.
What's the strace/truss equivalent under IRIX?

I'm trying to figure out why my "dynamically-linked" hello world
binaries are 115K, and I can't tell where the heck the linker is
finding the static libs.

Mike

-- 
#> Mike Shaver (shaver@ingenia.com) Ingenia Communications Corporation 
#>              Linux: because every cycle counts.
#>
#> "I don't know what you do for a living[...]" -- perry@piermont.com
#>        "I change the world." -- davem@caip.rutgers.edu
