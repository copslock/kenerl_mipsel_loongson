Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Nov 2017 16:32:13 +0100 (CET)
Received: from mail.free-electrons.com ([62.4.15.54]:39369 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990517AbdK1P2CyImOY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Nov 2017 16:28:02 +0100
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id 2B4CE2039F; Tue, 28 Nov 2017 16:27:57 +0100 (CET)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 0E4DE20375;
        Tue, 28 Nov 2017 16:27:44 +0100 (CET)
From:   Alexandre Belloni <alexandre.belloni@free-electrons.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH 10/13] MIPS: mscc: add ocelot dtsi
Date:   Tue, 28 Nov 2017 16:26:40 +0100
Message-Id: <20171128152643.20463-11-alexandre.belloni@free-electrons.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20171128152643.20463-1-alexandre.belloni@free-electrons.com>
References: <20171128152643.20463-1-alexandre.belloni@free-electrons.com>
Return-Path: <alexandre.belloni@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61149
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexandre.belloni@free-electrons.com
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

Add a device tree include file for the Microsemi Ocelot SoC.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/mips/boot/dts/Makefile         |   1 +
 arch/mips/boot/dts/mscc/Makefile    |   4 ++
 arch/mips/boot/dts/mscc/ocelot.dtsi | 118 ++++++++++++++++++++++++++++++++++++
 3 files changed, 123 insertions(+)
 create mode 100644 arch/mips/boot/dts/mscc/Makefile
 create mode 100644 arch/mips/boot/dts/mscc/ocelot.dtsi

diff --git a/arch/mips/boot/dts/Makefile b/arch/mips/boot/dts/Makefile
index e2c6f131c8eb..1e79cab8e269 100644
--- a/arch/mips/boot/dts/Makefile
+++ b/arch/mips/boot/dts/Makefile
@@ -4,6 +4,7 @@ subdir-y	+= cavium-octeon
 subdir-y	+= img
 subdir-y	+= ingenic
 subdir-y	+= lantiq
+subdir-y	+= mscc
 subdir-y	+= mti
 subdir-y	+= netlogic
 subdir-y	+= ni
diff --git a/arch/mips/boot/dts/mscc/Makefile b/arch/mips/boot/dts/mscc/Makefile
new file mode 100644
index 000000000000..f0a155a74e02
--- /dev/null
+++ b/arch/mips/boot/dts/mscc/Makefile
@@ -0,0 +1,4 @@
+obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
+
+# Force kbuild to make empty built-in.o if necessary
+obj-				+= dummy.o
diff --git a/arch/mips/boot/dts/mscc/ocelot.dtsi b/arch/mips/boot/dts/mscc/ocelot.dtsi
new file mode 100644
index 000000000000..ddbb3449fa92
--- /dev/null
+++ b/arch/mips/boot/dts/mscc/ocelot.dtsi
@@ -0,0 +1,118 @@
+/*
+ * Copyright (c) 2017 Microsemi Corporation
+ *
+ * SPDX-License-Identifier: (GPL-2.0 OR MIT)
+ */
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "mscc,ocelot";
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		mips-hpt-frequency = <250000000>;
+
+		cpu@0 {
+			compatible = "mscc,ocelot";
+			device_type = "cpu";
+			reg = <0>;
+		};
+	};
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	cpuintc: interrupt-controller@0 {
+		#address-cells = <0>;
+		#interrupt-cells = <1>;
+		interrupt-controller;
+		compatible = "mti,cpu-interrupt-controller";
+	};
+
+	ahb_clk: ahb-clk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <250000000>;
+	};
+
+	ahb {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		interrupt-parent = <&intc>;
+
+		cpu_ctrl: syscon@70000000 {
+			compatible = "syscon";
+			reg = <0x70000000 0x2c>;
+		};
+
+		intc: interrupt-controller@70000070 {
+			compatible = "mscc,ocelot-icpu-intr";
+			reg = <0x70000070 0x70>;
+			#interrupt-cells = <1>;
+			interrupt-controller;
+			interrupt-parent = <&cpuintc>;
+			interrupts = <2>;
+		};
+
+		uart0: serial@70100000 {
+			pinctrl-0 = <&uart_pins>;
+			pinctrl-names = "default";
+			compatible = "ns16550a";
+			reg = <0x70100000 0x20>;
+			interrupts = <6>;
+			clocks = <&ahb_clk>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+
+			status = "disabled";
+		};
+
+		uart2: serial@70100800 {
+			pinctrl-0 = <&uart2_pins>;
+			pinctrl-names = "default";
+			compatible = "ns16550a";
+			reg = <0x70100800 0x20>;
+			interrupts = <7>;
+			clocks = <&ahb_clk>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+
+			status = "disabled";
+		};
+
+		chip_regs: syscon@71070000 {
+			compatible = "simple-mfd", "syscon";
+			reg = <0x71070000 0x1c>;
+
+			reset {
+				compatible = "mscc,ocelot-chip-reset";
+				mscc,cpucontrol = <&cpu_ctrl>;
+			};
+		};
+
+		gpio: pinctrl@71070034 {
+			compatible = "mscc,ocelot-pinctrl";
+			reg = <0x71070034 0x28>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&gpio 0 0 22>;
+
+			uart_pins: uart-pins {
+				pins = "GPIO_6", "GPIO_7";
+				function = "uart";
+			};
+
+			uart2_pins: uart2-pins {
+				pins = "GPIO_12", "GPIO_13";
+				function = "uart2";
+			};
+		};
+	};
+};
-- 
2.15.0
