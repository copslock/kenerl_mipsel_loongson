Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Oct 2018 14:24:18 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:52459 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992907AbeJDMXEw0fHk (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 4 Oct 2018 14:23:04 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 93717207F3; Thu,  4 Oct 2018 14:22:58 +0200 (CEST)
Received: from localhost.localdomain (AAubervilliers-681-1-28-153.w90-88.abo.wanadoo.fr [90.88.148.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id D791520DBD;
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
Subject: [PATCH net-next v4 06/11] phy: add QSGMII and PCIE modes
Date:   Thu,  4 Oct 2018 14:22:03 +0200
Message-Id: <20181004122208.32272-7-quentin.schulz@bootlin.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181004122208.32272-1-quentin.schulz@bootlin.com>
References: <20181004122208.32272-1-quentin.schulz@bootlin.com>
Return-Path: <quentin.schulz@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66680
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

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
---
 include/linux/phy/phy.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index 9713aebdd348..03b319f89a34 100644
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
2.17.1
