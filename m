Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id IAA566252 for <linux-archive@neteng.engr.sgi.com>; Tue, 16 Sep 1997 08:58:38 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id IAA11878 for linux-list; Tue, 16 Sep 1997 08:58:16 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id IAA11861 for <linux@engr.sgi.com>; Tue, 16 Sep 1997 08:58:14 -0700
Received: from neon.ingenia.ca (neon.ingenia.ca [205.207.220.57]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id IAA22794
	for <linux@engr.sgi.com>; Tue, 16 Sep 1997 08:58:12 -0700
	env-from (shaver@neon.ingenia.ca)
Received: (from shaver@localhost) by neon.ingenia.ca (8.8.5/8.7.3) id LAA02252 for linux@engr.sgi.com; Tue, 16 Sep 1997 11:52:54 -0400
From: Mike Shaver <shaver@neon.ingenia.ca>
Message-Id: <199709161552.LAA02252@neon.ingenia.ca>
Subject: EFS update II
To: linux@cthulhu.engr.sgi.com (Linux/SGI list)
Date: Tue, 16 Sep 1997 11:52:54 -0400 (EDT)
X-Mailer: ELM [version 2.4ME+ PL28 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

OK, there's more that needs fixing than the symlink handling.
I still don't handle indirect extents properly either, and I've got
something a little wrong in the directory reading that gives bogus
filenames on occasion.

I'll let you know when I have something usable.

Mike

-- 
#> Mike Shaver (shaver@ingenia.com) Ingenia Communications Corporation 
#>              Commando Developer - Whatever It Takes
#>                                                                     
#> "See, you not only have to be a good coder to create a system like
#>    Linux, you have to be a sneaky bastard too." - Linus Torvalds
