Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Feb 2016 01:15:07 +0100 (CET)
Received: from mail-lf0-f53.google.com ([209.85.215.53]:35244 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011954AbcBAALGyUofA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Feb 2016 01:11:06 +0100
Received: by mail-lf0-f53.google.com with SMTP id l143so18960458lfe.2
        for <linux-mips@linux-mips.org>; Sun, 31 Jan 2016 16:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nWuMe9TbL32M3b1YjzIH7ntTpPmsxY5A9+euvCdqkDs=;
        b=F4TMDQUY2y3QtSDBp6NQUhS9Qx/96tBT961q5AXnOdK1SYytPT3Oh9QfNfJXEPnVzY
         8adK289mJMxEQ9NYzIu2qROfuE9plUGGi21uUM6g1C/7pKF3/jB7etMvcjWz+JC70Eys
         +V/ICBv/hnSan7TXd+iG/T04ASFl8VNA/Asae3fsNK7u7AetEDgpthEQhw4hWhGYYvum
         W0VPJSgTCWIqQaze1efJJGE5fe3sPrSWbLHXp0DSj36MrNOTVkn9pEYIuJ0Jp1FBVKgz
         ojou7G1P68Wjf+SRfI7q+/JE2qDiMQa+2q/ZeWVJ7X6M4W8fmgJ646/a0u7AwGwPv1Yk
         mM3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nWuMe9TbL32M3b1YjzIH7ntTpPmsxY5A9+euvCdqkDs=;
        b=kYCee0q22ZUD3QpPn4mxIT6r6Ow8kdqlJxVGP8zVinKttS0WtPLz+MCOONeR1HubGy
         vZOXAzLse4GBYDNhuOCFmHL6fVtwVLmI2wi42SKlrRfgx8MzVol5LOJz/drEyLv2wuY2
         TP+YStQOGYp+WRwvbJBVdLhXmZq75i6EoLid7W5QGhMmLMQgyqUd7HHV6R20N9iGY3Uv
         fCywKCfd/INQ9DHQxw2lRjTR/zVoW+ht4JFuaoEP6E7Ml1f8eBDuKLT4pzuQT30yq2jK
         dROqJgmQHEthEKUEDQ4Xm+l7vxbOf4tc2aoeCTq0/VoCw7H+amJbtQ44i9uhajddGF9N
         IVCg==
X-Gm-Message-State: AG10YOT0yZmLPipuDDJXYAqEHd3OzXjHisOgN3LncjeyR00zM6d+NfNfY8D3G1P+ir/J/g==
X-Received: by 10.25.145.14 with SMTP id t14mr7968980lfd.100.1454285461668;
        Sun, 31 Jan 2016 16:11:01 -0800 (PST)
Received: from localhost.localdomain (ppp109-252-26-184.pppoe.spdop.ru. [109.252.26.184])
        by smtp.gmail.com with ESMTPSA id o97sm2807958lfi.25.2016.01.31.16.11.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 31 Jan 2016 16:11:01 -0800 (PST)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Antony Pavlov <antonynpavlov@gmail.com>,
        Gabor Juhos <juhosg@openwrt.org>, Alban Bedel <albeu@free.fr>,
        "L . D . Pinney" <ldpinney@gmail.com>, Boken Lin <bl@onion.io>,
        Jacky Huang <huangfangcheng@163.com>,
        devicetree@vger.kernel.org
Subject: [RFC v4 14/15] MIPS: ath79: add initial support for Onion Omega
Date:   Mon,  1 Feb 2016 03:10:39 +0300
Message-Id: <1454285440-18916-15-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1454285440-18916-1-git-send-email-antonynpavlov@gmail.com>
References: <1454285440-18916-1-git-send-email-antonynpavlov@gmail.com>
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51575
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
 arch/mips/ath79/Kconfig          |  5 ++++
 arch/mips/boot/dts/qca/Makefile  |  1 +
 arch/mips/boot/dts/qca/omega.dts | 54 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 60 insertions(+)

diff --git a/arch/mips/ath79/Kconfig b/arch/mips/ath79/Kconfig
index 2797581..5273039 100644
--- a/arch/mips/ath79/Kconfig
+++ b/arch/mips/ath79/Kconfig
@@ -82,6 +82,11 @@ choice
 		select BUILTIN_DTB
 		select SOC_AR933X
 
+	config DTB_ONION_OMEGA
+		bool "Onion Omega"
+		select BUILTIN_DTB
+		select SOC_AR933X
+
 	config DTB_TL_MR3020
 		bool "TL-MR3020"
 		select BUILTIN_DTB
diff --git a/arch/mips/boot/dts/qca/Makefile b/arch/mips/boot/dts/qca/Makefile
index 428ebac5..efecdac 100644
--- a/arch/mips/boot/dts/qca/Makefile
+++ b/arch/mips/boot/dts/qca/Makefile
@@ -1,6 +1,7 @@
 # All DTBs
 dtb-$(CONFIG_DTB_TL_WR1043ND_V1)	+= ar9132_tl_wr1043nd_v1.dtb
 dtb-$(CONFIG_DTB_DRAGINO_MS14)		+= dragino_ms14.dtb
+dtb-$(CONFIG_DTB_ONION_OMEGA)		+= omega.dtb
 dtb-$(CONFIG_DTB_TL_MR3020)		+= tl_mr3020.dtb
 
 obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
diff --git a/arch/mips/boot/dts/qca/omega.dts b/arch/mips/boot/dts/qca/omega.dts
new file mode 100644
index 0000000..9cd9f91
--- /dev/null
+++ b/arch/mips/boot/dts/qca/omega.dts
@@ -0,0 +1,54 @@
+/dts-v1/;
+
+#include "ar9331.dtsi"
+#include <dt-bindings/gpio/gpio.h>
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
