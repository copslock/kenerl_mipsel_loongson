Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Mar 2016 04:38:00 +0100 (CET)
Received: from mail-lf0-f67.google.com ([209.85.215.67]:36405 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007140AbcCQDey2oMTp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Mar 2016 04:34:54 +0100
Received: by mail-lf0-f67.google.com with SMTP id h198so2226423lfh.3
        for <linux-mips@linux-mips.org>; Wed, 16 Mar 2016 20:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5MGCYxm2faudCqKQSQ/Dyt0h5nBndfKZ3xYZEfpXpms=;
        b=gD+dU2Gxxpi5rTJndtQ334mnAQWk9MLKkV4nnPx+ksRNU7CD4P2lY9iEQ7VXuclmn3
         31qb4n1OAPMzbo+GmH5n0VPC7yfxH7NsMHq1aoqj2myk05N//tpR8LCRsXJYlGLQ8I5Y
         A7d8mH2D50OoH2Kh+BKQKGvt5EjTyeTYbhWsxiOiZQC1JNhI7YrdhVu+CKX32vUxLe1r
         TmQj83CCNn/xj6P2qDqE2HughzvNZfoI0HgoC/8lOiIaho+Xvst5xwDBLI60hs7a6CFF
         sxgBFzktLUjByNqTKPjiPXji6d5sQ52jXr91WdB4PmLqdTNicO8gtP7952ArVOMIZwoM
         ro3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5MGCYxm2faudCqKQSQ/Dyt0h5nBndfKZ3xYZEfpXpms=;
        b=C3AwitTpCi/PgDYNm9Is+cDF2DeE1QMnaDl7TdRrlbI3W4JR+GBycW30xcN1vH5Kzd
         plo/tPLj/tUAi1xTPVlkt79vx3SEueU+xDu37YvmAcbtGBbrxODqj0EH7OHaDIc3vq/D
         m2ipnC/aqsk4M6Vi7DYlxS2L3ht/RXnnqmJKG1FW2V9cfzNy01u2I9X8nrpHbNFhMr9u
         D/AbcTdETQoqYMhJT+8g7KG9PcHnJHd9WdSzv4QgAXVTEM7a6LaNpRlq6K25E0oFWuUK
         TtYUNrTFPMAc6648IxYISUA3G0r2+kb3TYsH5ZPFVwdx4kSHGeKKm9xnFz1Ag5Y/KcDr
         qZfg==
X-Gm-Message-State: AD7BkJJzqOnY31W3zS3/tv8eikTgrPoer2lYVlZum6UjPKl13/6MvHWn8rNw2DT2uWRfBg==
X-Received: by 10.25.161.205 with SMTP id k196mr2215619lfe.61.1458185689138;
        Wed, 16 Mar 2016 20:34:49 -0700 (PDT)
Received: from localhost.localdomain (ppp109-252-26-173.pppoe.spdop.ru. [109.252.26.173])
        by smtp.gmail.com with ESMTPSA id gp6sm1026698lbc.44.2016.03.16.20.34.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Mar 2016 20:34:48 -0700 (PDT)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Gabor Juhos <juhosg@openwrt.org>, Alban Bedel <albeu@free.fr>,
        devicetree@vger.kernel.org
Subject: [PATCH v2 12/18] MIPS: ath79: add initial support for TP-LINK MR3020
Date:   Thu, 17 Mar 2016 06:34:19 +0300
Message-Id: <1458185665-4521-13-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1458185665-4521-1-git-send-email-antonynpavlov@gmail.com>
References: <1458185665-4521-1-git-send-email-antonynpavlov@gmail.com>
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52626
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: antonynpavlov@gmail.com
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

The following features are supported:

  * UART;
  * SPI-flash;
  * USB host;
  * GPIO keys and LEDs.

Links:

  * http://www.tp-link.com/en/products/details/?model=TL-MR3020
  * http://wiki.openwrt.org/toh/tp-link/tl-mr3020
  * https://wikidevi.com/wiki/TP-LINK_TL-MR3020

Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
Cc: Gabor Juhos <juhosg@openwrt.org>
Cc: Alban Bedel <albeu@free.fr>
Cc: linux-mips@linux-mips.org
Cc: devicetree@vger.kernel.org
---
 arch/mips/boot/dts/qca/Makefile             |   1 +
 arch/mips/boot/dts/qca/ar9331_tl_mr3020.dts | 118 ++++++++++++++++++++++++++++
 2 files changed, 119 insertions(+)

diff --git a/arch/mips/boot/dts/qca/Makefile b/arch/mips/boot/dts/qca/Makefile
index 14bd225..5e2c20d 100644
--- a/arch/mips/boot/dts/qca/Makefile
+++ b/arch/mips/boot/dts/qca/Makefile
@@ -1,5 +1,6 @@
 # All DTBs
 dtb-$(CONFIG_ATH79)			+= ar9132_tl_wr1043nd_v1.dtb
+dtb-$(CONFIG_ATH79)			+= ar9331_tl_mr3020.dtb
 
 # Force kbuild to make empty built-in.o if necessary
 obj-				+= dummy.o
diff --git a/arch/mips/boot/dts/qca/ar9331_tl_mr3020.dts b/arch/mips/boot/dts/qca/ar9331_tl_mr3020.dts
new file mode 100644
index 0000000..919cf3b
--- /dev/null
+++ b/arch/mips/boot/dts/qca/ar9331_tl_mr3020.dts
@@ -0,0 +1,118 @@
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+
+#include "ar9331.dtsi"
+
+/ {
+	model = "TP-Link TL-MR3020";
+	compatible = "tplink,tl-mr3020";
+
+	aliases {
+		serial0 = &uart;
+	};
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x0 0x2000000>;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		wlan {
+			label = "tp-link:green:wlan";
+			gpios = <&gpio 0 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		lan {
+			label = "tp-link:green:lan";
+			gpios = <&gpio 17 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
+
+		wps {
+			label = "tp-link:green:wps";
+			gpios = <&gpio 26 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
+
+		led3g {
+			label = "tp-link:green:3g";
+			gpios = <&gpio 27 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
+	};
+
+	gpio-keys-polled {
+		compatible = "gpio-keys-polled";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		poll-interval = <100>;
+
+		button@0 {
+			label = "wps";
+			linux,code = <KEY_WPS_BUTTON>;
+			gpios = <&gpio 11 GPIO_ACTIVE_HIGH>;
+		};
+
+		button@1 {
+			label = "sw1";
+			linux,code = <BTN_0>;
+			gpios = <&gpio 18 GPIO_ACTIVE_HIGH>;
+		};
+
+		button@2 {
+			label = "sw2";
+			linux,code = <BTN_1>;
+			gpios = <&gpio 20 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	reg_usb_vbus: reg_usb_vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usb_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpio 8 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+};
+
+&ref {
+	clock-frequency = <25000000>;
+};
+
+&uart {
+	status = "okay";
+};
+
+&gpio {
+	status = "okay";
+};
+
+&usb {
+	dr_mode = "host";
+	vbus-supply = <&reg_usb_vbus>;
+	status = "okay";
+};
+
+&usb_phy {
+	status = "okay";
+};
+
+&spi {
+	num-chipselects = <1>;
+	status = "okay";
+
+	/* Spansion S25FL032PIF SPI flash */
+	spiflash: s25sl032p@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "spansion,s25sl032p", "jedec,spi-nor";
+		spi-max-frequency = <104000000>;
+		reg = <0>;
+	};
+};
-- 
2.7.0
