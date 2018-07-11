Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jul 2018 13:39:24 +0200 (CEST)
Received: from mx2.suse.de ([195.135.220.15]:52474 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993880AbeGKLjHWfHw0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 11 Jul 2018 13:39:07 +0200
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 862F2AD82;
        Wed, 11 Jul 2018 11:39:00 +0000 (UTC)
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] mips: Fix mips_dma_map_sg by using correct dma mapping function
Date:   Wed, 11 Jul 2018 13:38:51 +0200
Message-Id: <20180711113852.2734-1-tbogendoerfer@suse.de>
X-Mailer: git-send-email 2.13.7
Return-Path: <tbogendoerfer@suse.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64786
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbogendoerfer@suse.de
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

sg list elements could cover more than one page of data. Therefore
using plat_map_dma_mem_page() doesn't work for platforms, which have
IOMMU functionality hidden behind plat_map_dma_XXX functions.

Fixes: e36863a550da ("MIPS: HIGHMEM DMA on noncoherent MIPS32 processors")
Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
---
 arch/mips/mm/dma-default.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
index f9fef0028ca2..2718185a3d38 100644
--- a/arch/mips/mm/dma-default.c
+++ b/arch/mips/mm/dma-default.c
@@ -288,8 +288,8 @@ static int mips_dma_map_sg(struct device *dev, struct scatterlist *sglist,
 #ifdef CONFIG_NEED_SG_DMA_LENGTH
 		sg->dma_length = sg->length;
 #endif
-		sg->dma_address = plat_map_dma_mem_page(dev, sg_page(sg)) +
-				  sg->offset;
+		sg->dma_address = plat_map_dma_mem(dev, sg_virt(sg),
+						   sg->length);
 	}
 
 	return nents;
-- 
2.13.7
