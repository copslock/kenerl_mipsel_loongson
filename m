Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Feb 2016 09:16:11 +0100 (CET)
Received: from mail-lf0-f66.google.com ([209.85.215.66]:34248 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011955AbcBIIOfA-Zw5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 9 Feb 2016 09:14:35 +0100
Received: by mail-lf0-f66.google.com with SMTP id 78so5995670lfy.1
        for <linux-mips@linux-mips.org>; Tue, 09 Feb 2016 00:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Pmf64A65Iytj2PAgS8BJmXiFvpHgzgTDFpJ9DJLSFAA=;
        b=qyUpMyUtWFzJsxjAXUj/5wBIljnnasJ6w4yxuyCIRqiHp/qxyg6YUNZCsrY81NApim
         nmR2Vp0I0z2ohVHBduSs3KRx/bGlZnUPbfKmWzWMjtKQaHF6EKD7WcEFzd4KgufCIvRB
         Fo2I9u+ygtRpP+kXwsgVNv4uaHrDs7DHXhm39REff4Lil6L2qFX61ujayElfzyYHz0DD
         X4vQRjoFUOb+rEl+0M47gNOrhAmfwiPwHet70Xwy07x1fnKGO4mV46cdCYzMKl46ArUu
         RZdCieGF9DJiyFUXPS/3bgMF2aoyPUmHgXV13LViJ5ZmRN1WMb3dMWTTT/RhSIAekne6
         uhww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Pmf64A65Iytj2PAgS8BJmXiFvpHgzgTDFpJ9DJLSFAA=;
        b=loJejKlzyRJCHIBSyVMK2yzv8tl22DparjI3CIP4H4Q9WrkQjByeqiGyfBodZntm/8
         fP//XAkNyGaKlQ7LdUPkPO4YBXLPDIII3LuvzQbwEZfSOSRLeL2zfQLxB00lfKp3zPvp
         JQbSZtN6zRMoy9wLyloMTYIXLxXuPKtji5RsJObpsRXvKfGF8iB+8UEoWJkOAdMNUH3g
         nXr0Vi0xsteX2uIlbvIIGAi3zjur8d1oUIyC7TavziWzEUWndcVba3Sm0LNxJFpN+SGg
         AmTJfyHP0F7GKLHbbVO3q3jCD/85DtA2Pmn/pU6ZlGq+aOp68vYvhUlMlPq4X6Dj9Krd
         oxsg==
X-Gm-Message-State: AG10YOTL1h+fLzUD+2sHXzCRwc+btaSz+c7iYo+o+5y4MnNCuEtLB8fuTgirgDsAXzLXTw==
X-Received: by 10.25.41.140 with SMTP id p134mr6178998lfp.15.1455005669720;
        Tue, 09 Feb 2016 00:14:29 -0800 (PST)
Received: from localhost.localdomain (ppp109-252-26-173.pppoe.spdop.ru. [109.252.26.173])
        by smtp.gmail.com with ESMTPSA id v140sm212726lfd.24.2016.02.09.00.14.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Feb 2016 00:14:29 -0800 (PST)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Marek Vasut <marex@denx.de>, Wills Wang <wills.wang@live.com>,
        Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
        Alban Bedel <albeu@free.fr>, Gabor Juhos <juhosg@openwrt.org>,
        devicetree@vger.kernel.org
Subject: [RFC v5 06/15] MIPS: ath79: add initial support for TP-LINK MR3020
Date:   Tue,  9 Feb 2016 11:13:52 +0300
Message-Id: <1455005641-7079-7-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1455005641-7079-1-git-send-email-antonynpavlov@gmail.com>
References: <1455005641-7079-1-git-send-email-antonynpavlov@gmail.com>
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51882
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
 arch/mips/boot/dts/qca/Makefile      |  1 +
 arch/mips/boot/dts/qca/tl_mr3020.dts | 99 ++++++++++++++++++++++++++++++++++++
 2 files changed, 100 insertions(+)

diff --git a/arch/mips/boot/dts/qca/Makefile b/arch/mips/boot/dts/qca/Makefile
index 14bd225..504c4b1 100644
--- a/arch/mips/boot/dts/qca/Makefile
+++ b/arch/mips/boot/dts/qca/Makefile
@@ -1,5 +1,6 @@
 # All DTBs
 dtb-$(CONFIG_ATH79)			+= ar9132_tl_wr1043nd_v1.dtb
+dtb-$(CONFIG_ATH79)			+= tl_mr3020.dtb
 
 # Force kbuild to make empty built-in.o if necessary
 obj-				+= dummy.o
diff --git a/arch/mips/boot/dts/qca/tl_mr3020.dts b/arch/mips/boot/dts/qca/tl_mr3020.dts
new file mode 100644
index 0000000..2a1b296
--- /dev/null
+++ b/arch/mips/boot/dts/qca/tl_mr3020.dts
@@ -0,0 +1,99 @@
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
2.7.0
