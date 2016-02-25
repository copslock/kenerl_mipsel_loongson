Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Feb 2016 19:09:08 +0100 (CET)
Received: from exsmtp03.microchip.com ([198.175.253.49]:7425 "EHLO
        email.microchip.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27013960AbcBYSIyz1Lmy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Feb 2016 19:08:54 +0100
Received: from mx.microchip.com (10.10.76.4) by chn-sv-exch03.mchp-main.com
 (10.10.76.49) with Microsoft SMTP Server id 14.3.181.6; Thu, 25 Feb 2016
 11:08:47 -0700
Received: by mx.microchip.com (sSMTP sendmail emulation); Thu, 25 Feb 2016
 11:09:33 -0700
From:   Joshua Henderson <joshua.henderson@microchip.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>,
        Purna Chandra Mandal <purna.mandal@microchip.com>,
        Joshua Henderson <joshua.henderson@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Sandeep Sheriker <sandeepsheriker.mallikarjun@microchip.com>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v9 3/3] MIPS: dts: pic32: Update dts to reflect new PIC32MZDA clk binding
Date:   Thu, 25 Feb 2016 11:07:53 -0700
Message-ID: <1456423709-24145-4-git-send-email-joshua.henderson@microchip.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1456423709-24145-1-git-send-email-joshua.henderson@microchip.com>
References: <1456423709-24145-1-git-send-email-joshua.henderson@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <Joshua.Henderson@microchip.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52266
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

From: Purna Chandra Mandal <purna.mandal@microchip.com>

- now clock nodes definition is merged with core .dtsi file
- only one rootclk is now part of DT
- clock clients also updated based on new binding doc

Signed-off-by: Purna Chandra Mandal <purna.mandal@microchip.com>
Signed-off-by: Joshua Henderson <joshua.henderson@microchip.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>
---
Note: Please pull this complete series through the MIPS tree.

Changes since v8: None
Changes since v7: None
---
 arch/mips/boot/dts/pic32/pic32mzda-clk.dtsi |  236 ---------------------------
 arch/mips/boot/dts/pic32/pic32mzda.dtsi     |   63 ++++---
 arch/mips/boot/dts/pic32/pic32mzda_sk.dts   |    5 +-
 3 files changed, 45 insertions(+), 259 deletions(-)
 delete mode 100644 arch/mips/boot/dts/pic32/pic32mzda-clk.dtsi

