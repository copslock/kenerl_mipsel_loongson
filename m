Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id HAA71522 for <linux-archive@neteng.engr.sgi.com>; Sun, 28 Mar 1999 07:58:59 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id HAA95761
	for linux-list;
	Sun, 28 Mar 1999 07:58:07 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id HAA79801
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 28 Mar 1999 07:58:04 -0800 (PST)
	mail_from (sgi.com!rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id HAA00206
	for <linux@cthulhu.engr.sgi.com>; Sun, 28 Mar 1999 07:58:03 -0800 (PST)
	mail_from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m10RI01-0027TpC@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Sun, 28 Mar 1999 18:01:21 +0200 (MET DST)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m10RHvS-002OqWC; Sun, 28 Mar 99 17:56 MET DST
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id RAA01180;
	Sun, 28 Mar 1999 17:49:12 +0200
Message-ID: <19990328174912.A1163@alpha.franken.de>
Date: Sun, 28 Mar 1999 17:49:12 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: linux@cthulhu.engr.sgi.com
Cc: wje@fir.engr.sgi.com
Subject: SCSI problem nearly solved
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Ok, after letting the problem get some rest I figured out why I see those
strange IRQ 0. There is a bug in the driver, which leads to enabling IRQ 0
instead of IRQ 1, when a scsi_abort() occurs. Easy fix, but only part of
the problem. The lockup happened because of a bug in the generic wd33c93
driver part. If the command, which should be aborted, was at the head
of the input queue, the driver messed up the input queue, which leads
to a endless loop on the next abort. Solved !

Now the only remaining problem is, that the the wd93 reset code, isn't
able to reset the bus, because the chip is busy (looks like it doesn't
get ready again in that situation). I guess I have to use the HPC3 channel
reset, but my first try to do it wasn't quite successful. I guess one
of my next tries will succeed:-)

Thomas.

-- 
   This device has completely bogus header. Compaq scores again :-|
It's a host bridge, but it should be called ghost bridge instead ;^)
                                        [Martin `MJ' Mares on linux-kernel]
