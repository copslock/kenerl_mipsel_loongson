Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jul 2018 13:39:12 +0200 (CEST)
Received: from mx2.suse.de ([195.135.220.15]:52464 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993874AbeGKLjFo92o0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 11 Jul 2018 13:39:05 +0200
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 03857AD74;
        Wed, 11 Jul 2018 11:39:00 +0000 (UTC)
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] mips/jazz: provide dma_mask/coherent_dma_mask for platform devices
Date:   Wed, 11 Jul 2018 13:38:52 +0200
Message-Id: <20180711113852.2734-2-tbogendoerfer@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20180711113852.2734-1-tbogendoerfer@suse.de>
References: <20180711113852.2734-1-tbogendoerfer@suse.de>
Return-Path: <tbogendoerfer@suse.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64785
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

platform devices for sonic and esp didn't have dma_masks.

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
