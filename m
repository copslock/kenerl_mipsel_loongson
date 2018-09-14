Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Sep 2018 11:46:14 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:33227 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994544AbeINJpIFyqeI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 14 Sep 2018 11:45:08 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 65BE8208ED; Fri, 14 Sep 2018 11:44:58 +0200 (CEST)
Received: from localhost.localdomain (AAubervilliers-681-1-99-10.w90-88.abo.wanadoo.fr [90.88.4.10])
        by mail.bootlin.com (Postfix) with ESMTPSA id 0BE7820618;
        Fri, 14 Sep 2018 11:44:58 +0200 (CEST)
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
Subject: [PATCH 6/7] MIPS: mscc: add DT for Ocelot PCB120
Date:   Fri, 14 Sep 2018 11:44:27 +0200
Message-Id: <f2ef1137991cabde5e9529403982d84b5b0fe0a6.1536916714.git-series.quentin.schulz@bootlin.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.b921b010b6d6bde1c11e69551ae38f3b2818645b.1536916714.git-series.quentin.schulz@bootlin.com>
References: <cover.b921b010b6d6bde1c11e69551ae38f3b2818645b.1536916714.git-series.quentin.schulz@bootlin.com>
In-Reply-To: <cover.b921b010b6d6bde1c11e69551ae38f3b2818645b.1536916714.git-series.quentin.schulz@bootlin.com>
References: <cover.b921b010b6d6bde1c11e69551ae38f3b2818645b.1536916714.git-series.quentin.schulz@bootlin.com>
Return-Path: <quentin.schulz@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66247
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

The Ocelot PCB120 evaluation board is different from the PCB123 in that
it has 4 external VSC8584 (or VSC8574) PHYs.

It uses the SoC's second MDIO bus for external PHYs which have a
reversed address on the bus (i.e. PHY4 is on address 3, PHY5 is on
address 2, PHY6 on 1 and PHY7 on 0).

Here is how the PHYs are connected to the switch ports:
port 0: phy0 (internal)
port 1: phy1 (internal)
port 2: phy2 (internal)
port 3: phy3 (internal)
port 4: phy7
port 5: phy4
port 6: phy6
port 9: phy5

Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
---
 arch/mips/boot/dts/mscc/Makefile          |   2 +-
 arch/mips/boot/dts/mscc/ocelot_pcb120.dts | 100 +++++++++++++++++++++++-
 2 files changed, 101 insertions(+), 1 deletion(-)
 create mode 100644 arch/mips/boot/dts/mscc/ocelot_pcb120.dts

diff --git a/arch/mips/boot/dts/mscc/Makefile b/arch/mips/boot/dts/mscc/Makefile
index 9a9bb7e..ec6f5b2 100644
--- a/arch/mips/boot/dts/mscc/Makefile
+++ b/arch/mips/boot/dts/mscc/Makefile
@@ -1,3 +1,3 @@
-dtb-$(CONFIG_MSCC_OCELOT)	+= ocelot_pcb123.dtb
+dtb-$(CONFIG_MSCC_OCELOT)	+= ocelot_pcb123.dtb ocelot_pcb120.dtb
 
 obj-$(CONFIG_BUILTIN_DTB)	+= $(addsuffix .o, $(dtb-y))
diff --git a/arch/mips/boot/dts/mscc/ocelot_pcb120.dts b/arch/mips/boot/dts/mscc/ocelot_pcb120.dts
new file mode 100644
index 0000000..8eb03a5
--- /dev/null
+++ b/arch/mips/boot/dts/mscc/ocelot_pcb120.dts
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/* Copyright (c) 2017 Microsemi Corporation */
+
+/dts-v1/;
+
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/phy/phy-ocelot-serdes.h>
+#include "ocelot.dtsi"
+
+/ {
+	compatible = "mscc,ocelot-pcb120", "mscc,ocelot";
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x0 0x0e000000>;
+	};
+};
+
+&mdio0 {
+	status = "okay";
+};
+
+&mdio1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&miim1>, <&gpio4>;
+
+	phy7: ethernet-phy@0 {
+		reg = <0>;
+		interrupts = <4 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-parent = <&gpio>;
+	};
+	phy6: ethernet-phy@1 {
+		reg = <1>;
+		interrupts = <4 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-parent = <&gpio>;
+	};
+	phy5: ethernet-phy@2 {
+		reg = <2>;
+		interrupts = <4 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-parent = <&gpio>;
+	};
+	phy4: ethernet-phy@3 {
+		reg = <3>;
+		interrupts = <4 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-parent = <&gpio>;
+	};
+};
+
+&port0 {
+	phy-handle = <&phy0>;
+};
+
+&port1 {
+	phy-handle = <&phy1>;
+};
+
+&port2 {
+	phy-handle = <&phy2>;
+};
+
+&port3 {
+	phy-handle = <&phy3>;
+};
+
+&port4 {
+	phy-handle = <&phy7>;
+	phy-mode = "sgmii";
+	phys = <&serdes 4 SERDES1G_2>;
+};
+
+&port5 {
+	phy-handle = <&phy4>;
+	phy-mode = "sgmii";
+	phys = <&serdes 5 SERDES1G_5>;
+};
+
+&port6 {
+	phy-handle = <&phy6>;
+	phy-mode = "sgmii";
+	phys = <&serdes 6 SERDES1G_3>;
+};
+
+&port9 {
+	phy-handle = <&phy5>;
+	phy-mode = "sgmii";
+	phys = <&serdes 9 SERDES1G_4>;
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&uart2 {
+	status = "okay";
+};
-- 
git-series 0.9.1
