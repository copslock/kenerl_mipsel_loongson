Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id CAA72079 for <linux-archive@neteng.engr.sgi.com>; Sun, 6 Sep 1998 02:41:06 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id CAA38087
	for linux-list;
	Sun, 6 Sep 1998 02:40:11 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id CAA09112
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 6 Sep 1998 02:40:09 -0700 (PDT)
	mail_from (sgi.sgi.com!rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id CAA09970
	for <linux@cthulhu.engr.sgi.com>; Sun, 6 Sep 1998 02:40:08 -0700 (PDT)
	mail_from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m0zFbIh-0027vPC@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Sun, 6 Sep 1998 11:40:03 +0200 (MET DST)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m0zFbIV-002Ow7C; Sun, 6 Sep 98 11:39 MET DST
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id LAA00981;
	Sun, 6 Sep 1998 11:37:15 +0200
Message-ID: <19980906113715.16157@alpha.franken.de>
Date: Sun, 6 Sep 1998 11:37:15 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Ulf Carlsson <grim@ballyhoo.ml.org>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: SCSI problems
References: <19980905223307.15653@alpha.franken.de> <Pine.LNX.3.96.980906104849.14540A-100000@ballyhoo.ml.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85
In-Reply-To: <Pine.LNX.3.96.980906104849.14540A-100000@ballyhoo.ml.org>; from Ulf Carlsson on Sun, Sep 06, 1998 at 10:54:52AM +0200
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Sun, Sep 06, 1998 at 10:54:52AM +0200, Ulf Carlsson wrote:
> On Sat, 5 Sep 1998, Thomas Bogendoerfer wrote:
> Which processor do you have, e.g. which dma_cache_wback_inv procedure are
> you making use of? 

it's a R4600 with second level cache. So it should use 
r4k_dma_cache_wback_inv_sc(), too.

Thomas.

-- 
See, you not only have to be a good coder to create a system like Linux,
you have to be a sneaky bastard too ;-)
                   [Linus Torvalds in <4rikft$7g5@linux.cs.Helsinki.FI>]
