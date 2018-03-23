Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Mar 2018 21:12:39 +0100 (CET)
Received: from mail.bootlin.com ([62.4.15.54]:52037 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990864AbeCWULmWVc04 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 23 Mar 2018 21:11:42 +0100
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 5C9D820858; Fri, 23 Mar 2018 21:11:35 +0100 (CET)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id 21DEB2072D;
        Fri, 23 Mar 2018 21:11:35 +0100 (CET)
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
Subject: [PATCH net-next 4/8] dt-bindings: net: add DT bindings for Microsemi Ocelot Switch
Date:   Fri, 23 Mar 2018 21:11:13 +0100
Message-Id: <20180323201117.8416-5-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323201117.8416-1-alexandre.belloni@bootlin.com>
References: <20180323201117.8416-1-alexandre.belloni@bootlin.com>
Return-Path: <alexandre.belloni@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63183
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

Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 .../devicetree/bindings/net/mscc-ocelot.txt        | 62 ++++++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/mscc-ocelot.txt

diff --git a/Documentation/devicetree/bindings/net/mscc-ocelot.txt b/Documentation/devicetree/bindings/net/mscc-ocelot.txt
new file mode 100644
index 000000000000..ee092a85b5a0
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/mscc-ocelot.txt
@@ -0,0 +1,62 @@
+Microsemi Ocelot network Switch
+===============================
+
+The Microsemi Ocelot network switch can be found on Microsemi SoCs (VSC7513,
+VSC7514)
+
+Required properties:
+- compatible: Should be "mscc,ocelot-switch"
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
+
+Example:
+
+	switch@1010000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "mscc,ocelot-switch";
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
+		port0: port@0 {
+			reg = <0>;
+			phy-handle = <&phy0>;
+		};
+		port1: port@1 {
+			reg = <1>;
+			phy-handle = <&phy1>;
+		};
+	};
-- 
2.16.2
