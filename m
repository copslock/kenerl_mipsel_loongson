Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jun 2017 15:16:33 +0200 (CEST)
Received: from verein.lst.de ([213.95.11.211]:53691 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992143AbdFTNQX5pcNn (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 20 Jun 2017 15:16:23 +0200
Received: by newverein.lst.de (Postfix, from userid 2407)
        id A31747FC8A; Tue, 20 Jun 2017 15:16:23 +0200 (CEST)
Date:   Tue, 20 Jun 2017 15:16:23 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
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
        linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
Subject: Re: new dma-mapping tree, was Re: clean up and modularize arch
        dma_mapping interface V2
Message-ID: <20170620131623.GB30769@lst.de>
References: <20170616181059.19206-1-hch@lst.de> <20170620124140.GA27163@lst.de> <20170620230400.1a5ae889@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170620230400.1a5ae889@canb.auug.org.au>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58687
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

On Tue, Jun 20, 2017 at 11:04:00PM +1000, Stephen Rothwell wrote:
> git://git.linaro.org/people/mszyprowski/linux-dma-mapping.git#dma-mapping-next
> 
> Contacts: Marek Szyprowski and Kyungmin Park (cc'd)
> 
> I have called your tree dma-mapping-hch for now.  The other tree has
> not been updated since 4.9-rc1 and I am not sure how general it is.
> Marek, Kyungmin, any comments?

I'd be happy to join efforts - co-maintainers and reviers are always
welcome.
