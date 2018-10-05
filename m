Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Oct 2018 16:56:19 +0200 (CEST)
Received: from pio-pvt-msa1.bahnhof.se ([79.136.2.40]:54933 "EHLO
        pio-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990423AbeJEO4P0qayA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Oct 2018 16:56:15 +0200
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTP id EBC453F519;
        Fri,  5 Oct 2018 16:56:14 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id bDGz6261yrce; Fri,  5 Oct 2018 16:56:13 +0200 (CEST)
Received: from localhost (h-41-252.A163.priv.bahnhof.se [46.59.41.252])
        (Authenticated sender: mb547485)
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 22B543F390;
        Fri,  5 Oct 2018 16:56:12 +0200 (CEST)
Date:   Fri, 5 Oct 2018 16:56:12 +0200
From:   Fredrik Noring <noring@nocrew.org>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban@gmx.de>
Subject: Re: [PATCH] TC: Set DMA masks for devices
Message-ID: <20181005145612.GA2341@sx-9>
References: <alpine.LFD.2.21.1810030109210.5483@eddie.linux-mips.org>
 <20181004165720.GA2361@sx-9>
 <alpine.LFD.2.21.1810041916420.12089@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1810041916420.12089@eddie.linux-mips.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Return-Path: <noring@nocrew.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66703
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: noring@nocrew.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Hi Maciej,

> > A complication with the PS2 OHCI is that DMA addresses 0-0x200000 map to
> > 0x1c000000-0x1c200000 as seen by the kernel. Robin suggested that the mask
> > might correspond to the effective addressing capability, which would be
> > DMA_BIT_MASK(21),
> 
>  I take it you mean 0-0x1fffff obviously; let's be accurate in a technical 
> discussion and avoid ambiguous cases.

That's interesting. :) 0x1fffff is not a valid DMA address due to alignment
restrictions, so if one wants to indicate a closed [inclusive] DMA address
interval it would be 0-0x1ffffc, since the 32-bit word rather than the byte
is the unit of the IOP DMA. In mathematics and programming languages it is
often convenient to work with half-open intervals denoted by "[0,0x200000)"
in this case. I think both notations are technically accurate, but they do
emphasize different aspects of addresses and memory. I can switch to your
byte-centric notation if that helps. :)

>  Well, the need to map between the CPU and the DMA address space is not 
> uncommon.  As I recall the Galileo/Marvell GT-64xxx system controllers 
> have a BAR for PCI master accesses to local DRAM (so that multiple such 
> controllers can coexist in a NUMA system) and any non-identity mapping has 
> to be taken into account with DMA of course
> 
>  And indeed e.g. `dma_map_single' does handle that and given a CPU-side 
> physical memory address returns a corresponding DMA-side address.  And the 
> DMA mask has to reflect that and describe the DMA side, as it's the device 
> side that has an address space limitation here and any offset resulting 
> from a non-identity mapping does not change that limitation, although the 
> offset does have of course to be taken into account by `dma_map_single', 
> etc. in determining whether the memory area requested for use by a DMA 
> device can be used directly or whether a bounce buffer will be required 
> for that mapping.

Ah... memory that is known to be DMA compatible is allocated separately,
and then handed over to the DMA subsystem using dma_declare_coherent_memory.
This is done once during driver initialisation. The drivers ohci-sm501.c and
ohci-tmio.c do that too, which is why I suspect they might broken as well.

The SM501 driver has this explanation:

	/* The sm501 chip is equipped with local memory that may be used
	 * by on-chip devices such as the video controller and the usb host.
	 * This driver uses dma_declare_coherent_memory() to make sure
	 * usb allocations with dma_alloc_coherent() allocate from
	 * this local memory. The dma_handle returned by dma_alloc_coherent()
	 * will be an offset starting from 0 for the first local memory byte.
	 *
	 * So as long as data is allocated using dma_alloc_coherent() all is
	 * fine. This is however not always the case - buffers may be allocated
	 * using kmalloc() - so the usb core needs to be told that it must copy
	 * data into our local memory if the buffers happen to be placed in
	 * regular memory. The HCD_LOCAL_MEM flag does just that.
	 */

	retval = dma_declare_coherent_memory(dev, mem->start,
					 mem->start - mem->parent->start,
					 resource_size(mem),
					 DMA_MEMORY_EXCLUSIVE);

The corresponding code in the PS2 OHCI driver does

	ps2priv->iop_dma_addr = iop_alloc(size);
	if (ps2priv->iop_dma_addr == 0) {
		dev_err(dev, "iop_alloc failed\n");
		return -ENOMEM;
	}

	if (dma_declare_coherent_memory(dev,
			iop_bus_to_phys(ps2priv->iop_dma_addr),
			ps2priv->iop_dma_addr, size, flags)) {
		dev_err(dev, "dma_declare_coherent_memory failed\n");
		iop_free(ps2priv->iop_dma_addr);
		ps2priv->iop_dma_addr = 0;
		return -ENOMEM;
	}

