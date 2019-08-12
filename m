Return-Path: <SRS0=4POb=WI=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8648C31E40
	for <linux-mips@archiver.kernel.org>; Mon, 12 Aug 2019 10:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3A8A2085A
	for <linux-mips@archiver.kernel.org>; Mon, 12 Aug 2019 10:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbfHLKhN (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 12 Aug 2019 06:37:13 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:35772 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727276AbfHLKhN (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Mon, 12 Aug 2019 06:37:13 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 88666A33D8;
        Mon, 12 Aug 2019 12:37:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id 9qlWgnnSM-P8; Mon, 12 Aug 2019 12:36:57 +0200 (CEST)
From:   Stefan Roese <sr@denx.de>
To:     linux-mips@vger.kernel.org
Cc:     Paul Burton <paul.burton@mips.com>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        John Crispin <john@phrozen.org>
Subject: [PATCH 4/4 v4] MIPS: ralink: Add GARDENA smart Gateway MT7688 board
Date:   Mon, 12 Aug 2019 12:36:55 +0200
Message-Id: <20190812103655.11070-4-sr@denx.de>
In-Reply-To: <20190812103655.11070-1-sr@denx.de>
References: <20190812103655.11070-1-sr@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

This patch adds support for the GARDENA smart Gateway, which is based on
the MediaTek MT7688 SoC. It is equipped with 128 MiB of DDR and 8 MiB of
flash (SPI NOR) and additional 128MiB SPI NAND storage.

Signed-off-by: Stefan Roese <sr@denx.de>
Cc: Paul Burton <paul.burton@mips.com>
Cc: Harvey Hunt <harveyhuntnexus@gmail.com>
Cc: John Crispin <john@phrozen.org>
---
v4:
- Added "ralink,mt7688a-soc" to compatible for the used SoC

v3:
- No change (bindings documentation added in separate patch)

v2:
- Use Harvey's new email address (not at imgtec)
- Use correct linux-mips list address

 .../ralink/gardena_smart_gateway_mt7688.dts   | 197 ++++++++++++++++++
 1 file changed, 197 insertions(+)
 create mode 100644 arch/mips/boot/dts/ralink/gardena_smart_gateway_mt7688.dts

diff --git a/arch/mips/boot/dts/ralink/gardena_smart_gateway_mt7688.dts b/arch/mips/boot/dts/ralink/gardena_smart_gateway_mt7688.dts
new file mode 100644
index 000000000000..aa5caaa31104
--- /dev/null
+++ b/arch/mips/boot/dts/ralink/gardena_smart_gateway_mt7688.dts
@@ -0,0 +1,197 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 Stefan Roese <sr@denx.de>
+ */
+
+/dts-v1/;
+
+/include/ "mt7628a.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+
+/ {
+	compatible = "gardena,smart-gateway-mt7688", "ralink,mt7688a-soc",
+		     "ralink,mt7628a-soc";
+	model = "GARDENA smart Gateway (MT7688)";
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x0 0x8000000>;
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinmux_gpio_gpio>;	/* GPIO11 */
+
+		user_btn1 {
+			label = "USER_BTN1";
+			gpios = <&gpio 11 GPIO_ACTIVE_LOW>;
+			linux,code =<KEY_PROG1> ;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinmux_pwm0_gpio>,	/* GPIO18 */
+			    <&pinmux_pwm1_gpio>,	/* GPIO19 */
+			    <&pinmux_sdmode_gpio>,	/* GPIO22..29 */
+			    <&pinmux_p0led_an_gpio>;	/* GPIO43 */
+		/*
+		 * <&pinmux_i2s_gpio> (covers GPIO0..3) is needed here as
+		 * well for GPIO3. But this is already claimed for uart1
+		 * (see below). So we can't include it in this LED node.
+		 */
+
+		power_blue {
+			label = "smartgw:power:blue";
+			gpios = <&gpio 18 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		power_green {
+			label = "smartgw:power:green";
+			gpios = <&gpio 19 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		power_red {
+			label = "smartgw:power:red";
+			gpios = <&gpio 22 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		radio_blue {
+			label = "smartgw:radio:blue";
+			gpios = <&gpio 23 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		radio_green {
+			label = "smartgw:radio:green";
+			gpios = <&gpio 24 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		radio_red {
+			label = "smartgw:radio:red";
+			gpios = <&gpio 25 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		internet_blue {
+			label = "smartgw:internet:blue";
+			gpios = <&gpio 26 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		internet_green {
+			label = "smartgw:internet:green";
+			gpios = <&gpio 27 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		internet_red {
+			label = "smartgw:internet:red";
+			gpios = <&gpio 28 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		ethernet_link {
+			label = "smartgw:eth:link";
+			gpios = <&gpio 3 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "netdev";
+		};
+
+		ethernet_activity {
+			label = "smartgw:eth:act";
+			gpios = <&gpio 43 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "netdev";
+		};
+	};
+
+	aliases {
+		serial0 = &uart0;
+	};
+};
+
+&i2c {
+	status = "okay";
+};
+
+&spi {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinmux_spi_spi>, <&pinmux_spi_cs1_cs>;
+
+	m25p80@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <40000000>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 {
+				label = "uboot";
+				reg = <0x0 0xa0000>;
+				read-only;
+			};
+
+			partition@a0000 {
+				label = "uboot_env0";
+				reg = <0xa0000 0x10000>;
+			};
+
+			partition@b0000 {
+				label = "uboot_env1";
+				reg = <0xb0000 0x10000>;
+			};
+
+			factory: partition@c0000 {
+				label = "factory";
+				reg = <0xc0000 0x10000>;
+				read-only;
+			};
+		};
+	};
+
+	nand_flash@1 {
+		compatible = "spi-nand";
+		linux,mtd-name = "gd5f";
+		reg = <1>;
+		spi-max-frequency = <40000000>;
+	};
+};
+
+&uart1 {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinmux_i2s_gpio>;		/* GPIO0..3 */
+
+	rts-gpios = <&gpio 1 GPIO_ACTIVE_LOW>;
+	cts-gpios = <&gpio 2 GPIO_ACTIVE_LOW>;
+};
+
+&uart2 {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinmux_p2led_an_gpio>,	/* GPIO41 */
+		    <&pinmux_p3led_an_gpio>;	/* GPIO40 */
+
+	rts-gpios = <&gpio 40 GPIO_ACTIVE_LOW>;
+	cts-gpios = <&gpio 41 GPIO_ACTIVE_LOW>;
+};
+
+&watchdog {
+	status = "okay";
+};
-- 
2.22.0

