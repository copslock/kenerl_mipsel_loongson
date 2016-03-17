Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Mar 2016 04:38:34 +0100 (CET)
Received: from mail-lf0-f67.google.com ([209.85.215.67]:34405 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006209AbcCQDe4TkW7p (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Mar 2016 04:34:56 +0100
Received: by mail-lf0-f67.google.com with SMTP id i75so2201820lfb.1
        for <linux-mips@linux-mips.org>; Wed, 16 Mar 2016 20:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kH3M2YWS7Il47tQxVWbrkHMTnkmOeHN70jnM/JGNLbw=;
        b=FOBrNHzaIU9i8zIRr2CwuHFnWEfGRaASe56r499fSDiNcHT3Z5BF8D7Fu6KQYFtaO0
         C1YWTrfpCoAdgWrc/So97hczpXbkMS/ZOr3QytbWL371V2jN3CTPjJGmlcHavLY7eakc
         vkPc53xNOHwAyxy9s6rMLrotnx1vs7T4LWgIDotoZkJdU96HCrH4JlCmJF6gUCQlcED0
         uqQ0mdrgzE67b50GkfiBsNgfW37fuoJROfZDXMJzOu2deLom+x0ZuGOwFB47mfmPW+8y
         gyAk1L8NQ7lbRapuBZv4IInGrzQ+qI97Um/OSryFJlc3aRdOzzeSHW3I4yKPO2KxKfCx
         c0mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kH3M2YWS7Il47tQxVWbrkHMTnkmOeHN70jnM/JGNLbw=;
        b=HPyLED3uiI7Q2Ay9pvmoAdP9D4k/RLaTHYrjJRFmqtUw/wrk2Bf8TpaWQSogPMlO0f
         G4kb0RbnLd+dttzSjXpAxGIQel90I0aENBNlSrya3KsHazjzg6WpwUJqpEPWa0n+zx3u
         bMYYjGb9qPLHHV07mL0HSZk0o3HSJM5P1zMxG7QkwS4YhrCCfNJYHL44RY1zJS5B3XQp
         Q7BHHyPCsh0jp1u2K/Zr1SlEG7AvxGsjmhD28v0gM3VzuAetihUVw974qjR29suS+Yz5
         C521FaUjZhKSk0IqkOmW2zS6s5HIY2CpDcojOF3gbBhnrap9ogNcgJpmkvzpeWKlpZjd
         OIBQ==
X-Gm-Message-State: AD7BkJL5YolQzrGJe4qtlDH42DvaOvfAZGk7yA6myn4++BGlUY6gZog9/Dqt0HZwLUzwBw==
X-Received: by 10.25.21.151 with SMTP id 23mr2702167lfv.89.1458185691059;
        Wed, 16 Mar 2016 20:34:51 -0700 (PDT)
Received: from localhost.localdomain (ppp109-252-26-173.pppoe.spdop.ru. [109.252.26.173])
        by smtp.gmail.com with ESMTPSA id gp6sm1026698lbc.44.2016.03.16.20.34.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Mar 2016 20:34:50 -0700 (PDT)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Gabor Juhos <juhosg@openwrt.org>, Alban Bedel <albeu@free.fr>,
        devicetree@vger.kernel.org
Subject: [PATCH v2 14/18] MIPS: ath79: add initial support for Dragino MS14 (Dragino 2)
Date:   Thu, 17 Mar 2016 06:34:21 +0300
Message-Id: <1458185665-4521-15-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1458185665-4521-1-git-send-email-antonynpavlov@gmail.com>
References: <1458185665-4521-1-git-send-email-antonynpavlov@gmail.com>
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52628
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

    * http://www.dragino.com/products/mother-board/item/71-ms14-p.html
    * https://wiki.openwrt.org/toh/dragino/ms14

Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
Cc: Gabor Juhos <juhosg@openwrt.org>
Cc: Alban Bedel <albeu@free.fr>
Cc: linux-mips@linux-mips.org
Cc: devicetree@vger.kernel.org
---
 arch/mips/boot/dts/qca/Makefile                |   1 +
 arch/mips/boot/dts/qca/ar9331_dragino_ms14.dts | 102 +++++++++++++++++++++++++
 2 files changed, 103 insertions(+)

diff --git a/arch/mips/boot/dts/qca/Makefile b/arch/mips/boot/dts/qca/Makefile
index 5e2c20d..2451364 100644
--- a/arch/mips/boot/dts/qca/Makefile
+++ b/arch/mips/boot/dts/qca/Makefile
@@ -1,5 +1,6 @@
 # All DTBs
 dtb-$(CONFIG_ATH79)			+= ar9132_tl_wr1043nd_v1.dtb
+dtb-$(CONFIG_ATH79)			+= ar9331_dragino_ms14.dtb
 dtb-$(CONFIG_ATH79)			+= ar9331_tl_mr3020.dtb
 
 # Force kbuild to make empty built-in.o if necessary
diff --git a/arch/mips/boot/dts/qca/ar9331_dragino_ms14.dts b/arch/mips/boot/dts/qca/ar9331_dragino_ms14.dts
new file mode 100644
index 0000000..56f8320
--- /dev/null
+++ b/arch/mips/boot/dts/qca/ar9331_dragino_ms14.dts
@@ -0,0 +1,102 @@
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+
+#include "ar9331.dtsi"
+
+/ {
+	model = "Dragino MS14 (Dragino 2)";
+	compatible = "dragino,ms14";
+
+	aliases {
+		serial0 = &uart;
+	};
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x0 0x4000000>;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		wlan {
+			label = "dragino2:red:wlan";
+			gpios = <&gpio 0 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		lan {
+			label = "dragino2:red:lan";
+			gpios = <&gpio 13 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
+
+		wan {
+			label = "dragino2:red:wan";
+			gpios = <&gpio 17 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
+
+		system {
+			label = "dragino2:red:system";
+			gpios = <&gpio 28 GPIO_ACTIVE_HIGH>;
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
+			label = "jumpstart";
+			linux,code = <KEY_WPS_BUTTON>;
+			gpios = <&gpio 11 GPIO_ACTIVE_LOW>;
+		};
+
+		button@1 {
+			label = "reset";
+			linux,code = <KEY_RESTART>;
+			gpios = <&gpio 12 GPIO_ACTIVE_LOW>;
+		};
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
+	/* Winbond 25Q128BVFG SPI flash */
+	spiflash: w25q128@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "winbond,w25q128", "jedec,spi-nor";
+		spi-max-frequency = <104000000>;
+		reg = <0>;
+	};
+};
-- 
2.7.0
