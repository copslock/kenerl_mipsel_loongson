Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id NAA10052 for <linux-archive@neteng.engr.sgi.com>; Sun, 23 Aug 1998 13:40:33 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id NAA64307
	for linux-list;
	Sun, 23 Aug 1998 13:39:48 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id NAA01580
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 23 Aug 1998 13:39:46 -0700 (PDT)
	mail_from (sgi.sgi.com!rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id NAA00880
	for <linux@cthulhu.engr.sgi.com>; Sun, 23 Aug 1998 13:39:49 -0700 (PDT)
	mail_from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m0zAgvM-0027u4C@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Sun, 23 Aug 1998 22:39:40 +0200 (MET DST)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m0zAgvH-002OzBC; Sun, 23 Aug 98 22:39 MET DST
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id WAA00378;
	Sun, 23 Aug 1998 22:36:48 +0200
Message-ID: <19980823223647.12724@alpha.franken.de>
Date: Sun, 23 Aug 1998 22:36:47 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: linux-mips@fnet.fr, linux@cthulhu.engr.sgi.com
Subject: Emacs problem
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

I've found the cause for the emacs X11 problems. The unexec code of Emacs
doesn't handle relocations in the .rel.dyn section, because Mips seems to
be the only platform, which uses such section (sgi and sni, are using
a different implementation of unexec). This mishandling leads to an emacs
binary, which has double resolved dynamic relocations (once when dumped,
twice when executed), which leads to a seg fault. It happens only with
X11, because the relocations are only for X11 stuff.

I'll try to fix that, but it would be good to have some documentation about
the .rel.dyn section, which looks a little bit different than the i386
.rel.data section). Any pointers other than the bfd source code ?

Thomas.

-- 
See, you not only have to be a good coder to create a system like Linux,
you have to be a sneaky bastard too ;-)
                   [Linus Torvalds in <4rikft$7g5@linux.cs.Helsinki.FI>]
