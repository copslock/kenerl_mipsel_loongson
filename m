Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id CAA25001 for <linux-archive@neteng.engr.sgi.com>; Sat, 17 Oct 1998 02:35:23 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id CAA28078
	for linux-list;
	Sat, 17 Oct 1998 02:34:37 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id CAA78301
	for <linux@cthulhu.engr.sgi.com>;
	Sat, 17 Oct 1998 02:34:33 -0700 (PDT)
	mail_from (sgi.sgi.com!rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id CAA00539
	for <linux@cthulhu.engr.sgi.com>; Sat, 17 Oct 1998 02:34:32 -0700 (PDT)
	mail_from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m0zUSkl-0027pSC@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Sat, 17 Oct 1998 10:34:27 +0100 (MET)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m0zUSkb-002OvDC; Sat, 17 Oct 98 11:34 MET DST
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id LAA01182;
	Sat, 17 Oct 1998 11:16:45 +0200
Message-ID: <19981017111645.C1121@alpha.franken.de>
Date: Sat, 17 Oct 1998 11:16:45 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Jeff Coffin <jcoffin@sv.usweb.com>, linux@cthulhu.engr.sgi.com
Subject: Re: Partial Success Report
References: <m3ww618s88.fsf@lil.sv.usweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
In-Reply-To: <m3ww618s88.fsf@lil.sv.usweb.com>; from Jeff Coffin on Thu, Oct 15, 1998 at 01:50:31PM -0700
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Thu, Oct 15, 1998 at 01:50:31PM -0700, Jeff Coffin wrote:
> Last night I got the HardHat kernel to boot via the bootp method
> described in the Howto and, as expected from the experiences of
> Richard Hartensveld, it hung looking for a console.

Could you please lookup major and minor number of /dev/console on
your root filesystem ? It should be major 5 and minor 2 to work
properly with the serial console.

>  I then grabbed
> newer kernels (2.1.116 and 2.1.121) from the /pub/test on the ftp
> server and attmepted to get them loaded by the same mechanism, but
> both of them hang after loading via tftp.

please try to boot these kernels with bootp()/vmlinux console=ttyS0 (also
try ttyS1) and a terminal hooked up to one of the serial ports (in .116
ttyS0 is port 2 and ttyS1 is port 1; I've changed that in .121, but I'm not
sure if this fix is already in the precompiled kernel). It's possible, 
that I've messed up the card detection so, that it panics, when there is 
no newport installed.

Thomas.

-- 
   This device has completely bogus header. Compaq scores again :-|
It's a host bridge, but it should be called ghost bridge instead ;^)
                                        [Martin `MJ' Mares on linux-kernel]
