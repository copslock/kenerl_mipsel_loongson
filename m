Received:  by oss.sgi.com id <S305171AbQDFULr>;
	Thu, 6 Apr 2000 13:11:47 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:15632 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305167AbQDFULa>;
	Thu, 6 Apr 2000 13:11:30 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id NAA00912; Thu, 6 Apr 2000 13:06:48 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id NAA83335
	for linux-list;
	Thu, 6 Apr 2000 13:03:27 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id NAA83356
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 6 Apr 2000 13:03:26 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id NAA01215
	for <linux@cthulhu.engr.sgi.com>; Thu, 6 Apr 2000 13:03:23 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 536657F9; Thu,  6 Apr 2000 22:03:23 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 0E3228FC3; Thu,  6 Apr 2000 21:50:17 +0200 (CEST)
Date:   Thu, 6 Apr 2000 21:50:16 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     linux@cthulhu.engr.sgi.com
Subject: DMA memory on IP22 unavailable ?
Message-ID: <20000406215014.E5141@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
Organization: rfc822 - pure communication
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

Hi,
i have fixed the original problem with the bootmem initialization 
for ARC which didnt reserve the kernel pages as unallocatable - This
is already committed to CVS for the ones trying on IP22. Now i have
a different problems - The kernel halts on further boot with
no memory for SCSI DMA.

This is due to my indigo2 having physical memory from
0x08002000 - 0x08740000
0x08200000 - 0x0ff85000

Now the official DMA able memory from include/asm/dma.h is

#define MAX_DMA_ADDRESS         (PAGE_OFFSET + 0x01000000)

which is 0x81000000 which is completely out of range for
the SGI. I now just changed this to 8f000000 but what
is the correct way to solve this and what is the correct
dma able memory (I suppose all memory is dma-able).

-- 
Florian Lohoff		flo@rfc822.org		      	+49-subject-2-change
"Technology is a constant battle between manufacturers producing bigger and
more idiot-proof systems and nature producing bigger and better idiots."
