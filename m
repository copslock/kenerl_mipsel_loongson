Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id PAA14426 for <linux-archive@neteng.engr.sgi.com>; Thu, 20 Aug 1998 15:27:23 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA42115
	for linux-list;
	Thu, 20 Aug 1998 15:26:49 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA66146
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 20 Aug 1998 15:26:43 -0700 (PDT)
	mail_from (sgi.sgi.com!rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA03703
	for <linux@cthulhu.engr.sgi.com>; Thu, 20 Aug 1998 15:27:48 -0700 (PDT)
	mail_from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m0z9dBE-0027pSC@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Fri, 21 Aug 1998 00:27:40 +0200 (MET DST)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m0z9dB7-002OkdC; Fri, 21 Aug 98 00:27 MET DST
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id AAA02733;
	Fri, 21 Aug 1998 00:21:11 +0200
Message-ID: <19980821002111.03847@alpha.franken.de>
Date: Fri, 21 Aug 1998 00:21:11 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: linux-mips@fnet.fr
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: Debugging emacs
References: <19980819235142.36595@alpha.franken.de> <19980820000237.A11980@loria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85
In-Reply-To: <19980820000237.A11980@loria.fr>; from Olivier Galibert on Thu, Aug 20, 1998 at 12:02:37AM +0200
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Thu, Aug 20, 1998 at 12:02:37AM +0200, Olivier Galibert wrote:
> You're doomed.  At least on XEmacs this hasn't worked for a while, and
> I guess FSF Emacs isn't in any better shape  in that area.  Fixing the
> undumping code  may  be easier.

Thanks for the tip. It was fairly easy to fix the undumping code, because
everything was already there. It was just ifdef'd out for Linux. Now
I have a dumped emacs with working debugging information and a lot
to learn about XtCreateWidget().

Thomas.

-- 
See, you not only have to be a good coder to create a system like Linux,
you have to be a sneaky bastard too ;-)
                   [Linus Torvalds in <4rikft$7g5@linux.cs.Helsinki.FI>]
