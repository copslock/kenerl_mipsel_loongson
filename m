Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Mar 2016 22:33:00 +0100 (CET)
Received: from emh01.mail.saunalahti.fi ([62.142.5.107]:43679 "EHLO
        emh01.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006763AbcCHVciW9fo3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Mar 2016 22:32:38 +0100
Received: from localhost.localdomain (85-76-14-12-nat.elisa-mobile.fi [85.76.14.12])
        by emh01.mail.saunalahti.fi (Postfix) with ESMTP id 88C5690069;
        Tue,  8 Mar 2016 23:32:37 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org
Cc:     devicetree@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 1/2] MIPS: OCTEON: add DTS for D-Link DSR-1000N
Date:   Tue,  8 Mar 2016 23:32:26 +0200
Message-Id: <1457472747-9339-1-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.4.0
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52557
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

Add DTS for D-Link DSR-1000N that is usable as is without any "pruning"
with APPENDED_DTB. Split out the common parts from octeon_3xxx.dts
into octeon_3xxx.dtsi.

Compared to builtin generic DTB, we can specificy fixed links properly
and avoid probing non-existent I2C devices.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 .../boot/dts/cavium-octeon/dlink_dsr-1000n.dts     |  78 +++++++
 arch/mips/boot/dts/cavium-octeon/octeon_3xxx.dts   | 205 +-----------------
 arch/mips/boot/dts/cavium-octeon/octeon_3xxx.dtsi  | 231 +++++++++++++++++++++
 3 files changed, 312 insertions(+), 202 deletions(-)
 create mode 100644 arch/mips/boot/dts/cavium-octeon/dlink_dsr-1000n.dts
 create mode 100644 arch/mips/boot/dts/cavium-octeon/octeon_3xxx.dtsi

diff --git a/arch/mips/boot/dts/cavium-octeon/dlink_dsr-1000n.dts b/arch/mips/boot/dts/cavium-octeon/dlink_dsr-1000n.dts
new file mode 100644
index 0000000..d6bc994
--- /dev/null
+++ b/arch/mips/boot/dts/cavium-octeon/dlink_dsr-1000n.dts
@@ -0,0 +1,78 @@
+/*
+ * Device tree source for D-Link DSR-1000N.
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
+	model = "dlink,dsr-1000n";
+
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
+		uart0: serial@1180000000800 {
+			clock-frequency = <500000000>;
+		};
+
+		usbn: usbn@1180068000000 {
+			refclk-frequency = <12000000>;
+			refclk-type = "crystal";
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		usb1 {
+			label = "usb1";
+			gpios = <&gpio 9 1>; /* Active low */
+		};
+
+		usb2 {
+			label = "usb2";
+			gpios = <&gpio 10 1>; /* Active low */
+		};
+	};
+
+	aliases {
+		pip = &pip;
+	};
+};
diff --git a/arch/mips/boot/dts/cavium-octeon/octeon_3xxx.dts b/arch/mips/boot/dts/cavium-octeon/octeon_3xxx.dts
index 9c48e05..de61f02 100644
--- a/arch/mips/boot/dts/cavium-octeon/octeon_3xxx.dts
+++ b/arch/mips/boot/dts/cavium-octeon/octeon_3xxx.dts
@@ -1,4 +1,3 @@
-/dts-v1/;
 /*
  * OCTEON 3XXX, 5XXX, 63XX device tree skeleton.
  *
@@ -6,56 +5,12 @@
  * use.	 Because of this, it contains a super-set of the available
  * devices and properties.
  */
