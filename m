Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Nov 2017 19:21:55 +0100 (CET)
Received: from verein.lst.de ([213.95.11.211]:36977 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990489AbdKFSVtNy6RO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 6 Nov 2017 19:21:49 +0100
Received: by newverein.lst.de (Postfix, from userid 2407)
        id C59C568D10; Mon,  6 Nov 2017 19:21:48 +0100 (CET)
Date:   Mon, 6 Nov 2017 19:21:48 +0100
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
        linux-scsi@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH V9 2/4] MIPS: Implement
        dma_map_ops::get_cache_alignment()
Message-ID: <20171106182148.GA29657@lst.de>
References: <1508742767-28366-1-git-send-email-chenhc@lemote.com> <1508742767-28366-2-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1508742767-28366-2-git-send-email-chenhc@lemote.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60723
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

This doesn't apply to the current dma mapping tree:

	http://git.infradead.org/users/hch/dma-mapping.git/shortlog/refs/heads/for-next

so even if I were to get the proper ACKs it would need a resend.
