Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 Apr 2015 17:28:13 +0200 (CEST)
Received: from smtp5-g21.free.fr ([212.27.42.5]:53756 "EHLO smtp5-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011791AbbDSP2KSDHD4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 19 Apr 2015 17:28:10 +0200
Received: from localhost.localdomain (unknown [78.54.30.204])
        (Authenticated sender: albeu)
        by smtp5-g21.free.fr (Postfix) with ESMTPA id 57396D48056;
        Sun, 19 Apr 2015 17:25:14 +0200 (CEST)
From:   Alban Bedel <albeu@free.fr>
To:     linux-mips@linux-mips.org
Cc:     Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Alban Bedel <albeu@free.fr>,
        Andrew Bresticker <abrestic@chromium.org>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Gabor Juhos <juhosg@openwrt.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 12/12] MIPS: Add basic support for the TL-WR1043ND version 1
Date:   Sun, 19 Apr 2015 17:27:53 +0200
Message-Id: <1429457273-29975-1-git-send-email-albeu@free.fr>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1429448288-20742-1-git-send-email-albeu@free.fr>
References: <1429448288-20742-1-git-send-email-albeu@free.fr>
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46939
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: albeu@free.fr
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

Add a DTS for TL-WR1043ND version 1 and allow to have it built in the
kernel to circumvent the broken u-boot found on these boards.
Currently only the UART, LEDs and buttons are supported.

Signed-off-by: Alban Bedel <albeu@free.fr>
---
v2: * Rebased for the new vendor directory structure
    * Merged the 2 separate patch for SoC dtsi and board DTS in a
      single one
    * Fixed the node names to use ePAPR standardized names
---
 arch/mips/ath79/Kconfig                          |   5 +
 arch/mips/boot/dts/Makefile                      |   1 +
 arch/mips/boot/dts/qca/Makefile                  |   9 ++
 arch/mips/boot/dts/qca/ar9132.dtsi               | 121 +++++++++++++++++++++++
 arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts |  83 ++++++++++++++++
 5 files changed, 219 insertions(+)
 create mode 100644 arch/mips/boot/dts/qca/Makefile
 create mode 100644 arch/mips/boot/dts/qca/ar9132.dtsi
 create mode 100644 arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts

diff --git a/arch/mips/ath79/Kconfig b/arch/mips/ath79/Kconfig
index 1d38c6a..0df05d0 100644
--- a/arch/mips/ath79/Kconfig
+++ b/arch/mips/ath79/Kconfig
@@ -79,6 +79,11 @@ choice
 
 	config DTB_ATH79_NONE
 		bool "None"
+
+	config DTB_TL_WR1043ND_V1
+		bool "TL-WR1043ND Version 1"
+		select BUILTIN_DTB
+		select SOC_AR913X
 endchoice
 
 endmenu
diff --git a/arch/mips/boot/dts/Makefile b/arch/mips/boot/dts/Makefile
index 5d95e4b..9975485 100644
--- a/arch/mips/boot/dts/Makefile
+++ b/arch/mips/boot/dts/Makefile
@@ -3,6 +3,7 @@ dts-dirs	+= cavium-octeon
 dts-dirs	+= lantiq
 dts-dirs	+= mti
 dts-dirs	+= netlogic
+dts-dirs	+= qca
 dts-dirs	+= ralink
 
 obj-y		:= $(addsuffix /, $(dts-dirs))
