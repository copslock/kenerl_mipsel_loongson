Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Feb 2016 19:26:53 +0100 (CET)
Received: from exsmtp01.microchip.com ([198.175.253.37]:58684 "EHLO
        email.microchip.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27013931AbcBYS0vpyy8l (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Feb 2016 19:26:51 +0100
Received: from mx.microchip.com (10.10.76.4) by CHN-SV-EXCH01.mchp-main.com
 (10.10.76.37) with Microsoft SMTP Server id 14.3.181.6; Thu, 25 Feb 2016
 11:26:43 -0700
Received: by mx.microchip.com (sSMTP sendmail emulation); Thu, 25 Feb 2016
 11:27:29 -0700
From:   Joshua Henderson <joshua.henderson@microchip.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>,
        Joshua Henderson <joshua.henderson@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        <devicetree@vger.kernel.org>, <linux-watchdog@vger.kernel.org>
Subject: [PATCH v2 1/2] dt/bindings: Add bindings for PIC32 watchdog peripheral
Date:   Thu, 25 Feb 2016 11:27:20 -0700
Message-ID: <1456424846-24409-1-git-send-email-joshua.henderson@microchip.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <Joshua.Henderson@microchip.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52267
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

Document the devicetree bindings for the watchdog peripheral found on Microchip
PIC32 SoC class devices.

Signed-off-by: Joshua Henderson <joshua.henderson@microchip.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
---
Note: Please merge this patch series through the MIPS tree.

Changes since v1:
	- Change the example node name to be standard.
---
 .../bindings/watchdog/microchip,pic32-wdt.txt      |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/microchip,pic32-wdt.txt

diff --git a/Documentation/devicetree/bindings/watchdog/microchip,pic32-wdt.txt b/Documentation/devicetree/bindings/watchdog/microchip,pic32-wdt.txt
new file mode 100644
index 0000000..d140103
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/microchip,pic32-wdt.txt
@@ -0,0 +1,18 @@
+* Microchip PIC32 Watchdog Timer
+
+When enabled, the watchdog peripheral can be used to reset the device if the
+WDT is not cleared periodically in software.
+
+Required properties:
+- compatible: must be "microchip,pic32mzda-wdt".
+- reg: physical base address of the controller and length of memory mapped
+  region.
+- clocks: phandle of source clk. should be <&LPRC> clk.
+
+Example:
+
+	watchdog@1f800800 {
+		compatible = "microchip,pic32mzda-wdt";
+		reg = <0x1f800800 0x200>;
+		clocks = <&LPRC>;
+	};
-- 
1.7.9.5
