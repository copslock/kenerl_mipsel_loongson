Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Mar 2016 04:37:30 +0100 (CET)
Received: from mail-lb0-f194.google.com ([209.85.217.194]:34850 "EHLO
        mail-lb0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007113AbcCQDevmwRkp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Mar 2016 04:34:51 +0100
Received: by mail-lb0-f194.google.com with SMTP id wn5so4261010lbb.2
        for <linux-mips@linux-mips.org>; Wed, 16 Mar 2016 20:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mlzpjBD+3RJ7WQzZnkroS8f84K7skyjRzxjZZOP8Y10=;
        b=fAa6KxBVRGP83tprz1OqM1YxSX0p9X4WiiA9619iYe/HWaw7Ho3hFhuXEqlK/O5DhM
         tU1+BMIJydcvcAAzwp2vyo0r+/VAmYY0+k3/O7vt01a6tUrSEHoJy+//LbC09WqNIP5o
         8HC+Go+OqqyvkL4dYhi0RAXX6OfEj1+tUEr0JPMKterF66JlH2Xxg/DKiviDJ5e1YpPW
         0oKJFjGS+sHf5od82a2vYIQ0L16OjCX+P5pukWz+F95t4szt53zh5BalUYk8cD27LWW7
         zpYanBUHarN7ho1EDS/4a5zU+9RVzgAeqBy2w6V9KAwCbgaLigDooTX9pNc6DEGDEdPi
         FUlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mlzpjBD+3RJ7WQzZnkroS8f84K7skyjRzxjZZOP8Y10=;
        b=MnkEa+oY34vRuGNBfsyeol08qc3v1IOAULFHntEprOZd7MI6uYZ6xG3b5oHM7BT03m
         huY5AZKUZv0hGmRfB3F5SMOAI9RmNNKC8hOUIQhLMcTy6mDCBeCPxgfybTH05GjCkuN9
         dYAsHOiDtYNauueJl5RJ8xSL8hZbHQcBIJjUzf9e8ARltiOIeFAtwhUeU4cuWJQ48KoE
         h5mq9UAhMb2Z67lWmEKOguPyr3kKBvmLI+PwTqt+Ola9sxkSN0UCClzG8+ZVVaIUWOTN
         KHXf11XyMDauL/5skOaWakzehacGtSm8nCr868TQ9+0TrB9sJvdYP+6kr/S6KInIA1+J
         LEQA==
X-Gm-Message-State: AD7BkJIMtCYbauyZ1LYJuOXxgKWttuxpZwwY2wv0jTkOL8s9tazsoveqtVaFXNznhvfcrQ==
X-Received: by 10.112.27.202 with SMTP id v10mr2660472lbg.34.1458185686449;
        Wed, 16 Mar 2016 20:34:46 -0700 (PDT)
Received: from localhost.localdomain (ppp109-252-26-173.pppoe.spdop.ru. [109.252.26.173])
        by smtp.gmail.com with ESMTPSA id gp6sm1026698lbc.44.2016.03.16.20.34.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Mar 2016 20:34:45 -0700 (PDT)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Gabor Juhos <juhosg@openwrt.org>, Alban Bedel <albeu@free.fr>,
        devicetree@vger.kernel.org
Subject: [PATCH v2 10/18] MIPS: dts: qca: introduce AR9331 devicetree
Date:   Thu, 17 Mar 2016 06:34:17 +0300
Message-Id: <1458185665-4521-11-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1458185665-4521-1-git-send-email-antonynpavlov@gmail.com>
References: <1458185665-4521-1-git-send-email-antonynpavlov@gmail.com>
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52624
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

This patch introduces devicetree for Atheros AR9331 SoC (AKA Hornet).
The AR9331 chip is a Wi-Fi System-On-Chip (WiSOC),
typically used in very cheap Access Points and Routers.

Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
Cc: Gabor Juhos <juhosg@openwrt.org>
Cc: Alban Bedel <albeu@free.fr>
Cc: linux-mips@linux-mips.org
Cc: devicetree@vger.kernel.org
---
 arch/mips/boot/dts/qca/ar9331.dtsi | 155 +++++++++++++++++++++++++++++++++++++
 1 file changed, 155 insertions(+)

diff --git a/arch/mips/boot/dts/qca/ar9331.dtsi b/arch/mips/boot/dts/qca/ar9331.dtsi
new file mode 100644
index 0000000..cf47ed4
--- /dev/null
+++ b/arch/mips/boot/dts/qca/ar9331.dtsi
@@ -0,0 +1,155 @@
+#include <dt-bindings/clock/ath79-clk.h>
+
+/ {
+	compatible = "qca,ar9331";
+
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu@0 {
+			device_type = "cpu";
+			compatible = "mips,mips24Kc";
+			clocks = <&pll ATH79_CLK_CPU>;
+			reg = <0>;
+		};
+	};
+
+	cpuintc: interrupt-controller {
+		compatible = "qca,ar7100-cpu-intc";
+
+		interrupt-controller;
+		#interrupt-cells = <1>;
+
+		qca,ddr-wb-channel-interrupts = <2>, <3>;
+		qca,ddr-wb-channels = <&ddr_ctrl 3>, <&ddr_ctrl 2>;
+	};
+
+	ref: ref {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+	};
+
+	ahb {
+		compatible = "simple-bus";
+		ranges;
+
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		interrupt-parent = <&cpuintc>;
+
+		apb {
+			compatible = "simple-bus";
+			ranges;
+
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			interrupt-parent = <&miscintc>;
+
+			ddr_ctrl: memory-controller@18000000 {
+				compatible = "qca,ar7240-ddr-controller";
+				reg = <0x18000000 0x100>;
+
+				#qca,ddr-wb-channel-cells = <1>;
+			};
+
+			uart: uart@18020000 {
+				compatible = "qca,ar9330-uart";
+				reg = <0x18020000 0x14>;
+
+				interrupts = <3>;
+
+				clocks = <&ref>;
+				clock-names = "uart";
+
+				status = "disabled";
+			};
+
+			gpio: gpio@18040000 {
+				compatible = "qca,ar7100-gpio";
+				reg = <0x18040000 0x34>;
+				interrupts = <2>;
+
+				ngpios = <30>;
+
+				gpio-controller;
+				#gpio-cells = <2>;
+
+				interrupt-controller;
+				#interrupt-cells = <2>;
+
+				status = "disabled";
+			};
+
+			pll: pll-controller@18050000 {
+				compatible = "qca,ar9330-pll";
+				reg = <0x18050000 0x100>;
+
+				clocks = <&ref>;
+				clock-names = "ref";
+
+				#clock-cells = <1>;
+			};
+
+			miscintc: interrupt-controller@18060010 {
+				compatible = "qca,ar7240-misc-intc";
+				reg = <0x18060010 0x4>;
+
+				interrupt-parent = <&cpuintc>;
+				interrupts = <6>;
+
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+
+			rst: reset-controller@1806001c {
+				compatible = "qca,ar7100-reset";
+				reg = <0x1806001c 0x4>;
+
+				#reset-cells = <1>;
+			};
+		};
+
+		usb: usb@1b000100 {
+			compatible = "chipidea,usb2";
+			reg = <0x1b000000 0x200>;
+
+			interrupts = <3>;
+			resets = <&rst 5>;
+
+			phy-names = "usb-phy";
+			phys = <&usb_phy>;
+
+			status = "disabled";
+		};
+
+		spi: spi@1f000000 {
+			compatible = "qca,ar7100-spi";
+			reg = <0x1f000000 0x10>;
+
+			clocks = <&pll ATH79_CLK_AHB>;
+			clock-names = "ahb";
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			status = "disabled";
+		};
+	};
+
+	usb_phy: usb-phy {
+		compatible = "qca,ar7100-usb-phy";
+
+		reset-names = "usb-phy", "usb-suspend-override";
+		resets = <&rst 4>, <&rst 3>;
+
+		#phy-cells = <0>;
+
+		status = "disabled";
+	};
+};
-- 
2.7.0
