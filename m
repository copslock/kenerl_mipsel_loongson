Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id RAA22153; Sun, 11 May 1997 17:18:54 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id RAA15044 for linux-list; Sun, 11 May 1997 17:17:49 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id RAA15003 for <linux@engr.sgi.com>; Sun, 11 May 1997 17:17:43 -0700
Received: from neon.ingenia.ca (neon.ingenia.ca [205.207.220.57]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id RAA11766
	for <linux@engr.sgi.com>; Sun, 11 May 1997 17:17:42 -0700
	env-from (shaver@neon.ingenia.ca)
Received: (from shaver@localhost) by neon.ingenia.ca (8.8.5/8.7.3) id UAA13036 for linux@engr.sgi.com; Sun, 11 May 1997 20:19:59 -0400
From: Mike Shaver <shaver@neon.ingenia.ca>
Message-Id: <199705120019.UAA13036@neon.ingenia.ca>
Subject: Almost there...
To: linux@cthulhu.engr.sgi.com
Date: Sun, 11 May 1997 20:19:58 -0400 (EDT)
X-Mailer: ELM [version 2.4ME+ PL28 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

(kinda)

Everything compiles now (had to comment out another PRINT() in
arch/mips/lib/watch.S), and I just have to chase down the undefined
refs that the linker is barfing on.  So picky, these binutils are. =)

In case anyone else is working on this (Miguel?  You get your box
yet?), these are the ones that it's complaining about:

__mips_bh_counter (arch/mips/kernel/softirq.c:do_bottom_half, among
about 8 other places)
copy_sigbits32 (kernel/irixelf.c:irix_core_dump)
initialize_kbd (sgi/prom/misc.c:prom_*)
kh (drivers/char/psaux.c:write_aux_{dev,cmd})
local_irq_count (bunch of places)
rs_init (drivers/char/ttyio.c:tty_init)
serial_console (sgi/kernel/setup.c:sgi_setup)

Mail me if you want patches to my current working set...

I'll probably get back on this tomorrow at some point...I have "real
work" to do tonight. =(

Mike

-- 
#> Mike Shaver (shaver@ingenia.com)      Information Warfare Division  
#> Chief Tactical and Strategic Officer         "Saepe fidelis"        
#>                                                                     
#> "I like your game, but we have to change the rules." -- Anon        
#>                                                                     
