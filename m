Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Nov 2017 06:14:56 +0100 (CET)
Received: from verein.lst.de ([213.95.11.211]:48165 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990409AbdKCFOsIcaCC (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 3 Nov 2017 06:14:48 +0100
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 5082B68B01; Fri,  3 Nov 2017 06:14:45 +0100 (CET)
Date:   Fri, 3 Nov 2017 06:14:45 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     =?utf-8?B?6ZmI5Y2O5omN?= <chenhc@lemote.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        JamesHogan <james.hogan@imgtec.com>,
        linux-mips <linux-mips@linux-mips.org>,
        "James E . J .Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Pawel Osciak <pawel@osciak.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Michael Chan <michael.chan@broadcom.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ivan Mikhaylov <ivan@ru.ibm.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Andy Gross <agross@codeaurora.org>,
        "Mark A . Greer" <mgreer@animalcreek.com>,
        RobertBaldyga <r.baldyga@hackerion.com>
Subject: Re: [PATCH V9 1/4] dma-mapping: Rework dma_get_cache_alignment()
Message-ID: <20171103051445.GA14933@lst.de>
References: <CGME20171023071025epcas4p3e9b9c0af7c0a34561f0d57a20a4f9946@epcas4p3.samsung.com> <1508742767-28366-1-git-send-email-chenhc@lemote.com> <0f34e021-a559-3e3c-4586-48450e87d5c8@samsung.com> <tencent_06493D0500CE277740BDF088@qq.com> <7ac87ae6-32e5-bd14-32a1-abdcf8aa8221@samsung.com> <tencent_6576ECDE049EE8921F2D13BB@qq.com> <tencent_56D97C65293D16191A2D88C9@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_56D97C65293D16191A2D88C9@qq.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60700
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

I can queue 1 up in the dma-mapping tree, and if I get reviews for
the mips and scsi bits I'd be happy to queue those up as well.

But I think you'd be better off moving patches 3 and 4 to the front
without the dma_get_cache_alignment prototype change so that they can be
merged to stable.
