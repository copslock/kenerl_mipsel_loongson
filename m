Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id PAA21510 for <linux-archive@neteng.engr.sgi.com>; Mon, 15 Mar 1999 15:08:52 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA88439
	for linux-list;
	Mon, 15 Mar 1999 15:06:59 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from deliverator.sgi.com (deliverator.sgi.com [150.166.91.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA38911
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 15 Mar 1999 15:06:57 -0800 (PST)
	mail_from (deliverator.sgi.com!rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id PAA04909
	for <linux@cthulhu.engr.sgi.com>; Mon, 15 Mar 1999 15:06:41 -0800 (PST)
	mail_from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m10MejN-0027TUC@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Mon, 15 Mar 1999 22:17:01 +0100 (MET)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m10MejG-002OuWC; Mon, 15 Mar 99 22:16 MET
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id WAA02363
	for linux@cthulhu.engr.sgi.com; Mon, 15 Mar 1999 22:03:41 +0100
Message-ID: <19990315220341.C2301@alpha.franken.de>
Date: Mon, 15 Mar 1999 22:03:41 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: linux@cthulhu.engr.sgi.com
Subject: newport console problems, some hardware questions
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Ok, I finally found the reason for the video corruptions with the new
newport console some reported to me. It happens only, when there are
less than 1024 scanlines on the screen. My fix is to enable the
faster scrolling only with 1024 scanline screen modes. This slows
down scrolling, and I hope there is a better solution (but I doubt it).

It looks like video rams get only refreshed, when they are displayed. 
Is this true ? I've tried enabling the vram refresh in the config
register, but that didn't change anything. Is there are a way to avoid
losing the content of offscreen scanlines ?

Another question:

As the newport problem is mostly solved, I'll try to get the scsi fixed.
I'm now able to reproduce a complete lockup with my DAT drive. While
looking for the reason, I've got GIO fifo full interrupts (INT2 local
interrupt 0). Can someone explain, when these interrupts occur ?

Thomas.

-- 
   This device has completely bogus header. Compaq scores again :-|
It's a host bridge, but it should be called ghost bridge instead ;^)
                                        [Martin `MJ' Mares on linux-kernel]
