Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id DAA26628 for <linux-archive@neteng.engr.sgi.com>; Sat, 27 Feb 1999 03:20:04 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id DAA91081
	for linux-list;
	Sat, 27 Feb 1999 03:19:17 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id DAA23180
	for <linux@cthulhu.engr.sgi.com>;
	Sat, 27 Feb 1999 03:19:16 -0800 (PST)
	mail_from (sgi.com!rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id DAA06975
	for <linux@cthulhu.engr.sgi.com>; Sat, 27 Feb 1999 03:19:15 -0800 (PST)
	mail_from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m10Ghm5-0027TFC@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Sat, 27 Feb 1999 12:19:13 +0100 (MET)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m10Ghly-002OmfC; Sat, 27 Feb 99 12:19 MET
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id MAA00697;
	Sat, 27 Feb 1999 12:01:45 +0100
Message-ID: <19990227120144.A601@alpha.franken.de>
Date: Sat, 27 Feb 1999 12:01:44 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: gkm@total.net, linux@cthulhu.engr.sgi.com
Subject: Re: 2.2.1 MIPS kernel sources plus Indy kernel binaries uploaded
References: <19990227001617.A4022@alpha.franken.de> <199902270430.XAA21725@wacky.total.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
In-Reply-To: <199902270430.XAA21725@wacky.total.net>; from gkm@total.net on Fri, Feb 26, 1999 at 11:30:50PM -0500
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Fri, Feb 26, 1999 at 11:30:50PM -0500, gkm@total.net wrote:
> How has everyone else faired in the compiling game?  :)

it worked out of the box, but not on an out of the box HardHat:-(

HardHat has still gcc-2.7.2 as the default C compiler and this
compiler has different defines. So either use egcs or update your
gcc specs file (sorry, I couldn't find the patch right now, anyone ?)

Thomas.

-- 
   This device has completely bogus header. Compaq scores again :-|
It's a host bridge, but it should be called ghost bridge instead ;^)
                                        [Martin `MJ' Mares on linux-kernel]
