Received:  by oss.sgi.com id <S305190AbQDXLpB>;
	Mon, 24 Apr 2000 04:45:01 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:16249 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305161AbQDXLox>; Mon, 24 Apr 2000 04:44:53 -0700
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id EAA06526; Mon, 24 Apr 2000 04:49:00 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id EAA96784
	for linux-list;
	Mon, 24 Apr 2000 04:31:10 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id EAA04568
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 24 Apr 2000 04:31:09 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id EAA01874
	for <linux@cthulhu.engr.sgi.com>; Mon, 24 Apr 2000 04:31:08 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id B5BC883D; Mon, 24 Apr 2000 13:31:09 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 74D2F8FFD; Mon, 24 Apr 2000 13:22:21 +0200 (CEST)
Date:   Mon, 24 Apr 2000 13:22:21 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     Ulf Carlsson <ulfc@calypso.engr.sgi.com>
Cc:     Florian Lohoff <flo@oss.sgi.com>, linux@cthulhu.engr.sgi.com
Subject: early crash on indigo2 fix breaks indy ...
Message-ID: <20000424132221.D2583@paradigm.rfc822.org>
References: <20000406181353Z305167-1649+66@oss.sgi.com> <Pine.LNX.4.21.0004240346370.23887-100000@calypso.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <Pine.LNX.4.21.0004240346370.23887-100000@calypso.engr.sgi.com>; from Ulf Carlsson on Mon, Apr 24, 2000 at 03:49:21AM -0700
Organization: rfc822 - pure communication
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Mon, Apr 24, 2000 at 03:49:21AM -0700, Ulf Carlsson wrote:
> > Modified files:
> > 	arch/mips/arc  : memory.c 
> > 
> > Log message:
> > 	Fix early crash on SGI_IP22 due to not reserving kernel
> > 	pages in the boomem setup
> 
> This breaks on my Indy.  What machine are you using?  Do we know whether the
> part of memory where the kernel is loaded is reported as free memory from the
> prom or should we add some tests?

Indigo2 - I had the problem that the first alloc_bootmem i think
got back pages in the kernel marked as "free" - The resulting memset
let the kernel crash. My solution was to mark the kernel pages
as reserved.

BTW: What does break on indy ? Does it crash ? Does it hang in SCSI Detection ?
The SCSI detection is a different thing - The problem is that the kernel
gets loaded in a area which is from the MAX_DMA_ADDRESS DMAable memory.
Afterwards no pages are left for DMA and the generic scsi layer is not
able to get dma able pages (from zone 0 GFP_DMA) which results in error
messages in the scsi layer. I solved this by changing mm/init.c
to put ALL pages into zone 0 as from my understanding the MAX_DMA_ADDRESS
is only aplicable to PC style DMA Controllers which the indy/indigo2 hopefully
dont have. For this patch i didnt apply to CVS nobody gave back 
and usefull comment.

Here is the fix i am using:

Index: init.c
===================================================================
RCS file: /cvs/linux/arch/mips/mm/init.c,v
retrieving revision 1.27
diff -u -r1.27 init.c
--- init.c	2000/02/23 01:33:56	1.27
+++ init.c	2000/04/24 11:29:51
@@ -256,13 +256,16 @@
 	max_dma = virt_to_phys((char *)MAX_DMA_ADDRESS) >> PAGE_SHIFT;
 	low = max_low_pfn;
 
+#if defined(CONFIG_ISA) || defined(CONFIG_PCI)
 	if (low < max_dma)
 		zones_size[ZONE_DMA] = low;
 	else {
 		zones_size[ZONE_DMA] = max_dma;
 		zones_size[ZONE_NORMAL] = low - max_dma;
 	}
-
+#else
+	zones_size[ZONE_DMA] = low;
+#endif
 	free_area_init(zones_size);
 }
 


Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-subject-2-change
"Technology is a constant battle between manufacturers producing bigger and
more idiot-proof systems and nature producing bigger and better idiots."
