Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id PAA94119 for <linux-archive@neteng.engr.sgi.com>; Tue, 9 Mar 1999 15:29:42 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA85309
	for linux-list;
	Tue, 9 Mar 1999 15:27:19 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA77188
	for <linux@engr.sgi.com>;
	Tue, 9 Mar 1999 15:27:17 -0800 (PST)
	mail_from (sgi.com!rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA00803
	for <linux@engr.sgi.com>; Tue, 9 Mar 1999 15:26:52 -0800 (PST)
	mail_from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m10KVti-0027U9C@rachael.franken.de>
	for engr.sgi.com!linux; Wed, 10 Mar 1999 00:26:50 +0100 (MET)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m10KVte-002OyPC; Wed, 10 Mar 99 00:26 MET
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id AAA07340;
	Wed, 10 Mar 1999 00:22:18 +0100
Message-ID: <19990310002217.A6143@alpha.franken.de>
Date: Wed, 10 Mar 1999 00:22:17 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Jake Griesbach <griesbac@gamera.colorado.edu>
Cc: linux@cthulhu.engr.sgi.com, ralf@uni-koblenz.de
Subject: Re: Linux/Mips installation
References: <19990309231121.A3408@alpha.franken.de> <Pine.LNX.3.96.990309152601.7439A-100000@gamera.colorado.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
In-Reply-To: <Pine.LNX.3.96.990309152601.7439A-100000@gamera.colorado.edu>; from Jake Griesbach on Tue, Mar 09, 1999 at 03:43:23PM -0700
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Tue, Mar 09, 1999 at 03:43:23PM -0700, Jake Griesbach wrote:
> On Tue, 9 Mar 1999, Thomas Bogendoerfer wrote:
> > please mail me the oops, so I could look up, where is happens.
> 
> Here it is:

thanks. The oops is caused by something going wrong in the SCSI driver.

I saw in your hinv, that there are different devices on your scsi bus.
Could you please try to remove as much as possible from the bus and
try it again ? What devices do have on the bus ?

Thomas.

-- 
   This device has completely bogus header. Compaq scores again :-|
It's a host bridge, but it should be called ghost bridge instead ;^)
                                        [Martin `MJ' Mares on linux-kernel]
