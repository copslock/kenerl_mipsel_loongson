Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id PAA03065 for <linux-archive@neteng.engr.sgi.com>; Wed, 3 Feb 1999 15:25:11 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA84096
	for linux-list;
	Wed, 3 Feb 1999 15:24:31 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA92212
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 3 Feb 1999 15:24:25 -0800 (PST)
	mail_from (sgi.com!rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA02216
	for <linux@cthulhu.engr.sgi.com>; Wed, 3 Feb 1999 15:24:23 -0800 (PST)
	mail_from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m108Bef-0027SnC@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Thu, 4 Feb 1999 00:24:21 +0100 (MET)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m108BeY-002OmOC; Thu, 4 Feb 99 00:24 MET
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id AAA02458
	for linux@cthulhu.engr.sgi.com; Thu, 4 Feb 1999 00:13:37 +0100
Message-ID: <19990204001336.A1919@alpha.franken.de>
Date: Thu, 4 Feb 1999 00:13:36 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: linux@cthulhu.engr.sgi.com
Subject: HAL2 problem solved
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi,

look what my Indy tells me now:

resetting global isr:0018
reset done isr:0000
reactivation done isr:0018
SGI HAL2 Processor, Revision 4.1.0
hal2: checking registers
hal2: waiting isr:0019 idr0:0123 idr1:ffff idr2:0000 idr3:0000
hal2: finished waiting at cnt:1000 isr:0018 idr0:0123 idr1:ffff idr2:0000 idr3:0000
hal2: wrote #1
hal2: waiting isr:0019 idr0:0132 idr1:0231 idr2:0000 idr3:0000
hal2: finished waiting at cnt:1000 isr:0018 idr0:0132 idr1:0231 idr2:0000 idr3:0000
hal2: wrote #2
hal2: waiting isr:0019 idr0:0123 idr1:0231 idr2:0000 idr3:0000
hal2: finished waiting at cnt:1000 isr:0018 idr0:0123 idr1:0231 idr2:0000 idr3:0000
hal2: read #1
hal2: waiting isr:0019 idr0:0132 idr1:0231 idr2:0000 idr3:0000
hal2: finished waiting at cnt:1000 isr:0018 idr0:0132 idr1:0231 idr2:0000 idr3:0000
hal2: read #2
hal2: waiting isr:0019 idr0:0231 idr1:0231 idr2:0000 idr3:0000
hal2: finished waiting at cnt:1000 isr:0018 idr0:0231 idr1:0231 idr2:0000 idr3:0000
hal2: read #3
hal2: card found
sgiaudio: initializing


The problem was, that the access to HAL2 register must be 32bit wide, but
they were only 16bit (I'll check in the fixed hal2.h in a couple of minutes).
Silly me did the change yesterday, but the .o didn't get recompiled due to
messed up dependencies:-( So I did some changes today and it worked, removed
the changes and it still worked. 

Thomas.

-- 
   This device has completely bogus header. Compaq scores again :-|
It's a host bridge, but it should be called ghost bridge instead ;^)
                                        [Martin `MJ' Mares on linux-kernel]
