Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id NAA66589 for <linux-archive@neteng.engr.sgi.com>; Tue, 9 Feb 1999 13:40:29 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id NAA97534
	for linux-list;
	Tue, 9 Feb 1999 13:38:51 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id NAA97405
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 9 Feb 1999 13:38:49 -0800 (PST)
	mail_from (sgi.com!rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id NAA09048
	for <linux@cthulhu.engr.sgi.com>; Tue, 9 Feb 1999 13:38:31 -0800 (PST)
	mail_from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m10AKrU-0027UFC@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Tue, 9 Feb 1999 22:38:28 +0100 (MET)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m10AKrL-002OjdC; Tue, 9 Feb 99 22:38 MET
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id WAA01552;
	Tue, 9 Feb 1999 22:33:41 +0100
Message-ID: <19990209223341.C1509@alpha.franken.de>
Date: Tue, 9 Feb 1999 22:33:41 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Alex deVries <adevries@engsoc.carleton.ca>,
        SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: newport stuff.
References: <Pine.LNX.3.96.990208190624.11444G-100000@lager.engsoc.carleton.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
In-Reply-To: <Pine.LNX.3.96.990208190624.11444G-100000@lager.engsoc.carleton.ca>; from Alex deVries on Mon, Feb 08, 1999 at 07:53:26PM -0500
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Mon, Feb 08, 1999 at 07:53:26PM -0500, Alex deVries wrote:
> Are there objctions to me stripping out functionality from the very
> excellent newport_cons.c and putting it into newport.c so I can use it
> from graphics. as well?

If you find something, which is worth sharing do it. But I have to agree
with Miguel, there isn't much usefull stuff for /dev/graphic in newport_con.c.

Thomas.

-- 
   This device has completely bogus header. Compaq scores again :-|
It's a host bridge, but it should be called ghost bridge instead ;^)
                                        [Martin `MJ' Mares on linux-kernel]
