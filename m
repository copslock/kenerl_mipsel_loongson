Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id NAA85302 for <linux-archive@neteng.engr.sgi.com>; Tue, 9 Mar 1999 13:00:36 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA00337
	for linux-list;
	Tue, 9 Mar 1999 12:57:23 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from deliverator.sgi.com (deliverator.sgi.com [150.166.91.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA93994
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 9 Mar 1999 12:57:19 -0800 (PST)
	mail_from (deliverator.sgi.com!rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id MAA28609
	for <linux@cthulhu.engr.sgi.com>; Tue, 9 Mar 1999 12:57:00 -0800 (PST)
	mail_from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m10KTYh-0027U9C@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Tue, 9 Mar 1999 21:56:59 +0100 (MET)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m10KTYb-002OpzC; Tue, 9 Mar 99 21:56 MET
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id VAA02219;
	Tue, 9 Mar 1999 21:47:15 +0100
Message-ID: <19990309214715.B2209@alpha.franken.de>
Date: Tue, 9 Mar 1999 21:47:15 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Jake Griesbach <griesbac@gamera.colorado.edu>, linux@cthulhu.engr.sgi.com
Subject: Re: Linux/Mips installation
References: <Pine.LNX.3.96.990308095619.29222A-100000@gamera.colorado.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
In-Reply-To: <Pine.LNX.3.96.990308095619.29222A-100000@gamera.colorado.edu>; from Jake Griesbach on Mon, Mar 08, 1999 at 09:57:29AM -0700
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Mon, Mar 08, 1999 at 09:57:29AM -0700, Jake Griesbach wrote:
> Do you have any ideas as to what may be wrong?  I'm using the
> hardhat-sgi-5.1.tar.gz file from
> ftp://ftp.linux.sgi.com:/pub/linux/mips/RedHat.

Please try a newer kernel. Take the one from

ftp://ftp.linux.sgi.com/pub/linux/mips/test/vmlinux-indy-2.2.1-990226.tar.gz

If you have problems with this kernel, please send the output of
hinv (IRIX command).

Thomas.

-- 
   This device has completely bogus header. Compaq scores again :-|
It's a host bridge, but it should be called ghost bridge instead ;^)
                                        [Martin `MJ' Mares on linux-kernel]
