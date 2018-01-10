Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Jan 2018 16:30:27 +0100 (CET)
Received: from verein.lst.de ([213.95.11.211]:37375 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990435AbeAJPaTBKbE2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 10 Jan 2018 16:30:19 +0100
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 7D4B89F163; Wed, 10 Jan 2018 16:30:17 +0100 (CET)
Date:   Wed, 10 Jan 2018 16:30:17 +0100
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
Subject: Re: [PATCH 27/33] dma-direct: use node local allocations for
        coherent memory
Message-ID: <20180110153017.GD17790@lst.de>
References: <20180110080027.13879-1-hch@lst.de> <20180110080027.13879-28-hch@lst.de> <3672aa56-b85c-5d2c-0c0e-709031b0c0a0@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3672aa56-b85c-5d2c-0c0e-709031b0c0a0@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62039
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

On Wed, Jan 10, 2018 at 12:06:22PM +0000, Robin Murphy wrote:
> On 10/01/18 08:00, Christoph Hellwig wrote:
>> To preserve the x86 behavior.
>
> And combined with patch 10/22 of the SWIOTLB refactoring, this means 
> SWIOTLB allocations will also end up NUMA-aware, right? Great, that's what 
> we want on arm64 too :)

Well, only for swiotlb allocations that can be satisfied by
dma_direct_alloc.  If we actually have to fall back to the swiotlb
buffers there is not node affinity yet.
