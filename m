Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Nov 2017 09:35:07 +0100 (CET)
Received: from verein.lst.de ([213.95.11.211]:49271 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992241AbdKTIfAXHCIL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 20 Nov 2017 09:35:00 +0100
Received: by newverein.lst.de (Postfix, from userid 2407)
        id CAEDC68CFD; Mon, 20 Nov 2017 09:34:59 +0100 (CET)
Date:   Mon, 20 Nov 2017 09:34:59 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Fuxin Zhang <zhangfx@lemote.com>, linux-mips@linux-mips.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Pawel Osciak <pawel@osciak.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Michael Chan <michael.chan@broadcom.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ivan Mikhaylov <ivan@ru.ibm.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Andy Gross <agross@codeaurora.org>,
        Robert Baldyga <r.baldyga@hackerion.com>
Subject: Re: [PATCH V10 1/4] dma-mapping: Rework dma_get_cache_alignment()
Message-ID: <20171120083459.GA28235@lst.de>
References: <1510892872-32696-1-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1510892872-32696-1-git-send-email-chenhc@lemote.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61019
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

Please send the scsi fixes on their own for now so that the rework
can go into 4.16.  If you don't want to do it I'll do it myself
and will send them to Martin for now you can the rebase the dma-mapping
and mips work after that.
