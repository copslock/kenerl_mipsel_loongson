Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id MAA04695; Wed, 9 Apr 1997 12:25:56 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id MAA29136 for linux-list; Wed, 9 Apr 1997 12:25:19 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id MAA29112 for <linux@engr.sgi.com>; Wed, 9 Apr 1997 12:25:16 -0700
Received: from neon.ingenia.ca (neon.ingenia.ca [205.207.220.57]) by sgi.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id MAA11579 for <linux@engr.sgi.com>; Wed, 9 Apr 1997 12:25:11 -0700
Received: (from shaver@localhost) by neon.ingenia.ca (8.8.5/8.7.3) id EAA08923 for linux@engr.sgi.com; Wed, 9 Apr 1997 04:58:18 -0400
From: Mike Shaver <shaver@neon.ingenia.ca>
Message-Id: <199704090858.EAA08923@neon.ingenia.ca>
Subject: More on the serial strangeness
To: linux@cthulhu.engr.sgi.com
Date: Wed, 9 Apr 1997 04:58:17 -0400 (EDT)
X-Mailer: ELM [version 2.4ME+ PL28 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Some better information about my situation, now that I'm not as
rushed:

- I have a serial console on port 1 of the Indy, and I'm talking to it
via minicom on my Linux box.  WOrks great.  Sometimes BRK gets me back
to the PROM, sometimes it just hangs, but I can live with that.
- The boot process goes pretty well, but when I get past the root
mount (using init=/bin/sh), I can't interact with anything.
- I see the `# ' prompt, I get stderr output (!) but the following
commands (which do execute) produce no output:
echo "ttyS0" > /dev/ttyS0
echo "ttyS1" > /dev/ttyS1
echo "cua1" > /dev/cua1
echo "cua0" > /dev/cua0
- If I try to access /dev/console or /dev/tty[1234], I get "can't
create /dev/whatever: Error 19", which seems to be "no such device".

If someone with the appropriate tools could build me a static tail
binary, it'll make the experimentation go a fair bit faster.

I'll be back in Ottawa tomorrow afternoon for a few days, so I'll be
able to work on the console, but since I'll be travelling a _lot_ over
the next few weeks, having the serial stuff work properly is still
important.

I'm still using the dm@neteng 2.0.12 kernel.  Ralf, do you have
anything else built over there you want me to test?

(If it'll help, I can set Miguel and Ralf up with appropriate access
on neon so they can experiment.  It'll take a few days, but if it
keeps those precious geek-cycle from going to waste...)

Mike

-- 
#> Mike Shaver (shaver@ingenia.com) Ingenia Communications Corporation 
#>      Chief System Architect -- will tame sendmail(8) for food       
#>                                                                     
#> "You are a very perverse individual, and I think I'd like to get to 
#>  know you better." --- eric@reference.com                           
