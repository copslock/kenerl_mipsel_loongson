Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBJKARL15408
	for linux-mips-outgoing; Wed, 19 Dec 2001 12:10:27 -0800
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBJKANo15405
	for <linux-mips@oss.sgi.com>; Wed, 19 Dec 2001 12:10:23 -0800
Received: from zeus.mvista.com (zeus.mvista.com [10.0.0.112])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id fBJJ8QB05718;
	Wed, 19 Dec 2001 11:08:26 -0800
Subject: Re: kmalloc/pci_alloc and skbuff's
From: Pete Popov <ppopov@mvista.com>
To: Geoffrey Espin <espin@idiom.com>
Cc: James Simmons <jsimmons@transvirtual.com>,
   "Gleb O. Raiko"
	 <raiko@niisi.msk.ru>, linux-mips <linux-mips@oss.sgi.com>
In-Reply-To: <20011219105633.B54722@idiom.com>
References: <3C205853.EE642541@niisi.msk.ru>
	<Pine.LNX.4.10.10112190903520.3562-100000@www.transvirtual.com> 
	<20011219105633.B54722@idiom.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 19 Dec 2001 11:12:25 -0800
Message-Id: <1008789145.31066.140.camel@zeus>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 2001-12-19 at 10:56, Geoffrey Espin wrote:
> 
> > > What's wrong with GFP_DMA ? Doesn't it solve exactly this problem ?
> > Personally I don't like the hack but you have to ask what he needs.
> > kmalloc grabs memory from the CPU cache. GFP_DMA insures that cache memory
> > is continues. I think Geoffrey needs to use a specific memory address in 
> > PCI space. Tho I like Geoffrey to try using GFP_DMA. The reason I don't
> > like the hack is that skbuff's is bus independent. Not all ethernet cards
> > are PCI based. Please try using GFP_DMA and let us know if it worked. 
> 
> Yes, I originally thought this was what addressed it.
> Is "setting dma_mask" what is meant by "using GFP_DMA"?
> 
> The problem is drivers call dev_alloc_skb() which can allocate
> memory anywhere in (my 32M) memory.
> 
> The PCI host controller part of the uPD98052 with its VR4120a core
> (doc at http://www.idiom.com/~espin/nec/hwdoc/uPD98502-UM.pdf)
> allows you to program a 4M window onto DRAM.  I use top 4M of 32M,
> but it's arbitrary.  Then only this area can be transferred to
> by/from the PCI devices.  So its not the PCI devices that is the
> problem, but access to the host-side DRAM.
> 
> Currently, my private pci_alloc/free_consistent() routines manage
> the 4M at top of memory (its not added to kernel with
> add_memory_region() in prom.c).
> 
> With these hacks (including net/core/skbuff.c:alloc_skb->pci_alloc_consistent)
> I've been successfully using the Tulip Ethernet (LinkSys) card (with no
> changes to the driver).

FYI, this is not an isolated issue. We deal with a number of
architectures and we've seen this problem with other arches and system
controllers as well. A 'generic' solution would be nice and probably
necessary at some point. 2.5 would be a good place to do it, if only
someone would volunteer ;-)

Pete
