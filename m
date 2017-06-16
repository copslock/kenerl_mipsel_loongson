Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jun 2017 20:11:17 +0200 (CEST)
Received: from bombadil.infradead.org ([65.50.211.133]:50639 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994824AbdFPSLKQbC3W (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Jun 2017 20:11:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=41KyiF2F2DWxIRbSvuXvB+YeQ1lQaKy72q70xwqtfwY=; b=jvwxIOJNuTIbiA+Bvx9+xA5YP
        hm9SWuBM21AkR4HkfU3qGsSsnbHIfzD3V+zzFV8+SIv5ZTA6diCkZ2LKOBfLLxaIxB4kLw525b/jC
        0C2IxfI/RFHJ7gLyyOQ+PYsYXSN9FfcPQ4mgv0h3uW+WbtIRUCnQpvirj+1kQPJmzbJQfM/062Tjs
        C8fDBhq6FSyB2lWQ1tP8eERVm8ZPnQOCv5VBB4uzczF92Q8g99m1cUumT3Wu77BCi6TqOspLxtfUg
        ZAzIUxQbtw0FbDc5NQLm8fjAS0czt2dhQjE+U+PG2kFwkdCGR3T4k3J/bUw6UfMIBV/hYBfP1kFBD
        n4ULYpqoA==;
Received: from clnet-p099-196.ikbnet.co.at ([83.175.99.196] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.87 #1 (Red Hat Linux))
        id 1dLvi2-00043r-UL; Fri, 16 Jun 2017 18:11:03 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        xen-devel@lists.xenproject.org, linux-c6x-dev@linux-c6x.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, openrisc@lists.librecores.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, dmaengine@vger.kernel.org,
        linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-samsung-soc@vger.kernel.org,
        iommu@lists.linux-foundation.org, netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: clean up and modularize arch dma_mapping interface V2
Date:   Fri, 16 Jun 2017 20:10:15 +0200
Message-Id: <20170616181059.19206-1-hch@lst.de>
X-Mailer: git-send-email 2.11.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+48ca1ab4adaecdf09dc3+5045+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58531
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

Hi all,

for a while we have a generic implementation of the dma mapping routines
that call into per-arch or per-device operations.  But right now there
still are various bits in the interfaces where don't clearly operate
on these ops.  This series tries to clean up a lot of those (but not all
yet, but the series is big enough).  It gets rid of the DMA_ERROR_CODE
way of signaling failures of the mapping routines from the
implementations to the generic code (and cleans up various drivers that
were incorrectly using it), and gets rid of the ->set_dma_mask routine
in favor of relying on the ->dma_capable method that can be used in
the same way, but which requires less code duplication.

I've got a good number of reviews last time, but a few are still missing.
I'd love to not have to re-spam everyone with this patchbomb, so early
ACKs (or complaints) are welcome.

I plan to create a new dma-mapping tree to collect all this work.
Any volunteers for co-maintainers, especially from the iommu gang?

The whole series is also available in git:

    git://git.infradead.org/users/hch/misc.git dma-map

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-map

Changes since V1:
 - remove two lines of code from arm dmabounce
 - a few commit message tweaks
 - lots of ACKs
