Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Jan 2016 02:12:37 +0100 (CET)
Received: from exsmtp01.microchip.com ([198.175.253.37]:59076 "EHLO
        email.microchip.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27014744AbcANBLG7PCh9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 14 Jan 2016 02:11:06 +0100
Received: from mx.microchip.com (10.10.76.4) by CHN-SV-EXCH01.mchp-main.com
 (10.10.76.37) with Microsoft SMTP Server id 14.3.181.6; Wed, 13 Jan 2016
 18:11:04 -0700
Received: by mx.microchip.com (sSMTP sendmail emulation); Wed, 13 Jan 2016
 18:18:51 -0700
From:   Joshua Henderson <joshua.henderson@microchip.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>,
        Joshua Henderson <joshua.henderson@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v5 05/14] dt/bindings: Add bindings for PIC32/MZDA platforms
Date:   Wed, 13 Jan 2016 18:15:38 -0700
Message-ID: <1452734299-460-6-git-send-email-joshua.henderson@microchip.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1452734299-460-1-git-send-email-joshua.henderson@microchip.com>
References: <1452734299-460-1-git-send-email-joshua.henderson@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <Joshua.Henderson@microchip.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51101
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

This adds support for the Microchip PIC32 platform along with the
specific variant PIC32MZDA on a PIC32MZDA Starter Kit.

Signed-off-by: Joshua Henderson <joshua.henderson@microchip.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Acked-by: Rob Herring <robh@kernel.org>
---
Changes since v4: None
Changes since v3:
	- Remove broken URL and use full manual name for boot protocol
Changes since v2: None
Changes since v1: None
---
 .../bindings/mips/pic32/microchip,pic32mzda.txt    |   31 ++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mips/pic32/microchip,pic32mzda.txt

diff --git a/Documentation/devicetree/bindings/mips/pic32/microchip,pic32mzda.txt b/Documentation/devicetree/bindings/mips/pic32/microchip,pic32mzda.txt
new file mode 100644
index 0000000..1c8dbc4
--- /dev/null
+++ b/Documentation/devicetree/bindings/mips/pic32/microchip,pic32mzda.txt
@@ -0,0 +1,31 @@
+* Microchip PIC32MZDA Platforms
+
+PIC32MZDA Starter Kit
+Required root node properties:
+    - compatible = "microchip,pic32mzda-sk", "microchip,pic32mzda"
+
+CPU nodes:
+----------
+A "cpus" node is required.  Required properties:
+ - #address-cells: Must be 1.
+ - #size-cells: Must be 0.
+A CPU sub-node is also required.  Required properties:
+ - device_type: Must be "cpu".
+ - compatible: Must be "mti,mips14KEc".
+Example:
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			compatible = "mti,mips14KEc";
+		};
+	};
+
+Boot protocol
+--------------
+In accordance with Unified Hosting Interface Reference Manual (MD01069), the
+bootloader must pass the following arguments to the kernel:
+ - $a0: -2.
+ - $a1: KSEG0 address of the flattened device-tree blob.
-- 
1.7.9.5
