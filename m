Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id FAA05966 for <linux-archive@neteng.engr.sgi.com>; Sun, 12 Jul 1998 05:56:17 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id FAA26085
	for linux-list;
	Sun, 12 Jul 1998 05:55:43 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id FAA09516
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 12 Jul 1998 05:55:41 -0700 (PDT)
	mail_from (sgi.sgi.com!rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id FAA29530
	for <linux@cthulhu.engr.sgi.com>; Sun, 12 Jul 1998 05:55:40 -0700 (PDT)
	mail_from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m0yvLfE-0027sFC@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Sun, 12 Jul 1998 14:55:36 +0200 (MET DST)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m0yvLf5-002OyXC; Sun, 12 Jul 98 14:55 MET DST
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id OAA01434;
	Sun, 12 Jul 1998 14:53:25 +0200
Message-ID: <19980712145324.03216@alpha.franken.de>
Date: Sun, 12 Jul 1998 14:53:24 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: linux@cthulhu.engr.sgi.com
Subject: Indy serial ports
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi,

I'm about to start converting the SGI console to a abscon style console.
To make debugging easier I'm planning to use a serial console. But my
Indy doesn't have any "normal" serial connector. I guess the two serial
ports are those PS/2 connectors near the mouse and keyboard connectors.
As I don't have an converter I need the pinout of the PS/2 connectors
to build my own one. Any hints where I can find a description of that
ports ?

Thomas.

-- 
See, you not only have to be a good coder to create a system like Linux,
you have to be a sneaky bastard too ;-)
                   [Linus Torvalds in <4rikft$7g5@linux.cs.Helsinki.FI>]
