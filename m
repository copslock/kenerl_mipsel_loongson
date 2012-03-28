Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Mar 2012 08:10:58 +0200 (CEST)
Received: from mailout4.w1.samsung.com ([210.118.77.14]:51299 "EHLO
        mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903564Ab2C1GKv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Mar 2012 08:10:51 +0200
MIME-version: 1.0
Content-transfer-encoding: 7BIT
Content-type: text/plain; charset=us-ascii
Received: from euspt2 ([210.118.77.14]) by mailout4.w1.samsung.com
 (Sun Java(tm) System Messaging Server 6.3-8.04 (built Jul 29 2009; 32bit))
 with ESMTP id <0M1K00G7QZTXVU10@mailout4.w1.samsung.com> for
 linux-mips@linux-mips.org; Wed, 28 Mar 2012 07:10:45 +0100 (BST)
Received: from linux.samsung.com ([106.116.38.10])
 by spt2.w1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
 2004)) with ESMTPA id <0M1K002VYZTSZH@spt2.w1.samsung.com> for
 linux-mips@linux-mips.org; Wed, 28 Mar 2012 07:10:41 +0100 (BST)
Received: from AMDC159 (unknown [106.116.37.153])
        by linux.samsung.com (Postfix) with ESMTP id CAA2427004B; Wed,
 28 Mar 2012 08:13:50 +0200 (CEST)
Date:   Wed, 28 Mar 2012 08:10:20 +0200
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Subject: RE: [PATCHv2 09/14] Unicore32: adapt for dma_map_ops changes
In-reply-to: <4F7275FE.8000100@mprc.pku.edu.cn>
To:     'Guan Xuetao' <gxt@mprc.pku.edu.cn>
Cc:     linux-kernel@vger.kernel.org,
        'Benjamin Herrenschmidt' <benh@kernel.crashing.org>,
        'Thomas Gleixner' <tglx@linutronix.de>,
        'Andrew Morton' <akpm@linux-foundation.org>,
        'Arnd Bergmann' <arnd@arndb.de>,
        'Stephen Rothwell' <sfr@canb.auug.org.au>,
        'FUJITA Tomonori' <fujita.tomonori@lab.ntt.co.jp>,
        microblaze-uclinux@itee.uq.edu.au, linux-arch@vger.kernel.org,
        x86@kernel.org, linux-sh@vger.kernel.org,
        linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mips@linux-mips.org, discuss@x86-64.org,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linaro-mm-sig@lists.linaro.org, 'Jonathan Corbet' <corbet@lwn.net>,
        'Kyungmin Park' <kyungmin.park@samsung.com>,
        Andrzej Pietrasiewicz <andrzej.p@samsung.com>,
        'Kevin Cernekee' <cernekee@gmail.com>,
        'Dezhong Diao' <dediao@cisco.com>,
        'Richard Kuo' <rkuo@codeaurora.org>,
        "'David S. Miller'" <davem@davemloft.net>,
        'Michal Simek' <monstr@monstr.eu>,
        'Paul Mundt' <lethal@linux-sh.org>,
        'Richard Henderson' <rth@twiddle.net>,
        'Ivan Kokshaysky' <ink@jurassic.park.msu.ru>,
        'Matt Turner' <mattst88@gmail.com>,
        'Tony Luck' <tony.luck@intel.com>,
        'Fenghua Yu' <fenghua.yu@intel.com>
Message-id: <00ac01cd0ca9$7508f4e0$5f1adea0$%szyprowski@samsung.com>
Organization: SPRC
X-Mailer: Microsoft Office Outlook 12.0
Content-language: pl
Thread-index: Ac0MjBftzrBY64NAQOqZW8vvTBNuSQAGmQ1Q
References: <1332855768-32583-1-git-send-email-m.szyprowski@samsung.com>
 <1332855768-32583-10-git-send-email-m.szyprowski@samsung.com>
 <4F7275FE.8000100@mprc.pku.edu.cn>
X-archive-position: 32801
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: m.szyprowski@samsung.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hello,

On Wednesday, March 28, 2012 4:23 AM Guan Xuetao wrote:

> On 03/27/2012 09:42 PM, Marek Szyprowski wrote:
> > diff --git a/arch/unicore32/mm/dma-swiotlb.c b/arch/unicore32/mm/dma-swiotlb.c
> > index bfa9fbb..4cf5f0c 100644
> > --- a/arch/unicore32/mm/dma-swiotlb.c
> > +++ b/arch/unicore32/mm/dma-swiotlb.c
> > @@ -17,9 +17,23 @@
> >
> >   #include<asm/dma.h>
> >
> > +static void *unicore_swiotlb_alloc_coherent(struct device *dev, size_t size,
> > +					    dma_addr_t *dma_handle, gfp_t flags,
> > +					    struct dma_attrs *attrs)
> > +{
> > +	return swiotlb_alloc_coherent(dev, size, dma_handle, flags);
> > +}
> > +
> > +static void unicode_swiotlb_free_coherent(struct device *dev, size_t size,
> The bit is ok for me. Only a typo here, please change unicode to unicore.

Ups, I'm sorry for that typo. I've fixed it on my git tree:

http://git.linaro.org/gitweb?p=people/mszyprowski/linux-dma-mapping.git;a=commitdiff;h=bbe43c05b0653
9c09f89e07bcaf61ea0fca8d67f

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
