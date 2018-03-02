Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Mar 2018 23:49:27 +0100 (CET)
Received: from mail.bootlin.com ([62.4.15.54]:36956 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993945AbeCBWtT6HJid (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 2 Mar 2018 23:49:19 +0100
Received: by mail.bootlin.com (Postfix, from userid 110)
        id D752D207CA; Fri,  2 Mar 2018 23:49:11 +0100 (CET)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id 94F14207EF;
        Fri,  2 Mar 2018 23:49:01 +0100 (CET)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>
Cc:     Allan Nielsen <Allan.Nielsen@microsemi.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v4 2/6] dt-bindings: mips: Add bindings for Microsemi SoCs
Date:   Fri,  2 Mar 2018 23:48:07 +0100
Message-Id: <20180302224811.26840-3-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302224811.26840-1-alexandre.belloni@bootlin.com>
References: <20180302224811.26840-1-alexandre.belloni@bootlin.com>
Return-Path: <alexandre.belloni@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62779
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexandre.belloni@bootlin.com
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

Add bindings for Microsemi SoCs. Currently only Ocelot is supported.

Reviewed-by: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 Documentation/devicetree/bindings/mips/mscc.txt | 44 +++++++++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mips/mscc.txt

diff --git a/Documentation/devicetree/bindings/mips/mscc.txt b/Documentation/devicetree/bindings/mips/mscc.txt
new file mode 100644
index 000000000000..f4514c274510
--- /dev/null
+++ b/Documentation/devicetree/bindings/mips/mscc.txt
@@ -0,0 +1,44 @@
+* Microsemi MIPS CPUs
+
+Boards with a SoC of the Microsemi MIPS family shall have the following
+properties:
+
+Required properties:
+- compatible: "mscc,ocelot"
+- mips-hpt-frequency: CPU counter frequency.
+
+
+* Other peripherals:
+
+o CPU chip regs:
+
+The SoC has a few registers (DEVCPU_GCB:CHIP_REGS) handling miscellaneous
+functionalities: chip ID, general purpose register for software use, reset
+controller, hardware status and configuration, efuses.
+
+Required properties:
+- compatible: Should be "mscc,ocelot-chip-regs", "simple-mfd", "syscon"
+- reg : Should contain registers location and length
+
+Example:
+	syscon@71070000 {
+		compatible = "mscc,ocelot-chip-regs", "simple-mfd", "syscon";
+		reg = <0x71070000 0x1c>;
+	};
+
+
+o CPU system control:
+
+The SoC has a few registers (ICPU_CFG:CPU_SYSTEM_CTRL) handling configuration of
+the CPU: 8 general purpose registers, reset control, CPU en/disabling, CPU
+endianness, CPU bus control, CPU status.
+
+Required properties:
+- compatible: Should be "mscc,ocelot-cpu-syscon", "syscon"
+- reg : Should contain registers location and length
+
+Example:
+	syscon@70000000 {
+		compatible = "mscc,ocelot-cpu-syscon", "syscon";
+		reg = <0x70000000 0x2c>;
+	};
-- 
2.16.2
