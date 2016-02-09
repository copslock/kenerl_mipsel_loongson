Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Feb 2016 09:17:22 +0100 (CET)
Received: from mail-lf0-f66.google.com ([209.85.215.66]:36705 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012056AbcBIIOkBs-l5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 9 Feb 2016 09:14:40 +0100
Received: by mail-lf0-f66.google.com with SMTP id h198so5993303lfh.3
        for <linux-mips@linux-mips.org>; Tue, 09 Feb 2016 00:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F17zWfMVb3pJeiUVvj66yl0MqMpXRr1H19pFu++4pjg=;
        b=zIEKmHRgfniKkP31WIRMJLA6U2tIaqvYo8sQSRxRN1nLdvhlc7/AW//H2UB7N7I7+E
         n8x+Iw8j6ogK0Xfygt10lrlxN1/9rKgRZsDADNtGk7sL8nF/CgCbk7ivrFiU9U+3itjh
         ZaCIs+0TnyjKZzik9xqJcpaoz1nV/Q4OrNiTpWGhP3gc9rIdxWtpcwDlq3LaYAttzWrO
         Xg4hcWNUc8Ov2rbCSwAB7JcSaRilGsLSImR49ZtM1JRUgzuKixIUjM3WIsZHc6cKN1DN
         Uab1DTDL6nux0JBRvZIlOKvVsjOhVupe9OPmpC2Rspe2QQniVQxcBFSzpOnsQtFaEHnt
         BvGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=F17zWfMVb3pJeiUVvj66yl0MqMpXRr1H19pFu++4pjg=;
        b=L5ye1zwfFQARTcA1U+tf/h/BMBHNhszjVebdFYi3Nh3al5VshR3YEdkAJLNlxhD3XX
         L+KgTjfvClx2pVa6hjRwXWag14Ir4MCbw7nbuJDYIPBydXoBGuZ1WWwt05wpt1XWbBxy
         aEinGuLH1i9Ygbry+ObGa4FP5P7h5zIOPSXt4MBtlWDfd1A9hqZV6jgwIw8x3dpThsCn
         gWKHdURFsZYUOHVQGvshYrT76FNGvbVVryafoogzm/dYfWYM2n2Mlsr7XZU+nzpUDXLk
         5BD7CExytaY4oUDhdUUP4tqkx40u1sb+XEcpEZA6L2SGrlVmbQI+cDjjZFnQdOjrb4iG
         OXYQ==
X-Gm-Message-State: AG10YOR4nRzkQQuN+GoyNdQouV3Y/diY5yFFo0UX8TZhrS8ogfIoyoyJnOIQMVaHRPbBog==
X-Received: by 10.25.25.142 with SMTP id 136mr13548735lfz.42.1455005674756;
        Tue, 09 Feb 2016 00:14:34 -0800 (PST)
Received: from localhost.localdomain (ppp109-252-26-173.pppoe.spdop.ru. [109.252.26.173])
        by smtp.gmail.com with ESMTPSA id v140sm212726lfd.24.2016.02.09.00.14.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Feb 2016 00:14:34 -0800 (PST)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Marek Vasut <marex@denx.de>, Wills Wang <wills.wang@live.com>,
        Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
        Alban Bedel <albeu@free.fr>, Gabor Juhos <juhosg@openwrt.org>,
        devicetree@vger.kernel.org
Subject: [RFC v5 10/15] MIPS: ath79: add initial support for Dragino MS14 (Dragino 2)
Date:   Tue,  9 Feb 2016 11:13:56 +0300
Message-Id: <1455005641-7079-11-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1455005641-7079-1-git-send-email-antonynpavlov@gmail.com>
References: <1455005641-7079-1-git-send-email-antonynpavlov@gmail.com>
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51886
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
 arch/mips/boot/dts/qca/Makefile         |   1 +
 arch/mips/boot/dts/qca/dragino_ms14.dts | 101 ++++++++++++++++++++++++++++++++
 2 files changed, 102 insertions(+)

diff --git a/arch/mips/boot/dts/qca/Makefile b/arch/mips/boot/dts/qca/Makefile
index 504c4b1..e949cff 100644
--- a/arch/mips/boot/dts/qca/Makefile
+++ b/arch/mips/boot/dts/qca/Makefile
@@ -1,5 +1,6 @@
 # All DTBs
 dtb-$(CONFIG_ATH79)			+= ar9132_tl_wr1043nd_v1.dtb
+dtb-$(CONFIG_ATH79)			+= dragino_ms14.dtb
 dtb-$(CONFIG_ATH79)			+= tl_mr3020.dtb
 
 # Force kbuild to make empty built-in.o if necessary
diff --git a/arch/mips/boot/dts/qca/dragino_ms14.dts b/arch/mips/boot/dts/qca/dragino_ms14.dts
new file mode 100644
index 0000000..44abb77
--- /dev/null
+++ b/arch/mips/boot/dts/qca/dragino_ms14.dts
@@ -0,0 +1,101 @@
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
