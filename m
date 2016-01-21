Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Jan 2016 23:35:55 +0100 (CET)
Received: from mail-lf0-f47.google.com ([209.85.215.47]:35672 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011182AbcAUWeopOqZN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 21 Jan 2016 23:34:44 +0100
Received: by mail-lf0-f47.google.com with SMTP id c192so36081106lfe.2
        for <linux-mips@linux-mips.org>; Thu, 21 Jan 2016 14:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0LezZTddopfE/T2esL34qja2mQ9TbgBhe5TueY73ocs=;
        b=WbwP5ycH3FbV7YRp2+zRTNa1z6r1s0fgjk0OcGDBCldty9mQfacIlvi7A9V2zrtS/Y
         J6Uwhe3t6Ces/et3Z8rb8VrLCyZQ3DDTjVqe9AGUVV+sQ+MCy5WnPxEiZJ00RJ8LrsUr
         PJnVdt/VFUDe9Z674mHbbuisbIbsxBjXZYVP8uxerdyfaa4BxZrhGUgEGqcOiBxqvs/8
         aiO1c/tvHr9rCYfx1fvIsi9hbwo5QdstvSh8PpfSQvzXEHJndBoUna/7MXP2VrNm1amp
         Qj2TT0Ogn0Gju63b8w+vmaSuLDJXfkiS58Y4dh+At+my08xjd1OC9qa+o233Zn1ilcUr
         zj1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0LezZTddopfE/T2esL34qja2mQ9TbgBhe5TueY73ocs=;
        b=h9fn8hftKzQEvfuOkWnMnPh/ZQCP8nBnHjJ4ZfQRcOT+9AUaBItmuzAZgQ0VPH892V
         tL9CfkHsS66HH8QfKrdBQCKgQZGKMTyATTMBY48Jpks4LgkXjS76bJ6zAMrjWIi+ZoYG
         ISSOLH1tP3a/2LLnKT0HAjP09rUlR/5yrgn443FC4PCbljACI6NhhB8ZyBIDOcN5Nz42
         sFGa3bP0+ApTQ0QbkAwHK0ZHQ0+X7HDzMHM4zYxwU7nKI16NOPObLEYSbGDD0eVFYW15
         WikusBj4Y+1D0EOJ7H3oJ+d/QJUbGWEcN24+80mXARKYZIok0hic6jc8UhqKeN0VgYOq
         5/fA==
X-Gm-Message-State: ALoCoQm74jKQlYJ7Y4Msi8B5ewflm1wq0aPM1jVkIBM2cpIZwUqdvQS1XbnQuW2ht3MV9iCnn83QIcwiK6NtKSb8rG81BHeQsw==
X-Received: by 10.25.18.162 with SMTP id 34mr14715193lfs.52.1453415679509;
        Thu, 21 Jan 2016 14:34:39 -0800 (PST)
Received: from localhost.localdomain (ppp109-252-26-184.pppoe.spdop.ru. [109.252.26.184])
        by smtp.gmail.com with ESMTPSA id j130sm319217lfe.23.2016.01.21.14.34.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 21 Jan 2016 14:34:38 -0800 (PST)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Antony Pavlov <antonynpavlov@gmail.com>,
        Gabor Juhos <juhosg@openwrt.org>, Alban Bedel <albeu@free.fr>,
        devicetree@vger.kernel.org
Subject: [RFC v2 4/7] MIPS: ath79: add initial support for TP-LINK MR3020
Date:   Fri, 22 Jan 2016 01:34:21 +0300
Message-Id: <1453415664-20307-5-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1453415664-20307-1-git-send-email-antonynpavlov@gmail.com>
References: <1453415664-20307-1-git-send-email-antonynpavlov@gmail.com>
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51287
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

Currently only the UART, SPI-flash and LEDs are supported.

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
 arch/mips/ath79/Kconfig              |  5 +++
 arch/mips/boot/dts/qca/Makefile      |  1 +
 arch/mips/boot/dts/qca/tl_mr3020.dts | 72 ++++++++++++++++++++++++++++++++++++
 3 files changed, 78 insertions(+)

diff --git a/arch/mips/ath79/Kconfig b/arch/mips/ath79/Kconfig
index 13c04cf..4fd53ae 100644
--- a/arch/mips/ath79/Kconfig
+++ b/arch/mips/ath79/Kconfig
@@ -77,6 +77,11 @@ choice
 	help
 	  Select a devicetree that should be built into the kernel.
 
+	config DTB_TL_MR3020
+		bool "TL-MR3020"
+		select BUILTIN_DTB
+		select SOC_AR933X
+
 	config DTB_TL_WR1043ND_V1
 		bool "TL-WR1043ND Version 1"
 		select BUILTIN_DTB
diff --git a/arch/mips/boot/dts/qca/Makefile b/arch/mips/boot/dts/qca/Makefile
index 2d61455d..ae47e35 100644
--- a/arch/mips/boot/dts/qca/Makefile
+++ b/arch/mips/boot/dts/qca/Makefile
@@ -2,6 +2,7 @@
 dtb-$(CONFIG_ATH79)			+= ar9132_tl_wr1043nd_v1.dtb
 
 # Select a DTB to build in the kernel
+obj-$(CONFIG_DTB_TL_MR3020)		+= tl_mr3020.dtb.o
 obj-$(CONFIG_DTB_TL_WR1043ND_V1)	+= ar9132_tl_wr1043nd_v1.dtb.o
 
 # Force kbuild to make empty built-in.o if necessary
diff --git a/arch/mips/boot/dts/qca/tl_mr3020.dts b/arch/mips/boot/dts/qca/tl_mr3020.dts
new file mode 100644
index 0000000..ca00836
--- /dev/null
+++ b/arch/mips/boot/dts/qca/tl_mr3020.dts
@@ -0,0 +1,72 @@
+/dts-v1/;
+
+#include "ar9331.dtsi"
+#include <dt-bindings/gpio/gpio.h>
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
2.6.2
