Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Jan 2017 00:20:00 +0100 (CET)
Received: from outils.crapouillou.net ([89.234.176.41]:35052 "EHLO
        outils.crapouillou.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993967AbdAQXPlkNbpA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Jan 2017 00:15:41 +0100
From:   Paul Cercueil <paul@crapouillou.net>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Maarten ter Huurne <maarten@treewalker.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Burton <paul.burton@imgtec.com>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org,
        james.hogan@imgtec.com, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 08/13] MIPS: JZ4780: CI20: Add pinctrl configuration for several drivers
Date:   Wed, 18 Jan 2017 00:14:16 +0100
Message-Id: <20170117231421.16310-9-paul@crapouillou.net>
In-Reply-To: <20170117231421.16310-1-paul@crapouillou.net>
References: <20170117231421.16310-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1484694911; bh=Q1LyBbJWdHoGU3/Z9ivLJre+vSvkjSbdKFlVLvHAw8s=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=SAuZAdZV78aLXNHZaEnD0phzOdsVDwpRx17DnEHFWvoaQSQFHJDcEhVXnbFU7zyWM/kRjbeYjbeCqJ2iYlzJmvIHJaV8FyHBtFVKIq8Hp0MA7EaXZA7FBzMWZZJIim5T37yV+VHkXLHr+CDG/fDxPjAdVuVsws46wr2VCYXtCpw=
Return-Path: <paul@outils.crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56381
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
 arch/mips/boot/dts/ingenic/ci20.dts | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/mips/boot/dts/ingenic/ci20.dts b/arch/mips/boot/dts/ingenic/ci20.dts
index 1652d8d60b1e..e2cd3ebb7be8 100644
--- a/arch/mips/boot/dts/ingenic/ci20.dts
+++ b/arch/mips/boot/dts/ingenic/ci20.dts
@@ -29,18 +29,30 @@
 
 &uart0 {
 	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pins_uart0_data>;
 };
 
 &uart1 {
 	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pins_uart1_data>;
 };
 
 &uart3 {
 	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pins_uart2_dataplusflow>;
 };
 
 &uart4 {
 	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pins_uart4_data>;
 };
 
 &nemc {
@@ -61,6 +73,16 @@
 		ingenic,nemc-tAW = <15>;
 		ingenic,nemc-tSTRV = <100>;
 
+		/*
+		 * Only CLE/ALE are needed for the devices that are connected, rather
+		 * than the full address line set.
+		 */
+		pinctrl-names = "default";
+		pinctrl-0 = <&pins_nemc_data
+				 &pins_nemc_cle_ale
+				 &pins_nemc_rd_we
+				 &pins_nemc_frd_fwe>;
+
 		nand@1 {
 			reg = <1>;
 
@@ -69,6 +91,9 @@
 			nand-ecc-mode = "hw";
 			nand-on-flash-bbt;
 
+			pinctrl-names = "default";
+			pinctrl-0 = <&pins_nemc_cs1>;
+
 			partitions {
 				compatible = "fixed-partitions";
 				#address-cells = <2>;
-- 
2.11.0
