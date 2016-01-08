Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Jan 2016 01:00:33 +0100 (CET)
Received: from exsmtp01.microchip.com ([198.175.253.37]:34180 "EHLO
        email.microchip.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27010161AbcAGX6WyV5Fu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Jan 2016 00:58:22 +0100
Received: from mx.microchip.com (10.10.76.4) by CHN-SV-EXCH01.mchp-main.com
 (10.10.76.37) with Microsoft SMTP Server id 14.3.181.6; Thu, 7 Jan 2016
 16:58:15 -0700
Received: by mx.microchip.com (sSMTP sendmail emulation); Thu, 07 Jan 2016
 17:05:53 -0700
From:   Joshua Henderson <joshua.henderson@microchip.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>,
        Joshua Henderson <joshua.henderson@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Andrew Bresticker <abrestic@chromium.org>,
        Paul Burton <paul.burton@imgtec.com>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v3 13/14] MIPS: dts: Add initial DTS for the PIC32MZDA Starter Kit
Date:   Thu, 7 Jan 2016 17:00:28 -0700
Message-ID: <1452211389-31025-14-git-send-email-joshua.henderson@microchip.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1452211389-31025-1-git-send-email-joshua.henderson@microchip.com>
References: <1452211389-31025-1-git-send-email-joshua.henderson@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <Joshua.Henderson@microchip.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50980
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joshua.henderson@microchip.com
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

This adds basic DTS configuration for the PIC32MZDA chip and in turn the
PIC32MZDA Starter Kit.

Signed-off-by: Joshua Henderson <joshua.henderson@microchip.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
---
 arch/mips/boot/dts/Makefile                 |    1 +
 arch/mips/boot/dts/pic32/Makefile           |   12 ++
 arch/mips/boot/dts/pic32/pic32mzda-clk.dtsi |  236 +++++++++++++++++++++++
 arch/mips/boot/dts/pic32/pic32mzda.dtsi     |  275 +++++++++++++++++++++++++++
 arch/mips/boot/dts/pic32/pic32mzda_sk.dts   |  151 +++++++++++++++
 arch/mips/pic32/Kconfig                     |   16 ++
 6 files changed, 691 insertions(+)
 create mode 100644 arch/mips/boot/dts/pic32/Makefile
 create mode 100644 arch/mips/boot/dts/pic32/pic32mzda-clk.dtsi
 create mode 100644 arch/mips/boot/dts/pic32/pic32mzda.dtsi
 create mode 100644 arch/mips/boot/dts/pic32/pic32mzda_sk.dts

diff --git a/arch/mips/boot/dts/Makefile b/arch/mips/boot/dts/Makefile
index a0bf516..fc7a0a9 100644
--- a/arch/mips/boot/dts/Makefile
+++ b/arch/mips/boot/dts/Makefile
@@ -4,6 +4,7 @@ dts-dirs	+= ingenic
 dts-dirs	+= lantiq
 dts-dirs	+= mti
 dts-dirs	+= netlogic
+dts-dirs	+= pic32
 dts-dirs	+= qca
 dts-dirs	+= ralink
 dts-dirs	+= xilfpga