where iop_alloc is a special IOP memory allocation function and its return
value stored in iop_dma_addr is handed over to dma_declare_coherent_memory.

> > but it does not seem to be entirely clear, since his
> > commit message said that
> > 
> >     A somewhat similar line of reasoning also applies at the other end for
> >     the mask check in dma_alloc_attrs() too - indeed, a device which cannot
> >     access anything other than its own local memory probably *shouldn't*
> >     have a valid mask for the general coherent DMA API.
> 
>  Well, how can such a device use the DMA API in the first place?  If the 
> device has local memory, than the driver has to manage it itself somehow 
> if needed, and then arrange copying it to main memory, either by a CPU or 
> a third-party DMA controller (data mover) if available.  Of course in the 
> latter case a driver for the DMA controller may have to use the DMA API.

The coherently declared memory given to the DMA subsystem is used for a
fixed sized DMA pool and no additional allocations are permitted. One could
choose a DMA mask that pretends to be reasonable, or the opposite, a mask
such as 1 that is unreasonable on purpose, as Robin writes:

	Alternatively, there is perhaps some degree of argument for
	deliberately picking a nonzero but useless value like 1,
	although it looks like the MIPS allocator (at least the dma-
	default one) never actually checks whether the page it gets
	is within range of the device's coherent mask, which it
	probably should do.

	https://lkml.org/lkml/2018/7/6/697

>  I'll be resubmitting a driver for such a device shortly, the DEFZA (the 
> previous submission can be found here: 
> <https://marc.info/?l=linux-netdev&m=139841853827404>).  It is interesting 
> in that the FDDI engine supports host DMA on the reception side (and 
> consequently the driver uses the DMA API to handle that), while on the 
> transmission side (as well as with a couple of maintenance queues) it only 
> does DMA with its onboard buffer memory, the contents of which need to be 
> copied by the CPU.  So there's no use of the DMA API on the transmission 
> or maintenance side.  However usual DMA rings (all located in board memory 
> too) are used for all data moves.

The DMA for its onboard buffer memory appears to be very similar to the
IOP and its DMA? That memory is currently copied by the EE, but there are
other DMA controllers that could handle that, possibly synchronised using
DMA chaining, which would assist the EE significantly.

Apart from USB, the IOP does networking, FireWire, harddisks, etc. Some
or all of the peripherals could be accelerated with DMA, which is an
interesting challenge.

>  The DEFTA is a follow-up and an upgrade to the DEFZA, more integrated 
> (the DEFZA uses a pair of PCBs while the DEFTA fits on one, of the size of 
> each in the former pair), and with the extra silicon space gained it was 
> possible to squeeze in circuitry required to do host DMA for all data 
> moves, and also the DMA rings.

Nice. :)

> > A special circumstance here is the use of HCD_LOCAL_MEM that is a kind of
> > DMA bounce buffer. Are you using anything similar with your DEFTA driver?
> 
>  The driver does need either an IOMMU or bounce buffers in system RAM in 
> the case of 64-bit PCI systems, as the PFI PCI ASIC that the FDDI PDQ ASIC 
> interfaces on the DEFPA does not AFAIK support 64-bit addressing (be it 
> directly or with the use of DAC), although the PDQ itself does support 
> 48-bit addressing (i.e. DMA descriptor addresses hold bits 47:2 of host 
> addresses), which would be sufficient for the usual cases.
> 
>  Not in the DEFTA (or for that matter DEFEA; possibly the only EISA device 
> using the DMA API) case though, as the most equipped TURBOchannel systems, 
> i.e. the DEC 3000 AXP models 500, 800 and 900 only support up to 1GiB of 
> memory, which is well below the 34-bit addressing limit.
> 
>  The PDQ ASIC was used to interface FDDI to many host buses and in 
> addition to the 3 bus attachments mentioned above, all of which we have 
> support for in Linux, it was also used for Q-bus (the DEFQA) and FutureBus 
> (the DEFAA).  We may have support for the DEFQA one day as I have both 
> such a board and a suitable system to use it with.  We are unlikely to 
> have support for the DEFAA, as FutureBus was only used in high-end VAX and 
> Alpha systems, the size of a full 19" rack at the very least, but it is 
> there I believe only that the full PDQ addressing capability was actually 
> utilised.

Thanks! By the way, is it possible to find spare parts for such vintage
hardware these days in case of irrepairable failures?

>  NB I sat on this fix from 2014, well before the warning was introduced in 
> the first place, and it's only now that I got to unloading my patch queue. 
> :(

Do you have the latest kernel running on your DECstation machines now? :)

Fredrik
