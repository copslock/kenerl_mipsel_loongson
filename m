Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Feb 2016 01:13:52 +0100 (CET)
Received: from mail-lf0-f50.google.com ([209.85.215.50]:35231 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011944AbcBAALDW0KhA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Feb 2016 01:11:03 +0100
Received: by mail-lf0-f50.google.com with SMTP id l143so18960064lfe.2
        for <linux-mips@linux-mips.org>; Sun, 31 Jan 2016 16:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=n+LQkqtRdjK646HwtkR4R+OQh1en058RdLFgYsgtq2I=;
        b=LP/jYKT67uBucFtcdQyJ7UDnd3zmZNC9H7TEavstDNwE3Ci6UskriMU/SwqoKGtpDG
         ChNLSrL3/UNT+Ad91jv3OeYfypkZ9razh/7OaDG+2iwS05Lt3cL31NVHHEtYJ6nMhFnQ
         SKHD4fHaAO+l91CI5hSKD6StUaWuRbXuqwSRfqIICKMM0dl8trlAZd0/id7V+Wb2O6SF
         N9j6vnC0oLG0uqVLY03OemILSrBfF/wXcZLR90cV4dskkkG3jUR0HjTRwY6DMbIG8KQc
         qELZbe+kk4do91Xlob+tzhht3hHUfB+FwLZwMF+xp9urCtDmNjZAHykaFMG5oow9pEpB
         KglQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=n+LQkqtRdjK646HwtkR4R+OQh1en058RdLFgYsgtq2I=;
        b=ZzOARyPscWpqfHXTbcdpAvznbDn6FYwAkptJNsMszBfVmm4M2179EYSSsGA1pUwr+1
         pMEpHEsiq23C9+izzmCWT8UThLd+OWJgrOscFXdHjAvtp3lA5vPdiQH4wcqZa8nO6d0G
         jFMjeZ7Ivdnx0l4QrXQaAFFQ1QZAhymPnLf0IOOQn1cpxilHKjwTX2vEzgK5pEHyxND4
         630xZMwNRvuIzNPy//dcFvtdbckGPXOrCOMjW9cm0nBkI/RDstTDeKyiTjrTUTIhkpqJ
         1yDjmMZh6S0sm/yt4nXnfu+nvKbQEyRL7afHRSRM78y2LoRbyB3E74bo7d5rWdrLICVz
         DCWg==
X-Gm-Message-State: AG10YOQrFrWFwshCRAHspvhTKlmaz3KXje+DtNITdrrwC/o4vhuBeKlupGFpYSOdKe0S/Q==
X-Received: by 10.25.0.193 with SMTP id 184mr4573066lfa.132.1454285458078;
        Sun, 31 Jan 2016 16:10:58 -0800 (PST)
Received: from localhost.localdomain (ppp109-252-26-184.pppoe.spdop.ru. [109.252.26.184])
        by smtp.gmail.com with ESMTPSA id o97sm2807958lfi.25.2016.01.31.16.10.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 31 Jan 2016 16:10:57 -0800 (PST)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Antony Pavlov <antonynpavlov@gmail.com>,
        Gabor Juhos <juhosg@openwrt.org>, Alban Bedel <albeu@free.fr>,
        devicetree@vger.kernel.org
Subject: [RFC v4 10/15] MIPS: ath79: add initial support for TP-LINK MR3020
Date:   Mon,  1 Feb 2016 03:10:35 +0300
Message-Id: <1454285440-18916-11-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1454285440-18916-1-git-send-email-antonynpavlov@gmail.com>
References: <1454285440-18916-1-git-send-email-antonynpavlov@gmail.com>
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51571
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
index 244329e..04fe47c 100644
--- a/arch/mips/boot/dts/qca/Makefile
+++ b/arch/mips/boot/dts/qca/Makefile
@@ -1,5 +1,6 @@
 # All DTBs
 dtb-$(CONFIG_DTB_TL_WR1043ND_V1)	+= ar9132_tl_wr1043nd_v1.dtb
+dtb-$(CONFIG_DTB_TL_MR3020)		+= tl_mr3020.dtb
 
 obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
 
diff --git a/arch/mips/boot/dts/qca/tl_mr3020.dts b/arch/mips/boot/dts/qca/tl_mr3020.dts
new file mode 100644
index 0000000..ac9f3dc
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
