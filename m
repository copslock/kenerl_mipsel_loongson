Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id MAA34873 for <linux-archive@neteng.engr.sgi.com>; Wed, 23 Sep 1998 12:53:08 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA99255
	for linux-list;
	Wed, 23 Sep 1998 12:52:28 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA54805
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 23 Sep 1998 12:52:26 -0700 (PDT)
	mail_from (sgi.sgi.com!rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id MAA08985
	for <linux@cthulhu.engr.sgi.com>; Wed, 23 Sep 1998 12:52:24 -0700 (PDT)
	mail_from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m0zLuxU-0027xMC@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Wed, 23 Sep 1998 21:52:16 +0200 (MET DST)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m0zLuxL-002OwLC; Wed, 23 Sep 98 21:52 MET DST
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id VAA02085;
	Wed, 23 Sep 1998 21:22:41 +0200
Message-ID: <19980923212241.01963@alpha.franken.de>
Date: Wed, 23 Sep 1998 21:22:41 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Alex deVries <adevries@engsoc.carleton.ca>
Cc: Richard Hartensveld <richardh@infopact.nl>, Rob Lembree <lembree@sgi.com>,
        linux@cthulhu.engr.sgi.com
Subject: Re: challenge s boots linux
References: <36081982.8D3B6975@infopact.nl> <Pine.LNX.3.96.980922201845.10292B-100000@lager.engsoc.carleton.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85
In-Reply-To: <Pine.LNX.3.96.980922201845.10292B-100000@lager.engsoc.carleton.ca>; from Alex deVries on Tue, Sep 22, 1998 at 08:24:20PM -0400
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Tue, Sep 22, 1998 at 08:24:20PM -0400, Alex deVries wrote:
> 	First, I wonder how much of the kernel will actually work on the
> Challenge S; I'm told there are SCSI controller differences.

looking linus.linux.sgi.com, which is AFAIK a Challenge S, it seems the
Challenge has a wd33c93 and a wd33c95. The wd33c93 is what we already support.
As long as the harddisk are attached to it, it should work. The wd33c95
is a rather strange chip, and from the datasheet I have here, it looks like
a lot of work to write a driver for it, because besides the kernel code,
you have to write sequence code for the chip, too.

> 	The install kernel you're using (and oh god, is it ever a bad one)
> is broken in that serial console won't work.  Yes, I should have looked
> into it way back when.

When I did the new console code, I first made the serial console working.
As far as I remember I had to do some ugly hacks, but I'll try to clean
it up and check it in.

Thomas.

-- 
See, you not only have to be a good coder to create a system like Linux,
you have to be a sneaky bastard too ;-)
                   [Linus Torvalds in <4rikft$7g5@linux.cs.Helsinki.FI>]
