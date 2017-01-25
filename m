Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jan 2017 19:53:22 +0100 (CET)
Received: from outils.crapouillou.net ([89.234.176.41]:52106 "EHLO
        outils.crapouillou.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993885AbdAYSwgY5bUw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Jan 2017 19:52:36 +0100
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
Subject: [PATCH v3 06/14] MIPS: jz4740: DTS: Add nodes for ingenic pinctrl and gpio drivers
Date:   Wed, 25 Jan 2017 19:51:59 +0100
Message-Id: <20170125185207.23902-7-paul@crapouillou.net>
In-Reply-To: <20170125185207.23902-1-paul@crapouillou.net>
References: <27071da2f01d48141e8ac3dfaa13255d@mail.crapouillou.net>
 <20170125185207.23902-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1485370355; bh=xvvA87E3tsxNvgSmAV43LSOckxrJaQKqmeg5bmIGfqo=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Z9KKQdTM3uNF6BZFMeRqh+hbB6sa/v2H8H1eUrIi+v+soZeBDVRxcn2SITgbBMNYdybLDtnarAWWzkTQaJwdgS8tek13mQ+yj+TOTM+hQP53XnovsJPyQcNWwo6VGxONlp1GColWT/LwgVPQiAeBd6MzQXqXIne9FEd4x8yoa34=
Return-Path: <paul@outils.crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56494
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

For a description of the pinctrl devicetree node, please read
Documentation/devicetree/bindings/pinctrl/ingenic,pinctrl.txt

For a description of the gpio devicetree nodes, please read
Documentation/devicetree/bindings/gpio/ingenic,gpio.txt

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 arch/mips/boot/dts/ingenic/jz4740.dtsi | 194 +++++++++++++++++++++++++++++++++
 1 file changed, 194 insertions(+)

v2: Changed the devicetree bindings to match the new driver
v3: No changes

diff --git a/arch/mips/boot/dts/ingenic/jz4740.dtsi b/arch/mips/boot/dts/ingenic/jz4740.dtsi
index 3e1587f1f77a..960e060eb725 100644
--- a/arch/mips/boot/dts/ingenic/jz4740.dtsi
+++ b/arch/mips/boot/dts/ingenic/jz4740.dtsi
@@ -55,6 +55,200 @@
 		clock-names = "rtc";
 	};
 
+	pinctrl: ingenic-pinctrl@10010000 {
+		compatible = "ingenic,jz4740-pinctrl";
+		reg = <0x10010000 0x400>;
+
+		ingenic,pull-ups   = <0xffffffff 0xffffffff 0xffffffff 0xdfffffff>;
+		ingenic,pull-downs = <0x00000000 0x00000000 0x00000000 0x00000000>;
+
+		functions {
+			mmc {
+				mmc-1bit {
+					/* CLK, CMD, D0 */
+					ingenic,pins = <0x69 0 0x68 0 0x6a 0>;
+				};
+
+				mmc-4bit {
+					/* D1, D2, D3 */
+					ingenic,pins = <0x6b 0 0x6c 0 0x6d 0>;
+				};
+			};
+
+			uart0 {
+				uart0-data {
+					/* RXD, TXD */
+					ingenic,pins = <0x7a 1 0x79 1>;
+				};
+
+				uart0-hwflow {
+					/* CTS, RTS */
+					ingenic,pins = <0x7e 1 0x7f 1>;
+				};
+			};
+
+			uart1 {
+				uart1-data {
+					/* RXD, TXD */
+					ingenic,pins = <0x7e 2 0x7f 2>;
+				};
+			};
+
+			lcd {
+				lcd-8bit {
+					/* LCD_DATA0 ... LCD_DATA7, PCLK, HSYNC, VSYNC */
+					ingenic,pins = <0x40 0 0x41 0 0x42 0 0x43 0
+									0x44 0 0x45 0 0x46 0 0x47 0
+									0x52 0 0x53 0 0x54 0>;
+				};
+
+				lcd-16bit {
+					/* LCD_DATA8 ... LCD_DATA15, DE */
+					ingenic,pins = <0x48 0 0x49 0 0x4a 0 0x4b 0
+									0x4c 0 0x4d 0 0x4e 0 0x4f 0
+									0x55 0>;
+				};
+
+				lcd-18bit {
+					/* LCD_DATA16, LCD_DATA17 */
+					ingenic,pins = <0x50 0 0x51 0>;
+				};
+
+				lcd-18bit-tft {
+					/* PS, REV, CLS, SPL */
+					ingenic,pins = <0x56 0 0x57 0 0x31 0 0x32 0>;
+				};
+
+				lcd-no-pins {
+					ingenic,pins = <>;
+				};
+			};
+
+			nand {
+				nand {
+					/* CS1, CS2, CS3, CS4 */
+					ingenic,pins = <0x39 0 0x3a 0 0x3b 0 0x3c 0>;
+				};
+			};
+
+			pwm0 {
+				pwm0 {
+					ingenic,pins = <0x77 0>;
+				};
+			};
+
+			pwm1 {
+				pwm1 {
+					ingenic,pins = <0x78 0>;
+				};
+			};
+
+			pwm2 {
+				pwm2 {
+					ingenic,pins = <0x79 0>;
+				};
+			};
+
+			pwm3 {
+				pwm3 {
+					ingenic,pins = <0x7a 0>;
+				};
+			};
+
+			pwm4 {
+				pwm4 {
+					ingenic,pins = <0x7b 0>;
+				};
+			};
+
+			pwm5 {
+				pwm5 {
+					ingenic,pins = <0x7c 0>;
+				};
+			};
+
+			pwm6 {
+				pwm6 {
+					ingenic,pins = <0x7e 0>;
+				};
+			};
+
+			pwm7 {
+				pwm7 {
+					ingenic,pins = <0x7f 0>;
+				};
+			};
+		};
+	};
+
+	gpa: gpio-controller@10010000 {
+		compatible = "ingenic,jz4740-gpio";
+		reg = <0x10010000 0x100>;
+
+		gpio-controller;
+		gpio-ranges = <&pinctrl 0 0 32>;
+		#gpio-cells = <2>;
+
+		base = <0x00>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <28>;
+	};
+
+	gpb: gpio-controller@10010100 {
+		compatible = "ingenic,jz4740-gpio";
+		reg = <0x10010100 0x100>;
+
+		gpio-controller;
+		gpio-ranges = <&pinctrl 0 32 32>;
+		#gpio-cells = <2>;
+
+		base = <0x20>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <27>;
+	};
+
+	gpc: gpio-controller@10010200 {
+		compatible = "ingenic,jz4740-gpio";
+		reg = <0x10010200 0x100>;
+
+		gpio-controller;
+		gpio-ranges = <&pinctrl 0 64 32>;
+		#gpio-cells = <2>;
+
+		base = <0x40>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <26>;
+	};
+
+	gpd: gpio-controller@10010300 {
+		compatible = "ingenic,jz4740-gpio";
+		reg = <0x10010300 0x100>;
+
+		gpio-controller;
+		gpio-ranges = <&pinctrl 0 96 32>;
+		#gpio-cells = <2>;
+
+		base = <0x60>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <25>;
+	};
+
 	uart0: serial@10030000 {
 		compatible = "ingenic,jz4740-uart";
 		reg = <0x10030000 0x100>;
-- 
2.11.0
