Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jul 2018 15:43:18 +0200 (CEST)
Received: from mx2.suse.de ([195.135.220.15]:45620 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993889AbeGLNnKKJvxA (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 12 Jul 2018 15:43:10 +0200
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 38447ACC7;
        Thu, 12 Jul 2018 13:43:02 +0000 (UTC)
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mips/jazz: provide missing dma_mask/coherent_dma_mask
Date:   Thu, 12 Jul 2018 15:42:55 +0200
Message-Id: <20180712134255.30748-1-tbogendoerfer@suse.de>
X-Mailer: git-send-email 2.13.7
Return-Path: <tbogendoerfer@suse.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64816
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

Commit 205e1b7f51e4 ("dma-mapping: warn when there is no coherent_dma_mask")
introduced a warning, if a device is missing a coherent_dma_mask.
ESP and sonic are using dma mapping functions, so they need dma masks.

Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
---
 arch/mips/jazz/setup.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/mips/jazz/setup.c b/arch/mips/jazz/setup.c
index 448fd41792e4..1b5e121c3f0d 100644
--- a/arch/mips/jazz/setup.c
+++ b/arch/mips/jazz/setup.c
@@ -16,6 +16,7 @@
 #include <linux/screen_info.h>
 #include <linux/platform_device.h>
 #include <linux/serial_8250.h>
+#include <linux/dma-mapping.h>
 
 #include <asm/jazz.h>
 #include <asm/jazzdma.h>
@@ -136,10 +137,16 @@ static struct resource jazz_esp_rsrc[] = {
 	}
 };
 
+static u64 jazz_esp_dma_mask = DMA_BIT_MASK(32);
+
 static struct platform_device jazz_esp_pdev = {
 	.name		= "jazz_esp",
 	.num_resources	= ARRAY_SIZE(jazz_esp_rsrc),
-	.resource	= jazz_esp_rsrc
+	.resource	= jazz_esp_rsrc,
+	.dev = {
+		.dma_mask	   = &jazz_esp_dma_mask,
+		.coherent_dma_mask = DMA_BIT_MASK(32),
+	}
 };
 
 static struct resource jazz_sonic_rsrc[] = {
@@ -155,10 +162,16 @@ static struct resource jazz_sonic_rsrc[] = {
 	}
 };
 
+static u64 jazz_sonic_dma_mask = DMA_BIT_MASK(32);
+
 static struct platform_device jazz_sonic_pdev = {
 	.name		= "jazzsonic",
 	.num_resources	= ARRAY_SIZE(jazz_sonic_rsrc),
-	.resource	= jazz_sonic_rsrc
+	.resource	= jazz_sonic_rsrc,
+	.dev = {
+		.dma_mask	   = &jazz_sonic_dma_mask,
+		.coherent_dma_mask = DMA_BIT_MASK(32),
+	}
 };
 
 static struct resource jazz_cmos_rsrc[] = {
-- 
2.13.7
