Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Sep 2017 14:51:16 +0200 (CEST)
Received: from verein.lst.de ([213.95.11.211]:39910 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990493AbdIYMvJ6wnhV (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 25 Sep 2017 14:51:09 +0200
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 999D268C4E; Mon, 25 Sep 2017 14:51:07 +0200 (CEST)
Date:   Mon, 25 Sep 2017 14:51:07 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Fuxin Zhang <zhangfx@lemote.com>, linux-kernel@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>,
        linux-mips@linux-mips.org,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Roland Dreier <rolandd@cisco.com>,
        Pawel Osciak <pawel@osciak.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Michael Chan <michael.chan@broadcom.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ivan Mikhaylov <ivan@ru.ibm.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Andy Gross <agross@codeaurora.org>,
        "Mark A . Greer" <mgreer@mvista.com>,
        Robert Baldyga <r.baldyga@samsung.com>, stable@vger.kernel.org
Subject: Re: [PATCH V7 1/2] dma-mapping: Rework dma_get_cache_alignment()
Message-ID: <20170925125107.GC8130@lst.de>
References: <1506332766-23966-1-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1506332766-23966-1-git-send-email-chenhc@lemote.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60148
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

> index aba7138..e2c5d9e 100644
> --- a/arch/mips/include/asm/dma-mapping.h
> +++ b/arch/mips/include/asm/dma-mapping.h
> @@ -39,4 +39,6 @@ static inline void arch_setup_dma_ops(struct device *dev, u64 dma_base,
>  #endif
>  }
>  
> +int mips_get_cache_alignment(struct device *dev);

All the other mips generic dma helpers are prefixed mips_dma_*
so it might make sense to follow that.

Also please don't add arch-local helpers to asm/dma-mapping.h - this
is a header used by linux/dma-mapping.h and should not contain
implementation details if avoidable.

> +					   dma_get_cache_alignment(NULL)) / mdev->limits.mtt_seg_size;

As said before - please don't pass NULL to this function but the proper
device, which would be &mdev->pdev->dev in this case for example.
