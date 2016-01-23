Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Jan 2016 21:20:28 +0100 (CET)
Received: from mail-lb0-f178.google.com ([209.85.217.178]:34432 "EHLO
        mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014855AbcAWUR5I5Nld (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 23 Jan 2016 21:17:57 +0100
Received: by mail-lb0-f178.google.com with SMTP id cl12so56907207lbc.1
        for <linux-mips@linux-mips.org>; Sat, 23 Jan 2016 12:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FdiAryVWJae1T4k8t25EdfDCqTnzkVN3U9x978qfnnE=;
        b=zlU6PXR1+T9o46FmiB3ztQ0otc9pagNqW5j4ht462mPzN7fjk7K7b9XaSgeof8fbfg
         7oLlFIuVT4Aff3A9KWGQ+j57dNtVgwN0sFPN7izmZsSCo/RoYcvX4s7vDkA65FkeMxw3
         dx2gVOscQKaxjeB5pxZ4gS+psMoRyCwOjoTb3tLTlDDN81OaVxjYBx2FbzzEXKajd5FY
         4s/L31Gc7vb3WHwLdUNRjBktdweNtAnb0vJcz5w7zeyoY3msvl1xn8EivNgw2uFDeJ2U
         iqh1f0WefDw7Wj6i8VOeyCYdj77m55CNXcR+h3kXjklEy1Tdd0yDQFwrdXXh9p5fCPp8
         6RVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FdiAryVWJae1T4k8t25EdfDCqTnzkVN3U9x978qfnnE=;
        b=kMvPaz5vRoKtciedco3stZzW8SFNku86qPEcYmplzvGM10uxMoJpP9AzdtkePqjn3j
         QZhMl3Kd8rNAOddWYS9Ez5nOoKojKZNs6N9c2mrSOEzzMVJR+8A98iGM11LEgh/7Sla7
         39kqCxaxSODA2zqDoL3xj5/L+JJyMRlNy2hcmnTvE4ylDfA06Z5D9v2lqlpkzvlIoIev
         91Y/RSflyFN4fQKf8cex9OiT5TCxERI5F53Ek9xMXw1Ala/Q0BYBIrdr34G0GIH1nHRk
         l5UTIlLPcyDCVfOoh4h9XjHnD6FF6HzcEJQ3HoSMBy1NWxDz0d8/2ISyMphqeteHVUc3
         omUg==
X-Gm-Message-State: AG10YOST66U0bfjTqcdHOYouaZ7rlvba3y+wMUxVSxN5oHcOltcScMaWO5ZuUyPcBgy5mA==
X-Received: by 10.112.172.200 with SMTP id be8mr3480904lbc.78.1453580271835;
        Sat, 23 Jan 2016 12:17:51 -0800 (PST)
Received: from localhost.localdomain (ppp109-252-26-184.pppoe.spdop.ru. [109.252.26.184])
        by smtp.gmail.com with ESMTPSA id o82sm1664186lfo.47.2016.01.23.12.17.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 23 Jan 2016 12:17:51 -0800 (PST)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Antony Pavlov <antonynpavlov@gmail.com>,
        Gabor Juhos <juhosg@openwrt.org>, Alban Bedel <albeu@free.fr>,
        devicetree@vger.kernel.org
Subject: [RFC v3 09/14] MIPS: ath79: add initial support for TP-LINK MR3020
Date:   Sat, 23 Jan 2016 23:17:26 +0300
Message-Id: <1453580251-2341-10-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1453580251-2341-1-git-send-email-antonynpavlov@gmail.com>
References: <1453580251-2341-1-git-send-email-antonynpavlov@gmail.com>
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51335
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
2.6.2
