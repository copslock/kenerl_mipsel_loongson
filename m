Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id OAA70315 for <linux-archive@neteng.engr.sgi.com>; Wed, 19 Aug 1998 14:55:37 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA98201
	for linux-list;
	Wed, 19 Aug 1998 14:54:55 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA94031
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 19 Aug 1998 14:54:54 -0700 (PDT)
	mail_from (sgi.sgi.com!rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA28157
	for <linux@cthulhu.engr.sgi.com>; Wed, 19 Aug 1998 14:54:46 -0700 (PDT)
	mail_from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m0z9GBn-0027nxC@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Wed, 19 Aug 1998 23:54:43 +0200 (MET DST)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m0z9GBf-002PBgC; Wed, 19 Aug 98 23:54 MET DST
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id XAA02624;
	Wed, 19 Aug 1998 23:34:29 +0200
Message-ID: <19980819233429.57253@alpha.franken.de>
Date: Wed, 19 Aug 1998 23:34:29 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Alex deVries <adevries@engsoc.carleton.ca>
Cc: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: Merging for 2.1.116...
References: <Pine.LNX.3.96.980818205222.15702E-100000@lager.engsoc.carleton.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85
In-Reply-To: <Pine.LNX.3.96.980818205222.15702E-100000@lager.engsoc.carleton.ca>; from Alex deVries on Tue, Aug 18, 1998 at 08:54:22PM -0400
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Tue, Aug 18, 1998 at 08:54:22PM -0400, Alex deVries wrote:
> Is someone going to take to task merging our latest kernel into 2.1.116?

I exchanged some emails with Ralf, and he said, that he has started merging
with .115. I've commited the newport abscon and g364 fbcon driver, so
he could even test the merged sources:-) But I haven't heard anything since
then from him about the merge.

> It would be really good to get everything in for 2.2.

I doubt, that we will be able to merge all the stuff. But we will see.

> I don't mind taking a stab at it, although I'm supposed to be packing for
> my move to Toronto in two weeks (finally!).

looks like moving time everywhere. I'll move most of my stuff next
weekend.

Thomas.

-- 
See, you not only have to be a good coder to create a system like Linux,
you have to be a sneaky bastard too ;-)
                   [Linus Torvalds in <4rikft$7g5@linux.cs.Helsinki.FI>]
