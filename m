Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id WAA10918; Sun, 11 May 1997 22:34:21 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id WAA12889 for linux-list; Sun, 11 May 1997 22:34:18 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id WAA12883 for <linux@engr.sgi.com>; Sun, 11 May 1997 22:34:16 -0700
Received: from neon.ingenia.ca (neon.ingenia.ca [205.207.220.57]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id WAA16387
	for <linux@engr.sgi.com>; Sun, 11 May 1997 22:34:14 -0700
	env-from (shaver@neon.ingenia.ca)
Received: (from shaver@localhost) by neon.ingenia.ca (8.8.5/8.7.3) id BAA16316 for linux@engr.sgi.com; Mon, 12 May 1997 01:44:04 -0400
From: Mike Shaver <shaver@neon.ingenia.ca>
Message-Id: <199705120544.BAA16316@neon.ingenia.ca>
Subject: indyIRQ.S vs irq.c
To: linux@cthulhu.engr.sgi.com
Date: Mon, 12 May 1997 01:44:03 -0400 (EDT)
X-Mailer: ELM [version 2.4ME+ PL28 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

The comments in the mips/kernel Makefile indicate that the SGIs need a
different IRQ setup, and so they don't use mips/kernel/irq.c.

And yet, in mips/kernel/irq.c, we have things like:
#ifdef CONFIG_SGI
#include <asm/sgialib.h>
#endif

I presume that this stuff is vestigial from davem's early hacking, but
I'm wondering whether it's best to try and hack local_irq_count,
etc. support into indyIRQ.S, or to try and integrate the Indy support
into irq.c.  I'm much better with C, so the latter is tempting, but I
figure there's a reason Dave decided to keep them separate.

Advice?

Mike

-- 
#> Mike Shaver (shaver@ingenia.com) Ingenia Communications Corporation 
#>              Linux: because every cycle counts.
#>
#> "I don't know what you do for a living[...]" -- perry@piermont.com
#>        "I change the world." -- davem@caip.rutgers.edu
