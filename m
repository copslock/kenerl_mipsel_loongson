Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Jan 2016 00:57:44 +0100 (CET)
Received: from mail-lb0-f172.google.com ([209.85.217.172]:34941 "EHLO
        mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010207AbcAQX5KzrMDD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 Jan 2016 00:57:10 +0100
Received: by mail-lb0-f172.google.com with SMTP id bc4so337602340lbc.2
        for <linux-mips@linux-mips.org>; Sun, 17 Jan 2016 15:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LQhdhi8lSIyds4ZSxS/swqYsgiL+u08h0zR3p6xXB1o=;
        b=dhYvAOwAC1YEpWK8rahln0E+PGkI5ZryliBQBq7Eyn+GZQkNHhLC7yGeLxkQZWpuMX
         dKAprc9Z8I8tOqxrQezGUBGdkiI1RYd9AR50gb/Uze4N0zZVa+9O1too5USc173W0cjH
         BA5NILNA3kDVfelZzGGjFtqTZOd0QM0J9/knbXwXbQO3oknUvSPaDq3MP+ReFn9So811
         7C86EVmWoOEHLG0v7sZrNZIXaS1Y1sSoXYYQQW7UlHx68yJa3X32hsxDy0BjS8Xgl6rv
         fsVzQw5zvPoiUeS1aHNwRdXLestoEpJokt+0vx5gsjG9V1K2dLQSXotjLldjTTItLUPw
         2IaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LQhdhi8lSIyds4ZSxS/swqYsgiL+u08h0zR3p6xXB1o=;
        b=T+dX3LIJDFASMJp1pBV6nY7frLnM1tFn1SS+epPLklo2w25C/AJb5tSghnFjuKP0zN
         KSAhKcyoHGgDwyrVFcqjA+Ym9b0VqMpkeLEzrH0vwsc4cDzU5avmcrSg7jw3yP8gCBT5
         4/EysUQvmdJw6w5Tqw7dYcgqsvgHdrOjX4X6M2vBdk3i12CNNHuIPnYucgCz0WrfpKEy
         oT2Mzk3eBSkvqzZQad81M3Cn53OCa/spAkbmQ3nMXweD1YKAA50RNCyS1X+X/tTEVBLD
         XGZf/yloOd4SF7GeYi1+rsb+aimaLsMlwSJzsAKIO+ackLtVlyB6JgjJYtLEDJZuXVog
         oYcA==
X-Gm-Message-State: ALoCoQl3iHpNU/Ee2cuwt6lJ4fuP4g8EI/XXNWql9ltVHxvcrpi8q60ToABgpWBd3HHKQboMOiSHnzklxifKxOE4FWXGIj/jYQ==
X-Received: by 10.112.13.99 with SMTP id g3mr6996542lbc.86.1453075025661;
        Sun, 17 Jan 2016 15:57:05 -0800 (PST)
Received: from localhost.localdomain (ppp109-252-26-184.pppoe.spdop.ru. [109.252.26.184])
        by smtp.gmail.com with ESMTPSA id xe8sm2783445lbb.41.2016.01.17.15.57.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 17 Jan 2016 15:57:05 -0800 (PST)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Yegor Yefremov <yegorslists@googlemail.com>,
        Antony Pavlov <antonynpavlov@gmail.com>,
        Gabor Juhos <juhosg@openwrt.org>, Alban Bedel <albeu@free.fr>,
        devicetree@vger.kernel.org
Subject: [RFC 2/4] MIPS: dts: qca: introduces AR9331 devicetree
Date:   Mon, 18 Jan 2016 02:56:25 +0300
Message-Id: <1453074987-3356-3-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1453074987-3356-1-git-send-email-antonynpavlov@gmail.com>
References: <1453074987-3356-1-git-send-email-antonynpavlov@gmail.com>
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51182
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
 arch/mips/boot/dts/qca/ar9331.dtsi | 113 +++++++++++++++++++++++++++++++++++++
 1 file changed, 113 insertions(+)

diff --git a/arch/mips/boot/dts/qca/ar9331.dtsi b/arch/mips/boot/dts/qca/ar9331.dtsi
new file mode 100644
index 0000000..49513b0
--- /dev/null
+++ b/arch/mips/boot/dts/qca/ar9331.dtsi
@@ -0,0 +1,113 @@
+#include <dt-bindings/clock/ar933x-clk.h>
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
+				clocks = <&pll AR933X_CLK_UART>;
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
+				reg = <0x18050000 0x20>;
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
+			spi: spi@1f000000 {
+				compatible = "qca,ar7100-spi";
+				reg = <0x1f000000 0x10>;
+
+				clocks = <&pll AR933X_CLK_AHB>;
+
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				status = "disabled";
+			};
+		};
+	};
+};
-- 
2.6.2
