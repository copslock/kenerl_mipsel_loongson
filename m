Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Dec 2011 17:35:27 +0100 (CET)
Received: from palinux.external.hp.com ([192.25.206.14]:37481 "EHLO
        mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903617Ab1LWQfW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Dec 2011 17:35:22 +0100
Received: by mail.parisc-linux.org (Postfix, from userid 26919)
        id 098C7494005; Fri, 23 Dec 2011 09:35:16 -0700 (MST)
Date:   Fri, 23 Dec 2011 09:35:16 -0700
From:   Matthew Wilcox <matthew@wil.cx>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        microblaze-uclinux@itee.uq.edu.au, linux-arch@vger.kernel.org,
        x86@kernel.org, linux-sh@vger.kernel.org,
        linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mips@linux-mips.org, discuss@x86-64.org,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linaro-mm-sig@lists.linaro.org, Jonathan Corbet <corbet@lwn.net>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Andrzej Pietrasiewicz <andrzej.p@samsung.com>
Subject: Re: [PATCH 00/14] DMA-mapping framework redesign preparation
Message-ID: <20111223163516.GO20129@parisc-linux.org>
References: <1324643253-3024-1-git-send-email-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1324643253-3024-1-git-send-email-m.szyprowski@samsung.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-archive-position: 32173
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matthew@wil.cx
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 18988

On Fri, Dec 23, 2011 at 01:27:19PM +0100, Marek Szyprowski wrote:
> The first issue we identified is the fact that on some platform (again,
> mainly ARM) there are several functions for allocating DMA buffers:
> dma_alloc_coherent, dma_alloc_writecombine and dma_alloc_noncoherent

Is this write-combining from the point of view of the device (ie iommu),
or from the point of view of the CPU, or both?

> The next step in dma mapping framework update is the introduction of
> dma_mmap/dma_mmap_attrs() function. There are a number of drivers
> (mainly V4L2 and ALSA) that only exports the DMA buffers to user space.
> Creating a userspace mapping with correct page attributes is not an easy
> task for the driver. Also the DMA-mapping framework is the only place
> where the complete information about the allocated pages is available,
> especially if the implementation uses IOMMU controller to provide a
> contiguous buffer in DMA address space which is scattered in physical
> memory space.

Surely we only need a helper which drivrs can call from their mmap routine to solve this?

> Usually these drivers don't touch the buffer data at all, so the mapping
> in kernel virtual address space is not needed. We can introduce
> DMA_ATTRIB_NO_KERNEL_MAPPING attribute which lets kernel to skip/ignore
> creation of kernel virtual mapping. This way we can save previous
> vmalloc area and simply some mapping operation on a few architectures.

I really think this wants to be a separate function.  dma_alloc_coherent
is for allocating memory to be shared between the kernel and a driver;
we already have dma_map_sg for mapping userspace I/O as an alternative
interface.  This feels like it's something different again rather than
an option to dma_alloc_coherent.

-- 
Matthew Wilcox				Intel Open Source Technology Centre
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
