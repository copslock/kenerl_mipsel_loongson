Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Jan 2018 18:02:47 +0100 (CET)
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50334 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991619AbeAJRCknYH02 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Jan 2018 18:02:40 +0100
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 02C7F1529;
        Wed, 10 Jan 2018 09:02:34 -0800 (PST)
Received: from [10.1.210.88] (e110467-lin.cambridge.arm.com [10.1.210.88])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D87FD3F487;
        Wed, 10 Jan 2018 09:02:31 -0800 (PST)
Subject: Re: [PATCH 10/22] swiotlb: refactor coherent buffer allocation
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org, linux-arch@vger.kernel.org,
        linux-mips@linux-mips.org, Michal Simek <monstr@monstr.eu>,
        linux-ia64@vger.kernel.org,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad@darnok.org>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
References: <20180110080932.14157-1-hch@lst.de>
 <20180110080932.14157-11-hch@lst.de>
 <cecc98cf-2e6a-a7bc-7390-d6dcced038c4@arm.com>
 <20180110154649.GA18529@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <03c25dda-30da-9169-a8a1-1720ec741b9d@arm.com>
Date:   Wed, 10 Jan 2018 17:02:30 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180110154649.GA18529@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Return-Path: <robin.murphy@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62049
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

On 10/01/18 15:46, Christoph Hellwig wrote:
> On Wed, Jan 10, 2018 at 12:22:18PM +0000, Robin Murphy wrote:
>>> +	if (phys_addr == SWIOTLB_MAP_ERROR)
>>> +		goto out_warn;
>>>    -		/* Confirm address can be DMA'd by device */
>>> -		if (dev_addr + size - 1 > dma_mask) {
>>> -			printk("hwdev DMA mask = 0x%016Lx, dev_addr = 0x%016Lx\n",
>>> -			       (unsigned long long)dma_mask,
>>> -			       (unsigned long long)dev_addr);
>>> +	*dma_handle = swiotlb_phys_to_dma(dev, phys_addr);
>>
>> nit: this should probably go after the dma_coherent_ok() check (as with the
>> original logic).
> 
> But the originall logic also needs the dma_addr_t for the
> dma_coherent_ok check:
> 
> 		dev_addr = swiotlb_phys_to_dma(hwdev, paddr);
> 		/* Confirm address can be DMA'd by device */
> 		if (dev_addr + size - 1 > dma_mask) {
> 			...
> 			goto err_warn;
> 		}
> 
> or do you mean assining to *dma_handle?  The dma_handle is not
> valid for a failure return, so I don't think this should matter.

Yeah, only the assignment - as I said, it's just a stylistic nit; no big 
deal either way.

>>> +	if (ret) {
>>> +		*dma_handle = swiotlb_virt_to_bus(hwdev, ret);
>>> +		if (dma_coherent_ok(hwdev, *dma_handle, size)) {
>>> +			memset(ret, 0, size);
>>> +			return ret;
>>> +		}
>>
>> Aren't we leaking the pages here?
> 
> Yes, that free_pages got lost somewhere in the rebases, I've added
> it back.

Cool.

Robin.
