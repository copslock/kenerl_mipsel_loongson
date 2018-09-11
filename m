Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Sep 2018 10:20:08 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:57466 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992925AbeIKIUEXYCo4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 11 Sep 2018 10:20:04 +0200
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 74596B9E;
        Tue, 11 Sep 2018 08:19:55 +0000 (UTC)
Date:   Tue, 11 Sep 2018 10:19:52 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Paul Burton <paul.burton@mips.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] dma-mapping: move the dma_coherent flag to struct
 device
Message-ID: <20180911081952.GA17267@kroah.com>
References: <20180910060533.27172-1-hch@lst.de>
 <20180910060533.27172-3-hch@lst.de>
 <20180910161350.GA10380@kroah.com>
 <20180911064636.GA6214@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180911064636.GA6214@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66198
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

On Tue, Sep 11, 2018 at 08:46:36AM +0200, Christoph Hellwig wrote:
> On Mon, Sep 10, 2018 at 06:13:50PM +0200, Greg Kroah-Hartman wrote:
> > > +#if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
> > > +    defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
> > > +    defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
> > > +	bool			dma_coherent:1;
> > > +#endif
> > 
> > It's just one bit, why not always have it enabled here?  If the arch
> > uses it or doesn't, no big deal.
> > 
> > Or are you using this to "catch" arches that mess something up?
> 
> Yes, that is the intent - I don't want architectures to accidentally
> set it while not selecting the non-coherent infrastructure, as it
> won't have an effect.

Ok, fine with me:
	Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
