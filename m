Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id PAA11526 for <linux-archive@neteng.engr.sgi.com>; Mon, 31 Aug 1998 15:23:31 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA43338
	for linux-list;
	Mon, 31 Aug 1998 15:22:47 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA41485
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 31 Aug 1998 15:22:45 -0700 (PDT)
	mail_from (sgi.sgi.com!rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA14052
	for <linux@cthulhu.engr.sgi.com>; Mon, 31 Aug 1998 15:22:38 -0700 (PDT)
	mail_from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m0zDcLJ-0027rwC@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Tue, 1 Sep 1998 00:22:33 +0200 (MET DST)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m0zDcLB-002PEKC; Tue, 1 Sep 98 00:22 MET DST
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id AAA04179;
	Tue, 1 Sep 1998 00:19:11 +0200
Message-ID: <19980901001911.30136@alpha.franken.de>
Date: Tue, 1 Sep 1998 00:19:11 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Ulf Carlsson <grim@zigzegv.ml.org>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: cdrom
References: <Pine.LNX.3.96.980831184941.15439A-100000@calypso.saturn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85
In-Reply-To: <Pine.LNX.3.96.980831184941.15439A-100000@calypso.saturn>; from Ulf Carlsson on Mon, Aug 31, 1998 at 06:56:10PM +0200
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Mon, Aug 31, 1998 at 06:56:10PM +0200, Ulf Carlsson wrote:
> Hi,
> Has someone managed to mount a CD yet?

my Indy doesn't have a CDrom drive. But it works on my M700. So it's
probably related to the scsi low level driver. Ralf mentioned some
problems with DAT, but that could also be a generic problem.

> scsi: aborting command due to timeout : pid 665, scsi0, channel 0, id4,
> lun 0 Test Unit Ready 00 00 00 00 00

and CDrom drive works with IRIX ?

Thomas.

-- 
See, you not only have to be a good coder to create a system like Linux,
you have to be a sneaky bastard too ;-)
                   [Linus Torvalds in <4rikft$7g5@linux.cs.Helsinki.FI>]
