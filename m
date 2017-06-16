Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jun 2017 10:43:41 +0200 (CEST)
Received: from verein.lst.de ([213.95.11.211]:60912 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993859AbdFPIncB624U (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 16 Jun 2017 10:43:32 +0200
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 1CF0268D1E; Fri, 16 Jun 2017 10:43:29 +0200 (CEST)
Date:   Fri, 16 Jun 2017 10:43:28 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Russell King - ARM Linux <linux@armlinux.org.uk>
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
Subject: Re: [PATCH 25/44] arm: implement ->mapping_error
Message-ID: <20170616084328.GC10582@lst.de>
References: <20170608132609.32662-1-hch@lst.de> <20170608132609.32662-26-hch@lst.de> <20170608144313.GL4902@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170608144313.GL4902@n2100.armlinux.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58510
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

On Thu, Jun 08, 2017 at 03:43:14PM +0100, Russell King - ARM Linux wrote:
> BOn Thu, Jun 08, 2017 at 03:25:50PM +0200, Christoph Hellwig wrote:
> > +static int dmabounce_mapping_error(struct device *dev, dma_addr_t dma_addr)
> > +{
> > +	if (dev->archdata.dmabounce)
> > +		return 0;
> 
> I'm not convinced that we need this check here:
> 
>         dev->archdata.dmabounce = device_info;
>         set_dma_ops(dev, &dmabounce_ops);
> 
> There shouldn't be any chance of dev->archdata.dmabounce being NULL if
> the dmabounce_ops has been set as the current device DMA ops.  So I
> think that test can be killed.

Ok, I'll fix it up.
