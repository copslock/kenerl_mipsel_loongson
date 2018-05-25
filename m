Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 May 2018 11:28:10 +0200 (CEST)
Received: from bombadil.infradead.org ([IPv6:2607:7c80:54:e::133]:51320 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993874AbeEYJWflO2hA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 25 May 2018 11:22:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ygIkm2DsfROKerydEdY/LwWHXCw2JpCbUXzKIPvmOks=; b=KV9HVnVRiULaXah5wcdThmf9H
        PLZzSf0wbC+3azkkWC4RZip9j+ZzugVHWuhHqUkx/YCvuDkICP3jbJLiZ4AQNrmCxFr82pYxsHQuJ
        +meb0hwkeSnNq0dAJquCxvS+74eyriqpmYev4RcPCtfkU0uY32czA1HKwokgEcpejpRkQq++8bgcF
        hg6enJ9X6c3GuOGxBpPY5gwkHVFJXVt8J0Nz6dMlyPQau3NGcsfaPAsUlTW3trG+agbtCrVb0vTs5
        B+JPqtqEmLfhwxUFcvUkPE8GwItPN6OiBKEluvmFqVYMvAmBzfIxvPi3tN5aNvKwKylOF6/XxIcxM
        aCKDfH8SQ==;
Received: from 80-109-164-210.cable.dynamic.surfer.at ([80.109.164.210] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fM8vi-00020x-71; Fri, 25 May 2018 09:22:34 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>
Cc:     Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        David Daney <david.daney@cavium.com>,
        Tom Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@linux-mips.org, iommu@lists.linux-foundation.org
Subject: [PATCH 25/25] MIPS: remove unneeded includes from dma-mapping.h
Date:   Fri, 25 May 2018 11:21:11 +0200
Message-Id: <20180525092111.18516-26-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180525092111.18516-1-hch@lst.de>
References: <20180525092111.18516-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+5cb9c4fab7748cb05a15+5388+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64038
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

Keep this file as light as possible as it gets pulled into every
driver using dma mapping APIs.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/mips/include/asm/dma-mapping.h | 8 --------
 arch/mips/mti-malta/malta-setup.c   | 1 +
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/mips/include/asm/dma-mapping.h b/arch/mips/include/asm/dma-mapping.h
index 143250986e17..1c6e0c8ef483 100644
--- a/arch/mips/include/asm/dma-mapping.h
+++ b/arch/mips/include/asm/dma-mapping.h
@@ -2,14 +2,6 @@
 #ifndef _ASM_DMA_MAPPING_H
 #define _ASM_DMA_MAPPING_H
 
-#include <linux/scatterlist.h>
-#include <asm/dma-coherence.h>
-#include <asm/cache.h>
-
-#ifndef CONFIG_SGI_IP27 /* Kludge to fix 2.6.39 build for IP27 */
-#include <dma-coherence.h>
-#endif
-
 extern const struct dma_map_ops jazz_dma_ops;
 extern const struct dma_map_ops mips_swiotlb_ops;
 
diff --git a/arch/mips/mti-malta/malta-setup.c b/arch/mips/mti-malta/malta-setup.c
index 4d5cdfeee3db..7cb7d5a42087 100644
--- a/arch/mips/mti-malta/malta-setup.c
+++ b/arch/mips/mti-malta/malta-setup.c
@@ -26,6 +26,7 @@
 #include <linux/screen_info.h>
 #include <linux/time.h>
 
+#include <asm/dma-coherence.h>
 #include <asm/fw/fw.h>
 #include <asm/mach-malta/malta-dtshim.h>
 #include <asm/mips-cps.h>
-- 
2.17.0
