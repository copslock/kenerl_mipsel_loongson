Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id IAA528209 for <linux-archive@neteng.engr.sgi.com>; Tue, 16 Sep 1997 08:04:35 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id IAA28557 for linux-list; Tue, 16 Sep 1997 08:04:11 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id IAA28548 for <linux@engr.sgi.com>; Tue, 16 Sep 1997 08:04:09 -0700
Received: from neon.ingenia.ca ([205.207.220.57]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id IAA07140
	for <linux@engr.sgi.com>; Tue, 16 Sep 1997 08:04:07 -0700
	env-from (shaver@neon.ingenia.ca)
Received: (from shaver@localhost) by neon.ingenia.ca (8.8.5/8.7.3) id KAA01510 for linux@engr.sgi.com; Tue, 16 Sep 1997 10:58:42 -0400
From: Mike Shaver <shaver@neon.ingenia.ca>
Message-Id: <199709161458.KAA01510@neon.ingenia.ca>
Subject: EFS update
To: linux@cthulhu.engr.sgi.com (Linux/SGI list)
Date: Tue, 16 Sep 1997 10:58:41 -0400 (EDT)
X-Mailer: ELM [version 2.4ME+ PL28 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

OK, I've managed to merge (read: rewrite) the EFS module code into the
2.1.55 tree from linus.  I can mount my root IRIX partition, ls -l
stuff, run simple binaries and the like.  I don't handle symlinks
correctly, but that's going to be easy enough to fix.

I'm checking in my changes now, and I'll put a kernel up on ftp.linux
for people to test with.  This should make the installation process
_much_ simpler.

Mike

-- 
#> Mike Shaver (shaver@ingenia.com) Ingenia Communications Corporation 
#>           Resident Linux bigot and kernel hacker. (OOPS!)           
#> `If you get bitten by a bug, tough luck...the one thing I won't do  
#> is feel sorry for you.  In fact, I might ask you to do it all over  
#> again, just to get more information.  I'm a heartless bastard.'     
#>                       -- Linus Torvalds (on development kernels)    
