Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id RAA21181 for <linux-archive@neteng.engr.sgi.com>; Sat, 1 Aug 1998 17:32:08 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id RAA10520
	for linux-list;
	Sat, 1 Aug 1998 17:31:32 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id RAA62102
	for <linux@cthulhu.engr.sgi.com>;
	Sat, 1 Aug 1998 17:31:30 -0700 (PDT)
	mail_from (sgi.sgi.com!rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id RAA19521
	for <linux@cthulhu.engr.sgi.com>; Sat, 1 Aug 1998 17:31:24 -0700 (PDT)
	mail_from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m0z2m3W-0027cWC@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Sun, 2 Aug 1998 02:31:22 +0200 (MET DST)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m0z2m3Q-002OsKC; Sun, 2 Aug 98 02:31 MET DST
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id CAA02483;
	Sun, 2 Aug 1998 02:29:07 +0200
Message-ID: <19980802022907.05519@alpha.franken.de>
Date: Sun, 2 Aug 1998 02:29:07 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: linux@cthulhu.engr.sgi.com
Subject: FYI newport abscon
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi,

yesterday I managed to bring up my Indy with the new console code riped
out from 2.1.109. Today I've implemented new scrolling stuff for newport
abscon, which will give us a really fast console. My simple test program, 
which does 1000 printf("\n") in a loop, gives me about 62000 lines/second
on a 160x64 sized console. I also tried that program on my Dual P-233
with a Matrox Millenium and got about 260000 lines/s on a 80x25 sized
console (which is less than 1/5 the size of the Indy console).

My next steps are to bring up hardware cursor and palette stuff. So stay
tuned...

Thomas.

-- 
See, you not only have to be a good coder to create a system like Linux,
you have to be a sneaky bastard too ;-)
                   [Linus Torvalds in <4rikft$7g5@linux.cs.Helsinki.FI>]
