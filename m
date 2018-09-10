Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Sep 2018 17:19:45 +0200 (CEST)
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35420 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994573AbeIJPTllGAbl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 10 Sep 2018 17:19:41 +0200
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9CB7B18A;
        Mon, 10 Sep 2018 08:19:33 -0700 (PDT)
Received: from [10.4.12.131] (e110467-lin.emea.arm.com [10.4.12.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 58D3D3F557;
        Mon, 10 Sep 2018 08:19:32 -0700 (PDT)
Subject: Re: [PATCH 2/5] dma-mapping: move the dma_coherent flag to struct
 device
To:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Paul Burton <paul.burton@mips.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
References: <20180910060533.27172-1-hch@lst.de>
 <20180910060533.27172-3-hch@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <71ec3eef-54c1-f692-5a17-4302c4dd4b05@arm.com>
Date:   Mon, 10 Sep 2018 16:19:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180910060533.27172-3-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Return-Path: <robin.murphy@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66185
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robin.murphy@arm.com
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

On 10/09/18 07:05, Christoph Hellwig wrote:
> Various architectures support both coherent and non-coherent dma on a
> per-device basis.  Move the dma_noncoherent flag from the mips archdata
> field to struct device proper to prepare the infrastructure for reuse on
> other architectures.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Paul Burton <paul.burton@mips.com>
> ---

[...]
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 8f882549edee..983506789402 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -927,6 +927,8 @@ struct dev_links_info {
>    * @offline:	Set after successful invocation of bus type's .offline().
>    * @of_node_reused: Set if the device-tree node is shared with an ancestor
>    *              device.
> + * @dma_coherent: this particular device is dma coherent, even if the
> + *		architecture supports non-coherent devices.
>    *
>    * At the lowest level, every device in a Linux system is represented by an
>    * instance of struct device. The device structure contains the information
> @@ -1016,6 +1018,11 @@ struct device {
>   	bool			offline_disabled:1;
>   	bool			offline:1;
>   	bool			of_node_reused:1;
> +#if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
> +    defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
> +    defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)

If we're likely to refer to it more than once, is it worth wrapping that 
condition up in something like ARCH_HAS_NONCOHERENT_DMA?

> +	bool			dma_coherent:1;
> +#endif
>   };
>   
>   static inline struct device *kobj_to_dev(struct kobject *kobj)
> diff --git a/include/linux/dma-noncoherent.h b/include/linux/dma-noncoherent.h
> index a0aa00cc909d..69630ec320be 100644
> --- a/include/linux/dma-noncoherent.h
> +++ b/include/linux/dma-noncoherent.h
> @@ -4,6 +4,22 @@
>   
>   #include <linux/dma-mapping.h>
>   
> +#ifdef CONFIG_ARCH_HAS_DMA_COHERENCE_H
> +#include <asm/dma-coherence.h>
> +#elif defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
> +	defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
> +	defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
> +static inline int dev_is_dma_coherent(struct device *dev)

Given that it's backed by a bool and used as a bool everywhere, this 
(and its equivalents) should probably return a bool ;)

> +{
> +	return dev->dma_coherent;
> +}
> +#else
> +static inline int dev_is_dma_coherent(struct device *dev)
> +{
> +	return true;
> +}
> +#endif /* CONFIG_ARCH_HAS_DMA_COHERENCE_H */
> +
>   void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
>   		gfp_t gfp, unsigned long attrs);
>   void arch_dma_free(struct device *dev, size_t size, void *cpu_addr,
> diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
> index 9bd54304446f..040859ac2a56 100644
> --- a/kernel/dma/Kconfig
> +++ b/kernel/dma/Kconfig
> @@ -13,6 +13,9 @@ config NEED_DMA_MAP_STATE
>   config ARCH_DMA_ADDR_T_64BIT
>   	def_bool 64BIT || PHYS_ADDR_T_64BIT
>   
> +config ARCH_HAS_DMA_COHERENCE_H
> +	bool

This seems a little crude - is it unbearably churny to make an 
asm-generic/dma-coherence.h implementation for everyone else?

Nits aside, this otherwise looks sane to me for factoring out the 
equivalent Xen and arm64 DMA ops cases.

Robin.

> +
>   config HAVE_GENERIC_DMA_COHERENT
>   	bool
>   
> 
