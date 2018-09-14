Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Sep 2018 11:45:40 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:33184 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994248AbeINJpD0PWkI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 14 Sep 2018 11:45:03 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 787EE208B7; Fri, 14 Sep 2018 11:44:57 +0200 (CEST)
Received: from localhost.localdomain (AAubervilliers-681-1-99-10.w90-88.abo.wanadoo.fr [90.88.4.10])
        by mail.bootlin.com (Postfix) with ESMTPSA id 1FF69206F6;
        Fri, 14 Sep 2018 11:44:57 +0200 (CEST)
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
Subject: [PATCH net-next 3/7] net: phy: mscc: split config_init in two functions for VSC8584
Date:   Fri, 14 Sep 2018 11:44:24 +0200
Message-Id: <5daa7f3e467b218410238ef0fb97f01779f8f49f.1536916714.git-series.quentin.schulz@bootlin.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.b921b010b6d6bde1c11e69551ae38f3b2818645b.1536916714.git-series.quentin.schulz@bootlin.com>
References: <cover.b921b010b6d6bde1c11e69551ae38f3b2818645b.1536916714.git-series.quentin.schulz@bootlin.com>
In-Reply-To: <cover.b921b010b6d6bde1c11e69551ae38f3b2818645b.1536916714.git-series.quentin.schulz@bootlin.com>
References: <cover.b921b010b6d6bde1c11e69551ae38f3b2818645b.1536916714.git-series.quentin.schulz@bootlin.com>
Return-Path: <quentin.schulz@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66244
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

Part of the config init is common between the VSC8584 and the VSC8574,
so to prepare the upcoming support for VSC8574, separate config_init
PHY-specific code to config_pre_init function which is set in the probe
function of the PHY and used in config_init.

Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
---
 drivers/net/phy/mscc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/mscc.c b/drivers/net/phy/mscc.c
index b450489..69cc3cf 100644
--- a/drivers/net/phy/mscc.c
+++ b/drivers/net/phy/mscc.c
@@ -355,6 +355,7 @@ struct vsc8531_private {
 	u64 *stats;
 	int nstats;
 	bool pkg_init;
+	int (*config_pre_init)(struct mii_bus *bus, int phy);
 };
 
 #ifdef CONFIG_OF_MDIO
@@ -1298,7 +1299,7 @@ static int vsc8584_config_init(struct phy_device *phydev)
 	 */
 	if (!vsc8584_is_pkg_init(phydev, base_addr,
 				 val & PHY_ADDR_REVERSED ? 1 : 0)) {
-		ret = vsc8584_config_pre_init(phydev->mdio.bus, base_addr);
+		ret = vsc8531->config_pre_init(phydev->mdio.bus, base_addr);
 		if (ret)
 			goto err;
 	}
@@ -1486,6 +1487,7 @@ static int vsc8584_probe(struct phy_device *phydev)
 
 	phydev->priv = vsc8531;
 
+	vsc8531->config_pre_init = vsc8584_config_pre_init;
 	vsc8531->nleds = 4;
 	vsc8531->supp_led_modes = VSC8584_SUPP_LED_MODES;
 	vsc8531->hw_stats = vsc8584_hw_stats;
-- 
git-series 0.9.1
