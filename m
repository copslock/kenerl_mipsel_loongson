Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id PAA16548 for <linux-archive@neteng.engr.sgi.com>; Thu, 11 Feb 1999 15:37:46 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA92606
	for linux-list;
	Thu, 11 Feb 1999 15:37:04 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA91325
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 11 Feb 1999 15:37:03 -0800 (PST)
	mail_from (sgi.com!rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA03499
	for <linux@cthulhu.engr.sgi.com>; Thu, 11 Feb 1999 15:37:00 -0800 (PST)
	mail_from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m10B5fG-0027UOC@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Fri, 12 Feb 1999 00:36:58 +0100 (MET)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m10B5f7-002PAmC; Fri, 12 Feb 99 00:36 MET
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id AAA04565;
	Fri, 12 Feb 1999 00:29:15 +0100
Message-ID: <19990212002915.A4561@alpha.franken.de>
Date: Fri, 12 Feb 1999 00:29:15 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Chris Chiapusio <chipper@llamas.net>
Cc: Alex deVries <adevries@engsoc.carleton.ca>, linux@cthulhu.engr.sgi.com
Subject: Re: Challange S question..
References: <19990211002534.A3363@alpha.franken.de> <Pine.LNX.4.05.9902111059380.683-100000@chipsworld.llamas.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
In-Reply-To: <Pine.LNX.4.05.9902111059380.683-100000@chipsworld.llamas.net>; from Chris Chiapusio on Thu, Feb 11, 1999 at 11:05:23AM -0500
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Thu, Feb 11, 1999 at 11:05:23AM -0500, Chris Chiapusio wrote:
> where can i find info on what the kernel is doing at each stage of the
> boot process for a 'install' kernel like this so i can try to debug this
> without buggin you guys for each problem?

the kernel has already booted. The HardHat kernel isn't able to work
with a serial console, and in mine is /dev/ram missing.

> mke2fs 1.10, 24-Apr-97 for EXT2 FS 0.5b, 95/08/09
> /dev/ram: Operation not supported by device while setting up superblock
> creating 100k of ramdisk space... done
> mounting /tmp from ramdisk... failed.

ok, I didn't include the ramdisk driver in the kernel. Please try:

ftp://ftp.linux.sgi.com/pub/linux/mips/test/vmlinux-indy-990212.gz

This kernel boots with the Rough Cut CD I have here.

Thomas.

-- 
   This device has completely bogus header. Compaq scores again :-|
It's a host bridge, but it should be called ghost bridge instead ;^)
                                        [Martin `MJ' Mares on linux-kernel]
