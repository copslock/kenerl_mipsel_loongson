Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id QAA59958 for <linux-archive@neteng.engr.sgi.com>; Sat, 8 May 1999 16:01:43 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA41121
	for linux-list;
	Sat, 8 May 1999 16:00:09 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA49475
	for <linux@cthulhu.engr.sgi.com>;
	Sat, 8 May 1999 16:00:07 -0700 (PDT)
	mail_from (sgi.com!rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id TAA08639
	for <linux@cthulhu.engr.sgi.com>; Sat, 8 May 1999 19:00:05 -0400 (EDT)
	mail_from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m10gFdu-0027VWC@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Sun, 9 May 1999 00:32:22 +0200 (MET DST)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m10gG4b-002OyCC; Sun, 9 May 99 00:59 MET DST
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id XAA01674
	for linux@cthulhu.engr.sgi.com; Sat, 8 May 1999 23:30:58 +0200
Message-ID: <19990508233058.D1601@alpha.franken.de>
Date: Sat, 8 May 1999 23:30:58 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: SGI/Linux mailing list <linux@cthulhu.engr.sgi.com>
Subject: Re: parallel Port
References: <19990508165019.A6441@us08-568b-1.res.umassd.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
In-Reply-To: <19990508165019.A6441@us08-568b-1.res.umassd.edu>; from Matthias Kleinschmidt on Sat, May 08, 1999 at 04:50:20PM -0400
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Sat, May 08, 1999 at 04:50:20PM -0400, Matthias Kleinschmidt wrote:
> is there any progress with the parallel port driver?

sorry, I tried to get out the necessary bits from Irix header files and
the small documentation about the parallel port. I couldn't find out
whether it's possible to use the parallel port in PIO mode.

> If not maybe I could try.
> I never wrote a driver before but if it is really as simple as Thomas said
> it might be a good project to start with. 

If you could run the parallel port in PIO mode, it's pretty straight
forward. But if this isn't possible, you need to do DMA, which is much
more work.

Thomas.

-- 
   This device has completely bogus header. Compaq scores again :-|
It's a host bridge, but it should be called ghost bridge instead ;^)
                                        [Martin `MJ' Mares on linux-kernel]
