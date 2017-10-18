Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Oct 2017 21:54:56 +0200 (CEST)
Received: from www.llwyncelyn.cymru ([82.70.14.225]:34354 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991526AbdJRTyn0GMKN (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 18 Oct 2017 21:54:43 +0200
Received: from alans-desktop (82-70-14-226.dsl.in-addr.zen.co.uk [82.70.14.226])
        by fuzix.org (8.15.2/8.15.2) with ESMTP id v9IJsMDJ005662;
        Wed, 18 Oct 2017 20:54:22 +0100
Date:   Wed, 18 Oct 2017 20:54:22 +0100
From:   Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
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
        linux-ide@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH V8 5/5] libata: Align DMA buffer to
 dma_get_cache_alignment()
Message-ID: <20171018205422.7fc8cbce@alans-desktop>
In-Reply-To: <94f55c1e-7553-0fc8-124e-ac6df5ac10ce@cogentembedded.com>
References: <1508227542-13165-1-git-send-email-chenhc@lemote.com>
        <1508227542-13165-5-git-send-email-chenhc@lemote.com>
        <94f55c1e-7553-0fc8-124e-ac6df5ac10ce@cogentembedded.com>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <gnomes@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60448
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gnomes@lxorguk.ukuu.org.uk
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

>     This function is called only for the PIO mode commands, so I doubt this is 
> necessary...

That is true but there are platforms out there that issue disk level PIO
commands via DMA (or can do so). Indeed the Cyrix MediaGX could do that
in the 1990s but I never add support 8)

So I think it makes sense to allocate the buffers DMA aligned, but it
doesn't seem to explain the situation in this case and I think it would
be helpful to know what platform and ATA driver is tripping this and wny
they are the only people in the universe to have the problem.

Alan
