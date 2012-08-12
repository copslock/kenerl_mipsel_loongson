Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 12 Aug 2012 08:18:18 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:59501 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1901166Ab2HLGSO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 12 Aug 2012 08:18:14 +0200
Message-ID: <50274A6B.30807@phrozen.org>
Date:   Sun, 12 Aug 2012 08:17:15 +0200
From:   John Crispin <john@phrozen.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.24) Gecko/20111114 Icedove/3.1.16
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: Re: [PATCH V5 09/18] MIPS: Loongson: Add swiotlb to support big memory
 (>4GB).
References: <1344677543-22591-1-git-send-email-chenhc@lemote.com> <1344677543-22591-10-git-send-email-chenhc@lemote.com>
In-Reply-To: <1344677543-22591-10-git-send-email-chenhc@lemote.com>
X-Enigmail-Version: 1.1.2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 34115
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>


> diff --git a/arch/mips/include/asm/mach-loongson/dma-coherence.h b/arch/mips/include/asm/mach-loongson/dma-coherence.h
> index e143305..b1dc286 100644
> --- a/arch/mips/include/asm/mach-loongson/dma-coherence.h
> +++ b/arch/mips/include/asm/mach-loongson/dma-coherence.h

[...]
>  static inline unsigned long plat_dma_addr_to_phys(struct device *dev,
>  	dma_addr_t dma_addr)
>  {
> -#if defined(CONFIG_CPU_LOONGSON2F) && defined(CONFIG_64BIT)
> +#if defined(CONFIG_64BIT)
> +#if defined(CONFIG_CPU_LOONGSON3)
> +	return (dma_addr < 0x90000000 && dma_addr >= 0x80000000) ?
> +			(dma_addr & 0x0fffffff) : dma_addr;
> +#elif defined(CONFIG_CPU_LOONGSON2F)
>  	return (dma_addr > 0x8fffffff) ? dma_addr : (dma_addr & 0x0fffffff);
> +#endif /* CONFIG_CPU_LOONGSON3 */
>  #else
>  	return dma_addr & 0x7fffffff;
> -#endif
> +#endif /* CONFIG_64BIT */
>  }

This will break if 64bit is defined and neither LOONGSON2F/3 are not
defined.
