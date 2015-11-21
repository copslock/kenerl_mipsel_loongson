Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Nov 2015 01:16:33 +0100 (CET)
Received: from exsmtp01.microchip.com ([198.175.253.37]:13018 "EHLO
        email.microchip.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27013022AbbKUAQ0MtxSx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 21 Nov 2015 01:16:26 +0100
Received: from mx.microchip.com (10.10.76.4) by CHN-SV-EXCH01.mchp-main.com
 (10.10.76.37) with Microsoft SMTP Server id 14.3.181.6; Fri, 20 Nov 2015
 17:16:19 -0700
Received: by mx.microchip.com (sSMTP sendmail emulation); Fri, 20 Nov 2015
 17:22:45 -0700
From:   Joshua Henderson <joshua.henderson@microchip.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <linux-mips@linux-mips.org>,
        Andrei Pistirica <andrei.pistirica@microchip.com>,
        Joshua Henderson <joshua.henderson@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, <devicetree@vger.kernel.org>
Subject: [PATCH 07/14] DEVICETREE: Add bindings for PIC32 pin control and GPIO
Date:   Fri, 20 Nov 2015 17:17:19 -0700
Message-ID: <1448065205-15762-8-git-send-email-joshua.henderson@microchip.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1448065205-15762-1-git-send-email-joshua.henderson@microchip.com>
References: <1448065205-15762-1-git-send-email-joshua.henderson@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <Joshua.Henderson@microchip.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50014
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

From: Andrei Pistirica <andrei.pistirica@microchip.com>

Document the devicetree bindings for PINCTRL and GPIO found on Microchip
PIC32 class devices. This also adds a header defining related port and
peripheral pin select functionality.

Signed-off-by: Andrei Pistirica <andrei.pistirica@microchip.com>
Signed-off-by: Joshua Henderson <joshua.henderson@microchip.com>
---
 .../bindings/gpio/microchip,pic32-gpio.txt         |   33 ++
 .../bindings/pinctrl/microchip,pic32-pinctrl.txt   |  100 +++++
 include/dt-bindings/pinctrl/pic32mzda.h            |  404 ++++++++++++++++++++
 3 files changed, 537 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/microchip,pic32-gpio.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/microchip,pic32-pinctrl.txt
 create mode 100644 include/dt-bindings/pinctrl/pic32mzda.h

diff --git a/Documentation/devicetree/bindings/gpio/microchip,pic32-gpio.txt b/Documentation/devicetree/bindings/gpio/microchip,pic32-gpio.txt
new file mode 100644
index 0000000..f6eeb2f
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/microchip,pic32-gpio.txt
@@ -0,0 +1,33 @@
+* Microchip PIC32 GPIO devices (PIO).
+
+Required properties:
+ - compatible: "microchip,pic32-gpio"
+ - reg: Base address and length for the device.
+ - interrupts: The port interrupt shared be all pins.
+ - gpio-controller: Marks the port as GPIO controller.
+ - #gpio-cells: Two. The first cell is the pin number and
+   the second cell is unused.
+ - interrupt-controller: Marks the device node as an interrupt controller.
+ - #interrupt-cells: Two. The first cell is the GPIO number and second cell
+   is used to specify the trigger type:
+	PIC32_PIN_CN_RISING	: low-to-high edge triggered.
+	PIC32_PIN_CN_FALLING	: high-to-low edge triggered.
+	PIC32_PIN_CN_BOTH	: low-to-high and high-to-low edges triggered.
+
+Note:
+ - If gpio-ranges is missing, then all the pins (32) related to the gpio bank
+   are enabled.
+
+Example:
+	pioA: gpio@1f860000 {
+		compatible = "microchip,pic32-gpio";
+		reg = <0x1f860000 0x24>;
+		interrupts = <PORTA_INPUT_CHANGE_INTERRUPT
+				DEFAULT_INT_PRI IRQ_TYPE_LEVEL_HIGH>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		gpio-ranges = <&pic32_pinctrl 0 0 32>;
+		clocks = <&PBCLK4>;
+	};
diff --git a/Documentation/devicetree/bindings/pinctrl/microchip,pic32-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/microchip,pic32-pinctrl.txt
new file mode 100644
index 0000000..7cf4167
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/microchip,pic32-pinctrl.txt
@@ -0,0 +1,100 @@
+* Microchip PIC32 Pinmux device.
+
+Please refer to pinctrl-bindings.txt for details of the pinctrl properties and
+common bindings.
+
+PIC32 'pin configuration node' is a node of a group of pins which can be
+used for a specific device or function. This node represents configuraions of
+single pins or a pairs of mux and related configuration.
+
+Required properties for pic32 device:
+ - compatible: "microchip,pic32-pinctrl", "microchip,pic32mz-pinctrl"
+ - reg: Base address and length for pps:in and pps:out registers.
+
+Properties for 'pin configuration node':
+ - pic32,pins: each entry consists of 3 intergers and represents the mux and
+   config settings for one pin. The first integer represent the remappable pin,
+   the second represent the peripheral pin and the last the configuration.
+   The format is pic32,pins = <PIC32_RP_'dir'_'pin'
+   PIC32_PP_'dir'_'peripherl-pin' PIC32_PIN_CONF_'config'>. The configurations
+   are divided in 2 classes: IN and OUT and each in 4 buckets. Each entry must
+   contains items from the same class and bucket, otherwise the driver will
+   notify an error and the initialization will fail.
+ - pic32,single-pins: each entry consists of 3 intergers and represents a pin
+   (that is not remappable) and related configuraion. The format is
+   pic32,single-pins = <PORT_'x' 'pin' PIC32_PIN_CONF_'config'>. Each port has
+   32 pins and please refer to chip documentation for details of remappable
+   pins.
+
+Available pin configurations (refer to dt-bindings/pinctrl/pic32.h):
+	PIC32_PIN_CONF_NONE	: no configuration (default).
+	PIC32_PIN_CONF_OD	: indicate this pin need a open-drain (no direction).
+	PIC32_PIN_CONF_OD_OUT	: indicate this pin need a open-drain out.
+	PIC32_PIN_CONF_PU	: indicate this pin need a pull up (no direction).
+	PIC32_PIN_CONF_PU_IN	: indicate this pin need a pull up in.
+	PIC32_PIN_CONF_PD	: indicate this pin need a pull down (no direction).
+	PIC32_PIN_CONF_PD_IN	: indicate this pin need a pull down input.
+	PIC32_PIN_CONF_AN	: indicate this pin as analogic (no direction).
+	PIC32_PIN_CONF_AN_IN	: indicate this pin as analogic input.
+	PIC32_PIN_CONF_DG	: indicate this pin as digital (no direction).
+	PIC32_PIN_CONF_DG_IN	: indicate this pin as digital input.
+	PIC32_PIN_CONF_DG_OUT	: indicate this pin as digital output.
+
+NOTEs:
+1. The pins functions nods are defined under pic32 pinctrl node. The function's
+   pin groups are defined under functions node.
+2. Each pin group can have both pic32,pins and pic32,single-pins properties to
+   specify re-mappable or non-remappable pins with related mux and configs or
+   at least one.
+3. Each pin configuration node can have a phandle and devices can set pins
+   configurations by referring to the phandle of that pin configuration node.
+4. The pinctrl bindings are listed in dt-bindings/pinctrl/pic32.h.
+5. The gpio controller must be described in the pinctrl simple-bus.
+
+Example:
+pinctrl@1f800000{
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "microchip,pic32-pinctrl", "simple-bus";
+	ranges;
+	reg = <0x1f801404 0x3c>, /* in  */
+	      <0x1f801538 0x57>; /* out */
+
+	pioA: gpio@1f860000 {
+		compatible = "microchip,pic32-gpio";
+		reg = <0x1f860000 0x24>;
+		gpio-controller;
+	};
+
+	/* functions */
+	sw1 {
+		pinctrl_sw1: sw1-0 {
+			pic32,single-pins = <PORT_B 12 PIC32_PIN_CONF_PULLUP>;
+		};
+	};
+
+	uart1 {
+		pinctrl_uart1: uart1-0 {
+			pic32,pins =
+				<PIC32_RP_OUT_RPG7 PIC32_PP_OUT_U1TX PIC32_PIN_CONF_NONE
+				 PIC32_RP_IN_RPG8 PIC32_PP_IN_U1RX PIC32_PIN_CONF_NONE>;
+		};
+	};
+};
+
+uart1: serial@1f822000 {
+	compatible = "microchip,pic32-uart";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+};
+
+sw@1 {
+	compatible = "microchip,pic32-switch";
+
+	interrupt-parent = <&pioB>;
+	interrupts = <12 PIC32_CN_RISING>;/* GPIO_B_12 */
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sw1>;
+};
diff --git a/include/dt-bindings/pinctrl/pic32mzda.h b/include/dt-bindings/pinctrl/pic32mzda.h
new file mode 100644
index 0000000..2fb86e8
--- /dev/null
+++ b/include/dt-bindings/pinctrl/pic32mzda.h
@@ -0,0 +1,404 @@
+/*
+ * This header provides constants for PIC32MZDA pinctrl bindings.
+ *
+ * Copyright (C) 2015 Sorin-Andrei Pistirica <andrei.pistirica@microchip.com>
+ *
+ * GPLv2 or later.
+*/
+
+#ifndef __DT_BINDINGS_PIC32MZDA_PINCTRL_H__
+#define __DT_BINDINGS_PIC32MZDA_PINCTRL_H__
+
+/* cods offsets */
+#define BANK_OFF	0
+#define RP_OFF		5
+#define PP_OFF		0
+#define BUCKET_OFF	10
+#define DIR_OFF		15
+#define COD_OFF		16
+
+#define BANK(x)		((x) << (BANK_OFF))
+#define RPIN(x)		((x) << (RP_OFF))
+#define PPIN(x)		((x) << (PP_OFF))
+#define BUCKET(x)	((x) << (BUCKET_OFF))
+#define PINDIR(x)	((x) << (DIR_OFF))
+#define COD(x)		((x) << (COD_OFF))
+
+#define PP(x_pin, x_bucket, x_dir) \
+		((PPIN(x_pin)) | (BUCKET(x_bucket)) | (PINDIR(x_dir)))
+
+#define RP(x_bank, x_pin, x_bucket, x_dir) \
+		((BANK(x_bank)) | (RPIN(x_pin)) | \
+		(BUCKET(x_bucket)) | (PINDIR(x_dir)))
+
+/* pin direction
+ *  Note: for PPS  direction has 1 bit: IN or OUT and
+ *	 for CONF direction has 2 bit: IN, OUT or NONE
+ */
+#ifdef DIR_IN
+#undef DIR_IN
+#endif
+#ifdef DIR_OUT
+#undef DIR_OUT
+#endif
+#define DIR_IN		0	/* 00 */
+#define DIR_OUT		1	/* 01 */
+#define DIR_NONE	2	/* 10 */
+
+/* buckets */
+#define BUCKET_A	(0x1)			/* 00001 */
+#define BUCKET_B	(0x2)			/* 00010 */
+#define BUCKET_C	(0x4)			/* 00100 */
+#define BUCKET_D	(0x8)			/* 01000 */
+#define BUCKET_AB	(BUCKET_A | BUCKET_B)	/* 00011 */
+#define BUCKET_BD	(BUCKET_B | BUCKET_D)	/* 01010 */
+#define BUCKET_CD	(BUCKET_C | BUCKET_D)	/* 01100 */
+
+/* port, bank */
+#define PORT_A		0
+#define PORT_B		1
+#define PORT_C		2
+#define PORT_D		3
+#define PORT_E		4
+#define PORT_F		5
+#define PORT_G		6
+#define PORT_H		7
+#define PORT_J		8
+#define PORT_K		9
+
+/* peripheral pins */
+#define PP_INT0		0
+#define PP_INT1		1
+#define PP_INT2		2
+#define PP_INT3		3
+#define PP_INT4		4
+#define PP_T2CK		5
+#define PP_T3CK		6
+#define PP_T4CK		7
+#define PP_T5CK		8
+#define PP_T6CK		9
+#define PP_T7CK		10
+#define PP_T8CK		11
+#define PP_T9CK		12
+#define PP_IC1		13
+#define PP_IC2		14
+#define PP_IC3		15
+#define PP_IC4		16
+#define PP_IC5		17
+#define PP_IC6		18
+#define PP_IC7		19
+#define PP_IC8		20
+#define PP_IC9		21
+#define PP_OCFA		22
+#define PP_OCFB		23
+#define PP_U1RX		24
+#define PP_U1CTS	25
+#define PP_U2RX		26
+#define PP_U2CTS	27
+#define PP_U3RX		28
+#define PP_U3CTS	29
+#define PP_U4RX		30
+#define PP_U4CTS	31
+#define PP_U5RX		32
+#define PP_U5CTS	33
+#define PP_U6RX		34
+#define PP_U6CTS	35
+#define PP_SDI1		36
+#define PP_SS1		37
+#define PP_SDI2		38
+#define PP_SS2		39
+#define PP_SDI3		40
+#define PP_SS3		41
+#define PP_SDI4		42
+#define PP_SS4		43
+#define PP_SDI5		44
+#define PP_SS5		45
+#define PP_SDI6		46
+#define PP_SS6		47
+#define PP_C1RX		48
+#define PP_C2RX		49
+#define PP_REFCLKI1	50
+#define PP_REFCLKI3	51
+#define PP_REFCLKI4	52
+#define PP_U1RTS	53
+#define PP_U2RTS	54
+#define PP_U3RTS	55
+#define PP_U4RTS	56
+#define PP_U5RTS	57
+#define PP_U6RTS	58
+#define PP_U1TX		59
+#define PP_U2TX		60
+#define PP_U3TX		61
+#define PP_U4TX		62
+#define PP_U5TX		63
+#define PP_U6TX		64
+#define PP_REFCLKO1	65
+#define PP_REFCLKO3	66
+#define PP_REFCLKO4	67
+#define PP_SDO1		68
+#define PP_SDO2		69
+#define PP_SDO3		70
+#define PP_SDO4		71
+#define PP_SDO5		72
+#define PP_SDO6		73
+#define PP_OC1		74
+#define PP_OC2		75
+#define PP_OC3		76
+#define PP_OC4		77
+#define PP_OC5		78
+#define PP_OC6		79
+#define PP_OC7		80
+#define PP_OC8		81
+#define PP_OC9		82
+#define PP_C1OUT	83
+#define PP_C2OUT	84
+#define PP_C1TX		85
+#define PP_C2TX		86
+#define PP_SENTINEL	87
+/* add above this line and update the PP_MAX accordingly */
+#define PP_MAX		88
+
+/* MUX INPUT ----------------------------------------------------------------*/
+/* Peripheral pins: BUCKET A */
+#define PIC32_PP_IN_INT3	(PP(PP_INT3, BUCKET_A, DIR_IN))
+#define PIC32_PP_IN_T2CK	(PP(PP_T2CK, BUCKET_A, DIR_IN))
+#define PIC32_PP_IN_T6CK	(PP(PP_T6CK, BUCKET_A, DIR_IN))
+#define PIC32_PP_IN_IC3		(PP(PP_IC3, BUCKET_A, DIR_IN))
+#define PIC32_PP_IN_IC7		(PP(PP_IC7, BUCKET_A, DIR_IN))
+#define PIC32_PP_IN_U1RX	(PP(PP_U1RX, BUCKET_A, DIR_IN))
+#define PIC32_PP_IN_U2CTS	(PP(PP_U2CTS, BUCKET_A, DIR_IN))
+#define PIC32_PP_IN_U5RX	(PP(PP_U5RX, BUCKET_A, DIR_IN))
+#define PIC32_PP_IN_U6CTS	(PP(PP_U6CTS, BUCKET_A, DIR_IN))
+#define PIC32_PP_IN_SDI1	(PP(PP_SDI1, BUCKET_A, DIR_IN))
+#define PIC32_PP_IN_SDI3	(PP(PP_SDI3, BUCKET_A, DIR_IN))
+#define PIC32_PP_IN_SDI5	(PP(PP_SDI5, BUCKET_A, DIR_IN))
+#define PIC32_PP_IN_SS6		(PP(PP_SS6, BUCKET_A, DIR_IN))
+#define PIC32_PP_IN_REFCLKI1	(PP(PP_REFCLKI1, BUCKET_A, DIR_IN))
+
+/* Peripheral pins: BUCKET B */
+#define PIC32_PP_IN_INT4	(PP(PP_INT4, BUCKET_B, DIR_IN))
+#define PIC32_PP_IN_T5CK	(PP(PP_T5CK, BUCKET_B, DIR_IN))
+#define PIC32_PP_IN_T7CK	(PP(PP_T7CK, BUCKET_B, DIR_IN))
+#define PIC32_PP_IN_IC4		(PP(PP_IC4, BUCKET_B, DIR_IN))
+#define PIC32_PP_IN_IC8		(PP(PP_IC8, BUCKET_B, DIR_IN))
+#define PIC32_PP_IN_U3RX	(PP(PP_U3RX, BUCKET_B, DIR_IN))
+#define PIC32_PP_IN_U4CTS	(PP(PP_U4CTS, BUCKET_B, DIR_IN))
+#define PIC32_PP_IN_SDI2	(PP(PP_SDI2, BUCKET_B, DIR_IN))
+#define PIC32_PP_IN_SDI4	(PP(PP_SDI4, BUCKET_B, DIR_IN))
+#define PIC32_PP_IN_C1RX	(PP(PP_C1RX, BUCKET_B, DIR_IN))
+#define PIC32_PP_IN_REFCLKI4	(PP(PP_REFCLKI4, BUCKET_A, DIR_IN))
+
+/* Peripheral pins: BUCKET C */
+#define PIC32_PP_IN_INT2	(PP(PP_INT2, BUCKET_C, DIR_IN))
+#define PIC32_PP_IN_T3CK	(PP(PP_T3CK, BUCKET_C, DIR_IN))
+#define PIC32_PP_IN_T8CK	(PP(PP_T8CK, BUCKET_C, DIR_IN))
+#define PIC32_PP_IN_IC2		(PP(PP_IC2, BUCKET_C, DIR_IN))
+#define PIC32_PP_IN_IC5		(PP(PP_IC5, BUCKET_C, DIR_IN))
+#define PIC32_PP_IN_IC9		(PP(PP_IC9, BUCKET_C, DIR_IN))
+#define PIC32_PP_IN_U1CTS	(PP(PP_U1CTS, BUCKET_C, DIR_IN))
+#define PIC32_PP_IN_U2RX	(PP(PP_U2RX, BUCKET_C, DIR_IN))
+#define PIC32_PP_IN_U5CTS	(PP(PP_U5CTS, BUCKET_C, DIR_IN))
+#define PIC32_PP_IN_SS1		(PP(PP_SS1, BUCKET_C, DIR_IN))
+#define PIC32_PP_IN_SS3		(PP(PP_SS3, BUCKET_C, DIR_IN))
+#define PIC32_PP_IN_SS4		(PP(PP_SS4, BUCKET_C, DIR_IN))
+#define PIC32_PP_IN_SS5		(PP(PP_SS5, BUCKET_C, DIR_IN))
+#define PIC32_PP_IN_C2RX	(PP(PP_C2RX, BUCKET_C, DIR_IN))
+
+/* Peripheral pins: BUCKET D */
+#define PIC32_PP_IN_INT1	(PP(PP_INT1, BUCKET_D, DIR_IN))
+#define PIC32_PP_IN_T4CK	(PP(PP_T4CK, BUCKET_D, DIR_IN))
+#define PIC32_PP_IN_T9CK	(PP(PP_T9CK, BUCKET_D, DIR_IN))
+#define PIC32_PP_IN_IC1		(PP(PP_IC1, BUCKET_D, DIR_IN))
+#define PIC32_PP_IN_IC6		(PP(PP_IC6, BUCKET_D, DIR_IN))
+#define PIC32_PP_IN_U3CTS	(PP(PP_U3CTS, BUCKET_D, DIR_IN))
+#define PIC32_PP_IN_U4RX	(PP(PP_U4RX, BUCKET_D, DIR_IN))
+#define PIC32_PP_IN_U6RX	(PP(PP_U6RX, BUCKET_D, DIR_IN))
+#define PIC32_PP_IN_SS2		(PP(PP_SS2, BUCKET_D, DIR_IN))
+#define PIC32_PP_IN_SDI6	(PP(PP_SDI6, BUCKET_D, DIR_IN))
+#define PIC32_PP_IN_OCFA	(PP(PP_OCFA, BUCKET_D, DIR_IN))
+#define PIC32_PP_IN_REFCLKI3	(PP(PP_REFCLKI3, BUCKET_D, DIR_IN))
+
+/* Remappable pins: BUCKET A */
+#define PIC32_RP_IN_RPD2	(RP(PORT_D, 2, BUCKET_A, DIR_IN) | COD(0x0))
+#define PIC32_RP_IN_RPG8	(RP(PORT_G, 8, BUCKET_A, DIR_IN) | COD(0x1))
+#define PIC32_RP_IN_RPF4	(RP(PORT_F, 4, BUCKET_A, DIR_IN) | COD(0x2))
+#define PIC32_RP_IN_RPF1	(RP(PORT_F, 1, BUCKET_A, DIR_IN) | COD(0x4))
+#define PIC32_RP_IN_RPB9	(RP(PORT_B, 9, BUCKET_A, DIR_IN) | COD(0x5))
+#define PIC32_RP_IN_RPB10	(RP(PORT_B, 10, BUCKET_A, DIR_IN) | COD(0x6))
+#define PIC32_RP_IN_RPC14	(RP(PORT_C, 14, BUCKET_A, DIR_IN) | COD(0x7))
+#define PIC32_RP_IN_RPB5	(RP(PORT_B, 5, BUCKET_A, DIR_IN) | COD(0x8))
+#define PIC32_RP_IN_RPC1	(RP(PORT_C, 1, BUCKET_A, DIR_IN) | COD(0xA))
+#define PIC32_RP_IN_RPD14	(RP(PORT_D, 14, BUCKET_A, DIR_IN) | COD(0xB))
+#define PIC32_RP_IN_RPG1	(RP(PORT_G, 1, BUCKET_A, DIR_IN) | COD(0xC))
+#define PIC32_RP_IN_RPA14	(RP(PORT_A, 14, BUCKET_A, DIR_IN) | COD(0xD))
+#define PIC32_RP_IN_RPD6	(RP(PORT_D, 6, BUCKET_A, DIR_IN) | COD(0xE))
+
+/* Remappable pins: BUCKET B */
+#define PIC32_RP_IN_RPD3	(RP(PORT_D, 3, BUCKET_B, DIR_IN) | COD(0x0))
+#define PIC32_RP_IN_RPG7	(RP(PORT_G, 7, BUCKET_B, DIR_IN) | COD(0x1))
+#define PIC32_RP_IN_RPF5	(RP(PORT_F, 5, BUCKET_B, DIR_IN) | COD(0x2))
+#define PIC32_RP_IN_RPD11	(RP(PORT_D, 11, BUCKET_B, DIR_IN) | COD(0x3))
+#define PIC32_RP_IN_RPF0	(RP(PORT_F, 0, BUCKET_B, DIR_IN) | COD(0x4))
+#define PIC32_RP_IN_RPB1	(RP(PORT_B, 1, BUCKET_B, DIR_IN) | COD(0x5))
+#define PIC32_RP_IN_RPE5	(RP(PORT_E, 5, BUCKET_B, DIR_IN) | COD(0x6))
+#define PIC32_RP_IN_RPC13	(RP(PORT_C, 13, BUCKET_B, DIR_IN) | COD(0x7))
+#define PIC32_RP_IN_RPB3	(RP(PORT_B, 3, BUCKET_B, DIR_IN) | COD(0x8))
+#define PIC32_RP_IN_RPC4	(RP(PORT_C, 4, BUCKET_B, DIR_IN) | COD(0xA))
+#define PIC32_RP_IN_RPG0	(RP(PORT_G, 0, BUCKET_B, DIR_IN) | COD(0xC))
+#define PIC32_RP_IN_RPA15	(RP(PORT_A, 15, BUCKET_B, DIR_IN) | COD(0xD))
+#define PIC32_RP_IN_RPD7	(RP(PORT_D, 7, BUCKET_B, DIR_IN) | COD(0xE))
+
+/* Remappable pins: BUCKET C */
+#define PIC32_RP_IN_RPD9	(RP(PORT_D, 9, BUCKET_C, DIR_IN) | COD(0x0))
+#define PIC32_RP_IN_RPB8	(RP(PORT_B, 8, BUCKET_C, DIR_IN) | COD(0x2))
+#define PIC32_RP_IN_RPB15	(RP(PORT_B, 15, BUCKET_C, DIR_IN) | COD(0x3))
+#define PIC32_RP_IN_RPD4	(RP(PORT_D, 4, BUCKET_C, DIR_IN) | COD(0x4))
+#define PIC32_RP_IN_RPB0	(RP(PORT_B, 0, BUCKET_C, DIR_IN) | COD(0x5))
+#define PIC32_RP_IN_RPE3	(RP(PORT_E, 3, BUCKET_C, DIR_IN) | COD(0x6))
+#define PIC32_RP_IN_RPB7	(RP(PORT_B, 7, BUCKET_C, DIR_IN) | COD(0x7))
+#define PIC32_RP_IN_RPF12	(RP(PORT_F, 12, BUCKET_C, DIR_IN) | COD(0x9))
+#define PIC32_RP_IN_RPD12	(RP(PORT_D, 12, BUCKET_C, DIR_IN) | COD(0xA))
+#define PIC32_RP_IN_RPF8	(RP(PORT_F, 8, BUCKET_C, DIR_IN) | COD(0xB))
+#define PIC32_RP_IN_RPC3	(RP(PORT_C, 3, BUCKET_C, DIR_IN) | COD(0xC))
+#define PIC32_RP_IN_RPE9	(RP(PORT_E, 9, BUCKET_C, DIR_IN) | COD(0xD))
+
+/* Remappable pins: BUCKET D */
+#define PIC32_RP_IN_RPG9	(RP(PORT_G, 9, BUCKET_D, DIR_IN) | COD(0x1))
+#define PIC32_RP_IN_RPD0	(RP(PORT_D, 0, BUCKET_D, DIR_IN) | COD(0x3))
+#define PIC32_RP_IN_RPB6	(RP(PORT_B, 6, BUCKET_D, DIR_IN) | COD(0x5))
+#define PIC32_RP_IN_RPD5	(RP(PORT_D, 5, BUCKET_D, DIR_IN) | COD(0x6))
+#define PIC32_RP_IN_RPB2	(RP(PORT_B, 2, BUCKET_D, DIR_IN) | COD(0x7))
+#define PIC32_RP_IN_RPF3	(RP(PORT_F, 3, BUCKET_D, DIR_IN) | COD(0x8))
+#define PIC32_RP_IN_RPF2	(RP(PORT_F, 2, BUCKET_D, DIR_IN) | COD(0xB))
+#define PIC32_RP_IN_RPC2	(RP(PORT_C, 2, BUCKET_D, DIR_IN) | COD(0xC))
+#define PIC32_RP_IN_RPE8	(RP(PORT_E, 8, BUCKET_D, DIR_IN) | COD(0xD))
+
+/* MUX OUTPUT ---------------------------------------------------------------*/
+/* Remappable pins: BUCKET A */
+#define PIC32_RP_OUT_RPD2	(RP(PORT_D, 2, BUCKET_A, DIR_OUT))
+#define PIC32_RP_OUT_RPG8	(RP(PORT_G, 8, BUCKET_A, DIR_OUT))
+#define PIC32_RP_OUT_RPF4	(RP(PORT_F, 4, BUCKET_A, DIR_OUT))
+#define PIC32_RP_OUT_RPF1	(RP(PORT_F, 1, BUCKET_A, DIR_OUT))
+#define PIC32_RP_OUT_RPB9	(RP(PORT_B, 9, BUCKET_A, DIR_OUT))
+#define PIC32_RP_OUT_RPB10	(RP(PORT_B, 10, BUCKET_A, DIR_OUT))
+#define PIC32_RP_OUT_RPB5	(RP(PORT_B, 5, BUCKET_A, DIR_OUT))
+#define PIC32_RP_OUT_RPC1	(RP(PORT_C, 1, BUCKET_A, DIR_OUT))
+#define PIC32_RP_OUT_RPD14	(RP(PORT_D, 14, BUCKET_A, DIR_OUT))
+#define PIC32_RP_OUT_RPG1	(RP(PORT_G, 1, BUCKET_A, DIR_OUT))
+#define PIC32_RP_OUT_RPA14	(RP(PORT_A, 14, BUCKET_A, DIR_OUT))
+#define PIC32_RP_OUT_RPD6	(RP(PORT_D, 6, BUCKET_A, DIR_OUT))
+
+/* Remappable pins: BUCKET B */
+#define PIC32_RP_OUT_RPD3	(RP(PORT_D, 3, BUCKET_B, DIR_OUT))
+#define PIC32_RP_OUT_RPG7	(RP(PORT_G, 7, BUCKET_B, DIR_OUT))
+#define PIC32_RP_OUT_RPF5	(RP(PORT_F, 5, BUCKET_B, DIR_OUT))
+#define PIC32_RP_OUT_RPD11	(RP(PORT_D, 11, BUCKET_B, DIR_OUT))
+#define PIC32_RP_OUT_RPF0	(RP(PORT_F, 0, BUCKET_B, DIR_OUT))
+#define PIC32_RP_OUT_RPB1	(RP(PORT_B, 1, BUCKET_B, DIR_OUT))
+#define PIC32_RP_OUT_RPE5	(RP(PORT_E, 5, BUCKET_B, DIR_OUT))
+#define PIC32_RP_OUT_RPB3	(RP(PORT_B, 3, BUCKET_B, DIR_OUT))
+#define PIC32_RP_OUT_RPC4	(RP(PORT_C, 4, BUCKET_B, DIR_OUT))
+#define PIC32_RP_OUT_RPG0	(RP(PORT_G, 0, BUCKET_B, DIR_OUT))
+#define PIC32_RP_OUT_RPA15	(RP(PORT_A, 15, BUCKET_B, DIR_OUT))
+#define PIC32_RP_OUT_RPD7	(RP(PORT_D, 7, BUCKET_B, DIR_OUT))
+
+/* Remappable pins: BUCKET C */
+#define PIC32_RP_OUT_RPD9	(RP(PORT_D, 9, BUCKET_C, DIR_OUT))
+#define PIC32_RP_OUT_RPB8	(RP(PORT_B, 8, BUCKET_C, DIR_OUT))
+#define PIC32_RP_OUT_RPB15	(RP(PORT_B, 15, BUCKET_C, DIR_OUT))
+#define PIC32_RP_OUT_RPD4	(RP(PORT_D, 4, BUCKET_C, DIR_OUT))
+#define PIC32_RP_OUT_RPB0	(RP(PORT_B, 0, BUCKET_C, DIR_OUT))
+#define PIC32_RP_OUT_RPE3	(RP(PORT_E, 3, BUCKET_C, DIR_OUT))
+#define PIC32_RP_OUT_RPB7	(RP(PORT_B, 7, BUCKET_C, DIR_OUT))
+#define PIC32_RP_OUT_RPF12	(RP(PORT_F, 12, BUCKET_C, DIR_OUT))
+#define PIC32_RP_OUT_RPD12	(RP(PORT_D, 12, BUCKET_C, DIR_OUT))
+#define PIC32_RP_OUT_RPF8	(RP(PORT_F, 8, BUCKET_C, DIR_OUT))
+#define PIC32_RP_OUT_RPC3	(RP(PORT_C, 3, BUCKET_C, DIR_OUT))
+#define PIC32_RP_OUT_RPE9	(RP(PORT_E, 9, BUCKET_C, DIR_OUT))
+
+/* Remappable pins: BUCKET D */
+#define PIC32_RP_OUT_RPG9	(RP(PORT_G, 9, BUCKET_D, DIR_OUT))
+#define PIC32_RP_OUT_RPD0	(RP(PORT_D, 0, BUCKET_D, DIR_OUT))
+#define PIC32_RP_OUT_RPB6	(RP(PORT_B, 6, BUCKET_D, DIR_OUT))
+#define PIC32_RP_OUT_RPD5	(RP(PORT_D, 5, BUCKET_D, DIR_OUT))
+#define PIC32_RP_OUT_RPB2	(RP(PORT_B, 2, BUCKET_D, DIR_OUT))
+#define PIC32_RP_OUT_RPF3	(RP(PORT_F, 3, BUCKET_D, DIR_OUT))
+#define PIC32_RP_OUT_RPC2	(RP(PORT_C, 2, BUCKET_D, DIR_OUT))
+#define PIC32_RP_OUT_RPE8	(RP(PORT_E, 8, BUCKET_D, DIR_OUT))
+#define PIC32_RP_OUT_RPF2	(RP(PORT_F, 2, BUCKET_D, DIR_OUT))
+
+/* Peripheral pins: all buckets */
+#define PIC32_PP_OUT_U3TX	(PP(PP_U3TX, BUCKET_A, DIR_OUT) | COD(0x1))
+#define PIC32_PP_OUT_U4RTS	(PP(PP_U4RTS, BUCKET_A, DIR_OUT) | COD(0x2))
+#define PIC32_PP_OUT_SDO1	(PP(PP_SDO1, BUCKET_AB, DIR_OUT) | COD(0x5))
+#define PIC32_PP_OUT_SDO2	(PP(PP_SDO2, BUCKET_AB, DIR_OUT) | COD(0x6))
+#define PIC32_PP_OUT_SDO3	(PP(PP_SDO3, BUCKET_AB, DIR_OUT) | COD(0x7))
+#define PIC32_PP_OUT_SDO5	(PP(PP_SDO5, BUCKET_AB, DIR_OUT) | COD(0x9))
+#define PIC32_PP_OUT_SS6	(PP(PP_SS6, BUCKET_A, DIR_OUT) | COD(0xA))
+#define PIC32_PP_OUT_OC3	(PP(PP_OC3, BUCKET_A, DIR_OUT) | COD(0xB))
+#define PIC32_PP_OUT_OC6	(PP(PP_OC6, BUCKET_A, DIR_OUT) | COD(0xC))
+#define PIC32_PP_OUT_REFCLKO4	(PP(PP_REFCLKO4, BUCKET_A, DIR_OUT) | COD(0xD))
+#define PIC32_PP_OUT_C2OUT	(PP(PP_C2OUT, BUCKET_A, DIR_OUT) | COD(0xE))
+#define PIC32_PP_OUT_C1TX	(PP(PP_C1TX, BUCKET_A, DIR_OUT) | COD(0xF))
+
+#define PIC32_PP_OUT_U1TX	(PP(PP_U1TX, BUCKET_B, DIR_OUT) | COD(0x1))
+#define PIC32_PP_OUT_U2RTS	(PP(PP_U2RTS, BUCKET_B, DIR_OUT) | COD(0x2))
+#define PIC32_PP_OUT_U5TX	(PP(PP_U5TX, BUCKET_B, DIR_OUT) | COD(0x3))
+#define PIC32_PP_OUT_U6RTS	(PP(PP_U6RTS, BUCKET_B, DIR_OUT) | COD(0x4))
+#define PIC32_PP_OUT_SDO4	(PP(PP_SDO4, BUCKET_BD, DIR_OUT) | COD(0x8))
+#define PIC32_PP_OUT_OC4	(PP(PP_OC4, BUCKET_B, DIR_OUT) | COD(0xB))
+#define PIC32_PP_OUT_OC7	(PP(PP_OC7, BUCKET_B, DIR_OUT) | COD(0xC))
+#define PIC32_PP_OUT_REFCLKO1	(PP(PP_REFCLKO1, BUCKET_B, DIR_OUT) | COD(0xF))
+
+#define PIC32_PP_OUT_U3RTS	(PP(PP_U3RTS, BUCKET_C, DIR_OUT) | COD(0x1))
+#define PIC32_PP_OUT_U4TX	(PP(PP_U4TX, BUCKET_C, DIR_OUT) | COD(0x2))
+#define PIC32_PP_OUT_U6TX	(PP(PP_U6TX, BUCKET_CD, DIR_OUT) | COD(0x4))
+#define PIC32_PP_OUT_SS1	(PP(PP_SS1, BUCKET_C, DIR_OUT) | COD(0x5))
+#define PIC32_PP_OUT_SS3	(PP(PP_SS3, BUCKET_C, DIR_OUT) | COD(0x7))
+#define PIC32_PP_OUT_SS4	(PP(PP_SS4, BUCKET_C, DIR_OUT) | COD(0x8))
+#define PIC32_PP_OUT_SS5	(PP(PP_SS5, BUCKET_C, DIR_OUT) | COD(0x9))
+#define PIC32_PP_OUT_SDO6	(PP(PP_SDO6, BUCKET_CD, DIR_OUT) | COD(0xA))
+#define PIC32_PP_OUT_OC5	(PP(PP_OC5, BUCKET_C, DIR_OUT) | COD(0xB))
+#define PIC32_PP_OUT_OC8	(PP(PP_OC8, BUCKET_C, DIR_OUT) | COD(0xC))
+#define PIC32_PP_OUT_C1OUT	(PP(PP_C1OUT, BUCKET_C, DIR_OUT) | COD(0xE))
+#define PIC32_PP_OUT_REFCLKO3	(PP(PP_REFCLKO3, BUCKET_C, DIR_OUT) | COD(0xF))
+
+#define PIC32_PP_OUT_U1RTS	(PP(PP_U1RTS, BUCKET_D, DIR_OUT) | COD(0x1))
+#define PIC32_PP_OUT_U2TX	(PP(PP_U2TX, BUCKET_D, DIR_OUT) | COD(0x2))
+#define PIC32_PP_OUT_U5RTS	(PP(PP_U5RTS, BUCKET_D, DIR_OUT) | COD(0x3))
+#define PIC32_PP_OUT_SS2	(PP(PP_SS2, BUCKET_D, DIR_OUT) | COD(0x6))
+#define PIC32_PP_OUT_OC2	(PP(PP_OC2, BUCKET_D, DIR_OUT) | COD(0xB))
+#define PIC32_PP_OUT_OC1	(PP(PP_OC1, BUCKET_D, DIR_OUT) | COD(0xC))
+#define PIC32_PP_OUT_OC9	(PP(PP_OC9, BUCKET_D, DIR_OUT) | COD(0xD))
+#define PIC32_PP_OUT_C2TX	(PP(PP_C2TX, BUCKET_D, DIR_OUT) | COD(0xF))
+
+/* pin configurations flags */
+#define CONF_DIR_OFF			0
+#define CONF_COD_OFF			2
+#define CONF_DIR(x)			((x) << (CONF_DIR_OFF))
+#define CONF_COD(x)			((x) << (CONF_COD_OFF))
+
+#define PIC32_PIN_CONF_NONE		(CONF_DIR(DIR_NONE) | CONF_COD(0x0))
+
+#define PIC32_PIN_CONF_OD		(CONF_DIR(DIR_NONE) | CONF_COD(0x1))
+#define PIC32_PIN_CONF_OD_OUT		(CONF_DIR(DIR_OUT)  | CONF_COD(0x2))
+
+#define PIC32_PIN_CONF_PU		(CONF_DIR(DIR_NONE) | CONF_COD(0x3))
+#define PIC32_PIN_CONF_PU_IN		(CONF_DIR(DIR_IN)   | CONF_COD(0x4))
+
+#define PIC32_PIN_CONF_PD		(CONF_DIR(DIR_NONE) | CONF_COD(0x5))
+#define PIC32_PIN_CONF_PD_IN		(CONF_DIR(DIR_IN)   | CONF_COD(0x6))
+
+#define PIC32_PIN_CONF_AN		(CONF_DIR(DIR_NONE) | CONF_COD(0x7))
+#define PIC32_PIN_CONF_AN_IN		(CONF_DIR(DIR_IN)   | CONF_COD(0x8))
+
+#define PIC32_PIN_CONF_DG		(CONF_DIR(DIR_NONE) | CONF_COD(0x9))
+#define PIC32_PIN_CONF_DG_IN		(CONF_DIR(DIR_IN)   | CONF_COD(0xA))
+#define PIC32_PIN_CONF_DG_OUT		(CONF_DIR(DIR_OUT)  | CONF_COD(0xB))
+
+/* change notification trigger type */
+#define PIC32_CN_RISING		1
+#define PIC32_CN_FALLING	2
+#define PIC32_CN_BOTH		3
+
+#endif /* __DT_BINDINGS_PIC32MZDA_PINCTRL_H__ */
-- 
1.7.9.5
