Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id PAA81136 for <linux-archive@neteng.engr.sgi.com>; Fri, 5 Mar 1999 15:47:00 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA45665
	for linux-list;
	Fri, 5 Mar 1999 15:46:01 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from deliverator.sgi.com (deliverator.sgi.com [150.166.91.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA04353
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 5 Mar 1999 15:45:55 -0800 (PST)
	mail_from (deliverator.sgi.com!rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id PAA15035
	for <linux@cthulhu.engr.sgi.com>; Fri, 5 Mar 1999 15:45:40 -0800 (PST)
	mail_from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m10J4Ho-0027U7C@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Sat, 6 Mar 1999 00:45:44 +0100 (MET)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m10J4Hd-002OpiC; Sat, 6 Mar 99 00:45 MET
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id AAA02366;
	Sat, 6 Mar 1999 00:16:10 +0100
Message-ID: <19990306001607.B1601@alpha.franken.de>
Date: Sat, 6 Mar 1999 00:16:07 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Ben Payne <bpayne@propeller.com>, linux@cthulhu.engr.sgi.com
Subject: Re: Debuggers?
References: <51C3D69B3643D21194AD00400551982C5103@dino-192.propeller.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
In-Reply-To: <51C3D69B3643D21194AD00400551982C5103@dino-192.propeller.com>; from Ben Payne on Wed, Mar 03, 1999 at 01:04:55PM -0800
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, Mar 03, 1999 at 01:04:55PM -0800, Ben Payne wrote:
> I recently installed Linux on an Indy and was looking for GDB.  It's not
> part of the hardhat install, and the source doesn't support the
> mips-linux host.  I need to develop an application on the mips-linux
> architecture is there any debuggers available? 

just use gdb:-)

> I saw a mention of a patch to GDB in the list archive.  Is this solution 
> stable?  And where can I get the latest GDB patch?

I've build a SRPM for gdb, when I've compiled most of the RedHat 5.1
RPMS for little endian Linux/MIPS. You can find it on

ftp://ftp.linux.sgi.com/pub/mips/mipsel-linux/SRPMS/gdb-4.17-3.src.rpm

There is also a CVS repository of gdb von ftp.linux.sgi.com.

For me it's not always as stable as it should be. So there is still work
to do.

Thomas.

-- 
   This device has completely bogus header. Compaq scores again :-|
It's a host bridge, but it should be called ghost bridge instead ;^)
                                        [Martin `MJ' Mares on linux-kernel]
