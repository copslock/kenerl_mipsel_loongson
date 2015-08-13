Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Aug 2015 19:58:19 +0200 (CEST)
Received: from verein.lst.de ([213.95.11.211]:39332 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011814AbbHMR6PQ-fp6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 13 Aug 2015 19:58:15 +0200
Received: by newverein.lst.de (Postfix, from userid 2407)
        id BDF33691E9; Thu, 13 Aug 2015 19:58:14 +0200 (CEST)
Date:   Thu, 13 Aug 2015 19:58:14 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>, akpm@linux-foundation.org,
        arnd@arndb.de, catalin.marinas@arm.com, will.deacon@arm.com,
        ysato@users.sourceforge.jp, monstr@monstr.eu, jonas@southpole.se,
        cmetcalf@ezchip.com, gxt@mprc.pku.edu.cn, x86@kernel.org,
        linux-alpha@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] dma-mapping: consolidate dma_set_mask
Message-ID: <20150813175814.GB21103@lst.de>
References: <1439478248-15183-1-git-send-email-hch@lst.de> <1439478248-15183-6-git-send-email-hch@lst.de> <20150813152505.GR7557@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150813152505.GR7557@n2100.arm.linux.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48874
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

On Thu, Aug 13, 2015 at 04:25:05PM +0100, Russell King - ARM Linux wrote:
> On Thu, Aug 13, 2015 at 05:04:08PM +0200, Christoph Hellwig wrote:
> > diff --git a/arch/arm/common/dmabounce.c b/arch/arm/common/dmabounce.c
> > index 1143c4d..260f52a 100644
> > --- a/arch/arm/common/dmabounce.c
> > +++ b/arch/arm/common/dmabounce.c
> > @@ -440,14 +440,6 @@ static void dmabounce_sync_for_device(struct device *dev,
> >  	arm_dma_ops.sync_single_for_device(dev, handle, size, dir);
> >  }
> >  
> > -static int dmabounce_set_mask(struct device *dev, u64 dma_mask)
> > -{
> > -	if (dev->archdata.dmabounce)
> > -		return 0;
> > -
> > -	return arm_dma_ops.set_dma_mask(dev, dma_mask);
> 
> Are you sure about this?  A user of dmabounce gets to request any mask
> with the original code (even though it was never written back... which
> is a separate bug.)  After this, it seems that this will get limited
> by the dma_supported() check.  As this old code is about bouncing any
> buffer into DMA-able memory, it doesn't care about the DMA mask.

I think you're right.  With the default dma_supported implementation
it would be fine, but ARM uses a custom one.  I'll keep the arm
specific dma_set_mask implementation for the next round.
