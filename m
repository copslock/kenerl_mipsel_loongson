Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id NAA10470 for <linux-archive@neteng.engr.sgi.com>; Fri, 5 Feb 1999 13:39:55 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id NAA91362
	for linux-list;
	Fri, 5 Feb 1999 13:39:07 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id NAA86873
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 5 Feb 1999 13:39:00 -0800 (PST)
	mail_from (sgi.com!rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id NAA03290
	for <linux@cthulhu.engr.sgi.com>; Fri, 5 Feb 1999 13:38:59 -0800 (PST)
	mail_from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m108sxk-0027SkC@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Fri, 5 Feb 1999 22:38:56 +0100 (MET)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m108sxd-002PC3C; Fri, 5 Feb 99 22:38 MET
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id WAA02081;
	Fri, 5 Feb 1999 22:26:07 +0100
Message-ID: <19990205222607.A2076@alpha.franken.de>
Date: Fri, 5 Feb 1999 22:26:07 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Alexander Graefe <nachtfalke@usa.net>, ralf@uni-koblenz.de,
        linux@cthulhu.engr.sgi.com
Subject: Re: What kernel to use to install RH on a R4400 ?
References: <19990202155147.A1565@ganymede> <19990203043951.D3920@uni-koblenz.de> <19990204154637.B5941@ganymede> <19990205034821.A620@uni-koblenz.de> <19990205055140.A383@ganymede>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
In-Reply-To: <19990205055140.A383@ganymede>; from Alexander Graefe on Fri, Feb 05, 1999 at 05:51:40AM +0100
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Fri, Feb 05, 1999 at 05:51:40AM +0100, Alexander Graefe wrote:
> I tried that, but .131 doesn't support nfs-root. It keeps failing to
> mount the root device.

I've uploaded my current development kernel with support for bootp
and nfs-root compiled it:

ftp://ftp.linux.sgi.com/pub/linux/mips/test/vmlinux-indy-990205.gz

BTW I want to make sure, that the kernel also boots headless (Challange S
simulation), can I just remove the newport from the Indy ?

> Can I bake my own kernel for the Indy on my PC with the right compiler ?

sure, but be prepared to do some hacking. There is no out of the box
cross compiling stuff.

Thomas.

-- 
   This device has completely bogus header. Compaq scores again :-|
It's a host bridge, but it should be called ghost bridge instead ;^)
                                        [Martin `MJ' Mares on linux-kernel]
