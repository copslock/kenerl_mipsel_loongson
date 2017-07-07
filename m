Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Jul 2017 18:12:59 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:24388 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993945AbdGGQMrGb7p- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Jul 2017 18:12:47 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 56104D1BEBC68;
        Fri,  7 Jul 2017 17:12:37 +0100 (IST)
Received: from LDT-H-Hunt.le.imgtec.org (192.168.154.107) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 7 Jul 2017 17:12:41 +0100
From:   Harvey Hunt <harvey.hunt@imgtec.com>
To:     <ralf@linux-mips.org>
CC:     Harvey Hunt <harvey.hunt@imgtec.com>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] MIPS: dts: Ci20: Add ethernet and fixed-regulator nodes
Date:   Fri, 7 Jul 2017 17:12:08 +0100
Message-ID: <1499443928-10620-2-git-send-email-harvey.hunt@imgtec.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1499443928-10620-1-git-send-email-harvey.hunt@imgtec.com>
References: <1499443928-10620-1-git-send-email-harvey.hunt@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.107]
Return-Path: <Harvey.Hunt@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59056
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: harvey.hunt@imgtec.com
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

Add devicetree nodes for the DM9000 and the ethernet power regulator.
Additionally, add a new pinctrl node for the ethernet chip's pins.

Signed-off-by: Harvey Hunt <harvey.hunt@imgtec.com>
Cc: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: Rob Herring <robh+dt@kernel.org> 
Cc: Mark Rutland <mark.rutland@arm.com> 
Cc: Paul Cercueil <paul@crapouillou.net> 
Cc: Linus Walleij <linus.walleij@linaro.org> 
Cc: devicetree@vger.kernel.org 
Cc: linux-mips@linux-mips.org 
Cc: linux-kernel@vger.kernel.org 
---
Ralf, both of these patches rely on Paul Cercueil's pinctrl
and gpio patches from Linus Walleij's 4.13 pinctrl pull request.

 arch/mips/boot/dts/ingenic/ci20.dts | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/mips/boot/dts/ingenic/ci20.dts b/arch/mips/boot/dts/ingenic/ci20.dts
index fd138d99..6c38184 100644
--- a/arch/mips/boot/dts/ingenic/ci20.dts
+++ b/arch/mips/boot/dts/ingenic/ci20.dts
@@ -1,6 +1,7 @@
 /dts-v1/;
 
 #include "jz4780.dtsi"
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	compatible = "img,ci20", "ingenic,jz4780";
@@ -21,6 +22,13 @@
 		reg = <0x0 0x10000000
 		       0x30000000 0x30000000>;
 	};
+
+	eth0_power: fixedregulator@0 {
+		compatible = "regulator-fixed";
+		regulator-name = "eth0_power";
+		gpio = <&gpb 25 GPIO_ACTIVE_LOW>;
+		enable-active-high;
+	};
 };
 
 &ext {
@@ -123,6 +131,29 @@
 			};
 		};
 	};
+
+	dm9000@6 {
+		compatible = "davicom,dm9000";
+		davicom,no-eeprom;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&pins_nemc_cs6>;
+
+		reg = <6 0 1   /* addr */
+		       6 2 1>; /* data */
+
+		ingenic,nemc-tAS = <15>;
+		ingenic,nemc-tAH = <10>;
+		ingenic,nemc-tBP = <20>;
+		ingenic,nemc-tAW = <50>;
+		ingenic,nemc-tSTRV = <100>;
+
+		reset-gpios = <&gpf 12 GPIO_ACTIVE_HIGH>;
+		vcc-supply = <&eth0_power>;
+
+		interrupt-parent = <&gpe>;
+		interrupts = <19 4>;
+	};
 };
 
 &bch {
@@ -165,4 +196,10 @@
 		groups = "nemc-cs1";
 		bias-disable;
 	};
+
+	pins_nemc_cs6: nemc-cs6 {
+		function = "nemc-cs6";
+		groups = "nemc-cs6";
+		bias-disable;
+	};
 };
-- 
2.7.4
