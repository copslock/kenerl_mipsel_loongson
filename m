Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id WAA13472; Thu, 29 May 1997 22:51:34 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id WAA09513 for linux-list; Thu, 29 May 1997 22:50:09 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id WAA09493 for <linux@engr.sgi.com>; Thu, 29 May 1997 22:50:06 -0700
Received: from neon.ingenia.ca (neon.ingenia.ca [205.207.220.57]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id WAA16815
	for <linux@engr.sgi.com>; Thu, 29 May 1997 22:50:04 -0700
	env-from (shaver@neon.ingenia.ca)
Received: (from shaver@localhost) by neon.ingenia.ca (8.8.5/8.7.3) id BAA09588 for linux@engr.sgi.com; Fri, 30 May 1997 01:48:34 -0400
From: Mike Shaver <shaver@neon.ingenia.ca>
Message-Id: <199705300548.BAA09588@neon.ingenia.ca>
Subject: userland cometh
To: linux@cthulhu.engr.sgi.com
Date: Fri, 30 May 1997 01:48:34 -0400 (EDT)
X-Mailer: ELM [version 2.4ME+ PL28 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

OK, I think I've got this cross-compiling thing licked.

Modulo some bogus interactions between the mostly-hacked 2.1.36 kernel
headers and the glibc 2.0.1 stuff (which seems to be a bit off itself,
but that's for another day), userland is coming along nicely.

I've been rebuilding with the glibc-2.0.1 stuff and all-dynamic
linking, and I've got:
fileutils-3.16
tar-1.12
sh-utils-1.16
textutils-1.22
ncurses_1.9.9g (just the libncurses.a, ma'am)
net-tools' inetd, arp, ifconfig, rarp, route and telnetd

I can't get ping or bash to work build just yet (ping was _not_ happy with
my headers), but I'll keep at it.

Once I'm done here, I'll be making a new root.tar.gz for anyone who
wants to play around with it.

Mike

-- 
#> Mike Shaver (shaver@ingenia.com) Ingenia Communications Corporation 
#>      Chief System Architect -- will tame sendmail(8) for food       
#>                                                                     
#> "You are a very perverse individual, and I think I'd like to get to 
#>  know you better." --- eric@reference.com                           
