Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Jan 2017 15:54:34 +0100 (CET)
Received: from outils.crapouillou.net ([89.234.176.41]:53174 "EHLO
        outils.crapouillou.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993881AbdAVOvDvfZpb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 22 Jan 2017 15:51:03 +0100
From:   Paul Cercueil <paul@crapouillou.net>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Boris Brezillon <boris.brezillon@free-electrons.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Maarten ter Huurne <maarten@treewalker.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Burton <paul.burton@imgtec.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org,
        james.hogan@imgtec.com, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 07/14] MIPS: jz4780: DTS: Add nodes for ingenic pinctrl and gpio drivers
Date:   Sun, 22 Jan 2017 15:49:40 +0100
Message-Id: <20170122144947.16158-8-paul@crapouillou.net>
In-Reply-To: <20170122144947.16158-1-paul@crapouillou.net>
References: <27071da2f01d48141e8ac3dfaa13255d@mail.crapouillou.net>
 <20170122144947.16158-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1485096633; bh=YuuqexmAG68bIawjtOJxbwISLQ1AfHcliyjFE1Ay01c=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=bf5RVTjTYWCFaG9VupelWlVcgjND2p+grAthB16tamnCqGZHaCjBj5HnF9QT3OyjBcna9q/9hpMc2O+lKEtbvC4P+brb8YuixyE1nLmJ1pQM+WzMD+TSkWBCnGjG74jMvIT4Ehyk5Lab33e/5XkEXXrsRzCQf3UoK3OHIFwHqRg=
Return-Path: <paul@outils.crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56451
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul@crapouillou.net
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

For a description of the devicetree node, please read
Documentation/devicetree/bindings/pinctrl/ingenic,pinctrl.txt

For a description of the gpio devicetree nodes, please read
Documentation/devicetree/bindings/gpio/ingenic,gpio.txt

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 arch/mips/boot/dts/ingenic/jz4780.dtsi | 297 +++++++++++++++++++++++++++++++++
 1 file changed, 297 insertions(+)

v2: Changed the devicetree bindings to match the new driver

diff --git a/arch/mips/boot/dts/ingenic/jz4780.dtsi b/arch/mips/boot/dts/ingenic/jz4780.dtsi
index b868b429add2..47e079e9236e 100644
--- a/arch/mips/boot/dts/ingenic/jz4780.dtsi
+++ b/arch/mips/boot/dts/ingenic/jz4780.dtsi
@@ -44,6 +44,303 @@
 		#clock-cells = <1>;
 	};
 
