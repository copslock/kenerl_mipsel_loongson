Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Jul 2018 14:45:35 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:38327 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993097AbeG3Mof3Pi1l (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 30 Jul 2018 14:44:35 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 90AF920908; Mon, 30 Jul 2018 14:44:25 +0200 (CEST)
Received: from localhost.localdomain (AAubervilliers-681-1-89-120.w90-88.abo.wanadoo.fr [90.88.30.120])
        by mail.bootlin.com (Postfix) with ESMTPSA id 2C3F520765;
        Mon, 30 Jul 2018 14:44:25 +0200 (CEST)
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     alexandre.belloni@bootlin.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, davem@davemloft.net
Cc:     kishon@ti.com, andrew@lunn.ch, f.fainelli@gmail.com,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        allan.nielsen@microsemi.com, thomas.petazzoni@bootlin.com,
        Quentin Schulz <quentin.schulz@bootlin.com>
Subject: [PATCH 06/10] phy: add QSGMII and PCIE modes
Date:   Mon, 30 Jul 2018 14:43:51 +0200
Message-Id: <5e716845982fb2a034bd1a9d63ce9824421fe40c.1532954208.git-series.quentin.schulz@bootlin.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.aa759035f6eefdd0bb2a5ae335dab5bd5399bd46.1532954208.git-series.quentin.schulz@bootlin.com>
References: <cover.aa759035f6eefdd0bb2a5ae335dab5bd5399bd46.1532954208.git-series.quentin.schulz@bootlin.com>
In-Reply-To: <cover.aa759035f6eefdd0bb2a5ae335dab5bd5399bd46.1532954208.git-series.quentin.schulz@bootlin.com>
References: <cover.aa759035f6eefdd0bb2a5ae335dab5bd5399bd46.1532954208.git-series.quentin.schulz@bootlin.com>
Return-Path: <quentin.schulz@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65245
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

Prepare for upcoming phys that'll handle QSGMII or PCIe.

Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
---
 include/linux/phy/phy.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index 9713aeb..03b319f 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -37,9 +37,11 @@ enum phy_mode {
 	PHY_MODE_USB_OTG,
 	PHY_MODE_SGMII,
 	PHY_MODE_2500SGMII,
+	PHY_MODE_QSGMII,
 	PHY_MODE_10GKR,
 	PHY_MODE_UFS_HS_A,
 	PHY_MODE_UFS_HS_B,
+	PHY_MODE_PCIE,
 };
 
 /**
-- 
git-series 0.9.1
