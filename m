Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Dec 2017 09:19:36 +0100 (CET)
Received: from bombadil.infradead.org ([65.50.211.133]:42968 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990412AbdL2IT3GPKzC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 29 Dec 2017 09:19:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=uHcdiZaap4EXldpBlP5c9vLack7dyELhdTZUqUyEaRw=; b=j8zrdZDTX/UEMi3XTAomBcy+p
        Xm2/9J5nEB9NMuCmtrysk1h4BZjRvqLVAaGX1HA6rD5chqSXDb4dmod4cuc+7Uz1JUPzEAaR4fkW5
        QnPQBPKEP3MdBI3il+IW75HQfCJnYdyFn4neneHofqPyC1X6PE1BUgdPo7KxHiUrXmg2MqRsCL4X7
        EeTEex+QP+2F7a38pVI+k1sEJf5vGabXeU5nTuP9qQf098zIIy8wZ0y5iGARt0FqKR4m6i3QZMWT9
        6AbJ2ob6dWspkepipJ0Oftnylfg2UbEXtoGSxdQDOwbQ/j0VQda8tdapUpZBD3YhVjTSRoc/R3BYv
        6NTiv7J1Q==;
Received: from 77.117.237.29.wireless.dyn.drei.com ([77.117.237.29] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.89 #1 (Red Hat Linux))
        id 1eUpsr-0008IO-CL; Fri, 29 Dec 2017 08:19:18 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-c6x-dev@linux-c6x.org, linux-cris-kernel@axis.com,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org,
        Michal Simek <monstr@monstr.eu>, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        patches@groups.riscv.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        Guan Xuetao <gxt@mprc.pku.edu.cn>, x86@kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: consolidate direct dma mapping and swiotlb support
Date:   Fri, 29 Dec 2017 09:18:04 +0100
Message-Id: <20171229081911.2802-1-hch@lst.de>
X-Mailer: git-send-email 2.14.2
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+bc2f3f92dc59fc4fc549+5241+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61697
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

It then switches a large number of architectures to this generic
direct map implement and the new generic swiotlb dma_map ops.

Note that for now this only handles architectures that do cache coherent
DMA, but a similar consolidation for non-coherent architectures is in the
work for later merge windows.
