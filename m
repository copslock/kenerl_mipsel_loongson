Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBJJxJk15045
	for linux-mips-outgoing; Wed, 19 Dec 2001 11:59:19 -0800
Received: from idiom.com (espin@idiom.com [216.240.32.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBJJxFo15042
	for <linux-mips@oss.sgi.com>; Wed, 19 Dec 2001 11:59:15 -0800
Received: (from espin@localhost)
	by idiom.com (8.9.3/8.9.3) id KAA02726;
	Wed, 19 Dec 2001 10:56:33 -0800 (PST)
Date: Wed, 19 Dec 2001 10:56:33 -0800
From: Geoffrey Espin <espin@idiom.com>
To: James Simmons <jsimmons@transvirtual.com>
Cc: "Gleb O. Raiko" <raiko@niisi.msk.ru>, linux-mips@oss.sgi.com
Subject: Re: kmalloc/pci_alloc and skbuff's
Message-ID: <20011219105633.B54722@idiom.com>
References: <3C205853.EE642541@niisi.msk.ru> <Pine.LNX.4.10.10112190903520.3562-100000@www.transvirtual.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.1i
In-Reply-To: <Pine.LNX.4.10.10112190903520.3562-100000@www.transvirtual.com>; from James Simmons on Wed, Dec 19, 2001 at 09:09:11AM -0800
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


> > What's wrong with GFP_DMA ? Doesn't it solve exactly this problem ?
> Personally I don't like the hack but you have to ask what he needs.
> kmalloc grabs memory from the CPU cache. GFP_DMA insures that cache memory
> is continues. I think Geoffrey needs to use a specific memory address in 
> PCI space. Tho I like Geoffrey to try using GFP_DMA. The reason I don't
> like the hack is that skbuff's is bus independent. Not all ethernet cards
> are PCI based. Please try using GFP_DMA and let us know if it worked. 

Yes, I originally thought this was what addressed it.
Is "setting dma_mask" what is meant by "using GFP_DMA"?

The problem is drivers call dev_alloc_skb() which can allocate
memory anywhere in (my 32M) memory.

The PCI host controller part of the uPD98052 with its VR4120a core
(doc at http://www.idiom.com/~espin/nec/hwdoc/uPD98502-UM.pdf)
allows you to program a 4M window onto DRAM.  I use top 4M of 32M,
but it's arbitrary.  Then only this area can be transferred to
by/from the PCI devices.  So its not the PCI devices that is the
problem, but access to the host-side DRAM.

Currently, my private pci_alloc/free_consistent() routines manage
the 4M at top of memory (its not added to kernel with
add_memory_region() in prom.c).

With these hacks (including net/core/skbuff.c:alloc_skb->pci_alloc_consistent)
I've been successfully using the Tulip Ethernet (LinkSys) card (with no
changes to the driver).

Geoff
-- 
Geoffrey Espin
espin@idiom.com
