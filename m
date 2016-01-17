Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Jan 2016 00:58:00 +0100 (CET)
Received: from mail-lb0-f177.google.com ([209.85.217.177]:36669 "EHLO
        mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010228AbcAQX5Lq01YD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 Jan 2016 00:57:11 +0100
Received: by mail-lb0-f177.google.com with SMTP id oh2so339170771lbb.3
        for <linux-mips@linux-mips.org>; Sun, 17 Jan 2016 15:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rP/17juRxa+pa+JVCSj/HIQvSORmpGtX/ks05qSF2BA=;
        b=TGto3r8VXwts2R5+x7buBQRmTZejfqrTUdMV8KA56BhxnF0NnRAzpoQ4no77l1gTHv
         Nn/3jF/48b69UJAHXTnjSe6Cnfi5Kd7xy4QuWCyV6nVbRghk+TvbMS3+uppaiQxx37WN
         q2T09UsUq2sjTatDWtiXjL8kb9T+jfFRdAo8WdyrjsmZgiJ10yJx3h6AXEN5/TDDHiQd
         nPW2/R2MjkPe4fVesVmwFy/F9SoRWhumZyMRdWFOwwI/KjeuxHi+H1I1FwalWfe6W7Cl
         RA2ImPsFAlZmD3286H+mukGahoXh7CS8HsDE+w6QxQz8GLVztg3u2N6z/Zxul999NLuM
         0YIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rP/17juRxa+pa+JVCSj/HIQvSORmpGtX/ks05qSF2BA=;
        b=YYZejSp5HA7LH80k7caoeKTYFzYkCHhBqF4Wnf3UkEY1biwrFGm8J5lZ6ipsSATtjS
         OIAhb5ICQcLiKkN4NY3qNCzlyDKYc18dstC5ddu6UPdX6G9gT55nPrFSUAy5Pk20Fu86
         /mG8fUVMuiQUdx3m04B/r9DCUEmCVN6LAfpJyUQwxaSudQ9F9D60Yr9J3BsRKmPB5xAy
         +VQbhEwmYt3q1eF+f0KAoJnYLoP1jGNxWY4qo/F9IgDIGc3pLKscBhPGvcPIPgvNEBXP
         9sizJmg6kWOxo5KxRpUxy95xiIpDM85CwfR2bHMvacGmqXKXWTPZ/VlDbsjvFiIy8Smg
         NOtw==
X-Gm-Message-State: ALoCoQm3tFOLEx4ohldwe8BA+yRCgXfK5K2dEGVi7LqCA7rwFVju/SMz8AwqkAdo38Ca1RP8DvLWZFNpiS3zOd/6RKNsruhDkA==
X-Received: by 10.112.182.8 with SMTP id ea8mr7246714lbc.114.1453075026494;
        Sun, 17 Jan 2016 15:57:06 -0800 (PST)
Received: from localhost.localdomain (ppp109-252-26-184.pppoe.spdop.ru. [109.252.26.184])
        by smtp.gmail.com with ESMTPSA id xe8sm2783445lbb.41.2016.01.17.15.57.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 17 Jan 2016 15:57:06 -0800 (PST)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Yegor Yefremov <yegorslists@googlemail.com>,
        Antony Pavlov <antonynpavlov@gmail.com>,
        Gabor Juhos <juhosg@openwrt.org>, Alban Bedel <albeu@free.fr>,
        devicetree@vger.kernel.org
Subject: [RFC 3/4] MIPS: ath79: add initial support for TP-LINK MR3020
Date:   Mon, 18 Jan 2016 02:56:26 +0300
Message-Id: <1453074987-3356-4-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1453074987-3356-1-git-send-email-antonynpavlov@gmail.com>
References: <1453074987-3356-1-git-send-email-antonynpavlov@gmail.com>
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51183
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
 arch/mips/boot/dts/qca/tl_mr3020.dts | 68 ++++++++++++++++++++++++++++++++++++
 3 files changed, 74 insertions(+)

diff --git a/arch/mips/ath79/Kconfig b/arch/mips/ath79/Kconfig
index 13c04cf..bbd7a1f 100644
--- a/arch/mips/ath79/Kconfig
+++ b/arch/mips/ath79/Kconfig
@@ -81,6 +81,11 @@ choice
 		bool "TL-WR1043ND Version 1"
 		select BUILTIN_DTB
 		select SOC_AR913X
+
+	config DTB_TL_MR3020
+		bool "TL-MR3020"
+		select BUILTIN_DTB
+		select SOC_AR933X
 endchoice
 
 endmenu
diff --git a/arch/mips/boot/dts/qca/Makefile b/arch/mips/boot/dts/qca/Makefile
index 2d61455d..8c96d67 100644
--- a/arch/mips/boot/dts/qca/Makefile
+++ b/arch/mips/boot/dts/qca/Makefile
@@ -3,6 +3,7 @@ dtb-$(CONFIG_ATH79)			+= ar9132_tl_wr1043nd_v1.dtb
 
 # Select a DTB to build in the kernel
 obj-$(CONFIG_DTB_TL_WR1043ND_V1)	+= ar9132_tl_wr1043nd_v1.dtb.o
+obj-$(CONFIG_DTB_TL_MR3020)		+= tl_mr3020.dtb.o
 
 # Force kbuild to make empty built-in.o if necessary
 obj-				+= dummy.o
diff --git a/arch/mips/boot/dts/qca/tl_mr3020.dts b/arch/mips/boot/dts/qca/tl_mr3020.dts
new file mode 100644
index 0000000..571989b
--- /dev/null
+++ b/arch/mips/boot/dts/qca/tl_mr3020.dts
@@ -0,0 +1,68 @@
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
+	spiflash: m25p80@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "m25p80";
+		spi-max-frequency = <104000000>;
+		reg = <0>;
+	};
+};
-- 
2.6.2
