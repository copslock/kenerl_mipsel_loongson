Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Sep 2017 08:10:30 +0200 (CEST)
Received: from verein.lst.de ([213.95.11.211]:45534 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990515AbdIZGKYCzknz (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 26 Sep 2017 08:10:24 +0200
Received: by newverein.lst.de (Postfix, from userid 2407)
        id D34909EDA3; Tue, 26 Sep 2017 08:10:19 +0200 (CEST)
Date:   Tue, 26 Sep 2017 08:10:19 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     =?utf-8?B?6ZmI5Y2O5omN?= <chenhc@lemote.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>,
        linux-mips <linux-mips@linux-mips.org>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Roland Dreier <rolandd@cisco.com>,
        Pawel Osciak <pawel@osciak.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Michael Chan <michael.chan@broadcom.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ivan Mikhaylov <ivan@ru.ibm.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Andy Gross <agross@codeaurora.org>,
        "Mark A . Greer" <mgreer@mvista.com>,
        Robert Baldyga <r.baldyga@samsung.com>,
        stable <stable@vger.kernel.org>
Subject: Re: [PATCH V7 1/2] dma-mapping: Rework dma_get_cache_alignment()
Message-ID: <20170926061019.GA6416@lst.de>
References: <1506332766-23966-1-git-send-email-chenhc@lemote.com> <20170925125107.GC8130@lst.de> <tencent_7716E99906A9D63D4592EFB6@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_7716E99906A9D63D4592EFB6@qq.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60151
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

On Tue, Sep 26, 2017 at 09:48:01AM +0800, 陈华才 wrote:
> Hi, Christoph,
> 
> Can I put the declaration in asm/dma-coherence.h?

Generally something not expose to the rest of the kernel (that is not
in arch/mips/include/) would be preferred, but in the end the architecture
maintainer will have to decide.

> And, last time you said it is OK to pass a NULL to dma_get_cache_alignment() and cc all driver maintainers. I have do so.

No, I asked you to converted everything to pass the struct device and
cc the driver maintainers.
