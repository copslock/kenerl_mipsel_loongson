Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Apr 2013 09:50:16 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:56048 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827479Ab3DLHsRunsdO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 12 Apr 2013 09:48:17 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH V2 12/16] MIPS: ralink: add rt3883 dts files
Date:   Fri, 12 Apr 2013 09:27:39 +0200
Message-Id: <1365751663-5725-12-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1365751663-5725-1-git-send-email-blogic@openwrt.org>
References: <1365751663-5725-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36100
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

Add a dtsi file for RT3883 SoC. This SoC is almost the same as RT3050 but has
OHCI/EHCI in favour of the Synopsis DWC2 core. There is also a 3x3 802.11n
wifi core.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/ralink/Kconfig             |    4 +
 arch/mips/ralink/dts/Makefile        |    1 +
 arch/mips/ralink/dts/rt3883.dtsi     |  186 ++++++++++++++++++++++++++++++++++
 arch/mips/ralink/dts/rt3883_eval.dts |   52 ++++++++++
 4 files changed, 243 insertions(+)
 create mode 100644 arch/mips/ralink/dts/rt3883.dtsi
 create mode 100644 arch/mips/ralink/dts/rt3883_eval.dts

diff --git a/arch/mips/ralink/Kconfig b/arch/mips/ralink/Kconfig
index f21cbaa..2ef69ee 100644
--- a/arch/mips/ralink/Kconfig
+++ b/arch/mips/ralink/Kconfig
@@ -39,6 +39,10 @@ choice
 		bool "RT305x eval kit"
 		depends on SOC_RT305X
 
+	config DTB_RT3883_EVAL
+		bool "RT3883 eval kit"
+		depends on SOC_RT3883
+
 endchoice
 
 endif
diff --git a/arch/mips/ralink/dts/Makefile b/arch/mips/ralink/dts/Makefile
index f635a01..040a986 100644
--- a/arch/mips/ralink/dts/Makefile
+++ b/arch/mips/ralink/dts/Makefile
@@ -1,2 +1,3 @@
 obj-$(CONFIG_DTB_RT2880_EVAL) := rt2880_eval.dtb.o
 obj-$(CONFIG_DTB_RT305X_EVAL) := rt3052_eval.dtb.o
+obj-$(CONFIG_DTB_RT3883_EVAL) := rt3883_eval.dtb.o
diff --git a/arch/mips/ralink/dts/rt3883.dtsi b/arch/mips/ralink/dts/rt3883.dtsi
new file mode 100644
index 0000000..1e80ad3
--- /dev/null
+++ b/arch/mips/ralink/dts/rt3883.dtsi
@@ -0,0 +1,186 @@
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "ralink,rt3883-soc";
+
+	cpus {
+		cpu@0 {
+			compatible = "mips,mips74Kc";
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
+			compatible = "ralink,rt3883-sysc", "ralink,rt3050-sysc";
+			reg = <0x0 0x100>;
+		};
+
+		timer@100 {
+			compatible = "ralink,rt3883-timer", "ralink,rt2880-timer";
+			reg = <0x100 0x20>;
+
+			interrupt-parent = <&intc>;
+			interrupts = <1>;
+
+			status = "disabled";
+		};
+
+		watchdog@120 {
+			compatible = "ralink,rt3883-wdt", "ralink,rt2880-wdt";
+			reg = <0x120 0x10>;
+		};
+
+		intc: intc@200 {
+			compatible = "ralink,rt3883-intc", "ralink,rt2880-intc";
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
+			compatible = "ralink,rt3883-memc", "ralink,rt3050-memc";
+			reg = <0x300 0x100>;
+		};
+
+		gpio0: gpio@600 {
+			compatible = "ralink,rt3883-gpio", "ralink,rt2880-gpio";
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
+			compatible = "ralink,rt3883-gpio", "ralink,rt2880-gpio";
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
+			compatible = "ralink,rt3883-gpio", "ralink,rt2880-gpio";
+			reg = <0x660 0x24>;
+
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			ralink,num-gpios = <32>;
+			ralink,register-map = [ 00 04 08 0c
+						10 14 18 1c
+						20 24 ];
+
+			status = "disabled";
+		};
+
+		gpio3: gpio@688 {
+			compatible = "ralink,rt3883-gpio", "ralink,rt2880-gpio";
+			reg = <0x688 0x24>;
+
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			ralink,num-gpios = <24>;
+			ralink,register-map = [ 00 04 08 0c
+						10 14 18 1c
+						20 24 ];
+
+			status = "disabled";
+		};
+
+		spi@b00 {
+			compatible = "ralink,rt3883-spi", "ralink,rt2880-spi";
+			reg = <0xb00 0x100>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			status = "disabled";
+		};
+
+		uartlite@c00 {
+			compatible = "ralink,rt3883-uart", "ralink,rt2880-uart", "ns16550a";
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
+		compatible = "ralink,rt3883-eth";
+		reg = <0x10100000 10000>;
+
+		interrupt-parent = <&cpuintc>;
+		interrupts = <5>;
+
+		status = "disabled";
+	};
+
+	wmac@10180000 {
+		compatible = "ralink,rt3883-wmac", "ralink,rt2880-wmac";
+		reg = <0x10180000 40000>;
+
+		interrupt-parent = <&cpuintc>;
+		interrupts = <6>;
+
+		status = "disabled";
+	};
+
+	ehci@101c0000 {
+		compatible = "ralink,rt3883-ehci", "ehci-platform";
+		reg = <0x101c0000 0x1000>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <18>;
+
+		status = "disabled";
+	};
+
+	ohci@101c1000 {
+		compatible = "ralink,rt3883-ohci", "ohci-platform";
+		reg = <0x101c1000 0x1000>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <18>;
+
+		status = "disabled";
+	};
+};
diff --git a/arch/mips/ralink/dts/rt3883_eval.dts b/arch/mips/ralink/dts/rt3883_eval.dts
new file mode 100644
index 0000000..ca42e68
--- /dev/null
+++ b/arch/mips/ralink/dts/rt3883_eval.dts
@@ -0,0 +1,52 @@
+/dts-v1/;
+
+/include/ "rt3883.dtsi"
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "ralink,rt3883-eval-board", "ralink,rt3883-soc";
+	model = "Ralink RT3883 evaluation board";
+
+	memory@0 {
+		reg = <0x0 0x4000000>;
+	};
+
+	palmbus@10000000 {
+		sysc@0 {
+			ralink,pinmux = "uartlite", "spi";
+			ralink,uartmux = "gpio";
+			ralink,wdtmux = <0>;
+		};
+	};
+
+	cfi@1f000000 {
+		compatible = "cfi-flash";
+		reg = <0x1f000000 0x800000>;
+
+		bank-width = <2>;
+		device-width = <2>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		partition@0 {
+			label = "uboot";
+			reg = <0x0 0x30000>;
+			read-only;
+		};
+		partition@30000 {
+			label = "uboot-env";
+			reg = <0x30000 0x10000>;
+			read-only;
+		};
+		partition@40000 {
+			label = "calibration";
+			reg = <0x40000 0x10000>;
+			read-only;
+		};
+		partition@50000 {
+			label = "linux";
+			reg = <0x50000 0x7b0000>;
+		};
+	};
+};
-- 
1.7.10.4
