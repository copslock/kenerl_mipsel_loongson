Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id IAA82644 for <linux-archive@neteng.engr.sgi.com>; Sun, 10 Jan 1999 08:42:11 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id IAA91490
	for linux-list;
	Sun, 10 Jan 1999 08:41:19 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id IAA91271
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 10 Jan 1999 08:41:12 -0800 (PST)
	mail_from (sgi.sgi.com!rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id IAA06343
	for <linux@cthulhu.engr.sgi.com>; Sun, 10 Jan 1999 08:35:09 -0800 (PST)
	mail_from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m0zzNpH-0027r8C@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Sun, 10 Jan 1999 17:34:55 +0100 (MET)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m0zzNpB-002PWBC; Sun, 10 Jan 99 17:34 MET
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id RAA02088;
	Sun, 10 Jan 1999 17:22:59 +0100
Message-ID: <19990110172259.A2057@alpha.franken.de>
Date: Sun, 10 Jan 1999 17:22:59 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: linux-mips@fnet.fr, linux@cthulhu.engr.sgi.com
Cc: ulfc@bun.falkenberg.se
Subject: Unused memory
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi,

maybe some of you might remember Ulf Carlsson's test program, which
allocates memory in a loop until it gets an error from malloc(). This
program failed on his Indy long before the machine was really out of 
memory.

I now know the reason for this. Before giving out memory via brk() the
kernel checks, whether there is enough memory. The kernel holds back
(2 + page_cache.min_percent + buffer_mem.min_pecent) percent of the
available memory (see function vm_enough_memory() in mm/mmap.c). Problem
on the Indy is, that num_physpages is wrong by 128MB, because we account
the memory by only looking at the highest page number and forget about 
holes in the memory map. And the Indy has a big hole between 0x80002000 
and 0x88002000 ...

Right now I can't think of a good fix for this problem. Any ideas ?

Thomas.

-- 
   This device has completely bogus header. Compaq scores again :-|
It's a host bridge, but it should be called ghost bridge instead ;^)
                                        [Martin `MJ' Mares on linux-kernel]
