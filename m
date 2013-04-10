Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Apr 2013 13:51:57 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:41819 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823067Ab3DJLveaFmKA (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 10 Apr 2013 13:51:34 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Gabor Juhos <juhosg@openwrt.org>, linux-mips@linux-mips.org,
        John Crispin <blogic@openwrt.org>
Subject: [PATCH 08/18] MIPS: ralink: add RT5350 dtsi file
Date:   Wed, 10 Apr 2013 13:47:17 +0200
Message-Id: <1365594447-13068-9-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1365594447-13068-1-git-send-email-blogic@openwrt.org>
References: <1365594447-13068-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36038
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

Add a dtsi file for RT5350 Soc. This SoC is almost the same as RT3050 but has
OHCI/EHCI in favour of the Synopsis DWC2 core.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/ralink/dts/rt5350.dtsi |  181 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 181 insertions(+)
 create mode 100644 arch/mips/ralink/dts/rt5350.dtsi

diff --git a/arch/mips/ralink/dts/rt5350.dtsi b/arch/mips/ralink/dts/rt5350.dtsi
new file mode 100644
index 0000000..9ca95a3
--- /dev/null
+++ b/arch/mips/ralink/dts/rt5350.dtsi
@@ -0,0 +1,181 @@
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "ralink,rt5350-soc";
+
+	cpus {
+		cpu@0 {
+			compatible = "mips,mips24KEc";
+		};
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,57600 init=/init";
+	};
+
+	cpuintc: cpuintc@0 {
+		#address-cells = <0>;
+		#interrupt-cells = <1>;
+		interrupt-controller;
+		compatible = "mti,cpu-interrupt-controller";
+	};
+
+	palmbus@10000000 {
+		compatible = "palmbus";
+		reg = <0x10000000 0x200000>;
+		ranges = <0x0 0x10000000 0x1FFFFF>;
+
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		sysc@0 {
+			compatible = "ralink,rt5350-sysc", "ralink,rt3050-sysc";
+			reg = <0x0 0x100>;
+		};
+
+		timer@100 {
+			compatible = "ralink,rt5350-timer", "ralink,rt2880-timer";
+			reg = <0x100 0x20>;
+
+			interrupt-parent = <&intc>;
+			interrupts = <1>;
+
+			status = "disabled";
+		};
+
+		watchdog@120 {
+			compatible = "ralink,rt5350-wdt", "ralink,rt2880-wdt";
+			reg = <0x120 0x10>;
+		};
+
+		intc: intc@200 {
+			compatible = "ralink,rt5350-intc", "ralink,rt2880-intc";
+			reg = <0x200 0x100>;
+
+			interrupt-controller;
+			#interrupt-cells = <1>;
+
+			interrupt-parent = <&cpuintc>;
+			interrupts = <2>;
+		};
+
+		memc@300 {
+			compatible = "ralink,rt5350-memc", "ralink,rt3050-memc";
+			reg = <0x300 0x100>;
+		};
+
+		gpio0: gpio@600 {
+			compatible = "ralink,rt5350-gpio", "ralink,rt2880-gpio";
+			reg = <0x600 0x34>;
+
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			ralink,num-gpios = <24>;
+			ralink,register-map = [ 00 04 08 0c
+						20 24 28 2c
+						30 34 ];
+
+			status = "disabled";
+		};
+
+		gpio1: gpio@638 {
+			compatible = "ralink,rt5350-gpio", "ralink,rt2880-gpio";
+			reg = <0x638 0x24>;
+
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			ralink,num-gpios = <16>;
+			ralink,register-map = [ 00 04 08 0c
+						10 14 18 1c
+						20 24 ];
+
+			status = "disabled";
+		};
+
+		gpio2: gpio@660 {
+			compatible = "ralink,rt5350-gpio", "ralink,rt2880-gpio";
+			reg = <0x660 0x24>;
+
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			ralink,num-gpios = <12>;
+			ralink,register-map = [ 00 04 08 0c
+						10 14 18 1c
+						20 24 ];
+
+			status = "disabled";
+		};
+
+		spi@b00 {
+			compatible = "ralink,rt5350-spi", "ralink,rt2880-spi";
+			reg = <0xb00 0x100>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			status = "disabled";
+		};
+
+		uartlite@c00 {
+			compatible = "ralink,rt5350-uart", "ralink,rt2880-uart", "ns16550a";
+			reg = <0xc00 0x100>;
+
+			interrupt-parent = <&intc>;
+			interrupts = <12>;
+
+			reg-shift = <2>;
+		};
+	};
+
+	ethernet@10100000 {
+		compatible = "ralink,rt5350-eth", "ralink,rt3050-eth";
+		reg = <0x10100000 10000>;
+
+		interrupt-parent = <&cpuintc>;
+		interrupts = <5>;
+
+		status = "disabled";
+	};
+
+	esw@10110000 {
+		compatible = "ralink,rt5350-esw", "ralink,rt3050-esw";
+		reg = <0x10110000 8000>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <17>;
+
+		status = "disabled";
+	};
+
+	wmac@10180000 {
+		compatible = "ralink,rt5350-wmac", "ralink,rt2880-wmac";
+		reg = <0x10180000 40000>;
+
+		interrupt-parent = <&cpuintc>;
+		interrupts = <6>;
+
+		status = "disabled";
+	};
+
+	ehci@101c0000 {
+		compatible = "ralink,rt5350-ehci", "ehci-platform";
+		reg = <0x101c0000 0x1000>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <18>;
+
+		status = "disabled";
+	};
+
+	ohci@101c1000 {
+		compatible = "ralink,rt5350-ohci", "ohci-platform";
+		reg = <0x101c1000 0x1000>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <18>;
+
+		status = "disabled";
+	};
+};
-- 
1.7.10.4
