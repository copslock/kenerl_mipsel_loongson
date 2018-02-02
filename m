Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Feb 2018 18:47:57 +0100 (CET)
Received: from merlin.infradead.org ([IPv6:2001:8b0:10b:1231::1]:59226 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991025AbeBBRrsUAdj7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Feb 2018 18:47:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=wOahYfPH3eqAbGWl///EiVWN8yzu/m5QdifGTHB8Dgc=; b=bWdqdLJiICz/HhEQHmVEEI9V5I
        b2NnwYz3+AT9i6+gB90OLvygXVj+ETZUSoe4TY2NtRL1Ou2id6xAZwEf3UpLgaU44Cpx7JjjkQUP3
        etDxjgstCKm66c3EY/JUQ8XY6Ivaeunqcb+BTwgb8tSrTnTqiOFnsiZlhrFRMwrqTP3Kl+2Qc44Ou
        TEJzNs5IBKctMdwM4eoAEUgV1xZQG08+UMNH/3LlgcjU/Ui7UJL72bQSYxJbnr0VBvgxF0AsSfrsx
        MZiu506SOcRAg/Z80PEz4X36xfUD/2XBHdrL18WV2G9A4x+vZrlAqDWJVfy2nGPbWeBgO1dzgxy7+
        nmOySb5Q==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.site)
        by merlin.infradead.org with esmtpsa (Exim 4.89 #1 (Red Hat Linux))
        id 1ehfQv-0003Qh-7c; Fri, 02 Feb 2018 17:47:29 +0000
Subject: Re: [PATCH 22/34] dma-mapping: add an arch_dma_supported hook
To:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org
Cc:     Konrad Rzeszutek Wilk <konrad@darnok.org>,
        linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
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
References: <20180112084232.2857-1-hch@lst.de>
 <20180112084232.2857-23-hch@lst.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <5d7dfb29-eeef-2280-13c9-5260e9104f67@infradead.org>
Date:   Fri, 2 Feb 2018 09:47:23 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180112084232.2857-23-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <rdunlap@infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62426
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rdunlap@infradead.org
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

On 01/12/2018 12:42 AM, Christoph Hellwig wrote:
> To implement the x86 forbid_dac and iommu_sac_force we want an arch hook
> so that it can apply the global options across all dma_map_ops
> implementations.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/x86/include/asm/dma-mapping.h |  3 +++
>  arch/x86/kernel/pci-dma.c          | 19 ++++++++++++-------
>  include/linux/dma-mapping.h        | 11 +++++++++++
>  3 files changed, 26 insertions(+), 7 deletions(-)

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

                     in new code.

> + */
> +#ifndef arch_dma_supported
> +#define arch_dma_supported(dev, mask)	(1)
> +#endif


-- 
~Randy
