Return-Path: <SRS0=3G5J=YH=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59643ECE58D
	for <linux-mips@archiver.kernel.org>; Mon, 14 Oct 2019 06:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D1A420854
	for <linux-mips@archiver.kernel.org>; Mon, 14 Oct 2019 06:16:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730051AbfJNGQR (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 14 Oct 2019 02:16:17 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:40331 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730070AbfJNGQR (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Mon, 14 Oct 2019 02:16:17 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1iJte6-0006eu-FQ; Mon, 14 Oct 2019 08:15:54 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1iJte2-0000yS-KA; Mon, 14 Oct 2019 08:15:50 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Andrew Lunn <andrew@lunn.ch>, Chris Snook <chris.snook@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        James Hogan <jhogan@kernel.org>,
        Jay Cliburn <jcliburn@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Vivien Didelot <vivien.didelot@gmail.com>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: [PATCH v1 2/4] dt-bindings: net: dsa: qca,ar9331 switch documentation
Date:   Mon, 14 Oct 2019 08:15:47 +0200
Message-Id: <20191014061549.3669-3-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191014061549.3669-1-o.rempel@pengutronix.de>
References: <20191014061549.3669-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-mips@vger.kernel.org
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Atheros AR9331 has built-in 5 port switch. The switch can be configured
to use all 5 or 4 ports. One of built-in PHYs can be used by first built-in
ethernet controller or to be used directly by the switch over second ethernet
controller.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 .../devicetree/bindings/net/dsa/ar9331.txt    | 155 ++++++++++++++++++
 1 file changed, 155 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/dsa/ar9331.txt

diff --git a/Documentation/devicetree/bindings/net/dsa/ar9331.txt b/Documentation/devicetree/bindings/net/dsa/ar9331.txt
new file mode 100644
index 000000000000..b0f95fd19584
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/dsa/ar9331.txt
@@ -0,0 +1,155 @@
+Atheros AR9331 built-in switch
+=============================
+
+It is a switch built-in to Atheros AR9331 WiSoC and addressable over internal
+MDIO bus. All PHYs are build-in as well. 
+
+Required properties:
+
+ - compatible: should be: "qca,ar9331-switch" 
+ - reg: Address on the MII bus for the switch.
+ - resets : Must contain an entry for each entry in reset-names.
+ - reset-names : Must include the following entries: "switch"
+ - interrupt-parent: Phandle to the parent interrupt controller
+ - interrupts: IRQ line for the switch
+ - interrupt-controller: Indicates the switch is itself an interrupt
+   controller. This is used for the PHY interrupts.
+ - #interrupt-cells: must be 1
+ - mdio: Container of PHY and devices on the switches MDIO bus.
+
+See Documentation/devicetree/bindings/net/dsa/dsa.txt for a list of additional
+required and optional properties.
+Examples:
+
+eth0: ethernet@19000000 {
+	compatible = "qca,ar9330-eth";
+	reg = <0x19000000 0x200>;
+	interrupts = <4>;
+
+	resets = <&rst 9>, <&rst 22>;
+	reset-names = "mac", "mdio";
+	clocks = <&pll ATH79_CLK_AHB>, <&pll ATH79_CLK_AHB>;
+	clock-names = "eth", "mdio";
+
+	phy-mode = "mii";
+	phy-handle = <&phy_port4>;
+};
+
+eth1: ethernet@1a000000 {
+	compatible = "qca,ar9330-eth";
+	reg = <0x1a000000 0x200>;
+	interrupts = <5>;
+	resets = <&rst 13>, <&rst 23>;
+	reset-names = "mac", "mdio";
+	clocks = <&pll ATH79_CLK_AHB>, <&pll ATH79_CLK_AHB>;
+	clock-names = "eth", "mdio";
+
+	phy-mode = "gmii";
+	phy-handle = <&switch_port0>;
+
+	fixed-link {
+		speed = <1000>;
+		full-duplex;
+	};
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		switch10: switch@10 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			compatible = "qca,ar9331-switch";
+			reg = <16>;
+			resets = <&rst 8>;
+			reset-names = "switch";
+
+			interrupt-parent = <&miscintc>;
+			interrupts = <12>;
+
+			interrupt-controller;
+			#interrupt-cells = <1>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				switch_port0: port@0 {
+					reg = <0>;
+					label = "cpu";
+					ethernet = <&eth1>;
+
+					phy-mode = "gmii";
+
+					fixed-link {
+						speed = <1000>;
+						full-duplex;
+					};
+				};
+
+				switch_port1: port@1 {
+					reg = <1>;
+					phy-handle = <&phy_port0>;
+					phy-mode = "internal";
+				};
+
+				switch_port2: port@2 {
+					reg = <2>;
+					phy-handle = <&phy_port1>;
+					phy-mode = "internal";
+				};
+
+				switch_port3: port@3 {
+					reg = <3>;
+					phy-handle = <&phy_port2>;
+					phy-mode = "internal";
+				};
+
+				switch_port4: port@4 {
+					reg = <4>;
+					phy-handle = <&phy_port3>;
+					phy-mode = "internal";
+				};
+
+				switch_port5: port@5 {
+					reg = <5>;
+					phy-handle = <&phy_port4>;
+					phy-mode = "internal";
+				};
+			};
+
+			mdio {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				interrupt-parent = <&switch10>;
+
+				phy_port0: phy@0 {
+					reg = <0>;
+					interrupts = <0>;
+				};
+
+				phy_port1: phy@1 {
+					reg = <1>;
+					interrupts = <0>;
+				};
+
+				phy_port2: phy@2 {
+					reg = <2>;
+					interrupts = <0>;
+				};
+
+				phy_port3: phy@3 {
+					reg = <3>;
+					interrupts = <0>;
+				};
+
+				phy_port4: phy@4 {
+					reg = <4>;
+					interrupts = <0>;
+				};
+			};
+		};
+	};
+};
-- 
2.23.0

