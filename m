Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id QAA06041; Sat, 31 May 1997 16:13:11 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id QAA25552 for linux-list; Sat, 31 May 1997 16:12:56 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id QAA25546 for <linux@engr.sgi.com>; Sat, 31 May 1997 16:12:53 -0700
Received: from neon.ingenia.ca (neon.ingenia.ca [205.207.220.57]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id QAA20924
	for <linux@engr.sgi.com>; Sat, 31 May 1997 16:12:47 -0700
	env-from (shaver@neon.ingenia.ca)
Received: (from shaver@localhost) by neon.ingenia.ca (8.8.5/8.7.3) id SAA30365; Sat, 31 May 1997 18:57:54 -0400
From: Mike Shaver <shaver@neon.ingenia.ca>
Message-Id: <199705312257.SAA30365@neon.ingenia.ca>
Subject: Re: ah...
In-Reply-To: <199705312209.AAA13044@informatik.uni-koblenz.de> from Ralf Baechle at "Jun 1, 97 00:09:15 am"
To: ralf@mailhost.uni-koblenz.de (Ralf Baechle)
Date: Sat, 31 May 1997 18:57:54 -0400 (EDT)
Cc: linux@cthulhu.engr.sgi.com
X-Mailer: ELM [version 2.4ME+ PL28 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Thus spake Ralf Baechle:
> I checked my own source base at home; both libc and the kernel use the
> same values as IRIX 6.2 so there must be something wrong with your libc.

No, there's something wrong with my kernel.
I'm still using davem's 2.0.12 from the CVS archive, and it uses the
"standard Linux" values for SOCK_{STREAM,DGRAM}.

I'll wait to get a newer source tree, I guess.  (Wednesday?)

I think I'd prefer to keep all of the values standard across Linux
ports, but it's not really my call.  I guess as long as your libc
changes and kernel stuff propogate into the mainline trees, it's no
big deal.

Mike

-- 
#> Mike Shaver (shaver@ingenia.com) Ingenia Communications Corporation 
#>              Linux: because every cycle counts.
#>
#> "I don't know what you do for a living[...]" -- perry@piermont.com
#>        "I change the world." -- davem@caip.rutgers.edu
