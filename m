Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Jan 2018 14:17:51 +0100 (CET)
Received: from mail-qt0-x243.google.com ([IPv6:2607:f8b0:400d:c0d::243]:37475
        "EHLO mail-qt0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994664AbeALNRl2vlCd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Jan 2018 14:17:41 +0100
Received: by mail-qt0-x243.google.com with SMTP id f2so5950335qtj.4
        for <linux-mips@linux-mips.org>; Fri, 12 Jan 2018 05:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZKgdw1gemyM4jVL0TF+CFek9N9fcJbbl2Efz/YxINC4=;
        b=fSpmkAEkD8xg4xgKtRJCorbBB+68j+aJoIgJRQ09IGUZYKfASFEt8lSrEzV6hdIxTx
         cWsNLkw5nIKksPnuUGnfH1MlcL9BAYBxlO4mbu63QQWXHpCpe5uf9o5D59OgNNVuoI+0
         RMOkAo17Ndd8lkYYYpntDRi9KBEL6cvh44X7sYIY7qJNci9XWsPTLYzYsAQmj4+ATfma
         Bph4vBOT91DamI83b4SUDrEGIruAF3LocuxRnxqbqpSQYQ0/F1myEmKjxkFAru8vj4LP
         5gP89HIFBEmjcOaUh2mAGZ7OlpzkWdvmPLUo4SlYvFHUFqTZiSJfnGyJ2/9ZqW1UOOJn
         jf7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZKgdw1gemyM4jVL0TF+CFek9N9fcJbbl2Efz/YxINC4=;
        b=lFHvFKNqSRnvrGbiV/02/Zq6BFJ9rZSjHnXqj8ATvBS4ni2uOiHiMH3K3O/1Cw05jB
         qLIZZIdraCZWxPi4i0+AhCARnxFOCI8BRbPoYtfIsd97rCICwfQ+Vv11KwzSw5Fl4HFW
         YQpG/J5zRC+Py47/IUaR6JN2Uqdlqh3Mj+T6qXX9QDQ3JM2dLBfWK0KokAj/olTdrIu0
         t0B9lzA7N3grfKTx5VCdU5Z0/c3m20DPUbj+O3XgfBrdL/Bbf84b6C6zh63y+yVnJClk
         ke94I+NR6uOxjIs2jbqnePQhswM22I+Jyj6pgL7SG7AUNMK4mIc5wEGDF/+TIBv/RRfL
         W+KA==
X-Gm-Message-State: AKwxytfHJRUxWYhqHOolJ+D5Qo9+sEyxcJ+TvgLC8fxESjeQxAC8FiyH
        fFEZvmKz7xquS0SPj2Ob580=
X-Google-Smtp-Source: ACJfBovpq6hn2yLEjgZBIULSluqz60LKXnsWF0VIZzSl8AlATmyA3zQbFj6D8xo0I0zDJoj95FpGnQ==
X-Received: by 10.200.64.90 with SMTP id j26mr17290939qtl.29.1515763052969;
        Fri, 12 Jan 2018 05:17:32 -0800 (PST)
Received: from localhost.localdomain (209-6-200-48.s4398.c3-0.smr-ubr2.sbo-smr.ma.cable.rcncustomer.com. [209.6.200.48])
        by smtp.gmail.com with ESMTPSA id q12sm13737527qtk.32.2018.01.12.05.17.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Jan 2018 05:17:32 -0800 (PST)
Date:   Fri, 12 Jan 2018 08:17:28 -0500
From:   Konrad Rzeszutek Wilk <konrad@darnok.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org, linux-alpha@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        linux-cris-kernel@axis.com, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-metag@vger.kernel.org, Michal Simek <monstr@monstr.eu>,
        linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, patches@groups.riscv.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>,
        x86@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 21/33] dma-mapping: add an arch_dma_supported hook
Message-ID: <20180112131727.GB26900@localhost.localdomain>
References: <20180110080027.13879-1-hch@lst.de>
 <20180110080027.13879-22-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180110080027.13879-22-hch@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Return-Path: <konrad.r.wilk@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62099
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

