Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Mar 2016 04:39:41 +0100 (CET)
Received: from mail-lf0-f67.google.com ([209.85.215.67]:32992 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007998AbcCQDfAaxdXp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Mar 2016 04:35:00 +0100
Received: by mail-lf0-f67.google.com with SMTP id l83so2209241lfd.0
        for <linux-mips@linux-mips.org>; Wed, 16 Mar 2016 20:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6SpxopKbZNb599wgnN3GfXSFTpJaeNSBzMLMsgcfjWc=;
        b=vyDANvShk/v8hA9sXCzS4Mtzi3ivS1WJgqnQj2y64JDAC7qxrL0/OJn2aRi8vH432P
         r20bWuycePNyLdM841H9ds7O8dwmd0ERtD/8XvYqafDyjTqG54PywspLLTrol+IxJqSO
         25FD/LF0XYt/yVT1mac4tq6w9i0nFjBe8fCZ7TvHu3sKpnRKxZkXfuyZEIdjRi7D9BcT
         G4rfRyW0f731fOQrXKwpZX7UEQ365gHzlEQ6azhYedKxwBlVZLoFvfc4uei+vKKhu596
         gd+iOT3Gj1ETElkcCBV86Q38Abnofoa50BiY6KisvMVPnE+jk2xN4l7cIPVa59Sf8kv1
         lQ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6SpxopKbZNb599wgnN3GfXSFTpJaeNSBzMLMsgcfjWc=;
        b=lktQ5V65WlBt4TEqW7I2zviJSmeTeXIe1i8xM1w34QoEXSwC4hYB/A4znjlEfjN/DU
         WKUlgzwX3wSGFcqV/kLJE0vddx5iVlKyDzILj6hayeMSOXMJMRPrkxT6cCRBNQCTp9Yr
         CjlwpTU/IDBOwnEBEFm2afNUqrNUQ5fZH2pm64muxcxVW2PWSJJJcwsTgdjDFpWsK0sM
         NYyNGOGGC0C7f2ibLmjHK4w6SSDx5rJwLsWBbSsoXiCgxjJhZhp+RY1swtqhELg75t/W
         uGMnYenPCkC4JSm4WtYTAPNnfGtlKvnFHVVxb0sRRbLXH9czqt+ffTwK8ugVbd9pXe1D
         vscQ==
X-Gm-Message-State: AD7BkJJsgyF/rH19BJ1rfrGjkRP2pXU7DCURnEE7WNUzj7/VSx5e2qaYBglP7NXneJFXWQ==
X-Received: by 10.25.37.135 with SMTP id l129mr2834163lfl.160.1458185695219;
        Wed, 16 Mar 2016 20:34:55 -0700 (PDT)
Received: from localhost.localdomain (ppp109-252-26-173.pppoe.spdop.ru. [109.252.26.173])
        by smtp.gmail.com with ESMTPSA id gp6sm1026698lbc.44.2016.03.16.20.34.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Mar 2016 20:34:54 -0700 (PDT)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Daan Pape <daan@dptechnics.com>, devicetree@vger.kernel.org
Subject: [PATCH v2 18/18] MIPS: ath79: add initial support for DPT-Module
Date:   Thu, 17 Mar 2016 06:34:25 +0300
Message-Id: <1458185665-4521-19-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1458185665-4521-1-git-send-email-antonynpavlov@gmail.com>
References: <1458185665-4521-1-git-send-email-antonynpavlov@gmail.com>
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52632
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
  * GPIO key and LED.

Links:

  * https://dptechnics.com/shop/index.php?route=product/product&path=59&product_id=50
  * https://dptechnics.com/shop/index.php?route=product/product&path=59&product_id=63

Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
Cc: Daan Pape <daan@dptechnics.com>
Cc: linux-mips@linux-mips.org
Cc: devicetree@vger.kernel.org
---
 arch/mips/boot/dts/qca/Makefile              |  1 +
 arch/mips/boot/dts/qca/ar9331_dpt_module.dts | 78 ++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+)

diff --git a/arch/mips/boot/dts/qca/Makefile b/arch/mips/boot/dts/qca/Makefile
index dc0b5a4..63a9ddf 100644
--- a/arch/mips/boot/dts/qca/Makefile
+++ b/arch/mips/boot/dts/qca/Makefile
@@ -1,5 +1,6 @@
 # All DTBs
 dtb-$(CONFIG_ATH79)			+= ar9132_tl_wr1043nd_v1.dtb
+dtb-$(CONFIG_ATH79)			+= ar9331_dpt_module.dtb
 dtb-$(CONFIG_ATH79)			+= ar9331_dragino_ms14.dtb
 dtb-$(CONFIG_ATH79)			+= ar9331_omega.dtb
 dtb-$(CONFIG_ATH79)			+= ar9331_tl_mr3020.dtb
diff --git a/arch/mips/boot/dts/qca/ar9331_dpt_module.dts b/arch/mips/boot/dts/qca/ar9331_dpt_module.dts
new file mode 100644
index 0000000..98e7450
--- /dev/null
+++ b/arch/mips/boot/dts/qca/ar9331_dpt_module.dts
@@ -0,0 +1,78 @@
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
+	dr_mode = "host";
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
