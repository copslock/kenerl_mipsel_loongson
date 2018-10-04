Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Oct 2018 22:09:24 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S23994608AbeJDUJOEsqze (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Oct 2018 22:09:14 +0200
Date:   Thu, 4 Oct 2018 21:09:14 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Fredrik Noring <noring@nocrew.org>
cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        =?UTF-8?Q?J=C3=BCrgen_Urban?= <JuergenUrban@gmx.de>
Subject: Re: [PATCH] TC: Set DMA masks for devices
In-Reply-To: <20181004165720.GA2361@sx-9>
Message-ID: <alpine.LFD.2.21.1810041916420.12089@eddie.linux-mips.org>
References: <alpine.LFD.2.21.1810030109210.5483@eddie.linux-mips.org> <20181004165720.GA2361@sx-9>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66696
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

Hi Fredrik,

> A complication with the PS2 OHCI is that DMA addresses 0-0x200000 map to
> 0x1c000000-0x1c200000 as seen by the kernel. Robin suggested that the mask
> might correspond to the effective addressing capability, which would be
> DMA_BIT_MASK(21),

 I take it you mean 0-0x1fffff obviously; let's be accurate in a technical 
discussion and avoid ambiguous cases.

 Well, the need to map between the CPU and the DMA address space is not 
uncommon.  As I recall the Galileo/Marvell GT-64xxx system controllers 
have a BAR for PCI master accesses to local DRAM (so that multiple such 
controllers can coexist in a NUMA system) and any non-identity mapping has 
to be taken into account with DMA of course

 And indeed e.g. `dma_map_single' does handle that and given a CPU-side 
physical memory address returns a corresponding DMA-side address.  And the 
DMA mask has to reflect that and describe the DMA side, as it's the device 
side that has an address space limitation here and any offset resulting 
from a non-identity mapping does not change that limitation, although the 
offset does have of course to be taken into account by `dma_map_single', 
etc. in determining whether the memory area requested for use by a DMA 
device can be used directly or whether a bounce buffer will be required 
for that mapping.

> but it does not seem to be entirely clear, since his
> commit message said that
> 
>     A somewhat similar line of reasoning also applies at the other end for
>     the mask check in dma_alloc_attrs() too - indeed, a device which cannot
>     access anything other than its own local memory probably *shouldn't*
>     have a valid mask for the general coherent DMA API.

 Well, how can such a device use the DMA API in the first place?  If the 
device has local memory, than the driver has to manage it itself somehow 
if needed, and then arrange copying it to main memory, either by a CPU or 
a third-party DMA controller (data mover) if available.  Of course in the 
latter case a driver for the DMA controller may have to use the DMA API.

 I'll be resubmitting a driver for such a device shortly, the DEFZA (the 
previous submission can be found here: 
<https://marc.info/?l=linux-netdev&m=139841853827404>).  It is interesting 
in that the FDDI engine supports host DMA on the reception side (and 
consequently the driver uses the DMA API to handle that), while on the 
transmission side (as well as with a couple of maintenance queues) it only 
does DMA with its onboard buffer memory, the contents of which need to be 
copied by the CPU.  So there's no use of the DMA API on the transmission 
or maintenance side.  However usual DMA rings (all located in board memory 
too) are used for all data moves.

 The DEFTA is a follow-up and an upgrade to the DEFZA, more integrated 
(the DEFZA uses a pair of PCBs while the DEFTA fits on one, of the size of 
each in the former pair), and with the extra silicon space gained it was 
possible to squeeze in circuitry required to do host DMA for all data 
moves, and also the DMA rings.

> A special circumstance here is the use of HCD_LOCAL_MEM that is a kind of
> DMA bounce buffer. Are you using anything similar with your DEFTA driver?

 The driver does need either an IOMMU or bounce buffers in system RAM in 
the case of 64-bit PCI systems, as the PFI PCI ASIC that the FDDI PDQ ASIC 
interfaces on the DEFPA does not AFAIK support 64-bit addressing (be it 
directly or with the use of DAC), although the PDQ itself does support 
48-bit addressing (i.e. DMA descriptor addresses hold bits 47:2 of host 
addresses), which would be sufficient for the usual cases.

 Not in the DEFTA (or for that matter DEFEA; possibly the only EISA device 
using the DMA API) case though, as the most equipped TURBOchannel systems, 
i.e. the DEC 3000 AXP models 500, 800 and 900 only support up to 1GiB of 
memory, which is well below the 34-bit addressing limit.

 The PDQ ASIC was used to interface FDDI to many host buses and in 
addition to the 3 bus attachments mentioned above, all of which we have 
support for in Linux, it was also used for Q-bus (the DEFQA) and FutureBus 
(the DEFAA).  We may have support for the DEFQA one day as I have both 
such a board and a suitable system to use it with.  We are unlikely to 
have support for the DEFAA, as FutureBus was only used in high-end VAX and 
Alpha systems, the size of a full 19" rack at the very least, but it is 
there I believe only that the full PDQ addressing capability was actually 
utilised.

 NB I sat on this fix from 2014, well before the warning was introduced in 
the first place, and it's only now that I got to unloading my patch queue. 
:(

  Maciej
