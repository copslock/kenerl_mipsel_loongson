Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id OAA30419; Thu, 7 Aug 1997 14:42:07 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id OAA01323 for linux-list; Thu, 7 Aug 1997 14:41:46 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id OAA01316 for <linux@engr.sgi.com>; Thu, 7 Aug 1997 14:41:44 -0700
Received: from neon.ingenia.ca (neon.ingenia.ca [205.207.220.57]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id OAA21270
	for <linux@engr.sgi.com>; Thu, 7 Aug 1997 14:41:42 -0700
	env-from (shaver@neon.ingenia.ca)
Received: (from shaver@localhost) by neon.ingenia.ca (8.8.5/8.7.3) id RAA00275 for linux@engr.sgi.com; Thu, 7 Aug 1997 17:37:53 -0400
From: Mike Shaver <shaver@neon.ingenia.ca>
Message-Id: <199708072137.RAA00275@neon.ingenia.ca>
Subject: usema stat() magic
To: linux@cthulhu.engr.sgi.com (Linux/SGI list)
Date: Thu, 7 Aug 1997 17:37:53 -0400 (EDT)
X-Mailer: ELM [version 2.4ME+ PL28 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

I'm starting to work on the /dev/usema{,clone} drivers, and it looks
pretty conceptually straightforward.

It looks like libc uses some data hidden in the stat structure (dunno
what yet, but I'm sure Miguel will need it to be accurate =) ).  What
I can't figure out is how that data's hidden in the stat structure.  I
could _completely_ understand an IOCTL on the clone fd to get data,
but it doesn't seem to do that.  It does an fstat() on the fd it gets
back...

I tried looking at the stat data, but I can't see anything in there
that leaps out at me.  If it's just for diagnostics, I'm not _too_
worried about it, certainly not in the short term, but I have the
sinking feeling that there's more to it than that.

It's quite handy that the zero-contention cases are all handled in
user-space, BTW, except that my test cases have to get that much more
complex because of it. =)

Mike

-- 
#> Mike Shaver (shaver@ingenia.com) Ingenia Communications Corporation 
#>                 Ignore the man behind the curtain.                  
#>                                                                     
#> "And then I realized that it never should have worked in the first  
#>  place.  Thus, it would not work again until rewritten." --- Anon.  
