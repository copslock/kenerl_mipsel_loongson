Received:  by oss.sgi.com id <S305167AbQDFIZH>;
	Thu, 6 Apr 2000 01:25:07 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:54067 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305166AbQDFIYl>;
	Thu, 6 Apr 2000 01:24:41 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id BAA16639; Thu, 6 Apr 2000 01:19:58 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id BAA03945
	for linux-list;
	Thu, 6 Apr 2000 01:12:47 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from deliverator.sgi.com (deliverator.sgi.com [150.166.91.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id BAA63435
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 6 Apr 2000 01:12:46 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id BAA14530
	for <linux@cthulhu.engr.sgi.com>; Thu, 6 Apr 2000 01:08:05 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 1DA597F4; Thu,  6 Apr 2000 09:59:35 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id B16008FC3; Wed,  5 Apr 2000 22:34:13 +0200 (CEST)
Date:   Wed, 5 Apr 2000 22:34:13 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     linux@cthulhu.engr.sgi.com
Subject: cause of early indigo2 crash
Message-ID: <20000405223413.B996@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
Organization: rfc822 - pure communication
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

Hi,
i discovered that the prom of the indigo2 reports 2 MEMTYPE_FREE
segments - One at 08002000 and the other at 88000000 - The second one
at least 16 times larger - If i exclude the first segment from beeing
freed and thus used the kernel boots much further - This is what
i did in the arch/mips/arc/memory.c

        for (i = 0; pblocks[i].size; i++)
                if (pblocks[i].type == MEMTYPE_FREE &&
                                pblocks[i].base != 0x8002000)
                        free_bootmem(pblocks[i].base, pblocks[i].size);

Now i get a very different crash - After SCSI Detection i get

scsi::resize_dma_pool: WARNING, dma_sectors=0, wanted=96, scaling
scsi::resize_dma_pool: WARNING, dma_sectors=0, wanted=80, scaling
scsi::resize_dma_pool: WARNING, dma_sectors=0, wanted=64, scaling
scsi::resize_dma_pool: WARNING, dma_sectors=0, wanted=48, scaling
       WARNING, not enough memory, pool not expanded
Unable to handle kernel paging request at virtual address 00000000, epc == 880cc668, ra == 880cc5d8
[...]

Thats it - Might the first area be DMA bounce buffer only which have to
be initialized in the memory controller ?

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-subject-2-change
"Technology is a constant battle between manufacturers producing bigger and
more idiot-proof systems and nature producing bigger and better idiots."
