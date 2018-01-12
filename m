Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Jan 2018 14:25:34 +0100 (CET)
Received: from mail-qk0-x244.google.com ([IPv6:2607:f8b0:400d:c09::244]:37330
        "EHLO mail-qk0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994663AbeALNZ0uxtKn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Jan 2018 14:25:26 +0100
Received: by mail-qk0-x244.google.com with SMTP id y80so2011331qkb.4
        for <linux-mips@linux-mips.org>; Fri, 12 Jan 2018 05:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/cyGSk+wtmyfQDABWc6RHWWbG69xGCVsYYyZsDPdKhY=;
        b=rRuTW0FdRhg1+Uh3KyJenS01FbYPrCikTeDRt5S2Vyv6QJJInvY7ZrXiXR7B9zSTWH
         KhiugIW1NQbM6bFGiOdkSzQfAYaodVVQ87tUnBHBOqZW4QQ0kuo9qC7JFREmzwhLZKLC
         /FcfeEJkZO6ftlys9DvZHklUWjc9kSVBN++6mpClifyWZHg4hDg+XT+8wuDkxXGqlr6M
         Qe5j+dOT7OKUecpyBOdMVmiBE8tVBPLIMVJ34h6ZUeXSY7NmynZHWEsUHs6dc5uaDv3B
         1Wi+CzQkrqxyXpcjmgSJJXVAC1ys7TO/h0+Mt5k8+ywl8Tykh1A54aCoOF9GCj+9xxTL
         9Flg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=/cyGSk+wtmyfQDABWc6RHWWbG69xGCVsYYyZsDPdKhY=;
        b=k9pb2ZF+EjGcgwJBRi6T0oT/avhY+xo89qfsaeH13GIsNJMK0spCDQ4Mda4prfx0E3
         9jNVJDfRyl4VS6jyLuhPbb2NGh73egvMpFn7apsDO5fTIq0IFfYM5H6trm3OSOwIPsZg
         lXgk3xOq8KsqQ/yPpx+tm/B/whZNAf7NzOme32SsjL3l/heVxo1jxaXXZJEwD3fsPNt7
         Ma4XC2mR2cSsa50/dlwIPMhiWyDNpkakuQWcr/yEBj9s7wgSjSVDNuAseSuneGAlJXLO
         p+h4gyUiQtHjZeNC6g3PS2E1qY3RUZRbXKCuw1yS/Wv+QMk04u7EfYWz5qmeUGsBdJnL
         U/qg==
X-Gm-Message-State: AKwxytd3bflOTp6GUzI2EGi64qN/SSqV00CzdmlhDfp+3hnO3oHLCWvO
        ufqVKfqNWepD/JVBGtpaKV0=
X-Google-Smtp-Source: ACJfBouk3vWdR/QVdwcmVsk86Avh+Neu4OLcm71KZ2LWfSHzENA3SP5X9sdazYG6SoZLxVDzEs89wA==
X-Received: by 10.55.160.14 with SMTP id j14mr18331444qke.305.1515763520849;
        Fri, 12 Jan 2018 05:25:20 -0800 (PST)
Received: from localhost.localdomain (209-6-200-48.s4398.c3-0.smr-ubr2.sbo-smr.ma.cable.rcncustomer.com. [209.6.200.48])
        by smtp.gmail.com with ESMTPSA id r9sm13654415qtf.82.2018.01.12.05.25.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Jan 2018 05:25:19 -0800 (PST)
Date:   Fri, 12 Jan 2018 08:25:17 -0500
From:   Konrad Rzeszutek Wilk <konrad@darnok.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org, Michal Simek <monstr@monstr.eu>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Christian =?iso-8859-1?Q?K=F6nig?= 
        <ckoenig.leichtzumerken@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        x86@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/22] powerpc: rename swiotlb_dma_ops
Message-ID: <20180112132516.GD26900@localhost.localdomain>
References: <20180110080932.14157-1-hch@lst.de>
 <20180110080932.14157-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180110080932.14157-5-hch@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Return-Path: <konrad.r.wilk@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62101
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: konrad@darnok.org
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

