Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Dec 2011 13:53:10 +0100 (CET)
Received: from mailout1.w1.samsung.com ([210.118.77.11]:28372 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903568Ab1L1MxC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Dec 2011 13:53:02 +0100
Received: from euspt1 (mailout1.w1.samsung.com [210.118.77.11])
 by mailout1.w1.samsung.com
 (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTP id <0LWW0097PZS5K1@mailout1.w1.samsung.com> for
 linux-mips@linux-mips.org; Wed, 28 Dec 2011 12:52:53 +0000 (GMT)
Received: from linux.samsung.com ([106.116.38.10])
 by spt1.w1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
 2004)) with ESMTPA id <0LWW002P1ZS4E9@spt1.w1.samsung.com> for
 linux-mips@linux-mips.org; Wed, 28 Dec 2011 12:52:53 +0000 (GMT)
Received: from AMDC159 (unknown [106.116.37.153])
        by linux.samsung.com (Postfix) with ESMTP id 7B41227004A; Wed,
 28 Dec 2011 14:04:54 +0100 (CET)
Date:   Wed, 28 Dec 2011 13:52:45 +0100
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Subject: RE: [PATCH 00/14] DMA-mapping framework redesign preparation
In-reply-to: <1325008393.14252.5.camel@dabdike>
To:     'James Bottomley' <James.Bottomley@HansenPartnership.com>
Cc:     'Matthew Wilcox' <matthew@wil.cx>, linux-kernel@vger.kernel.org,
        'Benjamin Herrenschmidt' <benh@kernel.crashing.org>,
        'Thomas Gleixner' <tglx@linutronix.de>,
        'Andrew Morton' <akpm@linux-foundation.org>,
        'Arnd Bergmann' <arnd@arndb.de>,
        'Stephen Rothwell' <sfr@canb.auug.org.au>,
        microblaze-uclinux@itee.uq.edu.au, linux-arch@vger.kernel.org,
        x86@kernel.org, linux-sh@vger.kernel.org,
        linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mips@linux-mips.org, discuss@x86-64.org,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linaro-mm-sig@lists.linaro.org, 'Jonathan Corbet' <corbet@lwn.net>,
        'Kyungmin Park' <kyungmin.park@samsung.com>,
        Andrzej Pietrasiewicz <andrzej.p@samsung.com>
Message-id: <003a01ccc55f$98dc6f50$ca954df0$%szyprowski@samsung.com>
Organization: SPRC
MIME-version: 1.0
X-Mailer: Microsoft Office Outlook 12.0
Content-type: text/plain; charset=UTF-8
Content-language: pl
Content-transfer-encoding: 7BIT
Thread-index: AczEwG5Jc0rEXHLyR72j2XGo7DHGOwAdkvRw
References: <1324643253-3024-1-git-send-email-m.szyprowski@samsung.com>
 <20111223163516.GO20129@parisc-linux.org>
 <000901ccc471$15db8bc0$4192a340$%szyprowski@samsung.com>
 <1325008393.14252.5.camel@dabdike>
X-archive-position: 32205
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: m.szyprowski@samsung.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 20380

Hello,

On Tuesday, December 27, 2011 6:53 PM James Bottomley wrote:

> On Tue, 2011-12-27 at 09:25 +0100, Marek Szyprowski wrote:
> [...]
> > > > Usually these drivers don't touch the buffer data at all, so the mapping
> > > > in kernel virtual address space is not needed. We can introduce
> > > > DMA_ATTRIB_NO_KERNEL_MAPPING attribute which lets kernel to skip/ignore
> > > > creation of kernel virtual mapping. This way we can save previous
> > > > vmalloc area and simply some mapping operation on a few architectures.
> > >
> > > I really think this wants to be a separate function.  dma_alloc_coherent
> > > is for allocating memory to be shared between the kernel and a driver;
> > > we already have dma_map_sg for mapping userspace I/O as an alternative
> > > interface.  This feels like it's something different again rather than
> > > an option to dma_alloc_coherent.
> >
> > That is just a starting point for the discussion.
> >
> > I thought about this API a bit and came to conclusion that there is no much
> > difference between a dma_alloc_coherent which creates a mapping in kernel
> > virtual space and the one that does not. It is just a hint from the driver
> > that it will not use that mapping at all. Of course this attribute makes sense
> > only together with adding a dma_mmap_attrs() call, because otherwise drivers
> > won't be able to get access to the buffer data.
> 
> This depends.  On Virtually indexed systems like PA-RISC, there are two
> ways of making a DMA range coherent.  One is to make the range uncached.
> This is incredibly slow and not what we do by default, but it can be
> used to make multiple mappings coherent.  The other is to load the
> virtual address up as a coherence index into the IOMMU.  This makes it a
> full peer in the coherence process, but means we can only designate a
> single virtual range to be coherent (not multiple mappings unless they
> happen to be congruent).  Perhaps it doesn't matter that much, since I
> don't see a use for this on PA, but if any other architecture works the
> same, you'd have to designate a single mapping as the coherent one and
> essentially promise not to use the other mapping if we followed our
> normal coherence protocols.
> 
> Obviously, the usual range we currently make coherent is the kernel
> mapping (that's actually the only virtual address we have by the time
> we're deep in the iommu code), so designating a different virtual
> address would need some surgery to the guts of the iommu code.

I see, in this case not much can be achieved by dropping the kernel
mapping for the allocated buffer. I'm also not sure how to mmap the buffer
into userspace meet the cpu requirements? Is it possible to use non-cached
mapping in userspace together with coherent mapping in kernel virtual
space?

However on some other architectures this attribute allows using HIGH_MEM
for the allocated coherent buffer. The other possibility is to allocate it
in chunks and map them contiguously into dma address space. With 
NO_KERNEL_MAPPING attribute we avoid consuming vmalloc range for the newly
allocated buffer for which we cannot use the linear mapping (because it is
scattered).

Of course this attribute will be implemented by the architectures where it
gives some benefits. All other can simply ignore it and return plain
coherent buffer with ordinary kernel virtual mapping. The driver will just
ignore it.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
