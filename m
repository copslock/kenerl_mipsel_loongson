Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Aug 2014 03:05:11 +0200 (CEST)
Received: from test.hauke-m.de ([5.39.93.123]:41409 "EHLO test.hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006623AbaHYBDBlzv2p (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 25 Aug 2014 03:03:01 +0200
Received: from hauke-desktop.lan (spit-414.wohnheim.uni-bremen.de [134.102.133.158])
        by test.hauke-m.de (Postfix) with ESMTPSA id D18B820980;
        Sun, 24 Aug 2014 23:25:20 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org
Cc:     zajec5@gmail.com, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [RFC 7/7] ARM: BCM5301X: register bcma bus
Date:   Sun, 24 Aug 2014 23:24:45 +0200
Message-Id: <1408915485-8078-9-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1408915485-8078-1-git-send-email-hauke@hauke-m.de>
References: <1408915485-8078-1-git-send-email-hauke@hauke-m.de>
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42208
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

---
 arch/arm/boot/dts/bcm4708.dtsi | 58 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/arch/arm/boot/dts/bcm4708.dtsi b/arch/arm/boot/dts/bcm4708.dtsi
index 31141e8..7c240ab 100644
--- a/arch/arm/boot/dts/bcm4708.dtsi
+++ b/arch/arm/boot/dts/bcm4708.dtsi
@@ -31,4 +31,62 @@
 		};
 	};
 
+	nvram0: nvram@0 {
+		compatible = "brcm,bcm47xx-nvram";
+		reg = <0x1c000000 0x01000000>;
+	};
+
+	sprom0: sprom@0 {
+		compatible = "brcm,bcm47xx-sprom";
+		nvram = <&nvram0>;
+	};
+
+	aix@18000000 {
+		compatible = "brcm,bus-aix";
+		reg = <0x18000000 0x1000>;
+		ranges = <0x00000000 0x18000000 0x00100000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		sprom = <&sprom0>;
+
+		usb2@0 {
+			reg = <0x18021000 0x1000>;
+			interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		usb3@0 {
+			reg = <0x18023000 0x1000>;
+			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		gmac@0 {
+			reg = <0x18024000 0x1000>;
+			interrupts = <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		gmac@1 {
+			reg = <0x18025000 0x1000>;
+			interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		gmac@2 {
+			reg = <0x18026000 0x1000>;
+			interrupts = <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		gmac@3 {
+			reg = <0x18027000 0x1000>;
+			interrupts = <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		pcie@0 {
+			reg = <0x18012000 0x1000>;
+			interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		pcie@1 {
+			reg = <0x18013000 0x1000>;
+			interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
+		};
+	};
 };
-- 
1.9.1
