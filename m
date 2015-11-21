Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Nov 2015 01:18:26 +0100 (CET)
Received: from exsmtp03.microchip.com ([198.175.253.49]:24129 "EHLO
        email.microchip.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27013019AbbKUARcE0Gzx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 21 Nov 2015 01:17:32 +0100
Received: from mx.microchip.com (10.10.76.4) by chn-sv-exch03.mchp-main.com
 (10.10.76.49) with Microsoft SMTP Server id 14.3.181.6; Fri, 20 Nov 2015
 17:17:23 -0700
Received: by mx.microchip.com (sSMTP sendmail emulation); Fri, 20 Nov 2015
 17:23:50 -0700
From:   Joshua Henderson <joshua.henderson@microchip.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <linux-mips@linux-mips.org>,
        Joshua Henderson <joshua.henderson@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Andrew Bresticker <abrestic@chromium.org>,
        Paul Burton <paul.burton@imgtec.com>,
        <devicetree@vger.kernel.org>
Subject: [PATCH 13/14] MIPS: dts: Add initial DTS for the PIC32MZDA Starter Kit
Date:   Fri, 20 Nov 2015 17:17:25 -0700
Message-ID: <1448065205-15762-14-git-send-email-joshua.henderson@microchip.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1448065205-15762-1-git-send-email-joshua.henderson@microchip.com>
References: <1448065205-15762-1-git-send-email-joshua.henderson@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <Joshua.Henderson@microchip.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50020
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

This adds basic DTS configuration for the PIC32MZDA and in turn the
PIC32MZDA Starter Kit.

Signed-off-by: Joshua Henderson <joshua.henderson@microchip.com>
---
 arch/mips/boot/dts/Makefile                 |    1 +
 arch/mips/boot/dts/pic32/Makefile           |   12 ++
 arch/mips/boot/dts/pic32/pic32mzda-clk.dtsi |  251 ++++++++++++++++++++++++
 arch/mips/boot/dts/pic32/pic32mzda.dtsi     |  280 +++++++++++++++++++++++++++
 arch/mips/boot/dts/pic32/pic32mzda_sk.dts   |  150 ++++++++++++++
 arch/mips/pic32/Kconfig                     |   16 ++
 6 files changed, 710 insertions(+)
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
index 0000000..fa1d2bb
--- /dev/null
+++ b/arch/mips/boot/dts/pic32/pic32mzda-clk.dtsi
@@ -0,0 +1,251 @@
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
+	/* UPLL provides UTMI clock to USBCORE */
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
+		compatible = "microchip,pic32-clk";
+		interrupts = <12>;
+		ranges;
+
+		/* secondary oscillator; external input on SOSCI pin */
+		SOSC:sosc_clk {
+			#clock-cells = <0>;
+			compatible = "microchip,pic32-sosc";
+			clock-frequency = <32768>;
+			reg = <0x1f801200 0x10   /* enable reg */
+			       0x1f8013d0 0x10>; /* status reg */
+			microchip,bit-mask = <0x02>; /* enable mask */
+			microchip,status-bit-mask = <0x10>; /* status-mask*/
+		};
+
+		FRCDIV:frcdiv_clk {
+			#clock-cells = <0>;
+			compatible = "microchip,pic32-frcdivclk";
+			clocks = <&FRC>;
+			clock-output-names = "frcdiv_clk";
+		};
+
+		/* System PLL clock */
+		SYSPLL:spll_clk {
+			#clock-cells = <0>;
+			compatible = "microchip,pic32-syspll";
+			reg = <0x1f801220 0x10 /* SPLL register */
+			       0x1f8013d0 0x10>; /* CLKSTAT register */
+			clocks = <&POSC>, <&FRC>;
+			clock-output-names = "sys_pll";
+			microchip,status-bit-mask = <0x80>; /* SPLLRDY */
+		};
+
+		/* system clock; mux with postdiv & slew */
+		SYSCLK:sys_clk {
+			#clock-cells = <0>;
+			compatible = "microchip,pic32-sysclk-v2";
+			reg = <0x1f8013c0 0x04>; /* SLEWCON */
+			clocks = <&FRCDIV>, <&SYSPLL>, <&POSC>, <&SOSC>,
+				 <&LPRC>, <&FRCDIV>;
+			microchip,clock-indices = <0>, <1>, <2>, <4>, <5>, <7>;
+			clock-output-names = "sys_clk";
+		};
+
+		/* DDR Ctrl & DDR PHY PLL */
+		MPLL: CLK_MPLL {
+			#clock-cells = <0>;
+			compatible = "microchip,pic32-mpll";
+			reg = <0x1f800100 0x04>; /* CFGMPLL */
+			clocks = <&POSC>;
+			clock-output-names = "pic32-mpll";
+			status = "disabled";
+		};
+
+		/* Peripheral bus1 clock */
+		PBCLK1:pb1_clk {
+			reg = <0x1f801340 0x10>;
+			#clock-cells = <0>;
+			compatible = "microchip,pic32-pbclk";
+			clocks = <&SYSCLK>;
+			clock-output-names = "pb1_clk";
+			/* used by system modules, not gateable */
+			microchip,ignore-unused;
+		};
+
+		/* Peripheral bus2 clock */
+		PBCLK2:pb2_clk {
+			reg = <0x1f801350 0x10>;
+			#clock-cells = <0>;
+			compatible = "microchip,pic32-pbclk";
+			clocks = <&SYSCLK>;
+			clock-output-names = "pb2_clk";
+			/* avoid gating even if unused */
+			microchip,ignore-unused;
+		};
+
+		/* Peripheral bus3 clock */
+		PBCLK3:pb3_clk {
+			reg = <0x1f801360 0x10>;
+			#clock-cells = <0>;
+			compatible = "microchip,pic32-pbclk";
+			clocks = <&SYSCLK>;
+			clock-output-names = "pb3_clk";
+		};
+
+		/* Peripheral bus4 clock(I/O ports, GPIO) */
+		PBCLK4:pb4_clk {
+			reg = <0x1f801370 0x10>;
+			#clock-cells = <0>;
+			compatible = "microchip,pic32-pbclk";
+			clocks = <&SYSCLK>;
+			clock-output-names = "pb4_clk";
+		};
+
+		/* Peripheral bus clock */
+		PBCLK5:pb5_clk {
+			reg = <0x1f801380 0x10>;
+			#clock-cells = <0>;
+			compatible = "microchip,pic32-pbclk";
+			clocks = <&SYSCLK>;
+			clock-output-names = "pb5_clk";
+		};
+
+		/* Peripheral Bus6 clock; */
+		PBCLK6:pb6_clk {
+			reg = <0x1f801390 0x10>;
+			compatible = "microchip,pic32-pbclk";
+			clocks = <&SYSCLK>;
+			#clock-cells = <0>;
+		};
+
+		/* Peripheral bus7 clock */
+		PBCLK7:pb7_clk {
+			reg = <0x1f8013A0 0x10>;
+			#clock-cells = <0>;
+			compatible = "microchip,pic32-pbclk";
+			/* CPU is driven by this clock; so named */
+			clock-output-names = "cpu_clk";
+			clocks = <&SYSCLK>;
+		};
+
+		/* Reference Oscillator clock for SPI/I2S */
+		REFCLKO1:refo1_clk {
+			reg = <0x1f801280 0x20>;
+			#clock-cells = <0>;
+			compatible = "microchip,pic32-refoclk";
+			clocks = <&SYSCLK>, <&PBCLK1>, <&POSC>, <&FRC>, <&LPRC>,
+				<&SOSC>, <&SYSPLL>, <&REFIx>, <&BFRC>;
+			microchip,clock-indices = <0>, <1>, <2>, <3>, <4>,
+						  <5>, <7>, <8>, <9>;
+			clock-output-names = "refo1_clk";
+			clock-frequency = <10000000>;  /* 10Mhz for I2S MCLK */
+		};
+
+		/* Reference Oscillator clock for SQI */
+		REFCLKO2:refo2_clk {
+			reg = <0x1f8012A0 0x20>;
+			#clock-cells = <0>;
+			compatible = "microchip,pic32-refoclk";
+			clocks = <&SYSCLK>, <&PBCLK1>, <&POSC>, <&FRC>, <&LPRC>,
+				<&SOSC>, <&SYSPLL>, <&REFIx>, <&BFRC>;
+			microchip,clock-indices = <0>, <1>, <2>, <3>, <4>,
+						  <5>, <7>, <8>, <9>;
+			clock-output-names = "refo2_clk";
+			clock-frequency = <50000000>; /* 50MHz for SQI */
+		};
+
+		/* Reference Oscillator clock, ADC */
+		REFCLKO3:refo3_clk {
+			reg = <0x1f8012C0 0x20>;
+			compatible = "microchip,pic32-refoclk";
+			clocks = <&SYSCLK>, <&PBCLK1>, <&POSC>, <&FRC>, <&LPRC>,
+				<&SOSC>, <&SYSPLL>, <&REFIx>, <&BFRC>;
+			microchip,clock-indices = <0>, <1>, <2>, <3>, <4>,
+						  <5>, <7>, <8>, <9>;
+			#clock-cells = <0>;
+			clock-output-names = "refo3_clk";
+			clock-frequency = <10000000>;  /* 1Mhz */
+		};
+
+		/* Reference Oscillator clock */
+		REFCLKO4:refo4_clk {
+			reg = <0x1f8012E0 0x20>;
+			compatible = "microchip,pic32-refoclk";
+			clocks = <&SYSCLK>, <&PBCLK1>, <&POSC>, <&FRC>, <&LPRC>,
+					<&SOSC>, <&SYSPLL>, <&REFIx>, <&BFRC>;
+			microchip,clock-indices = <0>, <1>, <2>, <3>, <4>,
+						  <5>, <7>, <8>, <9>;
+			#clock-cells = <0>;
+			clock-output-names = "refo4_clk";
+			clock-frequency = <25000000>;  /* 25Mhz */
+		};
+
+		/* Reference Oscillator clock, LCD */
+		REFCLKO5:refo5_clk {
+			reg = <0x1f801300 0x20>;
+			compatible = "microchip,pic32-refoclk";
+			clocks = <&SYSCLK>,<&PBCLK1>,<&POSC>,<&FRC>,<&LPRC>,
+				<&SOSC>,<&SYSPLL>,<&REFIx>,<&BFRC>;
+			microchip,clock-indices = <0>, <1>, <2>, <3>, <4>,
+						  <5>, <7>, <8>, <9>;
+			#clock-cells = <0>;
+			clock-output-names = "refo5_clk";
+			clock-frequency = <40000000>;  /* 40Mhz */
+		};
+	};
+};
diff --git a/arch/mips/boot/dts/pic32/pic32mzda.dtsi b/arch/mips/boot/dts/pic32/pic32mzda.dtsi
new file mode 100644
index 0000000..08d3156
--- /dev/null
+++ b/arch/mips/boot/dts/pic32/pic32mzda.dtsi
@@ -0,0 +1,280 @@
+/*
+ * Copyright (C) 2015 Microchip Technology Inc.  All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <dt-bindings/interrupt-controller/microchip,pic32mz-evic.h>
+
+#include "pic32mzda-clk.dtsi"
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	interrupt-parent = <&evic>;
+
+	aliases {
+		gpio0 = &pioA;
+		gpio1 = &pioB;
+		gpio2 = &pioC;
+		gpio3 = &pioD;
+		gpio4 = &pioE;
+		gpio5 = &pioF;
+		gpio6 = &pioG;
+		gpio7 = &pioH;
+		gpio8 = &pioJ;
+		gpio9 = &pioK;
+		serial1 = &usart2;
+		serial3 = &usart4;
+		serial5 = &usart6;
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
+		compatible = "microchip,evic-v2";
+		interrupt-controller;
+		#interrupt-cells = <3>;
+		reg = <0x1f810000 0x1000>;
+		device_type="evic-v2";
+	};
+
+	pic32_pinctrl: pinctrl@1f800000{
+		#address-cells = <1>;
+		#size-cells = <1>;
+		#gpio-range-cells = <3>;
+		compatible = "microchip,pic32-pinctrl", "simple-bus";
+		ranges;
+		reg = <0x1f801400 0x100>, /* in	 */
+		      <0x1f801500 0x200>; /* out */
+		clocks = <&PBCLK1>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-ranges = <&pic32_pinctrl 0 0 32
+			&pic32_pinctrl 0 32 32
+			&pic32_pinctrl 0 64 32
+			&pic32_pinctrl 0 96 32
+			&pic32_pinctrl 0 128 32
+			&pic32_pinctrl 0 160 32
+			&pic32_pinctrl 0 192 32
+			&pic32_pinctrl 0 224 32
+			&pic32_pinctrl 0 256 32
+			&pic32_pinctrl 0 288 32>;
+
+		/* GPIO banks */
+		pioA: gpio@1f860000 {
+			compatible = "microchip,pic32-gpio";
+			reg = <0x1f860000 0x24>;
+			interrupts = <PORTA_INPUT_CHANGE_INTERRUPT
+					DEFAULT_INT_PRI IRQ_TYPE_LEVEL_HIGH>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&PBCLK4>;
+		};
+
+		pioB: gpio@1f860100 {
+			compatible = "microchip,pic32-gpio";
+			reg = <0x1f860100 0x24>;
+			interrupts = <PORTB_INPUT_CHANGE_INTERRUPT
+					DEFAULT_INT_PRI IRQ_TYPE_LEVEL_HIGH>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&PBCLK4>;
+		};
+
+		pioC: gpio@1f860200 {
+			compatible = "microchip,pic32-gpio";
+			reg = <0x1f860200 0x24>;
+			interrupts = <PORTC_INPUT_CHANGE_INTERRUPT
+					DEFAULT_INT_PRI IRQ_TYPE_LEVEL_HIGH>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&PBCLK4>;
+		};
+
+		pioD: gpio@1f860300 {
+			compatible = "microchip,pic32-gpio";
+			reg = <0x1f860300 0x24>;
+			interrupts = <PORTD_INPUT_CHANGE_INTERRUPT
+					DEFAULT_INT_PRI IRQ_TYPE_LEVEL_HIGH>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&PBCLK4>;
+		};
+
+		pioE: gpio@1f860400 {
+			compatible = "microchip,pic32-gpio";
+			reg = <0x1f860400 0x24>;
+			interrupts = <PORTE_INPUT_CHANGE_INTERRUPT
+					DEFAULT_INT_PRI IRQ_TYPE_LEVEL_HIGH>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&PBCLK4>;
+		};
+
+		pioF: gpio@1f860500 {
+			compatible = "microchip,pic32-gpio";
+			reg = <0x1f860500 0x24>;
+			interrupts = <PORTF_INPUT_CHANGE_INTERRUPT
+					DEFAULT_INT_PRI IRQ_TYPE_LEVEL_HIGH>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&PBCLK4>;
+		};
+
+		pioG: gpio@1f860600 {
+			compatible = "microchip,pic32-gpio";
+			reg = <0x1f860600 0x24>;
+			interrupts = <PORTG_INPUT_CHANGE_INTERRUPT
+					 DEFAULT_INT_PRI IRQ_TYPE_LEVEL_HIGH>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&PBCLK4>;
+		};
+
+		pioH: gpio@1f860700 {
+			compatible = "microchip,pic32-gpio";
+			reg = <0x1f860700 0x24>;
+			interrupts = <PORTH_INPUT_CHANGE_INTERRUPT
+					DEFAULT_INT_PRI IRQ_TYPE_LEVEL_HIGH>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&PBCLK4>;
+		};
+
+		/* There is no pioI */
+
+		pioJ: gpio@1f860800 {
+			compatible = "microchip,pic32-gpio";
+			reg = <0x1f860800 0x24>;
+			interrupts = <PORTJ_INPUT_CHANGE_INTERRUPT
+					DEFAULT_INT_PRI IRQ_TYPE_LEVEL_HIGH>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&PBCLK4>;
+		};
+
+		pioK: gpio@1f860900 {
+			compatible = "microchip,pic32-gpio";
+			reg = <0x1f860900 0x24>;
+			interrupts = <PORTK_INPUT_CHANGE_INTERRUPT
+					DEFAULT_INT_PRI IRQ_TYPE_LEVEL_HIGH>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&PBCLK4>;
+		};
+	};
+
+	sdhci: sdhci@1f8ec000 {
+		compatible = "microchip,pic32-sdhci";
+		reg = <0x1f8ec000 0x100>;
+		interrupts = <SDHC_EVENT DEFAULT_INT_PRI IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&REFCLKO4>, <&PBCLK5>;
+		clock-names = "base_clk", "sys_clk";
+		no-1-8-v;
+		status = "disabled";
+	};
+
+	usart1: serial@1f822000 {
+		compatible = "microchip,pic32-usart";
+		reg = <0x1f822000 0x50>;
+		interrupts = <UART1_FAULT DEFAULT_INT_PRI IRQ_TYPE_LEVEL_HIGH>,
+			<UART1_RECEIVE_DONE DEFAULT_INT_PRI
+				IRQ_TYPE_LEVEL_HIGH>,
+			<UART1_TRANSFER_DONE DEFAULT_INT_PRI
+				IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&PBCLK2>;
+		status = "disabled";
+	};
+
+	usart2: serial@1f822200 {
+		compatible = "microchip,pic32-usart";
+		reg = <0x1f822200 0x50>;
+		interrupts = <UART2_FAULT DEFAULT_INT_PRI IRQ_TYPE_LEVEL_HIGH>,
+			<UART2_RECEIVE_DONE DEFAULT_INT_PRI
+				IRQ_TYPE_LEVEL_HIGH>,
+			<UART2_TRANSFER_DONE DEFAULT_INT_PRI
+				IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&PBCLK2>;
+		status = "disabled";
+	};
+
+	usart3: serial@1f822400 {
+		compatible = "microchip,pic32-usart";
+		reg = <0x1f822400 0x50>;
+		interrupts = <UART3_FAULT DEFAULT_INT_PRI IRQ_TYPE_LEVEL_HIGH>,
+			<UART3_RECEIVE_DONE DEFAULT_INT_PRI
+				IRQ_TYPE_LEVEL_HIGH>,
+			<UART3_TRANSFER_DONE DEFAULT_INT_PRI
+				IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&PBCLK2>;
+		status = "disabled";
+	};
+
+	usart4: serial@1f822600 {
+		compatible = "microchip,pic32-usart";
+		reg = <0x1f822600 0x50>;
+		interrupts = <UART4_FAULT DEFAULT_INT_PRI IRQ_TYPE_LEVEL_HIGH>,
+			<UART4_RECEIVE_DONE DEFAULT_INT_PRI
+				IRQ_TYPE_LEVEL_HIGH>,
+			<UART4_TRANSFER_DONE DEFAULT_INT_PRI
+				IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&PBCLK2>;
+		status = "disabled";
+	};
+
+	usart5: serial@1f822800 {
+		compatible = "microchip,pic32-usart";
+		reg = <0x1f822800 0x50>;
+		interrupts = <UART5_FAULT DEFAULT_INT_PRI IRQ_TYPE_LEVEL_HIGH>,
+			<UART5_RECEIVE_DONE DEFAULT_INT_PRI
+				IRQ_TYPE_LEVEL_HIGH>,
+			<UART5_TRANSFER_DONE DEFAULT_INT_PRI
+				IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&PBCLK2>;
+		status = "disabled";
+	};
+
+	usart6: serial@1f822A00 {
+		compatible = "microchip,pic32-usart";
+		reg = <0x1f822A00 0x50>;
+		interrupts = <UART6_FAULT DEFAULT_INT_PRI IRQ_TYPE_LEVEL_HIGH>,
+			<UART6_RECEIVE_DONE DEFAULT_INT_PRI
+				IRQ_TYPE_LEVEL_HIGH>,
+			<UART6_TRANSFER_DONE DEFAULT_INT_PRI
+				IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&PBCLK2>;
+		status = "disabled";
+	};
+};
diff --git a/arch/mips/boot/dts/pic32/pic32mzda_sk.dts b/arch/mips/boot/dts/pic32/pic32mzda_sk.dts
new file mode 100644
index 0000000..5c62228
--- /dev/null
+++ b/arch/mips/boot/dts/pic32/pic32mzda_sk.dts
@@ -0,0 +1,150 @@
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
+#include <dt-bindings/pinctrl/pic32mzda.h>
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
+		bootargs = "earlyprintk=ttyS1,115200n8r console=ttyS1,115200n8";
+	};
+
+	leds0 {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&user_leds_s0>;
+
+		led@1 {
+			label = "pic32mzda_sk:red:led1";
+			gpios = <&pioH 0 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+
+		led@2 {
+			label = "pic32mzda_sk:yellow:led2";
+			gpios = <&pioH 1 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "mmc0";
+		};
+
+		led@3 {
+			label = "pic32mzda_sk:green:led3";
+			gpios = <&pioH 2 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+		};
+	};
+
+	keys0 {
+		compatible = "gpio-keys-polled";
+		pinctrl-0 = <&user_buttons_s0>;
+		pinctrl-names = "default";
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+		poll-interval = <300>;
+
+		button@sw1 {
+			label = "ESC";
+			linux,code = <1>;
+			gpios = <&pioB 12 0>;
+		};
+
+		button@sw2 {
+			label = "Home";
+			linux,code = <102>;
+			gpios = <&pioB 13 0>;
+		};
+
+		button@sw3 {
+			label = "Menu";
+			linux,code = <139>;
+			gpios = <&pioB 14 0>;
+		};
+	};
+};
+
+&usart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2>;
+	status = "okay";
+};
+
+&usart4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart4>;
+	status = "okay";
+};
+
+&sdhci {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sdhc1>;
+	status = "okay";
+};
+
+&pic32_pinctrl {
+
+	sdhc1 {
+		pinctrl_sdhc1: sdhc1_pins0 {
+			/* SDCLK */
+			pic32,single-pins = <PORT_A 6 PIC32_PIN_CONF_DG>,
+				<PORT_D 4 PIC32_PIN_CONF_DG>,	  /* SDCMD */
+				<PORT_G 13 PIC32_PIN_CONF_DG>,	  /* SDDATA0 */
+				<PORT_G 12 PIC32_PIN_CONF_DG>,	  /* SDDATA1 */
+				<PORT_G 14 PIC32_PIN_CONF_DG>,	  /* SDDATA2 */
+				<PORT_A 7 PIC32_PIN_CONF_DG>,	  /* SDDATA3 */
+				<PORT_A 0 PIC32_PIN_CONF_DG>;	  /* SDCD */
+		};
+	};
+
+	leds {
+
+		user_leds_s0: user_leds_s0 {
+			pic32,single-pins = <PORT_H 0 PIC32_PIN_CONF_DG_OUT
+				PORT_H 1 PIC32_PIN_CONF_DG_OUT
+				PORT_H 2 PIC32_PIN_CONF_DG_OUT>;
+		};
+	};
+
+	buttons0 {
+		user_buttons_s0: user_buttons_s0 {
+			pic32,single-pins = <PORT_B 12 PIC32_PIN_CONF_PU_IN
+				PORT_B 13 PIC32_PIN_CONF_PU_IN
+				PORT_B 14 PIC32_PIN_CONF_PU_IN>;
+		};
+	};
+
+	uart2 {
+		pinctrl_uart2: uart2-0 {
+			pic32,pins = <PIC32_RP_OUT_RPG9 PIC32_PP_OUT_U2TX
+					PIC32_PIN_CONF_DG_OUT
+				PIC32_RP_IN_RPB0 PIC32_PP_IN_U2RX
+					PIC32_PIN_CONF_DG_IN>;
+		};
+	};
+
+	uart4 {
+		pinctrl_uart4: uart4-0 {
+			pic32,pins = <PIC32_RP_OUT_RPC3 PIC32_PP_OUT_U4TX
+					PIC32_PIN_CONF_DG_OUT
+				PIC32_RP_IN_RPE8 PIC32_PP_IN_U4RX
+					PIC32_PIN_CONF_DG_IN>;
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
