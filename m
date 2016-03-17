Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Mar 2016 04:39:09 +0100 (CET)
Received: from mail-lf0-f65.google.com ([209.85.215.65]:32989 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007230AbcCQDe6a9Jlp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Mar 2016 04:34:58 +0100
Received: by mail-lf0-f65.google.com with SMTP id l83so2209225lfd.0
        for <linux-mips@linux-mips.org>; Wed, 16 Mar 2016 20:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YVJIpTgy/BOapDgEHx1MDpu/8AqpkcSUIxxPyzmA86g=;
        b=HqKnVEM3Fm03YFTEPuvwUd+M9DjFib5CTavlEcXLPgpE49eXc2cNOun+tDnEAh1Xqp
         wdulQ7bElHExyVMvY1x0kzO5oicEGPz8PfmIxrJNFF/vCQ7p14CrNMS6xUCfNq50QxC0
         E3yHVwJITIfXG2/t29VPNOLMRd7sQwqAQGOwy9x51YF226pVboQ9KNF4aBu917p9JzQS
         Qo7Fh9in4HAOI+P4Pa1eqIUYVOUXkxk/ruaTRoy1JdaIb5nxJlhc5fu/9hy1PFznQrKh
         GdQjIey0XadUGpTk+w/c1qB3ekzTgAr0eX5VngJeRYXUj18nZkXwITB5ckTR1M8RmyNg
         z7NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YVJIpTgy/BOapDgEHx1MDpu/8AqpkcSUIxxPyzmA86g=;
        b=CyFWXujlWE+ke1Y3FSQ8um/K8l2fRlp+N7/UjOzHwoF0n6phTFQ16uM9leJbll23Qj
         rLP94jqcjsGK8FcpNVf4ZoNQ3adKxxhMoSUoCYdd92lnriBR5ATohZtZKc/GKvkVwKPy
         /C/q1Qby9cwINloHy2dNOqBWINhXFJ1L4qZZXP/bUH26q8cli9BZxIHlA4Ec2gNbJKVH
         9ijmqsLU7cYToc0vyQoz2HHyX/9z0543ybF0dHk8wBzOGV37DeGxdGcMeLBhSAS1ERRe
         tqk9bXDcOXC14NI5b9SZnBeqwqyTOzFJ5TotH01JBC4Jv3N98OXBIrFCbo1s55KKHMyE
         kfJw==
X-Gm-Message-State: AD7BkJLH4ymDbCwJObYVs4va0vdaJ2mh2t7X4n0xwzR0QAJ0lEiSiQnCQa9aymDURc14rQ==
X-Received: by 10.25.77.204 with SMTP id a195mr2695680lfb.111.1458185693266;
        Wed, 16 Mar 2016 20:34:53 -0700 (PDT)
Received: from localhost.localdomain (ppp109-252-26-173.pppoe.spdop.ru. [109.252.26.173])
        by smtp.gmail.com with ESMTPSA id gp6sm1026698lbc.44.2016.03.16.20.34.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Mar 2016 20:34:52 -0700 (PDT)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Gabor Juhos <juhosg@openwrt.org>, Alban Bedel <albeu@free.fr>,
        "L . D . Pinney" <ldpinney@gmail.com>, Boken Lin <bl@onion.io>,
        Jacky Huang <huangfangcheng@163.com>,
        devicetree@vger.kernel.org
Subject: [PATCH v2 16/18] MIPS: ath79: add initial support for Onion Omega
Date:   Thu, 17 Mar 2016 06:34:23 +0300
Message-Id: <1458185665-4521-17-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1458185665-4521-1-git-send-email-antonynpavlov@gmail.com>
References: <1458185665-4521-1-git-send-email-antonynpavlov@gmail.com>
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52630
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
 arch/mips/boot/dts/qca/Makefile         |  1 +
 arch/mips/boot/dts/qca/ar9331_omega.dts | 78 +++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+)

diff --git a/arch/mips/boot/dts/qca/Makefile b/arch/mips/boot/dts/qca/Makefile
index 2451364..dc0b5a4 100644
--- a/arch/mips/boot/dts/qca/Makefile
+++ b/arch/mips/boot/dts/qca/Makefile
@@ -1,6 +1,7 @@
 # All DTBs
 dtb-$(CONFIG_ATH79)			+= ar9132_tl_wr1043nd_v1.dtb
 dtb-$(CONFIG_ATH79)			+= ar9331_dragino_ms14.dtb
+dtb-$(CONFIG_ATH79)			+= ar9331_omega.dtb
 dtb-$(CONFIG_ATH79)			+= ar9331_tl_mr3020.dtb
 
 # Force kbuild to make empty built-in.o if necessary
diff --git a/arch/mips/boot/dts/qca/ar9331_omega.dts b/arch/mips/boot/dts/qca/ar9331_omega.dts
new file mode 100644
index 0000000..b2be3b0
--- /dev/null
+++ b/arch/mips/boot/dts/qca/ar9331_omega.dts
@@ -0,0 +1,78 @@
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
