Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id MAA74167 for <linux-archive@neteng.engr.sgi.com>; Thu, 17 Jun 1999 12:38:15 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA62899
	for linux-list;
	Thu, 17 Jun 1999 12:36:59 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA40753
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 17 Jun 1999 12:36:57 -0700 (PDT)
	mail_from (sgi.com!rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id MAA00983
	for <linux@cthulhu.engr.sgi.com>; Thu, 17 Jun 1999 12:36:54 -0700 (PDT)
	mail_from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m10uhxu-0027VRC@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Thu, 17 Jun 1999 21:36:46 +0200 (MET DST)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m10uhxo-002P40C; Thu, 17 Jun 99 21:36 MET DST
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id VAA02284;
	Thu, 17 Jun 1999 21:23:10 +0200
Message-ID: <19990617212309.B2084@alpha.franken.de>
Date: Thu, 17 Jun 1999 21:23:09 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Mike Hill <mikehill@hgeng.com>, linux@cthulhu.engr.sgi.com
Subject: Re: Booting an Indigo2
References: <E138DB347D10D3119C630008C79F5DEC07EA0E@BART>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
In-Reply-To: <E138DB347D10D3119C630008C79F5DEC07EA0E@BART>; from Mike Hill on Thu, Jun 17, 1999 at 02:39:40PM -0400
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Thu, Jun 17, 1999 at 02:39:40PM -0400, Mike Hill wrote:
> Sorry, this looks familiar.  Here's what I get in my serial console:

do you think so ?

> Root-NFS: Server returned error -13 while mounting /usr/src/installfs
> VFS: Unable to mount root fs via NFS, trying floppy.

your Indigo isn't able to mount the NFS root. According to linux/nfs.h
the error is NFSERR_ACCES.

> request_module[block-major-2]: Root fs not mounted

so it tries to use the floppy drive. But since there is no driver in the
kernel, it tries to load the module for it, which fails.

> VFS: Cannot open root device 02:00
> Kernel panic: VFS: Unable to mount root fs on 02:00

no root filesystem, no fun.

Or do I miss something ?

Thomas.

-- 
   This device has completely bogus header. Compaq scores again :-|
It's a host bridge, but it should be called ghost bridge instead ;^)
                                        [Martin `MJ' Mares on linux-kernel]
