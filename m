Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id PAA03480 for <linux-archive@neteng.engr.sgi.com>; Sat, 13 Feb 1999 15:21:26 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA74876
	for linux-list;
	Sat, 13 Feb 1999 15:20:44 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA47502
	for <linux@cthulhu.engr.sgi.com>;
	Sat, 13 Feb 1999 15:20:42 -0800 (PST)
	mail_from (sgi.com!rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA03227
	for <linux@cthulhu.engr.sgi.com>; Sat, 13 Feb 1999 15:20:40 -0800 (PST)
	mail_from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m10BoMV-0027SkC@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Sun, 14 Feb 1999 00:20:35 +0100 (MET)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m10BoMJ-002PJbC; Sun, 14 Feb 99 00:20 MET
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id AAA02772;
	Sun, 14 Feb 1999 00:09:14 +0100
Message-ID: <19990214000913.A2212@alpha.franken.de>
Date: Sun, 14 Feb 1999 00:09:13 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Mike Hill <mikehill@hgeng.com>, linux@cthulhu.engr.sgi.com
Subject: Re: Kernel Compile
References: <ED3F21AD1879D21191A900A02435011C040FC2@BART>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
In-Reply-To: <ED3F21AD1879D21191A900A02435011C040FC2@BART>; from Mike Hill on Fri, Feb 12, 1999 at 12:07:07PM -0500
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Fri, Feb 12, 1999 at 12:07:07PM -0500, Mike Hill wrote:
> What does the .config file look like these days for a successful compile?
> Alex?  Thomas?

I've uploaded the .config, I've used for the vmlinux-indy-990212.gz. URL is:

ftp://ftp.linux.sgi.com/pub/linux/mips/test/vmlinux-indy-990212.config

> Which version of egcs is recommended?  Mine's still the one from hardhat
> 5.1.

I'm still using a gcc-2.7.2.3 cross compiler.

Thomas.

-- 
   This device has completely bogus header. Compaq scores again :-|
It's a host bridge, but it should be called ghost bridge instead ;^)
                                        [Martin `MJ' Mares on linux-kernel]
