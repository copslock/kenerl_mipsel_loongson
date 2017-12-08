Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Dec 2017 16:51:30 +0100 (CET)
Received: from mail.free-electrons.com ([62.4.15.54]:40719 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991827AbdLHPruReagP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Dec 2017 16:47:50 +0100
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id AA57120934; Fri,  8 Dec 2017 16:47:44 +0100 (CET)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.free-electrons.com (Postfix) with ESMTPSA id C34CF2095B;
        Fri,  8 Dec 2017 16:47:26 +0100 (CET)
From:   Alexandre Belloni <alexandre.belloni@free-electrons.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH v2 10/13] MIPS: mscc: add ocelot dtsi
Date:   Fri,  8 Dec 2017 16:46:15 +0100
Message-Id: <20171208154618.20105-11-alexandre.belloni@free-electrons.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20171208154618.20105-1-alexandre.belloni@free-electrons.com>
References: <20171208154618.20105-1-alexandre.belloni@free-electrons.com>
Return-Path: <alexandre.belloni@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61368
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
 arch/mips/boot/dts/mscc/ocelot.dtsi | 115 ++++++++++++++++++++++++++++++++++++
 3 files changed, 120 insertions(+)
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
index 000000000000..97f85431aa16
--- /dev/null
+++ b/arch/mips/boot/dts/mscc/ocelot.dtsi
@@ -0,0 +1,115 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
+/* Copyright (c) 2017 Microsemi Corporation */
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
+		ranges = <0 0x70000000 0x2000000>;
+
+		interrupt-parent = <&intc>;
+
+		cpu_ctrl: syscon@0 {
+			compatible = "mscc,ocelot-cpu-syscon", "syscon";
+			reg = <0x0 0x2c>;
+		};
+
+		intc: interrupt-controller@70 {
+			compatible = "mscc,ocelot-icpu-intr";
+			reg = <0x70 0x70>;
+			#interrupt-cells = <1>;
+			interrupt-controller;
+			interrupt-parent = <&cpuintc>;
+			interrupts = <2>;
+		};
+
+		uart0: serial@100000 {
+			pinctrl-0 = <&uart_pins>;
+			pinctrl-names = "default";
+			compatible = "ns16550a";
+			reg = <0x100000 0x20>;
+			interrupts = <6>;
+			clocks = <&ahb_clk>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+
+			status = "disabled";
+		};
+
+		uart2: serial@100800 {
+			pinctrl-0 = <&uart2_pins>;
+			pinctrl-names = "default";
+			compatible = "ns16550a";
+			reg = <0x100800 0x20>;
+			interrupts = <7>;
+			clocks = <&ahb_clk>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+
+			status = "disabled";
+		};
+
+		chip_regs: syscon@1070000 {
+			compatible = "mscc,ocelot-chip-regs", "simple-mfd", "syscon";
+			reg = <0x1070000 0x1c>;
+
+			reset {
+				compatible = "mscc,ocelot-chip-reset";
+				mscc,cpucontrol = <&cpu_ctrl>;
+			};
+		};
+
+		gpio: pinctrl@1070034 {
+			compatible = "mscc,ocelot-pinctrl";
+			reg = <0x1070034 0x28>;
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
2.15.1
