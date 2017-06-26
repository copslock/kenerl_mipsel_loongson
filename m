Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Jun 2017 09:03:57 +0200 (CEST)
Received: from verein.lst.de ([213.95.11.211]:54815 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993876AbdFZHDujGreE (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 26 Jun 2017 09:03:50 +0200
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 4B49970482; Mon, 26 Jun 2017 09:03:50 +0200 (CEST)
Date:   Mon, 26 Jun 2017 09:03:50 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
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
        Kyungmin Park <kyungmin.park@samsung.com>
Subject: Re: new dma-mapping tree, was Re: clean up and modularize arch
        dma_mapping interface V2
Message-ID: <20170626070350.GB10544@lst.de>
References: <20170616181059.19206-1-hch@lst.de> <20170620124140.GA27163@lst.de> <20170620230400.1a5ae889@canb.auug.org.au> <CGME20170620131628epcas1p4f21d821bd414cba7e2d49abcbe414365@epcas1p4.samsung.com> <20170620131623.GB30769@lst.de> <5425587c-73e8-e24a-86a3-8a65a7791dcb@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5425587c-73e8-e24a-86a3-8a65a7791dcb@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58794
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

On Wed, Jun 21, 2017 at 03:32:39PM +0200, Marek Szyprowski wrote:
> linux-next
> was a side effect of that. I think that for now it can be dropped in favor 
> of
> Christoph's tree. I can also do some review and help in maintainers work if
> needed, although I was recently busy with other stuff.
>
> Christoph: Could you add me to your MAINTAINERS patch, so further 
> dma-mapping
> related patches hopefully will be also CC: to me?

I've added you as a co-maintainer, thanks!
