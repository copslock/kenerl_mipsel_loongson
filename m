Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Jan 2018 16:53:05 +0100 (CET)
Received: from outils.crapouillou.net ([89.234.176.41]:42074 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994677AbeAPPsWtPGkE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 16 Jan 2018 16:48:22 +0100
From:   Paul Cercueil <paul@crapouillou.net>
To:     Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>
Cc:     Maarten ter Huurne <maarten@treewalker.org>,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v7 11/14] MIPS: ingenic: Initial JZ4770 support
Date:   Tue, 16 Jan 2018 16:48:01 +0100
Message-Id: <20180116154804.21150-12-paul@crapouillou.net>
In-Reply-To: <20180116154804.21150-1-paul@crapouillou.net>
References: <20180105182513.16248-2-paul@crapouillou.net>
 <20180116154804.21150-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1516117702; bh=Nv+QNJrSRt5q7VExfPS3lscGEUhtJaXKqDcbYiDhtfo=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=gX53bd/Q4yEuTrJ91uwCTQjxpAwTojKMzYKIadommhMn11ykpol3wb+lInr/Jyo6/QEE03XihR2J3HlPxB6ZLsdloBSOzhccJxqkjLyZTT0HtS5ijLnbgy2jwW06h8zu9GTKCH9idvwaJnIaMuvQ9hhfTJWcCdYMfkLgruUlzFY=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62187
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul@crapouillou.net
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

Provide just enough bits (clocks, clocksource, uart) to allow a kernel
to boot on the JZ4770 SoC to a initramfs userspace.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Reviewed-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
---
 arch/mips/boot/dts/ingenic/jz4770.dtsi | 212 +++++++++++++++++++++++++++++++++
 arch/mips/jz4740/Kconfig               |   6 +
 arch/mips/jz4740/time.c                |   2 +-
 3 files changed, 219 insertions(+), 1 deletion(-)
 create mode 100644 arch/mips/boot/dts/ingenic/jz4770.dtsi

 v2: No change
 v3: No change
 v4: No change
 v5: Use SPDX license identifier
 v6: No change
 v7: No change

