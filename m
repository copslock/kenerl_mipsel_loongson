Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Feb 2016 09:18:31 +0100 (CET)
Received: from mail-lf0-f67.google.com ([209.85.215.67]:35627 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011117AbcBIIOoCTU65 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 9 Feb 2016 09:14:44 +0100
Received: by mail-lf0-f67.google.com with SMTP id j99so5995494lfi.2
        for <linux-mips@linux-mips.org>; Tue, 09 Feb 2016 00:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cb60Ly1aNCvYKoWwDe5c8rDMcdF9lw9Mvw9yequxbvo=;
        b=u3fvR0T4Sse8i+34qzGromvHh8ZPLySheZB2c45FQJj2Q3MijU6OyO+2D7/PjwKlfQ
         HQnbVZwwKLmcj3hG5ovAniunoRrU2AYcnAEvpgcamr5mpV4Yf6dRF/PaCO4FEGaQZSmO
         KTnwihrlVUKQ2iGwoVrfy91qEbd2MD0GkQPu4whUOzBg3w7Yj5T8gogLOWogNnjcNqHC
         CflUc+ofHun22pqk2k9ANsKTTt2nqeL/tXrDOQfyXXAUncfgyh1YzhrQXhONMIUZ2kqO
         FoBAPslZ6tNRIeUggGnt6I4KQMxBuCQFOAgkRZVH27Qts3qQlgsAyX96n763WNRRb9/K
         zdCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cb60Ly1aNCvYKoWwDe5c8rDMcdF9lw9Mvw9yequxbvo=;
        b=Nr1PcLCUNA9e4SQZBMsRttt4mTRwUmrhkEzCkbq664S6l7w2YgVmgq54bWF7F1uzjc
         63FcZ+aoYANtNhIisqsgiUFzu+Utjnpwjhb5zKOzOqjSb96ssybQPDgQ+Gpnb+munG0h
         ItvHRR/AjELX4X37srhj9IxZrFpSv2OldN1IZc7qdOBKQSrE6Vk3JWjD/xs1wvC88rkX
         tgjXlHa95iegyajfqB9Tvh2+5BNXtRegYlrf+UupDyZWEKFUCDtlASOT9DydoV7KTUrq
         GMLUHwb+E/2XijIc8u4lqqZqlQrxVyJ3nCTeL8tEIZSeE5QqoUEAnCROzVOOma4OHIut
         atcQ==
X-Gm-Message-State: AG10YOQdDjdfXV2o5XBaU8mgkbcJo0aJnpnXZKtNP4hppa/NEQB66p1BwRUN65XYBYV2Zw==
X-Received: by 10.25.4.210 with SMTP id 201mr13592964lfe.47.1455005678765;
        Tue, 09 Feb 2016 00:14:38 -0800 (PST)
Received: from localhost.localdomain (ppp109-252-26-173.pppoe.spdop.ru. [109.252.26.173])
        by smtp.gmail.com with ESMTPSA id v140sm212726lfd.24.2016.02.09.00.14.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Feb 2016 00:14:38 -0800 (PST)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Marek Vasut <marex@denx.de>, Wills Wang <wills.wang@live.com>,
        Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
        Alban Bedel <albeu@free.fr>, Daan Pape <daan@dptechnics.com>,
        devicetree@vger.kernel.org
Subject: [RFC v5 14/15] MIPS: ath79: add DPT-Module support
Date:   Tue,  9 Feb 2016 11:14:00 +0300
Message-Id: <1455005641-7079-15-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1455005641-7079-1-git-send-email-antonynpavlov@gmail.com>
References: <1455005641-7079-1-git-send-email-antonynpavlov@gmail.com>
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51890
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

  * https://dptechnics.com/shop/index.php?route=product/product&path=59&product_id=50
  * https://dptechnics.com/shop/index.php?route=product/product&path=59&product_id=63

Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
Cc: Daan Pape <daan@dptechnics.com>
Cc: linux-mips@linux-mips.org
Cc: devicetree@vger.kernel.org
---
 arch/mips/boot/dts/qca/Makefile       |  1 +
 arch/mips/boot/dts/qca/dpt_module.dts | 77 +++++++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+)

diff --git a/arch/mips/boot/dts/qca/Makefile b/arch/mips/boot/dts/qca/Makefile
index ca2ecb8..7d4bf43 100644
--- a/arch/mips/boot/dts/qca/Makefile
+++ b/arch/mips/boot/dts/qca/Makefile
@@ -1,5 +1,6 @@
 # All DTBs
 dtb-$(CONFIG_ATH79)			+= ar9132_tl_wr1043nd_v1.dtb
+dtb-$(CONFIG_ATH79)			+= dpt_module.dtb
 dtb-$(CONFIG_ATH79)			+= dragino_ms14.dtb
 dtb-$(CONFIG_ATH79)			+= omega.dtb
 dtb-$(CONFIG_ATH79)			+= tl_mr3020.dtb
diff --git a/arch/mips/boot/dts/qca/dpt_module.dts b/arch/mips/boot/dts/qca/dpt_module.dts
new file mode 100644
index 0000000..f4ccb74
--- /dev/null
+++ b/arch/mips/boot/dts/qca/dpt_module.dts
@@ -0,0 +1,77 @@
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+
+#include "ar9331.dtsi"
+
+/ {
+	model = "DPTechnics DPT-Module";
+	compatible = "dptechnics,dpt-module";
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
+			label = "dpt-module:green:system";
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
+			gpios = <&gpio 11 GPIO_ACTIVE_LOW>;
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
