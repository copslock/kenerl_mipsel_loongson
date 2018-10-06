Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 06 Oct 2018 11:22:03 +0200 (CEST)
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:44150 "EHLO
        pio-pvt-msa3.bahnhof.se" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990394AbeJFJV7ED260 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 6 Oct 2018 11:21:59 +0200
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id 78D793F5A2;
        Sat,  6 Oct 2018 11:21:58 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id gWgjjzcoHPBo; Sat,  6 Oct 2018 11:21:57 +0200 (CEST)
Received: from localhost (h-41-252.A163.priv.bahnhof.se [46.59.41.252])
        (Authenticated sender: mb547485)
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id 328253F3B6;
        Sat,  6 Oct 2018 11:21:57 +0200 (CEST)
Date:   Sat, 6 Oct 2018 11:21:56 +0200
From:   Fredrik Noring <noring@nocrew.org>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban@gmx.de>
Subject: Re: [PATCH] TC: Set DMA masks for devices
Message-ID: <20181006092156.GA6783@sx-9>
References: <alpine.LFD.2.21.1810030109210.5483@eddie.linux-mips.org>
 <20181004165720.GA2361@sx-9>
 <alpine.LFD.2.21.1810041916420.12089@eddie.linux-mips.org>
 <20181005145612.GA2341@sx-9>
 <alpine.LFD.2.21.1810051602280.22125@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1810051602280.22125@eddie.linux-mips.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Return-Path: <noring@nocrew.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66713
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

> > Ah... memory that is known to be DMA compatible is allocated separately,
> > and then handed over to the DMA subsystem using dma_declare_coherent_memory.
> 
>  Well, that does specify both a CPU-side and a corresponding DMA-side 
> address too.

Yes, side-stepping any practical use of a DMA mask, which is why it
probably could have an arbitrary value except 0 that causes this warning.

> > This is done once during driver initialisation. The drivers ohci-sm501.c and
> > ohci-tmio.c do that too, which is why I suspect they might broken as well.
> > 
> > The SM501 driver has this explanation:
> > 
> > 	/* The sm501 chip is equipped with local memory that may be used
> > 	 * by on-chip devices such as the video controller and the usb host.
> > 	 * This driver uses dma_declare_coherent_memory() to make sure
> > 	 * usb allocations with dma_alloc_coherent() allocate from
> > 	 * this local memory. The dma_handle returned by dma_alloc_coherent()
> > 	 * will be an offset starting from 0 for the first local memory byte.
> 
>  From the description I take it it is some MMIO memory rather than host 
> memory.  I fail to see how it is supposed to work with these calls for 
> non-system memory, which certainly any MMIO memory is, which surely is not 
> under the supervision of the kernel memory allocator.

I agree, this is obscure to me too.

>  There are calls for MMIO memory defined in the DMA API, specifically 
> `dma_map_resource' and `dma_unmap_resource'.  I've never used them myself, 
> and I gather they provide you with a way for CPUs to access MMIO memory 
> with caching enabled and without the need to use the MMIO accessors only, 
> such as `readl', `writel', etc., which are expected to avoid going through 
> any CPU cache.  Maybe these are what you're after?
> 
>  But maybe I'm missing something.

That is handled within the USB OHCI subsystem. I don't know the details,
actually.

> > 	 *
> > 	 * So as long as data is allocated using dma_alloc_coherent() all is
> > 	 * fine. This is however not always the case - buffers may be allocated
> > 	 * using kmalloc() - so the usb core needs to be told that it must copy
> > 	 * data into our local memory if the buffers happen to be placed in
> > 	 * regular memory. The HCD_LOCAL_MEM flag does just that.
> > 	 */
> 
>  This raises a hack alert to me TBH.

Christoph Hellwig raised concerns too, but I don't know how an OHCI driver
could do things differently given the circumstances, at least for a simple
initial implementation. For sure, the IOP has the capability and was most
likely designed for handling USB devices and other peripherals to a much
greater extent than allowed by the current PS2 OHCI driver, where the EE
manipulates the OHCI registers directly, which is quite inefficient.

> > The DMA for its onboard buffer memory appears to be very similar to the
> > IOP and its DMA? That memory is currently copied by the EE, but there are
> > other DMA controllers that could handle that, possibly synchronised using
> > DMA chaining, which would assist the EE significantly.
> 
>  Mind that the DEFZA runs its own RTOS for initialization and management 
> support, including in particular SMT (Station Management).  This is run on 
> an MC68000 processor.  That processor is interfaced to a bus where board 
> memory is attached as well as the RMC (Ring Memory Controller) chip, which 
> acts as a DMA master on that bus, like does the host bus interface.  Also 
> certain control register writes from the host raise interrupts to the 
> MC68000 for special situations to handle.
> 
>  All the PDQ-based FDDI adapters also have an M68000 which runs an RTOS, 
> however the presence of the PDQ ASIC makes their architecture slightly 
> different as the FDDI chipset does host DMA via the PDQ ASIC, which acts 
> as a master on the host bus (possibly through a bridge chip like the PFI, 
> though TURBOchannel for example is interfaced directly).

How is its firmware handled? The Linux MIPS wiki entry for the DECstation
firmware

https://www.linux-mips.org/wiki/DECstation#Firmware

is a TODO. :) The main reason I'm asking is that the IOP is a MIPS R3000
(apparently in later product models replaced with a PowerPC 405GP and its
DECKARD software emulator) that also needs firmware. The IOP most likely
ought to handle multiple firmware files, in the IRX format, depending on
its set of services.

Have you implemented sysfs structures to inspect the DEFZA RTOS? That is
something I would like to do for the IOP.

>  The biggest challenge has turned out to be electrolytic capacitor 
> failures in power supplies.  Unfortunately in late 1980s to mid 1990s 
> several lines of low-ESR capacitors, used in output filters in switch-mode 
> PSUs, were made with a new electrolyte formula based on a quaternary 
> ammonium salt.  All they have turned out to suffer from excessive 
> corrosion caused by that electrolyte, shortening the lifespan of those 
> parts well below the expectations even in the enhanced lines specifically 
> made with long life in mind.  Consequently those parts start leaking even 
> if unused (or indeed never used) and then obviously cause PSU breakage if 
> powered up.
> 
>  Those were all from reputable manufacturers, such as Chemi-con, Nichicon 
> or Panasonic; not to be confused with the bulged capacitor problem, aka 
> capacitor plague, which many ATX PSUs have suffered from mid 1990s to mid 
> 2000s where cheap parts were used from less reputable manufacturers.

Interesting!

> This is a DECstation 5000/2x0
> CPU0 revision is: 00000440 (R4400SC)
> FPU revision is: 00000500
> Checking for the multiply/shift bug... no.
> Checking for the daddiu bug... yes, workaround... yes.
> Determined physical RAM map:
>  memory: 0000000004000000 @ 0000000000000000 (usable)

Considering the amount of memory, how do compile for it?

Fredrik