diff --git a/arch/mips/boot/dts/pic32/Makefile b/arch/mips/boot/dts/pic32/Makefile
new file mode 100644
index 0000000..7ac7905
--- /dev/null
+++ b/arch/mips/boot/dts/pic32/Makefile
@@ -0,0 +1,12 @@
+dtb-$(CONFIG_DTB_PIC32_MZDA_SK)		+= pic32mzda_sk.dtb
+
+dtb-$(CONFIG_DTB_PIC32_NONE)		+= \
+					pic32mzda_sk.dtb
+
+obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
+
+# Force kbuild to make empty built-in.o if necessary
+obj-				+= dummy.o
+
+always				:= $(dtb-y)
+clean-files			:= *.dtb *.dtb.S
diff --git a/arch/mips/boot/dts/pic32/pic32mzda-clk.dtsi b/arch/mips/boot/dts/pic32/pic32mzda-clk.dtsi
new file mode 100644
index 0000000..ef13350
--- /dev/null
+++ b/arch/mips/boot/dts/pic32/pic32mzda-clk.dtsi
@@ -0,0 +1,236 @@
+/*
+ * Device Tree Source for PIC32MZDA clock data
+ *
+ * Purna Chandra Mandal <purna.mandal@microchip.com>
+ * Copyright (C) 2015 Microchip Technology Inc.  All rights reserved.
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+/* all fixed rate clocks */
+
+/ {
+	POSC:posc_clk { /* On-chip primary oscillator */
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <24000000>;
+	};
+
+	FRC:frc_clk { /* internal FRC oscillator */
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <8000000>;
+	};
+
+	BFRC:bfrc_clk { /* internal backup FRC oscillator */
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <8000000>;
+	};
+
+	LPRC:lprc_clk { /* internal low-power FRC oscillator */
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <32000>;
+	};
+
+	/* UPLL provides clock to USBCORE */
+	UPLL:usb_phy_clk {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <24000000>;
+		clock-output-names = "usbphy_clk";
+	};
+
+	TxCKI:txcki_clk { /* external clock input on TxCLKI pin */
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <4000000>;
+		status = "disabled";
+	};
+
+	/* external clock input on REFCLKIx pin */
+	REFIx:refix_clk {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <24000000>;
+		status = "disabled";
+	};
+
+	/* PIC32 specific clks */
+	pic32_clktree {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0x1f801200 0x200>;
+		compatible = "microchip,pic32mzda-clk";
+		ranges = <0 0x1f801200 0x200>;
+
+		/* secondary oscillator; external input on SOSCI pin */
+		SOSC:sosc_clk@0 {
+			#clock-cells = <0>;
+			compatible = "microchip,pic32mzda-sosc";
+			clock-frequency = <32768>;
+			reg = <0x000 0x10>,   /* enable reg */
+			      <0x1d0 0x10>; /* status reg */
+			microchip,bit-mask = <0x02>; /* enable mask */
+			microchip,status-bit-mask = <0x10>; /* status-mask*/
+		};
+
+		FRCDIV:frcdiv_clk {
+			#clock-cells = <0>;
+			compatible = "microchip,pic32mzda-frcdivclk";
+			clocks = <&FRC>;
+			clock-output-names = "frcdiv_clk";
+		};
+
+		/* System PLL clock */
+		SYSPLL:spll_clk@020 {
+			#clock-cells = <0>;
+			compatible = "microchip,pic32mzda-syspll";
+			reg = <0x020 0x10>, /* SPLL register */
+			      <0x1d0 0x10>; /* CLKSTAT register */
+			clocks = <&POSC>, <&FRC>;
+			clock-output-names = "sys_pll";
+			microchip,status-bit-mask = <0x80>; /* SPLLRDY */
+		};
+
+		/* system clock; mux with postdiv & slew */
+		SYSCLK:sys_clk@1c0 {
+			#clock-cells = <0>;
+			compatible = "microchip,pic32mzda-sysclk-v2";
+			reg = <0x1c0 0x04>; /* SLEWCON */
+			clocks = <&FRCDIV>, <&SYSPLL>, <&POSC>, <&SOSC>,
+				 <&LPRC>, <&FRCDIV>;
+			microchip,clock-indices = <0>, <1>, <2>, <4>,
+						  <5>, <7>;
+			clock-output-names = "sys_clk";
+		};
+
+		/* Peripheral bus1 clock */
+		PBCLK1:pb1_clk@140 {
+			reg = <0x140 0x10>;
+			#clock-cells = <0>;
+			compatible = "microchip,pic32mzda-pbclk";
+			clocks = <&SYSCLK>;
+			clock-output-names = "pb1_clk";
+			/* used by system modules, not gateable */
+			microchip,ignore-unused;
+		};
+
+		/* Peripheral bus2 clock */
+		PBCLK2:pb2_clk@150 {
+			reg = <0x150 0x10>;
+			#clock-cells = <0>;
+			compatible = "microchip,pic32mzda-pbclk";
+			clocks = <&SYSCLK>;
+			clock-output-names = "pb2_clk";
+			/* avoid gating even if unused */
+			microchip,ignore-unused;
+		};
+
+		/* Peripheral bus3 clock */
+		PBCLK3:pb3_clk@160 {
+			reg = <0x160 0x10>;
+			#clock-cells = <0>;
+			compatible = "microchip,pic32mzda-pbclk";
+			clocks = <&SYSCLK>;
+			clock-output-names = "pb3_clk";
+		};
+
+		/* Peripheral bus4 clock(I/O ports, GPIO) */
+		PBCLK4:pb4_clk@170 {
+			reg = <0x170 0x10>;
+			#clock-cells = <0>;
+			compatible = "microchip,pic32mzda-pbclk";
+			clocks = <&SYSCLK>;
+			clock-output-names = "pb4_clk";
+		};
+
+		/* Peripheral bus clock */
+		PBCLK5:pb5_clk@180 {
+			reg = <0x180 0x10>;
+			#clock-cells = <0>;
+			compatible = "microchip,pic32mzda-pbclk";
+			clocks = <&SYSCLK>;
+			clock-output-names = "pb5_clk";
+		};
+
+		/* Peripheral Bus6 clock; */
+		PBCLK6:pb6_clk@190 {
+			reg = <0x190 0x10>;
+			compatible = "microchip,pic32mzda-pbclk";
+			clocks = <&SYSCLK>;
+			#clock-cells = <0>;
+		};
+
+		/* Peripheral bus7 clock */
+		PBCLK7:pb7_clk@1a0 {
+			reg = <0x1a0 0x10>;
+			#clock-cells = <0>;
+			compatible = "microchip,pic32mzda-pbclk";
+			/* CPU is driven by this clock; so named */
+			clock-output-names = "cpu_clk";
+			clocks = <&SYSCLK>;
+		};
+
+		/* Reference Oscillator clock for SPI/I2S */
+		REFCLKO1:refo1_clk@80 {
+			reg = <0x080 0x20>;
+			#clock-cells = <0>;
+			compatible = "microchip,pic32mzda-refoclk";
+			clocks = <&SYSCLK>, <&PBCLK1>, <&POSC>, <&FRC>, <&LPRC>,
+				 <&SOSC>, <&SYSPLL>, <&REFIx>, <&BFRC>;
+			microchip,clock-indices = <0>, <1>, <2>, <3>, <4>,
+						  <5>, <7>, <8>, <9>;
+			clock-output-names = "refo1_clk";
+		};
+
+		/* Reference Oscillator clock for SQI */
+		REFCLKO2:refo2_clk@a0 {
+			reg = <0x0a0 0x20>;
+			#clock-cells = <0>;
+			compatible = "microchip,pic32mzda-refoclk";
+			clocks = <&SYSCLK>, <&PBCLK1>, <&POSC>, <&FRC>, <&LPRC>,
+				 <&SOSC>, <&SYSPLL>, <&REFIx>, <&BFRC>;
+			microchip,clock-indices = <0>, <1>, <2>, <3>, <4>,
+						  <5>, <7>, <8>, <9>;
+			clock-output-names = "refo2_clk";
+		};
+
+		/* Reference Oscillator clock, ADC */
+		REFCLKO3:refo3_clk@c0 {
+			reg = <0x0c0 0x20>;
+			compatible = "microchip,pic32mzda-refoclk";
+			clocks = <&SYSCLK>, <&PBCLK1>, <&POSC>, <&FRC>, <&LPRC>,
+				 <&SOSC>, <&SYSPLL>, <&REFIx>, <&BFRC>;
+			microchip,clock-indices = <0>, <1>, <2>, <3>, <4>,
+						  <5>, <7>, <8>, <9>;
+			#clock-cells = <0>;
+			clock-output-names = "refo3_clk";
+		};
+
+		/* Reference Oscillator clock */
+		REFCLKO4:refo4_clk@e0 {
+			reg = <0x0e0 0x20>;
+			compatible = "microchip,pic32mzda-refoclk";
+			clocks = <&SYSCLK>, <&PBCLK1>, <&POSC>, <&FRC>, <&LPRC>,
+				 <&SOSC>, <&SYSPLL>, <&REFIx>, <&BFRC>;
+			microchip,clock-indices = <0>, <1>, <2>, <3>, <4>,
+						  <5>, <7>, <8>, <9>;
+			#clock-cells = <0>;
+			clock-output-names = "refo4_clk";
+		};
+
+		/* Reference Oscillator clock, LCD */
+		REFCLKO5:refo5_clk@100 {
+			reg = <0x100 0x20>;
+			compatible = "microchip,pic32mzda-refoclk";
+			clocks = <&SYSCLK>,<&PBCLK1>,<&POSC>,<&FRC>,<&LPRC>,
+				 <&SOSC>,<&SYSPLL>,<&REFIx>,<&BFRC>;
+			microchip,clock-indices = <0>, <1>, <2>, <3>, <4>,
+						  <5>, <7>, <8>, <9>;
+			#clock-cells = <0>;
+			clock-output-names = "refo5_clk";
+		};
+	};
+};
diff --git a/arch/mips/boot/dts/pic32/pic32mzda.dtsi b/arch/mips/boot/dts/pic32/pic32mzda.dtsi
new file mode 100644
index 0000000..3eee106
--- /dev/null
+++ b/arch/mips/boot/dts/pic32/pic32mzda.dtsi
@@ -0,0 +1,275 @@
+/*
+ * Copyright (C) 2015 Microchip Technology Inc.  All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <dt-bindings/interrupt-controller/irq.h>
+
+#include "pic32mzda-clk.dtsi"
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	interrupt-parent = <&evic>;
+
+	aliases {
+		gpio0 = &gpio0;
+		gpio1 = &gpio1;
+		gpio2 = &gpio2;
+		gpio3 = &gpio3;
+		gpio4 = &gpio4;
+		gpio5 = &gpio5;
+		gpio6 = &gpio6;
+		gpio7 = &gpio7;
+		gpio8 = &gpio8;
+		gpio9 = &gpio9;
+		serial0 = &uart1;
+		serial1 = &uart2;
+		serial2 = &uart3;
+		serial3 = &uart4;
+		serial4 = &uart5;
+		serial5 = &uart6;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu@0 {
+			compatible = "mti,mips14KEc";
+			device_type = "cpu";
+		};
+	};
+
+	evic: interrupt-controller@1f810000 {
+		compatible = "microchip,pic32mzda-evic";
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		reg = <0x1f810000 0x1000>;
+	};
+
+	pic32_pinctrl: pinctrl@1f801400{
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "microchip,pic32mzda-pinctrl";
+		reg = <0x1f801400 0x400>;
+		clocks = <&PBCLK1>;
+	};
+
+	/* PORTA */
+	gpio0: gpio0@1f860000 {
+		compatible = "microchip,pic32mzda-gpio";
+		reg = <0x1f860000 0x100>;
+		interrupts = <118 IRQ_TYPE_LEVEL_HIGH>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		clocks = <&PBCLK4>;
+		microchip,gpio-bank = <0>;
+		gpio-ranges = <&pic32_pinctrl 0 0 16>;
+	};
+
+	/* PORTB */
+	gpio1: gpio1@1f860100 {
+		compatible = "microchip,pic32mzda-gpio";
+		reg = <0x1f860100 0x100>;
+		interrupts = <119 IRQ_TYPE_LEVEL_HIGH>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		clocks = <&PBCLK4>;
+		microchip,gpio-bank = <1>;
+		gpio-ranges = <&pic32_pinctrl 0 16 16>;
+	};
+
+	/* PORTC */
+	gpio2: gpio2@1f860200 {
+		compatible = "microchip,pic32mzda-gpio";
+		reg = <0x1f860200 0x100>;
+		interrupts = <120 IRQ_TYPE_LEVEL_HIGH>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		clocks = <&PBCLK4>;
+		microchip,gpio-bank = <2>;
+		gpio-ranges = <&pic32_pinctrl 0 32 16>;
+	};
+
+	/* PORTD */
+	gpio3: gpio3@1f860300 {
+		compatible = "microchip,pic32mzda-gpio";
+		reg = <0x1f860300 0x100>;
+		interrupts = <121 IRQ_TYPE_LEVEL_HIGH>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		clocks = <&PBCLK4>;
+		microchip,gpio-bank = <3>;
+		gpio-ranges = <&pic32_pinctrl 0 48 16>;
+	};
+
+	/* PORTE */
+	gpio4: gpio4@1f860400 {
+		compatible = "microchip,pic32mzda-gpio";
+		reg = <0x1f860400 0x100>;
+		interrupts = <122 IRQ_TYPE_LEVEL_HIGH>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		clocks = <&PBCLK4>;
+		microchip,gpio-bank = <4>;
+		gpio-ranges = <&pic32_pinctrl 0 64 16>;
+	};
+
+	/* PORTF */
+	gpio5: gpio5@1f860500 {
+		compatible = "microchip,pic32mzda-gpio";
+		reg = <0x1f860500 0x100>;
+		interrupts = <123 IRQ_TYPE_LEVEL_HIGH>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		clocks = <&PBCLK4>;
+		microchip,gpio-bank = <5>;
+		gpio-ranges = <&pic32_pinctrl 0 80 16>;
+	};
+
+	/* PORTG */
+	gpio6: gpio6@1f860600 {
+		compatible = "microchip,pic32mzda-gpio";
+		reg = <0x1f860600 0x100>;
+		interrupts = <124 IRQ_TYPE_LEVEL_HIGH>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		clocks = <&PBCLK4>;
+		microchip,gpio-bank = <6>;
+		gpio-ranges = <&pic32_pinctrl 0 96 16>;
+	};
+
+	/* PORTH */
+	gpio7: gpio7@1f860700 {
+		compatible = "microchip,pic32mzda-gpio";
+		reg = <0x1f860700 0x100>;
+		interrupts = <125 IRQ_TYPE_LEVEL_HIGH>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		clocks = <&PBCLK4>;
+		microchip,gpio-bank = <7>;
+		gpio-ranges = <&pic32_pinctrl 0 112 16>;
+	};
+
+	/* PORTI does not exist */
+
+	/* PORTJ */
+	gpio8: gpio8@1f860800 {
+		compatible = "microchip,pic32mzda-gpio";
+		reg = <0x1f860800 0x100>;
+		interrupts = <126 IRQ_TYPE_LEVEL_HIGH>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		clocks = <&PBCLK4>;
+		microchip,gpio-bank = <8>;
+		gpio-ranges = <&pic32_pinctrl 0 128 16>;
+	};
+
+	/* PORTK */
+	gpio9: gpio9@1f860900 {
+		compatible = "microchip,pic32mzda-gpio";
+		reg = <0x1f860900 0x100>;
+		interrupts = <127 IRQ_TYPE_LEVEL_HIGH>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		clocks = <&PBCLK4>;
+		microchip,gpio-bank = <9>;
+		gpio-ranges = <&pic32_pinctrl 0 144 16>;
+	};
+
+	sdhci: sdhci@1f8ec000 {
+		compatible = "microchip,pic32mzda-sdhci";
+		reg = <0x1f8ec000 0x100>;
+		interrupts = <191 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&REFCLKO4>, <&PBCLK5>;
+		clock-names = "base_clk", "sys_clk";
+		bus-width = <4>;
+		cap-sd-highspeed;
+		status = "disabled";
+	};
+
+	uart1: serial@1f822000 {
+		compatible = "microchip,pic32mzda-uart";
+		reg = <0x1f822000 0x50>;
+		interrupts = <112 IRQ_TYPE_LEVEL_HIGH>,
+			<113 IRQ_TYPE_LEVEL_HIGH>,
+			<114 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&PBCLK2>;
+		status = "disabled";
+	};
+
+	uart2: serial@1f822200 {
+		compatible = "microchip,pic32mzda-uart";
+		reg = <0x1f822200 0x50>;
+		interrupts = <145 IRQ_TYPE_LEVEL_HIGH>,
+			<146 IRQ_TYPE_LEVEL_HIGH>,
+			<147 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&PBCLK2>;
+		status = "disabled";
+	};
+
+	uart3: serial@1f822400 {
+		compatible = "microchip,pic32mzda-uart";
+		reg = <0x1f822400 0x50>;
+		interrupts = <157 IRQ_TYPE_LEVEL_HIGH>,
+			<158 IRQ_TYPE_LEVEL_HIGH>,
+			<159 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&PBCLK2>;
+		status = "disabled";
+	};
+
+	uart4: serial@1f822600 {
+		compatible = "microchip,pic32mzda-uart";
+		reg = <0x1f822600 0x50>;
+		interrupts = <170 IRQ_TYPE_LEVEL_HIGH>,
+			<171 IRQ_TYPE_LEVEL_HIGH>,
+			<172 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&PBCLK2>;
+		status = "disabled";
+	};
+
+	uart5: serial@1f822800 {
+		compatible = "microchip,pic32mzda-uart";
+		reg = <0x1f822800 0x50>;
+		interrupts = <179 IRQ_TYPE_LEVEL_HIGH>,
+			<180 IRQ_TYPE_LEVEL_HIGH>,
+			<181 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&PBCLK2>;
+		status = "disabled";
+	};
+
+	uart6: serial@1f822A00 {
+		compatible = "microchip,pic32mzda-uart";
+		reg = <0x1f822A00 0x50>;
+		interrupts = <188 IRQ_TYPE_LEVEL_HIGH>,
+			<189 IRQ_TYPE_LEVEL_HIGH>,
+			<190 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&PBCLK2>;
+		status = "disabled";
+	};
+};
diff --git a/arch/mips/boot/dts/pic32/pic32mzda_sk.dts b/arch/mips/boot/dts/pic32/pic32mzda_sk.dts
new file mode 100644
index 0000000..5d434a5
--- /dev/null
+++ b/arch/mips/boot/dts/pic32/pic32mzda_sk.dts
@@ -0,0 +1,151 @@
+/*
+ * Copyright (C) 2015 Microchip Technology Inc.  All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+
+#include "pic32mzda.dtsi"
+
+/ {
+	compatible = "microchip,pic32mzda-sk", "microchip,pic32mzda";
+	model = "Microchip PIC32MZDA Starter Kit";
+
+	memory {
+		device_type = "memory";
+		reg = <0x08000000 0x08000000>;
+	};
+
+	chosen {
+		bootargs = "earlyprintk=ttyPIC1,115200n8r console=ttyPIC1,115200n8";
+	};
+
+	leds0 {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&user_leds_s0>;
+
+		led@1 {
+			label = "pic32mzda_sk:red:led1";
+			gpios = <&gpio7 0 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+
+		led@2 {
+			label = "pic32mzda_sk:yellow:led2";
+			gpios = <&gpio7 1 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "mmc0";
+		};
+
+		led@3 {
+			label = "pic32mzda_sk:green:led3";
+			gpios = <&gpio7 2 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+		};
+	};
+
+	keys0 {
+		compatible = "gpio-keys";
+		pinctrl-0 = <&user_buttons_s0>;
+		pinctrl-names = "default";
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		button@sw1 {
+			label = "ESC";
+			linux,code = <1>;
+			gpios = <&gpio1 12 0>;
+		};
+
+		button@sw2 {
+			label = "Home";
+			linux,code = <102>;
+			gpios = <&gpio1 13 0>;
+		};
+
+		button@sw3 {
+			label = "Menu";
+			linux,code = <139>;
+			gpios = <&gpio1 14 0>;
+		};
+	};
+};
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2>;
+	status = "okay";
+};
+
+&uart4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart4>;
+	status = "okay";
+};
+
+&sdhci {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sdhc1>;
+	status = "okay";
+	assigned-clocks = <&REFCLKO2>,<&REFCLKO4>,<&REFCLKO5>;
+	assigned-clock-rates = <50000000>,<25000000>,<40000000>;
+};
+
+&pic32_pinctrl {
+
+	pinctrl_sdhc1: sdhc1_pins0 {
+		pins = "A6", "D4", "G13", "G12", "G14", "A7", "A0";
+		microchip,digital;
+	};
+
+	user_leds_s0: user_leds_s0 {
+		pins = "H0", "H1", "H2";
+		output-low;
+		microchip,digital;
+	};
+
+	user_buttons_s0: user_buttons_s0 {
+		pins = "B12", "B13", "B14";
+		microchip,digital;
+		input-enable;
+		bias-pull-up;
+	};
+
+	pinctrl_uart2: pinctrl_uart2 {
+		uart2-tx {
+			pins = "G9";
+			function = "U2TX";
+			microchip,digital;
+			output-high;
+		};
+		uart2-rx {
+			pins = "B0";
+			function = "U2RX";
+			microchip,digital;
+			input-enable;
+		};
+	};
+
+	pinctrl_uart4: uart4-0 {
+		uart4-tx {
+			pins = "C3";
+			function = "U4TX";
+			microchip,digital;
+			output-high;
+		};
+		uart4-rx {
+			pins = "E8";
+			function = "U4RX";
+			microchip,digital;
+			input-enable;
+		};
+	};
+};
diff --git a/arch/mips/pic32/Kconfig b/arch/mips/pic32/Kconfig
index 0161f09..b1bd7ba 100644
--- a/arch/mips/pic32/Kconfig
+++ b/arch/mips/pic32/Kconfig
@@ -31,4 +31,20 @@ config PIC32MZDA
 
 endchoice
 
+choice
+	prompt "Devicetree selection"
+	default DTB_PIC32_NONE
+	help
+	  Select the devicetree.
+
+config DTB_PIC32_NONE
+       bool "None"
+
+config DTB_PIC32_MZDA_SK
+       bool "PIC32MZDA Starter Kit"
+       depends on PIC32MZDA
+       select BUILTIN_DTB
+
+endchoice
+
 endif # MACH_PIC32
-- 
1.7.9.5
