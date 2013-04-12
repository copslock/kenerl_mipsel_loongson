Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Apr 2013 09:34:46 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:55498 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6826582Ab3DLHcFY4Gzt (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 12 Apr 2013 09:32:05 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH V2 06/16] MIPS: ralink: extend RT3050 dtsi file
Date:   Fri, 12 Apr 2013 09:27:33 +0200
Message-Id: <1365751663-5725-6-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1365751663-5725-1-git-send-email-blogic@openwrt.org>
References: <1365751663-5725-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36090
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

Add some additional properties to the dtsi file for ethernet and wifi.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/ralink/dts/rt3050.dtsi     |   96 ++++++++++++++++++++++++++++------
 arch/mips/ralink/dts/rt3052_eval.dts |    2 +-
 2 files changed, 82 insertions(+), 16 deletions(-)

diff --git a/arch/mips/ralink/dts/rt3050.dtsi b/arch/mips/ralink/dts/rt3050.dtsi
index 069d066..5aede8d 100644
--- a/arch/mips/ralink/dts/rt3050.dtsi
+++ b/arch/mips/ralink/dts/rt3050.dtsi
@@ -1,7 +1,7 @@
 / {
 	#address-cells = <1>;
 	#size-cells = <1>;
-	compatible = "ralink,rt3050-soc", "ralink,rt3052-soc";
+	compatible = "ralink,rt3050-soc", "ralink,rt3052-soc", "ralink,rt3350-soc";
 
 	cpus {
 		cpu@0 {
@@ -23,7 +23,7 @@
 	palmbus@10000000 {
 		compatible = "palmbus";
 		reg = <0x10000000 0x200000>;
-                ranges = <0x0 0x10000000 0x1FFFFF>;
+		ranges = <0x0 0x10000000 0x1FFFFF>;
 
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -34,8 +34,18 @@
 		};
 
 		timer@100 {
+			compatible = "ralink,rt3052-timer", "ralink,rt2880-timer";
+			reg = <0x100 0x20>;
+
+			interrupt-parent = <&intc>;
+			interrupts = <1>;
+
+			status = "disabled";
+		};
+
+		watchdog@120 {
 			compatible = "ralink,rt3052-wdt", "ralink,rt2880-wdt";
-			reg = <0x100 0x100>;
+			reg = <0x120 0x10>;
 		};
 
 		intc: intc@200 {
@@ -61,10 +71,12 @@
 			gpio-controller;
 			#gpio-cells = <2>;
 
-			ralink,ngpio = <24>;
-			ralink,regs = [ 00 04 08 0c
-					20 24 28 2c
-					30 34 ];
+			ralink,num-gpios = <24>;
+			ralink,register-map = [ 00 04 08 0c
+						20 24 28 2c
+						30 34 ];
+
+			status = "disabled";
 		};
 
 		gpio1: gpio@638 {
@@ -74,10 +86,12 @@
 			gpio-controller;
 			#gpio-cells = <2>;
 
-			ralink,ngpio = <16>;
-			ralink,regs = [ 00 04 08 0c
-					10 14 18 1c
-					20 24 ];
+			ralink,num-gpios = <16>;
+			ralink,register-map = [ 00 04 08 0c
+						10 14 18 1c
+						20 24 ];
+
+			status = "disabled";
 		};
 
 		gpio2: gpio@660 {
@@ -87,10 +101,21 @@
 			gpio-controller;
 			#gpio-cells = <2>;
 
-			ralink,ngpio = <12>;
-			ralink,regs = [ 00 04 08 0c
-					10 14 18 1c
-					20 24 ];
+			ralink,num-gpios = <12>;
+			ralink,register-map = [ 00 04 08 0c
+						10 14 18 1c
+						20 24 ];
+
+			status = "disabled";
+		};
+
+		spi@b00 {
+			compatible = "ralink,rt3050-spi", "ralink,rt2880-spi";
+			reg = <0xb00 0x100>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			status = "disabled";
 		};
 
 		uartlite@c00 {
@@ -102,5 +127,46 @@
 
 			reg-shift = <2>;
 		};
+
+	};
+
+	ethernet@10100000 {
+		compatible = "ralink,rt3050-eth";
+		reg = <0x10100000 10000>;
+
+		interrupt-parent = <&cpuintc>;
+		interrupts = <5>;
+
+		status = "disabled";
+	};
+
+	esw@10110000 {
+		compatible = "ralink,rt3050-esw";
+		reg = <0x10110000 8000>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <17>;
+
+		status = "disabled";
+	};
+
+	wmac@10180000 {
+		compatible = "ralink,rt3050-wmac", "ralink,rt2880-wmac";
+		reg = <0x10180000 40000>;
+
+		interrupt-parent = <&cpuintc>;
+		interrupts = <6>;
+
+		status = "disabled";
+	};
+
+	otg@101c0000 {
+		compatible = "ralink,rt3050-otg";
+		reg = <0x101c0000 40000>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <18>;
+
+		status = "disabled";
 	};
 };
diff --git a/arch/mips/ralink/dts/rt3052_eval.dts b/arch/mips/ralink/dts/rt3052_eval.dts
index 148a590..dc56e58 100644
--- a/arch/mips/ralink/dts/rt3052_eval.dts
+++ b/arch/mips/ralink/dts/rt3052_eval.dts
@@ -14,7 +14,7 @@
 
 	palmbus@10000000 {
 		sysc@0 {
-			ralink,pinmmux = "uartlite", "spi";
+			ralink,pinmux = "uartlite", "spi";
 			ralink,uartmux = "gpio";
 			ralink,wdtmux = <0>;
 		};
-- 
1.7.10.4
