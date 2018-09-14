Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Sep 2018 17:44:32 +0200 (CEST)
Received: from foss.arm.com ([217.140.101.70]:40018 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994248AbeINPo164iP6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 14 Sep 2018 17:44:27 +0200
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D24FC80D;
        Fri, 14 Sep 2018 08:44:20 -0700 (PDT)
Received: from [10.4.12.131] (e110467-lin.emea.arm.com [10.4.12.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 10EEC3F557;
        Fri, 14 Sep 2018 08:44:19 -0700 (PDT)
Subject: Re: [PATCH, for-4.19] dma-mapping: add the missing
 ARCH_HAS_SYNC_DMA_FOR_CPU_ALL declaration
To:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org
Cc:     linux-mips@linux-mips.org, paul.burton@mips.com
References: <20180911090049.10747-1-hch@lst.de>
 <20180914100842.GA23696@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <00257a79-72cf-15aa-fed9-d75923eed51e@arm.com>
Date:   Fri, 14 Sep 2018 16:44:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180914100842.GA23696@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Return-Path: <robin.murphy@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66296
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

On 14/09/18 11:08, Christoph Hellwig wrote:
> Aby chance to get a review for this?

So without this, the select does nothing, 
CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL is never defined, and BMIPS gets 
the static inline stub and never flushes the RAC when it should? I don't 
know enough MIPS to consider even compile-testing to check it, but that 
sounds like a legitimate fix to me.

Robin.

> On Tue, Sep 11, 2018 at 11:00:49AM +0200, Christoph Hellwig wrote:
>> The patch adding the infrastructure failed to actually add the symbol
>> declaration, oops..
>>
>> Fixes: faef87723a ("dma-noncoherent: add a arch_sync_dma_for_cpu_all hook")
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> ---
>>   kernel/dma/Kconfig | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
>> index 9bd54304446f..1b1d63b3634b 100644
>> --- a/kernel/dma/Kconfig
>> +++ b/kernel/dma/Kconfig
>> @@ -23,6 +23,9 @@ config ARCH_HAS_SYNC_DMA_FOR_CPU
>>   	bool
>>   	select NEED_DMA_MAP_STATE
>>   
>> +config ARCH_HAS_SYNC_DMA_FOR_CPU_ALL
>> +	bool
>> +
>>   config DMA_DIRECT_OPS
>>   	bool
>>   	depends on HAS_DMA
>> -- 
>> 2.18.0
>>
>> _______________________________________________
>> iommu mailing list
>> iommu@lists.linux-foundation.org
>> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> ---end quoted text---
> 
