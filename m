Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id KAA14329; Fri, 30 May 1997 10:20:57 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id KAA09235 for linux-list; Fri, 30 May 1997 10:20:38 -0700
Received: from odin.corp.sgi.com (odin.corp.sgi.com [192.26.51.194]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id KAA09148 for <linux@engr.sgi.com>; Fri, 30 May 1997 10:20:29 -0700
Received: from sgi.sgi.com by odin.corp.sgi.com via ESMTP (951211.SGI.8.6.12.PATCH1502/951211.SGI)
	for <linux@engr.sgi.com> id IAA27163; Fri, 30 May 1997 08:31:57 -0700
Received: from neon.ingenia.ca (neon.ingenia.ca [205.207.220.57]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id IAA08234
	for <linux@engr.sgi.com>; Fri, 30 May 1997 08:31:55 -0700
	env-from (shaver@neon.ingenia.ca)
Received: (from shaver@localhost) by neon.ingenia.ca (8.8.5/8.7.3) id LAA13588 for linux@engr.sgi.com; Fri, 30 May 1997 11:17:00 -0400
From: Mike Shaver <shaver@neon.ingenia.ca>
Message-Id: <199705301517.LAA13588@neon.ingenia.ca>
Subject: ah...
To: linux@cthulhu.engr.sgi.com
Date: Fri, 30 May 1997 11:17:00 -0400 (EDT)
X-Mailer: ELM [version 2.4ME+ PL28 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

I think something's a bit wonky here.

  if ((fd = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP)) < 0) {
    perror("nothingserv: socket");
    return -1;
  }
# ./bind-indy 2000
nothingserv: socket: Socket type not supported
#

Perhaps I'll try building a new kernel...

Mike

-- 
#> Mike Shaver (shaver@ingenia.com) Ingenia Communications Corporation 
#>              Commando Developer - Whatever It Takes
#>                                                                     
#> "See, you not only have to be a good coder to create a system like
#>    Linux, you have to be a sneaky bastard too." - Linus Torvalds
