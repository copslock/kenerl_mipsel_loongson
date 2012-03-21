Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Mar 2012 14:44:11 +0100 (CET)
Received: from mailout4.w1.samsung.com ([210.118.77.14]:28749 "EHLO
        mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903745Ab2CUNn6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Mar 2012 14:43:58 +0100
MIME-version: 1.0
Content-transfer-encoding: 7BIT
Content-type: text/plain; charset=us-ascii
Received: from euspt1 ([210.118.77.14]) by mailout4.w1.samsung.com
 (Sun Java(tm) System Messaging Server 6.3-8.04 (built Jul 29 2009; 32bit))
 with ESMTP id <0M1800DADM54OF90@mailout4.w1.samsung.com> for
 linux-mips@linux-mips.org; Wed, 21 Mar 2012 13:43:52 +0000 (GMT)
Received: from linux.samsung.com ([106.116.38.10])
 by spt1.w1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
 2004)) with ESMTPA id <0M18008O5M51Q1@spt1.w1.samsung.com> for
 linux-mips@linux-mips.org; Wed, 21 Mar 2012 13:43:50 +0000 (GMT)
Received: from AMDC159 (unknown [106.116.37.153])
        by linux.samsung.com (Postfix) with ESMTP id 94D2B270055; Wed,
 21 Mar 2012 14:43:57 +0100 (CET)
Date:   Wed, 21 Mar 2012 14:43:46 +0100
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Subject: RE: [GIT PULL] DMA-mapping framework updates for 3.4
In-reply-to: <1332228283-29077-1-git-send-email-m.szyprowski@samsung.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        'Linus Torvalds' <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        'Benjamin Herrenschmidt' <benh@kernel.crashing.org>,
        'Thomas Gleixner' <tglx@linutronix.de>,
        'Andrew Morton' <akpm@linux-foundation.org>,
        'Arnd Bergmann' <arnd@arndb.de>,
        'FUJITA Tomonori' <fujita.tomonori@lab.ntt.co.jp>,
        microblaze-uclinux@itee.uq.edu.au, linux-arch@vger.kernel.org,
        x86@kernel.org, linux-sh@vger.kernel.org,
        linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mips@linux-mips.org, discuss@x86-64.org,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linaro-mm-sig@lists.linaro.org, 'Jonathan Corbet' <corbet@lwn.net>,
        'Kyungmin Park' <kyungmin.park@samsung.com>,
        Andrzej Pietrasiewicz <andrzej.p@samsung.com>
Message-id: <079801cd0768$a3623d10$ea26b730$%szyprowski@samsung.com>
Organization: SPRC
X-Mailer: Microsoft Office Outlook 12.0
Content-language: pl
Thread-index: Ac0Gaoh/WBn+OB0fQva36xRWNNJUlQA5kGmQ
References: <1332228283-29077-1-git-send-email-m.szyprowski@samsung.com>
X-archive-position: 32734
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: m.szyprowski@samsung.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hello,

On Tuesday, March 20, 2012 8:25 AM Marek Szyprowski wrote:

> Hi Linus,
> 
> Please pull the dma-mapping framework updates for v3.4 since commit
> c16fa4f2ad19908a47c63d8fa436a1178438c7e7:
> 
>   Linux 3.3
> 
> with the top-most commit e749a9f707f1102735e02338fa564be86be3bb69
> 
>   common: DMA-mapping: add NON-CONSISTENT attribute
> 
> from the git repository at:
> 
>   git://git.infradead.org/users/kmpark/linux-samsung dma-mapping-next
> 
> Those patches introduce a new alloc method (with support for memory
> attributes) in dma_map_ops structure, which will later replace
> dma_alloc_coherent and dma_alloc_writecombine functions.
 
I've been pointed out that this summary is quite short and misses the main
rationale for the proposed changes.

A few limitations have been identified in the current dma-mapping design and 
its implementations for various architectures. There exist more than one function
for allocating and freeing the buffers: currently these 3 are used dma_{alloc,
free}_coherent, dma_{alloc,free}_writecombine, dma_{alloc,free}_noncoherent.

For most of the systems these calls are almost equivalent and can be interchanged.
For others, especially the truly non-coherent ones (like ARM), the difference can
be easily noticed in overall driver performance. Sadly not all architectures 
provide implementations for all of them, so the drivers might need to be adapted 
and cannot be easily shared between different architectures. The provided patches
unify all these functions and hide the differences under the already existing
dma attributes concept. The thread with more references is available here: 
http://www.spinics.net/lists/linux-sh/msg09777.html

These patches are also a prerequisite for unifying DMA-mapping implementation
on ARM architecture with the common one provided by dma_map_ops structure and 
extending it with IOMMU support. More information is available in the following 
thread: http://thread.gmane.org/gmane.linux.kernel.cross-arch/12819

More works on dma-mapping framework are planned, especially in the area of buffer
sharing and managing the shared mappings (together with the recently introduced 
dma_buf interface: commit d15bd7ee445d0702ad801fdaece348fdb79e6581 "dma-buf: 
Introduce dma buffer sharing mechanism" ).

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
