Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Mar 2018 21:12:02 +0100 (CET)
Received: from mail.bootlin.com ([62.4.15.54]:52017 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990723AbeCWULmVnez4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 23 Mar 2018 21:11:42 +0100
Received: by mail.bootlin.com (Postfix, from userid 110)
        id CF2AD2084D; Fri, 23 Mar 2018 21:11:34 +0100 (CET)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id 918A520715;
        Fri, 23 Mar 2018 21:11:34 +0100 (CET)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     "David S . Miller" <davem@davemloft.net>
Cc:     Allan Nielsen <Allan.Nielsen@microsemi.com>,
        razvan.stefanescu@nxp.com, po.liu@nxp.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH net-next 2/8] dt-bindings: net: add DT bindings for Microsemi MIIM
Date:   Fri, 23 Mar 2018 21:11:11 +0100
Message-Id: <20180323201117.8416-3-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323201117.8416-1-alexandre.belloni@bootlin.com>
References: <20180323201117.8416-1-alexandre.belloni@bootlin.com>
Return-Path: <alexandre.belloni@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63181
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

Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 .../devicetree/bindings/net/mscc-miim.txt          | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/mscc-miim.txt

diff --git a/Documentation/devicetree/bindings/net/mscc-miim.txt b/Documentation/devicetree/bindings/net/mscc-miim.txt
new file mode 100644
index 000000000000..711ac9ab853c
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/mscc-miim.txt
@@ -0,0 +1,25 @@
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
2.16.2
