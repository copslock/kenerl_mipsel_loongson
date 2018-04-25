Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Apr 2018 07:18:57 +0200 (CEST)
Received: from bombadil.infradead.org ([IPv6:2607:7c80:54:e::133]:34072 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994684AbeDYFQrGtupp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Apr 2018 07:16:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6WwaejUOU61TxEhlpk/5OaNVRJuy50sBBJXT6h5b7KA=; b=ZIEZ8zDG4INT9SiebbiO7K5x0
        VipetctMtytQT/LGWGf9ZVloKOMbWpqWSAZGYUBUlZkK7SbSqDNt3kgl9TkEosaFs9sT4J5THefLX
        B2ZaKZ9agaG1FOmumeSE0DZ/3mo6r4AGQcq4rPjLk3gJ/I4wjs70pwxezVmyWl2uZYtOYcKsLVdXY
        DswaXImrGVqLuUE5rexBu1ei3Sow161rmX/lW5UCEGarJ4Pxc6MPRwwpbVEk4Q7eNJdoeg4nJCgsL
        PLD/RDhkqDPUR2mPxdPoO3qFAqAtu+G81MTLRc4TktjhwrCF4Hm0rPrBaYNt08UQITNt7BY1xONzH
        fUO9HGi1w==;
Received: from [93.83.86.253] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fBCmx-0005JW-RB; Wed, 25 Apr 2018 05:16:20 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        iommu@lists.linux-foundation.org
Cc:     sstabellini@kernel.org, x86@kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, linux-mips@linux-mips.org,
        sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 11/13] mips,unicore32: swiotlb doesn't need sg->dma_length
Date:   Wed, 25 Apr 2018 07:15:37 +0200
Message-Id: <20180425051539.1989-12-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425051539.1989-1-hch@lst.de>
References: <20180425051539.1989-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+8b59ddf2a3dd4691ec7e+5358+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63753
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

Only mips and unicore32 select CONFIG_NEED_SG_DMA_LENGTH when building
swiotlb.  swiotlb itself never merges segements and doesn't accesses the
dma_length field directly, so drop the dependency.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/mips/cavium-octeon/Kconfig | 1 -
 arch/mips/loongson64/Kconfig    | 1 -
 arch/unicore32/mm/Kconfig       | 1 -
 3 files changed, 3 deletions(-)

diff --git a/arch/mips/cavium-octeon/Kconfig b/arch/mips/cavium-octeon/Kconfig
index 5d73041547a7..eb5faeed4f66 100644
--- a/arch/mips/cavium-octeon/Kconfig
+++ b/arch/mips/cavium-octeon/Kconfig
@@ -70,7 +70,6 @@ config CAVIUM_OCTEON_LOCK_L2_MEMCPY
 config SWIOTLB
 	def_bool y
 	select DMA_DIRECT_OPS
-	select NEED_SG_DMA_LENGTH
 
 config OCTEON_ILM
 	tristate "Module to measure interrupt latency using Octeon CIU Timer"
diff --git a/arch/mips/loongson64/Kconfig b/arch/mips/loongson64/Kconfig
index 641a1477031e..2a4fb91adbb6 100644
--- a/arch/mips/loongson64/Kconfig
+++ b/arch/mips/loongson64/Kconfig
@@ -135,7 +135,6 @@ config SWIOTLB
 	default y
 	depends on CPU_LOONGSON3
 	select DMA_DIRECT_OPS
-	select NEED_SG_DMA_LENGTH
 	select NEED_DMA_MAP_STATE
 
 config PHYS48_TO_HT40
diff --git a/arch/unicore32/mm/Kconfig b/arch/unicore32/mm/Kconfig
index 1d9fed0ada71..45b7f769375e 100644
--- a/arch/unicore32/mm/Kconfig
+++ b/arch/unicore32/mm/Kconfig
@@ -43,4 +43,3 @@ config CPU_TLB_SINGLE_ENTRY_DISABLE
 config SWIOTLB
 	def_bool y
 	select DMA_DIRECT_OPS
-	select NEED_SG_DMA_LENGTH
-- 
2.17.0
