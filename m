Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id HAA457060 for <linux-archive@neteng.engr.sgi.com>; Tue, 6 Jan 1998 07:28:09 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id HAA02492 for linux-list; Tue, 6 Jan 1998 07:26:26 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id HAA02487 for <linux@cthulhu.engr.sgi.com>; Tue, 6 Jan 1998 07:26:21 -0800
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id HAA09975
	for <linux@cthulhu.engr.sgi.com>; Tue, 6 Jan 1998 07:26:19 -0800
	env-from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m0xpatS-0027YbC@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Tue, 6 Jan 1998 16:26:14 +0100 (MET)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m0xpatD-002OhsC; Tue, 6 Jan 98 16:25 MET
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id QAA00432;
	Tue, 6 Jan 1998 16:21:06 +0100
Message-ID: <19980106162106.28163@alpha.franken.de>
Date: Tue, 6 Jan 1998 16:21:06 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-mips@fnet.fr, linux@cthulhu.engr.sgi.com
Subject: Re: gcc -shared ... -lc ?
References: <19980106001619.35362@alpha.franken.de> <m0xpMZT-0005FsC@lightning.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85
In-Reply-To: <m0xpMZT-0005FsC@lightning.swansea.linux.org.uk>; from Alan Cox on Tue, Jan 06, 1998 at 12:08:38AM +0000
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Tue, Jan 06, 1998 at 12:08:38AM +0000, Alan Cox wrote:
> > > This is a binutils 2.7 bug.  Upgrading to 2.8.1 solves the problem.
> > 
> > this is with binutils-2.8.1
> 
> Oh good its not me seeing things. Ralf - could there be two sets of your
> binutils-2.8.1 one working one not and could you maybe post MD5 hashes
> of your binaries you know work ?

I'm using the little endian rpm from ftp.linux.sgi.com. Here is the md5sum:

bce052ce002cbe434133cecf2c4a4f10  binutils-2.8.1-1.mips.rpm

and:

Linux mips.franken.de 2.1.72 #140 Sat Jan 3 23:43:04 MET 1998 mips
[root@mips /root]# ld --version
GNU ld 2.8.1
Copyright 1997 Free Software Foundation, Inc.
This program is free software; you may redistribute it under the terms of
the GNU General Public License.  This program has absolutely no warranty.
  Supported emulations:
   elf32lmip
   elf32bmip
   mipslit
   mipsbig


I'm sure the binutils 2.7, I've used before, didn't have the bug. But
I wanted to make the redhat-5.0 rpms with the newer binutils.

Thomas.

-- 
See, you not only have to be a good coder to create a system like Linux,
you have to be a sneaky bastard too ;-)
                   [Linus Torvalds in <4rikft$7g5@linux.cs.Helsinki.FI>]
