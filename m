Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 09 Sep 2018 22:20:44 +0200 (CEST)
Received: from mx1.mailbox.org ([80.241.60.212]:20440 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992363AbeIIUUlH2X71 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 9 Sep 2018 22:20:41 +0200
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 7009949429;
        Sun,  9 Sep 2018 22:20:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id gczSXyLLz2nH; Sun,  9 Sep 2018 22:20:33 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     davem@davemloft.net
Cc:     netdev@vger.kernel.org, andrew@lunn.ch,
        vivien.didelot@savoirfairelinux.com, f.fainelli@gmail.com,
        john@phrozen.org, linux-mips@linux-mips.org, dev@kresin.me,
        hauke.mehrtens@intel.com, devicetree@vger.kernel.org
Subject: [PATCH v3 net-next 5/6] dt-bindings: net: dsa: Add lantiq,xrx200-gswip DT bindings
Date:   Sun,  9 Sep 2018 22:20:27 +0200
Message-Id: <20180909202027.411-1-hauke@hauke-m.de>
In-Reply-To: <20180909201647.32727-1-hauke@hauke-m.d>
References: <20180909201647.32727-1-hauke@hauke-m.d>
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66163
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

This adds the binding for the GSWIP (Gigabit switch) core found in the
xrx200 / VR9 Lantiq / Intel SoC.

This part takes care of the switch, MDIO bus, and loading the FW into
the embedded GPHYs.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
Cc: devicetree@vger.kernel.org
---
 .../devicetree/bindings/net/dsa/lantiq-gswip.txt   | 141 +++++++++++++++++++++
 1 file changed, 141 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/dsa/lantiq-gswip.txt

diff --git a/Documentation/devicetree/bindings/net/dsa/lantiq-gswip.txt b/Documentation/devicetree/bindings/net/dsa/lantiq-gswip.txt
new file mode 100644
index 000000000000..a089f5856778
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/dsa/lantiq-gswip.txt
@@ -0,0 +1,141 @@
+Lantiq GSWIP Ethernet switches
+==================================
+
+Required properties for GSWIP core:
+
+- compatible	: "lantiq,xrx200-gswip" for the embedded GSWIP in the
+		  xRX200 SoC
+- reg		: memory range of the GSWIP core registers
+		: memory range of the GSWIP MDIO registers
+		: memory range of the GSWIP MII registers
+
+See Documentation/devicetree/bindings/net/dsa/dsa.txt for a list of
+additional required and optional properties.
+
+
+Required properties for MDIO bus:
+- compatible	: "lantiq,xrx200-mdio" for the MDIO bus inside the GSWIP
+		  core of the xRX200 SoC and the PHYs connected to it.
+
+See Documentation/devicetree/bindings/net/mdio.txt for a list of additional
+required and optional properties.
+
+
+Required properties for GPHY firmware loading:
+- compatible	: "lantiq,gphy-fw" and "lantiq,xrx200-gphy-fw",
+		  "lantiq,xrx200a1x-gphy-fw", "lantiq,xrx200a2x-gphy-fw",
+		  "lantiq,xrx300-gphy-fw", or "lantiq,xrx330-gphy-fw"
+		  for the loading of the firmware into the embedded
+		  GPHY core of the SoC.
+- lantiq,rcu	: reference to the rcu syscon
+
+The GPHY firmware loader has a list of GPHY entries, one for each
+embedded GPHY
+
+- reg		: Offset of the GPHY firmware register in the RCU
+		  register range
+- resets	: list of resets of the embedded GPHY
+- reset-names	: list of names of the resets
+
+Example:
+
+Ethernet switch on the VRX200 SoC:
+
+gswip: gswip@E108000 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	compatible = "lantiq,xrx200-gswip";
+	reg = <	0xE108000 0x3000 /* switch */
+		0xE10B100 0x70 /* mdio */
+		0xE10B1D8 0x30 /* mii */
+		>;
+	dsa,member = <0 0>;
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@0 {
+			reg = <0>;
+			label = "lan3";
+			phy-mode = "rgmii";
+			phy-handle = <&phy0>;
+		};
+
+		port@1 {
+			reg = <1>;
+			label = "lan4";
+			phy-mode = "rgmii";
+			phy-handle = <&phy1>;
+		};
+
+		port@2 {
+			reg = <2>;
+			label = "lan2";
+			phy-mode = "internal";
+			phy-handle = <&phy11>;
+		};
+
+		port@4 {
+			reg = <4>;
+			label = "lan1";
+			phy-mode = "internal";
+			phy-handle = <&phy13>;
+		};
+
+		port@5 {
+			reg = <5>;
+			label = "wan";
+			phy-mode = "rgmii";
+			phy-handle = <&phy5>;
+		};
+
+		port@6 {
+			reg = <0x6>;
+			label = "cpu";
+			ethernet = <&eth0>;
+		};
+	};
+
+	mdio@0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "lantiq,xrx200-mdio";
+		reg = <0>;
+
+		phy0: ethernet-phy@0 {
+			reg = <0x0>;
+		};
+		phy1: ethernet-phy@1 {
+			reg = <0x1>;
+		};
+		phy5: ethernet-phy@5 {
+			reg = <0x5>;
+		};
+		phy11: ethernet-phy@11 {
+			reg = <0x11>;
+		};
+		phy13: ethernet-phy@13 {
+			reg = <0x13>;
+		};
+	};
+
+	gphy-fw {
+		compatible = "lantiq,xrx200-gphy-fw", "lantiq,gphy-fw";
+		lantiq,rcu = <&rcu0>;
+
+		gphy@20 {
+			reg = <0x20>;
+
+			resets = <&reset0 31 30>;
+			reset-names = "gphy";
+		};
+
+		gphy@68 {
+			reg = <0x68>;
+
+			resets = <&reset0 29 28>;
+			reset-names = "gphy";
+		};
+	};
+};
-- 
2.11.0
