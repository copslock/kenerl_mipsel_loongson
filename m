Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id MAA50280 for <linux-archive@neteng.engr.sgi.com>; Fri, 6 Nov 1998 12:44:25 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA07542
	for linux-list;
	Fri, 6 Nov 1998 12:43:54 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA85265
	for <linux@engr.sgi.com>;
	Fri, 6 Nov 1998 12:43:51 -0800 (PST)
	mail_from (sgi.sgi.com!rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id MAA07312
	for <linux@engr.sgi.com>; Fri, 6 Nov 1998 12:43:46 -0800 (PST)
	mail_from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m0zbsjJ-0027wqC@rachael.franken.de>
	for engr.sgi.com!linux; Fri, 6 Nov 1998 21:43:37 +0100 (MET)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m0zbsj8-002PGvC; Fri, 6 Nov 98 21:43 MET
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id VAA02276;
	Fri, 6 Nov 1998 21:24:24 +0100
Message-ID: <19981106212424.A2271@alpha.franken.de>
Date: Fri, 6 Nov 1998 21:24:24 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: linux-mips@fnet.fr, linux@cthulhu.engr.sgi.com
Subject: Re: GDB
References: <19981105023015.K359@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
In-Reply-To: <19981105023015.K359@uni-koblenz.de>; from ralf@uni-koblenz.de on Thu, Nov 05, 1998 at 02:30:15AM +0100
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Thu, Nov 05, 1998 at 02:30:15AM +0100, ralf@uni-koblenz.de wrote:
> I found that by accident GDB and the kernel were using different
> ptrace(2) interfaces.  After fixing that for example ``info registers''
> works ok.

how about sharing your fix with us ? 

Thomas.

-- 
   This device has completely bogus header. Compaq scores again :-|
It's a host bridge, but it should be called ghost bridge instead ;^)
                                        [Martin `MJ' Mares on linux-kernel]
