Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id GAA72968 for <linux-archive@neteng.engr.sgi.com>; Sun, 11 Apr 1999 06:19:37 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id GAA26709
	for linux-list;
	Sun, 11 Apr 1999 06:15:37 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id GAA86491
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 11 Apr 1999 06:15:35 -0700 (PDT)
	mail_from (sgi.com!rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id GAA01645
	for <linux@cthulhu.engr.sgi.com>; Sun, 11 Apr 1999 06:15:34 -0700 (PDT)
	mail_from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m10WKFy-0027TsC@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Sun, 11 Apr 1999 15:26:38 +0200 (MET DST)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m10WK5B-002OiNC; Sun, 11 Apr 99 15:15 MET DST
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id OAA01042
	for linux@cthulhu.engr.sgi.com; Sun, 11 Apr 1999 14:39:03 +0200
Message-ID: <19990411143903.A1039@alpha.franken.de>
Date: Sun, 11 Apr 1999 14:39:03 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Linux SGI <linux@cthulhu.engr.sgi.com>
Subject: Re: SGI Console
References: <19990411123035.A7346@bun.falkenberg.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
In-Reply-To: <19990411123035.A7346@bun.falkenberg.se>; from Ulf Carlsson on Sun, Apr 11, 1999 at 12:30:35PM +0200
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Sun, Apr 11, 1999 at 12:30:35PM +0200, Ulf Carlsson wrote:
> What I wonder is: What should happen when you don't select "y" here? As it is
> now nothing takes over the console, it justs remain in the state the prom left
> it.

there is also the chance someone has only a serial console (Challenge S).

> Is this what we want, or do we want to use some other console when we don't
> use newport console?

If someone doesn't configure newport nor serial console, it's his fault.
So just leave it as it is, not need for anything automatic.

Thomas.

-- 
   This device has completely bogus header. Compaq scores again :-|
It's a host bridge, but it should be called ghost bridge instead ;^)
                                        [Martin `MJ' Mares on linux-kernel]
