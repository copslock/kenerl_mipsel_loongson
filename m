Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Jul 2016 20:19:04 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:59598 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993529AbcGLSShtl6fj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 Jul 2016 20:18:37 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <steven.hill@cavium.com>)
        id 1bN27A-0001eU-AW; Tue, 12 Jul 2016 13:09:00 -0500
Subject: [PATCH V8 1/2] mmc: OCTEON: Add DT bindings for OCTEON MMC
 controller.
To:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@linux-mips.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>
From:   "Steven J. Hill" <steven.hill@cavium.com>
Message-ID: <57853472.2050404@cavium.com>
Date:   Tue, 12 Jul 2016 13:18:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <steven.hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54300
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: steven.hill@cavium.com
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

Add Device Tree binding document for Octeon MMC controller. The driver
is in a following patch. The OCTEON's MMC controller can be connected
to up to 4 "slots" which may be eMMC, MMC or SD card devices. As there
is a single controller, each available slot is represented as a child
node of the controller.

Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
Acked-by: David Daney <david.daney@cavium.com>

---
v8:
- Properly documented deprecated device tree properties.

v7:
- Rewrote a lot of the document for better readability

v6:
- Split up patch
- Moved device tree fixup to platform code
---

Signed-off-by: Steven J. Hill <Steven.Hill@cavium.com>
---
 .../devicetree/bindings/mmc/octeon-mmc.txt         | 72 ++++++++++++++++++++++
 1 file changed, 72 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/octeon-mmc.txt

diff --git a/Documentation/devicetree/bindings/mmc/octeon-mmc.txt b/Documentation/devicetree/bindings/mmc/octeon-mmc.txt
new file mode 100644
index 0000000..d4e2e28
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/octeon-mmc.txt
@@ -0,0 +1,72 @@
+* OCTEON SD/MMC Host Controller
+
+This controller is present on some members of the Cavium OCTEON SoC
+family, provide an interface for eMMC, MMC and SD devices.  There is a
+single controller that may have several "slots" connected.  These
+slots appear as children of the main controller node.
+The DMA engine is an integral part of the controller block.
+
+Required properties:
+- compatible : Should be "cavium,octeon-6130-mmc" or "cavium,octeon-7890-mmc"
+- reg : Two entries:
+	1) The base address of the MMC controller register bank
+	2) The base address of the MMC DMA engine register bank
+- interrupts :
+	For "cavium,octeon-6130-mmc": two entries:
+	1) The MMC controller interrupt line
+	2) The MMC DMA engine interrupt line
+	For "cavium,octeon-7890-mmc": nine entries:
+	1) Next block transfer of a multiblock transfer has completed (BUF_DONE)
+	2) Operation completed successfully (CMD_DONE)
+	3) DMA transfer completed successfully (DMA_DONE)
+	4) Operation encountered an error (CMD_ERR)
+	5) DMA transfer encountered an error (DMA_ERR)
+	6) Switch operation completed successfully (SWITCH_DONE)
+	7) Switch operation encountered an error (SWITCH_ERR)
+	8) Internal DMA engine request completion interrupt (DONE)
+	9) Internal DMA FIFO underflow (FIFO)
+- #address-cells : Must be <1>
+- #size-cells : Must be <0>
+
+Required properties of child nodes:
+- compatible : Should be
+  - "cavium,octeon-6130-mmc-slot"
+- reg : The slot number.
+
+Optional properties of child nodes:
+- cd-gpios : Specify GPIOs for card detection
+- wp-gpios : Specify GPIOs for write protection
+- bus-width : for data lines present in the slot. Default is 8.
+- max-frequency : Maximum operating frequency of the slot. Default is 52000000.
+- spi-max-frequency (DEPRECATED)
+
+Cavium specific properties of child nodes:
+- power-gpios : Specify GPIOs for power control
+- cavium,cmd-clk-skew : the amount of delay (in pS) past the clock edge
+	to sample the command pin.
+- cavium,dat-clk-skew : the amount of delay (in pS) past the clock edge
+	to sample the data pin.
+- cavium,bus-max-width (DEPRECATED)
+
+Example:
+	mmc@1180000002000 {
+		compatible = "cavium,octeon-6130-mmc";
+		reg = <0x11800 0x00002000 0x0 0x100>,
+		      <0x11800 0x00000168 0x0 0x20>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		/* EMM irq, DMA irq */
+		interrupts = <1 19>, <0 63>;
+
+		/* The board only has a single MMC slot */
+		mmc-slot@0 {
+			compatible = "cavium,octeon-6130-mmc-slot";
+			reg = <0>;
+			max-frequency = <20000000>;
+			/* bus width can be 1, 4 or 8 */
+			bus-width = <8>;
+			cd-gpios = <&gpio 9 0>;
+			wp-gpios = <&gpio 10 0>;
+			power-gpios = <&gpio 8 0>;
+		};
+	};
-- 
1.9.1