diff --git a/arch/mips/boot/dts/qca/Makefile b/arch/mips/boot/dts/qca/Makefile
new file mode 100644
index 0000000..5f02aa6
--- /dev/null
+++ b/arch/mips/boot/dts/qca/Makefile
@@ -0,0 +1,9 @@
+dtb-$(CONFIG_DTB_TL_WR1043ND_V1)	+= ar9132_tl_wr1043nd_v1.dtb
+
+obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
+
+# Force kbuild to make empty built-in.o if necessary
+obj-				+= dummy.o
+
+always				:= $(dtb-y)
+clean-files			:= *.dtb *.dtb.S
diff --git a/arch/mips/boot/dts/qca/ar9132.dtsi b/arch/mips/boot/dts/qca/ar9132.dtsi
new file mode 100644
index 0000000..c05b65c2
--- /dev/null
+++ b/arch/mips/boot/dts/qca/ar9132.dtsi
@@ -0,0 +1,121 @@
+/ {
+	compatible = "qca,ar9132";
+
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu@0 {
+			device_type = "cpu";
+			compatible = "mips,mips24Kc";
+			reg = <0>;
+		};
+	};
+
+	cpuintc: interrupt-controller {
+		compatible = "qca,ar9132-cpu-intc", "qca,ar7100-cpu-intc";
+
+		interrupt-controller;
+		#interrupt-cells = <1>;
+
+		qca,ddr-wb-channel-interrupts = <2>, <3>, <4>, <5>;
+		qca,ddr-wb-channels = <&ddr_ctrl 3>, <&ddr_ctrl 2>,
+					<&ddr_ctrl 0>, <&ddr_ctrl 1>;
+	};
+
+	ahb {
+		compatible = "simple-bus";
+		ranges;
+
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		interrupt-parent = <&cpuintc>;
+
+		apb {
+			compatible = "simple-bus";
+			ranges;
+
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			interrupt-parent = <&miscintc>;
+
+			ddr_ctrl: memory-controller@18000000 {
+				compatible = "qca,ar9132-ddr-controller",
+						"qca,ar7240-ddr-controller";
+				reg = <0x18000000 0x100>;
+
+				#qca,ddr-wb-channel-cells = <1>;
+			};
+
+			uart@18020000 {
+				compatible = "ns8250";
+				reg = <0x18020000 0x20>;
+				interrupts = <3>;
+
+				clocks = <&pll 2>;
+				clock-names = "uart";
+
+				reg-io-width = <4>;
+				reg-shift = <2>;
+				no-loopback-test;
+
+				status = "disabled";
+			};
+
+			gpio: gpio@18040000 {
+				compatible = "qca,ar9132-gpio",
+						"qca,ar7100-gpio";
+				reg = <0x18040000 0x30>;
+				interrupts = <2>;
+
+				ngpios = <22>;
+
+				gpio-controller;
+				#gpio-cells = <2>;
+
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			pll: pll-controller@18050000 {
+				compatible = "qca,ar9132-ppl",
+						"qca,ar9130-pll";
+				reg = <0x18050000 0x20>;
+
+				clock-names = "ref";
+				/* The board must provides the ref clock */
+
+				#clock-cells = <1>;
+				clock-output-names = "cpu", "ddr", "ahb";
+			};
+
+			wdt@18060008 {
+				compatible = "qca,ar7130-wdt";
+				reg = <0x18060008 0x8>;
+
+				interrupts = <4>;
+
+				clocks = <&pll 2>;
+				clock-names = "wdt";
+			};
+
+			miscintc: interrupt-controller@18060010 {
+				compatible = "qca,ar9132-misc-intc",
+					   "qca,ar7100-misc-intc";
+				reg = <0x18060010 0x4>;
+
+				interrupt-parent = <&cpuintc>;
+				interrupts = <6>;
+
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+
+		};
+	};
+};
diff --git a/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts b/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts
new file mode 100644
index 0000000..ab36c7c
--- /dev/null
+++ b/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts
@@ -0,0 +1,83 @@
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+
+#include "ar9132.dtsi"
+
+/ {
+	compatible = "tplink,tl-wr1043nd-v1", "qca,ar9132";
+	model = "TP-Link TL-WR1043ND Version 1";
+
+	alias {
+		serial0 = "/ahb/apb/uart@18020000";
+	};
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x0 0x2000000>;
+	};
+
+	extosc: oscillator {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <40000000>;
+	};
+
+	ahb {
+		apb {
+			uart@18020000 {
+				status = "okay";
+			};
+
+			pll-controller@18050000 {
+				clocks = <&extosc>;
+			};
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys-polled";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		poll-interval = <20>;
+		button@0 {
+			label = "reset";
+			linux,code = <KEY_RESTART>;
+			gpios = <&gpio 3 GPIO_ACTIVE_LOW>;
+			debounce-interval = <60>;
+		};
+
+		button@1 {
+			label = "qss";
+			linux,code = <KEY_WPS_BUTTON>;
+			gpios = <&gpio 7 GPIO_ACTIVE_LOW>;
+			debounce-interval = <60>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		led@0 {
+			label = "tp-link:green:usb";
+			gpios = <&gpio 1 GPIO_ACTIVE_LOW>;
+		};
+
+		led@1 {
+			label = "tp-link:green:system";
+			gpios = <&gpio 2 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "heartbeat";
+		};
+
+		led@2 {
+			label = "tp-link:green:qss";
+			gpios = <&gpio 5 GPIO_ACTIVE_HIGH>;
+		};
+
+		led@3 {
+			label = "tp-link:green:wlan";
+			gpios = <&gpio 9 GPIO_ACTIVE_LOW>;
+		};
+	};
+};
-- 
2.0.0
