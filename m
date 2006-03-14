Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Mar 2006 19:45:16 +0000 (GMT)
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:49326 "EHLO
	lxorguk.ukuu.org.uk") by ftp.linux-mips.org with ESMTP
	id S8133734AbWCNTpH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 14 Mar 2006 19:45:07 +0000
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by lxorguk.ukuu.org.uk (8.13.4/8.13.4) with ESMTP id k2EK0XaQ003815;
	Tue, 14 Mar 2006 20:00:33 GMT
Received: (from alan@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id k2EK0Wx3003814;
	Tue, 14 Mar 2006 20:00:32 GMT
X-Authentication-Warning: localhost.localdomain: alan set sender to alan@lxorguk.ukuu.org.uk using -f
Subject: RE: BCM91x80A/B PCI DMA problems
From:	Alan Cox <alan@lxorguk.ukuu.org.uk>
To:	Mark E Mason <mark.e.mason@broadcom.com>
Cc:	Martin Michlmayr <tbm@cyrius.com>, linux-mips@linux-mips.org
In-Reply-To: <7E000E7F06B05C49BDBB769ADAF44D07868182@NT-SJCA-0750.brcm.ad.broadcom.com>
References: <7E000E7F06B05C49BDBB769ADAF44D07868182@NT-SJCA-0750.brcm.ad.broadcom.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date:	Tue, 14 Mar 2006 20:00:28 +0000
Message-Id: <1142366428.3623.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Return-Path: <alan@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10814
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

On Maw, 2006-03-14 at 08:55 -0800, Mark E Mason wrote:
> > needs fixing. The drivers don't deal with this matter beyond 
> > setting their PCI DMA range mask.
> 
> Thanks!
> 
> I'm not that familiar with all parts of the Linux kernel.  What should I
> be looking for in order to find the relevant bits in the arch-port code?

At the heart of it you need to look at the PCI DMA API. 

[Documentation/DMA-mapping.txt]

Linux uses three kinds of address: virtual and physical are the usual
expected CPU view, bus is the view from the I/O side. On most platforms
physical == bus but not all.

These are mapped onto the dma_* functions of the same name for most
platforms (see include/asm-generic/pci-dma-compat.h) but need not be.
The allocators then grab memory from the right memory pool (16Mb, 32bit,
highmem ..).

For mapping of pages this isn't so simple as the page might be above the
DMA limit of a device. dma_map_* gives you the bus address of a
something relative to the device. This is arch implemented and can
return an address out of the device range.

For a block device that is misbehaving you want to check

1. That the DMA allocations done by the driver (eg the IDE PRD) are
coming in below 4GB as expected

2. Take a look then at block/ll_rw_blk.c which deals with the block
layer. Dump the calls to blk_queue_block_limit and make sure the things
it does are looking sane. 

3. Take a look at what is going on in blk_rq_map_sg which deals with
mapping scatter gather lists to the device, while handling the bounce
limits. (dma_unmap_sg is the clean up end of this)

4. This lot then gets used by ide_build_sglist in drivers/ide/ide-dma.c
and the related ide_build_dmatable function. These might also be worth
dropping debug into to see what is cooking.

Alan
