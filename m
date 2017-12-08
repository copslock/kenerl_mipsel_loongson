Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Dec 2017 16:49:54 +0100 (CET)
Received: from mail.free-electrons.com ([62.4.15.54]:40704 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991359AbdLHPrtgEyTP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Dec 2017 16:47:49 +0100
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id 085A220391; Fri,  8 Dec 2017 16:47:44 +0100 (CET)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 8F81B20934;
        Fri,  8 Dec 2017 16:47:25 +0100 (CET)
From:   Alexandre Belloni <alexandre.belloni@free-electrons.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v2 06/13] dt-bindings: mips: Add bindings for Microsemi SoCs
Date:   Fri,  8 Dec 2017 16:46:11 +0100
Message-Id: <20171208154618.20105-7-alexandre.belloni@free-electrons.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20171208154618.20105-1-alexandre.belloni@free-electrons.com>
References: <20171208154618.20105-1-alexandre.belloni@free-electrons.com>
Return-Path: <alexandre.belloni@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61364
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexandre.belloni@free-electrons.com
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

Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 Documentation/devicetree/bindings/mips/mscc.txt | 46 +++++++++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mips/mscc.txt

diff --git a/Documentation/devicetree/bindings/mips/mscc.txt b/Documentation/devicetree/bindings/mips/mscc.txt
new file mode 100644
index 000000000000..1bb578b9d135
--- /dev/null
+++ b/Documentation/devicetree/bindings/mips/mscc.txt
@@ -0,0 +1,46 @@
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
+endianess, CPU bus control, CPU status.
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
+
+
-- 
2.15.1
