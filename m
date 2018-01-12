Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Jan 2018 14:24:54 +0100 (CET)
Received: from mail-qk0-x241.google.com ([IPv6:2607:f8b0:400d:c09::241]:38138
        "EHLO mail-qk0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994663AbeALNYqnYsyb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Jan 2018 14:24:46 +0100
Received: by mail-qk0-x241.google.com with SMTP id j185so8599664qkc.5
        for <linux-mips@linux-mips.org>; Fri, 12 Jan 2018 05:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Q/vx7J7gDEr+VgV0yaBX+mwbyOpWLFVox7YtrG0v3BI=;
        b=OAoVrSrkZBFlliMzf+H60v93UNFISNAiwGevL1ROr1L9btIXBcZEpfHjHCv6JlE41U
         Mw5ysDjgsGoJO6DLdWR7hzxlGn2enXTXnhRr86Uy6WNG9e3/hgb/LMRWNcVLiZW/mhw+
         tiVMaeHA+DzZ3mJSMBCGL4RWl3HX5i0naE3ojP1sMj76b8fTmmw6lMFMkTaoBOpYBAMD
         waf+tcm+HH6AoczPR8VKY8xPCqLoX48gVxHp9gwvT4cJvSqvkM7E6npQ+D9oatEtGZYq
         UcrrdINqURcWdAA0ufpik+mIrAO0vuPcMDEPHFyS1uZPW3TiZJm3yxoOn3xtR5dKKpM7
         LZCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q/vx7J7gDEr+VgV0yaBX+mwbyOpWLFVox7YtrG0v3BI=;
        b=syj7cjck0fF/pnj86djfb0BlwCACWGfE/pfuqPuAwhCqFw+jkJ1quCip1AL4lZvrjs
         Hw1K6gTR2z2KxtLxNHBiqr9bm6Mn/im04vpdjaQ+xt3mN00TDScRk6DWt7fLsYUqUYtf
         ScENJ18kn11U+3Ty2IjPF+7OiUsLznzD1y1S6OME4ZfHMNcIPaJi2e3/T3yJ3lZVuI10
         H63xQiT7U++Hy2FTuVa++dnIg+1cDpSthgjHX3zwohfGySj2NymUQrUoIjNteUPRKXB4
         70L87wvyUFSkvh433Jzzc5V7yvxfQZl/440sn/Wq8PkFi/chowsONepd/CYv0A0WheK1
         zZQA==
X-Gm-Message-State: AKwxytdjVvReGk8k6bk1uyREa28NxDiqC/kBdgDq/cLTjuh1XUHbuXFl
        LZWnk3QydAnVz+bLQkbC1z8=
X-Google-Smtp-Source: ACJfBovLxWkYG3YN+mE98hW/ImglyBtuq9sd+aThTnu+hcQQp0E1dQ9oHUKuR8Hq0eQ5rOHio5/KyQ==
X-Received: by 10.55.164.216 with SMTP id n207mr28268391qke.225.1515763480719;
        Fri, 12 Jan 2018 05:24:40 -0800 (PST)
Received: from localhost.localdomain (209-6-200-48.s4398.c3-0.smr-ubr2.sbo-smr.ma.cable.rcncustomer.com. [209.6.200.48])
        by smtp.gmail.com with ESMTPSA id z40sm13747554qtj.30.2018.01.12.05.24.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Jan 2018 05:24:39 -0800 (PST)
Date:   Fri, 12 Jan 2018 08:24:36 -0500
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
Subject: Re: [PATCH 03/22] ia64: rename swiotlb_dma_ops
Message-ID: <20180112132435.GC26900@localhost.localdomain>
References: <20180110080932.14157-1-hch@lst.de>
 <20180110080932.14157-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180110080932.14157-4-hch@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Return-Path: <konrad.r.wilk@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62100
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

On Wed, Jan 10, 2018 at 09:09:13AM +0100, Christoph Hellwig wrote:
> We'll need that name for a generic implementation soon.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>


Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> ---
>  arch/ia64/hp/common/hwsw_iommu.c | 4 ++--
>  arch/ia64/hp/common/sba_iommu.c  | 6 +++---
>  arch/ia64/kernel/pci-swiotlb.c   | 6 +++---
>  3 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/ia64/hp/common/hwsw_iommu.c b/arch/ia64/hp/common/hwsw_iommu.c
> index 63d8e1d2477f..41279f0442bd 100644
> --- a/arch/ia64/hp/common/hwsw_iommu.c
> +++ b/arch/ia64/hp/common/hwsw_iommu.c
> @@ -19,7 +19,7 @@
>  #include <linux/export.h>
>  #include <asm/machvec.h>
>  
> -extern const struct dma_map_ops sba_dma_ops, swiotlb_dma_ops;
> +extern const struct dma_map_ops sba_dma_ops, ia64_swiotlb_dma_ops;
>  
>  /* swiotlb declarations & definitions: */
>  extern int swiotlb_late_init_with_default_size (size_t size);
> @@ -38,7 +38,7 @@ static inline int use_swiotlb(struct device *dev)
>  const struct dma_map_ops *hwsw_dma_get_ops(struct device *dev)
>  {
>  	if (use_swiotlb(dev))
> -		return &swiotlb_dma_ops;
> +		return &ia64_swiotlb_dma_ops;
>  	return &sba_dma_ops;
>  }
>  EXPORT_SYMBOL(hwsw_dma_get_ops);
> diff --git a/arch/ia64/hp/common/sba_iommu.c b/arch/ia64/hp/common/sba_iommu.c
> index aec4a3354abe..8c0a9ae6afec 100644
> --- a/arch/ia64/hp/common/sba_iommu.c
> +++ b/arch/ia64/hp/common/sba_iommu.c
> @@ -2096,7 +2096,7 @@ static int __init acpi_sba_ioc_init_acpi(void)
>  /* This has to run before acpi_scan_init(). */
>  arch_initcall(acpi_sba_ioc_init_acpi);
>  
> -extern const struct dma_map_ops swiotlb_dma_ops;
> +extern const struct dma_map_ops ia64_swiotlb_dma_ops;
>  
>  static int __init
>  sba_init(void)
> @@ -2111,7 +2111,7 @@ sba_init(void)
>  	 * a successful kdump kernel boot is to use the swiotlb.
>  	 */
>  	if (is_kdump_kernel()) {
> -		dma_ops = &swiotlb_dma_ops;
> +		dma_ops = &ia64_swiotlb_dma_ops;
>  		if (swiotlb_late_init_with_default_size(64 * (1<<20)) != 0)
>  			panic("Unable to initialize software I/O TLB:"
>  				  " Try machvec=dig boot option");
> @@ -2133,7 +2133,7 @@ sba_init(void)
>  		 * If we didn't find something sba_iommu can claim, we
>  		 * need to setup the swiotlb and switch to the dig machvec.
>  		 */
> -		dma_ops = &swiotlb_dma_ops;
> +		dma_ops = &ia64_swiotlb_dma_ops;
>  		if (swiotlb_late_init_with_default_size(64 * (1<<20)) != 0)
>  			panic("Unable to find SBA IOMMU or initialize "
>  			      "software I/O TLB: Try machvec=dig boot option");
> diff --git a/arch/ia64/kernel/pci-swiotlb.c b/arch/ia64/kernel/pci-swiotlb.c
> index 5e50939aa03e..f1ae873a8c35 100644
> --- a/arch/ia64/kernel/pci-swiotlb.c
> +++ b/arch/ia64/kernel/pci-swiotlb.c
> @@ -31,7 +31,7 @@ static void ia64_swiotlb_free_coherent(struct device *dev, size_t size,
>  	swiotlb_free_coherent(dev, size, vaddr, dma_addr);
>  }
>  
> -const struct dma_map_ops swiotlb_dma_ops = {
> +const struct dma_map_ops ia64_swiotlb_dma_ops = {
>  	.alloc = ia64_swiotlb_alloc_coherent,
>  	.free = ia64_swiotlb_free_coherent,
>  	.map_page = swiotlb_map_page,
> @@ -48,7 +48,7 @@ const struct dma_map_ops swiotlb_dma_ops = {
>  
>  void __init swiotlb_dma_init(void)
>  {
> -	dma_ops = &swiotlb_dma_ops;
> +	dma_ops = &ia64_swiotlb_dma_ops;
>  	swiotlb_init(1);
>  }
>  
> @@ -60,7 +60,7 @@ void __init pci_swiotlb_init(void)
>  		printk(KERN_INFO "PCI-DMA: Re-initialize machine vector.\n");
>  		machvec_init("dig");
>  		swiotlb_init(1);
> -		dma_ops = &swiotlb_dma_ops;
> +		dma_ops = &ia64_swiotlb_dma_ops;
>  #else
>  		panic("Unable to find Intel IOMMU");
>  #endif
> -- 
> 2.14.2
> 
