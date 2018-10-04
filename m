Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Oct 2018 14:23:40 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:52421 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994608AbeJDMW6Jdkik (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 4 Oct 2018 14:22:58 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id B034C208B5; Thu,  4 Oct 2018 14:22:51 +0200 (CEST)
Received: from localhost.localdomain (AAubervilliers-681-1-28-153.w90-88.abo.wanadoo.fr [90.88.148.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id 38E6120CFE;
        Thu,  4 Oct 2018 14:22:32 +0200 (CEST)
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     alexandre.belloni@bootlin.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, davem@davemloft.net, kishon@ti.com,
        andrew@lunn.ch, f.fainelli@gmail.com
Cc:     allan.nielsen@microchip.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com,
        Quentin Schulz <quentin.schulz@bootlin.com>
Subject: [PATCH net-next v4 04/11] net: mscc: ocelot: move the HSIO header to include/soc
Date:   Thu,  4 Oct 2018 14:22:01 +0200
Message-Id: <20181004122208.32272-5-quentin.schulz@bootlin.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181004122208.32272-1-quentin.schulz@bootlin.com>
References: <20181004122208.32272-1-quentin.schulz@bootlin.com>
Return-Path: <quentin.schulz@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66677
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

Since HSIO address space can be used by different drivers (PLL, SerDes
muxing, temperature sensor), let's move it somewhere it can be included
by all drivers.

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
---
 drivers/net/ethernet/mscc/ocelot.h                       | 2 +-
 {drivers/net/ethernet => include/soc}/mscc/ocelot_hsio.h | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename {drivers/net/ethernet => include/soc}/mscc/ocelot_hsio.h (100%)

diff --git a/drivers/net/ethernet/mscc/ocelot.h b/drivers/net/ethernet/mscc/ocelot.h
index 616bec30dfa3..d3980158c4a3 100644
--- a/drivers/net/ethernet/mscc/ocelot.h
+++ b/drivers/net/ethernet/mscc/ocelot.h
@@ -13,10 +13,10 @@
 #include <linux/if_vlan.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
+#include <soc/mscc/ocelot_hsio.h>
 
 #include "ocelot_ana.h"
 #include "ocelot_dev.h"
-#include "ocelot_hsio.h"
 #include "ocelot_qsys.h"
 #include "ocelot_rew.h"
 #include "ocelot_sys.h"
diff --git a/drivers/net/ethernet/mscc/ocelot_hsio.h b/include/soc/mscc/ocelot_hsio.h
similarity index 100%
rename from drivers/net/ethernet/mscc/ocelot_hsio.h
rename to include/soc/mscc/ocelot_hsio.h
-- 
2.17.1
