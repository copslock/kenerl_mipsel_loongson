Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Apr 2017 22:13:25 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:43092 "EHLO
        outils.crapouillou.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993942AbdD1UJbhUrbE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 28 Apr 2017 22:09:31 +0200
From:   Paul Cercueil <paul@crapouillou.net>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Boris Brezillon <boris.brezillon@free-electrons.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Maarten ter Huurne <maarten@treewalker.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Burton <paul.burton@imgtec.com>, james.hogan@imgtec.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v5 07/14] MIPS: jz4780: DTS: Add nodes for ingenic pinctrl and gpio drivers
Date:   Fri, 28 Apr 2017 22:08:17 +0200
Message-Id: <20170428200824.10906-8-paul@crapouillou.net>
In-Reply-To: <20170428200824.10906-1-paul@crapouillou.net>
References: <20170402204244.14216-2-paul@crapouillou.net>
 <20170428200824.10906-1-paul@crapouillou.net>
Return-Path: <paul@outils.crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57831
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
 arch/mips/boot/dts/ingenic/jz4780.dtsi | 98 ++++++++++++++++++++++++++++++++++
 1 file changed, 98 insertions(+)

 v2: Changed the devicetree bindings to match the new driver
 v3: No changes
 v4: Update the bindings for the v4 version of the drivers
 v5: Add 'reg' properties and rename pinctrl/gpio nodes

diff --git a/arch/mips/boot/dts/ingenic/jz4780.dtsi b/arch/mips/boot/dts/ingenic/jz4780.dtsi
index b868b429add2..4853ef67b3ab 100644
--- a/arch/mips/boot/dts/ingenic/jz4780.dtsi
+++ b/arch/mips/boot/dts/ingenic/jz4780.dtsi
@@ -44,6 +44,104 @@
 		#clock-cells = <1>;
 	};
 
+	pinctrl: pin-controller@10010000 {
+		compatible = "ingenic,jz4780-pinctrl";
+		reg = <0x10010000 0x600>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		gpa: gpio@0 {
+			compatible = "ingenic,jz4780-gpio";
+			reg = <0>;
+
+			gpio-controller;
+			gpio-ranges = <&pinctrl 0 0 32>;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+
+			interrupt-parent = <&intc>;
+			interrupts = <17>;
+		};
+
+		gpb: gpio@1 {
+			compatible = "ingenic,jz4780-gpio";
+			reg = <1>;
+
+			gpio-controller;
+			gpio-ranges = <&pinctrl 0 32 32>;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+
+			interrupt-parent = <&intc>;
+			interrupts = <16>;
+		};
+
+		gpc: gpio@2 {
+			compatible = "ingenic,jz4780-gpio";
+			reg = <2>;
+
+			gpio-controller;
+			gpio-ranges = <&pinctrl 0 64 32>;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+
+			interrupt-parent = <&intc>;
+			interrupts = <15>;
+		};
+
+		gpd: gpio@3 {
+			compatible = "ingenic,jz4780-gpio";
+			reg = <3>;
+
+			gpio-controller;
+			gpio-ranges = <&pinctrl 0 96 32>;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+
+			interrupt-parent = <&intc>;
+			interrupts = <14>;
+		};
+
+		gpe: gpio@4 {
+			compatible = "ingenic,jz4780-gpio";
+			reg = <4>;
+
+			gpio-controller;
+			gpio-ranges = <&pinctrl 0 128 32>;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+
+			interrupt-parent = <&intc>;
+			interrupts = <13>;
+		};
+
+		gpf: gpio@5 {
+			compatible = "ingenic,jz4780-gpio";
+			reg = <5>;
+
+			gpio-controller;
+			gpio-ranges = <&pinctrl 0 160 32>;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+
+			interrupt-parent = <&intc>;
+			interrupts = <12>;
+		};
+	};
+
 	uart0: serial@10030000 {
 		compatible = "ingenic,jz4780-uart";
 		reg = <0x10030000 0x100>;
-- 
2.11.0
