Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id EAA22929; Fri, 2 May 1997 04:17:47 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id EAA05288 for linux-list; Fri, 2 May 1997 04:17:42 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id EAA05268 for <linux@engr.sgi.com>; Fri, 2 May 1997 04:17:38 -0700
Received: from neon.ingenia.ca (neon.ingenia.ca [205.207.220.57]) by sgi.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id EAA13851
	for <linux@engr.sgi.com>; Fri, 2 May 1997 04:17:37 -0700
	env-from (shaver@neon.ingenia.ca)
Received: (from shaver@localhost) by neon.ingenia.ca (8.8.5/8.7.3) id HAA22284; Fri, 2 May 1997 07:21:18 -0400
From: Mike Shaver <shaver@neon.ingenia.ca>
Message-Id: <199705021121.HAA22284@neon.ingenia.ca>
Subject: linux-2.1.36
To: ralf@uni-koblenz.de
Date: Fri, 2 May 1997 07:21:17 -0400 (EDT)
Cc: linux@cthulhu.engr.sgi.com
X-Mailer: ELM [version 2.4ME+ PL28 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Looks like sgiserial.c needs to be updated to use the new IRQ stuff,
etc. (can't find keypress_wait, still using queue_task_irq_off).

I'm going to wish I was paying more attention on linux-kernel when
people were going over this stuff, I just know it. =)

Also, wd33c93.c fails to compile.  Probably some simple stuff (I'm
getting parse errors), but I won't be able to do much with it until
the afternoon.

I'll try building without SCSI and serial support, and see how that
works.

Mike

-- 
#> Mike Shaver (shaver@ingenia.com) Ingenia Communications Corporation 
#>              Linux: because every cycle counts.
#>
#> "I don't know what you do for a living[...]" -- perry@piermont.com
#>        "I change the world." -- davem@caip.rutgers.edu
