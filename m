Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 15 Nov 2015 03:04:54 +0100 (CET)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:59895 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012337AbbKOCEwT01w0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 15 Nov 2015 03:04:52 +0100
Received: from deadeye.wl.decadent.org.uk ([192.168.4.247] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84)
        (envelope-from <ben@decadent.org.uk>)
        id 1ZxmgR-0007AT-DW; Sun, 15 Nov 2015 02:04:47 +0000
Received: from ben by deadeye with local (Exim 4.86)
        (envelope-from <ben@decadent.org.uk>)
        id 1ZxmgL-0000WC-8N; Sun, 15 Nov 2015 02:04:41 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "James Hogan" <james.hogan@imgtec.com>,
        "Ralf Baechle" <ralf@linux-mips.org>, linux-mips@linux-mips.org
Date:   Sun, 15 Nov 2015 01:45:45 +0000
Message-ID: <lsq.1447551945.72310369@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 10/60] MIPS: dma-default: Fix 32-bit fall back to GFP_DMA
In-Reply-To: <lsq.1447551944.536641563@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.247
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49928
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ben@decadent.org.uk
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

3.2.73-rc1 review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/mm/dma-default.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/mm/dma-default.c
+++ b/arch/mips/mm/dma-default.c
@@ -67,7 +67,7 @@ static gfp_t massage_gfp_flags(const str
 	else
 #endif
 #if defined(CONFIG_ZONE_DMA) && !defined(CONFIG_ZONE_DMA32)
-	     if (dev->coherent_dma_mask < DMA_BIT_MASK(64))
+	     if (dev->coherent_dma_mask < DMA_BIT_MASK(sizeof(phys_addr_t) * 8))
 		dma_flag = __GFP_DMA;
 	else
 #endif
