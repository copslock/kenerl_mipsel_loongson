Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Feb 2016 01:13:34 +0100 (CET)
Received: from mail-lf0-f53.google.com ([209.85.215.53]:35227 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011941AbcBAALC0Ed5A (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Feb 2016 01:11:02 +0100
Received: by mail-lf0-f53.google.com with SMTP id l143so18959966lfe.2
        for <linux-mips@linux-mips.org>; Sun, 31 Jan 2016 16:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2MasP2ErQ6zt796yxIJ25kV2UO/PFzKfXkGB0zIxctA=;
        b=XQV/M+17Kpj75RihnJc5hGhJjkAZC9NNGkl61d9dGTjkAd9M8mT2xmKfyq4GXgscCH
         wKk9ZnbPXGtCs71NE7ffeQuEjQb2hayAe6sMApOR0WrtfrrJAVuyjq6u0MtKbP7znsKO
         fN1vbPTVj3uLIX6B6k5EoYSEaTZiBKH09hTPVohDW0eDvcxc++Tv+dntL66zKyL6Lpep
         /9CZH3huiE19kCjeEokacxS209kaEN0P8t0ofGFlNCkhl/FkXEJpuSL6ml6K0fcWEVl0
         9uqDX3nZ4vAnR7RP4ixT2h0wthYeSo1DEvyUxSy7tZ24F5z6kWiEusA5J97tg3Igrp8d
         m3Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2MasP2ErQ6zt796yxIJ25kV2UO/PFzKfXkGB0zIxctA=;
        b=HAtyRk96PNNPRcYw7mGGYL2H5VguOkcpe22SV8700u/Y4lZ0JZIRz170tOwZfHbYLs
         MmKjzoDLfeAWDofoiOfL5aHrtDTJLKZJ5zjPkcq6qNFVWMzdguHKZrhineeA1mnntIbq
         kXav94kc8b6hSuzimI0SCXOhEL+SFfuavujM/xuYuGzSuqd+1XPwdZcxIMUX/EmUReSd
         MKplsP7dB6kn5jyTLFhhlxm8qV/qZRZfKy1TKrpp+mVLlEUkcijnO32lvUNfg7Qd8iRY
         Zq0q+zS1V6/0/TpNVNxXMopBdh2y/SGIxeUMAUIqDzLq2EnvQmqSEXEgDEUde7KIUWoI
         Uwww==
X-Gm-Message-State: AG10YOSyAboLDPlLg+01a86d7n7ILLZhtVf3m3huG8CeOY7fz5/H9JlF9Lsba5zlg8V+sA==
X-Received: by 10.25.159.9 with SMTP id i9mr7762634lfe.109.1454285457194;
        Sun, 31 Jan 2016 16:10:57 -0800 (PST)
Received: from localhost.localdomain (ppp109-252-26-184.pppoe.spdop.ru. [109.252.26.184])
        by smtp.gmail.com with ESMTPSA id o97sm2807958lfi.25.2016.01.31.16.10.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 31 Jan 2016 16:10:56 -0800 (PST)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Antony Pavlov <antonynpavlov@gmail.com>,
        Gabor Juhos <juhosg@openwrt.org>, Alban Bedel <albeu@free.fr>,
        devicetree@vger.kernel.org
Subject: [RFC v4 09/15] MIPS: dts: qca: introduce AR9331 devicetree
Date:   Mon,  1 Feb 2016 03:10:34 +0300
Message-Id: <1454285440-18916-10-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1454285440-18916-1-git-send-email-antonynpavlov@gmail.com>
References: <1454285440-18916-1-git-send-email-antonynpavlov@gmail.com>
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51570
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
 arch/mips/boot/dts/qca/ar9331.dtsi | 158 +++++++++++++++++++++++++++++++++++++
 1 file changed, 158 insertions(+)

diff --git a/arch/mips/boot/dts/qca/ar9331.dtsi b/arch/mips/boot/dts/qca/ar9331.dtsi
new file mode 100644
index 0000000..854778b
--- /dev/null
+++ b/arch/mips/boot/dts/qca/ar9331.dtsi
@@ -0,0 +1,158 @@
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
+	extosc: oscillator {
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
+				reg = <0x18050000 0x100
+					0x18060000 0x100>;
+
+				clocks = <&extosc>;
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
