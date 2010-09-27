Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Sep 2010 07:30:55 +0200 (CEST)
Received: from sh.osrg.net ([192.16.179.4]:35700 "EHLO sh.osrg.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491041Ab0I0Faw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 27 Sep 2010 07:30:52 +0200
Received: from localhost (rose.osrg.net [10.76.0.1])
        by sh.osrg.net (8.14.3/8.14.3/OSRG-NET) with ESMTP id o8R5UjZE026935;
        Mon, 27 Sep 2010 14:30:45 +0900
Date:   Mon, 27 Sep 2010 14:30:45 +0900
To:     ddaney@caviumnetworks.com
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] MIPS: Convert DMA to use dma-mapping-common.h
From:   FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
In-Reply-To: <1285281496-24696-6-git-send-email-ddaney@caviumnetworks.com>
References: <1285281496-24696-1-git-send-email-ddaney@caviumnetworks.com>
        <1285281496-24696-6-git-send-email-ddaney@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20100927142628X.fujita.tomonori@lab.ntt.co.jp>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (sh.osrg.net [192.16.179.4]); Mon, 27 Sep 2010 14:30:46 +0900 (JST)
X-Virus-Scanned: clamav-milter 0.96.1 at sh
X-Virus-Status: Clean
X-archive-position: 27830
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fujita.tomonori@lab.ntt.co.jp
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 20861

On Thu, 23 Sep 2010 15:38:12 -0700
David Daney <ddaney@caviumnetworks.com> wrote:

> Use asm-generic/dma-mapping-common.h to handle all DMA mapping
> operations and establish a default get_dma_ops() that forwards all
> operations to the existing code.
> 
> Augment dev_archdata to carry a pointer to the struct dma_map_ops,
> allowing DMA operations to be overridden on a per device basis.
> Currently this is never filled in, so the default dma_map_ops are
> used.  A follow-on patch sets this for Octeon PCI devices.
> 
> Also initialize the dma_debug system as it is now used if it is
> configured.
> 
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> ---
>  arch/mips/Kconfig                   |    2 +
>  arch/mips/include/asm/device.h      |   15 +++-
>  arch/mips/include/asm/dma-mapping.h |  125 +++++++++++++++++--------
>  arch/mips/mm/dma-default.c          |  179 +++++++++++++---------------------
>  4 files changed, 172 insertions(+), 149 deletions(-)
> 
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 6c33709..e68b89f 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -14,6 +14,8 @@ config MIPS
>  	select HAVE_KRETPROBES
>  	select RTC_LIB if !MACH_LOONGSON
>  	select GENERIC_ATOMIC64 if !64BIT
> +	select HAVE_DMA_ATTRS
> +	select HAVE_DMA_API_DEBUG
>  
>  mainmenu "Linux/MIPS Kernel Configuration"
>  
> diff --git a/arch/mips/include/asm/device.h b/arch/mips/include/asm/device.h
> index 06746c5..65bf274 100644
> --- a/arch/mips/include/asm/device.h
> +++ b/arch/mips/include/asm/device.h
> @@ -3,4 +3,17 @@
>   *
>   * This file is released under the GPLv2
>   */
> -#include <asm-generic/device.h>
> +#ifndef _ASM_MIPS_DEVICE_H
> +#define _ASM_MIPS_DEVICE_H
> +
> +struct mips_dma_map_ops;
> +
> +struct dev_archdata {
> +	/* DMA operations on that device */
> +	struct mips_dma_map_ops	*dma_ops;
> +};
> +
> +struct pdev_archdata {
> +};
> +
> +#endif /* _ASM_MIPS_DEVICE_H*/
> diff --git a/arch/mips/include/asm/dma-mapping.h b/arch/mips/include/asm/dma-mapping.h
> index 18fbf7a..9a4c307 100644
> --- a/arch/mips/include/asm/dma-mapping.h
> +++ b/arch/mips/include/asm/dma-mapping.h
> @@ -5,51 +5,67 @@
>  #include <asm/cache.h>
>  #include <asm-generic/dma-coherent.h>
>  
> -void *dma_alloc_noncoherent(struct device *dev, size_t size,
> -			   dma_addr_t *dma_handle, gfp_t flag);
> +struct mips_dma_map_ops {
> +	struct dma_map_ops dma_map_ops;
> +	dma_addr_t (*phys_to_dma)(struct device *dev, phys_addr_t paddr);
> +	phys_addr_t (*dma_to_phys)(struct device *dev, dma_addr_t daddr);
> +};

The above code doesn't look great but we don't want to add phys_to_dma
and dma_to_phys to dma_map_ops struct, and these functions on MIPS
looks too complicated for ifdef. So I guess that we need to live with
the above code.
