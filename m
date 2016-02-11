Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Feb 2016 17:26:30 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:40162 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011283AbcBKQ02pAAZr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Feb 2016 17:26:28 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 0F928D1B26738;
        Thu, 11 Feb 2016 16:26:20 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Thu, 11 Feb 2016 16:26:22 +0000
Received: from mredfearn-linux.kl.imgtec.org (192.168.154.116) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Thu, 11 Feb 2016 16:26:21 +0000
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     <david.daney@cavium.com>, <aleksey.makarov@caviumnetworks.com>,
        <ulf.hansson@linaro.org>, <robh@kernel.org>, <ralf@linux-mips.org>
CC:     <linux-mmc@vger.kernel.org>, <linux-mips@linux-mips.org>,
        <devicetree@vger.kernel.org>,
        Chandrakala Chavva <cchavva@caviumnetworks.com>,
        Aleksey Makarov <aleksey.makarov@auriga.com>,
        Leonid Rosenboim <lrosenboim@caviumnetworks.com>,
        Peter Swain <pswain@cavium.com>,
        Aaron Williams <aaron.williams@cavium.com>,
        "Matt Redfearn" <matt.redfearn@imgtec.com>
Subject: [PATCH v6 1/3] mmc: OCTEON: Add DT bindings for OCTEON MMC controller
Date:   Thu, 11 Feb 2016 16:26:14 +0000
Message-ID: <1455207976-2262-1-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.5.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.116]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52013
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@imgtec.com
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

From: Aleksey Makarov <aleksey.makarov@caviumnetworks.com>

Add Device Tree binding document for Octeon MMC controller. The driver
is in a following patch.

The MMC controller can be connected to up to 4 "slots" which may be
eMMC, MMC or SD card devices. As there is a single controller, each
available slot is represented as a child node of the controller.

This is a similar concept to the atmel-mci driver.

Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Signed-off-by: Chandrakala Chavva <cchavva@caviumnetworks.com>
Signed-off-by: David Daney <david.daney@cavium.com>
Signed-off-by: Aleksey Makarov <aleksey.makarov@auriga.com>
Signed-off-by: Leonid Rosenboim <lrosenboim@caviumnetworks.com>
Signed-off-by: Peter Swain <pswain@cavium.com>
Signed-off-by: Aaron Williams <aaron.williams@cavium.com>
Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
---
Changes since v6:
- Split up patch
- Moved device tree fixup to platform code
---
 .../devicetree/bindings/mmc/octeon-mmc.txt         | 80 ++++++++++++++++++++++
 1 file changed, 80 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/octeon-mmc.txt

diff --git a/Documentation/devicetree/bindings/mmc/octeon-mmc.txt b/Documentation/devicetree/bindings/mmc/octeon-mmc.txt
new file mode 100644
index 000000000000..a1b20753172f
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/octeon-mmc.txt
@@ -0,0 +1,80 @@
+* OCTEON SD/MMC Host Controller
+
+This controller is present on some members of the Cavium OCTEON SoC
+family, provide an interface for eMMC, MMC and SD devices.  There is a
+single controller that may have several "slots" connected.  These
+slots appear as children of the main controller node.
+The DMA engine is an integral part of the controller block.
+
+1) MMC node
+
+Required properties:
+- compatible : Should be "cavium,octeon-6130-mmc" or "cavium,octeon-7890-mmc"
+- reg : Two entries:
+	1) The base address of the MMC controller register bank.
+	2) The base address of the MMC DMA engine register bank.
+- interrupts :
+	For "cavium,octeon-6130-mmc": two entries:
+	1) The MMC controller interrupt line.
+	2) The MMC DMA engine interrupt line.
+	For "cavium,octeon-7890-mmc": nine entries:
+	1) The next block transfer of a multiblock transfer has completed (BUF_DONE)
+	2) Operation completed successfully (CMD_DONE).
+	3) DMA transfer completed successfully (DMA_DONE).
+	4) Operation encountered an error (CMD_ERR).
+	5) DMA transfer encountered an error (DMA_ERR).
+	6) Switch operation completed successfully (SWITCH_DONE).
+	7) Switch operation encountered an error (SWITCH_ERR).
+	8) Internal DMA engine request completion interrupt (DONE).
+	9) Internal DMA FIFO underflow (FIFO).
+- #address-cells : Must be <1>
+- #size-cells : Must be <0>
+
+The node contains child nodes for each slot that the platform uses.
+
+Example:
+mmc@1180000002000 {
+	compatible = "cavium,octeon-6130-mmc";
+	reg = <0x11800 0x00002000 0x0 0x100>,
+		<0x11800 0x00000168 0x0 0x20>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	/* EMM irq, DMA irq */
+	interrupts = <1 19>, <0 63>;
+
+	[ child node definitions...]
+};
+
+
+2) Slot nodes
+Properties in mmc.txt apply to each slot node that the platform uses.
+
+Required properties:
+- reg : The slot number.
+
+Optional properties:
+- cavium,cmd-clk-skew : the amount of delay (in pS) past the clock edge
+	to sample the command pin.
+- cavium,dat-clk-skew : the amount of delay (in pS) past the clock edge
+	to sample the data pin.
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
+			reg = <0>;
+			max-frequency = <20000000>;
+			bus-width = <8>;
+			vmmc-supply = <&reg_vmmc3>;
+			cd-gpios = <&gpio 9 0>;
+			wp-gpios = <&gpio 10 0>;
+		};
+	};
-- 
2.5.0
