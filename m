Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id NAA10726 for <linux-archive@neteng.engr.sgi.com>; Wed, 14 Jan 1998 13:14:30 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id NAA12851 for linux-list; Wed, 14 Jan 1998 13:10:26 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id NAA12833 for <linux@cthulhu.engr.sgi.com>; Wed, 14 Jan 1998 13:10:25 -0800
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id NAA01905
	for <linux@cthulhu.engr.sgi.com>; Wed, 14 Jan 1998 13:10:21 -0800
	env-from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m0xsa4p-0027dcC@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Wed, 14 Jan 1998 22:10:19 +0100 (MET)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m0xsa4P-002OinC; Wed, 14 Jan 98 22:09 MET
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id VAA02426;
	Wed, 14 Jan 1998 21:58:47 +0100
Message-ID: <19980114215847.36294@alpha.franken.de>
Date: Wed, 14 Jan 1998 21:58:47 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: linux@cthulhu.engr.sgi.com
Subject: Re: The world's worst RPM
References: <19980114152935.14483@uni-koblenz.de> <m0xsUPg-0005FsC@lightning.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85
In-Reply-To: <m0xsUPg-0005FsC@lightning.swansea.linux.org.uk>; from Alan Cox on Wed, Jan 14, 1998 at 03:07:27PM +0000
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, Jan 14, 1998 at 03:07:27PM +0000, Alan Cox wrote:
> > Have you taken care of the fact that ncompress makes assumptions about
> > the byteorder of the machine it's running on?  For MIPS it's broken, but
> > I don't remember if it was on big or little endian ...
> 
> Its passed in the spec file. I've even port mipsel in as well for you ;)

hmm, to do this with only one src.rpm, we need a little support from
rpm. At the moment mips is defined for mipsel and mipseb. I would suggest,
that for .spec execution mips is defined for bot mipsel and mipseb, because 
there are changes, which work for both and we only need to seperate changes 
like that needed by ncompress.  Comments ? Does anybody how to do this ?

Thomas.

-- 
See, you not only have to be a good coder to create a system like Linux,
you have to be a sneaky bastard too ;-)
                   [Linus Torvalds in <4rikft$7g5@linux.cs.Helsinki.FI>]
