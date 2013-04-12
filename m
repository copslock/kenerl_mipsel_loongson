Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Apr 2013 09:36:36 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:55510 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827445Ab3DLHcIf1ZS0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 12 Apr 2013 09:32:08 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH V2 10/16] MIPS: ralink: add rt2880 dts files
Date:   Fri, 12 Apr 2013 09:27:37 +0200
Message-Id: <1365751663-5725-10-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1365751663-5725-1-git-send-email-blogic@openwrt.org>
References: <1365751663-5725-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36094
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

Add a dtsi file for RT2880 SoC and a sample dts file. This SoC is first one that
was released in this SoC family.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/ralink/Kconfig             |    4 ++
 arch/mips/ralink/dts/Makefile        |    1 +
 arch/mips/ralink/dts/rt2880.dtsi     |  116 ++++++++++++++++++++++++++++++++++
 arch/mips/ralink/dts/rt2880_eval.dts |   52 +++++++++++++++
 4 files changed, 173 insertions(+)
 create mode 100644 arch/mips/ralink/dts/rt2880.dtsi
 create mode 100644 arch/mips/ralink/dts/rt2880_eval.dts

diff --git a/arch/mips/ralink/Kconfig b/arch/mips/ralink/Kconfig
index 6723b94..0d312fc 100644
--- a/arch/mips/ralink/Kconfig
+++ b/arch/mips/ralink/Kconfig
@@ -26,6 +26,10 @@ choice
 	config DTB_RT_NONE
 		bool "None"
 
+	config DTB_RT2880_EVAL
+		bool "RT2880 eval kit"
+		depends on SOC_RT288X
+
 	config DTB_RT305X_EVAL
 		bool "RT305x eval kit"
 		depends on SOC_RT305X
diff --git a/arch/mips/ralink/dts/Makefile b/arch/mips/ralink/dts/Makefile
index 1a69fb3..f635a01 100644
--- a/arch/mips/ralink/dts/Makefile
+++ b/arch/mips/ralink/dts/Makefile
@@ -1 +1,2 @@
+obj-$(CONFIG_DTB_RT2880_EVAL) := rt2880_eval.dtb.o
 obj-$(CONFIG_DTB_RT305X_EVAL) := rt3052_eval.dtb.o
diff --git a/arch/mips/ralink/dts/rt2880.dtsi b/arch/mips/ralink/dts/rt2880.dtsi
new file mode 100644
index 0000000..b57b2bd
--- /dev/null
+++ b/arch/mips/ralink/dts/rt2880.dtsi
@@ -0,0 +1,116 @@
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "ralink,rt2880-soc";
+
+	cpus {
+		cpu@0 {
+			compatible = "mips,mips4KEc";
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
+                ranges = <0x0 0x10000000 0x1FFFFF>;
+
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		sysc@300000 {
+			compatible = "ralink,rt2880-sysc";
+			reg = <0x300000 0x100>;
+		};
+
+		timer@300100 {
+			compatible = "ralink,rt2880-timer";
+			reg = <0x300100 0x20>;
+
+			interrupt-parent = <&intc>;
+			interrupts = <1>;
+
+			status = "disabled";
+		};
+
+		watchdog@300120 {
+			compatible = "ralink,rt2880-wdt";
+			reg = <0x300120 0x10>;
+		};
+
+		intc: intc@300200 {
+			compatible = "ralink,rt2880-intc";
+			reg = <0x300200 0x100>;
+
+			interrupt-controller;
+			#interrupt-cells = <1>;
+
+			interrupt-parent = <&cpuintc>;
+			interrupts = <2>;
+		};
+
+		memc@300300 {
+			compatible = "ralink,rt2880-memc";
+			reg = <0x300300 0x100>;
+		};
+
+		gpio0: gpio@300600 {
+			compatible = "ralink,rt2880-gpio";
+			reg = <0x300600 0x34>;
+
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			ralink,num-gpios = <24>;
+			ralink,register-map = [ 00 04 08 0c
+						20 24 28 2c
+						30 34 ];
+		};
+
+		gpio1: gpio@300638 {
+			compatible = "ralink,rt2880-gpio";
+			reg = <0x300638 0x24>;
+
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			ralink,num-gpios = <16>;
+			ralink,register-map = [ 00 04 08 0c
+						10 14 18 1c
+						20 24 ];
+		};
+
+		gpio2: gpio@300660 {
+			compatible = "ralink,rt2880-gpio";
+			reg = <0x300660 0x24>;
+
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			ralink,num-gpios = <32>;
+			ralink,register-map = [ 00 04 08 0c
+						10 14 18 1c
+						20 24 ];
+		};
+
+		uartlite@300c00 {
+			compatible = "ralink,rt2880-uart", "ns16550a";
+			reg = <0x300c00 0x100>;
+
+			interrupt-parent = <&intc>;
+			interrupts = <8>;
+
+			reg-shift = <2>;
+		};
+	};
+};
diff --git a/arch/mips/ralink/dts/rt2880_eval.dts b/arch/mips/ralink/dts/rt2880_eval.dts
new file mode 100644
index 0000000..c2710c1
--- /dev/null
+++ b/arch/mips/ralink/dts/rt2880_eval.dts
@@ -0,0 +1,52 @@
+/dts-v1/;
+
+/include/ "rt2880.dtsi"
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "ralink,rt2880-eval-board", "ralink,rt2880-soc";
+	model = "Ralink RT2880 evaluation board";
+
+	memory@8000000 {
+		reg = <0x0 0x2000000>;
+	};
+
+	palmbus@10000000 {
+		sysc@300000 {
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
