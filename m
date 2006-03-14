Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Mar 2006 22:35:07 +0000 (GMT)
Received: from mms1.broadcom.com ([216.31.210.17]:2578 "EHLO mms1.broadcom.com")
	by ftp.linux-mips.org with ESMTP id S8133636AbWCNWe5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 14 Mar 2006 22:34:57 +0000
Received: from 10.10.64.154 by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.2.0)); Tue, 14 Mar 2006 14:45:22 -0800
X-Server-Uuid: F962EFE0-448C-40EE-8100-87DF498ED0EA
Received: by mail-irva-10.broadcom.com (Postfix, from userid 47) id
 BCA912AF; Tue, 14 Mar 2006 14:43:45 -0800 (PST)
Received: from mail-irva-8.broadcom.com (mail-irva-8 [10.10.64.221]) by
 mail-irva-10.broadcom.com (Postfix) with ESMTP id 953CA2AE; Tue, 14 Mar
 2006 14:43:45 -0800 (PST)
Received: from mail-sj1-12.sj.broadcom.com (mail-sj1-12.sj.broadcom.com
 [10.16.128.215]) by mail-irva-8.broadcom.com (MOS 3.7.3a-GA) with ESMTP
 id DCF49061; Tue, 14 Mar 2006 14:43:42 -0800 (PST)
Received: from NT-SJCA-0750.brcm.ad.broadcom.com (nt-sjca-0750
 [10.16.192.220]) by mail-sj1-12.sj.broadcom.com (Postfix) with ESMTP id
 C2BD720501; Tue, 14 Mar 2006 14:43:42 -0800 (PST)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: BCM91x80A/B PCI DMA problems
Date:	Tue, 14 Mar 2006 14:43:25 -0800
Message-ID: <7E000E7F06B05C49BDBB769ADAF44D078681FA@NT-SJCA-0750.brcm.ad.broadcom.com>
Thread-Topic: BCM91x80A/B PCI DMA problems
Thread-Index: AcZHoRumVFSyjirYTZOBFy4nBgb3hgAFc1Iw
From:	"Mark E Mason" <mark.e.mason@broadcom.com>
To:	"Alan Cox" <alan@lxorguk.ukuu.org.uk>
cc:	"Martin Michlmayr" <tbm@cyrius.com>, linux-mips@linux-mips.org
X-TMWD-Spam-Summary: SEV=1.1; DFV=A2006031408; IFV=2.0.6,4.0-7;
 RPD=4.00.0004;
 RPDID=303030312E30413039303230352E34343137343643462E303034342D412D;
 ENG=IBF; TS=20060314224524; CAT=NONE; CON=NONE;
X-MMS-Spam-Filter-ID: A2006031408_4.00.0004_2.0.6,4.0-7
X-WSS-ID: 6809980836K7773806-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-Path: <mark.e.mason@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10815
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mark.e.mason@broadcom.com
Precedence: bulk
X-list: linux-mips

Hello,

Unfortunately, I don't have the failing piece of HW.... So this is all
by code inspection.
 
> For a block device that is misbehaving you want to check
> 
> 1. That the DMA allocations done by the driver (eg the IDE 
> PRD) are coming in below 4GB as expected

Well, the 32bit DMA mask appears to be set correctly by the IDE driver
in drivers/ide/setup-pci.c (around line 312) -- so it would seem that if
large (>32-bit) addresses were being attempted by the driver, either the
code path including the call to pci_set_dma_mask() wasn't invoked, or
something within the driver or memory allocator went wrong.

What I'm not clear about is what part of this -- if any -- actually
involves the architecture specific code.  In particular, when you say
architecture specific here, do you mean "MIPS" or "SB1 on MIPS"?  It
seems like all of this is handled in the arch independent code.  FWIW,
the SB1 uses the fairly generic dma-coherent.c support under
arch/mips/mm.

The only troubling thing I saw in Documentation/DMA-mapping.txt was what
looked like an assumption that 64-bit systems with 32-bit devices would
have an IOMMU to redirect (arbitrary) 32-bit PCI bus addresses to
(arbitrary) 64-bit physical memory addresses.  I've seen (and
programmed) such things on UltraSPARC systems, but none exists on the
SB1.

But, the later comments about the automatic bounce buffering and the PCI
DMA mask seemed to imply that the IOMMU wasn't required/assumed in all
cases.

> 
> 2. Take a look then at block/ll_rw_blk.c which deals with the 
> block layer. Dump the calls to blk_queue_block_limit and make 
> sure the things it does are looking sane. 
> 
> 3. Take a look at what is going on in blk_rq_map_sg which 
> deals with mapping scatter gather lists to the device, while 
> handling the bounce limits. (dma_unmap_sg is the clean up end of this)
> 
> 4. This lot then gets used by ide_build_sglist in 
> drivers/ide/ide-dma.c and the related ide_build_dmatable 
> function. These might also be worth dropping debug into to 
> see what is cooking.

Unfortunately, 2-4 above requires that I have the failing HW on hand,
which I don't at the moment.  Martin - any chance you can take a look at
this?

64-bit capable devices are known to work correctly in this system (and
known to use >32-bit physical addresses for DMA targets), so it seems
like the issue would mostly lie with the allocation of DMA buffers from
the lower 4G of physical memory.

Of course, I'm probably a bit lost here.  Chuckle.

Thx,
Mark

 