diff --git a/arch/mips/boot/dts/pic32/pic32mzda-clk.dtsi b/arch/mips/boot/dts/pic32/pic32mzda-clk.dtsi
deleted file mode 100644
index ef13350..0000000
--- a/arch/mips/boot/dts/pic32/pic32mzda-clk.dtsi
+++ /dev/null
@@ -1,236 +0,0 @@
-/*
- * Device Tree Source for PIC32MZDA clock data
- *
- * Purna Chandra Mandal <purna.mandal@microchip.com>
- * Copyright (C) 2015 Microchip Technology Inc.  All rights reserved.
- *
- * Licensed under GPLv2 or later.
- */
-
-/* all fixed rate clocks */
-
-/ {
-	POSC:posc_clk { /* On-chip primary oscillator */
-		#clock-cells = <0>;
-		compatible = "fixed-clock";
-		clock-frequency = <24000000>;
-	};
-
-	FRC:frc_clk { /* internal FRC oscillator */
-		#clock-cells = <0>;
-		compatible = "fixed-clock";
-		clock-frequency = <8000000>;
-	};
-
-	BFRC:bfrc_clk { /* internal backup FRC oscillator */
-		#clock-cells = <0>;
-		compatible = "fixed-clock";
-		clock-frequency = <8000000>;
-	};
-
-	LPRC:lprc_clk { /* internal low-power FRC oscillator */
-		#clock-cells = <0>;
-		compatible = "fixed-clock";
-		clock-frequency = <32000>;
-	};
-
-	/* UPLL provides clock to USBCORE */
-	UPLL:usb_phy_clk {
-		#clock-cells = <0>;
-		compatible = "fixed-clock";
-		clock-frequency = <24000000>;
-		clock-output-names = "usbphy_clk";
-	};
-
-	TxCKI:txcki_clk { /* external clock input on TxCLKI pin */
-		#clock-cells = <0>;
-		compatible = "fixed-clock";
-		clock-frequency = <4000000>;
-		status = "disabled";
-	};
-
-	/* external clock input on REFCLKIx pin */
-	REFIx:refix_clk {
-		#clock-cells = <0>;
-		compatible = "fixed-clock";
-		clock-frequency = <24000000>;
-		status = "disabled";
-	};
-
-	/* PIC32 specific clks */
-	pic32_clktree {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		reg = <0x1f801200 0x200>;
-		compatible = "microchip,pic32mzda-clk";
-		ranges = <0 0x1f801200 0x200>;
-
-		/* secondary oscillator; external input on SOSCI pin */
-		SOSC:sosc_clk@0 {
-			#clock-cells = <0>;
-			compatible = "microchip,pic32mzda-sosc";
-			clock-frequency = <32768>;
-			reg = <0x000 0x10>,   /* enable reg */
-			      <0x1d0 0x10>; /* status reg */
-			microchip,bit-mask = <0x02>; /* enable mask */
-			microchip,status-bit-mask = <0x10>; /* status-mask*/
-		};
-
-		FRCDIV:frcdiv_clk {
-			#clock-cells = <0>;
-			compatible = "microchip,pic32mzda-frcdivclk";
-			clocks = <&FRC>;
-			clock-output-names = "frcdiv_clk";
-		};
-
-		/* System PLL clock */
-		SYSPLL:spll_clk@020 {
-			#clock-cells = <0>;
-			compatible = "microchip,pic32mzda-syspll";
-			reg = <0x020 0x10>, /* SPLL register */
-			      <0x1d0 0x10>; /* CLKSTAT register */
-			clocks = <&POSC>, <&FRC>;
-			clock-output-names = "sys_pll";
-			microchip,status-bit-mask = <0x80>; /* SPLLRDY */
-		};
-
-		/* system clock; mux with postdiv & slew */
-		SYSCLK:sys_clk@1c0 {
-			#clock-cells = <0>;
-			compatible = "microchip,pic32mzda-sysclk-v2";
-			reg = <0x1c0 0x04>; /* SLEWCON */
-			clocks = <&FRCDIV>, <&SYSPLL>, <&POSC>, <&SOSC>,
-				 <&LPRC>, <&FRCDIV>;
-			microchip,clock-indices = <0>, <1>, <2>, <4>,
-						  <5>, <7>;
-			clock-output-names = "sys_clk";
-		};
-
-		/* Peripheral bus1 clock */
-		PBCLK1:pb1_clk@140 {
-			reg = <0x140 0x10>;
-			#clock-cells = <0>;
-			compatible = "microchip,pic32mzda-pbclk";
-			clocks = <&SYSCLK>;
-			clock-output-names = "pb1_clk";
-			/* used by system modules, not gateable */
-			microchip,ignore-unused;
-		};
-
-		/* Peripheral bus2 clock */
-		PBCLK2:pb2_clk@150 {
-			reg = <0x150 0x10>;
-			#clock-cells = <0>;
-			compatible = "microchip,pic32mzda-pbclk";
-			clocks = <&SYSCLK>;
-			clock-output-names = "pb2_clk";
-			/* avoid gating even if unused */
-			microchip,ignore-unused;
-		};
-
-		/* Peripheral bus3 clock */
-		PBCLK3:pb3_clk@160 {
-			reg = <0x160 0x10>;
-			#clock-cells = <0>;
-			compatible = "microchip,pic32mzda-pbclk";
-			clocks = <&SYSCLK>;
-			clock-output-names = "pb3_clk";
-		};
-
-		/* Peripheral bus4 clock(I/O ports, GPIO) */
-		PBCLK4:pb4_clk@170 {
-			reg = <0x170 0x10>;
-			#clock-cells = <0>;
-			compatible = "microchip,pic32mzda-pbclk";
-			clocks = <&SYSCLK>;
-			clock-output-names = "pb4_clk";
-		};
-
-		/* Peripheral bus clock */
-		PBCLK5:pb5_clk@180 {
-			reg = <0x180 0x10>;
-			#clock-cells = <0>;
-			compatible = "microchip,pic32mzda-pbclk";
-			clocks = <&SYSCLK>;
-			clock-output-names = "pb5_clk";
-		};
-
-		/* Peripheral Bus6 clock; */
-		PBCLK6:pb6_clk@190 {
-			reg = <0x190 0x10>;
-			compatible = "microchip,pic32mzda-pbclk";
-			clocks = <&SYSCLK>;
-			#clock-cells = <0>;
-		};
-
-		/* Peripheral bus7 clock */
-		PBCLK7:pb7_clk@1a0 {
-			reg = <0x1a0 0x10>;
-			#clock-cells = <0>;
-			compatible = "microchip,pic32mzda-pbclk";
-			/* CPU is driven by this clock; so named */
-			clock-output-names = "cpu_clk";
-			clocks = <&SYSCLK>;
-		};
-
-		/* Reference Oscillator clock for SPI/I2S */
-		REFCLKO1:refo1_clk@80 {
-			reg = <0x080 0x20>;
-			#clock-cells = <0>;
-			compatible = "microchip,pic32mzda-refoclk";
-			clocks = <&SYSCLK>, <&PBCLK1>, <&POSC>, <&FRC>, <&LPRC>,
-				 <&SOSC>, <&SYSPLL>, <&REFIx>, <&BFRC>;
-			microchip,clock-indices = <0>, <1>, <2>, <3>, <4>,
-						  <5>, <7>, <8>, <9>;
-			clock-output-names = "refo1_clk";
-		};
-
-		/* Reference Oscillator clock for SQI */
-		REFCLKO2:refo2_clk@a0 {
-			reg = <0x0a0 0x20>;
-			#clock-cells = <0>;
-			compatible = "microchip,pic32mzda-refoclk";
-			clocks = <&SYSCLK>, <&PBCLK1>, <&POSC>, <&FRC>, <&LPRC>,
-				 <&SOSC>, <&SYSPLL>, <&REFIx>, <&BFRC>;
-			microchip,clock-indices = <0>, <1>, <2>, <3>, <4>,
-						  <5>, <7>, <8>, <9>;
-			clock-output-names = "refo2_clk";
-		};
-
-		/* Reference Oscillator clock, ADC */
-		REFCLKO3:refo3_clk@c0 {
-			reg = <0x0c0 0x20>;
-			compatible = "microchip,pic32mzda-refoclk";
-			clocks = <&SYSCLK>, <&PBCLK1>, <&POSC>, <&FRC>, <&LPRC>,
-				 <&SOSC>, <&SYSPLL>, <&REFIx>, <&BFRC>;
-			microchip,clock-indices = <0>, <1>, <2>, <3>, <4>,
-						  <5>, <7>, <8>, <9>;
-			#clock-cells = <0>;
-			clock-output-names = "refo3_clk";
-		};
-
-		/* Reference Oscillator clock */
-		REFCLKO4:refo4_clk@e0 {
-			reg = <0x0e0 0x20>;
-			compatible = "microchip,pic32mzda-refoclk";
-			clocks = <&SYSCLK>, <&PBCLK1>, <&POSC>, <&FRC>, <&LPRC>,
-				 <&SOSC>, <&SYSPLL>, <&REFIx>, <&BFRC>;
-			microchip,clock-indices = <0>, <1>, <2>, <3>, <4>,
-						  <5>, <7>, <8>, <9>;
-			#clock-cells = <0>;
-			clock-output-names = "refo4_clk";
-		};
-
-		/* Reference Oscillator clock, LCD */
-		REFCLKO5:refo5_clk@100 {
-			reg = <0x100 0x20>;
-			compatible = "microchip,pic32mzda-refoclk";
-			clocks = <&SYSCLK>,<&PBCLK1>,<&POSC>,<&FRC>,<&LPRC>,
-				 <&SOSC>,<&SYSPLL>,<&REFIx>,<&BFRC>;
-			microchip,clock-indices = <0>, <1>, <2>, <3>, <4>,
-						  <5>, <7>, <8>, <9>;
-			#clock-cells = <0>;
-			clock-output-names = "refo5_clk";
-		};
-	};
-};
diff --git a/arch/mips/boot/dts/pic32/pic32mzda.dtsi b/arch/mips/boot/dts/pic32/pic32mzda.dtsi
index ad9e3318..5353a63 100644
--- a/arch/mips/boot/dts/pic32/pic32mzda.dtsi
+++ b/arch/mips/boot/dts/pic32/pic32mzda.dtsi
@@ -6,11 +6,9 @@
  * published by the Free Software Foundation.
  *
  */
