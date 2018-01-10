Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Jan 2018 18:10:20 +0100 (CET)
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50486 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992160AbeAJRKNk-du2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Jan 2018 18:10:13 +0100
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 446D81529;
        Wed, 10 Jan 2018 09:10:07 -0800 (PST)
Received: from [10.1.210.88] (e110467-lin.cambridge.arm.com [10.1.210.88])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC05C3F487;
        Wed, 10 Jan 2018 09:10:04 -0800 (PST)
Subject: Re: [PATCH 21/22] arm64: replace ZONE_DMA with ZONE_DMA32
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
 <20180110080932.14157-22-hch@lst.de>
 <0371cef8-d980-96da-9cb5-3609c39be18a@arm.com>
 <20180110155517.GA18774@lst.de> <20180110155546.GB18903@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <3c3263ca-b0ab-654a-d67d-f5ff5e31280c@arm.com>
Date:   Wed, 10 Jan 2018 17:10:02 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180110155546.GB18903@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Return-Path: <robin.murphy@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62050
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

On 10/01/18 15:55, Christoph Hellwig wrote:
> On Wed, Jan 10, 2018 at 04:55:17PM +0100, Christoph Hellwig wrote:
>> On Wed, Jan 10, 2018 at 12:58:14PM +0000, Robin Murphy wrote:
>>> On 10/01/18 08:09, Christoph Hellwig wrote:
>>>> arm64 uses ZONE_DMA for allocations below 32-bits.  These days we
>>>> name the zone for that ZONE_DMA32, which will allow to use the
>>>> dma-direct and generic swiotlb code as-is, so rename it.
>>>
>>> I do wonder if we could also "upgrade" GFP_DMA to GFP_DMA32 somehow when
>>> !ZONE_DMA - there are almost certainly arm64 drivers out there using a
>>> combination of GFP_DMA and streaming mappings which will no longer get the
>>> guaranteed 32-bit addresses they expect after this. I'm not sure quite how
>>> feasible that is, though :/
>>
>> I can't find anything obvious in the tree. The alternative would be
>> to keep ZONE_DMA and set ARCH_ZONE_DMA_BITS.
>>
>>> That said, I do agree that this is an appropriate change (the legacy of
>>> GFP_DMA is obviously horrible), so, provided we get plenty of time to find
>>> and fix the fallout when it lands:
>>>
>>> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
>>
>> I was hoping to get this into 4.15.  What would be proper time to
>> fix the fallout?
> 
> Err, 4.16 of course.

Hee hee - cramming it into 4.15 is exactly what I wouldn't want to do, 
even if Linus would accept it :)

Landing it this merge window for 4.16-rc1 sounds good if we can manage that.

Robin.
