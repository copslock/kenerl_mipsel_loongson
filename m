Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Feb 2016 09:15:52 +0100 (CET)
Received: from mail-lf0-f67.google.com ([209.85.215.67]:36653 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011798AbcBIIOd4AXj5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 9 Feb 2016 09:14:33 +0100
Received: by mail-lf0-f67.google.com with SMTP id h198so5993015lfh.3
        for <linux-mips@linux-mips.org>; Tue, 09 Feb 2016 00:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cduLPUBxU4QkcLlvmEyOHfsVedmWE2Cy8gndJCzrqhA=;
        b=j0CN6a923fFC90GciIFZ9w5X+PNvujMfbX7pPT3S7N0cm70GNpt/qngWWKRDIPqhXI
         yZ8lZM/jHT3kCS8E2q+7xLgsozBJW6cQ0y49cXG7E2Ra30xFCP1qnXtWuWzqrhdRFlPE
         uvIcBb+xz+dR1hcQhZC3Du1NTkWc3aCZiEhQQnz1GvTO8qZb7WyHraSdXBASVJ/IkMr/
         HCl/iagqVon8fBGj+3vw4gLvE23+ZqH/pRXwT1jXO8VrcMhuDvFBZQpaKdgv2sUu5Xpl
         /LgpQNS+b+qBZ9nGb7vILxMUxEADKjHTZvEQ/wzqLApMFGACOIflwUOlewstrlubh4CE
         28ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cduLPUBxU4QkcLlvmEyOHfsVedmWE2Cy8gndJCzrqhA=;
        b=I/txiJn05K2+azoVgfhSo3EpFmvNp9WfSsyEfb5YB+KU+OuMu3PTtGWG9DcQHDVt2L
         jxNKOLuhsmRxmWEerSni1QL+oyVt9bj2NPFe7r7fOfHyfhp1OqT1uBZMlpwqnnleB6Ml
         /6NGfWEvodcsZKUwJBF+LLdxeGTOkYzIUpVRR0ebkPtjqSCWMm+25JRnIOPa4ogzynKn
         jcpE3sgq+jYzvxUddW2zgWgIZFTPrE9xatIOhahzD+Gx7Vo+jKLTGHq8EQ3KLbaICWio
         KKRSBHLf7r5Nr6xAAESw5Wb8ynpq3xEhfG582WqVAMySDaMta1AqrA6NF/MOMSyOB5cL
         dNpA==
X-Gm-Message-State: AG10YOQgtszKvJPHm7cTiw9TGGO+ZJvA8iuk46vtaANtin3PH1sTYaAJMPVgTWp0QN0v/g==
X-Received: by 10.25.16.30 with SMTP id f30mr14299788lfi.126.1455005668656;
        Tue, 09 Feb 2016 00:14:28 -0800 (PST)
Received: from localhost.localdomain (ppp109-252-26-173.pppoe.spdop.ru. [109.252.26.173])
        by smtp.gmail.com with ESMTPSA id v140sm212726lfd.24.2016.02.09.00.14.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Feb 2016 00:14:27 -0800 (PST)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Marek Vasut <marex@denx.de>, Wills Wang <wills.wang@live.com>,
        Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
        Alban Bedel <albeu@free.fr>, Gabor Juhos <juhosg@openwrt.org>,
        devicetree@vger.kernel.org
Subject: [RFC v5 05/15] MIPS: dts: qca: introduce AR9331 devicetree
Date:   Tue,  9 Feb 2016 11:13:51 +0300
Message-Id: <1455005641-7079-6-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1455005641-7079-1-git-send-email-antonynpavlov@gmail.com>
References: <1455005641-7079-1-git-send-email-antonynpavlov@gmail.com>
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51881
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
 arch/mips/boot/dts/qca/ar9331.dtsi | 157 +++++++++++++++++++++++++++++++++++++
 1 file changed, 157 insertions(+)

diff --git a/arch/mips/boot/dts/qca/ar9331.dtsi b/arch/mips/boot/dts/qca/ar9331.dtsi
new file mode 100644
index 0000000..333c7ff
--- /dev/null
+++ b/arch/mips/boot/dts/qca/ar9331.dtsi
@@ -0,0 +1,157 @@
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
+				clocks = <&pll ATH79_CLK_UART>;
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
+
+			usb: usb@1b000100 {
+				compatible = "qca,ar7100-ehci", "generic-ehci";
+				reg = <0x1b000100 0x100>;
+
+				interrupt-parent = <&cpuintc>;
+				interrupts = <3>;
+				resets = <&rst 5>;
+
+				has-transaction-translator;
+
+				phy-names = "usb";
+				phys = <&usb_phy>;
+
+				status = "disabled";
+			};
+
+			spi: spi@1f000000 {
+				compatible = "qca,ar7100-spi";
+				reg = <0x1f000000 0x10>;
+
+				clocks = <&pll ATH79_CLK_AHB>;
+				clock-names = "ahb";
+
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				status = "disabled";
+			};
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
