Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 May 2018 22:06:18 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:47549 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992692AbeENUF2Q1CF- (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 14 May 2018 22:05:28 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id C6C75208B1; Mon, 14 May 2018 22:05:21 +0200 (CEST)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id 9D33D203B7;
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
Subject: [PATCH net-next v3 3/7] dt-bindings: net: add DT bindings for Microsemi Ocelot Switch
Date:   Mon, 14 May 2018 22:04:56 +0200
Message-Id: <20180514200500.2953-4-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514200500.2953-1-alexandre.belloni@bootlin.com>
References: <20180514200500.2953-1-alexandre.belloni@bootlin.com>
Return-Path: <alexandre.belloni@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63937
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

DT bindings for the Ethernet switch found on Microsemi Ocelot platforms.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 .../devicetree/bindings/net/mscc-ocelot.txt   | 82 +++++++++++++++++++
 1 file changed, 82 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/mscc-ocelot.txt

diff --git a/Documentation/devicetree/bindings/net/mscc-ocelot.txt b/Documentation/devicetree/bindings/net/mscc-ocelot.txt
new file mode 100644
index 000000000000..0a84711abece
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/mscc-ocelot.txt
@@ -0,0 +1,82 @@
+Microsemi Ocelot network Switch
+===============================
+
+The Microsemi Ocelot network switch can be found on Microsemi SoCs (VSC7513,
+VSC7514)
+
+Required properties:
+- compatible: Should be "mscc,vsc7514-switch"
+- reg: Must contain an (offset, length) pair of the register set for each
+  entry in reg-names.
+- reg-names: Must include the following entries:
+  - "sys"
+  - "rew"
+  - "qs"
+  - "hsio"
+  - "qsys"
+  - "ana"
+  - "portX" with X from 0 to the number of last port index available on that
+    switch
+- interrupts: Should contain the switch interrupts for frame extraction and
+  frame injection
+- interrupt-names: should contain the interrupt names: "xtr", "inj"
+- ethernet-ports: A container for child nodes representing switch ports.
+
+The ethernet-ports container has the following properties
+
+Required properties:
+
+- #address-cells: Must be 1
+- #size-cells: Must be 0
+
+Each port node must have the following mandatory properties:
+- reg: Describes the port address in the switch
+
+Port nodes may also contain the following optional standardised
+properties, described in binding documents:
+
+- phy-handle: Phandle to a PHY on an MDIO bus. See
+  Documentation/devicetree/bindings/net/ethernet.txt for details.
+
+Example:
+
+	switch@1010000 {
+		compatible = "mscc,vsc7514-switch";
+		reg = <0x1010000 0x10000>,
+		      <0x1030000 0x10000>,
+		      <0x1080000 0x100>,
+		      <0x10d0000 0x10000>,
+		      <0x11e0000 0x100>,
+		      <0x11f0000 0x100>,
+		      <0x1200000 0x100>,
+		      <0x1210000 0x100>,
+		      <0x1220000 0x100>,
+		      <0x1230000 0x100>,
+		      <0x1240000 0x100>,
+		      <0x1250000 0x100>,
+		      <0x1260000 0x100>,
+		      <0x1270000 0x100>,
+		      <0x1280000 0x100>,
+		      <0x1800000 0x80000>,
+		      <0x1880000 0x10000>;
+		reg-names = "sys", "rew", "qs", "hsio", "port0",
+			    "port1", "port2", "port3", "port4", "port5",
+			    "port6", "port7", "port8", "port9", "port10",
+			    "qsys", "ana";
+		interrupts = <21 22>;
+		interrupt-names = "xtr", "inj";
+
+		ethernet-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port0: port@0 {
+				reg = <0>;
+				phy-handle = <&phy0>;
+			};
+			port1: port@1 {
+				reg = <1>;
+				phy-handle = <&phy1>;
+			};
+		};
+	};
-- 
2.17.0
