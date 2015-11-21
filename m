Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Nov 2015 01:18:10 +0100 (CET)
Received: from exsmtp01.microchip.com ([198.175.253.37]:13497 "EHLO
        email.microchip.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27013027AbbKUARInPJJx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 21 Nov 2015 01:17:08 +0100
Received: from mx.microchip.com (10.10.76.4) by CHN-SV-EXCH01.mchp-main.com
 (10.10.76.37) with Microsoft SMTP Server id 14.3.181.6; Fri, 20 Nov 2015
 17:17:01 -0700
Received: by mx.microchip.com (sSMTP sendmail emulation); Fri, 20 Nov 2015
 17:23:28 -0700
From:   Joshua Henderson <joshua.henderson@microchip.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <linux-mips@linux-mips.org>,
        Andrei Pistirica <andrei.pistirica@microchip.com>,
        Joshua Henderson <joshua.henderson@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, <devicetree@vger.kernel.org>
Subject: [PATCH 12/14] DEVICETREE: Add bindings for PIC32 SDHC host controller
Date:   Fri, 20 Nov 2015 17:17:24 -0700
Message-ID: <1448065205-15762-13-git-send-email-joshua.henderson@microchip.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1448065205-15762-1-git-send-email-joshua.henderson@microchip.com>
References: <1448065205-15762-1-git-send-email-joshua.henderson@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <Joshua.Henderson@microchip.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50019
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

Document the devicetree bindings for the SDHC peripheral found on
Microchip PIC32 class devices.

Signed-off-by: Andrei Pistirica <andrei.pistirica@microchip.com>
Signed-off-by: Joshua Henderson <joshua.henderson@microchip.com>
---
 .../devicetree/bindings/mmc/sdhci-pic32.txt        |   24 ++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-pic32.txt

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-pic32.txt b/Documentation/devicetree/bindings/mmc/sdhci-pic32.txt
new file mode 100644
index 0000000..f16388c
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/sdhci-pic32.txt
@@ -0,0 +1,24 @@
+* Microchip PIC32 SDHCI Controller
+
+This file documents differences between the core properties in mmc.txt
+and the properties used by the sdhci-pic32 driver.
+
+Required properties:
+- compatible: Should be "microchip,pic32-sdhci"
+- reg: Should contain registers location and length
+- interrupts: Should contain interrupt
+- pinctrl: Should contain pinctrl for data and command lines
+
+Optional properties:
+- no-1-8-v: 1.8V voltage selection not supported
+- piomode: disable DMA support
+
+Example:
+
+	sdhci@1f8ec000 {
+		compatible = "microchip,pic32-sdhci";
+		reg = <0x1f8ec000 0x100>;
+		interrupts = <SDHC_EVENT DEFAULT_INT_PRI IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&REFCLKO4>, <&PBCLK5>;
+		clock-names = "base_clk", "sys_clk";
+	};
-- 
1.7.9.5
