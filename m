Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Oct 2017 10:59:36 +0200 (CEST)
Received: from smtp-out6.electric.net ([192.162.217.192]:54005 "EHLO
        smtp-out6.electric.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990482AbdJDI72lbBVX convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 4 Oct 2017 10:59:28 +0200
Received: from 1dzfWT-0003Go-U2 by out6a.electric.net with emc1-ok (Exim 4.87)
        (envelope-from <David.Laight@ACULAB.COM>)
        id 1dzfWV-0003XA-VM; Wed, 04 Oct 2017 01:59:23 -0700
Received: by emcmailer; Wed, 04 Oct 2017 01:59:23 -0700
Received: from [156.67.243.126] (helo=AcuExch.aculab.com)
        by out6a.electric.net with esmtps (TLSv1:AES128-SHA:128)
        (Exim 4.87)
        (envelope-from <David.Laight@ACULAB.COM>)
        id 1dzfWT-0003Go-U2; Wed, 04 Oct 2017 01:59:21 -0700
Received: from ACUEXCH.Aculab.com ([::1]) by AcuExch.aculab.com ([::1]) with
 mapi id 14.03.0123.003; Wed, 4 Oct 2017 09:59:24 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Christoph Hellwig' <hch@lst.de>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
CC:     Chris Zankel <chris@zankel.net>, Michal Simek <monstr@monstr.eu>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        "Max Filippov" <jcmvbkbc@gmail.com>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        "Robin Murphy" <robin.murphy@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: RE: [PATCH 04/11] ia64: make dma_cache_sync a no-op
Thread-Topic: [PATCH 04/11] ia64: make dma_cache_sync a no-op
Thread-Index: AQHTPDXADE7dOjrCr0uZ75iOyVOby6LTY46g
Date:   Wed, 4 Oct 2017 08:59:24 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DD0089626@AcuExch.aculab.com>
References: <20171003104311.10058-1-hch@lst.de>
 <20171003104311.10058-5-hch@lst.de>
In-Reply-To: <20171003104311.10058-5-hch@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.99.200]
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Outbound-IP: 156.67.243.126
X-Env-From: David.Laight@ACULAB.COM
X-Proto: esmtps
X-Revdns: 
X-HELO: AcuExch.aculab.com
X-TLS:  TLSv1:AES128-SHA:128
X-Authenticated_ID: 
X-PolicySMART: 3396946, 3397078
X-Virus-Status: Scanned by VirusSMART (c)
X-Virus-Status: Scanned by VirusSMART (s)
Return-Path: <David.Laight@ACULAB.COM>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60246
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: David.Laight@ACULAB.COM
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

From: Christoph Hellwig
> Sent: 03 October 2017 11:43
>
> ia64 does not implement DMA_ATTR_NON_CONSISTENT allocations, so it doesn't
> make any sense to do any work in dma_cache_sync given that it must be a
> no-op when dma_alloc_attrs returns coherent memory.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/ia64/include/asm/dma-mapping.h | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/arch/ia64/include/asm/dma-mapping.h b/arch/ia64/include/asm/dma-mapping.h
> index 3ce5ab4339f3..99dfc1aa9d3c 100644
> --- a/arch/ia64/include/asm/dma-mapping.h
> +++ b/arch/ia64/include/asm/dma-mapping.h
> @@ -48,11 +48,6 @@ static inline void
>  dma_cache_sync (struct device *dev, void *vaddr, size_t size,
>  	enum dma_data_direction dir)
>  {
> -	/*
> -	 * IA-64 is cache-coherent, so this is mostly a no-op.  However, we do need to
> -	 * ensure that dma_cache_sync() enforces order, hence the mb().
> -	 */
> -	mb();
>  }

Are you sure about this one?
It looks as though you are doing a mechanical change for all architectures.
Some of them are probably stranger than you realise.

Even with cache coherent memory any cpu 'store/write buffer' may not
be snooped by dma reads.

Something needs to flush the store buffer between the last cpu write
to the dma buffer and the write (probably a device register) that
tells the device it can read the memory.

My guess from the comment is that dma_cache_synch() is expected to
include that barrier - and it might not be anywhere else.

	David
