Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Jan 2016 23:36:14 +0100 (CET)
Received: from mail-lf0-f44.google.com ([209.85.215.44]:35682 "EHLO
        mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011206AbcAUWerY562N (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 21 Jan 2016 23:34:47 +0100
Received: by mail-lf0-f44.google.com with SMTP id c192so36081447lfe.2
        for <linux-mips@linux-mips.org>; Thu, 21 Jan 2016 14:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QEXLYfEJWumLxnU94uy8EaEQE5vLpzSboxn8UY9JYMs=;
        b=X/WakbRIicOD7fsQ5ugITRbPuGTxhNLK+1GBF5FZW4usayIeXivIuNHVXzpiLEudR5
         fLuW1qGJuKL+918DYU2Z6kmAcfIWywMqJ1eZqNw3zPQlOoNibK4d5D6zaUntJktKVSZ7
         Atd+2vlR+8mB3O/RkJcr22Z/QPJUSC4297SgixqpWSHs2asJU4IciRiTLRGszm5CGcsO
         9EwYv+/LOjQ5n4JCYvpZ8UZfjfxoKU5K7K4I5iLABMRNEnuQWp511KVA/lcp9R1dsD7R
         FK1hcRp7W+MZcuxLoFDVHkCVgIrWNMRgCZMWXT/kRg/1Pihl7+c1ze6eFzI6Jg2Rv4nK
         QJNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QEXLYfEJWumLxnU94uy8EaEQE5vLpzSboxn8UY9JYMs=;
        b=FQbfwgc8Phn/vzn3T0XUYg9Q0YGSMQspSpudThV9HAXfNpALiMHkrF8UC3MHfw+5Sl
         Ud4ZSV4NsUpoSVOb4t/kYXGfLyj5OP8+SjymY34P87x8SX7YjTE/7+m5SLFcnGPdBhtV
         ohxm7CF+sNEFhGpLTCT6X2c5d+ltgVfmA6WcBmQCjEYg5YDaTbGHYc97/rZshYTQs7bu
         xgUJDbYEWfMUC4aQU+rtMBU6ov7s5EZZfSPB1vN6JKxbPZldWijNGEpSuFtVpQaAyh0i
         cleTfqt5DcLNU1LQnXJP2YnYCp+X6P4PrP1A7f6YaGrzbmuymuIP6G0hI1uQZuLDnUlY
         Htjg==
X-Gm-Message-State: AG10YORO701tMVei1t2M4NvY3bYU2bXagKG311a9csU1PDGtxRYqabrSzyfeFleyjO9IzQ==
X-Received: by 10.25.157.74 with SMTP id g71mr12921722lfe.80.1453415681248;
        Thu, 21 Jan 2016 14:34:41 -0800 (PST)
Received: from localhost.localdomain (ppp109-252-26-184.pppoe.spdop.ru. [109.252.26.184])
        by smtp.gmail.com with ESMTPSA id j130sm319217lfe.23.2016.01.21.14.34.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 21 Jan 2016 14:34:40 -0800 (PST)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Antony Pavlov <antonynpavlov@gmail.com>,
        Gabor Juhos <juhosg@openwrt.org>, Alban Bedel <albeu@free.fr>,
        devicetree@vger.kernel.org
Subject: [RFC v2 6/7] MIPS: ath79: add initial support for Dragino MS14 (Dragino 2)
Date:   Fri, 22 Jan 2016 01:34:23 +0300
Message-Id: <1453415664-20307-7-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1453415664-20307-1-git-send-email-antonynpavlov@gmail.com>
References: <1453415664-20307-1-git-send-email-antonynpavlov@gmail.com>
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51288
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
 arch/mips/boot/dts/qca/dragino_ms14.dts | 73 +++++++++++++++++++++++++++++++++
 3 files changed, 79 insertions(+)

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
index ae47e35..dfba4d2 100644
--- a/arch/mips/boot/dts/qca/Makefile
+++ b/arch/mips/boot/dts/qca/Makefile
@@ -2,6 +2,7 @@
 dtb-$(CONFIG_ATH79)			+= ar9132_tl_wr1043nd_v1.dtb
 
 # Select a DTB to build in the kernel
+obj-$(CONFIG_DTB_DRAGINO_MS14)		+= dragino_ms14.dtb.o
 obj-$(CONFIG_DTB_TL_MR3020)		+= tl_mr3020.dtb.o
 obj-$(CONFIG_DTB_TL_WR1043ND_V1)	+= ar9132_tl_wr1043nd_v1.dtb.o
 
diff --git a/arch/mips/boot/dts/qca/dragino_ms14.dts b/arch/mips/boot/dts/qca/dragino_ms14.dts
new file mode 100644
index 0000000..ec4dc64
--- /dev/null
+++ b/arch/mips/boot/dts/qca/dragino_ms14.dts
@@ -0,0 +1,73 @@
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
2.6.2
