Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Jun 2017 00:40:44 +0200 (CEST)
Received: from hauke-m.de ([5.39.93.123]:45463 "EHLO mail.hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993457AbdFTWi0t5FdQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 21 Jun 2017 00:38:26 +0200
Received: from hauke-desktop.lan (p2003008628185200F758E6CB56AA268C.dip0.t-ipconnect.de [IPv6:2003:86:2818:5200:f758:e6cb:56aa:268c])
        by mail.hauke-m.de (Postfix) with ESMTPSA id E67CE1001E4;
        Wed, 21 Jun 2017 00:38:25 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, linux-mtd@lists.infradead.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        martin.blumenstingl@googlemail.com, john@phrozen.org,
        linux-spi@vger.kernel.org, hauke.mehrtens@intel.com,
        robh@kernel.org, andy.shevchenko@gmail.com, p.zabel@pengutronix.de,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v5 07/16] Documentation: DT: MIPS: lantiq: Add docs for the RCU bindings
Date:   Wed, 21 Jun 2017 00:37:34 +0200
Message-Id: <20170620223743.13735-8-hauke@hauke-m.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170620223743.13735-1-hauke@hauke-m.de>
References: <20170620223743.13735-1-hauke@hauke-m.de>
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58720
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

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

This adds the initial documentation for the RCU module (a MFD device
which provides USB PHYs, reset controllers and more).

The RCU register range is used for multiple purposes. Mostly one device
uses one or multiple register exclusively, but for some registers some
bits are for one driver and some other bits are for a different driver.
With this patch all accesses to the RCU registers will go through
syscon.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../devicetree/bindings/mips/lantiq/rcu.txt        | 95 ++++++++++++++++++++++
 1 file changed, 95 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mips/lantiq/rcu.txt

diff --git a/Documentation/devicetree/bindings/mips/lantiq/rcu.txt b/Documentation/devicetree/bindings/mips/lantiq/rcu.txt
new file mode 100644
index 000000000000..9c875f4f3c90
--- /dev/null
+++ b/Documentation/devicetree/bindings/mips/lantiq/rcu.txt
@@ -0,0 +1,95 @@
+Lantiq XWAY SoC RCU binding
+===========================
+
+This binding describes the RCU (reset controller unit) multifunction device,
+where each sub-device has it's own set of registers.
+
+The RCU register range is used for multiple purposes. Mostly one device
+uses one or multiple register exclusively, but for some registers some
+bits are for one driver and some other bits are for a different driver.
+With this patch all accesses to the RCU registers will go through
+syscon.
+
+
+-------------------------------------------------------------------------------
+Required properties:
+- compatible	: The first and second values must be:
+		  "lantiq,xrx200-rcu", "simple-mfd", "syscon"
+- reg		: The address and length of the system control registers
+
+
+-------------------------------------------------------------------------------
+Example of the RCU bindings on a xRX200 SoC:
+	rcu0: rcu@203000 {
+		compatible = "lantiq,xrx200-rcu", "simple-mfd", "syscon";
+		reg = <0x203000 0x100>;
+		ranges = <0x0 0x203000 0x100>;
+		big-endian;
+
+		gphy0: gphy@0 {
+			compatible = "lantiq,xrx200a2x-gphy";
+			reg = <0x20 0x4>;
+
+			resets = <&reset0 31 30>, <&reset1 7 7>;
+			reset-names = "gphy", "gphy2";
+			lantiq,gphy-mode = <GPHY_MODE_GE>;
+		};
+
+		gphy1: gphy@1 {
+			compatible = "lantiq,xrx200a2x-gphy";
+			reg = <0x68 0x4>;
+
+			resets = <&reset0 29 28>, <&reset1 6 6>;
+			reset-names = "gphy", "gphy2";
+			lantiq,gphy-mode = <GPHY_MODE_GE>;
+		};
+
+		reset0: reset-controller@0 {
+			compatible = "lantiq,xrx200-reset";
+
+			offset-set = <0x10>;
+			offset-status = <0x14>;
+			#reset-cells = <2>;
+		};
+
+		reset1: reset-controller@1 {
+			compatible = "lantiq,xrx200-reset";
+
+			offset-set = <0x48>;
+			offset-status = <0x24>;
+			#reset-cells = <2>;
+		};
+
+		usb_phy0: usb2-phy@0 {
+			compatible = "lantiq,xrx200-usb2-phy";
+			status = "disabled";
+
+			regmap = <&rcu0>;
+			offset-phy = <0x18>;
+			offset-ana = <0x38>;
+			resets = <&reset1 4 4>, <&reset0 4 4>;
+			reset-names = "phy", "ctrl";
+			#phy-cells = <0>;
+		};
+
+		usb_phy1: usb2-phy@1 {
+			compatible = "lantiq,xrx200-usb2-phy";
+			status = "disabled";
+
+			regmap = <&rcu0>;
+			offset-phy = <0x34>;
+			offset-ana = <0x3C>;
+			resets = <&reset1 5 4>, <&reset0 4 4>;
+			reset-names = "phy", "ctrl";
+			#phy-cells = <0>;
+		};
+
+		reboot {
+			compatible = "syscon-reboot";
+
+			regmap = <&rcu0>;
+			offset = <0x10>;
+			mask = <0x40000000>;
+		};
+	};
+
-- 
2.11.0
