Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Jan 2016 21:20:09 +0100 (CET)
Received: from mail-lb0-f178.google.com ([209.85.217.178]:33064 "EHLO
        mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014853AbcAWUR4nlLkd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 23 Jan 2016 21:17:56 +0100
Received: by mail-lb0-f178.google.com with SMTP id x4so57483995lbm.0
        for <linux-mips@linux-mips.org>; Sat, 23 Jan 2016 12:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0E9XvVGqoGWC6AeXxXrXo7uGnA88jRcfphBYmdggsK8=;
        b=gB3BIJVDz70+uHUtSxUxIxVgBdQNPVvdsAcj9rMSa5xce8nJGo2OAf7no8Grx1A7ru
         TtWyPCMx/I1gYwsNdUAE2vzaXK0LbGpjkJyAvuXdK5SCrMHT0QKgV72yBrn44ZYRPKOw
         7P5ASpINlaIoJ6n1l+yVwHAj6suzlvXuslrrhDPIOf3vi7WJl5CXBMuNQwH6pA6lPZ0X
         REMtZiwuRv9ZkAYrj3UK28f7V+ViXAvnMi8sb8NI46/v8WXXAt9GJGJZaJVIrz77wkuA
         qRUe/dUiNFB5eotLg6PtSHTlchzH4oIb241cBCj+Us37yJofiH7m1yqfI840lW4ermaf
         4WMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0E9XvVGqoGWC6AeXxXrXo7uGnA88jRcfphBYmdggsK8=;
        b=AVLkZAJkI6Mi35kvVlSL9C+2f83DaMrdUQlljRXKZ3FXlaV3DmVZjgkTehyiLZNl9V
         xK3dhQttONVAU3phsCb+xZFB+LnaZx28jQslouSg2UIkIbHCDxtASPmKRdN6hL2N86ko
         XgQNcJo4mw4H3Vg2GCfR9A0e01WueBHOQknjG6IA8oYv8qPfwO1FQVBEgv/hl9+qY9t4
         F1A/ymqrcBOGCU1NiR3V+S3aYAZoydie9k8T90TVI59sTSfW8/mSbZqggF8lN1GOkSRg
         O3prN2ZAmvEX78W7YMRdoYluTpSKIZzMpTimfoieVE4QKYpoG7qpQQfoDDH5J+3JkA/E
         VivQ==
X-Gm-Message-State: AG10YOSgNRwEEtvNchqHTeckgRFG6QxtuWAZ/v86q7bd75ooQ2jeZE28Z8aJjEXnUmJucg==
X-Received: by 10.112.171.100 with SMTP id at4mr3530495lbc.7.1453580270579;
        Sat, 23 Jan 2016 12:17:50 -0800 (PST)
Received: from localhost.localdomain (ppp109-252-26-184.pppoe.spdop.ru. [109.252.26.184])
        by smtp.gmail.com with ESMTPSA id o82sm1664186lfo.47.2016.01.23.12.17.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 23 Jan 2016 12:17:50 -0800 (PST)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Antony Pavlov <antonynpavlov@gmail.com>,
        Gabor Juhos <juhosg@openwrt.org>, Alban Bedel <albeu@free.fr>,
        devicetree@vger.kernel.org
Subject: [RFC v3 08/14] MIPS: dts: qca: introduce AR9331 devicetree
Date:   Sat, 23 Jan 2016 23:17:25 +0300
Message-Id: <1453580251-2341-9-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1453580251-2341-1-git-send-email-antonynpavlov@gmail.com>
References: <1453580251-2341-1-git-send-email-antonynpavlov@gmail.com>
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51334
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
index 0000000..bf128a2
--- /dev/null
+++ b/arch/mips/boot/dts/qca/ar9331.dtsi
@@ -0,0 +1,123 @@
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
+				reg = <0x18050000 0x20>;
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
+};
-- 
2.6.2
