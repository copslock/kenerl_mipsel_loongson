Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Jan 2016 21:21:04 +0100 (CET)
Received: from mail-lb0-f178.google.com ([209.85.217.178]:35763 "EHLO
        mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014862AbcAWUR7FQdEd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 23 Jan 2016 21:17:59 +0100
Received: by mail-lb0-f178.google.com with SMTP id bc4so56847290lbc.2
        for <linux-mips@linux-mips.org>; Sat, 23 Jan 2016 12:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SUcu+SGcQXelNRhozf6bga6J1hUJnGEwm6tyrWOtgqs=;
        b=LCyakRh7L/cj+q8VZC4d+YLeWinjwzMSTBIJVis5kfymirOOtrFshFIzNxfq9g/B+V
         iaP3JvnK78GOQzE806tHT76ixrpt1s7ZqUjYce9TcdyLh5j+JxuNoA6AE6RK3ePjED5Y
         +0jbOpw4C0Wh6fDL3DnnDk9gbWhqdRc/yRAnqClWEJ8n9EQPKt8s+1koc98EKPxfYE4V
         6gI+UM7o2sJpgQanXcWTpPeK9J3fUVnLzg+itD3fNQdIz2QrIrJ88CWxiWPiDIaNuqOu
         MVxsr7tCPHoPMs2XrqPYDB6lfVelV8mjy9T+ci60NLtc7BOJcGuzGrDQmKFVX4cE/SCr
         APSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SUcu+SGcQXelNRhozf6bga6J1hUJnGEwm6tyrWOtgqs=;
        b=QUH+Bh5TvrGN34u+pwjxizC3p5uE8TS6yZLRxgy9LVOmaYn6t4QhaOnmekFSf3S8Cp
         5A1zLlhVRdxHaZC8GbvtA4H/o67IwJWyP2cE0jlsL51BwbZ+Dd7TENt4SBw0lQor/nbj
         FyhTQ3l28g46scBKqJnmy7tCLuCpDrDt+TwdTS3REqciRCtpk9/Vv3lbSZZN1r8Eb6qS
         IVRkfYcSXj20CaPVarKiEqge7Wsy5Xyb/UJ54L1i6l8ONgFNLEpc8dF4DKaY9BR5Uwsv
         kpYMm+pUZnbf+7wNz5p++9GfPaddw3BeO9bi4ZH+eyiAJRSyzBO4OpCjEchk69p92G5E
         VBjw==
X-Gm-Message-State: AG10YORcWcbg/HW/7k2nDOskEwXJqYgYo4jmJwrvCRHFum010IEFvJs1XSv1X3SvxdLDRw==
X-Received: by 10.112.14.102 with SMTP id o6mr3458654lbc.87.1453580273821;
        Sat, 23 Jan 2016 12:17:53 -0800 (PST)
Received: from localhost.localdomain (ppp109-252-26-184.pppoe.spdop.ru. [109.252.26.184])
        by smtp.gmail.com with ESMTPSA id o82sm1664186lfo.47.2016.01.23.12.17.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 23 Jan 2016 12:17:53 -0800 (PST)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Antony Pavlov <antonynpavlov@gmail.com>,
        Gabor Juhos <juhosg@openwrt.org>, Alban Bedel <albeu@free.fr>,
        devicetree@vger.kernel.org
Subject: [RFC v3 11/14] MIPS: ath79: add initial support for Dragino MS14 (Dragino 2)
Date:   Sat, 23 Jan 2016 23:17:28 +0300
Message-Id: <1453580251-2341-12-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1453580251-2341-1-git-send-email-antonynpavlov@gmail.com>
References: <1453580251-2341-1-git-send-email-antonynpavlov@gmail.com>
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51337
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

    * http://www.dragino.com/products/mother-board/item/71-ms14-p.html
    * https://wiki.openwrt.org/toh/dragino/ms14

Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
Cc: Gabor Juhos <juhosg@openwrt.org>
Cc: Alban Bedel <albeu@free.fr>
Cc: linux-mips@linux-mips.org
Cc: devicetree@vger.kernel.org
---
 arch/mips/ath79/Kconfig                 |  5 +++
 arch/mips/boot/dts/qca/Makefile         |  1 +
 arch/mips/boot/dts/qca/dragino_ms14.dts | 73 +++++++++++++++++++++++++++++++++
 3 files changed, 79 insertions(+)

diff --git a/arch/mips/ath79/Kconfig b/arch/mips/ath79/Kconfig
index 4fd53ae..2797581 100644
--- a/arch/mips/ath79/Kconfig
+++ b/arch/mips/ath79/Kconfig
@@ -77,6 +77,11 @@ choice
 	help
 	  Select a devicetree that should be built into the kernel.
 
+	config DTB_DRAGINO_MS14
+		bool "Dragino MS14 (Dragino 2)"
+		select BUILTIN_DTB
+		select SOC_AR933X
+
 	config DTB_TL_MR3020
 		bool "TL-MR3020"
 		select BUILTIN_DTB
diff --git a/arch/mips/boot/dts/qca/Makefile b/arch/mips/boot/dts/qca/Makefile
index 04fe47c..428ebac5 100644
--- a/arch/mips/boot/dts/qca/Makefile
+++ b/arch/mips/boot/dts/qca/Makefile
@@ -1,5 +1,6 @@
 # All DTBs
 dtb-$(CONFIG_DTB_TL_WR1043ND_V1)	+= ar9132_tl_wr1043nd_v1.dtb
+dtb-$(CONFIG_DTB_DRAGINO_MS14)		+= dragino_ms14.dtb
 dtb-$(CONFIG_DTB_TL_MR3020)		+= tl_mr3020.dtb
 
 obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
diff --git a/arch/mips/boot/dts/qca/dragino_ms14.dts b/arch/mips/boot/dts/qca/dragino_ms14.dts
new file mode 100644
index 0000000..7c25d1f
--- /dev/null
+++ b/arch/mips/boot/dts/qca/dragino_ms14.dts
@@ -0,0 +1,73 @@
+/dts-v1/;
+
+#include "ar9331.dtsi"
+#include <dt-bindings/gpio/gpio.h>
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
2.6.2
