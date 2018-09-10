Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Sep 2018 18:06:53 +0200 (CEST)
Received: from foss.arm.com ([217.140.101.70]:36164 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994571AbeIJQGueE9Vg (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 10 Sep 2018 18:06:50 +0200
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AF80418A;
        Mon, 10 Sep 2018 09:06:43 -0700 (PDT)
Received: from [10.4.12.131] (e110467-lin.emea.arm.com [10.4.12.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7B8603F557;
        Mon, 10 Sep 2018 09:06:42 -0700 (PDT)
Subject: Re: [PATCH 2/5] dma-mapping: move the dma_coherent flag to struct
 device
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Paul Burton <paul.burton@mips.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
References: <20180910060533.27172-1-hch@lst.de>
 <20180910060533.27172-3-hch@lst.de>
 <71ec3eef-54c1-f692-5a17-4302c4dd4b05@arm.com>
 <20180910154747.GA23578@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <aa6f49f8-24ea-f166-9c58-aecb13df0418@arm.com>
Date:   Mon, 10 Sep 2018 17:06:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180910154747.GA23578@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Return-Path: <robin.murphy@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66187
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

On 10/09/18 16:47, Christoph Hellwig wrote:
>>> --- a/kernel/dma/Kconfig
>>> +++ b/kernel/dma/Kconfig
>>> @@ -13,6 +13,9 @@ config NEED_DMA_MAP_STATE
>>>    config ARCH_DMA_ADDR_T_64BIT
>>>    	def_bool 64BIT || PHYS_ADDR_T_64BIT
>>>    +config ARCH_HAS_DMA_COHERENCE_H
>>> +	bool
>>
>> This seems a little crude - is it unbearably churny to make an
>> asm-generic/dma-coherence.h implementation for everyone else?
> 
> The case of having something else than the per-device flag is rather
> odd, and I hope we don't grow any new user in addition to mips.
> 
> In fact I'm already thinking of ways to get rid of it for mips by
> e.g. iterating over all devices and just setting dma_coherent,
> but for now I wanted to solve the more urgen issues and tackle this
> later, as this unification blocks a few other things

Ah, somehow I started thinking that arm(64) would need to implement 
their own as well, but I see the point now. In that case, TBH I'd be 
quite happy with just a simple #ifdef CONFIG_MIPS in 
linux/dma-noncoherent.h - plus then it looks even more like something 
nobody else is expected to do.

>> Nits aside, this otherwise looks sane to me for factoring out the
>> equivalent Xen and arm64 DMA ops cases.
> 
> Like this? :)
> 
> http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-maybe-coherent

Man, that's going to take me a *lot* of time to pick through. All those 
horrendous subtleties that I barely remember!

Robin.
