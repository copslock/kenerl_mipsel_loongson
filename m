Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Sep 2018 10:17:22 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:58164 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992066AbeINIQrgTfnY (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 14 Sep 2018 10:16:47 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 9F2B8207D4; Fri, 14 Sep 2018 10:16:41 +0200 (CEST)
Received: from localhost.localdomain (AAubervilliers-681-1-99-10.w90-88.abo.wanadoo.fr [90.88.4.10])
        by mail.bootlin.com (Postfix) with ESMTPSA id 41F502080A;
        Fri, 14 Sep 2018 10:16:31 +0200 (CEST)
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     alexandre.belloni@bootlin.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, davem@davemloft.net, kishon@ti.com,
        andrew@lunn.ch, f.fainelli@gmail.com
Cc:     allan.nielsen@microchip.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com,
        Quentin Schulz <quentin.schulz@bootlin.com>
Subject: [PATCH net-next v3 03/11] net: mscc: ocelot: get HSIO regmap from syscon
Date:   Fri, 14 Sep 2018 10:16:01 +0200
Message-Id: <d9b23949e81272006e076e0b58d90e0541f80c7f.1536912834.git-series.quentin.schulz@bootlin.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.ff40d591b548a6da31716e6e600f11a303e0e643.1536912834.git-series.quentin.schulz@bootlin.com>
References: <cover.ff40d591b548a6da31716e6e600f11a303e0e643.1536912834.git-series.quentin.schulz@bootlin.com>
In-Reply-To: <cover.ff40d591b548a6da31716e6e600f11a303e0e643.1536912834.git-series.quentin.schulz@bootlin.com>
References: <cover.ff40d591b548a6da31716e6e600f11a303e0e643.1536912834.git-series.quentin.schulz@bootlin.com>
Return-Path: <quentin.schulz@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66227
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quentin.schulz@bootlin.com
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

HSIO address space was moved to a syscon, hence we need to get the
regmap of this address space from there and no more from the device
node.

Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
---
 drivers/net/ethernet/mscc/ocelot_board.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mscc/ocelot_board.c b/drivers/net/ethernet/mscc/ocelot_board.c
index 26bb3b1..b7d755b 100644
--- a/drivers/net/ethernet/mscc/ocelot_board.c
+++ b/drivers/net/ethernet/mscc/ocelot_board.c
@@ -9,6 +9,7 @@
 #include <linux/netdevice.h>
 #include <linux/of_mdio.h>
 #include <linux/of_platform.h>
+#include <linux/mfd/syscon.h>
 #include <linux/skbuff.h>
 
 #include "ocelot.h"
@@ -162,6 +163,7 @@ static int mscc_ocelot_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	struct device_node *ports, *portnp;
 	struct ocelot *ocelot;
+	struct regmap *hsio;
 	u32 val;
 
 	struct {
@@ -173,7 +175,6 @@ static int mscc_ocelot_probe(struct platform_device *pdev)
 		{ QSYS, "qsys" },
 		{ ANA, "ana" },
 		{ QS, "qs" },
-		{ HSIO, "hsio" },
 	};
 
 	if (!np && !pdev->dev.platform_data)
@@ -196,6 +197,14 @@ static int mscc_ocelot_probe(struct platform_device *pdev)
 		ocelot->targets[res[i].id] = target;
 	}
 
+	hsio = syscon_regmap_lookup_by_compatible("mscc,ocelot-hsio");
+	if (IS_ERR(hsio)) {
+		dev_err(&pdev->dev, "missing hsio syscon\n");
+		return PTR_ERR(hsio);
+	}
+
+	ocelot->targets[HSIO] = hsio;
+
 	err = ocelot_chip_init(ocelot);
 	if (err)
 		return err;
-- 
git-series 0.9.1
