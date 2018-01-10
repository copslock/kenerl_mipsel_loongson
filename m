Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Jan 2018 09:00:53 +0100 (CET)
Received: from bombadil.infradead.org ([65.50.211.133]:53187 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991619AbeAJIAq1uAmS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Jan 2018 09:00:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SOywdknrZ4bbNdt4Uig2NdNyk/e51kyVkWYDr2cMVJ8=; b=Wf8bk37GdXU6lEh3iz/vA69WN
        XqaH/ORCCoeA9/iSmMd1EYYr7qXLFQiYungbsBR21tUmEUSiE+7NQqEL9FGSchrQDZu01vwoC7pcb
        6v4rgfMx4hNxeEDUvvzMC7+7Kizjpz7w4kio1AiVOeVDcCRRlO3pzo72mgjf4uIzm7OvdrkykpvXH
        6nEdfwIna9TIsqV7+RkyuFs++PzE4PoPxdoZ45O3wkJxOOAoX5y3ruudhslAyIQdo7KA9Woh4L0f/
        z2q6T8zjoJLP1/HNGssL++MxSyJpXVe/Odxv5CLFWwsF6xIiVrdhJpXxQf+vrcdYrwgFuxm4K856i
        t3379dkYw==;
Received: from clnet-p099-196.ikbnet.co.at ([83.175.99.196] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.89 #1 (Red Hat Linux))
        id 1eZBJH-0003yJ-4R; Wed, 10 Jan 2018 08:00:31 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Konrad Rzeszutek Wilk <konrad@darnok.org>,
        linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        linux-cris-kernel@axis.com, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-metag@vger.kernel.org, Michal Simek <monstr@monstr.eu>,
        linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, patches@groups.riscv.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>,
        x86@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: consolidate direct dma mapping V3
Date:   Wed, 10 Jan 2018 08:59:54 +0100
Message-Id: <20180110080027.13879-1-hch@lst.de>
X-Mailer: git-send-email 2.14.2
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+ddff6d03254b98e050e8+5253+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61965
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

Almost every architecture supports a direct dma mapping implementation,
where no iommu is used and the device dma address is a 1:1 mapping to
the physical address or has a simple linear offset.  Currently the
code for this implementation is most duplicated over the architectures,
and the duplicated again in the swiotlb code, and then duplicated again
for special cases like the x86 memory encryption DMA ops.

This series takes the existing very simple dma-noop dma mapping
implementation, enhances it with all the x86 features and quirks, and
creates a common set of architecture hooks for it and the swiotlb code.

It then switches a number of architectures to this generic
direct map implemention.

Note that for now this only handles architectures that do cache coherent
DMA, but a similar consolidation for non-coherent architectures is in the
work for later merge windows.

A git tree is also available:

   git://git.infradead.org/users/hch/misc.git dma-direct.3

Gitweb:

   http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-direct.3

Changes since V1:
 - fixed a few patch description typos
 - fixed a few printk formats
 - fixed an off by one in dma_coherent_ok
 - add a few Reviewed-by/Acked-by tags.
 - moved the swiotlb consolidation to a new series
 - dropped a few patches for now to not overwhelem the x86
   maintainers.  They will be resubmitted in the next merge window