-
+#include <dt-bindings/clock/microchip,pic32-clock.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 
-#include "pic32mzda-clk.dtsi"
-
 / {
 	#address-cells = <1>;
 	#size-cells = <1>;
@@ -50,6 +48,29 @@
 		interrupts = <0 IRQ_TYPE_EDGE_RISING>;
 	};
 
+	/* external clock input on TxCLKI pin */
+	txcki: txcki_clk {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <4000000>;
+		status = "disabled";
+	};
+
+	/* external input on REFCLKIx pin */
+	refix: refix_clk {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <24000000>;
+		status = "disabled";
+	};
+
+	rootclk: clock-controller@1f801200 {
+		compatible = "microchip,pic32mzda-clk";
+		reg = <0x1f801200 0x200>;
+		#clock-cells = <1>;
+		microchip,pic32mzda-sosc;
+	};
+
 	evic: interrupt-controller@1f810000 {
 		compatible = "microchip,pic32mzda-evic";
 		interrupt-controller;
@@ -63,7 +84,7 @@
 		#size-cells = <1>;
 		compatible = "microchip,pic32mzda-pinctrl";
 		reg = <0x1f801400 0x400>;
-		clocks = <&PBCLK1>;
+		clocks = <&rootclk PB1CLK>;
 	};
 
 	/* PORTA */
