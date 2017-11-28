Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Nov 2017 16:29:10 +0100 (CET)
Received: from mail.free-electrons.com ([62.4.15.54]:39337 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990490AbdK1P1yvGHDY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Nov 2017 16:27:54 +0100
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id C3A302039F; Tue, 28 Nov 2017 16:27:48 +0100 (CET)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 9874F206F9;
        Tue, 28 Nov 2017 16:27:38 +0100 (CET)
From:   Alexandre Belloni <alexandre.belloni@free-electrons.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Jason Cooper <jason@lakedaemon.net>
Subject: [PATCH 02/13] dt-bindings: interrupt-controller: Add binding for the Microsemi Ocelot interrupt controller
Date:   Tue, 28 Nov 2017 16:26:32 +0100
Message-Id: <20171128152643.20463-3-alexandre.belloni@free-electrons.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20171128152643.20463-1-alexandre.belloni@free-electrons.com>
References: <20171128152643.20463-1-alexandre.belloni@free-electrons.com>
Return-Path: <alexandre.belloni@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61142
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

Add the Device Tree binding documentation for the Microsemi Ocelot
interrupt controller that is part of the ICPU. It is connected directly to
the MIPS core interrupt controller.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>

 .../interrupt-controller/mscc,ocelot-icpu-intr.txt | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/mscc,ocelot-icpu-intr.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/mscc,ocelot-icpu-intr.txt b/Documentation/devicetree/bindings/interrupt-controller/mscc,ocelot-icpu-intr.txt
new file mode 100644
index 000000000000..b47a8a02b17b
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/mscc,ocelot-icpu-intr.txt
@@ -0,0 +1,22 @@
+Microsemi Ocelot SoC ICPU Interrupt Controller
+
+Required properties:
+
+- compatible : should be "mscc,ocelot-icpu-intr"
+- reg : Specifies base physical address and size of the registers.
+- interrupt-controller : Identifies the node as an interrupt controller
+- #interrupt-cells : Specifies the number of cells needed to encode an
+  interrupt source. The value shall be 1.
+- interrupt-parent : phandle of the CPU interrupt controller.
+- interrupts : Specifies the CPU interrupt the controller is connected to.
+
+Example:
+
+		intc: interrupt-controller@70000070 {
+			compatible = "mscc,ocelot-icpu-intr";
+			reg = <0x70000070 0x70>;
+			#interrupt-cells = <1>;
+			interrupt-controller;
+			interrupt-parent = <&cpuintc>;
+			interrupts = <2>;
+		};
-- 
2.15.0
