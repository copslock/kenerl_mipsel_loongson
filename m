Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jan 2017 19:54:08 +0100 (CET)
Received: from outils.crapouillou.net ([89.234.176.41]:53698 "EHLO
        outils.crapouillou.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993945AbdAYSwoF4i3w (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Jan 2017 19:52:44 +0100
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
Subject: [PATCH v3 09/14] MIPS: JZ4780: CI20: Add pinctrl configuration for several drivers
Date:   Wed, 25 Jan 2017 19:52:02 +0100
Message-Id: <20170125185207.23902-10-paul@crapouillou.net>
In-Reply-To: <20170125185207.23902-1-paul@crapouillou.net>
References: <27071da2f01d48141e8ac3dfaa13255d@mail.crapouillou.net>
 <20170125185207.23902-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1485370362; bh=+3NCaoUaUgVnQ8rvgn/NyjELzfkGHIu3FXdSYUbUrKo=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=x9JD3d0DTA00KO1UhaDrC7paeKwcaoPo5us/VH83Qo2945d80rbtSp027VQrkdbSHIOef0t2Q3Igx9J54qUEkg8hiKbjLSvfZPc8r5OZuOKvVpQaPCHoB5GgB8ECdRq51MD83LlOXz7nz6EiwsN+OAYBnasrcY3Q/k6t5AcoVts=
Return-Path: <paul@outils.crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56496
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

We set the pin configuration for the jz4780-nand and jz4780-uart
drivers.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 arch/mips/boot/dts/ingenic/ci20.dts | 60 +++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

v2: Changed the devicetree bindings to match the new driver
v3: No changes

diff --git a/arch/mips/boot/dts/ingenic/ci20.dts b/arch/mips/boot/dts/ingenic/ci20.dts
index 1652d8d60b1e..fd138d9978c1 100644
--- a/arch/mips/boot/dts/ingenic/ci20.dts
+++ b/arch/mips/boot/dts/ingenic/ci20.dts
@@ -29,18 +29,30 @@
 
 &uart0 {
 	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pins_uart0>;
 };
 
 &uart1 {
 	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pins_uart1>;
 };
 
 &uart3 {
 	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pins_uart2>;
 };
 
 &uart4 {
 	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pins_uart4>;
 };
 
 &nemc {
@@ -61,6 +73,13 @@
 		ingenic,nemc-tAW = <15>;
 		ingenic,nemc-tSTRV = <100>;
 
+		/*
+		 * Only CLE/ALE are needed for the devices that are connected, rather
+		 * than the full address line set.
+		 */
+		pinctrl-names = "default";
+		pinctrl-0 = <&pins_nemc>;
+
 		nand@1 {
 			reg = <1>;
 
@@ -69,6 +88,9 @@
 			nand-ecc-mode = "hw";
 			nand-on-flash-bbt;
 
+			pinctrl-names = "default";
+			pinctrl-0 = <&pins_nemc_cs1>;
+
 			partitions {
 				compatible = "fixed-partitions";
 				#address-cells = <2>;
@@ -106,3 +128,41 @@
 &bch {
 	status = "okay";
 };
+
+&pinctrl {
+	pins_uart0: uart0 {
+		function = "uart0";
+		groups = "uart0-data";
+		bias-disable;
+	};
+
+	pins_uart1: uart1 {
+		function = "uart1";
+		groups = "uart1-data";
+		bias-disable;
+	};
+
+	pins_uart2: uart2 {
+		function = "uart2";
+		groups = "uart2-data", "uart2-hwflow";
+		bias-disable;
+	};
+
+	pins_uart4: uart4 {
+		function = "uart4";
+		groups = "uart4-data";
+		bias-disable;
+	};
+
+	pins_nemc: nemc {
+		function = "nemc";
+		groups = "nemc-data", "nemc-cle-ale", "nemc-rd-we", "nemc-frd-fwe";
+		bias-disable;
+	};
+
+	pins_nemc_cs1: nemc-cs1 {
+		function = "nemc-cs1";
+		groups = "nemc-cs1";
+		bias-disable;
+	};
+};
-- 
2.11.0
