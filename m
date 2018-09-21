Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Sep 2018 08:10:55 +0200 (CEST)
Received: from verein.lst.de ([213.95.11.211]:54093 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991532AbeIUGKviQ0vv (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 21 Sep 2018 08:10:51 +0200
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 6AAD968D80; Fri, 21 Sep 2018 08:10:52 +0200 (CEST)
Date:   Fri, 21 Sep 2018 08:10:52 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     linux-mips@linux-mips.org, paul.burton@mips.com
Cc:     robin.murphy@arm.com, iommu@lists.linux-foundation.org
Subject: Re: [PATCH, for-4.19] dma-mapping: add the missing
 ARCH_HAS_SYNC_DMA_FOR_CPU_ALL declaration
Message-ID: <20180921061052.GA13705@lst.de>
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
X-archive-position: 66475
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

Paul, other mips folks, any comments?

At this point I'm tempted to just move it to 4.20 and add a stable
tag given that no one cared so far.

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
