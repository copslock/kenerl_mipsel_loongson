Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 15 Sep 2018 14:10:01 +0200 (CEST)
Received: from mx2.mailbox.org ([80.241.60.215]:58582 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992482AbeIOMJSJbLN2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 15 Sep 2018 14:09:18 +0200
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 72E4F41A5F;
        Sat, 15 Sep 2018 14:09:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
        with ESMTP id 4KchZA8hN2Yc; Sat, 15 Sep 2018 14:09:11 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     davem@davemloft.net
Cc:     netdev@vger.kernel.org, andrew@lunn.ch,
        vivien.didelot@savoirfairelinux.com, f.fainelli@gmail.com,
        john@phrozen.org, linux-mips@linux-mips.org, dev@kresin.me,
        hauke.mehrtens@intel.com, devicetree@vger.kernel.org,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH net-next 4/5] net: dsa: lantiq_gswip: Minor code style improvements
Date:   Sat, 15 Sep 2018 14:08:48 +0200
Message-Id: <20180915120849.24630-5-hauke@hauke-m.de>
In-Reply-To: <20180915120849.24630-1-hauke@hauke-m.de>
References: <20180915120849.24630-1-hauke@hauke-m.de>
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66329
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

Use one code block when returning because the interface type is
unsupported and also check if some unsupported port gets configured.
In addition fix a double the and use dsa_is_cpu_port() instated of
manually getting the CPU port.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 drivers/net/dsa/lantiq_gswip.c | 38 ++++++++++++++++++--------------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/drivers/net/dsa/lantiq_gswip.c b/drivers/net/dsa/lantiq_gswip.c
index 9c28d0b2fcdb..4e3732b5790f 100644
--- a/drivers/net/dsa/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq_gswip.c
@@ -615,32 +615,24 @@ static void gswip_phylink_validate(struct dsa_switch *ds, int port,
 		if (!phy_interface_mode_is_rgmii(state->interface) &&
 		    state->interface != PHY_INTERFACE_MODE_MII &&
 		    state->interface != PHY_INTERFACE_MODE_REVMII &&
-		    state->interface != PHY_INTERFACE_MODE_RMII) {
-			bitmap_zero(supported, __ETHTOOL_LINK_MODE_MASK_NBITS);
-			dev_err(ds->dev,
-			"Unsupported interface: %d\n", state->interface);
-			return;
-		}
+		    state->interface != PHY_INTERFACE_MODE_RMII)
+			goto unsupported;
 		break;
 	case 2:
 	case 3:
 	case 4:
-		if (state->interface != PHY_INTERFACE_MODE_INTERNAL) {
-			bitmap_zero(supported, __ETHTOOL_LINK_MODE_MASK_NBITS);
-			dev_err(ds->dev,
-			"Unsupported interface: %d\n", state->interface);
-			return;
-		}
+		if (state->interface != PHY_INTERFACE_MODE_INTERNAL)
+			goto unsupported;
 		break;
 	case 5:
 		if (!phy_interface_mode_is_rgmii(state->interface) &&
-		    state->interface != PHY_INTERFACE_MODE_INTERNAL) {
-			bitmap_zero(supported, __ETHTOOL_LINK_MODE_MASK_NBITS);
-			dev_err(ds->dev,
-			"Unsupported interface: %d\n", state->interface);
-			return;
-		}
+		    state->interface != PHY_INTERFACE_MODE_INTERNAL)
+			goto unsupported;
 		break;
+	default:
+		bitmap_zero(supported, __ETHTOOL_LINK_MODE_MASK_NBITS);
+		dev_err(ds->dev, "Unsupported port: %i\n", port);
+		return;
 	}
 
 	/* Allow all the expected bits */
@@ -667,6 +659,12 @@ static void gswip_phylink_validate(struct dsa_switch *ds, int port,
 		   __ETHTOOL_LINK_MODE_MASK_NBITS);
 	bitmap_and(state->advertising, state->advertising, mask,
 		   __ETHTOOL_LINK_MODE_MASK_NBITS);
+	return;
+
+unsupported:
+	bitmap_zero(supported, __ETHTOOL_LINK_MODE_MASK_NBITS);
+	dev_err(ds->dev, "Unsupported interface: %d\n", state->interface);
+	return;
 }
 
 static void gswip_phylink_mac_config(struct dsa_switch *ds, int port,
@@ -970,7 +968,7 @@ static int gswip_gphy_fw_list(struct gswip_priv *priv,
 	int err;
 	int i = 0;
 
-	/* The The VRX200 rev 1.1 uses the GSWIP 2.0 and needs the older
+	/* The VRX200 rev 1.1 uses the GSWIP 2.0 and needs the older
 	 * GPHY firmware. The VRX200 rev 1.2 uses the GSWIP 2.1 and also
 	 * needs a different GPHY firmware.
 	 */
@@ -1097,7 +1095,7 @@ static int gswip_probe(struct platform_device *pdev)
 		dev_err(dev, "dsa switch register failed: %i\n", err);
 		goto mdio_bus;
 	}
-	if (priv->ds->dst->cpu_dp->index != priv->hw_info->cpu_port) {
+	if (!dsa_is_cpu_port(priv->ds, priv->hw_info->cpu_port)) {
 		dev_err(dev, "wrong CPU port defined, HW only supports port: %i",
 			priv->hw_info->cpu_port);
 		err = -EINVAL;
-- 
2.11.0
