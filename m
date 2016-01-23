Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Jan 2016 21:21:56 +0100 (CET)
Received: from mail-lf0-f52.google.com ([209.85.215.52]:35390 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014873AbcAWUSDVOysd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 23 Jan 2016 21:18:03 +0100
Received: by mail-lf0-f52.google.com with SMTP id c192so64966105lfe.2
        for <linux-mips@linux-mips.org>; Sat, 23 Jan 2016 12:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XJzv24hwW8YzaVEk1WLAWZgZEoig5z7uGAhuDNuxzyU=;
        b=V1iCdB4T9f/hCgwW5U72S03jWsy3GKCA1KyuWybQvOxqTQsPtXmYjVFIKOuMnM85vM
         83YCSR3jxt2ZY95nO1M6cXdszLWq6bKfSqW1H2NAm2hZMUuiHKk5W2ecoO6jgmp0Gz6r
         OxiYiYeviq53zbXxn1N98xg1FBqhpB4VbTt3sjpqXprMUMxIfL4tciUVz+TuBAmG5OaC
         87NZEArhf/LXY6NiJxdEMDeuAxh3bKdm91pBXV66AEfCHGpp6Yv5moRnRGI+q1BQxKT4
         cSzhQqlxxSy2/p4v/v8RYww/xZTGrY3sDLsvfrkdIIZU7k7/x2YskV60ormXE67V8cen
         Bpfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XJzv24hwW8YzaVEk1WLAWZgZEoig5z7uGAhuDNuxzyU=;
        b=Go3d5ecMjhx/3CLAHqmi/p4eJf4FqY3qdajcG5gQzGfvj+49XMH8iCLpQzg5pWZb4k
         kDd1bQnlTcf8DDp4qWd1Vu5EokmTGcTOBHuJUE10rfCeEarttkR73qKnQGL2TBAW4ty+
         lfDtX5NowhgI0jypWV+EtVgfDkzoe1El20juFGglWojym95oTVLQ0QWnsEC4OXtLO1Vb
         7kcwf0unlV1wuLo5sUeGyzqhPpWlsPdUSGo0E1blr8sXb24/A30psnHsBTd3opmXtfO+
         a++De/L/TJyJdlzDbLjNxTQ6aB561Qqs9NrkbUjGXItVGEsSgbsbGUbmgm02jjZiII/5
         EGiQ==
X-Gm-Message-State: AG10YORmcNmk7vuAflcJi67FvqMQrSJRLKDM50cEuRSBr8CDcl5+xdx6ylK/CJlFkDCm5w==
X-Received: by 10.25.158.147 with SMTP id h141mr3540003lfe.147.1453580275811;
        Sat, 23 Jan 2016 12:17:55 -0800 (PST)
Received: from localhost.localdomain (ppp109-252-26-184.pppoe.spdop.ru. [109.252.26.184])
        by smtp.gmail.com with ESMTPSA id o82sm1664186lfo.47.2016.01.23.12.17.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 23 Jan 2016 12:17:55 -0800 (PST)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Antony Pavlov <antonynpavlov@gmail.com>,
        Gabor Juhos <juhosg@openwrt.org>, Alban Bedel <albeu@free.fr>,
        "L . D . Pinney" <ldpinney@gmail.com>, Boken Lin <bl@onion.io>,
        Jacky Huang <huangfangcheng@163.com>,
        devicetree@vger.kernel.org
Subject: [RFC v3 13/14] MIPS: ath79: add initial support for Onion Omega
Date:   Sat, 23 Jan 2016 23:17:30 +0300
Message-Id: <1453580251-2341-14-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1453580251-2341-1-git-send-email-antonynpavlov@gmail.com>
References: <1453580251-2341-1-git-send-email-antonynpavlov@gmail.com>
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51340
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
2.6.2
