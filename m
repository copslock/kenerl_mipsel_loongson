Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id NAA62972 for <linux-archive@neteng.engr.sgi.com>; Thu, 18 Mar 1999 13:40:54 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id NAA00562
	for linux-list;
	Thu, 18 Mar 1999 13:39:18 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id NAA27744
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 18 Mar 1999 13:39:16 -0800 (PST)
	mail_from (sgi.com!rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id NAA03245
	for <linux@cthulhu.engr.sgi.com>; Thu, 18 Mar 1999 13:39:13 -0800 (PST)
	mail_from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m10NkVS-0027U1C@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Thu, 18 Mar 1999 22:39:10 +0100 (MET)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m10NkVI-002OydC; Thu, 18 Mar 99 22:39 MET
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id WAA02218;
	Thu, 18 Mar 1999 22:35:25 +0100
Message-ID: <19990318223524.B2195@alpha.franken.de>
Date: Thu, 18 Mar 1999 22:35:24 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: mdhill@genxl.com, linux@cthulhu.engr.sgi.com
Subject: Re: newport console problems, some hardware questions
References: <19990315220341.C2301@alpha.franken.de> <tsbogend@alpha.franken.de> <9903180745.ZM1473@mdhill.genxl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
In-Reply-To: <9903180745.ZM1473@mdhill.genxl.com>; from Michael Hill on Thu, Mar 18, 1999 at 07:45:43AM -0500
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Thu, Mar 18, 1999 at 07:45:43AM -0500, Michael Hill wrote:
> > faster scrolling only with 1024 scanline screen modes. This slows
> > down scrolling, and I hope there is a better solution (but I doubt it).
> 
> This works well, Thomas.  Now I can see what's happening on the screen.  I
> haven't run into any problems with the scrolling speed yet (I don't notice a
> difference just by watching it).

it isn't that bad, when the lines are only partially filled or whenever
columns contain the same content. But there is a fix insight. I just
have to figure out, how to completly clear the scrolled in scanlines.

Thomas.

-- 
   This device has completely bogus header. Compaq scores again :-|
It's a host bridge, but it should be called ghost bridge instead ;^)
                                        [Martin `MJ' Mares on linux-kernel]
