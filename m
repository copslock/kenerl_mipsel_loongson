Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id QAA16769; Sun, 11 May 1997 16:49:13 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id QAA11358 for linux-list; Sun, 11 May 1997 16:49:09 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id QAA11353 for <linux@engr.sgi.com>; Sun, 11 May 1997 16:49:07 -0700
Received: from neon.ingenia.ca (neon.ingenia.ca [205.207.220.57]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id QAA08905
	for <linux@engr.sgi.com>; Sun, 11 May 1997 16:49:05 -0700
	env-from (shaver@neon.ingenia.ca)
Received: (from shaver@localhost) by neon.ingenia.ca (8.8.5/8.7.3) id TAA12648 for linux@engr.sgi.com; Sun, 11 May 1997 19:59:36 -0400
From: Mike Shaver <shaver@neon.ingenia.ca>
Message-Id: <199705112359.TAA12648@neon.ingenia.ca>
Subject: progress...
To: linux@cthulhu.engr.sgi.com
Date: Sun, 11 May 1997 19:59:36 -0400 (EDT)
X-Mailer: ELM [version 2.4ME+ PL28 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

OK, it now compiles everything except for the entry.S and head.S
problems I described before.

I think I'm getting closer to that problem, too.
The entry.S bit barfs on all the BUILD_HANDLER(...,verbose)
entries, and not on the (...,silent) ones.  Looking right above, I see
that BUILD_HANDLER(...,verbose) uses the macro BUILD_verbose(), which
contains:
                PRINT(fmt)

Aaaaaand....the offending line in head.S is:
        PRINT("Cache error exception: c0_errorepc == %08x\n")

So, I think the issue is that the Indy code for the PRINT()
macro/whatever isn't correctly set up.  I'm going to cheat and just
comment out the PRINT() lines, and see what happens to my box. =)

Mike
(-D__GOGOGO__)

-- 
#> Mike Shaver (shaver@ingenia.com) Ingenia Communications Corporation 
#>      Chief System Architect -- will tame sendmail(8) for food       
#>                                                                     
#> "You are a very perverse individual, and I think I'd like to get to 
#>  know you better." --- eric@reference.com                           
