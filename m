Received:  by oss.sgi.com id <S305164AbQDFKpj>;
	Thu, 6 Apr 2000 03:45:39 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:30558 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305166AbQDFKpJ>;
	Thu, 6 Apr 2000 03:45:09 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id DAA07991; Thu, 6 Apr 2000 03:39:06 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id DAA79414
	for linux-list;
	Thu, 6 Apr 2000 03:36:08 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from deliverator.sgi.com (deliverator.sgi.com [150.166.91.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id DAA76172
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 6 Apr 2000 03:34:47 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id DAA06798
	for <linux@cthulhu.engr.sgi.com>; Thu, 6 Apr 2000 03:30:06 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 8751C7F5; Thu,  6 Apr 2000 12:21:37 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 192D68FC3; Thu,  6 Apr 2000 12:08:31 +0200 (CEST)
Date:   Thu, 6 Apr 2000 12:08:31 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc:     linux@cthulhu.engr.sgi.com
Subject: Re: cause of early indigo2 crash
Message-ID: <20000406120830.A276@paradigm.rfc822.org>
References: <20000405223413.B996@paradigm.rfc822.org> <Pine.GSO.4.10.10004061050160.28032-100000@dandelion.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <Pine.GSO.4.10.10004061050160.28032-100000@dandelion.sonytel.be>; from Geert Uytterhoeven on Thu, Apr 06, 2000 at 10:51:17AM +0200
Organization: rfc822 - pure communication
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Thu, Apr 06, 2000 at 10:51:17AM +0200, Geert Uytterhoeven wrote:
> > scsi::resize_dma_pool: WARNING, dma_sectors=0, wanted=48, scaling
> >        WARNING, not enough memory, pool not expanded
> > Unable to handle kernel paging request at virtual address 00000000, epc == 880cc668, ra == 880cc5d8
> > [...]
>   ^^^^^
> What's here? Usually it tells the function where it crashes.

:) I dont have an System.map available - But i think i know the cause
of the crash - I think the arch/mips/arc/memory.c forgets to
allocate/not-free the memory the kernel - I dont think the ARC Prom is
able to mark the kernel memory different - But i cant see a location
where it explicitly reserves/allocates the kernel pages. Dec and ddb
to something like free_bootmem(bootmap,&_end,size-_end) - Nothing
like that in the arc things ... They free all memory segments
the ARC Prom gives back as "MEMTYPE_FREE" (arc_contigm, arc_freem)
and then it just takes the largest segment (there are 2 segments 
- before and after the arc-prom segment) and installs the bootmem-map
in there. The next alloc and memset causes the crash as it allocates
from 88002000 which is the end of the mem map - My suspicion is (Which
ill try tonight) that the memory map with 2 pages is that small
that is just overwrites parts of the kernel with no effect - The next alloc
and memset is 4MB - This destroys the kernel completely and though causes
a crash.

> I see these panics sometimes as well. Where does the crash happen? Please
> lookup in System.map.

Ill do tonight

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-subject-2-change
"Technology is a constant battle between manufacturers producing bigger and
more idiot-proof systems and nature producing bigger and better idiots."
