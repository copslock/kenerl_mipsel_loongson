Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id PAA92820 for <linux-archive@neteng.engr.sgi.com>; Tue, 9 Mar 1999 15:08:42 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA83826
	for linux-list;
	Tue, 9 Mar 1999 15:07:08 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA95449
	for <linux@engr.sgi.com>;
	Tue, 9 Mar 1999 15:07:06 -0800 (PST)
	mail_from (sgi.com!rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA04327
	for <linux@engr.sgi.com>; Tue, 9 Mar 1999 15:06:33 -0800 (PST)
	mail_from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m10KUsj-0027U9C@rachael.franken.de>
	for engr.sgi.com!linux; Tue, 9 Mar 1999 23:21:45 +0100 (MET)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m10KUse-002OyOC; Tue, 9 Mar 99 23:21 MET
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id XAA03411;
	Tue, 9 Mar 1999 23:11:22 +0100
Message-ID: <19990309231121.A3408@alpha.franken.de>
Date: Tue, 9 Mar 1999 23:11:21 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Jake Griesbach <griesbac@gamera.colorado.edu>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: Linux/Mips installation
References: <19990309214715.B2209@alpha.franken.de> <Pine.LNX.3.96.990309142512.5281A-100000@gamera.colorado.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
In-Reply-To: <Pine.LNX.3.96.990309142512.5281A-100000@gamera.colorado.edu>; from Jake Griesbach on Tue, Mar 09, 1999 at 02:34:09PM -0700
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Tue, Mar 09, 1999 at 02:34:09PM -0700, Jake Griesbach wrote:
> Hmm.  That still didn't work, although the new kernel booted just fine.  I
> still got an Oops message right after I selected the drive to install to.

please mail me the oops, so I could look up, where is happens.

> Could this be a swapon problem?  I also have an internal floppy/floptical

maybe. Did you try to create swap ? AFAIK this doesn't work with HardHat.

> drive (this also appears on the select drive list).  Could this be
> throwing things off?  Does this work for R4600 processors?

it works perfect here.

Thomas.

-- 
   This device has completely bogus header. Compaq scores again :-|
It's a host bridge, but it should be called ghost bridge instead ;^)
                                        [Martin `MJ' Mares on linux-kernel]
