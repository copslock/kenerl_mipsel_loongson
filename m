Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id OAA224695 for <linux-archive@neteng.engr.sgi.com>; Fri, 23 Jan 1998 14:28:12 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id OAA12276 for linux-list; Fri, 23 Jan 1998 14:26:09 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id OAA12265 for <linux@cthulhu.engr.sgi.com>; Fri, 23 Jan 1998 14:26:07 -0800
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id OAA14904
	for <linux@cthulhu.engr.sgi.com>; Fri, 23 Jan 1998 14:26:05 -0800
	env-from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m0xvrXs-0027ngC@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Fri, 23 Jan 1998 23:25:52 +0100 (MET)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m0xvrXl-002OiMC; Fri, 23 Jan 98 23:25 MET
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id XAA02086;
	Fri, 23 Jan 1998 23:24:20 +0100
Message-ID: <19980123232420.65169@alpha.franken.de>
Date: Fri, 23 Jan 1998 23:24:20 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: ralf@uni-koblenz.de
Cc: Oliver Frommel <oliver@aec.at>, Mike Shaver <shaver@netscape.com>,
        Alex deVries <adevries@engsoc.carleton.ca>,
        SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: root-be-0.03.tar.gz
References: <34C6E304.680D7541@netscape.com> <Pine.LNX.3.96.980122130326.18071A-100000@web.aec.at> <19980123045725.54480@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85
In-Reply-To: <19980123045725.54480@uni-koblenz.de>; from ralf@uni-koblenz.de on Fri, Jan 23, 1998 at 04:57:25AM +0100
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Fri, Jan 23, 1998 at 04:57:25AM +0100, ralf@uni-koblenz.de wrote:
> Q: What filesystem types are supported directly by the ARC firmware in the
> ROMs?

is there a way to do a raw disk access via ARC firmware ? Mabye we could
use some bits from SILO (Sparc Linux Loader) and get ext2fs access this
way. 

Thomas.

-- 
See, you not only have to be a good coder to create a system like Linux,
you have to be a sneaky bastard too ;-)
                   [Linus Torvalds in <4rikft$7g5@linux.cs.Helsinki.FI>]
