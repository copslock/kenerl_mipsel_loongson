Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id PAA80070 for <linux-archive@neteng.engr.sgi.com>; Wed, 15 Jul 1998 15:01:51 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA54747
	for linux-list;
	Wed, 15 Jul 1998 15:01:23 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA53289
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 15 Jul 1998 15:01:21 -0700 (PDT)
	mail_from (sgi.sgi.com!rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA28585
	for <linux@cthulhu.engr.sgi.com>; Wed, 15 Jul 1998 15:01:19 -0700 (PDT)
	mail_from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m0ywZbv-0027nxC@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Thu, 16 Jul 1998 00:01:15 +0200 (MET DST)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m0ywZbk-002P64C; Thu, 16 Jul 98 00:01 MET DST
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id XAA02457;
	Wed, 15 Jul 1998 23:42:36 +0200
Message-ID: <19980715234236.27992@alpha.franken.de>
Date: Wed, 15 Jul 1998 23:42:36 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Alex deVries <adevries@engsoc.carleton.ca>
Cc: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: The pre-release of Hard Hat Linux for SGI...
References: <Pine.LNX.3.95.980714192038.7212G-100000@lager.engsoc.carleton.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85
In-Reply-To: <Pine.LNX.3.95.980714192038.7212G-100000@lager.engsoc.carleton.ca>; from Alex deVries on Tue, Jul 14, 1998 at 07:38:32PM -0400
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Tue, Jul 14, 1998 at 07:38:32PM -0400, Alex deVries wrote:
> - many more packages; things like glibc, egcs, gcc, XFree libs, kernel
> sources, too many to mention here. 

how did you built egcs ? I just tried it on the Indy and ld dies, when 
building shared libstdc++ (same as on my Olli). Which binutils are you
using ?

Thomas.

PS: Could you please include mipsel also when modifying .spec Files. Most of
the time you need the same fixes for mipseb and mipsel.

Thomas.

-- 
See, you not only have to be a good coder to create a system like Linux,
you have to be a sneaky bastard too ;-)
                   [Linus Torvalds in <4rikft$7g5@linux.cs.Helsinki.FI>]
