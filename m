Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id QAA13950 for <linux-archive@neteng.engr.sgi.com>; Sun, 10 Jan 1999 16:37:51 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA92304
	for linux-list;
	Sun, 10 Jan 1999 16:37:05 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA93050
	for <linux@engr.sgi.com>;
	Sun, 10 Jan 1999 16:37:03 -0800 (PST)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA02697
	for <linux@engr.sgi.com>; Sun, 10 Jan 1999 16:36:56 -0800 (PST)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (pmport-03.uni-koblenz.de [141.26.249.3])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id AAA08122
	for <linux@engr.sgi.com>; Mon, 11 Jan 1999 00:55:27 +0100 (MET)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.8.7/8.8.7) id AAA32395;
	Mon, 11 Jan 1999 00:48:48 +0100
Message-ID: <19990111004848.C18917@uni-koblenz.de>
Date: Mon, 11 Jan 1999 00:48:48 +0100
From: ralf@uni-koblenz.de
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: Re: Unused memory
References: <19990110172259.A2057@alpha.franken.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
In-Reply-To: <19990110172259.A2057@alpha.franken.de>; from Thomas Bogendoerfer on Sun, Jan 10, 1999 at 05:22:59PM +0100
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Sun, Jan 10, 1999 at 05:22:59PM +0100, Thomas Bogendoerfer wrote:

> I now know the reason for this. Before giving out memory via brk() the
> kernel checks, whether there is enough memory. The kernel holds back
> (2 + page_cache.min_percent + buffer_mem.min_pecent) percent of the
> available memory (see function vm_enough_memory() in mm/mmap.c). Problem
> on the Indy is, that num_physpages is wrong by 128MB, because we account
> the memory by only looking at the highest page number and forget about 
> holes in the memory map. And the Indy has a big hole between 0x80002000 
> and 0x88002000 ...
> 
> Right now I can't think of a good fix for this problem. Any ideas ?

Attached is a quickfix which just fixes the calculation of num_physpages.
The real thing is to us the PG_skip flag and implement the PageSkip macro.
See the Sparc / Sparc64 code for how to implement.  Implementing this
will save us alot of memory as well.  I'll post a real patch later.

  Ralf

--- arch/mips/mm/init.c.orig	Sun Jan 10 23:50:12 1999
+++ arch/mips/mm/init.c	Sun Jan 10 23:50:53 1999
@@ -247,8 +247,9 @@
 #endif
 
 	end_mem &= PAGE_MASK;
-	max_mapnr = num_physpages = MAP_NR(end_mem);
+	max_mapnr = MAP_NR(end_mem);
 	high_memory = (void *)end_mem;
+	num_physpages = 0;
 
 	/* mark usable pages in the mem_map[] */
 	start_mem = PAGE_ALIGN(start_mem);
@@ -278,6 +279,7 @@
 				datapages++;
 			continue;
 		}
+		num_physpages++;
 		atomic_set(&mem_map[MAP_NR(tmp)].count, 1);
 #ifdef CONFIG_BLK_DEV_INITRD
 		if (!initrd_start || (tmp < initrd_start || tmp >=
