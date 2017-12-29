Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Dec 2017 09:20:54 +0100 (CET)
Received: from bombadil.infradead.org ([65.50.211.133]:37874 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990436AbdL2ITs5QfPC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 29 Dec 2017 09:19:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vdePqvUj61iE5s31eV5JeBeZN5vOIc09n73lsDtN5eM=; b=sYXC/8xbrowSOX76dPUBVx+RZ
        /woozOCIl6fmD/3HdHpZ6UcGQ8uNNXQWam7NITnKt6M73c8M4vo+fEzodY3KVhtTw6+NCp4QvTGG+
        vY9tfwd7CkQXqA245dxbEDH5BvTTZsd4CcPPtk1Fq0KU7JYzq55N7GOUz/vVkOYbz2cgFQ1ul4rxq
        JUJbwFw/jTSmlLIMm7qQK25RpM/Nt+TZiUOZ7IAtvBl3dqfKzLjjU3pwBLH+dhdc2hsBxGNW7bfYw
        lbrpMuodPclylsVdJcTENbzjr9yg7t1dZNArrGrGWkBMK7LaxJrMtcrM0T8lKSVMI3cdLjZ8LrnQZ
        xaoK354SQ==;
Received: from 77.117.237.29.wireless.dyn.drei.com ([77.117.237.29] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.89 #1 (Red Hat Linux))
        id 1eUpt4-0008LP-7J; Fri, 29 Dec 2017 08:19:30 +0000
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
Subject: [PATCH 03/67] dma-mapping: take dma_pfn_offset into account in dma_max_pfn
Date:   Fri, 29 Dec 2017 09:18:07 +0100
Message-Id: <20171229081911.2802-4-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20171229081911.2802-1-hch@lst.de>
References: <20171229081911.2802-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+bc2f3f92dc59fc4fc549+5241+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61700
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

This makes sure the generic version can be used with architectures /
devices that have a DMA offset in the direct mapping.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/dma-mapping.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 81ed9b2d84dc..d84951865be7 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -692,7 +692,7 @@ static inline int dma_set_seg_boundary(struct device *dev, unsigned long mask)
 #ifndef dma_max_pfn
 static inline unsigned long dma_max_pfn(struct device *dev)
 {
-	return *dev->dma_mask >> PAGE_SHIFT;
+	return (*dev->dma_mask >> PAGE_SHIFT) + dev->dma_pfn_offset;
 }
 #endif
 
-- 
2.14.2
