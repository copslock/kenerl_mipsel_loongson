Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id OAA70302 for <linux-archive@neteng.engr.sgi.com>; Wed, 19 Aug 1998 14:55:37 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA80309
	for linux-list;
	Wed, 19 Aug 1998 14:54:54 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA75895
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 19 Aug 1998 14:54:52 -0700 (PDT)
	mail_from (sgi.sgi.com!rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA28228
	for <linux@cthulhu.engr.sgi.com>; Wed, 19 Aug 1998 14:54:51 -0700 (PDT)
	mail_from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m0z9GBo-0027pQC@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Wed, 19 Aug 1998 23:54:44 +0200 (MET DST)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m0z9GBf-002PBjC; Wed, 19 Aug 98 23:54 MET DST
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id XAA02656;
	Wed, 19 Aug 1998 23:51:42 +0200
Message-ID: <19980819235142.36595@alpha.franken.de>
Date: Wed, 19 Aug 1998 23:51:42 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr
Subject: Debugging emacs
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi,

before I'll ask a bigger audience, I ask here:

As some of you know, emacs dies, when started to open it's own
X window on Linux/MIPS. While trying to debug emacs with gdb,
I found out, that emacs kills it's own .mdebug section when it dumps
(it inserts a new .data section, which kills all references in
the .mdebug section).

Now I'm looking for a way to start a X session with temacs, which has
a working .mdebug section. I'm able to do a temacs -l loadup, which 
will give me a "normal" looking emacs. But I haven't found a way to get 
temacs to create a X session.

Any hints ?

Thomas.

-- 
See, you not only have to be a good coder to create a system like Linux,
you have to be a sneaky bastard too ;-)
                   [Linus Torvalds in <4rikft$7g5@linux.cs.Helsinki.FI>]
