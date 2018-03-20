Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Mar 2018 14:09:08 +0100 (CET)
Received: from mail.bootlin.com ([62.4.15.54]:59857 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992923AbeCTNIS4Z8B7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 20 Mar 2018 14:08:18 +0100
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 88F35207E5; Tue, 20 Mar 2018 14:08:12 +0100 (CET)
Received: from localhost (unknown [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 2646E2082C;
        Tue, 20 Mar 2018 14:08:02 +0100 (CET)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>
Cc:     Allan Nielsen <Allan.Nielsen@microsemi.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v6 3/6] MIPS: mscc: add ocelot dtsi
Date:   Tue, 20 Mar 2018 14:07:58 +0100
Message-Id: <20180320130801.9247-4-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180320130801.9247-1-alexandre.belloni@bootlin.com>
References: <20180320130801.9247-1-alexandre.belloni@bootlin.com>
Return-Path: <alexandre.belloni@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63080
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexandre.belloni@bootlin.com
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

Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 arch/mips/boot/dts/Makefile         |   1 +
 arch/mips/boot/dts/mscc/Makefile    |   1 +
 arch/mips/boot/dts/mscc/ocelot.dtsi | 117 ++++++++++++++++++++++++++++++++++++
 3 files changed, 119 insertions(+)
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
index 000000000000..dd08e63a10ba
--- /dev/null
+++ b/arch/mips/boot/dts/mscc/Makefile
@@ -0,0 +1 @@
+obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
diff --git a/arch/mips/boot/dts/mscc/ocelot.dtsi b/arch/mips/boot/dts/mscc/ocelot.dtsi
new file mode 100644
index 000000000000..dd239cab2f9d
--- /dev/null
+++ b/arch/mips/boot/dts/mscc/ocelot.dtsi
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
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
+		cpu@0 {
+			compatible = "mips,mips24KEc";
+			device_type = "cpu";
+			clocks = <&cpu_clk>;
+			reg = <0>;
+		};
+	};
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	cpuintc: interrupt-controller {
+		#address-cells = <0>;
+		#interrupt-cells = <1>;
+		interrupt-controller;
+		compatible = "mti,cpu-interrupt-controller";
+	};
+
+	cpu_clk: cpu-clock {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <500000000>;
+	};
+
+	ahb_clk: ahb-clk {
+		compatible = "fixed-factor-clock";
+		#clock-cells = <0>;
+		clocks = <&cpu_clk>;
+		clock-div = <2>;
+		clock-mult = <1>;
+	};
+
+	ahb@70000000 {
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
+		reset@1070008 {
+			compatible = "mscc,ocelot-chip-reset";
+			reg = <0x1070008 0x4>;
+		};
+
+		gpio: pinctrl@1070034 {
+			compatible = "mscc,ocelot-pinctrl";
+			reg = <0x1070034 0x68>;
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
2.16.2
