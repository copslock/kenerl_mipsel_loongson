Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id PAA37184 for <linux-archive@neteng.engr.sgi.com>; Thu, 18 Mar 1999 15:07:42 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA88834
	for linux-list;
	Thu, 18 Mar 1999 15:06:25 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from deliverator.sgi.com (deliverator.sgi.com [150.166.91.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA00979
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 18 Mar 1999 15:06:24 -0800 (PST)
	mail_from (deliverator.sgi.com!rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id PAA09003
	for <linux@cthulhu.engr.sgi.com>; Thu, 18 Mar 1999 15:06:07 -0800 (PST)
	mail_from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m10Nlru-0027U4C@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Fri, 19 Mar 1999 00:06:26 +0100 (MET)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m10Nlri-002OygC; Fri, 19 Mar 99 00:06 MET
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id WAA03287;
	Thu, 18 Mar 1999 22:57:05 +0100
Message-ID: <19990318225705.A3281@alpha.franken.de>
Date: Thu, 18 Mar 1999 22:57:05 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: gkm@total.net, linux@cthulhu.engr.sgi.com
Subject: Re: Strange bootp behavior.
References: <199903171807.KAA26021@deliverator.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
In-Reply-To: <199903171807.KAA26021@deliverator.sgi.com>; from gkm@total.net on Wed, Mar 17, 1999 at 12:06:29PM -0600
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, Mar 17, 1999 at 12:06:29PM -0600, gkm@total.net wrote:
> scsidisk I/O error: dev 08:11, sector 528
> scsidisk I/O error: dev 08:11, sector 528
> scsidisk I/O error: dev 08:11, sector 528
> scsidisk I/O error: dev 08:11, sector 528
> Kernel panic: No init found.  Try passing init= option to kernel.

you have problems with that disk. The kernel isn't able to read the init
binary form it. The messages are for access to /dev/sdb1.

> It seems something is trying to talk to the SCSI drive for the console.

yes to get major/minor of the console and for /sbin/init.

> If I leave the PROM booting with sash from the IRIX drive, it works.

so you removed this harddisk from the scsi chain ? Have you thought about
scsi termination ?

Thomas.

-- 
   This device has completely bogus header. Compaq scores again :-|
It's a host bridge, but it should be called ghost bridge instead ;^)
                                        [Martin `MJ' Mares on linux-kernel]
