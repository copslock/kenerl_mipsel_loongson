Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jun 2017 15:04:20 +0200 (CEST)
Received: from ozlabs.org ([103.22.144.67]:48435 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992111AbdFTNEIIHnNn (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 20 Jun 2017 15:04:08 +0200
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 3wsShx45kdz9s76;
        Tue, 20 Jun 2017 23:04:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1497963842;
        bh=wlHkiX12XnsDMOSH4ngby4fr2WSQxdaJ/XP3NPTud/c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CgD1OIrpngvvYnVAekEguSgkYD7SvZB15QUTLdjsXjWiNdZy/RrNvqe3dJXuvWzw7
         M1lPtJRR2bG2sX9WtzmR7mjHTjKzf/hA2wM5ISA5PJBuATUKLJxSRabE0gz5WSiHW6
         IUfZtyVVgWw4vXsv3ZXdqPhi5BLAMJg6HNcVvvol2Xv7mcO5oO2oM1MS2EwWSNjezT
         gt95a5hVyA6vz3agGZlWSFqDSr0tihmLdsUW5UVQhASbQ/RXV8bbCVDiDHvJ4sYo29
         NNVv8+QgNFFRyTrEJJpJlCzhTpf8EaaiyO9gHjEg1KyaDEwPLmtHeqrLDo0eP0K260
         BehdKF8cI6fjQ==
Date:   Tue, 20 Jun 2017 23:04:00 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
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
Message-ID: <20170620230400.1a5ae889@canb.auug.org.au>
In-Reply-To: <20170620124140.GA27163@lst.de>
References: <20170616181059.19206-1-hch@lst.de>
        <20170620124140.GA27163@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <sfr@canb.auug.org.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58684
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sfr@canb.auug.org.au
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

Hi Christoph,

On Tue, 20 Jun 2017 14:41:40 +0200 Christoph Hellwig <hch@lst.de> wrote:
>
> On Fri, Jun 16, 2017 at 08:10:15PM +0200, Christoph Hellwig wrote:
> > I plan to create a new dma-mapping tree to collect all this work.
> > Any volunteers for co-maintainers, especially from the iommu gang?  
> 
> Ok, I've created the new tree:
> 
>    git://git.infradead.org/users/hch/dma-mapping.git for-next
> 
> Gitweb:
> 
>    http://git.infradead.org/users/hch/dma-mapping.git/shortlog/refs/heads/for-next
> 
> And below is the patch to add the MAINTAINERS entry, additions welcome.
> 
> Stephen, can you add this to linux-next?

Added from tomorrow.

I have another tree called dma-mapping:

git://git.linaro.org/people/mszyprowski/linux-dma-mapping.git#dma-mapping-next

Contacts: Marek Szyprowski and Kyungmin Park (cc'd)

I have called your tree dma-mapping-hch for now.  The other tree has
not been updated since 4.9-rc1 and I am not sure how general it is.
Marek, Kyungmin, any comments?

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgement of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window. 

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
        Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and 
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

-- 
Cheers,
Stephen Rothwell 
sfr@canb.auug.org.au
