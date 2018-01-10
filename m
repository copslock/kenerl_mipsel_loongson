Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Jan 2018 16:32:37 +0100 (CET)
Received: from verein.lst.de ([213.95.11.211]:37417 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990492AbeAJPc1Acdd2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 10 Jan 2018 16:32:27 +0100
Received: by newverein.lst.de (Postfix, from userid 2407)
        id A5D799F162; Wed, 10 Jan 2018 16:32:26 +0100 (CET)
Date:   Wed, 10 Jan 2018 16:32:26 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        Guan Xuetao <gxt@mprc.pku.edu.cn>, linux-arch@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-c6x-dev@linux-c6x.org,
        linux-hexagon@vger.kernel.org, x86@kernel.org,
        Konrad Rzeszutek Wilk <konrad@darnok.org>,
        linux-snps-arc@lists.infradead.org,
        linux-m68k@lists.linux-m68k.org, patches@groups.riscv.org,
        linux-metag@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Michal Simek <monstr@monstr.eu>, linux-parisc@vger.kernel.org,
        linux-cris-kernel@axis.com, linux-kernel@vger.kernel.org,
        linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 31/33] dma-direct: reject too small dma masks
Message-ID: <20180110153226.GE17790@lst.de>
References: <20180110080027.13879-1-hch@lst.de> <20180110080027.13879-32-hch@lst.de> <0bcca030-a8da-c34a-a905-707986689f33@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0bcca030-a8da-c34a-a905-707986689f33@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62041
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

On Wed, Jan 10, 2018 at 11:49:34AM +0000, Robin Murphy wrote:
>> +#ifdef CONFIG_ZONE_DMA
>> +	if (mask < DMA_BIT_MASK(ARCH_ZONE_DMA_BITS))
>> +		return 0;
>> +#else
>> +	/*
>> +	 * Because 32-bit DMA masks are so common we expect every architecture
>> +	 * to be able to satisfy them - either by not supporting more physical
>> +	 * memory, or by providing a ZONE_DMA32.  If neither is the case, the
>> +	 * architecture needs to use an IOMMU instead of the direct mapping.
>> +	 */
>> +	if (mask < DMA_BIT_MASK(32))
>> +		return 0;
>
> Do you think it's worth the effort to be a little more accommodating here? 
> i.e.:
>
> 		return dma_max_pfn(dev) >= max_pfn;
>
> We seem to have a fair few 28-31 bit masks for older hardware which 
> probably associates with host systems packing equivalently small amounts of 
> RAM.

And those devices don't have a ZONE_DMA?  I think we could do something
like that, but I'd rather have it as a separate commit with a good
explanation.  Maybe you can just send on on top of the series?
