Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Dec 2017 09:26:07 +0100 (CET)
Received: from bombadil.infradead.org ([65.50.211.133]:41238 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990921AbdL2IUj1GUFC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 29 Dec 2017 09:20:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ByUob5brYbOfJ2wJN60QiR5IInDo3xQPQKqbK+b9QmE=; b=bqI4GzSew+qOiyOkTXXQujd8H
        RoqEm4mkW66vYOsPdeD/cSdrYQ/LAzbAFnxRtgeI2+B9h7p5Xh4gM1FJ0zzC8y7cQ6+fyQNMninWI
        n89ByPNNKSunfQWQTvVnd7bZsxPqRycxImgylwEraahTUSWflh9wpYkvUXNhTwObuPjweTysX6uDb
        5imWQhR9uvFyTgksy5HjzpEY43hJjDyXmixnaZfo73nAKGNhddzURzF1a++2kk//8/4GcU8J+sPiD
        YZ2JReFvmJgbXVGxcIvIEyP4l/EEqS75+aa0788XN3dRaar+HkWCIbDTSf5dG1b81I3N8o4xH4E5m
        ogU4oLDOw==;
Received: from 77.117.237.29.wireless.dyn.drei.com ([77.117.237.29] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.89 #1 (Red Hat Linux))
        id 1eUptv-0000ns-Nb; Fri, 29 Dec 2017 08:20:24 +0000
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
Subject: [PATCH 15/67] hexagon: use the generic dma_capable helper
Date:   Fri, 29 Dec 2017 09:18:19 +0100
Message-Id: <20171229081911.2802-16-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20171229081911.2802-1-hch@lst.de>
References: <20171229081911.2802-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+bc2f3f92dc59fc4fc549+5241+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61712
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

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/hexagon/include/asm/dma-mapping.h | 7 -------
 arch/hexagon/kernel/dma.c              | 1 +
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/hexagon/include/asm/dma-mapping.h b/arch/hexagon/include/asm/dma-mapping.h
index 5208de242e79..263f6acbfb0f 100644
--- a/arch/hexagon/include/asm/dma-mapping.h
+++ b/arch/hexagon/include/asm/dma-mapping.h
@@ -37,11 +37,4 @@ static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 	return dma_ops;
 }
 
-static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
-{
-	if (!dev->dma_mask)
-		return 0;
-	return addr + size - 1 <= *dev->dma_mask;
-}
-
 #endif
diff --git a/arch/hexagon/kernel/dma.c b/arch/hexagon/kernel/dma.c
index 3683bb9c05a2..c1d24e37807c 100644
--- a/arch/hexagon/kernel/dma.c
+++ b/arch/hexagon/kernel/dma.c
@@ -19,6 +19,7 @@
  */
 
 #include <linux/dma-mapping.h>
+#include <linux/dma-direct.h>
 #include <linux/bootmem.h>
 #include <linux/genalloc.h>
 #include <asm/dma-mapping.h>
-- 
2.14.2
