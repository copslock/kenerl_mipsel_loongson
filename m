Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id CAA82096 for <linux-archive@neteng.engr.sgi.com>; Thu, 24 Sep 1998 02:33:32 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id CAA02325
	for linux-list;
	Thu, 24 Sep 1998 02:32:47 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id CAA36512
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 24 Sep 1998 02:32:41 -0700 (PDT)
	mail_from (sgi.sgi.com!rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id CAA02708
	for <linux@cthulhu.engr.sgi.com>; Thu, 24 Sep 1998 02:32:39 -0700 (PDT)
	mail_from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m0zM7lK-0027tCC@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Thu, 24 Sep 1998 11:32:34 +0200 (MET DST)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m0zM7lF-002OmEC; Thu, 24 Sep 98 11:32 MET DST
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id LAA00958;
	Thu, 24 Sep 1998 11:29:24 +0200
Message-ID: <19980924112924.00665@alpha.franken.de>
Date: Thu, 24 Sep 1998 11:29:24 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: ralf@uni-koblenz.de
Cc: Alex deVries <adevries@engsoc.carleton.ca>,
        Richard Hartensveld <richardh@infopact.nl>,
        Rob Lembree <lembree@sgi.com>, linux@cthulhu.engr.sgi.com
Subject: Re: challenge s boots linux
References: <36081982.8D3B6975@infopact.nl> <Pine.LNX.3.96.980922201845.10292B-100000@lager.engsoc.carleton.ca> <19980923212241.01963@alpha.franken.de> <19980924015938.K2843@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85
In-Reply-To: <19980924015938.K2843@uni-koblenz.de>; from ralf@uni-koblenz.de on Thu, Sep 24, 1998 at 01:59:38AM +0200
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Thu, Sep 24, 1998 at 01:59:38AM +0200, ralf@uni-koblenz.de wrote:
> > As long as the harddisk are attached to it, it should work. The wd33c95
> > is a rather strange chip, and from the datasheet I have here, it looks like
> > a lot of work to write a driver for it, because besides the kernel code,
> > you have to write sequence code for the chip, too.
> 
> Did I missunderstand the 95's documentation - I thought we can abuse the
> 95 as a 93, thereby saving alot of driver work for now?

The documentation isn't really clear about that, but I believe you need
sequencer code to make the 95 acting like a 93. And I couldn't find such
a thing, yet.

Thomas.

-- 
See, you not only have to be a good coder to create a system like Linux,
you have to be a sneaky bastard too ;-)
                   [Linus Torvalds in <4rikft$7g5@linux.cs.Helsinki.FI>]
