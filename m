Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Oct 2015 14:45:04 +0100 (CET)
Received: from youngberry.canonical.com ([91.189.89.112]:56159 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011343AbbJZNohUmWmQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 26 Oct 2015 14:44:37 +0100
Received: from 1.general.henrix.uk.vpn ([10.172.192.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <luis.henriques@canonical.com>)
        id 1Zqi4i-0000YQ-NC; Mon, 26 Oct 2015 13:44:36 +0000
From:   Luis Henriques <luis.henriques@canonical.com>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel-team@lists.ubuntu.com
Cc:     James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Luis Henriques <luis.henriques@canonical.com>
Subject: [PATCH 3.16.y-ckt 073/104] MIPS: dma-default: Fix 32-bit fall back to GFP_DMA
Date:   Mon, 26 Oct 2015 13:42:55 +0000
Message-Id: <1445867006-18048-74-git-send-email-luis.henriques@canonical.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1445867006-18048-1-git-send-email-luis.henriques@canonical.com>
References: <1445867006-18048-1-git-send-email-luis.henriques@canonical.com>
X-Extended-Stable: 3.16
Return-Path: <luis.henriques@canonical.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49698
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: luis.henriques@canonical.com
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

3.16.7-ckt19 -stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Hogan <james.hogan@imgtec.com>

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
Signed-off-by: Luis Henriques <luis.henriques@canonical.com>
---
 arch/mips/mm/dma-default.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
index 44b6dff5aba2..a1087593b3c2 100644
--- a/arch/mips/mm/dma-default.c
+++ b/arch/mips/mm/dma-default.c
@@ -94,7 +94,7 @@ static gfp_t massage_gfp_flags(const struct device *dev, gfp_t gfp)
 	else
 #endif
 #if defined(CONFIG_ZONE_DMA) && !defined(CONFIG_ZONE_DMA32)
-	     if (dev->coherent_dma_mask < DMA_BIT_MASK(64))
+	     if (dev->coherent_dma_mask < DMA_BIT_MASK(sizeof(phys_addr_t) * 8))
 		dma_flag = __GFP_DMA;
 	else
 #endif
