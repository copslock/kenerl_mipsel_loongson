Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id PAA03347; Wed, 30 Apr 1997 15:16:07 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id PAA04485 for linux-list; Wed, 30 Apr 1997 15:16:15 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id PAA04479 for <linux@engr.sgi.com>; Wed, 30 Apr 1997 15:16:12 -0700
Received: from neon.ingenia.ca (neon.ingenia.ca [205.207.220.57]) by sgi.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id PAA25276
	for <linux@engr.sgi.com>; Wed, 30 Apr 1997 15:16:10 -0700
	env-from (shaver@neon.ingenia.ca)
Received: (from shaver@localhost) by neon.ingenia.ca (8.8.5/8.7.3) id SAA06646 for linux@engr.sgi.com; Wed, 30 Apr 1997 18:01:36 -0400
From: Mike Shaver <shaver@neon.ingenia.ca>
Message-Id: <199704302201.SAA06646@neon.ingenia.ca>
Subject: crti.o
To: linux@cthulhu.engr.sgi.com
Date: Wed, 30 Apr 1997 18:01:36 -0400 (EDT)
X-Mailer: ELM [version 2.4ME+ PL28 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

I've installed Ralf's mips-linux-targetted gcc and binutils, and I'm
getting _real_ close.

It's getting to the linking stage, but it's looking for a file called
crti.o, which I can't find.  I've got crt[1n] from my Indy's /usr/lib,
but there's no crti.o to be found on there.

Is this a configuration problem?

Mike

-- 
#> Mike Shaver (shaver@ingenia.com) Ingenia Communications Corporation 
#>       Chief System Architect -- Head geek -- System exorcist        
#>                                                                     
#>   "Have you considered a life?  I hear they're quite affordable     
#>          these days." --- shields@tembel.org                        
