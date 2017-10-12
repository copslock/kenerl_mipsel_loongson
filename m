Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Oct 2017 19:07:07 +0200 (CEST)
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54122 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992544AbdJLRHAUN0Hz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 12 Oct 2017 19:07:00 +0200
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A641415BE;
        Thu, 12 Oct 2017 10:06:52 -0700 (PDT)
Received: from [10.1.210.88] (e110467-lin.cambridge.arm.com [10.1.210.88])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E377B3F483;
        Thu, 12 Oct 2017 10:06:49 -0700 (PDT)
Subject: Re: [PATCH 4/9] arm64: dma-mapping: export symbol arch_setup_dma_ops
To:     Jim Quinlan <jim2101024@gmail.com>, linux-kernel@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>, linux-mips@linux-mips.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        Kevin Cernekee <cernekee@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Brian Norris <computersforpeace@gmail.com>,
        linux-arm-kernel@lists.infradead.org
References: <1507761269-7017-1-git-send-email-jim2101024@gmail.com>
 <1507761269-7017-5-git-send-email-jim2101024@gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <a8fa87e4-4d70-eb60-f1c5-94071d6394aa@arm.com>
Date:   Thu, 12 Oct 2017 18:06:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <1507761269-7017-5-git-send-email-jim2101024@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <robin.murphy@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60387
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

On 11/10/17 23:34, Jim Quinlan wrote:
> The BrcmSTB driver needs to get ahold of a pointer to swiotlb_dma_ops.
> However, that variable is defined as static.  Instead, we use
> arch_setup_dma_ops() to get the pointer to swiotlb_dma_ops.  Since
> we also want our driver to be a separate module, we need to
> export this function.

NAK. Retrieve the platform-assigned ops from the device via
get_dma_ops() and stash them in your drvdata or wherever before you
replace them. Don't go poking around arch code internals directly from a
driver.

Robin.

> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> ---
>  arch/arm64/mm/dma-mapping.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> index 614af88..dae572f 100644
> --- a/arch/arm64/mm/dma-mapping.c
> +++ b/arch/arm64/mm/dma-mapping.c
> @@ -936,3 +936,4 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
>  	}
>  #endif
>  }
> +EXPORT_SYMBOL(arch_setup_dma_ops);
> 
