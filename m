Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Dec 2011 09:26:01 +0100 (CET)
Received: from mailout1.w1.samsung.com ([210.118.77.11]:57490 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903617Ab1L0IZr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Dec 2011 09:25:47 +0100
Received: from euspt1 (mailout1.w1.samsung.com [210.118.77.11])
 by mailout1.w1.samsung.com
 (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTP id <0LWU003OMSQQFV@mailout1.w1.samsung.com> for
 linux-mips@linux-mips.org; Tue, 27 Dec 2011 08:25:38 +0000 (GMT)
Received: from linux.samsung.com ([106.116.38.10])
 by spt1.w1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
 2004)) with ESMTPA id <0LWU00IWXSQQN9@spt1.w1.samsung.com> for
 linux-mips@linux-mips.org; Tue, 27 Dec 2011 08:25:38 +0000 (GMT)
Received: from AMDC159 (unknown [106.116.37.153])
        by linux.samsung.com (Postfix) with ESMTP id 36F9F27004A; Tue,
 27 Dec 2011 09:37:33 +0100 (CET)
Date:   Tue, 27 Dec 2011 09:25:25 +0100
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Subject: RE: [PATCH 00/14] DMA-mapping framework redesign preparation
In-reply-to: <20111223163516.GO20129@parisc-linux.org>
To:     'Matthew Wilcox' <matthew@wil.cx>
Cc:     linux-kernel@vger.kernel.org,
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
Message-id: <000901ccc471$15db8bc0$4192a340$%szyprowski@samsung.com>
Organization: SPRC
MIME-version: 1.0
X-Mailer: Microsoft Office Outlook 12.0
Content-type: text/plain; charset=us-ascii
Content-language: pl
Content-transfer-encoding: 7BIT
Thread-index: AczBkN6KMgxtoNoIReeb7jeu/nBm0QC3D65A
References: <1324643253-3024-1-git-send-email-m.szyprowski@samsung.com>
 <20111223163516.GO20129@parisc-linux.org>
X-archive-position: 32196
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: m.szyprowski@samsung.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 19857

Hello,

On Friday, December 23, 2011 5:35 PM Matthew Wilcox wrote:

> On Fri, Dec 23, 2011 at 01:27:19PM +0100, Marek Szyprowski wrote:
> > The first issue we identified is the fact that on some platform (again,
> > mainly ARM) there are several functions for allocating DMA buffers:
> > dma_alloc_coherent, dma_alloc_writecombine and dma_alloc_noncoherent
> 
> Is this write-combining from the point of view of the device (ie iommu),
> or from the point of view of the CPU, or both?

It is about write-combining from the CPU point of view. Right now there are
no devices with such advanced memory interface to do write combining on the
DMA side, but I believe that they might appear at some point in the future 
as well.

> > The next step in dma mapping framework update is the introduction of
> > dma_mmap/dma_mmap_attrs() function. There are a number of drivers
> > (mainly V4L2 and ALSA) that only exports the DMA buffers to user space.
> > Creating a userspace mapping with correct page attributes is not an easy
> > task for the driver. Also the DMA-mapping framework is the only place
> > where the complete information about the allocated pages is available,
> > especially if the implementation uses IOMMU controller to provide a
> > contiguous buffer in DMA address space which is scattered in physical
> > memory space.
> 
> Surely we only need a helper which drivrs can call from their mmap routine
> to solve this?

On ARM architecture it is already implemented this way and a bunch of drivers
use dma_mmap_coherent/dma_mmap_writecombine calls. We would like to standardize
these calls across all architectures.

> > Usually these drivers don't touch the buffer data at all, so the mapping
> > in kernel virtual address space is not needed. We can introduce
> > DMA_ATTRIB_NO_KERNEL_MAPPING attribute which lets kernel to skip/ignore
> > creation of kernel virtual mapping. This way we can save previous
> > vmalloc area and simply some mapping operation on a few architectures.
> 
> I really think this wants to be a separate function.  dma_alloc_coherent
> is for allocating memory to be shared between the kernel and a driver;
> we already have dma_map_sg for mapping userspace I/O as an alternative
> interface.  This feels like it's something different again rather than
> an option to dma_alloc_coherent.

That is just a starting point for the discussion. 

I thought about this API a bit and came to conclusion that there is no much
difference between a dma_alloc_coherent which creates a mapping in kernel
virtual space and the one that does not. It is just a hint from the driver
that it will not use that mapping at all. Of course this attribute makes sense
only together with adding a dma_mmap_attrs() call, because otherwise drivers
won't be able to get access to the buffer data.

On coherent architectures where dma_alloc_coherent is just a simple wrapper
around alloc_pages_exact() such attribute can be simply ignored without any
impact on the drivers (that's the main idea behind dma attributes!).
However such hint will help a lot on non-coherent architectures where 
additional work need to be done to provide a cohenent mapping in kernel 
address space. It also saves some precious kernel resources like vmalloc
address range.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
