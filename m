Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Mar 2018 23:02:53 +0200 (CEST)
Received: from bhuna.collabora.co.uk ([IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3]:43916
        "EHLO bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994588AbeC1VCLhwb1C (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Mar 2018 23:02:11 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id CF9D0260844
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     Mathieu Malaterre <malat@debian.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     linux-mmc@vger.kernel.org, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>, kernel@collabora.com,
        Ezequiel Garcia <ezequiel@collabora.co.uk>
Subject: [PATCH v4 03/15] mmc: jz4780: Order headers alphabetically
Date:   Wed, 28 Mar 2018 18:00:45 -0300
Message-Id: <20180328210057.31148-4-ezequiel@collabora.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180328210057.31148-1-ezequiel@collabora.com>
References: <20180328210057.31148-1-ezequiel@collabora.com>
Return-Path: <ezequiel@collabora.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63306
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ezequiel@collabora.com
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

From: Ezequiel Garcia <ezequiel@collabora.co.uk>

Just a minor cleanup to order the headers alphabetically.
This helps prevent merge conflicts.

Tested-by: Mathieu Malaterre <malat@debian.org>
Signed-off-by: Ezequiel Garcia <ezequiel@collabora.co.uk>
---
 drivers/mmc/host/jz4740_mmc.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index 97727cd34fc1..eb57f514a459 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -13,24 +13,24 @@
  *
  */
 
-#include <linux/mmc/host.h>
-#include <linux/mmc/slot-gpio.h>
+#include <linux/bitops.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/dmaengine.h>
+#include <linux/dma-mapping.h>
 #include <linux/err.h>
+#include <linux/gpio.h>
+#include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/irq.h>
-#include <linux/interrupt.h>
+#include <linux/mmc/host.h>
+#include <linux/mmc/slot-gpio.h>
 #include <linux/module.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
-#include <linux/delay.h>
 #include <linux/scatterlist.h>
-#include <linux/clk.h>
 
-#include <linux/bitops.h>
-#include <linux/gpio.h>
 #include <asm/cacheflush.h>
-#include <linux/dma-mapping.h>
-#include <linux/dmaengine.h>
 
 #include <asm/mach-jz4740/dma.h>
 #include <asm/mach-jz4740/jz4740_mmc.h>
-- 
2.16.2
