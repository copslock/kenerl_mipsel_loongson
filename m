Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jul 2018 13:49:46 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:44112 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993032AbeGQLsrrVUzT (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 17 Jul 2018 13:48:47 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 1D3DA20935; Tue, 17 Jul 2018 13:48:42 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id E39AB20884;
        Tue, 17 Jul 2018 13:48:41 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Wolfram Sang <wsa@the-dreams.de>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        James Hogan <jhogan@kernel.org>
Cc:     Paul Burton <paul.burton@mips.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microsemi.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 4/5] mips: dts: mscc: Add i2c on ocelot
Date:   Tue, 17 Jul 2018 13:48:36 +0200
Message-Id: <20180717114837.21839-5-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180717114837.21839-1-alexandre.belloni@bootlin.com>
References: <20180717114837.21839-1-alexandre.belloni@bootlin.com>
Return-Path: <alexandre.belloni@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64876
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

Ocelot has an i2c controller, add it. There is only one possible pinmux
configuration so add it as well.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 arch/mips/boot/dts/mscc/ocelot.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/mips/boot/dts/mscc/ocelot.dtsi b/arch/mips/boot/dts/mscc/ocelot.dtsi
index 4f33dbc67348..8b6398e09bb6 100644
--- a/arch/mips/boot/dts/mscc/ocelot.dtsi
+++ b/arch/mips/boot/dts/mscc/ocelot.dtsi
@@ -78,6 +78,20 @@
 			status = "disabled";
 		};
 
+		i2c: i2c@100400 {
+			compatible = "mscc,ocelot-i2c", "snps,designware-i2c";
+			pinctrl-0 = <&i2c_pins>;
+			pinctrl-names = "default";
+			reg = <0x100400 0x100>, <0x198 0x8>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <8>;
+			i2c-sda-hold-time-ns = <300>;
+			clocks = <&ahb_clk>;
+
+			status = "disabled";
+		};
+
 		uart2: serial@100800 {
 			pinctrl-0 = <&uart2_pins>;
 			pinctrl-names = "default";
@@ -178,6 +192,11 @@
 				pins = "GPIO_12", "GPIO_13";
 				function = "uart2";
 			};
+
+			i2c_pins: i2c-pins {
+				pins = "GPIO_16", "GPIO_17";
+				function = "twi";
+			};
 		};
 
 		mdio0: mdio@107009c {
-- 
2.18.0
