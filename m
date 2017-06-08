Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Jun 2017 18:32:30 +0200 (CEST)
Received: from mga05.intel.com ([192.55.52.43]:19897 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990509AbdFHQcWAurkp (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 8 Jun 2017 18:32:22 +0200
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP; 08 Jun 2017 09:32:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.39,315,1493708400"; 
   d="scan'208";a="112537781"
Received: from djiang5-desk3.ch.intel.com ([143.182.137.38])
  by fmsmga006.fm.intel.com with ESMTP; 08 Jun 2017 09:32:18 -0700
Subject: Re: [PATCH 03/44] dmaengine: ioat: don't use DMA_ERROR_CODE
To:     Christoph Hellwig <hch@lst.de>, "x86@kernel.org" <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-c6x-dev@linux-c6x.org" <linux-c6x-dev@linux-c6x.org>,
        "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "openrisc@lists.librecores.org" <openrisc@lists.librecores.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20170608132609.32662-1-hch@lst.de>
 <20170608132609.32662-4-hch@lst.de>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <bf0a16a3-75d9-25c9-98d3-f1e7624dc5d7@intel.com>
Date:   Thu, 8 Jun 2017 09:32:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <20170608132609.32662-4-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <dave.jiang@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58371
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dave.jiang@intel.com
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

On 06/08/2017 06:25 AM, Christoph Hellwig wrote:
> DMA_ERROR_CODE is not a public API and will go away.  Instead properly
> unwind based on the loop counter.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/dma/ioat/init.c | 24 +++++++-----------------
>  1 file changed, 7 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/dma/ioat/init.c b/drivers/dma/ioat/init.c
> index 6ad4384b3fa8..ed8ed1192775 100644
> --- a/drivers/dma/ioat/init.c
> +++ b/drivers/dma/ioat/init.c
> @@ -839,8 +839,6 @@ static int ioat_xor_val_self_test(struct ioatdma_device *ioat_dma)
>  		goto free_resources;
>  	}
>  
> -	for (i = 0; i < IOAT_NUM_SRC_TEST; i++)
> -		dma_srcs[i] = DMA_ERROR_CODE;
>  	for (i = 0; i < IOAT_NUM_SRC_TEST; i++) {
>  		dma_srcs[i] = dma_map_page(dev, xor_srcs[i], 0, PAGE_SIZE,
>  					   DMA_TO_DEVICE);
> @@ -910,8 +908,6 @@ static int ioat_xor_val_self_test(struct ioatdma_device *ioat_dma)
>  
>  	xor_val_result = 1;
>  
> -	for (i = 0; i < IOAT_NUM_SRC_TEST + 1; i++)
> -		dma_srcs[i] = DMA_ERROR_CODE;
>  	for (i = 0; i < IOAT_NUM_SRC_TEST + 1; i++) {
>  		dma_srcs[i] = dma_map_page(dev, xor_val_srcs[i], 0, PAGE_SIZE,
>  					   DMA_TO_DEVICE);
> @@ -965,8 +961,6 @@ static int ioat_xor_val_self_test(struct ioatdma_device *ioat_dma)
>  	op = IOAT_OP_XOR_VAL;
>  
>  	xor_val_result = 0;
> -	for (i = 0; i < IOAT_NUM_SRC_TEST + 1; i++)
> -		dma_srcs[i] = DMA_ERROR_CODE;
>  	for (i = 0; i < IOAT_NUM_SRC_TEST + 1; i++) {
>  		dma_srcs[i] = dma_map_page(dev, xor_val_srcs[i], 0, PAGE_SIZE,
>  					   DMA_TO_DEVICE);
> @@ -1017,18 +1011,14 @@ static int ioat_xor_val_self_test(struct ioatdma_device *ioat_dma)
>  	goto free_resources;
>  dma_unmap:
>  	if (op == IOAT_OP_XOR) {
> -		if (dest_dma != DMA_ERROR_CODE)
> -			dma_unmap_page(dev, dest_dma, PAGE_SIZE,
> -				       DMA_FROM_DEVICE);
> -		for (i = 0; i < IOAT_NUM_SRC_TEST; i++)
> -			if (dma_srcs[i] != DMA_ERROR_CODE)
> -				dma_unmap_page(dev, dma_srcs[i], PAGE_SIZE,
> -					       DMA_TO_DEVICE);
> +		while (--i >= 0)
> +			dma_unmap_page(dev, dma_srcs[i], PAGE_SIZE,
> +				       DMA_TO_DEVICE);
> +		dma_unmap_page(dev, dest_dma, PAGE_SIZE, DMA_FROM_DEVICE);
>  	} else if (op == IOAT_OP_XOR_VAL) {
> -		for (i = 0; i < IOAT_NUM_SRC_TEST + 1; i++)
> -			if (dma_srcs[i] != DMA_ERROR_CODE)
> -				dma_unmap_page(dev, dma_srcs[i], PAGE_SIZE,
> -					       DMA_TO_DEVICE);
> +		while (--i >= 0)
> +			dma_unmap_page(dev, dma_srcs[i], PAGE_SIZE,
> +				       DMA_TO_DEVICE);
>  	}
>  free_resources:
>  	dma->device_free_chan_resources(dma_chan);
> 
