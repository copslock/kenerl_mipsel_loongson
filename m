Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Jan 2018 14:26:35 +0100 (CET)
Received: from mail-qk0-x243.google.com ([IPv6:2607:f8b0:400d:c09::243]:41845
        "EHLO mail-qk0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994665AbeALNZ5OavYn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Jan 2018 14:25:57 +0100
Received: by mail-qk0-x243.google.com with SMTP id a8so8586588qkb.8
        for <linux-mips@linux-mips.org>; Fri, 12 Jan 2018 05:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FJaS99H8e9TewZl2H7whPHQfiIBDBUwWwZXPhDaMDcY=;
        b=CrVztuvVcTDvjCqhun+JfDiW2roc3SffMYO1GXDvsSs9EOvMzWnp9CaSTRUhgFxgIm
         9bkcMvpfmni3kEPhiNfFVHFfSjFNylPWUCiOvAVcnBx8fl1AtQYB2qtILiFLsDWrZMmG
         I18KiQuwVRa4t+Kw64DIUMadgUa1Py7cVL+gNoFLtxIFxYC6/9rQXMBFtqHTkxsWS4jK
         aLPTY/amP6HvEXgJtgCP0n+sWhtAg7zGpAKODUjdVtCHfCY8fstg23hYRaa7PMOZPWDK
         MBU0So2UW16dobqIMhcnsA+OBcVEiKfmNmxEI4B0kOPiFM4FlEsAmAHdvgWg+amCZGq6
         pciQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=FJaS99H8e9TewZl2H7whPHQfiIBDBUwWwZXPhDaMDcY=;
        b=DbFjRWT6g2zYwebP6n7kSWRKdNO6suFBxcXJ2ipRYeamh774H1vwbpBYlVhPViUJBF
         h5MZyEfCJAVFi5g5p9clnjF32Y47D1qyexzQD+aofnQTw+kStDTj3FLUMpvcV++9ET39
         XQrLENPvcV3U8RARNLy/aZ4AlrroBopyt99wgLqWmb8tVRBVQ4u3sFNq7BgkemCsCNKO
         D/L9YKAg+ao0tUItXF9AxO2jFtKzJEqYcxF/g34mR7fY9YF/8qojieajsUN6qtw7UBoc
         8ArTQmTmynvXXDMKAyCQVx4XY9ENRoh4WsLHeJWjsVFg6QvZiCNCBYesT6i9GltOL8Bi
         WRwQ==
X-Gm-Message-State: AKwxyte/3hRS/MtdLODAjK3P4SGZ1WX0Zm6mBlWR8uNIcC5UYFqOafW/
        X+XUujHPQ4k6ZpefydlQ0rk=
X-Google-Smtp-Source: ACJfBou04TdE+FwkQRecTvLrJL8CzfiuHrOk/JlP0umkE4R4niE4xDCz8JjMZg/ch7d1yeNz+/PhWg==
X-Received: by 10.55.204.81 with SMTP id r78mr37008549qki.356.1515763538429;
        Fri, 12 Jan 2018 05:25:38 -0800 (PST)
Received: from localhost.localdomain (209-6-200-48.s4398.c3-0.smr-ubr2.sbo-smr.ma.cable.rcncustomer.com. [209.6.200.48])
        by smtp.gmail.com with ESMTPSA id v14sm2077024qkl.76.2018.01.12.05.25.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Jan 2018 05:25:38 -0800 (PST)
Date:   Fri, 12 Jan 2018 08:25:34 -0500
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
Subject: Re: [PATCH 05/22] x86: rename swiotlb_dma_ops
Message-ID: <20180112132534.GE26900@localhost.localdomain>
References: <20180110080932.14157-1-hch@lst.de>
 <20180110080932.14157-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180110080932.14157-6-hch@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Return-Path: <konrad.r.wilk@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62102
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

On Wed, Jan 10, 2018 at 09:09:15AM +0100, Christoph Hellwig wrote:
> We'll need that name for a generic implementation soon.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> ---
>  arch/x86/kernel/pci-swiotlb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/pci-swiotlb.c b/arch/x86/kernel/pci-swiotlb.c
> index 9d3e35c33d94..0d77603c2f50 100644
> --- a/arch/x86/kernel/pci-swiotlb.c
> +++ b/arch/x86/kernel/pci-swiotlb.c
> @@ -48,7 +48,7 @@ void x86_swiotlb_free_coherent(struct device *dev, size_t size,
>  		dma_generic_free_coherent(dev, size, vaddr, dma_addr, attrs);
>  }
>  
> -static const struct dma_map_ops swiotlb_dma_ops = {
> +static const struct dma_map_ops x86_swiotlb_dma_ops = {
>  	.mapping_error = swiotlb_dma_mapping_error,
>  	.alloc = x86_swiotlb_alloc_coherent,
>  	.free = x86_swiotlb_free_coherent,
> @@ -112,7 +112,7 @@ void __init pci_swiotlb_init(void)
>  {
>  	if (swiotlb) {
>  		swiotlb_init(0);
> -		dma_ops = &swiotlb_dma_ops;
> +		dma_ops = &x86_swiotlb_dma_ops;
>  	}
>  }
>  
> -- 
> 2.14.2
> 
