Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Jan 2018 14:40:01 +0100 (CET)
Received: from mail-qt0-x242.google.com ([IPv6:2607:f8b0:400d:c0d::242]:45868
        "EHLO mail-qt0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994667AbeALNjxQRPin (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Jan 2018 14:39:53 +0100
Received: by mail-qt0-x242.google.com with SMTP id g10so6016847qtj.12
        for <linux-mips@linux-mips.org>; Fri, 12 Jan 2018 05:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F7priq2MEaSyMMZmuQVarmhLva+6mZO2OqCIRFGrftk=;
        b=JTmNuqaGGOWdtA+6Z7Vu07BH6I9plazPbQtCMedb9P5rxfnPykZspzCbJzE40hvxAL
         lu+UmZIWMd/74m/Ubs/r1FdRC2FLV5S0/17zo6avchy0SmS/almc1LjTCEwOHZaYGgdP
         yPzzAckoYQCQO8ffCNgDnzGzqBMFvBH4LcJxZ607mZ/El4yJOklxGm2569ttPfefl683
         sBOwFDXRJDrvCsgRE4NTa92Jik/LfTcb2HZFenoIMgx/87PNGJSApTn1Lnok3FtzTXK3
         HsNmHVDNZzWLPNG2bE8ZQZWKsA1mb7sOfQRBOP3LfpjZGFXg9FTRRbbCMr4hDuGd/zBN
         W6lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=F7priq2MEaSyMMZmuQVarmhLva+6mZO2OqCIRFGrftk=;
        b=HNlTe0CK8fg1WpUcmmPNZEDuC8zPpTTEpHKtdCQTAGjeyrzFBoqilxZFHPROWLY90l
         iaBxCpkeJYs+n5HoHbReSH4ht+maMnUgE9Ay/q1sLP7NBTSSLOTiOOVJ+qpj9bVrwX9D
         2QeDy3jdUMiqsZUbNa2eYeGgFmLCxjZz8JV4naK3+z93WkZ3jgMLmkocW6+Cdo0eKmj/
         rv6rIkUksMlMR/lu/kZ7wFbzNddjoURHLYNh0mb31eYIBenO+XB+62kUp0Lm5o42ql70
         a+aAx2d4BuWZAnF4kXUDyYX3DwBr1oUw7iW3EIVxcHx59i36s50ygXnM3gQgg+hdPhyo
         NrNw==
X-Gm-Message-State: AKwxytdo/KEgZOpTfWCJ8jIS9UmdC39C56CXf6HQimEMYRaicpMhmJVS
        ET1VsijrljhZiYOh8XKmau0=
X-Google-Smtp-Source: ACJfBouYXhE5BfvUBC2izv8g2+e6xD6r/deGN/OcgoKJaD+uRB3vymLNwfM4OZzrw2vZYmEgzandVw==
X-Received: by 10.200.18.131 with SMTP id y3mr38048923qti.95.1515764384517;
        Fri, 12 Jan 2018 05:39:44 -0800 (PST)
Received: from localhost.localdomain (209-6-200-48.s4398.c3-0.smr-ubr2.sbo-smr.ma.cable.rcncustomer.com. [209.6.200.48])
        by smtp.gmail.com with ESMTPSA id 92sm5879103qky.72.2018.01.12.05.39.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Jan 2018 05:39:43 -0800 (PST)
Date:   Fri, 12 Jan 2018 08:39:41 -0500
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
Subject: Re: [PATCH 06/22] swiotlb: rename swiotlb_free to swiotlb_exit
Message-ID: <20180112133939.GF26900@localhost.localdomain>
References: <20180110080932.14157-1-hch@lst.de>
 <20180110080932.14157-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180110080932.14157-7-hch@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Return-Path: <konrad.r.wilk@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62103
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

On Wed, Jan 10, 2018 at 09:09:16AM +0100, Christoph Hellwig wrote:

OK?

Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/powerpc/kernel/dma-swiotlb.c | 2 +-
>  arch/x86/kernel/pci-swiotlb.c     | 2 +-
>  include/linux/swiotlb.h           | 4 ++--
>  lib/swiotlb.c                     | 2 +-
>  4 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/dma-swiotlb.c b/arch/powerpc/kernel/dma-swiotlb.c
> index 506ac4fafac5..88f3963ca30f 100644
> --- a/arch/powerpc/kernel/dma-swiotlb.c
> +++ b/arch/powerpc/kernel/dma-swiotlb.c
> @@ -121,7 +121,7 @@ static int __init check_swiotlb_enabled(void)
>  	if (ppc_swiotlb_enable)
>  		swiotlb_print_info();
>  	else
> -		swiotlb_free();
> +		swiotlb_exit();
>  
>  	return 0;
>  }
> diff --git a/arch/x86/kernel/pci-swiotlb.c b/arch/x86/kernel/pci-swiotlb.c
> index 0d77603c2f50..0ee0f8f34251 100644
> --- a/arch/x86/kernel/pci-swiotlb.c
> +++ b/arch/x86/kernel/pci-swiotlb.c
> @@ -120,7 +120,7 @@ void __init pci_swiotlb_late_init(void)
>  {
>  	/* An IOMMU turned us off. */
>  	if (!swiotlb)
> -		swiotlb_free();
> +		swiotlb_exit();
>  	else {
>  		printk(KERN_INFO "PCI-DMA: "
>  		       "Using software bounce buffering for IO (SWIOTLB)\n");
> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> index 24ed817082ee..606375e35d87 100644
> --- a/include/linux/swiotlb.h
> +++ b/include/linux/swiotlb.h
> @@ -115,10 +115,10 @@ extern int
>  swiotlb_dma_supported(struct device *hwdev, u64 mask);
>  
>  #ifdef CONFIG_SWIOTLB
> -extern void __init swiotlb_free(void);
> +extern void __init swiotlb_exit(void);
>  unsigned int swiotlb_max_segment(void);
>  #else
> -static inline void swiotlb_free(void) { }
> +static inline void swiotlb_exit(void) { }
>  static inline unsigned int swiotlb_max_segment(void) { return 0; }
>  #endif
>  
> diff --git a/lib/swiotlb.c b/lib/swiotlb.c
> index 125c1062119f..cf5311908fa9 100644
> --- a/lib/swiotlb.c
> +++ b/lib/swiotlb.c
> @@ -417,7 +417,7 @@ swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
>  	return -ENOMEM;
>  }
>  
> -void __init swiotlb_free(void)
> +void __init swiotlb_exit(void)
>  {
>  	if (!io_tlb_orig_addr)
>  		return;
> -- 
> 2.14.2
> 
