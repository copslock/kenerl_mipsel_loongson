Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Jul 2004 20:30:58 +0100 (BST)
Received: from p508B6087.dip.t-dialin.net ([IPv6:::ffff:80.139.96.135]:5474
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225735AbUGMTax>; Tue, 13 Jul 2004 20:30:53 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i6DJTOik018348;
	Tue, 13 Jul 2004 21:29:24 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i6DJTNHD018347;
	Tue, 13 Jul 2004 21:29:23 +0200
Date: Tue, 13 Jul 2004 21:29:23 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Vadivelan Mani <daff_vadi@hotmail.com>
Cc: linux-mips@linux-mips.org
Subject: Re: pci_alloc_consistent() usage
Message-ID: <20040713192923.GA17250@linux-mips.org>
References: <BAY15-F223KfTpfpYea00005ca9@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BAY15-F223KfTpfpYea00005ca9@hotmail.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5464
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jul 13, 2004 at 06:31:01PM +0530, Vadivelan Mani wrote:

>   I'm writing a wireless driver which requires 8 transmit and 8 receive 
> buffers each of size 3KB approx.

I hope this device isn't really as simplistic as you make it sound ...

> These buffers should be in dma capable space.
> 
> I've allocated them using pci_alloc_consistent().
> 
> I've allocated 128KBytes just to make more space. I've got few doubts.
> 
>   1. Can pci_alloc_consistent() be used to allocate memory upto 128KBytes?

Yes.  For MIPS MAX_ORDER defaults to 11 so you even do alloc_page (which
is the underlying allocator of pci_alloc_consistent) upto 2^11 page that
is 8MB.  Downside - memory allocation is making such large allocations
unreliable; the more unreliable the larger the allocation.  In general
try to stick to allocations of order 0 that is PAGE_SIZE which atm is
4k on MIPS.  They're ok for permanent allocations such as rx/tx rings
which only happen rarely.

> 2.)   I would also like to know the exact use of this allocated space to 
> transmit or receive a packet.

pci_alloc_consistent() is meant to be used for permanent allocations
such as rx/tx rings.  It's not suitable for allocating skbufs; there are
other mechanisms available for that.

> During transmission i do the following. Plz correct me if i'm wrong because 
> i'm new to driver writing.
> 
> The device has a register which should be loaded with the transmit buffers 
> starting address.
> 
> I copy the packet coming from the Kernel in the form of sk_buff structure 
> into one of the transmit buffers that i've allocated using memcpy().

That's usually an idea only for very small packets.  pci_alloc_consistent
allocates uncached memory on a system withour hardware coherency so this
copy operation would be very slow.  In any case you should experiment to
find the breakeven point.

For larger packets you should use pci_map_single() in the start_xmit()
method of the driver, then pci_unmap_single() later when cleaning that is
typically in an interrupt handler.  Reception of packets would work
fairly similar.

> And i set the register in the device to initiate transmission of the packet.
> 
> Where does the dma transfer concept come in this?
> There is no mention of the direction of data transfer in 
> pci_alloc_consistent().

pci_alloc_consistent will allocate consistent memory that is it's suitable
for transfers in both directions.  On the typical MIPS processor which
doesn't maintain coherency in hardware this means it will return
uncached memory.  Obviously that will work for any direction of transfer.
But: uncached memory is slow - so avoid copying packets there.

> I also assumed that allocating buffer in dma capable space was itself 
> enough to start dma transfers.

No.  DMA capable space means some memory that can be accessed somehow by
a DMA engine.  You still have to tell the device to start the operation.

> Since i do not have the device now i'm not able to test the code. But i 
> would like to write the code before i get the device.

  Ralf
