Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Jan 2016 16:26:42 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:44991 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007969AbcACP0hyDpv7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 3 Jan 2016 16:26:37 +0100
Received: from arrakis.dune.hu (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id A130E28BFD3;
        Sun,  3 Jan 2016 16:26:06 +0100 (CET)
Received: from localhost.localdomain (p548C9B8E.dip0.t-ipconnect.de [84.140.155.142])
        by arrakis.dune.hu (Postfix) with ESMTPSA;
        Sun,  3 Jan 2016 16:26:06 +0100 (CET)
From:   John Crispin <blogic@openwrt.org>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-mips@linux-mips.org,
        linux-mediatek@lists.infradead.org,
        John Crispin <blogic@openwrt.org>,
        Felix Fietkau <nbd@nbd.name>, Michael Lee <igvtee@gmail.com>,
        =?UTF-8?q?Steven=20Liu=20=28=E5=8A=89=E4=BA=BA=E8=B1=AA=29?= 
        <steven.liu@mediatek.com>,
        =?UTF-8?q?Fred=20Chang=20=28=E5=BC=B5=E5=98=89=E5=AE=8F=29?= 
        <Fred.Chang@mediatek.com>
Subject: [PATCH 01/12] Documentation: DT: net: add docs for ralink/mediatek SoC ethernet binding
Date:   Sun,  3 Jan 2016 16:26:04 +0100
Message-Id: <1451834775-15789-1-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50820
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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

Add three files. ralink,rt2880-net.txt  descibes the actual frame engine
and the other two describe the switch forntend bindings.

Signed-off-by: John Crispin <blogic@openwrt.org>
Signed-off-by: Felix Fietkau <nbd@openwrt.org>
Signed-off-by: Michael Lee <igvtee@gmail.com>
Cc: devicetree@vger.kernel.org
---
 .../bindings/net/mediatek,mt7620-gsw.txt           |   26 +++++++++
 .../devicetree/bindings/net/ralink,rt2880-net.txt  |   61 ++++++++++++++++++++
 .../devicetree/bindings/net/ralink,rt3050-esw.txt  |   32 ++++++++++
 3 files changed, 119 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/mediatek,mt7620-gsw.txt
 create mode 100644 Documentation/devicetree/bindings/net/ralink,rt2880-net.txt
 create mode 100644 Documentation/devicetree/bindings/net/ralink,rt3050-esw.txt

diff --git a/Documentation/devicetree/bindings/net/mediatek,mt7620-gsw.txt b/Documentation/devicetree/bindings/net/mediatek,mt7620-gsw.txt
new file mode 100644
index 0000000..aa63130
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/mediatek,mt7620-gsw.txt
@@ -0,0 +1,26 @@
+Mediatek Gigabit Switch
+=======================
+
+The mediatek gigabit switch can be found on Mediatek SoCs (mt7620, mt7621).
+
+Required properties:
+- compatible: Should be "mediatek,mt7620-gsw" or "mediatek,mt7621-gsw"
+- reg: Address and length of the register set for the device
+- interrupt-parent: Should be the phandle for the interrupt controller
+  that services interrupts for this device
+- interrupts: Should contain the gigabit switches interrupt
+- resets: Should contain the gigabit switches resets
+- reset-names: Should contain the reset names "gsw"
+
+Example:
+
+gsw@10110000 {
+	compatible = "ralink,mt7620-gsw";
+	reg = <0x10110000 8000>;
+
+	resets = <&rstctrl 23>;
+	reset-names = "gsw";
+
+	interrupt-parent = <&intc>;
+	interrupts = <17>;
+};
diff --git a/Documentation/devicetree/bindings/net/ralink,rt2880-net.txt b/Documentation/devicetree/bindings/net/ralink,rt2880-net.txt
new file mode 100644
index 0000000..88b095d
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/ralink,rt2880-net.txt
@@ -0,0 +1,61 @@
+Ralink Frame Engine Ethernet controller
+=======================================
+
+The Ralink frame engine ethernet controller can be found on Ralink and
+Mediatek SoCs (RT288x, RT3x5x, RT366x, RT388x, rt5350, mt7620, mt7621, mt76x8).
+
+Depending on the SoC, there is a number of ports connected to the CPU port
+directly and/or via a (gigabit-)switch.
+
+* Ethernet controller node
+
+Required properties:
+- compatible: Should be one of "ralink,rt2880-eth", "ralink,rt3050-eth",
+  "ralink,rt3050-eth", "ralink,rt3883-eth", "ralink,rt5350-eth",
+  "mediatek,mt7620-eth", "mediatek,mt7621-eth"
+- reg: Address and length of the register set for the device
+- interrupt-parent: Should be the phandle for the interrupt controller
+  that services interrupts for this device
+- interrupts: Should contain the frame engines interrupt
+- resets: Should contain the frame engines resets
+- reset-names: Should contain the reset names "fe". If a switch is present
+  "esw" is also required.
+
+
+* Ethernet port node
+
+Required properties:
+- compatible: Should be "ralink,eth-port"
+- reg: The number of the physical port
+- phy-handle: reference to the node describing the phy
+
+Example:
+
+mdio-bus {
+	...
+	phy0: ethernet-phy@0 {
+		phy-mode = "mii";
+		reg = <0>;
+	};
+};
+
+ethernet@400000 {
+	compatible = "ralink,rt2880-eth";
+	reg = <0x00400000 10000>;
+
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	resets = <&rstctrl 18>;
+	reset-names = "fe";
+
+	interrupt-parent = <&cpuintc>;
+	interrupts = <5>;
+
+	port@0 {
+		compatible = "ralink,eth-port";
+		reg = <0>;
+		phy-handle = <&phy0>;
+	};
+
+};
diff --git a/Documentation/devicetree/bindings/net/ralink,rt3050-esw.txt b/Documentation/devicetree/bindings/net/ralink,rt3050-esw.txt
new file mode 100644
index 0000000..2e79bd3
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/ralink,rt3050-esw.txt
@@ -0,0 +1,32 @@
+Ralink Fast Ethernet Embedded Switch
+====================================
+
+The ralink fast ethernet embedded switch can be found on Ralink and Mediatek
+SoCs (RT3x5x, RT5350, MT76x8).
+
+Required properties:
+- compatible: Should be "ralink,rt3050-esw"
+- reg: Address and length of the register set for the device
+- interrupt-parent: Should be the phandle for the interrupt controller
+  that services interrupts for this device
+- interrupts: Should contain the embedded switches interrupt
+- resets: Should contain the embedded switches resets
+- reset-names: Should contain the reset names "esw"
+
+Optional properties:
+- ralink,portmap: can be used to choose if the default switch setup is
+  llllw or wllll
+- ralink,led_polarity: override the active high/low settings of the leds
+
+Example:
+
+esw@10110000 {
+	compatible = "ralink,rt3050-esw";
+	reg = <0x10110000 8000>;
+
+	resets = <&rstctrl 23>;
+	reset-names = "esw";
+
+	interrupt-parent = <&intc>;
+	interrupts = <17>;
+};
-- 
1.7.10.4