On Wed, Jan 10, 2018 at 09:09:14AM +0100, Christoph Hellwig wrote:
> We'll need that name for a generic implementation soon.
> 
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/powerpc/include/asm/swiotlb.h | 2 +-
>  arch/powerpc/kernel/dma-swiotlb.c  | 4 ++--
>  arch/powerpc/kernel/dma.c          | 2 +-
>  arch/powerpc/sysdev/fsl_pci.c      | 2 +-
>  4 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/swiotlb.h b/arch/powerpc/include/asm/swiotlb.h
> index 9341ee804d19..f65ecf57b66c 100644
> --- a/arch/powerpc/include/asm/swiotlb.h
> +++ b/arch/powerpc/include/asm/swiotlb.h
> @@ -13,7 +13,7 @@
>  
>  #include <linux/swiotlb.h>
>  
> -extern const struct dma_map_ops swiotlb_dma_ops;
> +extern const struct dma_map_ops powerpc_swiotlb_dma_ops;
>  
>  extern unsigned int ppc_swiotlb_enable;
>  int __init swiotlb_setup_bus_notifier(void);
> diff --git a/arch/powerpc/kernel/dma-swiotlb.c b/arch/powerpc/kernel/dma-swiotlb.c
> index f1e99b9cee97..506ac4fafac5 100644
> --- a/arch/powerpc/kernel/dma-swiotlb.c
> +++ b/arch/powerpc/kernel/dma-swiotlb.c
> @@ -46,7 +46,7 @@ static u64 swiotlb_powerpc_get_required(struct device *dev)
>   * map_page, and unmap_page on highmem, use normal dma_ops
>   * for everything else.
>   */
> -const struct dma_map_ops swiotlb_dma_ops = {
> +const struct dma_map_ops powerpc_swiotlb_dma_ops = {
>  	.alloc = __dma_nommu_alloc_coherent,
>  	.free = __dma_nommu_free_coherent,
>  	.mmap = dma_nommu_mmap_coherent,
> @@ -89,7 +89,7 @@ static int ppc_swiotlb_bus_notify(struct notifier_block *nb,
>  
>  	/* May need to bounce if the device can't address all of DRAM */
>  	if ((dma_get_mask(dev) + 1) < memblock_end_of_DRAM())
> -		set_dma_ops(dev, &swiotlb_dma_ops);
> +		set_dma_ops(dev, &powerpc_swiotlb_dma_ops);
>  
>  	return NOTIFY_DONE;
>  }
> diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
> index 76079841d3d0..da20569de9d4 100644
> --- a/arch/powerpc/kernel/dma.c
> +++ b/arch/powerpc/kernel/dma.c
> @@ -33,7 +33,7 @@ static u64 __maybe_unused get_pfn_limit(struct device *dev)
>  	struct dev_archdata __maybe_unused *sd = &dev->archdata;
>  
>  #ifdef CONFIG_SWIOTLB
> -	if (sd->max_direct_dma_addr && dev->dma_ops == &swiotlb_dma_ops)
> +	if (sd->max_direct_dma_addr && dev->dma_ops == &powerpc_swiotlb_dma_ops)
>  		pfn = min_t(u64, pfn, sd->max_direct_dma_addr >> PAGE_SHIFT);
>  #endif
>  
> diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
> index e4d0133bbeeb..61e07c78d64f 100644
> --- a/arch/powerpc/sysdev/fsl_pci.c
> +++ b/arch/powerpc/sysdev/fsl_pci.c
> @@ -118,7 +118,7 @@ static void setup_swiotlb_ops(struct pci_controller *hose)
>  {
>  	if (ppc_swiotlb_enable) {
>  		hose->controller_ops.dma_dev_setup = pci_dma_dev_setup_swiotlb;
> -		set_pci_dma_ops(&swiotlb_dma_ops);
> +		set_pci_dma_ops(&powerpc_swiotlb_dma_ops);
>  	}
>  }
>  #else
> -- 
> 2.14.2
> 
