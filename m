Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Nov 2018 09:34:09 +0100 (CET)
Received: from verein.lst.de ([213.95.11.211]:60146 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990434AbeKAIdqP3ssT (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 1 Nov 2018 09:33:46 +0100
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 196CC7F1C0; Thu,  1 Nov 2018 09:33:46 +0100 (CET)
Date:   Thu, 1 Nov 2018 09:33:46 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     Christoph Hellwig <hch@lst.de>, Paul Burton <paul.burton@mips.com>,
        iommu@lists.linux-foundation.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] MIPS: Fix `dma_alloc_coherent' returning a
 non-coherent allocation
Message-ID: <20181101083346.GA7136@lst.de>
References: <20180914095808.22202-1-hch@lst.de> <20180914095808.22202-5-hch@lst.de> <alpine.LFD.2.21.1810311414200.20378@eddie.linux-mips.org> <alpine.LFD.2.21.1810311559590.20378@eddie.linux-mips.org> <20181031203206.GA28337@lst.de> <alpine.LFD.2.21.1810312043250.20378@eddie.linux-mips.org> <20181101051359.GA4164@lst.de> <alpine.LFD.2.21.1811010523440.20378@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1811010523440.20378@eddie.linux-mips.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67027
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

On Thu, Nov 01, 2018 at 07:54:24AM +0000, Maciej W. Rozycki wrote:
> Fix a MIPS `dma_alloc_coherent' regression from commit bc3ec75de545 
> ("dma-mapping: merge direct and noncoherent ops") that causes a cached 
> allocation to be returned on noncoherent cache systems.
> 
> This is due to an inverted check now used in the MIPS implementation of 
> `arch_dma_alloc' on the result from `dma_direct_alloc_pages' before 
> doing the cached-to-uncached mapping of the allocation address obtained.  
> The mapping has to be done for a non-NULL rather than NULL result, 
> because a NULL result means the allocation has failed.
> 
> Invert the check for correct operation then.
> 
> Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
> Fixes: bc3ec75de545 ("dma-mapping: merge direct and noncoherent ops")
> Cc: stable@vger.kernel.org # 4.19+

Oops, yes this looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
