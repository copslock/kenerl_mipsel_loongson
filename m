Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Jan 2018 09:14:53 +0100 (CET)
Received: from bombadil.infradead.org ([65.50.211.133]:44453 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992170AbeAJIJniJtIS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Jan 2018 09:09:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1UUZMo5mlrsYXTAjzzhfnKwWeOydpa00tbu+ULpftag=; b=Nb6g8SN+2YOkDyMrcH2kwLCuG
        D5ap6952d0byVhFZHcvzj4f3RgcdKnkyphH6bJEcF/2b7SJTjIPVwpeZITK/FZUytO7l/AuEnXW32
        lNaWidLfzK3QFMHxi30R7xHlrF7T3l3z7tzv3me3oZ+PUhRrWT9IzSfs0aNCW/8RfCm+HhfzExu+R
        w/XWc0t359nDUrdFQaRB9vNXxBcyg9oWavNwGXbuc9E7xhuPDgy6zBYHkMztYaxrYG7ctxXZzXYKq
        pdagUpqXO5Yt3dpyqhOOdLbLB4XjHGhByhg9XxOADEdvVGWrqNl9KAbEiVw89Plz1qjRCDuwtBLDr
        UvHowZxkA==;
Received: from clnet-p099-196.ikbnet.co.at ([83.175.99.196] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.89 #1 (Red Hat Linux))
        id 1eZBS2-0007db-ND; Wed, 10 Jan 2018 08:09:35 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Konrad Rzeszutek Wilk <konrad@darnok.org>,
        Michal Simek <monstr@monstr.eu>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= 
        <ckoenig.leichtzumerken@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        x86@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: consolidate swiotlb dma_map implementations
Date:   Wed, 10 Jan 2018 09:09:10 +0100
Message-Id: <20180110080932.14157-1-hch@lst.de>
X-Mailer: git-send-email 2.14.2
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+ddff6d03254b98e050e8+5253+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61999
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

A lot of architectures have essentially identical dma_map_ops
implementations to use swiotlb.  This series adds new generic
swiotlb_alloc/free helpers that take the attrs argument exposed
in dma_map_ops, and which do an enhanced direct allocation
modelled after x86 and reused from the dma-direct code, and
then switches most architectures over to it.  The only exceptions
are mips, which requires additional cache flushing which will
need a new abstraction, and x86 itself which will be handled in
a later series with other x86 dma mapping changes.

To support the generic code a few architectures that currently
use ZONE_DMA/GFP_DMA for <= 32-bit allocations are switched to
implement ZONE_DMA32 instead.

This series is based on the previously sent series to consolidate
the direct dma mapping implementation.  A git tree with this
series as well as the prerequisites is available here:

   git://git.infradead.org/users/hch/misc.git swiotlb

Gitweb:

   http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/swiotlb
