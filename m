Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id RAA60144 for <linux-archive@neteng.engr.sgi.com>; Fri, 28 Aug 1998 17:12:21 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id RAA85011
	for linux-list;
	Fri, 28 Aug 1998 17:11:49 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id RAA42947
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 28 Aug 1998 17:11:47 -0700 (PDT)
	mail_from (sgi.sgi.com!rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id RAA18741
	for <linux@cthulhu.engr.sgi.com>; Fri, 28 Aug 1998 17:11:46 -0700 (PDT)
	mail_from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m0zCYcH-0027whC@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Sat, 29 Aug 1998 02:11:41 +0200 (MET DST)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m0zCYbm-002P86C; Sat, 29 Aug 98 02:11 MET DST
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id CAA06005;
	Sat, 29 Aug 1998 02:08:18 +0200
Message-ID: <19980829020818.25410@alpha.franken.de>
Date: Sat, 29 Aug 1998 02:08:18 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: ralf@uni-koblenz.de
Cc: linux-mips@fnet.fr, linux@cthulhu.engr.sgi.com
Subject: Re: Emacs problem
References: <19980823223647.12724@alpha.franken.de> <19980824121930.00186@uni-koblenz.de> <19980825225603.43888@alpha.franken.de> <19980828123154.B358@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85
In-Reply-To: <19980828123154.B358@uni-koblenz.de>; from ralf@uni-koblenz.de on Fri, Aug 28, 1998 at 12:31:54PM +0200
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Fri, Aug 28, 1998 at 12:31:54PM +0200, ralf@uni-koblenz.de wrote:
> On Tue, Aug 25, 1998 at 10:56:03PM +0200, Thomas Bogendoerfer wrote:
> 
> > Another questione does gcc/egcs produce .sdata, .lit4 or .li8 sections
> > on Linux/MIPS ?
> 
> These sections are mostly being used for code using global pointer
> optimization.  .lit8 is also being used for fp code when assembling li.d
> macros.

as they don't show up in the temacs binary, I'll ignore them for unexec().

With a crude hack in unexec(), I now have a emcas binary, which will show up
an empty X window. Looking with strace and tcpdump it looks like emacs
tries to do more X work, but doesn't succeed. Stuff for the weekend ...

Thomas.

-- 
See, you not only have to be a good coder to create a system like Linux,
you have to be a sneaky bastard too ;-)
                   [Linus Torvalds in <4rikft$7g5@linux.cs.Helsinki.FI>]
