Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Oct 2017 12:43:58 +0200 (CEST)
Received: from bombadil.infradead.org ([65.50.211.133]:59975 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993070AbdJCKn2lc0J1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Oct 2017 12:43:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=UVQaFwQhFMOvBfrd/m+Y3es4h5g69taSUmL7RQ7Zrpc=; b=QWxQfWXROud6Z0vewCYA7wsSf
        IdOXdA+Q7IwiMX3GKgTgWJC2oF33v/vMHNsLGZfvqnvwpj3YEHPsTVxsGxLMploDFtyBQjeoPjM2e
        aKXfHe189OzM71oKoCKp8Tl9xan1fXh7/YdykkLuil111CTL+KwnHkKEm5xxi3ALZtgd11P8cSKVC
        5ayFEg/31YK6adzeasiijYvrYK/KatLs7yDsYcYisNe1jqWcVdbl+Rx4M2kPqNvJd88+BkeKu3piI
        8o6a7gsTo4YpGDVn0YQMWo+V/Z1R2dGUK9JX2h9UD8DPOMFwVQmkxr/nn5fkj69BMlIme/XKkPB+h
        I2YOIhBaw==;
Received: from 80-109-164-210.cable.dynamic.surfer.at ([80.109.164.210] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.87 #1 (Red Hat Linux))
        id 1dzKfS-0000Mu-KR; Tue, 03 Oct 2017 10:43:15 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Michal Simek <monstr@monstr.eu>,
        David Howells <dhowells@redhat.com>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, x86@kernel.org,
        linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-xtensa@linux-xtensa.org,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: refactor dma_cache_sync V2
Date:   Tue,  3 Oct 2017 12:43:00 +0200
Message-Id: <20171003104311.10058-1-hch@lst.de>
X-Mailer: git-send-email 2.14.1
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+69bb01a06caa5cf26dd3+5154+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60222
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

The dma_cache_sync routines is used to flush caches for memory returned
by dma_alloc_attrs with the DMA_ATTR_NON_CONSISTENT flag (or previously
from dma_alloc_noncoherent), but the requirements for it seems to be
frequently misunderstood.  dma_cache_sync is documented to be a no-op for
allocations that do not have the DMA_ATTR_NON_CONSISTENT flag set, and
yet a lot of architectures implement it in some way despite not
implementing DMA_ATTR_NON_CONSISTENT.

This series removes a few abuses of dma_cache_sync for non-DMA API
purposes, then changes all remaining architectures that do not implement
DMA_ATTR_NON_CONSISTENT to implement dma_cache_sync as a no-op, and
then adds the struct dma_map_ops indirection we use for all other
DMA mapping operations to dma_cache_sync as well, thus removing all but
two implementations of the function.

Changes since V1:
 - drop the mips fd_cacheflush, merged via maintainer
 - spelling fix in last commit descriptions (thanks Geert)
