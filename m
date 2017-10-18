Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Oct 2017 19:23:46 +0200 (CEST)
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:48087 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992456AbdJRRXjefaSo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Oct 2017 19:23:39 +0200
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id B496E20FC7;
        Wed, 18 Oct 2017 13:23:37 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute3.internal (MEProxy); Wed, 18 Oct 2017 13:23:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=animalcreek.com;
         h=cc:content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        mesmtp; bh=ZZVDulCJESBmzbup1FxMfAbV8V16an+3mi+JRvoLPPE=; b=JtK68
        5p6nxsFaA2sZSO9ELbAd6/uPkqtdXEmbgGGO+PUP9p5Zkn6PZNjkP7tOahv0SRbI
        s7XrAcSJZWR1M3IoKSMhGfrgpjDHAAII30QeRLGj3UbmKdOkEpVCSw2nYA+Mo91j
        kyHTmlaqPzFneYRaGkTE8B7Ehru4MdAhGPEIOQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=ZZVDulCJESBmzbup1FxMfAbV8V16a
        n+3mi+JRvoLPPE=; b=KxKXtKYriwtTXvLFngBtdgTDwjQqX/3+NM2gmXZfKI5q5
        HmsEp4EUo+ABHptcFYy7ANHls/pb2ydVTHHMuXcwjHcnDnkajv21cG5ej6gWIrvd
        Ar2E8Qpje8WA5gLzX2OZChnFLRb9/fDav/bSAHmqfK9GjY6PDRpt8gbato3aTh78
        32OmA27eJObSLELbbQ6hTz5zPxpzFJv+ekgm6zp25QqnSnaaT/Z6tuIaEEZtg0wX
        D6+DSDUlhGo/B6OYiayR8qu7EH/UqtFxN/TKEKlnCHrdAOt2xqNiHWSvN5ZL5GUV
        axT6PirvGsUbIzDkWRJ466xJj57/e41mVQ8UC4gKg==
X-ME-Sender: <xms:GY7nWaHolKQ_qqzzgyWMglPN1rfW6l3zfZO6N2tOPV-JxOFo3VUPPA>
Received: from blue.animalcreek.com (ip68-3-119-204.ph.ph.cox.net [68.3.119.204])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5973324787;
        Wed, 18 Oct 2017 13:23:37 -0400 (EDT)
Received: by blue.animalcreek.com (Postfix, from userid 1000)
        id A718AA20754; Wed, 18 Oct 2017 10:23:36 -0700 (MST)
Date:   Wed, 18 Oct 2017 10:23:36 -0700
From:   Mark Greer <mgreer@animalcreek.com>
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
        "Mark A . Greer" <mgreer@animalcreek.com>,
        Robert Baldyga <r.baldyga@hackerion.com>
Subject: Re: [PATCH V8 1/5] dma-mapping: Rework dma_get_cache_alignment()
Message-ID: <20171018172336.GA29358@animalcreek.com>
References: <1508227542-13165-1-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1508227542-13165-1-git-send-email-chenhc@lemote.com>
Organization: Animal Creek Technologies, Inc.
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <mgreer@animalcreek.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60446
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mgreer@animalcreek.com
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

On Tue, Oct 17, 2017 at 04:05:38PM +0800, Huacai Chen wrote:
> Make dma_get_cache_alignment() to accept a 'dev' argument. As a result,
> it can return different alignments due to different devices' I/O cache
> coherency.
> 
> Currently, ARM/ARM64 and MIPS support coherent & noncoherent devices
> co-exist. This may be extended in the future, so add a new function
> pointer (i.e, get_cache_alignment) in 'struct dma_map_ops' as a generic
> solution.

Hi Huacai.

> diff --git a/drivers/tty/serial/mpsc.c b/drivers/tty/serial/mpsc.c
> index 67ffecc..c708457 100644
> --- a/drivers/tty/serial/mpsc.c
> +++ b/drivers/tty/serial/mpsc.c
> @@ -81,19 +81,19 @@
>   * Number of Tx & Rx descriptors must be powers of 2.
>   */
>  #define	MPSC_RXR_ENTRIES	32
> -#define	MPSC_RXRE_SIZE		dma_get_cache_alignment()
> +#define	MPSC_RXRE_SIZE		dma_get_cache_alignment(dma_dev)

I would much prefer that you add a parameter to the macro to avoid forcing
a non-flexible and non-obvious variable definition wherever it is used.
What I mean is something like:

#define MPSC_RXRE_SIZE(d)		dma_get_cache_alignment(d)

Similarly for all of the other macros and where they're used.

Thanks,

Mark
--
