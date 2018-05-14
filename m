Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 May 2018 22:05:49 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:47532 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992670AbeENUF1lRsq- (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 14 May 2018 22:05:27 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 357E420896; Mon, 14 May 2018 22:05:21 +0200 (CEST)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id 11834203B7;
        Mon, 14 May 2018 22:05:21 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     "David S . Miller" <davem@davemloft.net>
Cc:     Allan Nielsen <Allan.Nielsen@microsemi.com>,
        razvan.stefanescu@nxp.com, po.liu@nxp.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH net-next v3 1/7] dt-bindings: net: add DT bindings for Microsemi MIIM
Date:   Mon, 14 May 2018 22:04:54 +0200
Message-Id: <20180514200500.2953-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514200500.2953-1-alexandre.belloni@bootlin.com>
References: <20180514200500.2953-1-alexandre.belloni@bootlin.com>
Return-Path: <alexandre.belloni@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63935
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexandre.belloni@bootlin.com
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

DT bindings for the Microsemi MII Management Controller found on Microsemi
SoCs

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 .../devicetree/bindings/net/mscc-miim.txt     | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/mscc-miim.txt

diff --git a/Documentation/devicetree/bindings/net/mscc-miim.txt b/Documentation/devicetree/bindings/net/mscc-miim.txt
new file mode 100644
index 000000000000..7104679cf59d
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/mscc-miim.txt
@@ -0,0 +1,26 @@
+Microsemi MII Management Controller (MIIM) / MDIO
+=================================================
+
+Properties:
+- compatible: must be "mscc,ocelot-miim"
+- reg: The base address of the MDIO bus controller register bank. Optionally, a
+  second register bank can be defined if there is an associated reset register
+  for internal PHYs
+- #address-cells: Must be <1>.
+- #size-cells: Must be <0>.  MDIO addresses have no size component.
+- interrupts: interrupt specifier (refer to the interrupt binding)
+
+Typically an MDIO bus might have several children.
+
+Example:
+	mdio@107009c {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "mscc,ocelot-miim";
+		reg = <0x107009c 0x36>, <0x10700f0 0x8>;
+		interrupts = <14>;
+
+		phy0: ethernet-phy@0 {
+			reg = <0>;
+		};
+	};
-- 
2.17.0
