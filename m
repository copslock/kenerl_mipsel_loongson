Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id PAA81503 for <linux-archive@neteng.engr.sgi.com>; Wed, 10 Feb 1999 15:55:06 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA82862
	for linux-list;
	Wed, 10 Feb 1999 15:53:38 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA83362
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 10 Feb 1999 15:53:36 -0800 (PST)
	mail_from (sgi.com!rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA01175
	for <linux@cthulhu.engr.sgi.com>; Wed, 10 Feb 1999 15:53:34 -0800 (PST)
	mail_from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m10AjRi-0027U5C@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Thu, 11 Feb 1999 00:53:30 +0100 (MET)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m10AjRY-002P79C; Thu, 11 Feb 99 00:53 MET
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id AAA03699
	for linux@cthulhu.engr.sgi.com; Thu, 11 Feb 1999 00:47:44 +0100
Message-ID: <19990211004744.A3682@alpha.franken.de>
Date: Thu, 11 Feb 1999 00:47:44 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: linux@cthulhu.engr.sgi.com
Subject: NG1 Revisions
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi,

the rewritten newport console has cursor problems with some newport revisions.
While it works on revision 3 NG1s, it has problems on revision 6 boards. On
these boards the cursor is nearly a character off to left from the position
it should be. Yesterday I remembered, that I had to tweak the X value for
the cursor, because it didn't work on my rev 3 board (you guessed it, the
cursor was off to the right). But the docs of the VC2 say, that the value 
I use isn't correct. So I guess, when I change it to the right value
the cursor will work perfectly on the rev 6 boards, but not on rev 3s.

To make a long story short, how do I get the revision of the newport ?

Thomas.

-- 
   This device has completely bogus header. Compaq scores again :-|
It's a host bridge, but it should be called ghost bridge instead ;^)
                                        [Martin `MJ' Mares on linux-kernel]