On Wed, Jan 10, 2018 at 09:00:15AM +0100, Christoph Hellwig wrote:
> To implement the x86 forbid_dac and iommu_sac_force we want an arch hook
> so that it can apply the global options across all dma_map_ops
> implementations.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> ---
>  arch/x86/include/asm/dma-mapping.h |  3 +++
>  arch/x86/kernel/pci-dma.c          | 19 ++++++++++++-------
>  include/linux/dma-mapping.h        | 11 +++++++++++
>  3 files changed, 26 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/include/asm/dma-mapping.h b/arch/x86/include/asm/dma-mapping.h
> index dfdc9357a349..6277c83c0eb1 100644
> --- a/arch/x86/include/asm/dma-mapping.h
> +++ b/arch/x86/include/asm/dma-mapping.h
> @@ -30,6 +30,9 @@ static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
>  	return dma_ops;
>  }
>  
> +int arch_dma_supported(struct device *dev, u64 mask);
> +#define arch_dma_supported arch_dma_supported
> +
>  bool arch_dma_alloc_attrs(struct device **dev, gfp_t *gfp);
>  #define arch_dma_alloc_attrs arch_dma_alloc_attrs
>  
> diff --git a/arch/x86/kernel/pci-dma.c b/arch/x86/kernel/pci-dma.c
> index 61a8f1cb3829..df7ab02f959f 100644
> --- a/arch/x86/kernel/pci-dma.c
> +++ b/arch/x86/kernel/pci-dma.c
> @@ -215,7 +215,7 @@ static __init int iommu_setup(char *p)
>  }
>  early_param("iommu", iommu_setup);
>  
> -int x86_dma_supported(struct device *dev, u64 mask)
> +int arch_dma_supported(struct device *dev, u64 mask)
>  {
>  #ifdef CONFIG_PCI
>  	if (mask > 0xffffffff && forbid_dac > 0) {
> @@ -224,12 +224,6 @@ int x86_dma_supported(struct device *dev, u64 mask)
>  	}
>  #endif
>  
> -	/* Copied from i386. Doesn't make much sense, because it will
> -	   only work for pci_alloc_coherent.
> -	   The caller just has to use GFP_DMA in this case. */
> -	if (mask < DMA_BIT_MASK(24))
> -		return 0;
> -
>  	/* Tell the device to use SAC when IOMMU force is on.  This
>  	   allows the driver to use cheaper accesses in some cases.
>  
> @@ -249,6 +243,17 @@ int x86_dma_supported(struct device *dev, u64 mask)
>  
>  	return 1;
>  }
> +EXPORT_SYMBOL(arch_dma_supported);
> +
> +int x86_dma_supported(struct device *dev, u64 mask)
> +{
> +	/* Copied from i386. Doesn't make much sense, because it will
> +	   only work for pci_alloc_coherent.
> +	   The caller just has to use GFP_DMA in this case. */
> +	if (mask < DMA_BIT_MASK(24))
> +		return 0;
> +	return 1;
> +}
>  
>  static int __init pci_iommu_init(void)
>  {
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index 88bcb1a8211d..d67742dad904 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -576,6 +576,14 @@ static inline int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
>  	return 0;
>  }
>  
> +/*
> + * This is a hack for the legacy x86 forbid_dac and iommu_sac_force. Please
> + * don't use this is new code.
> + */
> +#ifndef arch_dma_supported
> +#define arch_dma_supported(dev, mask)	(1)
> +#endif
> +
>  static inline void dma_check_mask(struct device *dev, u64 mask)
>  {
>  	if (sme_active() && (mask < (((u64)sme_get_me_mask() << 1) - 1)))
> @@ -588,6 +596,9 @@ static inline int dma_supported(struct device *dev, u64 mask)
>  
>  	if (!ops)
>  		return 0;
> +	if (!arch_dma_supported(dev, mask))
> +		return 0;
> +
>  	if (!ops->dma_supported)
>  		return 1;
>  	return ops->dma_supported(dev, mask);
> -- 
> 2.14.2
> 
