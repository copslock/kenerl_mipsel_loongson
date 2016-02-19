Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Feb 2016 17:26:27 +0100 (CET)
Received: from exsmtp01.microchip.com ([198.175.253.37]:53562 "EHLO
        email.microchip.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27007331AbcBSQ0QwGngd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Feb 2016 17:26:16 +0100
Received: from mx.microchip.com (10.10.76.4) by CHN-SV-EXCH01.mchp-main.com
 (10.10.76.37) with Microsoft SMTP Server id 14.3.181.6; Fri, 19 Feb 2016
 09:26:07 -0700
Received: by mx.microchip.com (sSMTP sendmail emulation); Fri, 19 Feb 2016
 09:26:44 -0700
From:   Joshua Henderson <joshua.henderson@microchip.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>,
        Purna Chandra Mandal <purna.mandal@microchip.com>,
        Joshua Henderson <joshua.henderson@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v7 1/3] dt/bindings: Add PIC32 clock binding documentation
Date:   Fri, 19 Feb 2016 09:25:34 -0700
Message-ID: <1455899179-14097-2-git-send-email-joshua.henderson@microchip.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1455899179-14097-1-git-send-email-joshua.henderson@microchip.com>
References: <1455899179-14097-1-git-send-email-joshua.henderson@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <Joshua.Henderson@microchip.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52131
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

Document the devicetree bindings for the clock driver found on Microchip
PIC32 class devices.

Signed-off-by: Purna Chandra Mandal <purna.mandal@microchip.com>
Signed-off-by: Joshua Henderson <joshua.henderson@microchip.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>
---
Note: Please pull this complete series through the MIPS tree.

Changes since v6:
	- Update Microchip PIC32 clock binding document based on review
	- Add header defining clocks
Changes since v5: None
Changes since v4: None
Changes since v3: None
Changes since v2:
	- Force lowercase in PIC32 clock binding documentation
Changes since v1: None
---
 .../devicetree/bindings/clock/microchip,pic32.txt  |   39 ++++++++++++++++++
 include/dt-bindings/clock/microchip,pic32-clock.h  |   42 ++++++++++++++++++++
 2 files changed, 81 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/microchip,pic32.txt
 create mode 100644 include/dt-bindings/clock/microchip,pic32-clock.h

diff --git a/Documentation/devicetree/bindings/clock/microchip,pic32.txt b/Documentation/devicetree/bindings/clock/microchip,pic32.txt
new file mode 100644
index 0000000..5352718
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/microchip,pic32.txt
@@ -0,0 +1,39 @@
+Microchip PIC32 Clock Controller Binding
+----------------------------------------
+Microchip clock controller is consists of few oscillators, PLL, multiplexer
+and few divider modules.
+
+This binding uses common clock bindings.
+[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
+
+Required properties:
+- compatible: shall be "microchip,pic32mzda-clk".
+- reg: shall contain base address and length of clock registers.
+- #clock-cells: shall be 1.
+
+Optional properties:
+- microchip,pic32mzda-sosc: shall be added only if platform has
+  secondary oscillator connected.
+
+Example:
+	rootclk: clock-controller@1f801200 {
+		compatible = "microchip,pic32mzda-clk";
+		reg = <0x1f801200 0x200>;
+		#clock-cells = <1>;
+		/* optional */
+		microchip,pic32mzda-sosc;
+	};
+
+
+The clock consumer shall specify the desired clock-output of the clock
+controller (as defined in [2]) by specifying output-id in its "clock"
+phandle cell.
+[2] include/dt-bindings/clock/microchip,pic32-clock.h
+
+For example for UART2:
+uart2: serial@2 {
+	compatible = "microchip,pic32mzda-uart";
+        reg = <>;
+	interrupts = <>;
+	clocks = <&rootclk PB2CLK>;
+};
diff --git a/include/dt-bindings/clock/microchip,pic32-clock.h b/include/dt-bindings/clock/microchip,pic32-clock.h
new file mode 100644
index 0000000..184647a6
--- /dev/null
+++ b/include/dt-bindings/clock/microchip,pic32-clock.h
@@ -0,0 +1,42 @@
+/*
+ * Purna Chandra Mandal,<purna.mandal@microchip.com>
+ * Copyright (C) 2015 Microchip Technology Inc.  All rights reserved.
+ *
+ * This program is free software; you can distribute it and/or modify it
+ * under the terms of the GNU General Public License (Version 2) as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ * for more details.
+ */
+
+#ifndef _DT_BINDINGS_CLK_MICROCHIP_PIC32_H_
+#define _DT_BINDINGS_CLK_MICROCHIP_PIC32_H_
+
+/* clock output indices */
+#define POSCCLK		0
+#define FRCCLK		1
+#define BFRCCLK		2
+#define LPRCCLK		3
+#define SOSCCLK		4
+#define FRCDIVCLK	5
+#define PLLCLK		6
+#define SCLK		7
+#define PB1CLK		8
+#define PB2CLK		9
+#define PB3CLK		10
+#define PB4CLK		11
+#define PB5CLK		12
+#define PB6CLK		13
+#define PB7CLK		14
+#define REF1CLK		15
+#define REF2CLK		16
+#define REF3CLK		17
+#define REF4CLK		18
+#define REF5CLK		19
+#define UPLLCLK		20
+#define MAXCLKS		21
+
+#endif	/* _DT_BINDINGS_CLK_MICROCHIP_PIC32_H_ */
-- 
1.7.9.5
