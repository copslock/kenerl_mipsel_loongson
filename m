Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id OAA54682 for <linux-archive@neteng.engr.sgi.com>; Tue, 25 Aug 1998 14:16:26 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA71507
	for linux-list;
	Tue, 25 Aug 1998 14:15:37 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA87047
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 25 Aug 1998 14:15:30 -0700 (PDT)
	mail_from (sgi.sgi.com!rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA13669
	for <linux@cthulhu.engr.sgi.com>; Tue, 25 Aug 1998 14:15:35 -0700 (PDT)
	mail_from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m0zBQR5-0027rwC@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Tue, 25 Aug 1998 23:15:27 +0200 (MET DST)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m0zBQQv-002P2dC; Tue, 25 Aug 98 23:15 MET DST
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id WAA02630;
	Tue, 25 Aug 1998 22:56:03 +0200
Message-ID: <19980825225603.43888@alpha.franken.de>
Date: Tue, 25 Aug 1998 22:56:03 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: ralf@uni-koblenz.de
Cc: linux-mips@fnet.fr, linux@cthulhu.engr.sgi.com
Subject: Re: Emacs problem
References: <19980823223647.12724@alpha.franken.de> <19980824121930.00186@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85
In-Reply-To: <19980824121930.00186@uni-koblenz.de>; from ralf@uni-koblenz.de on Mon, Aug 24, 1998 at 12:19:30PM +0200
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Mon, Aug 24, 1998 at 12:19:30PM +0200, ralf@uni-koblenz.de wrote:
> I think you can find the related ABI documentation on www.mipsabi.org.

ok, I've found what I was looking for.

> What details exactly are you interested in?  I've got a printed copy at
> home.

On other ELF platforms .rel section reference the section for which the
relocations are for in the sh_info section header. This field is 0 for
.rel.dyn sections. The ABI document states that the relocations for
.data and .sdata sections, so I know what I wanted to know:-)

Another questione does gcc/egcs produce .sdata, .lit4 or .li8 sections
on Linux/MIPS ?

Thomas.

-- 
See, you not only have to be a good coder to create a system like Linux,
you have to be a sneaky bastard too ;-)
                   [Linus Torvalds in <4rikft$7g5@linux.cs.Helsinki.FI>]
