Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id TAA01616; Tue, 8 Apr 1997 19:12:19 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id TAA04880 for linux-list; Tue, 8 Apr 1997 19:10:57 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id TAA04851 for <linux@engr.sgi.com>; Tue, 8 Apr 1997 19:10:50 -0700
Received: from neon.ingenia.ca (neon.ingenia.ca [205.207.220.57]) by sgi.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id TAA03728 for <linux@engr.sgi.com>; Tue, 8 Apr 1997 19:10:44 -0700
Received: (from shaver@localhost) by neon.ingenia.ca (8.8.5/8.7.3) id WAA06281 for linux@engr.sgi.com; Tue, 8 Apr 1997 22:09:50 -0400
From: Mike Shaver <shaver@neon.ingenia.ca>
Message-Id: <199704090209.WAA06281@neon.ingenia.ca>
Subject: init=/bin/sh and serial devices
To: linux@cthulhu.engr.sgi.com
Date: Tue, 8 Apr 1997 22:09:49 -0400 (EDT)
X-Mailer: ELM [version 2.4ME+ PL28 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Wierd stuff here.
We've got it mountinng the NFS partition and running /bin/sh, but we
can't type anything to it at that point.
It's kinda weird, because we see the `#' prompt, but stuff I type to
it isn't registering.

stdin in /dev/cua1, FWIW.

I'm going to try to get some better diags, I guess.

Mike

-- 
#> Mike Shaver (shaver@ingenia.com) Ingenia Communications Corporation 
#>              Commando Developer - Whatever It Takes
#>                                                                     
#> "See, you not only have to be a good coder to create a system like
#>    Linux, you have to be a sneaky bastard too." - Linus Torvalds
