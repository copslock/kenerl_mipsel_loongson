Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id KAA17648; Mon, 30 Jun 1997 10:58:22 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id KAA00849 for linux-list; Mon, 30 Jun 1997 10:58:02 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id KAA00813 for <linux@engr.sgi.com>; Mon, 30 Jun 1997 10:57:55 -0700
Received: from neon.ingenia.ca (neon.ingenia.ca [205.207.220.57]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id KAA12311
	for <linux@engr.sgi.com>; Mon, 30 Jun 1997 10:57:54 -0700
	env-from (shaver@neon.ingenia.ca)
Received: (from shaver@localhost) by neon.ingenia.ca (8.8.5/8.7.3) id NAA07279; Mon, 30 Jun 1997 13:54:24 -0400
From: Mike Shaver <shaver@neon.ingenia.ca>
Message-Id: <199706301754.NAA07279@neon.ingenia.ca>
Subject: ncurses
To: ralf@uni-koblenz.de (Ralf Baechle),
        miguel@roxanne.nuclecu.unam.mx (Miguel de Icaza)
Date: Mon, 30 Jun 1997 13:54:23 -0400 (EDT)
Cc: linux@cthulhu.engr.sgi.com
X-Mailer: ELM [version 2.4ME+ PL28 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

ncurses is built, and it was pretty clean (now that I've got tools to
munge Makefiles for me).

I'll build a tarball with includes and libs suitable for unpacking in
/usr/local/mips-linux on the crossdev machine or /usr on the Indy
itself and stick it on linus shortly.

Mike

-- 
#> Mike Shaver (shaver@ingenia.com) Ingenia Communications Corporation 
#>       Chief System Architect -- Head geek -- System exorcist        
#>                                                                     
#>   "Have you considered a life?  I hear they're quite affordable     
#>          these days." --- shields@tembel.org                        