+	pinctrl: ingenic-pinctrl@10010000 {
+		compatible = "ingenic,jz4780-pinctrl";
+		reg = <0x10010000 0x600>;
+
+		ingenic,pull-ups   = <0x3fffffff 0xfff0030c 0xffffffff
+							  0xffff4fff 0xfffffb7c 0xffa7f00f>;
+		ingenic,pull-downs = <0x00000000 0x000f0c03 0x00000000
+							  0x0000b000 0x00000483 0x00580ff0>;
+
+		functions {
+			uart0 {
+				uart0-data {
+					/* RXD, TXD */
+					ingenic,pins = <0xa0 0 0xa3 0>;
+				};
+
+				uart0-hwflow {
+					/* CTS, RTS */
+					ingenic,pins = <0xa1 0 0xa2 0>;
+				};
+			};
+
+			uart1 {
+				uart1-data {
+					/* RXD, TXD */
+					ingenic,pins = <0x7a 0 0x7c 0>;
+				};
+
+				uart1-hwflow {
+					/* CTS, RTS */
+					ingenic,pins = <0x7b 0 0x7d 0>;
+				};
+			};
+
+			uart2 {
+				uart2-data {
+					/* RXD, TXD */
+					ingenic,pins = <0x66 1 0x67 1>;
+				};
+
+				uart2-hwflow {
+					/* CTS, RTS */
+					ingenic,pins = <0x65 1 0x64 1>;
+				};
+			};
+
+			uart3 {
+				uart3-data {
+					/* RXD, TXD */
+					ingenic,pins = <0x6c 0 0x85 1>;
+				};
+
+				uart3-hwflow {
+					/* CTS, RTS */
+					ingenic,pins = <0x88 0 0x89 0>;
+				};
+			};
+
+			uart4 {
+				uart4-data {
+					/* RXD, TXD */
+					ingenic,pins = <0x54 2 0x4a 2>;
+				};
+			};
+
+			msc0 {
+				msc0-8bit-a {
+					/* D4, D5, D6, D7, RST */
+					ingenic,pins = <0x04 1 0x05 1 0x06 1 0x07 1
+									0x18 1>;
+				};
+
+				msc0-4bit-a {
+					/* D1, D2, D3 */
+					ingenic,pins = <0x15 1 0x16 1 0x17 1>;
+				};
+
+				msc0-1bit-a {
+					/* CLK, CMD, D0 */
+					ingenic,pins = <0x12 1 0x13 1 0x14 1>;
+				};
+
+				msc0-1bit-e {
+					/* CLK, CMD, D0 */
+					ingenic,pins = <0x9c 0 0x9d 0 0x94 0>;
+				};
+
+				msc0-4bit-e {
+					/* D1, D2, D3 */
+					ingenic,pins = <0x95 0 0x96 0 0x97 0>;
+				};
+			};
+
+			msc1 {
+				msc1-1bit-d {
+					/* CLK, CMD, D0 */
+					ingenic,pins = <0x78 0 0x79 0 0x74 0>;
+				};
+
+				msc1-4bit-d {
+					/* D1, D2, D3 */
+					ingenic,pins = <0x75 0 0x76 0 0x77 0>;
+				};
+
+				msc1-1bit-e {
+					/* CLK, CMD, D0 */
+					ingenic,pins = <0x9c 1 0x9d 1 0x94 1>;
+				};
+
+				msc1-4bit-e {
+					/* D1, D2, D3 */
+					ingenic,pins = <0x95 1 0x96 1 0x97 1>;
+				};
+			};
+
+			nemc {
+				nemc-data {
+					/* SD0, SD1, SD2, SD3, SD4, SD5, SD6, SD7 */
+					ingenic,pins = <0x00 0 0x01 0 0x02 0 0x03 0
+									0x04 0 0x05 0 0x06 0 0x07 0>;
+				};
+
+				nemc-cle-ale {
+					/* SA0_CL, SA1_AL */
+					ingenic,pins = <0x20 0 0x21 0>;
+				};
+
+				nemc-addr {
+					/* SA2, SA3, SA4, SA5 */
+					ingenic,pins = <0x22 0 0x23 0 0x24 0 0x25 0>;
+				};
+
+				nemc-rd-we {
+					/* RD, WE */
+					ingenic,pins = <0x10 0 0x11 0>;
+				};
+
+				nemc-frd-fwe {
+					/* RD, WE */
+					ingenic,pins = <0x12 0 0x13 0>;
+				};
+			};
+
+			nemc-cs1 {
+				nemc-cs1 {
+					/* CS1 */
+					ingenic,pins = <0x15 0>;
+				};
+			};
+
+			nemc-cs6 {
+				nemc-cs6 {
+					/* CS6 */
+					ingenic,pins = <0x1a 0>;
+				};
+			};
+
+			i2c0 {
+				i2c0-data {
+					/* SDA, SCL */
+					ingenic,pins = <0x6e 0 0x6f 0>;
+				};
+			};
+
+			i2c1 {
+				i2c1-data {
+					/* SDA, SCL */
+					ingenic,pins = <0x8e 0 0x8f 0>;
+				};
+			};
+
+			i2c2 {
+				i2c2-data {
+					/* SDA, SCL */
+					ingenic,pins = <0xb0 2 0xb1 2>;
+				};
+			};
+
+			i2c3 {
+				i2c3-data {
+					/* SDA, SCL */
+					ingenic,pins = <0x6a 1 0x6b 1>;
+				};
+			};
+
+			i2c4 {
+				i2c4-data-pe {
+					/* SDA, SCL */
+					ingenic,pins = <0x8c 1 0x8d 1>;
+				};
+
+				i2c4-data-pf {
+					/* HDMI_SDA, HDMI_SCL */
+					ingenic,pins = <0xb9 1 0xb8 1>;
+				};
+			};
+
+			cim {
+				cim-pb {
+					ingenic,pins = <0x26 0 0x27 0 0x28 0 0x29 0
+									0x2a 0 0x2b 0 0x2c 0 0x2d 0
+									0x2e 0 0x2f 0 0x30 0 0x31 0>;
+				};
+			};
+		};
+	};
+
+	gpa: gpio-controller@10010000 {
+		compatible = "ingenic,jz4780-gpio";
+		reg = <0x10010000 0x100>;
+
+		gpio-controller;
+		gpio-ranges = <&pinctrl 0 0 32>;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <17>;
+	};
+
+	gpb: gpio-controller@10010100 {
+		compatible = "ingenic,jz4780-gpio";
+		reg = <0x10010100 0x100>;
+
+		gpio-controller;
+		gpio-ranges = <&pinctrl 0 32 32>;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <16>;
+	};
+
+	gpc: gpio-controller@10010200 {
+		compatible = "ingenic,jz4780-gpio";
+		reg = <0x10010200 0x100>;
+
+		gpio-controller;
+		gpio-ranges = <&pinctrl 0 64 32>;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <15>;
+	};
+
+	gpd: gpio-controller@10010300 {
+		compatible = "ingenic,jz4780-gpio";
+		reg = <0x10010300 0x100>;
+
+		gpio-controller;
+		gpio-ranges = <&pinctrl 0 96 32>;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <14>;
+	};
+
+	gpe: gpio-controller@10010400 {
+		compatible = "ingenic,jz4780-gpio";
+		reg = <0x10010400 0x100>;
+
+		gpio-controller;
+		gpio-ranges = <&pinctrl 0 128 32>;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <13>;
+	};
+
+	gpf: gpio-controller@10010500 {
+		compatible = "ingenic,jz4780-gpio";
+		reg = <0x10010500 0x100>;
+
+		gpio-controller;
+		gpio-ranges = <&pinctrl 0 160 32>;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <12>;
+	};
+
 	uart0: serial@10030000 {
 		compatible = "ingenic,jz4780-uart";
 		reg = <0x10030000 0x100>;
-- 
2.11.0
