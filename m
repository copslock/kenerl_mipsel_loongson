Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Aug 2013 19:04:49 +0200 (CEST)
Received: from mail-ie0-f172.google.com ([209.85.223.172]:43472 "EHLO
        mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6824926Ab3HLREiouym8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 Aug 2013 19:04:38 +0200
Received: by mail-ie0-f172.google.com with SMTP id 17so8751905iea.17
        for <linux-mips@linux-mips.org>; Mon, 12 Aug 2013 10:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=TbOfQyODWNhfJ2xfMFJ6s+g66Q5o1KN+FodD4TiaV5c=;
        b=MQS/Vz0Kd7DV5pEx2AeKy2YL5eyDffYDStz1WK888TYfnEj5IGgq7f2+RfZXEW04jA
         FPUfMcaDvQpjKbKLHPrwJNcUPLWB3cyKN0nUlNFVjjNkYfydmmQnkeU8eV3nWIf3Aqjt
         RRM4ZZEdIcHYvUaeVVL+OHCqu3nAC1cQb13b6BS/g0A18xhHwTkSldP28R+k60gZb1Cq
         7NTT+jiDqAeBc5zeCqmMpordYJC98+ACPsUOlF5pjjB+GFLz9Qat6d2O5AHSkyC9xqjh
         z01y/4HSfTiF+L0n1KaR/9DsRGcSwwfPfM0mfpGOX+346glEfGyF0U9FDaU/GBrrhGCo
         oKpA==
X-Received: by 10.43.147.196 with SMTP id kd4mr12641icc.98.1376327072176;
        Mon, 12 Aug 2013 10:04:32 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id pj4sm23706632igb.10.2013.08.12.10.04.30
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 12 Aug 2013 10:04:31 -0700 (PDT)
Message-ID: <5209159D.7040301@gmail.com>
Date:   Mon, 12 Aug 2013 10:04:29 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Felix Fietkau <nbd@openwrt.org>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH 1/2] MIPS: remove unnecessary platform dma helper functions
References: <1376306569-83278-1-git-send-email-nbd@openwrt.org>
In-Reply-To: <1376306569-83278-1-git-send-email-nbd@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37532
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

That's a mighty thin changelog there.

You are changing the semantics in the 
asm/mach-cavium-octeon/dma-coherence.h case.

Have you verified that all in-tree cases really are NOPs?

David Daney


