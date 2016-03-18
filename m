Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Mar 2016 14:55:35 +0100 (CET)
Received: from smtp.codeaurora.org ([198.145.29.96]:34926 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007499AbcCRNzbs0FmA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Mar 2016 14:55:31 +0100
Received: from smtp.codeaurora.org (localhost [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id D3E0060F74;
        Fri, 18 Mar 2016 13:55:29 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C3DD360236; Fri, 18 Mar 2016 13:55:29 +0000 (UTC)
Received: from [10.228.68.107] (global_nat1_iad_fw.qualcomm.com [129.46.232.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: okaya@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6CCDC6029E;
        Fri, 18 Mar 2016 13:55:22 +0000 (UTC)
Subject: Re: [PATCH 3/3] dma-mapping: move swiotlb dma-phys functions to
 common header
To:     Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org, timur@codeaurora.org,
        cov@codeaurora.org, nwatters@codeaurora.org
References: <1458252137-24497-1-git-send-email-okaya@codeaurora.org>
 <1458252137-24497-3-git-send-email-okaya@codeaurora.org>
 <56EBE71F.2080203@arm.com>
Cc:     linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
        linux-xtensa@linux-xtensa.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Florian Fainelli <f.fainelli@gmail.com>, x86@kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Geliang Tang <geliangtang@163.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Rothberg <valentinrothberg@gmail.com>,
        Chris Zankel <chris@zankel.net>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>
From:   Sinan Kaya <okaya@codeaurora.org>
Message-ID: <56EC08C9.3080809@codeaurora.org>
Date:   Fri, 18 Mar 2016 09:55:21 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <56EBE71F.2080203@arm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <okaya@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52660
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: okaya@codeaurora.org
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

On 3/18/2016 7:31 AM, Robin Murphy wrote:
> On 17/03/16 22:02, Sinan Kaya wrote:
>> Moving the default implementation of swiotlb_dma_to_phys and
>> swiotlb_phys_to_dma functions to dma-mapping.h so that we can get
>> rid of the duplicate code in multiple ARCH.
>>
>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>> ---
>>   arch/arm64/include/asm/dma-mapping.h               | 14 --------------
>>   arch/ia64/include/asm/dma-mapping.h                | 14 --------------
>>   arch/mips/include/asm/mach-generic/dma-coherence.h | 16 ----------------
>>   arch/tile/include/asm/dma-mapping.h                | 14 --------------
>>   arch/unicore32/include/asm/dma-mapping.h           | 14 --------------
>>   arch/x86/include/asm/dma-mapping.h                 | 13 -------------
>>   arch/xtensa/include/asm/dma-mapping.h              | 14 --------------
>>   include/linux/dma-mapping.h                        | 14 ++++++++++++++
>>   8 files changed, 14 insertions(+), 99 deletions(-)
> 
> [...]
> 
>> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
>> index 728ef07..871d620 100644
>> --- a/include/linux/dma-mapping.h
>> +++ b/include/linux/dma-mapping.h
>> @@ -683,4 +683,18 @@ static inline int dma_mmap_writecombine(struct device *dev,
>>   #define dma_unmap_len_set(PTR, LEN_NAME, VAL)    do { } while (0)
>>   #endif
>>
>> +#ifndef swiotlb_phys_to_dma
>> +static inline dma_addr_t swiotlb_phys_to_dma(struct device *dev, phys_addr_t paddr)
>> +{
>> +         return paddr;
>> +}
>> +#endif
>> +
>> +#ifndef swiotlb_dma_to_phys
>> +static inline phys_addr_t swiotlb_dma_to_phys(struct device *dev, dma_addr_t daddr)
>> +{
>> +        return daddr;
>> +}
>> +#endif
>> +
>>   #endif
>>
> 
> Could the default definition not be pushed all the way down into swiotlb.c (or at least swiotlb.h)?

I can do that but then we lose the inlining capability of the compiler. This could cost
performance penalty on architectures using it.

I tried moving it to swiotlb.h. swiotlb.h seems to be only used by swiotlb.c file. I could try 
including it into dma-mapping.h and then moving the definitions into swiotlb.h file. 

Let me give this a try.

> 
> Robin.
> 


-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
