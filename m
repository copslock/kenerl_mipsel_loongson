Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id HAA96883 for <linux-archive@neteng.engr.sgi.com>; Sun, 4 Oct 1998 07:45:06 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id HAA47687
	for linux-list;
	Sun, 4 Oct 1998 07:44:25 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id HAA93478
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 4 Oct 1998 07:44:23 -0700 (PDT)
	mail_from (sgi.sgi.com!rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id HAA00173
	for <linux@cthulhu.engr.sgi.com>; Sun, 4 Oct 1998 07:44:18 -0700 (PDT)
	mail_from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m0zPpOR-00281bC@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Sun, 4 Oct 1998 15:44:15 +0100 (MET)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m0zPpOM-002OsaC; Sun, 4 Oct 98 16:44 MET DST
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id QAA01200;
	Sun, 4 Oct 1998 16:38:41 +0200
Message-ID: <19981004163840.40084@alpha.franken.de>
Date: Sun, 4 Oct 1998 16:38:40 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Ulf Carlsson <grim@zigzegv.ml.org>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: HAL2
References: <Pine.LNX.3.96.981004125525.2569A-100000@calypso.saturn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85
In-Reply-To: <Pine.LNX.3.96.981004125525.2569A-100000@calypso.saturn>; from Ulf Carlsson on Sun, Oct 04, 1998 at 01:23:12PM +0200
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Sun, Oct 04, 1998 at 01:23:12PM +0200, Ulf Carlsson wrote:
> level applications. The implementation of my HAL2 driver will exist in
> kernel space, and a user level library will provide higher level interface
> to the applications (the same interface as libaudio.a in IRIX). Do we know
> what the interface between libaudio.a and the Irix kernel looks like or am
> I free to do what I want?

For IRIX compatibilty, we may want to implement the same interface as
IRIX has. But for Linux compatiblity we should have something, which fits
into the current Linux sound devices scheme. And as the Linux interface is 
available in source, I would go that way. And when you do the libaudio.a 
stuff based on the Linux sound devices, it will also be available for other 
Linux architectures.

Maybe it's even possible to get IRIX compatible sound, with a user level
only solution.

Thomas.

-- 
See, you not only have to be a good coder to create a system like Linux,
you have to be a sneaky bastard too ;-)
                   [Linus Torvalds in <4rikft$7g5@linux.cs.Helsinki.FI>]
