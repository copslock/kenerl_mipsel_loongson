Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Jan 2018 18:23:25 +0100 (CET)
Received: from foss.arm.com ([217.140.101.70]:50672 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992243AbeAJRXS50dD7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 10 Jan 2018 18:23:18 +0100
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 142E41529;
        Wed, 10 Jan 2018 09:23:12 -0800 (PST)
Received: from [10.1.210.88] (e110467-lin.cambridge.arm.com [10.1.210.88])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EEDC13F487;
        Wed, 10 Jan 2018 09:23:09 -0800 (PST)
Subject: Re: [PATCH 08/22] swiotlb: wire up ->dma_supported in swiotlb_dma_ops
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
 <20180110080932.14157-9-hch@lst.de>
 <7a058876-08fc-7323-7cb3-fe85116e2ea8@arm.com>
 <20180110153517.GF17790@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <5b14af5b-e6e9-17c5-d433-f50ccb466f90@arm.com>
Date:   Wed, 10 Jan 2018 17:23:08 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180110153517.GF17790@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Return-Path: <robin.murphy@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62051
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

On 10/01/18 15:35, Christoph Hellwig wrote:
> On Wed, Jan 10, 2018 at 12:16:15PM +0000, Robin Murphy wrote:
>> On 10/01/18 08:09, Christoph Hellwig wrote:
>>> To properly reject too small DMA masks based on the addressability of the
>>> bounce buffer.
>>
>> I reckon this is self-evident enough that it should simply be squashed into
>> the previous patch.
> 
> x86 didn't wire it up before, so I want a clear blaimpoint for this
> change instead of mixing it up.
That almost makes sense, if x86 were using this generic swiotlb_dma_ops 
already. AFAICS it's only ia64, unicore and tile who end up using it, 
and they all had swiotlb_dma_supported hooked up to begin with. Am I 
missing something?

If regressions are going to happen, they'll surely point at whichever 
commit pulls the ops into the relevant arch code - there doesn't seem to 
be a great deal of value in having a piecemeal history of said ops 
*before* that point.

Robin.
