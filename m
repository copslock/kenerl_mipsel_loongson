Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Jan 2016 23:35:35 +0100 (CET)
Received: from mail-lf0-f41.google.com ([209.85.215.41]:34509 "EHLO
        mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011180AbcAUWenrjUBN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 21 Jan 2016 23:34:43 +0100
Received: by mail-lf0-f41.google.com with SMTP id 17so36141740lfz.1
        for <linux-mips@linux-mips.org>; Thu, 21 Jan 2016 14:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9cwSD+wMnxpSRedBUtTZkXTn2hdzqH0qI/J5yEkARSQ=;
        b=Qxol6wC1mHHMNJkAPKriCw15c9JVwXOP0y4kO2jArqHTN6wnK5+O0IB2ECKgJCmhqt
         n2MBg+poJLTbWORW04Gyfzb9zjFbRaXp2JBQ4KIeM+LwV1W3M9qGxhdytxqy8NVABKsc
         QbFAdD4S/7ltDb/OF7wZN/nBbSz9Il9f5r63OsehdbRzpikrSCN7ImQ5+HBoVdQQVui/
         55rYW7ACkhEApT7bOplFN7R4MA4Glr3hhoIZLtKo+hy1XscyoV76JVOAhfknt6XZtke0
         XDB8LOF73ohPaHS9L2/wwmoNZRy5EakKuiXtbllJP3ZqHzV2MRLbeOSAsyZ3pU3BTblX
         SvTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9cwSD+wMnxpSRedBUtTZkXTn2hdzqH0qI/J5yEkARSQ=;
        b=c7i8Mq+61VjR8UwnCn7DSfdjmZyL9uY9/+vz4i4iDnO8/d0IHblw9mKVvgV1zQk8Jn
         NtZ/Vxnd5KxKk5qkOmNA3ceSDQVTPXSRfCYSa0tVnvb65ieUavlBtebLxlGQt9xHuvCj
         /FPbfhsw09vJHvlT+eCxiPLzrqCb/s0J2bdg5QMeNTCw9I/dTJm6qUJWY7qa03TLNsb6
         OXaTNtX2xvLa2M5DmrH9bUqjJ6xXqdQhifyVdxQNncKvIlto0n3bg0gqsunuJ8P9TBou
         v/z/AyLyuJNcizZsWQ09Ht7F6+Qrx/NxHuZULgFGs83oDHqkX8J6LoZ5bP0UIKhYLt8i
         hHVw==
X-Gm-Message-State: ALoCoQkX1VDTWl7E633FPD8apwJ00B7LSJT7kP52KDOKo2g3XEPL09rjYQ9EEdAc/FfqmT/EzBuF9BaPzWuHY5sz20cLkfRhnA==
X-Received: by 10.25.64.5 with SMTP id n5mr16275814lfa.89.1453415678577;
        Thu, 21 Jan 2016 14:34:38 -0800 (PST)
Received: from localhost.localdomain (ppp109-252-26-184.pppoe.spdop.ru. [109.252.26.184])
        by smtp.gmail.com with ESMTPSA id j130sm319217lfe.23.2016.01.21.14.34.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 21 Jan 2016 14:34:38 -0800 (PST)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Antony Pavlov <antonynpavlov@gmail.com>,
        Gabor Juhos <juhosg@openwrt.org>, Alban Bedel <albeu@free.fr>,
        devicetree@vger.kernel.org
Subject: [RFC v2 3/7] MIPS: dts: qca: introduce AR9331 devicetree
Date:   Fri, 22 Jan 2016 01:34:20 +0300
Message-Id: <1453415664-20307-4-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1453415664-20307-1-git-send-email-antonynpavlov@gmail.com>
References: <1453415664-20307-1-git-send-email-antonynpavlov@gmail.com>
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51286
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
 arch/mips/boot/dts/qca/ar9331.dtsi | 123 +++++++++++++++++++++++++++++++++++++
 1 file changed, 123 insertions(+)

diff --git a/arch/mips/boot/dts/qca/ar9331.dtsi b/arch/mips/boot/dts/qca/ar9331.dtsi
new file mode 100644
index 0000000..fae7e6d
--- /dev/null
+++ b/arch/mips/boot/dts/qca/ar9331.dtsi
@@ -0,0 +1,123 @@
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
+			ref: oscillator {
+				compatible = "fixed-clock";
+				#clock-cells = <0>;
+			};
+
+			pll: pll-controller@18050000 {
+				compatible = "qca,ar9330-pll";
+				reg = <0x18050000 0x20>;
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
+			spi: spi@1f000000 {
+				compatible = "qca,ar7100-spi";
+				reg = <0x1f000000 0x10>;
+
+				clocks = <&pll AR933X_CLK_AHB>;
+				clock-names = "ahb";
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
