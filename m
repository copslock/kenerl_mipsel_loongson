Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id PAA12136 for <linux-archive@neteng.engr.sgi.com>; Mon, 22 Mar 1999 15:16:19 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA03296
	for linux-list;
	Mon, 22 Mar 1999 15:15:31 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA02053
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 22 Mar 1999 15:15:30 -0800 (PST)
	mail_from (sgi.com!rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id SAA06939
	for <linux@cthulhu.engr.sgi.com>; Mon, 22 Mar 1999 18:15:21 -0500 (EST)
	mail_from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m10PDwX-0027T9C@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Tue, 23 Mar 1999 00:17:13 +0100 (MET)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m10PDuW-002P4CC; Tue, 23 Mar 99 00:15 MET
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id AAA03494
	for linux@cthulhu.engr.sgi.com; Tue, 23 Mar 1999 00:10:52 +0100
Message-ID: <19990323001051.B2701@alpha.franken.de>
Date: Tue, 23 Mar 1999 00:10:51 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Linux SGI <linux@cthulhu.engr.sgi.com>
Subject: Re: GDB
References: <19990322164706.A27372@bun.falkenberg.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
In-Reply-To: <19990322164706.A27372@bun.falkenberg.se>; from Ulf Carlsson on Mon, Mar 22, 1999 at 04:47:06PM -0500
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Mon, Mar 22, 1999 at 04:47:06PM -0500, Ulf Carlsson wrote:
> I'm having some problems with gdb for mips. I can't examine core files 
> since gdb itself dumps core files when I try start gdb (gdb nsgsml core).
> Are there other ways to check where a program crashes (except for printf()s)?
> It isn't possible to run nsgsml in gdb either, or at least it doesn't 
> provide the information I want.

hmm, if memory serves right, I had reading core working at some point.
But I just tried it again and it fails like you described. I debugged
gdb some time ago and it's was a real nightmare. IMHO fixing gdb isn't
a short term task and I'm right now trying to plug all SCSI holes
(two bugs smashed, but still too much known bugs unfixed). And after 
the SCSI stuff I'll port the RedHat Rawhide installer, so I'm not 
available to fix gdb for some time.

For a short term solution edit arch/mips/mm/fault.c and look for the
second #if 0 (after the label bad_area) and change that to a #if 1.
This will give you a kernel message for every segfault, but it won't
help you for bus errors (but it's also possible to add printks there, too).

Thomas.

-- 
   This device has completely bogus header. Compaq scores again :-|
It's a host bridge, but it should be called ghost bridge instead ;^)
                                        [Martin `MJ' Mares on linux-kernel]
