Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Feb 2016 23:38:39 +0100 (CET)
Received: from exsmtp03.microchip.com ([198.175.253.49]:51221 "EHLO
        email.microchip.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27012012AbcBAWiiIIWhJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Feb 2016 23:38:38 +0100
Received: from mx.microchip.com (10.10.76.4) by chn-sv-exch03.mchp-main.com
 (10.10.76.49) with Microsoft SMTP Server id 14.3.181.6; Mon, 1 Feb 2016
 15:38:28 -0700
Received: by mx.microchip.com (sSMTP sendmail emulation); Mon, 01 Feb 2016
 15:42:18 -0700
From:   Joshua Henderson <joshua.henderson@microchip.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <linux-mips@linux-mips.org>,
        Joshua Henderson <joshua.henderson@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, <devicetree@vger.kernel.org>
Subject: [PATCH 1/2] dt/bindings: Add bindings for the PIC32 random number generator
Date:   Mon, 1 Feb 2016 15:41:41 -0700
Message-ID: <1454366511-10640-1-git-send-email-joshua.henderson@microchip.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <Joshua.Henderson@microchip.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51594
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

Document the devicetree bindings for the random number generator found
on Microchip PIC32 class devices.

Signed-off-by: Joshua Henderson <joshua.henderson@microchip.com>
---
 .../bindings/rng/microchip,pic32-rng.txt           |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rng/microchip,pic32-rng.txt

diff --git a/Documentation/devicetree/bindings/rng/microchip,pic32-rng.txt b/Documentation/devicetree/bindings/rng/microchip,pic32-rng.txt
new file mode 100644
index 0000000..c6d1003
--- /dev/null
+++ b/Documentation/devicetree/bindings/rng/microchip,pic32-rng.txt
@@ -0,0 +1,17 @@
+* Microchip PIC32 Random Number Generator
+
+The PIC32 RNG provides a pseudo random number generator which can be seeded by
+another true random number generator.
+
+Required properties:
+- compatible : should be "microchip,pic32mzda-rng"
+- reg : Specifies base physical address and size of the registers.
+- clocks: clock phandle.
+
+Example:
+
+	rng: rng@1f8e6000 {
+		compatible = "microchip,pic32mzda-rng";
+		reg = <0x1f8e6000 0x1000>;
+		clocks = <&PBCLK5>;
+	};
-- 
1.7.9.5
