Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Nov 2018 20:17:01 +0100 (CET)
Received: from emh03.mail.saunalahti.fi ([62.142.5.109]:48624 "EHLO
        emh03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992824AbeKFTQ6DQWlr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 6 Nov 2018 20:16:58 +0100
Received: from darkstar.musicnaut.iki.fi (85-76-84-88-nat.elisa-mobile.fi [85.76.84.88])
        by emh03.mail.saunalahti.fi (Postfix) with ESMTP id 4F4E440037;
        Tue,  6 Nov 2018 21:16:56 +0200 (EET)
Date:   Tue, 6 Nov 2018 21:16:56 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     hch@lst.de, robh+dt@kernel.org, m.szyprowski@samsung.com,
        jean-philippe.brucker@arm.com, john.stultz@linaro.org,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-mips@linux-mips.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] of/device: Really only set bus DMA mask when appropriate
Message-ID: <20181106191655.GB14958@darkstar.musicnaut.iki.fi>
References: <b06321ac25a1211e572e650a630e5e1aa9f8173f.1541504601.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b06321ac25a1211e572e650a630e5e1aa9f8173f.1541504601.git.robin.murphy@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67103
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

Hi,

On Tue, Nov 06, 2018 at 11:54:15AM +0000, Robin Murphy wrote:
> of_dma_configure() was *supposed* to be following the same logic as
> acpi_dma_configure() and only setting bus_dma_mask if some range was
> specified by the firmware. However, it seems that subtlety got lost in
> the process of fitting it into the differently-shaped control flow, and
> as a result the force_dma==true case ends up always setting the bus mask
> to the 32-bit default, which is not what anyone wants.
> 
> Make sure we only touch it if the DT actually said so.
> 
> Fixes: 6c2fb2ea7636 ("of/device: Set bus DMA mask as appropriate")
> Reported-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> Reported-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>

This fixes the MMC driver DMA mask issue on OCTEON.

Thanks,

A.

> ---
> 
> Sorry about that... I guess I only have test setups that either have
> dma-ranges or where a 32-bit bus mask goes unnoticed :(
> 
> The Octeon and SMMU issues sound like they're purely down to this, and
> it's probably related to at least one of John's Hikey woes.
> 
> Robin.
> 
>  drivers/of/device.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/of/device.c b/drivers/of/device.c
> index 0f27fad9fe94..757ae867674f 100644
> --- a/drivers/of/device.c
> +++ b/drivers/of/device.c
> @@ -149,7 +149,8 @@ int of_dma_configure(struct device *dev, struct device_node *np, bool force_dma)
>  	 * set by the driver.
>  	 */
>  	mask = DMA_BIT_MASK(ilog2(dma_addr + size - 1) + 1);
> -	dev->bus_dma_mask = mask;
> +	if (!ret)
> +		dev->bus_dma_mask = mask;
>  	dev->coherent_dma_mask &= mask;
>  	*dev->dma_mask &= mask;
>  
> -- 
> 2.19.1.dirty
> 
