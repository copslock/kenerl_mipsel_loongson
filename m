Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Sep 2018 08:43:43 +0200 (CEST)
Received: from verein.lst.de ([213.95.11.211]:59115 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990473AbeIKGnjdsHO0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 11 Sep 2018 08:43:39 +0200
Received: by newverein.lst.de (Postfix, from userid 2407)
        id ED14D67357; Tue, 11 Sep 2018 08:48:02 +0200 (CEST)
Date:   Tue, 11 Sep 2018 08:48:02 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Paul Burton <paul.burton@mips.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] dma-mapping: move the dma_coherent flag to struct
 device
Message-ID: <20180911064802.GB6214@lst.de>
References: <20180910060533.27172-1-hch@lst.de> <20180910060533.27172-3-hch@lst.de> <71ec3eef-54c1-f692-5a17-4302c4dd4b05@arm.com> <20180910154747.GA23578@lst.de> <aa6f49f8-24ea-f166-9c58-aecb13df0418@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa6f49f8-24ea-f166-9c58-aecb13df0418@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66195
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

On Mon, Sep 10, 2018 at 05:06:40PM +0100, Robin Murphy wrote:
>>> Nits aside, this otherwise looks sane to me for factoring out the
>>> equivalent Xen and arm64 DMA ops cases.
>>
>> Like this? :)
>>
>> http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-maybe-coherent
>
> Man, that's going to take me a *lot* of time to pick through. All those 
> horrendous subtleties that I barely remember!

The good thing is that if I remember correctly there is just a single
patch that (intentionally) changes behavior.  The rest is just
refactoring and moving code around.

Anyway, I want to get this series in now, and the kick off the swiotlb
discussion with Konread.  We might not even get to the iommu patches
for this merge window depending on how long it takes.
