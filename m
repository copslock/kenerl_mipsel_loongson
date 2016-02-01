Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Feb 2016 01:14:29 +0100 (CET)
Received: from mail-lf0-f41.google.com ([209.85.215.41]:35238 "EHLO
        mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011946AbcBAALFJM0GA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Feb 2016 01:11:05 +0100
Received: by mail-lf0-f41.google.com with SMTP id l143so18960253lfe.2
        for <linux-mips@linux-mips.org>; Sun, 31 Jan 2016 16:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HO8nGr1y60ycDnIFMirR3scoqvEstMk8TZoJkVktmc8=;
        b=GXoT4ERJGuWRsheM+NtWo+3peeqDxkP9fOTcnyDa2taZx8MiAK2DT/MzWO9dL8q9K3
         oztA8JH4r6O0bgPKJl8I0ktZlYNp4gGkstfhyNxPPpmx99cKkmb9lou3eVipMCho/emL
         6uYPPb1d4rPXPcsKF8nFg/EB2D7jXX4j9q3vJ3KgpLa0xPeYZ911QJVLBECuoXW2mK0p
         zZ2jr4TDERu8fKmMwmA5GAF3iM4IYVHPIRd6GSA8XZ8+Yc7+y87LwADfbhwXOcCH0huT
         OUeR7oK/WboglwCCgoAPByLKwmjfvdel+QVpz4smhgpd9eMjgb8gXWhFWbFVaZegYQKY
         gRaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HO8nGr1y60ycDnIFMirR3scoqvEstMk8TZoJkVktmc8=;
        b=gydSZd21PiiSEkTSmF/58m3sRnc4zTEtEhwhzOB6GOI//qHcRVim7aIGGvBFonUjIk
         gtZPzuGFm9TozkjyRfPPX2heE/63eYeNpXvUHzUNazmA71gcKD0ocaFQLMunVoywqoZp
         vqC/ZdBHaEz1nqGfuz7+Wl4VbWTYLt+ZlYsZK7AegVd7tqlt7Bg2Y6OMlPGAGyxPEQ6B
         zkQyBZphVCJwVHM4RolqpCFuK5HbvdP9/aQT64thpyi6pbWzXnSbPfiz0N4lFKERYP1t
         Y7CgJ7fovA7loAdG4GnEA/E9Kz8KYbGDOkpoTD7vuGWactd54F71P6H5ly9yplueC4CW
         d9Zg==
X-Gm-Message-State: AG10YOQXOui9TCSebBLlQT1Af9C3FMFPdSAd0EL7kwBVpHuaIyR1e7BQefE2jbilvHVY+Q==
X-Received: by 10.25.218.137 with SMTP id r131mr5756779lfg.63.1454285459889;
        Sun, 31 Jan 2016 16:10:59 -0800 (PST)
Received: from localhost.localdomain (ppp109-252-26-184.pppoe.spdop.ru. [109.252.26.184])
        by smtp.gmail.com with ESMTPSA id o97sm2807958lfi.25.2016.01.31.16.10.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 31 Jan 2016 16:10:59 -0800 (PST)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Antony Pavlov <antonynpavlov@gmail.com>,
        Gabor Juhos <juhosg@openwrt.org>, Alban Bedel <albeu@free.fr>,
        devicetree@vger.kernel.org
Subject: [RFC v4 12/15] MIPS: ath79: add initial support for Dragino MS14 (Dragino 2)
Date:   Mon,  1 Feb 2016 03:10:37 +0300
Message-Id: <1454285440-18916-13-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1454285440-18916-1-git-send-email-antonynpavlov@gmail.com>
References: <1454285440-18916-1-git-send-email-antonynpavlov@gmail.com>
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51573
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

Currently only the UART, SPI-flash, USB host and LEDs are supported.

Links:

    * http://www.dragino.com/products/mother-board/item/71-ms14-p.html
    * https://wiki.openwrt.org/toh/dragino/ms14

Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
Cc: Gabor Juhos <juhosg@openwrt.org>
Cc: Alban Bedel <albeu@free.fr>
Cc: linux-mips@linux-mips.org
Cc: devicetree@vger.kernel.org
---
 arch/mips/ath79/Kconfig                 |  5 +++
 arch/mips/boot/dts/qca/Makefile         |  1 +
 arch/mips/boot/dts/qca/dragino_ms14.dts | 80 +++++++++++++++++++++++++++++++++
 3 files changed, 86 insertions(+)

diff --git a/arch/mips/ath79/Kconfig b/arch/mips/ath79/Kconfig
index 4fd53ae..2797581 100644
--- a/arch/mips/ath79/Kconfig
+++ b/arch/mips/ath79/Kconfig
@@ -77,6 +77,11 @@ choice
 	help
 	  Select a devicetree that should be built into the kernel.
 
+	config DTB_DRAGINO_MS14
+		bool "Dragino MS14 (Dragino 2)"
+		select BUILTIN_DTB
+		select SOC_AR933X
+
 	config DTB_TL_MR3020
 		bool "TL-MR3020"
 		select BUILTIN_DTB
diff --git a/arch/mips/boot/dts/qca/Makefile b/arch/mips/boot/dts/qca/Makefile
index 04fe47c..428ebac5 100644
--- a/arch/mips/boot/dts/qca/Makefile
+++ b/arch/mips/boot/dts/qca/Makefile
@@ -1,5 +1,6 @@
 # All DTBs
 dtb-$(CONFIG_DTB_TL_WR1043ND_V1)	+= ar9132_tl_wr1043nd_v1.dtb
+dtb-$(CONFIG_DTB_DRAGINO_MS14)		+= dragino_ms14.dtb
 dtb-$(CONFIG_DTB_TL_MR3020)		+= tl_mr3020.dtb
 
 obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
diff --git a/arch/mips/boot/dts/qca/dragino_ms14.dts b/arch/mips/boot/dts/qca/dragino_ms14.dts
new file mode 100644
index 0000000..774e606
--- /dev/null
+++ b/arch/mips/boot/dts/qca/dragino_ms14.dts
@@ -0,0 +1,80 @@
+/dts-v1/;
+
+#include "ar9331.dtsi"
+#include <dt-bindings/gpio/gpio.h>
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
+};
+
+&extosc {
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
