Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Oct 2018 15:18:43 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:55369 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994609AbeJDNRolhhuc (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 4 Oct 2018 15:17:44 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 6352B208F4; Thu,  4 Oct 2018 15:17:38 +0200 (CEST)
Received: from localhost.localdomain (AAubervilliers-681-1-28-153.w90-88.abo.wanadoo.fr [90.88.148.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id 2ABA420802;
        Thu,  4 Oct 2018 15:17:19 +0200 (CEST)
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
Subject: [PATCH v2 4/5] MIPS: mscc: add DT for Ocelot PCB120
Date:   Thu,  4 Oct 2018 15:17:09 +0200
Message-Id: <20181004131710.14978-5-quentin.schulz@bootlin.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181004131710.14978-1-quentin.schulz@bootlin.com>
References: <20181004131710.14978-1-quentin.schulz@bootlin.com>
Return-Path: <quentin.schulz@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66691
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

Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
---
 arch/mips/boot/dts/mscc/Makefile          |   2 +-
 arch/mips/boot/dts/mscc/ocelot_pcb120.dts | 107 ++++++++++++++++++++++
 2 files changed, 108 insertions(+), 1 deletion(-)
 create mode 100644 arch/mips/boot/dts/mscc/ocelot_pcb120.dts

diff --git a/arch/mips/boot/dts/mscc/Makefile b/arch/mips/boot/dts/mscc/Makefile
index 9a9bb7ea0503..ec6f5b2bf093 100644
--- a/arch/mips/boot/dts/mscc/Makefile
+++ b/arch/mips/boot/dts/mscc/Makefile
@@ -1,3 +1,3 @@
-dtb-$(CONFIG_MSCC_OCELOT)	+= ocelot_pcb123.dtb
+dtb-$(CONFIG_MSCC_OCELOT)	+= ocelot_pcb123.dtb ocelot_pcb120.dtb
 
 obj-$(CONFIG_BUILTIN_DTB)	+= $(addsuffix .o, $(dtb-y))
diff --git a/arch/mips/boot/dts/mscc/ocelot_pcb120.dts b/arch/mips/boot/dts/mscc/ocelot_pcb120.dts
new file mode 100644
index 000000000000..33991fd209f5
--- /dev/null
+++ b/arch/mips/boot/dts/mscc/ocelot_pcb120.dts
@@ -0,0 +1,107 @@
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
+&gpio {
+	phy_int_pins: phy_int_pins {
+		pins = "GPIO_4";
+		function = "gpio";
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
+	pinctrl-0 = <&miim1>, <&phy_int_pins>;
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
+	phys = <&serdes 4 SERDES1G(2)>;
+};
+
+&port5 {
+	phy-handle = <&phy4>;
+	phy-mode = "sgmii";
+	phys = <&serdes 5 SERDES1G(5)>;
+};
+
+&port6 {
+	phy-handle = <&phy6>;
+	phy-mode = "sgmii";
+	phys = <&serdes 6 SERDES1G(3)>;
+};
+
+&port9 {
+	phy-handle = <&phy5>;
+	phy-mode = "sgmii";
+	phys = <&serdes 9 SERDES1G(4)>;
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
2.17.1
