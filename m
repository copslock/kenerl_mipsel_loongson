Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id CAA56014 for <linux-archive@neteng.engr.sgi.com>; Sun, 2 Aug 1998 02:36:30 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id CAA87963
	for linux-list;
	Sun, 2 Aug 1998 02:35:50 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id CAA44108
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 2 Aug 1998 02:35:48 -0700 (PDT)
	mail_from (sgi.sgi.com!rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id CAA07683
	for <linux@cthulhu.engr.sgi.com>; Sun, 2 Aug 1998 02:35:47 -0700 (PDT)
	mail_from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m0z2uYI-0027qYC@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Sun, 2 Aug 1998 11:35:42 +0200 (MET DST)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m0z2uY8-002OtZC; Sun, 2 Aug 98 11:35 MET DST
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id LAA00790;
	Sun, 2 Aug 1998 11:27:12 +0200
Message-ID: <19980802112712.38261@alpha.franken.de>
Date: Sun, 2 Aug 1998 11:27:12 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Alex deVries <adevries@engsoc.carleton.ca>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: FYI newport abscon
References: <19980802022907.05519@alpha.franken.de> <Pine.LNX.3.95.980802003721.4859A-100000@lager.engsoc.carleton.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85
In-Reply-To: <Pine.LNX.3.95.980802003721.4859A-100000@lager.engsoc.carleton.ca>; from Alex deVries on Sun, Aug 02, 1998 at 12:39:37AM -0400
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Sun, Aug 02, 1998 at 12:39:37AM -0400, Alex deVries wrote:
> On Sun, 2 Aug 1998, Thomas Bogendoerfer wrote:
> > yesterday I managed to bring up my Indy with the new console code riped
> > out from 2.1.109. Today I've implemented new scrolling stuff for newport
> > abscon, which will give us a really fast console. 
> 
> This is very, very cool, and much needed to go on with 2.1.x kernel
> development.  

yes, and that's my primary goal. The closer we get to the current 2.1.x
kernel, the better we can merge our changes into Linus tree. And this is
the best thing to let people see, that the MIPS port is still alive.

> Well, this is very cool.  What kind of use is this?  aalib... man, that'll
> be neat.  To hell with X when you have aalib.

:-) As I only speeded up scrolling time, it won't make any difference for
aalib. But sitting in front of a fast console you get the impression, that
the machine flys:-)

Thomas.

-- 
See, you not only have to be a good coder to create a system like Linux,
you have to be a sneaky bastard too ;-)
                   [Linus Torvalds in <4rikft$7g5@linux.cs.Helsinki.FI>]
