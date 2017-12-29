Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Dec 2017 09:45:31 +0100 (CET)
Received: from bombadil.infradead.org ([65.50.211.133]:33322 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994677AbdL2IXuwO17z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 29 Dec 2017 09:23:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qEJPxY82r722va3wccbE9gkR0QaVccvPVmnX2w6WlZA=; b=Xe3UpygPIT5bZiSJXvkyl3VAL
        2Y5d7eEJb6WymusDvWnjApj1dC9ZYNNuHIdUZVcg+Vq26jAlsbuk0oPTOawXP0a83tlEDzDS8zPBP
        tT164QEdL46EFmXr2W2sG17+4fhlsDZ6Es/VrYMXqtHN9zAhTm8Tzvg4pMIL01lPCk0G68HeiXok/
        WhUolVw9xRw029WO+m9wXVkpbiAVMxzkEiK2j3AYmjQ5IIsPiGwxDRVOZF6KfCAMKylAf9fvELww9
        s66v3cp2fww50xLhvgjWQdH2eAsiKqm2W40t05voC5eRM5Zhy1+6FlGB9mYdXc4BtIOXSR/McNBAS
        1RpUheL1Q==;
Received: from 77.117.237.29.wireless.dyn.drei.com ([77.117.237.29] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.89 #1 (Red Hat Linux))
        id 1eUpwx-0003hM-4D; Fri, 29 Dec 2017 08:23:31 +0000
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
Subject: [PATCH 58/67] ia64: remove an ifdef around the content of pci-dma.c
Date:   Fri, 29 Dec 2017 09:19:02 +0100
Message-Id: <20171229081911.2802-59-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20171229081911.2802-1-hch@lst.de>
References: <20171229081911.2802-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+bc2f3f92dc59fc4fc549+5241+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61755
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

The file is only compiled if CONFIG_INTEL_IOMMU is set to start with.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/ia64/kernel/pci-dma.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/ia64/kernel/pci-dma.c b/arch/ia64/kernel/pci-dma.c
index 35e0cad33b7d..b5df084c0af4 100644
--- a/arch/ia64/kernel/pci-dma.c
+++ b/arch/ia64/kernel/pci-dma.c
@@ -12,12 +12,7 @@
 #include <asm/iommu.h>
 #include <asm/machvec.h>
 #include <linux/dma-mapping.h>
-
-
-#ifdef CONFIG_INTEL_IOMMU
-
 #include <linux/kernel.h>
-
 #include <asm/page.h>
 
 dma_addr_t bad_dma_address __read_mostly;
@@ -115,5 +110,3 @@ void __init pci_iommu_alloc(void)
 	}
 #endif /* CONFIG_SWIOTLB */
 }
-
-#endif
-- 
2.14.2
