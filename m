Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g77GafRw006685
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 7 Aug 2002 09:36:41 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g77Gaf0T006684
	for linux-mips-outgoing; Wed, 7 Aug 2002 09:36:41 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from ayrnetworks.com (64-166-72-141.ayrnetworks.com [64.166.72.141])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g77GaWRw006675;
	Wed, 7 Aug 2002 09:36:32 -0700
Received: (from wjhun@localhost)
	by  ayrnetworks.com (8.11.2/8.11.2) id g77GcSo06346;
	Wed, 7 Aug 2002 09:38:28 -0700
Date: Wed, 7 Aug 2002 09:38:28 -0700
From: William Jhun <wjhun@ayrnetworks.com>
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: Carsten Langgaard <carstenl@mips.com>,
   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, linux-mips@oss.sgi.com
Subject: Re: PCI patch of the day
Message-ID: <20020807093828.A6317@ayrnetworks.com>
References: <3D50D857.E2DDC84F@mips.com> <20020807120938.A13850@dea.linux-mips.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020807120938.A13850@dea.linux-mips.net>; from ralf@oss.sgi.com on Wed, Aug 07, 2002 at 12:09:38PM +0200
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ralf,

Will the *_dma_cache_wback() routines ever be implemented? I sent out a
set of patches a while ago that defaults them to calling _wback_inv()
instead of calling panic(). Additionally I sent out some PCI DMA
coherency patches that would, for pci_map_*():

- Invalidate if DMAing from the device
- Writeback if DMAing to the device
- Writeback/Invalidate if bidirectional

pci_dma_sync_*() was changed to simply invalidate if DMAing from the
device or bidirectional. Conceivably, the pci_unmap_*() should
invalidate as well, since the following could happen:

- pci_dma_sync_*()
- driver reads out of buffer
- DMA happens again
- pci_unmap_*()
- buffer cachelines better be invalidated!

Not to mention that the whole PCI DMA interface is inherently broken.
I've cogitated on this and sent patches to those responsible, but was
told to buzz off. The above is a good example of this broken-ness:
you'll have an extra invalidate for no reason if you never end up using
pci_dma_sync_*() but just simply map, DMA and unmap. Otherwise, it'll be
broken for the pci_dma_sync_*() case. And I've already went on before
about how streaming mappings are broken for PCI_DMA_TODEVICE when
re-using one buffer.

I've already spent a lot of time trying to sort this out and get the
patches right, but since I received almost zero response I dropped it.
Apparently it's still broken enough to need further attention.

Will

On Wed, Aug 07, 2002 at 12:09:38PM +0200, Ralf Baechle wrote:
> Sigh, yes.  The whole flushing thing was done improperly and the patches
> to fix that which I was integrating last night were not right either.  The
> big question for me is why nobody was complaining or is suddently everybody
> only using coherent machines ...
