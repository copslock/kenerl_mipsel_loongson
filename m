Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Oct 2015 14:54:09 +0100 (CET)
Received: from mx2.suse.de ([195.135.220.15]:34622 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011233AbbJ1NyHrn6x5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 28 Oct 2015 14:54:07 +0100
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9C76D7501C;
        Wed, 28 Oct 2015 13:54:25 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 3.12 071/123] MIPS: dma-default: Fix 32-bit fall back to GFP_DMA
Date:   Wed, 28 Oct 2015 14:53:02 +0100
Message-Id: <da16c372e311d6602415b79c3eea3caf93526ee8.1446021555.git.jslaby@suse.cz>
X-Mailer: git-send-email 2.6.2
In-Reply-To: <5584351853aa18c1d059ebc63948faa4aa0bbdd3.1446021555.git.jslaby@suse.cz>
References: <5584351853aa18c1d059ebc63948faa4aa0bbdd3.1446021555.git.jslaby@suse.cz>
In-Reply-To: <cover.1446021555.git.jslaby@suse.cz>
References: <cover.1446021555.git.jslaby@suse.cz>
Return-Path: <jslaby@suse.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49731
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jslaby@suse.cz
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

From: James Hogan <james.hogan@imgtec.com>

3.12-stable review patch.  If anyone has any objections, please let me know.

===============

commit 53960059d56ecef67d4ddd546731623641a3d2d1 upstream.

If there is a DMA zone (usually 24bit = 16MB I believe), but no DMA32
zone, as is the case for some 32-bit kernels, then massage_gfp_flags()
will cause DMA memory allocated for devices with a 32..63-bit
coherent_dma_mask to fall back to using __GFP_DMA, even though there may
only be 32-bits of physical address available anyway.

Correct that case to compare against a mask the size of phys_addr_t
instead of always using a 64-bit mask.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Fixes: a2e715a86c6d ("MIPS: DMA: Fix computation of DMA flags from device's coherent_dma_mask.")
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/9610/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 arch/mips/mm/dma-default.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
index 5f8b95512580..7dd78fc991bf 100644
--- a/arch/mips/mm/dma-default.c
+++ b/arch/mips/mm/dma-default.c
@@ -92,7 +92,7 @@ static gfp_t massage_gfp_flags(const struct device *dev, gfp_t gfp)
 	else
 #endif
 #if defined(CONFIG_ZONE_DMA) && !defined(CONFIG_ZONE_DMA32)
-	     if (dev->coherent_dma_mask < DMA_BIT_MASK(64))
+	     if (dev->coherent_dma_mask < DMA_BIT_MASK(sizeof(phys_addr_t) * 8))
 		dma_flag = __GFP_DMA;
 	else
 #endif
-- 
2.6.2
