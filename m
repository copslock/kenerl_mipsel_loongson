Received:  by oss.sgi.com id <S305177AbQDFXIS>;
	Thu, 6 Apr 2000 16:08:18 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:42573 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305167AbQDFXHy>;
	Thu, 6 Apr 2000 16:07:54 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id QAA27194; Thu, 6 Apr 2000 16:03:12 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA42702
	for linux-list;
	Thu, 6 Apr 2000 16:01:02 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgigate.sgi.com (sgigate.sgi.com [198.29.75.75])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA42868
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 6 Apr 2000 16:01:01 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received:  by lappi.waldorf-gmbh.de id <S407785AbQDFWhl>;
	Thu, 6 Apr 2000 15:37:41 -0700
Date:   Thu, 6 Apr 2000 15:37:41 -0700
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Florian Lohoff <flo@rfc822.org>
Cc:     linux@cthulhu.engr.sgi.com
Subject: Re: DMA memory on IP22 unavailable ?
Message-ID: <20000406153741.C801@uni-koblenz.de>
References: <20000406215014.E5141@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20000406215014.E5141@paradigm.rfc822.org>; from flo@rfc822.org on Thu, Apr 06, 2000 at 09:50:16PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Thu, Apr 06, 2000 at 09:50:16PM +0200, Florian Lohoff wrote:

> i have fixed the original problem with the bootmem initialization 
> for ARC which didnt reserve the kernel pages as unallocatable - This
> is already committed to CVS for the ones trying on IP22. Now i have
> a different problems - The kernel halts on further boot with
> no memory for SCSI DMA.
> 
> This is due to my indigo2 having physical memory from
> 0x08002000 - 0x08740000
> 0x08200000 - 0x0ff85000
> 
> Now the official DMA able memory from include/asm/dma.h is
> 
> #define MAX_DMA_ADDRESS         (PAGE_OFFSET + 0x01000000)
> 
> which is 0x81000000 which is completely out of range for
> the SGI. I now just changed this to 8f000000 but what
> is the correct way to solve this and what is the correct
> dma able memory (I suppose all memory is dma-able).

This change is not acceptable for the IP22 because the Indigo2 has EISA
slots.

When only using the builtin SCSI hostadapter nothing should use GFP_DMA;
on IP22 the entire memory is DMA-able.

  Ralf
