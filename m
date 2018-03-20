Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Mar 2018 14:08:55 +0100 (CET)
Received: from mail.bootlin.com ([62.4.15.54]:59852 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992828AbeCTNISe4xQ7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 20 Mar 2018 14:08:18 +0100
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 3F38720710; Tue, 20 Mar 2018 14:08:12 +0100 (CET)
Received: from localhost (unknown [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id D356C207E5;
        Tue, 20 Mar 2018 14:08:01 +0100 (CET)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>
Cc:     Allan Nielsen <Allan.Nielsen@microsemi.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v6 2/6] dt-bindings: mips: Add bindings for Microsemi SoCs
Date:   Tue, 20 Mar 2018 14:07:57 +0100
Message-Id: <20180320130801.9247-3-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180320130801.9247-1-alexandre.belloni@bootlin.com>
References: <20180320130801.9247-1-alexandre.belloni@bootlin.com>
Return-Path: <alexandre.belloni@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63079
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
 Documentation/devicetree/bindings/mips/mscc.txt | 43 +++++++++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mips/mscc.txt

diff --git a/Documentation/devicetree/bindings/mips/mscc.txt b/Documentation/devicetree/bindings/mips/mscc.txt
new file mode 100644
index 000000000000..ae15ec333542
--- /dev/null
+++ b/Documentation/devicetree/bindings/mips/mscc.txt
@@ -0,0 +1,43 @@
+* Microsemi MIPS CPUs
+
+Boards with a SoC of the Microsemi MIPS family shall have the following
+properties:
+
+Required properties:
+- compatible: "mscc,ocelot"
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
