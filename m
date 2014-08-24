Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Aug 2014 03:04:56 +0200 (CEST)
Received: from test.hauke-m.de ([5.39.93.123]:41406 "EHLO test.hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006615AbaHYBDBlv-UB (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 25 Aug 2014 03:03:01 +0200
Received: from hauke-desktop.lan (spit-414.wohnheim.uni-bremen.de [134.102.133.158])
        by test.hauke-m.de (Postfix) with ESMTPSA id 2D13720971;
        Sun, 24 Aug 2014 23:25:20 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org
Cc:     zajec5@gmail.com, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [RFC 5/7] bcma: get IRQ numbers from dt
Date:   Sun, 24 Aug 2014 23:24:43 +0200
Message-Id: <1408915485-8078-7-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1408915485-8078-1-git-send-email-hauke@hauke-m.de>
References: <1408915485-8078-1-git-send-email-hauke@hauke-m.de>
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42207
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

It is not possible to auto detect the irq numbers used by the cores on
an arm SoC. If bcma was registered with device tree it will search for
some device tree nodes with the irq number and add it to the core
configuration.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 drivers/bcma/main.c | 42 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/bcma/main.c b/drivers/bcma/main.c
index 0ff8d58..3f75776 100644
--- a/drivers/bcma/main.c
+++ b/drivers/bcma/main.c
@@ -10,6 +10,8 @@
 #include <linux/platform_device.h>
 #include <linux/bcma/bcma.h>
 #include <linux/slab.h>
+#include <linux/of_irq.h>
+#include <linux/of_address.h>
 
 MODULE_DESCRIPTION("Broadcom's specific AMBA driver");
 MODULE_LICENSE("GPL");
@@ -120,6 +122,38 @@ static void bcma_release_core_dev(struct device *dev)
 	kfree(core);
 }
 
+static struct device_node *bcma_of_find_child_device(struct platform_device *parent,
+						     struct bcma_device *core)
+{
+	struct device_node *node;
+	u64 size;
+	const __be32 *reg;
+
+	if (!parent || !parent->dev.of_node)
+		return NULL;
+
+	for_each_child_of_node(parent->dev.of_node, node) {
+		reg = of_get_address(node, 0, &size, NULL);
+		if (!reg)
+			continue;
+		if (be32_to_cpup(reg) == core->addr)
+			return node;
+	}
+	return NULL;
+}
+
+static void bcma_of_fill_device(struct platform_device *parent,
+				struct bcma_device *core)
+{
+	struct device_node *node;
+
+	node = bcma_of_find_child_device(parent, core);
+	if (!node)
+		return;
+	core->dev.of_node = node;
+	core->irq = irq_of_parse_and_map(node, 0);
+}
+
 static int bcma_register_cores(struct bcma_bus *bus)
 {
 	struct bcma_device *core;
@@ -155,7 +189,13 @@ static int bcma_register_cores(struct bcma_bus *bus)
 			break;
 		case BCMA_HOSTTYPE_SOC:
 			core->dev.dma_mask = &core->dev.coherent_dma_mask;
-			core->dma_dev = &core->dev;
+			if (bus->host_pdev) {
+				core->dma_dev = &bus->host_pdev->dev;
+				core->dev.parent = &bus->host_pdev->dev;
+				bcma_of_fill_device(bus->host_pdev, core);
+			} else {
+				core->dma_dev = &core->dev;
+			}
 			break;
 		case BCMA_HOSTTYPE_SDIO:
 			break;
-- 
1.9.1
