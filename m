Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Jan 2018 16:31:27 +0100 (CET)
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48364 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990502AbeAJPbUhd2y2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Jan 2018 16:31:20 +0100
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11D78F;
        Wed, 10 Jan 2018 07:31:14 -0800 (PST)
Received: from [10.1.210.88] (e110467-lin.cambridge.arm.com [10.1.210.88])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4DB133F487;
        Wed, 10 Jan 2018 07:31:10 -0800 (PST)
Subject: Re: [PATCH 11/33] dma-mapping: move swiotlb arch helpers to a new
 header
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org, linux-mips@linux-mips.org,
        linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>,
        linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org,
        x86@kernel.org, Konrad Rzeszutek Wilk <konrad@darnok.org>,
        linux-snps-arc@lists.infradead.org,
        linux-m68k@lists.linux-m68k.org, patches@groups.riscv.org,
        linux-metag@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Michal Simek <monstr@monstr.eu>, linux-parisc@vger.kernel.org,
        linux-cris-kernel@axis.com, linux-kernel@vger.kernel.org,
        linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <20180110080027.13879-1-hch@lst.de>
 <20180110080027.13879-12-hch@lst.de>
 <3721b4ba-0685-255e-06b9-6e60678a1a92@arm.com>
 <20180110152617.GB17790@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <b0f90ed0-989f-4dc2-6f86-de8b4e486b55@arm.com>
Date:   Wed, 10 Jan 2018 15:31:08 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180110152617.GB17790@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Return-Path: <robin.murphy@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62040
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

On 10/01/18 15:26, Christoph Hellwig wrote:
> On Wed, Jan 10, 2018 at 02:56:01PM +0000, Robin Murphy wrote:
>> I took a look at these, and it seems their phys_to_dma() usage is doing the
>> thing which we subsequently formalised as dma_map_resource(). I've had a
>> crack at a quick patch to update the CESA driver; qcom_nandc looks slightly
>> more complex in that the changes probably need to span the BAM dmaengine
>> driver as well.
> 
> Sounds great, although probably something for the next merge window.
> 
> In the meantime does this patch looks good to you?

Yes indeed, modulo Vladimir's comments - it does seem prudent to fix the 
obvious off-by-ones as we touch them. I've wanted to do something like 
this for ages, but never got around to it myself.

Thanks,
Robin.
