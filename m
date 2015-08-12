Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Aug 2015 11:36:56 +0200 (CEST)
Received: from cassarossa.samfundet.no ([193.35.52.29]:50425 "EHLO
        cassarossa.samfundet.no" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011323AbbHLJgyZ2H4X (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Aug 2015 11:36:54 +0200
Received: from egtvedt by cassarossa.samfundet.no with local (Exim 4.80)
        (envelope-from <egtvedt@samfundet.no>)
        id 1ZPSSG-0006O7-1Y; Wed, 12 Aug 2015 11:36:16 +0200
Date:   Wed, 12 Aug 2015 11:36:16 +0200
From:   Hans-Christian Egtvedt <egtvedt@samfundet.no>
To:     Christoph Hellwig <hch@lst.de>
Cc:     torvalds@linux-foundation.org, axboe@kernel.dk,
        dan.j.williams@intel.com, vgupta@synopsys.com,
        hskinnemoen@gmail.com, realmz6@gmail.com, dhowells@redhat.com,
        monstr@monstr.eu, x86@kernel.org, dwmw2@infradead.org,
        alex.williamson@redhat.com, grundler@parisc-linux.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-nvdimm@ml01.01.org,
        linux-media@vger.kernel.org
Subject: Re: [PATCH 20/31] avr32: handle page-less SG entries
Message-ID: <20150812093615.GA16483@samfundet.no>
References: <1439363150-8661-1-git-send-email-hch@lst.de>
 <1439363150-8661-21-git-send-email-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1439363150-8661-21-git-send-email-hch@lst.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <egtvedt@samfundet.no>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48811
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: egtvedt@samfundet.no
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

Around Wed 12 Aug 2015 09:05:39 +0200 or thereabout, Christoph Hellwig wrote:
> Make all cache invalidation conditional on sg_has_page() and use
> sg_phys to get the physical address directly, bypassing the noop
> page_to_bus.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Hans-Christian Egtvedt <egtvedt@samfundet.no>

> ---
>  arch/avr32/include/asm/dma-mapping.h | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/avr32/include/asm/dma-mapping.h b/arch/avr32/include/asm/dma-mapping.h
> index ae7ac92..a662ce2 100644
> --- a/arch/avr32/include/asm/dma-mapping.h
> +++ b/arch/avr32/include/asm/dma-mapping.h
> @@ -216,11 +216,9 @@ dma_map_sg(struct device *dev, struct scatterlist *sglist, int nents,
>  	struct scatterlist *sg;
>  
>  	for_each_sg(sglist, sg, nents, i) {
> -		char *virt;
> -
> -		sg->dma_address = page_to_bus(sg_page(sg)) + sg->offset;
> -		virt = sg_virt(sg);
> -		dma_cache_sync(dev, virt, sg->length, direction);
> +		sg->dma_address = sg_phys(sg);
> +		if (sg_has_page(sg))
> +			dma_cache_sync(dev, sg_virt(sg), sg->length, direction);
>  	}
>  
>  	return nents;
> @@ -328,8 +326,10 @@ dma_sync_sg_for_device(struct device *dev, struct scatterlist *sglist,
>  	int i;
>  	struct scatterlist *sg;
>  
> -	for_each_sg(sglist, sg, nents, i)
> -		dma_cache_sync(dev, sg_virt(sg), sg->length, direction);
> +	for_each_sg(sglist, sg, nents, i) {
> +		if (sg_has_page(sg))
> +			dma_cache_sync(dev, sg_virt(sg), sg->length, direction);
> +	}
>  }
>  
>  /* Now for the API extensions over the pci_ one */
-- 
mvh
Hans-Christian Egtvedt
