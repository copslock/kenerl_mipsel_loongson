Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id PAA65708 for <linux-archive@neteng.engr.sgi.com>; Wed, 10 Feb 1999 15:55:06 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA81024
	for linux-list;
	Wed, 10 Feb 1999 15:53:39 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA54370
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 10 Feb 1999 15:53:37 -0800 (PST)
	mail_from (sgi.com!rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA05026
	for <linux@cthulhu.engr.sgi.com>; Wed, 10 Feb 1999 15:53:36 -0800 (PST)
	mail_from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m10AjRj-0027UCC@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Thu, 11 Feb 1999 00:53:31 +0100 (MET)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m10AjRY-002P78C; Thu, 11 Feb 99 00:53 MET
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id AAA03663;
	Thu, 11 Feb 1999 00:25:34 +0100
Message-ID: <19990211002534.A3363@alpha.franken.de>
Date: Thu, 11 Feb 1999 00:25:34 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Alex deVries <adevries@engsoc.carleton.ca>,
        Chris Chiapusio <chipper@llamas.net>
Cc: linux@cthulhu.engr.sgi.com, Richard Hartensveld <richard@infopact.nl>
Subject: Re: Challange S question..
References: <Pine.LNX.4.05.9902101630540.769-100000@chipsworld.llamas.net> <Pine.LNX.3.96.990210165646.26706F-100000@lager.engsoc.carleton.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
In-Reply-To: <Pine.LNX.3.96.990210165646.26706F-100000@lager.engsoc.carleton.ca>; from Alex deVries on Wed, Feb 10, 1999 at 04:58:25PM -0500
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, Feb 10, 1999 at 04:58:25PM -0500, Alex deVries wrote:
> I really need to rebuild a kernel for installation that includes R4400
> support and serial console.  I just wish I could find a serial console
> cable somewhere.

I've already done that last week (announced on this mailing list) and that 
kernel boots fine on a Challenge S (tested on a real Challenge S, thanks to
Richard Hartensveld).

URL is:

ftp://ftp.linux.sgi.com/pub/linux/mips/test/vmlinux-indy-990205.gz

Thomas.

-- 
   This device has completely bogus header. Compaq scores again :-|
It's a host bridge, but it should be called ghost bridge instead ;^)
                                        [Martin `MJ' Mares on linux-kernel]
