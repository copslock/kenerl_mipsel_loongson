Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Jan 2018 16:29:56 +0100 (CET)
Received: from verein.lst.de ([213.95.11.211]:37349 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990435AbeAJP3peEMo2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 10 Jan 2018 16:29:45 +0100
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 33AFE9F162; Wed, 10 Jan 2018 16:29:45 +0100 (CET)
Date:   Wed, 10 Jan 2018 16:29:45 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        Guan Xuetao <gxt@mprc.pku.edu.cn>, linux-arch@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-c6x-dev@linux-c6x.org,
        linux-hexagon@vger.kernel.org, x86@kernel.org,
        Konrad Rzeszutek Wilk <konrad@darnok.org>,
        linux-snps-arc@lists.infradead.org,
        linux-m68k@lists.linux-m68k.org, patches@groups.riscv.org,
        linux-metag@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Michal Simek <monstr@monstr.eu>, linux-parisc@vger.kernel.org,
        linux-cris-kernel@axis.com, linux-kernel@vger.kernel.org,
        linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 20/33] dma-mapping: clear harmful GFP_* flags in common
        code
Message-ID: <20180110152945.GC17790@lst.de>
References: <20180110080027.13879-1-hch@lst.de> <20180110080027.13879-21-hch@lst.de> <27b90341-f9d0-356f-0194-1c7203a3f93e@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27b90341-f9d0-356f-0194-1c7203a3f93e@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62038
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

On Wed, Jan 10, 2018 at 11:59:30AM +0000, Robin Murphy wrote:
> Just a note that if we're all happy to enshrine the "allocations are always 
> zeroed" behaviour in the API (I am too, for the record), we should remember 
> to follow up once the dust settles to update the docs and I guess just 
> #define dma_zalloc_coherent dma_alloc_coherent.

And then just remove it.  But yes, another item for the todo list..
