Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Jan 2018 16:46:56 +0100 (CET)
Received: from verein.lst.de ([213.95.11.211]:37528 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990492AbeAJPqt4AA22 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 10 Jan 2018 16:46:49 +0100
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 8C0739F162; Wed, 10 Jan 2018 16:46:49 +0100 (CET)
Date:   Wed, 10 Jan 2018 16:46:49 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        linux-arch@vger.kernel.org, linux-mips@linux-mips.org,
        Michal Simek <monstr@monstr.eu>, linux-ia64@vger.kernel.org,
        Christian =?iso-8859-1?Q?K=F6nig?= 
        <ckoenig.leichtzumerken@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad@darnok.org>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 10/22] swiotlb: refactor coherent buffer allocation
Message-ID: <20180110154649.GA18529@lst.de>
References: <20180110080932.14157-1-hch@lst.de> <20180110080932.14157-11-hch@lst.de> <cecc98cf-2e6a-a7bc-7390-d6dcced038c4@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cecc98cf-2e6a-a7bc-7390-d6dcced038c4@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62044
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hch@lst.de
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

On Wed, Jan 10, 2018 at 12:22:18PM +0000, Robin Murphy wrote:
>> +	if (phys_addr == SWIOTLB_MAP_ERROR)
>> +		goto out_warn;
>>   -		/* Confirm address can be DMA'd by device */
>> -		if (dev_addr + size - 1 > dma_mask) {
>> -			printk("hwdev DMA mask = 0x%016Lx, dev_addr = 0x%016Lx\n",
>> -			       (unsigned long long)dma_mask,
>> -			       (unsigned long long)dev_addr);
>> +	*dma_handle = swiotlb_phys_to_dma(dev, phys_addr);
>
> nit: this should probably go after the dma_coherent_ok() check (as with the 
> original logic).

But the originall logic also needs the dma_addr_t for the
dma_coherent_ok check:

		dev_addr = swiotlb_phys_to_dma(hwdev, paddr);
		/* Confirm address can be DMA'd by device */
		if (dev_addr + size - 1 > dma_mask) {
			...
			goto err_warn;
		}

or do you mean assining to *dma_handle?  The dma_handle is not
valid for a failure return, so I don't think this should matter.

>> +	if (ret) {
>> +		*dma_handle = swiotlb_virt_to_bus(hwdev, ret);
>> +		if (dma_coherent_ok(hwdev, *dma_handle, size)) {
>> +			memset(ret, 0, size);
>> +			return ret;
>> +		}
>
> Aren't we leaking the pages here?

Yes, that free_pages got lost somewhere in the rebases, I've added
it back.
