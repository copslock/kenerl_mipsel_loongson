Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Sep 2018 09:02:42 +0200 (CEST)
Received: from verein.lst.de ([213.95.11.211]:47776 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990697AbeITHCjWXp2C (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 20 Sep 2018 09:02:39 +0200
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 9B08E68D7C; Thu, 20 Sep 2018 09:02:40 +0200 (CEST)
Date:   Thu, 20 Sep 2018 09:02:40 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     linux-mips@linux-mips.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Paul Burton <paul.burton@mips.com>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: merge dma_direct_ops and dma_noncoherent_ops v3
Message-ID: <20180920070240.GA13994@lst.de>
References: <20180914095808.22202-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180914095808.22202-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66429
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

I've pulled this into the dma-mapping for-next tree now to make
progress.  Any further review comments should be dealt with in
incremental patches.
