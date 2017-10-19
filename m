Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Oct 2017 17:09:29 +0200 (CEST)
Received: from verein.lst.de ([213.95.11.211]:33391 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990392AbdJSPJWkq1hl (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 19 Oct 2017 17:09:22 +0200
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 5764CDE7F7; Thu, 19 Oct 2017 17:09:21 +0200 (CEST)
Date:   Thu, 19 Oct 2017 17:09:21 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Mark Greer <mgreer@animalcreek.com>
Cc:     Huacai Chen <chenhc@lemote.com>, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Fuxin Zhang <zhangfx@lemote.com>, linux-kernel@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>,
        linux-mips@linux-mips.org,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        linux-ide@vger.kernel.org, stable@vger.kernel.org,
        "Michael S . Tsirkin" <mst@mellanox.co.il>,
        Pawel Osciak <pawel@osciak.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Michael Chan <michael.chan@broadcom.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ivan Mikhaylov <ivan@ru.ibm.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Andy Gross <agross@codeaurora.org>,
        Robert Baldyga <r.baldyga@hackerion.com>
Subject: Re: [PATCH V8 1/5] dma-mapping: Rework dma_get_cache_alignment()
Message-ID: <20171019150921.GB24204@lst.de>
References: <1508227542-13165-1-git-send-email-chenhc@lemote.com> <20171018172336.GA29358@animalcreek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171018172336.GA29358@animalcreek.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60478
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

On Wed, Oct 18, 2017 at 10:23:36AM -0700, Mark Greer wrote:
> >  #define	MPSC_RXR_ENTRIES	32
> > -#define	MPSC_RXRE_SIZE		dma_get_cache_alignment()
> > +#define	MPSC_RXRE_SIZE		dma_get_cache_alignment(dma_dev)
> 
> I would much prefer that you add a parameter to the macro to avoid forcing
> a non-flexible and non-obvious variable definition wherever it is used.
> What I mean is something like:
> 
> #define MPSC_RXRE_SIZE(d)		dma_get_cache_alignment(d)
> 
> Similarly for all of the other macros and where they're used.

Agreed.  Except for that the patch looks fine to me, though.
