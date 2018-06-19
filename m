Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Jun 2018 01:19:50 +0200 (CEST)
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:48459 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993097AbeFSXTlEhrgR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 Jun 2018 01:19:41 +0200
Received: from mipsdag03.mipstec.com (mail3.mips.com [12.201.5.33]) by mx1403.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=NO); Tue, 19 Jun 2018 23:19:26 +0000
Received: from mipsdag02.mipstec.com (10.20.40.47) by mipsdag03.mipstec.com
 (10.20.40.48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1415.2; Tue, 19
 Jun 2018 16:19:24 -0700
Received: from localhost (10.20.2.29) by mipsdag02.mipstec.com (10.20.40.47)
 with Microsoft SMTP Server id 15.1.1415.2 via Frontend Transport; Tue, 19 Jun
 2018 16:19:24 -0700
Date:   Tue, 19 Jun 2018 16:19:25 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        David Daney <david.daney@cavium.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Tom Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhc@lemote.com>,
        <iommu@lists.linux-foundation.org>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH 18/25] MIPS: loongson64: use generic dma noncoherent ops
Message-ID: <20180619231925.mgbgc7lfvjqumr7a@pburton-laptop>
References: <20180615110854.19253-1-hch@lst.de>
 <20180615110854.19253-19-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180615110854.19253-19-hch@lst.de>
User-Agent: NeoMutt/20180512
X-BESS-ID: 1529450365-321459-12798-18587-1
X-BESS-VER: 2018.7-r1806151722
X-BESS-Apparent-Source-IP: 12.201.5.33
X-BESS-Envelope-From: Paul.Burton@mips.com
X-BESS-Outbound-Spam-Score: 1.10
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.194207
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.50 BSF_RULE7568M          META: Custom Rule 7568M 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.60 MARKETING_SUBJECT      HEADER: Subject contains popular marketing words 
X-BESS-Outbound-Spam-Status: SCORE=1.10 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND, MARKETING_SUBJECT
X-BESS-Orig-Rcpt: hch@lst.de,ralf@linux-mips.org,jhogan@kernel.org,f.fainelli@gmail.com,david.daney@cavium.com,cernekee@gmail.com,jiaxun.yang@flygoat.com,tsbogend@alpha.franken.de,chenhc@lemote.com,iommu@lists.linux-foundation.org,linux-mips@linux-mips.org
X-BESS-BRTS-Status: 1
Return-Path: <Paul.Burton@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64386
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

On Fri, Jun 15, 2018 at 01:08:47PM +0200, Christoph Hellwig wrote:
> -static inline unsigned long plat_dma_addr_to_phys(struct device *dev,
> -	dma_addr_t dma_addr)
> -{
> -#if defined(CONFIG_CPU_LOONGSON2F) && defined(CONFIG_64BIT)
> -	return (dma_addr > 0x8fffffff) ? dma_addr : (dma_addr & 0x0fffffff);
> -#else
> -	return dma_addr & 0x7fffffff;
> -#endif
> -}

...

> +phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t dma_addr)
> +{
> +#if defined(CONFIG_CPU_LOONGSON2F) && defined(CONFIG_64BIT)
> +	if (dma_addr > 0x8fffffff)
> +		return dma_addr;
> +#endif
> +	return dma_addr & 0x0fffffff;
> +}

Thanks for putting in the work here - I've applied patches 1-17 to
mips-next so far, but I'm struggling to convince myself that the above
is correct.

In the original code we have 3 distinct cases:

  64b Loongson2F, dma_addr > 0x8fffffff  -> dma_addr
  64b Loongson2F, dma_addr <= 0x8fffffff -> dma_addr & 0x0fffffff
  Everything else                        -> dma_addr & 0x7fffffff

In the new __dma_to_phys() though only the first case remains the same.

Is this intentional or a mixup?

Thanks,
    Paul
