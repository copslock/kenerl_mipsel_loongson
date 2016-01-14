Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Jan 2016 02:14:44 +0100 (CET)
Received: from exsmtp03.microchip.com ([198.175.253.49]:37814 "EHLO
        email.microchip.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27014749AbcANBMif20a9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 14 Jan 2016 02:12:38 +0100
Received: from mx.microchip.com (10.10.76.4) by chn-sv-exch03.mchp-main.com
 (10.10.76.49) with Microsoft SMTP Server id 14.3.181.6; Wed, 13 Jan 2016
 18:12:31 -0700
Received: by mx.microchip.com (sSMTP sendmail emulation); Wed, 13 Jan 2016
 18:20:19 -0700
From:   Joshua Henderson <joshua.henderson@microchip.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>,
        Andrei Pistirica <andrei.pistirica@microchip.com>,
        Joshua Henderson <joshua.henderson@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v5 11/14] dt/bindings: Add bindings for PIC32 SDHCI host controller
Date:   Wed, 13 Jan 2016 18:15:44 -0700
Message-ID: <1452734299-460-12-git-send-email-joshua.henderson@microchip.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1452734299-460-1-git-send-email-joshua.henderson@microchip.com>
References: <1452734299-460-1-git-send-email-joshua.henderson@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <Joshua.Henderson@microchip.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51107
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

From: Andrei Pistirica <andrei.pistirica@microchip.com>

Document the devicetree bindings for the SDHCI peripheral found on
Microchip PIC32 class devices.

Signed-off-by: Andrei Pistirica <andrei.pistirica@microchip.com>
Signed-off-by: Joshua Henderson <joshua.henderson@microchip.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Acked-by: Rob Herring <robh@kernel.org>
---
Changes since v4: None
Changes since v3: None
Changes since v2: None
Changes since v1:
	- Drop usage of piomode and no-1-8-v DT properties
---
 .../bindings/mmc/microchip,sdhci-pic32.txt         |   29 ++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/microchip,sdhci-pic32.txt

diff --git a/Documentation/devicetree/bindings/mmc/microchip,sdhci-pic32.txt b/Documentation/devicetree/bindings/mmc/microchip,sdhci-pic32.txt
new file mode 100644
index 0000000..71ad57e
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/microchip,sdhci-pic32.txt
@@ -0,0 +1,29 @@
+* Microchip PIC32 SDHCI Controller
+
+This file documents differences between the core properties in mmc.txt
+and the properties used by the sdhci-pic32 driver.
+
+Required properties:
+- compatible: Should be "microchip,pic32mzda-sdhci"
+- interrupts: Should contain interrupt
+- clock-names: Should be "base_clk", "sys_clk".
+               See: Documentation/devicetree/bindings/resource-names.txt
+- clocks: Phandle to the clock.
+          See: Documentation/devicetree/bindings/clock/clock-bindings.txt
+- pinctrl-names: A pinctrl state names "default" must be defined.
+- pinctrl-0: Phandle referencing pin configuration of the SDHCI controller.
+             See: Documentation/devicetree/bindings/pinctrl/pinctrl-binding.txt
+
+Example:
+
+	sdhci@1f8ec000 {
+		compatible = "microchip,pic32mzda-sdhci";
+		reg = <0x1f8ec000 0x100>;
+		interrupts = <191 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&REFCLKO4>, <&PBCLK5>;
+		clock-names = "base_clk", "sys_clk";
+		bus-width = <4>;
+		cap-sd-highspeed;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_sdhc1>;
+	};
-- 
1.7.9.5