On 08/12/2013 04:22 AM, Felix Fietkau wrote:
> Signed-off-by: Felix Fietkau <nbd@openwrt.org>
> ---
>   arch/mips/include/asm/mach-cavium-octeon/dma-coherence.h | 12 ------------
>   arch/mips/include/asm/mach-generic/dma-coherence.h       | 10 ----------
>   arch/mips/include/asm/mach-ip27/dma-coherence.h          | 10 ----------
>   arch/mips/include/asm/mach-ip32/dma-coherence.h          | 11 -----------
>   arch/mips/include/asm/mach-jazz/dma-coherence.h          | 10 ----------
>   arch/mips/include/asm/mach-loongson/dma-coherence.h      | 10 ----------
>   arch/mips/include/asm/mach-powertv/dma-coherence.h       | 10 ----------
>   arch/mips/mm/dma-default.c                               |  4 +---
>   8 files changed, 1 insertion(+), 76 deletions(-)
>
> diff --git a/arch/mips/include/asm/mach-cavium-octeon/dma-coherence.h b/arch/mips/include/asm/mach-cavium-octeon/dma-coherence.h
> index 47fb247..f9f4486 100644
> --- a/arch/mips/include/asm/mach-cavium-octeon/dma-coherence.h
> +++ b/arch/mips/include/asm/mach-cavium-octeon/dma-coherence.h
> @@ -52,23 +52,11 @@ static inline int plat_dma_supported(struct device *dev, u64 mask)
>   	return 0;
>   }
>
> -static inline void plat_extra_sync_for_device(struct device *dev)
> -{
> -	BUG();
> -}
> -
>   static inline int plat_device_is_coherent(struct device *dev)
>   {
>   	return 1;
>   }
>
> -static inline int plat_dma_mapping_error(struct device *dev,
> -					 dma_addr_t dma_addr)
> -{
> -	BUG();
> -	return 0;
> -}
> -
>   dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr);
>   phys_addr_t dma_to_phys(struct device *dev, dma_addr_t daddr);
>
> diff --git a/arch/mips/include/asm/mach-generic/dma-coherence.h b/arch/mips/include/asm/mach-generic/dma-coherence.h
> index 74cb992..a9e8f6b 100644
> --- a/arch/mips/include/asm/mach-generic/dma-coherence.h
> +++ b/arch/mips/include/asm/mach-generic/dma-coherence.h
> @@ -47,16 +47,6 @@ static inline int plat_dma_supported(struct device *dev, u64 mask)
>   	return 1;
>   }
>
> -static inline void plat_extra_sync_for_device(struct device *dev)
> -{
> -}
> -
> -static inline int plat_dma_mapping_error(struct device *dev,
> -					 dma_addr_t dma_addr)
> -{
> -	return 0;
> -}
> -
>   static inline int plat_device_is_coherent(struct device *dev)
>   {
>   #ifdef CONFIG_DMA_COHERENT
> diff --git a/arch/mips/include/asm/mach-ip27/dma-coherence.h b/arch/mips/include/asm/mach-ip27/dma-coherence.h
> index 06c4419..4ffddfd 100644
> --- a/arch/mips/include/asm/mach-ip27/dma-coherence.h
> +++ b/arch/mips/include/asm/mach-ip27/dma-coherence.h
> @@ -58,16 +58,6 @@ static inline int plat_dma_supported(struct device *dev, u64 mask)
>   	return 1;
>   }
>
> -static inline void plat_extra_sync_for_device(struct device *dev)
> -{
> -}
> -
> -static inline int plat_dma_mapping_error(struct device *dev,
> -					 dma_addr_t dma_addr)
> -{
> -	return 0;
> -}
> -
>   static inline int plat_device_is_coherent(struct device *dev)
>   {
>   	return 1;		/* IP27 non-cohernet mode is unsupported */
> diff --git a/arch/mips/include/asm/mach-ip32/dma-coherence.h b/arch/mips/include/asm/mach-ip32/dma-coherence.h
> index 073f0c4..104cfbc 100644
> --- a/arch/mips/include/asm/mach-ip32/dma-coherence.h
> +++ b/arch/mips/include/asm/mach-ip32/dma-coherence.h
> @@ -80,17 +80,6 @@ static inline int plat_dma_supported(struct device *dev, u64 mask)
>   	return 1;
>   }
>
> -static inline void plat_extra_sync_for_device(struct device *dev)
> -{
> -	return;
> -}
> -
> -static inline int plat_dma_mapping_error(struct device *dev,
> -					 dma_addr_t dma_addr)
> -{
> -	return 0;
> -}
> -
>   static inline int plat_device_is_coherent(struct device *dev)
>   {
>   	return 0;		/* IP32 is non-cohernet */
> diff --git a/arch/mips/include/asm/mach-jazz/dma-coherence.h b/arch/mips/include/asm/mach-jazz/dma-coherence.h
> index 9fc1e9a..949003e 100644
> --- a/arch/mips/include/asm/mach-jazz/dma-coherence.h
> +++ b/arch/mips/include/asm/mach-jazz/dma-coherence.h
> @@ -48,16 +48,6 @@ static inline int plat_dma_supported(struct device *dev, u64 mask)
>   	return 1;
>   }
>
> -static inline void plat_extra_sync_for_device(struct device *dev)
> -{
> -}
> -
> -static inline int plat_dma_mapping_error(struct device *dev,
> -					 dma_addr_t dma_addr)
> -{
> -	return 0;
> -}
> -
>   static inline int plat_device_is_coherent(struct device *dev)
>   {
>   	return 0;
> diff --git a/arch/mips/include/asm/mach-loongson/dma-coherence.h b/arch/mips/include/asm/mach-loongson/dma-coherence.h
> index e143305..aeb2c05 100644
> --- a/arch/mips/include/asm/mach-loongson/dma-coherence.h
> +++ b/arch/mips/include/asm/mach-loongson/dma-coherence.h
> @@ -53,16 +53,6 @@ static inline int plat_dma_supported(struct device *dev, u64 mask)
>   	return 1;
>   }
>
> -static inline void plat_extra_sync_for_device(struct device *dev)
> -{
> -}
> -
> -static inline int plat_dma_mapping_error(struct device *dev,
> -					 dma_addr_t dma_addr)
> -{
> -	return 0;
> -}
> -
>   static inline int plat_device_is_coherent(struct device *dev)
>   {
>   	return 0;
> diff --git a/arch/mips/include/asm/mach-powertv/dma-coherence.h b/arch/mips/include/asm/mach-powertv/dma-coherence.h
> index f831672..5d4c3fe 100644
> --- a/arch/mips/include/asm/mach-powertv/dma-coherence.h
> +++ b/arch/mips/include/asm/mach-powertv/dma-coherence.h
> @@ -99,16 +99,6 @@ static inline int plat_dma_supported(struct device *dev, u64 mask)
>   	return 1;
>   }
>
> -static inline void plat_extra_sync_for_device(struct device *dev)
> -{
> -}
> -
> -static inline int plat_dma_mapping_error(struct device *dev,
> -					 dma_addr_t dma_addr)
> -{
> -	return 0;
> -}
> -
>   static inline int plat_device_is_coherent(struct device *dev)
>   {
>   	return 0;
> diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
> index aaccf1c..63e45d6 100644
> --- a/arch/mips/mm/dma-default.c
> +++ b/arch/mips/mm/dma-default.c
> @@ -292,7 +292,6 @@ static void mips_dma_sync_single_for_cpu(struct device *dev,
>   static void mips_dma_sync_single_for_device(struct device *dev,
>   	dma_addr_t dma_handle, size_t size, enum dma_data_direction direction)
>   {
> -	plat_extra_sync_for_device(dev);
>   	if (!plat_device_is_coherent(dev))
>   		__dma_sync(dma_addr_to_page(dev, dma_handle),
>   			   dma_handle & ~PAGE_MASK, size, direction);
> @@ -326,7 +325,7 @@ static void mips_dma_sync_sg_for_device(struct device *dev,
>
>   int mips_dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
>   {
> -	return plat_dma_mapping_error(dev, dma_addr);
> +	return 0;
>   }
>
>   int mips_dma_supported(struct device *dev, u64 mask)
> @@ -339,7 +338,6 @@ void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
>   {
>   	BUG_ON(direction == DMA_NONE);
>
> -	plat_extra_sync_for_device(dev);
>   	if (!plat_device_is_coherent(dev))
>   		__dma_sync_virtual(vaddr, size, direction);
>   }
>
