Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Jun 2018 01:13:23 +0200 (CEST)
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:32958 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994689AbeEaXNPi7HMJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 1 Jun 2018 01:13:15 +0200
Received: from mipsdag02.mipstec.com (mail2.mips.com [12.201.5.32]) by mx28.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=NO); Thu, 31 May 2018 23:13:00 +0000
Received: from mipsdag02.mipstec.com (10.20.40.47) by mipsdag02.mipstec.com
 (10.20.40.47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1415.2; Thu, 31
 May 2018 16:13:05 -0700
Received: from localhost (10.20.2.29) by mipsdag02.mipstec.com (10.20.40.47)
 with Microsoft SMTP Server id 15.1.1415.2 via Frontend Transport; Thu, 31 May
 2018 16:13:05 -0700
Date:   Thu, 31 May 2018 16:12:59 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        David Daney <david.daney@cavium.com>,
        Tom Bogendoerfer <tsbogend@alpha.franken.de>,
        <linux-mips@linux-mips.org>, <iommu@lists.linux-foundation.org>
Subject: Re: [PATCH 06/25] MIPS: loongson: remove loongson_dma_supported
Message-ID: <20180531231259.s2zfywv3ei23rkoe@pburton-laptop>
References: <20180525092111.18516-1-hch@lst.de>
 <20180525092111.18516-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180525092111.18516-7-hch@lst.de>
User-Agent: NeoMutt/20180512
X-BESS-ID: 1527808380-637138-19061-4586-1
X-BESS-VER: 2018.6-r1805312037
X-BESS-Apparent-Source-IP: 12.201.5.32
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.193591
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Paul.Burton@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64143
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@mips.com
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

Hi Christoph,

On Fri, May 25, 2018 at 11:20:52AM +0200, Christoph Hellwig wrote:
> swiotlb_dma_supported will always return true for the a mask
> large enough to be covered by wired up physical address, so this
> function is pointless.

Shouldn't this be "large enough to cover all wired up physical
addresses"? Or maybe even more correctly "large enough to cover all DMA
addresses that might be used"?

Also, there's a spurious "the" on the first line.

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/mips/loongson64/common/dma-swiotlb.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/arch/mips/loongson64/common/dma-swiotlb.c b/arch/mips/loongson64/common/dma-swiotlb.c
> index 6a739f8ae110..a5e50f2ec301 100644
> --- a/arch/mips/loongson64/common/dma-swiotlb.c
> +++ b/arch/mips/loongson64/common/dma-swiotlb.c
> @@ -56,13 +56,6 @@ static void loongson_dma_sync_sg_for_device(struct device *dev,
>  	mb();
>  }
>  
> -static int loongson_dma_supported(struct device *dev, u64 mask)
> -{
> -	if (mask > DMA_BIT_MASK(loongson_sysconf.dma_mask_bits))
> -		return 0;

The comparison here will only evaluate true (indicating that DMA is not
supported) if the mask is larger than that supported by the system,
right? Therefore is this not essentially a check that the mask is
appropriately small, whilst swiotlb_dma_supported() checks that the mask
is appropriately large?

I'm struggling to understand how it follows that this function is
pointless given the behaviour of swiotlb_dma_supported(), which is what
the commit message suggests.

Thanks,
    Paul

> -	return swiotlb_dma_supported(dev, mask);
> -}
> -
>  dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t paddr)
>  {
>  	long nid;
> @@ -99,7 +92,7 @@ static const struct dma_map_ops loongson_dma_map_ops = {
>  	.sync_sg_for_cpu = swiotlb_sync_sg_for_cpu,
>  	.sync_sg_for_device = loongson_dma_sync_sg_for_device,
>  	.mapping_error = swiotlb_dma_mapping_error,
> -	.dma_supported = loongson_dma_supported,
> +	.dma_supported = swiotlb_dma_supported,
>  };
>  
>  void __init plat_swiotlb_setup(void)
> -- 
> 2.17.0
> 
> 
