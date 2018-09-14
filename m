Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Sep 2018 11:45:15 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:33160 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994240AbeINJpCkPvnI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 14 Sep 2018 11:45:02 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id BF17F20877; Fri, 14 Sep 2018 11:44:56 +0200 (CEST)
Received: from localhost.localdomain (AAubervilliers-681-1-99-10.w90-88.abo.wanadoo.fr [90.88.4.10])
        by mail.bootlin.com (Postfix) with ESMTPSA id 6A52B206F6;
        Fri, 14 Sep 2018 11:44:56 +0200 (CEST)
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     alexandre.belloni@bootlin.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, davem@davemloft.net, andrew@lunn.ch,
        f.fainelli@gmail.com
Cc:     allan.nielsen@microchip.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com,
        antoine.tenart@bootlin.com,
        Quentin Schulz <quentin.schulz@bootlin.com>
Subject: [PATCH net-next 1/7] dt-bindings: net: vsc8531: add two additional LED modes for VSC8584
Date:   Fri, 14 Sep 2018 11:44:22 +0200
Message-Id: <f54f6cda7f505d99531e33626f8d4e6f1dc084ec.1536916714.git-series.quentin.schulz@bootlin.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.b921b010b6d6bde1c11e69551ae38f3b2818645b.1536916714.git-series.quentin.schulz@bootlin.com>
References: <cover.b921b010b6d6bde1c11e69551ae38f3b2818645b.1536916714.git-series.quentin.schulz@bootlin.com>
In-Reply-To: <cover.b921b010b6d6bde1c11e69551ae38f3b2818645b.1536916714.git-series.quentin.schulz@bootlin.com>
References: <cover.b921b010b6d6bde1c11e69551ae38f3b2818645b.1536916714.git-series.quentin.schulz@bootlin.com>
Return-Path: <quentin.schulz@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66242
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

The VSC8584 (and most likely other PHYs in the same generation) has two
additional LED modes that can be picked, so let's add them.

Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
---
 include/dt-bindings/net/mscc-phy-vsc8531.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/dt-bindings/net/mscc-phy-vsc8531.h b/include/dt-bindings/net/mscc-phy-vsc8531.h
index 697161f..9eb2ec2 100644
--- a/include/dt-bindings/net/mscc-phy-vsc8531.h
+++ b/include/dt-bindings/net/mscc-phy-vsc8531.h
@@ -18,9 +18,11 @@
 #define VSC8531_LINK_100_1000_ACTIVITY  4
 #define VSC8531_LINK_10_1000_ACTIVITY   5
 #define VSC8531_LINK_10_100_ACTIVITY    6
+#define VSC8584_LINK_100FX_1000X_ACTIVITY	7
 #define VSC8531_DUPLEX_COLLISION        8
 #define VSC8531_COLLISION               9
 #define VSC8531_ACTIVITY                10
+#define VSC8584_100FX_1000X_ACTIVITY	11
 #define VSC8531_AUTONEG_FAULT           12
 #define VSC8531_SERIAL_MODE             13
 #define VSC8531_FORCE_LED_OFF           14
-- 
git-series 0.9.1
