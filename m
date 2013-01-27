Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 27 Jan 2013 19:09:36 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:41602 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6833525Ab3A0SGwfkyrq (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 27 Jan 2013 19:06:52 +0100
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH V2 09/10] MIPS: ralink: adds rt305x devicetree
Date:   Sun, 27 Jan 2013 19:04:01 +0100
Message-Id: <1359309842-31925-10-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1359309842-31925-1-git-send-email-blogic@openwrt.org>
References: <1359309842-31925-1-git-send-email-blogic@openwrt.org>
X-archive-position: 35577
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

This adds the devicetree file that describes the rt305x evaluation kit.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/ralink/dts/rt305x.dts |  151 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 151 insertions(+)
 create mode 100644 arch/mips/ralink/dts/rt305x.dts

diff --git a/arch/mips/ralink/dts/rt305x.dts b/arch/mips/ralink/dts/rt305x.dts
new file mode 100644
index 0000000..3ee6086
--- /dev/null
+++ b/arch/mips/ralink/dts/rt305x.dts
@@ -0,0 +1,151 @@
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "ralink,rt305x";
+
+	cpus {
+		cpu@0 {
+			compatible = "mips,mips24KEc";
+		};
+	};
+
+	memory@0 {
+		reg = <0x0 0x2000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,57600 init=/init";
+	};
+
+	palmbus@10000000 {
+		compatible = "palmbus";
+		reg = <0x10000000 0x200000>;
+                ranges = <0x0 0x10000000 0x1FFFFF>;
+
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		sysc@0 {
+			compatible = "ralink,rt305x-sysc";
+			reg = <0x0 0x100>;
+
+			ralink,pinmmux = "uartlite", "spi";
+			ralink,uartmux = "gpio";
+			ralink,wdtmux = <0>;
+		};
+
+		timer@100 {
+			compatible = "ralink,rt305x-wdt";
+			reg = <0x100 0x100>;
+		};
+
+		intc: intc@200 {
+			compatible = "ralink,rt305x-intc";
+			reg = <0x200 0x100>;
+
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
+		memc@300 {
+			compatible = "ralink,rt305x-memc";
+			reg = <0x300 0x100>;
+		};
+
+		gpio0: gpio@600 {
+			compatible = "ralink,rt305x-gpio";
+			reg = <0x600 0x34>;
+
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			ralink,ngpio = <24>;
+			ralink,regs = [ 00 04 08 0c
+					20 24 28 2c
+					30 34 ];
+		};
+
+		gpio1: gpio@638 {
+			compatible = "ralink,rt305x-gpio";
+			reg = <0x638 0x24>;
+
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			ralink,ngpio = <16>;
+			ralink,regs = [ 00 04 08 0c
+					10 14 18 1c
+					20 24 ];
+		};
+
+		gpio2: gpio@660 {
+			compatible = "ralink,rt305x-gpio";
+			reg = <0x660 0x24>;
+
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			ralink,ngpio = <12>;
+			ralink,regs = [ 00 04 08 0c
+					10 14 18 1c
+					20 24 ];
+		};
+
+		spi@b00 {
+			compatible = "ralink,rt305x-spi";
+			reg = <0xb00 0x100>;
+		};
+
+		uartlite@c00 {
+			compatible = "ns16550a";
+			reg = <0xc00 0x100>;
+
+			interrupt-parent = <&intc>;
+			interrupts = <20>;
+
+			reg-shift = <2>;
+		};
+
+		fe@100000 {
+			compatible = "ralink,rt305x-fe";
+			reg = <0x100000 0x10000>;
+		};
+
+		esw@110000 {
+			compatible = "ralink,rt305x-esw";
+			reg = <0x110000 0x8000>;
+		};
+	};
+
+	cfi@1f000000 {
+		compatible = "cfi-flash";
+		reg = <0x1f000000 0x800000>;
+
+		bank-width = <2>;
+		device-width = <2>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		partition@0 {
+			label = "uboot";
+			reg = <0x0 0x30000>;
+			read-only;
+		};
+		partition@30000 {
+			label = "uboot-env";
+			reg = <0x30000 0x10000>;
+			read-only;
+		};
+		partition@40000 {
+			label = "calibration";
+			reg = <0x40000 0x10000>;
+			read-only;
+		};
+		partition@50000 {
+			label = "linux";
+			reg = <0x50000 0x7b0000>;
+		};
+	};
+};
-- 
1.7.10.4
