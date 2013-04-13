Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Apr 2013 10:56:06 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:54426 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822680Ab3DMIydFhDbw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 13 Apr 2013 10:54:33 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, devicetree-discuss@lists.ozlabs.org,
        John Crispin <blogic@openwrt.org>
Subject: [PATCH 3/6] DT: MIPS: ralink: extend RT3050 dtsi and dts file
Date:   Sat, 13 Apr 2013 10:50:23 +0200
Message-Id: <1365843026-11015-3-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1365843026-11015-1-git-send-email-blogic@openwrt.org>
References: <1365843026-11015-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36134
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

* remove nodes for cores whose drivers are not upstream yet
* add compat string for an additional soc
* fix a whitespace error

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/ralink/dts/rt3050.dtsi     |   52 ++--------------------------------
 arch/mips/ralink/dts/rt3052_eval.dts |    8 ------
 2 files changed, 2 insertions(+), 58 deletions(-)

diff --git a/arch/mips/ralink/dts/rt3050.dtsi b/arch/mips/ralink/dts/rt3050.dtsi
index 069d066..ef7da1e 100644
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
@@ -9,10 +9,6 @@
 		};
 	};
 
-	chosen {
-		bootargs = "console=ttyS0,57600 init=/init";
-	};
-
 	cpuintc: cpuintc@0 {
 		#address-cells = <0>;
 		#interrupt-cells = <1>;
@@ -23,7 +19,7 @@
 	palmbus@10000000 {
 		compatible = "palmbus";
 		reg = <0x10000000 0x200000>;
-                ranges = <0x0 0x10000000 0x1FFFFF>;
+		ranges = <0x0 0x10000000 0x1FFFFF>;
 
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -33,11 +29,6 @@
 			reg = <0x0 0x100>;
 		};
 
-		timer@100 {
-			compatible = "ralink,rt3052-wdt", "ralink,rt2880-wdt";
-			reg = <0x100 0x100>;
-		};
-
 		intc: intc@200 {
 			compatible = "ralink,rt3052-intc", "ralink,rt2880-intc";
 			reg = <0x200 0x100>;
@@ -54,45 +45,6 @@
 			reg = <0x300 0x100>;
 		};
 
-		gpio0: gpio@600 {
-			compatible = "ralink,rt3052-gpio", "ralink,rt2880-gpio";
-			reg = <0x600 0x34>;
-
-			gpio-controller;
-			#gpio-cells = <2>;
-
-			ralink,ngpio = <24>;
-			ralink,regs = [ 00 04 08 0c
-					20 24 28 2c
-					30 34 ];
-		};
-
-		gpio1: gpio@638 {
-			compatible = "ralink,rt3052-gpio", "ralink,rt2880-gpio";
-			reg = <0x638 0x24>;
-
-			gpio-controller;
-			#gpio-cells = <2>;
-
-			ralink,ngpio = <16>;
-			ralink,regs = [ 00 04 08 0c
-					10 14 18 1c
-					20 24 ];
-		};
-
-		gpio2: gpio@660 {
-			compatible = "ralink,rt3052-gpio", "ralink,rt2880-gpio";
-			reg = <0x660 0x24>;
-
-			gpio-controller;
-			#gpio-cells = <2>;
-
-			ralink,ngpio = <12>;
-			ralink,regs = [ 00 04 08 0c
-					10 14 18 1c
-					20 24 ];
-		};
-
 		uartlite@c00 {
 			compatible = "ralink,rt3052-uart", "ralink,rt2880-uart", "ns16550a";
 			reg = <0xc00 0x100>;
diff --git a/arch/mips/ralink/dts/rt3052_eval.dts b/arch/mips/ralink/dts/rt3052_eval.dts
index 148a590..c566c6c 100644
--- a/arch/mips/ralink/dts/rt3052_eval.dts
+++ b/arch/mips/ralink/dts/rt3052_eval.dts
@@ -12,14 +12,6 @@
 		reg = <0x0 0x2000000>;
 	};
 
-	palmbus@10000000 {
-		sysc@0 {
-			ralink,pinmmux = "uartlite", "spi";
-			ralink,uartmux = "gpio";
-			ralink,wdtmux = <0>;
-		};
-	};
-
 	cfi@1f000000 {
 		compatible = "cfi-flash";
 		reg = <0x1f000000 0x800000>;
-- 
1.7.10.4
