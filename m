Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Mar 2012 04:35:09 +0200 (CEST)
Received: from mprc.pku.edu.cn ([162.105.203.9]:52146 "EHLO mprc.pku.edu.cn"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1901346Ab2C1CfB (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 28 Mar 2012 04:35:01 +0200
Received: from [192.168.0.105] ([162.105.80.111])
        by mprc.pku.edu.cn (8.13.8/8.13.8) with ESMTP id q2S2fe5E003107;
        Wed, 28 Mar 2012 10:41:40 +0800
Message-ID: <4F7275FE.8000100@mprc.pku.edu.cn>
Date:   Wed, 28 Mar 2012 10:22:54 +0800
From:   Guan Xuetao <gxt@mprc.pku.edu.cn>
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
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
        Andrzej Pietrasiewicz <andrzej.p@samsung.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Dezhong Diao <dediao@cisco.com>,
        Richard Kuo <rkuo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Michal Simek <monstr@monstr.eu>,
        Paul Mundt <lethal@linux-sh.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: Re: [PATCHv2 09/14] Unicore32: adapt for dma_map_ops changes
References: <1332855768-32583-1-git-send-email-m.szyprowski@samsung.com> <1332855768-32583-10-git-send-email-m.szyprowski@samsung.com>
In-Reply-To: <1332855768-32583-10-git-send-email-m.szyprowski@samsung.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 32798
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gxt@mprc.pku.edu.cn
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 03/27/2012 09:42 PM, Marek Szyprowski wrote:
> diff --git a/arch/unicore32/mm/dma-swiotlb.c b/arch/unicore32/mm/dma-swiotlb.c
> index bfa9fbb..4cf5f0c 100644
> --- a/arch/unicore32/mm/dma-swiotlb.c
> +++ b/arch/unicore32/mm/dma-swiotlb.c
> @@ -17,9 +17,23 @@
>
>   #include<asm/dma.h>
>
> +static void *unicore_swiotlb_alloc_coherent(struct device *dev, size_t size,
> +					    dma_addr_t *dma_handle, gfp_t flags,
> +					    struct dma_attrs *attrs)
> +{
> +	return swiotlb_alloc_coherent(dev, size, dma_handle, flags);
> +}
> +
> +static void unicode_swiotlb_free_coherent(struct device *dev, size_t size,
The bit is ok for me. Only a typo here, please change unicode to unicore.

Thanks and Regards.

Guan Xuetao
