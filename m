Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Aug 2018 16:50:48 +0200 (CEST)
Received: from bombadil.infradead.org ([IPv6:2607:7c80:54:e::133]:55476 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993094AbeH0OupPgElR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 Aug 2018 16:50:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=B9B+czopVD1XDEm1zVeboVAiiwpjaQGbUi9Ag3Br6D0=; b=er3V17+hYLVlo+1qC5Sug6+rT
        5/nt4y+xRGb75e/FV9ul83Irt8MKiEneAc8Uzm/At3qhNYv8ETFEY5aKEXGWsTr9FsewR92mia+EJ
        irYlUBXffVzrBoNQGvgqtlnEzwJCAasxNW2QTuOM7iWPGmRb9aahX40zdUpqkIQysnWLZvF/kUMr7
        7qqhrD7jeRy6GFj8BdaFpYzU6n26TpKZIkBY0+q+y9ajzkEdH6rjVe6XwEJ4Jw55PTQ8twfUuoCzr
        ywaBSnzrlTWzOp7dTwbKL4q6d/fVXo1n4dXpVnv8dXbfNRiT+Mi2u47mdKamd/H0f+Hqr5WthcbIF
        5rBTcKqxg==;
Received: from 089144202128.atnat0011.highway.a1.net ([89.144.202.128] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fuIqj-0004VD-0l; Mon, 27 Aug 2018 14:50:39 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Paul Burton <paul.burton@mips.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: 
Date:   Mon, 27 Aug 2018 16:50:27 +0200
Message-Id: <20180827145032.9522-1-hch@lst.de>
X-Mailer: git-send-email 2.18.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+0060dd1d165dc04ea21d+5482+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65749
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

Subject: [RFC] merge dma_direct_ops and dma_noncoherent_ops

While most architectures are either always or never dma coherent for a
given build, the arm, arm64, mips and soon arc architectures can have
different dma coherent settings on a per-device basis.  Additionally
some mips builds can decide at boot time if dma is coherent or not.

I've started to look into handling noncoherent dma in swiotlb, and
moving the dma-iommu ops into common code [1], and for that we need a
generic way to check if a given device is coherent or not.  Moving
this flag into struct device also simplifies the conditionally coherent
architecture implementations.

These patches are also available in a git tree given that they have
a few previous posted dependencies:

    git://git.infradead.org/users/hch/misc.git dma-direct-noncoherent-merge

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-direct-noncoherent-merge
