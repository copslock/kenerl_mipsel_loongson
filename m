Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id NAA47290 for <linux-archive@neteng.engr.sgi.com>; Thu, 8 Apr 1999 13:41:47 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id NAA16111
	for linux-list;
	Thu, 8 Apr 1999 13:39:16 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id NAA04157
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 8 Apr 1999 13:39:14 -0700 (PDT)
	mail_from (sgi.com!rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id NAA07214
	for <linux@cthulhu.engr.sgi.com>; Thu, 8 Apr 1999 13:39:13 -0700 (PDT)
	mail_from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m10VLjS-0027SnC@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Thu, 8 Apr 1999 22:49:02 +0200 (MET DST)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m10VLZt-002PjbC; Thu, 8 Apr 99 22:39 MET DST
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id WAA02494
	for linux@cthulhu.engr.sgi.com; Thu, 8 Apr 1999 22:34:36 +0200
Message-ID: <19990408223436.A2491@alpha.franken.de>
Date: Thu, 8 Apr 1999 22:34:36 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: linux@cthulhu.engr.sgi.com
Subject: Indy ISDN questions
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Ok, after Ulf got the sound working the remaining not supported hardware 
is VINO and ISDN. Since I'm involved in ISDN programing at work and I already
worked with the Linux ISDN code, I hacked together the necessary code to
access ISAC and HSCX. The detection looks pretty good now, but I don't
get interrupts from any of the two chips.

The IRIX header files only talk about ISDN on the IP24, but not on the IP22.
But I've found both of the Siemens chip on the Indy board (Fullhouse == IP22).
So what's up with ISDN on the Indy ? How do I get the interrupts ?

Thomas.

-- 
   This device has completely bogus header. Compaq scores again :-|
It's a host bridge, but it should be called ghost bridge instead ;^)
                                        [Martin `MJ' Mares on linux-kernel]
