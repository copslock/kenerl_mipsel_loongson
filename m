Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id OAA92009 for <linux-archive@neteng.engr.sgi.com>; Mon, 1 Feb 1999 14:25:44 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA40684
	for linux-list;
	Mon, 1 Feb 1999 14:24:43 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA48811
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 1 Feb 1999 14:24:41 -0800 (PST)
	mail_from (sgi.com!rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA08253
	for <linux@cthulhu.engr.sgi.com>; Mon, 1 Feb 1999 14:24:40 -0800 (PST)
	mail_from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m107RkV-0027SwC@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Mon, 1 Feb 1999 23:23:19 +0100 (MET)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m107RkP-002P2jC; Mon, 1 Feb 99 23:23 MET
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id XAA02813
	for linux@cthulhu.engr.sgi.com; Mon, 1 Feb 1999 23:10:03 +0100
Message-ID: <19990201231003.A2810@alpha.franken.de>
Date: Mon, 1 Feb 1999 23:10:03 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: linux@cthulhu.engr.sgi.com
Subject: weird HAL2
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi,

I've looked at the HAL2 driver, and everything is looking strange hardware-
wise. The driver first resets the hardware by clearing the isr register and 
setting the appropriate bits afterwards. But reading back isr indicates, that
the hardware is still in reset state. I've removed clearing of the isr, so the
driver just writes the same value as was before. This still leads to a HAL2
in reset state. Even removing the reset code completly the HAL2 acts very
strange. Doing the first indirect register access, causes as set busy bit
in isr, that's all. Any ideas ?

Thomas.

-- 
   This device has completely bogus header. Compaq scores again :-|
It's a host bridge, but it should be called ghost bridge instead ;^)
                                        [Martin `MJ' Mares on linux-kernel]
