Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Feb 2016 09:17:58 +0100 (CET)
Received: from mail-lf0-f52.google.com ([209.85.215.52]:36828 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012129AbcBIIOl7C6u5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 9 Feb 2016 09:14:41 +0100
Received: by mail-lf0-f52.google.com with SMTP id 78so110700501lfy.3
        for <linux-mips@linux-mips.org>; Tue, 09 Feb 2016 00:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1ananaEIO6SNic3mB5b7UJDRfkik/9HF9urm2bleogY=;
        b=gsIp27DxZWn5UnVL6+xJbyW1Apd5X6xQIpDrdj1Squ014is8ewuiDx23Lj5o1wQZVX
         Wag8NeOo8XdS+irjtXgOi6cWNr4nyJwmF1XyMYvAMHy74iHYakjjV1foghOjQYYyeqXm
         YbU/gI7sufzyK4WnifKutWgg306IuQ3IaVlH6s6rzL5DnchddJD9cQcvODiB0jgNbd8s
         Es8WdTBOHH7egmKV0FdsvnEa/VVpqLruN/eNgEF+P8fflPTXiMSJ9DzlIUavOP58MSc9
         btBVkgXY6t+NrFijhz0tHJM7ePycGxqCcV0j0ZIzxVzzdYpmulfajZOXE4QX8QAvUyqr
         0z0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1ananaEIO6SNic3mB5b7UJDRfkik/9HF9urm2bleogY=;
        b=HzvdchAt+pFxFWxrNsQATKMr38PNw9FASamcnMRdmijRxR9uGJY4+VtRSl2eRuIKdU
         G+jKwDz3zeDVIl65t1ZuD9jSuabAhmcXzUxysgvTzGMy47pGA3eNE3ll4W9SHsKy33XZ
         YdY3h+50YUxAgYKt/GXYh/LDXOUTEbzHthYnDXq6CzipwfXB9dltMHrZfwvbdJVvc9Dh
         cxfwTYtlNkh8Kb68+SXpH/V63RepvocK3zw7X0CiSV3cFHSJjRNEpTQb+Rf+JDckrF46
         KF7iXyqliQUeoTVdaFgRs41i0Mr2RBYdN7sKTZc0dI4Wr8NbDO8q+lDWARnMqNwrZ/0t
         w+7w==
X-Gm-Message-State: AG10YOQpn3Qlio9yTUjKg7aEe6wOeOoKl26MMpcKzT5+nb9QHCyyTcllno560xHZJUe25Q==
X-Received: by 10.25.218.137 with SMTP id r131mr10839529lfg.63.1455005676737;
        Tue, 09 Feb 2016 00:14:36 -0800 (PST)
Received: from localhost.localdomain (ppp109-252-26-173.pppoe.spdop.ru. [109.252.26.173])
        by smtp.gmail.com with ESMTPSA id v140sm212726lfd.24.2016.02.09.00.14.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Feb 2016 00:14:36 -0800 (PST)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Marek Vasut <marex@denx.de>, Wills Wang <wills.wang@live.com>,
        Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
        Alban Bedel <albeu@free.fr>, Gabor Juhos <juhosg@openwrt.org>,
        "L . D . Pinney" <ldpinney@gmail.com>, Boken Lin <bl@onion.io>,
        Jacky Huang <huangfangcheng@163.com>,
        devicetree@vger.kernel.org
Subject: [RFC v5 12/15] MIPS: ath79: add initial support for Onion Omega
Date:   Tue,  9 Feb 2016 11:13:58 +0300
Message-Id: <1455005641-7079-13-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1455005641-7079-1-git-send-email-antonynpavlov@gmail.com>
References: <1455005641-7079-1-git-send-email-antonynpavlov@gmail.com>
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51888
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

Please see https://onion.io/omega for details.

Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
Cc: Gabor Juhos <juhosg@openwrt.org>
Cc: Alban Bedel <albeu@free.fr>
Cc: L. D. Pinney <ldpinney@gmail.com>
Cc: Boken Lin <bl@onion.io>
Cc: Jacky Huang <huangfangcheng@163.com>
Cc: linux-mips@linux-mips.org
Cc: devicetree@vger.kernel.org
---
 arch/mips/boot/dts/qca/Makefile  |  1 +
 arch/mips/boot/dts/qca/omega.dts | 77 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+)

diff --git a/arch/mips/boot/dts/qca/Makefile b/arch/mips/boot/dts/qca/Makefile
index e949cff..ca2ecb8 100644
--- a/arch/mips/boot/dts/qca/Makefile
+++ b/arch/mips/boot/dts/qca/Makefile
@@ -1,6 +1,7 @@
 # All DTBs
 dtb-$(CONFIG_ATH79)			+= ar9132_tl_wr1043nd_v1.dtb
 dtb-$(CONFIG_ATH79)			+= dragino_ms14.dtb
+dtb-$(CONFIG_ATH79)			+= omega.dtb
 dtb-$(CONFIG_ATH79)			+= tl_mr3020.dtb
 
 # Force kbuild to make empty built-in.o if necessary
diff --git a/arch/mips/boot/dts/qca/omega.dts b/arch/mips/boot/dts/qca/omega.dts
new file mode 100644
index 0000000..f4a7ed0
--- /dev/null
+++ b/arch/mips/boot/dts/qca/omega.dts
@@ -0,0 +1,77 @@
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+
+#include "ar9331.dtsi"
+
+/ {
+	model = "Onion Omega";
+	compatible = "onion,omega";
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
+		system {
+			label = "onion:amber:system";
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
+			label = "reset";
+			linux,code = <KEY_RESTART>;
+			gpios = <&gpio 11 GPIO_ACTIVE_HIGH>;
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
+	/* Winbond 25Q128FVSG SPI flash */
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
