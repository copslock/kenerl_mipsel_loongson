Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 06 Mar 2016 05:37:30 +0100 (CET)
Received: from exsmtp03.microchip.com ([198.175.253.49]:29075 "EHLO
        email.microchip.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27005160AbcCFEh3A3rQg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 6 Mar 2016 05:37:29 +0100
Received: from mx.microchip.com (10.10.76.4) by chn-sv-exch03.mchp-main.com
 (10.10.76.49) with Microsoft SMTP Server id 14.3.181.6; Sat, 5 Mar 2016
 21:37:19 -0700
Received: by mx.microchip.com (sSMTP sendmail emulation); Sun, 06 Mar 2016
 10:05:47 +0530
From:   Purna Chandra Mandal <purna.mandal@microchip.com>
To:     <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>
CC:     Mark Brown <broonie@kernel.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Joshua Henderson <digitalpeer@digitalpeer.com>,
        Purna Chandra Mandal <purna.mandal@microchip.com>,
        <devicetree@vger.kernel.org>, <linux-mips@linux-mips.org>,
        Kumar Gala <galak@codeaurora.org>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [RESEND PATCH v2 1/2] dt/bindings: Add bindings for PIC32 SPI peripheral
Date:   Sun, 6 Mar 2016 10:05:26 +0530
Message-ID: <1457238927-16120-1-git-send-email-purna.mandal@microchip.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <Purna.Mandal@microchip.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52473
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: purna.mandal@microchip.com
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

Signed-off-by: Purna Chandra Mandal <purna.mandal@microchip.com>

---

Changes in v2:
 - fix indentation
 - add space after comma
 - moved 'cs-gpios' section under 'required' properties.

 .../bindings/spi/microchip,spi-pic32.txt           | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/microchip,spi-pic32.txt

diff --git a/Documentation/devicetree/bindings/spi/microchip,spi-pic32.txt b/Documentation/devicetree/bindings/spi/microchip,spi-pic32.txt
new file mode 100644
index 0000000..79de379f
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/microchip,spi-pic32.txt
@@ -0,0 +1,34 @@
+Microchip PIC32 SPI Master controller
+
+Required properties:
+- compatible: Should be "microchip,pic32mzda-spi".
+- reg: Address and length of register space for the device.
+- interrupts: Should contain all three spi interrupts in sequence
+              of <fault-irq>, <receive-irq>, <transmit-irq>.
+- interrupt-names: Should be "fault", "rx", "tx" in order.
+- clocks: Phandle of the clock generating SPI clock on the bus.
+- clock-names: Should be "mck0".
+- cs-gpios: Specifies the gpio pins to be used for chipselects.
+            See: Documentation/devicetree/bindings/spi/spi-bus.txt
+
+Optional properties:
+- dmas: Two or more DMA channel specifiers following the convention outlined
+        in Documentation/devicetree/bindings/dma/dma.txt
+- dma-names: Names for the dma channels. There must be at least one channel
+             named "spi-tx" for transmit and named "spi-rx" for receive.
+
+Example:
+
+spi1: spi@1f821000 {
+        compatible = "microchip,pic32mzda-spi";
+        reg = <0x1f821000 0x200>;
+        interrupts = <109 IRQ_TYPE_LEVEL_HIGH>,
+                     <110 IRQ_TYPE_LEVEL_HIGH>,
+                     <111 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "fault", "rx", "tx";
+        clocks = <&PBCLK2>;
+        clock-names = "mck0";
+        cs-gpios = <&gpio3 4 GPIO_ACTIVE_LOW>;
+        dmas = <&dma 134>, <&dma 135>;
+        dma-names = "spi-rx", "spi-tx";
+};
-- 
1.8.3.1
