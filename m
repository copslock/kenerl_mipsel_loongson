Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Nov 2018 09:04:15 +0100 (CET)
Received: from verein.lst.de ([213.95.11.211]:36341 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990946AbeKGIDgfMUlZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 7 Nov 2018 09:03:36 +0100
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 01BC968C44; Wed,  7 Nov 2018 09:03:36 +0100 (CET)
Date:   Wed, 7 Nov 2018 09:03:35 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     hch@lst.de, robh+dt@kernel.org, m.szyprowski@samsung.com,
        aaro.koskinen@iki.fi, jean-philippe.brucker@arm.com,
        john.stultz@linaro.org, iommu@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-mips@linux-mips.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] of/device: Really only set bus DMA mask when
 appropriate
Message-ID: <20181107080335.GA24511@lst.de>
References: <b06321ac25a1211e572e650a630e5e1aa9f8173f.1541504601.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b06321ac25a1211e572e650a630e5e1aa9f8173f.1541504601.git.robin.murphy@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67122
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

On Tue, Nov 06, 2018 at 11:54:15AM +0000, Robin Murphy wrote:
> of_dma_configure() was *supposed* to be following the same logic as
> acpi_dma_configure() and only setting bus_dma_mask if some range was
> specified by the firmware. However, it seems that subtlety got lost in
> the process of fitting it into the differently-shaped control flow, and
> as a result the force_dma==true case ends up always setting the bus mask
> to the 32-bit default, which is not what anyone wants.
> 
> Make sure we only touch it if the DT actually said so.

This looks good, but I think it could really use a comment as the use
of ret all the way down the function isn't exactly obvious.

Let me now if you want this picked up through the OF or DMA trees.
