Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Oct 2017 17:03:02 +0200 (CEST)
Received: from verein.lst.de ([213.95.11.211]:33344 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990392AbdJSPCwEPxdl (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 19 Oct 2017 17:02:52 +0200
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 6F22368CF0; Thu, 19 Oct 2017 17:02:49 +0200 (CEST)
Date:   Thu, 19 Oct 2017 17:02:49 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Michal Simek <monstr@monstr.eu>,
        David Howells <dhowells@redhat.com>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, x86@kernel.org,
        linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-xtensa@linux-xtensa.org,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: refactor dma_cache_sync V2
Message-ID: <20171019150249.GA24079@lst.de>
References: <20171003104311.10058-1-hch@lst.de> <87817c6a-b03f-6da0-4e69-22ea68d44bd5@arm.com> <20171016124442.GB2177@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171016124442.GB2177@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60476
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

On Mon, Oct 16, 2017 at 02:44:42PM +0200, Christoph Hellwig wrote:
> On Tue, Oct 03, 2017 at 12:49:51PM +0100, Robin Murphy wrote:
> > Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> 
> Thanks Robin.  I've heard very little from the arch maintainers,
> but if people remain silent I will apply the whole series to the
> dma-mapping tree in the next days.

Applied to the dma-mapping tree for 4.15.
