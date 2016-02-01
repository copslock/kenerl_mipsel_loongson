Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Feb 2016 23:41:22 +0100 (CET)
Received: from exsmtp01.microchip.com ([198.175.253.37]:55388 "EHLO
        email.microchip.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27012023AbcBAWlVPhMKJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Feb 2016 23:41:21 +0100
Received: from mx.microchip.com (10.10.76.4) by CHN-SV-EXCH01.mchp-main.com
 (10.10.76.37) with Microsoft SMTP Server id 14.3.181.6; Mon, 1 Feb 2016
 15:41:13 -0700
Received: by mx.microchip.com (sSMTP sendmail emulation); Mon, 01 Feb 2016
 15:45:03 -0700
From:   Joshua Henderson <joshua.henderson@microchip.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <linux-mips@linux-mips.org>,
        Purna Chandra Mandal <purna.mandal@microchip.com>,
        Joshua Henderson <joshua.henderson@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, <devicetree@vger.kernel.org>
Subject: [PATCH 1/2] dt/bindings: Add bindings for the PIC32 SPI peripheral
Date:   Mon, 1 Feb 2016 15:44:56 -0700
Message-ID: <1454366701-10847-1-git-send-email-joshua.henderson@microchip.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <Joshua.Henderson@microchip.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51598
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joshua.henderson@microchip.com
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

From: Purna Chandra Mandal <purna.mandal@microchip.com>

Document the devicetree bindings for the SPI peripheral found
on Microchip PIC32 class devices.

Signed-off-by: Purna Chandra Mandal <purna.mandal@microchip.com>
Signed-off-by: Joshua Henderson <joshua.henderson@microchip.com>
---
 .../bindings/spi/microchip,spi-pic32.txt           |   44 ++++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/microchip,spi-pic32.txt

diff --git a/Documentation/devicetree/bindings/spi/microchip,spi-pic32.txt b/Documentation/devicetree/bindings/spi/microchip,spi-pic32.txt
new file mode 100644
index 0000000..a555618
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/microchip,spi-pic32.txt
@@ -0,0 +1,44 @@
+* Microchip PIC32 SPI device
+
+Required properties:
+- compatible: Should be "microchip,pic32mzda-spi".
+- reg: Address and length of the register set for the device
+- interrupts: Should contain all three spi interrupts in sequence
+              of <fault-irq>, <receive-irq>, <transmit-irq>.
+- interrupt-names: Should be "fault","rx","tx" in order.
+- clocks: phandles of baud generation clocks. Maximum two possible clocks
+	  can be provided (&PBCLK2, &REFCLKO1).
+          See: Documentation/devicetree/bindings/clock/clock-bindings.txt
+- clock-names: Should be "mck0","mck1".
+               See: Documentation/devicetree/bindings/resource-names.txt
+- pinctrl-names: A pinctrl state names "default" must be defined.
+- pinctrl-0: Phandle referencing pin configuration of the SPI peripheral.
+             See: Documentation/devicetree/bindings/pinctrl/pinctrl-binding.txt
+
+Optional properties:
+- cs-gpios: List of GPIO chip selects. See ../spi/spi-bus.txt
+            See: Documentation/devicetree/bindings/spi/spi-bus.txt
+- dmas: Two or more DMA channel specifiers following the convention outlined
+        in Documentation/devicetree/bindings/dma/dma.txt
+- dma-names: Names for the dma channels. There must be at least one channel
+             named "spi-tx" for transmit and named "spi-rx" for receive.
+
+Example:
+
+	spi1:spi@0x1f821000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "microchip,pic32mzda-spi";
+		reg = <0x1f821000 0x200>;
+		interrupts = <109 IRQ_TYPE_LEVEL_HIGH>,
+			<110 IRQ_TYPE_LEVEL_HIGH>,
+			<111 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "fault", "rx", "tx";
+		clocks = <&PBCLK2>, <&REFCLKO1>;
+		clock-names = "mck0", "mck1";
+		dmas = <&dma 134>,
+			<&dma 135>;
+		dma-names = "spi-rx", "spi-tx";
+		cs-gpios = <&gpio3 0 GPIO_ACTIVE_LOW>,
+			<&gpio3 14 GPIO_ACTIVE_LOW>;
+	};
-- 
1.7.9.5
