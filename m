Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Dec 2015 15:32:57 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:12861 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007854AbbLIOcygCpt5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Dec 2015 15:32:54 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 7CF8AA05249CF;
        Wed,  9 Dec 2015 14:32:43 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Wed, 9 Dec 2015 14:32:46 +0000
Received: from [192.168.154.94] (192.168.154.94) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Wed, 9 Dec
 2015 14:32:46 +0000
Subject: Re: [PATCH] MIPS: Fix DMA contiguous allocation
To:     Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>
References: <1449569930-2118-1-git-send-email-qais.yousef@imgtec.com>
 <20151208141939.d0edbb72b3c15844c5ac25ea@linux-foundation.org>
 <20151209113635.GA15910@techsingularity.net>
CC:     <linux-mips@linux-mips.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <ralf@linux-mips.org>
From:   Qais Yousef <qais.yousef@imgtec.com>
Message-ID: <56683B8E.2000600@imgtec.com>
Date:   Wed, 9 Dec 2015 14:32:46 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <20151209113635.GA15910@techsingularity.net>
Content-Type: text/plain; charset="iso-8859-15"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.94]
Return-Path: <Qais.Yousef@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50484
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: qais.yousef@imgtec.com
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

On 12/09/2015 11:36 AM, Mel Gorman wrote:
> On Tue, Dec 08, 2015 at 02:19:39PM -0800, Andrew Morton wrote:
>> On Tue, 8 Dec 2015 10:18:50 +0000 Qais Yousef <qais.yousef@imgtec.com> wrote:
>>
>>> --- a/arch/mips/mm/dma-default.c
>>> +++ b/arch/mips/mm/dma-default.c
>>> @@ -145,7 +145,7 @@ static void *mips_dma_alloc_coherent(struct device *dev, size_t size,
>>>   
>>>   	gfp = massage_gfp_flags(dev, gfp);
>>>   
>>> -	if (IS_ENABLED(CONFIG_DMA_CMA) && !(gfp & GFP_ATOMIC))
>>> +	if (IS_ENABLED(CONFIG_DMA_CMA) && ((gfp & GFP_ATOMIC) != GFP_ATOMIC))
>>>   		page = dma_alloc_from_contiguous(dev,
>>>   					count, get_order(size));
>>>   	if (!page)
>> hm.  It seems that the code is asking "can I do a potentially-sleeping
>> memory allocation"?
>>
>> The way to do that under the new regime is
>>
>> 	if (IS_ENABLED(CONFIG_DMA_CMA) && gfpflags_allow_blocking(gfp))
>>
>> Mel, can you please confirm?
> Yes, this is the correct way it should be checked. The full flags cover
> watermark and kswapd treatment which potentially could be altered by
> the caller.
>

OK thanks both. I'll send a revised version with this change.

Thanks,
Qais
