Received:  by oss.sgi.com id <S305171AbQDGIiY>;
	Fri, 7 Apr 2000 01:38:24 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:17196 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305167AbQDGIiO>;
	Fri, 7 Apr 2000 01:38:14 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id BAA09772; Fri, 7 Apr 2000 01:33:32 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id BAA47731
	for linux-list;
	Fri, 7 Apr 2000 01:27:35 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id BAA48356
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 7 Apr 2000 01:27:34 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id BAA08749
	for <linux@cthulhu.engr.sgi.com>; Fri, 7 Apr 2000 01:27:33 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 960307FC; Fri,  7 Apr 2000 10:27:18 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id A5A828FC3; Fri,  7 Apr 2000 10:13:46 +0200 (CEST)
Date:   Fri, 7 Apr 2000 10:13:46 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     Ralf Baechle <ralf@oss.sgi.com>
Cc:     linux@cthulhu.engr.sgi.com
Subject: Re: DMA memory on IP22 unavailable ?
Message-ID: <20000407101346.C268@paradigm.rfc822.org>
References: <20000406215014.E5141@paradigm.rfc822.org> <20000406153741.C801@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <20000406153741.C801@uni-koblenz.de>; from Ralf Baechle on Thu, Apr 06, 2000 at 03:37:41PM -0700
Organization: rfc822 - pure communication
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Thu, Apr 06, 2000 at 03:37:41PM -0700, Ralf Baechle wrote:
> 
> This change is not acceptable for the IP22 because the Indigo2 has EISA
> slots.

OK 

> When only using the builtin SCSI hostadapter nothing should use GFP_DMA;
> on IP22 the entire memory is DMA-able.

It does request DMA pages which are not available within the zone allocator
or at least not because the kernel occupies the dma able pages
with the setup above. That causes the SCSI Partition scan to fail
as scsi_dma.c requests space for 96 dmaable sectors which are not available.

A couple of locations in the generic scsi code call scsi_resize_dma_pool
which itself tries to get DMA memory via

__get_free_pages(GFP_ATOMIC | GFP_DMA, 0);

Which trys to get pages from ZONE_DMA which itself contains
no free pages on MY indigo2 as the kernel occoupies the handful pages in
the default specified range. This causes scsi_resize_dma_pool to fail
but the locations i checked in the generic scsi code do not check
for return values.

BTW: Are the EISA slots supported ? 
     Does the "Default" MAX_DMA_ADDRESS apply to that DMA controller ?
     My above solution just declares all memory to DMA-able memory.

Solution ?

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-subject-2-change
"Technology is a constant battle between manufacturers producing bigger and
more idiot-proof systems and nature producing bigger and better idiots."
