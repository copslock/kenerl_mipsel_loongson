Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id QAA22231 for <linux-archive@neteng.engr.sgi.com>; Mon, 28 Sep 1998 16:18:08 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA74555
	for linux-list;
	Mon, 28 Sep 1998 16:17:02 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA51519
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 28 Sep 1998 16:17:00 -0700 (PDT)
	mail_from (sgi.sgi.com!rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA04966
	for <linux@cthulhu.engr.sgi.com>; Mon, 28 Sep 1998 16:16:58 -0700 (PDT)
	mail_from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m0zNmXI-0027wLC@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Tue, 29 Sep 1998 00:16:56 +0100 (MET)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m0zNmX8-002PVAC; Tue, 29 Sep 98 01:16 MET DST
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id BAA03556;
	Tue, 29 Sep 1998 01:14:14 +0200
Message-ID: <19980929011414.43485@alpha.franken.de>
Date: Tue, 29 Sep 1998 01:14:14 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: linux@cthulhu.engr.sgi.com
Subject: VCEI/VCED handling
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Yesterday I studied the MIPS user's manual to find out, what has to be
done for the virtual cache coherency exceptions. Before I start to write
some code, I want make sure, that I got it right.

VCEI:
	Hit Set Virtual on BadVaddr

VCED: 
	Hit Invalidate BadVaddr
	TLB Lookup for BadVaddr
	Physical Address -> Index
	Index Load Tag
	Extract PIdx from TagLo
	Construct Vaddr from BadVaddr and PIdx
	Hit Write Back on created Vaddr
	Hit Set Virtual on BadVaddr

Comments ?

Thomas.

-- 
See, you not only have to be a good coder to create a system like Linux,
you have to be a sneaky bastard too ;-)
                   [Linus Torvalds in <4rikft$7g5@linux.cs.Helsinki.FI>]
