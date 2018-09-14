Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Sep 2018 12:08:45 +0200 (CEST)
Received: from verein.lst.de ([213.95.11.211]:46772 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992066AbeINKIkWAclI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 14 Sep 2018 12:08:40 +0200
Received: by newverein.lst.de (Postfix, from userid 2407)
        id E4BEB68CFF; Fri, 14 Sep 2018 12:08:42 +0200 (CEST)
Date:   Fri, 14 Sep 2018 12:08:42 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     linux-mips@linux-mips.org, paul.burton@mips.com,
        robin.murphy@arm.com
Subject: Re: [PATCH, for-4.19] dma-mapping: add the missing
 ARCH_HAS_SYNC_DMA_FOR_CPU_ALL declaration
Message-ID: <20180914100842.GA23696@lst.de>
References: <20180911090049.10747-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180911090049.10747-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66257
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hch@lst.de
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

Aby chance to get a review for this?

On Tue, Sep 11, 2018 at 11:00:49AM +0200, Christoph Hellwig wrote:
> The patch adding the infrastructure failed to actually add the symbol
> declaration, oops..
> 
> Fixes: faef87723a ("dma-noncoherent: add a arch_sync_dma_for_cpu_all hook")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  kernel/dma/Kconfig | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
> index 9bd54304446f..1b1d63b3634b 100644
> --- a/kernel/dma/Kconfig
> +++ b/kernel/dma/Kconfig
> @@ -23,6 +23,9 @@ config ARCH_HAS_SYNC_DMA_FOR_CPU
>  	bool
>  	select NEED_DMA_MAP_STATE
>  
> +config ARCH_HAS_SYNC_DMA_FOR_CPU_ALL
> +	bool
> +
>  config DMA_DIRECT_OPS
>  	bool
>  	depends on HAS_DMA
> -- 
> 2.18.0
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
---end quoted text---