@@ -75,7 +96,7 @@
 		gpio-controller;
 		interrupt-controller;
 		#interrupt-cells = <2>;
-		clocks = <&PBCLK4>;
+		clocks = <&rootclk PB4CLK>;
 		microchip,gpio-bank = <0>;
 		gpio-ranges = <&pic32_pinctrl 0 0 16>;
 	};
@@ -89,7 +110,7 @@
 		gpio-controller;
 		interrupt-controller;
 		#interrupt-cells = <2>;
-		clocks = <&PBCLK4>;
+		clocks = <&rootclk PB4CLK>;
 		microchip,gpio-bank = <1>;
 		gpio-ranges = <&pic32_pinctrl 0 16 16>;
 	};
@@ -103,7 +124,7 @@
 		gpio-controller;
 		interrupt-controller;
 		#interrupt-cells = <2>;
-		clocks = <&PBCLK4>;
+		clocks = <&rootclk PB4CLK>;
 		microchip,gpio-bank = <2>;
 		gpio-ranges = <&pic32_pinctrl 0 32 16>;
 	};
@@ -117,7 +138,7 @@
 		gpio-controller;
 		interrupt-controller;
 		#interrupt-cells = <2>;
-		clocks = <&PBCLK4>;
+		clocks = <&rootclk PB4CLK>;
 		microchip,gpio-bank = <3>;
 		gpio-ranges = <&pic32_pinctrl 0 48 16>;
 	};
@@ -131,7 +152,7 @@
 		gpio-controller;
 		interrupt-controller;
 		#interrupt-cells = <2>;
-		clocks = <&PBCLK4>;
+		clocks = <&rootclk PB4CLK>;
 		microchip,gpio-bank = <4>;
 		gpio-ranges = <&pic32_pinctrl 0 64 16>;
 	};
@@ -145,7 +166,7 @@
 		gpio-controller;
 		interrupt-controller;
 		#interrupt-cells = <2>;
-		clocks = <&PBCLK4>;
+		clocks = <&rootclk PB4CLK>;
 		microchip,gpio-bank = <5>;
 		gpio-ranges = <&pic32_pinctrl 0 80 16>;
 	};
@@ -159,7 +180,7 @@
 		gpio-controller;
 		interrupt-controller;
 		#interrupt-cells = <2>;
-		clocks = <&PBCLK4>;
+		clocks = <&rootclk PB4CLK>;
 		microchip,gpio-bank = <6>;
 		gpio-ranges = <&pic32_pinctrl 0 96 16>;
 	};
@@ -173,7 +194,7 @@
 		gpio-controller;
 		interrupt-controller;
 		#interrupt-cells = <2>;
