Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 May 2018 11:22:33 +0200 (CEST)
Received: from bombadil.infradead.org ([IPv6:2607:7c80:54:e::133]:50586 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992916AbeEYJV3tzg0A (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 25 May 2018 11:21:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=O5XEAFvEluCivkncBvsnLNIO2YCzMQuVcphVHLKpoXw=; b=J/VusVnDb8rKF2NwoqjhKNxn6
        Rkv11lp6nD9PnkHHNEpH00SVMlk82tw9iz+D5nPCffHiirMP++2hQEtgY9ZyqNpnue6QpIAG6sOff
        OTEz1z06Du2jPVZt/YwKdQqS1t41xnbheagQRpMh0vYaX9H5QXaNPREiBFM3DuA+1LjqAR2B/Hbwm
        YiZRSgqB9yZJ25q9SSl+TzeXTsfP5q8X5mkyCKjMQMABYMRlc7g2PFgfMowl8dWYQedWMH9+fYeW6
        uE5XpdxAL8PD/EIkAycJwMjn4/WnA4/1x/IWNZgCQd6F5xG2XMPWBs0JfbmCEMVvZXd1OKAk35Min
        CsDneiAtQ==;
Received: from 80-109-164-210.cable.dynamic.surfer.at ([80.109.164.210] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fM8uc-0001e6-Mt; Fri, 25 May 2018 09:21:27 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>
Cc:     Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        David Daney <david.daney@cavium.com>,
        Tom Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@linux-mips.org, iommu@lists.linux-foundation.org
Subject: [PATCH 04/25] MIPS: Octeon: unexport __phys_to_dma and __dma_to_phys
Date:   Fri, 25 May 2018 11:20:50 +0200
Message-Id: <20180525092111.18516-5-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180525092111.18516-1-hch@lst.de>
References: <20180525092111.18516-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+5cb9c4fab7748cb05a15+5388+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64017
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

These functions are just low-level helpers for the swiotlb and dma-direct
implementations, and should never be used by drivers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/mips/cavium-octeon/dma-octeon.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/mips/cavium-octeon/dma-octeon.c b/arch/mips/cavium-octeon/dma-octeon.c
index 7b335ab21697..e5d00c79bd26 100644
--- a/arch/mips/cavium-octeon/dma-octeon.c
+++ b/arch/mips/cavium-octeon/dma-octeon.c
@@ -13,7 +13,6 @@
 #include <linux/dma-direct.h>
 #include <linux/scatterlist.h>
 #include <linux/bootmem.h>
-#include <linux/export.h>
 #include <linux/swiotlb.h>
 #include <linux/types.h>
 #include <linux/init.h>
@@ -190,7 +189,6 @@ dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t paddr)
 
 	return ops->phys_to_dma(dev, paddr);
 }
-EXPORT_SYMBOL(__phys_to_dma);
 
 phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t daddr)
 {
@@ -200,7 +198,6 @@ phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t daddr)
 
 	return ops->dma_to_phys(dev, daddr);
 }
-EXPORT_SYMBOL(__dma_to_phys);
 
 static struct octeon_dma_map_ops octeon_linear_dma_map_ops = {
 	.dma_map_ops = {
-- 
2.17.0
