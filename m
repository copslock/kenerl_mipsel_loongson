Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Dec 2011 18:53:37 +0100 (CET)
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:37254 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903627Ab1L0Rxa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Dec 2011 18:53:30 +0100
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 177948EE0E4;
        Tue, 27 Dec 2011 09:53:22 -0800 (PST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id faUfMhRSVqP9; Tue, 27 Dec 2011 09:53:21 -0800 (PST)
Received: from [192.168.10.225] (unknown [192.168.10.225])
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id E1E618EE081;
        Tue, 27 Dec 2011 09:53:15 -0800 (PST)
Subject: RE: [PATCH 00/14] DMA-mapping framework redesign preparation
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
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
In-Reply-To: <000901ccc471$15db8bc0$4192a340$%szyprowski@samsung.com>
References: <1324643253-3024-1-git-send-email-m.szyprowski@samsung.com>
         <20111223163516.GO20129@parisc-linux.org>
         <000901ccc471$15db8bc0$4192a340$%szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Date:   Tue, 27 Dec 2011 17:53:13 +0000
Message-ID: <1325008393.14252.5.camel@dabdike>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.1 
Content-Transfer-Encoding: 7bit
X-archive-position: 32197
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: James.Bottomley@HansenPartnership.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 20059

On Tue, 2011-12-27 at 09:25 +0100, Marek Szyprowski wrote:
[...]
> > > Usually these drivers don't touch the buffer data at all, so the mapping
> > > in kernel virtual address space is not needed. We can introduce
> > > DMA_ATTRIB_NO_KERNEL_MAPPING attribute which lets kernel to skip/ignore
> > > creation of kernel virtual mapping. This way we can save previous
> > > vmalloc area and simply some mapping operation on a few architectures.
> > 
> > I really think this wants to be a separate function.  dma_alloc_coherent
> > is for allocating memory to be shared between the kernel and a driver;
> > we already have dma_map_sg for mapping userspace I/O as an alternative
> > interface.  This feels like it's something different again rather than
> > an option to dma_alloc_coherent.
> 
> That is just a starting point for the discussion. 
> 
> I thought about this API a bit and came to conclusion that there is no much
> difference between a dma_alloc_coherent which creates a mapping in kernel
> virtual space and the one that does not. It is just a hint from the driver
> that it will not use that mapping at all. Of course this attribute makes sense
> only together with adding a dma_mmap_attrs() call, because otherwise drivers
> won't be able to get access to the buffer data.

This depends.  On Virtually indexed systems like PA-RISC, there are two
ways of making a DMA range coherent.  One is to make the range uncached.
This is incredibly slow and not what we do by default, but it can be
used to make multiple mappings coherent.  The other is to load the
virtual address up as a coherence index into the IOMMU.  This makes it a
full peer in the coherence process, but means we can only designate a
single virtual range to be coherent (not multiple mappings unless they
happen to be congruent).  Perhaps it doesn't matter that much, since I
don't see a use for this on PA, but if any other architecture works the
same, you'd have to designate a single mapping as the coherent one and
essentially promise not to use the other mapping if we followed our
normal coherence protocols.

Obviously, the usual range we currently make coherent is the kernel
mapping (that's actually the only virtual address we have by the time
we're deep in the iommu code), so designating a different virtual
address would need some surgery to the guts of the iommu code.

James
