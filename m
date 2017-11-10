Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Nov 2017 13:31:10 +0100 (CET)
Received: from verein.lst.de ([213.95.11.211]:33889 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992297AbdKJMbD6DLcx (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 10 Nov 2017 13:31:03 +0100
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 5F16F68C40; Fri, 10 Nov 2017 13:30:59 +0100 (CET)
Date:   Fri, 10 Nov 2017 13:30:59 +0100
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
        linux-scsi@vger.kernel.org, stable@vger.kernel.org,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Pawel Osciak <pawel@osciak.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Michael Chan <michael.chan@broadcom.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ivan Mikhaylov <ivan@ru.ibm.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Andy Gross <agross@codeaurora.org>,
        "Mark A . Greer" <mgreer@animalcreek.com>,
        Robert Baldyga <r.baldyga@hackerion.com>
Subject: Re: [PATCH V9 1/4] dma-mapping: Rework dma_get_cache_alignment()
Message-ID: <20171110123059.GA9296@lst.de>
References: <1508742767-28366-1-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1508742767-28366-1-git-send-email-chenhc@lemote.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60828
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

> diff --git a/drivers/net/ethernet/broadcom/b44.c b/drivers/net/ethernet/broadcom/b44.c
> index a1125d1..2f6ffe5 100644
> --- a/drivers/net/ethernet/broadcom/b44.c
> +++ b/drivers/net/ethernet/broadcom/b44.c
> @@ -2344,6 +2344,10 @@ static int b44_init_one(struct ssb_device *sdev,
>  	struct net_device *dev;
>  	struct b44 *bp;
>  	int err;
> +	unsigned int dma_desc_align_size = dma_get_cache_alignment(sdev->dma_dev);
> +
> +	/* Setup paramaters for syncing RX/TX DMA descriptors */
> +	dma_desc_sync_size = max_t(unsigned int, dma_desc_align_size, sizeof(struct dma_desc));
>  
>  	instance++;
>  
> @@ -2587,12 +2591,8 @@ static inline void b44_pci_exit(void)
>  
>  static int __init b44_init(void)
>  {
> -	unsigned int dma_desc_align_size = dma_get_cache_alignment();
>  	int err;
>  
> -	/* Setup paramaters for syncing RX/TX DMA descriptors */
> -	dma_desc_sync_size = max_t(unsigned int, dma_desc_align_size, sizeof(struct dma_desc));
> -

This looks wrong - you override a global variable for each probed
device.
