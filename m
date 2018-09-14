Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Sep 2018 17:51:49 +0200 (CEST)
Received: from verein.lst.de ([213.95.11.211]:48231 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992066AbeINPvqnzSv6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 14 Sep 2018 17:51:46 +0200
Received: by newverein.lst.de (Postfix, from userid 2407)
        id EBE0A67358; Fri, 14 Sep 2018 17:51:50 +0200 (CEST)
Date:   Fri, 14 Sep 2018 17:51:50 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        linux-mips@linux-mips.org, paul.burton@mips.com
Subject: Re: [PATCH, for-4.19] dma-mapping: add the missing
 ARCH_HAS_SYNC_DMA_FOR_CPU_ALL declaration
Message-ID: <20180914155150.GA30438@lst.de>
References: <20180911090049.10747-1-hch@lst.de> <20180914100842.GA23696@lst.de> <00257a79-72cf-15aa-fed9-d75923eed51e@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00257a79-72cf-15aa-fed9-d75923eed51e@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66297
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

On Fri, Sep 14, 2018 at 04:44:15PM +0100, Robin Murphy wrote:
> On 14/09/18 11:08, Christoph Hellwig wrote:
>> Aby chance to get a review for this?
>
> So without this, the select does nothing, 
> CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL is never defined, and BMIPS gets the 
> static inline stub and never flushes the RAC when it should?

Exactly!
