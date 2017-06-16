Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jun 2017 10:37:08 +0200 (CEST)
Received: from verein.lst.de ([213.95.11.211]:60844 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993859AbdFPIhBUr5UU (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 16 Jun 2017 10:37:01 +0200
Received: by newverein.lst.de (Postfix, from userid 2407)
        id AB24B68BDB; Fri, 16 Jun 2017 10:37:00 +0200 (CEST)
Date:   Fri, 16 Jun 2017 10:37:00 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        xen-devel@lists.xenproject.org, linux-c6x-dev@linux-c6x.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, openrisc@lists.librecores.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, dmaengine@vger.kernel.org,
        linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-samsung-soc@vger.kernel.org,
        iommu@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/44] iommu/dma: don't rely on DMA_ERROR_CODE
Message-ID: <20170616083700.GA10582@lst.de>
References: <20170608132609.32662-1-hch@lst.de> <20170608132609.32662-7-hch@lst.de> <0bfb0841-f054-78de-628d-a0955336bcb4@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0bfb0841-f054-78de-628d-a0955336bcb4@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58508
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

On Thu, Jun 08, 2017 at 02:59:07PM +0100, Robin Murphy wrote:
> Hi Christoph,
> 
> On 08/06/17 14:25, Christoph Hellwig wrote:
> > DMA_ERROR_CODE is not a public API and will go away soon.  dma dma-iommu
> > driver already implements a proper ->mapping_error method, so it's only
> > using the value internally.  Add a new local define using the value
> > that arm64 which is the only current user of dma-iommu.
> 
> It would be fine to just use 0, since dma-iommu already makes sure that
> that will never be allocated for a valid DMA address.

I'll change it to 0.

> Otherwise, looks good!

Can you give me a formal ACK or Reviewed-by: ?
