Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Jan 2018 16:35:24 +0100 (CET)
Received: from verein.lst.de ([213.95.11.211]:37446 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991619AbeAJPfSWrZ02 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 10 Jan 2018 16:35:18 +0100
Received: by newverein.lst.de (Postfix, from userid 2407)
        id EE4909F162; Wed, 10 Jan 2018 16:35:17 +0100 (CET)
Date:   Wed, 10 Jan 2018 16:35:17 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        linux-arch@vger.kernel.org, linux-mips@linux-mips.org,
        Michal Simek <monstr@monstr.eu>, linux-ia64@vger.kernel.org,
        Christian =?iso-8859-1?Q?K=F6nig?= 
        <ckoenig.leichtzumerken@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad@darnok.org>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 08/22] swiotlb: wire up ->dma_supported in
        swiotlb_dma_ops
Message-ID: <20180110153517.GF17790@lst.de>
References: <20180110080932.14157-1-hch@lst.de> <20180110080932.14157-9-hch@lst.de> <7a058876-08fc-7323-7cb3-fe85116e2ea8@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a058876-08fc-7323-7cb3-fe85116e2ea8@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62042
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

On Wed, Jan 10, 2018 at 12:16:15PM +0000, Robin Murphy wrote:
> On 10/01/18 08:09, Christoph Hellwig wrote:
>> To properly reject too small DMA masks based on the addressability of the
>> bounce buffer.
>
> I reckon this is self-evident enough that it should simply be squashed into 
> the previous patch.

x86 didn't wire it up before, so I want a clear blaimpoint for this
change instead of mixing it up.
