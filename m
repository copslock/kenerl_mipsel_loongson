Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Sep 2016 23:12:08 +0200 (CEST)
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:55970 "EHLO
        emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992043AbcIBVLlkpQ5g (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Sep 2016 23:11:41 +0200
Received: from localhost.localdomain (85-76-72-196-nat.elisa-mobile.fi [85.76.72.196])
        by emh07.mail.saunalahti.fi (Postfix) with ESMTP id 2A1E8409D;
        Sat,  3 Sep 2016 00:11:41 +0300 (EEST)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 1/3] MIPS: OCTEON: split dlink_dsr-1000n.dts
Date:   Sat,  3 Sep 2016 00:11:34 +0300
Message-Id: <20160902211136.8610-2-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.9.2
In-Reply-To: <20160902211136.8610-1-aaro.koskinen@iki.fi>
References: <20160902211136.8610-1-aaro.koskinen@iki.fi>
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55027
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

Split dlink_dsr-1000n.dts to allow reuse with D-Link DSR-500N.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 .../boot/dts/cavium-octeon/dlink_dsr-1000n.dts     | 45 +----------------
 .../dts/cavium-octeon/dlink_dsr-500n-1000n.dtsi    | 58 ++++++++++++++++++++++
 2 files changed, 59 insertions(+), 44 deletions(-)
 create mode 100644 arch/mips/boot/dts/cavium-octeon/dlink_dsr-500n-1000n.dtsi

diff --git a/arch/mips/boot/dts/cavium-octeon/dlink_dsr-1000n.dts b/arch/mips/boot/dts/cavium-octeon/dlink_dsr-1000n.dts
index b134798..cfa2915 100644
--- a/arch/mips/boot/dts/cavium-octeon/dlink_dsr-1000n.dts
+++ b/arch/mips/boot/dts/cavium-octeon/dlink_dsr-1000n.dts
@@ -8,55 +8,16 @@
  * published by the Free Software Foundation.
  */
 
-/include/ "octeon_3xxx.dtsi"
+/include/ "dlink_dsr-500n-1000n.dtsi"
 #include <dt-bindings/gpio/gpio.h>
 
 / {
 	model = "dlink,dsr-1000n";
 
 	soc@0 {
-		smi0: mdio@1180000001800 {
-			phy8: ethernet-phy@8 {
-				reg = <8>;
-				compatible = "ethernet-phy-ieee802.3-c22";
-			};
-		};
-
-		pip: pip@11800a0000000 {
-			interface@0 {
-				ethernet@0 {
-					fixed-link {
-						speed = <1000>;
-						full-duplex;
-					};
-				};
-				ethernet@1 {
-					fixed-link {
-						speed = <1000>;
-						full-duplex;
-					};
-				};
-				ethernet@2 {
-					phy-handle = <&phy8>;
-				};
-			};
-		};
-
-		twsi0: i2c@1180000001000 {
-			rtc@68 {
-				compatible = "dallas,ds1337";
-				reg = <0x68>;
-			};
-		};
-
 		uart0: serial@1180000000800 {
 			clock-frequency = <500000000>;
 		};
-
-		usbn: usbn@1180068000000 {
-			refclk-frequency = <12000000>;
-			refclk-type = "crystal";
-		};
 	};
 
 	leds {
@@ -87,8 +48,4 @@
 			gpios = <&gpio 18 GPIO_ACTIVE_LOW>;
 		};
 	};
-
-	aliases {
-		pip = &pip;
-	};
 };
diff --git a/arch/mips/boot/dts/cavium-octeon/dlink_dsr-500n-1000n.dtsi b/arch/mips/boot/dts/cavium-octeon/dlink_dsr-500n-1000n.dtsi
new file mode 100644
index 0000000..246b598
--- /dev/null
+++ b/arch/mips/boot/dts/cavium-octeon/dlink_dsr-500n-1000n.dtsi
@@ -0,0 +1,58 @@
+/*
+ * Device tree source for D-Link DSR-500N/1000N (common parts).
+ *
+ * Written by: Aaro Koskinen <aaro.koskinen@iki.fi>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/include/ "octeon_3xxx.dtsi"
+
+/ {
+	soc@0 {
+		smi0: mdio@1180000001800 {
+			phy8: ethernet-phy@8 {
+				reg = <8>;
+				compatible = "ethernet-phy-ieee802.3-c22";
+			};
+		};
+
+		pip: pip@11800a0000000 {
+			interface@0 {
+				ethernet@0 {
+					fixed-link {
+						speed = <1000>;
+						full-duplex;
+					};
+				};
+				ethernet@1 {
+					fixed-link {
+						speed = <1000>;
+						full-duplex;
+					};
+				};
+				ethernet@2 {
+					phy-handle = <&phy8>;
+				};
+			};
+		};
+
+		twsi0: i2c@1180000001000 {
+			rtc@68 {
+				compatible = "dallas,ds1337";
+				reg = <0x68>;
+			};
+		};
+
+		usbn: usbn@1180068000000 {
+			refclk-frequency = <12000000>;
+			refclk-type = "crystal";
+		};
+	};
+
+	aliases {
+		pip = &pip;
+	};
+};
-- 
2.9.2