-		clocks = <&PBCLK4>;
+		clocks = <&rootclk PB4CLK>;
 		microchip,gpio-bank = <7>;
 		gpio-ranges = <&pic32_pinctrl 0 112 16>;
 	};
@@ -189,7 +210,7 @@
 		gpio-controller;
 		interrupt-controller;
 		#interrupt-cells = <2>;
-		clocks = <&PBCLK4>;
+		clocks = <&rootclk PB4CLK>;
 		microchip,gpio-bank = <8>;
 		gpio-ranges = <&pic32_pinctrl 0 128 16>;
 	};
@@ -203,7 +224,7 @@
 		gpio-controller;
 		interrupt-controller;
 		#interrupt-cells = <2>;
-		clocks = <&PBCLK4>;
+		clocks = <&rootclk PB4CLK>;
 		microchip,gpio-bank = <9>;
 		gpio-ranges = <&pic32_pinctrl 0 144 16>;
 	};
@@ -212,7 +233,7 @@
 		compatible = "microchip,pic32mzda-sdhci";
 		reg = <0x1f8ec000 0x100>;
 		interrupts = <191 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&REFCLKO4>, <&PBCLK5>;
+		clocks = <&rootclk REF4CLK>, <&rootclk PB5CLK>;
 		clock-names = "base_clk", "sys_clk";
 		bus-width = <4>;
 		cap-sd-highspeed;
@@ -225,7 +246,7 @@
 		interrupts = <112 IRQ_TYPE_LEVEL_HIGH>,
 			<113 IRQ_TYPE_LEVEL_HIGH>,
 			<114 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&PBCLK2>;
+		clocks = <&rootclk PB2CLK>;
 		status = "disabled";
 	};
 
@@ -235,7 +256,7 @@
 		interrupts = <145 IRQ_TYPE_LEVEL_HIGH>,
 			<146 IRQ_TYPE_LEVEL_HIGH>,
 			<147 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&PBCLK2>;
+		clocks = <&rootclk PB2CLK>;
 		status = "disabled";
 	};
 
@@ -245,7 +266,7 @@
 		interrupts = <157 IRQ_TYPE_LEVEL_HIGH>,
 			<158 IRQ_TYPE_LEVEL_HIGH>,
 			<159 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&PBCLK2>;
+		clocks = <&rootclk PB2CLK>;
 		status = "disabled";
 	};
 
@@ -255,7 +276,7 @@
 		interrupts = <170 IRQ_TYPE_LEVEL_HIGH>,
 			<171 IRQ_TYPE_LEVEL_HIGH>,
 			<172 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&PBCLK2>;
+		clocks = <&rootclk PB2CLK>;
 		status = "disabled";
 	};
 
@@ -265,7 +286,7 @@
 		interrupts = <179 IRQ_TYPE_LEVEL_HIGH>,
 			<180 IRQ_TYPE_LEVEL_HIGH>,
 			<181 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&PBCLK2>;
+		clocks = <&rootclk PB2CLK>;
 		status = "disabled";
 	};
 
@@ -275,7 +296,7 @@
 		interrupts = <188 IRQ_TYPE_LEVEL_HIGH>,
 			<189 IRQ_TYPE_LEVEL_HIGH>,
 			<190 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&PBCLK2>;
+		clocks = <&rootclk PB2CLK>;
 		status = "disabled";
 	};
 };
diff --git a/arch/mips/boot/dts/pic32/pic32mzda_sk.dts b/arch/mips/boot/dts/pic32/pic32mzda_sk.dts
index 5d434a5..fc74010 100644
--- a/arch/mips/boot/dts/pic32/pic32mzda_sk.dts
+++ b/arch/mips/boot/dts/pic32/pic32mzda_sk.dts
@@ -95,8 +95,9 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_sdhc1>;
 	status = "okay";
-	assigned-clocks = <&REFCLKO2>,<&REFCLKO4>,<&REFCLKO5>;
-	assigned-clock-rates = <50000000>,<25000000>,<40000000>;
+	assigned-clocks = <&rootclk REF2CLK>, <&rootclk REF4CLK>,
+		<&rootclk REF5CLK>;
+	assigned-clock-rates = <50000000>, <25000000>, <40000000>;
 };
 
 &pic32_pinctrl {
-- 
1.7.9.5
