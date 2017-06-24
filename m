Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Jun 2017 09:19:02 +0200 (CEST)
Received: from verein.lst.de ([213.95.11.211]:46711 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993156AbdFXHS4FwMKR (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 24 Jun 2017 09:18:56 +0200
Received: by newverein.lst.de (Postfix, from userid 2407)
        id A900068D37; Sat, 24 Jun 2017 09:18:55 +0200 (CEST)
Date:   Sat, 24 Jun 2017 09:18:55 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     tndave <tushar.n.dave@oracle.com>
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
Subject: Re: clean up and modularize arch dma_mapping interface V2
Message-ID: <20170624071855.GD14580@lst.de>
References: <20170616181059.19206-1-hch@lst.de> <162d7932-5766-4c29-5471-07d1b699190a@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162d7932-5766-4c29-5471-07d1b699190a@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58783
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

On Wed, Jun 21, 2017 at 12:24:28PM -0700, tndave wrote:
> Thanks for doing this.
> So archs can still have their own definition for dma_set_mask() if 
> HAVE_ARCH_DMA_SET_MASK is y?
> (and similarly for dma_set_coherent_mask() when 
> CONFIG_ARCH_HAS_DMA_SET_COHERENT_MASK is y)
> Any plan to change these?

Yes, those should go away, but I'm not entirely sure how yet.  We'll
need some hook for switching between an IOMMU and a direct mapping
(I guess that's what you want to do for sparc as well?), and I need
to find the best way to do that.  Reimplementing all of dma_set_mask
and dma_set_coherent_mask is something that I want to move away from.