-/ {
-	compatible = "cavium,octeon-3860";
-	#address-cells = <2>;
-	#size-cells = <2>;
-	interrupt-parent = <&ciu>;
-
-	soc@0 {
-		compatible = "simple-bus";
-		#address-cells = <2>;
-		#size-cells = <2>;
-		ranges; /* Direct mapping */
-
-		ciu: interrupt-controller@1070000000000 {
-			compatible = "cavium,octeon-3860-ciu";
-			interrupt-controller;
-			/* Interrupts are specified by two parts:
-			 * 1) Controller register (0 or 1)
-			 * 2) Bit within the register (0..63)
-			 */
-			#interrupt-cells = <2>;
-			reg = <0x10700 0x00000000 0x0 0x7000>;
-		};
 
-		gpio: gpio-controller@1070000000800 {
-			#gpio-cells = <2>;
-			compatible = "cavium,octeon-3860-gpio";
-			reg = <0x10700 0x00000800 0x0 0x100>;
-			gpio-controller;
-			/* Interrupts are specified by two parts:
-			 * 1) GPIO pin number (0..15)
-			 * 2) Triggering (1 - edge rising
-			 *		  2 - edge falling
-			 *		  4 - level active high
-			 *		  8 - level active low)
-			 */
-			interrupt-controller;
-			#interrupt-cells = <2>;
-			/* The GPIO pin connect to 16 consecutive CUI bits */
-			interrupts = <0 16>, <0 17>, <0 18>, <0 19>,
-				     <0 20>, <0 21>, <0 22>, <0 23>,
-				     <0 24>, <0 25>, <0 26>, <0 27>,
-				     <0 28>, <0 29>, <0 30>, <0 31>;
-		};
+/include/ "octeon_3xxx.dtsi"
 
+/ {
+	soc@0 {
 		smi0: mdio@1180000001800 {
-			compatible = "cavium,octeon-3860-mdio";
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <0x11800 0x00001800 0x0 0x40>;
-
 			phy0: ethernet-phy@0 {
 				compatible = "marvell,88e1118";
 				marvell,reg-init =
@@ -220,35 +175,16 @@
 		};
 
 		pip: pip@11800a0000000 {
-			compatible = "cavium,octeon-3860-pip";
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <0x11800 0xa0000000 0x0 0x2000>;
-
 			interface@0 {
-				compatible = "cavium,octeon-3860-pip-interface";
-				#address-cells = <1>;
-				#size-cells = <0>;
-				reg = <0>; /* interface */
-
 				ethernet@0 {
-					compatible = "cavium,octeon-3860-pip-port";
-					reg = <0x0>; /* Port */
-					local-mac-address = [ 00 00 00 00 00 00 ];
 					phy-handle = <&phy2>;
 					cavium,alt-phy-handle = <&phy100>;
 				};
 				ethernet@1 {
-					compatible = "cavium,octeon-3860-pip-port";
-					reg = <0x1>; /* Port */
-					local-mac-address = [ 00 00 00 00 00 00 ];
 					phy-handle = <&phy3>;
 					cavium,alt-phy-handle = <&phy101>;
 				};
 				ethernet@2 {
-					compatible = "cavium,octeon-3860-pip-port";
-					reg = <0x2>; /* Port */
-					local-mac-address = [ 00 00 00 00 00 00 ];
 					phy-handle = <&phy4>;
 					cavium,alt-phy-handle = <&phy102>;
 				};
@@ -322,11 +258,6 @@
 			};
 
 			interface@1 {
-				compatible = "cavium,octeon-3860-pip-interface";
-				#address-cells = <1>;
-				#size-cells = <0>;
-				reg = <1>; /* interface */
-
 				ethernet@0 {
 					compatible = "cavium,octeon-3860-pip-port";
 					reg = <0x0>; /* Port */
@@ -355,13 +286,6 @@
 		};
 
 		twsi0: i2c@1180000001000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "cavium,octeon-3860-twsi";
-			reg = <0x11800 0x00001000 0x0 0x200>;
-			interrupts = <0 45>;
-			clock-frequency = <100000>;
-
 			rtc@68 {
 				compatible = "dallas,ds1337";
 				reg = <0x68>;
@@ -381,15 +305,6 @@
 			clock-frequency = <100000>;
 		};
 
-		uart0: serial@1180000000800 {
-			compatible = "cavium,octeon-3860-uart","ns16550";
-			reg = <0x11800 0x00000800 0x0 0x400>;
-			clock-frequency = <0>;
-			current-speed = <115200>;
-			reg-shift = <3>;
-			interrupts = <0 34>;
-		};
-
 		uart1: serial@1180000000c00 {
 			compatible = "cavium,octeon-3860-uart","ns16550";
 			reg = <0x11800 0x00000c00 0x0 0x400>;
@@ -409,98 +324,6 @@
 		};
 
 		bootbus: bootbus@1180000000000 {
-			compatible = "cavium,octeon-3860-bootbus";
-			reg = <0x11800 0x00000000 0x0 0x200>;
-			/* The chip select number and offset */
-			#address-cells = <2>;
-			/* The size of the chip select region */
-			#size-cells = <1>;
-			ranges = <0 0  0x0 0x1f400000  0xc00000>,
-				 <1 0  0x10000 0x30000000  0>,
-				 <2 0  0x10000 0x40000000  0>,
-				 <3 0  0x10000 0x50000000  0>,
-				 <4 0  0x0 0x1d020000  0x10000>,
-				 <5 0  0x0 0x1d040000  0x10000>,
-				 <6 0  0x0 0x1d050000  0x10000>,
-				 <7 0  0x10000 0x90000000  0>;
-
-			cavium,cs-config@0 {
-				compatible = "cavium,octeon-3860-bootbus-config";
-				cavium,cs-index = <0>;
-				cavium,t-adr  = <20>;
-				cavium,t-ce   = <60>;
-				cavium,t-oe   = <60>;
-				cavium,t-we   = <45>;
-				cavium,t-rd-hld = <35>;
-				cavium,t-wr-hld = <45>;
-				cavium,t-pause	= <0>;
-				cavium,t-wait	= <0>;
-				cavium,t-page	= <35>;
-				cavium,t-rd-dly = <0>;
-
-				cavium,pages	 = <0>;
-				cavium,bus-width = <8>;
-			};
-			cavium,cs-config@4 {
-				compatible = "cavium,octeon-3860-bootbus-config";
-				cavium,cs-index = <4>;
-				cavium,t-adr  = <320>;
-				cavium,t-ce   = <320>;
-				cavium,t-oe   = <320>;
-				cavium,t-we   = <320>;
-				cavium,t-rd-hld = <320>;
-				cavium,t-wr-hld = <320>;
-				cavium,t-pause	= <320>;
-				cavium,t-wait	= <320>;
-				cavium,t-page	= <320>;
-				cavium,t-rd-dly = <0>;
-
-				cavium,pages	 = <0>;
-				cavium,bus-width = <8>;
-			};
-			cavium,cs-config@5 {
-				compatible = "cavium,octeon-3860-bootbus-config";
-				cavium,cs-index = <5>;
-				cavium,t-adr  = <5>;
-				cavium,t-ce   = <300>;
-				cavium,t-oe   = <125>;
-				cavium,t-we   = <150>;
-				cavium,t-rd-hld = <100>;
-				cavium,t-wr-hld = <30>;
-				cavium,t-pause	= <0>;
-				cavium,t-wait	= <30>;
-				cavium,t-page	= <320>;
-				cavium,t-rd-dly = <0>;
-
-				cavium,pages	 = <0>;
-				cavium,bus-width = <16>;
-			};
-			cavium,cs-config@6 {
-				compatible = "cavium,octeon-3860-bootbus-config";
-				cavium,cs-index = <6>;
-				cavium,t-adr  = <5>;
-				cavium,t-ce   = <300>;
-				cavium,t-oe   = <270>;
-				cavium,t-we   = <150>;
-				cavium,t-rd-hld = <100>;
-				cavium,t-wr-hld = <70>;
-				cavium,t-pause	= <0>;
-				cavium,t-wait	= <0>;
-				cavium,t-page	= <320>;
-				cavium,t-rd-dly = <0>;
-
-				cavium,pages	 = <0>;
-				cavium,wait-mode;
-				cavium,bus-width = <16>;
-			};
-
-			flash0: nor@0,0 {
-				compatible = "cfi-flash";
-				reg = <0 0 0x800000>;
-				#address-cells = <1>;
-				#size-cells = <1>;
-			};
-
 			led0: led-display@4,0 {
 				compatible = "avago,hdsp-253x";
 				reg = <4 0x20 0x20>, <4 0 0x20>;
@@ -515,17 +338,6 @@
 			};
 		};
 
-		dma0: dma-engine@1180000000100 {
-			compatible = "cavium,octeon-5750-bootbus-dma";
-			reg = <0x11800 0x00000100 0x0 0x8>;
-			interrupts = <0 63>;
-		};
-		dma1: dma-engine@1180000000108 {
-			compatible = "cavium,octeon-5750-bootbus-dma";
-			reg = <0x11800 0x00000108 0x0 0x8>;
-			interrupts = <0 63>;
-		};
-
 		uctl: uctl@118006f000000 {
 			compatible = "cavium,octeon-6335-uctl";
 			reg = <0x11800 0x6f000000 0x0 0x100>;
@@ -552,21 +364,10 @@
 		};
 
 		usbn: usbn@1180068000000 {
-			compatible = "cavium,octeon-5750-usbn";
-			reg = <0x11800 0x68000000 0x0 0x1000>;
-			ranges; /* Direct mapping */
-			#address-cells = <2>;
-			#size-cells = <2>;
 			/* 12MHz, 24MHz and 48MHz allowed */
 			refclk-frequency = <12000000>;
 			/* Either "crystal" or "external" */
 			refclk-type = "crystal";
-
-			usbc@16f0010000000 {
-				compatible = "cavium,octeon-5750-usbc";
-				reg = <0x16f00 0x10000000 0x0 0x80000>;
-				interrupts = <0 56>;
-			};
 		};
 	};
 
diff --git a/arch/mips/boot/dts/cavium-octeon/octeon_3xxx.dtsi b/arch/mips/boot/dts/cavium-octeon/octeon_3xxx.dtsi
new file mode 100644
index 0000000..5302148
--- /dev/null
+++ b/arch/mips/boot/dts/cavium-octeon/octeon_3xxx.dtsi
@@ -0,0 +1,231 @@
+/* OCTEON 3XXX DTS common parts. */
+
+/dts-v1/;
+
+/ {
+	compatible = "cavium,octeon-3860";
+	#address-cells = <2>;
+	#size-cells = <2>;
+	interrupt-parent = <&ciu>;
+
+	soc@0 {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges; /* Direct mapping */
+
+		ciu: interrupt-controller@1070000000000 {
+			compatible = "cavium,octeon-3860-ciu";
+			interrupt-controller;
+			/* Interrupts are specified by two parts:
+			 * 1) Controller register (0 or 1)
+			 * 2) Bit within the register (0..63)
+			 */
+			#interrupt-cells = <2>;
+			reg = <0x10700 0x00000000 0x0 0x7000>;
+		};
+
+		gpio: gpio-controller@1070000000800 {
+			#gpio-cells = <2>;
+			compatible = "cavium,octeon-3860-gpio";
+			reg = <0x10700 0x00000800 0x0 0x100>;
+			gpio-controller;
+			/* Interrupts are specified by two parts:
+			 * 1) GPIO pin number (0..15)
+			 * 2) Triggering (1 - edge rising
+			 *		  2 - edge falling
+			 *		  4 - level active high
+			 *		  8 - level active low)
+			 */
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			/* The GPIO pin connect to 16 consecutive CUI bits */
+			interrupts = <0 16>, <0 17>, <0 18>, <0 19>,
+				     <0 20>, <0 21>, <0 22>, <0 23>,
+				     <0 24>, <0 25>, <0 26>, <0 27>,
+				     <0 28>, <0 29>, <0 30>, <0 31>;
+		};
+
+		smi0: mdio@1180000001800 {
+			compatible = "cavium,octeon-3860-mdio";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x11800 0x00001800 0x0 0x40>;
+		};
+
+		pip: pip@11800a0000000 {
+			compatible = "cavium,octeon-3860-pip";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x11800 0xa0000000 0x0 0x2000>;
+
+			interface@0 {
+				compatible = "cavium,octeon-3860-pip-interface";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0>; /* interface */
+
+				ethernet@0 {
+					compatible = "cavium,octeon-3860-pip-port";
+					reg = <0x0>; /* Port */
+					local-mac-address = [ 00 00 00 00 00 00 ];
+				};
+				ethernet@1 {
+					compatible = "cavium,octeon-3860-pip-port";
+					reg = <0x1>; /* Port */
+					local-mac-address = [ 00 00 00 00 00 00 ];
+				};
+				ethernet@2 {
+					compatible = "cavium,octeon-3860-pip-port";
+					reg = <0x2>; /* Port */
+					local-mac-address = [ 00 00 00 00 00 00 ];
+				};
+			};
+
+			interface@1 {
+				compatible = "cavium,octeon-3860-pip-interface";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <1>; /* interface */
+			};
+		};
+
+		twsi0: i2c@1180000001000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "cavium,octeon-3860-twsi";
+			reg = <0x11800 0x00001000 0x0 0x200>;
+			interrupts = <0 45>;
+			clock-frequency = <100000>;
+		};
+
+		uart0: serial@1180000000800 {
+			compatible = "cavium,octeon-3860-uart","ns16550";
+			reg = <0x11800 0x00000800 0x0 0x400>;
+			clock-frequency = <0>;
+			current-speed = <115200>;
+			reg-shift = <3>;
+			interrupts = <0 34>;
+		};
+
+		bootbus: bootbus@1180000000000 {
+			compatible = "cavium,octeon-3860-bootbus";
+			reg = <0x11800 0x00000000 0x0 0x200>;
+			/* The chip select number and offset */
+			#address-cells = <2>;
+			/* The size of the chip select region */
+			#size-cells = <1>;
+			ranges = <0 0  0x0 0x1f400000  0xc00000>,
+				 <1 0  0x10000 0x30000000  0>,
+				 <2 0  0x10000 0x40000000  0>,
+				 <3 0  0x10000 0x50000000  0>,
+				 <4 0  0x0 0x1d020000  0x10000>,
+				 <5 0  0x0 0x1d040000  0x10000>,
+				 <6 0  0x0 0x1d050000  0x10000>,
+				 <7 0  0x10000 0x90000000  0>;
+
+			cavium,cs-config@0 {
+				compatible = "cavium,octeon-3860-bootbus-config";
+				cavium,cs-index = <0>;
+				cavium,t-adr  = <20>;
+				cavium,t-ce   = <60>;
+				cavium,t-oe   = <60>;
+				cavium,t-we   = <45>;
+				cavium,t-rd-hld = <35>;
+				cavium,t-wr-hld = <45>;
+				cavium,t-pause	= <0>;
+				cavium,t-wait	= <0>;
+				cavium,t-page	= <35>;
+				cavium,t-rd-dly = <0>;
+
+				cavium,pages	 = <0>;
+				cavium,bus-width = <8>;
+			};
+			cavium,cs-config@4 {
+				compatible = "cavium,octeon-3860-bootbus-config";
+				cavium,cs-index = <4>;
+				cavium,t-adr  = <320>;
+				cavium,t-ce   = <320>;
+				cavium,t-oe   = <320>;
+				cavium,t-we   = <320>;
+				cavium,t-rd-hld = <320>;
+				cavium,t-wr-hld = <320>;
+				cavium,t-pause	= <320>;
+				cavium,t-wait	= <320>;
+				cavium,t-page	= <320>;
+				cavium,t-rd-dly = <0>;
+
+				cavium,pages	 = <0>;
+				cavium,bus-width = <8>;
+			};
+			cavium,cs-config@5 {
+				compatible = "cavium,octeon-3860-bootbus-config";
+				cavium,cs-index = <5>;
+				cavium,t-adr  = <5>;
+				cavium,t-ce   = <300>;
+				cavium,t-oe   = <125>;
+				cavium,t-we   = <150>;
+				cavium,t-rd-hld = <100>;
+				cavium,t-wr-hld = <30>;
+				cavium,t-pause	= <0>;
+				cavium,t-wait	= <30>;
+				cavium,t-page	= <320>;
+				cavium,t-rd-dly = <0>;
+
+				cavium,pages	 = <0>;
+				cavium,bus-width = <16>;
+			};
+			cavium,cs-config@6 {
+				compatible = "cavium,octeon-3860-bootbus-config";
+				cavium,cs-index = <6>;
+				cavium,t-adr  = <5>;
+				cavium,t-ce   = <300>;
+				cavium,t-oe   = <270>;
+				cavium,t-we   = <150>;
+				cavium,t-rd-hld = <100>;
+				cavium,t-wr-hld = <70>;
+				cavium,t-pause	= <0>;
+				cavium,t-wait	= <0>;
+				cavium,t-page	= <320>;
+				cavium,t-rd-dly = <0>;
+
+				cavium,pages	 = <0>;
+				cavium,wait-mode;
+				cavium,bus-width = <16>;
+			};
+
+			flash0: nor@0,0 {
+				compatible = "cfi-flash";
+				reg = <0 0 0x800000>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+			};
+		};
+
+		dma0: dma-engine@1180000000100 {
+			compatible = "cavium,octeon-5750-bootbus-dma";
+			reg = <0x11800 0x00000100 0x0 0x8>;
+			interrupts = <0 63>;
+		};
+
+		dma1: dma-engine@1180000000108 {
+			compatible = "cavium,octeon-5750-bootbus-dma";
+			reg = <0x11800 0x00000108 0x0 0x8>;
+			interrupts = <0 63>;
+		};
+
+		usbn: usbn@1180068000000 {
+			compatible = "cavium,octeon-5750-usbn";
+			reg = <0x11800 0x68000000 0x0 0x1000>;
+			ranges; /* Direct mapping */
+			#address-cells = <2>;
+			#size-cells = <2>;
+
+			usbc@16f0010000000 {
+				compatible = "cavium,octeon-5750-usbc";
+				reg = <0x16f00 0x10000000 0x0 0x80000>;
+				interrupts = <0 56>;
+			};
+		};
+	};
+};
-- 
2.4.0
