Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id IAA75349; Fri, 8 Aug 1997 08:25:15 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id IAA14407 for linux-list; Fri, 8 Aug 1997 08:23:37 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id IAA14364 for <linux@engr.sgi.com>; Fri, 8 Aug 1997 08:23:34 -0700
Received: from neon.ingenia.ca (neon.ingenia.ca [205.207.220.57]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id IAA29160
	for <linux@engr.sgi.com>; Fri, 8 Aug 1997 08:23:32 -0700
	env-from (shaver@neon.ingenia.ca)
Received: (from shaver@localhost) by neon.ingenia.ca (8.8.5/8.7.3) id LAA06545 for linux@engr.sgi.com; Fri, 8 Aug 1997 11:19:35 -0400
From: Mike Shaver <shaver@neon.ingenia.ca>
Message-Id: <199708081519.LAA06545@neon.ingenia.ca>
Subject: par and us*
To: linux@cthulhu.engr.sgi.com (Linux/SGI list)
Date: Fri, 8 Aug 1997 11:19:35 -0400 (EDT)
X-Mailer: ELM [version 2.4ME+ PL28 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

I've got a simple lock-contention program that I'm using to see how
the usema stuff works.

When I try to run the program under par, though, it only lets me trace
one of the invocations:

1 [shaver@linus ~/work/usema]$ par -s -SS -l -o lock-p.par ./lock p
1 Creating new lock.
1 Storing lock.
1 Getting lock.
1 Waiting...

(now I start the second one)
2 [shaver@linus ~/work/usema]$ par -s -SS -l -o lock-c2.par ./lock c
2 Cannot syscall trace pid 23779:Resource busy
2 Finding existing lock.
2 Getting lock.
2 [shaver@linus ~/work/usema]$

(back to the shell!)
(release the lock on the first invocation)
1 
1 Releasing lock.
1 Exiting
1 [shaver@linus ~/work/usema]$ 

(and now I get more output from the second invocation)
2 [shaver@linus ~/work/usema]$ Waiting...
2 Releasing lock.
2 Exiting

Under normal circumstances (no par), I have to press enter on the
second one as well for it to release the lock and exit.  When par is
doing its (arguably weird, maybe broken) thing, I don't have to do
that...

Is this a known problem?

Mike

-- 
#> Mike Shaver (shaver@ingenia.com) Ingenia Communications Corporation 
#>              Linux: because every cycle counts.
#>
#> "I don't know what you do for a living[...]" -- perry@piermont.com
#>        "I change the world." -- davem@caip.rutgers.edu
