Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Feb 2012 11:43:08 +0100 (CET)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:46342 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1904262Ab2BMKnB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Feb 2012 11:43:01 +0100
Received: by bkcjk13 with SMTP id jk13so4941364bkc.36
        for <linux-mips@linux-mips.org>; Mon, 13 Feb 2012 02:42:55 -0800 (PST)
Received: by 10.204.133.219 with SMTP id g27mr6895244bkt.47.1329129772722;
        Mon, 13 Feb 2012 02:42:52 -0800 (PST)
Received: from [192.168.2.2] (ppp91-79-92-216.pppoe.mtu-net.ru. [91.79.92.216])
        by mx.google.com with ESMTPS id x20sm44878826bka.9.2012.02.13.02.42.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 13 Feb 2012 02:42:51 -0800 (PST)
Message-ID: <4F38E8E1.3070004@mvista.com>
Date:   Mon, 13 Feb 2012 14:41:37 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:10.0) Gecko/20120129 Thunderbird/10.0
MIME-Version: 1.0
To:     Marek Szyprowski <m.szyprowski@samsung.com>
CC:     linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
        microblaze-uclinux@itee.uq.edu.au, linux-arch@vger.kernel.org,
        x86@kernel.org, linux-sh@vger.kernel.org,
        linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mips@linux-mips.org, discuss@x86-64.org,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linaro-mm-sig@lists.linaro.org, Jonathan Corbet <corbet@lwn.net>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Andrzej Pietrasiewicz <andrzej.p@samsung.com>
Subject: Re: [PATCH 03/14 v2] MIPS: adapt for dma_map_ops changes
References: <1324643253-3024-4-git-send-email-m.szyprowski@samsung.com> <1329129329-25205-1-git-send-email-m.szyprowski@samsung.com>
In-Reply-To: <1329129329-25205-1-git-send-email-m.szyprowski@samsung.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQl/Rww8b5Z4OLdydnfAbPadgXRIbSl8B3mT4WtjQlmGw4ciU8XFBnPlsnSxACKIAC1qz+hk
X-archive-position: 32421
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hello.

On 13-02-2012 14:35, Marek Szyprowski wrote:

> From: Andrzej Pietrasiewicz<andrzej.p@samsung.com>

> Adapt core MIPS architecture code for dma_map_ops changes: replace
> alloc/free_coherent with generic alloc/free methods.

> Signed-off-by: Andrzej Pietrasiewicz<andrzej.p@samsung.com>
> [added missing changes to arch/mips/cavium-octeon/dma-octeon.c]
> Signed-off-by: Marek Szyprowski<m.szyprowski@samsung.com>
> Signed-off-by: Kyungmin Park<kyungmin.park@samsung.com>
[...]

> diff --git a/arch/mips/include/asm/dma-mapping.h b/arch/mips/include/asm/dma-mapping.h
> index 7aa37dd..cbd41f5 100644
> --- a/arch/mips/include/asm/dma-mapping.h
> +++ b/arch/mips/include/asm/dma-mapping.h
> @@ -57,25 +57,31 @@ dma_set_mask(struct device *dev, u64 mask)
>   extern void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
>   	       enum dma_data_direction direction);
>
> -static inline void *dma_alloc_coherent(struct device *dev, size_t size,
> -				       dma_addr_t *dma_handle, gfp_t gfp)
> +#define dma_alloc_coherent(d,s,h,f)	dma_alloc_attrs(d,s,h,f,NULL)
> +
> +static inline void *dma_alloc_attrs(struct device *dev, size_t size,
> +				    dma_addr_t *dma_handle, gfp_t gfp,
> +				    struct dma_attrs *attrs)
>   {
>   	void *ret;
>   	struct dma_map_ops *ops = get_dma_ops(dev);
>
> -	ret = ops->alloc_coherent(dev, size, dma_handle, gfp);
> +	ret = ops->alloc(dev, size, dma_handle, gfp, NULL);

    Not 'attrs' instead of NULL?

>
>   	debug_dma_alloc_coherent(dev, size, *dma_handle, ret);
>
>   	return ret;
>   }
>
> -static inline void dma_free_coherent(struct device *dev, size_t size,
> -				     void *vaddr, dma_addr_t dma_handle)
> +#define dma_free_coherent(d,s,c,h) dma_free_attrs(d,s,c,h,NULL)
> +
> +static inline void dma_free_attrs(struct device *dev, size_t size,
> +				  void *vaddr, dma_addr_t dma_handle,
> +				  struct dma_attrs *attrs)
>   {
>   	struct dma_map_ops *ops = get_dma_ops(dev);
>
> -	ops->free_coherent(dev, size, vaddr, dma_handle);
> +	ops->free(dev, size, vaddr, dma_handle, NULL);

    Same here...

WBR, Sergei