diff --git a/arch/mips/boot/dts/ingenic/jz4770.dtsi b/arch/mips/boot/dts/ingenic/jz4770.dtsi
new file mode 100644
index 000000000000..7c2804f3f5f1
--- /dev/null
+++ b/arch/mips/boot/dts/ingenic/jz4770.dtsi
@@ -0,0 +1,212 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <dt-bindings/clock/jz4770-cgu.h>
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "ingenic,jz4770";
+
+	cpuintc: interrupt-controller {
+		#address-cells = <0>;
+		#interrupt-cells = <1>;
+		interrupt-controller;
+		compatible = "mti,cpu-interrupt-controller";
+	};
+
+	intc: interrupt-controller@10001000 {
+		compatible = "ingenic,jz4770-intc";
+		reg = <0x10001000 0x40>;
+
+		interrupt-controller;
+		#interrupt-cells = <1>;
+
+		interrupt-parent = <&cpuintc>;
+		interrupts = <2>;
+	};
+
+	ext: ext {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+	};
+
+	osc32k: osc32k {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
+	};
+
+	cgu: jz4770-cgu@10000000 {
+		compatible = "ingenic,jz4770-cgu";
+		reg = <0x10000000 0x100>;
+
+		clocks = <&ext>, <&osc32k>;
+		clock-names = "ext", "osc32k";
+
+		#clock-cells = <1>;
+	};
+
+	pinctrl: pin-controller@10010000 {
+		compatible = "ingenic,jz4770-pinctrl";
+		reg = <0x10010000 0x600>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		gpa: gpio@0 {
+			compatible = "ingenic,jz4770-gpio";
+			reg = <0>;
+
+			gpio-controller;
+			gpio-ranges = <&pinctrl 0 0 32>;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+
+			interrupt-parent = <&intc>;
+			interrupts = <17>;
+		};
+
+		gpb: gpio@1 {
+			compatible = "ingenic,jz4770-gpio";
+			reg = <1>;
+
+			gpio-controller;
+			gpio-ranges = <&pinctrl 0 32 32>;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+
+			interrupt-parent = <&intc>;
+			interrupts = <16>;
+		};
+
+		gpc: gpio@2 {
+			compatible = "ingenic,jz4770-gpio";
+			reg = <2>;
+
+			gpio-controller;
+			gpio-ranges = <&pinctrl 0 64 32>;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+
+			interrupt-parent = <&intc>;
+			interrupts = <15>;
+		};
+
+		gpd: gpio@3 {
+			compatible = "ingenic,jz4770-gpio";
+			reg = <3>;
+
+			gpio-controller;
+			gpio-ranges = <&pinctrl 0 96 32>;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+
+			interrupt-parent = <&intc>;
+			interrupts = <14>;
+		};
+
+		gpe: gpio@4 {
+			compatible = "ingenic,jz4770-gpio";
+			reg = <4>;
+
+			gpio-controller;
+			gpio-ranges = <&pinctrl 0 128 32>;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+
+			interrupt-parent = <&intc>;
+			interrupts = <13>;
+		};
+
+		gpf: gpio@5 {
+			compatible = "ingenic,jz4770-gpio";
+			reg = <5>;
+
+			gpio-controller;
+			gpio-ranges = <&pinctrl 0 160 32>;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+
+			interrupt-parent = <&intc>;
+			interrupts = <12>;
+		};
+	};
+
+	uart0: serial@10030000 {
+		compatible = "ingenic,jz4770-uart";
+		reg = <0x10030000 0x100>;
+
+		clocks = <&ext>, <&cgu JZ4770_CLK_UART0>;
+		clock-names = "baud", "module";
+
+		interrupt-parent = <&intc>;
+		interrupts = <5>;
+
+		status = "disabled";
+	};
+
+	uart1: serial@10031000 {
+		compatible = "ingenic,jz4770-uart";
+		reg = <0x10031000 0x100>;
+
+		clocks = <&ext>, <&cgu JZ4770_CLK_UART1>;
+		clock-names = "baud", "module";
+
+		interrupt-parent = <&intc>;
+		interrupts = <4>;
+
+		status = "disabled";
+	};
+
+	uart2: serial@10032000 {
+		compatible = "ingenic,jz4770-uart";
+		reg = <0x10032000 0x100>;
+
+		clocks = <&ext>, <&cgu JZ4770_CLK_UART2>;
+		clock-names = "baud", "module";
+
+		interrupt-parent = <&intc>;
+		interrupts = <3>;
+
+		status = "disabled";
+	};
+
+	uart3: serial@10033000 {
+		compatible = "ingenic,jz4770-uart";
+		reg = <0x10033000 0x100>;
+
+		clocks = <&ext>, <&cgu JZ4770_CLK_UART3>;
+		clock-names = "baud", "module";
+
+		interrupt-parent = <&intc>;
+		interrupts = <2>;
+
+		status = "disabled";
+	};
+
+	uhc: uhc@13430000 {
+		compatible = "generic-ohci";
+		reg = <0x13430000 0x1000>;
+
+		clocks = <&cgu JZ4770_CLK_UHC>, <&cgu JZ4770_CLK_UHC_PHY>;
+		assigned-clocks = <&cgu JZ4770_CLK_UHC>;
+		assigned-clock-rates = <48000000>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <20>;
+
+		status = "disabled";
+	};
+};
diff --git a/arch/mips/jz4740/Kconfig b/arch/mips/jz4740/Kconfig
index 643af2012e14..29a9361a2b77 100644
--- a/arch/mips/jz4740/Kconfig
+++ b/arch/mips/jz4740/Kconfig
@@ -18,6 +18,12 @@ config MACH_JZ4740
 	bool
 	select SYS_HAS_CPU_MIPS32_R1
 
+config MACH_JZ4770
+	bool
+	select MIPS_CPU_SCACHE
+	select SYS_HAS_CPU_MIPS32_R2
+	select SYS_SUPPORTS_HIGHMEM
+
 config MACH_JZ4780
 	bool
 	select MIPS_CPU_SCACHE
diff --git a/arch/mips/jz4740/time.c b/arch/mips/jz4740/time.c
index bb1ad5119da4..2ca9160f642a 100644
--- a/arch/mips/jz4740/time.c
+++ b/arch/mips/jz4740/time.c
@@ -113,7 +113,7 @@ static struct clock_event_device jz4740_clockevent = {
 #ifdef CONFIG_MACH_JZ4740
 	.irq = JZ4740_IRQ_TCU0,
 #endif
-#ifdef CONFIG_MACH_JZ4780
+#if defined(CONFIG_MACH_JZ4770) || defined(CONFIG_MACH_JZ4780)
 	.irq = JZ4780_IRQ_TCU2,
 #endif
 };
-- 
2.11.0
