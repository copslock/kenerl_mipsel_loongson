Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Nov 2015 01:15:08 +0100 (CET)
Received: from exsmtp03.microchip.com ([198.175.253.49]:23335 "EHLO
        email.microchip.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27013021AbbKUAOfR9pdx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 21 Nov 2015 01:14:35 +0100
Received: from mx.microchip.com (10.10.76.4) by chn-sv-exch03.mchp-main.com
 (10.10.76.49) with Microsoft SMTP Server id 14.3.181.6; Fri, 20 Nov 2015
 17:14:27 -0700
Received: by mx.microchip.com (sSMTP sendmail emulation); Fri, 20 Nov 2015
 17:20:54 -0700
From:   Joshua Henderson <joshua.henderson@microchip.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <linux-mips@linux-mips.org>,
        Purna Chandra Mandal <purna.mandal@microchip.com>,
        Joshua Henderson <joshua.henderson@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, <devicetree@vger.kernel.org>
Subject: [PATCH 03/14] DEVICETREE: Add PIC32 clock binding documentation
Date:   Fri, 20 Nov 2015 17:17:15 -0700
Message-ID: <1448065205-15762-4-git-send-email-joshua.henderson@microchip.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1448065205-15762-1-git-send-email-joshua.henderson@microchip.com>
References: <1448065205-15762-1-git-send-email-joshua.henderson@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <Joshua.Henderson@microchip.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50010
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

Document the devicetree bindings for the clock driver found on Microchip
PIC32 class devices.

Signed-off-by: Purna Chandra Mandal <purna.mandal@microchip.com>
Signed-off-by: Joshua Henderson <joshua.henderson@microchip.com>
---
 .../devicetree/bindings/clock/microchip,pic32.txt  |  263 ++++++++++++++++++++
 1 file changed, 263 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/microchip,pic32.txt

diff --git a/Documentation/devicetree/bindings/clock/microchip,pic32.txt b/Documentation/devicetree/bindings/clock/microchip,pic32.txt
new file mode 100644
index 0000000..4cef72d
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/microchip,pic32.txt
@@ -0,0 +1,263 @@
+Binding for a Clock hardware block found on
+certain Microchip PIC32 MCU devices.
+
+Microchip SoC clocks-node consists of few oscillators, PLL, multiplexer
+and few divider nodes.
+
+We will find only the base address of the clock tree, this base
+address is common for some of the subnodes, not all. If no address is
+specified for any of subnode base address of the clock tree will be
+treated as its base. Each of subnodes follow the same common clock
+binding with some additional optional properties.
+
+	clocks_node {
+		reg = <>;
+
+		spll_node {
+			...
+		};
+
+		frcdiv_node {
+			...
+		};
+
+		sysclk_mux_node {
+			...
+		};
+
+		pbdiv_node {
+			...
+		};
+
+		refoclk_node {
+			...
+		};
+		...
+	};
+
+This binding uses the common clock binding[1].
+
+[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
+
+Required properties:
+- compatible : should have "microchip,pic32-clk".
+- reg : A Base address and length of the register set.
+- interrupts : source of interrupt.
+
+Optional properties (for subnodes):
+- #clock-cells: From common clock binding, should be 0.
+
+- microchip,clock-indices: in multiplexer node clock sources always aren't linear
+    and contiguous. This property helps define clock-sources with respect to
+    the mux clock node.
+
+- microchip,ignore-unused : ignore gate request even if the gated clock is unused.
+- microchip,status-bit-mask: bitmask for status check. This will be used to confirm
+    particular operation by clock sub-node is completed. It is dependent sub-node.
+- microchip,bit-mask: enable mask, similar to microchip,status-bit-mask.
+- microchip,slew-step: enable frequency slewing(stepping) during rate change;
+    applicable only to sys-clock subnode.
+
+Example:
+
+/* PIC32 specific clks */
+pic32_clktree {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	reg = <0x1f801200 0x200>;
+	compatible = "microchip,pic32-clk";
+	interrupts = <12>;
+	ranges;
+
+	/* secondary oscillator; external input on SOSCI pin */
+	SOSC:sosc_clk {
+		#clock-cells = <0>;
+		compatible = "microchip,pic32-sosc";
+		clock-frequency = <32768>;
+		reg = <0x1f801200 0x10   /* enable reg */
+			0x1f801390 0x10>; /* status reg */
+		microchip,bit-mask = <0x02>; /* enable mask */
+		microchip,status-bit-mask = <0x10>; /* status-mask*/
+	};
+
+	FRCDIV:frcdiv_clk {
+		#clock-cells = <0>;
+		compatible = "microchip,pic32-frcdivclk";
+		clocks = <&FRC>;
+		clock-output-names = "frcdiv_clk";
+	};
+
+	/* System PLL clock */
+	SYSPLL:spll_clk {
+		#clock-cells = <0>;
+		compatible = "microchip,pic32-syspll";
+		reg = <0x1f801220 0x10 /* SPLL register */
+			0x1f801390 0x10>; /* CLKSTAT register */
+		clocks = <&POSC>, <&FRC>;
+		clock-output-names = "sys_pll";
+		microchip,status-bit-mask = <0x80>; /* SPLLRDY */
+	};
+
+	/* system clock; mux with postdiv & slew */
+	SYSCLK:sys_clk {
+		#clock-cells = <0>;
+		compatible = "microchip,pic32-sysclk-v2";
+		reg = <0x1f8013c0 0x04>; /* SLEWCON */
+		clocks = <&FRCDIV>, <&SYSPLL>, <&POSC>, <&SOSC>,
+				<&LPRC>, <&FRCDIV>;
+		microchip,clock-indices = <0>, <1>, <2>, <4>, <5>, <7>;
+		clock-output-names = "sys_clk";
+	};
+
+	/* DDR Ctrl & DDR PHY PLL */
+	MPLL: CLK_MPLL {
+		#clock-cells = <0>;
+		compatible = "microchip,pic32-mpll";
+		reg = <0x1f800100 0x04>; /* CFGMPLL */
+		clocks = <&POSC>;
+		clock-output-names = "pic32-mpll";
+		status = "disabled";
+	};
+
+	/* Peripheral bus1 clock */
+	PBCLK1:pb1_clk {
+		reg = <0x1f801340 0x10>;
+		#clock-cells = <0>;
+		compatible = "microchip,pic32-pbclk";
+		clocks = <&SYSCLK>;
+		clock-output-names = "pb1_clk";
+		/* used by system modules, not gateable */
+		microchip,ignore-unused;
+	};
+
+	/* Peripheral bus2 clock */
+	PBCLK2:pb2_clk {
+		reg = <0x1f801350 0x10>;
+		#clock-cells = <0>;
+		compatible = "microchip,pic32-pbclk";
+		clocks = <&SYSCLK>;
+		clock-output-names = "pb2_clk";
+		/* avoid gating even if unused */
+		microchip,ignore-unused;
+	};
+
+	/* Peripheral bus3 clock */
+	PBCLK3:pb3_clk {
+		reg = <0x1f801360 0x10>;
+		#clock-cells = <0>;
+		compatible = "microchip,pic32-pbclk";
+		clocks = <&SYSCLK>;
+		clock-output-names = "pb3_clk";
+	};
+
+	/* Peripheral bus4 clock(I/O ports, GPIO) */
+	PBCLK4:pb4_clk {
+		reg = <0x1f801370 0x10>;
+		#clock-cells = <0>;
+		compatible = "microchip,pic32-pbclk";
+		clocks = <&SYSCLK>;
+		clock-output-names = "pb4_clk";
+	};
+
+	/* Peripheral bus clock */
+	PBCLK5:pb5_clk {
+		reg = <0x1f801380 0x10>;
+		#clock-cells = <0>;
+		compatible = "microchip,pic32-pbclk";
+		clocks = <&SYSCLK>;
+		clock-output-names = "pb5_clk";
+	};
+
+	/* Peripheral Bus6 clock; */
+	PBCLK6:pb6_clk {
+		reg = <0x1f801390 0x10>;
+		compatible = "microchip,pic32-pbclk";
+		clocks = <&SYSCLK>;
+		#clock-cells = <0>;
+	};
+
+	/* Peripheral bus7 clock */
+	PBCLK7:pb7_clk {
+		reg = <0x1f8013A0 0x10>;
+		#clock-cells = <0>;
+		compatible = "microchip,pic32-pbclk";
+		/* CPU is driven by this clock; so named */
+		clock-output-names = "cpu_clk";
+		clocks = <&SYSCLK>;
+	};
+
+	/* Reference Oscillator clock for SPI/I2S */
+	REFCLKO1:refo1_clk {
+		reg = <0x1f801280 0x20>;
+		#clock-cells = <0>;
+		compatible = "microchip,pic32-refoclk";
+		clocks = <&SYSCLK>, <&PBCLK1>, <&POSC>, <&FRC>, <&LPRC>,
+			<&SOSC>, <&SYSPLL>, <&REFIx>, <&BFRC>;
+		microchip,clock-indices = <0>, <1>, <2>, <3>, <4>, <5>,
+						<7>, <8>, <9>;
+		clock-output-names = "refo1_clk";
+		clock-frequency = <10000000>;  /* 10Mhz for I2S MCLK */
+	};
+
+	/* Reference Oscillator clock for SQI */
+	REFCLKO2:refo2_clk {
+		reg = <0x1f8012A0 0x20>;
+		#clock-cells = <0>;
+		compatible = "microchip,pic32-refoclk";
+		clocks = <&SYSCLK>, <&PBCLK1>, <&POSC>, <&FRC>, <&LPRC>,
+			<&SOSC>, <&SYSPLL>, <&REFIx>, <&BFRC>;
+		microchip,clock-indices = <0>, <1>, <2>, <3>, <4>, <5>,
+						<7>, <8>, <9>;
+		clock-output-names = "refo2_clk";
+		clock-frequency = <50000000>; /* 50MHz for SQI */
+	};
+
+	/* Reference Oscillator clock, ADC */
+	REFCLKO3:refo3_clk {
+		reg = <0x1f8012C0 0x20>;
+		compatible = "microchip,pic32-refoclk";
+		clocks = <&SYSCLK>, <&PBCLK1>, <&POSC>, <&FRC>, <&LPRC>,
+			<&SOSC>, <&SYSPLL>, <&REFIx>, <&BFRC>;
+		microchip,clock-indices = <0>, <1>, <2>, <3>, <4>, <5>,
+						<7>, <8>, <9>;
+		#clock-cells = <0>;
+		clock-output-names = "refo3_clk";
+		clock-frequency = <10000000>;  /* 1Mhz */
+	};
+
+	/* Reference Oscillator clock */
+	REFCLKO4:refo4_clk {
+		reg = <0x1f8012E0 0x20>;
+		compatible = "microchip,pic32-refoclk";
+		clocks = <&SYSCLK>, <&PBCLK1>, <&POSC>, <&FRC>, <&LPRC>,
+				<&SOSC>, <&SYSPLL>, <&REFIx>, <&BFRC>;
+		microchip,clock-indices = <0>,<1>,<2>,<3>,<4>,<5>,<7>,
+						<8>,<9>;
+		#clock-cells = <0>;
+		clock-output-names = "refo4_clk";
+		clock-frequency = <25000000>;  /* 25Mhz */
+	};
+
+	/* Reference Oscillator clock, LCD */
+	REFCLKO5:refo5_clk {
+		reg = <0x1f801300 0x20>;
+		compatible = "microchip,pic32-refoclk";
+		clocks = <&SYSCLK>,<&PBCLK1>,<&POSC>,<&FRC>,<&LPRC>,
+			<&SOSC>,<&SYSPLL>,<&REFIx>,<&BFRC>;
+		microchip,clock-indices = <0>, <1>, <2>, <3>, <4>, <5>,
+					<7>, <8>,<9>;
+		#clock-cells = <0>;
+		clock-output-names = "refo5_clk";
+		clock-frequency = <40000000>;  /* 40Mhz */
+	};
+};
+
+The clock consumer should specify the desired clock by having the clocks in its
+"clock" phandle cell. For example for UART:
+
+uart2: serial@<> {
+	compatible = "microchip,pic32-uart";
+	reg = <>;
+	interrupts = <>;
+	clocks = <&PBCLK2>;
+}
-- 
1.7.9.5
