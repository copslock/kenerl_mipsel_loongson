Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Oct 2016 07:57:28 +0200 (CEST)
Received: from mailapp02.imgtec.com ([217.156.133.132]:22616 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992110AbcJNF5J10S5s (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 14 Oct 2016 07:57:09 +0200
Received: from HHMAIL03.hh.imgtec.org (unknown [10.44.0.21])
        by Forcepoint Email with ESMTPS id 3F293D87D8051;
        Fri, 14 Oct 2016 06:57:00 +0100 (IST)
Received: from PUMAIL01.pu.imgtec.org (192.168.91.250) by
 HHMAIL03.hh.imgtec.org (10.44.0.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 14 Oct 2016 06:57:02 +0100
Received: from pudesk287-linux.pu.imgtec.org (192.168.91.23) by
 PUMAIL01.pu.imgtec.org (192.168.91.250) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Fri, 14 Oct 2016 11:27:00 +0530
From:   Rahul Bedarkar <rahul.bedarkar@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        James Hartley <james.hartley@imgtec.com>
CC:     <linux-mips@linux-mips.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Rahul Bedarkar <rahul.bedarkar@imgtec.com>
Subject: [PATCH v2 2/2] MIPS: DTS: img: add device tree for Marduk board
Date:   Fri, 14 Oct 2016 11:25:55 +0530
Message-ID: <1476424555-22629-2-git-send-email-rahul.bedarkar@imgtec.com>
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1476424555-22629-1-git-send-email-rahul.bedarkar@imgtec.com>
References: <1476424555-22629-1-git-send-email-rahul.bedarkar@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.91.23]
Return-Path: <Rahul.Bedarkar@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55426
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rahul.bedarkar@imgtec.com
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

Add support for Imagination Technologies' Marduk board which is based
on Pistachio SoC. It is also known as Creator Ci40. Marduk is legacy
name and will be there for decades.

Documentation for this board can be found on
https://docs.creatordev.io/ci40/

This patch adds initial support for board with following peripherals:

* PWM based heartbeat LED
* GPIO based buttons
* SPI NOR flash on SPI1
* UART0 and UART1
* SD card
* Ethernet
* USB
* PWM
* ADC
* I2C

Signed-off-by: Rahul Bedarkar <rahul.bedarkar@imgtec.com>
---
Changes in v2:
  - Correct RAM size. It is 256MB instead of 128MB.
  - Rename nodes pwm_leds -> leds and gpio_keys -> keys (Suggested by Rob Herring)
  - Don't use '_' in node name for internal_dac_supply (Suggested by Rob Herring)
  - Add part name in compatible string for spi-nor (Suggested by Rob Herring)
---
 .../bindings/mips/img/pistachio-marduk.txt         |  10 ++
 MAINTAINERS                                        |   6 +
 arch/mips/boot/dts/img/Makefile                    |   9 ++
 arch/mips/boot/dts/img/pistachio_marduk.dts        | 163 +++++++++++++++++++++
 4 files changed, 188 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mips/img/pistachio-marduk.txt
 create mode 100644 arch/mips/boot/dts/img/Makefile
 create mode 100644 arch/mips/boot/dts/img/pistachio_marduk.dts

diff --git a/Documentation/devicetree/bindings/mips/img/pistachio-marduk.txt b/Documentation/devicetree/bindings/mips/img/pistachio-marduk.txt
new file mode 100644
index 0000000..2d5126d
--- /dev/null
+++ b/Documentation/devicetree/bindings/mips/img/pistachio-marduk.txt
@@ -0,0 +1,10 @@
+Imagination Technologies' Pistachio SoC based Marduk Board
+==========================================================
+
+Compatible string must be "img,pistachio-marduk", "img,pistachio"
+
+Hardware and other related documentation is available at
+https://docs.creatordev.io/ci40/
+
+It is also known as Creator Ci40. Marduk is legacy name and will
+be there for decades.
diff --git a/MAINTAINERS b/MAINTAINERS
index 98bcf06..8e6c962b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7515,6 +7515,12 @@ W:	http://www.kernel.org/doc/man-pages
 L:	linux-man@vger.kernel.org
 S:	Maintained
 
+MARDUK (CREATOR CI40) DEVICE TREE SUPPORT
+M:	Rahul Bedarkar <rahul.bedarkar@imgtec.com>
+L:	linux-mips@linux-mips.org
+S:	Maintained
+F:	arch/mips/boot/dts/img/pistachio_marduk.dts
+
 MARVELL 88E6XXX ETHERNET SWITCH FABRIC DRIVER
 M:	Andrew Lunn <andrew@lunn.ch>
 M:	Vivien Didelot <vivien.didelot@savoirfairelinux.com>
diff --git a/arch/mips/boot/dts/img/Makefile b/arch/mips/boot/dts/img/Makefile
new file mode 100644
index 0000000..69a65f0
--- /dev/null
+++ b/arch/mips/boot/dts/img/Makefile
@@ -0,0 +1,9 @@
+dtb-$(CONFIG_MACH_PISTACHIO)	+= pistachio_marduk.dtb
+
+obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
+
+# Force kbuild to make empty built-in.o if necessary
+obj-				+= dummy.o
+
+always				:= $(dtb-y)
+clean-files			:= *.dtb *.dtb.S
diff --git a/arch/mips/boot/dts/img/pistachio_marduk.dts b/arch/mips/boot/dts/img/pistachio_marduk.dts
new file mode 100644
index 0000000..cf9cebd
--- /dev/null
+++ b/arch/mips/boot/dts/img/pistachio_marduk.dts
@@ -0,0 +1,163 @@
+/*
+ * Copyright (C) 2015, 2016 Imagination Technologies Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * IMG Marduk board is also known as Creator Ci40.
+ */
+
+/dts-v1/;
+
+#include "pistachio.dtsi"
+
+/ {
+	model = "IMG Marduk (Creator Ci40)";
+	compatible = "img,pistachio-marduk", "img,pistachio";
+
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+		ethernet0 = &enet;
+		spi0 = &spfi0;
+		spi1 = &spfi1;
+	};
+
+	chosen {
+		bootargs = "root=/dev/sda1 rootwait ro lpj=723968";
+		stdout-path = "serial1:115200";
+	};
+
+	memory {
+		device_type = "memory";
+		reg =  <0x00000000 0x10000000>;
+	};
+
+	reg_1v8: fixed-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "aux_adc_vref";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-boot-on;
+	};
+
+	internal_dac_supply: internal-dac-supply {
+		compatible = "regulator-fixed";
+		regulator-name = "internal_dac_supply";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
+	leds {
+		compatible = "pwm-leds";
+		heartbeat {
+			label = "marduk:red:heartbeat";
+			pwms = <&pwm 3 300000>;
+			max-brightness = <255>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
+	keys {
+		compatible = "gpio-keys";
+		button@1 {
+			label = "Button 1";
+			linux,code = <0x101>; /* BTN_1 */
+			gpios = <&gpio3 6 GPIO_ACTIVE_LOW>;
+		};
+		button@2 {
+			label = "Button 2";
+			linux,code = <0x102>; /* BTN_2 */
+			gpios = <&gpio2 14 GPIO_ACTIVE_LOW>;
+		};
+	};
+};
+
+&internal_dac {
+	VDD-supply = <&internal_dac_supply>;
+};
+
+&spfi1 {
+	status = "okay";
+
+	pinctrl-0 = <&spim1_pins>, <&spim1_quad_pins>, <&spim1_cs0_pin>,
+		    <&spim1_cs1_pin>;
+	pinctrl-names = "default";
+	cs-gpios = <&gpio0 0 GPIO_ACTIVE_HIGH>, <&gpio0 1 GPIO_ACTIVE_HIGH>;
+
+	flash@0 {
+		compatible = "spansion,s25fl016k", "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <50000000>;
+	};
+};
+
+&uart0 {
+	status = "okay";
+	assigned-clock-rates = <114278400>, <1843200>;
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&usb {
+	status = "okay";
+};
+
+&enet {
+	status = "okay";
+};
+
+&pin_enet {
+	drive-strength = <2>;
+};
+
+&pin_enet_phy_clk {
+	drive-strength = <2>;
+};
+
+&sdhost {
+	status = "okay";
+	bus-width = <4>;
+	disable-wp;
+};
+
+&pin_sdhost_cmd {
+	drive-strength = <2>;
+};
+
+&pin_sdhost_data {
+	drive-strength = <2>;
+};
+
+&pwm {
+	status = "okay";
+
+	pinctrl-0 = <&pwmpdm0_pin>, <&pwmpdm1_pin>, <&pwmpdm2_pin>,
+		    <&pwmpdm3_pin>;
+	pinctrl-names = "default";
+};
+
+&adc {
+	status = "okay";
+	vref-supply = <&reg_1v8>;
+	adc-reserved-channels = <0x10>;
+};
+
+&i2c2 {
+	status = "okay";
+	clock-frequency = <400000>;
+
+	tpm@20 {
+		compatible = "infineon,slb9645tt";
+		reg = <0x20>;
+	};
+
+};
+
+&i2c3 {
+	status = "okay";
+	clock-frequency = <400000>;
+};
-- 
2.6.2
