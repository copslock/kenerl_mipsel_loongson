Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id LAA94623 for <linux-archive@neteng.engr.sgi.com>; Fri, 25 Jun 1999 11:48:34 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA85805
	for linux-list;
	Fri, 25 Jun 1999 11:47:07 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA63576
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 25 Jun 1999 11:47:05 -0700 (PDT)
	mail_from (sgi.com!rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id LAA00553
	for <linux@cthulhu.engr.sgi.com>; Fri, 25 Jun 1999 11:47:03 -0700 (PDT)
	mail_from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m10xb08-0027X8C@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Fri, 25 Jun 1999 20:47:00 +0200 (MET DST)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m10xb03-002OrMC; Fri, 25 Jun 99 20:46 MET DST
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id UAA02016;
	Fri, 25 Jun 1999 20:08:38 +0200
Message-ID: <19990625200837.A2013@alpha.franken.de>
Date: Fri, 25 Jun 1999 20:08:37 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Ralf Baechle <ralf@uni-koblenz.de>, linux@cthulhu.engr.sgi.com
Subject: Re: File corruption
References: <19990622032859.B6955@thepuffingroup.com> <19990622152145.A1059@uni-koblenz.de> <19990623014923.A8953@thepuffingroup.com> <19990625002853.D17220@uni-koblenz.de> <19990625153108.A8684@thepuffingroup.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
In-Reply-To: <19990625153108.A8684@thepuffingroup.com>; from Ulf Carlsson on Fri, Jun 25, 1999 at 03:31:08PM +0200
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Fri, Jun 25, 1999 at 03:31:08PM +0200, Ulf Carlsson wrote:
> Probably.  I have a new problem with the 2.3.8 kernel now as well:  Page->owner
[...]
> I get some error messages before the oops as well:
> 
> attempt to access beyond end of device
> 08:01: rw=0, want=122156967, limit=929559
> attempt to access beyond end of device
> 08:01: rw=0, want=886680107, limit=929559

this seems to be a normal 2.3 error. At least I get this impression, when
reading the linux-kernel mailinglist.

Thomas.

-- 
   This device has completely bogus header. Compaq scores again :-|
It's a host bridge, but it should be called ghost bridge instead ;^)
                                        [Martin `MJ' Mares on linux-kernel]
