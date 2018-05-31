Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 May 2018 18:32:36 +0200 (CEST)
Received: from verein.lst.de ([213.95.11.211]:57818 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994685AbeEaQc3pOvhO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 31 May 2018 18:32:29 +0200
Received: by newverein.lst.de (Postfix, from userid 2407)
        id CE8B068CEE; Thu, 31 May 2018 18:38:59 +0200 (CEST)
Date:   Thu, 31 May 2018 18:38:59 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Paul Burton <paul.burton@mips.com>
Cc:     Christoph Hellwig <hch@lst.de>, Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        David Daney <david.daney@cavium.com>,
        Tom Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@linux-mips.org, iommu@lists.linux-foundation.org
Subject: Re: [PATCH 05/25] MIPS: Octeon: refactor swiotlb code
Message-ID: <20180531163859.GA31181@lst.de>
References: <20180525092111.18516-1-hch@lst.de> <20180525092111.18516-6-hch@lst.de> <20180530232552.4rqnoo3652mabrqq@pburton-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180530232552.4rqnoo3652mabrqq@pburton-laptop>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64135
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

On Wed, May 30, 2018 at 04:25:52PM -0700, Paul Burton wrote:
> > +static const struct octeon_dma_map_ops octeon_gen2_ops = {
> > +	.phys_to_dma	= octeon_hole_phys_to_dma,
> > +	.dma_to_phys	= octeon_hole_dma_to_phys,
> > +};
> 
> These are pointers to functions of the wrong type, right? phys_to_dma &
> dma_to_phys have the struct device * argument but the octeon_hole_*
> functions do not. I'd expect we either need to restore the
> octeon_gen2_* wrappers that you remove below or change the definition of
> the octeon_hole_* functions.

That is true.  I have no idea how that passed the buildbot, which
reported all kinds of other issues in the original octeon conversion.

I'll fix this for the next respin.
